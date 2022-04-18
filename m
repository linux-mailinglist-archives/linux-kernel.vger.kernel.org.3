Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BE3504D53
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 09:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237036AbiDRIAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 04:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiDRIAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 04:00:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D291903C;
        Mon, 18 Apr 2022 00:57:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6142AB80E16;
        Mon, 18 Apr 2022 07:57:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7003CC385A7;
        Mon, 18 Apr 2022 07:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650268645;
        bh=b7GQE/+OBPXkgoj6+iT3PLf9vEfeClGLdfkCcGiZhFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OgBrZg2Tj6hOmuGMl0sm2HzDN9mW5SMfRZF6b6u1GLZcxxBRf6eyMv9OuD0RN7IZc
         W3/RJT5toyhj99acG4+LD5KvcWbfbCksK2SQn0Uyuy2tkifcXey1JE4y9XzWXoRH5C
         vyNjqiHKHogqsmK03XFlCVDzDEXnrNQPy36M/CptBG5e5Mbd6bqxcJz+4zm82Qif9G
         LFbT8gz2MFDy08ZlU9yIVO2HVHxj9iPF2ux5+yS5fGtuH3Np7+PAGVfd42OYEXLbZE
         1lGMZrvLRxK46PdxwP/zRkqHcqo8KWiPl5A83isojzY4JBdZZJ/DdOcsQbo4SkAM4f
         CCxu2HREkIm1w==
Date:   Mon, 18 Apr 2022 15:57:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] imx8mm-venice-gw7902: update pci refclk
Message-ID: <20220418075718.GB391514@dragon>
References: <20220405200625.19359-1-tharvey@gateworks.com>
 <20220411013106.GD129381@dragon>
 <CAJ+vNU0VVpDGDXivz=r8C4U8dYjA08SqnzPXwmtOv4ujvc3=Zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+vNU0VVpDGDXivz=r8C4U8dYjA08SqnzPXwmtOv4ujvc3=Zg@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 12:44:23PM -0700, Tim Harvey wrote:
> On Sun, Apr 10, 2022 at 6:31 PM Shawn Guo <shawnguo@kernel.org> wrote:
> >
> > On Tue, Apr 05, 2022 at 01:06:25PM -0700, Tim Harvey wrote:
> > > Use the correct PCI clock bindings.
> >
> > Please improve the commit log to explain why clock "pcie_phy" can be
> > dropped.
> >
> 
> Shawn,
> 
> The original PCIe bindings for this board were wrong - they were from
> a version of the bindings that was not yet approved (my mistake) and
> I'm just trying to bring them up to date.
> 
> That said, I looked at the latest fsl,imx6q-pcie.yaml dt-bindings [1]
> and see that there should be a min of 3 clocks called 'pcie',
> 'pcie_bus', and 'pcie_phy'. However I notice that all of the current
> imx8mm boards that enable PCI have clock-names of 'pcie', 'pcie_aux',
> and 'pcie_bus'. It seems like all the imx8mm boards having pcie have
> clock-names this way:
> 
> arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
> arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dts
> arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
> arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
> arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi
> arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
> arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
> arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts
> 
> Does the binding need to change or do the clock names need to change
> in the above?

If the bindings is approved/correct, device tree should match bindings.

Shawn
