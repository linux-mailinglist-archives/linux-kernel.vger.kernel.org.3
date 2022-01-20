Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393A84945ED
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 03:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358258AbiATC6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 21:58:47 -0500
Received: from mail-bn8nam11on2113.outbound.protection.outlook.com ([40.107.236.113]:14561
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1358237AbiATC6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 21:58:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEG9Iuw8otjg3fiSCt5EVaMpQlW4lIObGvagioxJdTcFCfaGfbk7gT2TL/XP6QIDTPuspG4v5/XpTTRr0d3J+GonqS9tLHQOt6+VnHunYlYQzkIfRRBjIDidqtPfOsquKfdUocfArfLeuoXgC5owiBtpndOZvJ/0lbHN+sQhTdt7CIoOXQQN1aR7m/BnhqRbDmUcbVi6DR45BYHgQRxX5jdNf+exJ5uPvwsIr353/g6hBisiF4+EWzFGI7SXcGZHiuzgaDRSezoonKP8q82ddR0uBuoK6W00LnhCFzDNXF0ZBi9Uref1Oi6cMxzB4gACRf1KyaNLTd+/ytk+lWJSOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7SZZoMWg5bmQdiLrooB7tRgKvs4sbk1MutYbJ93VWU=;
 b=asupHADw2rsJSopXPADNejqBtst37ftLL1UKW1FpUuHIjZlab1vPXAnkkRHC1RvaaZC1hqNVpBuLFosKYklDhTPJvgI3pwRdns3J6lT3L7cYX/PIpKKR+gB1QQhmAp4X3X96kpO9ZjUfBy3dSrycZ2Xm1HmxfSkmiwqvcaOHt9rthTk803smO9dkrZeLWPhf3Uv6LELvjA1Gz0zCQuKpxduDD5Nm7wflVlXE9vVK91R/GafukzQNwc5VDOBPwe5APnacvQdOu7hiTAXy1l9I5sg3G5IZDRV5N5Nbus3nUYYfS/VKq2xdKtWyi6ezhNPPohjtTHN/ig9hMAmQE+kvBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7SZZoMWg5bmQdiLrooB7tRgKvs4sbk1MutYbJ93VWU=;
 b=HbrBe3RV2a9GJYU93syrxexSM3LOJiiNv2wp/zm5KtgNyOTIAs/pplLdNEmQgOsAKsw6k/tWKwoOc891nJlf3+181BKtL+23GXFsBY/fNn6koEVkS07sumzO60yHg1q8Iecg3hyx7ll84a3BAA2NNsuTjXKLZFLzuJS398m+tRo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 BY5PR01MB5827.prod.exchangelabs.com (2603:10b6:a03:1c9::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.8; Thu, 20 Jan 2022 02:58:38 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::c4f4:4df1:380a:2ad8]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::c4f4:4df1:380a:2ad8%5]) with mapi id 15.20.4909.008; Thu, 20 Jan 2022
 02:58:38 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rafael@kernel.org, linux@armlinux.org.uk
Cc:     lenb@kernel.org, robert.moore@intel.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com,
        scott@os.amperecomputing.com, darren@os.amperecomputing.com,
        james.morse@arm.com
Subject: [PATCH v4 2/2] ACPI: AGDI: Add driver for Arm Generic Diagnostic Dump and Reset device
Date:   Wed, 19 Jan 2022 18:57:59 -0800
Message-Id: <20220120025759.8630-3-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220120025759.8630-1-ilkka@os.amperecomputing.com>
References: <20220120025759.8630-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0337.namprd03.prod.outlook.com
 (2603:10b6:610:11a::27) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5933904-1b4f-4379-9fd8-08d9dbc0c1c5
