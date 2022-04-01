Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C774EE62E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 04:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244175AbiDACpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 22:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbiDACp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 22:45:27 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2064.outbound.protection.outlook.com [40.107.255.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EB813F8DF
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 19:43:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Le/8xqEglvE/PedpztSlb15L5bIjW0RztcyLYJlCBXSOlWda1lMzLzAif3oPAQXBgG83OkzHAAWXWEx+t6vQYvcMVRu/rPbTynrmzliABvLlbe743GwwRnVSkNu5K1KCsUiUF83C479FRlUqhjNUCHITYpLH1lCDeljMktztsyZreDKDyciu6FIrcy2hOYR1OLxpriu3gEa2JSDy3ZFYirmBdkqBphtUMDhJO6Zy6zcy1NxCvCWeeE646M0udfFGMRp9y7M7Fz0z/3mmC6H4xVIbwpnnpT3NOSyS0p3vGpLYfuPpCQfAIIAekYHzcyWw5E1BXstbJXR/sN9iwvKFVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nh+Jk8UbGRHOv2ZMhzYZG7dD2fF/TU29e8UnBQl04fo=;
 b=PxPNrVv1gO37CMOL1epuVyU8tkJ4c/ibFbfp/dhccZtU6exggzn089bHzgkFAor4RsTru1eV8VKexOoAnSSYRm8FwI1okmWhr+toYEw505WK25NWHq3V+OVpwrlkluOOTOBuHPtxp8jvAsmcB/ng8z3QZW+GvcvOf3w+fY0jxYQtOA0spiZG+OlsDeWKP0aPzhNgaZGCWa+BihiVQk8g6auYm1Ft2EHCGnenRx0hfyh3KAwBxjX9XZ9MkjjDMLd7xKKs6fPXiX6anUaZwf6afZyqcn5Ggm+qGcK/zAuf585c1EvYznRbQvA14Ftyq6Y0sSt34zz6TFoo0E0oVCa7sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nh+Jk8UbGRHOv2ZMhzYZG7dD2fF/TU29e8UnBQl04fo=;
 b=XSTDFFJh6eNQpR6IoklMWAMgcuFI86YbwT0cubL6gOn69o71F9m3YPkrAlUsA6cJxgAfoeLbIPf4LY6W8gO9H3GrPJY6yYtoWMrO4OKvQp1hyEqYjRdGER3+YlXS6akgn1hWXbfCc0ZDoshrCsrNapjpI/aMESQYnbXOZ3oT53I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB5379.apcprd02.prod.outlook.com (2603:1096:4:177::10)
 by PSBPR02MB4408.apcprd02.prod.outlook.com (2603:1096:301:a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.25; Fri, 1 Apr
 2022 02:43:34 +0000
Received: from SG2PR02MB5379.apcprd02.prod.outlook.com
 ([fe80::84ba:7c96:f19f:85ec]) by SG2PR02MB5379.apcprd02.prod.outlook.com
 ([fe80::84ba:7c96:f19f:85ec%6]) with mapi id 15.20.5123.025; Fri, 1 Apr 2022
 02:43:34 +0000
From:   Chuanhua Han <hanchuanhua@oppo.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     alexandre.ghiti@canonical.com, jszhang@kernel.org,
        mhiramat@kernel.org, akpm@linux-foundation.org,
        zhengqi.arch@bytedance.com, ebiederm@xmission.com,
        liushixin2@huawei.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Chuanhua Han <hanchuanhua@oppo.com>
Subject: [PATCH v4] riscv: mm: Remove the copy operation of pmd
Date:   Thu, 31 Mar 2022 19:43:20 -0700
Message-Id: <20220401024320.98510-1-hanchuanhua@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0030.apcprd06.prod.outlook.com
 (2603:1096:404:2e::18) To SG2PR02MB5379.apcprd02.prod.outlook.com
 (2603:1096:4:177::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1cc67ef-1a28-43e6-b097-08da13896a1f
X-MS-TrafficTypeDiagnostic: PSBPR02MB4408:EE_
X-Microsoft-Antispam-PRVS: <PSBPR02MB4408962BBBD6A121B2232E0ADFE09@PSBPR02MB4408.apcprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z88OophW7l44OR1zR0nLwyMQjzdmdrbB2chepbxz9wqry5m7kI+OD9TCzTb17nuO7eNhSjLUzvDVy4eEco6+qlcZN/ZykFpwz8BCHJx1RB/8wNdVoMxkazGzxhybhNsvN020hqWY0pnkds4Q6YCw4PGHXrahkQKaHgipXKJzpEAqe443wVcUawf7UK68ZHGF+6YifE9Kh4K0CMC4AwIZsKEDrYzKkWjViOUYRr0ipjkn9hlyNSpXhMwnVeXNjMt4dcOEt+lK6r2TwgvwFutowMgmZtVlsTGaCbTuWtUg1Oa8iKc/1dR9nnoa8oy0nd8JH5oFXjxQ3q7e2TZzoIyGLZ6GJJERq0CwuINxIa4Bwsd0rWTOYawjp2t+g28cSNw/d/xwtDXOOPKwEUpuepQ1UurPMPDrN7Rb7+oDTQgaYkGxGK7odhTgwvpgQqEXv5YbJFHZgJs3jJ6Ko3HaV2D9Zgb5qhP9BbcElUR1BjAYPQJ8qU77kkcIY6AEqmsUNtdTX1Z2c5DSlj7hoVddY/NzRNM3JFEuGGqIivfF2GruA8IhyDCsv+RjwnGCSvf1LQ8g5pNceGJYUJgU0C6yGrlQSmdPfvSRfbUGnvA/5XKXSKTB6Sbd9CU2Yz6EhNELYAF/5U4WtXRMXAF7NI1aUj5HUh5Z3n2mDwNO1/x3WwrPRmEuUsxiJ43F9YHvFQllPTpG2lRPgac8V3E1x4V0Rf+v6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR02MB5379.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52116002)(6512007)(8936002)(83380400001)(6506007)(6666004)(2616005)(1076003)(186003)(8676002)(107886003)(38100700002)(26005)(38350700002)(86362001)(5660300002)(7416002)(6486002)(36756003)(66476007)(2906002)(66556008)(66946007)(508600001)(316002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B83byt4q5dRf5B5G8PcUgozCNYHUWgfVNSXPSyhMrguS22M5C96ovV6Cj7Dq?=
 =?us-ascii?Q?+/F3N+zHXEVwXmRLlMi6ri4wrMeIfsrzUABey3lhfTZ13ixnL0qrymG31B24?=
 =?us-ascii?Q?3vxoyQfMTadER+RAZ2Llq7FJZgcHRQYdmNGt8ySLeyxyeBfitAj8hC+5VE9w?=
 =?us-ascii?Q?te9y3ET/dH/vFkpqTG2cMLQxvx/XGUI2YomsE+bbG4Zxl8F3EVGMUw1Gw+Fg?=
 =?us-ascii?Q?ESvnrnOrM/ZR9noi2t4n1jsArkmkduqAswf0HL7l+LWG921gjM4gmRP+F5rX?=
 =?us-ascii?Q?QgYOYFezCOK1GLZNYp9aLW/PHMgBxvpDdMAunzOYp6YnS18GNYHCJSg1ThRo?=
 =?us-ascii?Q?6SnG9+SawWQhw2Pqz0qJMWZU5n43CGfX8xuvOBzbEWPFmUwJDxogMvd+NoOI?=
 =?us-ascii?Q?3PBvP1T4Sq3KMGyiWiM6vWLvoA4sZ8u/bB3bZ4OzsR1NBx8wtT9Ixd203sY9?=
 =?us-ascii?Q?GCJBSscM5K2GpctMnTRTWtQbajo1SubO6gGGxFtAZsoWwTut4Hq+7pVjuYi8?=
 =?us-ascii?Q?ePdUt37mZB5PWkN2iRXN3YwEQNoNDpCpNsbHILcNqvstM+8H++/NgfahLSvh?=
 =?us-ascii?Q?LZUuR4n3zYsrFzAmNb1tmk3jSlFeLuxVAFfDHOZWAVQibpJLk5L3UA3CZ5bX?=
 =?us-ascii?Q?uY9ZWuaTBnJeCjfedZCFd97Wv8ctp8yHZpoYhD/i81ps/elM1vEPri08UHh0?=
 =?us-ascii?Q?UvZc9uhHdA9KnrFcNPiiofqGheoIrQquuC6GhhuBEyz+5X8+7X4+J6M+08cu?=
 =?us-ascii?Q?lr01qZlzs4JfXxdtQKeJ/v+NK6gzpr0U5cNw/N54UOdxVeUrzUQiyPI9Z4kO?=
 =?us-ascii?Q?EfPuP2XJfpHY9u9lBBHyVob2RZIfIWlFxvxBrUj6bfBcH6ZMh34hY+LfdSAv?=
 =?us-ascii?Q?6OmN7ogFNlzTZFMDQrrHRdncIIDIAaDTQ7tjTV6fuNGjzryaXifQJA/fOsgW?=
 =?us-ascii?Q?Nn18mjkLWLkcCa0FVhgOtARqvYHq/PqxQZ/8gRPbd2ykQqVCdqhBTIvuwcvN?=
 =?us-ascii?Q?hPcHvWh+BiY1OhQZGQmabONDrxYiT7AeaNPGuzEYFCefR2NiKiFS6gLdUXp0?=
 =?us-ascii?Q?aXXVwaJ8A/mbn7sfX8SDa3z63+d41UCcdYVwKn6qbx8DANNRx2tISt+K/lRk?=
 =?us-ascii?Q?mWvzMhVrU/G5HGm4OXULxwvBKXVXw/TwwhU5YRyLOCCr+SpzTuzEgsOF//zh?=
 =?us-ascii?Q?fLUGliz8HOZ4v589u0RUh2N+QMCqJ0s3nRLum4h0HtwSCvYBF7+hKylu2dos?=
 =?us-ascii?Q?ATaX/dI96zwvyRmKnkdMLRVNi3gXxyzMaJUfOZCA3oNWmYPTZzP+MBvBCutF?=
 =?us-ascii?Q?QZWNUJuvZvSSjQMRqRULXJUeM+Vr7oLFmwhAlHuKQvSxl2UTt6jDRrRH2OLS?=
 =?us-ascii?Q?k3kLiLiRPxBFv8LSM3CtCKvSGb/WMIt4o0o3voeQTlf3MCCq8pYfiQSzTS4T?=
 =?us-ascii?Q?WJswIMQT0WmOF5NoKzRq7kilD3lVZl/NncXwadvq6eph3YojSwYVfkcrVMsS?=
 =?us-ascii?Q?na3x0m7rSgTHXl3Lkdqc28YFZ8qJ16eMuW8YZF+8bTgT9PHF3aO6AWulPtcK?=
 =?us-ascii?Q?5fuTuL+JWO87ldgYPOgd48O5BXa9G3SNlmHhK/Ri7u2jWOtYK+VIQP7UZB1l?=
 =?us-ascii?Q?kvUvih2mN9B16OFYwdzu8iFZ7xJaadvmhLVVOtieWliP1SZMGiwkiNQAnLzx?=
 =?us-ascii?Q?TLVwin7rLfrZ6qHpf7jJIPYPZtu8/teb/aeN24B51FQ2WYK4ue8OK1ogZb+j?=
 =?us-ascii?Q?WgwFjkxoXOny+7/b8QAtKj9BALGTM/8=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1cc67ef-1a28-43e6-b097-08da13896a1f
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB5379.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 02:43:33.9985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDq4MuSJ1o7YbSlWu89d3xEXtfx7U+0jOkHfINSlalZovUknuWouPGfTcAKAaKy6f2nKaMvRWsOT0p61BO/5VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSBPR02MB4408
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since all processes share the kernel address space,
we only need to copy pgd in case of a vmalloc page
fault exception, the other levels of page tables are
shared, so the operation of copying pmd is unnecessary.

Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
---
Changes in v4:
  -Modify incorrect author name.

Changes in v3:
  -Change the real name of signed-off-by.

Changes in v2:
  -Delete incorrect default signatures.


 arch/riscv/mm/fault.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 4e9efbe46d5f..40694f0cab9e 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -102,9 +102,9 @@ static inline void bad_area(struct pt_regs *regs, struct mm_struct *mm, int code
 static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long addr)
 {
 	pgd_t *pgd, *pgd_k;
-	pud_t *pud, *pud_k;
-	p4d_t *p4d, *p4d_k;
-	pmd_t *pmd, *pmd_k;
+	pud_t *pud_k;
+	p4d_t *p4d_k;
+	pmd_t *pmd_k;
 	pte_t *pte_k;
 	int index;
 	unsigned long pfn;
@@ -132,14 +132,12 @@ static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long a
 	}
 	set_pgd(pgd, *pgd_k);
 
-	p4d = p4d_offset(pgd, addr);
 	p4d_k = p4d_offset(pgd_k, addr);
 	if (!p4d_present(*p4d_k)) {
 		no_context(regs, addr);
 		return;
 	}
 
-	pud = pud_offset(p4d, addr);
 	pud_k = pud_offset(p4d_k, addr);
 	if (!pud_present(*pud_k)) {
 		no_context(regs, addr);
@@ -150,13 +148,11 @@ static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long a
 	 * Since the vmalloc area is global, it is unnecessary
 	 * to copy individual PTEs
 	 */
-	pmd = pmd_offset(pud, addr);
 	pmd_k = pmd_offset(pud_k, addr);
 	if (!pmd_present(*pmd_k)) {
 		no_context(regs, addr);
 		return;
 	}
-	set_pmd(pmd, *pmd_k);
 
 	/*
 	 * Make sure the actual PTE exists as well to
-- 
2.25.1

