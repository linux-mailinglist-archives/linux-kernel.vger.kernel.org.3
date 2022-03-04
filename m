Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E2A4CCD63
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238223AbiCDFlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238216AbiCDFl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:41:27 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2130.outbound.protection.outlook.com [40.107.237.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4058A158DAF;
        Thu,  3 Mar 2022 21:40:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3tMzAj8qGlsa5H1PEdOvFv0yrZyw4sSrrTfOBhjXjdOzFrXxb+c9RRdPvG4+LFPnqoYi58JA/PYjAJP+ltjw+j7A4AYthraMHfLR/dDLHWP7V+98FozsD7qSqflTyuSAFdvFoPXHtlT+NeZH9B95a30v0zKzgjotjyqEqnGol9h7WMuOrnHewBDPZHtJtR7BHH1pUgm9iiGOwSJJvNxlQdIJspmTiRkfTDeMZFdd2V52syM6WY/yPtBsXVMLfKXl9t+Gf2cM4f8YJmZ5AR1E29EiS2EZ6Yrs8WTfo9g2CFRLfPcoOg2dYOnkQVQQg7w3mKUnKKcaLh8jm/KHv+Hxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mfWXihvszlFOIpsJH3Q772oo+mschXSOeDO1eSG5H4=;
 b=RbyYBbPow87TOqd4bTckMbPZb/VnTWKEkd+Yq83r01dKe6KdfIelGeJix4FKUtiOZqTli7R8RRNB3yQ9jnFB/+nVFE7AT7YSvXn1u7x/JBO9JWK3LcO5FWF8u1wluWOdWXVtxOwbmff0a4HwJExE+bEa+6ydlbtN8CoUOEUDry3YA9gZhjAy3tF3ooG20rbpmx59wcGMDkpE8lNbBHlnrtOEnollM6mDGcq/Y7kz/pNLlXdfbd7vFbcNKl8DgvlFwg3Hek65Y6+QW35BdkXlySrNPkL7x0c3hZYMrc1dgs+HMauRFo7YMj7nIZv5V9Pxmc3veoyYJ0FP1MsRj2vY/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mfWXihvszlFOIpsJH3Q772oo+mschXSOeDO1eSG5H4=;
 b=jNYUithR13phh8v6VWhgVVWw78rD28VxKQyFiyJ48GDAZdUT/dJ7FiwVpaz93kiryUHnABuvlaJj6vVdVPrtm4p5mIxlRvIGbY9NCprV4m/kybWgoDgGJeV7F1j8JpTEf6Md7OGSzKE8XvEX4TefvX8bgW+Prezl73JsDIj+dN4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 CY4PR0101MB3174.prod.exchangelabs.com (2603:10b6:910:41::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.13; Fri, 4 Mar 2022 05:40:36 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::181b:1522:26bc:c243]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::181b:1522:26bc:c243%4]) with mapi id 15.20.5017.026; Fri, 4 Mar 2022
 05:40:36 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rafael@kernel.org, linux@armlinux.org.uk
Cc:     lenb@kernel.org, robert.moore@intel.com, james.morse@arm.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com,
        scott@os.amperecomputing.com, darren@os.amperecomputing.com