X-MS-TrafficTypeDiagnostic: BY5PR01MB5827:EE_
X-Microsoft-Antispam-PRVS: <BY5PR01MB5827E595296C36A2548AE1A59D5A9@BY5PR01MB5827.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TIFc6zTL954KO51yk/W0ADpb2iqM1LkcYABGxps5In7wIOourq5LMYdDLuz03BaS/7e5u3cta4Fw1lGEG5HZs3/HCyUZUcdr1Gxv4Z2+rjAmsfwnpntEQfBdj0ISPMCdBjpOTELB+C7oGsjGYxu3mtcxrsnZ62gT524+CsHk8ZQv51X/YmFUTMElHj2f2FXxUts8uUEKEbMi/SA8jgyU8kIu/eQxeMVMChjgT/vhwBV2B2DHY/cA8ETgR1ihSLdW3/v5X9g1f8+CS58N4X377qfNh7mvp8VJVIC7GawPwywjIj5NjdeBID5XC99Bjv6Igqr/TP+Uz5PoLgH/PVblHM2mwF66T/f1uPhc5PclWeT3/OflbJZ1Zs8//6NpUtC1772QLsbl5niay8XypD1PrY5Nm4N1NRvQvFFJmqiAJyPF0MWDiaZsrAD9O5/NezPDEbvC8UsRkurvztSRbvVXtezbpe/Y3XijX0YCGxGO/LrOyjZHInNcTaTgI5Ou66iWWRhysBTUqwSK+B2wTYqdD3WQA5Zu8hraM/pxrUXnEeyyhWO7T/LEV5oSk674w3ojIZ4z/Nv3ix99SnErkzpZ4Qdn4klldvvoKsEU3JpFRSkVuGXduXW2exBmoNvMcGzMC5RApK6HVvWggtNYflnyKq7BqWmdgPeu7w0hcDLHrhPDMhkKfqjFmLv4jQvkEW03aUN4cFJO7nlP1dgSjYpy2j1TD1pahhpvYGSjNrHusrGDvMI5wK7SBQiQjXYh9EZ/4wu8VFAX/ea7qSmYDrxLE7kLPvZZHC5A8Mh9waMjnqWxBtx7h5OfChpIiPm/HT0m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(66946007)(66556008)(66476007)(6512007)(38350700002)(86362001)(38100700002)(316002)(6506007)(5660300002)(2906002)(508600001)(2616005)(52116002)(4326008)(7416002)(966005)(186003)(83380400001)(6666004)(8936002)(8676002)(6486002)(26005)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NCVD2ehVEAKCFfGshaaux3d0X+BuiLhtPzjmkzX/rEau8sqhTzAat2vMR/PU?=
 =?us-ascii?Q?j993WhVKGzaTZOJm2S6vKisMOn8nC39evoGxlmziMjj45WSH9N3oAWZeKMvJ?=
 =?us-ascii?Q?MmLvhFus+6Z8vDgnWEgNX6+3Gmf6/16Bd019OQFXSQz8f6G+nrFkFem9GCxK?=
 =?us-ascii?Q?83wMgT0bmo34H16uUHFjev6MxekE9I3JQ89mSK26bhYLNgJXlGJi4a17ymOs?=
 =?us-ascii?Q?FbI4bR2SKgSdB7dz9SUsvYsLcPFtDY1G5a56Gfi++ZXD0Xhr94uDULCBvXpb?=
 =?us-ascii?Q?9Ce+QAAmhJ03GOFtmAv6lPmWh5QYvjKV1qD9X2DVCq+eyg6r+Eg/ZZH8yZFM?=
 =?us-ascii?Q?4YFtFOypZ2vciLgnzsGcX6uIs2xAYLaTZLcMTzQSuX2HKiiEhKO9M/n2RPF4?=
 =?us-ascii?Q?dTTJUmgN+zGnp11V+l0hAd6SyA3O5fzwRg5kPmiLLZJRNUOKVY/j/hQbKsXe?=
 =?us-ascii?Q?EiDLrku+5tlJgvMSDDzSkGstAR1jFuWRavpvljapN2HAf8d9Cn23zyA0rHXb?=
 =?us-ascii?Q?G/E1CD+s7sgdJI0XQFFToE/MvjUgFECpcUejCvmxk1KRlUP22nvE6w84rswx?=
 =?us-ascii?Q?xnMRl6PNLVvpSYQtJSMJNWEVV9+UCso+4j8HSQKyGcioeVjHZweUC4Moisxk?=
 =?us-ascii?Q?KsN4SPZnQRg/u67fdJ97NHDzl1EkzU2gXFYPqE3xZLrkHzA9Fmz2V9cpMDbQ?=
 =?us-ascii?Q?OZobgkjCbPG1LSQVL9f8ugD0Yf2OlcTMAUtPN1gp3SoBCawFcGJoPavk7l/O?=
 =?us-ascii?Q?1tWSkyrxD0PdLzVRq37ziLlDjtYmcXkSh5H9/x16WSNCyRmwJHHaaPPJy0vh?=
 =?us-ascii?Q?fU6JelZm3u3W7b6dvtDDL10Of25/mTsHWoDNKXdvoo7qN8ZLecyc9XP9taEY?=
 =?us-ascii?Q?Kfm5M8Anxoc+RUSj856iLTKntlaJdEzulH7AMviGh9bmfk41fq2eUMxeiODx?=
 =?us-ascii?Q?JETqdweNP6pI+RnENjlphvve1VHQTux6gf5ca9Y6u/KpOXssqYVGjjl9ZiCH?=
 =?us-ascii?Q?V4RBbPpHv4QAkNWECXd2kpSvaanNzzou7FtUXKsvLorpuyeCn2oChLI3UyHt?=
 =?us-ascii?Q?LnB0EdUPc1A5mJB9UjQslyD+xgx3o8qLiPTKbKVLhLogQWK4vAVJ2wm2DpHh?=
 =?us-ascii?Q?d//oJkJI/twudyG1jeNKnyb+62goZNZBlK4OWVfxXaem8Y8Oz/7tddx8lfUE?=
 =?us-ascii?Q?QWRR+H3yHCKnBdm+MS5YeEcPY6Q69oaT4FnhmxXsVtSopBayBBpK9RQx04O1?=
 =?us-ascii?Q?Pg09tCfrQ/FplTAe6DOSzxYQAeM5RuQfyo29MosQz5Gtmn3FyxL7Js/yt5UB?=
 =?us-ascii?Q?/PDKoeUZFQ6DpSy9XPwfxL+UvugW/tjLgnMXZ36ceY6LcaKrI+d2c/4mduvF?=
 =?us-ascii?Q?gx8IzxiOyNkzSjX5r2EbAPrbp4TOUlS+oFX5PPR4WuNcc5recjlXeiaMtCOO?=
 =?us-ascii?Q?iKUQgpfCFSUymmnglIpUqsnQE3PVv8YUpXKndGzlHyBw3u2f++0qQIPHzu0/?=
 =?us-ascii?Q?52/wzo4cWL0PX0V8H9FNT0j31mnLydB3KHQuaAy93yWM5Ex2wBaPWJ1igz93?=
 =?us-ascii?Q?ZDfsLHnFnCQlO5Ff9HQKgPJzFQXZLm63PCphKkKvfusNmS/fbYfhoIcW3hhJ?=
 =?us-ascii?Q?KjO7LZgO7UOCQqd6Q/p61cmftgy1LcAGEbt68l+BjdKy6GOCROJfMzkm4ACZ?=
 =?us-ascii?Q?wlRptfVmfcExdlT5IknpiYJu7kPlYIrl8gRGAgS+z2Feob2NE1T/iGwkaYa5?=
 =?us-ascii?Q?Ac20+R/NhA=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5933904-1b4f-4379-9fd8-08d9dbc0c1c5
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 02:58:38.3606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hoTRfFFgA4Vq1N89BvGSeWxzmCVoYa+vIr4yre/uUuZnobhi4+Q2YtMABHGs/zEgORjYzZ653QJBaOdrYqmb63XQ5FFq3yepxiuzZXALLlvuz2Hh+L1of6aPsOGV/9Yd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR01MB5827
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI for Arm Components 1.1 Platform Design Document v1.1 [0] specifices
Arm Generic Diagnostic Device Interface (AGDI). It allows an admin to
issue diagnostic dump and reset via an SDEI event or an interrupt.
This patch implements SDEI path.

