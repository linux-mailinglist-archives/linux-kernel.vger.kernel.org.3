Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF2754D61B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346497AbiFPAaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344002AbiFPA37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:29:59 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B371E57101
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655339398; x=1686875398;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UpXQHU0gqujhxD5jb4VyE96JVSMoT9SxWll6RvwlrfQ=;
  b=KliSP+pKmwu2++0fBycc7mvpHL6A8dx5FMGZtwYNz+vsKORg2RA0dTXS
   9aw0RI+aWx4tLTWeO2BE5PYGD8WNzlSP823ySggax+1/v+KGQc0mE2jTv
   2oBV8+/hSZX8FZtqVczCU5oKdLpT661zL+tOnOsjoM7aVxhvokiwwPDY0
   w1I7Ewz6RbKGllElz+KqLdvpQK5PixW3Sq2QwgpczkDv1w4t3rIkl90t+
   /YVyAdFMM/gtFiNDEvzzaA/EifCzBUKir1sGsORTzxFfbNOOeZPXEMyac
   UuewRVCaVVvRY9N2S2S7iP6Baj1E3Ldj42pb4MQH+j2xhyFiq5QfaxTIF
   w==;
X-IronPort-AV: E=Sophos;i="5.91,302,1647273600"; 
   d="scan'208";a="204038356"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2022 08:29:56 +0800
IronPort-SDR: GbNbAATaz49SErrB+w0HUUmBZtpOwUeMq4Hqu+MJGwiMXcmRhZqaxMHzu8UU20yyuM3M8+9UcF
 XA7jA1sCKV5qiUpFAL+bT9ZIgthsyYOFCsXdvluFWqjpNztJoeJ3AbgmogtK0oi4PFQ99hCg2J
 0en1BCx5INxc0YaINDi4RMzqMLvBy7tJhDWcKdQxVXWIG7sLdj2Kt7TCDax2WAGPlfp/I740VP
 DUy0ptnID++684YcbSYPIU4oHWWXNz+ANtEsc2cwBQftx8qrgAm4byzzQh+P+fVj1X2rvsW23n
 7mXi8npjGliGST8zB6Ko7SA2
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 16:52:45 -0700
IronPort-SDR: aF5SbIxt1dmvLDnYnDlDQ3SuhXFkkiOtX4fg+lPQcjCsz7sNmBeXLWwHODFDcDv4Y6EvD257CQ
 EfvKT5jeQmzGE8S1KzdMVgmtF1z92m84mu8rMVIvz63Uo6pHdeiME2nHPfh1+s65XmH/zVYkyw
 eYFfSc33yyQ2qdU/WWpFS/qOrXw5Mf8TeH1j6n2orB6sHOIe6LCXCBe6XrUjweM49e2qMO2rJg
 LPgO7bPQEwUyM5AtIylM7HDpwJV+QShUz0womsMKi1rbRaqzVnsTiqhCFZ7RAqO5JUjct+ldOz
 S2M=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 17:29:56 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LNjjv0WN7z1SVny
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:29:55 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655339393; x=1657931394; bh=UpXQHU0gqujhxD5jb4VyE96JVSMoT9SxWll
        6RvwlrfQ=; b=WBsbuh5pNKtQzyheI0o8mg1Wjt5MDWZFWHDPy8QXbwzUi7OYH5w
        zJUut5VzSAVDq9W4pT18POcb1rJ38D4KB2OLEJeRiU+f37w5rmeVvJsun9tG0Ln5
        SzYTcGunt8PxOpX+EOqZ6c8h/ulamML2DDch9wafUJmpQuDDZQPzWgD4FI5DeZpx
        vsIVJUM7YTxsDzdPLnkIw8zTOlmqAuIRnPu1ycBQtRxG5ogy1QWBAc8JvVrsEp9p
        NDvjeCFXQU24PMZcIhNsUcVvKI+lAiQUsfo1FcsIsdYSH8st/HUQX4sRz6HzTNy3
        /ynYQioNChffK5glDccWDpXJ4hRGeOSW09w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id V-X_9NEDS6hu for <linux-kernel@vger.kernel.org>;
        Wed, 15 Jun 2022 17:29:53 -0700 (PDT)
Received: from [10.89.84.185] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.84.185])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LNjjq3Nwrz1Rvlc;
        Wed, 15 Jun 2022 17:29:51 -0700 (PDT)
Message-ID: <eb65ccc8-1a59-5847-77c4-80420864eb17@opensource.wdc.com>
Date:   Thu, 16 Jun 2022 09:29:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v4 16/23] ata: ahci: Introduce firmware-specific caps
 initialization
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-17-Sergey.Semin@baikalelectronics.ru>
 <c1fa74f0-28d7-3394-6c43-5063c62db666@opensource.wdc.com>
 <20220615211134.2wxzizbpmfl2akjh@mobilestation>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220615211134.2wxzizbpmfl2akjh@mobilestation>
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

