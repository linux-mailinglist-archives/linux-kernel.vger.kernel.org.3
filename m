Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F242E4821DF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 04:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242639AbhLaDhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 22:37:54 -0500
Received: from mail-bn8nam11on2131.outbound.protection.outlook.com ([40.107.236.131]:9953
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242620AbhLaDhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 22:37:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewnAPMzhEhTDhS+q6AbwI2AHv1pUggxzvNclqI8wC7a3UtOMQdTdcp9RajDy6LkhO0ct1v2C1VUr6xfZHpnZQ6O+EzSm9YAsGAmPpXxmBk5gVqQOVJ9z5J/2HHntblPMhatUqpBpjoH6BluwFFORRB6TIHbP2tT95chYCJKaIFCAimFb4dmzKCASGJQ7l9WktqTyib5CJV9UxfKoJSyMm019ouV7TkJAofxUhduAScrDHb9TAvv45jRN91fDj//rjN9T2D4Noydq9kp2kwxa2xPD7Dtk3vKO0nsGO3ZUrYVp996Eb1JgYpv6+aEWazooOOtXLITC2KJPxWf2PPSsAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbAkhrQB8e00n7Lfgi9b6VumYWZ7vNWCYET9PxfwR7o=;
 b=fOP5eGSwZoEEOXRaKgmH6eF2y6z860VxU7pXzozfKguio8SvLIncL6pLdrZsxrk4cHawBkWANI7IE+4gQ7g15Zmdu2AHBJXRJLqhFZxvuFfos+Gt4/z23v3xPAmNEWYGnCOTBygoYIT6OJW9YsRh1Vp5FUDzLraOD4SRS6DnrMxtcfITPvTGvC9R5rRH2jkephkwcfPZ46djGm/RvosYnARyaSyTdg5BhfUlAYd8JzWz95FLCti+kzUefmExR9vJZ9cfUFq/fJphduUJJOGZ2VHuYks5aFOCrStD92EUgnAspKzzg2cgQBF6FPy8Cd5ipFVN/qhofLxPnGxFwXbXmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbAkhrQB8e00n7Lfgi9b6VumYWZ7vNWCYET9PxfwR7o=;
 b=I0s0T3n04TC6X9uBD+/Yb1Fz/kSlAm6uc+clZ2oiCRTVTpZkog4wOz8RzE25HGfJoiuSEtCgL3HCxC3tBpZECljwZNg0WFLvMH6uYVjztElVNmYmUJGRRdmxBzft0GRIoJiTrmKeCkCfHlza1Zh5b6DIAzVt8XWSXzLxoYjfMwY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 DM6PR01MB4172.prod.exchangelabs.com (2603:10b6:5:2a::18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4823.23; Fri, 31 Dec 2021 03:37:49 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::38b6:2855:7c14:274b]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::38b6:2855:7c14:274b%3]) with mapi id 15.20.4823.023; Fri, 31 Dec 2021
 03:37:49 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rafael@kernel.org, linux@armlinux.org.uk
Cc:     lenb@kernel.org, robert.moore@intel.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com,
        scott@os.amperecomputing.com, darren@os.amperecomputing.com
Subject: [PATCH v3 2/2] ACPI: AGDI: Add driver for Arm Generic Diagnostic Dump and Reset device
Date:   Thu, 30 Dec 2021 19:37:25 -0800
Message-Id: <20211231033725.21109-3-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211231033725.21109-1-ilkka@os.amperecomputing.com>
References: <20211231033725.21109-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: CH2PR18CA0049.namprd18.prod.outlook.com
 (2603:10b6:610:55::29) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0f24ca1-be01-4742-a6ca-08d9cc0eea8f
