Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46293506594
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349014AbiDSHWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiDSHV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:21:59 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2132.outbound.protection.outlook.com [40.107.117.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BA72E685
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:19:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kk4WCzcS8rGBw0h6nAd4ApTqoyvev4RC8u1drPcMJZUxcxgqcAOjNhRZ6s0GTFDUhPeEKgu3OzZo/U7wvap694NBZ/uhbpllww035GJcSc+ba780rfm4FCqdYXF8vepJ2WIbqjY2oopqNYveLJ7+ZGY3dNOMndHztKNypDobgXs/cPHZwx8RRfZDvIEMOYMGaf7ISLvIbinB+7pDhGxQ72KXvm+B+E8hepRrjKGIj8aAnqOmZuVU2LTIrLuiQdQptTI3oB947e/si+a7fHLSIqRY8sxVcWzAQaTasrIPMCmvL5GZuRS0hsktlcRwQiVVGkIGzIm1cF68yRYkHHan2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRy4wwgQTREZYJVtVS97zYTJufqsybFOgKNazQ1Sk6o=;
 b=CXdAB8WR2Lu55m2o/vrcOga5yxSUsSFZUhxwywTVmNowawDZZnO4BzjcULDSpyv0zkI+A2CcY8oWetLFvtRWgsUgl2yLkurBBPJhdVa5YVMbfUoTjSUxvaraRhPyhAmpydafmyVq/uyfwkfjdJYur/QHPKtltP0UvI0mD3ZACsp4bOCkRxLsZa5NI+cpBcKpbG4azlu+f9s7cR5wzt2snEm58LLCRAhOuhuc+iZGS3JhSr222ctP9QMNfSVVxsPxCFOz/zmoZ0yapnS6yD9gILtaNNgI6Z5IMoDWQUvYdcA7p5/fPIbXNGVYTYwWbANZ3XV7w+znBuS6VbxutamVeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRy4wwgQTREZYJVtVS97zYTJufqsybFOgKNazQ1Sk6o=;
 b=XYtOG7xsnm689eivML3Zbfo71zZXJg+7NHPh0Ugs9ANnLLulH1F4B8ibAM0Mr0A1Bduw9JqwNBcPAkiLdg7TCs1evbF+0y2tGsqzMl0xTjnyZJMDMkfrQfiDByUIMrYcUbPNSPvdb273GX4800AU57RROiWzI690dNlyCShDAwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by SI2PR06MB5338.apcprd06.prod.outlook.com (2603:1096:4:1ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 07:19:10 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::5aa:dfff:8ca7:ae33]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::5aa:dfff:8ca7:ae33%6]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 07:19:10 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        Alexander Fomichev <fomichev.ru@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        ntb@lists.linux.dev (open list:NTB DRIVER CORE),
        linux-kernel@vger.kernel.org (open list)
