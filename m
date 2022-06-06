Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA6253E384
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbiFFHot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 03:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiFFHos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 03:44:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4569F12743
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 00:44:45 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 92FD521A50;
        Mon,  6 Jun 2022 07:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654501484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gl2LIOki7IclaVgoPOxZ9+LeHO0mCTcUzw9bAt9ainc=;
        b=D6bpADW7ZDmNA5kyTqEJPe76QrU6kx0RN0xMjcubZ90YoMrLZvFPSpik8Fw43CJ/U0DY4T
        Hl08qJJgHcNNM//HVFP5vp9j1V1wkY44HZ7oIBUXSj7kMDxxGHrr2E7X3q0j5Xd4/3mhLz
        DidW3d7H9JHgi1iqIHGu6k36dEQg+DI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654501484;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gl2LIOki7IclaVgoPOxZ9+LeHO0mCTcUzw9bAt9ainc=;
        b=oKGo6sNTWMh29fGUpsRPQxzL63npAQaAiVfmG8ph7q5iUZfR2e/wYG5r07B6r4fM6OQlpD
        fSHTdoLyq12XXRBg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 85F672C141;
        Mon,  6 Jun 2022 07:44:44 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 42EC7A0633; Mon,  6 Jun 2022 09:44:44 +0200 (CEST)
Date:   Mon, 6 Jun 2022 09:44:44 +0200
From:   Jan Kara <jack@suse.cz>
To:     wuchi <wuchi.zero@gmail.com>
Cc:     jack@suse.cz, hch@lst.de, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] lib/flex_proportions.c: Remove local_irq_ops in
 fprop_new_period()
Message-ID: <20220606074444.7givh4uaf2sgz6rn@quack3.lan>
References: <20220604131502.5190-1-wuchi.zero@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220604131502.5190-1-wuchi.zero@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 04-06-22 21:15:02, wuchi wrote:
> The commit <e78d4833c03e28> (lib: Fix possible deadlock in flexible
> proportion code) adds the local_irq_ops because percpu_counter_{sum
> |add} ops'lock can cause deadlock by interrupts. Now percpu_counter
> _{sum|add} ops use raw_spin_(un)lock_irq*, so revert the commit and
> resolve the conflict.
> 
> Signed-off-by: wuchi <wuchi.zero@gmail.com>

Yes, good point. Thanks for cleaning this up. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

I guess Andrew will pickup this patch, or should I do it Andrew?

								Honza

> ---
>  lib/flex_proportions.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/lib/flex_proportions.c b/lib/flex_proportions.c
> index 53e7eb1dd76c..05cccbcf1661 100644
> --- a/lib/flex_proportions.c
> +++ b/lib/flex_proportions.c
> @@ -63,18 +63,13 @@ void fprop_global_destroy(struct fprop_global *p)
>   */
>  bool fprop_new_period(struct fprop_global *p, int periods)
>  {
> -	s64 events;
> -	unsigned long flags;
> +	s64 events = percpu_counter_sum(&p->events);
>  
> -	local_irq_save(flags);
> -	events = percpu_counter_sum(&p->events);
>  	/*
>  	 * Don't do anything if there are no events.
>  	 */
> -	if (events <= 1) {
> -		local_irq_restore(flags);
> +	if (events <= 1)
>  		return false;
> -	}
>  	write_seqcount_begin(&p->sequence);
>  	if (periods < 64)
>  		events -= events >> periods;
> @@ -82,7 +77,6 @@ bool fprop_new_period(struct fprop_global *p, int periods)
>  	percpu_counter_add(&p->events, -events);
>  	p->period += periods;
>  	write_seqcount_end(&p->sequence);
> -	local_irq_restore(flags);
>  
>  	return true;
>  }
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
