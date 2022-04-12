Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68E14FD95B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391432AbiDLJ3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385036AbiDLImn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 04:42:43 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2080.outbound.protection.outlook.com [40.107.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB41F5F4EB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:10:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vfp6DDgXibft5dACBOY5SUgY8LT0eLVCDIZqEfMzNpnubnASOUmhGIUn3ktZQ7ysrMFiN+U9noGk4THSNWMwb9jRq+rfuwBa5sQo6aP4GJIBFG9DdUlK9SD/MhrtvIqJzfmaPX0/zO+6rIfJgO1NHCByMBJqC3tUxhfkUajoNL//UjXh+wVw6AVTwRkbV249ORpbHhamY7GmvCT7VaXD5PaY61WNFGNNiPigsoAAhgvjHd0BuaNKx0QXvcrYASSOIODI5isAUo1k2Cj5RMeD+5rVtQBm0dIcwT81ZaZ2MBkdfgMOOMEm0pdsoCq61au91vazhI1XnTtcWZWFWJSQ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKiCCqBRE24H1k2IX6n6NDE3wmGhVUF9ebn366Uz9wQ=;
 b=QMi4vAoSg445Woumo4W0Hb7/klJWTZxpbQDQhMTxOVxdQUvcndCD9UNsWYY9UcGPL/tm5EpxaKjZA+dStzZLp3xvG1PyomHoc0CTSPbUrFvWXZmEjeqq6c5UzVfJfu2Ons4PmlXKubemHS6IAHk5JtyAHmz+zzn3vftgPMZJGgMNCfRkiWr5oKCnjJsYbh6QipAUVVlXDpWdJEl8wN557OS1+9j4LaTmmiVFkw+1q90BJnd4cReaizc7k0kb93aKQJiyNdIKEpvel87mhsdEPTJF02IYfB7Na1Z2ZYwZ130zJPQ6qk0CiZeE9sLun2F9axxiVkvOR/oML8FqRRDzaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKiCCqBRE24H1k2IX6n6NDE3wmGhVUF9ebn366Uz9wQ=;
 b=lV9Bz5Gyh2xZ5MwP9v5bLu7TGVlsMv1rKhxIrCmO2+6t8pvuP+VoEdXNPDGslX6u8nsZ0lox7hTJSNuMOn28Tz0qz9T6Ypyf7Uhm8YSjfBF+NzCuJ+1IlsQJxBtBhH1lUYwfPHqi1o2AO+bEBuAmyXr9BUPfQLh/P11ZkYSzlJs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from TY2PR02MB4431.apcprd02.prod.outlook.com
 (2603:1096:404:8003::13) by HKAPR02MB4417.apcprd02.prod.outlook.com
 (2603:1096:203:de::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Tue, 12 Apr
 2022 08:10:36 +0000
Received: from TY2PR02MB4431.apcprd02.prod.outlook.com
 ([fe80::8179:176f:a62e:c998]) by TY2PR02MB4431.apcprd02.prod.outlook.com
 ([fe80::8179:176f:a62e:c998%5]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 08:10:35 +0000
From:   lipeifeng@oppo.com
To:     akpm@linux-foundation.org, michel@lespinasse.org, hughd@google.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        21cnbao@gmail.com, zhangshiming@oppo.com,
        lipeifeng <lipeifeng@oppo.com>
Subject: [PATCH] mm: fix align-error when get_addr in unmapped_area_topdown
Date:   Tue, 12 Apr 2022 16:10:14 +0800
Message-Id: <20220412081014.399-1-lipeifeng@oppo.com>
X-Mailer: git-send-email 2.31.1.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0003.APCP153.PROD.OUTLOOK.COM (2603:1096::13) To
 TY2PR02MB4431.apcprd02.prod.outlook.com (2603:1096:404:8003::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7222554-37cf-4c64-dbd9-08da1c5beb41
X-MS-TrafficTypeDiagnostic: HKAPR02MB4417:EE_
X-Microsoft-Antispam-PRVS: <HKAPR02MB4417A59A9D1F06E931F8FF57C6ED9@HKAPR02MB4417.apcprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w1T8XdE1FVfjUzad3kQOMGl4KWhIxq1kBl0Em9fVjqpDX87+3XBvd8+hNyC0QRtejlA+HUqvtPmu653G7TaoN1Jh/81j9BdrxgMMBFEk4ondiA+xtDq95lxbAufW5fsGF30OV3hDtGwBs2al5Dj8VEs/sTdvvVttcuQLf08po7O4JiXvtS2nnCKnyEq2/7guMz5P1UYA2ddHwITdmJZTxnnqbEtgqnZ26kS8WK7VK3yXUl82cHKvMGQozIOhKSXfPtW8/LX2PA2Oq/rRQArvyKeu975P/MkOeSnqCaAlUKtCC+BXRoneD9BUui/FSgCT09rpxE0bUXuEQ9lxNx4Y6ywS80A0bg3hzU1VyvcP2qyqho+dr7Jh4cr10VT9wiinEZsuIuRbjaitoNwDhoaAa6Vcz0jQF0En3F5kOz4fDrjvj2Zw3YmQqwp1jFFXTOFTFmLjA0D98d04AU1W0K5LLLZ36gjn+F2oiEHhZmfzSdGyXa0eNHXAoydGLnwO5is8Nq6kmqwCGYqwK18gwzHUkJJZkjNxKMDdaj12U7oPso4u8cZpjHYq32d+DZ9krOCen+VVa2XlmAYkVKpkQvDtvioVjQBuDJaIqrnvJcqEfuc0+lfkc4cWTmbe/vZUKIj2mP3RyE5F84RsvRYYUe9VRZ749FG6X3vwP7W95gCVq50atnX7yknPZTNQ16Qcgg32dsNI+0QnwPtSPG3lzVdZ9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR02MB4431.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(5660300002)(6486002)(508600001)(83380400001)(38100700002)(38350700002)(2906002)(4326008)(66476007)(66556008)(66946007)(8676002)(36756003)(316002)(86362001)(2616005)(9686003)(6512007)(107886003)(6506007)(52116002)(6666004)(26005)(186003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bEHSsrDDG+2Ylza5gguxxzwH0fHVeHkj9GlPqnwj/xifuF+zF/kYGjfm0ypU?=
 =?us-ascii?Q?XfqBCexlekYgDuYx91qpedYsK866WOx3Zb9cnXaIpnL3NUrHfDXEV6NLTX2N?=
 =?us-ascii?Q?sw5KAzVdXUifFyCjw4KjDQjckUQjbiyhhyV5+aH7GgZwkyPj8QestDT+LxXE?=
 =?us-ascii?Q?lloAs8MG3+rgYLddibsSCjloY8W+JQXPGOClJRYDwjKLVk6ENLosq5bTOmyJ?=
 =?us-ascii?Q?WCqJR8CKIbvHVqhhDpqiPL/FSFbn13ruikFr2NlJh/+YOlLrkMUZn7PO0bhq?=
 =?us-ascii?Q?KUpVZ5NGsGKCzYLY5u2PUMe6PeUsHZ+iqjXO2nrLzVH39ZpjcI/NH6WRGe/Z?=
 =?us-ascii?Q?27gmi6eTzVwwwlHLxdLwsvD628S6JyxalcEJaykFvAG/lHXD/pIBSkcrLKjJ?=
 =?us-ascii?Q?a/qC5wZp3KFcrNtgk6IdBmonVRzypElpOZ+l3lx9yk7UvldlKka2KTEcoDi/?=
 =?us-ascii?Q?xyCE+5YS1qmv+tT5e4SU+LXZZkQJonHZcWDMQM/Jjvwsd2kRe6DLBGzZrYH1?=
 =?us-ascii?Q?U/UH/uOVtOA1poEJ7XGUHgw0nUkt7xr2aXtt42HYuLitNJroZtc/zjiJ24vd?=
 =?us-ascii?Q?pBhlWpdmDjRdM/pq3823tkoMbX8kc0MeFrtNaaxifDcMAqo/qIGjI4mI4EV8?=
 =?us-ascii?Q?zUxrp5gufRYQBkaXv00MIhxCdGeVQ9cD0GHYf/2cXJUW2NEMY/dI/gbmC5yb?=
 =?us-ascii?Q?uJxcX04bPJZ2J2230Q6nLfKk1tUfOXyXgeRRvuq8eAv45KMgVVcPeekcRmzM?=
 =?us-ascii?Q?b7HkHn1J/lXeC5zY215S+ITS2gqfgC/O7TNhrRkMm7i/M0pLhcORHZ+XsAw3?=
 =?us-ascii?Q?eebwqTy1iAzTu2Ek+dT4YB2QiMChqT1pBYvbK5c2IJykYWFA9WifeiqTdfgI?=
 =?us-ascii?Q?Le9SL6VFzR2tfNv4nket0yV4k3O7WbkYXxGDp1qagJMLG2N90GrR7Y8aMRap?=
 =?us-ascii?Q?JmIJvS4p6IUA+LUCbp2zDsZbxFMaG5x91+0Ppb++OeUeCgZkFirlkmektJKk?=
 =?us-ascii?Q?XxidfmAQieueqs9yb/HwAixti+Efol/ZeVAeb0ozUrrrpzaf4Epir9CSpWP8?=
 =?us-ascii?Q?IUiqkhbvpgijM2bXaxIgY3rF+4De6ubBaDrbaCaEN/IDnxq0YkheUajhQzAJ?=
 =?us-ascii?Q?XRhfc0RVKMa6cHocxaV01NQJs/yHE2oFJdpoUm1fCmb14B4hRm/sxrc07na2?=
 =?us-ascii?Q?6Ffea+GgfHadmOREnQXNz4YYoxFT9zMSibCtIkOkAXsUXDbP8Si19f7ImKif?=
 =?us-ascii?Q?le84W2Qyt8OBggLz31ym83FI3uDwHlGT435VwjFrfz3YKusajiDkd2248y00?=
 =?us-ascii?Q?Mlo/2otxL48hDfTmhonAqwwn1wTFgJgkEEDeJ6WbAfx1WQNqneYHG2/kxZ0y?=
 =?us-ascii?Q?GJbu7CXaQIwS1BD4CDag//ai9+m22m6SbZz+uCUGq+emS39F1QULqhdYkmz7?=
 =?us-ascii?Q?fzxVLN0SVfN2yoNjI9xDSCm6eyi/7id68RDuDK4gWQgOc1LRII9fK/gmcKTi?=
 =?us-ascii?Q?J+Jq5TTk65AMdu2AV5B5ffSbNDVLXSSGaREXjv9ruASaz2o8C4BjtwbMhcFY?=
 =?us-ascii?Q?Qunu2w4WvC+z/epi3cZs/CqPvrK/2tXnGt8Qy1ba/H3FemnhnP/53wUEhShk?=
 =?us-ascii?Q?M3qQTjBB0TQPg3Cdo4w2QXEm60J8jmrXu/F4nErL/OTNtng6qUiqY+dxcbg1?=
 =?us-ascii?Q?HsHwxVs/gCmlSyan8zP9a2y8oPTPWSvLj1sJxeOOSANYYTIED8AoR68HPrEQ?=
 =?us-ascii?Q?0odo0XWkCcLENUqBk/PMdGbTm3KWGT0=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7222554-37cf-4c64-dbd9-08da1c5beb41
X-MS-Exchange-CrossTenant-AuthSource: TY2PR02MB4431.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 08:10:34.3565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0hiTfLjoY4tyeuAH1YYWOKz/1ci28un/Imnh9/aJrfot38/Cajw0CwKg+y3DoF73MzibCeO/KA+ULHMZrbxkmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HKAPR02MB4417
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

when we found a suitable gap_end(> info->high_limit), gap_end
must be set to info->high_limit. And we will get the gap_end
after computing highest gap address at the desired alignment.

2096 found:
2097         if (gap_end > info->high_limit)
2098                 gap_end = info->high_limit;
2099
2100 found_highest:
2101         gap_end -= info->length;
2102         gap_end -= (gap_end - info->align_offset) & info->align_mask;
2103
2104         VM_BUG_ON(gap_end < info->low_limit);
2105         VM_BUG_ON(gap_end < gap_start);
2106         return gap_end;

so we must promise: info->high_limit - info->low_limit >=
info->length + info->align_mask.
Or in rare cases(info->high_limit - info->low_limit <
info->length + info->align_mask) we will get the addr in
align-error if found suitable gap_end(> info->high_limit).

Signed-off-by: lipeifeng <lipeifeng@oppo.com>
---
 mm/mmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 30e33d3..a28ea5c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2009,7 +2009,6 @@ static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 	if (length < info->length)
 		return -ENOMEM;
 
-	length = info->length;
 	/*
 	 * Adjust search limits by the desired length.
 	 * See implementation comment at top of unmapped_area().
@@ -2021,6 +2020,8 @@ static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 
 	if (info->low_limit > high_limit)
 		return -ENOMEM;
+
+	length = info->length;
 	low_limit = info->low_limit + length;
 
 	/* Check highest gap, which does not precede any rbtree node */
-- 
2.7.4

