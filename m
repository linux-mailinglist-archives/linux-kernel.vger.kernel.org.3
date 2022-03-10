Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A6E4D554F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 00:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344690AbiCJX1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 18:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239313AbiCJX1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:27:09 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434B519ABD5;
        Thu, 10 Mar 2022 15:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=rvvIpi7k3bDAjHNxFs9qtFYxGVX6i80TlE7ph4fJVv4=; b=k3yo2LKfmw5mbr+a8qBF2YD9aS
        UhS7OBBQ/wYCqavl/5XgGdyHCempe0UvcFDZtzwAtObmjcI2kXs1AQBQtSkUBgRuaCV3FVjv8LbhQ
        2u3sngzQmidqiNlt4WHV9HJsWE3GvsL9S1fJAHQZ9zNKVQtL4mlB0zTsQmwbZN0ohWxU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nSSAB-00ACP9-WC; Fri, 11 Mar 2022 00:25:44 +0100
Date:   Fri, 11 Mar 2022 00:25:43 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "kostap@marvell.com" <kostap@marvell.com>,
        "robert.marko@sartura.hr" <robert.marko@sartura.hr>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 3/4] arm64: dts: marvell: Add Armada 98DX2530 SoC and
 RD-AC5X board
Message-ID: <YiqI9/Or4SL6NthP@lunn.ch>
References: <20220310030039.2833808-1-chris.packham@alliedtelesis.co.nz>
 <20220310030039.2833808-4-chris.packham@alliedtelesis.co.nz>
 <YioKgjhEnqylB24M@lunn.ch>
 <b6128e83-3f97-e728-66f2-25507d0f7abe@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6128e83-3f97-e728-66f2-25507d0f7abe@alliedtelesis.co.nz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> +	mvDma {
> >> +		compatible = "marvell,mv_dma";
> >> +		memory-region = <&prestera_rsvd>;
> >> +		status = "okay";
> >> +	};
> > Is this different to the existing Marvell XOR engine?
> 
> Yes it has something to do with the DMA memory for the integrated L3 
> switch. Because that driver doesn't exist I'll probably remove this node 
> (and the other prestera node below) in v2.

The compatible itself is not so great, since it made me think of the
DMA engine in the SoC. So maybe when the driver is added, it could be
something like prestera_dma?

> >> +				sdhci0: sdhci@805c0000 {
> >> +					compatible = "marvell,ac5-sdhci", "marvell,armada-ap806-sdhci";
> > This additional compatible should be added to the existing binding
> > document.
> I'll see what differences there are with the ap806-sdhci. I might be 
> able to remove it.

It is actually good to have the additional compatible. You might not
spot a difference now, but sometime in the future you do find a
difference which you need to work around in the driver. Having the
compatible in place means you can just change the driver and existing
DT blobs, burnt into flash etc, don't need to change.

> >
> >> +			eth0: ethernet@20000 {
> >> +				compatible = "marvell,armada-ac5-neta";
> > So it is not compatible with plain nata?
> 
> There is some odd muxing setup where the serdes are either SGMII or PCIe 
> or can even be connected to the internal switch. Whether the Ethernet 
> driver needs to care about it I'm not sure.

Russell King probably knows more about this, but it sounds more like a
comphy issues, not neta. The comphy connects the MAC to a SERDES, and
that SERDES can be SGMII, PCIe or USB.

> >> +		nand: nand@805b0000 {
> >> +			compatible = "marvell,ac5-nand-controller";
> > The current NAND driver does not work?
> 
> This is one of the things I can't test on the board I have (uses eMMC 
> instead of NAND). Should I put "marvell,armada-8k-nand-controller" in as 
> a placeholder or leave the node out entirely?

I would leave it out if you cannot test it.

  Andrew
