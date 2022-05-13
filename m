Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103A752633C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 15:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381486AbiEMNhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 09:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380940AbiEMNd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 09:33:27 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2100.outbound.protection.outlook.com [40.107.117.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA3BFD1C;
        Fri, 13 May 2022 06:33:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbBQu4XcMN2/hRr7n8hnq8wKXgainasfy/V0Tj6POtXEjN8lVWCxo3Wd36N4fRXxe6y7B8gtGawvSBBXy9bt1tAwV5pfQuRmcTxMkEKrI8AuiTyPsSro7Wae1uTGM4lB6f2Er2ETgovxRDCyoms2mGu4XyJvWvxib4aC5icuqi0ZkWvFx+eGU/St1o9xxTlZEiyqKTPDs0PIjPZE4Pd8BoNoaunoXLbaaQneDM9ene2BQHQjMSmLoAkP7Yc8zXhd/q6r/ODNRALkQKYTfkXmPzOrUTU/L9zSLdrQtyuuDBR2rrWNoSvqu0Svzm50hf+/bsp1aDN2s92Ol/qjhuMsNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5O0tp7OZ3IOWiKP4vvKe0eOdrrh7OQcaxCHu7wZpPOA=;
 b=UnR72GFOU4nJ0QU6iMSsx3aHBg2WOu8kPelMfbxx/Q1KsKZ6G8qsr06EFcKt0z7CiWFyuJO6wnec4pV055XJci12sYXKT+pcncj8DzXL2N6uQaQ696cs9moxyKqJa+3gDIF8X8y7ZXuMxzYRacyZZFPtLJO6Lp1aFN7M0o0es2V9h1+KFQXzPSD2YAmjHc33vdlsGM1/OiohZEKmS46ZVW77TUNVtP5AQRo7kzaLrP/dCVWYtSZ5CRS2c+KrUE4siqnPNAh8HWA32Apxp3FhK5XJT5Kbsul+St1aW5cMimrkgZQRiv2pCmrcIQwG25KX6R53tuCuqPZ5+TbyBpYDgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5O0tp7OZ3IOWiKP4vvKe0eOdrrh7OQcaxCHu7wZpPOA=;
 b=XKEzqnmPuNPA8042snDOcJIhr1hLlySSWlErAdyJvnFlSF70W6AGXqtz8GiEzdqzCkETklhpwGLJnPNlXVSzNAiYJFR/UBB5z2E+P6s8rSfybpHcwHHpAHKXJUORt8MOA5bxcpRBRb6mWDzLGA6P4SYpJGHTGZ94smML/HfJ+oQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by HK0PR06MB2290.apcprd06.prod.outlook.com (2603:1096:203:4f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Fri, 13 May
 2022 13:33:21 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08%7]) with mapi id 15.20.5227.027; Fri, 13 May 2022
 13:33:21 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S5P
        SERIES JPEG CODEC SUPPORT),
        linux-media@vger.kernel.org (open list:ARM/SAMSUNG S5P SERIES JPEG
        CODEC SUPPORT), linux-kernel@vger.kernel.org (open list)
