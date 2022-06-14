Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330FF54AC30
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242551AbiFNIoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240797AbiFNIm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:42:59 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6124043AD6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 01:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655196166; x=1686732166;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=seQXUC2yFSK+xh+rRJdR/W+Fvg3IkeD6jADS01tkxBo=;
  b=Aw6EmerpDq8N4764yzJfE6byQP6tokzz/qNNMM2tZYFs6/Ne/MVxmB38
   WizpzZ6YnWkUmu8DNU9ofO231YcecNtS8QS4lz7HWVSdMJ43q4qlGPnJ1
   9+nd85sYA5LFFoKQ0lUI43+IKJgWujA8gDY99mq3QIbh+fcGdOpSin5fA
   o7Vaoa75XpUcwJENKzF5phA0oHW5xQE5MwQa3FAYFrXDAVwW+6494KlUZ
   hoCd7ZCeUwxKe6rjExdBHK4RorRDJVimHH00FMq5TyDWhPcpkdB5pUkFx
   5QEMMC5cPUA5US+pk0Qm3lFNLl2l7gYE7rBu0r/Sqtd4b217e1tHhST9z
   A==;
X-IronPort-AV: E=Sophos;i="5.91,299,1647273600"; 
   d="scan'208";a="203866928"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2022 16:42:41 +0800
IronPort-SDR: 7ulnaurNeiFWhGw5yggojWPaISW04LZsAVEAmcjzcB6fEYM8sfSrqoI7DBj3VXPAvJX2YOQ1wL
 NMAy4X7NrNzrD9YQTmHhlf+tplgacc7Wn2ODvYkJHv/gtUSfI5KNOKSpda2Lfvrx74i82107NV
 SIfc9HMSv2ftCNARmmhVWNZgwEhJCZF+9t8U0vxLxMAyfiZraf5B0URzTg0lpLc0Vm/NRw6m/a
 AYo23nSJ8fdjLgk2nmI5zDcY2kHW5D9qGXTa32u7Vk8e+K83OxHNeu+WeveBCFGyPZTWEFZMkV
 Pr8gE+xFoLxembog3Gnp1FZi
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2022 01:01:15 -0700
IronPort-SDR: 45V8u0XIPjG1mpSysajukr66pBajQeWRvnBYWdXfntONoesul7gqX8Y19f7OoSJGV1XYpDIK54
 R1m1xe1zWc5+b8gbFbCq7Ds/niD+JMSocrb2KBTcSDWbDH5J8KkTmV2DF+FFTomi05RE++3TOC
 QRSFhyesUeyM+2qgUyvSChfD51A8WF3lCepx9iLdVrnm8ExnQIU2D7ffAr0/f9mkWtmLyPDGyJ
 Urg3nhOjET+Hp2qR0/EL80/Bcmp+67xQF2eBVxsLgbcfV3ePrkzo+yzkI5cG2cz7mH8pe2hs+O
 koM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2022 01:42:41 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LMhlN0FHQz1SVp3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 01:42:40 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655196158; x=1657788159; bh=seQXUC2yFSK+xh+rRJdR/W+Fvg3IkeD6jAD
        S01tkxBo=; b=fXeWgrUCqZ+21sntn8IVdwzSKG/Nyml6ACmLw3g+9ilN5+XUUuo
        v3LFhvOMOwTvUd6pKb1mwVFGNYH83Nz63JTrwbeks2iXFX4sJcOapLOy/MMSRVY5
        JrVcl0SQItFUJc1bXxCZjtnd6MwVAntB3rkv+TamljEUZ9RPp3gw/iIl5n+QLluc
        +hF+3fcgECgoVlpwgjkQi50Sp+l2ysrcFXBHHB/zYgeaGvyluEI7HuIYWMJ3A3ez
        wA2WrPWmVAyGqwaaTOTlRdN3vgJUpOwWxLe0ewvhRwFc7l5q9gP9SrO4BFabeWOy
        KV6IHEG94q5p2fpDabloMpWNvkiHrrvs5EA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fszDTe5wI-Q3 for <linux-kernel@vger.kernel.org>;
        Tue, 14 Jun 2022 01:42:38 -0700 (PDT)
