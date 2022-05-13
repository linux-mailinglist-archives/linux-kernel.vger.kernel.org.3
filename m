Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1107C525FF8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379273AbiEMKKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 06:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350059AbiEMKKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 06:10:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDF22716DA;
        Fri, 13 May 2022 03:10:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26496B82D6E;
        Fri, 13 May 2022 10:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF2AC34100;
        Fri, 13 May 2022 10:10:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="cU4PLSXO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652436627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XRTDzmsbx973kPInNKLCT2EVNm4Q75Rke98n59MN8J8=;
        b=cU4PLSXOglGt9Pm+hmiu2Al61hFi58Mnmh/9WXmxR9KakKqeKjzJuhWndgmWxyFMOtR3yQ
        hVlvrJU8ALL98FTR9MR/4HxqQi8Zgtkclt+tiWhYw+hQRYDSTo6pph+4CSPy0XT+lBiBSg
        DWooVsVS0Sl9aAfZgQd21/ihfovC5PA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bf1eb54c (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 13 May 2022 10:10:27 +0000 (UTC)
Date:   Fri, 13 May 2022 12:10:25 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] random: mix in timestamps and reseed on system restore
Message-ID: <Yn4ukUajXcgU/W91@zx2c4.com>
References: <20220501123849.3858-1-Jason@zx2c4.com>
 <Yn35yGyVYT7gwGEq@owl.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yn35yGyVYT7gwGEq@owl.dominikbrodowski.net>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dominik,

On Fri, May 13, 2022 at 08:25:12AM +0200, Dominik Brodowski wrote:
> Am Sun, May 01, 2022 at 02:38:49PM +0200 schrieb Jason A. Donenfeld:
> > Since the RNG loses freshness system suspend/hibernation, when we
> > resume, immediately reseed using whatever data we can, which for this
> > particular case is the various timestamps regarding system suspend time,
> > in addition to more generally the RDSEED/RDRAND/RDTSC values that happen
> > whenever the crng reseeds.
> > 
> > On systems that suspend and resume automatically all the time -- such as
> > Android -- we skip the reseeding on suspend resumption, since that could
> > wind up being far too busy. This is the same trade-off made in
> > WireGuard.
> > 
> > In addition to reseeding upon resumption always mix into the pool these
> > various stamps on every power notification event.
> > 
> > Cc: Theodore Ts'o <tytso@mit.edu>
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> >  drivers/char/random.c | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> > 
> > diff --git a/drivers/char/random.c b/drivers/char/random.c
> > index 0935a140795e..48eac27214ea 100644
> > --- a/drivers/char/random.c
> > +++ b/drivers/char/random.c
> > @@ -53,6 +53,7 @@
> >  #include <linux/completion.h>
> >  #include <linux/uuid.h>
> >  #include <linux/uaccess.h>
> > +#include <linux/suspend.h>
> >  #include <crypto/chacha.h>
> >  #include <crypto/blake2s.h>
> >  #include <asm/processor.h>
> > @@ -966,6 +967,37 @@ static int __init parse_trust_bootloader(char *arg)
> >  early_param("random.trust_cpu", parse_trust_cpu);
> >  early_param("random.trust_bootloader", parse_trust_bootloader);
> >  
> > +static int random_pm_notification(struct notifier_block *nb, unsigned long action, void *data)
> > +{
> > +	unsigned long flags, entropy = random_get_entropy();
> > +
> > +	/*
> > +	 * Encode a representation of how long the system has been suspended,
> > +	 * in a way that is distinct from prior system suspends.
> > +	 */
> > +	ktime_t stamps[] = {
> > +		ktime_get(),
> > +		ktime_get_boottime(),
> > +		ktime_get_real()
> > +	};
> > +
> > +	spin_lock_irqsave(&input_pool.lock, flags);
> > +	_mix_pool_bytes(&action, sizeof(action));
> > +	_mix_pool_bytes(stamps, sizeof(stamps));
> > +	_mix_pool_bytes(&entropy, sizeof(entropy));
> > +	spin_unlock_irqrestore(&input_pool.lock, flags);
> > +
> > +	if (action == PM_RESTORE_PREPARE ||
> > +	    (action == PM_POST_SUSPEND &&
> > +	     !IS_ENABLED(CONFIG_PM_AUTOSLEEP) && !IS_ENABLED(CONFIG_ANDROID))) {
> > +		crng_reseed(true);
> > +		pr_notice("crng reseeded on system resumption\n");
> > +	}
> > +	return 0;
> > +}
> 
> Should this also wake up any thread waiting in add_hwgenerator_randomness()
> / "use" the input already in store there?

That would be a nice enhancement I think. Feel free to submit a patch.
Maybe more generally, the add_hwgenerator_randomness() thing should wake
up not based on a timer but just everytime crng_reseed() is called by
something? There are a lot of ways to skin that cat, and hopefully we'll
be able to really revamp the way hwrandomness is used in the future,
both here and other concerns you've brought up like 0 crediting.

Jason
