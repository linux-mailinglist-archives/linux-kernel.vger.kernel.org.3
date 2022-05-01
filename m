Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38975516121
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 02:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236922AbiEAAyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 20:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbiEAAxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 20:53:51 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF2D63E7;
        Sat, 30 Apr 2022 17:50:25 -0700 (PDT)
Received: from penguin.thunk.org (rrcs-69-75-72-162.west.biz.rr.com [69.75.72.162])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2410nvLC001587
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 30 Apr 2022 20:49:59 -0400
Received: by penguin.thunk.org (Postfix, from userid 1000)
        id B068E3D5B5; Sat, 30 Apr 2022 20:49:55 -0400 (EDT)
Date:   Sat, 30 Apr 2022 17:49:55 -0700
From:   tytso <tytso@mit.edu>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     nadiah@cs.ucsd.edu, noahsd@gmail.com, dodis@cs.nyu.edu,
        tessaro@cs.washington.edu, torvalds@linux-foundation.org,
        djb@cr.yp.to, jeanphilippe.aumasson@gmail.com, jann@thejh.net,
        keescook@chromium.org, gregkh@linuxfoundation.org,
        peter@cryptojedi.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: is "premature next" a real world rng concern, or just an
 academic exercise?
Message-ID: <Ym3ZM1P+uYYABtRm@mit.edu>
References: <YmlMGx6+uigkGiZ0@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmlMGx6+uigkGiZ0@zx2c4.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 03:58:51PM +0200, Jason A. Donenfeld wrote:
> 
> 3) More broadly speaking, what kernel infoleak is actually acceptable to
>    the degree that anybody would feel okay in the first place about the
>    system continuing to run after it's been compromised?

A one-time kernel infoleak where this might seem most likely is one
where memory is read while the system is suspended/hibernated, or if
you have a VM which is frozen and then replicated.  A related version
is one where a VM is getting migrated from one host to another, and
the attacker is able to grab the system memory from the source "host"
after the VM is migrated to the destination "host".

Merely reseeding the CRNG from the input pool isn't going to help,
since the attacker could have grabed not only the CRNG pool, but the
input pool as well.  In the case where the guest image is "freeze
dried" and then reconstituted multiple times, and where the attacker
hasn't actually grabed state, then all you need to do is to mix in
some kind of nonce, such as the current time (which hopefully will
vary across different VM "reconstitutions"), or some kind none (for
example the VM ID, if that can be obtained somehow).

But if the attacker can actually obtain internal state from one
reconstituted VM, and use that to attack another reconstituted VM, and
the attacker also knows what the nonce or time seed that was used so
that different reconstituted VMs will have unique CRNG streams, this
might be a place where the "premature next" attack might come into
play.

The simplest mitigation is if you have some kind of external RNG which
you can actually trust, or at least mostly trust.  e.g., either some
kind of CPU-based hwrng, such as RDRAND, or a hypervisor-provided
hwrng, such as Virtio-RNG.  And if the hypervisor is going to playing
games with reconstituting freeze-dried VM's, I'd argue it can d*mned
well provide a virtio-rng facility.  And the same argument could be
made just as easily with live migration scenario, with the hypervisor
providing some kind of notification that VM had just gotten live
migrated, so it should really reseed from the virtio-rng facility
right away.

That leaves the variant where the kernel infoleak happened while the
system was suspended.  And in that case, we're talking about an
attacker which had physical access to the machine (say, an "evil maid"
attack while the laptop was left suspended in a hotel room in Moscow
or Beijing).  And in that case, there are probably far simpler ways
that an "evil amid" with temporary physical access to the hardware
could compromise the secuity of the unattended laptop.

> Is "premature next" just an academic exercise, rather than a real world
> RNG concern?

I'd say it's mostly an academic exercise.  Given our current model,
where we only reseed the CRNG periodically, and we're hopefully
getting some amount of uncertainty into the input pool, there will be
a certain amount of "catastrophic reseeding" going on, which I don't
think is a bad thing.  But personally, I don't think the complexity of
N levels of Fortuna pools are worth it.

						- Ted

