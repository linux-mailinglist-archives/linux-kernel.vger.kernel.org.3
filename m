Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C512A5B0F0C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 23:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiIGVWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 17:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiIGVWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 17:22:51 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345805A80E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 14:22:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A9872CE1DA7
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 21:22:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8137C433D6;
        Wed,  7 Sep 2022 21:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1662585767;
        bh=gxMGpmoNCeRaJ1bjDJWBLm6Nn6Ybto9MKRxMg9yg0CM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=omGfrsh2M987hhabKX/032BRuB7di5tlViD/uI57wqu8oWbhfgtnlGmVMjaRwJCmx
         kVvQhLcqICUIPAxfihnqj3Mfg57B9aC5b3hSZyTig+15RyUEzu6SJw2gHPDJZm6YvL
         6S8uwjZ7hZ2KxjsppNkkhbu6CrLiMkpu9JK0SLLg=
Date:   Wed, 7 Sep 2022 14:22:46 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     david@redhat.com, peterx@redhat.com,
        kirill.shutemov@linux.intel.com, jhubbard@nvidia.com,
        jgg@nvidia.com, hughd@google.com, aneesh.kumar@linux.ibm.com,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 1/2] mm: gup: fix the fast GUP race against THP
 collapse
Message-Id: <20220907142246.c7d6f55e1b56fba3e16d974b@linux-foundation.org>
In-Reply-To: <20220907180144.555485-1-shy828301@gmail.com>
References: <20220907180144.555485-1-shy828301@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  7 Sep 2022 11:01:43 -0700 Yang Shi <shy828301@gmail.com> wrote:

> Since general RCU GUP fast was introduced in commit 2667f50e8b81 ("mm:
> introduce a general RCU get_user_pages_fast()"), a TLB flush is no longer
> sufficient to handle concurrent GUP-fast in all cases, it only handles
> traditional IPI-based GUP-fast correctly.  On architectures that send
> an IPI broadcast on TLB flush, it works as expected.  But on the
> architectures that do not use IPI to broadcast TLB flush, it may have
> the below race:
> 
>    CPU A                                          CPU B
> THP collapse                                     fast GUP
>                                               gup_pmd_range() <-- see valid pmd
>                                                   gup_pte_range() <-- work on pte
> pmdp_collapse_flush() <-- clear pmd and flush
> __collapse_huge_page_isolate()
>     check page pinned <-- before GUP bump refcount
>                                                       pin the page
>                                                       check PTE <-- no change
> __collapse_huge_page_copy()
>     copy data to huge page
>     ptep_clear()
> install huge pmd for the huge page
>                                                       return the stale page
> discard the stale page
> 
> The race could be fixed by checking whether PMD is changed or not after
> taking the page pin in fast GUP, just like what it does for PTE.  If the
> PMD is changed it means there may be parallel THP collapse, so GUP
> should back off.
> 
> Also update the stale comment about serializing against fast GUP in
> khugepaged.
> 
> Fixes: 2667f50e8b81 ("mm: introduce a general RCU get_user_pages_fast()")

Is this not worth a -stable backport?
