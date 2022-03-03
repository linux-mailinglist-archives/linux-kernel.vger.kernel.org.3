Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C1B4CBDCD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 13:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbiCCM2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 07:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbiCCM2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 07:28:22 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2106.outbound.protection.outlook.com [40.107.215.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF683EAA3;
        Thu,  3 Mar 2022 04:27:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmq1srDyZllLnFFcyyL6ehtgp4HFmWOV9R1MZSIlcZXRoQPy4tzqx2DDCruzCWSkXEDyZrECUbfcmA+Uqy6kaYHn951xKhP+YnUmIgnywV0ZDtVgxwLOUgKSYOpsi64fggaw0d4liGw0MuSHaB0F/asRs8qFiXT+fzUD7GnYDD9o6X/DydM9OvJ0yYnNcwflUB2N8hLSLhm/nUHdt7aadve4tdwA/c++TFTqoRJ7KWmv+VGjYGU8Et0sjfza9AEV5KdxhgBJVzw/FWk4Pja5IL42wP3uKzZr72cI3Qc5WvPGD672ToD23n8yUH9qA2N1m5GoNWvxp/LvDsSFIesm1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXUS26ZpKTgWNOz9wIs1WrCtb2AHRbZPOwA/k2+rwjo=;
 b=I47hiGneGrgQjE3DfIy+xt5RtV0aRw4pDU8jM8KkxG77QDsunkTnCr1M2Z+g+Q35tMO7HNWTSwDU8KcsJMDCsELVRX6wl+thSHc4Dxf1QmOTUc+HqzeHS8zbaZVgHjvxAkPK/abwnE4u7FlBi0y6vNnwW7VTG4S/n7NTB8FumnbBs3qQCnc1AyOOSnoJ/zoGKYFAY/7K5n8T01Rq6sSiMVz9d48DIxldyINpt90VYQYtE1VvGTD9Rs5mPRdprO8iHCvytv3ETRZQJPOYuP7sFB4OHUPeVH9OoLXR4YjDb2IfMKjZJ+Q5rITIkKndb96mcIjxgkJ5J6PU/VAzHqsfnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXUS26ZpKTgWNOz9wIs1WrCtb2AHRbZPOwA/k2+rwjo=;
 b=c/KzgNHBK/BRvtIU+BmNefjlDRA39R7sJVbpRvHfKFgDSnRo+jR59X7Lk+gflv+a7eUxCM0NIGB3B4vj3Th+abnFTnM3ZfIlcGfKYjBb6t0fgKNptF++TNUweaq/ygs2iSi2SLdkZNMxEBydtWMZx2rioQJwqvX5sStLzu38cf4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by HK0PR06MB3668.apcprd06.prod.outlook.com (2603:1096:203:b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 12:27:32 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::30ce:609e:c8e8:8a06]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::30ce:609e:c8e8:8a06%4]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 12:27:31 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Yihao Han <hanyihao@vivo.com>
Subject: [PATCH] power: supply: axp20x_ac_power: fix platform_get_irq.cocci warning
Date:   Thu,  3 Mar 2022 04:27:19 -0800
Message-Id: <20220303122719.2855-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0183.apcprd02.prod.outlook.com
 (2603:1096:201:21::19) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 227eff80-8319-4b04-ecc9-08d9fd11305e
