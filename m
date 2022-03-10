Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477C34D457E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 12:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbiCJLSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 06:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241563AbiCJLRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 06:17:47 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F10DBE1EB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 03:16:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0nCF/A7I5jQ8QB2lWFo/0ujvV4WkIQcMKSVkbwtiUIaWAKBq85WGqWsFu6M2LyR84ii3WkYqjOQZc+I3OxdrzCN9X+MHcXHL+bzAcUqMoCaTAgha8BxMHa/c5iT8kWKR28dFhg/yM26ZW2/1PLwkoYmnsFcJfMqGfLX78Gx3DSNJZuyW2FcvOUzu/ZCa2ZuX9VF0rdzPSBS2U77I5sQfpYcfwNGBkB+FIMIjg969zC3gl32IItkJhs+38p7urRZyvEo6ddZQfKy/DH/H2wy49DIEM6vWQ+73oy7asdwGUge8yWftpcSgXFAZO00VUzdTnamPiTPqCpj1jKmDQ+K1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFWi1O1bzOqLyHFf0gT/BNjKx4Kjm5hsOsFAWydQRTY=;
 b=gylIzh6QbxyzDBXpNnyx93xDmmMl7hLJYWN6nRsSRjjzCeeszm7E10vLHyCEBm632x3yPIPNZjoFiAP+GrdjRtdsc+yMAZvNpmHJDa2FrR43OQNaYwIiSq0BxZiPLejknbFdAnoXf191OKsTijdLIArmcDTVW8naL31ZeniibqMHv35BgKYRF7KkBk3+6DgVSzelYSuFafeJrU9KXvHB/Qp3tvJAWKMlVDlbpYle85APyBbGPnZ3Z3JO7yiNPitGKDsqhMw7NF7yLKCOW6R8GXMuH4biUk1EbX4ZNWuoFkKd8bCq3xWkTvlg16iBZKBqwANIMW1fTPmBhhKLcwWqGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFWi1O1bzOqLyHFf0gT/BNjKx4Kjm5hsOsFAWydQRTY=;
 b=ExzsUtUnwbj6c1RhgZrjtL8P3Bi4zFtIAoujK6eie3zcNJxdehhhyt9I61/41uSTDVExTVOo82NdenSGhaCEw+w68sTx82EpIzEA3Z6MAolH8+Ovp2DZfCjvDOjkOOJa2eEayvrhhEVQVxGIJOCQCA7fvceDilDy1WZ5Y84yR+M=