On 2022/06/16 6:11, Serge Semin wrote:
> On Tue, Jun 14, 2022 at 05:42:35PM +0900, Damien Le Moal wrote:
>> On 6/10/22 17:17, Serge Semin wrote:
>>> There are systems with no BIOS or comprehensive embedded firmware which
>>> could be able to properly initialize the SATA AHCI controller
>>> platform-specific capabilities. In that case a good alternative to having
>>> a clever bootloader is to create a device tree node with the properties
>>> well describing all the AHCI-related platform specifics. All the settings
>>> which are normally detected and marked as available in the HBA and its
>>> ports capabilities fields [1] could be defined in the platform DTB by
>>> means of a set of the dedicated properties. Such approach perfectly fits
>>> to the DTB-philosophy - to provide hardware/platform description.
>>>
>>> So here we suggest to extend the SATA AHCI device tree bindings with two
>>> additional DT-properties:
>>> 1) "hba-cap" - HBA platform generic capabilities like:
>>>    - SSS - Staggered Spin-up support.
>>>    - SMPS - Mechanical Presence Switch support.
>>> 2) "hba-port-cap" - HBA platform port capabilities like:
>>>    - HPCP - Hot Plug Capable Port.
>>>    - MPSP - Mechanical Presence Switch Attached to Port.
>>>    - CPD - Cold Presence Detection.
>>>    - ESP - External SATA Port.
>>>    - FBSCP - FIS-based Switching Capable Port.
>>> All of these capabilities require to have a corresponding hardware
>>> configuration. Thus it's ok to have them defined in DTB.
>>>
>>> Even though the driver currently takes into account the state of the ESP
>>> and FBSCP flags state only, there is nothing wrong with having all of them
>>> supported by the generic AHCI library in order to have a complete OF-based
>>> platform-capabilities initialization procedure. These properties will be
>>> parsed in the ahci_platform_get_resources() method and their values will
>>> be stored in the saved_* fields of the ahci_host_priv structure, which in
>>> its turn then will be used to restore the H.CAP, H.PI and P#.CMD
>>> capability fields on device init and after HBA reset.
>>>
>>> Please note this modification concerns the HW-init HBA and its ports flags
>>> only, which are by specification [1] are supposed to be initialized by the
>>> BIOS/platform firmware/expansion ROM and which are normally declared in
>>> the one-time-writable-after-reset register fields. Even though these flags
>>> aren't supposed to be cleared after HBA reset some AHCI instances may
>>> violate that rule so we still need to perform the fields resetting after
>>> each reset. Luckily the corresponding functionality has already been
>>> partly implemented in the framework of the ahci_save_initial_config() and
>>> ahci_restore_initial_config() methods.
>>>
>>> [1] Serial ATA AHCI 1.3.1 Specification, p. 103
>>>
>>> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
>>>
>>> ---
>>>
>>> Changelog v4:
>>> - Convert the boolean properties to the bitfield DT-properties. (@Rob)
>>> ---
>>>  drivers/ata/ahci.h             |  1 +
>>>  drivers/ata/libahci.c          | 51 ++++++++++++++++++++++++++++------
>>>  drivers/ata/libahci_platform.c | 41 +++++++++++++++++++++++++--
>>>  3 files changed, 82 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
>>> index 8b9826533ae5..0de221055961 100644
>>> --- a/drivers/ata/ahci.h
>>> +++ b/drivers/ata/ahci.h
>>> @@ -337,6 +337,7 @@ struct ahci_host_priv {
>>>  	u32			saved_cap;	/* saved initial cap */
>>>  	u32			saved_cap2;	/* saved initial cap2 */
>>>  	u32			saved_port_map;	/* saved initial port_map */
>>> +	u32			saved_port_cap[AHCI_MAX_PORTS]; /* saved port_cap */
>>>  	u32 			em_loc; /* enclosure management location */
>>>  	u32			em_buf_sz;	/* EM buffer size in byte */
>>>  	u32			em_msg_type;	/* EM message type */
>>> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
>>> index 1ffaa5f5f21a..954386a2b500 100644
>>> --- a/drivers/ata/libahci.c
>>> +++ b/drivers/ata/libahci.c
>>> @@ -16,6 +16,7 @@
>>>   * http://www.intel.com/technology/serialata/pdf/rev1_1.pdf
>>>   */
>>>  
>>> +#include <linux/bitops.h>
>>>  #include <linux/kernel.h>
>>>  #include <linux/gfp.h>
>>>  #include <linux/module.h>
>>> @@ -443,16 +444,28 @@ static ssize_t ahci_show_em_supported(struct device *dev,
>>>  void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
>>>  {
>>>  	void __iomem *mmio = hpriv->mmio;
>>> -	u32 cap, cap2, vers, port_map;
>>> +	void __iomem *port_mmio;
>>> +	unsigned long port_map;
>>> +	u32 cap, cap2, vers;
>>>  	int i;
>>>  
>>>  	/* make sure AHCI mode is enabled before accessing CAP */
>>>  	ahci_enable_ahci(mmio);
>>>  
>>> -	/* Values prefixed with saved_ are written back to host after
>>> -	 * reset.  Values without are used for driver operation.
>>> +	/*
>>> +	 * Values prefixed with saved_ are written back to the HBA and ports
>>> +	 * registers after reset. Values without are used for driver operation.
>>> +	 */
>>> +
>>> +	/*
>>> +	 * Override HW-init HBA capability fields with the platform-specific
>>> +	 * values. The rest of the HBA capabilities are defined as Read-only
>>> +	 * and can't be modified in CSR anyway.
>>>  	 */
>>> -	hpriv->saved_cap = cap = readl(mmio + HOST_CAP);
>>> +	cap = readl(mmio + HOST_CAP);
>>> +	if (hpriv->saved_cap)
>>> +		cap = (cap & ~(HOST_CAP_SSS | HOST_CAP_MPS)) | hpriv->saved_cap;
>>> +	hpriv->saved_cap = cap;
>>>  
>>>  	/* CAP2 register is only defined for AHCI 1.2 and later */
>>>  	vers = readl(mmio + HOST_VERSION);
>>> @@ -519,7 +532,7 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
>>>  	/* Override the HBA ports mapping if the platform needs it */
>>>  	port_map = readl(mmio + HOST_PORTS_IMPL);
>>>  	if (hpriv->saved_port_map && port_map != hpriv->saved_port_map) {
>>> -		dev_info(dev, "forcing port_map 0x%x -> 0x%x\n",
>>> +		dev_info(dev, "forcing port_map 0x%lx -> 0x%x\n",
>>
> 
>> This change is not necessary.
> 
> It is. The port_map type has been changed.

Ignore. When I read the patches the other day, the mailer font had that "l" look
like a "1" :) My mistake.

> 
>>
>>>  			 port_map, hpriv->saved_port_map);
>>>  		port_map = hpriv->saved_port_map;
>>>  	} else {
>>> @@ -527,7 +540,7 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
>>>  	}
>>>  
>>>  	if (hpriv->mask_port_map) {
>>> -		dev_warn(dev, "masking port_map 0x%x -> 0x%x\n",
>>> +		dev_warn(dev, "masking port_map 0x%lx -> 0x%lx\n",
>>
>> Same.
> 
> ditto
> 
>>
>>>  			port_map,
>>>  			port_map & hpriv->mask_port_map);
>>>  		port_map &= hpriv->mask_port_map;
>>> @@ -546,7 +559,7 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
>>>  		 */
>>>  		if (map_ports > ahci_nr_ports(cap)) {
>>>  			dev_warn(dev,
>>> -				 "implemented port map (0x%x) contains more ports than nr_ports (%u), using nr_ports\n",
>>> +				 "implemented port map (0x%lx) contains more ports than nr_ports (%u), using nr_ports\n",
>>
>> Same.
> 
> ditto.
> 
>>
>>>  				 port_map, ahci_nr_ports(cap));
>>>  			port_map = 0;
>>>  		}
>>> @@ -555,12 +568,26 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
>>>  	/* fabricate port_map from cap.nr_ports for < AHCI 1.3 */
>>>  	if (!port_map && vers < 0x10300) {
>>>  		port_map = (1 << ahci_nr_ports(cap)) - 1;
>>> -		dev_warn(dev, "forcing PORTS_IMPL to 0x%x\n", port_map);
>>> +		dev_warn(dev, "forcing PORTS_IMPL to 0x%lx\n", port_map);
>>
>> And again not needed.
> 
> and ditto.
> 
>>
>>>  
>>>  		/* write the fixed up value to the PI register */
>>>  		hpriv->saved_port_map = port_map;
>>>  	}
>>>  
>>> +	/*
>>> +	 * Preserve the ports capabilities defined by the platform. Note there
>>> +	 * is no need in storing the rest of the P#.CMD fields since they are
>>> +	 * volatile.
>>> +	 */
>>> +	for_each_set_bit(i, &port_map, AHCI_MAX_PORTS) {
>>> +		if (hpriv->saved_port_cap[i])
>>> +			continue;
>>> +
>>> +		port_mmio = __ahci_port_base(hpriv, i);
>>> +		hpriv->saved_port_cap[i] =
>>> +			readl(port_mmio + PORT_CMD) & PORT_CMD_CAP;
>>> +	}
>>> +
>>>  	/* record values to use during operation */
>>>  	hpriv->cap = cap;
>>>  	hpriv->cap2 = cap2;
>>> @@ -590,13 +617,21 @@ EXPORT_SYMBOL_GPL(ahci_save_initial_config);
>>>  static void ahci_restore_initial_config(struct ata_host *host)
>>>  {
>>>  	struct ahci_host_priv *hpriv = host->private_data;
>>> +	unsigned long port_map = hpriv->port_map;
>>>  	void __iomem *mmio = hpriv->mmio;
>>> +	void __iomem *port_mmio;
>>> +	int i;
>>>  
>>>  	writel(hpriv->saved_cap, mmio + HOST_CAP);
>>>  	if (hpriv->saved_cap2)
>>>  		writel(hpriv->saved_cap2, mmio + HOST_CAP2);
>>>  	writel(hpriv->saved_port_map, mmio + HOST_PORTS_IMPL);
>>>  	(void) readl(mmio + HOST_PORTS_IMPL);	/* flush */
>>> +
>>> +	for_each_set_bit(i, &port_map, AHCI_MAX_PORTS) {
>>> +		port_mmio = __ahci_port_base(hpriv, i);
>>> +		writel(hpriv->saved_port_cap[i], port_mmio + PORT_CMD);
>>> +	}
>>>  }
>>>  
>>>  static unsigned ahci_scr_offset(struct ata_port *ap, unsigned int sc_reg)
>>> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
>>> index efe640603f3f..8b542a8bc487 100644
>>> --- a/drivers/ata/libahci_platform.c
>>> +++ b/drivers/ata/libahci_platform.c
>>> @@ -23,6 +23,7 @@
>>>  #include <linux/pm_runtime.h>
>>>  #include <linux/of_platform.h>
>>>  #include <linux/reset.h>
>>> +
>>
>> white line change.
> 
> Ok. I'll drop it.
> 
> -Sergey
> 
>>
>>>  #include "ahci.h"
>>>  
>>>  static void ahci_host_stop(struct ata_host *host);
>>> @@ -383,6 +384,34 @@ static int ahci_platform_get_regulator(struct ahci_host_priv *hpriv, u32 port,
>>>  	return rc;
>>>  }
>>>  
>>> +static int ahci_platform_get_firmware(struct ahci_host_priv *hpriv,
>>> +				      struct device *dev)
>>> +{
>>> +	struct device_node *child;
>>> +	u32 port;
>>> +
>>> +	if (!of_property_read_u32(dev->of_node, "hba-cap", &hpriv->saved_cap))
>>> +		hpriv->saved_cap &= (HOST_CAP_SSS | HOST_CAP_MPS);
>>> +
>>> +	of_property_read_u32(dev->of_node,
>>> +			     "ports-implemented", &hpriv->saved_port_map);
>>> +
>>> +	for_each_child_of_node(dev->of_node, child) {
>>> +		if (!of_device_is_available(child))
>>> +			continue;
>>> +
>>> +		if (of_property_read_u32(child, "reg", &port)) {
>>> +			of_node_put(child);
>>> +			return -EINVAL;
>>> +		}
>>> +
>>> +		if (!of_property_read_u32(child, "hba-port-cap", &hpriv->saved_port_cap[port]))
>>> +			hpriv->saved_port_cap[port] &= PORT_CMD_CAP;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>  /**
>>>   * ahci_platform_get_resources - Get platform resources
>>>   * @pdev: platform device to get resources for
>>> @@ -523,9 +552,6 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>>>  		goto err_out;
>>>  	}
>>>  
>>> -	of_property_read_u32(dev->of_node,
>>> -			     "ports-implemented", &hpriv->saved_port_map);
>>> -
>>>  	if (child_nodes) {
>>>  		for_each_child_of_node(dev->of_node, child) {
>>>  			u32 port;
>>> @@ -590,6 +616,15 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>>>  		if (rc == -EPROBE_DEFER)
>>>  			goto err_out;
>>>  	}
>>> +
>>> +	/*
>>> +	 * Retrieve firmware-specific flags which then will be used to set
>>> +	 * the HW-init fields of HBA and its ports
>>> +	 */
>>> +	rc = ahci_platform_get_firmware(hpriv, dev);
>>> +	if (rc)
>>> +		goto err_out;
>>> +
>>>  	pm_runtime_enable(dev);
>>>  	pm_runtime_get_sync(dev);
>>>  	hpriv->got_runtime_pm = true;
>>
>>
>> -- 
>> Damien Le Moal
>> Western Digital Research


-- 
Damien Le Moal
Western Digital Research
