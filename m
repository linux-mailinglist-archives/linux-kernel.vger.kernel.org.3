Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239194F5C46
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiDFL3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiDFL2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:28:48 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2051.outbound.protection.outlook.com [40.107.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F185651AA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:15:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjQMLjbNZ0FprimKuIQAQidQ8yXufqHMq0gaxLgwvNz1IA6NtCwN7dg3c61bxe6SfWftOpTVmNsGIJqKOBXQ/eUhQ2TdUrhI9cs+kSLkSDBW3pnvTd6l8Hvi39hHRfMzqd0Kftzn4wPqeQUlO6C1VCnZkbIgy9eWfchw+YOtj+BmeeMkJ2tq3eP8xSLvU9to4y3C9vMztPQ7MCRTAYrKKgGKNuHniTUu8tdfWZCWMrOUh1wOzko4fTov8ijimAqsc3Kt0NlHiCAQsN+iJOWYiuP/E6FGr5HBjRbSi0R18Xf0Cr0FNnJcZom/PvkQPlkFxEkJ2EdZolqzU5caNpKZXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAkr7broKIcMdeiWXPsx7nylCx6jR3ypefPS5/elsdM=;
 b=TTDZhRYuX/5gLzb10i7Hbe9hMbHdes9wL9AnfgIIPj5FY1UdgxjF0FAuhtFh2t2KtubUXsBX2KLP2Mi8uDR/IfQMyJnsacWwYn+lulfNboLE+PRPTxcTg+cmmXYZB9CH69pzYSR3LXcvleJZAQ6BY/mPGMSg/IRPNQw5Z3pX2xgPPu3O3htPzAUqi2Y+LiGd8biTJ4yP2nf/Nfm15hIm8j3JbAnw1ZK3jMt7CaV3tfVPQ/dAdH0Jw7E8wuCJH5zpoKndqNngapMEjr5t9BvA+ZnaGgCAKOM7yRH0UnPyGIyP92D0BmQK6/1k8ibZXcnnTeleJsi7sX50G9D/Zibd/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAkr7broKIcMdeiWXPsx7nylCx6jR3ypefPS5/elsdM=;
 b=nEQdd7VecbwkHHk+qlakfzfzyFlseK7F8lgI7w7d7nFWLok3HDxeFbgL8Xtp3KW6j0KgpadV09+U02lXhcO9OAARtx+2gmhivuPd+d1+jgM7DdGlTAaUfDD7SpIvOD3xBReAm3xlpMvqk792wLGiYFgSC6SvlIDZkT8uxu+sNeI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from TY2PR02MB4431.apcprd02.prod.outlook.com
 (2603:1096:404:8003::13) by SG2PR02MB4473.apcprd02.prod.outlook.com
 (2603:1096:0:9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 08:15:08 +0000
Received: from TY2PR02MB4431.apcprd02.prod.outlook.com
 ([fe80::3c58:2561:8343:dbb2]) by TY2PR02MB4431.apcprd02.prod.outlook.com
 ([fe80::3c58:2561:8343:dbb2%4]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 08:15:08 +0000
From:   lipeifeng@oppo.com
To:     akpm@linux-foundation.org, michel@lespinasse.org, hughd@google.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        21cnbao@gmail.com, zhangshiming@oppo.com,
        lipeifeng <lipeifeng@oppo.com>
Subject: [PATCH v2] mm: modify the method to search addr in unmapped_area_topdown
Date:   Wed,  6 Apr 2022 16:13:32 +0800
Message-Id: <20220406081332.347-1-lipeifeng@oppo.com>
X-Mailer: git-send-email 2.31.1.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0050.apcprd03.prod.outlook.com
 (2603:1096:202:17::20) To TY2PR02MB4431.apcprd02.prod.outlook.com
 (2603:1096:404:8003::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ad910ec-a448-486d-480b-08da17a59050
X-MS-TrafficTypeDiagnostic: SG2PR02MB4473:EE_
X-Microsoft-Antispam-PRVS: <SG2PR02MB44734FBF00CC339DAA31BAE6C6E79@SG2PR02MB4473.apcprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eRbJAz8GUl+R0RPHlt9h2tdd/mKBriUsG0u3eLtgUCJNiZh9mkAaJ8avxEqQilW2TVC2WLbCSnwz3k+6xY6Bg1FCsgAF6uG6cw+TNItolpM4+9lozlUkl5DVDGBXVMwOJdvdhVbj//l38V+x34neha46RMDOl1DtQ2QRycpapff78KoZDUcO5CSkrq+cpb6Ow1jrysrhd8sGYfxgKZZB3JzERD43jvv7xCbZbDCSimRpU4pVfL3Y8dufY3oDcG0NyO9GxkmKV8Y1BKOlNx20FG6GF8Q+E0IKxb0E3KZTiGMQRMIuf1nhBRehDQvUCL7CuYqtIgRWS/ikaIKG/VD3Xao9fFlq+o1jECMyGYEERE9qZvaTmLAmuGmADgwGjh+ntDgHVYwPLtSvjJVov4eI4kLDxSggBT1aHLxvvSOhDBMiZ0yeV9dU8BDeTXjuAeKsWbXVioj9nN5sumOQqImB7drEFBJPrlBsH/ZOKv4bF9dMCsEZiyeSWU9IlS7v0ODjafCqTG0T/umIkMrOCZAhTldoXxGnS2LS6ZiTr+6EH7aJDPo1azbnj4eFAl+VqTH/l+c1LD2/+RzocB8mnAJeaXky5wGlSidy+iZj/hKn8fXBYhmBgbsPytpIsTBWEXzQZxm6T2W8Mu0nFhuvqdreRI9clpAalk9/AxhV3rTVYDBpemmo++FGVOZCpZIXzmAgUInbl7OPryqEYfC9vM1WvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR02MB4431.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(107886003)(5660300002)(26005)(38350700002)(38100700002)(186003)(1076003)(2616005)(36756003)(83380400001)(8936002)(6512007)(86362001)(4326008)(508600001)(8676002)(66946007)(66476007)(6506007)(6666004)(66556008)(6486002)(2906002)(52116002)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zozwB6wk7Oxfk7Uk9LwFtivmwifgDQvknqurgTfiYkzC/kxeDJ4f/raBbFK7?=
 =?us-ascii?Q?X/edxPks3zHipfyy+U8y2etlXe+TvGIBLFczj8mDVxNfO7NG7La888vjQP2K?=
 =?us-ascii?Q?XgghtxeiV6E8YrvNrbOfm9aL5TJD13Z6+1fmpIyHQP4ycyih8VnGVJA6v+WL?=
 =?us-ascii?Q?X+OtMueC7ww6C1isHIKQe0RoW/tnY4BMNYPYeUs/lYwHkNkctRugjyFky1fI?=
 =?us-ascii?Q?Wmo2mzWPu3tFDIrZBXXtlOcoYydx90iOzg8OOULqN8EBbgySfFQFhROAm+oU?=
 =?us-ascii?Q?FHpEawr1QfkE2G21LefvmZKxXJI1rV3ev31sdNS0CfAewchw5Du75yMWU65p?=
 =?us-ascii?Q?ztvdCc1yvkkWynbQrrCeAA20jT3ERCNUlRVHIRBPQxUd5BH3UJdERpfkxoZT?=
 =?us-ascii?Q?ZzMkXhJpIWPlB9OpCghrtzkslhGgreU/AMAWH1O5R9WrqwNg/APxjWslIwEw?=
 =?us-ascii?Q?8SdR7iHTyiqAUP4bT9+WeuOl+dRkwk9HZI3vIsvIpo9dci/Pyn+2WI5kqCUg?=
 =?us-ascii?Q?FzhNRpTBKkLQKYdKEqU2Pk5JKx1kTVFask7fx1AcRHMapUvWxtj2ZNONzjUR?=
 =?us-ascii?Q?sQ9+Qg5ha9b5DxySCXxEt6PHKUeR2crrouBGXKfio6oBu73C7OpOK70ijog6?=
 =?us-ascii?Q?jgHI6IkdGMiuDDu6lacsmd6kTNaXESnKOPNJrNtr9JGH4NA8uxTXSTTe0Yky?=
 =?us-ascii?Q?tJn1+WHlsr5vZBPmdOoSDqXMeULrw2TY6GYaGIpP5fGmmmWF91iFPzDRmyiZ?=
 =?us-ascii?Q?JwCLScE8w/34Cw3RA+sH0Wl02SJUQXIuZwRaF5XvPiRE4wnv4trzEH5zpLEJ?=
 =?us-ascii?Q?hsm6RdB2tOuNKcSHPx+QKGL14c0cuwBzf10xlM/F9pQgfASHZBCfqKE2BcXC?=
 =?us-ascii?Q?WH+tFM0RgJs1f5BXR5+hwD5WyBI46SJzKOhLuLEJhyTA/G9vSVWreeRtKBU2?=
 =?us-ascii?Q?yNSBo+sD5AULO04TypvTUWP2pNiWRV9VP65KbsRdH9l4TIio/7rucOzMjyIB?=
 =?us-ascii?Q?gkUDrsMf3Z6A3ElWjRTfrwOitseZ/73E82XkkWDerrntNPoOO5dYrFd9tjJl?=
 =?us-ascii?Q?+0AY56R8tET81ZgE8vuIar1K8dDxyjeVEoUa2KEJ1yV2v/7vrpqcxRmcfOvv?=
 =?us-ascii?Q?9VTkCLA5Hvi3sdgifQ5L1yd59WEHN+18rk2eGknv7e5zj0iOppsWRln4HF3F?=
 =?us-ascii?Q?ovPrteBjL2vJhruNfsIKAi0dKSugVJGWDq/3IPDDTq0HXYO8t5jjNfor8f6m?=
 =?us-ascii?Q?Szb5WMBLJr/0sW7vXkCdIfrKgJUffpO5s13hYaXXbc//Mhg6IQ5LTKxbDgr/?=
 =?us-ascii?Q?7gVmUdwaKWmrW2UitNA06MXE/6Ji1BhRGrPi/CU76gt5Nk0UvjgGm5bPcCDl?=
 =?us-ascii?Q?UvdqofyTZgiMDJ4CW6nQKNbNrFRYU0QhDWajzpO/5QNC8Al0NoeC0WDlUo6A?=
 =?us-ascii?Q?tSmeNqs/1GUKRUyWw5ipdgQr6tmk7tL6P31ZiRmIDkm2384a8/DcCA4/QJOh?=
 =?us-ascii?Q?Ifb/JqXjlzbbQHYACrNa6eZJgKEizGF1zq55B6f1+yFRcc1qzblpIHP7Kzb8?=
 =?us-ascii?Q?9K/ZwnUguY/4OLwumoXH3TX3PRT1bMiSOBu/ukUp3LowKetPzPF+wFH887Sy?=
 =?us-ascii?Q?OKy4DUizmwJopaSRoTOmLBBcPgzjeVJKvetZYKbhgrFBAB2wQtmCCULT8hfs?=
 =?us-ascii?Q?1cSuJdbzqrxm1Nt8YgkGV5mfSE42KFzaISdLpQoLPgvkmJoXG6AZGszxp+Fe?=
 =?us-ascii?Q?fXY2sNVSa6jGknH4iiuANKxAIBMYkr8=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad910ec-a448-486d-480b-08da17a59050
X-MS-Exchange-CrossTenant-AuthSource: TY2PR02MB4431.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 08:15:08.7708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6jIqgMzJbr3/msZtX1goKfS1jnCNpH9MrDiNlGqJunBjIAX9EorYen4KXv2WeNkVEp3sfR5dh8IP6sqNv+0fuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB4473
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

Do a simple test in TIF_32BIT:
- Try to take addr (size:1M align:2M) until allocation fails;
- Try to take addr (size:1M align:1M) and account how to space can be
alloced successfully.

Before optimization: alloced 0     bytes.
After  optimization: alloced 1.9+G bytes.

Signed-off-by: lipeifeng <lipeifeng@oppo.com>
---
-v2: fix the commit message

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

