Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C394C8A1F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 11:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbiCAK52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 05:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiCAK5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:57:25 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A558D6A7;
        Tue,  1 Mar 2022 02:56:44 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 221AuRaH097518;
        Tue, 1 Mar 2022 04:56:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1646132187;
        bh=zbZw6U1U+q/OqMykHu4syaDjok492zGJ/pzPQ7GdmIc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=UcIsJUv66SEzzErPBUmmhjSACZDy8Fxas9JTRe4ttpLwgcQu/7ifjQxmaH78Tu1QP
         lsX/pIBmpzD1/CIeyRwjq1GXVRbi23Fhpcp0ZfaxDVAhqPtFesBUVidVj+gUIBve//
         r/d075qIm14+AXlfk5pBNNkunZS3l8sGotW4Sudk=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 221AuQsY121867
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Mar 2022 04:56:26 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 1
 Mar 2022 04:56:26 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 1 Mar 2022 04:56:26 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 221AuPja033887;
        Tue, 1 Mar 2022 04:56:26 -0600
Date:   Tue, 1 Mar 2022 16:26:25 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
Subject: Re: [PATCH v9 1/4] phy: cadence: Add Cadence D-PHY Rx driver
Message-ID: <20220301105625.o7wlw6giqsw5nrvx@ti.com>
References: <20220131173314.2073641-1-p.yadav@ti.com>
 <20220131173314.2073641-2-p.yadav@ti.com>
 <YhTu2ixdWBKU1Y8y@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YhTu2ixdWBKU1Y8y@matsya>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/22 07:40PM, Vinod Koul wrote:
> On 31-01-22, 23:03, Pratyush Yadav wrote:
> > The Cadence D-PHY can be configured in Tx (DSI) mode or Rx (CSI) mode.
> > Both modes have a different programming sequence and share little among
> > them. In addition, a PHY configured in Tx mode cannot be used in Rx mode
> > and vice versa. For this reason, create a separate driver for the Rx
> > mode to make it easier to read and maintain.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > ---
> > 
> > Changes in v9:
> > - Use %ld instead of %d for printing PTR_ERR().
> > 
> > Changes in v8:
> > - Move lanes check to start of configure sequence.
> > - Change MODULE_LICENSE() to "GPL".
> > - Add Laurent's R-by.
> > 
> > Changes in v7:
> > - Add spaces after { and before } in the bands table.
> > - Drop the wrapping around the for loop on cdns_dphy_rx_get_band_ctrl().
> > - Make cdns_dphy_rx_wait_for_bit() inline.
> > - Print an error message if registering PHY provider fails.
> > 
> > Changes in v6:
> > - Move to a separate driver.
> > 
> > Changes in v5:
> > - Use the new cdns_dphy_info to specify PHY ops.
> > - Re-order include in alphabetical order.
> > - Make bands const.
> > - Drop num_bands.
> > - Make i, lanes unsigned.
> > - Drop the maximum check in cdns_dphy_rx_get_band_ctrl(). Let the loop
> >   complete and return -EOPNOTSUPP when we reach the end.
> > - Drop the "rate < bands[i].min_rate" check since the bands are in
> >   ascending order.
> > - Move data_lane_ctrl to start of function and make it static const.
> > 
> > Changes in v4:
> > - Drop the submode parts. Use a different compatible for the Rx ops.
> > - Make bands and num_bands static.
> > 
> > Changes in v3:
> > - Use a table to select the band.
> > - Use a table to poll the data lane ready bits.
> > - Multiply the DPHY HS clock rate by 2 to get the bit rate since the
> >   clock is DDR.
> > 
> >  drivers/phy/cadence/Kconfig        |   8 +
> >  drivers/phy/cadence/Makefile       |   1 +
> >  drivers/phy/cadence/cdns-dphy-rx.c | 255 +++++++++++++++++++++++++++++
> >  3 files changed, 264 insertions(+)
> >  create mode 100644 drivers/phy/cadence/cdns-dphy-rx.c
> > 
> > diff --git a/drivers/phy/cadence/Kconfig b/drivers/phy/cadence/Kconfig
> > index a62910ff5591..1adde2d99ae7 100644
> > --- a/drivers/phy/cadence/Kconfig
> > +++ b/drivers/phy/cadence/Kconfig
> > @@ -22,6 +22,14 @@ config PHY_CADENCE_DPHY
> >  	  system. If M is selected, the module will be called
> >  	  cdns-dphy.
> >  
> > +config PHY_CADENCE_DPHY_RX
> > +	tristate "Cadence D-PHY Rx Support"
> > +	depends on HAS_IOMEM && OF
> > +	select GENERIC_PHY
> > +	select GENERIC_PHY_MIPI_DPHY
> > +	help
> > +	  Support for Cadence D-PHY in Rx configuration.
> > +
> >  config PHY_CADENCE_SIERRA
> >  	tristate "Cadence Sierra PHY Driver"
> >  	depends on OF && HAS_IOMEM && RESET_CONTROLLER
> > diff --git a/drivers/phy/cadence/Makefile b/drivers/phy/cadence/Makefile
> > index 26e16bd34efe..e17f035ddece 100644
> > --- a/drivers/phy/cadence/Makefile
> > +++ b/drivers/phy/cadence/Makefile
> > @@ -1,5 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  obj-$(CONFIG_PHY_CADENCE_TORRENT)	+= phy-cadence-torrent.o
> >  obj-$(CONFIG_PHY_CADENCE_DPHY)	+= cdns-dphy.o
> > +obj-$(CONFIG_PHY_CADENCE_DPHY_RX)	+= cdns-dphy-rx.o
> >  obj-$(CONFIG_PHY_CADENCE_SIERRA)	+= phy-cadence-sierra.o
> >  obj-$(CONFIG_PHY_CADENCE_SALVO)	+= phy-cadence-salvo.o
> > diff --git a/drivers/phy/cadence/cdns-dphy-rx.c b/drivers/phy/cadence/cdns-dphy-rx.c
> > new file mode 100644
> > index 000000000000..c9bb8c7f16f6
> > --- /dev/null
> > +++ b/drivers/phy/cadence/cdns-dphy-rx.c
> > @@ -0,0 +1,255 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> 
> GPL v2 and more...
> 
> > +/*
> > + * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
> 
> this should say 2022 as well
> 
> > +MODULE_AUTHOR("Pratyush Yadav <p.yadav@ti.com>");
> > +MODULE_DESCRIPTION("Cadence D-PHY Rx Driver");
> > +MODULE_LICENSE("GPL");
> 
> This means GPL v2 only and does not match SPDX tag, pls update

Will change SPDX to GPL-2.0-only.

> 
> -- 
> ~Vinod

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
