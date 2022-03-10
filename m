Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED284D457A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 12:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241545AbiCJLRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 06:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241574AbiCJLRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 06:17:39 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2072.outbound.protection.outlook.com [40.107.212.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE20141FC5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 03:16:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZ0eQYGlCBLRC2bjhHg69PnXEBYHNwu/AGtTtiSt3iCraKZFv6xn2Kvp8raGkkbM2wQZTZvxmlTgZ3J+RHLVLtUU6/MH6+WcaaMCqNmqPah18yfAZXaRQfNAFhKj8tIWvfundWu3yAF9Q10D7hwuPW/Jc0+Q3Pu+GPXSVjEYqV9sDm/gXp2JKh5M72las9+JOs9Q3vtcbloiKVywxmudjQ1d3d1CLJ14dd1NxnQ9KvzMjJ5zk/g5salUZq7KR58omVmHBgYuiSdGgTfXNbgUOeWH9x5sc9sGozok1UcOwlX8WlReeNh6dtmbHrPfsFyKXSOc9uQXybOTVNPyjwvC+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYLRfgxtKoZIiXg2eWMGLkEDmmehjVWD4/SeCQnWfcU=;
 b=d5btnERBnD3CLF0IDBUu5p3UkTGQTtTzTQPS12kXDmXMs0/DXO6MOqpZ7i1cgv0gxRmCZTqsqN37VJg/AjrJO9p0MtD9nC0wW6Qb46UbHt8Q6a41L2LlQPjF04tSQcKHmkJOH5fmSRkiL5aC+E51vU9/sufG2t33j9eRo/J8XSUfIUQvBD0C/oxZ1Kt0I9gWzSBAMWmCVp8U+R2uGyLrVX/N5BAZgDm/VTwAomFRzt2OnV4PSsHKzSnhtWXEyEnrONxWbSeAPDW8CYEdAtbAxN0f6rM1c31vGWYRyjinbG9sM6/17aWTLbaJsKMzTZ2QaCAGyCxvNvWXAiGgpaQ4pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYLRfgxtKoZIiXg2eWMGLkEDmmehjVWD4/SeCQnWfcU=;
 b=tTaad1dlBuAjS0CB5PUrNsYPvbKhuW+Q3t+daGogC4aVSpmFazZtrhUOPmMc+fuRKPpzFruvITQjy+CofUYRc7atcjwL1NzCQ+659qzROR4mvQj2NO6CP4orL1TTW2h13ndN+ZLs6P8n3lukTxAX5P7Gp0ho1uFxNFLXwM7CeMY=
Received: from MW4PR04CA0170.namprd04.prod.outlook.com (2603:10b6:303:85::25)
 by MWHPR1201MB0157.namprd12.prod.outlook.com (2603:10b6:301:55::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Thu, 10 Mar
 2022 11:16:34 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::ee) by MW4PR04CA0170.outlook.office365.com
 (2603:10b6:303:85::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.20 via Frontend
 Transport; Thu, 10 Mar 2022 11:16:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 11:16:34 +0000
Received: from BLR-5CG1133937.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 05:16:26 -0600
From:   Bharata B Rao <bharata@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <x86@kernel.org>,
        <kirill.shutemov@linux.intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>, <shuah@kernel.org>,
        <oleg@redhat.com>, <ananth.narayan@amd.com>,
        "Bharata B Rao" <bharata@amd.com>
Subject: [RFC PATCH v0 4/6] x86: Provide an implementation of untagged_addr()
Date:   Thu, 10 Mar 2022 16:45:43 +0530
Message-ID: <20220310111545.10852-5-bharata@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: e35e95ad-af4b-429d-3d30-08da02876f90
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0157:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0157AA00C14ABB6611C7B946B00B9@MWHPR1201MB0157.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ve9KRyIQnSjG675v3UcG5cQU2a6JcX7T/qqrWtpyxX6d62atj2wK6aXOTYxBulZcT1PtyqMgLAGSAThjwEh6ikZH2eV6/S2dN08BhmoaipiZ0gCGFGHsjBxgJqGu/kcssqXUrevOALrTiR+sdgeX+P5mhRppzsGwFL6bHLrtmOGTMIZ1RScjlZOH6qingVVJMxQZgfMR8CzVr87CLud6sEf1zj5dW4TTrMi7Ikx3Uo92MNeozGqi/LAeplqNsJvrMjtk2RoGp/2VFj3BEGuE1+dyp9xXeoHDtn9Adj0dvKPxeltXZruq8TeLsoQ0qspaxR52qaqdqmVsPRwyFA4fIq9rOdhERsBv4SNke2Q997M9vAdWUleNi7rNXydbq90WrVg41KZmN/XwOIEuZG8nWgFcrFVZUjcLdS58zmuw9bheXCPFTRVkdSddd9V+dA+cAs6s0gwhIolgmMUGFWrhktdVVW/cDxtjsxofp7okGiC5eOxtCxivk+IOmCoOGecy3xAND4lkk+VJ8QGdlM4gJfupmaX1N4qL6onhl4YX8+F9Vl8ssKwkEgV/6Z29mUkAuAK0tzuHlHeUdAxwxJjHUMhX5H4MTdn48d3jMOJp0fqNxmB90CLQPBCxOOVTbafQwYoLYHQsJ5HvMXQkUBK3/my6KGAF7KxQv79M6vmPa3dwTIwXlbFZsfrObsEm50xALSwuTdYD3TSCCbjKKwAKFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(316002)(2616005)(426003)(336012)(186003)(81166007)(16526019)(26005)(1076003)(36860700001)(83380400001)(86362001)(356005)(40460700003)(47076005)(82310400004)(6916009)(54906003)(36756003)(2906002)(5660300002)(7416002)(8936002)(70586007)(70206006)(4326008)(8676002)(7696005)(6666004)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 11:16:34.0035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e35e95ad-af4b-429d-3d30-08da02876f90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0157
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

untagged_addr() will be used by core mm routines to remove
the tag bits and convert the address to canonical form.

Limit the implementation to AMD CPUs as Intel's version
of the same is likely to be different.

Signed-off-by: Bharata B Rao <bharata@amd.com>
---
 arch/x86/include/asm/page_32.h |  3 +++
 arch/x86/include/asm/page_64.h | 26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/x86/include/asm/page_32.h b/arch/x86/include/asm/page_32.h
index df42f8aa99e4..8309aa987354 100644
--- a/arch/x86/include/asm/page_32.h
+++ b/arch/x86/include/asm/page_32.h
@@ -30,6 +30,9 @@ static inline void copy_page(void *to, void *from)
 {
 	memcpy(to, from, PAGE_SIZE);
 }
+
+#define untagged_addr(addr)	(addr)
+#define untagged_ptr(ptr)	(ptr)
 #endif	/* !__ASSEMBLY__ */
 
 #endif /* _ASM_X86_PAGE_32_H */
diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index e9c86299b835..41d4a729e783 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -90,6 +90,32 @@ static __always_inline unsigned long task_size_max(void)
 }
 #endif	/* CONFIG_X86_5LEVEL */
 
+#ifdef CONFIG_CPU_SUP_AMD
+/*
+ * Tag bits are in same position [63:57] for both 4 and 5 level page
+ * tables. For both the cases we sign-extend from 56th bit since
+ * bits [56:48] are anyway expected to be canonical for 4 level page tables.
+ */
+#define __untagged_addr(addr)	\
+	((__force __typeof__(addr))sign_extend64((__force u64)(addr), 56))
+
+#define untagged_addr(addr)	({					\
+	u64 __addr = (__force u64)(addr);				\
+	__addr &= __untagged_addr(__addr);				\
+	(__force __typeof__(addr))__addr;				\
+})
+
+#define untagged_ptr(ptr)	({					\
+	u64 __ptrval = (__force u64)(ptr);				\
+	__ptrval = untagged_addr(__ptrval);				\
+	(__force __typeof__(*(ptr)) *)__ptrval;				\
+})
+
+#else
+#define untagged_addr(addr)	(addr)
+#define untagged_ptr(ptr)	(ptr)
+#endif
+
 #endif	/* !__ASSEMBLY__ */
 
 #ifdef CONFIG_X86_VSYSCALL_EMULATION
-- 
2.25.1