Subject: [PATCH v5 RESEND 2/2] ACPI: AGDI: Add support for Arm Generic Diagnostic Dump and Reset device
Date:   Thu,  3 Mar 2022 21:40:03 -0800
Message-Id: <20220304054003.152319-3-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220304054003.152319-1-ilkka@os.amperecomputing.com>
References: <20220304054003.152319-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: CH0P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::30) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dad92764-b511-4898-2d34-08d9fda1820b
X-MS-TrafficTypeDiagnostic: CY4PR0101MB3174:EE_
X-Microsoft-Antispam-PRVS: <CY4PR0101MB31749B1B522ACE59F5C677199D059@CY4PR0101MB3174.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zysyLTDceoUpC61A9AGcFcYNLJr7FKq0n6x7UvzPAFBqSbvDOGX3+46ktGHMxPBah6w1bxKEoSJPEgSobwjugEVmY1O5FeYwVzuyLfM6pmvrXXTC5xlrxxrKx/dhSccm7qMumlmBmcNnzTC8Nd5aGFmWUCDGdaB9jm/Gjx5jDESifpoCKeR7AS/z3NMhIm/5uqnzDnqntvyw3KYv6WcBwxJNhTT2aJvrtv0pJTMxjapl2Iad7Ha9KHjjhH1Rl2B6NLXtb80ldm5mHzcp+WYlPUHKYsTOKEP90AGR3vM5a3JXkoGb7BpbXms4wzKjxR51W6EGGbG5gUdEd8YuDUBHPwUddHvjU35ZyApBlBt8cDDVUCw3H7TmpfAyYMP7ybnY7sgl9tRdj/1tc4PNU06xyDHH/FP42kxGc1y4WOfQtrBK0mXGtxEWXXRBzkNaRquSjTKR0sJbSDJhJqNzr9ROjpqLmcdJKGpVTRGLRtm5Jq2tEUNaqfyock5AlPlR4XxouOkP2P27Fo1ElAjpwywucZM7fVJDIeOuY1FIdXAtQH+IUeeJN5etRA1CzyjqpOoYRIHgH/+73yYO737vAVYEsjMR91T0VzgIPyDZne08wpOi8Q7RJ0I+grIa4WN5MLhA5GDOCdONu4bpUSo1TE4EAoODqj0EYhzqcOs/ipdQ+Urjk7x73BAsNIapuaU1Eob0maGWe1LjMrRj1GfdceDxnA9zh2o79wGYCv5zXZfpy7uam+1DqMW9kcfDcwiez7LG4H5P85lDzLqu7oqwTT2lZ5Q3GnghXhwqV7Z1kuLS1aaNLGjef2oDG9TOSvv02GMp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(107886003)(186003)(6512007)(508600001)(1076003)(83380400001)(6666004)(966005)(4326008)(2906002)(8676002)(38350700002)(38100700002)(5660300002)(7416002)(6486002)(316002)(8936002)(52116002)(66946007)(66556008)(66476007)(2616005)(6506007)(86362001)(26005)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YdPHF4y/gbufosYKNkCNRrWsdOplNfHT9dhdRRPZuFxa5fUe3iNxlYZ9dK0z?=
 =?us-ascii?Q?2CmesMKSaf6hOLFnY/AeUeFu9rmGqzXNtjymnHYc9UVEqJ97iFvBoTNWy2XT?=
 =?us-ascii?Q?eockfeHfB2SClZi+AptNXvD+KkHt8SECBhyUz1By+37YIEXlDE+Vv1ZhBFlx?=
 =?us-ascii?Q?3TBKju8YJT2Ywc22wPUTuuH9uLCASDQKLdN1v5fOAY3WjOutAdi1KwZQC1Pt?=
 =?us-ascii?Q?R3rVymMXvwYgj/ibfZgxkip7jGOBlo+lWQ69/r2UECiMgITk/SsB2n/Un8uY?=
 =?us-ascii?Q?/pFuVsxpaXuFhOYzkCWRtEfJNopDtRnXT203XZDb+nR/C46EztWyic7hrEa9?=
 =?us-ascii?Q?jbt6fQjzMD6VAWOeLRQC35olbNGI4wjBP4P/B6///jhHqTj7Lix9+WuNtky/?=
 =?us-ascii?Q?GsBDaI7L/EtXMbE1yIwSE0/uWc8bwALqF/1GRWkqA8BBDd6tnlBHZQzzVlc6?=
 =?us-ascii?Q?u90L5Ln48lPnEkOwQALZuenhAtLpI2kOETBhOYGTiOjyqlnU4fyoL43h9eNV?=
 =?us-ascii?Q?/JbSGRaMHOlLqDG4aUIJ97w4YOk/quVIrjv80astUBdmuC2uyXmtv9E+6hUS?=
 =?us-ascii?Q?nQESLKJ0Up3GKFfbZMkdfRSvwZZOkxZKmiaJJe1QrCNZzf8I67LpJ3TgYi28?=
 =?us-ascii?Q?sTSmWBPbcHQjmRjJHGxAvbwsuLSpRUR5FezvScvD8/ZMynFI1+KBSK2lNNNp?=
 =?us-ascii?Q?se9kEpzdHHev7L15q7XXZ19BpZt3BofMnpjyUV9R3e3cbY9Fx5OMaBesbIAz?=
 =?us-ascii?Q?w0Rk/ORQsqeioWNg96h6Cqz2OVthO88tMzaku8lfj4zMMmQV9C8HEn8rk92N?=
 =?us-ascii?Q?VGYi5EAojXtsSPDH+n71jkBrX6h6BI3hq8dEtci2haOU8O62+/4RTU/AcvPN?=
 =?us-ascii?Q?aGUeVWz4A41na2cfjsJFMpY0Z8IgtlMJFzOjDbKLjZxH71rqc8CRmuHHphU7?=
 =?us-ascii?Q?UQ2zjwhnsNDd9bdUIqMxBal0sK4u9T+mVl1FsyMycoHqD2oA768hzp/hjLWg?=
 =?us-ascii?Q?PSf7Htv4lAaA0JIbBOLVczNPznfMYqiyQTXGcW+NR3aYJZhnDIVAVt3fs+JP?=
 =?us-ascii?Q?3D41cWQXcswpLF6VrE3wk/cYgRqcrdvDtjrBpQOlL0x3AS2IQdDtiXysmjz9?=
 =?us-ascii?Q?LzbKT95IkpZufQsLB9oQ15h1VJTr1ryaIcyi/73UK6bU/XoMVdb0+R3BfEyh?=
 =?us-ascii?Q?g1GPSYmtCagCdtuIxR2ifMT63eJHMat3iRqdSkhK3CkEMCrDnd20BDo4YF4d?=
 =?us-ascii?Q?VadUJaF57O8ot4vEaqtKje00OtYmMxMSeBdjJ8sOlk4qcZ0RJnfUHEs/JtuP?=
 =?us-ascii?Q?o2rZjDUJLvV/zOMRrWK9N8ytm0gcdARYirwTJJyngPy8NHXBO+e2BycIX847?=
 =?us-ascii?Q?IEYxQqByyQs0zrS1RCEs/WqQHH47k/S45zSZogEhhPeZ/VSAKXzb2LmcrMWV?=
 =?us-ascii?Q?7tXfGIC9R3SvOQCfd4p0IDyiFV8eKfJZvMBI93Wx3ORjO5MORqgLScwfSTUL?=
 =?us-ascii?Q?pK3NXn6iXcsvwoduY3d0fgAo0Z+J9HMdLkgB2GpNhL1AERthbIY8kkbhtp0O?=
 =?us-ascii?Q?YTpxw3GgakTk7z8t1seKCOZcwT6xaU++rvzGLLJkUmj2rq6r2wUe0NjB1YBM?=
 =?us-ascii?Q?PXchqvsUXYCyfW0oWSJURp3X3HvWw/Spf/TxAxqSwCQi/e20vJT5yb7tvFl0?=
 =?us-ascii?Q?b2bgSir3JTasybmd+/PdKgS6WklJhJNWJvB1T1pKBF+cdsI3p59XHVtdv94M?=
 =?us-ascii?Q?/WOfv9i+4A=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad92764-b511-4898-2d34-08d9fda1820b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 05:40:36.5624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zqe+eTYUzBBRttkTZRXizpEyexz4puK50tyntDWuoz4yiPRST1s59bfve0uO6C7VSyAYTQlPA4zOljVt0sddLV08mElxf1huRWL3BZA7KY8OrZhZyRDTjcMBfe9urbOi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0101MB3174
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

