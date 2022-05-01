Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F9A516400
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 13:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345642AbiEALUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 07:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345385AbiEALUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 07:20:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA26C33EAA;
        Sun,  1 May 2022 04:16:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9692860E1F;
        Sun,  1 May 2022 11:16:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784DAC385A9;
        Sun,  1 May 2022 11:16:53 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jL/mQeo/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651403812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xHARVfgSK74zGcv02Q7PtU/TQGPI87rkXvTgtZVty90=;
        b=jL/mQeo/DWCjYW8XzGl+ocGiuu6G7LvWHpM3bjOaMPDEfNohKaNVCaDr34KjE4Fh+9ggnq
        8FxUF91qzmnWqq8EVqxSUJHMn9nk4IXygtTN9MB11i1Knv/+L4aZ3Qal+L6Eol9VJSsCTF
        1vur+dSlm6ohYTDk6Vq5EZUduab851o=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c3dae223 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 1 May 2022 11:16:51 +0000 (UTC)
Date:   Sun, 1 May 2022 13:16:48 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     tytso <tytso@mit.edu>
Cc:     nadiah@cs.ucsd.edu, noahsd@gmail.com, dodis@cs.nyu.edu,
        tessaro@cs.washington.edu, torvalds@linux-foundation.org,
        djb@cr.yp.to, jeanphilippe.aumasson@gmail.com, jann@thejh.net,
        keescook@chromium.org, gregkh@linuxfoundation.org,
        peter@cryptojedi.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: is "premature next" a real world rng concern, or just an
 academic exercise?
Message-ID: <Ym5sICj5iBMn2w/E@zx2c4.com>
References: <YmlMGx6+uigkGiZ0@zx2c4.com>
 <Ym3ZM1P+uYYABtRm@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ym3ZM1P+uYYABtRm@mit.edu>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ted,

That's a useful analysis; thanks for that.

On Sat, Apr 30, 2022 at 05:49:55PM -0700, tytso wrote:
> On Wed, Apr 27, 2022 at 03:58:51PM +0200, Jason A. Donenfeld wrote:
> > 
> > 3) More broadly speaking, what kernel infoleak is actually acceptable to
> >    the degree that anybody would feel okay in the first place about the
> >    system continuing to run after it's been compromised?
> 
> A one-time kernel infoleak where this might seem most likely is one
> where memory is read while the system is suspended/hibernated, or if
> you have a VM which is frozen and then replicated.  A related version
> is one where a VM is getting migrated from one host to another, and
> the attacker is able to grab the system memory from the source "host"
> after the VM is migrated to the destination "host".

You've identified ~two places where compromises happen, but it's not an
attack that can just be repeated simply by re-running `./sploit > state`.

1) Virtual machines:

It seems like after a VM state compromise during migration, or during
snapshotting, the name of the game is getting entropy into the RNG in a
usable way _as soon as possible_, and not delaying that. This is
Nadia's point. There's some inherent tension between waiting some amount
of time to use all available entropy -- the premature next requirement
-- and using everything you can as fast as you can because your output
stream is compromised/duplicated and that's very bad and should be
mitigated ASAP at any expense.

[I'm also CC'ing Tom Risenpart, who's been following this thread, as he
 did some work regarding VM snapshots and compromise, and what RNG
 recovery in that context looks like, and arrived at pretty similar
 points.]

You mentioned virtio-rng as a mitigation for this. That works, but only
if the data read from it are actually used rather quickly. So probably
/waiting/ to use that is suboptimal.

One of the things added for 5.18 is this new "vmgenid" driver, which
responds to fork/snapshot notifications from hypervisors, so that VMs
can do something _immediately_ upon resumption/migration/etc. That's
probably the best general solution to that problem.

Though vmgenid is supported by QEMU, VMware, Hyper-V, and hopefully soon
Firecracker, there'll still be people that don't have it for one reason
or another (and it has to be enabled manually in QEMU with `-device
vmgenid,guid=auto`; perhaps I should send a patch adding that to some
default machine types). Maybe that's their problem, but I take as your
point that we can still try to be less bad than otherwise by using more
entropy more often, and not delaying as the premature next model
requirements would have us do.

2) Suspend / hibernation:

This is kind of the same situation as virtual machines, but the
particulars are a little bit different:

  - There's no hypervisor giving us new seed material on resumption like
    we have with VM snapshots and vmgenid; but

  - We also always know when it happens, because it's not transparent to
    the OS, so at least we can attempt to do something immediately like
    we do with the vmgenid driver.

Fortunately, most systems that are doing suspend or hibernation these
days also have a RDRAND-like thing. It seems like it'd be a good idea
for me to add a PM notifier, mix into the pool both
ktime_get_boottime_ns() and ktime_get(), in addition to whatever type
info I get from the notifier block (suspend vs hibernate vs whatever
else) to account for the amount of time in the sleeping state, and then
immediately reseed the crng, which will pull in a bunch of
RDSEED/RDRAND/RDTSC values. This way on resumption, the system is always
in a good place.

I did this years ago in WireGuard -- clearing key material before
suspend -- and there are some details around autosuspend (see
wg_pm_notification() in drivers/net/wireguard/device.c), but it's not
that hard to get right, so I'll give it a stab and send a patch.

> But if the attacker can actually obtain internal state from one
> reconstituted VM, and use that to attack another reconstituted VM, and
> the attacker also knows what the nonce or time seed that was used so
> that different reconstituted VMs will have unique CRNG streams, this
> might be a place where the "premature next" attack might come into
> play.

This is the place where it matters, I guess. It's also where the
tradeoff's from Nadia's argument come into play. System state gets
compromised during VM migration / hibernation. It comes back online and
starts doling out compromised random numbers. Worst case scenario is
there's no RDRAND or vmgenid or virtio-rng, and we've just got the good
old interrupt handler mangling cycle counters. Choices: A) recover from
the compromise /slowly/ in order to mitigate premature next, or B)
recover from the compromise /quickly/ in order to prevent things like
nonce reuse.

What is more likely? That an attacker who compromised this state at one
point in time doesn't have the means to do it again elsewhere in the
pipeline, will use a high bandwidth /dev/urandom output stream to mount
a premature next attack, and is going after a high value target that
inexplicably doesn't have RDRAND/vmgenid/virtio-rng enabled? Or that
Nadia's group (or that large building in Utah) will get an Internet tap
and simply start looking for repeated nonces to break?
 
Jason
