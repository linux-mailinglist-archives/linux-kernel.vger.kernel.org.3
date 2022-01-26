Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0647C49C4B1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 08:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238032AbiAZHom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 02:44:42 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49340 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiAZHol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 02:44:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93354B81B7D;
        Wed, 26 Jan 2022 07:44:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722BCC340E3;
        Wed, 26 Jan 2022 07:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643183079;
        bh=vtPURswq1do/5958Qsa3FJW0cYlaVmXbhfDTYeU+OH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JHMlhykQSTpMDY9BR/P6/EVFcCO5+WXfKtFcxPg6oEu2Uje+HF1ShNlhHxK+2Uc0r
         UZnFaEtebexA08W5OtXlZTsGTPPyXSinP7HLuZGQx3bvNYXtkECHYk254FYQvpRvcD
         WsMIIJWk9SG94/a/lzLZU/2HPh2i1awWLXVAMM6qmyT5apTO2MGiuWe2O6dtK5ttd3
         tfwXoxJxe9CNjESfsQNdUHiffW6nKI1sTvrZMqIDKzOXSwB9fd7PCoiJiyGfd9eOl2
         HLj6KKZ13hiIJ0h8fOU6NI6KwKEpIL4FdkYvL9T6/I6ivvxrja/05mol41kyKveDSy
         Ibi/gNTdqPaxw==
Date:   Wed, 26 Jan 2022 15:44:32 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Tim Harvey <tharvey@gateworks.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: Re: (EXT) Re: (EXT) Re: [PATCH] arm64: dts: imx8mm-venice-gw73xx-0x:
 add dt overlays for serial modes
Message-ID: <20220126074432.GF4686@dragon>
References: <20211214213630.14819-1-tharvey@gateworks.com>
 <2226437.ElGaqSPkdT@steina-w>
 <CAJ+vNU2PxF=9VwMv4f8N5W5Gs2Ynxdn9jHTSkWH7zd3Fo5hBiw@mail.gmail.com>
 <6686721.lOV4Wx5bFT@steina-w>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6686721.lOV4Wx5bFT@steina-w>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 07:58:00AM +0100, Alexander Stein wrote:
> Am Dienstag, 11. Januar 2022, 18:53:29 CET schrieb Tim Harvey:
> > On Mon, Jan 10, 2022 at 11:20 PM Alexander Stein
> > 
> > <alexander.stein@ew.tq-group.com> wrote:
> > > Am Dienstag, 11. Januar 2022, 01:00:21 CET schrieb Tim Harvey:
> > > > [SNIP]
> > > > 
> > > > > diff --git a/arch/arm64/boot/dts/freescale/Makefile
> > > > > b/arch/arm64/boot/dts/freescale/Makefile index
> > > > > a14a6173b765..5ec8d59347b6
> > > > > 100644
> > > > > --- a/arch/arm64/boot/dts/freescale/Makefile
> > > > > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > > > > @@ -44,6 +44,9 @@ dtb-$(CONFIG_ARCH_MXC) +=
> > > > > imx8mm-var-som-symphony.dtb
> > > > > 
> > > > >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw71xx-0x.dtb
> > > > >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw72xx-0x.dtb
> > > > >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x.dtb
> > > > > 
> > > > > +dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-rs232-rts.dtbo
> > > > > +dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-rs422.dtbo
> > > > > +dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-rs485.dtbo
> > > > > 
> > > > >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7901.dtb
> > > > >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7902.dtb
> > > > >  dtb-$(CONFIG_ARCH_MXC) += imx8mn-beacon-kit.dtb
> > > > 
> > > > [SNIP]
> > > > I'm mostly interested to see if my approach to dt fragments here and
> > > > the naming of the files makes sense to others.
> > > > 
> > > > This patch causes the kernel to build dtbo files for:
> > > > arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtbo
> > > > arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtbo
> > > > arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtbo
> > > > 
> > > > The intention is that these files are used by boot firmware (U-Boot)
> > > > to adjust the dtb before passing it to the kernel.
> > > 
> > > Hi Tim,
> > > 
> > > do these dtbo actually work? I'm wondering because I was trying to
> > > useoverlays myself and noticed that the had to be compiled with -@ for
> > > u-boot to be able
> > > to apply them. Apparently there are 2 possibilities:
> > Alexander,
> > 
> > Yes, they work, but I do manually set DTC_FLAGS=-@ when building
> > kernel dtbs to make them work.
> 
> I see, I expected something like this. That's why I responded to you.
> 
> > > * Set "DTC_FLAGS_[dtb] := -@" yourself
> > > See https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
> > > commit/?id=e426d63e752bdbe7d5ba2d872319dde9ab844a07
> > > 
> > > * Use dedicated overlay target
> > > See https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
> > > commit/?id=15d16d6dadf6947ac7f9a686c615995c5a426ce2
> > > 
> > > You use neither of them. IIRC just naming the target file .dtbo will not
> > > apply symbols (-Q) during dtc call. Can you verify using 'V=1'
> > > Also I'm wondering which way is the best to go.
> > 
> > I wasn't aware there was a way to do this via Makefiles. It seems that
> > perhaps Rob's approach with 'kbuild: Add generic rule to apply
> > fdtoverlay' is a way to avoid having to add them all manually in the
> > first approach? I must admit I'm not sure how to use that.
> 
> I tried using this myself for my custom board. I feel it is a bit cumbersome 
> to get it right.
> See https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/
> arch/arm64/boot/dts/xilinx/Makefile for an example.
> 
> Essentially you define your .dtb as before and add another target (e.g. sm-
> k26-revA-sck-kv-g-revA-dtbs) where you add your .dtbo _after_ the original 
> .dtb. This target needs to be added to 'dtb-y' as before.
> 
> I suspect this way is needed to check the .dtbo against the base .dtb if it 
> actually matches.

Yeah, I like this check.  Tim, could you update your patch to follow
this pattern?

Shawn
