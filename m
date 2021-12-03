Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573BB467026
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 03:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378188AbhLCCrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 21:47:31 -0500
Received: from mail-bn8nam11on2091.outbound.protection.outlook.com ([40.107.236.91]:13280
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234870AbhLCCr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 21:47:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISooEFm8Jj6FQEE/Bh5qtOl75iOIzSrIe4rmxD/B7Jv7v9isBXe+QrFqYjxLcKgu4PSdDhCAUEDYXvUtAkFNGRcW3/kz724pgvC9TOUR0s0C6EBrSy4dhAzJVul/hyT2P2Eg1FoYkmAw+kUqYBx9GSMfh/OdAOTxfYZTuvYdop8D2DEzXRQ/qh1RoOBcxWIkY+Xf+OO+EGiwhUtO538sAn+sMrm0wNKygJJ1bXSly+7Q6e6kOnMwQaVIraG/sUFEuxDpzGvrm3KQoAXWez10Mcyz59Z0VwyTkySxhl9mJB9AT5OhLJX/k7qHZ6fQ8kyYL0UX5HgRr3YIeQwryyBRVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJ+r+fpiBqIlURQpo8CHFrUdKco8Vdl/9kuKXY7RBQU=;
 b=XCAF7RafIR30A7TFLGn/WJdOFFgynI1hvEQi0Y1kl8Yme8JeV7eyhUossZWs5ORDjhNP3Tn6dr9JDuZ4MY4Acd01kf9tB6OhLkFmkTGSZIm1Z1iVyHuWO5t8eVxsNTPkelO5jQ156Q370kanGt9civAXYj1JpSyM6la4RYBHGOLrMYfVkLISt1ntj9+ZhbrF8KJ5zovgRyDDIuMlvXJApITCYt1UqbmyfQt6xRssdHjRGJ7iSY3BYPW1T9OUsn+0FCEE0eYKG07a5YEnkTbTxmKMeoAKi0RmrO1j0evSIXSId7TpbgkVoR8M6pdrgWrN+gLrW+hZpNKpBB9uOw4vew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJ+r+fpiBqIlURQpo8CHFrUdKco8Vdl/9kuKXY7RBQU=;
 b=fVhcsJP164UJqrMn2hIrUE0Z3TzMjXmJmEmHgE9evoPw+VFUdXnu3SSJHdHsu20Y5CEz06ItToa05eAJrsBJWEdD3oMAoVJCnBOv706jWP3y1JQxIvBPsipqyKb8nIxQq5whEEkdrYYdER1BrrB1WrogVC6tMKohhnrarxtPXi8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 DM5PR01MB2412.prod.exchangelabs.com (2603:10b6:3:3e::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.14; Fri, 3 Dec 2021 02:43:59 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::d93b:cd3c:bb56:33a2]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::d93b:cd3c:bb56:33a2%5]) with mapi id 15.20.4734.028; Fri, 3 Dec 2021
 02:43:59 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com
Cc:     rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devel@acpica.org,
        patches@amperecomputing.com, scott@os.amperecomputing.com,
        darren@os.amperecomputing.com
Subject: [PATCH 2/2] ACPI: AGDI: Add driver for Arm Generic Diagnostic Dump and Reset device
Date:   Thu,  2 Dec 2021 18:43:11 -0800
Message-Id: <20211203024311.49865-3-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211203024311.49865-1-ilkka@os.amperecomputing.com>
References: <20211203024311.49865-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0312.namprd03.prod.outlook.com
 (2603:10b6:610:118::21) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
