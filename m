Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5EF4E5D27
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 03:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347747AbiCXCWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 22:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240525AbiCXCWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 22:22:40 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611A6939A2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 19:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648088467; x=1679624467;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QfneqZNgUywmtq8vY7urEmUr+WjZ4xp2pYc/c2O0Aqo=;
  b=WlS6m2Bz06/sAwxDeaaK0fYFVUgPm2FYyNvJKvaKjhP2wOT/PldiM4K8
   NaRIMnJ265ekIUJJ5VHhvLRh70HkmXSbnEileG2b7OuiTUZkzdVSoJ5wQ
   yAIfrYsq8QAAw6Hav2keDZUKOv+OQBFIOz5AHWoUv0YhlexE6b+ymeneT
   XM3osIj4E/6HKxe+1vlNcbwpyAc8BJMAt/gBXrTaN9RmIjdnv+NHSGea/
   LkbcbtBIStEQmFR3KRfUvSRR2w1k/RQ45k7NYdRWvCn+STHXFl7BYymzD
   AdnH7ckoG3CB9oz+aIzxSxbS0tlA2vsMkW9kcP+zQ7ATYHZLKfdM3IEGt
   A==;
X-IronPort-AV: E=Sophos;i="5.90,206,1643644800"; 
   d="scan'208";a="200969087"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2022 10:21:05 +0800
IronPort-SDR: drvksE/FwFjMtxp4Zga8dVgIc0o+vbHtBAgwAcLKbRqf8r/CfTPMcEXgeAmMvuS3r3IXjZmCSC
 3D1gAnJQkWRmcENRjnWWMtaeyKqWbG7PqPMkZbW4Uy1GgMwHhDOmnT0HwSuX4OQuWuibqWDgmU
 aTE+en1HuRVYa2ooL8qxDc2yf2iNi+857vl1BY1cBsteCUOILgGXCR3jVy4KI1Bh7oj8DJ0lXY
 VkhV9PC+ZQX9UY/O5uzqFOKbH8txJl2Cy2D5oOpPe/nBLOBnLtI5wcnAa5fysrc8RFfNvBO1z6
 ZCpYCJWGVMNkOt7ZzHgZ7E/c
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 18:52:04 -0700
IronPort-SDR: 7AehL8jHq2zIkr8CThrJ6pIHwAZcsosLN+asHKE4r42P3KrZxaRBkX3+Lw4Ydxa6ygM9wRD75j
 0vFEGsSAllfr5n1gQr2fhDxInLO+S40c9FHnN7Y+LD1er32ZVl9iEo+I34WVi88NWZv6s31jMt
 Nh3iSZdn9h/fZDTqf7ynJBfciEUDzLgLkP+TXi8mfnbu6b3u95uAuzrPzc1pGNZN0JelSiiXYc
 kiQdUfkj2y/mAXcO9V2DEMIehwOXWBEIv/h3+gLnsXIenlo89F9UH85HmkmPUXpY0JYK6tGq3y
 GOg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 19:21:07 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KP88y4gGLz1SVp1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 19:21:06 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648088464; x=1650680465; bh=QfneqZNgUywmtq8vY7urEmUr+WjZ4xp2pYc
        /c2O0Aqo=; b=tBT2BkqDaWMY1Rg95hgv0P5CVYXdA5R5jj8wFbIVhArKJyf3Wis
        /Ex5C3x7iABLQs6lpYK8aq4xdAwLdU4036AYMtTzooImkLQigLnLxwyYtZb6qA9e
        VR/LTq6vcbTXBVIpD7UWvWpHIeWL3reQGmD2qvDVEJziGTM6tfvHApHrcY+DXRiY
        GEQLoViLsRJA2ft8Q9KMNS79/VQDU4Gj5Y5G1bsB+ykJ4sbmKHP+2Ctt8XDM0MjO
        aNvUd0xQAzjHn/byoF3nTyUfjrPpwo05Xg9eXzk3sz03nj05O5jWvvnmw8/YCsM5
        qwJKLNzKqptQnt7AGg1F8o7oKyNZ//BbFpA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id v4Z1p-lf4SZl for <linux-kernel@vger.kernel.org>;
        Wed, 23 Mar 2022 19:21:04 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KP88t4j3Pz1Rvlx;
        Wed, 23 Mar 2022 19:21:02 -0700 (PDT)
