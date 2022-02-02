Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FCD4A7314
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344957AbiBBO2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:28:46 -0500
Received: from mail-ua1-f54.google.com ([209.85.222.54]:39776 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239109AbiBBO2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:28:44 -0500
Received: by mail-ua1-f54.google.com with SMTP id p7so19435701uao.6;
        Wed, 02 Feb 2022 06:28:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DQbN/IG7k7oQjSkAnXdbQ+TtLAJYx9/TKrsGBZwRqyY=;
        b=DCNMFarRsSvnFzKpYbXc9DZw312hrM29QC6lb8KmHEFRltcO460WPtBncNCilee2tF
         FYWVLaEugfufQ21QvFpH99Xk+XdBlAv9+7OnAcUtIzZqLWv5JnLyYi3GlZQd2rwIrZBG
         0enOcORASSrAbQFtjCJwk/Ml/ceCbnuR0WQSF5lzqkx2fN0YfG23bD1WOsKHlQAhDCh8
         MvYEEPMdEGmvc9QFaep0WgC9coUfrOZ1IxwPEN0ou7WX8tneZ3Pt0qH4DgjPpR6eAPux
         DIHy8YEo4jOAlQVpW2terS+aQpskFqWND5w+GjQuUs3GE6Q5wWWz2AKtEnM0X6pdwuir
         RVCQ==
X-Gm-Message-State: AOAM530N15m0/4wHWbJHj0sOW168kBYR/fEqrZsDVY/Gdl9Hb8ap7bQM
        pr8AD2v/0l5Zju+KZ/SXtp4iZ2LEiIL0Zg==
X-Google-Smtp-Source: ABdhPJxpmmOITrW4JZ0N2uiuZleO3DWsTPcUVFXQhM0Q9ILvsflNW5ngoxahxwflKqc9dnGQuJEwLg==
X-Received: by 2002:a67:cb19:: with SMTP id b25mr12059436vsl.8.1643812123175;
        Wed, 02 Feb 2022 06:28:43 -0800 (PST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id q69sm5678301vka.21.2022.02.02.06.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 06:28:42 -0800 (PST)
Received: by mail-ua1-f49.google.com with SMTP id 60so2373130uae.1;
        Wed, 02 Feb 2022 06:28:42 -0800 (PST)
X-Received: by 2002:a67:b00e:: with SMTP id z14mr11549301vse.57.1643812121840;
 Wed, 02 Feb 2022 06:28:41 -0800 (PST)
MIME-Version: 1.0
References: <20220201120310.878267-1-maz@kernel.org> <20220201120310.878267-5-maz@kernel.org>
In-Reply-To: <20220201120310.878267-5-maz@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 2 Feb 2022 15:28:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV91fXfTTK=Jchr-wmatY3kJjke=UkSRCBs42kq5GL43w@mail.gmail.com>
Message-ID: <CAMuHMdV91fXfTTK=Jchr-wmatY3kJjke=UkSRCBs42kq5GL43w@mail.gmail.com>
Subject: Re: [PATCH 04/12] irqchip/renesas-irqc: Move PM device over to irq domain
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
> Move the reference to the device over to the irq domain.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Wake-up still works fine on R-Mobile APE6 and R-Car M2-W, so
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