Received: from eng01sys-r111.scc-lab.amperecomputing.com (4.28.12.214) by CH0PR03CA0312.namprd03.prod.outlook.com (2603:10b6:610:118::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Fri, 3 Dec 2021 02:43:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82d54e2a-c148-4ba2-1cbf-08d9b606c1e0
X-MS-TrafficTypeDiagnostic: DM5PR01MB2412:
X-Microsoft-Antispam-PRVS: <DM5PR01MB2412B9B44F64B7A5964C74099D6A9@DM5PR01MB2412.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3OYuP116UM7SKUmOHDGr/iZI50UxbhF2qiXyXvl6H+HYshCI/nirNsEWbgwbqkSei+DhhTUCqxIX2VfH4WDtIvIPq3+MgPLIn5iT7wI9FXtcj0OyXjX9WcMCN0LBW9nug0oeoMr6eyHkfVbYzkQXuy06nSCK4qNlqi6C0lyAprisQPNuRZsWZJMZut+4xuOg4ohOVij+O3rT+biLgMt1gVaGDgxkO/FDcrzEPLlyaxHUfmxrzh5S1csnRguGRAvLbagkdWiSz0G3z5swhLNONGP3LQkw5pBYSJYCYJDtJ2mordC2T1wd5B+2rKD4n/EyQiCfITuqrKt9F168u8LnpMI1YdZ8EfsCE+W2vIOP3cH+OAgLFpzUoSdk4nqA6gNqUNUxPDbwH8yoWZUwKyRrJC/IxPSxxgbfO1ugO8Rmn2/T4hjs5OhbZfQI+xKR7XPMkUUNAoKrK5xNIvJ3z4n3rYNZRzUXTg2CNew0IT+9LCreBO7dvVswk3D13JKXLFpjXfddz595x7pXe3DVd7n9yj9Vt8hX+BK1CWkgF9hHpk6UrxfvnbftW4SvTouYo48dzdJbFp2vfAG9aP4+F1sldRvJ6BRYNElUQaPuYt6CBBsBMZOJUDjHmVwJuJ4MYlLmZez8O2xvLmnbDcGPsl9honXBndh4WtvTOcJU27SKY0qtIRM3iA8rM6d998OIYbSLWNI8jJYbjzgNpCv4FyEs3q2FSuXrqTkrovP5PKeULtFNSQ00RvATby7CEoD2zQksBQJPmKitiFeXxLXsPQSedMILHtITSDZV0UkkSBX1Nt1WDg6xdwodJLbqhUT5ZBGf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(2616005)(966005)(6506007)(6666004)(66476007)(66946007)(6486002)(7416002)(1076003)(956004)(2906002)(8936002)(5660300002)(508600001)(26005)(66556008)(86362001)(4326008)(52116002)(186003)(38100700002)(6512007)(316002)(83380400001)(38350700002)(107886003)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vij9g5atelKtp8dDs92hrr8wypuZOuJwZwCQY5VtPBl/7TArojMZmyfJUJkZ?=
 =?us-ascii?Q?9wh7sXfCUIFmgQk0jw3Nmqm7ODhhkrGpl1GqLW9+rSoCvD7QCvb3iFpZRJLA?=
 =?us-ascii?Q?6YHV8FSWepUplBysY/ygyCKTlAoSX5jDKex2qvCBiDgCRZBeENkCZSqGN3zp?=
 =?us-ascii?Q?pCpD8S/aF9dUSmO/xMyyw+M3RnRregUCeRAq0k+5EtV8ZtzYTMdiRrGykppG?=
 =?us-ascii?Q?8+KxIf/hOO6U+89CS5WmzIwX6Eg4kpLltHUZ43dhmXtc007MtpeF063ODKJZ?=
 =?us-ascii?Q?yHFJQzc63rVsI+kJcBVz2OoasSO2JXJXhALpUFhmXXg2t8T5+fRnNn9oWvLM?=
 =?us-ascii?Q?Rcs29Z/iEmwaqxa3Q6zz3qSo3C4NqUVbNgIBvpYB5MH3dRV7JdyP5V9XHMhY?=
 =?us-ascii?Q?rWKais/DC5uoEO6+q27hyLXkllt2g+OEEXZ18QqC0LH4Po3vrsbUCZiN02RL?=
 =?us-ascii?Q?d6/64mLVeA2YU/dfL0HPrGopHOam1cJfVVPZ+Zsf3M/XWqlNUppGBUuZDIdE?=
 =?us-ascii?Q?GO3AnLQhdjYZxGRei4Hsy22AeK0Ahd9ktgTyBGxPAPH5P8coXMzMtnoJSETx?=
 =?us-ascii?Q?AbTGgldwfZ75nYowqtSu3a+1J+PyZiGOGWuIrFNicNNLq4IBvfNFjAzYApvS?=
 =?us-ascii?Q?3nvT6LBUN8lXX1m4QLOrWySRf39pUD5J4LaZQUJ4G/hlSC2naE1VsdkFnd3g?=
 =?us-ascii?Q?mYtvZy6jXEPqhcUGdeER1+RutFRZwMfmlGpJegppUp69JiLu6ZA/46eHmP4T?=
 =?us-ascii?Q?pv2EKcP4XjmTnoqySIkU02tVWsm5PbO6WD8eqTuKQn7Bn9LFO+883500veof?=
 =?us-ascii?Q?QXVti7x1McCcLp+1KFAossCHsgYCv5DVKAc1YiSrAZozuA+QGpi9aSDPGecY?=
 =?us-ascii?Q?JgAft56apblHyfnr5InMsNxbhBVHQjUi3AaMcuVud7Qrm0K9/fzk0gLs5sV8?=
 =?us-ascii?Q?R11ueIhwM3SwvjQcob0wTfxch6adxX85x4ta2H+iLn8t5yMiaRrNwqHldxvE?=
 =?us-ascii?Q?x5wqLTqLfpPSMnmUV1yiCG/QBixfEVPBt97ozwpdEzosdbd8dR9ID0yS/DaK?=
 =?us-ascii?Q?pc6CgTBXX4BUBFDYqojDYZqsdVllBUudwRYa9F2sf7/y8XRsLrsJLNi8X9h0?=
 =?us-ascii?Q?TOHiPm8/aAmZsO5D0rNRmfD/pUlSHIHdsLLzib14EGdOEBepIc8tlDJ8NcJ6?=
 =?us-ascii?Q?yuZpDk0ehW4bsoOzrq1Qx6Z4USfrEMdzzXaeyBLL60bDj8UWtPo/O/8avFcY?=
 =?us-ascii?Q?Rz0yXhwkb752rQhnd6+uA63N6Hz+zJlQCjVb0BAyPt6I0MunavKrdBW0XoXx?=
 =?us-ascii?Q?ZUFR+pt3i5wSCNJifR+LvTZcNHMQcNQT5znmLFZSfGyuQbFSHPlUC8aQf64o?=
 =?us-ascii?Q?zI0dOHuW8J5vqWsRp3/4z9+UrO1n0HR1V2np2Tu1o9CzGgys6jg45ai7Ajjr?=
 =?us-ascii?Q?zu6HhuczRvJIPvdTHn3u/EiPOJbDVrXZUqz5zJPXswMPzq4Jori1D2k+flA3?=
 =?us-ascii?Q?LpSK415v0TaV//DpeyTMsNhTmOXCZHFEa1FuqcdBfAw9QJxzwiUzCjLY+W/p?=
 =?us-ascii?Q?4pVoeRs3+q39fhwZrk7COIFzzBNUYGSWEixc1fvXZHXqtNX736qHHQ6J+PiK?=
 =?us-ascii?Q?DYYlVewqZ5vOiA4DWfTDDXxuImGhlY00C14SKH25Gp+FP5F+9ikrf+ddIqnv?=
 =?us-ascii?Q?KqJOt8OKyQPHp4VbawMwXXn8oNKTJIfAlTZPPh1UAjdppgv5RZKqlgDaEyc4?=
 =?us-ascii?Q?IIqb3EfmWg=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d54e2a-c148-4ba2-1cbf-08d9b606c1e0
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 02:43:59.1813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2iprQxTKMEQmHipb6VwXAiAtq1w8BDLXS/60rLB/+pgG1/YZmUZQe+ty3wLoUxqW7KAI1i5NozA5JWw81txXtLtX266x47YlKV/yyiI8le2ptLp1RsYLhStteU67kqK7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR01MB2412
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
 drivers/acpi/arm64/agdi.c   | 133 ++++++++++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+)
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
index 000000000000..cdd8811df3d5
--- /dev/null
+++ b/drivers/acpi/arm64/agdi.c
@@ -0,0 +1,133 @@
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
+	struct agdi_data *pdata;
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
+	pdata = kzalloc(sizeof(*pdata), GFP_ATOMIC);
+	if (!pdata) {
+		ret = -ENOMEM;
+		goto err_put_table;
+	}
+
+	if (agdi_table->flags & ACPI_AGDI_SIGNALING_MODE) {
+		pr_warn("Interrupt signaling is not supported");
+		ret = -ENODEV;
+		goto err_free_pdata;
+	}
+
+	pdata->sdei_event = agdi_table->sdei_event;
+
+	pdev = platform_device_register_data(NULL, "agdi", 0, pdata, sizeof(*pdata));
+	if (IS_ERR(pdev)) {
+		ret = PTR_ERR(pdev);
+		goto err_free_pdata;
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
+err_free_pdata:
+	kfree(pdata);
+err_put_table:
+	acpi_put_table((struct acpi_table_header *)agdi_table);
+	return ret;
+}
+device_initcall(agdi_init);
-- 
2.17.1

