Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6136477386
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 14:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbhLPNs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 08:48:29 -0500
Received: from mail-ua1-f54.google.com ([209.85.222.54]:43842 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhLPNs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:48:27 -0500
Received: by mail-ua1-f54.google.com with SMTP id 107so6847309uaj.10;
        Thu, 16 Dec 2021 05:48:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GwUf1MNdbmgw1pD6FZTK0J55XMOIj4oBEJuIlJQ7QX8=;
        b=lWzINCKwxWH3WIK087K9YInfBEaVVXqesaRYG0oxNbIlKS0fuJFC6/a0AwI2zjrh0R
         wtE8zf2/08h+amkJt6Sf/RJkPZDUebRLcb1a2M69xHiYYBZqkJfdo2ijkbKmqAfiVXZD
         WxN/tjz+hPlQqhrxYfmBnnS5r0h/KSeKThoERcWSjc4J8Xj+ucj+9FlkjXJcnWWgwM+1
         RFaA/pzbvWDB/JsGOLbsElZ5628Ai1hEyZRRmn0Ej/fgtB8NaxmPAN78JC9I/O50size
         vMs75cbwAvb0+tBcSGIf4tO1jtRDx1Jjz5NqVDfkz1jRmjasHwWd2Cp8FzYDva1VdTSu
         JWqA==
X-Gm-Message-State: AOAM530X/im7gjIUxO+9RvgPzqvMCDsJcGPc7uwncPgrRQPT3bex6EaI
        35xG3kHvPqBSqlV0eZOrox1Y5c8W0SoYtA==
X-Google-Smtp-Source: ABdhPJwqaUS1nG1kWLlUXyNY4TlRzaBBUAaq54M6E5gpV3v8FUHbK+8j3iofXYFbyyuNTzPzJ8JgyA==
X-Received: by 2002:a67:dd12:: with SMTP id y18mr5482184vsj.56.1639662507137;
        Thu, 16 Dec 2021 05:48:27 -0800 (PST)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id 66sm1213363uao.0.2021.12.16.05.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 05:48:27 -0800 (PST)
Received: by mail-ua1-f42.google.com with SMTP id 107so6847259uaj.10;
        Thu, 16 Dec 2021 05:48:26 -0800 (PST)
X-Received: by 2002:a05:6102:3232:: with SMTP id x18mr5387370vsf.38.1639662506625;
 Thu, 16 Dec 2021 05:48:26 -0800 (PST)
MIME-Version: 1.0
References: <cover.1639661878.git.geert@linux-m68k.org> <20211215154619.166360-1-miquel.raynal@bootlin.com>
In-Reply-To: <20211215154619.166360-1-miquel.raynal@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 16 Dec 2021 14:48:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXwBNm=hG7mCgnpGAHFGHEmTBM0cGoVBDiqWGq9Go5+5A@mail.gmail.com>
Message-ID: <CAMuHMdXwBNm=hG7mCgnpGAHFGHEmTBM0cGoVBDiqWGq9Go5+5A@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Renesas RZ/N1 NAND controller support
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        MTD Maling List <linux-mtd@lists.infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 2:41 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> From: Miquel Raynal <miquel.raynal@bootlin.com>
>
> Hello,
>
> Here is a short series bringing support for Renesas RZ/N1 NAND
> controller.

Oops, please ignore this email. Sorry for the noise.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
