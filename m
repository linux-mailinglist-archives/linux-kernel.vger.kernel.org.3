Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07431587482
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 01:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbiHAXmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 19:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbiHAXmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 19:42:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6036B27FCC;
        Mon,  1 Aug 2022 16:42:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E75C660F53;
        Mon,  1 Aug 2022 23:42:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4A6C433C1;
        Mon,  1 Aug 2022 23:42:03 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="A0JD2hrr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659397321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KE+Z7Xz+ouZT/080HMVULCy2dY3YczC2NNCozWYJR8I=;
        b=A0JD2hrroEZQ99dno6fb2bsPEwYCXv/PrThhRgvDjtOafeIecPw37bISnI9LF10F1IzXkR
        6P4J/aJvBByBE7Ine8vQ3uvGXUHpTrZyN7oie6iI25EYAMLAWDFkfKnZLOrCFwUUW4k9Mm
        +fQxz9WFw3xGRkxwxrI13mTM2UlUhmg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bd202276 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 1 Aug 2022 23:42:01 +0000 (UTC)
Date:   Tue, 2 Aug 2022 01:41:58 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        x86@kernel.org, Nadia Heninger <nadiah@cs.ucsd.edu>,
        Thomas Ristenpart <ristenpart@cornell.edu>,
        Theodore Ts'o <tytso@mit.edu>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RFC v2] random: implement getrandom() in vDSO
Message-ID: <YuhkxqBIflCVo23l@zx2c4.com>
References: <YuXLlUZ8EzvZB43U@zx2c4.com>
 <20220731013125.2103601-1-Jason@zx2c4.com>
 <87v8rbsn9j.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v8rbsn9j.ffs@tglx>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Mon, Aug 01, 2022 at 10:48:56PM +0200, Thomas Gleixner wrote:
> On Sun, Jul 31 2022 at 03:31, Jason A. Donenfeld wrote:
> You clearly forgot to tell people that they need a special config to
> make this compile.

As I wrote in my patch body:

| The actual place that has the most work to do is in all of the other
| files. Most of the vDSO shared page infrastructure is centered around
| gettimeofday, and so the main structs are all in arrays for different
| timestamp types, and attached to time namespaces, and so forth. I've
| done the best I could to add onto this in an unintrusive way, but you'll
| notice almost immediately from glancing at the code that it still needs
| some untangling work. This also only works on x86 at the moment. I could
| certainly use a hand with this part.

So I'm not surprised other things are screwed up. This works well in my
test harness, indeed, but I imagine there are lots of fiddly bits like
that to work out. I wanted to send an RFC to elicit comments on the idea
and API before moving forward, as I have a strong sense this is one of
those "90% 10%" things, where 10% of the details take 90% of the time.

Also, I haven't hooked up vdso32 yet.

> > +vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o vgetrandom.o
> 
> I don't even have to try to see that this cannot build with a defconfig:
> 
> Lacks -pg for that file and the included chacha.c contains
> EXPORT_SYMBOL() which is not really working in the VDSO.

Thanks, I'll address this if I do a v3. You meant the removal of -pg,
right? For the EXPORT_SYMBOL() stuff (and other symbols), I'm not sure
whether I'll add an #ifdef maze, hoist a static function into a .h file,
or just make another minier implementation of the necessary functions.
Each approach has a pitfall.

> > +DECLARE_VVAR_SINGLE(640, struct vdso_rng_data, _vdso_rng_data)
> ...
> > +#define __vdso_rng_data (VVAR(_vdso_rng_data))
> > +
> > +static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(void)
> > +{
> > +	return &__vdso_rng_data;
> > +}
> 
> That's not working with time name spaces.

> > +static __always_inline ssize_t
> > +__cvdso_getrandom(void *opaque_state, void *buffer, size_t len, unsigned int flags)
> > +{
> > +	struct getrandom_state *state = opaque_state;
> > +	const struct vdso_rng_data *rng_info = __arch_get_vdso_rng_data();
> 
> This gives you vvar__vdso_rng_data and that points to the VVAR page at
> offset 640. That works up to the point where a task is part of a
> non-root time name space.
> 
> The kernel side mapping (the one which is updated) looks like this:
> 
>     VVAR_PAGE
>     VIRT_CLOCK_PAGE[S]
>     TIMENS_PAGE
> 
> If time namespaces are disabled or the task is in the root time
> namespace then the user mapping is in the same order.
> 
> If the task is in the non-root time namespace, then the user mapping is:
> 
>     TIMENS_PAGE
>     VIRT_CLOCK_PAGE[S]
>     VVAR_PAGE
> 
> So your user space looks at offset 640 in the TIMENS_PAGE, which has
> rand_data->ready and rand_data->generation == 0 forever.
> 
> See the comment above timens_setup_vdso_data() and look at the way how
> e.g. __cvdso_time_data() deals with that.

Ahhh, bingo! Thanks a lot for that. I couldn't quite grok before what
was happening with the timens stuff, but I think I get it now. When a
process is made in a timens, these pages are mapped differently, so that
the timens is in the same place as the init ns page would be. That's
clever. So I need to figure out some way to make __arch_get_vdso_rng_
data() always return the address of VVAR_PAGE, even when it's been
scooted down... I guess this means checking a bit in what's normally in
the vvar slot, and if it's a timens one, then loading the one that it's
in the timens slot, since that'll be the vvar one. Maybe that'll do it.

> VDSO hacking is special and not a sunday evening project. :)

While initially a somewhat bewildering maze, it's a rather fun puzzle.

Jason
