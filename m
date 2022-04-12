Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86FC4FE8AF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 21:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358719AbiDLTfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 15:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243498AbiDLTfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 15:35:17 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D654A3D5;
        Tue, 12 Apr 2022 12:32:58 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-deb9295679so21841764fac.6;
        Tue, 12 Apr 2022 12:32:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k0JEyUctm+WKncuIF5YDm3I/aHHGOlYRWAe57/MVe48=;
        b=YGZCGKtGTSzMAXb6bZ2qzaTjlRcNJW96ShcF4wBXtdauJWoIJcw3cx3ZRaTgcKavtI
         Dz5UCMI8wuoalpDX2RfVDAB7tLSpW1VoTl6w+UxDJemB+hD5XKG7rP1eTZrzkJ6v5XgQ
         bgH9BQq8wd9fjZCR3mrbW5rO5tGkUtRTo0I2djeI59s7kaa84hPdVDUMgWuof8EOXjTd
         ffxKgz96qnN4Axfy/G1cnTIJYsrpd3T9yHesv0J0aw5+OL2faHANgKmhXujvNfqiS9g1
         +3UY+sXbyGiQoU+0HDnrgFUeI8kRTqHbYSMtDMoidujbEsocjEdYIzqH/MKWmoaFUj4C
         KswQ==
X-Gm-Message-State: AOAM530y9HNxgUiJwyzveli7QNtwGuoNnL1DR/dwm41k0ueAzkQjp+3g
        cfM8Og/vdVUY2jeZ+gBvaHr1+iA3MTyuDbSU
X-Google-Smtp-Source: ABdhPJzKqpnOQeF5ge0Mlri3CvfaQN7htbpNRbOIl+GvNjpi7xpgJnJ65un1tqGlusbQDbUOW2YM5A==
X-Received: by 2002:a05:6870:eaa9:b0:d6:f977:f757 with SMTP id s41-20020a056870eaa900b000d6f977f757mr2841115oap.18.1649791978050;
        Tue, 12 Apr 2022 12:32:58 -0700 (PDT)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com. [209.85.210.44])
        by smtp.gmail.com with ESMTPSA id s65-20020acac244000000b002ef4ee8c800sm12785918oif.13.2022.04.12.12.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 12:32:57 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id n19-20020a9d7113000000b005cd9cff76c3so14068864otj.1;
        Tue, 12 Apr 2022 12:32:57 -0700 (PDT)
X-Received: by 2002:a81:5210:0:b0:2ef:21e3:54dd with SMTP id
 g16-20020a815210000000b002ef21e354ddmr5208597ywb.438.1649791608129; Tue, 12
 Apr 2022 12:26:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220412172754.149498-1-Jason@zx2c4.com> <20220412172754.149498-3-Jason@zx2c4.com>
In-Reply-To: <20220412172754.149498-3-Jason@zx2c4.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Apr 2022 21:26:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXexfkgfrLcUis3DSWJ=SSC-CargHbMvopsjoWrvNacFg@mail.gmail.com>
Message-ID: <CAMuHMdXexfkgfrLcUis3DSWJ=SSC-CargHbMvopsjoWrvNacFg@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] m68k: use fallback for random_get_entropy()
 instead of zero
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, "Theodore Ts'o" <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 7:29 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> In the event that random_get_entropy() can't access a cycle counter or
> similar, falling back to returning 0 is really not the best we can do.
> Instead, at least calling random_get_entropy_fallback() would be
> preferable, because that always needs to return _something_, even
> falling back to jiffies eventually. It's not as though
> random_get_entropy_fallback() is super high precision or guaranteed to
> be entropic, but basically anything that's not zero all the time is
> better than returning zero all the time.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
