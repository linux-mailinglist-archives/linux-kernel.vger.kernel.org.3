Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CA0585B11
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 17:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbiG3PtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 11:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbiG3PtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 11:49:03 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F57315A1A
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 08:49:02 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id i13so8925744edj.11
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 08:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=YJCZuifYbBHHVUq8hg52oBQXwufMLlt5AWoYuTd/5Rw=;
        b=au15hpWWy8nTU6PUXBhTIhRkZrhjaE650nazkqq0yf5pJGpsrnZVd3qTIKQerPinE3
         /eCD+niBPu+FM6F6SFD4oEkIwkmQ2ZnRFYvYy0CB3YaeXXAuhjx246hyZHON5mmtuAiw
         6Ejwde6oSlpwSvQhvaA1a6wskcrFNLrUW7RIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=YJCZuifYbBHHVUq8hg52oBQXwufMLlt5AWoYuTd/5Rw=;
        b=HSt1nppspHvJZ54U8HJ2lvsy67VZLZzlj1Bguqi5ocWmM0549iIxpEh55wfH98wPkt
         x7bp0YuVW3SvPv0cdqhaL9p7oYP21LVDZ7kHpWGBUxCCRQozijAyy/Wt2kGBx+8Q9e26
         CZD4t7e41BEvCSyZyMOauCF4IMz1U13DEeW3YzsnLR8qgcYRoOmoOw5Kr9bNKpq6PKJZ
         ZsTA1cp8sAh9Qh52QLsgpm4NKWLZcktuYagSuhVA1HC+3F8cufT0+JF1BHLZmB8bkwcs
         dhjbAk0mEPIsfMz3pH2KGyE+8QHeub3IWymjshS6KKb4QkFl2Kc+OYG04sC5QNmm/idx
         HEEw==
X-Gm-Message-State: AJIora9pMVyeiFpkkgduhX4sqZjgTXadXKOV+LmbtUVE7J701VvKD1R/
        /janrTtD+9RaocXI4ZAdOz38iOxYBE0jfOyS
X-Google-Smtp-Source: AGRyM1uWyFSZ0sM2uQdiShLbG+dm3Amz4WeTnPVs8cP/yxG/gTZd0RwoX8Tult6/PBtEVRcHEeNDqQ==
X-Received: by 2002:a05:6402:d05:b0:425:b7ab:776e with SMTP id eb5-20020a0564020d0500b00425b7ab776emr8452607edb.142.1659196140558;
        Sat, 30 Jul 2022 08:49:00 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id e21-20020a170906315500b0072af930cf97sm3087850eje.115.2022.07.30.08.48.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Jul 2022 08:48:59 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id 129-20020a1c0287000000b003a2fa488efdso743498wmc.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 08:48:59 -0700 (PDT)
X-Received: by 2002:a05:600c:21d7:b0:3a3:2088:bbc6 with SMTP id
 x23-20020a05600c21d700b003a32088bbc6mr6044685wmj.68.1659196138936; Sat, 30
 Jul 2022 08:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220729145525.1729066-1-Jason@zx2c4.com>
In-Reply-To: <20220729145525.1729066-1-Jason@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 30 Jul 2022 08:48:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiLwz=9h9LD1-_yb1+T+u59a2EjTmMvCiGj4A-ZsPN1wA@mail.gmail.com>
Message-ID: <CAHk-=wiLwz=9h9LD1-_yb1+T+u59a2EjTmMvCiGj4A-ZsPN1wA@mail.gmail.com>
Subject: Re: [PATCH RFC v1] random: implement getrandom() in vDSO
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        x86@kernel.org, Nadia Heninger <nadiah@cs.ucsd.edu>,
        Thomas Ristenpart <ristenpart@cornell.edu>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Florian Weimer <fweimer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 3:32 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Two statements:
>
>   1) Userspace wants faster cryptographically secure numbers of
>      arbitrary size, big or small.
>
>   2) Userspace is currently unable to safely roll its own RNG with the
>      same security profile as getrandom().

So I'm really not convinced that this kind of thing is something the
kernel should work that hard to help.

And that state allocation in particular looks very random in all the
wrong ways, with various "if I run out of resources I'll just do a
system call" things.

Which just makes me go "just do the system call".

People who are _that_ sensitive to performance can't use this anyway,
unless they know the exact rules of "ok, I only need X state buffers"
(ok, the buckets are probably the more real "sometimes it might fail"
thing). So they basically need to know about the implementation
details - even if it's only about that kind of "only a limited number
of states" thing.

Not to mention that I don't think your patch can work anyway, with
things like "cmpxchg()" not being something you can do in the vdso
because it might have the kernel instrumentation in it.

So this all smells really fragile to me, and honestly, unlike the vdso
things we _do_ have, I don't think I've ever seen getrandom() be a
huge deal performance-wise.

It's just too specialized, and the people who care about performance
can - and do - do special things anyway.

Your patch fundamentally seems to be about "make it easy to not have
to care, and still get high performance", but that's _such_ a small
use-case (the intersection between "don't care" and "really really
need high performance" would seem to be basically NIL).

              Linus
