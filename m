Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87CB1467024
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 03:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378151AbhLCCr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 21:47:26 -0500
Received: from mail-bn8nam11on2091.outbound.protection.outlook.com ([40.107.236.91]:13280
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238206AbhLCCrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 21:47:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKdWVRw5lGmTocVlj5MrpHeDjn8LVtSjgPlekV0Ca+Rr0wS91YFDm1fpLXjb+YYMSs2M2AWyi56Aov5WtTScn2y9zymL6SPq6yOYmDcCKIacFYrPEadmRP9+7UqosZIa8IIjiEwQ7+milOn2qFH5/KHPymu5oEB/n4bF4GsPobGB/2P+vDhgV843PvSiUV8miT8fsvGCTt8w5hfXoa5rejqk/VUP0bKk84erDaOZgd8lxvL6YBzCe03FnxKZ4uMRBnvOfiKmAjBmogxYs4hUCaRM8xt7qQbE8A6QWqyM00WOAT3knLfMnDyOK45B8xM/a7hcipkbjMcuOp+lJyeo7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcs+w7TDYoeziTSR9MVk297dLxHWSNCreHdbz/t3U5U=;
 b=krIdHYjj8hnayDqcosGkTk/oCeTVZemScOWLoxrFoYMGf4XkRVGVVK4zE/I8m6UqJr3N1H7Zw7nCgGO7lljxFWz+Q/li1IT+/6LM4rP4/2kYpeI13Bd+OPJ2WmY5mkw1/l8uoryyUgDG2WmKBcDkxqakKFOqmZsRs1LBbkkvtb1B924iFRLLLUtumvBNpuuJtsCmhayo0bR3zhCIayxkddW11yP9xnw1jIsBMYFGsqKe0BZKs1sNGYQs89HAQXlmvotk7cAB20K6Zc4oydm+BZpJC6ZfDi941sVGCDKyjdEq/s0t35ozC7eFngSEPneyR+IMJzmDb8eesP+bcPTFdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcs+w7TDYoeziTSR9MVk297dLxHWSNCreHdbz/t3U5U=;
 b=rxQVtmpT6N46fJ1aHYo/XzPKJp2UVMiHRxuD12x01ioHi2RBRZIbEOivrUQ9KIAkXaZiMLGqVIGmFUxf09sLMcHr2D8NFwf5UFlsF1GX9QN1aUA4fgIZkOFeS0ODNtnbQBKot0e0hur8cfQeCigYT7+0hv8IQ77zaw/p7U/TteI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 DM5PR01MB2412.prod.exchangelabs.com (2603:10b6:3:3e::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.14; Fri, 3 Dec 2021 02:43:57 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::d93b:cd3c:bb56:33a2]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::d93b:cd3c:bb56:33a2%5]) with mapi id 15.20.4734.028; Fri, 3 Dec 2021
 02:43:57 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com
Cc:     rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devel@acpica.org,
        patches@amperecomputing.com, scott@os.amperecomputing.com,
        darren@os.amperecomputing.com
Subject: [PATCH 1/2] ACPI: AGDI: Add AGDI tables to drivers/acpi
Date:   Thu,  2 Dec 2021 18:43:10 -0800
Message-Id: <20211203024311.49865-2-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211203024311.49865-1-ilkka@os.amperecomputing.com>
References: <20211203024311.49865-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0312.namprd03.prod.outlook.com
 (2603:10b6:610:118::21) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
