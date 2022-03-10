Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1FB4D4580
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 12:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241578AbiCJLSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 06:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241593AbiCJLRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 06:17:54 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D70141E1E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 03:16:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdS0rd7JEURGAQWdz8jzvqalPkzITeIhmceeHkuyyEn1zAj6MzFaVWZrqOAqXDi5+M6PdvROzhXMeWwoE12TrDtr5Q541uCg0acY2pDiwg6XTxEF5OrttMeZ+D1n/n3CqkZyh5Ga/orb/DDPFlqB9mz/0YAXNcNHQnEfrTQvkK/lZfZFkVUyhIqE2ZTUOfLJ5KBtEqX55ehyelTyvm7S+CTqA+7XdDe/L+yJNOHc8Cin05+HMtlaW1U5eDtl2Psq85wd0cNWcLCLyhyGmK1RdTtjrTkZ6cQldFfnIYwco+PvS4CNtuGPtL3HSxByPNXk/vgzOmYAe84vEGmjftpcNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rfYUlsXYPJNu5slNzpLm+592cDa0WcESV4Wg5wtHZk=;
 b=MYKORmd6FmRA2MejJGvfKhKPGrS3/ev3s3axqWclFO4N2Sazz8HCmmwSBS2XNLe9DG/uKJMkIB2EcxXjY0ck/DxkL6hlruGDCkQljHcn33jlySPIm+zS1Q4w+YRO5mY1UGosxlQaeWYZIWxrmz8TiqYHlhbIy1LjulhSRlxwTu4syU2ukpnz+it7/hUo2j3LZTDU/x2lJPcdl2SoNJh73e9wlYc+ZFlnFyGcQPrZbEaE5nXv5OFTHbAYhV3TtBABszS0LMjoGrBvBppGIlWfTvb8UtbJ9WwG5SK996U1qNvEKdmSyoS95CpOeeUBMUbtaboUlMQNUBqRBM2gkKZc+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rfYUlsXYPJNu5slNzpLm+592cDa0WcESV4Wg5wtHZk=;
 b=qtKqSnBDTLa22tagngmj0PRNplB/2FPofd0RTA2GLuKVcP7vdi7zBCpMTLEHEBNx48sq+sctOgoMvQUiFTL9mngQowIsz/z/ydSRK9LMQyvcX66CD1d6o+IDRHXIjcfhDpNGUMRSDeUcaIicVum4f6Zue2+CTY5VzZxwu90xnxM=
