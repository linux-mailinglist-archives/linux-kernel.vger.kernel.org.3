Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8938F484359
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbiADO3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:29:10 -0500
Received: from mail-qt1-f170.google.com ([209.85.160.170]:45596 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiADO3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:29:09 -0500
Received: by mail-qt1-f170.google.com with SMTP id p19so34163745qtw.12;
        Tue, 04 Jan 2022 06:29:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jM7E4gCfGfoxFgJWleKBX6TQJqRfmyF+wiCFJCnxwsY=;
        b=NvMh+I2xn0kEXqfTzozNo5mBxrPbP8gZxgO8EEG2+iujNAIQajbpjmjhrrDMtA4awR
         LrZDB4vdH0OpdoX6AfGQlKRtruFMwxoYjw2S4Dq0PAx8Mi0L6tpMtiuJ7VuAEk8yAqYH
         Mx6SxDysTPKqB8TTQXqArHfMcoCD53EsNnqdATAaCMWkk2hT/rjOduxyuW9yFT5J0vM5
         1qWzZzZLXx4nLWosr5x7aP5XVfB1qaxMSw5rKvHhnBsiuM4bbgudSptog4dpHFdJzlYq
         7PsUGYPnzd15oE3Re1sE0W/AkF0mUSkLKE5x2Z8ps5SVOI1gQvoyNE1Gp5mbILjGGHPg
         JXtg==
X-Gm-Message-State: AOAM532cyTF8ahDWnufIkMveWEZIX+A1fFqUH1YBI7EHtiUC55KAY77A
        AX62AsNZ06fPm9Lwu/Agbh0Wh47po/zlM/Mff8M=
X-Google-Smtp-Source: ABdhPJxiYw0hjxleNX0kQWec5f6uBBGQD85+lmRpch781LiXQQcr8l2Pp1UYWapsxJOssbspB8PYy5xFMB4Si3aE+L8=
X-Received: by 2002:ac8:5c91:: with SMTP id r17mr45828345qta.18.1641306549106;
 Tue, 04 Jan 2022 06:29:09 -0800 (PST)
MIME-Version: 1.0
References: <20211231033725.21109-1-ilkka@os.amperecomputing.com> <20211231033725.21109-3-ilkka@os.amperecomputing.com>
In-Reply-To: <20211231033725.21109-3-ilkka@os.amperecomputing.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 4 Jan 2022 15:28:57 +0100
Message-ID: <CAJZ5v0g7OeQ=pa-7j+5NDMjbAsr89FUg09u0i2k98uJWf_GgTg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ACPI: AGDI: Add driver for Arm Generic Diagnostic
 Dump and Reset device
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        patches@amperecomputing.com, scott@os.amperecomputing.com,
        darren@os.amperecomputing.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2021 at 4:37 AM Ilkka Koskinen
<ilkka@os.amperecomputing.com> wrote:
>
> ACPI for Arm Components 1.1 Platform Design Document v1.1 [0] specifices
> Arm Generic Diagnostic Device Interface (AGDI). It allows an admin to
> issue diagnostic dump and reset via an SDEI event or an interrupt.
> This patch implements SDEI path.
>
> [0] https://developer.arm.com/documentation/den0093/latest/
>
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

This requires an ACK from the arm64 side if you want me to take it.

However, I can apply patch 1 from this series if that helps.

> ---
>  drivers/acpi/arm64/Kconfig  |   8 +++
>  drivers/acpi/arm64/Makefile |   1 +
>  drivers/acpi/arm64/agdi.c   | 125 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 134 insertions(+)
>  create mode 100644 drivers/acpi/arm64/agdi.c
>
> diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
> index 6dba187f4f2e..24869ba5b365 100644
> --- a/drivers/acpi/arm64/Kconfig
> +++ b/drivers/acpi/arm64/Kconfig
> @@ -8,3 +8,11 @@ config ACPI_IORT
>
>  config ACPI_GTDT
>         bool
> +
> +config ACPI_AGDI
> +       bool "Arm Generic Diagnostic Dump and Reset Device Interface"
> +       depends on ARM_SDE_INTERFACE
> +       help
> +         Arm Generic Diagnostic Dump and Reset Device Interface (AGDI) is
> +         a standard that enables issuing a non-maskable diagnostic dump and
> +         reset command.
> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> index 66acbe77f46e..7b9e4045659d 100644
> --- a/drivers/acpi/arm64/Makefile
> +++ b/drivers/acpi/arm64/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_ACPI_AGDI)        += agdi.o
>  obj-$(CONFIG_ACPI_IORT)        += iort.o
>  obj-$(CONFIG_ACPI_GTDT)        += gtdt.o
>  obj-y                          += dma.o
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
> +
> +struct agdi_data {
> +       int sdei_event;
> +};
> +
> +static int agdi_sdei_handler(u32 sdei_event, struct pt_regs *regs, void *arg)
> +{
> +       nmi_panic(regs, "Arm Generic Diagnostic Dump and Reset SDEI event issued");
> +       return 0;
> +}
> +
> +static int agdi_sdei_probe(struct platform_device *pdev,
> +                          struct agdi_data *adata)
> +{
> +       int err;
> +
> +       err = sdei_event_register(adata->sdei_event, agdi_sdei_handler, pdev);
> +       if (err) {
> +               dev_err(&pdev->dev, "Failed to register for SDEI event %d",
> +                       adata->sdei_event);
> +               return err;
> +       }
> +
> +       err = sdei_event_enable(adata->sdei_event);
> +       if (err)  {
> +               sdei_event_unregister(adata->sdei_event);
> +               dev_err(&pdev->dev, "Failed to enable event %d\n",
> +                       adata->sdei_event);
> +               return err;
> +       }
> +
> +       return 0;
> +}
> +
> +static int agdi_probe(struct platform_device *pdev)
> +{
> +       struct agdi_data *adata;
> +
> +       adata = dev_get_platdata(&pdev->dev);
> +       if (!adata)
> +               return -EINVAL;
> +
> +       return agdi_sdei_probe(pdev, adata);
> +}
> +
> +static int agdi_remove(struct platform_device *pdev)
> +{
> +       struct agdi_data *adata = platform_get_drvdata(pdev);
> +
> +       sdei_event_disable(adata->sdei_event);
> +       sdei_event_unregister(adata->sdei_event);
> +
> +       return 0;
> +}
> +
> +static struct platform_driver agdi_driver = {
> +       .driver = {
> +               .name = "agdi",
> +       },
> +       .probe = agdi_probe,
> +       .remove = agdi_remove,
> +};
> +
> +static int __init agdi_init(void)
> +{
> +       int ret;
> +       acpi_status status;
> +       struct acpi_table_agdi *agdi_table;
> +       struct agdi_data pdata;
> +       struct platform_device *pdev;
> +
> +       if (acpi_disabled)
> +               return 0;
> +
> +       status = acpi_get_table(ACPI_SIG_AGDI, 0,
> +                               (struct acpi_table_header **) &agdi_table);
> +       if (ACPI_FAILURE(status))
> +               return -ENODEV;
> +
> +       if (agdi_table->flags & ACPI_AGDI_SIGNALING_MODE) {
> +               pr_warn("Interrupt signaling is not supported");
> +               ret = -ENODEV;
> +               goto err_put_table;
> +       }
> +
> +       pdata.sdei_event = agdi_table->sdei_event;
> +
> +       pdev = platform_device_register_data(NULL, "agdi", 0, &pdata, sizeof(pdata));
> +       if (IS_ERR(pdev)) {
> +               ret = PTR_ERR(pdev);
> +               goto err_put_table;
> +       }
> +
> +       ret = platform_driver_register(&agdi_driver);
> +       if (ret)
> +               goto err_device_unregister;
> +
> +       acpi_put_table((struct acpi_table_header *)agdi_table);
> +       return 0;
> +
> +err_device_unregister:
> +       platform_device_unregister(pdev);
> +err_put_table:
> +       acpi_put_table((struct acpi_table_header *)agdi_table);
> +       return ret;
> +}
> +device_initcall(agdi_init);
> --
> 2.17.1
>
