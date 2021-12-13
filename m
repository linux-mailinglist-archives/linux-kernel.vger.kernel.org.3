Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56176472CCE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237152AbhLMNHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbhLMNHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:07:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46842C061574;
        Mon, 13 Dec 2021 05:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dZO5LI8ID/6JEA+jyyA3F3bKLk0KMZ/PAq5/idus8Ns=; b=GCWAK04LRc34iEhbc/HuogQkq5
        G/KA7qMvNIyJYxvkbT52p+Vo47b4i16/eCyTYTsJh88ZPuTmXG0YGoFXoJrmsYmxzHWqbz4yiFAbA
        e2H//GejEMiL/swftGqRLaAMWckpuqieeX4MZMndAvrgxlpge9piQjES8pTBbszEaq0zI/bEHj2O0
        ilVfNub6g36RMxMU5RzYIm7xx93jc9gmIGLGvvxg8ScfOLfHH5Q24CRImTtFgutF6k0T8ZNDvlD6e
        aqLDobrE0YK73Pfdp4B7rKWHnEmDSD23uL0F3YDUrWRtapiKo0F4/BRi8owQYjiJrjm/H8Oi3zm7B
        BJBeIixg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwl2m-009cIo-OA; Mon, 13 Dec 2021 13:07:04 +0000
Date:   Mon, 13 Dec 2021 05:07:04 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     axboe@kernel.dk, bigeasy@linutronix.de, tglx@linutronix.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] blk-mq: make synchronous hw_queue runs RT friendly
Message-ID: <YbdFeHVnQbT0E5kR@infradead.org>
References: <20211213054425.28121-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213054425.28121-1-dave@stgolabs.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#ifndef CONFIG_PREEMPT_RT

Please don't add these silly inverted ifdefs.

> +static inline void blk_mq_start_sync_run_hw_queue(void)
> +{
> +	preempt_disable();
> +}
> +static inline void blk_mq_end_sync_run_hw_queue(void)
> +{
> +	preempt_enable();
> +}
> +#else
> +static inline void blk_mq_start_sync_run_hw_queue(void)
> +{
> +	migrate_disable();
> +}
> +static inline void blk_mq_end_sync_run_hw_queue(void)
> +{
> +	migrate_enable();
> +}
> +#endif

But more importantly:  why isn't migrate_disable/enable doing the right
thing for !PREEMPT_RT to avoid this mess?
