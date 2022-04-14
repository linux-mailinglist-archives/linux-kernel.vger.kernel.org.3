Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A11C501CDC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 22:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345799AbiDNUoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 16:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbiDNUoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 16:44:08 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911E83C4AE;
        Thu, 14 Apr 2022 13:41:41 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id q129so6665555oif.4;
        Thu, 14 Apr 2022 13:41:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kQ16bevC74v8j9hP5RJfq+tF3CIcALFbt9dd1uaIG9E=;
        b=YXgvlrNFGYGLG+dW08HZ+Cs2iibvqp3tWcN5b5UrqhC6YCANqXNPVVtnfIbsuhryy9
         HxqZ9XkM8ITFRB0DvKuYGq4yITN9Jka54M+33mqkEssU2E/w7Hew1MQhvpbuDGTWTf1V
         wprph6WfZkMm5MmxT3zHCjdPppr3aWKuWMbEeQ8GeQKHZZA3E5QCS8zMU1A30ImMagp1
         UCZKrthXLAkly5dVR/crW6JNAQEuOR3IvV6BFjPiKsvepgbv9CS5iH22u3q3C0SbwBhn
         PU7hkelie7a2NkvQrxdojbhr5JGz/QrSgPKHxAsayag+BWxOpiaqExouGSWbNtA7kqEl
         XY5g==
X-Gm-Message-State: AOAM532vIQBPoSs6L+u8tjZwW8RIyTefqMvXwI1VJKwu1yOcP21Hmt1f
        IwPiMD3hKaSCLgLCLTm3ng==
X-Google-Smtp-Source: ABdhPJwC/Cf4MTxpznrthxydqEHpaVveVGXAK2ei0no2VM/vDG7BZn3PRSgiAWYQ1YAehWtlLvX6JQ==
X-Received: by 2002:a05:6808:1a1c:b0:2fa:6c17:5c07 with SMTP id bk28-20020a0568081a1c00b002fa6c175c07mr210417oib.80.1649968900860;
        Thu, 14 Apr 2022 13:41:40 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id lw19-20020a0568708e1300b000e2f7602666sm1038088oab.15.2022.04.14.13.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 13:41:40 -0700 (PDT)
Received: (nullmailer pid 2666253 invoked by uid 1000);
        Thu, 14 Apr 2022 20:41:38 -0000
Date:   Thu, 14 Apr 2022 15:41:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, "Theodore Ts'o" <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-um@lists.infradead.org, X86 ML <x86@kernel.org>,
        linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH v4 01/11] timekeeping: add raw clock fallback for
 random_get_entropy()
Message-ID: <YliHAl0XpQ57FSGy@robh.at.kernel.org>
References: <20220413115411.21489-1-Jason@zx2c4.com>
 <20220413115411.21489-2-Jason@zx2c4.com>
 <CAL_JsqJYq5Oe_zBbcwYNMpfpqGLGCyaSfGqOrPjZ_Pj=nF73mA@mail.gmail.com>
 <CAHmME9pn++c0qHzq39YWyXogcKRbn2XK=yA3kFqch0wH7qPcAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9pn++c0qHzq39YWyXogcKRbn2XK=yA3kFqch0wH7qPcAg@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 12:38:49AM +0200, Jason A. Donenfeld wrote:
> Hi Rob,
> 
> On Wed, Apr 13, 2022 at 4:32 PM Rob Herring <robh@kernel.org> wrote:
> > 'does not have a usable get_cycles(), ...' as clearly some arches have
> > get_cycles() and yet still need a fallback.
> >
> > Why not handle the 'if get_cycles() returns 0 do the fallback' within
> > a weak random_get_entropy() function? Then more arches don't need any
> > random_get_entropy() implementation.
> 
> No, this doesn't really work. Actually, most archs don't need a
> random_get_entropy() function, because it exists in asm-generic doing
> the thing we want. So that's taken care of. But weak functions as you
> suggested would be quite suboptimal, because on, e.g. x86, what we
> have now gets inlined into a single rdtsc instruction. Also, the
> relation between get_cycles() and random_get_entropy() doesn't always
> hold; some archs may not have a working get_cycles() function but do
> have a path for a random_get_entropy(). Etc, etc. So I'm pretty sure
> that this commit is really the most simple and optimal thing to do. I
> really don't want to go the weak functions route.

Is random_get_entropy() a hot path?


It doesn't have to be a weak function, but look at it this way. We have 
the following possibilities for what random_get_entropy() does:

- get_cycles()
- get_cycles() but returns 0 sometimes
- returns 0
- something else

You're handling the 3rd case.

For the 2nd case, that's riscv, arm, nios2, and x86. That's not a lot, 
but is 2 or 3 of the most widely used architectures. Is it really too 
much to ask to support the 2nd case in the generic code/header?

Rob
