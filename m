Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F0E484E99
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 08:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237952AbiAEHKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 02:10:42 -0500
Received: from mail-dm6nam11on2090.outbound.protection.outlook.com ([40.107.223.90]:4960
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237936AbiAEHKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 02:10:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVR6TJ5iJi617rC8svcwB4xwTVZyshel/UCc1sBdiIfUWeBzzzZq1jrZEqKzoM8jcxAyAsH4ENeSP61MO8VDCRDo4BCsGiDBcbPP5S9QsSeAubBgTv/gTFqdFw9/IAo3Mzt9F6TJS6/VfWNEYZ/OqIO6bJlf8imDBVRxA4ZX+r0NESdKKZufAO422mEfArfb/v/J3TgAEqqmH/owaEn10KPzHSpe/oY+CWrNbQcAsAAm6JAYr0FTPLOlrLu1byH9O6nEWfya8gGbZ9fSM/zwgvgnV4/QntFoIF4xL6w8J9TUQBFCy+FbhL4qTLyE1dGYluLGrAqTM+eNnGPm+BwGrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oc5QX9fQBavuoMYr/u3M/PzbRw26Eub6RXKdpvA2bbk=;
 b=A4kRkV81gPoszi7rgoLNXDMdusAiU6T8SqPAsts2HFtyaFtzDVe5E+d/xKJoqMN9fKzosVjOzy0Vy4n+ViOchFzx/m7DmrAZ4wLY/vvB2BC/vI5MESshGKLji3fOm/gTjtxSeazOWFT9nT8tIkW0wBBO/SvQP7eEpzJ56ylxweft+UQVW5M0A3bIEljKNTg1+NMU54nw2flgsiVXBJB5rjCOg6B3TmdWcDSFsorui4z3c8KsuOO8HZ/o6gpFQKV52M/oj9EstIcwjpZNdsHHs2KOHrmamMPwabfCBsy9bqHIw4cHDQTCopUETRU8TSpcDTKZ51DBOY8qT25WpZcYkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oc5QX9fQBavuoMYr/u3M/PzbRw26Eub6RXKdpvA2bbk=;
 b=YF5gZBXx2iV20vBgSIvcLcnQ+lPBGetLlHR+nMusm5wQUtjh+dL5VMxtyYwzN3uDQ8XfRWig+UcRew3Lz/B0W+J9qljSuFgaqcAbKtlehrcd5EKB5W6jxCJIuDA9lyHIuzYwVZksk85Pnx4y2NvtO8ElyQN7xW/VYCtfOvdBtqQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 DM6PR01MB4636.prod.exchangelabs.com (2603:10b6:5:62::33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.16; Wed, 5 Jan 2022 07:10:32 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::38b6:2855:7c14:274b]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::38b6:2855:7c14:274b%3]) with mapi id 15.20.4823.026; Wed, 5 Jan 2022
 07:10:32 +0000
Date:   Tue, 4 Jan 2022 23:10:23 -0800 (PST)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
X-X-Sender: ikoskine@ubuntu200401
To:     Hanjun Guo <guohanjun@huawei.com>
cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, rafael@kernel.org,
        linux@armlinux.org.uk, lenb@kernel.org, robert.moore@intel.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com,
        scott@os.amperecomputing.com, darren@os.amperecomputing.com
Subject: Re: [PATCH v3 2/2] ACPI: AGDI: Add driver for Arm Generic Diagnostic
 Dump and Reset device
In-Reply-To: <f0fecf95-0b7d-eeec-94fd-76bea61fdd0f@huawei.com>
Message-ID: <alpine.DEB.2.22.394.2201042306090.2515@ubuntu200401>
References: <20211231033725.21109-1-ilkka@os.amperecomputing.com> <20211231033725.21109-3-ilkka@os.amperecomputing.com> <f0fecf95-0b7d-eeec-94fd-76bea61fdd0f@huawei.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: MW4PR04CA0156.namprd04.prod.outlook.com
 (2603:10b6:303:85::11) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7252833-96b3-48a0-2aef-08d9d01a761d
