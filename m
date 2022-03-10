Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280CB4D4576
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 12:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241533AbiCJLRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 06:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241531AbiCJLRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 06:17:20 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE0B141466
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 03:16:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+dMWlBTcEhj9HicwINstZ/vnqWgX2sXkDIp8RzXSXOy2lXtvexwqu9fMngiYt8S67PtVRRyPu2utyDGSJyB3hKvC6E5HeNalsHSEadMD+PK+kvJ2S+aDltTClcS+kEO/XmlQ/kU0R8MBjqBetXag4vVX9j8xwqidI0H5WDXMZYaA20UZ6wOgA/sVtBvM40QnlJDx2/VO1nMyAFIP4fcyiXAypx6LBb2O1AytxqEmj3ugDnjC3TP97I8fjb7J40TreCwDedqS52CSxGfs1x3yCYcp4t5tj2NNDgWbi+3T0tBRkg491N/qHlOt2V3lv7HCg2nmSgJ51txWgQvy1g8gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZsu1j80b51aVDCZsYbxSMhONhjprdDenKJTK/70D+0=;
 b=TMz/RlkZvYlJqdCbvGtksFc2H8mEVv5mfdaqK2EotSWb5V2TYYeVyalPCAfsUOE36FEVwcJO8rHLku9GM65GTHFnfIZpVgX8bJ+sYCDD7aGvFqlj/BHMs0c9kzHx9qoAdtqO3siADn46HlLt/muF6eN7M6thSe6GvPasBKoeGFT0NredSzPuUnnnZWNFpO7AIj/S1jA1O96kEXLC+hPNUUCdLzOEUwB4fZBjyti3KCXPb/uk/Kru6WP2d2XduQAyMsHeXly5vYFANL+v/UJKVbUfIZeuLQWaR2/j8R5DTyB7SaYKfGDkd/lzXbIewdUeiJfbYvz22eYoDG1wtWR3eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZsu1j80b51aVDCZsYbxSMhONhjprdDenKJTK/70D+0=;
 b=ONVtwFcP6hqdTY+jdLUuuPxCPuU/gDArpHOlwxu0TQIlYoQ+jo66dxAVmharB0yMLAoMg0pW8+EbLlI9Lroot7W3LR0meecCmopKPcPwkXEfLTa0laqiWhAtdfhEvK/k5TJz8T0JLJ+/HhNxCrTevKR4LFnMEABaCZA1bOcNvrE=
