Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3880A564A7A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 01:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiGCXO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 19:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiGCXO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 19:14:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F455FBB
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 16:14:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A8C9B8015B
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 23:14:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E006C341C6;
        Sun,  3 Jul 2022 23:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1656890063;
        bh=eraPqmwROOb16b2jw4w/lY5LSrsNKAf5gsz/yzIab8s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=00wNNTZxm5k38yElTqGTrmvzRw8kLFqJOvQNb0pINHpqZUz3XC1uBlfeDyPfed3pw
         J792ub8Tx5cnrQ2kh2UH9cLFNPndI8ZbNx4s3D0neHF7SVB9imOHoSOD7MdU4sNkk6
         GrarUUdH0nG4C43R0bhMcRNp3CbR+F/XAp6TT1ds=
Date:   Sun, 3 Jul 2022 16:14:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        willy@infradead.org, zokeefe@google.com, linmiaohe@huawei.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [mm-unstable v5 PATCH 0/7] Cleanup transhuge_xxx helpers
Message-Id: <20220703161422.71e0c7316cca0442c682fcaf@linux-foundation.org>
In-Reply-To: <20220616174840.1202070-1-shy828301@gmail.com>
References: <20220616174840.1202070-1-shy828301@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2022 10:48:33 -0700 Yang Shi <shy828301@gmail.com> wrote:

> This series is the follow-up of the discussion about cleaning up transhuge_xxx
> helpers at https://lore.kernel.org/linux-mm/627a71f8-e879-69a5-ceb3-fc8d29d2f7f1@suse.cz/.
> 
> THP has a bunch of helpers that do VMA sanity check for different paths, they
> do the similar checks for the most callsites and have a lot duplicate codes.
> And it is confusing what helpers should be used at what conditions.
> 
> This series reorganized and cleaned up the code so that we could consolidate
> all the checks into hugepage_vma_check().
> 
> The transhuge_vma_enabled(), transparent_hugepage_active() and
> __transparent_hugepage_enabled() are killed by this series.

I plan to move this into mm-stable later this week, along with two fixups:

https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-thp-kill-transparent_hugepage_active-fix.patch
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-thp-kill-transparent_hugepage_active-fix-fix.patch
