Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2FD54FE6C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 22:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237702AbiFQUcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 16:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiFQUcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 16:32:48 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4599FFD;
        Fri, 17 Jun 2022 13:32:46 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id a2so8538806lfg.5;
        Fri, 17 Jun 2022 13:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Nt7BK1f6cRFHz6pLGJSxHQltGnG9CIf3ikjX+Fr4Z0c=;
        b=iZtZd6M+uTIfLBlp270F0Meh1CS3eDV5RHh0StqLHjHyXEXHs5Nppx1XK5u7JQFthi
         6bh8XC05k/qvhk0wG/MNjGl26sOHWSZkJT9r3viYgvtqFKocHdHcXjJs9YxmmEDKLk4N
         ckgItRtZ535KiqlH8Y6bqGMnl+H7fuUmybY/tSDexrXzIfK/gXy4EACP0okZ8LvyhqPL
         x2ejyKULTvtaEhQaVdw5eB8D+x6W67SKT4KOkQ7vgVywnkMVIQSF+27bHGi6Huah2KAk
         WfBK1m2EHbz576XCtxNaK0eyB1pB9OC5BSbPchGneuvh37HOPgnA19qJo50q6b0KHC0F
         w+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nt7BK1f6cRFHz6pLGJSxHQltGnG9CIf3ikjX+Fr4Z0c=;
        b=djYBwgIkRSXVB7Zx4ctToHH1hjhu1BODOVfDVw8iz8bqqvnnEAzHseevFsuhgQgB0y
         s6hD0AhuFkjpKCc4NiqVY5VjiNHyc+LujxZw1OvvxI+UY8kng9VxRonCxXWagwDaEvzj
         xFq/dnji3UtXZqEk/lIW/GbLA3ecgxaBi6GYlk/4JiOgP2sTNrsYI5IClg0FLT+gF4XF
         sHl1/kkGSC+vBBhH7CDt5vrAvmLtI74wpKGnn26cIX5EAHDliOVaI0fmmf7UDos6AKKe
         j3ZjqLxxN0kJlO9nxPsy9450HQDHXQOaqFZhKn4W6c+5h4m9Op995ckME79HTp49Zjcp
         aAGQ==
X-Gm-Message-State: AJIora+xRLvK1LG7/c2u06d2/4Dbr5PYbMgj3RhDa3WXuJ74fgH46Zp4
        oyJJp24iwBB3zSat131/9/U=
X-Google-Smtp-Source: AGRyM1vW2061WCMUWRb0OHVW1/LX+0Q11W4LRpcWpCFqKpxFHErX9s6W+TmseVwJHw2QzXUPIT2xog==
X-Received: by 2002:a05:6512:2623:b0:47d:ace7:c804 with SMTP id bt35-20020a056512262300b0047dace7c804mr6470255lfb.647.1655497964702;
        Fri, 17 Jun 2022 13:32:44 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id j10-20020a056512344a00b0047939239567sm752948lfr.240.2022.06.17.13.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 13:32:44 -0700 (PDT)
Date:   Fri, 17 Jun 2022 23:32:42 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 16/23] ata: ahci: Introduce firmware-specific caps
 initialization
Message-ID: <20220617203242.3ujyknllrx2frzmq@mobilestation>
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-17-Sergey.Semin@baikalelectronics.ru>
 <c1fa74f0-28d7-3394-6c43-5063c62db666@opensource.wdc.com>
 <20220615211134.2wxzizbpmfl2akjh@mobilestation>
 <eb65ccc8-1a59-5847-77c4-80420864eb17@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb65ccc8-1a59-5847-77c4-80420864eb17@opensource.wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 09:29:50AM +0900, Damien Le Moal wrote:
