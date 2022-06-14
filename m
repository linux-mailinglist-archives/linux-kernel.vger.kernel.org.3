Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D4954AA5E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352624AbiFNHW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238663AbiFNHWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:22:25 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D04B2AEC;
        Tue, 14 Jun 2022 00:22:24 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id d128so5778728qkg.8;
        Tue, 14 Jun 2022 00:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lz5y+DuSGcsSnnDOr5IwDKXRxK40o1ln7wWC0XPROlc=;
        b=WwjDeL74QwwVwhWKrgTGdhjG9DuQ1Dk5Tvm99HMAYFWRlVf46+DWMUFhsNUB+B3+C2
         GaNtptsyjRyvqUBfBOwXdz/8L68AisaTUDWan6SiOP8jOGTffQM+hCX0mnK9UZfp8qtO
         5d1MyW/kvqWr7liUKvuXMHryAZOO+Ty5Du15Jxlbi4fte4qrZ/9hWYZtKeNtq1pEsUkN
         CpxxTSTRbxjpZJ6XScVKqjFwNQoOs30psxdICWZQNjE5I5iTGgh0Tk3/c8YXFZ3Ef6Gr
         nlD/wX9PdzfyZxywK1l0Mr37cSQUCO1+Yj9Ni1h6gP8n5urderuy5jPrWhPjxFLF102K
         crSA==
X-Gm-Message-State: AOAM533aYYjY1QTmgc9YqSmhq7QikzCgxazljUjK0lQ/xdVwczReuR+p
        zRaGJXAd60T+JhzFMG9zY5aTtSY48RI8lA==
X-Google-Smtp-Source: ABdhPJygmQ/2Wq7fVBb2ApZdNFsf81yjbpPU4jBrob2NBfSB269ymskQJYJ8cwc0k/v7c/CCC7v09Q==
X-Received: by 2002:a05:620a:120f:b0:6a6:b30a:efb5 with SMTP id u15-20020a05620a120f00b006a6b30aefb5mr2919414qkj.21.1655191343244;
        Tue, 14 Jun 2022 00:22:23 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id t15-20020a05620a0b0f00b006a6d7c3a82esm8119423qkg.15.2022.06.14.00.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 00:22:22 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id p13so13757373ybm.1;
        Tue, 14 Jun 2022 00:22:22 -0700 (PDT)
X-Received: by 2002:a05:6902:905:b0:64a:2089:f487 with SMTP id
 bu5-20020a056902090500b0064a2089f487mr3641955ybb.202.1655191341994; Tue, 14
 Jun 2022 00:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220609150851.23084-1-max.oss.09@gmail.com> <20220613191549.GA4092455-robh@kernel.org>
In-Reply-To: <20220613191549.GA4092455-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 Jun 2022 09:22:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU+aOw_D3SR6714U_i5WhE8S-FCLdPJaf_+Fncz4aH8VA@mail.gmail.com>
Message-ID: <CAMuHMdU+aOw_D3SR6714U_i5WhE8S-FCLdPJaf_+Fncz4aH8VA@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] power: domain: Add driver for a PM domain provider
 which controls
To:     Rob Herring <robh@kernel.org>
Cc:     Max Krummenacher <max.oss.09@gmail.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, Jun 13, 2022 at 9:15 PM Rob Herring <robh@kernel.org> wrote:
> On Thu, Jun 09, 2022 at 05:08:46PM +0200, Max Krummenacher wrote:
> > From: Max Krummenacher <max.krummenacher@toradex.com>
> >
> > its power enable by using a regulator.
> >
> > The currently implemented PM domain providers are all specific to
> > a particular system on chip.
>
> Yes, power domains tend to be specific to an SoC... 'power-domains' is
> supposed to be power islands in a chip. Linux 'PM domains' can be
> anything...

> > This allows to use the "regulator-pm-pd" driver with an arbitrary
> > device just by adding the 'power-domains' property to the devices
> > device tree node. However the device's dt-bindings schema likely does
> > not allow the property 'power-domains'.
> > One way to solve this would be to allow 'power-domains' globally
> > similarly how 'status' and other common properties are allowed as
> > implicit properties.
>
> No. For 'power-domains' bindings have to define how many there are and
> what each one is.

IMO "power-domains" are an integration feature, i.e. orthogonal to the
actual device that is part of the domain.  Hence the "power-domains"
property may appear everywhere.

It is actually the same for on-chip devices, as an IP core may be
reused on a new SoC that does have power or clock domains.  For
these, we managed to handle that fine because most devices do have
some form of family- or SoC-specific compatible values to control if
the power-domains property can be present/is required or not.

But for off-chip devices, the integrator (board designed) can do
whatever he wants.  Off-chip devices do have the advantage that it
is usually well documented which power supply (if there are multiple)
serves which purpose, which is not always clear for on-chip devices.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
