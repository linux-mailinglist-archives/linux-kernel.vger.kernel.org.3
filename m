Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B434A7320
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240424AbiBBO3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:29:14 -0500
Received: from mail-ua1-f44.google.com ([209.85.222.44]:47098 "EHLO
        mail-ua1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbiBBO3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:29:12 -0500
Received: by mail-ua1-f44.google.com with SMTP id c36so19367584uae.13;
        Wed, 02 Feb 2022 06:29:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZRyCOx+Er0yiaBLPHzoN2OzH4NMZ0OLZ67W+SG58hjg=;
        b=DRUFJoux3xyokkrD/EswQEodo8Md3ImhN7hZvY8XOX2XJ6b0LeT7lgpmI1ejgCNCNn
         epz2gm97VwlkgGA226llhql820/y68ufFtMMfGtfHy26LesYOIZbyXxRQQDYB9Cu+Vtk
         WSJ+QVAfylxdT2BMXpoWvMO8IKDAUBRg0J4MC0SmZA0nhloBWmhEIBGZIqU/kVRULaqE
         EYmNTx4lS3wHVPLPwPKSwKOFk+X0YuC/nIDVH56HYCOdlu9TsdyOgnQxL7VHRgtHe6xk
         c82R9ED/4zThWX1XBeN4R0DNknrZTOYrXppwd6fBKTHLueBDVBOet5XiuINe9GyjfemU
         N7DA==
X-Gm-Message-State: AOAM530EigAAoL8vaMMcWP+sOUjW7jwxmUZiTj1phan/0AX6HezXKfCI
        HjJ0SVg70yzckLh44n1o7WQ3m5Z6vZcB0Q==
X-Google-Smtp-Source: ABdhPJzip04UbGxKp9OpIFLIunRV7lYMuDGHhHIM0NZ/CrKLjIdiIOnKECXAfZoN+0cA8osgTDSQXw==
X-Received: by 2002:a67:f70f:: with SMTP id m15mr11760366vso.61.1643812151300;
        Wed, 02 Feb 2022 06:29:11 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id c7sm5663197vkn.23.2022.02.02.06.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 06:29:10 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id 60so2375698uae.1;
        Wed, 02 Feb 2022 06:29:10 -0800 (PST)
X-Received: by 2002:a67:a401:: with SMTP id n1mr11148475vse.38.1643812150361;
 Wed, 02 Feb 2022 06:29:10 -0800 (PST)
MIME-Version: 1.0
References: <20220201120310.878267-1-maz@kernel.org> <20220201120310.878267-9-maz@kernel.org>
In-Reply-To: <20220201120310.878267-9-maz@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 2 Feb 2022 15:28:59 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWy+kYMNv+xLT6ybqnMKvaMchBXwXV-NSFNKDAfgPnLhQ@mail.gmail.com>
Message-ID: <CAMuHMdWy+kYMNv+xLT6ybqnMKvaMchBXwXV-NSFNKDAfgPnLhQ@mail.gmail.com>
Subject: Re: [PATCH 08/12] gpio: rcar: Move PM device over to irq domain
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

On Tue, Feb 1, 2022 at 1:16 PM Marc Zyngier <maz@kernel.org> wrote:
> Move the reference to the device over to the irq domain.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Wake-up still works fine on R-Car M2-W, so
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
