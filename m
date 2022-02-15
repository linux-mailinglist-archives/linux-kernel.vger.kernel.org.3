Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F7E4B61E4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 04:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbiBOD4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 22:56:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbiBOD4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 22:56:43 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2126.outbound.protection.outlook.com [40.107.93.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A8775E6B;
        Mon, 14 Feb 2022 19:56:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8OgZLQI5sj64dZpHsVz29g29uOOeNE0aSFfIYRM1VxLUFqd4I7BrHPs3jwLz6Z0W+x+8NFvibz2/emH9zpphdVUT/57ZOJR99K4m9u8PjRyw1N2asv7DmfJiSNQcXaKnLKyiQezH6xfr6gTn5dbj5dK+8GpaXDmI8ualTC/arabntwUqRCrFZMznaf0S90km12Z9OOdggiP2ba7y/Z8cyQ4cJOEOlMnLmj3OOGTwPtjgZKXV2IObqlyhpxiVsz+jImSyNoE8FgdtVPyHNhiVZ3lnCPnoYnCmAZl9FJLMMLeVOcvsd4cNt+KEVL9IELYH3FxKPe0u0vXMpY80+MFCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqrHSDdBCY3dbmh2SBmKGwbeRKiZRNsr8GQ9DG1Xaxw=;
 b=AGmw0tlHqjpYjLGgFBsg4i1qCEV4qkFTCLChvDEefeWsnIILAi1X/7SQajJzhj7fdlaQiWPjK6o3sQSduDU+Ts/DobFZThS6z2A2+ikONvrdx8U6VdCQM7I8zV0zl6djlA6sSHQOOgpK9pAxR40h3CAPVUlYlQmvPNl8+CRyla7GBfbZhUYOfqLKZlxXE5ZPpIoELtBcNDXc6Y4r79XViX2tbKDJKIX2oKj1uY0oknAkdZ2XiKarsN0roUkBHVh8+L4WRBpdmgxjNkteqNyTOd+eeHBkIHA9kYXe2sCWiEC+6I44iCDdp4ShbmHKrryTaaJ6pJccZsh29yI5CteQlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqrHSDdBCY3dbmh2SBmKGwbeRKiZRNsr8GQ9DG1Xaxw=;
 b=J1sY8LkztfwfqaJuR3r6Jd3CtaNjvvElWKE1psliGl3fiTBpW2zszpbtVtIe7VlflH4tlWCXDchFWpnZx5ycrA9vPM/RexBv+GlBmGJiYa8ZdZuzSL5iqNHB/dzZ3WU4Kzccr1+shT+ToDjsQ1Ewo0zrmRm7ncJTgiZuG+lEAWo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 CO6PR01MB7500.prod.exchangelabs.com (2603:10b6:303:147::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.15; Tue, 15 Feb 2022 03:56:29 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::e085:6acb:773c:c3e7]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::e085:6acb:773c:c3e7%3]) with mapi id 15.20.4975.018; Tue, 15 Feb 2022
 03:56:29 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rafael@kernel.org, linux@armlinux.org.uk
Cc:     lenb@kernel.org, robert.moore@intel.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com,
        scott@os.amperecomputing.com, darren@os.amperecomputing.com,
        james.morse@arm.com
