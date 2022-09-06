Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205B35ADE25
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 05:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbiIFDlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 23:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbiIFDlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 23:41:08 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2059.outbound.protection.outlook.com [40.107.21.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA2A61B1D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 20:38:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBw3q6YVB7CY2gypX+gd+eRb63Q4PzahEqIbCnLtci7tP6oSAjapv84cWCekiq+NpELwoIvYYMnuoQYHRi6DFh4pdebjYbTGEIgo58i37qiGLPXk8crPH5EBrceBTjdDWQEu2nnH6TQ0EWCUwfdm50s/fX0HEE4+rsHJMYUfeXYhb9nOs1twfsion23/7OlqlOL7MDSA72FAR/4lozoIxzpWsiAZqVs6PpnX/x3FLcVDC5y51mYAJ7n85a50OmrnQEy9Uk7PaT6eBmhQGjdwsj7zG0u97OFNxEgTZboIZWEivWdDcOcUplHjUPXDs1H0lSKKyaiNZyMBlsaK1auCoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfJkO1w4wK1kVnQXdY5Snf1E3+euslhd2I9WABve5ac=;
 b=SQuWw3t1Wdht6hkDdrucxIF5WvAC9A9PbhLY0fpe4q3YhZZZNsaJt5KnlK5q68l4zY+ThVOAfbEE5FWEpMpLRC/z769PrjagO4zrNnsU37gXWFsKzAbaqE9s6R6hQtaYqaFGs/+WkNKytQS89y0uKN1QsTk2eTV05+ntR5jLVdX8xgkkpMQclaLQodjPbgpzbyw3Upg1RCuExYGbJ6QZW5VOK0kErFsPfQYpV/TyWaqkyyU9XjXGWPSQijSzoH8oS1b7GSNLUGGD3/RYeK3mQ8Lyj+P1G1Af9lT2k/UZf9GwdC1PAjHk1WxgopigxrJQ5WIrqgjeo99Fu/c4z31Y2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfJkO1w4wK1kVnQXdY5Snf1E3+euslhd2I9WABve5ac=;
 b=O8fOrJKGNfuVsm2ydlBmxRGXJWmWmww2L+JQKTpZwleG76Xw+ron8HURhibyxsE/A9PSMx/jydhMqTFs2tplIRIWVdrQD37f30YJYVb/CZvKlczhSAZJarKhXVe4I74otZmyh/Km0XH1iRcAgHmWLEQMhn+BIEUtzl2an26MnlE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8742.eurprd04.prod.outlook.com (2603:10a6:10:2e0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Tue, 6 Sep
 2022 03:38:07 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.017; Tue, 6 Sep 2022
 03:38:07 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        l.stach@pengutronix.de, aford173@gmail.com,
        laurent.pinchart@ideasonboard.com, m.felsch@pengutronix.de,
        marex@denx.de, paul.elder@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] soc: imx: imx8m-blk-ctrl: Use genpd_xlate_onecell
Date:   Tue,  6 Sep 2022 11:39:43 +0800
Message-Id: <20220906033943.2184844-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0136.apcprd02.prod.outlook.com
 (2603:1096:4:188::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12454fe7-f6b5-4492-c457-08da8fb9367b
X-MS-TrafficTypeDiagnostic: DU2PR04MB8742:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6I+ufNlYA8FZ5FGdi1OAEZY0tcuWBuAG7oy0SLoUTELd66UgaaFziW5pmzFvyplXmbGp2CWViqxpLkFcwZwRa3ygMv2V/61k9xtwRUpvYTmzmjHkJln7sZ2N0wt+TMql6L440kuKXazTN8okRv7Mhy/men+rcR3on4ZjDgQmpnDX6wthOCsERneL+CYcsjarG+X55B1It8/OG0YClPewdlVl0CAsTH2xNnP92fSZC2YgEFUEBmfyLQXl4QrX2Ka2YPwELKEfK/Gogcuy5SFLJlNXU4vzUBMeFqKT9oUR279Trn1jQzV/LDn+YlPHVUHFkgbLiaAve6pH8Tbs8Ay9M9MU5J8xbccrMGLgX9I3r5r1CBWtlzBl1jv87qrItGO68XYznfCNGp4rlgrYEDusBYJMjTOEWaHhDQonk5laYUCOR75MzpWyGZBUz1ogf62P52C9R2gtHRKxnSgAOKNs+Gm4qDwHUMu1ZRSN7bNVXD2wkOqPyHj4tlUo5v21hXpVvY9I4cmWt6t3uYWUrITnmoX4Jd/5nrdA9WY+VopD4TyEycdwh52YdVSJIhb3CNFEOJJ8pFA83P4DW7IV4y+2gKTVrI63t0Kv9oHDMYOx0+XqYXVdScgLTUX8hgVOmiu2GhGU78oKL6hLOfTCKL1Ov9PxemwYo0mCsqAcHVIqfxXXQlNc9qjKwWcaNUT6vP1R3Dm1PHcdafSGmwyFEt5n/2X0qIrXfJxf9oOewNGemG3BhlZ5VT8dR28MTAjtWaI/yBk4/Tg80BuG3lpcc0WunRP2Td4sMLmSE0d6MbMLQ14=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(38100700002)(38350700002)(66556008)(66476007)(8676002)(4326008)(66946007)(316002)(2906002)(1076003)(7416002)(5660300002)(2616005)(6512007)(186003)(83380400001)(26005)(8936002)(478600001)(6486002)(52116002)(6506007)(41300700001)(6666004)(86362001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BIvIXklhLkdxLKJIkEtjmoxddSWau+i+GtzlFWjHN7c9CXWOhDVjqo50cSdq?=
 =?us-ascii?Q?Vn22X6U9K5VPSDKsERinXlG8E8Wvi7s5K3VDz5sgIVYt3aQXunCaIYRiYf8O?=
 =?us-ascii?Q?dI3/7jQXVN2UHOOdCWQ9jtwlMOsR1pmnxL3aHxKh/IFtvY60CajilVbjy2Wb?=
 =?us-ascii?Q?CQlgO+8/Kt8ulpOmXPkEX1QEXkxN3zDFekd/ehZ1WvIkjD2NOahhuXvZjLjM?=
 =?us-ascii?Q?fXenI6FPByaPL3HUUmKInzVU2TaZZYh23Wc1nPP5Xg5SxUIEK2jbMMwRrD7/?=
 =?us-ascii?Q?tlgRD9qXofp6lrUmxP3VuwjM/LKgfaEHwzLg4wFuoZcIGwi3OTFuorwjMPUm?=
 =?us-ascii?Q?aeskW+YjMsiFcrxLIK7UD3NTsiQ5Uua3/QyXuoT0Me5nrqRx4QRAiywFhs5x?=
 =?us-ascii?Q?Fo7vuXMF/TRZWkWTEmY2F6wSefm9prfciQkJIJ2GkpZENCyrVYfBRfOx1DZY?=
 =?us-ascii?Q?zrBp7tM52LxM1IO4mTSqUuXreOvWcpN1zGZ2cgQ2zjy29m5jD5mx7MeOMlxY?=
 =?us-ascii?Q?jtEF45e3tR8r00fhKoHRMMHrKwlSN+DWHhorNc5pM0UCn3u0p9YvECYc4aDP?=
 =?us-ascii?Q?O3fGyp3WwEoEtSH5slJ2t3rCCY6tcIxABhUg9b8mvGT/Ey5DyJ3wT+AOlrjA?=
 =?us-ascii?Q?4dIhiBERGJ171v32nvLRNVIeetgNpRV4bp+7s3qrbehqQZou2bzWyjVsJ4iJ?=
 =?us-ascii?Q?ngZu9U4uUIRAZM+ksvsDUklTXqUdYeI6T0nYxBYTJHrqIW985iDzxhtHyRjp?=
 =?us-ascii?Q?JAf6QhyO/3IdLk6td8wzAoHwwuHSapU+3i+RAtlXvLXKRlovx4b9YvPaldl4?=
 =?us-ascii?Q?wR2L2u/9A3uWb5iWfuebUPj5SwE8P5FMawBTCotnGmjIsMGY0s2oGDCqG00k?=
 =?us-ascii?Q?g5L8+A6PD437soHV1YMMUNUTs0uvf8OI/gb4p2JTDlvKrAo6OhQArk3H1wA3?=
 =?us-ascii?Q?55wm1txymfB+Gn4bS7zkxS3RSeFRXfjFR7ScMCh3lhtQP/uRc06gDCXWVyIx?=
 =?us-ascii?Q?VhM3lYimQQpX5z/52dqErclSFDh7utRUEsVmAu9ykr6g1ttREXlLs8+jmkNE?=
 =?us-ascii?Q?fL00/E2Xp9RQt734QmWxdwoKj3HhjbEmCStvHY8dzEX+CFwmFxqEJTQL+KAJ?=
 =?us-ascii?Q?dBzwxMGL06SJ+vnmtpN9bXVMt9Ob6J8e+Q0YToLFhSwLcq68GIm4Ac0lelji?=
 =?us-ascii?Q?SVd7nqMIZ7oaqOeRU9eBZJCqObKX2/0CvouAkzo39dTV5zTYE5LRkLGvBZzz?=
 =?us-ascii?Q?7TB7GsdAiUn8k/fMNjXtp4e7T0OPoAnA3Ef78YDFHCwtLtr8jYNjohFDY3d4?=
 =?us-ascii?Q?U8QO/0SIecI7+lCywRS/zbJ3RAJELW+iCg+a3fj9wggvs4XaqHIq0bWtJ4/1?=
 =?us-ascii?Q?rsg0NAV/cWy3UMQuWLeuM4x5BGDTqFR/8VJZfc9XuUO7S/86tMrNkVgvJZre?=
 =?us-ascii?Q?V1fxG1X06rCB4tRfusf+v2q5TmraJ1nxICNs2vD7c3Ly6m98PEcD+wEp9Ga5?=
 =?us-ascii?Q?9bPIQ6drraQvsgAMfQjziKjS05lxv5AsPUFddu1TE5ZBcgekEISTUTayuMEx?=
 =?us-ascii?Q?jsxI6IYnaaC+AS4lCfllVJwCcr7c6BQk7uI+gFDX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12454fe7-f6b5-4492-c457-08da8fb9367b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 03:38:07.3867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /UEEPYVrWxYVdMkddq5zN32EZt2gX+kuijvujny0BM6gD99CO6+iX7HGEFobhIuuD5QLGJG4nHRhQVApwnj2+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8742
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Simplify driver by using genpd_xlate_onecell instead of
driver specific xlate function.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/imx8m-blk-ctrl.c  | 14 --------------
 drivers/soc/imx/imx8mp-blk-ctrl.c | 14 --------------
 2 files changed, 28 deletions(-)

diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index 8c23d4cbbf05..d004b5aabf15 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -162,19 +162,6 @@ static int imx8m_blk_ctrl_power_off(struct generic_pm_domain *genpd)
 	return 0;
 }
 
-static struct generic_pm_domain *
-imx8m_blk_ctrl_xlate(struct of_phandle_args *args, void *data)
-{
-	struct genpd_onecell_data *onecell_data = data;
-	unsigned int index = args->args[0];
-
-	if (args->args_count != 1 ||
-	    index >= onecell_data->num_domains)
-		return ERR_PTR(-EINVAL);
-
-	return onecell_data->domains[index];
-}
-
 static struct lock_class_key blk_ctrl_genpd_lock_class;
 
 static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
@@ -216,7 +203,6 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	bc->onecell_data.num_domains = bc_data->num_domains;
-	bc->onecell_data.xlate = imx8m_blk_ctrl_xlate;
 	bc->onecell_data.domains =
 		devm_kcalloc(dev, bc_data->num_domains,
 			     sizeof(struct generic_pm_domain *), GFP_KERNEL);
diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c b/drivers/soc/imx/imx8mp-blk-ctrl.c
index 6f983adcb47c..343591cdefab 100644
--- a/drivers/soc/imx/imx8mp-blk-ctrl.c
+++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
@@ -450,19 +450,6 @@ static int imx8mp_blk_ctrl_power_off(struct generic_pm_domain *genpd)
 	return 0;
 }
 
-static struct generic_pm_domain *
-imx8m_blk_ctrl_xlate(struct of_phandle_args *args, void *data)
-{
-	struct genpd_onecell_data *onecell_data = data;
-	unsigned int index = args->args[0];
-
-	if (args->args_count != 1 ||
-	    index >= onecell_data->num_domains)
-		return ERR_PTR(-EINVAL);
-
-	return onecell_data->domains[index];
-}
-
 static struct lock_class_key blk_ctrl_genpd_lock_class;
 
 static int imx8mp_blk_ctrl_probe(struct platform_device *pdev)
@@ -505,7 +492,6 @@ static int imx8mp_blk_ctrl_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	bc->onecell_data.num_domains = num_domains;
-	bc->onecell_data.xlate = imx8m_blk_ctrl_xlate;
 	bc->onecell_data.domains =
 		devm_kcalloc(dev, num_domains,
 			     sizeof(struct generic_pm_domain *), GFP_KERNEL);
-- 
2.37.1

