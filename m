Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D450E484E96
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 08:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237930AbiAEHFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 02:05:31 -0500
Received: from mail-bn8nam11on2101.outbound.protection.outlook.com ([40.107.236.101]:61440
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229593AbiAEHFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 02:05:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQUGY+ARgPL2vbwZtL5gGvXss7KHeytHTvDYj6/Qf/l6oxm9DohtCkUCSMoC/zos5oALErjZkoMuDRFp91G0uypx7RH6V1fcLP44TqjE+3xopcKsKJpdYthwhhWseL1ctQwTQGNc3z4RAVkWYsoXK2NvH3w7FMEtseqEd4wgZFDbnTwAIy/36KXv8rhYnd0I26RGkF0i+cDYGBbHCal+frG2eYs8Pwy/0L5O5VjxjKyzACBiOAfEz4vSlBF89uP6thCg3L/tNuIAcEn1W80tyo15YTA8N8MR12bpkQ3LVGA4ijBZnH2kvK/b55/o8lZtHeTmNKb/Oy4JrtshqczOSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m87EJE/sh/5hWumAN3FeEfhCFS1F77fNvx8j8iQik9Q=;
 b=VXzi2SW3CSi9k/NtymFjSJY1uYnCJVmO6+4vIUs1UzP9G6Lg87JiMWdkRgYXMX0pXXFx49TSTg4cJu/E8hkcQNlR8HUGwFrJ39h4vv2GY1prGiw+M9RY7kCjszRsBiP9W8zTkYfHJUuhHKH6EtOl5xAJJruCrBjhozWdPfzryFyJQc6OjqAR81eaWPNZcB/lzRgJftpmMqDep+oH8MVksQlWfWnqBRlDQSmICwn68PHbZhdY5bLTCoqFjBVrgRZzqIJOGXSbTvm4gNYf6wz+0w4FDARBFlOelIjTh3ZuOjcXTeYbN4uBSmNBHWSPcPyCBJEm5CfaeV7uQxWNewzJ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m87EJE/sh/5hWumAN3FeEfhCFS1F77fNvx8j8iQik9Q=;
 b=fS+KTonPirZmm2xOlIdxnEa//hVnyXN/55RkLcSR+nWqA3tqbwuf/P++3zD/1HqEgDhg7PBwx/9o9F7sfZRDd4aIedtatXaTb7RWZYnb/4vB1WbQmgT7cqRUH8uKF2Sak2Qlkg27ln7R9SR0DAVIvOjQ0CjK8bzsbtLq1LeHJVI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 DM5PR0101MB3052.prod.exchangelabs.com (2603:10b6:4:2b::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.15; Wed, 5 Jan 2022 07:05:27 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::38b6:2855:7c14:274b]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::38b6:2855:7c14:274b%3]) with mapi id 15.20.4823.026; Wed, 5 Jan 2022
 07:05:27 +0000
Date:   Tue, 4 Jan 2022 23:05:11 -0800 (PST)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
X-X-Sender: ikoskine@ubuntu200401
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        patches@amperecomputing.com, scott@os.amperecomputing.com,
        darren@os.amperecomputing.com
Subject: Re: [PATCH v3 2/2] ACPI: AGDI: Add driver for Arm Generic Diagnostic
 Dump and Reset device
In-Reply-To: <CAJZ5v0g7OeQ=pa-7j+5NDMjbAsr89FUg09u0i2k98uJWf_GgTg@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2201042253340.2515@ubuntu200401>
References: <20211231033725.21109-1-ilkka@os.amperecomputing.com> <20211231033725.21109-3-ilkka@os.amperecomputing.com> <CAJZ5v0g7OeQ=pa-7j+5NDMjbAsr89FUg09u0i2k98uJWf_GgTg@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: MWHPR14CA0061.namprd14.prod.outlook.com
 (2603:10b6:300:81::23) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 416ef99c-0912-45c2-de6c-08d9d019c01d
X-MS-TrafficTypeDiagnostic: DM5PR0101MB3052:EE_
X-Microsoft-Antispam-PRVS: <DM5PR0101MB30521F042E0429065D7FAD8D9D4B9@DM5PR0101MB3052.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RIpKxb2n1a5hkzgfnOEA0YEg3C6+SDKH0jjhCpTwAa9KdRQNLs+UpFKXF3PPBORZvJcD38HI+J/pnrvw78tY4Da55VhryCeBI9B9q14A6AswVsf6H5F1lJ121CCcYgm8bY8ndOy95++hWuLVhtJhX9YDEyePK0In+kSSnCsVh3ydCfRE+9SLzmBo/wJh+NAxLFpSa8nBBpYGPAXmds2GHL8pfoqx5pC9I0RSnojPopECEOVvmB7dZWfg7mwQshjwebE2tEJ8xHUdFXjO3iLw2Ktxa6QA1FRrl5qQr+o9X83cri+b7Li/4Y0hHr6PnGC4WdZI2hpl4uwowWhgusUjU89ZDsLdgt5xqb3cTLkJRzM6bTPC/+Xx3oJFkTsgGnDk7yazdFEUF07aSJWJUZ0wTTvCdxpJkZAhT14TI7pLMctlH0pfn/Q5uz342nbC3bbsbcRLJ9g9u9mIK7E+4kErAWVeMRkE+pETXHb5O1x47KVWbqz5+TdkKdSVHlm3QR6xQb2AAOeZS0o7UhSI12AXjM1xS4BNWHfnTqnpDKKMKxU5RAk4zig+KPlhN914+FP80CFahk6UlXM0fUnpt0jYlK+ViUNlY3Ne43FnnqJ6JHOZhbF3/jqeCwawWShghe0+2XX2uO5uEaiFJ0P1uMapYjL9Fma/Uqy0Fky3FNhNdBpblvhm5XytcvnUfhNW9eM/57vPAyT9CaEcwT9nIzVJp/xEW5knX25Drz/SzrNQXHncuWrWgGWuVwRnWTkXF8PtD2rLGtB4chQYbTs5ARpehOYf8e8WJDLHcJ0A2bsZeCdi1k0NQpnOTxxo3zQU2yIw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(4326008)(8936002)(38350700002)(86362001)(53546011)(66946007)(6506007)(6486002)(6666004)(508600001)(5660300002)(9686003)(6512007)(8676002)(38100700002)(66476007)(66556008)(33716001)(186003)(83380400001)(6916009)(966005)(316002)(52116002)(107886003)(26005)(2906002)(7416002)(54906003)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s62PiPYF6eo0zxoEY/BbCWUAA6YYd0KSe1Oawnlab3tZhlxgisFHzX9g6e9s?=
 =?us-ascii?Q?Y0AciMa/7I5gzawGypWezY8SdHuNLS1MX/TtwATPDx3Z6Qxw+Oe07CXX1FFH?=
 =?us-ascii?Q?9uofW68seOGR5JUUCZbNMJtVCOcj0Rzcl1TeLIoieHNCyUIRpFP9Bny2aMgt?=
 =?us-ascii?Q?j9bustmcv5anqEWZL+zpq1SNqRKjYfytMSPXZcO+qHyyitqqGuup9gBDK4m0?=
 =?us-ascii?Q?7j54sZkAad7PwOwxwObCMVLQn/IbWY8gTJTwKpZXoM8KDbqR5OTOhdomPoWN?=
 =?us-ascii?Q?H/El/dG+8+R00ciF5JkslUhC9Xo7E7lW03aU7C20C+w5UTqxY8Jcwux7aejO?=
 =?us-ascii?Q?Wssth0eTCVhr2Rz7J2O6weSpWWRiaGsdT2jZ5JLeg0WJDHl2J0SY2ZjVmsvK?=
 =?us-ascii?Q?1+BjxBO89FSCZ+tO44BbQgqU3rHrQv8xPtmVVQcVEP7pH0aF0kxhDOjncXSy?=
 =?us-ascii?Q?/CVkLxuWUnJP3uC0CD1DITzOStWi7DlRkFT3WVYv8gd2wNx80JDUGl+4MqpN?=
 =?us-ascii?Q?qhYEHM8CoIcnZrUq/ZmKHgxNvn82lXgQ9nQZaWmowfUWUeZ0RIIGG7b9PD9L?=
 =?us-ascii?Q?Amo5BgjgldvNq3r+VBJZgGwE6JO+XfbVilq5MXvgwfFzu+exIc1N1gzB+zxU?=
 =?us-ascii?Q?NxzLJv0HDI8jtirebmpn+LZE9AaOgCJO6LWlS+kFrRIbt4EnMsYPMkehycAm?=
 =?us-ascii?Q?T4PqbiJ/b5XIQi9J/lRVQ3It7npQFuZ8dZzgnWOBM463zcId5XcNBlIVEcDM?=
 =?us-ascii?Q?UfSWps6f4ikdLscsIDDvnSHrCbxGG9VStwQv/vrSnASlNJ/RVQyVk6YkTwji?=
 =?us-ascii?Q?18Jxap6mE1DCvqtk3v+Og64byG54fL4taHohkVbzdOTei01CrNOUnAfVM0r9?=
 =?us-ascii?Q?2QWgyrMe4UP+hN1f/kC37dCT8VurOKNfm6x3eFHYqnjgP++8QWJJokzUILvy?=
 =?us-ascii?Q?AE4C03tTuvMsqfHgX8sNLzIq6dQGppww1bFLLVv+hwETFHaSdWpW7SkLz5Mo?=
 =?us-ascii?Q?+nbanqPmBOB5a9hLCHFaKOUX9JOxx900nwH6ZZMa+t+a2S+n2imlMlGWO71X?=
 =?us-ascii?Q?r6GdWij1Sn/UHD2RHdqL9VoxEoTKx/2EGPh+s3smKDQ8sxtjXncuOce9mvyh?=
 =?us-ascii?Q?sT1cS9npFRUZBt0QsacnRo7DZIpJ9uu4l2NRQINo4f6nA/En4HAK5rz2xKFi?=
 =?us-ascii?Q?xBtDkazLFphBexoHd6DGcysXJUgVCIv+eGxV7znjdKtr+hx5nnlTZDzqKrEQ?=
 =?us-ascii?Q?dI/y7J4AMciXx0Q5l5HviizuG6hgvTf+E9ECj37ktXeU0q0KSTzmTcD03Ydm?=
 =?us-ascii?Q?h3S5hYhIoJgDRkIoIyrOLOJJGlZylJQ9O0c3LMafleR1NddM9SGfQZUb0G4J?=
 =?us-ascii?Q?ltLJwWDZd9Kky9Kr0A10RbwOUEpRyosBjInuceKtHl4321Wb+44p/lu8I3Lx?=
 =?us-ascii?Q?y9Ow/ugKN2K8UA67PADYPwwL/GOqDq1fL+PW3UeEdkf1eMj+FUaoUCKAZGBl?=
 =?us-ascii?Q?746dSd05Hi+GvlsAHR0T/wiWqJYB+URbfDzjvHkd3ID2jpfeoLktZTefx3e2?=
 =?us-ascii?Q?5UHO8vATdhTGDh/ntA218NgGFIP/pPGemTKZAnemctBPX5vLhEfRqJc+2fUr?=
 =?us-ascii?Q?Kz2I+igEM65DHSaPNIP9kOXl/tCkpTq2sfVeX/pqv+VHk5hNv4xDMP/NvodW?=
 =?us-ascii?Q?NdL15BIUODMq79J5Olg6WZ62Z9EhyblpTZXXfWUpoih4Y7bMP7zEELNAGTaz?=
 =?us-ascii?Q?U1Bv5sMMrA=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 416ef99c-0912-45c2-de6c-08d9d019c01d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 07:05:26.9797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zd3+AtV6FxWWqKZvMZBReeo0NiIdlKMh1h8WjZ+cNjieGUI+XHTnUvBR8Xb/Czls23o0EO4J/NcUQWwMoJNeLLerBroixUqvEP/4YOCLf12DOJNS1ENDJzndpzSHoDk/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0101MB3052
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rafael,

On Tue, 4 Jan 2022, Rafael J. Wysocki wrote:
> On Fri, Dec 31, 2021 at 4:37 AM Ilkka Koskinen
> <ilkka@os.amperecomputing.com> wrote:
>>
>> ACPI for Arm Components 1.1 Platform Design Document v1.1 [0] specifices
>> Arm Generic Diagnostic Device Interface (AGDI). It allows an admin to
>> issue diagnostic dump and reset via an SDEI event or an interrupt.
>> This patch implements SDEI path.
>>
>> [0] https://developer.arm.com/documentation/den0093/latest/
>>
>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>
> This requires an ACK from the arm64 side if you want me to take it.

That's my understanding too.

> However, I can apply patch 1 from this series if that helps.

I'm not sure, if it makes sense to pick the first patch now since there 
aren't other users for it. I'd probably keep them together although I 
don't have strong feelings about it.

Cheers, Ilkka

>
>> ---
>>  drivers/acpi/arm64/Kconfig  |   8 +++
>>  drivers/acpi/arm64/Makefile |   1 +
>>  drivers/acpi/arm64/agdi.c   | 125 ++++++++++++++++++++++++++++++++++++
>>  3 files changed, 134 insertions(+)
>>  create mode 100644 drivers/acpi/arm64/agdi.c
>>
>> diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
>> index 6dba187f4f2e..24869ba5b365 100644
>> --- a/drivers/acpi/arm64/Kconfig
>> +++ b/drivers/acpi/arm64/Kconfig
>> @@ -8,3 +8,11 @@ config ACPI_IORT
>>
>>  config ACPI_GTDT
>>         bool
>> +
>> +config ACPI_AGDI
>> +       bool "Arm Generic Diagnostic Dump and Reset Device Interface"
>> +       depends on ARM_SDE_INTERFACE
>> +       help
>> +         Arm Generic Diagnostic Dump and Reset Device Interface (AGDI) is
>> +         a standard that enables issuing a non-maskable diagnostic dump and
>> +         reset command.
>> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
>> index 66acbe77f46e..7b9e4045659d 100644
>> --- a/drivers/acpi/arm64/Makefile
>> +++ b/drivers/acpi/arm64/Makefile
>> @@ -1,4 +1,5 @@
>>  # SPDX-License-Identifier: GPL-2.0-only
>> +obj-$(CONFIG_ACPI_AGDI)        += agdi.o
>>  obj-$(CONFIG_ACPI_IORT)        += iort.o
>>  obj-$(CONFIG_ACPI_GTDT)        += gtdt.o
>>  obj-y                          += dma.o
>> diff --git a/drivers/acpi/arm64/agdi.c b/drivers/acpi/arm64/agdi.c
>> new file mode 100644
>> index 000000000000..6525ccbae5c1
>> --- /dev/null
>> +++ b/drivers/acpi/arm64/agdi.c
>> @@ -0,0 +1,125 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * This file implements handling of
>> + * Arm Generic Diagnostic Dump and Reset Interface table (AGDI)
>> + *
>> + * Copyright (c) 2021, Ampere Computing LLC
>> + */
>> +
>> +#define pr_fmt(fmt) "ACPI: AGDI: " fmt
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/acpi.h>
>> +#include <linux/arm_sdei.h>
>> +#include <linux/io.h>
>> +
>> +struct agdi_data {
>> +       int sdei_event;
>> +};
>> +
>> +static int agdi_sdei_handler(u32 sdei_event, struct pt_regs *regs, void *arg)
>> +{
>> +       nmi_panic(regs, "Arm Generic Diagnostic Dump and Reset SDEI event issued");
>> +       return 0;
>> +}
>> +
>> +static int agdi_sdei_probe(struct platform_device *pdev,
>> +                          struct agdi_data *adata)
>> +{
>> +       int err;
>> +
>> +       err = sdei_event_register(adata->sdei_event, agdi_sdei_handler, pdev);
>> +       if (err) {
>> +               dev_err(&pdev->dev, "Failed to register for SDEI event %d",
>> +                       adata->sdei_event);
>> +               return err;
>> +       }
>> +
>> +       err = sdei_event_enable(adata->sdei_event);
>> +       if (err)  {
>> +               sdei_event_unregister(adata->sdei_event);
>> +               dev_err(&pdev->dev, "Failed to enable event %d\n",
>> +                       adata->sdei_event);
>> +               return err;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int agdi_probe(struct platform_device *pdev)
>> +{
>> +       struct agdi_data *adata;
>> +
>> +       adata = dev_get_platdata(&pdev->dev);
>> +       if (!adata)
>> +               return -EINVAL;
>> +
>> +       return agdi_sdei_probe(pdev, adata);
>> +}
>> +
>> +static int agdi_remove(struct platform_device *pdev)
>> +{
>> +       struct agdi_data *adata = platform_get_drvdata(pdev);
>> +
>> +       sdei_event_disable(adata->sdei_event);
>> +       sdei_event_unregister(adata->sdei_event);
>> +
>> +       return 0;
>> +}
>> +
>> +static struct platform_driver agdi_driver = {
>> +       .driver = {
>> +               .name = "agdi",
>> +       },
>> +       .probe = agdi_probe,
>> +       .remove = agdi_remove,
>> +};
>> +
>> +static int __init agdi_init(void)
>> +{
>> +       int ret;
>> +       acpi_status status;
>> +       struct acpi_table_agdi *agdi_table;
>> +       struct agdi_data pdata;
>> +       struct platform_device *pdev;
>> +
>> +       if (acpi_disabled)
>> +               return 0;
>> +
>> +       status = acpi_get_table(ACPI_SIG_AGDI, 0,
>> +                               (struct acpi_table_header **) &agdi_table);
>> +       if (ACPI_FAILURE(status))
>> +               return -ENODEV;
>> +
>> +       if (agdi_table->flags & ACPI_AGDI_SIGNALING_MODE) {
>> +               pr_warn("Interrupt signaling is not supported");
>> +               ret = -ENODEV;
>> +               goto err_put_table;
>> +       }
>> +
>> +       pdata.sdei_event = agdi_table->sdei_event;
>> +
>> +       pdev = platform_device_register_data(NULL, "agdi", 0, &pdata, sizeof(pdata));
>> +       if (IS_ERR(pdev)) {
>> +               ret = PTR_ERR(pdev);
>> +               goto err_put_table;
>> +       }
>> +
>> +       ret = platform_driver_register(&agdi_driver);
>> +       if (ret)
>> +               goto err_device_unregister;
>> +
>> +       acpi_put_table((struct acpi_table_header *)agdi_table);
>> +       return 0;
>> +
>> +err_device_unregister:
>> +       platform_device_unregister(pdev);
>> +err_put_table:
>> +       acpi_put_table((struct acpi_table_header *)agdi_table);
>> +       return ret;
>> +}
>> +device_initcall(agdi_init);
>> --
>> 2.17.1
>>
>
