Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1289C50067E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 09:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240188AbiDNHCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 03:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbiDNHCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 03:02:52 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2078.outbound.protection.outlook.com [40.107.255.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1663C18E18
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 00:00:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5ZkuZHmKPbJmI+5rjj0ihY5tTcnJxharT29dkX2FH3TQQ14XK2VaSVYtf8KEAMNDdNSBCpr4wO/VdsrQojFvb2mRkJGi74BillUgLfwyGcV94kFipr2ifM935nahfBAsHwg5qrFd1dpFacSP5Lip2eB7suHjQ5NNawnFqIsYgVo4kbmgBeVhxcYEZwKRDjLD2CFqWivjHzV41R2kVVEl0Y0g0yqL7Juvr1jGY5vsrjvJ6csPL1xjGK88zDm1gyBcbGISzh9vhJsE3Lgg31rm3i8zfWTztI/i4+FsDGULO4t3vrT/768/dleMv20+hhnvRNKH5aOUmIopA0aq8Rh6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqZSz5cckf5uzgRxpxOtSUGp0AonjZQitmtw9hAiT7w=;
 b=hQqk0ZE3bkC3NlxcVly+FlJDrIoKy54E8LgRyXEKWMSCL7d8B1pSJ3wFvaonUjDVCCg+izz7d4sb7G6YIVqdMsI82Tl8tefoW5hCV4z3VEhmZfheeB3ujn8clEjOJCCglCQsNzK9OGEKb1YEDTdzXsKSz+CiGK5ANx+R1A2cK51OVI2o8Y4OXHKs3cWQsYyG9ufTcNuXJjnDFa1o/PlhLFY4ixreMSkhIGmBq1reK0/K6FeysuZXD66roEKKLT+6V3zHka2IG073XH+cuGAEDwCmWHyrpgJPMuRBqaAVXL130c3tncFkgbBojegJQi00OV+10NC4PUlSlZyMMDxvVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqZSz5cckf5uzgRxpxOtSUGp0AonjZQitmtw9hAiT7w=;
 b=AJVpyoj2ITjLz5qOWPxpFb/pKsUQD5GeB12Ih2n3oOk9XWxP1t8lA89Mxb7pg81PDndFEchwGwGXzBwC4feawTkv4GZZUJsXETkJKRN9p4eIhNVMmIDK0zcb6BXtPnR8w4R6VZTu0/dUeHZ56ndVfAWWIG+5A8ojPveiFezDDOY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from TY2PR02MB4431.apcprd02.prod.outlook.com
 (2603:1096:404:8003::13) by TY2PR02MB2941.apcprd02.prod.outlook.com
 (2603:1096:404:53::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.19; Thu, 14 Apr
 2022 07:00:22 +0000
Received: from TY2PR02MB4431.apcprd02.prod.outlook.com
 ([fe80::8179:176f:a62e:c998]) by TY2PR02MB4431.apcprd02.prod.outlook.com
 ([fe80::8179:176f:a62e:c998%5]) with mapi id 15.20.5164.020; Thu, 14 Apr 2022
 07:00:22 +0000
From:   lipeifeng@oppo.com
To:     akpm@linux-foundation.org, michel@lespinasse.org, hughd@google.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        21cnbao@gmail.com, zhangshiming@oppo.com,
        lipeifeng <lipeifeng@oppo.com>
Subject: [PATCH] mm: modify the method to search addr in unmapped_area
Date:   Thu, 14 Apr 2022 14:57:01 +0800
Message-Id: <20220414065701.461-1-lipeifeng@oppo.com>
X-Mailer: git-send-email 2.31.1.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0134.apcprd02.prod.outlook.com
 (2603:1096:202:16::18) To TY2PR02MB4431.apcprd02.prod.outlook.com
 (2603:1096:404:8003::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba4844cd-530e-4b51-f8d6-08da1de47140
X-MS-TrafficTypeDiagnostic: TY2PR02MB2941:EE_
X-Microsoft-Antispam-PRVS: <TY2PR02MB29419E3A19CBB55E0F693430C6EF9@TY2PR02MB2941.apcprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mIInbSn37Ngz5BSQlHJpl6L+2bVvIlM4XzZkpJQ8cMsqOhpmRrHM8JD+dTLVDdRTfvQTF/0vqD47SsubK4rLyIH62FaiImpvo0nOnQHDQfA/sWXnzJEAXX7jkq4HpfulVp7CEpu/f9tJ69JkYQn+aX7L0x0VHVHiV+H0biWRvO+aRrttLB+xwYd+wEJ+pjA1vLewmvBEz+TxYMOfnoWIBLHF942ZilvPT9N5k/V14uOKkUgeLD0VqeP/O/UUasCkJNM06kyrqV2VhPz/OwuQtyR8WECtXajkXELCMWLGedj+HoYa+cmzowAtDvX1Kbvk6YiZG6Z+sKD2OoxjGTgdbYZKVEhYzh81UZn4/9wdZooC/2runu/BwZqfDEwqQFshkINaXkEdXzXvHDAhGgGVLuucKqlL0FlOgf/fxnZXjgpH41jou6h+iLj2IVq1LyTqUF/Y4Scnr35R3PJZ1KaPx94k46t2kFxeysjXxrzJXiMU0BisPeGeKi5WvKM74g0gOUjUUEeM7+1MZrAtkg2ka+M4JR+KsOEdYw9Br768iqIjc/3amENcCRJhEPqyM1huoWJ4YCqsbt7s+nNWTHof2WE4V3+bSTp++9KgCcLP3SK07UcKvRMGF96HwQzlRd08zQ86Db3lC0XlMFxeaB9LrgAB7rVlFe+zSHzOE9iGgREQV8srzt8REDO+mcNIRl7LU//1MXTuZbTMucrlKpGrJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR02MB4431.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(186003)(86362001)(8936002)(508600001)(66476007)(26005)(66556008)(66946007)(38100700002)(4326008)(2616005)(8676002)(107886003)(6512007)(9686003)(38350700002)(6486002)(6666004)(52116002)(2906002)(1076003)(6506007)(316002)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EkoQ0/RqrkCuKJAQ868C0vJBT/pl+vESZ/ISVd+gqIFFT3xp1PtA6J/axKZw?=
 =?us-ascii?Q?J/3UjJujxsVrDEiURfzEAXPJ8Yzo7EQA9RMWTZxyeb7VNPNkACLIaC9bk/hY?=
 =?us-ascii?Q?f3+U+1GUti6AxlPht7R9gyZ+uz52sUAW4nvcmFIcQKJ+N3TJNCOWHo2s/BuC?=
 =?us-ascii?Q?eV1O/yodls/Yp9yegudviKJgOTCx5JX6XpNPhe/o8NfNP1Eml0FT7XNzX2U3?=
 =?us-ascii?Q?0YjmuDfyW3P+h5EBg8crePytwz5QXef9cf3I/9AJoWZNW89CQUXV/e9ky7/5?=
 =?us-ascii?Q?spNDbyCy5ljzBwps11KZ+mm/NAE4BFPYDjyzYWKe3k1MyqUD5X9L4gHECifo?=
 =?us-ascii?Q?6/88+SirkgMq/vnaRYcgsyfcWKSBqWJm+FQjJyy0LvmpNIs32oRx6lOjC5Nx?=
 =?us-ascii?Q?jXjpbSsqiUDTtvZ3D4J+KWiBlHC1tYjPQHHPVlVqIr0BAFgIk8QNfEDKNSfC?=
 =?us-ascii?Q?Uw851hRUcN+3cgl6IXenEMw5CtRg7fGRPUyl0zyLuLZhtckJ+ykgIqnA8lOX?=
 =?us-ascii?Q?M6S8cv5DL8V2JS/XmciW/gn0TSTelih90BxMDoRy0Duf8Y6u9J9lMy1i4MRa?=
 =?us-ascii?Q?5sYUlBKeu/sKngHC9r5IKhAVTGSo76lqGiusKgz+Ti2L1IplSthVDjC/YIyA?=
 =?us-ascii?Q?wYXDGGEIqvI69sdLz+KL5wfJM1oF5bTDmClu1P499NtMcTCN0vWYISyZ9BZT?=
 =?us-ascii?Q?QOwNJ8POd2HxL+PiElSAVvQYLM8fivx82SYen54+oGDfZlbexBN+4ugDSwro?=
 =?us-ascii?Q?yGPNPadpSu9CkPU3qTe5SQAXLONe4RF67qIv7OSfh9JDrTmk6bbWCxTH0y7q?=
 =?us-ascii?Q?ADKLEX5BTx9n+PHSH3o/o8/qB4ZxNwfV6MoPjIAlYVc7F1g7t5xs7ZqU45iN?=
 =?us-ascii?Q?vJMDbeHpDzHKf7A+ddzt4LRmBuFgXGme0D6HV+HCJoB3uFCmO00xbCS3bCqi?=
 =?us-ascii?Q?L5NfbZ3qh0+7H675bW1EJkl1aSK5MiT8WrXvHe8UEZuueqBYGLGu8WAX2ARz?=
 =?us-ascii?Q?/fiq3YIOMYs4ZQTfGuVHJiSD7vhG5T5JPJdiDLeAQ82/MUqx0mSGnbXdAPPK?=
 =?us-ascii?Q?E3EjYAQEUCFP7jUEHVJNPYbk4rb0RIhj2tRDsrOyv5CZ+UY7dwqk4wSjFLZO?=
 =?us-ascii?Q?q2NkN+PbcTdnqE60Jc7Glf+v9q5HIC4aaBUr1dbA5OSOzjert4il6McahNZt?=
 =?us-ascii?Q?yRfzdCb/0KuMYXC5kqiq4rCo3nPqx03dJVdQbtl5JdiAJke/VJdLAJ3bSzne?=
 =?us-ascii?Q?MKa5SO/SB2SYIXzgGJdjcpoxLSoXayynqh87DWdy8AwAYZFev4AfZdBvtqnc?=
 =?us-ascii?Q?8GjpJnfyKexU1fdsZHutPPRyZhDGd1fJeUvGwuyjTAfys+DflO3QelqeGK6/?=
 =?us-ascii?Q?SWRKXEXKiPjFaM40IZUXDgpQGYoOJG4dSIhXk6jJBcIWTkNOyMFcRdINjnSR?=
 =?us-ascii?Q?qaaeH1La+q5LkrLENP3IhKEhC2GZVw48bMntt2PRFIyx04/1I0Efuq95nbsg?=
 =?us-ascii?Q?Tl1gkXMCx4uCwDAVzXG4eVkGRy3pWVGkhHqD9Ln6nZ0yI4aZiDIxbC4x1Tmx?=
 =?us-ascii?Q?sp1UuIyllkHHKLgPK9KIPaErtIv34geNQ5Vrc1E19wGHdUzJVE4oohJ+qPII?=
 =?us-ascii?Q?Yuq3fAiSbEY6p0hWnpvX0sEA+YmQjk0BFHMXxBMjE7RZqKGvbc1WeYMye5T4?=
 =?us-ascii?Q?POaABtQ8PNiqt8PupM1WVYrxOlh6L9HAa2tQnKFD4l4tBr0JF62HTT+DaYZQ?=
 =?us-ascii?Q?s9x91hGConRrgszn7UKppcfb/drOIL8=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4844cd-530e-4b51-f8d6-08da1de47140
X-MS-Exchange-CrossTenant-AuthSource: TY2PR02MB4431.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 07:00:21.8990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bUAuP8Wk75AgVhFg4cDvgZ2BFu0OZm3+I6+qU4xT3k172m1Z+Msh50FW9XOZVpzz7bAcnMjFA/UEa7Pl2kyzbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR02MB2941
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lipeifeng <lipeifeng@oppo.com>

The old method will firstly find the space in len(info->length
+ info->align_mask), and get address at the desired alignment.

Sometime, addr  would be failed if there are enough
addr space in kernel by above method, e.g., you can't get a
addr sized in 1Mbytes, align_mask 1Mbytes successfully although
there are still (2M-1)bytes space in kernel.

This patch would fix thr problem above by the new method: find the
space in info->length and judge if at the desired info->align_mask
at the same time.

Do a simple test in TIF_32BIT with unmapped_area:
- Try to take addr (size:1M align:2M) until allocation fails;
- Try to take addr (size:1M align:1M) and account how to space can
be alloced successfully.

Before optimization: alloced 0     bytes.
After  optimization: alloced 1.9+G bytes.

Signed-off-by: lipeifeng <lipeifeng@oppo.com>
---
 mm/mmap.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index a28ea5c..cb002f2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1923,6 +1923,7 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 		return -ENOMEM;
 	low_limit = info->low_limit + length;
 
+	length = info->length;
 	/* Check if rbtree root looks promising */
 	if (RB_EMPTY_ROOT(&mm->mm_rb))
 		goto check_highest;
@@ -1944,6 +1945,8 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 		}
 
 		gap_start = vma->vm_prev ? vm_end_gap(vma->vm_prev) : 0;
+		/* Adjust gap address to the desired alignment */
+		gap_start += (info->align_offset - gap_start) & info->align_mask;
 check_current:
 		/* Check if current node has a suitable gap */
 		if (gap_start > high_limit)
@@ -1984,15 +1987,19 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 	gap_end = ULONG_MAX;  /* Only for VM_BUG_ON below */
 	if (gap_start > high_limit)
 		return -ENOMEM;
-
+	if (gap_start >= info->low_limit) {
+		gap_start += (info->align_offset - gap_start) & info->align_mask;
+		goto return_gap_start;
+	}
 found:
 	/* We found a suitable gap. Clip it with the original low_limit. */
-	if (gap_start < info->low_limit)
+	if (gap_start < info->low_limit) {
 		gap_start = info->low_limit;
+		/* Adjust gap address to the desired alignment */
+		gap_start += (info->align_offset - gap_start) & info->align_mask;
+	}
 
-	/* Adjust gap address to the desired alignment */
-	gap_start += (info->align_offset - gap_start) & info->align_mask;
-
+return_gap_start:
 	VM_BUG_ON(gap_start + info->length > info->high_limit);
 	VM_BUG_ON(gap_start + info->length > gap_end);
 	return gap_start;
-- 
2.7.4