X-MS-TrafficTypeDiagnostic: DM6PR01MB4172:EE_
X-Microsoft-Antispam-PRVS: <DM6PR01MB4172554573F2C97845A699DF9D469@DM6PR01MB4172.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +oNZ7xP4Q8trHxfHvYTSwjimhdZeawheAg7qHD4tthxQ0bw7fG5iIYE3hJrwRrTXvUhAO3EiKD8BGIzLyee+1FyQ/UBhEoxAO5qaKhzDGYH4f0APl82Mg83xexQiCWY/i6cr1YsWZE/5e7mRQZuzPRljUv1Ulnt2OXgZP/nw1lLfGZRut6InAfHm/h0xQlzZlf7YNahGdINc02wE6EkbTlvIjhGZLs/niTqfHdVeaM1oZwLucbRtYUwJ4+yH8SQcmRhPGtVO+4KHT/FHcH9rQFhpi7XiAYlVG+bJc+Y6AvuZilvlPGBeNtYCL4/FUFHnCj0gxLMPWd2SbkmdA6DVbez5HvWnJJncsMiWrBTGikx02jqb2p+sJmRiAey+QFzMAs4AIvhXgXge1IkwciRVzRL+cJ27FyT8JcTsSSAWHe4f1fzDjVZjX6XHkR9LWFxRsFio7XTCem7nWk+6uL67iu0LKjqv1zE3EcrFMXtKbfvbXNF3QlApo9bQ65Fvd+No1Ru4ijdXHglCFsO7V/lfUmyM2RfWe8zKHfzfuHgiC71OPx+pehiNnPTc/IeG5AVke/n4vTPbr2cdja+DRiCNa2PGj592xgbp1KkNd4M8wB4p9eDEJ/Pj34iGgWAyC4bORoSZWDg/Heo94ZgbSIn2hW3a7n4bW2Ti3j0voXBNQdf9zQ7h6LmT0kqedB36Dm/rOuw/dyYpkKJflQ721GOwmCkqOz61aCRUNUL9WeXjR8MqaMnYDQfoK/XLFfFDQoi2VV+CImEFLmRrvuXABtET7i0aNselOeG452oqcIJzf4SymO997I+SE9MbYgclv9md
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7416002)(316002)(52116002)(6512007)(66556008)(2906002)(508600001)(26005)(66476007)(38350700002)(8936002)(2616005)(4326008)(107886003)(1076003)(66946007)(38100700002)(186003)(6486002)(6506007)(966005)(6666004)(5660300002)(83380400001)(86362001)(8676002)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N5W73UPMbs/ha83Ep+BWxBp6ou2vBAvX0G8xbppSzhT2W/9Ce/y0hxjQk3J/?=
 =?us-ascii?Q?8vPaK9FbEqZTfewoS9+IMYGQ0BVbPa7rp4uUBHcoCwLuZt4FGkm6MpEOMsUw?=
 =?us-ascii?Q?/iSw1i6a9wifnA/qTi6vGxHnQaxDEqNCEta3T5oCFHLHaGIkxvHNybPh4Qqg?=
 =?us-ascii?Q?Coe29eauzDMymP84W7TJ1Vst7dFAjRpsz6k3qOirgKgfmi/jd2+DfoanzJEt?=
 =?us-ascii?Q?n5Bi/KTvNWbzB+DL1TLFk/+adL6JbbKAm3hr8J7WlQKxtypoRzKcholI0Oc7?=
 =?us-ascii?Q?qEtW948xTlqozmsJXnUR7+LvwX/h8+Zn64i/QWZAW/10GXGIBobe1mno+HLh?=
 =?us-ascii?Q?cN5T81X5eEUXWmk0v62THBG+Yeir5/S5/TmkSSmJZ4aBMCMPMST2rwQkq72M?=
 =?us-ascii?Q?25hhjg5nbPyE/V9EWSle03I170KZavR8oaY5UK4eQPTfxoNTpG2e7UmkOPwO?=
 =?us-ascii?Q?BWUIvAJteDiqxsoeeCAuiu/l/+31sv92RWcCj7+yXQot6rrqEhCvREFFxStT?=
 =?us-ascii?Q?kOK0OnjO+T40Sq07Ou5utNo1oPH85oOWk+0Vo2fzWz6rekV4Cfnt0FWVHPQ8?=
 =?us-ascii?Q?/veS3cb9lxURo00gUA4CPyI3FT7oiDrK5CqegbEftNNvKW7YYIitPsx57iOO?=
 =?us-ascii?Q?ec6bo/wreomrPVxwTWlJV8ZUCCuFTSMA1rFVUMTXIIY1keKPpB5fyEDut33U?=
 =?us-ascii?Q?gONA/XLiPWSvipePAJ533NZQRr9Jt3vkoSG8dF+WYvcpQsj16kJwJOi+Y9fY?=
 =?us-ascii?Q?krUGLX+/3JVpC8+loOk+io6Gt3gyONaSSvnp7zinRy1fj2tY9+ydDucEDjHl?=
 =?us-ascii?Q?dTODWuLShqL/Jmf+oip84J2jlJzh2ec9sG9FZYRKx9yrABSQyJ587pv5JtsS?=
 =?us-ascii?Q?Qt0OwsveoRwjsH+Kpb0yWe3NISb0N1L2NWbC+Lp72J7oKJ//JsZgLcS11QOg?=
 =?us-ascii?Q?/AZVsWglSLo6LuMhyPPRtiM7a5fr8AqUmojKfASH/LXpQlSJnSFd58usPDY4?=
 =?us-ascii?Q?STEVchLMr/ll8GOwQTr0XCYnJIcyl6Msa4UWtgiUB1BFAX/BTV+KtKNi99uV?=
 =?us-ascii?Q?cZtyTNjYjQnnYkIUJZq+wfKBsKd/W9pi1sYamEbq/NRvrcphqWbJBbA8vWJP?=
 =?us-ascii?Q?71K3bpMGbgMXQSqEfigpiEJRSa2mF6CbPBHxqWbaYwqPSe6EOfXBlCEDnY7A?=
 =?us-ascii?Q?EsOTj22i2StyxNFXMMHmONDSaP32W3v029Cr6/BzmbXkVEMYKiW7CvhVCJxI?=
 =?us-ascii?Q?CWFGUv9PxLmb75kRibAoSX9f4efgsxOI7cE4ls/bLDeW7b9rDUPzXxf1BTQX?=
 =?us-ascii?Q?Ny4ANPxxWaA6HAcBWTXAx1mzq+s6BBqbqzZSjlA8D2mVERCzHzkFCR5C+iMT?=
 =?us-ascii?Q?1wrL1rIxjnuIb+m+jXUarDPyjMbeJ5OsLOQLDnQ7N0tCa/PeDNKYRadK+HaS?=
 =?us-ascii?Q?I2OnLvYUcomXy8+DKIrCH0lgCNvNZoDl55EwLKzbrV5ViG4Q0HHukGL+wHng?=
 =?us-ascii?Q?jQeH6O5iDnHVW55jlS4zaogZDahS/ERWsa4B9ITBgVfD4p5DYsNMZBcaLlmk?=
 =?us-ascii?Q?rJSbOgOY5bHw7kvNpMjceSZbbpSei7s54mzaKrQEdy48Ll6nY/uA5IM06HYk?=
 =?us-ascii?Q?2RUbchccGAI9Rs19qziU8hGtM+2YpkE0xrJ27WQU3GrPHr+wU2N7Xy5k2H+b?=
 =?us-ascii?Q?eH+uSRHJrwsN4ufhJw4Usu7bBW0kexDOrMCCqqNsJ0RbyQj1slKlgFf+EZoR?=
 =?us-ascii?Q?4TLPtoFfcw=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f24ca1-be01-4742-a6ca-08d9cc0eea8f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2021 03:37:48.9808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7PPWGLv+vFs5x4xQFx/gT6Mq6d31l6mcA7RED2iOJwviw0URs6z5xV3i2P5eeabzZHY8dFgwpbfZRnUgvQHflCOftespF212zhVMl4lknp9RGLE3JT8IKaJXIQZP8Npi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4172
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI for Arm Components 1.1 Platform Design Document v1.1 [0] specifices
Arm Generic Diagnostic Device Interface (AGDI). It allows an admin to
issue diagnostic dump and reset via an SDEI event or an interrupt.
This patch implements SDEI path.

[0] https://developer.arm.com/documentation/den0093/latest/

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 drivers/acpi/arm64/Kconfig  |   8 +++
 drivers/acpi/arm64/Makefile |   1 +
 drivers/acpi/arm64/agdi.c   | 125 ++++++++++++++++++++++++++++++++++++
 3 files changed, 134 insertions(+)
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
index 000000000000..6525ccbae5c1
--- /dev/null
+++ b/drivers/acpi/arm64/agdi.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This file implements handling of
+ * Arm Generic Diagnostic Dump and Reset Interface table (AGDI)
+ *
+ * Copyright (c) 2021, Ampere Computing LLC
+ */
+
+#define pr_fmt(fmt) "ACPI: AGDI: " fmt
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/acpi.h>
+#include <linux/arm_sdei.h>
+#include <linux/io.h>
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

