Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B500248C009
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351666AbiALIfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:35:47 -0500
Received: from mail-vk1-f179.google.com ([209.85.221.179]:33352 "EHLO
        mail-vk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237928AbiALIfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:35:46 -0500
Received: by mail-vk1-f179.google.com with SMTP id g5so1204271vkg.0;
        Wed, 12 Jan 2022 00:35:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uzrwVlUjF4Cm6U41jHDUviQoi4xXGcSU62ZROcX5r6A=;
        b=bKZSVX/o0J0WxS/bRe/rbKXfDgOjCeLz3+wTWocV5GrmnTLsoo1Iggu73czOyl2CKC
         kyANKLz4/aLV/okuFMs0Z9W6eRuC/T7n1YwRNoCuHeobemu94HFyVKAMV65I8KWRNGrZ
         ihvfTotBRFtr+G05DGS2+cGV6ktpa4HuQrROE4X+mhS4jNYSO1hV/t8RXnFb2wkmlBQc
         vR/f63G1YrdtD3VGZBc2FMDfKiexhl5XFZ2YhfzsfHgkqB88c5O7f3ujK2R/hrwAuJdR
         fO3k2rSp6585Rh9ffq/HJOsl1jGvkAuTIjz60dlsXIooMjrb6wLcerkYJUwM17u6dLI1
         2EPw==
X-Gm-Message-State: AOAM53275ONNMtyzyroGKct1C8q8tjouuqezMDBqfjb63vMaUmfcTSah
        foeu38PIyUOTp4UV29uvRD/FqIBSDIbi+MOW
X-Google-Smtp-Source: ABdhPJzi4p7aWrQykXDVAb7krxqvSPDFN0BmSfRikhyACl1rbvcgKzz9TGC0pQZVaUqJzSxxsCSs/A==
X-Received: by 2002:a05:6122:2029:: with SMTP id l41mr361041vkd.4.1641976545776;
        Wed, 12 Jan 2022 00:35:45 -0800 (PST)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id m8sm6793899uae.8.2022.01.12.00.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 00:35:45 -0800 (PST)
Received: by mail-vk1-f171.google.com with SMTP id d189so1172381vkg.3;
        Wed, 12 Jan 2022 00:35:45 -0800 (PST)
X-Received: by 2002:a1f:384b:: with SMTP id f72mr4131751vka.0.1641976544882;
 Wed, 12 Jan 2022 00:35:44 -0800 (PST)
MIME-Version: 1.0
References: <20220110144039.5810-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220110144039.5810-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 12 Jan 2022 09:35:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWnV33m99nM71YPYcrgEWxw4Oo_+HR3CBjtapzNuc089A@mail.gmail.com>
Message-ID: <CAMuHMdWnV33m99nM71YPYcrgEWxw4Oo_+HR3CBjtapzNuc089A@mail.gmail.com>
Subject: Re: [PATCH v4] thermal: rcar_thermal: Use platform_get_irq_optional()
 to get the interrupt
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 4:24 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
>
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq_optional().
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
