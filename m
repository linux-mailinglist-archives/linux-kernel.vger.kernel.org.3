Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE05E4CCD0E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238187AbiCDFYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238177AbiCDFYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:24:08 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2100.outbound.protection.outlook.com [40.107.100.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C418B1ADA0;
        Thu,  3 Mar 2022 21:23:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WT502SxKkPJxN5o61VOS5ROVg4Pv+o/jpzwarx1/Wcu0+kWX5Sx02wgmus2AqphxVsz1YMJZvm8PmklCMEqr2ORZKgT7woCXg9K63t6t74HTf7W/gaqK9/wgtNUyd6r5QEfeB5KKVRAtgNAjIEwqDBOqDyM56AABXdxdjSkuK+wSkoLX99ig/CRDyiUerja7PNxSrhd69HmhdX1FlHTct0h9NCOCL132noRyuTyPFyjusbJ+sNtpb1Zx/SPZg/cGbdpJu/4Es5pnCSw6z6ISoJTLHufER26udD/NZQ6+mDH8OSuZ99W9g3RBMnpMmQmdUqcj1esU7fmrj6T/tDSK1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mfWXihvszlFOIpsJH3Q772oo+mschXSOeDO1eSG5H4=;
 b=QYgNErm+dzVpCPRULrE61db38uZTWlAzY0YJRX1/uhzr62uri0DvDTNrqGd3k/dDSE2WoQc5uknSbmeeTEps2FVS6QSTTnutl3jikwQS07rmHScZNhfWhkovUi2P8xXbh+8P303huVc6Q0BAvjlCgvvJy7aothWzHZCNKRtW5IQEuSqWFgRsVFmT+d2VKndpF5tvYXAW1rjcPf2l0RBt3deqeYamORFa8BtIhnQLAqJAR7UtDjk4u6Q8TGP0pOXAKgDaCDYVq5ymkPjguwWVQJDqYPlUIY6uUhRHezxUeW4Uv8oPAfnmUza7ielGw2DpZN1aSUdjNOQzy5yqE4tUaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mfWXihvszlFOIpsJH3Q772oo+mschXSOeDO1eSG5H4=;
 b=gXPt/73GJg7I/QxhPdxUjsaqOe1ddFHcYjym0UJkekNU8ItYjVPv77hLTNEW5taSJPc34B2ixiP0oHUTOyHTxGrj9xI7lfcNvPWR34sbr5EDymixv7nI9wLOQ7X/0iG6HsBO+faYlJJ/sZU5R8qbJlqzwPP2t8QKA6cdshXoagM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 BL3PR01MB6898.prod.exchangelabs.com (2603:10b6:208:355::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.13; Fri, 4 Mar 2022 05:23:17 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::181b:1522:26bc:c243]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::181b:1522:26bc:c243%4]) with mapi id 15.20.5017.026; Fri, 4 Mar 2022
 05:23:17 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rafael@kernel.org, linux@armlinux.org.uk
Cc:     lenb@kernel.org, robert.moore@intel.com, james.morse@arm.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com,
        scott@os.amperecomputing.com, darren@os.amperecomputing.com
Subject: [PATCH v5 RESEND 2/2] ACPI: AGDI: Add support for Arm Generic Diagnostic Dump and Reset device
Date:   Thu,  3 Mar 2022 21:22:41 -0800
Message-Id: <20220304052241.151946-3-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220304052241.151946-1-ilkka@os.amperecomputing.com>
References: <20220304052241.151946-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: CH2PR12CA0006.namprd12.prod.outlook.com
 (2603:10b6:610:57::16) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1411cbf3-20a6-4983-839b-08d9fd9f1657
