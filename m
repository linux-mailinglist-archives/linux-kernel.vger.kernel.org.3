Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099564D3E8D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 02:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238864AbiCJBGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 20:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiCJBGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 20:06:21 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C921211C7C9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 17:05:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 23996CE21C9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 01:05:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCC8C340E8;
        Thu, 10 Mar 2022 01:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1646874318;
        bh=ThG1fFT54Wv/4ZXiHTVmZNvallBT7r7fC/7H3QeeXYk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OHm4embnTaj+PLorBW7tPxS3x5vEyTgX81f1/2Ut/Z5QYV8OmPigIijuI/qL21cFn
         Z4xdljH40eLM5axz78YxsWnLDSTaAymWSsfUOY+00Pukgmb+EdgYMu9k2cucY7dTJK
         R7qSddbtFGNSCXxjkr1n+BOpIScIhudgy8BBHuaE=
Date:   Wed, 9 Mar 2022 17:05:17 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     wangjianxing <wangjianxing@loongson.cn>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/page_alloc: add scheduling point to
 free_unref_page_list
Message-Id: <20220309170517.05facf4a2d183cc9aac9196d@linux-foundation.org>
In-Reply-To: <YieCFVMJOgT7es6E@casper.infradead.org>
References: <20220302013825.2290315-1-wangjianxing@loongson.cn>
        <YieCFVMJOgT7es6E@casper.infradead.org>
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

On Tue, 8 Mar 2022 16:19:33 +0000 Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, Mar 01, 2022 at 08:38:25PM -0500, wangjianxing wrote:
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 3589febc6..1b96421c8 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -3479,6 +3479,9 @@ void free_unref_page_list(struct list_head *list)
> >  		 */
> >  		if (++batch_count == SWAP_CLUSTER_MAX) {
> >  			local_unlock_irqrestore(&pagesets.lock, flags);
> > +
> > +			cond_resched();
> 
> This isn't safe.  This path can be called from interrupt context
> (otherwise we'd be using local_unlock_irq() instead of irqrestore()).

What a shame it is that we don't document our interfaces :(

I can't immediately find such callers, but I could imagine
put_pages_list() (which didn't document its interface this way either)
being called from IRQ.

And drivers/iommu/dma-iommu.c:fq_ring_free() calls put_pages_list()
from inside spin_lock().  
