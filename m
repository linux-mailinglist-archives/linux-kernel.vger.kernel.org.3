Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A560A58FC6E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbiHKMgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbiHKMgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:36:21 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B601817042;
        Thu, 11 Aug 2022 05:36:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQ2ohoWLwCnKeXhZ3U8kEpRTnSsYxyHjK5nIW9xrTexNFZ9TEcE6fUTqwfik90Z+tip0m4hmhiLVNYCUqLU6PYPIedLXk3r8vSEBgW3FGMxTjdD58NW9WChMlJSFLaZTqUu46QuxB8jOdAHxGPrbTNHMq1edzG8BWon6lwLx+j4E85OczGjbmMOqY4BiEssCEAB1lmZh0WQx1goTC5gLZZdepdTEQWXXwycT2Zx0TlK/2zTs5YUiPl7CToK/8Sv9LEzH6PhirHjmpl2rIVoebEjOoLNEvruEO1NM5WwHqHtJKGLnOp+HCYWoDAVCJ6QPYmtfmpkO8H6v00W2ANlKMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YAL/3Gb9taioYCVCWS/70p75KGTzItf8xr8PZPB4Nc=;
 b=JrKAH36BMBwQyLQg7NDoKKW3q00bYXVpVrhsG6JAPPl7XpD65QgJgfgFO07X5GHTLdlviHRY//FdOf96ayzI5Jy2hAwrWvB3g0OZcq8bP4n5QFDN5na1eHrZkZacLd9zPd5WCzF9XXFOxazFWkAgFjtqjuoHQYJG3NBquYJp62tswaj37oM1Quq0UhF0TWsMvD+ljSAX9HZgIsX42keBrQ+wxwZ+d1IUSQDVVFRjndiS0cQ+c6Xu+5KfI/j3Gxob12elqYP2Xo/iCZlcMt6br7quuGl2oQWG8JUDYT5aqJK0Qkhff2DL2WqHmeUz6oV6GOTLU2poTc6W38AdCd9oew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YAL/3Gb9taioYCVCWS/70p75KGTzItf8xr8PZPB4Nc=;
 b=Y6CVxRF+vCiZlVXXRgQ72VBGEaeRGJkMvTSqU1VqCgr24Lgma1BjhQ+drdTiqPxPNUV9wDjeN3la5QfQ/ZjdC6wXlPKe29s53er/bxdWtHs984vMUStIs7QegKhm0dBN1OX2v5quoZX8ixkHyO0R8xTFbpl6WDTarznZorKJkCs=