Received: from CO2PR04CA0160.namprd04.prod.outlook.com (2603:10b6:104:4::14)
 by BL1PR12MB5947.namprd12.prod.outlook.com (2603:10b6:208:39a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 11:16:40 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:4:cafe::35) by CO2PR04CA0160.outlook.office365.com
 (2603:10b6:104:4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.27 via Frontend
 Transport; Thu, 10 Mar 2022 11:16:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 11:16:39 +0000
Received: from BLR-5CG1133937.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 05:16:32 -0600
From:   Bharata B Rao <bharata@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <x86@kernel.org>,
        <kirill.shutemov@linux.intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>, <shuah@kernel.org>,
        <oleg@redhat.com>, <ananth.narayan@amd.com>,
        "Bharata B Rao" <bharata@amd.com>
Subject: [RFC PATCH v0 5/6] x86: Untag user pointers in access_ok()
Date:   Thu, 10 Mar 2022 16:45:44 +0530
Message-ID: <20220310111545.10852-6-bharata@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1f876cfd-bbff-4382-72cf-08da028772b4
X-MS-TrafficTypeDiagnostic: BL1PR12MB5947:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB594727E76F5D7D88356CBB1CB00B9@BL1PR12MB5947.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XTiV/uuAyzcyclK7GVgNwlU8GXrY0qAGoOGSQ5f/LBiG8l8PBLRyYMEZK4OgWoshXOsANYvAhvYR2+OfxAm2k6/Ke8up45waJsnriJDxZEsPAe2t6RVywbR7/digxvrPK/9uuDvoT7sAe27dpGyClgiHwqflMRlKhhyuZNSRKvdQ2uC1Jjs3ZTyCPFMSmgOSV4OvF9PSMaP30bX3zboMvAhhAFygRRO4Rigu7d27d9u1x/bOoB27iyVwntVasDimywqyxIpdkjL13ULZsbs5TRQV6Ap2Aas81f/g7jkg4gPOFZcz5uefrgdsLyU2+0z1Lp5dfuWyPriOzLLEr6MDutK8xuW2/EV7Z64RgCdU4+KM2R9C59Y4iKDb8KPiOuBd6+OOFGVAJ1Iq+zcG7ZaUfVM4rdwms/rluGI9RgWA8z4XxQfF7xuXI4VpmUc2hiEbyz1a0wGBDdDEEc6nrU0L8ionyMYife/5R3hBmEiE3Nl8SJ5KmZScnTRs+bXCDefAojT8clVBp7CRkY8dSQCFgVxfQNh3vMxAouY45LDgLb+Oi+GshFZwnZXSFL5M8k/yl0JzZ2tFO972pa+SA3a6jZbqfP48trxMMBY6My3ujt8GGfLYRXLa1sJ7SnCaQCrRIU2g2y7ZdG6lQFqGjUxCai3SX3BgC/9vkUAszq1d9eM8t9ne47XvGHJngVSypKQjilECZLZ8Zl4Gh1WSnIJn3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(70586007)(2906002)(70206006)(8676002)(4326008)(82310400004)(356005)(81166007)(54906003)(40460700003)(6916009)(8936002)(5660300002)(7416002)(47076005)(7696005)(508600001)(36860700001)(316002)(86362001)(16526019)(186003)(26005)(36756003)(426003)(336012)(83380400001)(1076003)(6666004)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 11:16:39.2740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f876cfd-bbff-4382-72cf-08da028772b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5947
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparatory work to allow passing of tagged user
pointers (with a top few bits other than zeroes) as syscall
arguments.

Since user can provide tagged pointer to syscalls they need
to be untagged before validating them in access_ok().
Untagging is done only if flag TIF_TAGGED_ADDR is set for
the thread. This is set via prctl() option which will be
introduced in a subsequent patch.

get_user() and put_user() don't use access_ok(), but check
access against TASK_SIZE direcly in assembly. Strip tags,
before calling into the assembly helper.

[kirill.shutemov@linux.intel.com - get/put_user() changes]

Signed-off-by: Bharata B Rao <bharata@amd.com>
---
 arch/x86/include/asm/thread_info.h |  2 ++
 arch/x86/include/asm/uaccess.h     | 28 +++++++++++++++++++++-------
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index ebec69c35e95..c786103a5325 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -101,6 +101,7 @@ struct thread_info {
 #define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
 #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
 #define TIF_ADDR32		29	/* 32-bit address space on 64 bits */
+#define TIF_TAGGED_ADDR		30	/* Allow tagged user addresses */
 
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
@@ -124,6 +125,7 @@ struct thread_info {
 #define _TIF_BLOCKSTEP		(1 << TIF_BLOCKSTEP)
 #define _TIF_LAZY_MMU_UPDATES	(1 << TIF_LAZY_MMU_UPDATES)
 #define _TIF_ADDR32		(1 << TIF_ADDR32)
+#define _TIF_TAGGED_ADDR	(1 << TIF_TAGGED_ADDR)
 
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW_BASE					\
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index ac96f9b2d64b..feb2e21c7e09 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -35,11 +35,15 @@ static inline bool __chk_range_not_ok(unsigned long addr, unsigned long size, un
 	return unlikely(addr > limit);
 }
 
-#define __range_not_ok(addr, size, limit)				\
-({									\
-	__chk_user_ptr(addr);						\
-	__chk_range_not_ok((unsigned long __force)(addr), size, limit); \
-})
+static inline bool __range_not_ok(const void __user *addr, unsigned long size,
+				  unsigned long limit)
+{
+	if (test_thread_flag(TIF_TAGGED_ADDR))
+		addr = untagged_addr(addr);
+
+	__chk_user_ptr(addr);
+	return __chk_range_not_ok((unsigned long __force)(addr), size, limit);
+}
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 static inline bool pagefault_disabled(void);
@@ -152,7 +156,12 @@ extern int __get_user_bad(void);
  * Return: zero on success, or -EFAULT on error.
  * On error, the variable @x is set to zero.
  */
-#define get_user(x,ptr) ({ might_fault(); do_get_user_call(get_user,x,ptr); })
+#define get_user(x,ptr)							\
+({									\
+	__typeof__(*(ptr)) *ptr_untagged = untagged_ptr(ptr);		\
+	might_fault();							\
+	do_get_user_call(get_user,x,ptr_untagged);			\
+})
 
 /**
  * __get_user - Get a simple variable from user space, with less checking.
@@ -249,7 +258,12 @@ extern void __put_user_nocheck_8(void);
  *
  * Return: zero on success, or -EFAULT on error.
  */
-#define put_user(x, ptr) ({ might_fault(); do_put_user_call(put_user,x,ptr); })
+#define put_user(x, ptr)						\
+({									\
+	__typeof__(*(ptr)) *ptr_untagged = untagged_ptr(ptr);		\
+	might_fault();							\
+	do_put_user_call(put_user,x,ptr_untagged);			\
+})
 
 /**
  * __put_user - Write a simple value into user space, with less checking.
-- 
2.25.1

