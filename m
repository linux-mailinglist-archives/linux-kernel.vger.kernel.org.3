Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D125C473C20
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 05:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhLNElS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 23:41:18 -0500
Received: from mail-bn8nam12on2135.outbound.protection.outlook.com ([40.107.237.135]:49601
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229449AbhLNElA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 23:41:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JH85nqoXgmvq+jWen+B+RRmCsCWt+GGVAVa5mM6jyxyfH7w9+ywnV840g9XG1/YqFzalnb4D3K0ZeB33gzanb4y7QGHVzwmbW4hNjWAP1hOnTgwZLOa6+YC7V3foSySQgAGTtoI4kcH5/DAvIXsOHK7wkAge6WQVhSuUWxagfc/FiBJGJ3F/ZcJ/arNDQM+C0TSLl5fYMs7cn5UMdWYF7el0MPV/3rzboM+4WPcUGjY9rKsijmIe0IhiQj8nM99MGGJ4JjUhfBJPYGDHrL77AQ7gb6bE5QUc0c63RSuEunBvWEoF6qGGsY7vMpKiItNhNUetyEXtICzDZ9v4+RWu7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbAkhrQB8e00n7Lfgi9b6VumYWZ7vNWCYET9PxfwR7o=;
 b=VHmlYs4riZ/lu8JWurWXD8CdflFWGLGKQzCFMntnCdod3USziHJJDRJ3c/9e74zKM4GoHkbVsPNWpoHNMmBycN58R3pRTByqkNR3TAXngKrsygpvP39c3G/wRbFLyESK1wByLjP7R9kv04lcJY6TEoEbdDxotpbOatZA+I6/H9G/hZpaCMsWXZwaY4m11mBy8XBQE+Higj611DJo53qBLkp0FQA4Oy1Dp0VxXSUl6jsYW6ATmg2k9Zgne+KVE1DGXeQh176YG5qQIEV9PTRIis2uXOF9T3M90HPgkXk9IBQ/JDL0dUZInEtHjGEBDyNUS14+d50nSO2yvW34g/PDXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbAkhrQB8e00n7Lfgi9b6VumYWZ7vNWCYET9PxfwR7o=;
 b=eG2NAsywWPkW0mKlx9aN9WP/PAzIcRCsEzq9njQJ5L/9CYXrr+HCg5UqUx68/Fpn3bpFWqAIY3A7BPP+MYnvqJ8M/Tr81UhEJVGa6ktd7o+Lb+/5r69SpPusYqz9MU011toVr6+Vjmfa601hohaZZ52Y9XM7MUxgdZnySViZZug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 DM6PR01MB4826.prod.exchangelabs.com (2603:10b6:5:64::17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.18; Tue, 14 Dec 2021 04:40:58 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::38e1:cab:501d:6b96]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::38e1:cab:501d:6b96%4]) with mapi id 15.20.4778.017; Tue, 14 Dec 2021
 04:40:58 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, linux@armlinux.org.uk
Cc:     rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devel@acpica.org,
        patches@amperecomputing.com, scott@os.amperecomputing.com,
        darren@os.amperecomputing.com