Received: from eng01sys-r111.scc-lab.amperecomputing.com (4.28.12.214) by CH0PR03CA0312.namprd03.prod.outlook.com (2603:10b6:610:118::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Fri, 3 Dec 2021 02:43:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48d72491-38f5-454e-6764-08d9b606c0d3
X-MS-TrafficTypeDiagnostic: DM5PR01MB2412:
X-Microsoft-Antispam-PRVS: <DM5PR01MB2412628539FD7379654170489D6A9@DM5PR01MB2412.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ovZRAn76kMYIBPWWmnlXroIVBdCXt6A61ffF1cJVAOCDcVZ+J+TRHpvlFO4OjHU3L/Wda9BUqbiRp0VW06HPM1p3AvfweyH+yBg25HfzFMrtN0sEgfcop7Uo9ZtGut7oYDbzzR55U5FxJJFSOxQUZoUFpFYxzbPDH4Xjv0Oe5KGasuSygd1jkODO2O1Nq90vVAGXVtzg0zrl7fz0PzpN2mMZk6Tr4c6l34p+yMxit7UHJtBUhEDv8uGdHPnhnvQQi4hQMVy4TiMUODqCQTkkIe2YexQpBKEcQu+jomo3JXlA+YYOtRgU1ntx9gvhrSUVKtxzAu+Q5QN0TDONKnKGhnHk05u+F0lq6rlMIL7JP0A7qEBD+2H0zNLEp4785wdx50qsmdr8eDT0W7TGrfYSI5SG9sahPeiGVPZSzOm8jCXGFMsvmzLbFxs4a2fstM/OR4Jo+sKMql4zZBDdJQcM+14DgG1ThKNpcwhmtuva1pLv4MhEkTGgDcB6g0BBZuWm0TxqP4KpLIgRLLLjzuiLoUfGZT7XpbXSrFqMF6SMI8WSbBgSeaAAa639GXnGDRT8B3z5qKqeYxn2aj3ghAkTr9Z5TLnZsflzyPK4ypeNH/CtwM6gOzRFQUuQwu9mH6gAc1b856sqiYiXy52DeM14+Ln7YfaF5l6Q9Dl1SOyBql6BneHr/JduapmAVdT2cY23v4fHUB0ui1o9CUKqQLI3VCL5wxhcVqV1ucLLzDolDdi3dUPaznDiXPIVMFCj6fEIHwF3RTmbiOJVadY7+dw55EtV9OcpprJxRQ9CfgfBSrA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(2616005)(966005)(6506007)(6666004)(66476007)(66946007)(6486002)(7416002)(1076003)(956004)(2906002)(8936002)(5660300002)(508600001)(26005)(66556008)(86362001)(4326008)(52116002)(186003)(38100700002)(6512007)(316002)(83380400001)(38350700002)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xXQPcu6diJaQQaWjGs060mIdaW0wWTieS2Gj0pxTKH4e+VZVQjsJgYN/2Iil?=
 =?us-ascii?Q?HHp49IWayusNp2aHpRm/fyt8cpbYFTY7vQ3Q1iunwKbE5rGb7k/4/myrwFAN?=
 =?us-ascii?Q?z2nq1mi7BKFpmSHB6ox3+prLtXCoCf9KsTLqXWuVzLnuT/AyXMfhk+wZLLmW?=
 =?us-ascii?Q?5uYqT4YeEp4RPLCSXACGZKPS4JSbX9V2ceCi+1gvOPwyCPpFJZeU45ELBgDQ?=
 =?us-ascii?Q?GGiq+LTBkuFsOoahS9diPXWRvonfl5PgCaLMzYoOgULiOiNDNTWC8huco8Ku?=
 =?us-ascii?Q?CIjBbtexvzfry1MfzjUW7QNO7SePkOqcoJra9RlQLNDUBozi87vbJwOUzFR2?=
 =?us-ascii?Q?bsHEFpNK+64upV++xVzs9RvufS+ZVCltvxPXgk0bzK9Do/u/GTv13Qg5Ha89?=
 =?us-ascii?Q?4V+jsuw6NYGVLhqWcNHQa3TrwKlSXZHqwIzMVckIxixtax+Zv2Q+s8oUBVtZ?=
 =?us-ascii?Q?P7ZHKIVYC8FLrlnozMS4ARgIZZ1ecwgpKLmZpcRmqvN5p8DBJlSGNl1biojl?=
 =?us-ascii?Q?TCgyoRyoi+vPmosJEHvs1T4nwO2GLtZYCk9qj9CLQoDfmU9oT9X/meYITQg8?=
 =?us-ascii?Q?TCi/xeJlnZ+ApnQKGOw2B9HYNHuYqVF+qK//d5EMJpPHZPvx2aLkvRECE0jx?=
 =?us-ascii?Q?RAgesPmwC2AGQsaidP2GueAt1ga/ckN+62ivJO0dsHMeSoyhPPH9y5COGsRc?=
 =?us-ascii?Q?jhlF5ZBYVVcaI2jjzMllBqxQ3T0DHMMvo/0ZzOhuk1TliNhJFd/UwsKZHrLx?=
 =?us-ascii?Q?K4ZAC16w9fRW5+gKi1Pn7z5U4lK24DQL/dgaOFNjP1CsxQlT9Myj+SzNO7z9?=
 =?us-ascii?Q?od21sMRNAMNmCFX6ALisl0fYytQ3VDUQ90WZnkzXkosduWtWWppg5ekvis6o?=
 =?us-ascii?Q?QxZDkkDo/mSCG+T1fP6EwUR8mDRv7fk4rK4JCYSHm/e06YI1Er7F54wp+oWw?=
 =?us-ascii?Q?VK8Cmuggxov83DYoq/DdkBfkjUwLNdVvLbz1zuNXf/zED6XlF3a8+JO9FZTA?=
 =?us-ascii?Q?cywARyscCVHdrSvw+BUIAkKaeFteiO/K85eGBkLo3crP+KQWOyTYvQJNoec0?=
 =?us-ascii?Q?pf12k/IW17KGNIooYFUkHPrADe0HjdPwwAdQTRfZzEr4FK5fbnd03wptrLi4?=
 =?us-ascii?Q?kdMVBUxgRvl39jPCkQWzO546QIMBIOt6fJaeo10UQ5NqOQjGFxR/OW+b5WUg?=
 =?us-ascii?Q?c8vgLFEECJjDOCzO73HIqmZq0x3l6+gBPUfkrNPvbE+KcDhHDIzdHShvYvhz?=
 =?us-ascii?Q?Rvmx6J5194ped+XKIJBg+PavsnxYlN+l8Tin4o0uV+XfXTNMTLn1O7vjpxvy?=
 =?us-ascii?Q?jIYUREA+ARxRwwh/RJT/0Ye+NzpfWIql1akxMpwhxg8KoBNJCGo0ECvvMTUP?=
 =?us-ascii?Q?06l46PZY3wZ18XJ5rkD2pSZLsM2uLKPuG3pgPr0rVRuoH2HZeBa+KUThg48K?=
 =?us-ascii?Q?3c7gHynMrtuZBCJRg0OXs4AfDv8HI7NbcGmMHkByWrty+ymVIl0nweMrrCDU?=
 =?us-ascii?Q?cD8j+5IGa6J9PKRPzclTIcyBirX2SiPt3wu+tHT8yLPis46O+MFUIXEFSTAQ?=
 =?us-ascii?Q?MRpeNW97VIyP79kPeu2KK7bfCXQfUEFPXwMiVJfvV1gNawFe0Ye150bOHokJ?=
 =?us-ascii?Q?PPqVw4Th5JcYFc3CMhVIgzgS3dNQ+/L17HBvDqpuAyGv/+63ZopbeeBdyOdD?=
 =?us-ascii?Q?nQLmJSIQedAe8d7Q9jvByUFxGUCOphibj6EVie2PwWw3CVs1b5sjg69z6H/v?=
 =?us-ascii?Q?5RPSVukNvg=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d72491-38f5-454e-6764-08d9b606c0d3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 02:43:57.4073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRDBxT496zORh6n3GEHTSyr3LkQzucRT8of+4O2BjHgaDPaFullkW3jX27BnGTWSggm2awradqtbaObI55zETzB3G1chqgLi3UdSYXa7ixJKRUqxzvbpHFqF499VSWYP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR01MB2412
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI for Arm Components 1.1 Platform Design Document v1.1 [0] specifices
Arm Generic Diagnostic Device Interface (AGDI). It allows an admin to
issue diagnostic dump and reset via an SDEI event or an interrupt. This
patch adds support to ACPI/AGDI tables.

[0] https://developer.arm.com/documentation/den0093/latest/

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 drivers/acpi/tables.c |  2 +-
 include/acpi/actbl2.h | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 71419eb16e09..5e3169bcb9fb 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -500,7 +500,7 @@ static const char table_sigs[][ACPI_NAMESEG_SIZE] __initconst = {
 	ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
 	ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
 	ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
-	ACPI_SIG_NHLT };
+	ACPI_SIG_NHLT, ACPI_SIG_AGDI };
 
 #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
 
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 71ca090fd61b..66ca85b9f5fe 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -24,6 +24,7 @@
  * file. Useful because they make it more difficult to inadvertently type in
  * the wrong signature.
  */
