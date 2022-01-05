Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C26485C6B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 00:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245510AbiAEXrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 18:47:02 -0500
Received: from mail-bn7nam10on2096.outbound.protection.outlook.com ([40.107.92.96]:40032
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245501AbiAEXq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 18:46:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtSPmbKn8Q2hw/XlrhWqe19fFhecX2eGemPQqJ6MLRGzQsTL5XeYpm2+hmchClYbeKNyzjr3IedmkZdv/0eA99SiEJGrTR4HOWbY1f6/a8La+UshqJMOZ2/lyCf4o0KGr7/q0XtAG9KQCJxdYoj60X48SVd7S11J42tY25ieQ67w7mDJKidB0/LtnjBj5JDfzS4hzp8LlJSJiSjC/vc1P5YQNT7dSuXPB/nYoHr4ZbcrAEoC7JWWJiIs1XI2FE639cgw9tPsJVAzTXq8xUIsVjxERh8YN7Mj3LkKBasdtNB3xTnWmKaQdIkuod2GF//tjG9Lwt2NQ9CLTNQAuuMn2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8A4GYR/IyS1+BnpeD4jUIcwF31RWJJEk2Zy9gladBQ=;
 b=h6d2SJbXx4CS/I0PMAp37bgj7Kcb9t9UPPkdu+4S2Yf3M/LQiwg6EvhqJ45yM6nX94gJy9RntJEq4aOm8V7z5zRXSiDe+AYeRjyj8AssmBiQl1v7BT7yphMmga0rNv5TJh2Ja0xsoHlMoU3rjfsBBbylrIBQdqhllsYkkdMZUniGHqE/OpUbiY/RpASw2BgZRO3XOjMR8OddYSPPavqdpF5MCQwK6xvPGqGSSypFFPiB9LF4YZEAIrBedaLXS8l7f/Z2Abs0x/Kdt+INgDdx0f370Xg4CAekmxklhVgr6hvARKpClqgyvtnfqyBt+pLKGMychwEwqkbKv3J46e08KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8A4GYR/IyS1+BnpeD4jUIcwF31RWJJEk2Zy9gladBQ=;
 b=eTIbSshAExPcJJUODLBL2PERNroBgyBPDbT3w7lO5pGO8OC6ZfZ3DwUJzOr1U/qa08NmigJk/9SRmwuXf1QPbZ/u7siRGXgTlWl9cnbmnrlD0D8rqW5HTQiX3EGoh+Y7i8UEBc9HY6+AneGMBeTcI/NRXMT+uL9s7XgW+/cqhqk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 DM6PR01MB5194.prod.exchangelabs.com (2603:10b6:5:b::19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.14; Wed, 5 Jan 2022 23:46:54 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::38b6:2855:7c14:274b]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::38b6:2855:7c14:274b%3]) with mapi id 15.20.4823.026; Wed, 5 Jan 2022
 23:46:54 +0000
Date:   Wed, 5 Jan 2022 15:46:38 -0800 (PST)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
X-X-Sender: ikoskine@ubuntu200401
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org,
        linux@armlinux.org.uk, lenb@kernel.org, robert.moore@intel.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com,
        scott@os.amperecomputing.com, darren@os.amperecomputing.com,
        james.morse@arm.com
Subject: Re: [PATCH v3 2/2] ACPI: AGDI: Add driver for Arm Generic Diagnostic
 Dump and Reset device
