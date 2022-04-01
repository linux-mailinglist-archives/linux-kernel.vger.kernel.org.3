Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A24D4EE609
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 04:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244074AbiDACbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 22:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241970AbiDACbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 22:31:15 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2070.outbound.protection.outlook.com [40.107.215.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD245677A
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 19:29:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sdc0SezCqnB9Ib3urjMvxbWDRxTYY9ATsjnUCjNIdiaQm/3NqpbyyavUB4Z7wkukcSgcM1o6s3/Uc1uHvs++L8pZ6dxOIz6Olbat6nvyH6wyJQ+dGApRgRTnESgOIqiGhCSv+NhMFH0WbYYI8YurIlfYKtnyCkGiRlEjldqgJVdQtxPQsE8vI4N6G4/VfRcBjLtSfqnwpk75hOZWFdHfGWxwL2s6i8bTWjSPGtsHLol4cce9Pj36mgPTVx4mNvnqilWecbZuMTuji0mFfaHo9N9k+j5ELUwWXtxNHu+7lGJ4z+BDckbqJHHLRjURysfm+ItB8tOQHf9Eei9nE/Jh3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fL3wSU78u1gR1aZucXLTlCzfJGnqDvtH4mS7knnBepc=;
 b=lN95JzJMmsIEbJyx5VM4VgI0gbz4S8dHw07cvTJQlw/0zWg3QPSwrNnuzGdYHmBbllw+cZ7EbymTXLEQbiTQLATOYMPvB1RWbW7B1v5WL4fzDaz8QH7aJ7zN1Il3vQe3wPok6gtcmfq9j3gxJtH5XAGfiHoPsctri4BJvKZ9QEjYWbwEXWB4y48GFS0hAhaTiXt7Hnc+lPSWdstAa8jN5wP5Lyot4n6ISsxmss924q6ppZvNsaSmQ88Ihm5iGR1brWd+hpG0Rvg3nUdgm1pjXxrMhU3TUJZt5pjmtgmn5S6U0dgElUfKKAyn8VP90Qb7z/zNUcNg0JCibrvKkj7TVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fL3wSU78u1gR1aZucXLTlCzfJGnqDvtH4mS7knnBepc=;
 b=U9nwlDpQwsZ044DAC8yjyEveMT5PVXbZKaHvTuIvVo+a1b/qiCDTgEjSZz9cHn45P/19YDVnsnAvftqtafWdP7pdnOKpTHXyyPxFapFqbfoc5DFvshWbTayvgSWRmFVwI2gNX7/1YnPs8wFh2AXxOMyWmy9MXxd+35nYp50V61I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB5379.apcprd02.prod.outlook.com (2603:1096:4:177::10)
 by TY0PR02MB5873.apcprd02.prod.outlook.com (2603:1096:400:21f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.25; Fri, 1 Apr
 2022 02:29:19 +0000
Received: from SG2PR02MB5379.apcprd02.prod.outlook.com
 ([fe80::84ba:7c96:f19f:85ec]) by SG2PR02MB5379.apcprd02.prod.outlook.com
 ([fe80::84ba:7c96:f19f:85ec%6]) with mapi id 15.20.5123.025; Fri, 1 Apr 2022
 02:29:19 +0000
From:   Chuanhua Han <hanchuanhua@oppo.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     alexandre.ghiti@canonical.com, jszhang@kernel.org,
        mhiramat@kernel.org, akpm@linux-foundation.org,
        zhengqi.arch@bytedance.com, ebiederm@xmission.com,
        liushixin2@huawei.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, hanchuanhua <hanchuanhua@oppo.com>
Subject: [PATCH v3] riscv: mm: Remove the copy operation of pmd
Date:   Thu, 31 Mar 2022 19:29:06 -0700
Message-Id: <20220401022906.97710-1-hanchuanhua@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0003.jpnprd01.prod.outlook.com (2603:1096:405::15)
 To SG2PR02MB5379.apcprd02.prod.outlook.com (2603:1096:4:177::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 045f2653-e6e8-456a-bb12-08da13876c9e
X-MS-TrafficTypeDiagnostic: TY0PR02MB5873:EE_
X-Microsoft-Antispam-PRVS: <TY0PR02MB587330974DBEF4B871F7F86ADFE09@TY0PR02MB5873.apcprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZtGx/ayWM3gxDmXVWQEom9l3qe13e3ABXhh/3DBkiNbUGQW8YgJ438jgeb2Jakl2/AgW2RF+DvMm/F8bPg65cyoU5ISRjKSJudjyohfH+MqaAUhYgkUL+1g8OUCa7BKU7pnwPOoSivem9VfTFdn5QhHzA+2GrIvM34/pJCd1IxAQ9Zay66+rphPDmnn9s5RD/hIOdUV5FoK8ijcArdH8sT66O0rIFdWEkehk3p4NhRSbFdeYkuTBETylPiBya4ajkqSOvm6hyMhS5vzDSxLPCwdmbHAHgKZmlHbE5Y+Ag0pnBwJf8VrEtcdT4uDT7vjQCBAGHpRZyIV5dgK32G5w1ycQeAeoVnDKsthI/+7WfIWay3hQaviMZa/6GqeVwLdYwhvgr4lkvhsWHJMvZpF/N8xgpW++freSQoPEN+tqkkQHbyRImDvgoodaBUko/SQyCJIMLAqqZ+1Gsm/TkIWp9RdvWOixPjHuCjBnsxmlMkGDxSo4XwIxj3QIl6Gi8rb8Ku7KpMX4MpMpyukFxtWNCiVQrBOBPdV3B44rtYM4DMi0OT0HAi1gIqfiirqfaZndExXzXxDrMhke7k7JVR6olPQ7NAfRNTvFifxP7jP7f/tJAfs+4JwjgWk3jqVX43jKLXizT+AhhaIOdKaieijS4qUNCLh7eAFjR41dQufwwacME3//umGDVTjUZHlUnHXbmFd7bkk+vpc24U4+KdT8Zg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR02MB5379.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(4326008)(83380400001)(6506007)(316002)(52116002)(8676002)(36756003)(86362001)(66556008)(66946007)(2906002)(5660300002)(7416002)(38350700002)(1076003)(38100700002)(8936002)(508600001)(6666004)(6486002)(6512007)(186003)(2616005)(107886003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?It2KJXXParcAiRVAc7vvM07gG/HroFki3iJTa11RxwN+zMvxAi1PevjwEhI3?=
 =?us-ascii?Q?bXeqO/GovWB3P1CW7n/G7MWN0ecHJ/ump3oq/srjFZ0Y3tuonJBqR3RJjMct?=
 =?us-ascii?Q?CXqETIetNlTWxZmng9XHSzimCP+3nF+qrqIvZDb6KAR381P2ZViV0cYxsVty?=
 =?us-ascii?Q?ytOl8I2i60WAOJPieTVDEpELnpLWbnlm+WtVzmfVkKfducsXWXnrho4KG2If?=
 =?us-ascii?Q?PCbODrdW642Rd8uwrhLxQj+K/+h9cLxp6VIgNbExfS7Cuk+6FERZvZGW1kDF?=
 =?us-ascii?Q?3lQXwS0p52pQoAjP+CP/qmOZrMq+WMlqFi4snh46RLF2W9pKZ+QZOv5X77gq?=
 =?us-ascii?Q?JqWXEumvuaSoVczmaMc79fI0LNGWtUDMOe14FlGA4BF6zcuF+i4lAX0pUVVm?=
 =?us-ascii?Q?oq31eEFwMRf35CnrisWQWz1pSqkxe1gNSYzl7nWFnNBJ7V0/nSx35UiqXevq?=
 =?us-ascii?Q?Bs3klls1tc5s27WqN2jCL+5fY4LuPxZPRvnTkes9sMxeQ5kCa7sqfXbzKSoe?=
 =?us-ascii?Q?LTGO8tiWv5888FKLJ5RoS5spYVS4Oe532xxeXTlAgMIAGiEVBWKrJgIH1vHs?=
 =?us-ascii?Q?5yy4WAaVLzn4e0pRcFuvqkWIWTW+i5UQWtiOblAPyvFfaEQszOlpA5H1Y/nO?=
 =?us-ascii?Q?orgJZq0cRRIB+oi9Exro+78CxCIf5Ixbl+Te3OX2OUSArj+A/28czt74xV4k?=
 =?us-ascii?Q?4Q/VksiJZlGLTpXZdZDRMOpwbsKc+UhqWKLwKRUWQmPzhWICW3BVLw8oBMDa?=
 =?us-ascii?Q?vyYIlLtUFWy3Of8n7Q4AHqDB60F3AyDUKUwwHkV16AUKL9lxUOeTBYtSPKog?=
 =?us-ascii?Q?P5qufMC6WhH9xzzNduwH94J9/mJlMJREMRwD4obk5cz9pZFYYJV7U75Nn8uP?=
 =?us-ascii?Q?JS199KgpB3gWUlqgwb33Av4dDsS9YrXcnMzaY25/Vryn7fkUVzVBK4CYdAb1?=
 =?us-ascii?Q?cnbvDyyb2vpfzyZAEP65JAlyoXrQmqJXCcZN/hrTJxLOYaS9oTYUKnWl6Tnh?=
 =?us-ascii?Q?azeec4ozLvfkuIzbN2fyjsu/7Gh3++/mnTaPBvWJfjrsz9lDs8E01xP/U+hJ?=
 =?us-ascii?Q?Ps8pswgAlEzyjULA9aC+IUD2vzgAbNlitRnuuz0DrfV3ASJJVQlKwNSHaY3v?=
 =?us-ascii?Q?5g1Doua3kM5F1IbRFEd5/1VF0txG80BSDBD0FlL/UfyEHDlfBWF5kf4BOi7v?=
 =?us-ascii?Q?+RJdRSH7RqP5bwq5av1JACF3EKzvLpPDmw0NGM0WtcJF5bKyiHJEshVOinSX?=
 =?us-ascii?Q?moDQ9PztfteJcIoWh/1iJ3oT72UtIoxyeuBEB3uclbeA5SI6sGTvFa9RGnoC?=
 =?us-ascii?Q?6htMNg+VRX+Mea/EjZz0H4CJyLFSr1ZGzQgnAqAi4flmHBt7IuMxXx42JRRA?=
 =?us-ascii?Q?9fAd31jtaEmAK0tGJcHuZ1u8ce2/NsHIdj1XvP4H7MGb/1NT4mK3PO4R6pJ+?=
 =?us-ascii?Q?F6N/xk0F52Pu9aq3xuUgs3n5a3w1RfpEtl0gUzmhKy1BcQlcclfsCDvShzRZ?=
 =?us-ascii?Q?AN9nIXz8u6oGOCczSw0R3py9WtG82NWeuxNA0hZfGpO4aQEkE2b6nuBFiHxQ?=
 =?us-ascii?Q?IHwoorYnXSQkYcactw8p2mk1/pYO6itQ/nE5ZRZ72zAT0nuHmaaiMruquF5W?=
 =?us-ascii?Q?j4ysCEPnxNeWKiyuFKDJwcNAEU0wpalkVrh8Hbw6B95ROgCls3uhVKCLfT4y?=
 =?us-ascii?Q?fy25kNnDez+dURuCoQWdiZ3vVf8WP2PYusbpvIs4Q5COrq9uuFwlG1t2AZz6?=
 =?us-ascii?Q?seRRdfMHD8BPWwzjWgEzFI/D3c15zko=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 045f2653-e6e8-456a-bb12-08da13876c9e
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB5379.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 02:29:19.1763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Rs3GjvFimtVVDzsEd+WCqHBdsGoK8swR7Bh6qUA5o2qjUQcIGegRIRxBf3nzPN3WE55+DmGn0yxLA/9ARJu2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR02MB5873
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: hanchuanhua <hanchuanhua@oppo.com>

Since all processes share the kernel address space,
we only need to copy pgd in case of a vmalloc page
fault exception, the other levels of page tables are
shared, so the operation of copying pmd is unnecessary.

Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
---
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

