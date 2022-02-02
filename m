Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1A74A72F6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344920AbiBBO0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:26:10 -0500
Received: from mail-ua1-f48.google.com ([209.85.222.48]:34362 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344911AbiBBO0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:26:09 -0500
Received: by mail-ua1-f48.google.com with SMTP id 60so2358495uae.1;
        Wed, 02 Feb 2022 06:26:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ad4RQzdAEV72aNypfbZ9YuoMVU2rEDrZVxH/YYvAS6A=;
        b=g71/dD0O8hBruqovRkLort0hM0ha3llLh+cLAWR9x+0kupL3O+XI8TgJCYkeRk6c7z
         4IVsP9Qy51sEBHn2ab7X60wtO/semQLblaJrBvMLdXdIk6r/USrOJW2a4J+JiEHCBAV/
         ZWQ/eXWRtOC6en4bhF8X0hwnTS0LIhrdQmjfuSn4AhxtfYqBP39J96d15ak0cmfvEvOC
         6hFgcdrp+IxIR9bf6x/MtrM9thai4RMYrdvGnQWHIiZawnzz/HiQYOSRHwBY8XvWLfmr
         NytJ+p3zfgH3n/aON/71FM4/2oZfk5ArA9L22GesK0JMKA7hrEx+jHuUl/oXMpfURYkB
         QCfg==
X-Gm-Message-State: AOAM53324vgjE/awuHD56OPlL7kN6lEEUyLEacyPaIT57UJcW2jkShuh
        SjiMrKpz/8TLVLaqiIHTN+Sqzt/zR18BAw==
X-Google-Smtp-Source: ABdhPJzJDpjiJ/6shkqTMIhUMV2bIdPp4gRB/VIr9HGFRfzQE0nlzCmMk5uT2KzO1mB8+iDcurU+eQ==
X-Received: by 2002:a67:fe88:: with SMTP id b8mr7811829vsr.16.1643811968197;
        Wed, 02 Feb 2022 06:26:08 -0800 (PST)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id l67sm2319312vkh.9.2022.02.02.06.26.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 06:26:07 -0800 (PST)
Received: by mail-ua1-f42.google.com with SMTP id a24so5712403uat.10;
        Wed, 02 Feb 2022 06:26:06 -0800 (PST)
X-Received: by 2002:a67:fd63:: with SMTP id h3mr10854285vsa.77.1643811966714;
 Wed, 02 Feb 2022 06:26:06 -0800 (PST)
MIME-Version: 1.0
References: <20220201120310.878267-1-maz@kernel.org> <20220201120310.878267-3-maz@kernel.org>
In-Reply-To: <20220201120310.878267-3-maz@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 2 Feb 2022 15:25:55 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX7RqQPw=H2AzMPaCJDy_pFqhM30hpNN-G4-_HP2tx_WA@mail.gmail.com>
Message-ID: <CAMuHMdX7RqQPw=H2AzMPaCJDy_pFqhM30hpNN-G4-_HP2tx_WA@mail.gmail.com>
Subject: Re: [PATCH 02/12] irqchip/gic: Move PM device over to irq domain
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
> Move the reference to the GIC device over to the irq domain.
> This allows for some localised cleanup.
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