In-Reply-To: <20220105104602.GA4752@lpieralisi>
Message-ID: <alpine.DEB.2.22.394.2201051530290.2489@ubuntu200401>
References: <20211231033725.21109-1-ilkka@os.amperecomputing.com> <20211231033725.21109-3-ilkka@os.amperecomputing.com> <20220105104602.GA4752@lpieralisi>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: MW4PR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:303:b6::8) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e857a8bd-2394-405e-edaa-08d9d0a5a723
X-MS-TrafficTypeDiagnostic: DM6PR01MB5194:EE_
X-Microsoft-Antispam-PRVS: <DM6PR01MB51949F15810EC1FB26C5FAA09D4B9@DM6PR01MB5194.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jrQKz6VAG/d8qkrPbe397rB9q1jHkZ3y0kInFbtsXd6WSTZobZcuVpZ8ciTOPNfS9ka3PThc4F8T1XUw87raygmyuY8tEUAzsriotjbEXDfp6033EcIv6WA65651NlfO5EYby6cpO9YDR9ixZ0IRQ0bSGZHmbbqO0+HucgDlbBt0hQSxJgeVdKCnuHZsxaN7NBDtDMVysyddO+B5IZXKZ+4kkAoe8oCjS/LwEIiE/jbfr+XxG/b64iAfy0Z2lIhsbw74F36vPQXiMTQuv+gYj0aXNMoyf8hcCo45eN8EmvSwfuF0uVsSKBaULx0D3avCCkP2HMtV6L91ut0jYxwSz40c6V1xi+ego9O0bnXlxvnSdQrdBZm8fAnevX3BAIhRbXdof2l1fQy7OgmYPfZOlhmGJh/xM4CNPtNGRLvPSJ4yRDm0ycFUc+Lnw5hoHLNPQvKtA9KqHsMMQbTpZUlFrV+kG/NG+/TEpAmiWLLIdQwlu9pw3Yzxd4hpijp8a9H4XZ2GiaefrVGEfsejdbLuPXZBNly+LZBzt47ICA8stsFJAacIkHdS0uCJryQlPGL8tDF3RcJGQWGbPz8rpgco2A83OdheAdPpT1Bef3ZRy0q4AT+riZNrviyu1nMRfjJpPAj8mQzTmosLNhiDiWveWsQ6W56cm+fSwMphgnl2Tup+7wf1EpQr1k40UB15yPZstYrgByj084MlExdOhDlGlzgg4zeIvhUD6ZUMTi7JytgHw2bbpg0M0yeWVpxkuS1x8H0MsgJuaRjMlxTH0fRLSjW4OJj7GCuZ+sfe74litxwpnQRGjVZP7qBgQdcOvFlp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(38350700002)(38100700002)(8676002)(6506007)(186003)(5660300002)(966005)(2906002)(6666004)(52116002)(86362001)(4326008)(33716001)(6512007)(9686003)(316002)(83380400001)(66556008)(66476007)(26005)(66946007)(6916009)(7416002)(6486002)(8936002)(508600001)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J7biHrW9cqY9+fSoeC0hZcCl/B0Ql/cfjI7SSX29aRxnDzWIlAwQwcNnsKdF?=
 =?us-ascii?Q?E2g/6HrPbuozQDfrG/SAlGLfYcizFLblzKBimdUYvHEYPsdaX/HpknjS3vj2?=
 =?us-ascii?Q?HVWr07HcHb+RJuflKbrx8evOQdVxuTJp/wIISHlId6qML+O0iu62taEiIgrP?=
 =?us-ascii?Q?0shLcv9h+OjbC4TDtdmzJYF5mvsTAmDKJW/drPoOTlZi3w59wMCN+AtxZL3H?=
 =?us-ascii?Q?oeY4YEM20onBiWMA9hXS6xP5702xkJLNbdS0u/y5uOUO7ehYyBfp7iBWEYpC?=
 =?us-ascii?Q?JO0UGslCgx95keWEEaReHKk3Oh0OalA619H0BoQpSaiRaGZ1T6bx6S4hAJpK?=
 =?us-ascii?Q?EF8VDK1YjD8jm3I701LJacahPnnGy3JA+eBuTO8Nox5y5xy2Fb7l1Y6aXE4Q?=
 =?us-ascii?Q?9BnVEsp8q7IwSkeRgZrqk52ZjjlOa5Bo89WHQf6asScxiMpulfa32XhBPw9h?=
 =?us-ascii?Q?gr4PMs+2+T03TFe5nVKaDiVN9MUnU8wglwRSu9ME3YaB1LDv0Q/rt/bsYzxg?=
 =?us-ascii?Q?oBVlsXKw6zl+okT9UB75e17ubu4RDgp5M37Iu3lj0ska4jIrLC3y31lskLsA?=
 =?us-ascii?Q?AWwsRDy2r0T6XW1sARRcpCqnItyBddBJOBBdPlxgshKD3LCycf02QJRmYP4p?=
 =?us-ascii?Q?g05vcaGF2x/hswTvCqi4TPSq2QdJ5RlBMmr5HqFJi8ix6/953K8nTS39FrtK?=
 =?us-ascii?Q?bT4tvD23y5MED/Z97m1sxRji9ZwqI9nvz7GxaxYHdv8glI4INExp8wiJS6kG?=
 =?us-ascii?Q?bD/t9vP+NjMa61CuS+8eWNgVvNiLoOKN3jNBAapwlJDti8eSeD3dGErDgSwC?=
 =?us-ascii?Q?KGi9IIQIEI80AW2vZgKIrdRX5oeO5p0qeDSiqoodzIc7zMz79HXIgm37nTTH?=
 =?us-ascii?Q?XqV630NNVCRsUdc8ANvki+FOpYtr5B9N1gcghvvpJpf5F6Sbaf6Ex1BvqthG?=
 =?us-ascii?Q?WAjPEUEpz4Y7wKA92Zu3EmrwV+pTON3Z5E8qg397b6/4WB7SFvRzoIMtKSF4?=
 =?us-ascii?Q?9jEHp1+QJIkgkzaxedPFWW84L7HSP4Iqz2XedHNaOqXzLMpQHokbjQKk6l2l?=
 =?us-ascii?Q?IDHDvDTW7NgGbTK5ogpoVKcdV1hE/GHtzheeoagEeMdSxhpi3jn3tu6PJlPu?=
 =?us-ascii?Q?SdczCnF//bHPtVTPlMTJGD/v1sN9r/8rVGxjUPDyfrpBiM8DIwGupbSB5Xno?=
 =?us-ascii?Q?UvIfb3LErGgzotccOxbZQUV4y+p4VLG2NSLhBgQJJmgypl/8BNf/V318Lm33?=
 =?us-ascii?Q?jbBm1FUtD35J5dJvoiCYPRo0Q+ZY8od10OdgwOjXjt5V4KaeGA1X8zsxTydt?=
 =?us-ascii?Q?cVfN2trDP2qvYXEqt5hO/NM6knJTpHRVHPdZK4VjTIF8hHsOUxIf6Zhccr+E?=
 =?us-ascii?Q?CTL80HPywu3Ikp2XVSgf+fRZozihyaWUanSlusRcCObTS4aGmig++eWq5FjV?=
 =?us-ascii?Q?7avjqt1aI++r53gs79EpGiq4gIo+WumhExizBznqToRrU571pYxnoThohmcy?=
 =?us-ascii?Q?0LzKHUlOYVmGGY7TAeODNMNYi6v261d3RtGsgg1IjW3lkzGeYZwwGHsmOSub?=
 =?us-ascii?Q?w9qe5qtTlaZPiYoBDM6Ex/AURItVkvhXOPE16zRDeDCuGuflOE68uGPYIO+s?=
 =?us-ascii?Q?XB1Kh1HXcM2A9UQHrDSpbyrYVE1a1x+ciQTdsSBKWOT65dWMuHBiOv9eiZ9b?=
 =?us-ascii?Q?QsnJd+WzqbgNZ7ZbBt0rV7oX4t0kz9joz8WDDl9EvsBaC7bDAY/kYV3L0+H0?=
 =?us-ascii?Q?pxxD71kCdw=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e857a8bd-2394-405e-edaa-08d9d0a5a723
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 23:46:54.5560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3otfF0mg+0yMrvlYhjIRD7sC/WP/Ac/VBKHJUE0+JUuEEtz4l7cmUH+EccGkEHs081ZTpJeNWMj4ih0ZXUiiCFA9ZpWsHvPP4dy+77ANDcYwr3DdgKVyQL2Wx/Z+RT8t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB5194
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Lorenzo,

