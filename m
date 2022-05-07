Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B365851EA39
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 23:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235641AbiEGVJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 17:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387445AbiEGVI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 17:08:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3808B23BFC;
        Sat,  7 May 2022 14:05:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5959B8068C;
        Sat,  7 May 2022 21:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB80C385A5;
        Sat,  7 May 2022 21:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651957509;
        bh=qYJf6KKIw0kS7h3klkpFrLBCOJEdBYsXoDnCkBbFot8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qxP2AP0lq9d2eXVJ8PA6dz/JiOL9xsmVaaf1clt+8Ad5mfECqtsRZDb9a5dBiJQfk
         SOPlgf7msLNc6PhcyaPgxTLCMEI2KQvWbOUGRd333UnGei+mEEUTt2Mr9Bhbe35wXy
         ee82ymIYse7stEUwRtebn8IQ76nJwnQD48BCeWck=
Date:   Sat, 7 May 2022 14:05:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, corbet@lwn.net,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com, masahiroy@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v9 2/4] mm: memory_hotplug: override memmap_on_memory
 when hugetlb_free_vmemmap=on
Message-Id: <20220507140508.38c9e211eae4715134f9fa31@linux-foundation.org>
In-Reply-To: <YnH1B1Al/oW3rbmu@FVFYT0MHHV2J.usts.net>
References: <20220429121816.37541-1-songmuchun@bytedance.com>
        <20220429121816.37541-3-songmuchun@bytedance.com>
        <3d040faf-7fc1-80a6-c584-aafeff27af18@oracle.com>
        <YnH1B1Al/oW3rbmu@FVFYT0MHHV2J.usts.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 May 2022 11:37:43 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> > Freeing HugeTLB vmemmap pages is not compatible with allocating memmap on
> > hot added memory. If "hugetlb_free_vmemmap=on" and
> > memory_hotplug.memmap_on_memory" are both passed on the kernel command line,
> > freeing hugetlb pages takes precedence.  However, the global variable
> > memmap_on_memory will still be set to 1, even though we will not try to
> > allocate memmap on hot added memory.
> > 
> > Not sure if that is more clear or not.
> > 
> 
> Clearer than mine.

I updated, thanks.
