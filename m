Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA28151B622
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 04:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239947AbiEECw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 22:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239845AbiEECwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 22:52:25 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2132.outbound.protection.outlook.com [40.107.215.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC75B38BD2
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 19:48:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYrLhjqzZKk5KFdg7fmyhUPTdxgydbTiuxt+IO1Phd253188Xuszj7dX6JM0ytJfNRcmc71R5NGCNqwpvDXb0bTxp+eklnOkZ7JxWm/uDxWYpg2D616voAVR/Q2+/HVqgLvqE6sGLmyljYF83amlCJbHIEO8zuRUPyZYDWEtwmC/ZTu1GdXXaGg8u7U8my3Q3ZlrAa7JKgWWYvw6HhgR9QHK+rQv7YLd/ombMA7Nii6u6miLlJGQlfAzFGYgPR49Wbx9FFePrxaFP1HEzPDBWNJLU0qlwcFSYuVOYyZ+124InmyDeMv+Cxo1YAi1A8yajqX3C6V5j3CmZ/NkQTh65g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29cEpcULozk/DLGSFSaBmoYeA7CdkEc96lJ3cZ5ZHCc=;
 b=CZ1l0oU+0UjSKtHpSnTXRxLA22Yx4+fd8aiiIIL33hVvjDihMOuQdiCXAUbe3MfrORF5Y5WyLWyPpWkvI1qGHEN4epU1K1lc6UVGCqfu4eb2y8LJ5Qkib2oYV821ZcCG5rCxj0ixPBz7yVBKfi0sQXICpfmwYElh2hQMXZc9TuWcjaOcSjUt3n9SiSJ5rsSztWs0SPXuyhOdrqjS/MsbrboZ1Ukq+1i1QDzrd4UXP3acPaUjAMiWLOvXXjcFkEnHFGmqG6TCgWMDZAZmqCw1ZVm4nUYes2qYJAYdN0aYEl3XQ9QZO5rBgX+cWC1ak6cYZg6HS8YxcFlCk2LSv9c8TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29cEpcULozk/DLGSFSaBmoYeA7CdkEc96lJ3cZ5ZHCc=;
 b=Lhhq5AkMHY05O9HJQTGcL8oFAFcRO9K/AuVRH3iho31JjYCq67J1IjYb8jjZN/XXQ9bKuQ5tksMPaXzPU5+JFvF+0HFBX3I6eJ/3B7iTlvY+fCQHktMA2+hzPUtjnMK+Oh+Lx9GALAoWSBmuJP1+OmIwXYX7DKzcVNl5DAsbELs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by SI2PR06MB5138.apcprd06.prod.outlook.com (2603:1096:4:1ad::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 02:48:45 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::d4bd:64f4:e1c0:25cb]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::d4bd:64f4:e1c0:25cb%4]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 02:48:45 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     kernel@vivo.com, Yihao Han <hanyihao@vivo.com>
Subject: [PATCH] soc: ti: wkup_m3_ipc: replace DEFINE_SIMPLE_ATTRIBUTE with DEFINE_DEBUGFS_ATTRIBUTE
Date:   Wed,  4 May 2022 19:48:33 -0700
Message-Id: <20220505024833.8494-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0079.jpnprd01.prod.outlook.com
 (2603:1096:405:3::19) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbaf26d2-c6cc-413d-fbad-08da2e41c5c0
