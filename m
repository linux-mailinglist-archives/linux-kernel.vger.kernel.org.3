Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0F15649B0
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 22:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiGCUWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 16:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiGCUWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 16:22:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC501B1
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 13:22:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F497611B5
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 20:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D47C341C6;
        Sun,  3 Jul 2022 20:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1656879730;
        bh=b7K9m4fAbOcD/g/S4tQDp1ZmghJk5cmGd/KRtIjljGQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p+7atuoFLRz41Z8H+eTqkdcbHwZnwumlQ1AWOimYmR38ojVc+aLWaJBkxcw6ZtEpK
         kLOTEKxAKT86zjXJ+qYblT+rFnep6XCt4zouaVHHDMyM0n0Lvy6oZ5RTjHn3jwdncN
         wbPLV/2PpZNOZFhg43PM3xIInGVM9ASZBGvCYZ5U=
Date:   Sun, 3 Jul 2022 13:22:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        lkp@lists.01.org, Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [mm/page_alloc]  2bd8eec68f:
 BUG:sleeping_function_called_from_invalid_context_at_mm/gup.c
Message-Id: <20220703132209.875b823d1cb7169a8d51d56d@linux-foundation.org>
In-Reply-To: <YsFk/qU+QtWun04h@xsang-OptiPlex-9020>
References: <20220613125622.18628-8-mgorman@techsingularity.net>
        <YsFk/qU+QtWun04h@xsang-OptiPlex-9020>
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

On Sun, 3 Jul 2022 17:44:30 +0800 kernel test robot <oliver.sang@intel.com> wrote:

> FYI, we noticed the following commit (built with gcc-11):
> 
> commit: 2bd8eec68f740608db5ea58ecff06965228764cb ("[PATCH 7/7] mm/page_alloc: Replace local_lock with normal spinlock")
> url: https://github.com/intel-lab-lkp/linux/commits/Mel-Gorman/Drain-remote-per-cpu-directly/20220613-230139
> base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
> patch link: https://lore.kernel.org/lkml/20220613125622.18628-8-mgorman@techsingularity.net
> 

Did this test include the followup patch
mm-page_alloc-replace-local_lock-with-normal-spinlock-fix.patch?


From: Mel Gorman <mgorman@techsingularity.net>
Subject: mm/page_alloc: replace local_lock with normal spinlock -fix
Date: Mon, 27 Jun 2022 09:46:45 +0100

As noted by Yu Zhao, use pcp_spin_trylock_irqsave instead of
pcpu_spin_trylock_irqsave.  This is a fix to the mm-unstable patch
mm-page_alloc-replace-local_lock-with-normal-spinlock.patch

Link: https://lkml.kernel.org/r/20220627084645.GA27531@techsingularity.net
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Reported-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/page_alloc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/page_alloc.c~mm-page_alloc-replace-local_lock-with-normal-spinlock-fix
+++ a/mm/page_alloc.c
@@ -3497,7 +3497,7 @@ void free_unref_page(struct page *page,
 
 	zone = page_zone(page);
 	pcp_trylock_prepare(UP_flags);
-	pcp = pcpu_spin_trylock_irqsave(struct per_cpu_pages, lock, zone->per_cpu_pageset, flags);
+	pcp = pcp_spin_trylock_irqsave(zone->per_cpu_pageset, flags);
 	if (pcp) {
 		free_unref_page_commit(zone, pcp, page, migratetype, order);
 		pcp_spin_unlock_irqrestore(pcp, flags);
_