Received: from CO2PR05CA0092.namprd05.prod.outlook.com (2603:10b6:104:1::18)
 by DM5PR1201MB0106.namprd12.prod.outlook.com (2603:10b6:4:4f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Thu, 10 Mar
 2022 11:16:16 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:1:cafe::ec) by CO2PR05CA0092.outlook.office365.com
 (2603:10b6:104:1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.7 via Frontend
 Transport; Thu, 10 Mar 2022 11:16:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Thu, 10 Mar 2022 11:16:15 +0000
Received: from BLR-5CG1133937.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 05:16:09 -0600
From:   Bharata B Rao <bharata@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <x86@kernel.org>,
        <kirill.shutemov@linux.intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>, <shuah@kernel.org>,
        <oleg@redhat.com>, <ananth.narayan@amd.com>,
        "Bharata B Rao" <bharata@amd.com>
Subject: [RFC PATCH v0 1/6] mm, arm64: Update PR_SET/GET_TAGGED_ADDR_CTRL interface
Date:   Thu, 10 Mar 2022 16:45:40 +0530
Message-ID: <20220310111545.10852-2-bharata@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220310111545.10852-1-bharata@amd.com>
References: <20220310111545.10852-1-bharata@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d7f5d4a-813c-45e2-1c33-08da028764b9
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0106:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0106764702C6E5ED4E43E100B00B9@DM5PR1201MB0106.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Yz+qSkQhVpN4l8JLdSaE2RDTrDBmt1vpMM0htHJkQKa3KMjM0Ly5Km7wusIHlwuYxuDUeOeW2yywO65q4lvwo9QvcLyfaPAw47FKQ25fiOxmyNfIUSY1mnT/2to0s68knWZRPR5Db9SYhmHdhddf688QfoVUBV0RrTB17/JIl3URUMnykxkeCK9kV32W5JYVGXGrdgPEvPGSjszVuOd5PjwVJMtLLNkCjwxHOIr0tWSk+p/bBJ2EWi+kBJQbe+DY/donKsA0B+UpXDaJ/Q9Faly41Z+LY/V660mA2o6bieQ0hpz4Ki7IsqupemRnWavrbJAfmA9VvAx55Af/G++N3FYLk1MFanQE641mo43U6I7iFb2AUB2T+omHEHUJ/wzcjbecoJDqWsdfPsUdzyShKxnRsGOnRzJGbobsc3QRqcLjneevHOBwWineArfHuDAoVlZMAPpZIfCmE4faaetWDDjotS/E6SUXYA9D9t8E26h9zfvKZyp9xGiNOn/C/V8DrLOQ/2v676+whmpRYPyzPeE23sAupIzS+tXSqv+a7hFa+jgaAfq8o5U8z+H+i1K57s9zfDcP9xAsL18zd5Tm49yYcjxjUQpHnDpaNZt2tIc78dRWfPo6+hQURsX9K9L/HJaPHiIDGd1TceuOSI8W/l61J7vB+qCb9vTgBDIt5SuSIUtAwh7qnBS0AGyIHTFu53ZLsuE6EKIijmS+ru8+ueHkFqbLwb+M3h6YZxlcJhbdFM1y9ZDd7hWI4ZsBNNa
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(508600001)(86362001)(70586007)(40460700003)(16526019)(426003)(26005)(83380400001)(336012)(1076003)(2616005)(6666004)(7696005)(47076005)(186003)(2906002)(30864003)(5660300002)(81166007)(4326008)(70206006)(8676002)(316002)(36860700001)(7416002)(54906003)(15650500001)(356005)(8936002)(36756003)(6916009)(82310400004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 11:16:15.8008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7f5d4a-813c-45e2-1c33-08da028764b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0106
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

The interface for enabling tagged addresses is very inflexible. It
implies tag size and tag shift implemented by ARM TBI.

Rework the interface to accommodate different shifts and tag sizes.

PR_SET_TAGGED_ADDR_CTRL now accepts two new arguments:

 - nr_bits is pointer to int. The caller specifies the tag size it
   wants. Kernel updates the value of actual tag size that can be
   larger.

 - offset is pointer to int. Kernel returns there a shift of tag in the
   address.

The change doesn't break existing users of the interface: if any of
these pointers are NULL (as we had before the change), the user expects
ARM TBI implementation: nr_bits == 8 && offset == 56 as it was implied
before.

The initial implementation checked that these argument are NULL and the
change wouldn't not break any legacy users.

If tagging is enabled, GET_TAGGED_ADDR_CTRL would return size of tags
and offset in the additional arguments.

If tagging is disable, GET_TAGGED_ADDR_CTRL would return the maximum tag
size in nr_bits.

The selftest is updated accordingly and moved out of arm64-specific
directory as we going to enable the interface on x86.

As alternative to this approach we could introduce a totally new API and
leave the legacy one as is. But it would slow down adoption: new
prctl(2) flag wound need to propogate to the userspace headers.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
	[selftests/vm/tags/tags_test.c: Set ptr tag only when tagging
	 is enabled and a couple of checkpatch warning fixes]
Signed-off-by: Bharata B Rao <bharata@amd.com>
---
 arch/arm64/include/asm/processor.h            | 12 ++--
 arch/arm64/kernel/process.c                   | 45 +++++++++++---
 arch/arm64/kernel/ptrace.c                    |  4 +-
 kernel/sys.c                                  | 14 +++--
 .../testing/selftests/arm64/tags/tags_test.c  | 31 ----------
 .../selftests/{arm64 => vm}/tags/.gitignore   |  0
 .../selftests/{arm64 => vm}/tags/Makefile     |  0
 .../{arm64 => vm}/tags/run_tags_test.sh       |  0
 tools/testing/selftests/vm/tags/tags_test.c   | 59 +++++++++++++++++++
 9 files changed, 115 insertions(+), 50 deletions(-)
 delete mode 100644 tools/testing/selftests/arm64/tags/tags_test.c
 rename tools/testing/selftests/{arm64 => vm}/tags/.gitignore (100%)
 rename tools/testing/selftests/{arm64 => vm}/tags/Makefile (100%)
 rename tools/testing/selftests/{arm64 => vm}/tags/run_tags_test.sh (100%)
 create mode 100644 tools/testing/selftests/vm/tags/tags_test.c

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 6f41b65f9962..c3936bebf006 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -367,10 +367,14 @@ extern void __init minsigstksz_setup(void);
 
 #ifdef CONFIG_ARM64_TAGGED_ADDR_ABI
 /* PR_{SET,GET}_TAGGED_ADDR_CTRL prctl */
-long set_tagged_addr_ctrl(struct task_struct *task, unsigned long arg);
-long get_tagged_addr_ctrl(struct task_struct *task);
-#define SET_TAGGED_ADDR_CTRL(arg)	set_tagged_addr_ctrl(current, arg)
-#define GET_TAGGED_ADDR_CTRL()		get_tagged_addr_ctrl(current)
+long set_tagged_addr_ctrl(struct task_struct *task, unsigned long flags,
+			  int __user *nr_bits, int __user *offset);
+long get_tagged_addr_ctrl(struct task_struct *task,
+			  int __user *nr_bits, int __user *offset);
+#define SET_TAGGED_ADDR_CTRL(flags, nr_bits, offset)	\
+	set_tagged_addr_ctrl(current, flags, nr_bits, offset)
+#define GET_TAGGED_ADDR_CTRL(nr_bits, offset)		\
+	get_tagged_addr_ctrl(current, nr_bits, offset)
 #endif
 
 /*
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 5369e649fa79..fc0240f5ead0 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -621,15 +621,21 @@ void arch_setup_new_exec(void)
 }
 
 #ifdef CONFIG_ARM64_TAGGED_ADDR_ABI
+
+#define TBI_TAG_BITS	8
+#define TBI_TAG_SHIFT	56
+
 /*
  * Control the relaxed ABI allowing tagged user addresses into the kernel.
  */
 static unsigned int tagged_addr_disabled;
 
-long set_tagged_addr_ctrl(struct task_struct *task, unsigned long arg)
+long set_tagged_addr_ctrl(struct task_struct *task, unsigned long flags,
+			  int __user *nr_bits, int __user *offset)
 {
 	unsigned long valid_mask = PR_TAGGED_ADDR_ENABLE;
 	struct thread_info *ti = task_thread_info(task);
+	int val;
 
 	if (is_compat_thread(ti))
 		return -EINVAL;
@@ -637,25 +643,41 @@ long set_tagged_addr_ctrl(struct task_struct *task, unsigned long arg)
 	if (system_supports_mte())
 		valid_mask |= PR_MTE_TCF_MASK | PR_MTE_TAG_MASK;
 
-	if (arg & ~valid_mask)
+	if (flags & ~valid_mask)
 		return -EINVAL;
 
+	if (nr_bits) {
+		if (get_user(val, nr_bits))
+			return -EFAULT;
+		if (val > TBI_TAG_BITS || val < 1)
+			return -EINVAL;
+	}
+
 	/*
 	 * Do not allow the enabling of the tagged address ABI if globally
 	 * disabled via sysctl abi.tagged_addr_disabled.
 	 */
-	if (arg & PR_TAGGED_ADDR_ENABLE && tagged_addr_disabled)
+	if (flags & PR_TAGGED_ADDR_ENABLE && tagged_addr_disabled)
 		return -EINVAL;
 
-	if (set_mte_ctrl(task, arg) != 0)
+	if (set_mte_ctrl(task, flags) != 0)
 		return -EINVAL;
 
-	update_ti_thread_flag(ti, TIF_TAGGED_ADDR, arg & PR_TAGGED_ADDR_ENABLE);
+	if (flags & PR_TAGGED_ADDR_ENABLE) {
+		if (nr_bits && put_user(TBI_TAG_BITS, nr_bits))
+			return -EFAULT;
+		if (offset && put_user(TBI_TAG_SHIFT, offset))
+			return -EFAULT;
+	}
+
+	update_ti_thread_flag(ti, TIF_TAGGED_ADDR,
+			      flags & PR_TAGGED_ADDR_ENABLE);
 
 	return 0;
 }
 
-long get_tagged_addr_ctrl(struct task_struct *task)
+long get_tagged_addr_ctrl(struct task_struct *task,
+			  int __user *nr_bits, int __user *offset)
 {
 	long ret = 0;
 	struct thread_info *ti = task_thread_info(task);
@@ -663,8 +685,17 @@ long get_tagged_addr_ctrl(struct task_struct *task)
 	if (is_compat_thread(ti))
 		return -EINVAL;
 
-	if (test_ti_thread_flag(ti, TIF_TAGGED_ADDR))
+	if (test_ti_thread_flag(ti, TIF_TAGGED_ADDR)) {
 		ret = PR_TAGGED_ADDR_ENABLE;
+		if (nr_bits && put_user(TBI_TAG_BITS, nr_bits))
+			return -EFAULT;
+		if (offset && put_user(TBI_TAG_SHIFT, offset))
+			return -EFAULT;
+	} else {
+		/* Report maximum tag size */
+		if (nr_bits && put_user(TBI_TAG_BITS, nr_bits))
+			return -EFAULT;
+	}
 
 	ret |= get_mte_ctrl(task);
 
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 39dbdfdc38d3..471fd40f7d4e 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1073,7 +1073,7 @@ static int tagged_addr_ctrl_get(struct task_struct *target,
 				const struct user_regset *regset,
 				struct membuf to)
 {
-	long ctrl = get_tagged_addr_ctrl(target);
+	long ctrl = get_tagged_addr_ctrl(target, NULL, NULL);
 
 	if (IS_ERR_VALUE(ctrl))
 		return ctrl;
@@ -1093,7 +1093,7 @@ static int tagged_addr_ctrl_set(struct task_struct *target, const struct
 	if (ret)
 		return ret;
 
-	return set_tagged_addr_ctrl(target, ctrl);
+	return set_tagged_addr_ctrl(target, ctrl, NULL, NULL);
 }
 #endif
 
diff --git a/kernel/sys.c b/kernel/sys.c
index 97dc9e5d6bf9..3af5c5098b3c 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -126,10 +126,10 @@
 # define PAC_GET_ENABLED_KEYS(a)	(-EINVAL)
 #endif
 #ifndef SET_TAGGED_ADDR_CTRL
-# define SET_TAGGED_ADDR_CTRL(a)	(-EINVAL)
+# define SET_TAGGED_ADDR_CTRL(a, b, c)	(-EINVAL)
 #endif
 #ifndef GET_TAGGED_ADDR_CTRL
-# define GET_TAGGED_ADDR_CTRL()		(-EINVAL)
+# define GET_TAGGED_ADDR_CTRL(a, b)	(-EINVAL)
 #endif
 
 /*
@@ -2557,14 +2557,16 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		error = PAC_GET_ENABLED_KEYS(me);
 		break;
 	case PR_SET_TAGGED_ADDR_CTRL:
-		if (arg3 || arg4 || arg5)
+		if (arg5)
 			return -EINVAL;
-		error = SET_TAGGED_ADDR_CTRL(arg2);
+		error = SET_TAGGED_ADDR_CTRL(arg2, (int __user *)arg3,
+					     (int __user *)arg4);
 		break;
 	case PR_GET_TAGGED_ADDR_CTRL:
-		if (arg2 || arg3 || arg4 || arg5)
+		if (arg4 || arg5)
 			return -EINVAL;
-		error = GET_TAGGED_ADDR_CTRL();
+		error = GET_TAGGED_ADDR_CTRL((int __user *)arg2,
+					     (int __user *)arg3);
 		break;
 	case PR_SET_IO_FLUSHER:
 		if (!capable(CAP_SYS_RESOURCE))
diff --git a/tools/testing/selftests/arm64/tags/tags_test.c b/tools/testing/selftests/arm64/tags/tags_test.c
deleted file mode 100644
index 5701163460ef..000000000000
--- a/tools/testing/selftests/arm64/tags/tags_test.c
+++ /dev/null
@@ -1,31 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <stdint.h>
-#include <sys/prctl.h>
-#include <sys/utsname.h>
-
-#define SHIFT_TAG(tag)		((uint64_t)(tag) << 56)
-#define SET_TAG(ptr, tag)	(((uint64_t)(ptr) & ~SHIFT_TAG(0xff)) | \
-					SHIFT_TAG(tag))
-
-int main(void)
-{
-	static int tbi_enabled = 0;
-	unsigned long tag = 0;
-	struct utsname *ptr;
-	int err;
-
-	if (prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE, 0, 0, 0) == 0)
-		tbi_enabled = 1;
-	ptr = (struct utsname *)malloc(sizeof(*ptr));
-	if (tbi_enabled)
-		tag = 0x42;
-	ptr = (struct utsname *)SET_TAG(ptr, tag);
-	err = uname(ptr);
-	free(ptr);
-
-	return err;
-}
diff --git a/tools/testing/selftests/arm64/tags/.gitignore b/tools/testing/selftests/vm/tags/.gitignore
similarity index 100%
rename from tools/testing/selftests/arm64/tags/.gitignore
rename to tools/testing/selftests/vm/tags/.gitignore
diff --git a/tools/testing/selftests/arm64/tags/Makefile b/tools/testing/selftests/vm/tags/Makefile
similarity index 100%
rename from tools/testing/selftests/arm64/tags/Makefile
rename to tools/testing/selftests/vm/tags/Makefile
diff --git a/tools/testing/selftests/arm64/tags/run_tags_test.sh b/tools/testing/selftests/vm/tags/run_tags_test.sh
similarity index 100%
rename from tools/testing/selftests/arm64/tags/run_tags_test.sh
rename to tools/testing/selftests/vm/tags/run_tags_test.sh
diff --git a/tools/testing/selftests/vm/tags/tags_test.c b/tools/testing/selftests/vm/tags/tags_test.c
new file mode 100644
index 000000000000..c8486b6398b1
--- /dev/null
+++ b/tools/testing/selftests/vm/tags/tags_test.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <stdint.h>
+#include <sys/prctl.h>
+#include <sys/utsname.h>
+
+static int tag_bits;
+static int tag_offset;
+
+#define SHIFT_TAG(tag)		((uint64_t)(tag) << tag_offset)
+#define SET_TAG(ptr, tag)	(((uint64_t)(ptr) & ~SHIFT_TAG((1 << tag_bits) - 1)) \
+				| SHIFT_TAG(tag))
+
+static int max_tag_bits(void)
+{
+	int nr;
+
+	if (prctl(PR_GET_TAGGED_ADDR_CTRL, 0, 0, 0) < 0)
+		return 0;
+
+	if (prctl(PR_GET_TAGGED_ADDR_CTRL, &nr, 0, 0) < 0)
+		return 8; /* Assume ARM TBI */
+
+	return nr;
+}
+
+int main(void)
+{
+	static int tags_enabled;
+	unsigned long tag = 0;
+	struct utsname *ptr;
+	int err;
+
+	tag_bits = max_tag_bits();
+
+	if (tag_bits && !prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE,
+			       &tag_bits, &tag_offset, 0)) {
+		tags_enabled = 1;
+	} else if (tag_bits == 8 && !prctl(PR_SET_TAGGED_ADDR_CTRL,
+					   PR_TAGGED_ADDR_ENABLE, 0, 0)) {
+		/* ARM TBI with legacy interface*/
+		tags_enabled = 1;
+		tag_offset = 56;
+	}
+
+	ptr = (struct utsname *)malloc(sizeof(*ptr));
+	if (tags_enabled) {
+		tag = (1UL << tag_bits) - 1;
+		ptr = (struct utsname *)SET_TAG(ptr, tag);
+	}
+	err = uname(ptr);
+	printf("Sysname: %s\n", ptr->sysname);
+	free(ptr);
+
+	return err;
+}
-- 
2.25.1

