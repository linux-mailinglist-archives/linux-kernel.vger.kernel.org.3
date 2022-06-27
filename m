Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935BD55C39F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbiF0GlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 02:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbiF0Gkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 02:40:49 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087DA2DF3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 23:40:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ld/ZYRAqU8fdbCoS7KtUlRQlOaUMdV5UgR3Qa48bNu7WIrcbRkChLN/wdXxqsgKay9r0Onc+3YsOPCKowbimd/bsndzO3hoNfTabAX49G7QmlvOaElw2ttfIbntxWNBxNtBcmUcKhHVE5IYJqkGAhVbcRVOn/qdnk1RV6iXzbNGQb/ADEpdyniEtCb4UbB2PGHklZuhyJJTimQ+auXE+ivh2Znb5k4Z372Cncvy6GWy+gvKOQmV6+gGeL8ksV0gv+N8o6NdD0d7k3tHDmb11UT/yaAxkO6mopdlGdQe2APR9MWYqJ7DHtUCTRQA7Xn2l3Jf71cOypow6Vz2+bk5kNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=My4PDXFyhvV8Zr3jLBvUCYRZfzBEoyIy3y1DndatSfg=;
 b=Qxt182GBOTdTz58gix5N6UkEBooOO8dzgGKCGBfOcYy7JrEJEtz0Lg2G7F/qR27d6cOILGk7ZNq+QOs/HA5bd1k1ty6zf4p0doMG9BpLL5Ls2TkmFsO5tuCRd6UBp42TjbPUdNWdVd3dIftOE9bXKIpVG06TfE6WnWxcErr0ahH4fdik7kZpM/CGdC882tDF0U6ViaHGgCQzR4Sl/NxLd2miUZW/RMGh6EKNlc7KPFnOUEEov2b3ksDo/HN/mRbCqQfwcvUgr00o3D7Wx53Y9nDQA/s9ENNKWQaPnSdyflOrJRYFBGd6N2G58jEOPs3/Xxtjd5a0NuMP1WJXxOBsqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=monstr.eu smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=My4PDXFyhvV8Zr3jLBvUCYRZfzBEoyIy3y1DndatSfg=;
 b=GxCCGCNxFQ1Ken5anicdgbwdmNOjjeWeAvGgL1HVQhVfVYc0yEKnPnUzSfYeDiZJbytP200HFRYt+Uh87uIJ5BudP6GH6VhMgyRmIYQhqmt80fmV9Db2FS5nhI/P4BiV6vpDlfpN82KTE/xaug6of6wJo44/NMalIhNrlOVvfP0=
