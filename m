Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CE34A730C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbiBBO1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:27:55 -0500
Received: from mail-ua1-f45.google.com ([209.85.222.45]:42724 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbiBBO1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:27:53 -0500
Received: by mail-ua1-f45.google.com with SMTP id e17so19406186uad.9;
        Wed, 02 Feb 2022 06:27:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tMuf6Mgi8WTV8TVhhqxvBDCExEnbdcrTWjjU3gY+Vog=;
        b=BFVjDkvgyWEhYCTNyYDec9lwfKEVPeQt0ZfAvN9qMX60TJW/giU5pTMqUNacl0D0JQ
         P/kUQprsydcRCsuYaHflsOE52/0CPu/niMr211xo7vlXygkHRYvsCaX6Xf3M2m6tWpGD
         5y9JiKAznVcJepUTCiVs6KwdletFKVLn7YQwzYZ6yEnWU+nbYZ9gGhMADUxOhNY70Lmb
         iTGZjtXl592Dvctg7tGA++hI2GhCvs+jX7PDclFjA4AR61IIjOMch8bNWpeCyilQkJ58
         FN1coYlqIxRsJqy8NDhpjS1TjaWaqAtjxsiPfOIVWm9fWCY/3yzLoxYbLivOVpEifUPl
         jb0Q==
X-Gm-Message-State: AOAM533ZKzDnyhBa0OwSorqOAv/ifezzwUxLi5xReaBcGCiBjth35MrM
        ngXAqk1VIJrupy+14wAhVnVugMyKkGl0IQ==
X-Google-Smtp-Source: ABdhPJweIUJ2u0LpWZ+xuXmOPq3hAOa2td2QomfNUjIdQtiEJl65VvmkhEvUOYUz3KBekYegh6cZCw==
X-Received: by 2002:a67:e1c3:: with SMTP id p3mr11372473vsl.31.1643812072309;
        Wed, 02 Feb 2022 06:27:52 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id q22sm3459500vsj.23.2022.02.02.06.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 06:27:51 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id e17so19405997uad.9;
        Wed, 02 Feb 2022 06:27:50 -0800 (PST)
X-Received: by 2002:a67:c198:: with SMTP id h24mr12318471vsj.5.1643812070591;
 Wed, 02 Feb 2022 06:27:50 -0800 (PST)
MIME-Version: 1.0
References: <20220201120310.878267-1-maz@kernel.org> <20220201120310.878267-4-maz@kernel.org>
In-Reply-To: <20220201120310.878267-4-maz@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 2 Feb 2022 15:27:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXbM8kvmv0XKP8=rYj-8k5cFt50VP69LeDNX5oHx2e9dw@mail.gmail.com>
Message-ID: <CAMuHMdXbM8kvmv0XKP8=rYj-8k5cFt50VP69LeDNX5oHx2e9dw@mail.gmail.com>
Subject: Re: [PATCH 03/12] irqchip/renesas-intc-gpio: Move PM device over to
 irq domain
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

Hi Marc,

On Tue, Feb 1, 2022 at 1:12 PM Marc Zyngier <maz@kernel.org> wrote:
> Move the reference to the device over to the irq domain.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Thanks for your patch!

s/gpio/irqpin/ in the one-line summary?

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Wake-up still works fine on R-Mobile A1 and SH-Mobile AG5, so
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
