Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB67157729B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 03:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbiGQBBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 21:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGQBBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 21:01:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B1D1A807
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 18:01:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3382260C53
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 01:01:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A681C34114;
        Sun, 17 Jul 2022 01:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1658019671;
        bh=efYIWOoWV0zkOHCTekecrsLSFtORWtfGT60gVLT8918=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eFOHmUhVf40FTuq6n783AYVUnDjqFs1s2oBFNrcOxWB72HxkcELLD+n0Riwxl23g6
         lknYahEVTA5Qi9HjpxyiIAox3xKgDzVrKGACH8i2gaTWf5SV5vk7rEqptUgAJAqjCS
         nmsM+JvZRXCYjvJlt+Yea4wAcUiPym7UHVWH797w=
Date:   Sat, 16 Jul 2022 18:01:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liu Song <liusong@linux.alibaba.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/dmapool.c: avoid duplicate memset within
 dma_pool_alloc
Message-Id: <20220716180110.eb9402180137d0ce84e3971c@linux-foundation.org>
In-Reply-To: <1657769100-66142-1-git-send-email-liusong@linux.alibaba.com>
References: <1657769100-66142-1-git-send-email-liusong@linux.alibaba.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jul 2022 11:25:00 +0800 Liu Song <liusong@linux.alibaba.com> wrote:

> From: Liu Song <liusong@linux.alibaba.com>
> 
> In "dma_direct_alloc", the allocated memory is explicitly set to 0.
> If use direct alloc, we need to avoid possible duplicate memset in
> dma_pool_alloc.

I'm having trouble seeing how this change is safe and correct and
maintainable.  Please describe the code flow more completely?

> --- a/mm/dmapool.c
> +++ b/mm/dmapool.c
> @@ -21,6 +21,7 @@
>  
>  #include <linux/device.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/dma-map-ops.h>
>  #include <linux/dmapool.h>
>  #include <linux/kernel.h>
>  #include <linux/list.h>
> @@ -372,7 +373,7 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
>  #endif
>  	spin_unlock_irqrestore(&pool->lock, flags);
>  
> -	if (want_init_on_alloc(mem_flags))
> +	if (want_init_on_alloc(mem_flags) && get_dma_ops(pool->dev))
>  		memset(retval, 0, pool->size);

That DMAPOOL_DEBUG memset a couple of lines earlier could/should be
testing the same condition - there's no point in poisoning an area
which we're about to zero out.