On Wed, 5 Jan 2022, Lorenzo Pieralisi wrote:
> [+James, for SDEI bits]
>
> On Thu, Dec 30, 2021 at 07:37:25PM -0800, Ilkka Koskinen wrote:
>> ACPI for Arm Components 1.1 Platform Design Document v1.1 [0] specifices
>> Arm Generic Diagnostic Device Interface (AGDI). It allows an admin to
>> issue diagnostic dump and reset via an SDEI event or an interrupt.
>> This patch implements SDEI path.
>>
>> [0] https://developer.arm.com/documentation/den0093/latest/
>>
>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
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
>>  	bool
>> +
>> +config ACPI_AGDI
>> +	bool "Arm Generic Diagnostic Dump and Reset Device Interface"
>> +	depends on ARM_SDE_INTERFACE
>> +	help
>> +	  Arm Generic Diagnostic Dump and Reset Device Interface (AGDI) is
>> +	  a standard that enables issuing a non-maskable diagnostic dump and
>> +	  reset command.
>> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
>> index 66acbe77f46e..7b9e4045659d 100644
>> --- a/drivers/acpi/arm64/Makefile
>> +++ b/drivers/acpi/arm64/Makefile
>> @@ -1,4 +1,5 @@
>>  # SPDX-License-Identifier: GPL-2.0-only
>> +obj-$(CONFIG_ACPI_AGDI) 	+= agdi.o
>>  obj-$(CONFIG_ACPI_IORT) 	+= iort.o
>>  obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
>>  obj-y				+= dma.o
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
>
> Nit: alphabetical order.

