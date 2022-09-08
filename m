Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8B55B18E3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 11:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiIHJjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 05:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiIHJjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 05:39:15 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABAAFBF21;
        Thu,  8 Sep 2022 02:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1662629954; x=1694165954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Alxpd1HY785/O28PkM/JBtWCPSW1SE57zwuThatvaiY=;
  b=myNgrW/A7lW0BfSZClNbnMelFH42lZ7//UJoxVgX6KPYiJeVj+ug6KbM
   tR+4kRhU5CAZ/ZOL3D7XRDD9ky95HkCIU/PNr4ePvnO+LTgoFFZs2pTGW
   9EsR2xobxgCpW8dCSpAQ2oB9ZLR5OJCBKQpFec4PclUpGvG/dZGDBpxcz
   cDLZEKEJ3KXJ7PPQRDs6EA1fkzUgoNBZhQ6xylbuS0yA++CuBFOFadNR8
   2kQPsYCwUnOHzkzz3HZwim/ZqcQniom5Hy0i+aYQyCbMAF/piGhMldF5r
   DKed0l8FMImYzbR5fsO8oR1rIvkj8cBieMa1Qx9f435ZRx1oUHsZgN8iF
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,299,1654552800"; 
   d="scan'208";a="26065096"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 08 Sep 2022 11:39:11 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 08 Sep 2022 11:39:11 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 08 Sep 2022 11:39:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1662629951; x=1694165951;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Alxpd1HY785/O28PkM/JBtWCPSW1SE57zwuThatvaiY=;
  b=J/nESCRd/wOz5y11btNFoD5/XkdrSS8iERoUm+zejHODoIinjOTjT23L
   qh23lDHriLra6fx1/hYH3SCUNrlPBwHQm2K1W06xCvFmLd+D9PXMjdCPK
   d+fNXeSEP8P1WC2l7L8EQ75FItZy7Q9MCPYUR4e+x60Iqw9SVpuJ1ZFb4
   p9neLWp3tfYqL3xT+/tPpWh5CPG6Tj9QJ9hBXDXs4/2Kp1+I0LxzSbPWw
   iS0fCZR7FuoCj+HJ2plLzN3W8QRptPFif5pM5xofLq2xNfhLhTUdsxtls
   xXhXSPbvCyv3EZHfaOViCbLI6Dfi1Whl8r/pdLWwrI6bbxri5rvU7mxw+
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,299,1654552800"; 
   d="scan'208";a="26065094"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 08 Sep 2022 11:39:11 +0200
Received: from steina-w.localnet (unknown [10.123.49.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 6FCB3280056;
        Thu,  8 Sep 2022 11:39:11 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Jun Li <jun.li@nxp.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/4] arm64: dts: imx8mp: Add snps, gfladj-refclk-lpm-sel quirk to USB nodes
Date:   Thu, 08 Sep 2022 11:39:09 +0200
Message-ID: <1836686.CQOukoFCf9@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <PA4PR04MB9640C21A8F2DC44DB58C5C9089409@PA4PR04MB9640.eurprd04.prod.outlook.com>
References: <20220907144624.2810117-1-alexander.stein@ew.tq-group.com> <20220907144624.2810117-4-alexander.stein@ew.tq-group.com> <PA4PR04MB9640C21A8F2DC44DB58C5C9089409@PA4PR04MB9640.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 8. September 2022, 11:12:23 CEST schrieb Jun Li:
> > -----Original Message-----
> > From: Alexander Stein <alexander.stein@ew.tq-group.com>
> > Sent: Wednesday, September 7, 2022 10:46 PM
> > To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Rob Herring
> > <robh+dt@kernel.org>; Krzysztof Kozlowski
> > <krzysztof.kozlowski+dt@linaro.org>; Shawn Guo <shawnguo@kernel.org>;
> > Sascha Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; dl-linux-imx
> > <linux-imx@nxp.com>; Jun Li <jun.li@nxp.com>
> > Cc: Alexander Stein <alexander.stein@ew.tq-group.com>;
> > linux-usb@vger.kernel.org; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: [PATCH 3/4] arm64: dts: imx8mp: Add snps,gfladj-refclk-lpm-sel
> > quirk to USB nodes
> > 
> > With this set the SOF/ITP counter is based on ref_clk when 2.0 ports are
> > suspended.
> > 
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> > 
> >  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > index 53493dc7d976..0e7f5842a3e4 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > @@ -1300,6 +1300,7 @@ usb_dwc3_0: usb@38100000 {
> > 
> >  				phys = <&usb3_phy0>, <&usb3_phy0>;
> >  				phy-names = "usb2-phy", "usb3-
phy";
> >  				snps,dis-u2-freeclk-exists-quirk;
> 
> So this property can be removed?

I'm not so sure about this one, as the description is talking about USB2 PHY 
providing a free-running PHY clock. I don't know the details if this is true 
or not.
But removing snps,dis-u2-freeclk-exists-quirk from both USB device nodes, USB 
devices attachments are still detected when the USB hub is suspended, both 
super-speed and high-speed ports.

Best regards,
Alexander

> > +				snps,gfladj-refclk-lpm-sel-quirk;
> > 
> >  			};
> >  		
> >  		};
> > 
> > @@ -1342,6 +1343,7 @@ usb_dwc3_1: usb@38200000 {
> > 
> >  				phys = <&usb3_phy1>, <&usb3_phy1>;
> >  				phy-names = "usb2-phy", "usb3-
phy";
> >  				snps,dis-u2-freeclk-exists-quirk;
> 
> Ditto.
> 
> Li Jun
> 
> > +				snps,gfladj-refclk-lpm-sel-quirk;
> > 
> >  			};
> >  		
> >  		};
> > 
> > --
> > 2.25.1