Subject: [PATCH v5 2/2] ACPI: AGDI: Add support for Arm Generic Diagnostic Dump and Reset device
Date:   Mon, 14 Feb 2022 19:55:53 -0800
Message-Id: <20220215035553.102315-3-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220215035553.102315-1-ilkka@os.amperecomputing.com>
References: <20220215035553.102315-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: CH2PR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:610:38::38) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1acd92dd-da69-4261-5a2f-08d9f0372540
X-MS-TrafficTypeDiagnostic: CO6PR01MB7500:EE_
X-Microsoft-Antispam-PRVS: <CO6PR01MB750021594A6F0ADBE446C99A9D349@CO6PR01MB7500.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vT/LGWY9XQuBR/5Db+Wzy5S0XGohyWtlc3PGGHzTLe+ETLNWkjCbIutVOZmdzLJuoMkzBhUWePng/WbnSxkFdkiRII1Dy6FUx7bXgHeMqSApqGUacTSE7D9CanWGV1ENWQwQr1FNCsLjD0GEm4XFG2I9vRS48QQoHR0ZzTDHkPRX+jqMBd0kein5jJgiFccD+TtutkSAqF3oOcQenYYamw7b4MpB8mJ91VextAn0/CEto6qEd2aXLwqRYwkgb2wMIvK8YAU7OHUexY99eFyFQgncJ5Qmdrihe3NYi1azg++Ow0vPHIkM8rMCYsLYJBQ/F5WH9l83mS6CQwjX3lrcPWk9uPGZYcC+XSWG9HQhdxBlTrWa+7jiibYAxXB5FkilDynriQzabIIq9EaAEK9+pVQYSXiltgCheSwolct6eW1+9j48o2o34hVkcDItvSP8SbXmFyFzSUU9Fdm67mdprvZ8IRNOCVT25XSSGNBsE8nwknLX8V2PahlKKmhS3OU/KHEU6fpNnFGYxskE7PGy7Lf+qkPzjOAE4RCknO1ei0+yNLdRIPgaiR01vqDJWN6X1UJhvQpR4m8xIhkXnyj7QNf1gI1EP5XyZwMaor4sVkJmw2LGGXJaTqikmzXigjXxkJEu0CGrs6R8RD7y7j2CxiFEYBYo0S27NFeDel2Ux8BRR0+dkeOKvvh3yjGrHhedc0JjhuWqZl283xKZciqprOfMEEkuMtouhMeDXobtCCqZSR+pMvu34FrLPryc6LG3CwqJMQUrO2f8ovwRtbMbjChNUFRcqQ2votkHtGx+DybsUT5lSz9pXubPl0ziP/NR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(8676002)(66946007)(4326008)(66556008)(66476007)(2616005)(316002)(1076003)(2906002)(38350700002)(38100700002)(86362001)(6512007)(5660300002)(7416002)(83380400001)(8936002)(6666004)(6486002)(508600001)(6506007)(966005)(186003)(52116002)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tU7pCPIeRpempZQDBUFb6MRojDC82Clb1ae9bsaeS7RE4GJf/zZUvrQax5cy?=
 =?us-ascii?Q?o4d2vNElliuBBHw52QGhfy1GAFz2GgCxK+0RJ/uVY97/Xsj//JDJ0x7Xw4uA?=
 =?us-ascii?Q?JqGOaB5VqjiukCvyWkGv1Jqx6o58UqUXRYUGLM0V8rSE19v6+OewHrley4jO?=
 =?us-ascii?Q?D6so3lUjDSE/npS0FibgRSCs0y8e27GG55bCWhyTBmwuXwIfSn0BXsiRGSCN?=
 =?us-ascii?Q?klIIspzcwrXV5rKF0wWfz7cWGQw1SzsWyv+8C9xR40iJ2kkOJgCkgr/IfAdr?=
 =?us-ascii?Q?HVeRz4BBENT4pir0isCyhZfHS43NmNuT4+GgUNJzz2EAyv3VOrddyls+3Eh2?=
 =?us-ascii?Q?QKnr9PSlYto9y1Sp6+Yvk8gyGsLqw+eDSaMi1jtehy8UqwY5Foivvi+8C5Th?=
 =?us-ascii?Q?sRJ2XFIpWbz22b1GO33iJ7AUHZN0OVlF/vPg5bQ44LxEFCgwd/m6DVHIp80l?=
 =?us-ascii?Q?ib5e/yYFteTUqOiVvaZwbWSPFbOA0+WHzRGbIcMlokinZQ+ekIHhICrGkQvL?=
 =?us-ascii?Q?kRKmpr9KnbShSpRr4t1IlxHYas86T4+CjEQTgWTnbhSDDQmWAkTwdVzt8rB/?=
 =?us-ascii?Q?uPOjmhOfQSs0IjYkO0gDsR5U7Qc/x+jZXw/DFLsvyqi0Q5nvf4F4tcPserly?=
 =?us-ascii?Q?Iq0tn0btQB1jEjRPsrKg8nbQTxey3UgQ4nqHOGslzO3PGTfdfWBdTca36aYi?=
 =?us-ascii?Q?P2cpvuhee4bGfjud9PibEvbM3G6i3Bx1W3UBSWyZllBLuI1lYGgNoezTgqnB?=
 =?us-ascii?Q?8LRU9PYUh5nKfWxtTAmzSPZkSpFfindd+5pkPoDXSf2GX+323B4eCILMkOz+?=
 =?us-ascii?Q?FdASAQqm7sP9KXka+ZrWoCiEcXxOiw+liC5snBG/f9myFkv8bza3RX8hT7Cg?=
 =?us-ascii?Q?fGSirXCEqIp/WJgX4mvLfa8YNJrk/bgJxb81PyRO26aY/roQlVXa+cnleUhP?=
 =?us-ascii?Q?UW5GSwRpsb7VWQJIqaiCmCBIs5TvUjZnZABIoZSA5G9Fup2GDiJLqujNlQhu?=
 =?us-ascii?Q?cEtBFo5DR06gzc0sOcwr1BBLvrnuy8dhwLGmW34Y7XO2eNZGDDmbXqAoKxkf?=
 =?us-ascii?Q?Ppq8DU97HDSnXz/QEHjh5vi9l9Ji+YSlsS90AILTDaApKgoydjwEdFeP5/eT?=
 =?us-ascii?Q?KvzBCnTYtWqquOf15XsgHb7iUPRW7v1BFsn5EBgPIHDZIBSBYBaL8ivf1WnW?=
 =?us-ascii?Q?EuNWOBdMjuHJCTmIqXjIKxmwHXcbM08lpv1Jeb+KnWPQPsQYov0F+2HqJW1e?=
 =?us-ascii?Q?kSPskj3wrThxFWyBrUtNVM6DuT+rK/cGadLqekxYSaCxFBXNVSwtfvkNEbYI?=
 =?us-ascii?Q?5KuyQWcMKCIkm98JHYWJEZYXD79m3XLT55nv/QrdBEZ7iK/oKn+iPumFF27r?=
 =?us-ascii?Q?oYAA6iaRxsmVk4agshpc6mFdhZ5D3LkZPT8gUqligW12IUgj3S+dlx6uh8ng?=
 =?us-ascii?Q?d0Am5jfcVvv/F6gByzQv3nv8A2ydAoOBeAd1zXzjEpBom7WOU2iXqeD4QM5a?=
 =?us-ascii?Q?SF0BZSmSa7o20kpID1/X2t98AkufOu5uafX94NHeqL+F1eZv1AGcwH0tRe0r?=
 =?us-ascii?Q?6heyIPVXQdAFzk1Vtp94Rxz5FctwuEZ+MEY8A28jBDJgH47fvQmabPSEXGdv?=
 =?us-ascii?Q?MFb+K1rmNaBiT/1vkpmFvn4dxNu20puDXRpNPTI0vDWcVd2Td88tusScGNmC?=
 =?us-ascii?Q?Ty2DulRjX2wUKkthodtH8N93oAlgojCSaf1JOusF9AKG0CAvmtjm1fCTiCuD?=
 =?us-ascii?Q?OVLVKoqutA=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1acd92dd-da69-4261-5a2f-08d9f0372540
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 03:56:29.2696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PpuHmETDbcbTj5KTqNhfneWrLTTw1WwKWtQV0Zm12I4u3cjU3FiMSelY3UWxa74ZjE01BGPOM7IN1+0c9yuik78suoMj0IC9su3ysziS0yoSmLOcU1vLbXRTTNXpQj8i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR01MB7500
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
---
 drivers/acpi/arm64/Kconfig  | 10 +++++++
 drivers/acpi/arm64/Makefile |  1 +
 drivers/acpi/arm64/agdi.c   | 52 +++++++++++++++++++++++++++++++++++++
 drivers/acpi/bus.c          |  2 ++
 include/linux/acpi_agdi.h   | 13 ++++++++++
 5 files changed, 78 insertions(+)
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
index 000000000000..28916650d834
--- /dev/null
+++ b/drivers/acpi/arm64/agdi.c
@@ -0,0 +1,52 @@
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
+
+static int agdi_sdei_handler(u32 sdei_event, struct pt_regs *regs, void *arg)
+{
+	nmi_panic(regs, "Arm Generic Diagnostic Dump and Reset SDEI event issued");
+	return 0;
+}
+
+void __init acpi_agdi_init(void)
+{
+	struct acpi_table_agdi *agdi_table;
+	acpi_status status;
+	int sdei_event;
+
+	status = acpi_get_table(ACPI_SIG_AGDI, 0,
+				(struct acpi_table_header **) &agdi_table);
+	if (ACPI_FAILURE(status))
+		return;
+
+	if (agdi_table->flags & ACPI_AGDI_SIGNALING_MODE) {
+		pr_warn("Interrupt signaling is not supported");
+		acpi_put_table((struct acpi_table_header *)agdi_table);
+		return;
+	}
+
+	sdei_event = agdi_table->sdei_event;
+	acpi_put_table((struct acpi_table_header *)agdi_table);
+
+	if (sdei_event_register(sdei_event, agdi_sdei_handler, NULL)) {
+		pr_err("Failed to register for SDEI event %d", sdei_event);
+		return;
+	}
+
+	if (sdei_event_enable(sdei_event)) {
+		pr_err("Failed to enable SDEI event %d\n", sdei_event);
+		sdei_event_unregister(sdei_event);
+		return;
+	}
+}
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index cd374210fb9f..747a7f98fc1b 100644
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
@@ -1341,6 +1342,7 @@ static int __init acpi_init(void)
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