Message-ID: <2f873143-eb45-e652-063d-615d63055401@opensource.wdc.com>
Date:   Thu, 24 Mar 2022 11:21:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 17/21] ata: ahci: Add DWC AHCI SATA controller support
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Serge Semin <fancer.lancer@gmail.com>
Cc:     Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
 <20220324001628.13028-18-Sergey.Semin@baikalelectronics.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220324001628.13028-18-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/22 09:16, Serge Semin wrote:
> Synopsys AHCI SATA controller can work pretty under with the generic
> AHCI-platform driver control. But there are vendor-specific peculiarities
> which can tune the device performance up and which may need to be fixed up
> for proper device functioning. In addition some DWC AHCI-based controllers
> may require small platform-specific fixups, so adding them in the generic
> AHCI driver would have ruined the code simplicity. Shortly speaking in
> order to keep the generic AHCI-platform code clean and have DWC AHCI
> SATA-specific features supported we suggest to add a dedicated DWC AHCI
> SATA device driver. Aside with the standard AHCI-platform resources
> getting, enabling/disabling and the controller registration the new driver
> performs the next actions.
> 
> First of all there is a way to verify whether the HBA/ports capabilities
> activated in OF are correct. Almost all features availability is reflected
> in the vendor-specific parameters registers. So the DWC AHCI driver does
> the capabilities sanity check based on the corresponding fields state.
> 
> Secondly if either the Command Completion Coalescing or the Device Sleep
> feature is enabled the DWC AHCI-specific internal 1ms timer must be fixed
> in accordance with the application clock signal frequency. In particular
> the timer value must be set to be Fapp * 1000. Normally the SoC designers
> pre-configure the TIMER1MS register to contain a correct value by default.
> But the platforms can support the application clock rate change. If that
> happens the 1ms timer value must be accordingly updated otherwise the
> dependent features won't work as expected. In the DWC AHCI driver we
> suggest to rely on the "aclk" reference clock rate to set the timer
> interval up. That clock source is supposed to be the AHCI SATA application
> clock in accordance with the DT bindings.
> 
> Finally DWC AHCI SATA controller AXI/AHB bus DMA-engine can be tuned up to
> transfer up to 1024 * FIFO words at a time by setting the Tx/Rx
> transaction size in the DMA control register. The maximum value depends on
> the DMA data bus and AXI/AHB bus maximum burst length. In most of the
> cases it's better to set the maximum possible value to reach the best AHCI
> SATA controller performance. But sometimes in order to improve the system
> interconnect responsiveness, transferring in smaller data chunks may be
> more preferable. For such cases and for the case when the default value
> doesn't provide the best DMA bus performance we suggest to use the new
> HBA-port specific DT-properties "snps,{tx,rx}-ts-max" to tune the DMA
> transactions size up.
> 
> After all the settings denoted above are handled the DWC AHCI SATA driver
> proceeds further with the standard AHCI-platform host initializations.
> 
> Note since DWC AHCI controller is now have a dedicated driver we can
> discard the corresponding compatible string from the ahci-platform.c
> module. The same concerns "snps,spear-ahci" compatible string, which is
> also based on the DWC AHCI IP-core.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Note there are three more AHCI SATA drivers which have been created for
> the devices based on the DWC AHCI SATA IP-core. It's AHCI SunXi, St and
> iMX drivers. Mostly they don't support the features implemented in this
> driver. So hopefully sometime in future they can be converted to be based
> on the generic DWC AHCI SATA driver and just perform some
> subvendor-specific setups in their own glue-driver code. But for now
> let's leave the generic DWC AHCI SATA code as is. Hopefully the new DWC
> AHCI-based device drivers will try at least to re-use a part of the DWC
> AHCI driver methods if not being able to be integrated in the generic
> DWC driver code.
> ---
>  drivers/ata/Kconfig         |  10 +
>  drivers/ata/Makefile        |   1 +
>  drivers/ata/ahci_dwc.c      | 395 ++++++++++++++++++++++++++++++++++++
>  drivers/ata/ahci_platform.c |   2 -
>  4 files changed, 406 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/ata/ahci_dwc.c
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index cb54631fd950..ab11bcf8510c 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -174,6 +174,16 @@ config AHCI_DM816
>  
>  	  If unsure, say N.
>  
> +config AHCI_DWC
> +	tristate "Synopsys DWC AHCI SATA support"
> +	select SATA_HOST
> +	default SATA_AHCI_PLATFORM
> +	help
> +	  This option enables support for the Synopsys DWC AHCI SATA
> +	  controller implementation.
> +
> +	  If unsure, say N.
> +
>  config AHCI_ST
>  	tristate "ST AHCI SATA support"
>  	depends on ARCH_STI
> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
> index b8aebfb14e82..34623365d9a6 100644
> --- a/drivers/ata/Makefile
> +++ b/drivers/ata/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_AHCI_BRCM)		+= ahci_brcm.o libahci.o libahci_platform.o
>  obj-$(CONFIG_AHCI_CEVA)		+= ahci_ceva.o libahci.o libahci_platform.o
>  obj-$(CONFIG_AHCI_DA850)	+= ahci_da850.o libahci.o libahci_platform.o
>  obj-$(CONFIG_AHCI_DM816)	+= ahci_dm816.o libahci.o libahci_platform.o
> +obj-$(CONFIG_AHCI_DWC)		+= ahci_dwc.o libahci.o libahci_platform.o
>  obj-$(CONFIG_AHCI_IMX)		+= ahci_imx.o libahci.o libahci_platform.o
>  obj-$(CONFIG_AHCI_MTK)		+= ahci_mtk.o libahci.o libahci_platform.o
>  obj-$(CONFIG_AHCI_MVEBU)	+= ahci_mvebu.o libahci.o libahci_platform.o
> diff --git a/drivers/ata/ahci_dwc.c b/drivers/ata/ahci_dwc.c
> new file mode 100644
> index 000000000000..c51e2251994e
> --- /dev/null
> +++ b/drivers/ata/ahci_dwc.c
> @@ -0,0 +1,395 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * DWC AHCI SATA Platform driver
> + *
> + * Copyright (C) 2021 BAIKAL ELECTRONICS, JSC
> + */
> +
> +#include <linux/ahci_platform.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/libata.h>
> +#include <linux/log2.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +
> +#include "ahci.h"
> +
> +#define DRV_NAME "ahci-dwc"
> +
> +#define DWC_AHCI_FBS_PMPN_MAX		15

