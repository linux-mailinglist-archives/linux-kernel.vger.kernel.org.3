Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F36484C24
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 02:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236909AbiAEBfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 20:35:02 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:34875 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbiAEBfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 20:35:01 -0500
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JTBq538Nnzcbxj;
        Wed,  5 Jan 2022 09:34:25 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 09:34:58 +0800
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 09:34:58 +0800
Subject: Re: [PATCH v3 2/2] ACPI: AGDI: Add driver for Arm Generic Diagnostic
 Dump and Reset device
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        <lorenzo.pieralisi@arm.com>, <sudeep.holla@arm.com>,
        <rafael@kernel.org>, <linux@armlinux.org.uk>
CC:     <lenb@kernel.org>, <robert.moore@intel.com>,
        <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <patches@amperecomputing.com>,
        <scott@os.amperecomputing.com>, <darren@os.amperecomputing.com>
References: <20211231033725.21109-1-ilkka@os.amperecomputing.com>
 <20211231033725.21109-3-ilkka@os.amperecomputing.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <f0fecf95-0b7d-eeec-94fd-76bea61fdd0f@huawei.com>
Date:   Wed, 5 Jan 2022 09:34:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20211231033725.21109-3-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ilkka,

On 2021/12/31 11:37, Ilkka Koskinen wrote:
> ACPI for Arm Components 1.1 Platform Design Document v1.1 [0] specifices
> Arm Generic Diagnostic Device Interface (AGDI). It allows an admin to
> issue diagnostic dump and reset via an SDEI event or an interrupt.
> This patch implements SDEI path.
> 
> [0] https://developer.arm.com/documentation/den0093/latest/
> 
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>   drivers/acpi/arm64/Kconfig  |   8 +++
>   drivers/acpi/arm64/Makefile |   1 +
>   drivers/acpi/arm64/agdi.c   | 125 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 134 insertions(+)
>   create mode 100644 drivers/acpi/arm64/agdi.c
> 
> diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
> index 6dba187f4f2e..24869ba5b365 100644
> --- a/drivers/acpi/arm64/Kconfig
> +++ b/drivers/acpi/arm64/Kconfig
> @@ -8,3 +8,11 @@ config ACPI_IORT
>   
>   config ACPI_GTDT
>   	bool
> +
> +config ACPI_AGDI
> +	bool "Arm Generic Diagnostic Dump and Reset Device Interface"
> +	depends on ARM_SDE_INTERFACE
> +	help
> +	  Arm Generic Diagnostic Dump and Reset Device Interface (AGDI) is
> +	  a standard that enables issuing a non-maskable diagnostic dump and
> +	  reset command.
> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> index 66acbe77f46e..7b9e4045659d 100644
> --- a/drivers/acpi/arm64/Makefile
> +++ b/drivers/acpi/arm64/Makefile
> @@ -1,4 +1,5 @@
>   # SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_ACPI_AGDI) 	+= agdi.o
>   obj-$(CONFIG_ACPI_IORT) 	+= iort.o
>   obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
>   obj-y				+= dma.o
> diff --git a/drivers/acpi/arm64/agdi.c b/drivers/acpi/arm64/agdi.c
> new file mode 100644
> index 000000000000..6525ccbae5c1
> --- /dev/null
> +++ b/drivers/acpi/arm64/agdi.c
> @@ -0,0 +1,125 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * This file implements handling of
> + * Arm Generic Diagnostic Dump and Reset Interface table (AGDI)
> + *
> + * Copyright (c) 2021, Ampere Computing LLC
> + */
> +
> +#define pr_fmt(fmt) "ACPI: AGDI: " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/acpi.h>
> +#include <linux/arm_sdei.h>
> +#include <linux/io.h>

Please keep the head files in alphabetical order.

> +
> +struct agdi_data {
> +	int sdei_event;
> +};
> +
> +static int agdi_sdei_handler(u32 sdei_event, struct pt_regs *regs, void *arg)
> +{
> +	nmi_panic(regs, "Arm Generic Diagnostic Dump and Reset SDEI event issued");
> +	return 0;
> +}
> +
> +static int agdi_sdei_probe(struct platform_device *pdev,
> +			   struct agdi_data *adata)
> +{
> +	int err;
> +
> +	err = sdei_event_register(adata->sdei_event, agdi_sdei_handler, pdev);
> +	if (err) {
> +		dev_err(&pdev->dev, "Failed to register for SDEI event %d",
> +			adata->sdei_event);
> +		return err;
> +	}
> +
> +	err = sdei_event_enable(adata->sdei_event);
> +	if (err)  {
> +		sdei_event_unregister(adata->sdei_event);
> +		dev_err(&pdev->dev, "Failed to enable event %d\n",
> +			adata->sdei_event);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int agdi_probe(struct platform_device *pdev)
> +{
> +	struct agdi_data *adata;
> +
> +	adata = dev_get_platdata(&pdev->dev);
> +	if (!adata)
> +		return -EINVAL;
> +
> +	return agdi_sdei_probe(pdev, adata);
> +}
> +
> +static int agdi_remove(struct platform_device *pdev)
> +{
> +	struct agdi_data *adata = platform_get_drvdata(pdev);
> +
> +	sdei_event_disable(adata->sdei_event);
> +	sdei_event_unregister(adata->sdei_event);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver agdi_driver = {
> +	.driver = {
> +		.name = "agdi",
> +	},
> +	.probe = agdi_probe,
> +	.remove = agdi_remove,
> +};
> +
> +static int __init agdi_init(void)
> +{
> +	int ret;
> +	acpi_status status;
> +	struct acpi_table_agdi *agdi_table;
> +	struct agdi_data pdata;
> +	struct platform_device *pdev;
> +
> +	if (acpi_disabled)
> +		return 0;
> +
> +	status = acpi_get_table(ACPI_SIG_AGDI, 0,
> +				(struct acpi_table_header **) &agdi_table);
> +	if (ACPI_FAILURE(status))
> +		return -ENODEV;
> +
> +	if (agdi_table->flags & ACPI_AGDI_SIGNALING_MODE) {
> +		pr_warn("Interrupt signaling is not supported");
> +		ret = -ENODEV;
> +		goto err_put_table;
> +	}
> +
> +	pdata.sdei_event = agdi_table->sdei_event;
> +
> +	pdev = platform_device_register_data(NULL, "agdi", 0, &pdata, sizeof(pdata));
> +	if (IS_ERR(pdev)) {
> +		ret = PTR_ERR(pdev);
> +		goto err_put_table;
> +	}
> +
> +	ret = platform_driver_register(&agdi_driver);
> +	if (ret)
> +		goto err_device_unregister;
> +
> +	acpi_put_table((struct acpi_table_header *)agdi_table);
> +	return 0;
> +
> +err_device_unregister:
> +	platform_device_unregister(pdev);
> +err_put_table:
> +	acpi_put_table((struct acpi_table_header *)agdi_table);
> +	return ret;
> +}
> +device_initcall(agdi_init);

The rest are looking good to me.

Thanks
Hanjun
