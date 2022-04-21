Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8C250985C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385235AbiDUGta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385171AbiDUGrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:47:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD7815712;
        Wed, 20 Apr 2022 23:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V2tdJCZ8HTKxolSAKhSx80I//fS72WmrvMwMKaTmS7g=; b=SRNJ9ebqoL9nbFWro4qSzTP63f
        m1T0F8c6cGzHk9e9r+9cg1AOUONZemwVWDYqAwhZxq9P49ITIpD9PrUHhYmOtzXXCq9XQXnA+ByzW
        1erDinkbDy+XRnB9lMkT0ZaCJpdovFanUgxuwOqUNIbphtrkPFrUYcueGANyvpYP1/hGYezhmDWIa
        4MnYW1TCzTPxQ/yijIZm0ZhVmHyfC3aq5/pLmK3619Z010NqOeXbCVLRa/5suny727uG/ABNDP6Xx
        n5CAHCWEoO3djgyjesKcoa9dV+j0IhGOaI2K3Pc8WzNzoHClxvxy6E+DhGZQjvKlSJIgTQxcXiyR7
        B5kbydLg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhQXg-00BoIL-Ok; Thu, 21 Apr 2022 06:43:52 +0000
Date:   Wed, 20 Apr 2022 23:43:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Subject: Re: [PATCH v2 12/12] md/raid5: Pivot raid5_make_request()
Message-ID: <YmD9KBJtOjV+J5We@infradead.org>
References: <20220420195425.34911-1-logang@deltatee.com>
 <20220420195425.34911-13-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420195425.34911-13-logang@deltatee.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 01:54:25PM -0600, Logan Gunthorpe wrote:
>  struct stripe_request_ctx {
>  	bool do_flush;
>  	struct stripe_head *batch_last;
> +	sector_t disk_sector_done;
> +	sector_t start_disk_sector;

Very nitpicky, but why use two different naming styles for the sectors
here?

> +	bool first_wrap;
> +	sector_t last_sector;

And especially with the last_sector here a few comments explaining
what each of the sector values mean might be useful.

I'd also keep the two bool variables together for a better structure
layout.

> +	 * if new_sector is less than the starting sector. Clear the
> +	 * boolean once the start sector is hit for the second time.
> +	 * When first_wrap is set, ignore the disk_sector_done.
> +	 */
> +	if (ctx->start_disk_sector == MaxSector) {
> +		ctx->start_disk_sector = new_sector;
> +	} else if (new_sector < ctx->start_disk_sector) {
> +		ctx->first_wrap = true;
> +	} else if (new_sector == ctx->start_disk_sector) {
> +		ctx->first_wrap = false;
> +		ctx->start_disk_sector = 0;
> +		return STRIPE_SUCCESS;
> +	} else if (!ctx->first_wrap && new_sector <= ctx->disk_sector_done) {
> +		return STRIPE_SUCCESS;
> +	}
> +

I find this a bit confusing to read.  While trying to mentally untangle
it I came up with this version instead, but it could really use some
good comments explaining each of the checks as I found your big comment
to not quite match the logic easily.

	if (ctx->start_disk_sector == MaxSector) {
		/*
		 * First loop iteration, start our state machine.
		 * 
		ctx->start_disk_sector = new_sector;
	} else {
		/*
		 * We are done if we wrapped around to the same sector.
		 * (???)
		 */
		if (new_sector == ctx->start_disk_sector) {
			ctx->first_wrap = false;
			ctx->start_disk_sector = 0;
			return STRIPE_SUCCESS;
		}

		/*
		 * Sector before the start sector?  Keep going and wrap
		 * around.
		 */
		if (new_sector < ctx->start_disk_sector) {
			ctx->first_wrap = true;
		} else {
			// ???
			if (new_sector <= ctx->disk_sector_done &&
			   !ctx->first_wrap)
				return STRIPE_SUCCESS;
		}
	}