+#define ACPI_SIG_AGDI           "AGDI"	/* ARM Generic Diagnostic Dump and Reset Device Interface */
 #define ACPI_SIG_BDAT           "BDAT"	/* BIOS Data ACPI Table */
 #define ACPI_SIG_IORT           "IORT"	/* IO Remapping Table */
 #define ACPI_SIG_IVRS           "IVRS"	/* I/O Virtualization Reporting Structure */
@@ -237,6 +238,25 @@ typedef struct acpi_aest_node_interrupt {
 #define ACPI_AEST_NODE_ERROR_RECOVERY       1
 #define ACPI_AEST_XRUPT_RESERVED            2	/* 2 and above are reserved */
 
+/*******************************************************************************
+ * AGDI - Generic Diagnostic Dump and Reset Device Interface
+ *
+ * Document number: ARM DEN0093
+ *
+ *******************************************************************************/
+
+struct acpi_table_agdi {
+	struct acpi_table_header header;
+	u8 flags;
+	u8 reserved[3];
+	u32 sdei_event;
+	u32 gsiv;
+};
+
+/* Masks for Flags field above for AGDI table */
+
+#define ACPI_AGDI_SIGNALING_MODE (1)
+
 /*******************************************************************************
  *
  * BDAT - BIOS Data ACPI Table
-- 
2.17.1