[0] https://developer.arm.com/documentation/den0093/latest/

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/acpi/arm64/Kconfig  |   8 +++
 drivers/acpi/arm64/Makefile |   1 +
 drivers/acpi/arm64/agdi.c   | 122 ++++++++++++++++++++++++++++++++++++
 3 files changed, 131 insertions(+)
 create mode 100644 drivers/acpi/arm64/agdi.c

diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
index 6dba187f4f2e..24869ba5b365 100644
--- a/drivers/acpi/arm64/Kconfig
+++ b/drivers/acpi/arm64/Kconfig
@@ -8,3 +8,11 @@ config ACPI_IORT
 
 config ACPI_GTDT
 	bool
+
+config ACPI_AGDI
+	bool "Arm Generic Diagnostic Dump and Reset Device Interface"
+	depends on ARM_SDE_INTERFACE
+	help
+	  Arm Generic Diagnostic Dump and Reset Device Interface (AGDI) is
+	  a standard that enables issuing a non-maskable diagnostic dump and
+	  reset command.
diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
index 66acbe77f46e..7b9e4045659d 100644
--- a/drivers/acpi/arm64/Makefile
+++ b/drivers/acpi/arm64/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_ACPI_AGDI) 	+= agdi.o
 obj-$(CONFIG_ACPI_IORT) 	+= iort.o
 obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
 obj-y				+= dma.o