X-MS-TrafficTypeDiagnostic: DM6PR01MB4636:EE_
X-Microsoft-Antispam-PRVS: <DM6PR01MB463634026A031EB124BA0BD19D4B9@DM6PR01MB4636.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gFPgjuXztB3CKaXSVF9H/lyi/Necgvr9wPqYmq5nxP+0B+LFu5VWrQkAYpbsjUZ2x8eXs6s1cOCNf7dJY+y5gF4BsZFyBpghyFgXSrAbOI/ecmMB1oqwVGCBCrfxzZGOm7S1Tg5aV85uzCVcwxT3Kx7Kb9Vif/QhfrOcyFwrQbMeuJw3w/KV6jsIYn1Pz35RBoqXrRiWACmwASAVjZl4IxF9+qB57aC9ttMg2eJmPQKzoBai9vQUQay3R8bjzYPzrxU0emNtUD8MzBOyprsAcYPPZNmc8OQNshA5909ZaZpuE847VvTJJZ7DWUHBejvzicAs/jvtEN7yUC5t86H1Mn7PqFyJotoOS4VxaJSiwE7pWTT7RXrnzD7kJgKQ/u/2FyMoChs5xk2VplylabytenGVorCGihdtxQc1qiAWe6Hm4m/moC3zdUKgM3r/CdXQYkujcJCaT1JpyjgXa6C48q3Ii0vmcvcTRHTur6nPueorVsHVK0HRr8afkGS9pIwC/f7rKcXtfgB0FKAGx86+EqzAveexZUGzfaJCJsfzM0s0pcJxGipugBbOCAwEuZRWtCFYim3Y7mqbBNsJY/dsbC57kWRiX27aCn7qm3zWkPY/ZEqOrrdYhJmXBFC9+nFlAYtzvfZMiiuYN2xZmQU3e1aRxmc5e4UVcoasHG6wTarx++R6QgtfmGbgrVFd7NnqdLsDC0OASpmsD0BF91j1z3z/3Mwnq92/jc7SJiST+cRxsLKFQ3DTbNrLo6Y3nt7gb1F55NvMNn9vSpdwkGGdtSwnrLqivteRXeLeX8J3MD6nCe/vlsXk//6vs320zKXO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(316002)(8936002)(53546011)(2906002)(86362001)(52116002)(6666004)(38350700002)(66946007)(6486002)(9686003)(6512007)(26005)(6916009)(186003)(7416002)(33716001)(8676002)(38100700002)(5660300002)(966005)(508600001)(83380400001)(107886003)(66556008)(66476007)(4326008)(6506007)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YgVSgu00hvc+Hpt8yC3Ej9XLpP/Vz5+5tz13ohPGA+StYKuzOr8adV/qdq8P?=
 =?us-ascii?Q?LE4Uy/JmLi1PzJnsdUevq/8SVltb1UNEKRElOKcsYjlAc83jnpHoHHtcjyXv?=
 =?us-ascii?Q?4Rm3vJ5VY7Lk/nLupmLUfXTkQYcQfXpYMbQ0eQe1MZIsyNnm7FCUceqfxOOW?=
 =?us-ascii?Q?nASUhACiipdxw+6b2O4g3HEqgNgyRfKB7+jAsUiQjytFYOAZ95srzcrcvdtF?=
 =?us-ascii?Q?wkEypw8JuRYiGSnvmoc6JjP9chSbPEBd0bEOpUeagjQ9D9HBZlPZq1vQX8Zk?=
 =?us-ascii?Q?I5Mvk8vLNHzGdnkCrDf12sn4ymDYQjMyTLECe/Nlc88IKjA9qJBuhZDLsd6d?=
 =?us-ascii?Q?F0Q32jwfjjzWu3lXWMBIlilThrRM7OZQWRYGboa1mTnej9o2Nh0i2KQw985G?=
 =?us-ascii?Q?8/uezg5XgF7IXCwQKD4YzdN4ufLJ6QmszhACIvIf9VM/Qes6KvRzb4bgqlMT?=
 =?us-ascii?Q?Ow0Rx69n4Cz9VyC+phizf1LbyGjJFMdq/hElRCjhP8H1cKsaAmlcUC3NceqI?=
 =?us-ascii?Q?SGD9PJyOEQqDpTi9HW9WP1Jh0T0qVaynu1Ayvcirsbif5E1nZxTIp5jvPyHP?=
 =?us-ascii?Q?bi+pPsaZNOFED9wie0kvSwSQGRY9rPdjE9VttJEzz3D4cYJQOCI9Ej+Y1HqI?=
 =?us-ascii?Q?EshdA2e3AlhtcKomvwbf7TaCtsq9tFHBmcVDdZSj58HaeYvTMBi7KF/oVvrg?=
 =?us-ascii?Q?qIjTQT6BPDSlQwaB9D1Gnyb5cBEu104iC7dxIVwNBF7o37XPnmdotmmzJAKW?=
 =?us-ascii?Q?OE0BbFquYCKT0uQl5OyI4ZLYQzzltJxk6byg3N9CxEk9Y4gKGYDxIfgoxMP3?=
 =?us-ascii?Q?rk09EWkKs8E3FO7eUvxrvhBM4ZaioRqF1X9D/KVWj/Eq5ZsxyumXt1pSdgbV?=
 =?us-ascii?Q?CaEfQE6ezgBUttis3oi6kJ+ztNYtCq58k4pm9FhCfmRXopPa/gJEU9Cgionc?=
 =?us-ascii?Q?mkPqW35BiTISvCqXpgYVO/B4RWJQ5TyPFzjE+6t2SFU5owczZE1MWvyqxT+D?=
 =?us-ascii?Q?rMic7SDzEFvtj8CkBD4yihwn3H7xLPRccbDenzUZ1icheaDZvVqLXJW8b4m/?=
 =?us-ascii?Q?Jd5EZvPSXkbgzn0bsQrR3jnTs35JlwtNuAg9Q1GPg26tR4q1zthJzG9KY1BJ?=
 =?us-ascii?Q?XYafqaBKKKP2WVeV27JI6qyxWZ6gcWofNsGrPR90jWKGwt4kL2iG7YZq5/vK?=
 =?us-ascii?Q?H+rMv5snCNfUJdlDncwhCZpkMmnc9Q9jzYUfkE2VZS8yIbQMy31o18bd1zCz?=
 =?us-ascii?Q?By9KqpnJFeoA5hN9ipcpVlWi9QA6p5kyxHpQcAm0ayn8Po9K/h7FRQsUXwqB?=
 =?us-ascii?Q?2Z0UDvuNPU+Dr9T0eW2a36lVwz9uYGfRX4lsJXawutiVAmUkaBJYHcWdGBAe?=
 =?us-ascii?Q?Iy18lXzAApKuBrbdMAYixGp3XWBiuDy+6JiuTOtEg9ygOMgJGfEwC+OPu1hO?=
 =?us-ascii?Q?wkD8lWRG+4nDNQRpfqpd47BtANX0D5z6vMiTO50AHkKHk6hN4dBJylIuLKr7?=
 =?us-ascii?Q?fDcdWsXf2NaQCg5V+cBLwGVuIlNnt10RT1gAKO00xi0aObUowdjdnpuCV+Yv?=
 =?us-ascii?Q?GyclNIefkD2DKWNoBnpCcMiYODmsFcg/xpnteXR+9mYWk6tSGqbvPxWb9L0t?=
 =?us-ascii?Q?f73qLvU+2lSQ9gyDIPDH+q/56XRZGbccTiqNgwtvlM7+IpT3zuH5SR8VqX0q?=
 =?us-ascii?Q?KbRTGoXPz1fr2AyBNLpvETHDkTM8F/b8HvVSgnlVFc75FOFliPEDR7YxSFXl?=
 =?us-ascii?Q?APKikdPPoQ=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7252833-96b3-48a0-2aef-08d9d01a761d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 07:10:32.2110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u90CTF8doOGXCdlSUvuMQND2Dn0K/4oMjkYPPJMGnXz8dm3MHt+77tTF1F0k74PCdswnzwpbgcN9WEU/r1FEJdvfsn6CL3UsxLi5cyCdJmg0Cj50F2WC2jp83k/J4rgA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4636
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Hanjun,