Cc:     zhengkui_guo@outlook.com
Subject: [PATCH] ntb_perf: fix doubletest cocci warning
Date:   Tue, 19 Apr 2022 15:18:50 +0800
Message-Id: <20220419071855.23338-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::15) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e57febb0-b5a3-4f0e-641b-08da21d4e5f6
X-MS-TrafficTypeDiagnostic: SI2PR06MB5338:EE_
X-Microsoft-Antispam-PRVS: <SI2PR06MB5338A43FBA247C7EBF6141C1C7F29@SI2PR06MB5338.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LQvN4FWkjkF5miK32ntVsBui7geHSwjq1718sacc07B03EBZFAEWYJyWwZGVB/NzEk+qTS/Mv1TJCYKfCTLZulVz+UlvNX14lPBcT9ted2Gn7+dY5dpXR6L2sKIXSn41IpOJs84gXAu7Ege0OJy76VclewClM8BfLfpXxbKaDiHwcHHrWhGtit8LmGztxzZA15cjHpr/cVYbrJpKVnJVrLTGWfIMNQRB+Gza8N9RHjkFEjw2LQiAomam2fx+THZ/ICOyxdPv+DUuXA7nP/YhmyvHc2nGgW/Pp9ZBSA2nh5kWakImykbXwSHf3cRtnYmET/8G9vsQt2MZoJ2xTB+v6ia2CFVp6XQJb3HwH9Pqi14PByeMp26J5LeEpMeJ/7WH2Q749aSyGAR7B73eAKHmugF/wGin6iszFUAq5+/P1BVbJmuvV4xH/S9xQ+LcmTlo4Mp2s7Jf371yDaxaIX3DKC7sGTiDhAfZDGy9QCR5UIM6XoVkA2CwKUHYp0oOhNq+S3s8GBTJNCrW5MzGmQoKAK1Rn2UI4B7OGWwW9trt8CPUIwam17XAzjHDZs5e3KdDrjZoSJEYCgXRe5/vghkxIM7pJ4aXaemZ2iWWGbq/gkPrTmgL/gNWxLBkBVwHlSjmgM2oqEzQjsBZPXBfM4WLtuzV/flokYuUH48YxGgb1uEfBqpwqIuzGJrM0ZITst99eKALFWYSriX+QVy4Ap5NSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(186003)(26005)(6512007)(6666004)(52116002)(6506007)(110136005)(2906002)(36756003)(8936002)(4744005)(5660300002)(38100700002)(6486002)(2616005)(83380400001)(66476007)(66946007)(66556008)(508600001)(316002)(4326008)(8676002)(38350700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?greOqp8YTlxg88EDiox6GEFPHfz4QSAzZE9JO2ghgCGC0AANCP3aLgGV9leN?=
 =?us-ascii?Q?c0RRLyCVw1W5AD7aERvvx9mcFG0m+bgyTulrhD9n2YkF68u9eaamwrrnvs4p?=
 =?us-ascii?Q?bKLpT+33AGNO6XHXD9o9fwczse5vQEgxkzKJoqYaIxym0+K3EEWEk1bQQhh5?=
 =?us-ascii?Q?gWHqfCthHh61YuzCAoCC5U77K6hBlOzXAqd0GnETl1IJIe9uTfJEX4vk2HYN?=
 =?us-ascii?Q?ZckUPH//cjtU3HrpgXKDhNrvAQiKPDffc/1r2m7Yt7TbsCqdirtA1OZ3qZAj?=
 =?us-ascii?Q?imJGM+4WzO9zeeytLycX9RsYXn95A4qg238IHyUTdVIZ4UxurJBv0DUJjcl1?=
 =?us-ascii?Q?7ZZWAWOwNIerOJKAm9dADnSq5AbQs6Uv3Lofhw1PjYiwNSGE6P8ru7BMz7rG?=
 =?us-ascii?Q?yzz0TY4G59Y2rFveoy63bNkoBuIdWC+BaF1H5wrSHTWDF30VgiUZzgHB+p5I?=
 =?us-ascii?Q?bQAjfS52WfqXNG6svL+JeOpQDoY2uP9YbuZ1krpLDUokIEtnM0XF46902cHe?=
 =?us-ascii?Q?e9su1pB8mQhX7xx+AMkWVXxDSYB48kvy0inBhlQjmzNhZ1/QPgFmSgo4PgC+?=
 =?us-ascii?Q?lxHsMvhgqB4pRXp1o5hb3u30QtT8HdO9njDa+w7alJBHLO8How9m3NNKqvMC?=
 =?us-ascii?Q?M4njDa0ZAxuToS6J3qBj+wKIDZ7PXtXwB8qXaOpMLStAd20ElWL4GmXJRVLi?=
 =?us-ascii?Q?mZZqnKx5Zjj/apR7/u2Ykx1ugcx8zoNhovwKOgjASfW/SdDkFp2hSvZUc4GJ?=
 =?us-ascii?Q?44hGdwBmUFZvtX5fLG/DBPa40oZzRtqFVjPmjSjPsL7mnOi2PkgC9u9PqUn7?=
 =?us-ascii?Q?4QbxQrfvjon/MqxsZ9C4t/5dtskbmTwLDAiieSCiPxxNw3duVOr5msHhvVum?=
 =?us-ascii?Q?XBiNWmBAW8fAxYRLyJMUgkEjr8IkTVoXlhmU/USGrh+2loIhiGgTupAfP287?=
 =?us-ascii?Q?RNnTNir8ZPBCAtAVQVgNEpGgiXDwUUNPUAjkUuD71jhTwnFg0/rmzPVOscBA?=
 =?us-ascii?Q?Utgn775MYeMdAAMMcIbzAZAlyYnjGo6W5m1p5SByfogPjVKkqs93nYday/yb?=
 =?us-ascii?Q?gh5lya1QesPaWuxH9QSa/5/2b4tDDrC5xEyEiW0XF2BGqFL07SBW5mvGIbo/?=
 =?us-ascii?Q?Z5Yg0rmJGYsGrDm/wuD9YGZKRpEQ/6pVWgBa2eS1D2hCA7zyFhH3DcIjS6yr?=
 =?us-ascii?Q?D6KACPGlc+jkPzOxbKBdLQ/iDuVdXd748e8dSjcHvZXL3dfyVC+QOvZPHYrq?=
 =?us-ascii?Q?KqnReKIsQBVPFYOCu+fvgYLdO+O2hLayLzcPW3/kXfDd07pwwuv12/yCEIB9?=
 =?us-ascii?Q?adRQ+WmEW5r7kMUwh99ZPDh2y0cDvWkrq9V2u95u7fqwnKn8aeBdbf4u8Ciw?=
 =?us-ascii?Q?UCraL2wntEQ4ge5o5GOz/yGyXJdDFptY5lxlb6USsoLBXpXemUIbD61cR5NL?=
 =?us-ascii?Q?Ewaqddq0GQZfAqC5jQ10ZhpWjJ2qXAfBITXXzo8pIVrJmOM0D7mgAPT1krRp?=
 =?us-ascii?Q?cKEQaq/ITzrzLngjD5yLMXIOtVLbyDnVjWRqpuUQ4xoSc9Av/wLtZ7vBs8bx?=
 =?us-ascii?Q?D8Qx/UC1tLzGktZruRjTZFatLapxDoHFBNo7XobL3/bE8mn43wfGo02AxyiB?=
 =?us-ascii?Q?8/JernqtgFf1TyXgk5JgiSp+b3lk4M/mHyWOY4MjLv4EgN2p9CYw/DuQo/99?=
 =?us-ascii?Q?rZ+doyUqZ7SeGEu1E/D8x12iViqiHjmBnTHIfTRVMxjCwm4xWZzeGyLkEi1q?=
 =?us-ascii?Q?XqFTli3uWA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e57febb0-b5a3-4f0e-641b-08da21d4e5f6
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 07:19:10.3290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vfprBTL2KYbaDbRY5BmUr0CemAtHOyG4IyXWdCP6E3S4SEU8k/BJCJpw5pyrAIS+W6tSeccdR+L1XkuFQe5R1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5338
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`!data->ops.init` has been repeated triple. The original logic is to
check whether `.init`, `.run` and `.clear` callbacks are NULL or not.

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 drivers/ntb/test/ntb_perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index c106c3a5097e..dcae4be91365 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -1451,7 +1451,7 @@ static void perf_ext_lat_work(struct work_struct *work)
 {
 	struct perf_ext_lat_data *data = to_ext_lat_data(work);
 
-	if (!data->ops.init || !data->ops.init || !data->ops.init) {
+	if (!data->ops.init || !data->ops.run || !data->ops.clear) {
 		struct perf_ctx *perf = data->perf;
 
 		data->status = -EFAULT;
-- 
2.20.1

