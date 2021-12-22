Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2DA347D379
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 15:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245636AbhLVOS2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Dec 2021 09:18:28 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:52999 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245605AbhLVOS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 09:18:27 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 77CBEE000D;
        Wed, 22 Dec 2021 14:18:24 +0000 (UTC)
Date:   Wed, 22 Dec 2021 15:18:23 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     krzysztof.kozlowski@canonical.com, tony@atomide.com,
        robh@kernel.org, kishon@ti.com, nm@ti.com, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/4] memory: omap-gpmc: Use a compatible match table
 when checking for NAND controller
Message-ID: <20211222151823.77179b74@xps13>
In-Reply-To: <51b8e895-95e1-0024-1457-ec534985c9f0@kernel.org>
References: <20211221131757.2030-1-rogerq@kernel.org>
        <20211221131757.2030-4-rogerq@kernel.org>
        <51b8e895-95e1-0024-1457-ec534985c9f0@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

rogerq@kernel.org wrote on Tue, 21 Dec 2021 22:01:28 +0200:

> Hi Miquel,
> 
> On 21/12/2021 15:17, Roger Quadros wrote:
> > As more compatibles can be added to the GPMC NAND controller driver
> > use a compatible match table.
> > 
> > Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> > Signed-off-by: Roger Quadros <rogerq@kernel.org>
> > ---
> >  drivers/memory/omap-gpmc.c                   | 6 +++++-
> >  drivers/mtd/nand/raw/omap2.c                 | 5 +----  
> 
> Will need your Ack for this one as well. Thanks :)
> 
> 
> >  include/linux/platform_data/mtd-nand-omap2.h | 9 ++++++++-
> >  3 files changed, 14 insertions(+), 6 deletions(-)  
> 
> cheers,
> -roger
> 
> > 
> > diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
> > index 624153048182..d19ffc895e5b 100644
> > --- a/drivers/memory/omap-gpmc.c
> > +++ b/drivers/memory/omap-gpmc.c
> > @@ -2091,6 +2091,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
> >  	u32 val;
> >  	struct gpio_desc *waitpin_desc = NULL;
> >  	struct gpmc_device *gpmc = platform_get_drvdata(pdev);
> > +	bool is_nand = false;
> >  
> >  	if (of_property_read_u32(child, "reg", &cs) < 0) {
> >  		dev_err(&pdev->dev, "%pOF has no 'reg' property\n",
> > @@ -2183,7 +2184,10 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
> >  		}
> >  	}
> >  
> > -	if (of_device_is_compatible(child, "ti,omap2-nand")) {
> > +	if (of_match_node(omap_nand_ids, child))
> > +		is_nand = true;
> > +
> > +	if (is_nand) {

nitpick: why this intermediate variable?

Otherwise for the NAND bits:

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

> >  		/* NAND specific setup */
> >  		val = 8;
> >  		of_property_read_u32(child, "nand-bus-width", &val);
> > diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
> > index b26d4947af02..e6dd8b4cf0d2 100644
> > --- a/drivers/mtd/nand/raw/omap2.c
> > +++ b/drivers/mtd/nand/raw/omap2.c
> > @@ -2352,10 +2352,7 @@ static int omap_nand_remove(struct platform_device *pdev)
> >  	return ret;
> >  }
> >  
> > -static const struct of_device_id omap_nand_ids[] = {
> > -	{ .compatible = "ti,omap2-nand", },
> > -	{},
> > -};
> > +/* omap_nand_ids defined in linux/platform_data/mtd-nand-omap2.h */
> >  MODULE_DEVICE_TABLE(of, omap_nand_ids);
> >  
> >  static struct platform_driver omap_nand_driver = {
> > diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/platform_data/mtd-nand-omap2.h
> > index de6ada739121..92f011805ad4 100644
> > --- a/include/linux/platform_data/mtd-nand-omap2.h
> > +++ b/include/linux/platform_data/mtd-nand-omap2.h
> > @@ -7,6 +7,7 @@
> >  #define	_MTD_NAND_OMAP2_H
> >  
> >  #include <linux/mtd/partitions.h>
> > +#include <linux/mod_devicetable.h>
> >  
> >  #define	GPMC_BCH_NUM_REMAINDER	8
> >  
> > @@ -61,4 +62,10 @@ struct gpmc_nand_regs {
> >  	void __iomem	*gpmc_bch_result5[GPMC_BCH_NUM_REMAINDER];
> >  	void __iomem	*gpmc_bch_result6[GPMC_BCH_NUM_REMAINDER];
> >  };
> > -#endif
> > +
> > +static const struct of_device_id omap_nand_ids[] = {
> > +	{ .compatible = "ti,omap2-nand", },
> > +	{},
> > +};
> > +
> > +#endif /* _MTD_NAND_OMAP2_H */
> >   


Thanks,
Miquèl