Received: from [10.225.163.77] (unknown [10.225.163.77])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LMhlJ1qJKz1Rvlc;
        Tue, 14 Jun 2022 01:42:36 -0700 (PDT)
Message-ID: <c1fa74f0-28d7-3394-6c43-5063c62db666@opensource.wdc.com>
Date:   Tue, 14 Jun 2022 17:42:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 16/23] ata: ahci: Introduce firmware-specific caps
 initialization
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-17-Sergey.Semin@baikalelectronics.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220610081801.11854-17-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/22 17:17, Serge Semin wrote:
> There are systems with no BIOS or comprehensive embedded firmware which
> could be able to properly initialize the SATA AHCI controller
> platform-specific capabilities. In that case a good alternative to having
> a clever bootloader is to create a device tree node with the properties
> well describing all the AHCI-related platform specifics. All the settings
> which are normally detected and marked as available in the HBA and its
> ports capabilities fields [1] could be defined in the platform DTB by
> means of a set of the dedicated properties. Such approach perfectly fits
> to the DTB-philosophy - to provide hardware/platform description.
> 
> So here we suggest to extend the SATA AHCI device tree bindings with two
> additional DT-properties:
> 1) "hba-cap" - HBA platform generic capabilities like:
>    - SSS - Staggered Spin-up support.
>    - SMPS - Mechanical Presence Switch support.
> 2) "hba-port-cap" - HBA platform port capabilities like:
>    - HPCP - Hot Plug Capable Port.
>    - MPSP - Mechanical Presence Switch Attached to Port.
>    - CPD - Cold Presence Detection.
>    - ESP - External SATA Port.
>    - FBSCP - FIS-based Switching Capable Port.
> All of these capabilities require to have a corresponding hardware
> configuration. Thus it's ok to have them defined in DTB.
> 
> Even though the driver currently takes into account the state of the ESP
> and FBSCP flags state only, there is nothing wrong with having all of them
> supported by the generic AHCI library in order to have a complete OF-based
> platform-capabilities initialization procedure. These properties will be
> parsed in the ahci_platform_get_resources() method and their values will
> be stored in the saved_* fields of the ahci_host_priv structure, which in
> its turn then will be used to restore the H.CAP, H.PI and P#.CMD
> capability fields on device init and after HBA reset.
> 
> Please note this modification concerns the HW-init HBA and its ports flags
> only, which are by specification [1] are supposed to be initialized by the
> BIOS/platform firmware/expansion ROM and which are normally declared in
> the one-time-writable-after-reset register fields. Even though these flags
> aren't supposed to be cleared after HBA reset some AHCI instances may
> violate that rule so we still need to perform the fields resetting after
> each reset. Luckily the corresponding functionality has already been
> partly implemented in the framework of the ahci_save_initial_config() and
> ahci_restore_initial_config() methods.
> 
> [1] Serial ATA AHCI 1.3.1 Specification, p. 103
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v4:
> - Convert the boolean properties to the bitfield DT-properties. (@Rob)
> ---
>  drivers/ata/ahci.h             |  1 +
>  drivers/ata/libahci.c          | 51 ++++++++++++++++++++++++++++------
>  drivers/ata/libahci_platform.c | 41 +++++++++++++++++++++++++--
>  3 files changed, 82 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index 8b9826533ae5..0de221055961 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -337,6 +337,7 @@ struct ahci_host_priv {
>  	u32			saved_cap;	/* saved initial cap */
>  	u32			saved_cap2;	/* saved initial cap2 */
>  	u32			saved_port_map;	/* saved initial port_map */
> +	u32			saved_port_cap[AHCI_MAX_PORTS]; /* saved port_cap */
>  	u32 			em_loc; /* enclosure management location */
>  	u32			em_buf_sz;	/* EM buffer size in byte */
>  	u32			em_msg_type;	/* EM message type */
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 1ffaa5f5f21a..954386a2b500 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -16,6 +16,7 @@
>   * http://www.intel.com/technology/serialata/pdf/rev1_1.pdf
>   */
>  
> +#include <linux/bitops.h>
>  #include <linux/kernel.h>
>  #include <linux/gfp.h>
>  #include <linux/module.h>
> @@ -443,16 +444,28 @@ static ssize_t ahci_show_em_supported(struct device *dev,
>  void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
>  {
>  	void __iomem *mmio = hpriv->mmio;
> -	u32 cap, cap2, vers, port_map;
> +	void __iomem *port_mmio;
> +	unsigned long port_map;
> +	u32 cap, cap2, vers;
>  	int i;
>  
>  	/* make sure AHCI mode is enabled before accessing CAP */
>  	ahci_enable_ahci(mmio);
>  
> -	/* Values prefixed with saved_ are written back to host after
> -	 * reset.  Values without are used for driver operation.
> +	/*
> +	 * Values prefixed with saved_ are written back to the HBA and ports
> +	 * registers after reset. Values without are used for driver operation.
> +	 */
> +
> +	/*
> +	 * Override HW-init HBA capability fields with the platform-specific
> +	 * values. The rest of the HBA capabilities are defined as Read-only
> +	 * and can't be modified in CSR anyway.
>  	 */
> -	hpriv->saved_cap = cap = readl(mmio + HOST_CAP);
> +	cap = readl(mmio + HOST_CAP);
> +	if (hpriv->saved_cap)
> +		cap = (cap & ~(HOST_CAP_SSS | HOST_CAP_MPS)) | hpriv->saved_cap;
> +	hpriv->saved_cap = cap;
>  
>  	/* CAP2 register is only defined for AHCI 1.2 and later */
>  	vers = readl(mmio + HOST_VERSION);
> @@ -519,7 +532,7 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
>  	/* Override the HBA ports mapping if the platform needs it */
>  	port_map = readl(mmio + HOST_PORTS_IMPL);
>  	if (hpriv->saved_port_map && port_map != hpriv->saved_port_map) {
> -		dev_info(dev, "forcing port_map 0x%x -> 0x%x\n",
> +		dev_info(dev, "forcing port_map 0x%lx -> 0x%x\n",

This change is not necessary.

>  			 port_map, hpriv->saved_port_map);
>  		port_map = hpriv->saved_port_map;
>  	} else {
> @@ -527,7 +540,7 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
>  	}
>  
>  	if (hpriv->mask_port_map) {
> -		dev_warn(dev, "masking port_map 0x%x -> 0x%x\n",
> +		dev_warn(dev, "masking port_map 0x%lx -> 0x%lx\n",

Same.

>  			port_map,
>  			port_map & hpriv->mask_port_map);
>  		port_map &= hpriv->mask_port_map;
> @@ -546,7 +559,7 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
>  		 */
>  		if (map_ports > ahci_nr_ports(cap)) {
>  			dev_warn(dev,
> -				 "implemented port map (0x%x) contains more ports than nr_ports (%u), using nr_ports\n",
> +				 "implemented port map (0x%lx) contains more ports than nr_ports (%u), using nr_ports\n",

Same.

>  				 port_map, ahci_nr_ports(cap));
>  			port_map = 0;
>  		}
> @@ -555,12 +568,26 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
>  	/* fabricate port_map from cap.nr_ports for < AHCI 1.3 */
>  	if (!port_map && vers < 0x10300) {
>  		port_map = (1 << ahci_nr_ports(cap)) - 1;
> -		dev_warn(dev, "forcing PORTS_IMPL to 0x%x\n", port_map);
> +		dev_warn(dev, "forcing PORTS_IMPL to 0x%lx\n", port_map);

And again not needed.

>  
>  		/* write the fixed up value to the PI register */
>  		hpriv->saved_port_map = port_map;
>  	}
>  
> +	/*
> +	 * Preserve the ports capabilities defined by the platform. Note there
> +	 * is no need in storing the rest of the P#.CMD fields since they are
> +	 * volatile.
> +	 */
> +	for_each_set_bit(i, &port_map, AHCI_MAX_PORTS) {
> +		if (hpriv->saved_port_cap[i])
> +			continue;
> +
> +		port_mmio = __ahci_port_base(hpriv, i);
> +		hpriv->saved_port_cap[i] =
> +			readl(port_mmio + PORT_CMD) & PORT_CMD_CAP;
> +	}
> +
>  	/* record values to use during operation */
>  	hpriv->cap = cap;
>  	hpriv->cap2 = cap2;
> @@ -590,13 +617,21 @@ EXPORT_SYMBOL_GPL(ahci_save_initial_config);
>  static void ahci_restore_initial_config(struct ata_host *host)
>  {
>  	struct ahci_host_priv *hpriv = host->private_data;
> +	unsigned long port_map = hpriv->port_map;
>  	void __iomem *mmio = hpriv->mmio;
> +	void __iomem *port_mmio;
> +	int i;
>  
>  	writel(hpriv->saved_cap, mmio + HOST_CAP);
>  	if (hpriv->saved_cap2)
>  		writel(hpriv->saved_cap2, mmio + HOST_CAP2);
>  	writel(hpriv->saved_port_map, mmio + HOST_PORTS_IMPL);
>  	(void) readl(mmio + HOST_PORTS_IMPL);	/* flush */
> +
> +	for_each_set_bit(i, &port_map, AHCI_MAX_PORTS) {
> +		port_mmio = __ahci_port_base(hpriv, i);
> +		writel(hpriv->saved_port_cap[i], port_mmio + PORT_CMD);
> +	}
>  }
>  
>  static unsigned ahci_scr_offset(struct ata_port *ap, unsigned int sc_reg)
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index efe640603f3f..8b542a8bc487 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -23,6 +23,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/of_platform.h>
>  #include <linux/reset.h>
> +

white line change.

>  #include "ahci.h"
>  
>  static void ahci_host_stop(struct ata_host *host);
> @@ -383,6 +384,34 @@ static int ahci_platform_get_regulator(struct ahci_host_priv *hpriv, u32 port,
>  	return rc;
>  }
>  
> +static int ahci_platform_get_firmware(struct ahci_host_priv *hpriv,
> +				      struct device *dev)
> +{
> +	struct device_node *child;
> +	u32 port;
> +
> +	if (!of_property_read_u32(dev->of_node, "hba-cap", &hpriv->saved_cap))
> +		hpriv->saved_cap &= (HOST_CAP_SSS | HOST_CAP_MPS);
> +
> +	of_property_read_u32(dev->of_node,
> +			     "ports-implemented", &hpriv->saved_port_map);
> +
> +	for_each_child_of_node(dev->of_node, child) {
> +		if (!of_device_is_available(child))
> +			continue;
> +
> +		if (of_property_read_u32(child, "reg", &port)) {
> +			of_node_put(child);
> +			return -EINVAL;
> +		}
> +
> +		if (!of_property_read_u32(child, "hba-port-cap", &hpriv->saved_port_cap[port]))
> +			hpriv->saved_port_cap[port] &= PORT_CMD_CAP;
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * ahci_platform_get_resources - Get platform resources
>   * @pdev: platform device to get resources for
> @@ -523,9 +552,6 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>  		goto err_out;
>  	}
>  
> -	of_property_read_u32(dev->of_node,
> -			     "ports-implemented", &hpriv->saved_port_map);
> -
>  	if (child_nodes) {
>  		for_each_child_of_node(dev->of_node, child) {
>  			u32 port;
> @@ -590,6 +616,15 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>  		if (rc == -EPROBE_DEFER)
>  			goto err_out;
>  	}
> +
> +	/*
> +	 * Retrieve firmware-specific flags which then will be used to set
> +	 * the HW-init fields of HBA and its ports
> +	 */
> +	rc = ahci_platform_get_firmware(hpriv, dev);
> +	if (rc)
> +		goto err_out;
> +
>  	pm_runtime_enable(dev);
>  	pm_runtime_get_sync(dev);
>  	hpriv->got_runtime_pm = true;


-- 
Damien Le Moal
Western Digital Research
