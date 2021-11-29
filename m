Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C156E4613E1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 12:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241101AbhK2Ld5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 06:33:57 -0500
Received: from st43p00im-zteg10062001.me.com ([17.58.63.166]:50897 "EHLO
        st43p00im-zteg10062001.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241172AbhK2Lbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:31:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1638185309; bh=FO0LUT32VcGamCeUuaNkSfl73khKfpMSTlnCbYYzcRo=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=Sm+l7dOwSWblAFjEalalHCDsvEiE5jSh5mxYhcgMF9W1pENtnnB0TVxX+bCX5+aY3
         eDsOep0NahianPdsVG0fGMG8caA8edjHtwb476z7p91Q0lZJMQLZPl1M2yqe20p6nr
         dYzdo3/RFqIeU2hVinXnr1t+oqrT13No9TWxO/gckf6HWj3FNaPK9CW+rQJrbmgdRh
         GR3FSsPFRVsLMxoUlyPEkVigfY0BsQo9/YcUKCcoY4eO6KXCWB+ME6JKewrgT/yX8W
         jJGqCVF/4FupDcrySmfkQhsz+/2a0KNEJbDj0yZ0vPOxmUDQgRk8BCRfJrW5UU1Y66
         Zu/8PFQENw5jg==
Received: from gnbcxl0045.gnb.st.com (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-zteg10062001.me.com (Postfix) with ESMTPSA id 1799A6C01B2;
        Mon, 29 Nov 2021 11:28:26 +0000 (UTC)
Date:   Mon, 29 Nov 2021 12:28:24 +0100
From:   Alain Volmat <avolmat@me.com>
To:     Andrew Lunn <andrew@lunn.ch>, robh+dt@kernel.org
Cc:     wsa@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Alain Volmat <avolmat@me.com>
Subject: Re: [RFC] sti: Conflict in node name for an IP supporting both I2C
 and SPI
Message-ID: <20211129112824.GA17122@gnbcxl0045.gnb.st.com>
Mail-Followup-To: Andrew Lunn <andrew@lunn.ch>, robh+dt@kernel.org,
        wsa@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Patrice Chotard <patrice.chotard@foss.st.com>
References: <20211125210428.GA27075@gnbcxl0045.gnb.st.com>
 <YaFkG85DHMMRiD7O@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaFkG85DHMMRiD7O@lunn.ch>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-11-29_05:2021-11-28,2021-11-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2111290057
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Nov 26, 2021 at 11:47:55PM +0100, Andrew Lunn wrote:
> On Thu, Nov 25, 2021 at 10:04:28PM +0100, Alain Volmat wrote:
> > Hello,
> > 
> > in the STi platform [1], the I2C and SPI controllers are handled by the
> > same IP, which can be configured in either one or the other mode.
> > This leads to warnings during the DT build and I was wondering if you could
> > give me some hints about how such situation should be handled since this
> > concern DT warnings but also bindings and YAML.
> > 
> > In the SoC DT (dtsi), for each IP, there are 2 entries:
> > 
> > One for the I2C mode (implemented by the driver i2c/busses/i2c-st.c)
> >                 i2c@9840000 {
> >                         compatible = "st,comms-ssc4-i2c";
> >                         interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
> >                         reg = <0x9840000 0x110>;
> >                         clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
> >                         clock-names = "ssc";
> >                         clock-frequency = <400000>;
> >                         pinctrl-names = "default";
> >                         pinctrl-0 = <&pinctrl_i2c0_default>;
> >                         #address-cells = <1>;
> >                         #size-cells = <0>;
> > 
> >                         status = "disabled";
> >                 };
> > 
> > One for the SPI mode (implemented by the driver spi/spi-st-ssc4.c)
> >                 spi@9840000 {
> >                         compatible = "st,comms-ssc4-spi";
> >                         reg = <0x9840000 0x110>;
> >                         interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
> >                         clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
> >                         clock-names = "ssc";
> >                         pinctrl-0 = <&pinctrl_spi0_default>;
> >                         pinctrl-names = "default";
> >                         #address-cells = <1>;
> >                         #size-cells = <0>;
> > 
> >                         status = "disabled";
> >                 };
> > 
> > So basically, there are 2 nodes, one for each mode, and enabling one or the
> > other mode is done within the board DT.
> > Since the address is the same, this obviously leads to warning during the build
> > of the DT.
> > 
> > arch/arm/boot/dts/stih407-family.dtsi:363.15-376.5: Warning (unique_unit_address): /soc/i2c@9840000: duplicate unit-address (also used in node /soc/spi@9840000)
> 
> How about making the compiler look at the status value. So long as
> only zero or one is enabled, it should not be an issue. If you have
> two or more nodes enabled for an address, then you want a warning or
> error.

From the compiler point of view it seems this behavior is already
possible, probably with something like:
   -Wno-unique_unit_address -Wunique_unit_address_if_enabled

Rob, is current behavior (checking unique unit address even if node
is disabled) on purpose or could this be changed to only checking if the
node is enabled ?

Alain

> 
>      Andrew
> 
