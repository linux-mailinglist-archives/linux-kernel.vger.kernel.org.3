Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685FF4F0033
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 11:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354179AbiDBJsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 05:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354173AbiDBJsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 05:48:19 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2057.outbound.protection.outlook.com [40.107.117.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC83B1770A2
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 02:46:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUdvJe6rWcn/+gt2GeKcsSdbkENUwS8oe5hLUaC8tIAchQjk/TlH4w94P5odVQCO3u/yw/coaOEFW/5g4RuT4FeoWzul5LJYpSQsr8/k38Sz3DfvwwfS1ZjFI7MuEW5sZ2kHuxPY6VZb2mm/XttKZmtVfOI3/pQa2kIdh7syROaFPyjEq8A1VPbw7Cf7BFrF0ITVOvF6Sgq31pXjOV2m45gGTtfYTrADI3z1cFimyKdL2910C1uR5xFj/j/rN1KR3c+4AAkpDjxxaG9lTqttsMe8PYilo+IBC2lJRED46Axnai7wcwHo5JJZ+fCT3HXP7KFKucAdfqkGSwQPwGRcSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaEiVu3Dkr6DswYO9aapdedp4RyokbNmtyTMytJzlJs=;
 b=eMrtbXYMG/+74XQFJyvIx33hu+HepwhTpBwrmRIoLSPNEf/lgSg3cAvkmCenylwbRHj+OSAL45U1E4ITn+5+EI+FClj7q8leccKcjKOEczS/sEYpa4jfGQETvnd15huCgtofGVWZ70XRYDhSesGMXx95ApuquC+tuvJOMUlwAbIIOhq9EeBMUpsXmIi+jbMbNIopg4FidtjX7Zi8aO5tfFMY4xkSu26QyRb6lVk65hudeyReSIFxTIymjuoyIuY47CKlbQw8n6HhFMHc9/dbkb02OQ6X5FDn4MFx7bOeyBAC6Oc0hc8wx3uv5Hha0jrxKm/CXePQ25Kl2pXSXwfMVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaEiVu3Dkr6DswYO9aapdedp4RyokbNmtyTMytJzlJs=;
 b=V3slYjLjp0opIyA2j8DIiwOcqWBwfa5g+qQ8rAGfqeyMaw9gJSr1OuI/lkHHAsFUGvlKXKzWWxRi81W0C9zoM7OSuWo2xQll7JuWfg3WdtS1u96rRVKSQ3uXHAJlp0tkNUevOsl/c2wKNXGngMsv1ZJgKw1Bo3mMchqqWOfK6ng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from TY2PR02MB4431.apcprd02.prod.outlook.com
 (2603:1096:404:8003::13) by TY2PR02MB2896.apcprd02.prod.outlook.com
 (2603:1096:404:43::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Sat, 2 Apr
 2022 09:46:23 +0000
Received: from TY2PR02MB4431.apcprd02.prod.outlook.com
 ([fe80::3c58:2561:8343:dbb2]) by TY2PR02MB4431.apcprd02.prod.outlook.com
 ([fe80::3c58:2561:8343:dbb2%4]) with mapi id 15.20.5123.029; Sat, 2 Apr 2022
 09:46:23 +0000
From:   lipeifeng@oppo.com
To:     akpm@linux-foundation.org
Cc:     peifeng55@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, 21cnbao@gmail.com,
        zhangshiming@oppo.com, lipeifeng <lipeifeng@oppo.com>
Subject: [PATCH] mm: modify the method to search addr in unmapped_area_topdown
Date:   Sat,  2 Apr 2022 17:45:50 +0800
Message-Id: <20220402094550.129-1-lipeifeng@oppo.com>
X-Mailer: git-send-email 2.31.1.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0016.apcprd04.prod.outlook.com
 (2603:1096:202:2::26) To TY2PR02MB4431.apcprd02.prod.outlook.com
 (2603:1096:404:8003::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 240f696e-f295-4e09-5b42-08da148da5c3
X-MS-TrafficTypeDiagnostic: TY2PR02MB2896:EE_
X-Microsoft-Antispam-PRVS: <TY2PR02MB28960E33FF0DE11712B56EB2C6E39@TY2PR02MB2896.apcprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b9uHkqk8uPbf8MboKstr4aNgSL70oZ7h54A3UJeXRKM2r2dlsFqks6h2NHVUpGMdcf9Y+nzUtxzuRtrFavabOU8EoYdIB4Z/i/Un8fGm3pfd5MIQQqbrmeUqJpOVs77naOd9C+921RkPH1qqcCjMDsMnudXk2yi+Mz9Ybw90kYim4iONX6IjNS1bLNzeoKKbPwpZI2RzA6kC0240Lpvf8qG513oCWd3vmvH9EXRve1qqwkxt7O6XmCrebcqZkHGnY9pE4q5IpVS1hee7ZBhOnbMUeT/c2wZmWPLiw/Y7oCmOGyTMFqpZaXEno+9OKUAxcpyLCg8uNFH63tg7c4CWahU/X+qf8fbqjw9+T5Cg8TvFHSPx4coQSRE90ogCOm5gbSPELjDgGI+aoWLR4Y3XS7VXxkBGn8KqNgOesCutX7tCdMuvnRQ74wnY1GK1OPjINgzHIL5p9IFwmrB4Q2TVpT6tvXGqQ1wBMRlLEudDHjZkK5ElwmBm+t4qnOtqmOXWCkhkJVq9yz0WHadUVb285XCzgSTCtay5lxaJnj2LEi9nAJf4qhK4PLgAr0a7SyLRN1n/xTcf2EnTCFvmn3DxwjNMflZZ5TJx6NabtI5hi9gcy34/h+fmGVzx7nTLL/+4nXLMrARbgA6onSdVbqtyqws9quLlr9Eje6MV0478Qxa+YZ/Ie9Zj/Wq86BXpIdHgrF4YErMnQsPxPDIUv4s6fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR02MB4431.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(2906002)(6666004)(2616005)(83380400001)(107886003)(26005)(186003)(1076003)(9686003)(6512007)(52116002)(36756003)(86362001)(316002)(6916009)(6486002)(66556008)(4326008)(66476007)(508600001)(66946007)(5660300002)(38100700002)(8936002)(38350700002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vFGVkSthCJaaLhjIjzt17jRIXvA3w1/sB5C3gfRjg0NCPyVClMMyn/rs4yv8?=
 =?us-ascii?Q?AMPGyxyxejWzJxm0gsnvkcr/8i6kjv6v9gxljX1PSIXo9ye5en+SAF6JB8gN?=
 =?us-ascii?Q?TNpMaDwZS7vSYsO4ySNTwiZfcpw7Bs+EMOqBaCOVZNVQ9lyOgvc0I9AaDLpc?=
 =?us-ascii?Q?qkgtWxKgKdUoVddjQYDFGy6J+deg1WxbNhl6Oc1bU4xYYOOXpTPObrxRiMPS?=
 =?us-ascii?Q?xklFocnwvA0NzfHL2i9tPwCh60WZMruKYtBURer2YVinFsAo3YAZb6zeIA6h?=
 =?us-ascii?Q?K/kkkczuWEXDGaMyki2Ku0DMK2K+p95sE7+3VO9jA441WZn0sY9en+C8qou6?=
 =?us-ascii?Q?gnKR/buzc0AcR/WVeDbgHy9eo1uZawZzlHzG/3nZR7LpNOoF/LWRboBlXJG+?=
 =?us-ascii?Q?lRrmh4Hx1YZhXTYfPHOs55aGIynpj4luDOI4gs+Gg24T+U7Z1QjSPUrms7jI?=
 =?us-ascii?Q?iAyljPcr0zduJSqatGKwBw41RlFp5TWHtCiOJbmXgratHpLYMxsAZ0ZWvvEN?=
 =?us-ascii?Q?z54Yh1bsAYl1ISZM7o3LXlBTMwFBSbag8aQr1Q5zF/ZxHd7499DP5IQkN73j?=
 =?us-ascii?Q?5OGJbLWylard1YMmpzC8YWuNHToBWD5FKBubCV5Nbhi5T48xv5G3XqChsbgP?=
 =?us-ascii?Q?z8gaECFGcNp26IB5x5hDJZK/KSmXdlIXCZlSBARe1+b2ZfoLHYuSAhoRB4T5?=
 =?us-ascii?Q?5c1ovm0a8cau5KLPjMYe9o2QHdjjPVZsJS1TFJmakV1f81JpIhoVz5K7zAp9?=
 =?us-ascii?Q?u87nTMoXCsanJrYauOMZfWYYu9CkdluNihBXi7+bDJBfW5Rvi3grMGe7LUA/?=
 =?us-ascii?Q?TennZZPmljj0LCSFN9ruOWreH9mFUnA9TZ9FvOC98GkSLUzVbPtQZzGL7NmW?=
 =?us-ascii?Q?b+0g0JIX3TdfvCnLFH/zpkn01l124kuJf0VrtPbXAFwn4UKB6AVcggosw+YS?=
 =?us-ascii?Q?7bRqMsix5geGMMMqEBr+fxMGThm/WclHonlzEyFGml9tycoUzd9Q9sdIvVZi?=
 =?us-ascii?Q?lkZMS9SEuLtf4NEDHdMcM7tJvQ0R1L4OwkuYco9X7mKlW+BtUyxL9OrKw1Ke?=
 =?us-ascii?Q?bnSvi2dr59VnZ90Bqlt0Vuu28T8N2Hd9SxHTzSuJaTcgX+fAlfW6N8ZiYf5Q?=
 =?us-ascii?Q?XQ4ZnKY7MmHXioFRA0gK3K8xLFq21elDCKqzno7sUHta3rWT4yMAu1z2373z?=
 =?us-ascii?Q?LgE78DRunN+VT+x4zkIty9YZod4YaJod1FBI3pb4lj73KIioxFpfzf825OxR?=
 =?us-ascii?Q?UIPr3wzWtUXltCgycFPtJP9VcOp7Nex9hVKGVtb7mLC7gDGWkCarqU2ontof?=
 =?us-ascii?Q?TpMubcTaLTEdP87Irk1W22a+ApXZE5J/e9H1qInlLbedjuP3kqJqRTMsRfbq?=
 =?us-ascii?Q?GAqzEfTEYFZi+/9mVD2wwTIxTGLU4AsUi6Phr4EKpPehKTBslcE06NdXUuZp?=
 =?us-ascii?Q?RN3RhcEApCawM9epAPmVVWLL7ht6uUIPjY/SDAh4Cy8jQXsIVQ8C6pO1Kz4z?=
 =?us-ascii?Q?sghZpfFmh6l3p2tIyvTfmIglulEzqAlFjEjsZ3i0XBCaai7jQw4qt9tdIyFG?=
 =?us-ascii?Q?xhqpM2aYuOaohuL6aOfAEx5XWNmdS025RjPSUijAUwIIPLy35qRMFKJykcJJ?=
 =?us-ascii?Q?0X6URjXhjTH97Nb1djA6UHxUlFI7YM0sp8SjDFLy3wvH18PweNGBfCVlrynX?=
 =?us-ascii?Q?37KhLBZ1aI+iTEQYGlkwppJ5kZnBlTpv63DbUHrvgo8hpRQGMczGggsM8mCF?=
 =?us-ascii?Q?FZX/SUFH7Rbph9n4t04WhBDEcTPodTI=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 240f696e-f295-4e09-5b42-08da148da5c3
X-MS-Exchange-CrossTenant-AuthSource: TY2PR02MB4431.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2022 09:46:23.2272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xhHshOXBoh4tVmNII/CoEA2d7vUSzNagvTlapgBRiN5uEUjL52JAw9ZfNjiinYs+Gt28oQM1K92SAdK5misXXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR02MB2896
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

Do a simple test in TIF_32BIT:
- Try to malloc (size:1M align:2M) until allocation fails;
- Try to malloc (size:1M align:1M) and account how to space can be
alloced successfully.

Before optimization: alloced 1.9G+ bytes.
After  optimization: alloced 0     bytes.

Signed-off-by: lipeifeng <lipeifeng@oppo.com>
---
 mm/mmap.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index f61a154..30e33d3 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2002,13 +2002,14 @@ static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
-	unsigned long length, low_limit, high_limit, gap_start, gap_end;
+	unsigned long length, low_limit, high_limit, gap_start, gap_end, gap_end_tmp;
 
 	/* Adjust search length to account for worst case alignment overhead */
 	length = info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
 
+	length = info->length;
 	/*
 	 * Adjust search limits by the desired length.
 	 * See implementation comment at top of unmapped_area().
@@ -2024,8 +2025,12 @@ static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 
 	/* Check highest gap, which does not precede any rbtree node */
 	gap_start = mm->highest_vm_end;
-	if (gap_start <= high_limit)
-		goto found_highest;
+	if (gap_start <= high_limit) {
+		gap_end_tmp = gap_end - info->length;
+		gap_end_tmp -= (gap_end_tmp - info->align_offset) & info->align_mask;
+		if (gap_end_tmp >= gap_start)
+			goto found_highest;
+	}
 
 	/* Check if rbtree root looks promising */
 	if (RB_EMPTY_ROOT(&mm->mm_rb))
@@ -2053,8 +2058,13 @@ static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 		if (gap_end < low_limit)
 			return -ENOMEM;
 		if (gap_start <= high_limit &&
-		    gap_end > gap_start && gap_end - gap_start >= length)
-			goto found;
+		    gap_end > gap_start && gap_end - gap_start >= length) {
+			gap_end_tmp = gap_end - info->length;
+			gap_end_tmp -= (gap_end_tmp - info->align_offset) & info->align_mask;
+			if (gap_end_tmp >= gap_start)
+				goto found;
+
+		}
 
 		/* Visit left subtree if it looks promising */
 		if (vma->vm_rb.rb_left) {
-- 
2.7.4