On Wed, 5 Jan 2022, Hanjun Guo wrote:
> Hi Ilkka,
>
> On 2021/12/31 11:37, Ilkka Koskinen wrote:
>> ACPI for Arm Components 1.1 Platform Design Document v1.1 [0] specifices
>> Arm Generic Diagnostic Device Interface (AGDI). It allows an admin to
>> issue diagnostic dump and reset via an SDEI event or an interrupt.
>> This patch implements SDEI path.
>> 
>> [0] https://developer.arm.com/documentation/den0093/latest/
>> 
>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> ---
>>   drivers/acpi/arm64/Kconfig  |   8 +++
>>   drivers/acpi/arm64/Makefile |   1 +
>>   drivers/acpi/arm64/agdi.c   | 125 ++++++++++++++++++++++++++++++++++++
>>   3 files changed, 134 insertions(+)
>>   create mode 100644 drivers/acpi/arm64/agdi.c
>> 
>> diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
>> index 6dba187f4f2e..24869ba5b365 100644
>> --- a/drivers/acpi/arm64/Kconfig
>> +++ b/drivers/acpi/arm64/Kconfig
>> @@ -8,3 +8,11 @@ config ACPI_IORT
>>     config ACPI_GTDT
>>   	bool
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
>>   # SPDX-License-Identifier: GPL-2.0-only
>> +obj-$(CONFIG_ACPI_AGDI) 	+= agdi.o
>>   obj-$(CONFIG_ACPI_IORT) 	+= iort.o
>>   obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
>>   obj-y				+= dma.o
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
> Please keep the head files in alphabetical order.