X-MS-TrafficTypeDiagnostic: BL3PR01MB6898:EE_
X-Microsoft-Antispam-PRVS: <BL3PR01MB6898785B0B1C9C402AE4832D9D059@BL3PR01MB6898.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cdVSu1thxOOAdRgNd3IcrV34oFzUuZF4QEJc/SzpEGTHGoGxpEhGwQElJlt56B37sxbFdUDj7JXkUsgV2zbwtoYmkCphxQr1cQzTQBZoObAn31MQJJ3VgG0iLl0pnvxbwTvqDNws5Fgela6wELVErePoZiGkhp8RxtVrw7DKP5SL+4ujMjjUEI+kvZvJgqYZESSUrf+xMIsLW8PSZAOe1BZl1enLMbhIWNVo09KZiGIig8wR+g2BjO8ZM8Ov9ZcNqHjYwfedZmLI/bHPGiqnuIpDVYpWammM1FeX9ow0G49oSDjmcHcTfbHbeX1oddlq8i8jTw2+i7GpkWfaTT2IRrtXGQJMBLauxx1W4lwOn4cC80ni7IiKeKzVauULpguWblNzndtZFZ9Ws5G82zsiE/WtdQVv65xwR7fC5HMSUa/ss0qra1r9qWLbtQZWuOd/z9DoIXbC1uuCSBjDLKa222d9ZsWJ6Da7eTZvNWZQCkNd4VyFkLzyUDxpbIwrfHgTNhBYcw2Hy9tovWrASeWjnZaDH8bMK8+/HVp6OppCuwnyNBDxSnxQJW3YC9tGbMn5F8Z3/c2IwLHqGn9KwqLQuHlyTsl07r2C9CUSR4t1uq0PAx/iz9iq7EB6AsNYmgit88JwdEn2ZNf0N96Pf1mthRgPyAG41Ng67gJq+aNKRloorGsC6WpTnUp5NWQnBtW2dbAs/5Jdpa8t/DfttqsVUWu1rEzXuzStw5A4jXjPQhRKVGDhKGkK8251m9Hs3s4kkzXQ9ZNZMqEuK1vIptVFcr4monH2p/3J2xCKJY/lbaWqxes++cR6IEigf2IR/0RV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(316002)(966005)(6486002)(66476007)(66556008)(8676002)(4326008)(2906002)(26005)(1076003)(7416002)(86362001)(508600001)(6666004)(66946007)(107886003)(6512007)(52116002)(6506007)(38100700002)(38350700002)(2616005)(186003)(5660300002)(83380400001)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?13Gp9uWQZMnkiB5EzmfB3R7+mHwbzlAZx3iAAS0uBrOPWZTWyvkj7fHcsBWP?=
 =?us-ascii?Q?Wfei4kAd00QjW1TLYvE+DpnOhya3p2JLOW/2vAPsnaYDX//H1enE9ab0R8/2?=
 =?us-ascii?Q?u9kz97eajx5UgFB0xPfP/4MzNPqltUOlRCJycD+wWCTOvi4wN7tSNGtVB+AG?=
 =?us-ascii?Q?4Fb994qc0wqfxwwyjrX+LwarzQ7B5jcnavg7KCLL73alq9by8I9rSBsY3B+p?=
 =?us-ascii?Q?WSzhXLLRPtsnMKq2rsmN9sk7dRMqmUptK0LUuC/NmbIGaYCrD+GvIhwaKr7R?=
 =?us-ascii?Q?tQcq9y9RGwAsB3hChySDOUuoZrMOTQ6wbUb1VdoHeECgveqeJkq6tBaYMmmQ?=
 =?us-ascii?Q?judD7kObOgda9v6oitmhd359k8+uCd25QH5VwpDqxmri7hrgX2EDFxpeUtWa?=
 =?us-ascii?Q?mNm4ktQ7XaL/181avQFESE5gHxrXiFDnt5oYWAwMbPjqanKNfN0Dm2H+tknZ?=
 =?us-ascii?Q?VhJXQonHyjVrvUSpiTykSFA5Y74oPo9aelK8cXN2MxGyCixBuenTOU/aJAyE?=
 =?us-ascii?Q?Jr3Nh9D4OcklSDe0n5Nd77WZy8AlBVd5S+sQeWq2T4gajFamz7CXs7j6Oz6P?=
 =?us-ascii?Q?xZGVzCAVTJbYkSpcCWLieotnKAYos4AEjOdWze9iKhWmbCuJdGah1UHP9W7U?=
 =?us-ascii?Q?KpfSB3gl9aO+Iv8Yh03TcSYqmjQyqdYluI/G+Ph6JYmdTxSt4CaeOR7tKHt6?=
 =?us-ascii?Q?IDVoI5mm1Zj23fIk9p/2WuTU/EpXKyFc1QBrCczS5+GBCE2zpi4+jhGwzzgn?=
 =?us-ascii?Q?NpxuktwIiC11vsjIjsC7fOoToSytMSU7lv0QTEjRGWu5Xuy49CQRyCNKB9kl?=
 =?us-ascii?Q?nWKrL4NUKn/OJAcNUiBFfRKToNwS1kzG1KzTIWNjbUlpwnth/hjqHy+guhoJ?=
 =?us-ascii?Q?SRRgjT6ALLbK5RYhzlnSSchs5obUrEkF3PByK8632PnRmqKF/g+8xuD6H/61?=
 =?us-ascii?Q?OtDuvhUQsPex+yXhki1qUHPGGMid5ZIipFMXWglpLqBeOsH/DCVhNoUgm0eJ?=
 =?us-ascii?Q?4vmn253INXHRemhovUllGfO1MU8+GdplTAVL468y5GEUI2QAuOOZCCV+WdkO?=
 =?us-ascii?Q?s4ybNLVRw1iUa6lVhReNvDPmQvYha0J3BtyPR7yi9A9l3XanuYA7Lb3d7qth?=
 =?us-ascii?Q?UopOoyu2KJ0jj+ktzL+MqayM2z8hRKID9zmi1HPKKVP1Q5v0aujxO6uAsFWo?=
 =?us-ascii?Q?yciahMIlIO2VoDUAzAzCuV9Pcs98ZmWMQGV+u+JCLWtwQrZt9XMC3Jocs6F8?=
 =?us-ascii?Q?i6qgWIRosg+vfR04ok+xP53+oAGLZij3wrAKSlDNIMzKgybXfWsdzhHEAJ59?=
 =?us-ascii?Q?M6ODYzSwgieF3vtsKVZJ5EIWlSbvR84Nk+j+ZnjAMpQdX3LQ3Q8mnm/JdISd?=
 =?us-ascii?Q?gx1oRjoiIoCpzZApGmYNdkAGAqg6Kte8kc4AaVlVw2lvv1XcP1YcVV9/CPeE?=
 =?us-ascii?Q?KVz0/VajivsIS7ToKScPZrdXDMw6lS3SoZ1n7O2AJyxaSK6r/ZjSBPXhFONs?=
 =?us-ascii?Q?mrgZ0OqqJpejRPYdFjTLvo7xErOgRw04QmPHy/Bb+HegZ1glT4FYhcA3DD6A?=
 =?us-ascii?Q?LYDdGX0zbnsgF7vTq65Z5+afEaBSp1llLQ/M+68pcSJIHP8g7/oFKGcGIrCm?=
 =?us-ascii?Q?iA/8H61e0Qum2eoa50B/EliNs3l2MolAoycXB68h8KTuNbR+Tl2nHwNrGm4d?=
 =?us-ascii?Q?eXw1zDVZqv9kJsqJHSkXA592hD9LU4jUFIpjoS6BCRDx0STL25XLYl+SkK+8?=
 =?us-ascii?Q?AYHS/FM66Q=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1411cbf3-20a6-4983-839b-08d9fd9f1657
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 05:23:16.9378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQs4xIjGKeO4OFrF5fAGvN+nSrtiDFLZTY6raeI/utWB0OnlfPiQJIFRiesqj3ur3AHK6AaKtRGi9Z74nUcoI0aitmTaYzRzeDb/lGQ5wzGnW5oRLu8Cmh2o2a4hFNOn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB6898
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