> On 2022/06/16 6:11, Serge Semin wrote:
> > On Tue, Jun 14, 2022 at 05:42:35PM +0900, Damien Le Moal wrote:
> >> On 6/10/22 17:17, Serge Semin wrote:
> >>> There are systems with no BIOS or comprehensive embedded firmware which
> >>> could be able to properly initialize the SATA AHCI controller
> >>> platform-specific capabilities. In that case a good alternative to having
> >>> a clever bootloader is to create a device tree node with the properties
> >>> well describing all the AHCI-related platform specifics. All the settings
> >>> which are normally detected and marked as available in the HBA and its
> >>> ports capabilities fields [1] could be defined in the platform DTB by
> >>> means of a set of the dedicated properties. Such approach perfectly fits
> >>> to the DTB-philosophy - to provide hardware/platform description.
> >>>
> >>> So here we suggest to extend the SATA AHCI device tree bindings with two
> >>> additional DT-properties:
> >>> 1) "hba-cap" - HBA platform generic capabilities like:
> >>>    - SSS - Staggered Spin-up support.
> >>>    - SMPS - Mechanical Presence Switch support.
> >>> 2) "hba-port-cap" - HBA platform port capabilities like:
> >>>    - HPCP - Hot Plug Capable Port.
> >>>    - MPSP - Mechanical Presence Switch Attached to Port.
> >>>    - CPD - Cold Presence Detection.
> >>>    - ESP - External SATA Port.
> >>>    - FBSCP - FIS-based Switching Capable Port.
> >>> All of these capabilities require to have a corresponding hardware
> >>> configuration. Thus it's ok to have them defined in DTB.
> >>>
> >>> Even though the driver currently takes into account the state of the ESP
> >>> and FBSCP flags state only, there is nothing wrong with having all of them
> >>> supported by the generic AHCI library in order to have a complete OF-based
> >>> platform-capabilities initialization procedure. These properties will be
> >>> parsed in the ahci_platform_get_resources() method and their values will
> >>> be stored in the saved_* fields of the ahci_host_priv structure, which in
> >>> its turn then will be used to restore the H.CAP, H.PI and P#.CMD
> >>> capability fields on device init and after HBA reset.
> >>>
> >>> Please note this modification concerns the HW-init HBA and its ports flags
> >>> only, which are by specification [1] are supposed to be initialized by the
> >>> BIOS/platform firmware/expansion ROM and which are normally declared in
> >>> the one-time-writable-after-reset register fields. Even though these flags
> >>> aren't supposed to be cleared after HBA reset some AHCI instances may
> >>> violate that rule so we still need to perform the fields resetting after
> >>> each reset. Luckily the corresponding functionality has already been
> >>> partly implemented in the framework of the ahci_save_initial_config() and
> >>> ahci_restore_initial_config() methods.
> >>>
> >>> [1] Serial ATA AHCI 1.3.1 Specification, p. 103
> >>>
> >>> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> >>>
> >>> ---
> >>>
> >>> Changelog v4:
> >>> - Convert the boolean properties to the bitfield DT-properties. (@Rob)
> >>> ---
> >>>  drivers/ata/ahci.h             |  1 +
> >>>  drivers/ata/libahci.c          | 51 ++++++++++++++++++++++++++++------
> >>>  drivers/ata/libahci_platform.c | 41 +++++++++++++++++++++++++--
> >>>  3 files changed, 82 insertions(+), 11 deletions(-)
> >>>
> >>> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> >>> index 8b9826533ae5..0de221055961 100644
> >>> --- a/drivers/ata/ahci.h
> >>> +++ b/drivers/ata/ahci.h
> >>> @@ -337,6 +337,7 @@ struct ahci_host_priv {
> >>>  	u32			saved_cap;	/* saved initial cap */
> >>>  	u32			saved_cap2;	/* saved initial cap2 */
> >>>  	u32			saved_port_map;	/* saved initial port_map */
> >>> +	u32			saved_port_cap[AHCI_MAX_PORTS]; /* saved port_cap */
> >>>  	u32 			em_loc; /* enclosure management location */
> >>>  	u32			em_buf_sz;	/* EM buffer size in byte */
> >>>  	u32			em_msg_type;	/* EM message type */
> >>> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> >>> index 1ffaa5f5f21a..954386a2b500 100644
> >>> --- a/drivers/ata/libahci.c
> >>> +++ b/drivers/ata/libahci.c
> >>> @@ -16,6 +16,7 @@
> >>>   * http://www.intel.com/technology/serialata/pdf/rev1_1.pdf
> >>>   */
> >>>  
> >>> +#include <linux/bitops.h>
> >>>  #include <linux/kernel.h>
> >>>  #include <linux/gfp.h>
> >>>  #include <linux/module.h>
> >>> @@ -443,16 +444,28 @@ static ssize_t ahci_show_em_supported(struct device *dev,
> >>>  void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
> >>>  {
> >>>  	void __iomem *mmio = hpriv->mmio;
> >>> -	u32 cap, cap2, vers, port_map;
> >>> +	void __iomem *port_mmio;
> >>> +	unsigned long port_map;
> >>> +	u32 cap, cap2, vers;
> >>>  	int i;
> >>>  
> >>>  	/* make sure AHCI mode is enabled before accessing CAP */
> >>>  	ahci_enable_ahci(mmio);
> >>>  
> >>> -	/* Values prefixed with saved_ are written back to host after
> >>> -	 * reset.  Values without are used for driver operation.
> >>> +	/*
> >>> +	 * Values prefixed with saved_ are written back to the HBA and ports
> >>> +	 * registers after reset. Values without are used for driver operation.
> >>> +	 */
> >>> +
> >>> +	/*
> >>> +	 * Override HW-init HBA capability fields with the platform-specific
> >>> +	 * values. The rest of the HBA capabilities are defined as Read-only
> >>> +	 * and can't be modified in CSR anyway.
> >>>  	 */
> >>> -	hpriv->saved_cap = cap = readl(mmio + HOST_CAP);
> >>> +	cap = readl(mmio + HOST_CAP);
> >>> +	if (hpriv->saved_cap)
> >>> +		cap = (cap & ~(HOST_CAP_SSS | HOST_CAP_MPS)) | hpriv->saved_cap;
> >>> +	hpriv->saved_cap = cap;
> >>>  
> >>>  	/* CAP2 register is only defined for AHCI 1.2 and later */
> >>>  	vers = readl(mmio + HOST_VERSION);
> >>> @@ -519,7 +532,7 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
> >>>  	/* Override the HBA ports mapping if the platform needs it */
> >>>  	port_map = readl(mmio + HOST_PORTS_IMPL);
> >>>  	if (hpriv->saved_port_map && port_map != hpriv->saved_port_map) {
> >>> -		dev_info(dev, "forcing port_map 0x%x -> 0x%x\n",
> >>> +		dev_info(dev, "forcing port_map 0x%lx -> 0x%x\n",
> >>
> > 
> >> This change is not necessary.
> > 
> > It is. The port_map type has been changed.
> 
> Ignore. When I read the patches the other day, the mailer font had that "l" look
> like a "1" :) My mistake.

Ok.)

-Sergey

> 
> > 
> >>
> >>>  			 port_map, hpriv->saved_port_map);
> >>>  		port_map = hpriv->saved_port_map;
> >>>  	} else {
> >>> @@ -527,7 +540,7 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
> >>>  	}
> >>>  
> >>>  	if (hpriv->mask_port_map) {
> >>> -		dev_warn(dev, "masking port_map 0x%x -> 0x%x\n",
> >>> +		dev_warn(dev, "masking port_map 0x%lx -> 0x%lx\n",
> >>
> >> Same.
> > 
> > ditto
> > 
> >>
> >>>  			port_map,
> >>>  			port_map & hpriv->mask_port_map);
> >>>  		port_map &= hpriv->mask_port_map;
> >>> @@ -546,7 +559,7 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
> >>>  		 */
> >>>  		if (map_ports > ahci_nr_ports(cap)) {
> >>>  			dev_warn(dev,
> >>> -				 "implemented port map (0x%x) contains more ports than nr_ports (%u), using nr_ports\n",
> >>> +				 "implemented port map (0x%lx) contains more ports than nr_ports (%u), using nr_ports\n",
> >>
> >> Same.
> > 
> > ditto.
> > 
> >>
> >>>  				 port_map, ahci_nr_ports(cap));
> >>>  			port_map = 0;
> >>>  		}
> >>> @@ -555,12 +568,26 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
> >>>  	/* fabricate port_map from cap.nr_ports for < AHCI 1.3 */
> >>>  	if (!port_map && vers < 0x10300) {
> >>>  		port_map = (1 << ahci_nr_ports(cap)) - 1;
> >>> -		dev_warn(dev, "forcing PORTS_IMPL to 0x%x\n", port_map);
> >>> +		dev_warn(dev, "forcing PORTS_IMPL to 0x%lx\n", port_map);
> >>
> >> And again not needed.
> > 
> > and ditto.
> > 
> >>
> >>>  
> >>>  		/* write the fixed up value to the PI register */
> >>>  		hpriv->saved_port_map = port_map;
> >>>  	}
> >>>  
> >>> +	/*
> >>> +	 * Preserve the ports capabilities defined by the platform. Note there
> >>> +	 * is no need in storing the rest of the P#.CMD fields since they are
> >>> +	 * volatile.
> >>> +	 */
> >>> +	for_each_set_bit(i, &port_map, AHCI_MAX_PORTS) {
> >>> +		if (hpriv->saved_port_cap[i])
> >>> +			continue;
> >>> +
> >>> +		port_mmio = __ahci_port_base(hpriv, i);
> >>> +		hpriv->saved_port_cap[i] =
> >>> +			readl(port_mmio + PORT_CMD) & PORT_CMD_CAP;
> >>> +	}
> >>> +
> >>>  	/* record values to use during operation */
> >>>  	hpriv->cap = cap;
> >>>  	hpriv->cap2 = cap2;
> >>> @@ -590,13 +617,21 @@ EXPORT_SYMBOL_GPL(ahci_save_initial_config);
> >>>  static void ahci_restore_initial_config(struct ata_host *host)
> >>>  {
> >>>  	struct ahci_host_priv *hpriv = host->private_data;
> >>> +	unsigned long port_map = hpriv->port_map;
> >>>  	void __iomem *mmio = hpriv->mmio;
> >>> +	void __iomem *port_mmio;
> >>> +	int i;
> >>>  
> >>>  	writel(hpriv->saved_cap, mmio + HOST_CAP);
> >>>  	if (hpriv->saved_cap2)
> >>>  		writel(hpriv->saved_cap2, mmio + HOST_CAP2);
> >>>  	writel(hpriv->saved_port_map, mmio + HOST_PORTS_IMPL);
> >>>  	(void) readl(mmio + HOST_PORTS_IMPL);	/* flush */
> >>> +
> >>> +	for_each_set_bit(i, &port_map, AHCI_MAX_PORTS) {
> >>> +		port_mmio = __ahci_port_base(hpriv, i);
> >>> +		writel(hpriv->saved_port_cap[i], port_mmio + PORT_CMD);
> >>> +	}
> >>>  }
> >>>  
> >>>  static unsigned ahci_scr_offset(struct ata_port *ap, unsigned int sc_reg)
> >>> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> >>> index efe640603f3f..8b542a8bc487 100644
> >>> --- a/drivers/ata/libahci_platform.c
> >>> +++ b/drivers/ata/libahci_platform.c
> >>> @@ -23,6 +23,7 @@
> >>>  #include <linux/pm_runtime.h>
> >>>  #include <linux/of_platform.h>
> >>>  #include <linux/reset.h>
> >>> +
> >>
> >> white line change.
> > 
> > Ok. I'll drop it.
> > 
> > -Sergey
> > 
> >>
> >>>  #include "ahci.h"
> >>>  
> >>>  static void ahci_host_stop(struct ata_host *host);
> >>> @@ -383,6 +384,34 @@ static int ahci_platform_get_regulator(struct ahci_host_priv *hpriv, u32 port,
> >>>  	return rc;
> >>>  }
> >>>  
> >>> +static int ahci_platform_get_firmware(struct ahci_host_priv *hpriv,
> >>> +				      struct device *dev)
> >>> +{
> >>> +	struct device_node *child;
> >>> +	u32 port;
> >>> +
> >>> +	if (!of_property_read_u32(dev->of_node, "hba-cap", &hpriv->saved_cap))
> >>> +		hpriv->saved_cap &= (HOST_CAP_SSS | HOST_CAP_MPS);
> >>> +
> >>> +	of_property_read_u32(dev->of_node,
> >>> +			     "ports-implemented", &hpriv->saved_port_map);
> >>> +
> >>> +	for_each_child_of_node(dev->of_node, child) {
> >>> +		if (!of_device_is_available(child))
> >>> +			continue;
> >>> +
> >>> +		if (of_property_read_u32(child, "reg", &port)) {
> >>> +			of_node_put(child);
> >>> +			return -EINVAL;
> >>> +		}
> >>> +
> >>> +		if (!of_property_read_u32(child, "hba-port-cap", &hpriv->saved_port_cap[port]))
> >>> +			hpriv->saved_port_cap[port] &= PORT_CMD_CAP;
> >>> +	}
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>>  /**
> >>>   * ahci_platform_get_resources - Get platform resources
> >>>   * @pdev: platform device to get resources for
> >>> @@ -523,9 +552,6 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
> >>>  		goto err_out;
> >>>  	}
> >>>  
> >>> -	of_property_read_u32(dev->of_node,
> >>> -			     "ports-implemented", &hpriv->saved_port_map);
> >>> -
> >>>  	if (child_nodes) {
> >>>  		for_each_child_of_node(dev->of_node, child) {
> >>>  			u32 port;
> >>> @@ -590,6 +616,15 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
> >>>  		if (rc == -EPROBE_DEFER)
> >>>  			goto err_out;
> >>>  	}
> >>> +
> >>> +	/*
> >>> +	 * Retrieve firmware-specific flags which then will be used to set
> >>> +	 * the HW-init fields of HBA and its ports
> >>> +	 */
> >>> +	rc = ahci_platform_get_firmware(hpriv, dev);
> >>> +	if (rc)
> >>> +		goto err_out;
> >>> +
> >>>  	pm_runtime_enable(dev);
> >>>  	pm_runtime_get_sync(dev);
> >>>  	hpriv->got_runtime_pm = true;
> >>
> >>
> >> -- 
> >> Damien Le Moal
> >> Western Digital Research
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