I'll fix the include lines

>
>> +
>> +struct agdi_data {
>> +	int sdei_event;
>> +};
>> +
>> +static int agdi_sdei_handler(u32 sdei_event, struct pt_regs *regs, void 
>> *arg)
>> +{
>> +	nmi_panic(regs, "Arm Generic Diagnostic Dump and Reset SDEI event 
>> issued");
>> +	return 0;
>> +}
>> +
>> +static int agdi_sdei_probe(struct platform_device *pdev,
>> +			   struct agdi_data *adata)
>> +{
>> +	int err;
>> +
>> +	err = sdei_event_register(adata->sdei_event, agdi_sdei_handler, 
>> pdev);
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
>> +
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
>> +
>> +	status = acpi_get_table(ACPI_SIG_AGDI, 0,
>> +				(struct acpi_table_header **) &agdi_table);
>> +	if (ACPI_FAILURE(status))
>> +		return -ENODEV;
>> +
>> +	if (agdi_table->flags & ACPI_AGDI_SIGNALING_MODE) {
>> +		pr_warn("Interrupt signaling is not supported");
>> +		ret = -ENODEV;
>> +		goto err_put_table;
>> +	}
>> +
>> +	pdata.sdei_event = agdi_table->sdei_event;
>> +
>> +	pdev = platform_device_register_data(NULL, "agdi", 0, &pdata, 
>> sizeof(pdata));
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
> The rest are looking good to me.

I'm glad to hear that

> Thanks
> Hanjun
>

Cheers, Ilkka