The convention is to name things starting with AHCI, e.g. AHCI_DWC_xxxx

> +
> +/* DWC AHCI SATA controller specific registers */
> +#define DWC_AHCI_HOST_OOBR		0xbc
> +#define DWC_AHCI_HOST_OOB_WE		BIT(31)
> +#define DWC_AHCI_HOST_CWMIN_MASK	GENMASK(30, 24)
> +#define DWC_AHCI_HOST_CWMAX_MASK	GENMASK(23, 16)
> +#define DWC_AHCI_HOST_CIMIN_MASK	GENMASK(15, 8)
> +#define DWC_AHCI_HOST_CIMAX_MASK	GENMASK(7, 0)
> +
> +#define DWC_AHCI_HOST_GPCR		0xd0
> +#define DWC_AHCI_HOST_GPSR		0xd4
> +
> +#define DWC_AHCI_HOST_TIMER1MS		0xe0
> +#define DWC_AHCI_HOST_TIMV_MASK		GENMASK(19, 0)
> +
> +#define DWC_AHCI_HOST_GPARAM1R		0xe8
> +#define DWC_AHCI_HOST_ALIGN_M		BIT(31)
> +#define DWC_AHCI_HOST_RX_BUFFER		BIT(30)
> +#define DWC_AHCI_HOST_PHY_DATA_MASK	GENMASK(29, 28)
> +#define DWC_AHCI_HOST_PHY_RST		BIT(27)
> +#define DWC_AHCI_HOST_PHY_CTRL_MASK	GENMASK(26, 21)
> +#define DWC_AHCI_HOST_PHY_STAT_MASK	GENMASK(20, 15)
> +#define DWC_AHCI_HOST_LATCH_M		BIT(14)
> +#define DWC_AHCI_HOST_PHY_TYPE_MASK	GENMASK(13, 11)
> +#define DWC_AHCI_HOST_RET_ERR		BIT(10)
> +#define DWC_AHCI_HOST_AHB_ENDIAN_MASK	GENMASK(9, 8)
> +#define DWC_AHCI_HOST_S_HADDR		BIT(7)
> +#define DWC_AHCI_HOST_M_HADDR		BIT(6)
> +#define DWC_AHCI_HOST_S_HDATA_MASK	GENMASK(5, 3)
> +#define DWC_AHCI_HOST_M_HDATA_MASK	GENMASK(2, 0)
> +
> +#define DWC_AHCI_HOST_GPARAM2R		0xec
> +#define DWC_AHCI_HOST_FBS_MEM_S		BIT(19)
> +#define DWC_AHCI_HOST_FBS_PMPN_MASK	GENMASK(17, 16)
> +#define DWC_AHCI_HOST_FBS_SUP		BIT(15)
> +#define DWC_AHCI_HOST_DEV_CP		BIT(14)
> +#define DWC_AHCI_HOST_DEV_MP		BIT(13)
> +#define DWC_AHCI_HOST_ENCODE_M		BIT(12)
> +#define DWC_AHCI_HOST_RXOOB_CLK_M	BIT(11)
> +#define DWC_AHCI_HOST_RXOOB_M		BIT(10)
> +#define DWC_AHCI_HOST_TXOOB_M		BIT(9)
> +#define DWC_AHCI_HOST_RXOOB_M		BIT(10)
> +#define DWC_AHCI_HOST_RXOOB_CLK_MASK	GENMASK(8, 0)
> +
> +#define DWC_AHCI_HOST_PPARAMR		0xf0
> +#define DWC_AHCI_HOST_TX_MEM_M		BIT(11)
> +#define DWC_AHCI_HOST_TX_MEM_S		BIT(10)
> +#define DWC_AHCI_HOST_RX_MEM_M		BIT(9)
> +#define DWC_AHCI_HOST_RX_MEM_S		BIT(8)
> +#define DWC_AHCI_HOST_TXFIFO_DEPTH	GENMASK(7, 4)
> +#define DWC_AHCI_HOST_RXFIFO_DEPTH	GENMASK(3, 0)
> +
> +#define DWC_AHCI_HOST_TESTR		0xf4
> +#define DWC_AHCI_HOST_PSEL_MASK		GENMASK(18, 16)
> +#define DWC_AHCI_HOST_TEST_IF		BIT(0)
> +
> +#define DWC_AHCI_HOST_VERSIONR		0xf8
> +#define DWC_AHCI_HOST_IDR		0xfc
> +
> +#define DWC_AHCI_PORT_DMACR		0x70
> +#define DWC_AHCI_PORT_RXABL_MASK	GENMASK(15, 12)
> +#define DWC_AHCI_PORT_TXABL_MASK	GENMASK(11, 8)
> +#define DWC_AHCI_PORT_RXTS_MASK		GENMASK(7, 4)
> +#define DWC_AHCI_PORT_TXTS_MASK		GENMASK(3, 0)
> +#define DWC_AHCI_PORT_PHYCR		0x74
> +#define DWC_AHCI_PORT_PHYSR		0x78
> +
> +struct dwc_ahci_host_priv {
> +	struct platform_device *pdev;
> +
> +	u32 timv;
> +	u32 dmacr[AHCI_MAX_PORTS];
> +};
> +
> +static struct ahci_host_priv *dwc_ahci_get_resources(struct platform_device *pdev)

