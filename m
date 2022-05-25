Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE405341AD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 18:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241218AbiEYQsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 12:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbiEYQsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 12:48:07 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B481F13F31
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 09:48:05 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id rs12so31096894ejb.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 09:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F4isnC1WV1H+0V+3lJAgXeygwiC1DgPFe1wzw0Zc3VU=;
        b=S+ACfIvzcWJjlMglo+Uy8+sLEk2CQ9HbwaLYlmJKrTBKc1vcpsXurnUVhYGBeP0wlU
         DpyqNHi/aXQ6zRQ1Dc8Y66siU4BdBur2XHOixq7DX2mt1ijDGVtTi6nkFLq+j6sVcWC/
         H3eSkQZj85Ekc/wp2KTVDQlAgCQNXgGdCeIK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F4isnC1WV1H+0V+3lJAgXeygwiC1DgPFe1wzw0Zc3VU=;
        b=E+0B4++QEF8+B5UxENhze2bvHvJvpT3zFLW+MH9FQr6khvr8SRLEZGF5aF779auu7T
         SE8p4g8WGw53Ip+kJ0PWG9dRpbkyN6mNzLv9COTy4yuSMGHNsL5YfVVNznOHBfuB5GmX
         iOPyft9KXLGqgvopcnpKbpXOEXMl8+3oEyV/lGRgp2P+3czcSfCuDwcyqa+vdePqPUFq
         OFbslgRWyVhHZwEKGkNyy6l7JOi2GPUmPs2l0E87EsB2a0I2OmNUDMszUSwF/PRRYify
         EbFitbQltAW5J853f5rztP6iFrpTI9TjTLbPNjgRAhs21oRBh7giyXSHG5BWzeEU5vfR
         eNDg==
X-Gm-Message-State: AOAM533/x3Ibqn8P3q47By42rNAkManloBZ3p2r2dDJ2P61Nj82cq3Gg
        hMm7m7CMbnTmql1LkXJmJhryV1G2f6kmSDT4
X-Google-Smtp-Source: ABdhPJwTgce7DXpEz10m+0gp3Rnfq92g5qBSrf/U2D+0PADgrjMYDoppnM7Oz90WDPoQ5z6qQNodTQ==
X-Received: by 2002:a17:906:4fd1:b0:6f3:be23:7ad5 with SMTP id i17-20020a1709064fd100b006f3be237ad5mr30079255ejw.264.1653497283917;
        Wed, 25 May 2022 09:48:03 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id kz12-20020a17090777cc00b006fee13caaeasm3379942ejc.190.2022.05.25.09.48.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 09:48:02 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id e2so19316853wrc.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 09:48:02 -0700 (PDT)
X-Received: by 2002:a5d:58c2:0:b0:210:1f7:bfa0 with SMTP id
 o2-20020a5d58c2000000b0021001f7bfa0mr2533912wrf.281.1653497282053; Wed, 25
 May 2022 09:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220525144013.6481-1-ubizjak@gmail.com> <20220525144013.6481-2-ubizjak@gmail.com>
In-Reply-To: <20220525144013.6481-2-ubizjak@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 25 May 2022 09:47:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh1XeaxWXG5QziGA4ds918UnW1hO924kusgVB-wGj+9Og@mail.gmail.com>
Message-ID: <CAHk-=wh1XeaxWXG5QziGA4ds918UnW1hO924kusgVB-wGj+9Og@mail.gmail.com>
Subject: Re: [PATCH 1/2] locking/lockref: Use try_cmpxchg64 in CMPXCHG_LOOP macro
To:     Uros Bizjak <ubizjak@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Waiman.Long@hp.com,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 7:40 AM Uros Bizjak <ubizjak@gmail.com> wrote:
>
> Use try_cmpxchg64 instead of cmpxchg64 in CMPXCHG_LOOP macro.
> x86 CMPXCHG instruction returns success in ZF flag, so this
> change saves a compare after cmpxchg (and related move instruction
> in front of cmpxchg). The main loop of lockref_get improves from:

Ack on this one regardless of the 32-bit x86 question.

HOWEVER.

I'd like other architectures to pipe up too, because I think right now
x86 is the only one that implements that "arch_try_cmpxchg()" family
of operations natively, and I think the generic fallback for when it
is missing might be kind of nasty.

Maybe it ends up generating ok code, but it's also possible that it
just didn't matter when it was only used in one place in the
scheduler.

The lockref_get() case can be quite hot under some loads, it would be
sad if this made other architectures worse.

Anyway, maybe that try_cmpxchg() fallback is fine, and works out well
on architectures that use load-locked / store-conditional as-is.

But just to verify, I'm adding arm/powerpc/s390/mips people to the cc. See

    https://lore.kernel.org/all/20220525144013.6481-2-ubizjak@gmail.com/

for the original email and the x86-64 code example.

                   Linus