X-MS-TrafficTypeDiagnostic: HK0PR06MB3668:EE_
X-Microsoft-Antispam-PRVS: <HK0PR06MB36686445C879DEA8FAD08987A2049@HK0PR06MB3668.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bHO86Md098fgyL4FlFO3lWftVwQq3OBpl+kOIYyMaxNarrR5oghITavMWcTfp8LNNgktpjeRsi2RQ/fZ+r+2h5naKvWpQzDrBqnd75Mi0Ojq0d/adB2dnxWDxbN41kU1C/HLeqCr6bHKzSqqxZJOACoY1SYLphqPMot7yv/TjAKHDjj847NzMNLDUcljvmA4grwH0zV+2hUZ9g9wE43dh6YLDHZJUdq4huZ+qIhkIngrSVsuhXmAMCLUrS6xgTOefhjTXRpBoUUCfJM7wvBQ50F4yq/eOollGNwYmO/MSXFe9/z1LgN17P6ZbmrhmJj/QH6xIhEx1KXgMsBchfmbWG+AgUdFDLYtRza9OD3WiPBJX/7RvmUcVZeFNi7M9Ec+L0kxRRJPaHuon/35weQ9lPpB7XsRH1oY5oH0q8o3skaAG5SK9vd4QKBa/L4/2ynUgsMurrHD/hPKlpr8pVEC44GXfoKpYNfDEdtjx1FOjromcA3FFDnOPH+NSgVDGXNpTGzPxsW70aKBKWswPvUw776SqdwcT2BrojyTOeLWH/zWiglDPAbBqlo+hc7nZkpIcqRVcPdTlxjXBb4uQOOoPe9KIg9LCirik0uKr+n9uCuRWWRhVZmgDIssYaj93K58QILDDi2nFx5qBFvF9tn79rDwhGpTiG+ZEO9v3epkqDjb3UF/8sRW2w6l4308SW22BKPWiacI3fNbMxwyJG1LhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(2906002)(2616005)(26005)(1076003)(316002)(508600001)(8676002)(4326008)(66556008)(107886003)(52116002)(110136005)(66946007)(38100700002)(38350700002)(66476007)(8936002)(6512007)(5660300002)(6506007)(6486002)(83380400001)(6666004)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e5n+nfC9xZ8PQ4yuDJgaTaQ513AMifrEsF/Mm0aPwT431yPP5+Mg39d/dorj?=
 =?us-ascii?Q?KuOrbfhPhTpA1k2eFqQKMV/2u4vQFSeF/1hPgRTmO6Ri6OY1fd9bVNBr5VHA?=
 =?us-ascii?Q?0pwz4oqXy/R06by/gX2gV0Bpr5EwjkHLIseuia/a40VybkLRrw+XGX3Nkt1l?=
 =?us-ascii?Q?xMm+YELaD0VOSy+38xWPCYVfl39dt9oNMVnpQSJgWPBrmIXGHtx0LE7IlOh5?=
 =?us-ascii?Q?T15Q3n1lPAg3KgT4B0q2QFmTjKfTD7DrF4RiIKDwo/ElvhFfQ+7SqZlMNMhG?=
 =?us-ascii?Q?YPA47kKHyqgStkAe7T7fSfWei4aGADcY/vF2uQO9s0AB/7x87lPnCxGkcKx1?=
 =?us-ascii?Q?Pr1aPPCqlkbP2Ljmq/cbT3vKTI25EjyIiysiQgejxQiGV38BebFEoaezskzy?=
 =?us-ascii?Q?ePUBf6iJIAlpY5CrXfbzcAW2SmgAAva2IiskHWV8+4SqjtX7OiUpn5AfdYZX?=
 =?us-ascii?Q?J5jmII0rMKNEPZ+CC2rVGzv7MEOwHjkZRtWe+fA2/Q3iIrPjMHMWXS3QGgkw?=
 =?us-ascii?Q?cgx+afvtBfafZmRm6HwCP/YG2klHWDbQZwjzx54zpAXe7YPuoF1+sSSClY89?=
 =?us-ascii?Q?qP1cvtETaXpJ/3uGMR/qjjTW4/eDyWtu//2k9o+kGLBjGzyXdHeDfj0L6XBJ?=
 =?us-ascii?Q?MZEMd6hkrwW0M0VExcco/i0aatu7ZpiQSaepVM3Xm3/GXzgAndboFQFF92fG?=
 =?us-ascii?Q?5s6Yr7goi13mvCTMWhhWtEfyN6D1Hyk4gPhf9cYwtrQyxHnVPiR7ym8SbsD1?=
 =?us-ascii?Q?JcaLDouBC7dYRsr9+/bhwM/v2GvWgUuJkBAOVutFtzkuwYhDGr4kZ9nQ1SXp?=
 =?us-ascii?Q?0x4KA4OWujYAP5QylWUs+rl1gExCwM0ledhSHS+IxajZPLCtGInjdj3ssCZR?=
 =?us-ascii?Q?bAPytQ9mf9tJ/4/jR6jflKJdm+SCWWzGitYAq1zI3rV7GoPAgGf02a9pOYHc?=
 =?us-ascii?Q?62hbyR5Uctx+2sphPT6MFYNzudbbiU/sW1/EeArD7YwkAfbv9B7JWBrqdNSH?=
 =?us-ascii?Q?pins47UUTm/OtP2yBBswYUjaPsyMJeL04ANJYvawUpdRJDdbKjpMsrrGoZfJ?=
 =?us-ascii?Q?HqJAxeAh84ME7/jTUmur8IAM7truyjb6rYohQn4z6V3omUqvQNbYqjJBVDHd?=
 =?us-ascii?Q?eSQyfKIuNu8Iy3SeFkAE/nay28shuY9Tt9w4q2dkMGdD37VuNxwyF51Hv9Mi?=
 =?us-ascii?Q?YyZatXjaxu5EzLJ9z8RBxHhXzsSSWNJqgyilA9x2XNLWqd2GTmZ69QwbQKwI?=
 =?us-ascii?Q?R34zhb21ynqFoVPgcM8CS2RKFEh6pnOcEppCg5moIA8xGUNsYRcuER97mXrD?=
 =?us-ascii?Q?yyHbCmUvpVotIkDVUw7pUfaqoyDOuGj9SwOi3/e/xpQz2cR0AF1J+da3u/GF?=
 =?us-ascii?Q?PCbk7Yg0RSB9gbLethdKVeZsARHmeYIqyOSF6UIuh5YgJu6oRXZP5Ygp3ijJ?=
 =?us-ascii?Q?CzZJWDqYqIoIgt+ZMDGGXR2UwDYJ0nrwkP3J4NfTp75COLcMXtcouM3azc9V?=
 =?us-ascii?Q?oZE4F0LEVi8vYbKCPnKg69Zwehx2CnTXdFgerwkfs7ppJhWoACNhxMQo1ZHu?=
 =?us-ascii?Q?xK/lKyqj4OAcdYD38qZbFctGwp7D15IX0FMmItNrMq3plnWXzS8g4XqHPE+y?=
 =?us-ascii?Q?y4tNgNwJk43f7Sxx0HuipSE=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 227eff80-8319-4b04-ecc9-08d9fd11305e
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 12:27:31.8996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: km5ZrIfeRoATOx8/e7YUif9Bxic5RTpoVyL0tBz8DFqYXp33xM7J4kjaRIQ/9xbsZbdShQAw6KHqGU3G5Fz+Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3668
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dev_err() messages after platform_get_irq*() failures.
platform_get_irq() already prints an error.

Generated by: scripts/coccinelle/api/platform_get_irq.cocci

Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 drivers/power/supply/axp20x_ac_power.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/axp20x_ac_power.c b/drivers/power/supply/axp20x_ac_power.c
index ac360016b08a..57e50208d537 100644
--- a/drivers/power/supply/axp20x_ac_power.c
+++ b/drivers/power/supply/axp20x_ac_power.c
@@ -377,11 +377,9 @@ static int axp20x_ac_power_probe(struct platform_device *pdev)
 	/* Request irqs after registering, as irqs may trigger immediately */
 	for (i = 0; i < axp_data->num_irq_names; i++) {
 		irq = platform_get_irq_byname(pdev, axp_data->irq_names[i]);
-		if (irq < 0) {
-			dev_err(&pdev->dev, "No IRQ for %s: %d\n",
-				axp_data->irq_names[i], irq);
+		if (irq < 0)
 			return irq;
-		}
+
 		power->irqs[i] = regmap_irq_get_virq(axp20x->regmap_irqc, irq);
 		ret = devm_request_any_context_irq(&pdev->dev, power->irqs[i],
 						   axp20x_ac_power_irq, 0,
-- 
2.17.1