Received: from MW4PR04CA0077.namprd04.prod.outlook.com (2603:10b6:303:6b::22)
 by DM5PR12MB2422.namprd12.prod.outlook.com (2603:10b6:4:b9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Thu, 11 Aug
 2022 12:36:14 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::47) by MW4PR04CA0077.outlook.office365.com
 (2603:10b6:303:6b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20 via Frontend
 Transport; Thu, 11 Aug 2022 12:36:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 12:36:13 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 11 Aug
 2022 07:36:03 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <bp@alien8.de>, <acme@kernel.org>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <like.xu.linux@gmail.com>,
        <eranian@google.com>, <ananth.narayan@amd.com>,
        <ravi.bangoria@amd.com>, <santosh.shukla@amd.com>,
        <sandipan.das@amd.com>
Subject: [PATCH 08/13] perf/x86: Move branch classifier
Date:   Thu, 11 Aug 2022 17:59:56 +0530
Message-ID: <bae5b95470d6bd49f40954bd379f414f5afcb965.1660211399.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1660211399.git.sandipan.das@amd.com>
References: <cover.1660211399.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66be2a11-5b22-4c37-a169-08da7b961416
X-MS-TrafficTypeDiagnostic: DM5PR12MB2422:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fg2Xp3laCIVxIG2bjF/vuNgRO6QrdXr/TGmnUfQ+Bhi0nTHDdBYdSKj9dmIsoe7gxPSKuhKatBdbxyMHopUrwY1ok1AnpGf0wIWXHzCwmyM02CKAavn947HUghvSNwFJKtLIkfw5iEYtkuLzHDQr9l5229FWhF9o5YR2w4xAkMSvvCuM5FqtMNohi2ONkP76cedo/p+q4UW7nx4hr3esEKnPKoDBaIeRJdvrwkL1RQuGMsxr4u9RmSRqWMInVSkwevIiq9wVxTPp1BIisc/Plotc7dvjp6wd1tceaSXnJIWmze0opsuX3c2ZothFJhFVvLBxmBGRC5ah6Nm3zSkDMTVrI6aazcL8lQ1lpdfwuCNRTALYpj39GWxgJrZseqiyWBL9jiU3lF3GY6jER7Neyvvbl6T0NLW47NOcQbortxd2HGOr/hkWDR3Dg/W12YOF7PnW/YC8yjBuaPUSW4G+qLNc+EY7/YC1S3k0XysgF+9Nqk8A38nFBq79RqML3HtXKx8j9KqlwQM2ys96KzcBZpFdW+VVKcO9o+3NRmrSseuU7iWZa8fn07otXRa8fuWGCWY0ulgQpVnsX3E/B5JSXFjjC1Tx/QBY7UGitBItEdRxbp+vkCwkgkZv6ADhBBNbCTLDtD7q0Zv3qSZa8AYT4Un/Mg9g2eU7u1ZR3Kcs/lF0j899TFJClCW94HmzbtoZF9IROwVMp8nzp3lwWbPU0nE/5prX9uLac5yqb/kX0yXBUFzQpYsEJGk8kLCsJWOby6tKDNqPz4FkHH00J1jmYHjzByh63dmroOQsao0eVv6rLgH9lPchc4TpbrKbeJYmYMehzJoYrBX6uyUN6DRX0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(136003)(396003)(36840700001)(46966006)(40470700004)(356005)(47076005)(81166007)(82740400003)(186003)(16526019)(26005)(2616005)(336012)(6666004)(478600001)(41300700001)(8676002)(40480700001)(54906003)(110136005)(7696005)(86362001)(4326008)(316002)(5660300002)(40460700003)(82310400005)(70206006)(70586007)(426003)(36860700001)(83380400001)(36756003)(44832011)(2906002)(7416002)(8936002)(30864003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 12:36:13.6809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66be2a11-5b22-4c37-a169-08da7b961416
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2422
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3e702ff6d1ea ("perf/x86: Add LBR software filter support for Intel
CPUs") introduces a software branch filter which complements the hardware
branch filter and adds an x86 branch classifier.

Move the branch classifier to arch/x86/events/ so that it can be utilized
by other vendors for branch record filtering.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/Makefile     |   2 +-
 arch/x86/events/intel/lbr.c  | 273 -----------------------------------
 arch/x86/events/perf_event.h |  62 ++++++++
 arch/x86/events/utils.c      | 216 +++++++++++++++++++++++++++
 4 files changed, 279 insertions(+), 274 deletions(-)
 create mode 100644 arch/x86/events/utils.c

diff --git a/arch/x86/events/Makefile b/arch/x86/events/Makefile
index 9933c0e8e97a..86a76efa8bb6 100644
--- a/arch/x86/events/Makefile
+++ b/arch/x86/events/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y					+= core.o probe.o
+obj-y					+= core.o probe.o utils.o
 obj-$(CONFIG_PERF_EVENTS_INTEL_RAPL)	+= rapl.o
 obj-y					+= amd/
 obj-$(CONFIG_X86_LOCAL_APIC)            += msr.o
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 13179f31fe10..d0dc1c358ec0 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -4,7 +4,6 @@
 
 #include <asm/perf_event.h>
 #include <asm/msr.h>
-#include <asm/insn.h>
 
 #include "../perf_event.h"
 
@@ -65,65 +64,6 @@
 
 #define LBR_FROM_SIGNEXT_2MSB	(BIT_ULL(60) | BIT_ULL(59))
 
-/*
- * x86control flow change classification
- * x86control flow changes include branches, interrupts, traps, faults
- */
-enum {
-	X86_BR_NONE		= 0,      /* unknown */
-
-	X86_BR_USER		= 1 << 0, /* branch target is user */
-	X86_BR_KERNEL		= 1 << 1, /* branch target is kernel */
-
-	X86_BR_CALL		= 1 << 2, /* call */
-	X86_BR_RET		= 1 << 3, /* return */
-	X86_BR_SYSCALL		= 1 << 4, /* syscall */
-	X86_BR_SYSRET		= 1 << 5, /* syscall return */
-	X86_BR_INT		= 1 << 6, /* sw interrupt */
-	X86_BR_IRET		= 1 << 7, /* return from interrupt */
-	X86_BR_JCC		= 1 << 8, /* conditional */
-	X86_BR_JMP		= 1 << 9, /* jump */
-	X86_BR_IRQ		= 1 << 10,/* hw interrupt or trap or fault */
-	X86_BR_IND_CALL		= 1 << 11,/* indirect calls */
-	X86_BR_ABORT		= 1 << 12,/* transaction abort */
-	X86_BR_IN_TX		= 1 << 13,/* in transaction */
-	X86_BR_NO_TX		= 1 << 14,/* not in transaction */
-	X86_BR_ZERO_CALL	= 1 << 15,/* zero length call */
-	X86_BR_CALL_STACK	= 1 << 16,/* call stack */
-	X86_BR_IND_JMP		= 1 << 17,/* indirect jump */
-
-	X86_BR_TYPE_SAVE	= 1 << 18,/* indicate to save branch type */
-
-};
-
-#define X86_BR_PLM (X86_BR_USER | X86_BR_KERNEL)
-#define X86_BR_ANYTX (X86_BR_NO_TX | X86_BR_IN_TX)
-
-#define X86_BR_ANY       \
-	(X86_BR_CALL    |\
-	 X86_BR_RET     |\
-	 X86_BR_SYSCALL |\
-	 X86_BR_SYSRET  |\
-	 X86_BR_INT     |\
-	 X86_BR_IRET    |\
-	 X86_BR_JCC     |\
-	 X86_BR_JMP	 |\
-	 X86_BR_IRQ	 |\
-	 X86_BR_ABORT	 |\
-	 X86_BR_IND_CALL |\
-	 X86_BR_IND_JMP  |\
-	 X86_BR_ZERO_CALL)
-
-#define X86_BR_ALL (X86_BR_PLM | X86_BR_ANY)
-
-#define X86_BR_ANY_CALL		 \
-	(X86_BR_CALL		|\
-	 X86_BR_IND_CALL	|\
-	 X86_BR_ZERO_CALL	|\
-	 X86_BR_SYSCALL		|\
-	 X86_BR_IRQ		|\
-	 X86_BR_INT)
-
 /*
  * Intel LBR_CTL bits
  *
@@ -1143,219 +1083,6 @@ int intel_pmu_setup_lbr_filter(struct perf_event *event)
 	return ret;
 }
 
-/*
- * return the type of control flow change at address "from"
- * instruction is not necessarily a branch (in case of interrupt).
- *
- * The branch type returned also includes the priv level of the
- * target of the control flow change (X86_BR_USER, X86_BR_KERNEL).
- *
- * If a branch type is unknown OR the instruction cannot be
- * decoded (e.g., text page not present), then X86_BR_NONE is
- * returned.
- */
-static int branch_type(unsigned long from, unsigned long to, int abort)
-{
-	struct insn insn;
-	void *addr;
-	int bytes_read, bytes_left;
-	int ret = X86_BR_NONE;
-	int ext, to_plm, from_plm;
-	u8 buf[MAX_INSN_SIZE];
-	int is64 = 0;
-
-	to_plm = kernel_ip(to) ? X86_BR_KERNEL : X86_BR_USER;
-	from_plm = kernel_ip(from) ? X86_BR_KERNEL : X86_BR_USER;
-
-	/*
-	 * maybe zero if lbr did not fill up after a reset by the time
-	 * we get a PMU interrupt
-	 */
-	if (from == 0 || to == 0)
-		return X86_BR_NONE;
-
-	if (abort)
-		return X86_BR_ABORT | to_plm;
-
-	if (from_plm == X86_BR_USER) {
-		/*
-		 * can happen if measuring at the user level only
-		 * and we interrupt in a kernel thread, e.g., idle.
-		 */
-		if (!current->mm)
-			return X86_BR_NONE;
-
-		/* may fail if text not present */
-		bytes_left = copy_from_user_nmi(buf, (void __user *)from,
-						MAX_INSN_SIZE);
-		bytes_read = MAX_INSN_SIZE - bytes_left;
-		if (!bytes_read)
-			return X86_BR_NONE;
-
-		addr = buf;
-	} else {
-		/*
-		 * The LBR logs any address in the IP, even if the IP just
-		 * faulted. This means userspace can control the from address.
-		 * Ensure we don't blindly read any address by validating it is
-		 * a known text address.
-		 */
-		if (kernel_text_address(from)) {
-			addr = (void *)from;
-			/*
-			 * Assume we can get the maximum possible size
-			 * when grabbing kernel data.  This is not
-			 * _strictly_ true since we could possibly be
-			 * executing up next to a memory hole, but
-			 * it is very unlikely to be a problem.
-			 */
-			bytes_read = MAX_INSN_SIZE;
-		} else {
-			return X86_BR_NONE;
-		}
-	}
-
-	/*
-	 * decoder needs to know the ABI especially
-	 * on 64-bit systems running 32-bit apps
-	 */
-#ifdef CONFIG_X86_64
-	is64 = kernel_ip((unsigned long)addr) || any_64bit_mode(current_pt_regs());
-#endif
-	insn_init(&insn, addr, bytes_read, is64);
-	if (insn_get_opcode(&insn))
-		return X86_BR_ABORT;
-
-	switch (insn.opcode.bytes[0]) {
-	case 0xf:
-		switch (insn.opcode.bytes[1]) {
-		case 0x05: /* syscall */
-		case 0x34: /* sysenter */
-			ret = X86_BR_SYSCALL;
-			break;
-		case 0x07: /* sysret */
-		case 0x35: /* sysexit */
-			ret = X86_BR_SYSRET;
-			break;
-		case 0x80 ... 0x8f: /* conditional */
-			ret = X86_BR_JCC;
-			break;
-		default:
-			ret = X86_BR_NONE;
-		}
-		break;
-	case 0x70 ... 0x7f: /* conditional */
-		ret = X86_BR_JCC;
-		break;
-	case 0xc2: /* near ret */
-	case 0xc3: /* near ret */
-	case 0xca: /* far ret */
-	case 0xcb: /* far ret */
-		ret = X86_BR_RET;
-		break;
-	case 0xcf: /* iret */
-		ret = X86_BR_IRET;
-		break;
-	case 0xcc ... 0xce: /* int */
-		ret = X86_BR_INT;
-		break;
-	case 0xe8: /* call near rel */
-		if (insn_get_immediate(&insn) || insn.immediate1.value == 0) {
-			/* zero length call */
-			ret = X86_BR_ZERO_CALL;
-			break;
-		}
-		fallthrough;
-	case 0x9a: /* call far absolute */
-		ret = X86_BR_CALL;
-		break;
-	case 0xe0 ... 0xe3: /* loop jmp */
-		ret = X86_BR_JCC;
-		break;
-	case 0xe9 ... 0xeb: /* jmp */
-		ret = X86_BR_JMP;
-		break;
-	case 0xff: /* call near absolute, call far absolute ind */
-		if (insn_get_modrm(&insn))
-			return X86_BR_ABORT;
-
-		ext = (insn.modrm.bytes[0] >> 3) & 0x7;
-		switch (ext) {
-		case 2: /* near ind call */
-		case 3: /* far ind call */
-			ret = X86_BR_IND_CALL;
-			break;
-		case 4:
-		case 5:
-			ret = X86_BR_IND_JMP;
-			break;
-		}
-		break;
-	default:
-		ret = X86_BR_NONE;
-	}
-	/*
-	 * interrupts, traps, faults (and thus ring transition) may
-	 * occur on any instructions. Thus, to classify them correctly,
-	 * we need to first look at the from and to priv levels. If they
-	 * are different and to is in the kernel, then it indicates
-	 * a ring transition. If the from instruction is not a ring
-	 * transition instr (syscall, systenter, int), then it means
-	 * it was a irq, trap or fault.
-	 *
-	 * we have no way of detecting kernel to kernel faults.
-	 */
-	if (from_plm == X86_BR_USER && to_plm == X86_BR_KERNEL
-	    && ret != X86_BR_SYSCALL && ret != X86_BR_INT)
-		ret = X86_BR_IRQ;
-
-	/*
-	 * branch priv level determined by target as
-	 * is done by HW when LBR_SELECT is implemented
-	 */
-	if (ret != X86_BR_NONE)
-		ret |= to_plm;
-
-	return ret;
-}
-
-#define X86_BR_TYPE_MAP_MAX	16
-
-static int branch_map[X86_BR_TYPE_MAP_MAX] = {
-	PERF_BR_CALL,		/* X86_BR_CALL */
-	PERF_BR_RET,		/* X86_BR_RET */
-	PERF_BR_SYSCALL,	/* X86_BR_SYSCALL */
-	PERF_BR_SYSRET,		/* X86_BR_SYSRET */
-	PERF_BR_UNKNOWN,	/* X86_BR_INT */
-	PERF_BR_ERET,		/* X86_BR_IRET */
-	PERF_BR_COND,		/* X86_BR_JCC */
-	PERF_BR_UNCOND,		/* X86_BR_JMP */
-	PERF_BR_IRQ,		/* X86_BR_IRQ */
-	PERF_BR_IND_CALL,	/* X86_BR_IND_CALL */
-	PERF_BR_UNKNOWN,	/* X86_BR_ABORT */
-	PERF_BR_UNKNOWN,	/* X86_BR_IN_TX */
-	PERF_BR_UNKNOWN,	/* X86_BR_NO_TX */
-	PERF_BR_CALL,		/* X86_BR_ZERO_CALL */
-	PERF_BR_UNKNOWN,	/* X86_BR_CALL_STACK */
-	PERF_BR_IND,		/* X86_BR_IND_JMP */
-};
-
-static int
-common_branch_type(int type)
-{
-	int i;
-
-	type >>= 2; /* skip X86_BR_USER and X86_BR_KERNEL */
-
-	if (type) {
-		i = __ffs(type);
-		if (i < X86_BR_TYPE_MAP_MAX)
-			return branch_map[i];
-	}
-
-	return PERF_BR_UNKNOWN;
-}
-
 enum {
 	ARCH_LBR_BR_TYPE_JCC			= 0,
 	ARCH_LBR_BR_TYPE_NEAR_IND_JMP		= 1,
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index c8397290f388..8ac8f9e6affb 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1208,6 +1208,68 @@ static inline void set_linear_ip(struct pt_regs *regs, unsigned long ip)
 	regs->ip = ip;
 }
 
+/*
+ * x86control flow change classification
+ * x86control flow changes include branches, interrupts, traps, faults
+ */
+enum {
+	X86_BR_NONE		= 0,      /* unknown */
+
+	X86_BR_USER		= 1 << 0, /* branch target is user */
+	X86_BR_KERNEL		= 1 << 1, /* branch target is kernel */
+
+	X86_BR_CALL		= 1 << 2, /* call */
+	X86_BR_RET		= 1 << 3, /* return */
+	X86_BR_SYSCALL		= 1 << 4, /* syscall */
+	X86_BR_SYSRET		= 1 << 5, /* syscall return */
+	X86_BR_INT		= 1 << 6, /* sw interrupt */
+	X86_BR_IRET		= 1 << 7, /* return from interrupt */
+	X86_BR_JCC		= 1 << 8, /* conditional */
+	X86_BR_JMP		= 1 << 9, /* jump */
+	X86_BR_IRQ		= 1 << 10,/* hw interrupt or trap or fault */
+	X86_BR_IND_CALL		= 1 << 11,/* indirect calls */
+	X86_BR_ABORT		= 1 << 12,/* transaction abort */
+	X86_BR_IN_TX		= 1 << 13,/* in transaction */
+	X86_BR_NO_TX		= 1 << 14,/* not in transaction */
+	X86_BR_ZERO_CALL	= 1 << 15,/* zero length call */
+	X86_BR_CALL_STACK	= 1 << 16,/* call stack */
+	X86_BR_IND_JMP		= 1 << 17,/* indirect jump */
+
+	X86_BR_TYPE_SAVE	= 1 << 18,/* indicate to save branch type */
+
+};
+
+#define X86_BR_PLM (X86_BR_USER | X86_BR_KERNEL)
+#define X86_BR_ANYTX (X86_BR_NO_TX | X86_BR_IN_TX)
+
+#define X86_BR_ANY       \
+	(X86_BR_CALL    |\
+	 X86_BR_RET     |\
+	 X86_BR_SYSCALL |\
+	 X86_BR_SYSRET  |\
+	 X86_BR_INT     |\
+	 X86_BR_IRET    |\
+	 X86_BR_JCC     |\
+	 X86_BR_JMP	 |\
+	 X86_BR_IRQ	 |\
+	 X86_BR_ABORT	 |\
+	 X86_BR_IND_CALL |\
+	 X86_BR_IND_JMP  |\
+	 X86_BR_ZERO_CALL)
+
+#define X86_BR_ALL (X86_BR_PLM | X86_BR_ANY)
+
+#define X86_BR_ANY_CALL		 \
+	(X86_BR_CALL		|\
+	 X86_BR_IND_CALL	|\
+	 X86_BR_ZERO_CALL	|\
+	 X86_BR_SYSCALL		|\
+	 X86_BR_IRQ		|\
+	 X86_BR_INT)
+
+int common_branch_type(int type);
+int branch_type(unsigned long from, unsigned long to, int abort);
+
 ssize_t x86_event_sysfs_show(char *page, u64 config, u64 event);
 ssize_t intel_event_sysfs_show(char *page, u64 config);
 
diff --git a/arch/x86/events/utils.c b/arch/x86/events/utils.c
new file mode 100644
index 000000000000..a32368945462
--- /dev/null
+++ b/arch/x86/events/utils.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <asm/insn.h>
+
+#include "perf_event.h"
+
+/*
+ * return the type of control flow change at address "from"
+ * instruction is not necessarily a branch (in case of interrupt).
+ *
+ * The branch type returned also includes the priv level of the
+ * target of the control flow change (X86_BR_USER, X86_BR_KERNEL).
+ *
+ * If a branch type is unknown OR the instruction cannot be
+ * decoded (e.g., text page not present), then X86_BR_NONE is
+ * returned.
+ */
+int branch_type(unsigned long from, unsigned long to, int abort)
+{
+	struct insn insn;
+	void *addr;
+	int bytes_read, bytes_left;
+	int ret = X86_BR_NONE;
+	int ext, to_plm, from_plm;
+	u8 buf[MAX_INSN_SIZE];
+	int is64 = 0;
+
+	to_plm = kernel_ip(to) ? X86_BR_KERNEL : X86_BR_USER;
+	from_plm = kernel_ip(from) ? X86_BR_KERNEL : X86_BR_USER;
+
+	/*
+	 * maybe zero if lbr did not fill up after a reset by the time
+	 * we get a PMU interrupt
+	 */
+	if (from == 0 || to == 0)
+		return X86_BR_NONE;
+
+	if (abort)
+		return X86_BR_ABORT | to_plm;
+
+	if (from_plm == X86_BR_USER) {
+		/*
+		 * can happen if measuring at the user level only
+		 * and we interrupt in a kernel thread, e.g., idle.
+		 */
+		if (!current->mm)
+			return X86_BR_NONE;
+
+		/* may fail if text not present */
+		bytes_left = copy_from_user_nmi(buf, (void __user *)from,
+						MAX_INSN_SIZE);
+		bytes_read = MAX_INSN_SIZE - bytes_left;
+		if (!bytes_read)
+			return X86_BR_NONE;
+
+		addr = buf;
+	} else {
+		/*
+		 * The LBR logs any address in the IP, even if the IP just
+		 * faulted. This means userspace can control the from address.
+		 * Ensure we don't blindly read any address by validating it is
+		 * a known text address.
+		 */
+		if (kernel_text_address(from)) {
+			addr = (void *)from;
+			/*
+			 * Assume we can get the maximum possible size
+			 * when grabbing kernel data.  This is not
+			 * _strictly_ true since we could possibly be
+			 * executing up next to a memory hole, but
+			 * it is very unlikely to be a problem.
+			 */
+			bytes_read = MAX_INSN_SIZE;
+		} else {
+			return X86_BR_NONE;
+		}
+	}
+
+	/*
+	 * decoder needs to know the ABI especially
+	 * on 64-bit systems running 32-bit apps
+	 */
+#ifdef CONFIG_X86_64
+	is64 = kernel_ip((unsigned long)addr) || any_64bit_mode(current_pt_regs());
+#endif
+	insn_init(&insn, addr, bytes_read, is64);
+	if (insn_get_opcode(&insn))
+		return X86_BR_ABORT;
+
+	switch (insn.opcode.bytes[0]) {
+	case 0xf:
+		switch (insn.opcode.bytes[1]) {
+		case 0x05: /* syscall */
+		case 0x34: /* sysenter */
+			ret = X86_BR_SYSCALL;
+			break;
+		case 0x07: /* sysret */
+		case 0x35: /* sysexit */
+			ret = X86_BR_SYSRET;
+			break;
+		case 0x80 ... 0x8f: /* conditional */
+			ret = X86_BR_JCC;
+			break;
+		default:
+			ret = X86_BR_NONE;
+		}
+		break;
+	case 0x70 ... 0x7f: /* conditional */
+		ret = X86_BR_JCC;
+		break;
+	case 0xc2: /* near ret */
+	case 0xc3: /* near ret */
+	case 0xca: /* far ret */
+	case 0xcb: /* far ret */
+		ret = X86_BR_RET;
+		break;
+	case 0xcf: /* iret */
+		ret = X86_BR_IRET;
+		break;
+	case 0xcc ... 0xce: /* int */
+		ret = X86_BR_INT;
+		break;
+	case 0xe8: /* call near rel */
+		if (insn_get_immediate(&insn) || insn.immediate1.value == 0) {
+			/* zero length call */
+			ret = X86_BR_ZERO_CALL;
+			break;
+		}
+		fallthrough;
+	case 0x9a: /* call far absolute */
+		ret = X86_BR_CALL;
+		break;
+	case 0xe0 ... 0xe3: /* loop jmp */
+		ret = X86_BR_JCC;
+		break;
+	case 0xe9 ... 0xeb: /* jmp */
+		ret = X86_BR_JMP;
+		break;
+	case 0xff: /* call near absolute, call far absolute ind */
+		if (insn_get_modrm(&insn))
+			return X86_BR_ABORT;
+
+		ext = (insn.modrm.bytes[0] >> 3) & 0x7;
+		switch (ext) {
+		case 2: /* near ind call */
+		case 3: /* far ind call */
+			ret = X86_BR_IND_CALL;
+			break;
+		case 4:
+		case 5:
+			ret = X86_BR_IND_JMP;
+			break;
+		}
+		break;
+	default:
+		ret = X86_BR_NONE;
+	}
+	/*
+	 * interrupts, traps, faults (and thus ring transition) may
+	 * occur on any instructions. Thus, to classify them correctly,
+	 * we need to first look at the from and to priv levels. If they
+	 * are different and to is in the kernel, then it indicates
+	 * a ring transition. If the from instruction is not a ring
+	 * transition instr (syscall, systenter, int), then it means
+	 * it was a irq, trap or fault.
+	 *
+	 * we have no way of detecting kernel to kernel faults.
+	 */
+	if (from_plm == X86_BR_USER && to_plm == X86_BR_KERNEL
+	    && ret != X86_BR_SYSCALL && ret != X86_BR_INT)
+		ret = X86_BR_IRQ;
+
+	/*
+	 * branch priv level determined by target as
+	 * is done by HW when LBR_SELECT is implemented
+	 */
+	if (ret != X86_BR_NONE)
+		ret |= to_plm;
+
+	return ret;
+}
+
+#define X86_BR_TYPE_MAP_MAX	16
+
+static int branch_map[X86_BR_TYPE_MAP_MAX] = {
+	PERF_BR_CALL,		/* X86_BR_CALL */
+	PERF_BR_RET,		/* X86_BR_RET */
+	PERF_BR_SYSCALL,	/* X86_BR_SYSCALL */
+	PERF_BR_SYSRET,		/* X86_BR_SYSRET */
+	PERF_BR_UNKNOWN,	/* X86_BR_INT */
+	PERF_BR_ERET,		/* X86_BR_IRET */
+	PERF_BR_COND,		/* X86_BR_JCC */
+	PERF_BR_UNCOND,		/* X86_BR_JMP */
+	PERF_BR_IRQ,		/* X86_BR_IRQ */
+	PERF_BR_IND_CALL,	/* X86_BR_IND_CALL */
+	PERF_BR_UNKNOWN,	/* X86_BR_ABORT */
+	PERF_BR_UNKNOWN,	/* X86_BR_IN_TX */
+	PERF_BR_UNKNOWN,	/* X86_BR_NO_TX */
+	PERF_BR_CALL,		/* X86_BR_ZERO_CALL */
+	PERF_BR_UNKNOWN,	/* X86_BR_CALL_STACK */
+	PERF_BR_IND,		/* X86_BR_IND_JMP */
+};
+
+int common_branch_type(int type)
+{
+	int i;
+
+	type >>= 2; /* skip X86_BR_USER and X86_BR_KERNEL */
+
+	if (type) {
+		i = __ffs(type);
+		if (i < X86_BR_TYPE_MAP_MAX)
+			return branch_map[i];
+	}
+
+	return PERF_BR_UNKNOWN;
+}
-- 
2.34.1

