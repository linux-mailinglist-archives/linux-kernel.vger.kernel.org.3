Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D948854CDDE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348362AbiFOQLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiFOQLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:11:03 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D237534B91;
        Wed, 15 Jun 2022 09:11:01 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a29so19702439lfk.2;
        Wed, 15 Jun 2022 09:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wvgXMUe19+tnC/niWqva2BYC9twBwMOusfC9xJToLc0=;
        b=cACKFlgk0vAjggeOqDqPolXWI9jqe1mUvzJqF/4ZKnk8BJWFIT/PaEHnCC0SYy56Ap
         nvSqh2iOZTc0A0gC7AATZVDIRIHTKX90DiHuGuJcrkq51uUmoVRmelpSD5ERp+tg+zxP
         yMwlSu9O5T/7K4zw4TYs54hMoUDNTtjlJ88BPrZIbJajlzAp16Ygw/+iLgySCp4+Glro
         48pFhIqHYpTN53/PcYy4/Qs5Ns3OfzD/D7QbKTYakwKoOP2wBFR/Q9zoLnISoKaaPtpN
         fMXmgFvuKcfhW5akq2llkc7KM2jHRsKoFWu9VQxqOckQ+8flI2EV/K6DwpLg2qoDFZaB
         4NxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wvgXMUe19+tnC/niWqva2BYC9twBwMOusfC9xJToLc0=;
        b=FU/b/LfBB0AyqZBy4XfcAss+F8YrFt02qUmfwxAu+rTz8H33aW5Ij5W68x7bvuw4ys
         Bj5W3kQkV/362etbONFhrrxzLH+WgE2SHlWZVtW9F9E79dmk9qERezwzJgp2fusWlaOS
         rxRuYm0eWJdIqAUtWIFW+M9X0bp5lGM4h5f9NSgPj1bXjbnWzjn8FUp1AVvRqtBJg7pt
         QVneKshm0LG3+Wu8U9o0ikoAXCcAiw1iHIX9crZQNpjdA0FKhob3dEaTx4477PmrB4kK
         KKE8mh0ooyO8AlZYmdgizhw4ONgwILgYJgBeTian5MZy0Idesufhder0K/kGBQ5ICF/A
         ndBQ==
X-Gm-Message-State: AJIora/5Dn0kVPaVqlZm9T8rEaVEyzFnl3cm20+L/0VyHCXyj5MV9EYQ
        aOSJ7O92UWpljFiduNz2YZ0ku0eebKr6155FiOk=
X-Google-Smtp-Source: AGRyM1toftMNLI+bMk64j8iSZzr0cxrrxwAj4tiO2+SyjcwnLTdWx7aNT3elpx26GbmD++Ti33aZvgxhE2LTFoe48Ts=
X-Received: by 2002:a19:9117:0:b0:47a:300:7506 with SMTP id
 t23-20020a199117000000b0047a03007506mr138552lfd.235.1655309460230; Wed, 15
 Jun 2022 09:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220609150851.23084-1-max.oss.09@gmail.com> <20220613191549.GA4092455-robh@kernel.org>
 <CAMuHMdU+aOw_D3SR6714U_i5WhE8S-FCLdPJaf_+Fncz4aH8VA@mail.gmail.com>
In-Reply-To: <CAMuHMdU+aOw_D3SR6714U_i5WhE8S-FCLdPJaf_+Fncz4aH8VA@mail.gmail.com>
From:   Max Krummenacher <max.oss.09@gmail.com>
Date:   Wed, 15 Jun 2022 18:10:48 +0200
Message-ID: <CAEHkU3VVM0zUsaKMUGeSzfbLmVJW6rqXGLv7TqaLTEQeXEVkUA@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] power: domain: Add driver for a PM domain provider
 which controls
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh@kernel.org>,
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, Jun 14, 2022 at 9:22 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Rob,
>
> On Mon, Jun 13, 2022 at 9:15 PM Rob Herring <robh@kernel.org> wrote:
> > On Thu, Jun 09, 2022 at 05:08:46PM +0200, Max Krummenacher wrote:
> > > From: Max Krummenacher <max.krummenacher@toradex.com>
> > >
> > > its power enable by using a regulator.
> > >
> > > The currently implemented PM domain providers are all specific to
> > > a particular system on chip.
> >
> > Yes, power domains tend to be specific to an SoC... 'power-domains' is
> > supposed to be power islands in a chip. Linux 'PM domains' can be
> > anything...

I don't see why such power islands should be restricted to a SoC. You can
build the exact same idea on a PCB or even more modular designs.

>
> > > This allows to use the "regulator-pm-pd" driver with an arbitrary
> > > device just by adding the 'power-domains' property to the devices
> > > device tree node. However the device's dt-bindings schema likely does
> > > not allow the property 'power-domains'.
> > > One way to solve this would be to allow 'power-domains' globally
> > > similarly how 'status' and other common properties are allowed as
> > > implicit properties.
> >
> > No. For 'power-domains' bindings have to define how many there are and
> > what each one is.
>
> IMO "power-domains" are an integration feature, i.e. orthogonal to the
> actual device that is part of the domain.  Hence the "power-domains"
> property may appear everywhere.
>
> It is actually the same for on-chip devices, as an IP core may be
> reused on a new SoC that does have power or clock domains.  For
> these, we managed to handle that fine because most devices do have
> some form of family- or SoC-specific compatible values to control if
> the power-domains property can be present/is required or not.
>
> But for off-chip devices, the integrator (board designed) can do
> whatever he wants.  Off-chip devices do have the advantage that it
> is usually well documented which power supply (if there are multiple)
> serves which purpose, which is not always clear for on-chip devices.
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