Received: from SN4PR0501CA0139.namprd05.prod.outlook.com
 (2603:10b6:803:2c::17) by DM5PR02MB2810.namprd02.prod.outlook.com
 (2603:10b6:3:10c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Mon, 27 Jun
 2022 06:40:45 +0000
Received: from SN1NAM02FT0035.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2c:cafe::7e) by SN4PR0501CA0139.outlook.office365.com
 (2603:10b6:803:2c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.6 via Frontend
 Transport; Mon, 27 Jun 2022 06:40:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0035.mail.protection.outlook.com (10.97.4.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Mon, 27 Jun 2022 06:40:44 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 26 Jun 2022 23:40:32 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 26 Jun 2022 23:40:32 -0700
Envelope-to: monstr@monstr.eu,
 arnd@arndb.de,
 shorne@gmail.com,
 ebiederm@xmission.com,
 appanad@amd.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 sam@ravnborg.org
Received: from [10.140.6.6] (port=50182 helo=xhdappanad40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1o5iQB-000Bsc-UW; Sun, 26 Jun 2022 23:40:32 -0700
From:   Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
To:     <monstr@monstr.eu>, <arnd@arndb.de>, <shorne@gmail.com>,
        <ebiederm@xmission.com>, <appanad@amd.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <sam@ravnborg.org>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [PATCH 1/3] microblaze: Add xmb_manager_register function
Date:   Mon, 27 Jun 2022 12:10:22 +0530
Message-ID: <20220627064024.771037-2-appana.durga.rao@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220627064024.771037-1-appana.durga.rao@xilinx.com>
References: <20220627064024.771037-1-appana.durga.rao@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aaa7e760-a696-4c86-6a43-08da5807f660
X-MS-TrafficTypeDiagnostic: DM5PR02MB2810:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NpRLXcTiUgQDt1fwVmFuW9kDcQFahoDdJIhC7WvcmzQLx90IMsronNi34KO2sQL/dAzbtzM0pc0SqObP0QKgBjPQlpjtQoMFVNnYKUQB8e9bbre6dUSYM2z+vWpkIjLoU3fz+/wG8feJVC5Q3kdcYRY0NWmgptcYzVWITF0GNDmLCBRcZve8UFXPdLccPEtS1WsNs+k2uHbyyMXeQZA3+ZbLwZPXaOBh99bdUd6Gb8JO1eQIXHyzD0+DpoDbYp6Kzj6fxnxYYNcSZaJXbWOT56S5nJmuxSszNJFKGeDF/1bIeKVaalR1tmSvM4Lpcj6gIGCu/TpoVjmRcRiQa78+niTfYO9Px36zPoNvL+5tN5rkhl1HpNpywCSI7w2fajUfZNN+01fmYVnB8SkBglalxRtiUlhSLJszdzs6/HqHU1iO/DMBdPd9L/+Hqe02E5ZIaJxc6tQiT5oTXqPI2uC4VA2FyMxpyzETHS4xxsW55Doi07+0RcppmeIo+5jb7JbvxAx6Sb74aXz5qpk9QBBJvsrkrw+RArucOvvXRZFPnHsjC1P2+Uj9sl77t9z/GyaqqWiRIXfUMJB4JMptANMP6jmM4I5DNmYUotU2JUhcqZgY5jpPSSZj5b2/eiTSR513X40J8wyjk0dcAn2VElFII5p6fmbR1fFuiLL9x1jD2AoRjBNvxHAabGgCKi1BATKOFtl5Xc/C5xNmcBnnH3zbjs1ih3Rb1WnQTrNKAZep4HyfWNjR9txayKcFYeGOtZ0oMQV+HPp2AOT+zpcgGN+6GSJjMRXOyo19SQiKu5q6L7HHTD0caQ9RBMK8e/DwHi7Lop//WSLrn60HhrJhNWwcgQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(396003)(39860400002)(346002)(40470700004)(36840700001)(46966006)(8936002)(7636003)(82310400005)(40480700001)(26005)(478600001)(82740400003)(5660300002)(9786002)(36756003)(186003)(356005)(6666004)(426003)(7696005)(336012)(103116003)(70206006)(70586007)(2616005)(41300700001)(107886003)(1076003)(83380400001)(47076005)(2906002)(110136005)(54906003)(316002)(4326008)(8676002)(40460700003)(36860700001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 06:40:44.7094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa7e760-a696-4c86-6a43-08da5807f660
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0035.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2810
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Triple Modular Redundancy (TMR) Microblaze solution provides soft error
injection, detection, correction and recovery for Microblaze cores in the
system. The Xilinx/AMD Triple Modular Redundancy (TMR) solution in Vivado
provides all the necessary building blocks to implement a redundant
triplicated MicroBlaze subsystem. This processing subsystem is
fault-tolerant and continues to operate nominally after encountering an
error. Together with the capability to detect and recover from errors,
the implementation ensures the reliability of the entire subsystem.

When the break vector gets asserted because of error injection,
the break signal must be blocked before exiting from the break handler,
This commit adds support for xmb_manager_register api which updates the
TMR manager address and control register and error count and reset callback
function arguments, which will be used by the break handler to block the
break and call the error count callback function and reset callback
function.

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
---
 arch/microblaze/Kconfig                       | 10 +++++
 .../include/asm/xilinx_mb_manager.h           | 21 +++++++++
 arch/microblaze/kernel/entry.S                | 44 +++++++++++++++++++
 3 files changed, 75 insertions(+)
 create mode 100644 arch/microblaze/include/asm/xilinx_mb_manager.h

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 8cf429ad1c84..7bcab7357f42 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -206,6 +206,16 @@ config TASK_SIZE
 	hex "Size of user task space" if TASK_SIZE_BOOL
 	default "0x80000000"
 
+config MB_MANAGER
+	bool "Support for Microblaze Manager"
+	depends on ADVANCED_OPTIONS
+	help
+	  This option enables API for configuring the MicroBlaze manager
+	  control register, which is consumed by the break handler to
+	  block the break.
+
+	  Say N here unless you know what you are doing.
+
 endmenu
 
 menu "Bus Options"
diff --git a/arch/microblaze/include/asm/xilinx_mb_manager.h b/arch/microblaze/include/asm/xilinx_mb_manager.h
new file mode 100644
index 000000000000..392c3aa278dc
--- /dev/null
+++ b/arch/microblaze/include/asm/xilinx_mb_manager.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 Xilinx, Inc.
+ */
+#ifndef _XILINX_MB_MANAGER_H
+#define _XILINX_MB_MANAGER_H
+
+#include <linux/of_address.h>
+
+/*
+ * When the break vector gets asserted because of error injection, the break
+ * signal must be blocked before exiting from the break handler, Below api
+ * updates the manager address and control register and error counter callback
+ * arguments, which will be used by the break handler to block the break and
+ * call the callback function.
+ */
+void xmb_manager_register(uintptr_t phys_baseaddr, u32 cr_val,
+			  void (*callback)(void *data),
+			  void *priv, void (*reset_callback)(void *data));
+
+#endif /* _XILINX_MB_MANAGER_H */
diff --git a/arch/microblaze/kernel/entry.S b/arch/microblaze/kernel/entry.S
index b179f8f6d287..b8e1dfe02d58 100644
--- a/arch/microblaze/kernel/entry.S
+++ b/arch/microblaze/kernel/entry.S
@@ -957,6 +957,50 @@ ENTRY(_switch_to)
 	rtsd	r15, 8
 	nop
 
+#ifdef CONFIG_MB_MANAGER
+.section .data
+.global xmb_manager_dev
+.global xmb_manager_baseaddr
+.global xmb_manager_crval
+.global xmb_manager_callback
+.global xmb_manager_reset_callback
+.align 4
+xmb_manager_dev:
+	.long 0
+xmb_manager_baseaddr:
+	.long 0
+xmb_manager_crval:
+	.long 0
+xmb_manager_callback:
+	.long 0
+xmb_manager_reset_callback:
+	.long 0
+
+/*
+ * When the break vector gets asserted because of error injection,
+ * the break signal must be blocked before exiting from the
+ * break handler, Below api updates the manager address and
+ * control register and error count callback arguments,
+ * which will be used by the break handler to block the
+ * break and call the callback function.
+ */
+.global xmb_manager_register
+.section .text
+.align 2
+.ent xmb_manager_register
+.type xmb_manager_register, @function
+xmb_manager_register:
+	swi	r5, r0, xmb_manager_baseaddr
+	swi	r6, r0, xmb_manager_crval
+	swi	r7, r0, xmb_manager_callback
+	swi	r8, r0, xmb_manager_dev
+	swi	r9, r0, xmb_manager_reset_callback
+
+	rtsd	r15, 8;
+	nop;
+.end xmb_manager_register
+#endif
+
 ENTRY(_reset)
 	VM_OFF
 	brai	0; /* Jump to reset vector */
-- 
2.25.1