X-MS-TrafficTypeDiagnostic: SI2PR06MB5138:EE_
X-Microsoft-Antispam-PRVS: <SI2PR06MB51388A161B96CA34F4290EF6A2C29@SI2PR06MB5138.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: itE7YnMXYlCDwym+J8Lv1hVMcrMZfwht8ak2D2Co1ZUzaGY/4o0bM/x4PxxH9iGu852HhiixgTaxlc1EPhmlvKJSpx6yDyq4uh+gwOYNq82Bm/c2h8s36PNXKuAW/Cy7W7nUxK+fYMt0WidlgfVhUD8UUjVqGfqi5dBsvx5R8B+p9ktqatF/kSURZF+sMlpsaVcnY5kAuxI6oS9pO7dhWIUlppYFlK94lafER2Rag13015A9INznvL6tF0EAGU1SJLNMch3PeN0sG5rgDGozBJNa+nxZn2nB4956DEHvpW1kL6f6a7qJdoeNnlQXMRgasg+BmqTrG+XVzpGzM9Dgtfj/9uaVbgfbcxgrmr6g1mz28d8waC4DSuvRLLIJx+VJ80E03nUNqdORJvUcL7MmIVyFk0sY3K0PdIB7NX9b5+mwehzAP89CkN2dTe4VLfzLJ95MyQXkfyYm2LwOVenQ2TVclpViIrdmT1ktJXWuSiqHec2pIuSgzuLrMj6wtpiBdqU2McEDhVdckIGP/cN7zOnucTLcnq7XNeXgICT7PlUsWS62OntPJ8lcvKLsABVnTL9FStTIBWB+CPLkYMIVKmXgm0INRxO2IJql9ihTD4xo1girPaltw3+5F5/cJofDH93dvGuNbB7WSJhMWEqqUKkPHQsmPCehHzv/A/R/uuB0BuDrTVHWqydDREMSqWkIJ5e1MOoZctlf2bxNn7JZqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(5660300002)(2906002)(4744005)(186003)(110136005)(107886003)(1076003)(36756003)(8936002)(2616005)(52116002)(86362001)(38100700002)(316002)(38350700002)(6512007)(26005)(66556008)(4326008)(66476007)(6666004)(8676002)(66946007)(508600001)(6506007)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gObY+ejThnBfdebGI6Ja1k+ajSnpTmVlsXWiYSZr9LET4fORBrNkNCDBzdQD?=
 =?us-ascii?Q?Mfiy10U8VpRNNW99I9aafrQu2wOeQAQWrcx69FiROCcgPzsk4XqQF74Dadkx?=
 =?us-ascii?Q?GT4tQEgRBttzwFNjX1ijPQBnp1y4cpQqoBaGD4T1i2HUlDoR3bVQv5ZD619f?=
 =?us-ascii?Q?pIPzfxaSNeakaI8FNHKAxOz36/3zAk4FStzY/M6PVz1Hi3BYi2xHXrjwO8Pn?=
 =?us-ascii?Q?+Cu/yIsyJMsLCitB63Q9hKnOR2E0yMedzlr1Yj1ta3yNuF1A0VCU1PeGl7pj?=
 =?us-ascii?Q?tzv3Dv05HIsp9QA/aOCphR/yJPF5x2m6pAFakRUE5ZS5VWBv/kWNzIF9zxts?=
 =?us-ascii?Q?sZFX0ts5FIcb7WSRI7Gao5O7o7FBKty/6YKx0PTRhQ0u/L1fy0+emToDyGAP?=
 =?us-ascii?Q?HnqCUG2xgTul1CE17ycGmKOlrzGy5VMwSjU2tWYcE6dlArvIKsIRkcALlOA1?=
 =?us-ascii?Q?X0EbdeSD/s4WzyS9+xA+WI7p+KTyO+eKv3RAOLqT7FKr/HIyNqMe6sOiRLEo?=
 =?us-ascii?Q?8/bvsv2DrOM0dvXp8YSphhnye+cHKJf0eDdKXuOx4OyDQ2NK+n7R9lxEj0Hj?=
 =?us-ascii?Q?5M+cBGi2C6wJ6i99VtHe5Jc/V52FGS6sg5HudLAk2sbOGIZJ0Llwn/bOEUG2?=
 =?us-ascii?Q?L31O1PGW/v9OiDDYoz/ZsLpGn8DGlavtT9YGISPVFAAPXU6DpeRlAVhFarP9?=
 =?us-ascii?Q?yO4WVrKVfZhnb8E+QLbMP+5zABAB4H8UjJzldhi0zvcbKW4VWMdh3+EE/Tcz?=
 =?us-ascii?Q?vzsq3cPZwyTiP56nxoDNcHs7a8W1PGFLAXUGkdxTBl2YrTi7d2ET8NP2MjPo?=
 =?us-ascii?Q?IlYQIgzaaQe7kVtG0fua5eLFLCFb3F9+T6TI0UB2sJ1/mWSJxBaicKv74fpg?=
 =?us-ascii?Q?13zefGYrjl3avj5s+IdVMVpMKgcrEC+5qnIYBbbEW+VsCYL8Oto8tmK1iLEi?=
 =?us-ascii?Q?XGy/kW5+uoxr+kSupPFkQh3f6qkOP9aMpmL+q28gIyzQ+5mU4Fyt7HwFxmcA?=
 =?us-ascii?Q?lTQyd4+Q5AnX+76KYmM2Dm/OWXn+YJ+J+zIHhGQK+azArg3J6lTgru2J2Mmq?=
 =?us-ascii?Q?RcPtcqiLiuZcBFUWbNlwabbTu5ho+oRl74YFjnUgHseWYEkP940bwjTTaFZm?=
 =?us-ascii?Q?O4qlT+wxPeLwaqBF2z2uPvk3ySYjB9KEQ8mzlAM1jj/JezGBBG4Nu30LFuGv?=
 =?us-ascii?Q?DJ/wyo9kjUgiLI91kXq7BN8DvoYziW4EkJCqRApKIN3qYjnDaUrAfgA7LRo8?=
 =?us-ascii?Q?QuUsIy6wArrxW7WTgzrYRg33TwbqIsJobbPXOUQWxr+O/b2XdSiEcFxIsywb?=
 =?us-ascii?Q?jo6roGRI/Hr0xEDs0eIdYSsX/qTce7C/eresDHuyBYsUOm8X8rQ2sC4Ay/4M?=
 =?us-ascii?Q?qkSQ8zmJxgOOH8P8wYeseVoju1Jl7rLGVCBLT/g6Q5PPW+vgV/dSSdyfAzxl?=
 =?us-ascii?Q?ucaDszTvUNngJgMFuCPkhAN8m/7+SS2Q4rOC3gbpGvXpycBP1i0UMXAR7xFj?=
 =?us-ascii?Q?VUmZR9vb+Gi4OA6AnQwgrAiY2XD8H1U+CBFUnkwyqJTic4Prllo7/SRjEPTm?=
 =?us-ascii?Q?RwII4scRlN75LEJ5jY00n65i78kde86c7Z58+eqgByoSB2wFum6foThOzrI6?=
 =?us-ascii?Q?7h51YwSOqp3UmfE/u+x8FtIk0xU0ob6PNQm3VuOo7fcHp0aMybkWtcjS0S/p?=
 =?us-ascii?Q?HQmERP+cqTUSrF4CxO9PW+Akl+mUNtJlJETYHC12DGNER7+TtqHxW5gUCXVJ?=
 =?us-ascii?Q?QF8a08nd9A=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbaf26d2-c6cc-413d-fbad-08da2e41c5c0
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 02:48:45.3419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1A0cLyeDklpFeb1FyxFZeQL5H+VfQA1ghGmdEv39Mj13aLffGDGyKe+BnxTOr0UDtpvSXF4e+bVOqxGzaUanWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5138
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:
./drivers/soc/ti/wkup_m3_ipc.c:198:0-23: WARNING: 
wkup_m3_ipc_option_fops should be defined with
DEFINE_DEBUGFS_ATTRIBUTE

Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 drivers/soc/ti/wkup_m3_ipc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
index 0076d467ff6b..2142d8fb3f5c 100644
--- a/drivers/soc/ti/wkup_m3_ipc.c
+++ b/drivers/soc/ti/wkup_m3_ipc.c
@@ -195,7 +195,7 @@ static int option_set(void *data, u64 val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(wkup_m3_ipc_option_fops, option_get, option_set,
+DEFINE_DEBUGFS_ATTRIBUTE(wkup_m3_ipc_option_fops, option_get, option_set,
 			"%llu\n");
 
 static int wkup_m3_ipc_dbg_init(struct wkup_m3_ipc *m3_ipc)
-- 
2.17.1

