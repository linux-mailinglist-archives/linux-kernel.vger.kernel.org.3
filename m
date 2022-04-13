Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5A15001F7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 00:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238028AbiDMWlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 18:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbiDMWlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 18:41:37 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9524D9C5;
        Wed, 13 Apr 2022 15:39:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2249DCE2160;
        Wed, 13 Apr 2022 22:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50A6C385A6;
        Wed, 13 Apr 2022 22:39:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="isnRa13t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1649889544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EXr0AZpcPcnbl6qsjtJM2/w/Togs9os9zG2LD36s86Y=;
        b=isnRa13tM55srvQFRbdzJYxWhWdGBxoBVCyxIFjzIKXcqZMIJ6P5g/6LcizEJPjV7ryoTh
        1qG+oJD4oZfH2HQwojHAnazg5/nctW757IuCgqZGxS2z6KX/ud9UCOq/GkRrsm4fw+pcx1
        Pau+x3kFX80Lryo47bysRfjq9L4k7W8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6322a305 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 13 Apr 2022 22:39:04 +0000 (UTC)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-2ec04a2ebadso37821757b3.12;
        Wed, 13 Apr 2022 15:39:02 -0700 (PDT)
X-Gm-Message-State: AOAM5325pUky3/4Unbr1Sbom+ukXm53SBUfYMcJ7WeSJazu0LmDwwBjr
        5yx3jkPXLWv+KAwm9ynKbDuD+ie2qFnLsy0/rrg=
X-Google-Smtp-Source: ABdhPJxXSf7GaLqdLU3LGxvJFMW4JvQbew20C3o4QQN4FpKqfaroqjsmiNxIHcc1vWzN4Jl4A9L3Loy9Cv7VCY2OIqY=
X-Received: by 2002:a81:6a84:0:b0:2ec:c59:9d22 with SMTP id
 f126-20020a816a84000000b002ec0c599d22mr1034376ywc.499.1649889540445; Wed, 13
 Apr 2022 15:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220413115411.21489-1-Jason@zx2c4.com> <20220413115411.21489-2-Jason@zx2c4.com>
 <CAL_JsqJYq5Oe_zBbcwYNMpfpqGLGCyaSfGqOrPjZ_Pj=nF73mA@mail.gmail.com>
In-Reply-To: <CAL_JsqJYq5Oe_zBbcwYNMpfpqGLGCyaSfGqOrPjZ_Pj=nF73mA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 14 Apr 2022 00:38:49 +0200
X-Gmail-Original-Message-ID: <CAHmME9pn++c0qHzq39YWyXogcKRbn2XK=yA3kFqch0wH7qPcAg@mail.gmail.com>
Message-ID: <CAHmME9pn++c0qHzq39YWyXogcKRbn2XK=yA3kFqch0wH7qPcAg@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] timekeeping: add raw clock fallback for random_get_entropy()
To:     Rob Herring <robh@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wed, Apr 13, 2022 at 4:32 PM Rob Herring <robh@kernel.org> wrote:
> 'does not have a usable get_cycles(), ...' as clearly some arches have
> get_cycles() and yet still need a fallback.
>
> Why not handle the 'if get_cycles() returns 0 do the fallback' within
> a weak random_get_entropy() function? Then more arches don't need any
> random_get_entropy() implementation.

No, this doesn't really work. Actually, most archs don't need a
random_get_entropy() function, because it exists in asm-generic doing
the thing we want. So that's taken care of. But weak functions as you
suggested would be quite suboptimal, because on, e.g. x86, what we
have now gets inlined into a single rdtsc instruction. Also, the
relation between get_cycles() and random_get_entropy() doesn't always
hold; some archs may not have a working get_cycles() function but do
have a path for a random_get_entropy(). Etc, etc. So I'm pretty sure
that this commit is really the most simple and optimal thing to do. I
really don't want to go the weak functions route.

Jason
