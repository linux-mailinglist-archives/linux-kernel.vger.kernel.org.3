Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48F2522531
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 22:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbiEJUJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 16:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiEJUJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 16:09:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931F1517CC;
        Tue, 10 May 2022 13:09:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 241D0B81CCA;
        Tue, 10 May 2022 20:09:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF09C385CA;
        Tue, 10 May 2022 20:09:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eNIy6d7i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652213352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iVsjahm8BYGF5k4eUyIen00pH/noxcYbwc9i8vcgHoE=;
        b=eNIy6d7iwonW+4amRxi1drIzCnIhDu3e/N6LWFCJlEu9GdZjwGDAIfp9Fmjip8qlfLhqwQ
        doq0CD7Axjzrq/xGg6PJBWhixYTJQFo5JcMJkZfiWN6tUb8Fmwi6fh7mSqg1fNjOldzKoR
        tzyBotb8FJqC5fvEMB56LM/WkQ0d0i4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id eceaa09b (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 10 May 2022 20:09:11 +0000 (UTC)
Date:   Tue, 10 May 2022 22:09:04 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     dodis@cs.nyu.edu, tytso@mit.edu, nadiah@cs.ucsd.edu,
        noahsd@gmail.com, tessaro@cs.washington.edu,
        torvalds@linux-foundation.org, jeanphilippe.aumasson@gmail.com,
        jann@thejh.net, keescook@chromium.org, gregkh@linuxfoundation.org,
        peter@cryptojedi.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, "D. J. Bernstein" <djb@cr.yp.to>
Subject: Re: is "premature next" a real world rng concern, or just an
 academic exercise?
Message-ID: <YnrGYMyEL8qPMRGt@zx2c4.com>
References: <YmlMGx6+uigkGiZ0@zx2c4.com>
 <Ym3ZM1P+uYYABtRm@mit.edu>
 <Ym5sICj5iBMn2w/E@zx2c4.com>
 <CAMvzKsiA52Si=PzOJXYwGSA1WUz-1S0A8cpgRJWDzpMkfFbX+Q@mail.gmail.com>
 <CAMvzKsiMY_+8HZqeFqD3tR65a3-JB0LG=+0jBBy1zF4GanrsGA@mail.gmail.com>
 <YnqDC25iR8mcL3XB@zx2c4.com>
 <20220510185123.80607.qmail@cr.yp.to>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220510185123.80607.qmail@cr.yp.to>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Dan,

On Tue, May 10, 2022 at 08:51:23PM +0200, D. J. Bernstein wrote:
> Jason A. Donenfeld writes:
> > Right, VMs are super problematic, but for that, there's now this
> > "vmgenid" driver, where the hypervisor actually gives a 128-bit seed to
> > guests when they're resumed, so that we can immediately reseed, which
> > should pretty comprehensively handle that situation.
> 
> Hmmm. If an application initializes its own RNG state from /dev/urandom,
> and is then cloned, and then generates an ECDSA nonce from the RNG
> state, and then uses this nonce to sign a message that's different
> across the clones, how is disaster averted?

Currently WireGuard will drop its ephemeral session key material from
the tx path, to prevent nonce use. This is because of an in-kernel
mechanism I added in 5.18, which is pretty minimal and non-invasive, and
came basically for free. CTRL+F for "vmgenid" in here for details:
https://www.zx2c4.com/projects/linux-rng-5.17-5.18/

For 5.19 (or at this point, more likely 5.20), there's a userspace
notifier in store, maybe, if I can figure out how to do it right.
There's a pretty bikesheddy thread here on what shape that interface
should take: https://lore.kernel.org/lkml/YnA5CUJKvqmXJxf2@zx2c4.com/
But basically there are some details about how an async interface should
work, and what the virtual hardware future, if any, looks like for a
memory mapped race-free polling interface. Plus some considerations on
how much we should care etc.

> Given the goal of sending money to cryptographers, I'm pretty sure we
> want the answer to be a security-audit nightmare, so let me suggest the
> following idea. There's SIGWINCH to notify processes about window-size
> changes, so there should also be a signal for RNG changes, which should
> be called SIGRINCH, and there should be a different mechanism to address
> RNG output cloning inside the kernel, and there should be endless papers
> on Grinch Attacks, including papers that sort of prove security against
> Grinch Attacks, and deployment of software that's sort of protected
> against Grinch Attacks, and fear of the bad PR from abandoning anything
> labeled as protection, because, hey, _maybe_ the protection accomplishes
> something, and it's not as if anyone is going to be blamed for whatever
> damage is caused by the systems-level effect of the added complexity.

I mean... you kid, but you're also kind of on point here. There are
about a thousand ways of doing this kind of notification that lead to
impossible-to-program-for paradigms that people will find necessary to
implement, and it'll be a nightmare if not done in a sufficiently slick
way. For the in-kernel thing WireGuard uses, it doesn't really matter
because the kernel is one big codebase so ergonomics can change need be.
But userspace is another challenge.

Jason
