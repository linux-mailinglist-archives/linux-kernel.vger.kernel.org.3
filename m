Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901FC587272
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 22:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbiHAUtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 16:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiHAUtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 16:49:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E2A2A268;
        Mon,  1 Aug 2022 13:48:59 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659386937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dat5xa5E/lEwDYPSAlowFSQnwBw0r1kem5ElGB1ydd0=;
        b=BTLKTq5qa6y8oFgPI11LD5sOpLfoGKVSH9tVvZhVfl+McxaW9Y6wMNs0pWu5Zme4dd64bv
        SG2JFEuE3eMSHYx1lDnU4ajha68cQUDB9/IUUkLOsiDH0WWS1zx0Cz26x+V9yLB1dJJ5bl
        NYGCefhtB26aITYUaJ41KkG0EIEIFtanRgeltlIqU0t5y424f0ToaYUpO5A8ABRXsAr/m4
        xUOKjvjdOw9CNyuMBv1rgW4HcOJAzMOMOgXG+vovv225SC96daMpjFXwzeZ4vm2Klnh/H7
        JZ3i5/QOOkhytNG60gGMNoCEVlw3rYqHENYsIk9Xg+wL8CNSYhTF3SiNC4qbAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659386937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dat5xa5E/lEwDYPSAlowFSQnwBw0r1kem5ElGB1ydd0=;
        b=Sp8PggihhISHUlZu90rNG3oLV9mEC3uKCgWY70wMBfCaomjVQ6WV5d7IqgQf9IL2v3ewwM
        RWLL6zTcWWADBeCg==
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        Nadia Heninger <nadiah@cs.ucsd.edu>,
        Thomas Ristenpart <ristenpart@cornell.edu>,
        Theodore Ts'o <tytso@mit.edu>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RFC v2] random: implement getrandom() in vDSO
In-Reply-To: <20220731013125.2103601-1-Jason@zx2c4.com>
References: <YuXLlUZ8EzvZB43U@zx2c4.com>
 <20220731013125.2103601-1-Jason@zx2c4.com>
Date:   Mon, 01 Aug 2022 22:48:56 +0200
Message-ID: <87v8rbsn9j.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31 2022 at 03:31, Jason A. Donenfeld wrote:

> +vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o vgetrandom.o

You clearly forgot to tell people that they need a special config to
make this compile.

I don't even have to try to see that this cannot build with a defconfig:

Lacks -pg for that file and the included chacha.c contains
EXPORT_SYMBOL() which is not really working in the VDSO.

> +DECLARE_VVAR_SINGLE(640, struct vdso_rng_data, _vdso_rng_data)
...
> +#define __vdso_rng_data (VVAR(_vdso_rng_data))
> +
> +static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(void)
> +{
> +	return &__vdso_rng_data;
> +}

That's not working with time name spaces.

> +static __always_inline ssize_t
> +__cvdso_getrandom(void *opaque_state, void *buffer, size_t len, unsigned int flags)
> +{
> +	struct getrandom_state *state = opaque_state;
> +	const struct vdso_rng_data *rng_info = __arch_get_vdso_rng_data();

This gives you vvar__vdso_rng_data and that points to the VVAR page at
offset 640. That works up to the point where a task is part of a
non-root time name space.

The kernel side mapping (the one which is updated) looks like this:

    VVAR_PAGE
    VIRT_CLOCK_PAGE[S]
    TIMENS_PAGE

If time namespaces are disabled or the task is in the root time
namespace then the user mapping is in the same order.

If the task is in the non-root time namespace, then the user mapping is:

    TIMENS_PAGE
    VIRT_CLOCK_PAGE[S]
    VVAR_PAGE

So your user space looks at offset 640 in the TIMENS_PAGE, which has
rand_data->ready and rand_data->generation == 0 forever.

See the comment above timens_setup_vdso_data() and look at the way how
e.g. __cvdso_time_data() deals with that.

VDSO hacking is special and not a sunday evening project. :)

Thanks,

        tglx
