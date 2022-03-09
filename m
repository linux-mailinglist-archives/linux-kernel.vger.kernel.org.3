Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9381A4D26BE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiCICJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 21:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbiCICJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 21:09:27 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2105.outbound.protection.outlook.com [40.107.243.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A00912AB2;
        Tue,  8 Mar 2022 18:08:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HG5JClYVJK51ttrLE/ADQbB5MzOv3/Ja1QYWTOuY6guMZf/BB8rBznl305ez328DsYjOcIuF0XVwSWyr4Fn9h4SE+EGfTNH+NsK1vLo+aDr0pI4P/Bwje2zvcVBXaqw1z7xUSxGVYbf0D2z7W7RKZUSYDIBmxHU8VtlEj58uMhCXFVHZtcoqeziSDBvQ7nVkmiuXbQqTOQ99boT+YgwgURcuINiTSBGsODwG24TZNLvBaLJvYYVGVd+MlJnlSCHzzA/C9kakepTjrnq5KH5yVQAO8f7aC/1fFmzsJE7dNZWft4NP6Kodea/myOg/G2y6pbgvgQiI8fII+mZDF2JGMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSIG8xyyG+EsYuBd/Yx9mjvz8c9I9RBO94R5frPgdEI=;
 b=Q5Pv1wY7TuXPDK64akBXHm6BaHAAi1tq3jHygHnL55NDE7XMhSoyGr5qe9qEm/aVryQa1whzpmvXYdlp+rr8G7lrmShCiSSjNuRLXco1R90i+7qmQjxsedWVRd6jrO6Ic4cxiTZBxXEHH1kXJrR7jmtPL1Otrgrh3SipyDhJiu9a68d/ssc8GrpkNO9rmnbCRL1UbkW/Mc2VC6x7ygI/YsJhV7USQCf7pDbADNQ3al/1xMuFvd2KCF7wCq8C4hEkd+zV40DjKXvnLfOnsHr/oJutvlmwqfRCNlNFbbEbAdCkEVawZLXkTFtc5TTargx0F3yKxWeMPpZ4xmWTU//ErQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSIG8xyyG+EsYuBd/Yx9mjvz8c9I9RBO94R5frPgdEI=;
 b=LJqF/+EIdRie9o0W4RTK0E6CSVyEPIvFcdFxD+3iFoaddj/dlwhuKpIGaAfyJVUh3m2RAIQsK+PzjE8Pt2geNZmtl19sEiXfJTxeB845+18g4O6wibn641GztfG3MXK/Z0yNnfThUG86l5HYWCpGrT7eqr4VphKeGLUmuBQo5MM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 SN6PR01MB4288.prod.exchangelabs.com (2603:10b6:805:af::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.17; Wed, 9 Mar 2022 02:08:27 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::181b:1522:26bc:c243]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::181b:1522:26bc:c243%4]) with mapi id 15.20.5038.017; Wed, 9 Mar 2022
 02:08:27 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rafael@kernel.org, linux@armlinux.org.uk
Cc:     lenb@kernel.org, robert.moore@intel.com, james.morse@arm.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com,
        scott@os.amperecomputing.com, darren@os.amperecomputing.com
Subject: [PATCH v6 2/2] ACPI: AGDI: Add driver for Arm Generic Diagnostic Dump and Reset device
Date:   Tue,  8 Mar 2022 18:07:50 -0800
Message-Id: <20220309020750.65399-3-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220309020750.65399-1-ilkka@os.amperecomputing.com>
References: <20220309020750.65399-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0423.namprd03.prod.outlook.com
 (2603:10b6:610:10e::6) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 398f6a29-7c67-491d-83e2-08da0171b2c7
