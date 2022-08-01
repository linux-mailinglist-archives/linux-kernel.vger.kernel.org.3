Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07FC58744E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 01:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbiHAXRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 19:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbiHAXRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 19:17:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9941C1571F;
        Mon,  1 Aug 2022 16:17:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90A65B81624;
        Mon,  1 Aug 2022 23:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0226DC433C1;
        Mon,  1 Aug 2022 23:17:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KjyvVmoT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659395820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6BLlcSVe1CGPnmaca1xSo/G7abzxcO+mP2nlAj4VRgM=;
        b=KjyvVmoTB9SNZ8poPhaMmH3/8n06j7ZChE8PP72Y9ZHmCz0L7wnqpi4fioWdyv5aRgtVjH
        Kcvn6bvYZpCcKbJCVoDVbPDPMreYiPEbaULCtbOxrzs1815Ay3WRQyoGWFxk+4JnwBm4/s
        dw83dXUA12VQSArYwSiems++IoRAgQ0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ac8a4693 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 1 Aug 2022 23:16:59 +0000 (UTC)
Date:   Tue, 2 Aug 2022 01:16:56 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        x86@kernel.org, Nadia Heninger <nadiah@cs.ucsd.edu>,
        Thomas Ristenpart <ristenpart@cornell.edu>,
        Theodore Ts'o <tytso@mit.edu>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH RFC v1] random: implement getrandom() in vDSO
Message-ID: <Yuhe6IIFXqNMZs5b@zx2c4.com>
References: <20220729145525.1729066-1-Jason@zx2c4.com>
 <CAHk-=wiLwz=9h9LD1-_yb1+T+u59a2EjTmMvCiGj4A-ZsPN1wA@mail.gmail.com>
 <YuXCpyULk6jFgGV5@zx2c4.com>
 <87zggnsqwj.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zggnsqwj.ffs@tglx>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 09:30:20PM +0200, Thomas Gleixner wrote:
> Jason!

Thomas!

> > So, anyway, if I do muster a v2 of this (perhaps just to see the idea
> > through), the API might split in two to something like:
> >
> >   void *getrandom_allocate_states([inout] size_t *number_of_states, [out] size_t *length_per_state);
> >   ssize_t getrandom(void *state, void *buffer, size_t len, unsigned long flags);
> 
> I'm not seeing any reason to have those functions at all.
> 
> The only thing which would be VDSO worthy here is the access to
> random_state->ready and random_state->generation as that's the
> information which is otherwise not available to userspace.

I think you might have missed the part of the patch message where I
discuss this. I'm happy to talk about that more, but it might help the
discussion to refer to the parts already addressed. Reproduced here:

| How do we rectify this? By putting a safe implementation of getrandom()
| in the vDSO, which has access to whatever information a
| particular iteration of random.c is using to make its decisions. I use
| that careful language of "particular iteration of random.c", because the
| set of things that a vDSO getrandom() implementation might need for making
| decisions as good as the kernel's will likely change over time. This
| isn't just a matter of exporting certain *data* to userspace. We're not
| going to commit to a "data API" where the various heuristics used are
| exposed, locking in how the kernel works for decades to come, and then
| leave it to various userspaces to roll something on top and shoot
| themselves in the foot and have all sorts of complexity disasters.
| Rather, vDSO getrandom() is supposed to be the *same exact algorithm*
| that runs in the kernel, except it's been hoisted into userspace as
| much as possible. And so vDSO getrandom() and kernel getrandom() will
| always mirror each other hermetically.

To reiterate, I don't want to commit to a particular data API, or even
to an ideal interplay between kernel random and user random. I'd like to
retain the latitude to change the semantics there considerably, so that
Linux isn't locked into one RNG design forever. I think that kind of
lock in would be a mistake. For example, just the generation counter
alone won't do it (as I mentioned later on in the message; the RFC patch
is somewhat incomplete). Rather, the interface I'm fine committing to
would be the higher level getrandom(), with maybe an added state
parameter, which doesn't expose any guts about what it's actually doing.

Comex (CC'd) described in a forum comment the idea (and perhaps vDSO in
general?) as a little more akin to system libraries on Windows or macOS,
which represent the OS barrier, rather than the raw system call. Such
libraries then can operate on private data as necessary. So in that
sense, this patch here isn't very Linuxy (which Comex described as a
potentially positive thing, but I assume you disagree).

Anyway, I guess it in large part isn't so dissimilar to decisions you
made around other vDSO functions, where to draw the barrier, etc. Why
not just have an accessor for each vvar struct member and leave it to
userspaces to implement? Well, that'd probably be a terrible idea for
various reasons, and I feel the same way about exposing too many
getrandom() guts.

> So you can just have:
> 
>    int random_check_and_update_generation(u64 *generation);
> 
> Everything else is library material, really.

Not very appealing for the reasons mentioned above, but also for the
record, I may like this idea for a closely related thing, vmgenid, but
that's a different conversation I'll get back to another time.

Jason
