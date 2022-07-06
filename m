Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC505568064
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 09:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiGFHno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 03:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiGFHn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 03:43:29 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD1B22BE1;
        Wed,  6 Jul 2022 00:43:28 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id o26so3362911qkl.6;
        Wed, 06 Jul 2022 00:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kjnCdbt6inqH5uX2FYdrJz59MYQX17h31Der8YuPd8E=;
        b=WMYG/kOWoAlZyRMbEILO7QNILBaSnADuRgWs2gaOwGqJ972RlKP67uA+3JFOGKq14k
         fKjbvMZUuMOc6aH0DNbwgI4hE4kzor9PcSLNef4WV8GuwQqIXavIfKyMGDNR0mMeqJWz
         AHhDZ/ALTae3xqJtWimZgCSvoJnoKSGScFy7K69I26IDNoHS0Qty393wd1AOiMRoYyIj
         +O9X916bWQhFnb+eLL5uejTRy+AT33Lsocvy+BY2PcdpQUV9orpMsm6QGQDXTO+LbheC
         iWEdLXe0v/lYZqzg92mv/pmHfkgFLWtvnu+fUFhAvCmwMkCGHMn4DQegIfUZYB3ferNe
         n95w==
X-Gm-Message-State: AJIora8UxxKebHj5Fyy4xXEI3EOgaakRz1lN8XEzJ5aJd4bvFFL0i8bY
        wRVqukBoM7WFTy2di1rCAmZclZR8mFMtAg==
X-Google-Smtp-Source: AGRyM1uHPHoOk+wyT+BH/wmqkxdIhsHz5Txnvb42inmI3c1qCLUfdkq0dlSP7E/FE00K3rK3Pryk7g==
X-Received: by 2002:a05:620a:2845:b0:6ab:8e0c:1938 with SMTP id h5-20020a05620a284500b006ab8e0c1938mr25700778qkp.315.1657093407102;
        Wed, 06 Jul 2022 00:43:27 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id bm9-20020a05620a198900b006a73ad95d40sm28610139qkb.55.2022.07.06.00.43.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 00:43:26 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 64so16684183ybt.12;
        Wed, 06 Jul 2022 00:43:26 -0700 (PDT)
X-Received: by 2002:a5b:6c1:0:b0:669:a7c3:4c33 with SMTP id
 r1-20020a5b06c1000000b00669a7c34c33mr41944626ybq.543.1657093406099; Wed, 06
 Jul 2022 00:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220705210143.315151-1-emil.renner.berthing@canonical.com> <20220705210143.315151-4-emil.renner.berthing@canonical.com>
In-Reply-To: <20220705210143.315151-4-emil.renner.berthing@canonical.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 Jul 2022 09:43:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV4QVoN53cqrbmVn3YJVHSdbB78xd120AO0FNz74qeGyA@mail.gmail.com>
Message-ID: <CAMuHMdV4QVoN53cqrbmVn3YJVHSdbB78xd120AO0FNz74qeGyA@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] leds: pwm-multicolor: Support active-low LEDs
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Bin Meng <bin.meng@windriver.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Ron Economos <w6rz@comcast.net>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        Stephen L Arnold <nerdboy@gentoo.org>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Abdurachmanov <davidlt@rivosinc.com>,
        linux-leds <linux-leds@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
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

On Tue, Jul 5, 2022 at 11:01 PM Emil Renner Berthing
<emil.renner.berthing@canonical.com> wrote:
> Add support for LEDs wired up to light when the PWM output is low, just
> like the regular PWM LEDs.
>
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