Cc:     zhengkui_guo@outlook.com, Guo Zhengkui <guozhengkui@vivo.com>
Subject: [PATCH] media: platform: replace ternary operator with max()
Date:   Fri, 13 May 2022 21:32:55 +0800
Message-Id: <20220513133255.58600-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:3:18::13) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f8086c4-2b7e-4a29-a8c8-08da34e5256f
X-MS-TrafficTypeDiagnostic: HK0PR06MB2290:EE_
X-Microsoft-Antispam-PRVS: <HK0PR06MB2290D2481DB2BD175A148E0BC7CA9@HK0PR06MB2290.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WKDqrGb1BrVzPbAkSr09mVhTX3DtrOuqCRafTGnRS6ts3koV+A+tXX1P27MpnNF04HzgmmLCo21VGAw7WyyuFCuOOl8tq6ElHXX0iZiuRGHsDN1uFMgrCBim7c6mbuIXtguB3VDHyP+tRmg/MXbqKY566grLpmAah5Tf5XzdddQMO+xiiYHTq4yWztSs51OeRZ6e8SOwi6byosuW8nZv+nw8UazRcCpO8kycxd885M5HtKsJk7tVIalwHSe76+7QEM0K7rW0B8X41U+GvF7BnaXSy6IGNoQzEiBU7bGxO86laSwYKxfrzTBYCsw0yaxKdnhjyyKBETcZ7wICXu6hnlUuiumxEbgAC+Wts78FLe/NtWnXbhdhpPCEIvRh7h8xMXactT/EM8qiia/j+jytx0RPOmgCwb5zb4t0Pu3Hag5qDi2v6waBYOMSq8r7AjODZR0yGEdINF7pUr3y+JdgLW6Mjrgb3Sot49pY0z+cvoSCCgkIY/+UnlGVYeMmp/lv8vup3hOIrHKGQNQjU+mbflZQYiWri4g0GsZ137lj6f7PpmtEb9nsWmpKmDC71akJgKhVuFJ4PtQ5NNfpSbj2Y5enQOJ/ONXqKcCHsc2rKtS0JLM50+xPlCpyZBnVzv+ragoAHHPd36m5w9l694Bh5CaplCq2IIAjl1DRHnAuxpU7VVz9aA4cv005DFuJT3NmuwISicpfK7ZPG1XEopSsPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(316002)(6666004)(6512007)(110136005)(66476007)(508600001)(66556008)(186003)(2906002)(86362001)(52116002)(4326008)(8676002)(6486002)(26005)(38350700002)(38100700002)(2616005)(83380400001)(8936002)(6506007)(1076003)(107886003)(5660300002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RqIGWKGG1f7oNk0u42IAbzoIb4m8RQ9QEbr1JzC7Y7PTFBBRMd2blpLjNFM6?=
 =?us-ascii?Q?/PHoIMIrHNeBfnk3YZcg/kTqN8YTr/Ah4mVAcdJrRdnH1SLA5NsJIZiftIu7?=
 =?us-ascii?Q?1vwv/o82VPy0E/HD9pQDUj+DQiWvx+oya5Zuagam9YFCJIqwGRKnoHTCaU5m?=
 =?us-ascii?Q?zY3bs/IoA5SKuQkhyWFPssQa/AlJpCQX5KHodDbbMLTdgw9Bj5hcjCQmHoX7?=
 =?us-ascii?Q?bOOSdRZzhXSH+zqbfTn7JfskadfyuwjXtFtTNEodcmzAUndh+7SIvlao5hC8?=
 =?us-ascii?Q?ZpuI/6fvcAc45EnHl4DvJEgEkTWSHNSaacZY9BbODccnwMa72/iz0eHLiWqM?=
 =?us-ascii?Q?tWiJ+NpCQh+k1ao3jayOktyH50HZvs2n0dW5YWUtNTDgaTmicH/u6T/QtL7J?=
 =?us-ascii?Q?ugouzEc9DLSJg/zgX6j3xw7lFVrJ7EDnQ1QjRI9yisCDgugAzbbWQjBwF70t?=
 =?us-ascii?Q?N8Kw+3OLhkCubP3KSyU1nFY2YFeRp9bAseA5XzQ/zjVDN0FYLxlMb3z72V4p?=
 =?us-ascii?Q?d4+qDgZOLSN9cxwDjAoYSYVeEnSnIcLPyzH8/6QrCSB1TuJ1Lfcr7AnN5Xxy?=
 =?us-ascii?Q?qTweQk2075NqDAbZrjf7JKtLsc9lF23DftYmxd08w1V+HHaVgnWhkzxF7qBa?=
 =?us-ascii?Q?IktwO6Opi6kOXg5o5PQGNQy+2DDSpN8TTWuRm1ztfuyqBwf3cASRfP3VD45f?=
 =?us-ascii?Q?sjrL1e38F8ux9zOQVwKeF9SF67cV4LKtH1LklFzCMv6BKIoxR6d5N5T0mCH5?=
 =?us-ascii?Q?w6/eD/hjRUk62wwKCtq3R/KlvjrUtsuocMTYNF9sSOgH3g+On5/1lyrvs83z?=
 =?us-ascii?Q?StHZhFdJSIRUIvLzJ0OR4iM2kplgnbPqdnR/3jDAxGpmf5k6gjK/od0J416V?=
 =?us-ascii?Q?4wInmkBJZpCpjqt97P7yt/BYeiVwRycFaqk9K0mHtXvnnL2LqvJwi0mSBYkm?=
 =?us-ascii?Q?cU99Qe4yQ57WxbFO3kZHGInqp2SBAuCEvqETK+yZp6sxB3Dmy1fc7PU3o4Iw?=
 =?us-ascii?Q?rsOetEjQM78if6tkqsEQiIEZJptU/mvedAWR151atwtkd2WjGe+kCsEPqUDE?=
 =?us-ascii?Q?QmNlxFoNBPbqIqVXYHgAqcGnDtyU3Bc9txmIpbnUQnj6DIzG5JaKJoSEWTpo?=
 =?us-ascii?Q?PZ/uGJmiXcLTOa5I4zWFunmeQDwaog0eehY/eqoTvYYwSzmSkO7GCuac9Wtn?=
 =?us-ascii?Q?LzWg52nK1zXoqw0LXwPnfr5bnV5kwRH/i3iOtU1Cex2HBYg77ydy9XJ5PYEZ?=
 =?us-ascii?Q?BFJ8fHuwDw+sdhQn3Fk44/Z5iZu4oW4DYVEFdoF9w3V6xHhOPDui39Cnrv7s?=
 =?us-ascii?Q?OrmY5SJAuHE8TV2XF7iQe3p3JgWyySqP80FwE5WEdNwpA6WR4VU2GuN2ZC3t?=
 =?us-ascii?Q?TUtPOiLVSXt74XGdXG3eBhohPYf+278lf0XmXNkHW/YKaZDg77lihgOMdQcQ?=
 =?us-ascii?Q?mIGXjgUGwA61JAPONPe2SJU50Jt8dsmEDTc3EbJ+UNqhaZX5ahUG90aCCFus?=
 =?us-ascii?Q?iZObMMh2G+a7aJnd+jefG7srPb14IGP+q2mQjXj/T9tqGQyO+l/Go5Sk25YW?=
 =?us-ascii?Q?Y4jD/G43wZ7HqydpwQtSGalmhYk9wwOraE8Nz1CjpmF37JeFo1DE8WJwjCBB?=
 =?us-ascii?Q?FzqdavwbGVJYtf7yiFLy2PjrQjmNPs46wmavtuh5k3l0OzuKdx3pgWMEh2hk?=
 =?us-ascii?Q?wbX3c+muO72lxXRDVfRsJ6Hcq9UOSEqLfqijS94NlKKthCwQo6H1vqwDmFBx?=
 =?us-ascii?Q?Z07hISyUEA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8086c4-2b7e-4a29-a8c8-08da34e5256f
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 13:33:20.9076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +rxroBcqKoBroGq1Rr5tAW5K4xCEX/tC+JNsjqFjsrV7K2Ml9GltPe0zSnEGQXSysHh/kS01Nl5HKCcEDb6qQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2290
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c:1712:24-25:
WARNING opportunity for max()

max() macro is defined in include/linux/minmax.h. It avoids multiple
evaluations of the arguments when non-constant and performs strict
type-checking.

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c b/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c
index 456287186ad8..55814041b8d8 100644
--- a/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c
+++ b/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c
@@ -1709,7 +1709,7 @@ static int exynos3250_jpeg_try_downscale(struct s5p_jpeg_ctx *ctx,
 	w_ratio = ctx->out_q.w / r->width;
 	h_ratio = ctx->out_q.h / r->height;
 
-	scale_factor = w_ratio > h_ratio ? w_ratio : h_ratio;
+	scale_factor = max(w_ratio, h_ratio);
 	scale_factor = clamp_val(scale_factor, 1, 8);
 
 	/* Align scale ratio to the nearest power of 2 */
-- 
2.20.1