Same: dwc_ahci_get_resources() -> ahci_dwc_get_resources()

> +{
> +	struct dwc_ahci_host_priv *dpriv;
> +	struct ahci_host_priv *hpriv;
> +
> +	dpriv = devm_kzalloc(&pdev->dev, sizeof(*dpriv), GFP_KERNEL);
> +	if (!dpriv)
> +		return ERR_PTR(-ENOMEM);
> +
> +	dpriv->pdev = pdev;
> +
> +	hpriv = ahci_platform_get_resources(pdev, AHCI_PLATFORM_GET_RESETS);
> +	if (IS_ERR(hpriv))
> +		return hpriv;
> +
> +	hpriv->plat_data = (void *)dpriv;
> +
> +	return hpriv;
> +}
> +
> +static void dwc_ahci_check_cap(struct ahci_host_priv *hpriv)
> +{
> +	unsigned long port_map = hpriv->saved_port_map | hpriv->mask_port_map;
> +	struct dwc_ahci_host_priv *dpriv = hpriv->plat_data;
> +	bool dev_mp, dev_cp, fbs_sup;
> +	unsigned int fbs_pmp;
> +	u32 param;
> +	int i;
> +
> +	param = readl(hpriv->mmio + DWC_AHCI_HOST_GPARAM2R);
> +	dev_mp = !!(param & DWC_AHCI_HOST_DEV_MP);
> +	dev_cp = !!(param & DWC_AHCI_HOST_DEV_CP);
> +	fbs_sup = !!(param & DWC_AHCI_HOST_FBS_SUP);
> +	fbs_pmp = 5 * FIELD_GET(DWC_AHCI_HOST_FBS_PMPN_MASK, param);
> +
> +	if (!dev_mp && hpriv->saved_cap & HOST_CAP_MPS) {
> +		dev_warn(&dpriv->pdev->dev, "MPS is unsupported\n");
> +		hpriv->saved_cap &= ~HOST_CAP_MPS;
> +	}
> +
> +
> +	if (fbs_sup && fbs_pmp < DWC_AHCI_FBS_PMPN_MAX) {
> +		dev_warn(&dpriv->pdev->dev, "PMPn is limited up to %u ports\n",
> +			 fbs_pmp);
> +	}
> +
> +	for_each_set_bit(i, &port_map, AHCI_MAX_PORTS) {
> +		if (!dev_mp && hpriv->saved_port_cap[i] & PORT_CMD_MPSP) {
> +			dev_warn(&dpriv->pdev->dev, "MPS incapable port %d\n", i);
> +			hpriv->saved_port_cap[i] &= ~PORT_CMD_MPSP;
> +		}
> +
> +		if (!dev_cp && hpriv->saved_port_cap[i] & PORT_CMD_CPD) {
> +			dev_warn(&dpriv->pdev->dev, "CPD incapable port %d\n", i);
> +			hpriv->saved_port_cap[i] &= ~PORT_CMD_CPD;
> +		}
> +
> +		if (!fbs_sup && hpriv->saved_port_cap[i] & PORT_CMD_FBSCP) {
> +			dev_warn(&dpriv->pdev->dev, "FBS incapable port %d\n", i);
> +			hpriv->saved_port_cap[i] &= ~PORT_CMD_FBSCP;
> +		}
> +	}
> +}
> +
> +static void dwc_ahci_init_timer(struct ahci_host_priv *hpriv)
> +{
> +	struct dwc_ahci_host_priv *dpriv = hpriv->plat_data;
> +	unsigned long rate;
> +	struct clk *aclk;
> +	u32 cap, cap2;
> +
> +	/* 1ms tick is generated only for the CCC or DevSleep features */
> +	cap = readl(hpriv->mmio + HOST_CAP);
> +	cap2 = readl(hpriv->mmio + HOST_CAP2);
> +	if (!(cap & HOST_CAP_CCC) && !(cap2 & HOST_CAP2_SDS))
> +		return;
> +
> +	/*
> +	 * Tick is generated based on the AXI/AHB application clocks signal
> +	 * so we need to be sure in the clock we are going to use.
> +	 */
> +	aclk = ahci_platform_find_clk(hpriv, "aclk");
> +	if (!aclk)
> +		return;
> +
> +	/* 1ms timer interval is set as TIMV = AMBA_FREQ[MHZ] * 1000 */
> +	dpriv->timv = readl(hpriv->mmio + DWC_AHCI_HOST_TIMER1MS);
> +	dpriv->timv = FIELD_GET(DWC_AHCI_HOST_TIMV_MASK, dpriv->timv);
> +	rate = clk_get_rate(aclk) / 1000UL;
> +	if (rate == dpriv->timv)
> +		return;
> +
> +	dev_info(&dpriv->pdev->dev, "Update CCC/DevSlp timer for Fapp %lu MHz\n",
> +		 rate / 1000UL);
> +	dpriv->timv = FIELD_PREP(DWC_AHCI_HOST_TIMV_MASK, rate);
> +	writel(dpriv->timv, hpriv->mmio + DWC_AHCI_HOST_TIMER1MS);
> +}
> +
> +static int dwc_ahci_init_dmacr(struct ahci_host_priv *hpriv)
> +{
> +	struct dwc_ahci_host_priv *dpriv = hpriv->plat_data;
> +	struct device_node *child;
> +	void __iomem *port_mmio;
> +	u32 port, dmacr, ts;
> +
> +	/*
> +	 * Update the DMA Tx/Rx transaction sizes in accordance with the
> +	 * platform setup. Note values exceeding maximal or minimal limits will
> +	 * be automatically clamped. Also note the register isn't affected by
> +	 * the HBA global reset so we can freely initialize it once until the
> +	 * next system reset.
> +	 */
> +	for_each_child_of_node(dpriv->pdev->dev.of_node, child) {
> +		if (!of_device_is_available(child))
> +			continue;
> +
> +		if (of_property_read_u32(child, "reg", &port)) {
> +			of_node_put(child);
> +			return -EINVAL;
> +		}
> +
> +		port_mmio = __ahci_port_base(hpriv, port);
> +		dmacr = readl(port_mmio + DWC_AHCI_PORT_DMACR);
> +
> +		if (!of_property_read_u32(child, "snps,tx-ts-max", &ts)) {
> +			ts = ilog2(ts);
> +			dmacr &= ~DWC_AHCI_PORT_TXTS_MASK;
> +			dmacr |= FIELD_PREP(DWC_AHCI_PORT_TXTS_MASK, ts);
> +		}
> +
> +		if (!of_property_read_u32(child, "snps,rx-ts-max", &ts)) {
> +			ts = ilog2(ts);
> +			dmacr &= ~DWC_AHCI_PORT_RXTS_MASK;
> +			dmacr |= FIELD_PREP(DWC_AHCI_PORT_RXTS_MASK, ts);
> +		}
> +
> +		writel(dmacr, port_mmio + DWC_AHCI_PORT_DMACR);
> +		dpriv->dmacr[port] = dmacr;
> +	}
> +
> +	return 0;
> +}
> +
> +static int dwc_ahci_init_host(struct ahci_host_priv *hpriv)
> +{
> +	int rc;
> +
> +	rc = ahci_platform_enable_resources(hpriv);
> +	if (rc)
> +		return rc;
> +
> +	dwc_ahci_check_cap(hpriv);
> +
> +	dwc_ahci_init_timer(hpriv);
> +
> +	rc = dwc_ahci_init_dmacr(hpriv);
> +	if (rc)
> +		goto err_disable_resources;
> +
> +	return 0;
> +
> +err_disable_resources:
> +	ahci_platform_disable_resources(hpriv);
> +
> +	return rc;
> +}
> +
> +static int dwc_ahci_reinit_host(struct ahci_host_priv *hpriv)
> +{
> +	struct dwc_ahci_host_priv *dpriv = hpriv->plat_data;
> +	unsigned long port_map = hpriv->port_map;
> +	void __iomem *port_mmio;
> +	int i, rc;
> +
> +	rc = ahci_platform_enable_resources(hpriv);
> +	if (rc)
> +		return rc;
> +
> +	writel(dpriv->timv, hpriv->mmio + DWC_AHCI_HOST_TIMER1MS);
> +
> +	for_each_set_bit(i, &port_map, AHCI_MAX_PORTS) {
> +		port_mmio = __ahci_port_base(hpriv, i);
> +		writel(dpriv->dmacr[i], port_mmio + DWC_AHCI_PORT_DMACR);
> +	}
> +
> +	return 0;
> +}
> +
> +static void dwc_ahci_clear_host(struct ahci_host_priv *hpriv)
> +{
> +	ahci_platform_disable_resources(hpriv);
> +}
> +
> +static void dwc_ahci_stop_host(struct ata_host *host)
> +{
> +	struct ahci_host_priv *hpriv = host->private_data;
> +
> +	dwc_ahci_clear_host(hpriv);
> +}
> +
> +static struct ata_port_operations dwc_ahci_port_ops = {
> +	.inherits	= &ahci_platform_ops,
> +	.host_stop	= dwc_ahci_stop_host,
> +};
> +
> +static const struct ata_port_info dwc_ahci_port_info = {
> +	.flags		= AHCI_FLAG_COMMON,
> +	.pio_mask	= ATA_PIO4,
> +	.udma_mask	= ATA_UDMA6,
> +	.port_ops	= &dwc_ahci_port_ops,
> +};
> +
> +static struct scsi_host_template dwc_ahci_scsi_info = {
> +	AHCI_SHT(DRV_NAME),
> +};
> +
> +static int dwc_ahci_probe(struct platform_device *pdev)
> +{
> +	struct ahci_host_priv *hpriv;
> +	int rc;
> +
> +	hpriv = dwc_ahci_get_resources(pdev);
> +	if (IS_ERR(hpriv))
> +		return PTR_ERR(hpriv);
> +
> +	rc = dwc_ahci_init_host(hpriv);
> +	if (rc)
> +		return rc;
> +
> +	rc = ahci_platform_init_host(pdev, hpriv, &dwc_ahci_port_info,
> +				     &dwc_ahci_scsi_info);
> +	if (rc)
> +		goto err_clear_host;
> +
> +	return 0;
> +
> +err_clear_host:
> +	dwc_ahci_clear_host(hpriv);
> +
> +	return rc;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int dwc_ahci_suspend(struct device *dev)
> +{
> +	struct ata_host *host = dev_get_drvdata(dev);
> +	struct ahci_host_priv *hpriv = host->private_data;
> +	int rc;
> +
> +	rc = ahci_platform_suspend_host(dev);
> +	if (rc)
> +		return rc;
> +
> +	dwc_ahci_clear_host(hpriv);
> +
> +	return 0;
> +}
> +
> +static int dwc_ahci_resume(struct device *dev)
> +{
> +	struct ata_host *host = dev_get_drvdata(dev);
> +	struct ahci_host_priv *hpriv = host->private_data;
> +	int rc;
> +
> +	rc = dwc_ahci_reinit_host(hpriv);
> +	if (rc)
> +		return rc;
> +
> +	return ahci_platform_resume_host(dev);
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(dwc_ahci_pm_ops, dwc_ahci_suspend, dwc_ahci_resume);
> +
> +static const struct of_device_id dwc_ahci_of_match[] = {
> +	{ .compatible = "snps,dwc-ahci", },
> +	{ .compatible = "snps,spear-ahci", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, dwc_ahci_of_match);
> +
> +static struct platform_driver dwc_ahci_driver = {
> +	.probe = dwc_ahci_probe,
> +	.remove = ata_platform_remove_one,
> +	.shutdown = ahci_platform_shutdown,
> +	.driver = {
> +		.name = DRV_NAME,
> +		.of_match_table = dwc_ahci_of_match,
> +		.pm = &dwc_ahci_pm_ops,
> +	},
> +};
> +module_platform_driver(dwc_ahci_driver);
> +
> +MODULE_DESCRIPTION("DWC AHCI SATA platform driver");
> +MODULE_AUTHOR("Serge Semin <Sergey.Semin@baikalelectronics.ru>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index 24c25f076f37..052eaa30d262 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -80,9 +80,7 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_platform_suspend,
>  static const struct of_device_id ahci_of_match[] = {
>  	{ .compatible = "generic-ahci", },
>  	/* Keep the following compatibles for device tree compatibility */
> -	{ .compatible = "snps,spear-ahci", },
>  	{ .compatible = "ibm,476gtr-ahci", },
> -	{ .compatible = "snps,dwc-ahci", },
>  	{ .compatible = "hisilicon,hisi-ahci", },
>  	{ .compatible = "cavium,octeon-7130-ahci", },
>  	{},


-- 
Damien Le Moal
Western Digital Research
