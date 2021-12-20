Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7EF47A7B2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 11:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhLTKVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 05:21:50 -0500
Received: from mail-ua1-f44.google.com ([209.85.222.44]:37691 "EHLO
        mail-ua1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbhLTKVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 05:21:49 -0500
Received: by mail-ua1-f44.google.com with SMTP id o1so16750513uap.4;
        Mon, 20 Dec 2021 02:21:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YZuaGItJIS6bhn0pnYKjSvX8duMimq87kuh/1dcSYow=;
        b=aRkJOOTNPw696QPGeQ8mJJL5ml+4d9Ss3igqtx3KsjVYZKRhGFSPd+jQPI+F2N73Ke
         fPOKoIkVBmM+23P0fKTOwFMz2/A8ETL8RPn1k7UYzgUAxUPo2b9eVhBrYRMWJYEiUXlS
         gBUL1kNHI6M3ZMj7YNzPRLEefwA39arOqKnteP4Nad01fqkyB3Lqa/kGOj6PNkhglciy
         uIWsveO1LCrzDNZQwBf4OiUO/0iJA19B8mjhJxcJT9WxCzANR+DwWqtmTEbPHwTXoikO
         zhYNXAHXI8NfIu+ANltFo19DJoLL7Yv3sVj7fEc79LY5Ygmi+Dmh3kQspKlOP2+kMtEj
         1WXg==
X-Gm-Message-State: AOAM533tpInY4aabqF+XKYXSAYAdIWPrJpb29qRy37X+bUebtk4yut0T
        DJ0LIwj7ItBpM7ymeUlyzlRGL1BI+6bwlQ==
X-Google-Smtp-Source: ABdhPJw6BR9Ub8uR9XHB5wgFkSpeBcPX2wk8nPa835SPT4+6i35xxCNVpRDG2ny5O3ACX9rM3wVQFw==
X-Received: by 2002:a67:ac49:: with SMTP id n9mr4735802vsh.65.1639995708807;
        Mon, 20 Dec 2021 02:21:48 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id b10sm3075523uad.8.2021.12.20.02.21.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 02:21:48 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id i6so16749005uae.6;
        Mon, 20 Dec 2021 02:21:47 -0800 (PST)
X-Received: by 2002:a9f:3e01:: with SMTP id o1mr4782661uai.89.1639995707724;
 Mon, 20 Dec 2021 02:21:47 -0800 (PST)
MIME-Version: 1.0
References: <20211220010411.12075-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20211220010411.12075-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20211220010411.12075-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Dec 2021 11:21:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUcZ4scjzoLE7gpJKTpixT8hUEXiLX8nCzrjViBcipPbw@mail.gmail.com>
Message-ID: <CAMuHMdUcZ4scjzoLE7gpJKTpixT8hUEXiLX8nCzrjViBcipPbw@mail.gmail.com>
Subject: Re: [PATCH 1/6] usb: host: fotg210: Use platform_get_irq() to get the interrupt
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Felipe Balbi <balbi@kernel.org>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Bin Liu <b-liu@ti.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 10:18 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
>
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq().
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
