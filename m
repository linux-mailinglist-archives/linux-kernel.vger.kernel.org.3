Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4EA568097
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 09:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiGFH4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 03:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiGFH4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 03:56:31 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CE3BC9E;
        Wed,  6 Jul 2022 00:56:30 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id k20so10502239qkj.1;
        Wed, 06 Jul 2022 00:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nFnExDmVG8iUyhRWe8k5w8cOxRLhlolbcIWrBxu+DeM=;
        b=KN3V6kqJKP2UMm7lQMcZQ/+mqOmA7MxnFAAZuv1d3KNR2ef6BdVCBXzERn9Cg6IG0O
         iXZVTjHl0YLyIohzIcmClmVVBQIEAZLBmcEcCkNIp47MIDS9ets1FhiiPFqty6Fp333s
         O4RCr3aKgZtey2Scfb2ymZaTob927bsLP3Dkfn70dj7MLDIo3897IWBYgKwjrRefIMwX
         KSc4G23L6AdX1t0FF+157ABgJNxpvs8GzaCvLw5OOnVrOg/5etiZyp/xmluuNNtUNA1v
         WnFfd5i/Z5wrlf4GnMzED4T0OnQb3sQFXDPzwpK2q539soh/bLeGZqCJmZ6f3X2e+mZT
         BIZQ==
X-Gm-Message-State: AJIora8ZGko2K0eVye/BBxFiuDSQHJfjSz0TaR3p7VzE/tgIlpCCMpac
        iFenS/X/M8JFCZHIAlJUqG2UE4hnp+fb9w==
X-Google-Smtp-Source: AGRyM1tsmRxfo5BxvAG8cJRBJNXZVTFdS1KVS6l6lcFic8Ha3vr8i9VA71BY4BdAGuS+na0/R18sXQ==
X-Received: by 2002:a05:620a:2296:b0:6af:46d:1671 with SMTP id o22-20020a05620a229600b006af046d1671mr26200088qkh.417.1657094189544;
        Wed, 06 Jul 2022 00:56:29 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id l21-20020a37f915000000b006b470422c78sm5849140qkj.121.2022.07.06.00.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 00:56:28 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id o2so20747130yba.7;
        Wed, 06 Jul 2022 00:56:28 -0700 (PDT)
X-Received: by 2002:a05:6902:a:b0:65c:b38e:6d9f with SMTP id
 l10-20020a056902000a00b0065cb38e6d9fmr44011964ybh.36.1657094187854; Wed, 06
 Jul 2022 00:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220705210143.315151-1-emil.renner.berthing@canonical.com> <20220705210143.315151-5-emil.renner.berthing@canonical.com>
In-Reply-To: <20220705210143.315151-5-emil.renner.berthing@canonical.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 Jul 2022 09:56:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV0VJh8Um2zM=kDTPPeLPci1OxU75mqkJgFSwhBZ1NR8w@mail.gmail.com>
Message-ID: <CAMuHMdV0VJh8Um2zM=kDTPPeLPci1OxU75mqkJgFSwhBZ1NR8w@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] riscv: dts: sifive unmatched: Add PWM controlled LEDs
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

Hi Emil,

On Tue, Jul 5, 2022 at 11:01 PM Emil Renner Berthing
<emil.renner.berthing@canonical.com> wrote:
> This adds the two PWM controlled LEDs to the HiFive Unmatched device
> tree. D12 is just a regular green diode, but D2 is an RGB diode with 3
> PWM inputs controlling the three different colours.
>
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

Thanks for your patch!

> --- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> +++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> @@ -44,6 +46,46 @@ gpio-poweroff {
>                 compatible = "gpio-poweroff";
>                 gpios = <&gpio 2 GPIO_ACTIVE_LOW>;
>         };
> +
> +       led-controller-1 {
> +               compatible = "pwm-leds";
> +
> +               led-d12 {
> +                       pwms = <&pwm0 0 7812500 PWM_POLARITY_INVERTED>;
> +                       active-low;

The first thing that came into my mind was "why not drop the
PWM_POLARITY_INVERTED flag instead?".

But it turns out drivers/pwm/pwm-sifive.c does not support
non-inverted PWMs, and returns -EINVAL if PWM_POLARITY_INVERSED
(no typo) is not set.  I think it would be good if
Documentation/devicetree/bindings/pwm/pwm-sifive.yaml would mention
this limitation, and perhaps even enforce it, if possible?

I didn't check this against the schematics, but the generic structure
LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