diff --git a/drivers/acpi/arm64/agdi.c b/drivers/acpi/arm64/agdi.c
new file mode 100644
index 000000000000..28f16b95ba12
--- /dev/null
+++ b/drivers/acpi/arm64/agdi.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This file implements handling of
+ * Arm Generic Diagnostic Dump and Reset Interface table (AGDI)
+ *
+ * Copyright (c) 2022, Ampere Computing LLC
+ */
+
+#define pr_fmt(fmt) "ACPI: AGDI: " fmt
+
+#include <linux/acpi.h>
+#include <linux/arm_sdei.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+
+struct agdi_data {
+	int sdei_event;
+};
+
+static int agdi_sdei_handler(u32 sdei_event, struct pt_regs *regs, void *arg)
+{
+	nmi_panic(regs, "Arm Generic Diagnostic Dump and Reset SDEI event issued");
+	return 0;
+}
+
+static int agdi_sdei_probe(struct platform_device *pdev,
+			   struct agdi_data *adata)
+{
+	int err;
+
+	err = sdei_event_register(adata->sdei_event, agdi_sdei_handler, pdev);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to register for SDEI event %d",
+			adata->sdei_event);
+		return err;
+	}
+
+	err = sdei_event_enable(adata->sdei_event);
+	if (err)  {
+		sdei_event_unregister(adata->sdei_event);
+		dev_err(&pdev->dev, "Failed to enable event %d\n",
+			adata->sdei_event);
+		return err;
+	}
+
+	return 0;
+}
+
+static int agdi_probe(struct platform_device *pdev)
+{
+	struct agdi_data *adata;
+
+	adata = dev_get_platdata(&pdev->dev);
+	if (!adata)
+		return -EINVAL;
+
+	return agdi_sdei_probe(pdev, adata);
+}
+
+static int agdi_remove(struct platform_device *pdev)
+{
+	struct agdi_data *adata = platform_get_drvdata(pdev);
+
+	sdei_event_disable(adata->sdei_event);
+	sdei_event_unregister(adata->sdei_event);
+
+	return 0;
+}
+
+static struct platform_driver agdi_driver = {
+	.driver = {
+		.name = "agdi",
+	},
+	.probe = agdi_probe,
+	.remove = agdi_remove,
+};
+
+static int __init agdi_init(void)
+{
+	int ret;
+	acpi_status status;
+	struct acpi_table_agdi *agdi_table;
+	struct agdi_data pdata;
+	struct platform_device *pdev;
+
+	if (acpi_disabled)
+		return 0;
+
+	status = acpi_get_table(ACPI_SIG_AGDI, 0,
+				(struct acpi_table_header **) &agdi_table);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	if (agdi_table->flags & ACPI_AGDI_SIGNALING_MODE) {
+		pr_warn("Interrupt signaling is not supported");
+		ret = -ENODEV;
+		goto err_put_table;
+	}
+
+	pdata.sdei_event = agdi_table->sdei_event;
+
+	pdev = platform_device_register_data(NULL, "agdi", 0, &pdata, sizeof(pdata));
+	if (IS_ERR(pdev)) {
+		ret = PTR_ERR(pdev);
+		goto err_put_table;
+	}
+
+	ret = platform_driver_register(&agdi_driver);
+	if (ret)
+		goto err_device_unregister;
+
+	acpi_put_table((struct acpi_table_header *)agdi_table);
+	return 0;
+
+err_device_unregister:
+	platform_device_unregister(pdev);
+err_put_table:
+	acpi_put_table((struct acpi_table_header *)agdi_table);
+	return ret;
+}
+device_initcall(agdi_init);
-- 
2.17.1

