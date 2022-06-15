Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BECB54D4F3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 01:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343803AbiFOXEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 19:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238604AbiFOXEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 19:04:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E5F2497B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 16:04:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36BEA61946
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 23:04:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B04C3411A;
        Wed, 15 Jun 2022 23:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1655334287;
        bh=NBWqMBdjUVKz+Ds4bsB0MdOwkR+I5F9aFtUm/9YqTLI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mr3Sz0ZzyOLpWYyTHQCRVgagCRsFMv3ptOdTtUstikuhnDCWGslvviwlBIHDF9tZe
         TwvgB3lTazuFL44KNId2LrkgHyZKY4yM2NXGOyPx9SxcwPVjfXvEMQp84N9jQfpTeH
         G4tzzSjjxKo9ACt0KnumE9mZDwZc84gqU91nHCBI=
Date:   Wed, 15 Jun 2022 16:04:46 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Yu Zhao <yuzhao@google.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 7/7] mm/page_alloc: Replace local_lock with normal
 spinlock
Message-Id: <20220615160446.be1f75fd256d67e57b27a9fc@linux-foundation.org>
In-Reply-To: <e1c73640-3f29-bf57-b98d-84b1800cf4e3@samsung.com>
References: <20220613125622.18628-1-mgorman@techsingularity.net>
        <20220613125622.18628-8-mgorman@techsingularity.net>
        <CGME20220615224855eucas1p1ea6d90c23ec9423dfe04b267f6dddd2a@eucas1p1.samsung.com>
        <e1c73640-3f29-bf57-b98d-84b1800cf4e3@samsung.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2022 00:48:55 +0200 Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> In the logs I see lots of errors like:
> 
> BUG: sleeping function called from invalid context at 
> ./include/linux/sched/mm.h:274
> 
> BUG: scheduling while atomic: systemd-udevd/288/0x00000002
> 
> BUG: sleeping function called from invalid context at mm/filemap.c:2647
> 
> however there are also a fatal ones like:
> 
> Unable to handle kernel paging request at virtual address 00000000017a87b4
> 
> 
> The issues seems to be a bit random. Looks like memory trashing. 
> Reverting $subject on top of current linux-next fixes all those issues.
> 
> 

This?

--- a/mm/page_alloc.c~mm-page_alloc-replace-local_lock-with-normal-spinlock-fix
+++ a/mm/page_alloc.c
@@ -183,8 +183,10 @@ static DEFINE_MUTEX(pcp_batch_high_lock)
 	type *_ret;							\
 	pcpu_task_pin();						\
 	_ret = this_cpu_ptr(ptr);					\
-	if (!spin_trylock_irqsave(&_ret->member, flags))		\
+	if (!spin_trylock_irqsave(&_ret->member, flags)) {		\
+		pcpu_task_unpin();					\
 		_ret = NULL;						\
+	}								\
 	_ret;								\
 })
 

I'll drop Mel's patch for next -next.
