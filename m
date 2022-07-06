Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47ED2567FDD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 09:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiGFHat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 03:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiGFHar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 03:30:47 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F4F22B08;
        Wed,  6 Jul 2022 00:30:46 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id ck6so17090448qtb.7;
        Wed, 06 Jul 2022 00:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l7jdNwqUxVmvsNaO4xkKTr+IxISvnOUVGzWu8CWMy8I=;
        b=NpA85b0lUlGtmA2c7o6s1IDA1zJ/BdNO4PNqEUf03xhjacbEewcTaadStrmxhvgb0g
         fhR+eT5Vs+CQA5KAqL0OFyGNlB7N2E3J63c4SsHfdrw9VO2SAXW1o1e6+75rUvcU7d8V
         K89LfkKH5qEThT/qoY6wQIn6db60yUUGPQuoywc4ATIe0GObc+Xks8bJ8BhlAa2w/rMi
         tauQmyHUnmcHt4tSl8qYP48lAOr8AZsLOktpdSOmsAW6mZsak/me8VGKIpgLUYOKP391
         EpEhYuA9fl3oCtQwzMD1F+iXAJ/cww94jjg5+AblJv9XDcKYYt0mfYzbW4Bf7xIXRZET
         jFZQ==
X-Gm-Message-State: AJIora/mhKqmdk9YTdkdY4ayHPn9lriFD0MLmXh84QGxAdNPY18WuRSQ
        6BzjsIe0AuQX0mhStyYqsfonwJTA0j2cWQ==
X-Google-Smtp-Source: AGRyM1sualVkhVTr9IE8GyKTkUsyvaESHEGFY+rjVtUptztEZR3aldwXsxCh5rxPWbi88m9V5F5bTQ==
X-Received: by 2002:a05:6214:27ce:b0:470:596b:4e82 with SMTP id ge14-20020a05621427ce00b00470596b4e82mr35691966qvb.118.1657092645093;
        Wed, 06 Jul 2022 00:30:45 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id c19-20020a05622a059300b00304edcfa109sm25649620qtb.33.2022.07.06.00.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 00:30:44 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-31c89653790so80232737b3.13;
        Wed, 06 Jul 2022 00:30:43 -0700 (PDT)
X-Received: by 2002:a81:9209:0:b0:31c:b1b7:b063 with SMTP id
 j9-20020a819209000000b0031cb1b7b063mr12871303ywg.383.1657092643442; Wed, 06
 Jul 2022 00:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220705210143.315151-1-emil.renner.berthing@canonical.com> <20220705210143.315151-2-emil.renner.berthing@canonical.com>
In-Reply-To: <20220705210143.315151-2-emil.renner.berthing@canonical.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 Jul 2022 09:30:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU3q4W+azwo5sAUHfsL7Se9vGftHxRdmu1c5-j5fPrwow@mail.gmail.com>
Message-ID: <CAMuHMdU3q4W+azwo5sAUHfsL7Se9vGftHxRdmu1c5-j5fPrwow@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] leds: pwm-multicolor: Don't show -EPROBE_DEFER as errors
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 5, 2022 at 11:01 PM Emil Renner Berthing
<emil.renner.berthing@canonical.com> wrote:
> When requesting a PWM it might return -EPROBE_DEFER if it hasn't probed
> yet. This is not an error, so just propagate the -EPROBE_DEFER without
> logging anything. There is already dev_err_probe for exactly this
> situation.
>
> Fixes: 9fa2762110dd ("leds: Add PWM multicolor driver")
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