I clean them

>
>> +
>> +struct agdi_data {
>> +	int sdei_event;
>> +};
>> +
>> +static int agdi_sdei_handler(u32 sdei_event, struct pt_regs *regs, void *arg)
>> +{
>> +	nmi_panic(regs, "Arm Generic Diagnostic Dump and Reset SDEI event issued");
>> +	return 0;
>> +}
>> +
>> +static int agdi_sdei_probe(struct platform_device *pdev,
>> +			   struct agdi_data *adata)
>> +{
>> +	int err;
>> +
>> +	err = sdei_event_register(adata->sdei_event, agdi_sdei_handler, pdev);
>> +	if (err) {
>> +		dev_err(&pdev->dev, "Failed to register for SDEI event %d",
>> +			adata->sdei_event);
>> +		return err;
>> +	}
>> +
>> +	err = sdei_event_enable(adata->sdei_event);
>> +	if (err)  {
>> +		sdei_event_unregister(adata->sdei_event);
>> +		dev_err(&pdev->dev, "Failed to enable event %d\n",
>> +			adata->sdei_event);
>> +		return err;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int agdi_probe(struct platform_device *pdev)
>> +{
>> +	struct agdi_data *adata;
>> +
>> +	adata = dev_get_platdata(&pdev->dev);
>> +	if (!adata)
>> +		return -EINVAL;
>> +
>> +	return agdi_sdei_probe(pdev, adata);
>> +}
>> +
>> +static int agdi_remove(struct platform_device *pdev)
>> +{
>> +	struct agdi_data *adata = platform_get_drvdata(pdev);
>> +
>> +	sdei_event_disable(adata->sdei_event);
>> +	sdei_event_unregister(adata->sdei_event);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver agdi_driver = {
>> +	.driver = {
>> +		.name = "agdi",
>> +	},
>> +	.probe = agdi_probe,
>> +	.remove = agdi_remove,
>> +};
>
> May I ask why we need a platform device (and driver) to register
> an SDEI event ?

Well, I guess I thought to have a device/driver to handle SDEI events and 
interrupts since the spec calls it a device. I can certainly remove those, 
if that's preferred.

>
>> +static int __init agdi_init(void)
>> +{
>> +	int ret;
>> +	acpi_status status;
>> +	struct acpi_table_agdi *agdi_table;
>> +	struct agdi_data pdata;
>> +	struct platform_device *pdev;
>> +
>> +	if (acpi_disabled)
>> +		return 0;
>
> Why don't we call agdi_init() from acpi_init() as we do for IORT/VIOT ?
>
> I don't think it is necessary to add a device_initcall(), with related
> ordering dependencies.

That's a good point. I change it.

>
>> +
>> +	status = acpi_get_table(ACPI_SIG_AGDI, 0,
>> +				(struct acpi_table_header **) &agdi_table);
>> +	if (ACPI_FAILURE(status))
>> +		return -ENODEV;
>> +
>> +	if (agdi_table->flags & ACPI_AGDI_SIGNALING_MODE) {
>
> Is this because specs need updating ?

Yes, that's the reason. AGDI table is missing flags that would define 
trigger type and polarity.

>
>> +		pr_warn("Interrupt signaling is not supported");
>> +		ret = -ENODEV;
>> +		goto err_put_table;
>> +	}
>> +
>> +	pdata.sdei_event = agdi_table->sdei_event;
>> +
>> +	pdev = platform_device_register_data(NULL, "agdi", 0, &pdata, sizeof(pdata));
>> +	if (IS_ERR(pdev)) {
>> +		ret = PTR_ERR(pdev);
>> +		goto err_put_table;
>> +	}
>> +
>> +	ret = platform_driver_register(&agdi_driver);
>> +	if (ret)
>> +		goto err_device_unregister;
>> +
>> +	acpi_put_table((struct acpi_table_header *)agdi_table);
>> +	return 0;
>> +
>> +err_device_unregister:
>> +	platform_device_unregister(pdev);
>> +err_put_table:
>> +	acpi_put_table((struct acpi_table_header *)agdi_table);
>> +	return ret;
>> +}
>> +device_initcall(agdi_init);
>
> See above.
>
> Thanks,
> Lorenzo
>

Cheers, Ilkka

