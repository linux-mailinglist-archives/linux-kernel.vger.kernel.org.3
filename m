Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9035855C8C2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbiF0Gkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 02:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbiF0Gkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 02:40:42 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2078.outbound.protection.outlook.com [40.107.96.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958CF2DC4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 23:40:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2g2l0NrqRI8AO2WR5atOlhdDH4jWPxpj6df/VuaOtTjKvFhHKQk40xsD0Xaq+m698dM5DMMaR6MLl8oMyory0HoBz7n/5eR+OZSJyeypGSBJT2Yvq5YYxnOUcCxiz0eUFAqqxN1sCYiTlYm2KyHZnHbJS1RDT5TEfpfvEhKKoAi4XOnhofOZIS1F7Ht5JkD39VdDv6Zk27dWpQXaz7KXJrd2YNgiqS5hUo9QXMyb8XHd1O4FfyM2rR7YFT3VyA69J2ROqWzDzeg9GJDrUmA/41DVlSGNHGwjnwt7MS8Y3eyOj/+N6KKzywc32B+edfkSn48oBtrxNr26I3MvhDMdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9638R0Y1i+laSeovK1OLHStCmgsdfhzQ6IPSStNgP0Y=;
 b=FcafXbyAU1hFqgoXD5Ik1QkVi4lLoqDL1nK2ooRTVRMAtdz9Mvmv1AiZ+KhAdGbhkgHg/86HffrhKBjxNIT0xEgnoDzqZq3K608a7RHiH9zVomV2zrzKPFFXgnNpBiPrd7Dw9SNHoYKFPmsnrC0eCmVnMpiONnuFyrQuEUMjHWJVgfj6Sux95nyfuFwSiketZyvaEsUwc2gNapjmfa3IVg8apEoet7Lms/0Ah485RtGnOSfAcyo4q0IpB8FYbB4F2Pf0WFqf6vcmzCrK7OmF/FFicG5wuCywSNKMkHd4PzAZtVqv+QmKOPMv7J3lzliaHQ4ogVr0ohbrZkZHUj1JJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=monstr.eu smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9638R0Y1i+laSeovK1OLHStCmgsdfhzQ6IPSStNgP0Y=;
 b=rByWQjbYwkZhK3OIIKTeo6o6JhU0rdlkx2D7jxqjOUYbVqYvtNPMgtNuRnnJKBnW7jRwGb3oUkhAsb92YUbIeJXFiDNjo/fzd05BFa4KdM0EINF1UpC40RLIF4nHBAnqOM03fuP/B2cfaQGIHimkUtAOVAgSMPS171DDh6KwNvE=
Received: from BN6PR13CA0031.namprd13.prod.outlook.com (2603:10b6:404:13e::17)
 by CY4PR0201MB3555.namprd02.prod.outlook.com (2603:10b6:910:93::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Mon, 27 Jun
 2022 06:40:39 +0000
Received: from BN1NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::f3) by BN6PR13CA0031.outlook.office365.com
 (2603:10b6:404:13e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.12 via Frontend
 Transport; Mon, 27 Jun 2022 06:40:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT032.mail.protection.outlook.com (10.13.3.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Mon, 27 Jun 2022 06:40:38 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 26 Jun 2022 23:40:38 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 26 Jun 2022 23:40:38 -0700
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
        id 1o5iQH-000Bsc-HP; Sun, 26 Jun 2022 23:40:37 -0700
From:   Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
To:     <monstr@monstr.eu>, <arnd@arndb.de>, <shorne@gmail.com>,
        <ebiederm@xmission.com>, <appanad@amd.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <sam@ravnborg.org>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [PATCH 3/3] microblaze: Add support for error injection
Date:   Mon, 27 Jun 2022 12:10:24 +0530
Message-ID: <20220627064024.771037-4-appana.durga.rao@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220627064024.771037-1-appana.durga.rao@xilinx.com>
References: <20220627064024.771037-1-appana.durga.rao@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3126f465-75c5-48b3-84d0-08da5807f2e4
X-MS-TrafficTypeDiagnostic: CY4PR0201MB3555:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ke7rUaLnYnR+lEi7wvE89GjnpxBP+w3CDkAdU59aJZsmCYHBsVTlMRwFCGqrPVmu/sJvNpnllEV3bEJwuYlDuCHJ1e1tzGXjljEQfYQXKeHRYUm4EiGS3ddDW3XbsTWUL7Vd7SOVsGs6r55P29stdVLsRJAyEMn+XOT5lXQWKH/V2e4+OX9mcuh+/pSh7udA6yG+myBW+zi2KcTT6cQkYk3xuZlBaKbaMuJ+rZqqHpF9TSHgd4zsVKqRHvHedFUZ32064b5lKNcdOq7l0Aaa7qnKenxA+xB4MsSbcECteCUn/o7KvU+RH9uVKm+YHnZRqvkZaD70/v7QO0a6g398Ha2P1jYX9+r5zfj2oFKeBTq/whfdPNIN5yI+hXkOhdx82qk4Z6V1cSIqcl2dujC13sd89ZUBkvKcWqW0yKwxhZSyke1VvFxnaJLJxpIotBzLxckY7al0owShn/z7LM6VMjS3o8rSinurFbMNAD9aPOF+N0N9ERajXi350JB6UoTw2MNsWIvoizcYz3tMuK6M+c19ya/NE3ULxzfCGNuhHR9jkgqM6PzNhgNp9I26UwduiQu/shiKSpYq/HsboQXb5tvApmZl6GJ4OupK3MGgYaJA1q/TcJRW6438bXd21TfnE/QEw7BG+/o/ESuualbVUPyqrjjPawQAZsWu+J0bWRYvMYhhHeJcxw/LM9SmMEce+enbJSRtLXbJdzYWEwjDYewWaXgPPa7sLSs1lgr76LYGsOiRYteYHxp9jX9ikddNpD0lZc31Z/HivOz6JZXHN9hnImKFCVO4NvRVh5o/1reYCBpW1slgIB3KotQ2QQ6bmSRjfjKhkg+8bqQNhYYxA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(39860400002)(136003)(36840700001)(46966006)(40470700004)(1076003)(478600001)(107886003)(40480700001)(110136005)(26005)(54906003)(316002)(186003)(82310400005)(336012)(426003)(47076005)(36756003)(2616005)(40460700003)(7636003)(83380400001)(356005)(5660300002)(8936002)(41300700001)(7696005)(6666004)(103116003)(36860700001)(8676002)(70206006)(70586007)(4326008)(2906002)(9786002)(82740400003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 06:40:38.8018
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3126f465-75c5-48b3-84d0-08da5807f2e4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT032.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3555
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To inject the error using the tmr inject IP reset vectors need to be placed
in lmb(bram) due to the limitation in HW when this code runs out of DDR.
Below code adds the error inject code to the .init.ivt section to copy
it in machine_early_init to lmb/Bram location. C_BASE_VECTORS which allow
moving reset vectors out of 0 location is not currently supported by
Microblaze architecture, that's why all the time reset vectors with
injection code is all the time copied to address 0.

As of now getting this functionality working CPU switches to real mode
and simply jumps to bram, which causes triggering of fault which continues
to call_xmb_manager_break break handler which will at the end calls the
error count callback function and performs recovery.

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
---
 .../include/asm/xilinx_mb_manager.h           |  8 +++
 arch/microblaze/kernel/entry.S                | 52 +++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/arch/microblaze/include/asm/xilinx_mb_manager.h b/arch/microblaze/include/asm/xilinx_mb_manager.h
index 392c3aa278dc..7b6995722b0c 100644
--- a/arch/microblaze/include/asm/xilinx_mb_manager.h
+++ b/arch/microblaze/include/asm/xilinx_mb_manager.h
@@ -5,6 +5,8 @@
 #ifndef _XILINX_MB_MANAGER_H
 #define _XILINX_MB_MANAGER_H
 
+# ifndef __ASSEMBLY__
+
 #include <linux/of_address.h>
 
 /*
@@ -17,5 +19,11 @@
 void xmb_manager_register(uintptr_t phys_baseaddr, u32 cr_val,
 			  void (*callback)(void *data),
 			  void *priv, void (*reset_callback)(void *data));
+asmlinkage void xmb_inject_err(void);
+
+# endif /* __ASSEMBLY__ */
+
+/* Error injection offset */
+#define XMB_INJECT_ERR_OFFSET	0x200
 
 #endif /* _XILINX_MB_MANAGER_H */
diff --git a/arch/microblaze/kernel/entry.S b/arch/microblaze/kernel/entry.S
index df367bf94b26..2bb2fea70b3e 100644
--- a/arch/microblaze/kernel/entry.S
+++ b/arch/microblaze/kernel/entry.S
@@ -27,6 +27,7 @@
 
 #include <asm/page.h>
 #include <asm/unistd.h>
+#include <asm/xilinx_mb_manager.h>
 
 #include <linux/errno.h>
 #include <asm/signal.h>
@@ -1151,6 +1152,41 @@ ENTRY(_switch_to)
 	nop
 
 #ifdef CONFIG_MB_MANAGER
+.global xmb_inject_err
+.section .text
+.align 2
+.ent xmb_inject_err
+.type xmb_inject_err, @function
+xmb_inject_err:
+	addik	r1, r1, -PT_SIZE
+	SAVE_REGS
+
+	/* Switch to real mode */
+	VM_OFF;
+	set_bip;
+	mbar	1
+	mbar	2
+	bralid	r15, XMB_INJECT_ERR_OFFSET
+	nop;
+
+	/* enable virtual mode */
+	set_vms;
+	/* barrier for instructions and data accesses */
+	mbar	1
+	mbar	2
+	/*
+	 * Enable Interrupts, Virtual Protected Mode, equalize
+	 * initial state for all possible entries.
+	 */
+	rtbd    r0, 1f
+	nop;
+1:
+	RESTORE_REGS
+	addik	r1, r1, PT_SIZE
+	rtsd	r15, 8;
+	nop;
+.end xmb_inject_err
+
 .section .data
 .global xmb_manager_dev
 .global xmb_manager_baseaddr
@@ -1225,6 +1261,22 @@ ENTRY(_reset)
 	.org	0x20
 	brai	TOPHYS(_hw_exception_handler);	/* HW exception handler */
 
+#ifdef CONFIG_MB_MANAGER
+	/*
+	 * For TMR Inject API which injects the error should
+	 * be executed from LMB.
+	 * TMR Inject is programmed with address of 0x200 so that
+	 * when program counter matches with this address error will
+	 * be injected. 0x200 is expected to be next available bram
+	 * offset, hence used for this api.
+	 */
+	.org	XMB_INJECT_ERR_OFFSET
+xmb_inject_error:
+	nop
+	rtsd	r15, 8
+	nop
+#endif
+
 .section .rodata,"a"
 #include "syscall_table.S"
 
-- 
2.25.1