X-MS-TrafficTypeDiagnostic: SN6PR01MB4288:EE_
X-Microsoft-Antispam-PRVS: <SN6PR01MB42882A7E8EB20A13CB055E1D9D0A9@SN6PR01MB4288.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hpqksOmwqGzoL2y5FE4hVullZd23sDUpz3amesXv1lqwAD+xBsWZ2O5J54owji2ImHrC2EEPh7pfmLVJIck1tlWejPokibCDPSVbPDxWZHX9WzwRjjBLbtJAkMDVRGuERrbyyD81+8eOGy5v4hJ53c6pc9DaimjlwQdM6OHBfkRl1PvvFKtrlT1jmG5pSIa5167yEcL9aRoiw6O38R2qtDLphg+A1vqNDoVhs0S8IV3Z9X8qs1V6KF/ThuqvOGjfbvnc9Ye/JEmcG5f8+jV797hrCU0rw3xRVeePLUvgd+N1M+3L18gQIQnPlDanDviELAdsSIbCrbBA9/Sp0/EVE4afOx9q54LtNSUuUfelqrtTdMJjQpH2IW4ElrjkFmSl8sNxm7bZ2HMp684BvMBTyhcRmj9wDFbUXQEMFzIA4z8U87mJji6+44QWNjWqM7l/2aXGtTeH2wktEdWL89fS5bcYw4IGbo9yAF3xww2OQJ0HCSfjYlapsXtgFJ8QvFtzVhIC8/892xLWHFfMyc5Y/oO+AR8RIjKVKpDGzP9sZjCMFtX7TNZAOmRhbHRcKKad4QUVdl0Xutwj5M6lctwiaG5ZxRp0bCQ8GTAJqlIdDafONrax9abCw9JqdpU51vsVConQ+5tK3PwYSNRmqiLc7FqsqIo4MeRGKmeMNIa2s4FJ0jZtdf+2a+rmFzK94ozG5j2u3enWUDS8LoBt24TIM/ZJJEZPgg3tNzdVDg38wukLlUlHO4Mqm7ivKBxNxNsNIBex3SfI6YyTc7sflVhBSIMUR6LcwOS3bDeI8uFdcuVB7oCvCDz1Ln+AM4gCoj19
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(316002)(86362001)(66556008)(66476007)(6666004)(4326008)(5660300002)(966005)(83380400001)(8676002)(6486002)(38350700002)(26005)(1076003)(2616005)(186003)(7416002)(8936002)(38100700002)(107886003)(52116002)(6506007)(508600001)(6512007)(2906002)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QjT00PZV4S8GsJk2deF73OxfkGeL0YCqlSgcVz81V7/cP+2CFA1yL4HNxcxD?=
 =?us-ascii?Q?4Yrf/OfjfDNByjB5idl4YL1zDUOKFk7uP5YaS3SjYCYWXUGzXxuAAg2q7J/x?=
 =?us-ascii?Q?Gt3OawvlSPBhHcq5nDFjqXJ1r/XPr12Joct/oyq5/B9GGTk42P3PBjFvH3LC?=
 =?us-ascii?Q?kdstKl5ys6Iisy8+yiktNG4iL1sXyuoZAO3oQxiojpO2gxYAgKZqdG1tOmqu?=
 =?us-ascii?Q?QFaiUjdZX1wbQHcsiq7TFSI3/ru7gwWMnFSvKytahTezseuOSgDY8aA2igrl?=
 =?us-ascii?Q?u0M/7zg4xlsO9+64vYi9dHGhGMmha7juvfRDgH+qrI82bYtdzYyXy9ThL/DM?=
 =?us-ascii?Q?Fc8yo53zVe1tg9qQ8t0Emz7BXmcVu6vCQU4DlNFTJ0Dbq3yr/P/W26wCST0X?=
 =?us-ascii?Q?lMXeiC7CyjcMM0R5KWsrqDrZ0PnkbZoSYFETV2n2QPd8P6VEJ97zsjY/rBHt?=
 =?us-ascii?Q?AsYoaN+S1Vfcwxa535LaF906W0mEVWNfpExKChnqOxhqbCt6yr+cohx2EQSF?=
 =?us-ascii?Q?W1s0Ja2uezwpE1+lp6PdscMyUGv7oGTd27MF3xtnIgnOI3dE7CCB/cV1gROQ?=
 =?us-ascii?Q?Zl1VV+ZHw1KmzIbnSPfYaWAofIsmxVSv1agUhZS4zqtl26msoUtxiR89U2Bc?=
 =?us-ascii?Q?tuptYySTbGs28KpfBg2e8bA8/2uJKFUsf1r/FYP7QeTXBgU734Nm2XCm+QwC?=
 =?us-ascii?Q?A5P+QyxHaMFUvA509dZtRsnkPmOaNMFe0ULek8BCJ/aCqwHxPjvJzjPxVSCk?=
 =?us-ascii?Q?23AFfhNdunIRX6Tb+1RdQr7i/GyH4kj1A41K4vWUjkbBHlokaIyNT0oizgkR?=
 =?us-ascii?Q?IVNKfoXlKfgnaQDNpRDMhW8maPjrImctEh4ml2oQ9rfRc4NRRbf/R+yXtjoB?=
 =?us-ascii?Q?Vw/58v4Vnx8ZGERa8j12ngGs2IC2ZknNL1l6wC5FqLkZzxYvgvX406jwnAN8?=
 =?us-ascii?Q?3CpMgl2LtqNiyFQa+xnUwRWSpEDHrdTUia6QARvBJxOenpqoXEwjenNj6yVm?=
 =?us-ascii?Q?qS4uNJcUWtcinlNIgSy/J1CeuMy/H9jsuPGNF9Ww0ZKf3qkUL3YyyFoUW0Yj?=
 =?us-ascii?Q?sED3K8vr2chhJFXOuCl1EbOtuBPfc//tKMBpaRhNgN9zFwhhMVJwNyzNSvS0?=
 =?us-ascii?Q?S+BtoqsN3OQZJm2GsSuEBQiZmYyooGGFQlfiAoIx8BAn5+DjZS9M7mwblAh4?=
 =?us-ascii?Q?6Gucy2vst51bpC02/KXQUUk9pzUruACrlFvxdrpPyH7+dKnyYJL8mPG6dloi?=
 =?us-ascii?Q?WQAsei/cvSNKiRc6kyaxP8c3ojKmSCSOfE+XKH7NBCIMj9zP3FVUMoD8JdEK?=
 =?us-ascii?Q?6bdvP+UJ+StfbgPAzFP0jseBAWiOsYdx+1VTFuFRN8UZAP30po/0Ykp5CHAL?=
 =?us-ascii?Q?3dF+rwFQFr6Myl+Ovm3kTn6J4IgAANouE02w34nACf9mg79CN1/b8ht36hrJ?=
 =?us-ascii?Q?/4OX73eVi0VgL8vINN2sn/QVymYzklbfwvCI6r0ODq+AWMTQp4IVXxO0Z3g5?=
 =?us-ascii?Q?QZAG4ngZfdwTXhDf7tLjhT1qAo/9NkjcA1j2r4u8iX+iIt+vzi6O5vFRW6Rk?=
 =?us-ascii?Q?B68Tr6++Y0RxQHK5ty0Q4UXucwBaZnPS/NHYIFTadWjwikXKQe4Nknp7N6MP?=
 =?us-ascii?Q?69GqXhRu5uoRHa+BcZ2ImU9929QlATj8HtBGbpppZUvC0ioFe1KsBBZzq7hj?=
 =?us-ascii?Q?7Ff0iUqqexPXtigk40UavnTsKaLQciU21qaO5kFrgPT7QK6mIYIBcBwHmsey?=
 =?us-ascii?Q?UrDCM1i/xQ=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 398f6a29-7c67-491d-83e2-08da0171b2c7
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 02:08:27.2604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xV/BFOr//P0o2ppSgdJY6+gExUM+PonXbuetTT87AsZm55glJAEWR3VWi95Op18OtsK1fMB+VvbP4Ga6a0MPHukyf9dqGxiF/UfemZQsvKCFv9midNQmiPQkWMy3lExv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR01MB4288
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 drivers/acpi/arm64/Kconfig  |  10 ++++
 drivers/acpi/arm64/Makefile |   1 +
 drivers/acpi/arm64/agdi.c   | 116 ++++++++++++++++++++++++++++++++++++
 drivers/acpi/bus.c          |   2 +
 include/linux/acpi_agdi.h   |  13 ++++
 5 files changed, 142 insertions(+)
 create mode 100644 drivers/acpi/arm64/agdi.c
 create mode 100644 include/linux/acpi_agdi.h

diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
index 6dba187f4f2e..d4a72835f328 100644
--- a/drivers/acpi/arm64/Kconfig
+++ b/drivers/acpi/arm64/Kconfig
@@ -8,3 +8,13 @@ config ACPI_IORT
 
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
+
+	  If set, the kernel parses AGDI table and listens for the command.
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
index 000000000000..4df337d545b7
--- /dev/null
+++ b/drivers/acpi/arm64/agdi.c
@@ -0,0 +1,116 @@
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
+	struct agdi_data *adata = dev_get_platdata(&pdev->dev);
+
+	if (!adata)
+		return -EINVAL;
+
+	return agdi_sdei_probe(pdev, adata);
+}
+
+static int agdi_remove(struct platform_device *pdev)
+{
+	struct agdi_data *adata = dev_get_platdata(&pdev->dev);
+	int err, i;
+
+	err = sdei_event_disable(adata->sdei_event);
+	if (err)
+		return err;
+
+	for (i = 0; i < 3; i++) {
+		err = sdei_event_unregister(adata->sdei_event);
+		if (err != -EINPROGRESS)
+			break;
+
+		schedule();
+	}
+
+	return err;
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
+void __init acpi_agdi_init(void)
+{
+	struct acpi_table_agdi *agdi_table;
+	struct agdi_data pdata;
+	struct platform_device *pdev;
+	acpi_status status;
+
+	status = acpi_get_table(ACPI_SIG_AGDI, 0,
+				(struct acpi_table_header **) &agdi_table);
+	if (ACPI_FAILURE(status))
+		return;
+
+	if (agdi_table->flags & ACPI_AGDI_SIGNALING_MODE) {
+		pr_warn("Interrupt signaling is not supported");
+		goto err_put_table;
+	}
+
+	pdata.sdei_event = agdi_table->sdei_event;
+
+	pdev = platform_device_register_data(NULL, "agdi", 0, &pdata, sizeof(pdata));
+	if (IS_ERR(pdev))
+		goto err_put_table;
+
+	if (platform_driver_register(&agdi_driver))
+		platform_device_unregister(pdev);
+
+err_put_table:
+	acpi_put_table((struct acpi_table_header *)agdi_table);
+}
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index eaa511fc9c66..87b93f4df0cf 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -26,6 +26,7 @@
 #include <asm/mpspec.h>
 #include <linux/dmi.h>
 #endif
+#include <linux/acpi_agdi.h>
 #include <linux/acpi_iort.h>
 #include <linux/acpi_viot.h>
 #include <linux/pci.h>
@@ -1386,6 +1387,7 @@ static int __init acpi_init(void)
 	acpi_debugger_init();
 	acpi_setup_sb_notify_handler();
 	acpi_viot_init();
+	acpi_agdi_init();
 	return 0;
 }
 
diff --git a/include/linux/acpi_agdi.h b/include/linux/acpi_agdi.h
new file mode 100644
index 000000000000..f477f0b452fa
--- /dev/null
+++ b/include/linux/acpi_agdi.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __ACPI_AGDI_H__
+#define __ACPI_AGDI_H__
+
+#include <linux/acpi.h>
+
+#ifdef CONFIG_ACPI_AGDI
+void __init acpi_agdi_init(void);
+#else
+static inline void acpi_agdi_init(void) {}
+#endif
+#endif /* __ACPI_AGDI_H__ */
-- 
2.17.1

