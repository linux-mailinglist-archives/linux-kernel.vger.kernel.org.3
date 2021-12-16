Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2E74773B3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 14:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237155AbhLPNyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 08:54:46 -0500
Received: from mail-qt1-f170.google.com ([209.85.160.170]:45645 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhLPNyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:54:45 -0500
Received: by mail-qt1-f170.google.com with SMTP id p19so25409828qtw.12;
        Thu, 16 Dec 2021 05:54:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r7QJ5cBXo5bJMtT1p7qM3PpjXsDY7rDmJRqDoolDi0U=;
        b=2VMxLStHSVZYdS47OWgNslnuumpW3odB99V7quDr3014FupJ2xnUqBtKP1uqvlHWfU
         45HnLuaeXq2hM7WQN5yr/OjOcwhEHRSNrQX0rCpkouHDb4OZVXpQ570sAZw8E83l3LJo
         GQpAAFOzjAdMNmJllbbswnr/UsrafqlgqOOZ7m/aqSLm45JnjcMrtwPodcwq5uuSqWvj
         4st1DwmsJbYUgLOiJ0v9YpXqZQiumQWf+CThspRlDKs7ozmIAKesZLqmK9jaTo1Y8Q2S
         nXV6JoNfEkyhhsIwCYzdT243ixFUs8v0/oCBA6Nuycxk9N83810QpVl/iCkr2qmjZhgB
         WpeQ==
X-Gm-Message-State: AOAM533uG0VRrvMjqvobDo0Depv1zSqupOlL7gkcnIR7Vf9tMQRDWl56
        vRunaAGjcG9XVLTtp3B+co4IgtPG6758rw==
X-Google-Smtp-Source: ABdhPJzFi1gUgt5i49QeCUL1jC2S3FXc0uZJARrSUSpQ7W0HjHpzhRkSXqSQfWNtmthWx7GJ6yzkTg==
X-Received: by 2002:a05:622a:413:: with SMTP id n19mr16757097qtx.69.1639662884927;
        Thu, 16 Dec 2021 05:54:44 -0800 (PST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com. [209.85.219.42])
        by smtp.gmail.com with ESMTPSA id n22sm4192703qtk.38.2021.12.16.05.54.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 05:54:44 -0800 (PST)
Received: by mail-qv1-f42.google.com with SMTP id kj6so8123000qvb.2;
        Thu, 16 Dec 2021 05:54:44 -0800 (PST)
X-Received: by 2002:a05:6102:c89:: with SMTP id f9mr5601778vst.68.1639662529143;
 Thu, 16 Dec 2021 05:48:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1639662093.git.geert@linux-m68k.org> <20211215154619.166360-1-miquel.raynal@bootlin.com>
In-Reply-To: <20211215154619.166360-1-miquel.raynal@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 16 Dec 2021 14:48:38 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUx0=b+GFP7Qvr9=L4tnf3K-UHatgKX=92EwRu3_7Bs_w@mail.gmail.com>
Message-ID: <CAMuHMdUx0=b+GFP7Qvr9=L4tnf3K-UHatgKX=92EwRu3_7Bs_w@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Renesas RZ/N1 NAND controller support
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup.patel@wdc.com>,
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

On Thu, Dec 16, 2021 at 2:44 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
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