Subject: [PATCH v2 2/2] ACPI: AGDI: Add driver for Arm Generic Diagnostic Dump and Reset device
Date:   Mon, 13 Dec 2021 20:40:36 -0800
Message-Id: <20211214044036.48245-3-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211214044036.48245-1-ilkka@os.amperecomputing.com>
References: <20211214044036.48245-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:610:cc::8) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2b255f8-55b4-4039-30c1-08d9bebbec80
X-MS-TrafficTypeDiagnostic: DM6PR01MB4826:EE_
X-Microsoft-Antispam-PRVS: <DM6PR01MB4826BED6C8B0BB106E8B85719D759@DM6PR01MB4826.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fKh8f8JTI1An9G4dURfNLnp+KTVF56ShkKtGL2IukRRKf1lIR65RDd5GEO4TWSWDk361/g7SYeoLIKAehmpf8SqoXFwjBHwOt861ARGvy2GaGUKuOxko8fq4QqjdgEaKfs55o2EBkUvtHRY6oTqlq+Wafi62O9Tdx263WqDWUj6sZk5INSzXhe8lEd8Tvs8t2uFPmRPu3YBBUCq+GhfAv5LEo+H4B0e2OfICM8vHQF27aEz9yYS1kJgckN4FCRJou9ysWeyiqvx3sdTHtWbzDO7+iD/gAEoW8/Lxlh9rmKaMPWjwiW3en6S6ufjUHpzb6yAEZmFkjcV5EHwTl6nTpgs3Sp/610j0dIcEAJ9NNjBdjPJdxR0rWRadGksMwXBVsOIoJkrFt0LdpOFQ/dX2nVjnAObBC+AsVWOiUKFgDoybzcdmr3JPZrptqFEXUPQaVbN4YhgGniolMekC6AVW1GTbxZ+0QZjiztIUbw5xBGohrfX5T2294VfZ7WkPfVJ3X5+boVBiRqQ+fZttn7LQxLGJW404DK4Zwj1myqze+dILHkOL9a611oM9D/r5/mQfZK8JMmtvF+Gqz1ZNKHHI0r7EPA4y5ugc8hqrxXDszGmFwLfiX+1MPP+qXBt5BD0tFr1jjucpUDz218jCheMWTU+hBvjluVW78o5t10EYw1qjnTKmzu8foUFkZqhMZTHN9XP4Z90lZOWV3s+SmKdaodSyiJGw3hWEEz/FZjFkQI9aoxEMQ8LVfIUnhmfZ0+Fmxh6d6mShrh43Er6wveoBoN3vEGfEl84YCognllRvlziKhnebYVsT5386bN0Rsinb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(107886003)(2616005)(66946007)(66476007)(66556008)(186003)(26005)(1076003)(316002)(6666004)(4326008)(6506007)(86362001)(52116002)(8936002)(2906002)(7416002)(6512007)(5660300002)(38100700002)(38350700002)(6486002)(8676002)(508600001)(83380400001)(966005)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zIdFMrxNubwvvcviH1GCMHOQz2mONyKynoxLi4Q+zr6MXHgR/4+rS03rI2nR?=
 =?us-ascii?Q?tu0RTvs4zTce4ay39nheHfoTECrW2nR/mCYPsdwNS1n73WxkHagoPZYOHmCu?=
 =?us-ascii?Q?BIXie7lCGzWpvuUokFmFxBSgo1DKf+JYH96vcZXNSI4M9aBiAlcUzSb9CsM0?=
 =?us-ascii?Q?w/pK9k74OB9z+2GSvVHN/0YS+rtz2v57OCA0Xqm6pHQQN2Z8l+RjeAU0Ofpf?=
 =?us-ascii?Q?bQzlVQTUM/BZMDkU/keCvUL3Z2sJhsg4DlGEchAU8YRiRFbhRNUZnWt18d5f?=
 =?us-ascii?Q?ISxd1H6FftPLw6wOBGnu+myJvTFm98xQ6B2Zb69jWMTMSyPwO0NJOoCV3csm?=
 =?us-ascii?Q?VwcT0vrz8+vGFR9+q7GJ/T5225890MqGeO9YiBCPD7Abk2Dtt5aZ+6WAwYH2?=
 =?us-ascii?Q?RBp+/tdiWxyYfsfgifGoMDzVbgBcT/8sVgM29+gHjnR1/dZZmDiV2rYQYuLy?=
 =?us-ascii?Q?b7Y3T+IPvW6YFgnT/o1iSR+U6SxKkNeeSeBokINBgjF40dOry3bLo0qB9IkW?=
 =?us-ascii?Q?gxvpOfkSvRxzt4qtRy2FgFyMJ8H5ytYaJ3QRGtPK/szzj6LO1PaA58pEF/2y?=
 =?us-ascii?Q?iKEKihV7nKrUzIh8D78Nr5AYKpqigwXmSxbRukensNR5d3UdQkydf/vfeBon?=
 =?us-ascii?Q?jAOME5AstTHP3LiZOmwk+OdOuyfNB5vYiMhcFBJcBst4pIxnev4suI7sJV/Q?=
 =?us-ascii?Q?yiCR+q40fAUd5uIxtDiZcSuEbK7cNhOHVvVcbfQhMVITlhJ9Rz5QhEvleHab?=
 =?us-ascii?Q?oFzH0o8RY///+VQcSBZTwp1yS/ExMCCvzSxL7clDIEMgnHo5euTGK5QlFllT?=
 =?us-ascii?Q?eoMbP/8DYh1X5ddvgL/+GlohGn3W4544uxqBXyIkNtv8JU0zee2jQIjADO6Y?=
 =?us-ascii?Q?FmC+yL1/h70hJDeivs7LEUL3m6TU3jJKUGYaib14aZ2xBUVsjZdyiOZMY49/?=
 =?us-ascii?Q?dVWMcB6xHZzHivBadky4kce+L2fZeTH/xRw0aPudhL6lKdgua+19klk/Bdab?=
 =?us-ascii?Q?Z/EROIPlVxWV+3NABbbMzoIj6cg6BUqKeLkiS1Pi9RUWv3BxLUP0oHjqvvW2?=
 =?us-ascii?Q?aS/vgCnahvxCNCE3MYGC9ScFY+E5HtXyUmLRKlhMo7devr9zq/hsJXMj3jMk?=
 =?us-ascii?Q?kgal4Bn4jtPRvK5PdRyCYn+5gqaPrqxaCr8EHvoz3uYWsPOI3xCAMvQ+hAVV?=
 =?us-ascii?Q?BnhdzkmqpkBpy/mSQUrTU0g9kjdEE7wyIb9Rd4mxgS3cozuoXi+OYnAKZIuL?=
 =?us-ascii?Q?XGt4F6nuMe9Tn8P09+FNfA8WM7F6dxuMcOsWSSjyb2rHex1CNOB8BffC+Cld?=
 =?us-ascii?Q?SpkNzqPZWUGQPZrOf9DeTe296/WwYo5NwtvKYJx6bbmxMknqOrdaTE9P/YHc?=
 =?us-ascii?Q?wHFyjORhGqph4K+jwedfhV22yyswbUdpVF9k6PTsQsXpkuC0kfP4cFG6tVhM?=
 =?us-ascii?Q?b9pHNUesfNShEvNLdsIvoT9oBAHpTFGS33TJQ1KIgCz8pYq9Mt41j+/ZcBDm?=
 =?us-ascii?Q?EVzUOWJvw69IjW9xMhHNL3YQRWd9qqczNfmjiQfZpb0y3qgBL1AkfODFzSJn?=
 =?us-ascii?Q?OdkV1jJciDkqDq5h3sncCt+C4OdMvzKSSKrnZJNJ2FsREDyiWGo8VldDQEUQ?=
 =?us-ascii?Q?FZJWNd5isuYL4ob8u1B3LXJty1Z7qZuQ7hUXE/FSXVnuvSduQ4VWnUT5DMFC?=
 =?us-ascii?Q?bX13Cemu5Ta45kZ8llbCu3SJ2C68R4doCxHnzJqvBRu6JDSoI4PYmnRoh9mr?=
 =?us-ascii?Q?c4IsEsLLPA=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b255f8-55b4-4039-30c1-08d9bebbec80
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 04:40:58.8746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VuoEDoMm+A24KnMrgBZzf/9heBRpvQoKOYdPtjbvDBt4sbozR0ksAgYWKRWHXPPKWUdGQ7mFRcRQUOokj026Wl0m9GTVNjDJYkN6gfVrGIBIjEuLx6lv111kdQCF2fSx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4826
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

