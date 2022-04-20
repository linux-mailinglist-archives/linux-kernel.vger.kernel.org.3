Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9DD5083AB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376827AbiDTIo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348475AbiDTIoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:44:55 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2058.outbound.protection.outlook.com [40.107.255.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473C03137C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:42:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fa19VQoB4uWUPx77hwkfMcwsy543OkVdfFkHDy81nXQ9vxA91ZwTOoz3RQQCd2st5iAQ43XfM9PCQQsnVLvdqoTt3RQwkNA2UziweFF7l70TJttctUsj9KG9tWbB2g5RPvr5h/1lvLAQ9L+8uVvtOPlLL51ttOLMaehigB6lJMeYuCRgRyAbSdjrEOegbqOnfhZ4u+h8yM5mkVZe6zR2f5oC+oRCmpH6KT+jPyJgYHBi+e+rpVbp2W2HuL3cFL+4FnEkPOqIZv4CVA9MrLqi77NteRDSg61TYFxDIqPVPpg/MgED6ZPXXJF0exRslw7dH2TiDQuAjjS89UHv7dtMGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqZSz5cckf5uzgRxpxOtSUGp0AonjZQitmtw9hAiT7w=;
 b=FadQCJELvNeGxsSFKerK3wSkotn+NyvN4lpWnlFLm6B0aF8yiD2sNKLngoUEssyV1RFuj6PfFdfoWNPGYXQoJ+ijQyrEAZN3V72/3vhnEsjumpBIyE7FOqeCCdaVZnU8lJSy7UO7BuXPk4jRB9sskMutBbabdozfjBdv71qgtqgQ6kvJPkCVUn4KAwdkWfm5/Aie01o3J3vQJcllfftVgXRjAD+T3riAIGTTgFxbi8lpej9PWNeuUqlhT8bzCfPysnc2/EHkmSAvG2810Hkr6d3KJ9OBTIi5eQL9OvqINqezJ4G7COBG8xUems8t6Rl/zJJC/mYf3bGKf3jnEgOfGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqZSz5cckf5uzgRxpxOtSUGp0AonjZQitmtw9hAiT7w=;
 b=I2cKaXNDp1v2eHtbGHr51dYnSgnFD/aPnHwcWWh+uais8AggCMePsNdxwBDgroFJHT5avlt52PbmGpYteeMK7Mxsg2P/xAlW6oGB1dH3i8cRdHd4mfQaAOTmy3fJo+S4qELA7cFMniRtQNnL98q6IyrfSx+xeYPTHH2AnDLa/xw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from TY2PR02MB4431.apcprd02.prod.outlook.com
 (2603:1096:404:8003::13) by TY2PR02MB3279.apcprd02.prod.outlook.com
 (2603:1096:404:5b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 08:42:03 +0000
Received: from TY2PR02MB4431.apcprd02.prod.outlook.com
 ([fe80::8179:176f:a62e:c998]) by TY2PR02MB4431.apcprd02.prod.outlook.com
 ([fe80::8179:176f:a62e:c998%5]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 08:42:03 +0000
From:   lipeifeng@oppo.com
To:     akpm@linux-foundation.org
Cc:     peifeng55@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, 21cnbao@gmail.com,
        zhangshiming@oppo.com, lipeifeng <lipeifeng@oppo.com>
Subject: [PATCH] mm: modify the method to search addr in unmapped_area
Date:   Wed, 20 Apr 2022 16:40:39 +0800
Message-Id: <20220420084039.1431-1-lipeifeng@oppo.com>
X-Mailer: git-send-email 2.31.1.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0064.apcprd03.prod.outlook.com
 (2603:1096:202:17::34) To TY2PR02MB4431.apcprd02.prod.outlook.com
 (2603:1096:404:8003::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63788d24-89e2-486c-2c71-08da22a9a46a
X-MS-TrafficTypeDiagnostic: TY2PR02MB3279:EE_
X-Microsoft-Antispam-PRVS: <TY2PR02MB32795101C3F6B435CCD19EBBC6F59@TY2PR02MB3279.apcprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bgguBTTYSim+M6T2XYtIm/+o8qWXOFE4xSSsM9aRFMB62Tu47f7uOk8OKtH+5RVJtMOyp6pf5EZxaL7JxG/W9qdsD0X02S0TVXoNKoYzc5aavORGrBEhraoXRdT0BIMVMni8mVZHPrhWECwaukTF175EtIANSX1Do64XceN9exe7kKbmi6GEzDbywA6Kx4YzZ3Lwdvj1mE0H5pDPUYSSKZGJfPHZ64QQxU1fhpK6vkEbKwbAQliPDiy1UHVgYc6mEhOJBcXxLRkGo7ub56w4QCgsRQfvGoDX2tamTho6Dlpuu5ChElohHdIISO0yxrQP9ANQPPpFb+uryA/nIYi3XoWfxUWutRehnCQykEGS+HajkUWBJ/d3ywUthtOygvar408sV7fkm5pGIbxKB1cNuLTuPQLqoe67H7bJDynW+Lvxw+Ibcyr+JfgnXy+8boxZY3RzPmi0ooC93SoGg9/NpreN4rD6ov9s5S5r3yq72Rgj2825jezaqoJ1K6f3BreUOl84aj7h0W99N2fYh0jsZpMIEkbYTW3tCN7WqTBm/sy9izJq4SWoVGBQ1UwukOMYhdwAQ8lTHF05dSFnrmtoGebNMSKnpxqC+iC7AP1EQ5bc3Ik9gqH82FFtysNpJxc0APtWpM0XChWqS6KB1G4pZds9Qrxk4H68jElDtFiOHKMvBAZQXphJ1roz1SoxTbnQGFH8ZbDQkNDRZowIHtFoWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR02MB4431.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(38100700002)(38350700002)(107886003)(4326008)(66946007)(316002)(186003)(1076003)(66476007)(2616005)(8676002)(86362001)(66556008)(83380400001)(8936002)(6486002)(6916009)(26005)(2906002)(508600001)(9686003)(6506007)(6666004)(6512007)(36756003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QRfulc8VI0cOmBhTcv0lr8rI48kKODVGhEimdFqpkff4LWkVZvRTKZFNb3mp?=
 =?us-ascii?Q?nHK5jjVRt2ofBPb4p9LvtjJ8tUEcs/ZuCgSZxY367KBzp4F0u9INfmKDUaxJ?=
 =?us-ascii?Q?Sz2CKG0p6ua8+r84DBf1qp907zlPQJA41PogdrsdLukT3tvkYDmF6LjFbES5?=
 =?us-ascii?Q?x/7UUkxvDeBLI5SllGQ8bLUei310qEi5aVJ/QtD3GkcgeMxOmexigaj6BWZs?=
 =?us-ascii?Q?7c/7VeGKdTx+UVqLqUtNdYabc6eMCiP4tzjTikWo+QGcDhJ2dcBpVKRH4mw/?=
 =?us-ascii?Q?5IqraULI313zJO8oCS0uxutykTOW8tlfl4PmSQLUfOuAWwaap1lE2K1NSXfk?=
 =?us-ascii?Q?T3mrI3K4/joaHUju003QUYOoA7LKq2mqL+ubwh8BFJ6cu7M6XubEGsbrEJRE?=
 =?us-ascii?Q?lqyLe566eibIYcJAj0IH8qxRwdHYU+YZB5Mt1cvRESJAYkfA+yFNuQDbk0W9?=
 =?us-ascii?Q?IMXDzxxvRQ2cAPZFtuHVPzMFBAjFQvhnVOVa7kup+md2iGbzJQEjdB0Wch9V?=
 =?us-ascii?Q?z51OaYaNwCH+6tI20Q3um5eFY5LIG6Kd4E8ZuToolMuNMj7BoojwQDPXiMhc?=
 =?us-ascii?Q?tTVX8nTvzeW9HDIrR6LtHUDq5vUizgseer75C47y+kdAgP9CqcnDvWNFNo49?=
 =?us-ascii?Q?owzJmgvOqmNShYHH2jmmtk4T3bFQb+wA5+lgOWPi/xBKN9AQGGrdw+XpE0i6?=
 =?us-ascii?Q?+0xn3y8nDGHsxPaigjF/5OGpGJ03PJrpevdjd9HEgvU+gs/KKcS6JuXgXeHQ?=
 =?us-ascii?Q?+/sgOwyF2+klDRQyzOcMqYJbkfnvhMqqxR1NxVbiqHBpI7W0FhN0cyyUVweH?=
 =?us-ascii?Q?B/kQJuiAVuBQYjqZN3vuf6mSjZNJEGZNQI9oI7X6xTOwLwYC6rnCdLPD6gWh?=
 =?us-ascii?Q?9sNEC9rZSghuX15IcVNxoI9vaRECupqIDLnI05p+zywc15hXl4ExU0Tn3q7B?=
 =?us-ascii?Q?2oEG78BwOqNcTCgkDkYptPBfe3ZHZd9Z2hi63ytLQOYIEY7Un2U7kurS3LFW?=
 =?us-ascii?Q?ifuP1klSCg9jDEQHxkllJndSMHCCZdVUA9T+oJMPBX2h+3sKyr82ykTRorne?=
 =?us-ascii?Q?xMd6uI09yMcaYrNGQ5H517Y0dzhTbLYjf8vEdpSUNHvG41QoqJcHD6hVCdHo?=
 =?us-ascii?Q?IObzUArXkckTauSw6yC5r268XACzLiwg+in/zaY9dZJ18ToWofNXhnvofhVi?=
 =?us-ascii?Q?4DAt7MXjOBEssqlNjsV2xJgGJuWc6tLz3DewPZs1dLCObnL7paC+YZR3MlMh?=
 =?us-ascii?Q?Xu0OeQ/BfMg29pd6K8PT9RSixEFwO6MSVtNtp2PYrbOS0s30+UhpXAErlqAK?=
 =?us-ascii?Q?OztV6ekX8bx+cGu372+Ypa158n5yTKMRQJ6OG7x34qKrQkAqzCA+UoaSS0mn?=
 =?us-ascii?Q?CcMXxxpKiXy0+Vmfy8NXz0u7jDsxL4sx6WESzqryzboUIyZUSFSJ2NSYVoqT?=
 =?us-ascii?Q?g5oNyZFdaICpyzuwLNUTfMa9ssvtPOxciq/DfhFXAVTGNZzqcZndo+xHrbX/?=
 =?us-ascii?Q?mZyyYgomxZ298mnNZuC8yl4W/4Y/jVAcSiHOMCFSFC0FDVwg1TTUnP0kaoUh?=
 =?us-ascii?Q?9ak0pwydC5yTuF/fjJ/S7N53uwpVH6vKZ6JSXgfBBD/01bidfoHcSbPxny04?=
 =?us-ascii?Q?LANZBINbElr9wU50sCw6jVy2Z73iXJqxbkq/eylu7lO4Vsx8dAM5jnw2NAdB?=
 =?us-ascii?Q?Cus5OREm6+7Gu0w8CVec3yiCBXgrvjtbEMzr0bIQLEwCCtoDnkRS7MrmSPi8?=
 =?us-ascii?Q?Xy5R2qBOVWOyuAYhfSZYqc35vvcAvuk=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63788d24-89e2-486c-2c71-08da22a9a46a
X-MS-Exchange-CrossTenant-AuthSource: TY2PR02MB4431.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 08:42:03.2241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tXyvzB0YDrb74V+FZO0/Ug+hVlhhRC7pP9M7SpJ01eVayLpAcpbQPFSIlSMK+NjdW0Fl/WZ7+b9ViCicPzQgdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR02MB3279
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

