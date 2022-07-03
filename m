Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7FD5649D7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 23:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiGCVBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 17:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiGCVBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 17:01:35 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91BF2BDE
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 14:01:33 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id pk21so13552757ejb.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 14:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fJNo+NTuQMKsop/8OveZPXGLX/hReyDdby5JCQhd09k=;
        b=LnfhrRGdEz+Izhbd4CUgGU43RFh0jE7m1HvgTxIa4gl9+bKuFg+kFye/P8COOIgrzz
         h2hGg0mtRHWWfvMn2DoA6Pb0rIxAYAFDU/xY2Tv51U4hdSujgT3rhh4KL5u1TwRZOTQ5
         DdSFtoIwaGvZ7cwIP8WSseFftyQYbcQTjVgpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fJNo+NTuQMKsop/8OveZPXGLX/hReyDdby5JCQhd09k=;
        b=oVDP++YyAaHRxTW2/B3Qa1UmFzaaQjxDYEaXEh5GYDGN61Ohqs0w//shSMYUp9uKCv
         3B0o7jscrsov2if9oXzMCe+XI/i5feR3vvoYh35Gjn0WHDLdfTrdK1lgdJVOkPVAWpc+
         8Tx9TFpQfh3bzyAoOin98lLJfaTR+FHgjVMbkrS2j3T0JX4tulEK2PZm8HNvtsu1K6V0
         p9EEB4YVeIwkyUGlM6wGbSUV8tkrCanuSJEqkbfqh8yQ8cvI+kfNsEtdOfUA5m26QP+L
         QO8d3kAINDcboBo4gHUaAQoJG1qWRzxM57u7R7HTsxWgkfBiJChel39AVDhOkwEzCMzz
         ovXw==
X-Gm-Message-State: AJIora8Kx9/+0K6mJIirjfNSjWAzZoDL2U36QgXLkfpcAFRTVwtf5oCT
        t6Ps3Xhil+X/9Yyot9weGbO2jtCu7AHnH/AV
X-Google-Smtp-Source: AGRyM1vahXKd4hKAyzq8WQfLZ17993CswH3HQMFJs0mbwFHaun4Ue2zyEiolfsz3w6p7iTq1Qf4N7w==
X-Received: by 2002:a17:906:cc47:b0:72a:95bf:2749 with SMTP id mm7-20020a170906cc4700b0072a95bf2749mr11552756ejb.204.1656882091939;
        Sun, 03 Jul 2022 14:01:31 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id a27-20020a170906275b00b00722e57fa051sm13370031ejd.90.2022.07.03.14.01.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jul 2022 14:01:30 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id b26so10789667wrc.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 14:01:30 -0700 (PDT)
X-Received: by 2002:a05:6000:1f8d:b0:21b:aaec:ebae with SMTP id
 bw13-20020a0560001f8d00b0021baaecebaemr24491236wrb.274.1656882089683; Sun, 03
 Jul 2022 14:01:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220626201712.18064-1-ubizjak@gmail.com>
In-Reply-To: <20220626201712.18064-1-ubizjak@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 3 Jul 2022 14:01:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiayOnntaOaQtjm4JXNoXjQdkyT3euMKNfn4ozHRk-oqg@mail.gmail.com>
Message-ID: <CAHk-=wiayOnntaOaQtjm4JXNoXjQdkyT3euMKNfn4ozHRk-oqg@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] locking/lockref/x86: Enable ARCH_USE_CMPXCHG_LOCKREF
 for X86_CMPXCHG64
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
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

On Sun, Jun 26, 2022 at 1:18 PM Uros Bizjak <ubizjak@gmail.com> wrote:
>
>    Also, by using try_cmpxchg64() instead of cmpxchg64()
> in CMPXCHG_LOOP macro, the compiler actually produces sane code,
> improving lockref_get_or_lock main loop from:

Heh. I'm actually looking at that function because I committed my "add
sparse annotation for conditional locking" patch, and
lockref_get_or_lock() has the wrong "polarity" for conditional locking
(it returns false when it takes the lock).

But then I started looking closer, and that function has no users any
more. In fact, it hasn't had users since back in 2013.

So while I still think ARCH_USE_CMPXCHG_LOCKREF is fine for 32-bit
x86, the part about improving lockref_get_or_lock() code generation is
kind of pointless. I'm going to remove that function as "unused, and
with the wrong return value".

              Linus
