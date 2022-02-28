Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AA74C7054
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 16:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbiB1PLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 10:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiB1PL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:11:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A67A78040;
        Mon, 28 Feb 2022 07:10:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9781160F79;
        Mon, 28 Feb 2022 15:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC541C340E7;
        Mon, 28 Feb 2022 15:10:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pIvr1d+o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1646061044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jQuhBCHHUW//7po3bY2Q72wpLcT2oHIDv8JxeMLWoMs=;
        b=pIvr1d+oGNZR/lMywlWpA4JpMZWY9Rf8ZU36C+ozNylhy7rrDhew6BGgOWhkzmuNQX55ci
        jK5wqE/sVQuEFTcb/S/gkCVdl6hPBB9dr34L4ardQfe7rnuIaR1b4JiPQksSby7acr4opF
        l6ccZAmE23jzBGdSKB1ZL/i+20m2hN0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c0439410 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 28 Feb 2022 15:10:43 +0000 (UTC)
Date:   Mon, 28 Feb 2022 16:10:38 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v2] random: do crng pre-init loading in worker rather
 than irq
Message-ID: <Yhzl7hgV12an3dhR@zx2c4.com>
References: <CAHmME9pTfwbs9xUJy_jrdPcrhSyVixSXBM==9EuB8v7ufWe9Pw@mail.gmail.com>
 <20220224152937.12747-1-Jason@zx2c4.com>
 <YhzWE1NqYQFKeL5B@linutronix.de>
 <CAHmME9r7bRh+CeBh98UMVCFgmeMWHQ=r3b-8odgV0tR45hOTbw@mail.gmail.com>
 <YhzcTOIQx5EkujXq@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YhzcTOIQx5EkujXq@linutronix.de>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Mon, Feb 28, 2022 at 03:29:32PM +0100, Sebastian Andrzej Siewior wrote:
> > > Could you please post a lockdep report so I can take a look?
> > 
> > I thought the problem with lockdep was stated by you somewhere in this thread?
> > https://lore.kernel.org/lkml/YfOqsOiNfURyvFRX@linutronix.de/
> > "But even then we need to find a way to move the crng init part
> > (crng_fast_load()) out of the hard-IRQ."
> > And Jonathan posted two related (?) splats he ran into.
> > 
> > I may have gotten that all wrong, in which case, I'll just excise that
> > part from the commit message. I'm pretty sure you want this patch
> > either way, right?
> 
> Oh, that report. So yes, I want that patch ;)
> 
> In this case the lockdep is right. The thing that it affects only
> PREEMPT_RT.
> That trylock is not the thing that lockdep complains about but the
> spin_lock_irqsave() within invalidate_batched_entropy().
> 
> Taking a spinlock_t from IRQ context is problematic for PREEMPT_RT,
> correct. A spin_try_lock() is also problematic since another spin_lock()
> invocation would PI-boost the wrong task (the spin_try_lock() is invoked
> from an IRQ-context so the task on CPU (random task or idle) is not the
> actual owner). I'm pointing this out because there was also _another_
> problem with try_lock from hard-IRQ context which was fixed in the
> meantime.
> 
> Would it work for you to update the commit message? Basically I'm fine
> with the firs sentence but the remaining part is misleading.

Ahh, I understand, okay. Yes, I'll change that first paragraph to
incorporate your wording, as:

"""
Taking spinlocks from IRQ context is generally problematic for
PREEMPT_RT. That is, in part, why we take trylocks instead. However, a
spin_try_lock() is also problematic since another spin_lock() invocation
can potentially PI-boost the wrong task, as the spin_try_lock() is
invoked from an IRQ-context, so the task on CPU (random task or idle) is
not the actual owner.
"""

Jason
