Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3505A6E27
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 22:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiH3UJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 16:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiH3UJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 16:09:46 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB07B75FF8;
        Tue, 30 Aug 2022 13:09:43 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27UK9NHi114191;
        Tue, 30 Aug 2022 15:09:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661890163;
        bh=MGaUNOMjOPEfn4vlyIIkJ5sPBMGzyhbOAMe1O0L6SHc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=tF4Jwr0+6fYb5w9JRGvr8E6vN2IIj4HOPBWuUyrTKIiQ7tfvvg2PBX2rqfNF/Tl3B
         2VSnL391o9QlLAxWKdf1+VXeUjbuYcpwIYneOTxfu0wMQmufDmN9Yb3JhXxPRQR8Ic
         KzBMD+Lx51xc/2UaazJ61z3GJP1DPFdQ4LUuviDc=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27UK9N7t033401
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Aug 2022 15:09:23 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 30
 Aug 2022 15:09:23 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 30 Aug 2022 15:09:23 -0500
Received: from ubuntu (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27UK9GZB122208;
        Tue, 30 Aug 2022 15:09:17 -0500
Date:   Tue, 30 Aug 2022 13:09:14 -0700
From:   Matt Ranostay <mranostay@ti.com>
To:     Lee Jones <lee@kernel.org>
CC:     <nm@ti.com>, <j-keerthy@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/6] MFD: TPS6594x: Add new PMIC device driver for
 TPS6594x chips
Message-ID: <Yw5t4G6hbn+mSD8y@ubuntu>
References: <20220812032242.564026-1-mranostay@ti.com>
 <20220812032242.564026-3-mranostay@ti.com>
 <YvX6sBMItZoAhLKe@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YvX6sBMItZoAhLKe@google.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 08:01:04AM +0100, Lee Jones wrote:
> On Thu, 11 Aug 2022, Matt Ranostay wrote:
> 
> > From: Keerthy <j-keerthy@ti.com>
> > 
> > The TPS6594x chip is a PMIC, and contains the following components:
> > 
> > - Regulators
> > - GPIO controller
> > - RTC
> > 
> > However initially only RTC is supported.
> > 
> > Signed-off-by: Keerthy <j-keerthy@ti.com>
> > Signed-off-by: Matt Ranostay <mranostay@ti.com>
> > ---
> >  drivers/mfd/Kconfig          |  14 ++++
> >  drivers/mfd/Makefile         |   1 +
> >  drivers/mfd/tps6594x.c       | 121 +++++++++++++++++++++++++++++++++++
> >  include/linux/mfd/tps6594x.h |  84 ++++++++++++++++++++++++
> >  4 files changed, 220 insertions(+)
> >  create mode 100644 drivers/mfd/tps6594x.c
> >  create mode 100644 include/linux/mfd/tps6594x.h
> > 
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index abb58ab1a1a4..4845683ae1d0 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -1547,6 +1547,20 @@ config MFD_TI_LP873X
> >  	  This driver can also be built as a module. If so, the module
> >  	  will be called lp873x.
> >  
> > +config MFD_TPS6594X
> > +	tristate "TI TPS6594X Power Management IC"
> > +	depends on I2C && OF
> > +	select MFD_CORE
> > +	select REGMAP_I2C
> > +	help
> > +	  If you say yes here then you get support for the TPS6594X series of
> > +	  Power Management Integrated Circuits (PMIC).
> > +	  These include voltage regulators, RTS, configurable
> > +	  General Purpose Outputs (GPO) that are used in portable devices.
> > +
> > +	  This driver can also be built as a module. If so, the module
> > +	  will be called tps6594x.
> > +
> >  config MFD_TI_LP87565
> >  	tristate "TI LP87565 Power Management IC"
> >  	depends on I2C && OF
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index 858cacf659d6..7ff6a8a57d55 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -105,6 +105,7 @@ obj-$(CONFIG_MFD_TPS65910)	+= tps65910.o
> >  obj-$(CONFIG_MFD_TPS65912)	+= tps65912-core.o
> >  obj-$(CONFIG_MFD_TPS65912_I2C)	+= tps65912-i2c.o
> >  obj-$(CONFIG_MFD_TPS65912_SPI)  += tps65912-spi.o
> > +obj-$(CONFIG_MFD_TPS6594X)	+= tps6594x.o
> >  obj-$(CONFIG_MENELAUS)		+= menelaus.o
> >  
> >  obj-$(CONFIG_TWL4030_CORE)	+= twl-core.o twl4030-irq.o twl6030-irq.o
> > diff --git a/drivers/mfd/tps6594x.c b/drivers/mfd/tps6594x.c
> > new file mode 100644
> > index 000000000000..ff265b91db3e
> > --- /dev/null
> > +++ b/drivers/mfd/tps6594x.c
> > @@ -0,0 +1,121 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Driver for tps6594x PMIC chips
> > + *
> > + * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
> > + * Author: Keerthy <j-keerthy@ti.com>
> > + */
> > +
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/mfd/core.h>
> > +#include <linux/mfd/tps6594x.h>
> > +#include <linux/module.h>
> > +#include <linux/i2c.h>
> > +#include <linux/regmap.h>
> > +
> > +static const struct regmap_config tps6594x_regmap_config = {
> > +	.reg_bits = 8,
> > +	.val_bits = 8,
> > +	.max_register = TPS6594X_REG_MAX,
> > +};
> > +
> > +static const struct mfd_cell tps6594x_cells[] = {
> > +	{ .name = "tps6594x-gpio" },
> > +	{ .name = "tps6594x-regulator" },
> > +	{ .name = "tps6594x-rtc" },
> > +};
> 
> Where are the device drivers for these?
>

They currently don't exist. Would these need to be merged/developed
before the acceptance of the mfd driver?

- Matt

> -- 
> Lee Jones [李琼斯]
