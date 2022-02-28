Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0D74C6CA1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbiB1Mfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiB1Mff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:35:35 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300044.outbound.protection.outlook.com [40.107.130.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5905975609
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:34:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLVpp6O/Rp6lpPI3yz+2AMFUvllkDsh6oGRzAxXd1NLQz94sJSJszfBc7USA0S203WWZYZ5tM9Erty0iUSlL/pjpNo8c9ve9ZKlIkohYyNZRLF8a6Lv6iKvIL26Q0xWeYOXG/TDL9U/2cqJoW9UIOCx//jLqUvYELbIByefwM5/oE6kvqCgjok+iZOvgQedVvO7FuzA1i8uQDfyADJQ8uJQiUPFCsNp3DzPKjYNkPPn2OlYqFFi8W2H/Z50rVl5fxIIQwExR2gXwdteH5Xx6goiMFZtWQ/8a958rxyEgi2g2Iq3luZxMFShOxVLXaETV3WK9hWDVDAKupqBghPsDrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=am9pMlNetqPWV+XzB5Gzk+JLrkBzd1+hok1X8N3XbBQ=;
 b=fzZdzibfJa6ur/XNnyIAcXkkaJf8MsgSJmh+hlrnSGTuCh/DQbOgzl/qp30U+yXl7Gpz338ePf3BSV4BSbWXNoEph+/OXjPvmvVNU9g+iRWYDxxF1mzUbBrX+NOO7XbF9mKK+kwnjbcjwfakxynohkAmrLlUb1N1R+djs54Ds3pJaEu23C+rAdNJ7aJCvhi/IlV9p49GBVhvgx1lQ0R2tHm9NKnbt9m/C6dpfhMGDobXaySSZ5nBTMb7RvuZ6XyQf9jsUissNb8JA98hGmv+wx0HOkWudqfal0kPe/CavhJjqm/ZaQtNm9WWg1RKCqOMVJb5c3pfaZ8aR7/OPTC53A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=am9pMlNetqPWV+XzB5Gzk+JLrkBzd1+hok1X8N3XbBQ=;
 b=wTvrOXP/1CrASPyfqcmjsCojg1k5dTfN2LhwmkLVW330Do1BPwJ79qDOyjt6TLr5DlGYPdGm8TOPYVhkdE86mEmiLRBOgSurYMdHRNseBXaQ9a2e3jcu0xnGlmvXcnihlOa4Eu0zFbW6D5SUD5T98N/DGgXIbKJKbTpVzZCabf8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB5379.apcprd02.prod.outlook.com (2603:1096:4:177::10)
 by SG2PR02MB3532.apcprd02.prod.outlook.com (2603:1096:4:4d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Mon, 28 Feb
 2022 12:34:47 +0000
Received: from SG2PR02MB5379.apcprd02.prod.outlook.com
 ([fe80::1cb4:8e1f:49c0:8b1]) by SG2PR02MB5379.apcprd02.prod.outlook.com
 ([fe80::1cb4:8e1f:49c0:8b1%4]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 12:34:47 +0000
From:   hanchuanhua <hanchuanhua@oppo.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     jszhang@kernel.org, alexandre.ghiti@canonical.com,
        wangkefeng.wang@huawei.com, liushixin2@huawei.com,
        zhengqi.arch@bytedance.com, ebiederm@xmission.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        hanchuanhua <hanchuanhua@oppo.com>
Subject: [PATCH v2] riscv: mm: Remove the copy operation of pmd
Date:   Mon, 28 Feb 2022 20:34:07 +0800
Message-Id: <20220228123407.939-1-hanchuanhua@oppo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0021.apcprd03.prod.outlook.com
 (2603:1096:202::31) To SG2PR02MB5379.apcprd02.prod.outlook.com
 (2603:1096:4:177::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e89c3feb-d97c-4fef-fda1-08d9fab6b50f
X-MS-TrafficTypeDiagnostic: SG2PR02MB3532:EE_
X-Microsoft-Antispam-PRVS: <SG2PR02MB353225CBB184189C174E90D1DF019@SG2PR02MB3532.apcprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wONtEwb614xYE08++eIqWHG+RrqDZ9luW16t15cdUOM0Nh3boF7SDJLmtlmO2nnPeb4OlfwF3TuiIodnMzh/q5dBDyh6CuoPMawywdgM9SyuT/DycSiMvF0mAzjF/qD61PqEZFA52Fl5bymfWJmTTD2PFOm29zbdnvBSGMMSyCava+466kZ5ly2i88ekRK086Zoj/tCATALsBQkE+Og4swAW7Ie3pvllNbRennkxLjR4ZQ86AjC6LZ2t43BUjpCvRc7mrB+lMpgGTkCDfoGJP3opdpPpoubw9VBFcJy81M0FPwgrsqVkloo3CO5wTeUFkk8j8uAU5ZoXEIV5QH/9VDx/UOEx+gpXMjum/ql69SvO/S7Ch5duCMhVnIoMu9a3mJs5ofKXVXcfxC+3ACJfOKyKCqFlBH5e24Kj85Qz7y5pLxy6IIpePm4EqEi/ViiID/KrEaZ1Zw1UON6lDPfE+lFeIdez0darRHd4RrbwSooQhMzmUncSAg9UIKoyrCPAa5tTERcVVTTwTMpmg1RhlasZASRJEiw7YgbYfIerenuBldtoaxIBMI/di2gnW589ZC0+qOW1J7fSJP88o8XPgPwDIcaSpJapRt8bQCPQTRRmevXYrX/EOT1hnhKIHKVouCL8+B+i14G9pvwaOzD81cD/Ycu/AFj4YUF1Kdq4AwE+8hj04SeEP3NfuoHVrbmD8fLOyvMXsA4TRzCGfugJTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR02MB5379.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(6486002)(5660300002)(36756003)(2616005)(38100700002)(4326008)(52116002)(8676002)(6512007)(86362001)(2906002)(6666004)(66946007)(38350700002)(66556008)(83380400001)(66476007)(508600001)(316002)(7416002)(186003)(107886003)(26005)(6506007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hrCpcUY2+6nn4hD1XnZBAhGIe83ZSMZkqJB7Blo7uy0Zst5CbJL4AZdbJLGx?=
 =?us-ascii?Q?PwU0hEgqhuguFA+DQk4PgPHXnlffBS6t8U8GRgmvbMthgSrwVYB0q92Jvn/k?=
 =?us-ascii?Q?rIBu+81v14VK0HNBKrEr72uvX1vwg8LJKkiPZm5ZtYxc4W4a8FCQf4fr5mSg?=
 =?us-ascii?Q?KrsI6YGTggjBpbXEtW5JYvFxYvh/aUd7j/K8kwKRwgJFwm3xd1NF1npiD3gM?=
 =?us-ascii?Q?wEl9FiXOnV6lKGKP9jBHWL3NXJBplIhjecoIS2c1ZGAQYgZBhNqy7e3+iUpt?=
 =?us-ascii?Q?qs9e4Mas0ZP46UAlcNX/EERmoK/CIp6u61pAzAAiQU4cbPC5TJlpJ64ftNr6?=
 =?us-ascii?Q?R/ZKGWROqXDPl7Da0Eu1RbDkF/D3yQgkH73qvstr1eaAvvWPRs0LcFwcsthd?=
 =?us-ascii?Q?fyPUiAzmygiUM/ZsAvYQ9/MQazqMK75p0aK/4HFXcTMVo9UdPQK1sO+25WJf?=
 =?us-ascii?Q?QbZ/0awd07pHhLWHToOkh9fmzvD2wTrlknb+vHPbYpDduwjVgGReEZjV7DvP?=
 =?us-ascii?Q?XKrN4upz5tNPG72+w3/FC+vAKWX3hHhGvOWI8RW8f9eVPf2fSKQbZEeYObp9?=
 =?us-ascii?Q?31zheZOrT/z5yRyBXAIiB4zmJ0Jt0ApHhvJq2WPGcmUg1tgg9N99fs7ohm1D?=
 =?us-ascii?Q?RNO8BFAsqTskvEk/UF22vRwH6OtP1C+AkfGGbU3EAoDEFO9kbALIaWEvbIIS?=
 =?us-ascii?Q?IbeqKJ1d6rpCkeU/zER7a62HDdujev1hZqJjtawHQCTFCFOAAgt83OOLNqAM?=
 =?us-ascii?Q?FKA05SsEViztmHU7KnPzyYGITIAJw6EpbFRzgoiuEz9g+zDi621xcBTdoSCM?=
 =?us-ascii?Q?1KfZh7yUtpv3dtPplm6btFJkvRpIghig69hKFQrZzFDIBLA8JF2UtPZDRnrI?=
 =?us-ascii?Q?gvU3vnFxzRaHywCfDL9MwkhDXtNAyn2KUceY7eHQng+oNg3qewVmasC+0tL4?=
 =?us-ascii?Q?EArQ3ELFmzPbgHAmy/XJfnl9D+aZk2qq9fP36z7FB2zRTJxwhK/y2q+7OIUs?=
 =?us-ascii?Q?seeQBoECJE4ADIRARXxUATV8zUM2lS22K5HjB87UeV4VOlU+rxDtF/SPLTQa?=
 =?us-ascii?Q?LsJyeF3x2KpsLUC2TDvJ6rtn7oF5CSC8ghMgk+0tuFZXQG/d7sPQNIerx96C?=
 =?us-ascii?Q?mVca7Ynh4cszgYaZ34yX+ue+en5QK1eeCRxAFq1o76hllQRpk1wIPwx8J7gq?=
 =?us-ascii?Q?cDbZNVtcG9Sr71L4A1Od73yTfJ59KZCjlq5hHoQuODigYkA2Uh9K5HyFUo1l?=
 =?us-ascii?Q?6lzcHov21pdkRKQGl4mT1ZK4Yzu3GQZ9QL6AdWKS8y4qNcoKcCqkRpIPW8t4?=
 =?us-ascii?Q?y5SLNEpPY1BJaYDPqp8Jpq+4Z9sIXN1SQuXfShcAeMbs7rv3Kg9iHTdSXqiz?=
 =?us-ascii?Q?LaTCV8QqodLZNgLWyTM3J5gjy28gKxJpliwcjnz7kzA5pB4i3mZY62gd1+cc?=
 =?us-ascii?Q?WT9MInhY4UtC/dQywtZv/NuEKM3ueX/hyWwplRgc21KkagSuMAFuQ6vGGjrK?=
 =?us-ascii?Q?q6s158YDJndt8SoFz5fNyoJrVUzUVPCC30tZR6XiOPlmfQXiyWoNm1dkJ3OY?=
 =?us-ascii?Q?TMWNN9X+iL/7UxuzPVaCaXgEKnhuWktmwYMOIPw4zj1RXDRGX6UAG3PmHIMs?=
 =?us-ascii?Q?E8I022fATbc7679s7Bvef7c=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e89c3feb-d97c-4fef-fda1-08d9fab6b50f
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB5379.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 12:34:47.9445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wXYrD1WSogPUqYG+xlQnYAFCYT8ekjPvAjr2W8iMoiwWcYGeTfQj5qouDZbsFJJ+KdLjqWod4M3a/Q/WPS8nSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3532
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

Signed-off-by: hanchuanhua <hanchuanhua@oppo.com>
---
Changes in v2:
  -Delete incorrect default signatures.

 arch/riscv/mm/fault.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 4e9efbe..40694f0 100644
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
2.7.4

