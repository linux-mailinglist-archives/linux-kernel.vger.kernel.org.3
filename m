Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F332B51EF53
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239483AbiEHTHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238209AbiEHR1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 13:27:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DF8DED0
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 10:23:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9512A6127C
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 17:23:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83812C385AC;
        Sun,  8 May 2022 17:23:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="EJMfnS5L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652030636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OY+nHI0YO6kQCBNTlVRD8FLakJgR/zoriqgGdSPfjBU=;
        b=EJMfnS5LiNVA/YwaUPsNY3gMvEgWOytlhQ/WJAOcmR7VyX529vbsns7pecoytsnFpvM0q0
        ceFFJFF4cszAQsPLECUOcrb4TQ5kzW2rNPiKob/CF4XfiygclPjFfZAshzt4krQPLfEYwn
        /6o0LL0tkoAYrQLNJHwcpof4RC9ut38=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3cffb8ff (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 8 May 2022 17:23:55 +0000 (UTC)
Date:   Sun, 8 May 2022 19:23:52 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH] random: use symbolic constants for crng_init states
Message-ID: <Ynf8qMmN+AAofKMy@zx2c4.com>
References: <20220508112609.138889-1-Jason@zx2c4.com>
 <d0b220993b2fb1d306bb959707ceb374596de559.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d0b220993b2fb1d306bb959707ceb374596de559.camel@perches.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 08, 2022 at 05:57:18AM -0700, Joe Perches wrote:
> > diff --git a/drivers/char/random.c b/drivers/char/random.c
> []
> > @@ -72,16 +72,16 @@
> []
> > -/* Various types of waiters for crng_init->2 transition. */
> > +static enum {
> > +	CRNG_EMPTY = 0, /* Little to no entropy collected */
> > +	CRNG_EARLY = 1, /* At least POOL_EARLY_BITS collected */
> > +	CRNG_READY = 2  /* Fully iniitalized with POOL_READY_BITS collected */
> 
> typo: initialized

Thanks, will do.

> 
> >  enum {
> >  	POOL_BITS = BLAKE2S_HASH_SIZE * 8,
> > -	POOL_INIT_BITS = POOL_BITS, /* No point in settling for less. */
> > -	POOL_FAST_INIT_BITS = POOL_INIT_BITS / 2
> > +	POOL_READY_BITS = POOL_BITS, /* When crng_init->CRNG_READY */
> > +	POOL_EARLY_BITS = POOL_READY_BITS / 2 /* When crng_init->CRNG_EARLY */
> 
> Seems odd to use a divisor with an enum

Why? The constants are defined in terms of other constants.

Jason
