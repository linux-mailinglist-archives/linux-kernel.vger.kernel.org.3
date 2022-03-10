Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494CE4D4333
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbiCJJMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 04:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbiCJJM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:12:26 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57EC713776D;
        Thu, 10 Mar 2022 01:11:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 214761650;
        Thu, 10 Mar 2022 01:11:25 -0800 (PST)
Received: from lpieralisi (unknown [10.57.42.251])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9FC83FA20;
        Thu, 10 Mar 2022 01:11:21 -0800 (PST)
Date:   Thu, 10 Mar 2022 09:11:17 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org,
        linux@armlinux.org.uk, lenb@kernel.org, robert.moore@intel.com,
        james.morse@arm.com, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@amperecomputing.com, scott@os.amperecomputing.com,
        darren@os.amperecomputing.com
Subject: Re: [PATCH v6 2/2] ACPI: AGDI: Add driver for Arm Generic Diagnostic
 Dump and Reset device
Message-ID: <YinAtUVV5e24r34j@lpieralisi>
References: <20220309020750.65399-1-ilkka@os.amperecomputing.com>
 <20220309020750.65399-3-ilkka@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309020750.65399-3-ilkka@os.amperecomputing.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 06:07:50PM -0800, Ilkka Koskinen wrote:
> ACPI for Arm Components 1.1 Platform Design Document v1.1 [0] specifices
> Arm Generic Diagnostic Device Interface (AGDI). It allows an admin to
> issue diagnostic dump and reset via an SDEI event or an interrupt.
> This patch implements SDEI path.
> 
> [0] https://developer.arm.com/documentation/den0093/latest/
> 
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/acpi/arm64/Kconfig  |  10 ++++
>  drivers/acpi/arm64/Makefile |   1 +
>  drivers/acpi/arm64/agdi.c   | 116 ++++++++++++++++++++++++++++++++++++
>  drivers/acpi/bus.c          |   2 +
>  include/linux/acpi_agdi.h   |  13 ++++
>  5 files changed, 142 insertions(+)
>  create mode 100644 drivers/acpi/arm64/agdi.c
>  create mode 100644 include/linux/acpi_agdi.h

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> 
> diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
> index 6dba187f4f2e..d4a72835f328 100644
> --- a/drivers/acpi/arm64/Kconfig
> +++ b/drivers/acpi/arm64/Kconfig
> @@ -8,3 +8,13 @@ config ACPI_IORT
>  
>  config ACPI_GTDT
>  	bool
> +
> +config ACPI_AGDI
> +	bool "Arm Generic Diagnostic Dump and Reset Device Interface"
> +	depends on ARM_SDE_INTERFACE
> +	help
> +	  Arm Generic Diagnostic Dump and Reset Device Interface (AGDI) is
> +	  a standard that enables issuing a non-maskable diagnostic dump and
> +	  reset command.
> +
> +	  If set, the kernel parses AGDI table and listens for the command.
> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> index 66acbe77f46e..7b9e4045659d 100644
> --- a/drivers/acpi/arm64/Makefile
> +++ b/drivers/acpi/arm64/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_ACPI_AGDI) 	+= agdi.o
>  obj-$(CONFIG_ACPI_IORT) 	+= iort.o
>  obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
>  obj-y				+= dma.o
> diff --git a/drivers/acpi/arm64/agdi.c b/drivers/acpi/arm64/agdi.c
> new file mode 100644
> index 000000000000..4df337d545b7
> --- /dev/null
> +++ b/drivers/acpi/arm64/agdi.c
> @@ -0,0 +1,116 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * This file implements handling of
> + * Arm Generic Diagnostic Dump and Reset Interface table (AGDI)
> + *
> + * Copyright (c) 2022, Ampere Computing LLC
> + */
> +
> +#define pr_fmt(fmt) "ACPI: AGDI: " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/arm_sdei.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
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
> +	struct agdi_data *adata = dev_get_platdata(&pdev->dev);
> +
> +	if (!adata)
> +		return -EINVAL;
> +
> +	return agdi_sdei_probe(pdev, adata);
> +}
> +
> +static int agdi_remove(struct platform_device *pdev)
> +{
> +	struct agdi_data *adata = dev_get_platdata(&pdev->dev);
> +	int err, i;
> +
> +	err = sdei_event_disable(adata->sdei_event);
> +	if (err)
> +		return err;
> +
> +	for (i = 0; i < 3; i++) {
> +		err = sdei_event_unregister(adata->sdei_event);
> +		if (err != -EINPROGRESS)
> +			break;
> +
> +		schedule();
> +	}
> +
> +	return err;
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
> +void __init acpi_agdi_init(void)
> +{
> +	struct acpi_table_agdi *agdi_table;
> +	struct agdi_data pdata;
> +	struct platform_device *pdev;
> +	acpi_status status;
> +
> +	status = acpi_get_table(ACPI_SIG_AGDI, 0,
> +				(struct acpi_table_header **) &agdi_table);
> +	if (ACPI_FAILURE(status))
> +		return;
> +
> +	if (agdi_table->flags & ACPI_AGDI_SIGNALING_MODE) {
> +		pr_warn("Interrupt signaling is not supported");
> +		goto err_put_table;
> +	}
> +
> +	pdata.sdei_event = agdi_table->sdei_event;
> +
> +	pdev = platform_device_register_data(NULL, "agdi", 0, &pdata, sizeof(pdata));
> +	if (IS_ERR(pdev))
> +		goto err_put_table;
> +
> +	if (platform_driver_register(&agdi_driver))
> +		platform_device_unregister(pdev);
> +
> +err_put_table:
> +	acpi_put_table((struct acpi_table_header *)agdi_table);
> +}
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index eaa511fc9c66..87b93f4df0cf 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -26,6 +26,7 @@
>  #include <asm/mpspec.h>
>  #include <linux/dmi.h>
>  #endif
> +#include <linux/acpi_agdi.h>
>  #include <linux/acpi_iort.h>
>  #include <linux/acpi_viot.h>
>  #include <linux/pci.h>
> @@ -1386,6 +1387,7 @@ static int __init acpi_init(void)
>  	acpi_debugger_init();
>  	acpi_setup_sb_notify_handler();
>  	acpi_viot_init();
> +	acpi_agdi_init();
>  	return 0;
>  }
>  
> diff --git a/include/linux/acpi_agdi.h b/include/linux/acpi_agdi.h
> new file mode 100644
> index 000000000000..f477f0b452fa
> --- /dev/null
> +++ b/include/linux/acpi_agdi.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __ACPI_AGDI_H__
> +#define __ACPI_AGDI_H__
> +
> +#include <linux/acpi.h>
> +
> +#ifdef CONFIG_ACPI_AGDI
> +void __init acpi_agdi_init(void);
> +#else
> +static inline void acpi_agdi_init(void) {}
> +#endif
> +#endif /* __ACPI_AGDI_H__ */
> -- 
> 2.17.1
> 
