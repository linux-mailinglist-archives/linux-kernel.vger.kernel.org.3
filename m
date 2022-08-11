Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966AF58F814
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 09:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbiHKHEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 03:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbiHKHEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 03:04:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F16D8E46D;
        Thu, 11 Aug 2022 00:04:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D32BFB81E64;
        Thu, 11 Aug 2022 07:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E536C433D7;
        Thu, 11 Aug 2022 07:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660201446;
        bh=AWD+WzG6o59UvcaXDCSkza+A97hytU18bS1We99ZWzY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U1MURVKJSA7UJ46YuGa6Qhfi2xegJLqFwrhlEbKkGDQ6dxAI0bO+FthpCpAFJL8rA
         JPQIUNqKn4fBOyON3eIo43+ngv1zlETG9R6OoFVN8WG2yC5zHbpUdCzSnPzeHKdl1A
         oBGf8eUU8iu7WgSjara1hPCxCIzxHXIPLkYjUwv0NozNhPLwdoHtCtvvhtuVHCbP8c
         ZG7cxQ5x5c8Wd+ZjWDMoJGNmLorg2Bt8Lep4Kvu5pa6mSxNbuA2ghnsghYuOZjjOc8
         mlOsLvh+zlVIrE9t6ogSSxD6uRzrcFJBoORrMdzAbTyL3lfDUmZA8EM3X8JPL3lpTP
         UFynQiPi5gWuA==
Date:   Thu, 11 Aug 2022 08:04:01 +0100
From:   Lee Jones <lee@kernel.org>
To:     Matt Ranostay <mranostay@ti.com>
Cc:     nm@ti.com, linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH 2/4] MFD: TPS6594x: Add new mfd device for TPS6594x PMIC
Message-ID: <YvSp4TOgRhoet1eY@google.com>
References: <20220805064352.793918-1-mranostay@ti.com>
 <20220805064352.793918-3-mranostay@ti.com>
 <YvOWHccZQ0RMkHiD@google.com>
 <YvSiuElc/LM5g7hl@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YvSiuElc/LM5g7hl@ubuntu>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2022, Matt Ranostay wrote:

> On Wed, Aug 10, 2022 at 12:27:25PM +0100, Lee Jones wrote:
> > On Thu, 04 Aug 2022, Matt Ranostay wrote:
> > 
> > > From: Keerthy <j-keerthy@ti.com>
> > > 
> > > The TPS6594x chip is a PMIC, and contains the following components:
> > > 
> > > - Regulators
> > > - GPIO controller
> > > - RTC
> > > 
> > > However initially only RTC is supported.
> > > 
> > > Signed-off-by: Keerthy <j-keerthy@ti.com>
> > > Signed-off-by: Matt Ranostay <mranostay@ti.com>
> > > ---
> > >  drivers/mfd/Kconfig          |  14 +++++
> > >  drivers/mfd/Makefile         |   1 +
> > >  drivers/mfd/tps6594x.c       | 106 +++++++++++++++++++++++++++++++++++
> > >  include/linux/mfd/tps6594x.h |  66 ++++++++++++++++++++++
> > >  4 files changed, 187 insertions(+)
> > >  create mode 100644 drivers/mfd/tps6594x.c
> > >  create mode 100644 include/linux/mfd/tps6594x.h
> > > 
> > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > index abb58ab1a1a4..cfb5b3d66b76 100644
> > > --- a/drivers/mfd/Kconfig
> > > +++ b/drivers/mfd/Kconfig
> > > @@ -1547,6 +1547,20 @@ config MFD_TI_LP873X
> > >  	  This driver can also be built as a module. If so, the module
> > >  	  will be called lp873x.
> > >  
> > > +config MFD_TPS6594X
> > > +	tristate "TI TPS6594X Power Management IC"
> > > +	depends on I2C
> > > +	select MFD_CORE
> > > +	select REGMAP_I2C
> > > +	help
> > > +	  If you say yes here then you get support for the TPS6594X series of
> > > +	  Power Management Integrated Circuits (PMIC).
> > > +	  These include voltage regulators, RTS, configurable
> > > +	  General Purpose Outputs (GPO) that are used in portable devices.
> > > +
> > > +	  This driver can also be built as a module. If so, the module
> > > +	  will be called tps7694x.
> > > +
> > >  config MFD_TI_LP87565
> > >  	tristate "TI LP87565 Power Management IC"
> > >  	depends on I2C && OF
> > > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > > index 858cacf659d6..7ff6a8a57d55 100644
> > > --- a/drivers/mfd/Makefile
> > > +++ b/drivers/mfd/Makefile
> > > @@ -105,6 +105,7 @@ obj-$(CONFIG_MFD_TPS65910)	+= tps65910.o
> > >  obj-$(CONFIG_MFD_TPS65912)	+= tps65912-core.o
> > >  obj-$(CONFIG_MFD_TPS65912_I2C)	+= tps65912-i2c.o
> > >  obj-$(CONFIG_MFD_TPS65912_SPI)  += tps65912-spi.o
> > > +obj-$(CONFIG_MFD_TPS6594X)	+= tps6594x.o
> > >  obj-$(CONFIG_MENELAUS)		+= menelaus.o
> > >  
> > >  obj-$(CONFIG_TWL4030_CORE)	+= twl-core.o twl4030-irq.o twl6030-irq.o
> > > diff --git a/drivers/mfd/tps6594x.c b/drivers/mfd/tps6594x.c
> > > new file mode 100644
> > > index 000000000000..519162cc1fbe
> > > --- /dev/null
> > > +++ b/drivers/mfd/tps6594x.c
> > > @@ -0,0 +1,106 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +/*
> > > + * tps6594x.c  --  TI TPS6594x chip family multi-function driver
> > 
> > No filenames in comments please.
> > 
> > Also, there are too many spaces around the '--'.
> > 
> > It's not a "multi-function driver" it's a PMIC Core driver.
> >
> 
> Noted. Will change to PMIC core driver to be more concise.
> 
> > > + * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
> > > + *
> > > + * Author: Keerthy <j-keerthy@ti.com>
> > > + */
> > > +
> > > +#include <linux/interrupt.h>
> > > +#include <linux/mfd/core.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/regmap.h>
> > 
> > Alphabetical.
> > 
> > > +#include <linux/mfd/tps6594x.h>
> > > +
> > > +static const struct regmap_config tps6594x_regmap_config = {
> > > +	.reg_bits = 8,
> > > +	.val_bits = 8,
> > > +	.max_register = TPS6594X_REG_MAX,
> > > +};
> > > +
> > > +static const struct mfd_cell tps6594x_cells[] = {
> > > +	{ .name = "tps6594x-rtc", },
> > > +};
> > 
> > Where are the rest of the devices?
> > 
> > This is not an MFD with only one device.
> 
> There are other devices, however there isn't any drivers currently for them
> just the RTC. Should there be placeholders for the gpio, and regulators even
> if support currently doesn't exist.

If support doesn't exist for the other devices, just submit an
independent RTC driver.

-- 
Lee Jones [李琼斯]
