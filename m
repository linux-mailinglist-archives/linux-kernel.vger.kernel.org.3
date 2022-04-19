Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2155079A5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 21:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357482AbiDSTDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 15:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357497AbiDSTDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 15:03:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7113F886;
        Tue, 19 Apr 2022 12:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E31FC615C6;
        Tue, 19 Apr 2022 19:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0300C385A5;
        Tue, 19 Apr 2022 19:00:22 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Xw2ORET4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650394820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N8yac2TcoM0oB2N8o8RD8oOMSu6h8CMOQ/2gSGccCdo=;
        b=Xw2ORET4meDc2i1UG0CWYpbs0iaUWcQnLT3ffJhZo1U8Lsm7pSxAHbESvxu8nlzUyWWdVC
        Echm4IJ8Ex7+0Q42YtIrN7D8W6MW+t1gBXd6FAgUc7yL/6cenmykPrqYtsHFv7WPqZjCz7
        8PrWgelWU+IK+xlb0J2ldbd+F7tgmBA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0d8a6a5d (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 19 Apr 2022 19:00:19 +0000 (UTC)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-2ec0bb4b715so183078087b3.5;
        Tue, 19 Apr 2022 12:00:19 -0700 (PDT)
X-Gm-Message-State: AOAM533fC6iLORr5IZul8Rg7Oj7MJkyhrfIN34Y2fCmuauWp4RI1u91G
        +VDxBGCDqbbVBTJmdV93gFxngkqx22w2qcGUpr8=
X-Google-Smtp-Source: ABdhPJwRc+bdyLezDAgNgTxENBqQkZz9Fe0qv2Ndkg8iOqE2wh+a0hjP/G2ABFOAPTKw6cDikwVfRb4lj/Ti4WdfWac=
X-Received: by 2002:a81:6a84:0:b0:2ec:c59:9d22 with SMTP id
 f126-20020a816a84000000b002ec0c599d22mr17880030ywc.499.1650394817507; Tue, 19
 Apr 2022 12:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220419111650.1582274-1-Jason@zx2c4.com> <20220419111650.1582274-8-Jason@zx2c4.com>
 <Yl78gLLcSb3EHv0B@zn.tnic> <CAHmME9q03Je-ROzzHCgZC0vy1n=y8bsGBOAs8U_K_r3ebLNHbw@mail.gmail.com>
 <Yl8GhNjwPLNiUfSZ@zn.tnic>
In-Reply-To: <Yl8GhNjwPLNiUfSZ@zn.tnic>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 19 Apr 2022 21:00:06 +0200
X-Gmail-Original-Message-ID: <CAHmME9q1wD7EBQPBaR1mBu5ZN+fSpe8yPMWTd7H20+sYEzy8cw@mail.gmail.com>
Message-ID: <CAHmME9q1wD7EBQPBaR1mBu5ZN+fSpe8yPMWTd7H20+sYEzy8cw@mail.gmail.com>
Subject: Re: [PATCH v5 07/11] x86: use fallback for random_get_entropy()
 instead of zero
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
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
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
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

Hi Borislav,

On Tue, Apr 19, 2022 at 8:59 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Apr 19, 2022 at 08:38:41PM +0200, Jason A. Donenfeld wrote:
> > I think I prefer doing (a), and leaving (b) for another time when you
> > or another x86 maintainer can do so. But I'll do whichever you say.
> > Which would you like?
>
> We are switching all feature checks to cpu_feature_enabled() so you
> might as well do the new preferred way of checking when adding a
> new function and so that we have one less place to touch. Which is
> appreciated. :)

Okay, no problem. I'll make the change there and get_cycles() for v+1
of the patchset.

Jason
