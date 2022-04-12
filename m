Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AE24FEB31
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiDLXWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiDLXV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:21:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0822BB644A;
        Tue, 12 Apr 2022 15:52:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A70C661CBA;
        Tue, 12 Apr 2022 21:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84EE1C385AE;
        Tue, 12 Apr 2022 21:17:25 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Y38jE8bb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1649798238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7RYqiP9nhX0rKf7m7FCUHmIMWi5HqXJa2wb5GRUCRN4=;
        b=Y38jE8bbwXnFadm3bSadxYJs0QKXhDjO8XeYq55V9FobkrYVUHtCltO8FbQ6ymeqNiU6sv
        4YirHaGCd68zWGnn9f3QSQlI+ccFB49iW2Qf2Va1404DwU3ctZ6ljDbPgEVcbkaDMLm42a
        UyuzHmfK7dQiDEDzUbSQKNSvKXXGO+I=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b1bb241b (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 12 Apr 2022 21:17:18 +0000 (UTC)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-2ec04a2ebadso1618747b3.12;
        Tue, 12 Apr 2022 14:17:18 -0700 (PDT)
X-Gm-Message-State: AOAM532drnYdp8Qvg9jDGBZC15qEdJXZSoHu6LHauDX4pOllbvZ+bpk1
        yWqCcA3drBNybhsyLR1K7+3ktG1a7E0lwNIiAGo=
X-Google-Smtp-Source: ABdhPJyzoWPsFnF8ik/yAzlm3KPNzdj5Txo6RqIWYvjdGUg1ERYyQK8PArA04S/85l5pbLiU/ZXjCNxyEog+/ToSU0U=
X-Received: by 2002:a81:4a55:0:b0:2ef:3ef1:def7 with SMTP id
 x82-20020a814a55000000b002ef3ef1def7mr1543639ywa.2.1649798234768; Tue, 12 Apr
 2022 14:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220412172754.149498-1-Jason@zx2c4.com> <20220412172754.149498-2-Jason@zx2c4.com>
 <87bkx6f29b.ffs@tglx>
In-Reply-To: <87bkx6f29b.ffs@tglx>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 12 Apr 2022 23:17:03 +0200
X-Gmail-Original-Message-ID: <CAHmME9pVhO24V8V3YdeHfz6q1nmSgqXocUtn=+zu5Wh-OWrSRA@mail.gmail.com>
Message-ID: <CAHmME9pVhO24V8V3YdeHfz6q1nmSgqXocUtn=+zu5Wh-OWrSRA@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] timekeeping: add raw clock fallback for random_get_entropy()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
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
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        X86 ML <x86@kernel.org>, linux-xtensa@linux-xtensa.org
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

Hi Thomas,

On Tue, Apr 12, 2022 at 10:57 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Tue, Apr 12 2022 at 19:27, Jason A. Donenfeld wrote:
> > +/**
> > + * random_get_entropy_fallback - Returns the raw clock source value,
> > + * used by random.c for platforms with no valid random_get_entropy().
> > + */
> > +unsigned long random_get_entropy_fallback(void)
> > +{
> > +     return tk_clock_read(&tk_core.timekeeper.tkr_mono);
> > +}
> > +EXPORT_SYMBOL(random_get_entropy_fallback);
>
> EXPORT_SYMBOL_GPL() please.

Okay, will do.

Jason
