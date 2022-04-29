Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3490515035
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378773AbiD2QHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378763AbiD2QHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:07:44 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0E385655
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:04:25 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s137so6855937pgs.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CNNorgah8ybYol7gjHDhFHcts5/oLyPdR4o5Dg4a4YY=;
        b=iz0iLtf5Kgi2CEamDtU3O35n39GYZGMdBjauwSTHbzwKnjawPqftV1+DkTxu8l+fYP
         t3qSRFrjLVUdYo0fXyr5RNryHNmSK+9EUoIIiyoRIa5/HelC4citWC2v1up652v7KFgz
         5vVtIgQrwZAO3JA17Uhx16lKZOYVUwKFGXKlwz9h/HCRwreWzGDnMmXkMarfczh4tpWg
         gwNzy8gHq9PJg4zsTl2I3oI4QnvAJadoE0Dz3iWgf7Dal7FjTiX5rj7kH6vnv8AQMDhg
         eMExwp74qxVfbIwj+RnyQF2c7ftt9BpB/6tCTPcbqwyHiSir7yAqU3Yfa2sOfp/hYiLq
         eMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CNNorgah8ybYol7gjHDhFHcts5/oLyPdR4o5Dg4a4YY=;
        b=H79VNSLFyz9CiRP5gAQNQB0Wl/Zb/8n8C+68E2XDyLAY1EIUgQ5x/ONO1n59g/LocA
         dDFupqA+ER8RghR56gRh00p+eCdco2aWUtRxqpLx26uSzUxrbXBiMwZrTmH/FdC9sLcT
         NwK1Dg0tqKOf5s7yV42Jqhu/HcpuZP0BJbt5bKiP3cxtWwDpdHLGNMixgoAd+xd3ij4d
         ZOBDf0TRfsK6JdNbpw56+iKWJ/2RdU+fyDG+RxtBefVQWIol3BOMozOMLczFcTiR0R4R
         q+8RZD3NL77X0UEXd+DXET6958DLwxeCQ9WfoqYVfiNnKiW9BAnZGcn5U/be0Swvl7Hf
         dsuA==
X-Gm-Message-State: AOAM5329gN3uPCy03qcHsZAfblSnELpqrx7Ok0Lzo/2vIKiF6qG5h39u
        Lmt4RVJmnF01SHvb0JI5uwgMTwzC4yvT2DDKfd7h6A==
X-Google-Smtp-Source: ABdhPJxsrjeODXrBp50VvsilExotJGBqxGmNr9R5vlCqNAXc0PJO2RfQxaGuXWFTfDX9NxLbE7pxdM/KFDsDWvkwkCA=
X-Received: by 2002:a63:d43:0:b0:3c1:475e:8341 with SMTP id
 3-20020a630d43000000b003c1475e8341mr49887pgn.533.1651248265273; Fri, 29 Apr
 2022 09:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220405200625.19359-1-tharvey@gateworks.com> <20220411013106.GD129381@dragon>
 <CAJ+vNU0VVpDGDXivz=r8C4U8dYjA08SqnzPXwmtOv4ujvc3=Zg@mail.gmail.com> <20220418075718.GB391514@dragon>
In-Reply-To: <20220418075718.GB391514@dragon>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Fri, 29 Apr 2022 09:04:13 -0700
Message-ID: <CAJ+vNU12t_2Jr_D=YC-ZRJdJuZS2aPQ7EoT0QA8vctGhhLuHtQ@mail.gmail.com>
Subject: Re: [PATCH] imx8mm-venice-gw7902: update pci refclk
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 12:57 AM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Mon, Apr 11, 2022 at 12:44:23PM -0700, Tim Harvey wrote:
> > On Sun, Apr 10, 2022 at 6:31 PM Shawn Guo <shawnguo@kernel.org> wrote:
> > >
> > > On Tue, Apr 05, 2022 at 01:06:25PM -0700, Tim Harvey wrote:
> > > > Use the correct PCI clock bindings.
> > >
> > > Please improve the commit log to explain why clock "pcie_phy" can be
> > > dropped.
> > >
> >
> > Shawn,
> >
> > The original PCIe bindings for this board were wrong - they were from
> > a version of the bindings that was not yet approved (my mistake) and
> > I'm just trying to bring them up to date.
> >
> > That said, I looked at the latest fsl,imx6q-pcie.yaml dt-bindings [1]
> > and see that there should be a min of 3 clocks called 'pcie',
> > 'pcie_bus', and 'pcie_phy'. However I notice that all of the current
> > imx8mm boards that enable PCI have clock-names of 'pcie', 'pcie_aux',
> > and 'pcie_bus'. It seems like all the imx8mm boards having pcie have
> > clock-names this way:
> >
> > arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
> > arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dts
> > arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
> > arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
> > arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi
> > arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
> > arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
> > arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts
> >
> > Does the binding need to change or do the clock names need to change
> > in the above?
>
> If the bindings is approved/correct, device tree should match bindings.
>

Shawn,

I think the bindings are wrong.

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml has [1]:

  clocks:
    minItems: 3
    items:
      - description: PCIe bridge clock.
      - description: PCIe bus clock.
      - description: PCIe PHY clock.
      - description: Additional required clock entry for imx6sx-pcie,
          imx8mq-pcie.

  clock-names:
    minItems: 3
    items:
      - const: pcie
      - const: pcie_bus
      - const: pcie_phy
      - const: pcie_inbound_axi for imx6sx-pcie, pcie_aux for imx8mq-pcie

This indicates the "pcie_phy" clock is required yet
drivers/pci/controller/dwc/pci-imx6.c [2] doesn't require it if it has
an abstract PHY driver which is the case for IMX8M (and that's why my
patch drops it)

Additionally I note that the 4th clock described in the bindings could
use some clarification for imx8mm-pcie as for this "pcie_aux" is
required.

Best Regards,

Tim
[1] https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
[2] https://elixir.bootlin.com/linux/v5.18-rc4/source/drivers/pci/controller/dwc/pci-imx6.c#L1140