Received: from MW4PR03CA0114.namprd03.prod.outlook.com (2603:10b6:303:b7::29)
 by DM6PR12MB3643.namprd12.prod.outlook.com (2603:10b6:5:3d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Thu, 10 Mar
 2022 11:16:45 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::bc) by MW4PR03CA0114.outlook.office365.com
 (2603:10b6:303:b7::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Thu, 10 Mar 2022 11:16:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 11:16:44 +0000
Received: from BLR-5CG1133937.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 05:16:38 -0600
From:   Bharata B Rao <bharata@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <x86@kernel.org>,
        <kirill.shutemov@linux.intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>, <shuah@kernel.org>,
        <oleg@redhat.com>, <ananth.narayan@amd.com>,
        "Bharata B Rao" <bharata@amd.com>
Subject: [RFC PATCH v0 6/6] x86: Add prctl() options to control tagged user addresses ABI
Date:   Thu, 10 Mar 2022 16:45:45 +0530
Message-ID: <20220310111545.10852-7-bharata@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 54ad381d-831f-48d6-562f-08da028775d8
X-MS-TrafficTypeDiagnostic: DM6PR12MB3643:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3643A400128C39341FEC1B75B00B9@DM6PR12MB3643.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kbcvRvV/lmgpXlu27R1XgpN84sc7HI3qrJYbNg30Ht35PJ8A7rf7i+OnKrVtoMxtV13gqtLpxeJGqrbzWg+ApeD+RwVKeplD4ypIFvVCa6Np1WRcgwUjbG0gLrWIGrADxq7KfSkKC60DLTlRVBqV1tujOjunRUlmc8ofbSRHAXzyU6TBUJYsfppexRwvQFgHztz6o7fjLLzmvZ0ixnaezRbY9yv8IMLdLKxUnvww7oZZioRerF80kuVV1xppLpCwDznAklKdA848s3MMBGt3XfAa0fz3UQgM7xF2uXofMEI4b/6mfbzoT2QpHb6g4F9Sn9HnrD/7sw0c1gkVuxK+2QZ+JXabYjQZjTxWnCBMzkbPb2scfG+2YFg/PrJotyjFNrHh75uXUWgkvnNP1fsp6JNKWuIP4yW9j5iqoVwg9YFErf0RAtcGfoicBSOfVW9gTDw/M8zi/D6OpmTKN3piWzgoTxhQda5gqYF1b0cOzcWJmpOWP2KbGUXwsM/DvFL0kZeDWp4U6YcU5KHNdKhvgWSgcsKCDXRdu28GA/huuURULJwNhDyhYASPqhQ4+tonoTnpIt4n83bar+XvCNR8uguDVpLae1BR1lxcv8nG198imbURcCSbD0BjC7ToZnrqHx8GH4+zpQX/WF3VuljEZzCJXD8J/V8Rvszv0jy3iRkb0kTHiljSsNBhNOIcjmIrfy7ZB/wOCpYMmIstDk3Cdg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(6916009)(81166007)(426003)(54906003)(1076003)(70206006)(8676002)(5660300002)(70586007)(356005)(2906002)(40460700003)(83380400001)(316002)(47076005)(36756003)(2616005)(336012)(7416002)(86362001)(16526019)(26005)(82310400004)(8936002)(186003)(4326008)(7696005)(6666004)(508600001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 11:16:44.5424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ad381d-831f-48d6-562f-08da028775d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3643
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide an option for applications to opt-in for a relaxed
tagged ABI via prtcl(). This allows them to pass tagged addresses
to syscalls as pointer arguments.

The implementation is kept separate for AMD UAI as the equivalent
implementation for Intel LAM is likely to be different.

Signed-off-by: Bharata B Rao <bharata@amd.com>
---
 arch/x86/Kconfig                 |   9 +++
 arch/x86/include/asm/processor.h |  12 +++
 arch/x86/include/asm/uaccess.h   |   3 +-
 arch/x86/kernel/process.c        | 134 +++++++++++++++++++++++++++++++
 4 files changed, 157 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9f5bd41bf660..b73414eb1c01 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2436,6 +2436,15 @@ config STRICT_SIGALTSTACK_SIZE
 
 source "kernel/livepatch/Kconfig"
 
+config X86_TAGGED_ADDR_ABI
+	bool "Enable the tagged user addresses syscall ABI"
+	depends on X86_64 && CPU_SUP_AMD
+	default y
+	help
+	  When this option is enabled, user applications can opt-in to a
+	  relaxed ABI via prctl() allowing tagged addresses to be passed
+	  to system calls as pointer arguments.
+
 endmenu
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 2c5f12ae7d04..414e2c039c34 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -863,4 +863,16 @@ bool arch_is_platform_page(u64 paddr);
 #define arch_is_platform_page arch_is_platform_page
 #endif
 
+#ifdef CONFIG_X86_TAGGED_ADDR_ABI
+/* PR_{SET,GET}_TAGGED_ADDR_CTRL prctl */
+long set_tagged_addr_ctrl(struct task_struct *task, unsigned long flags,
+			  int __user *nr_bits, int __user *offset);
+long get_tagged_addr_ctrl(struct task_struct *task,
+			  int __user *nr_bits, int __user *offset);
+#define SET_TAGGED_ADDR_CTRL(flags, nr_bits, offset)	\
+	set_tagged_addr_ctrl(current, flags, nr_bits, offset)
+#define GET_TAGGED_ADDR_CTRL(nr_bits, offset)		\
+	get_tagged_addr_ctrl(current, nr_bits, offset)
+#endif
+
 #endif /* _ASM_X86_PROCESSOR_H */
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index feb2e21c7e09..e415523dc425 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -38,7 +38,8 @@ static inline bool __chk_range_not_ok(unsigned long addr, unsigned long size, un
 static inline bool __range_not_ok(const void __user *addr, unsigned long size,
 				  unsigned long limit)
 {
-	if (test_thread_flag(TIF_TAGGED_ADDR))
+	if (IS_ENABLED(CONFIG_X86_TAGGED_ADDR_ABI) &&
+	    (current->flags & PF_KTHREAD || test_thread_flag(TIF_TAGGED_ADDR)))
 		addr = untagged_addr(addr);
 
 	__chk_user_ptr(addr);
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 81d8ef036637..2bc44efdd994 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -26,6 +26,7 @@
 #include <linux/elf-randomize.h>
 #include <trace/events/power.h>
 #include <linux/hw_breakpoint.h>
+#include <linux/sysctl.h>
 #include <asm/cpu.h>
 #include <asm/apic.h>
 #include <linux/uaccess.h>
@@ -231,6 +232,12 @@ static void pkru_flush_thread(void)
 	pkru_write_default();
 }
 
+static void flush_tagged_addr_state(void)
+{
+	if (IS_ENABLED(CONFIG_X86_TAGGED_ADDR_ABI))
+		clear_thread_flag(TIF_TAGGED_ADDR);
+}
+
 void flush_thread(void)
 {
 	struct task_struct *tsk = current;
@@ -240,6 +247,7 @@ void flush_thread(void)
 
 	fpu_flush_thread();
 	pkru_flush_thread();
+	flush_tagged_addr_state();
 }
 
 void disable_TSC(void)
@@ -1000,3 +1008,129 @@ long do_arch_prctl_common(struct task_struct *task, int option,
 
 	return -EINVAL;
 }
+
+#ifdef CONFIG_X86_TAGGED_ADDR_ABI
+/*
+ * Control the relaxed ABI allowing tagged user addresses into the kernel.
+ */
+static unsigned int tagged_addr_disabled;
+
+#ifdef CONFIG_CPU_SUP_AMD
+#define UAI_TAG_BITS	7
+
+static long amd_set_tagged_addr_ctrl(unsigned long flags, int __user *nr_bits,
+				     int __user *offset)
+{
+	int val;
+
+	if (!boot_cpu_has(X86_FEATURE_UAI))
+		return -EINVAL;
+
+	/* Disable tagging */
+	if (!(flags & PR_TAGGED_ADDR_ENABLE)) {
+		clear_thread_flag(TIF_TAGGED_ADDR);
+		return 0;
+	}
+
+	if (!nr_bits || !offset)
+		return -EINVAL;
+
+	/*
+	 * Do not allow the enabling of the tagged address ABI if globally
+	 * disabled via sysctl abi.tagged_addr_disabled.
+	 */
+	if (tagged_addr_disabled)
+		return -EINVAL;
+
+	if (get_user(val, nr_bits))
+		return -EFAULT;
+
+	if (val != UAI_TAG_BITS)
+		return -EINVAL;
+
+	if (put_user(val, nr_bits) || put_user(64 - val, offset))
+		return -EFAULT;
+
+	set_thread_flag(TIF_TAGGED_ADDR);
+	return 0;
+}
+
+static long amd_get_tagged_addr_ctrl(int __user *nr_bits, int __user *offset)
+{
+	long ret = 0;
+
+	if (!boot_cpu_has(X86_FEATURE_UAI))
+		return -EINVAL;
+
+	if (test_thread_flag(TIF_TAGGED_ADDR)) {
+		if (nr_bits && put_user(UAI_TAG_BITS, nr_bits))
+			return -EFAULT;
+		if (offset && put_user(64 - UAI_TAG_BITS, offset))
+			return -EFAULT;
+		ret = PR_TAGGED_ADDR_ENABLE;
+	} else {
+		/* Report max tag size */
+		if (nr_bits && put_user(UAI_TAG_BITS, nr_bits))
+			return -EFAULT;
+	}
+	return ret;
+}
+#endif
+
+long set_tagged_addr_ctrl(struct task_struct *task, unsigned long flags,
+			  int __user *nr_bits, int __user *offset)
+{
+	unsigned long valid_mask = PR_TAGGED_ADDR_ENABLE;
+
+	if (in_32bit_syscall())
+		return -EINVAL;
+
+	if (flags & ~valid_mask)
+		return -EINVAL;
+
+	if (IS_ENABLED(CONFIG_CPU_SUP_AMD))
+		return amd_set_tagged_addr_ctrl(flags, nr_bits, offset);
+	else
+		return -EINVAL;
+}
+
+long get_tagged_addr_ctrl(struct task_struct *task,
+			  int __user *nr_bits, int __user *offset)
+{
+
+	if (in_32bit_syscall())
+		return -EINVAL;
+
+	if (IS_ENABLED(CONFIG_CPU_SUP_AMD))
+		return amd_get_tagged_addr_ctrl(nr_bits, offset);
+	else
+		return -EINVAL;
+}
+
+/*
+ * Global sysctl to disable the tagged user addresses support. This control
+ * only prevents the tagged address ABI enabling via prctl() and does not
+ * disable it for tasks that already opted in to the relaxed ABI.
+ */
+static struct ctl_table tagged_addr_sysctl_table[] = {
+	{
+		.procname	= "tagged_addr_disabled",
+		.mode		= 0644,
+		.data		= &tagged_addr_disabled,
+		.maxlen		= sizeof(int),
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+	{ }
+};
+
+static int __init tagged_addr_init(void)
+{
+	if (!register_sysctl("abi", tagged_addr_sysctl_table))
+		return -EINVAL;
+	return 0;
+}
+
+core_initcall(tagged_addr_init);
+#endif	/* CONFIG_X86_TAGGED_ADDR_ABI */
-- 
2.25.1

