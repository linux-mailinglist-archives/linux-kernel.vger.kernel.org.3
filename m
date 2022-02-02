Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A195D4A72F0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344900AbiBBOZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:25:22 -0500
Received: from mail-vk1-f176.google.com ([209.85.221.176]:33708 "EHLO
        mail-vk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbiBBOZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:25:21 -0500
Received: by mail-vk1-f176.google.com with SMTP id 48so12753378vki.0;
        Wed, 02 Feb 2022 06:25:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VHHkDQZTsE2xhNxSVITPsL9fvc1DhHDBALiEGJ5aodc=;
        b=semfALvjA5GelZ7GgX4ueW4+fjdFs49V2c2sQE+yiYnhwSqyqZRrHx3eJRrFmEAswq
         PIslQzeUVW+RFQt2fxXisIxRsKPhogZsfsLN6IgrpXGbrkByuM2W25ME6BtaUo9vjhNZ
         QHumiSG5nQ6mzRl7rmLxKv497QkG+OzvWLqjZTSWKywfGW+r6zmL2o2atSEljBf+5pjz
         X0CnhwH05B6rkqZPTPFOpi6vj8kBhf4+q1sutJDKIfhm11NEBUcn8Y3NgTJ8ChhLfYSY
         /ppPKU5nJiwR45C2klRMUtk47X81HpO50mt9RW0XfWcFKccLI+G1Y5OKSN4+A//NEb+n
         l7LA==
X-Gm-Message-State: AOAM530ayXCmQxE9+H4929M1Cj7EVQ/Q5x0CMrtnEmdro4JWXHxb5KKL
        xzwIjcWpi3Gw5Rjo3flpyDrddxousNSsKw==
X-Google-Smtp-Source: ABdhPJx+IvKa+vH9VcvpP1lKOMLgPOrwNCFX20Bn+E1XI21/kEfhfkWP5RJf3zzm5fI2mOmJGB8RxA==
X-Received: by 2002:a1f:90d4:: with SMTP id s203mr13066144vkd.20.1643811920637;
        Wed, 02 Feb 2022 06:25:20 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id f68sm5626210vke.55.2022.02.02.06.25.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 06:25:20 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id 60so2353810uae.1;
        Wed, 02 Feb 2022 06:25:20 -0800 (PST)
X-Received: by 2002:ab0:6cf9:: with SMTP id l25mr12222950uai.122.1643811919950;
 Wed, 02 Feb 2022 06:25:19 -0800 (PST)
MIME-Version: 1.0
References: <20220201120310.878267-1-maz@kernel.org> <20220201120310.878267-2-maz@kernel.org>
In-Reply-To: <20220201120310.878267-2-maz@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 2 Feb 2022 15:25:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWaS9YnEELFhW4fdVj_Uo1D0R9sCWKnVDrPnLWN16NB1g@mail.gmail.com>
Message-ID: <CAMuHMdWaS9YnEELFhW4fdVj_Uo1D0R9sCWKnVDrPnLWN16NB1g@mail.gmail.com>
Subject: Re: [PATCH 01/12] genirq: Allow the PM device to originate from irq domain
To:     Marc Zyngier <maz@kernel.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:TI ETHERNET SWITCH DRIVER (CPSW)" 
        <linux-omap@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 1:15 PM Marc Zyngier <maz@kernel.org> wrote:
> As a preparation to moving the reference to the device used for
> runtime power management, add a new 'dev' field to the irqdomain
> structure for that exact purpose.
>
> The irq_chip_pm_{get,put}() helpers are made aware of the dual
> location via a new private helper.
>
> No functional change intended.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
