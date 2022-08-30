Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEAD5A59FA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 05:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiH3Da0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 23:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiH3DaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 23:30:17 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10069.outbound.protection.outlook.com [40.107.1.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4734B497;
        Mon, 29 Aug 2022 20:30:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABIsU7IkezeM6dqHDsXT/Uu3oUTvqWE6TGzqUdPY8TNw/BsDoAqYT9rYnhTK6tf98qH8PhFmQwu8+p8RkmvknS/hf8PIMVvS8FavM5xeFWvrhrsK7ANb6TQUCpr+7+Km6TkEr8qsWcBZAWonrIq9EvX4jrOBZHefV1cIpzI8X03ozhOV+JWpYQkoR2HMlVbMQEmEe5uDFtCX3k4a/WW7yso3bCHIsqaH9WpzhlBhP5oS2yZnufkr9dg33wUWnRdBU7tT/Wp3U/xYj0BBzES6JNjR/weY2cdxzFI/RerYAsQ6dgHdTX5yPUTU14MWqbVo1qERWZtzlZKUNKmSJkl/HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKug0aZ88tf/ZdTDEVVducmS5ImD74RJ6gH6+bYqRmQ=;
 b=ARHwF1XrXuyGh/4rg1YFZH/75JPtPNm90xsw5m351MNqqndyRg7bVfeSWtX9j/RKya3SrYpVj47CzdeU6WECp1SUF0QCbvXGtUD/jMvPEPnMiCh0pgRSZTwcf02QNOsraXbEM06cAO2qzdpcQ9a7t0CCCKCxExRcO5t5EQpCfWAfSEYt/1uEaki5405MhOTRy4bUw1IC1Ai8BOWzbd2lOP4896PHpEWnXQiyX8cHJtO4DqH8jarS+tblGR2lszwHaUAtLYGLeNRn4sjyimN+Jh+4QZ3qn3aBVNHcrX5Tlg04A2H61ScXQUgkwbuEWzb/aaseR81TSQrxBAVjo5Om0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKug0aZ88tf/ZdTDEVVducmS5ImD74RJ6gH6+bYqRmQ=;
 b=hEnPRelNs76YgoNh0aGwZl1e+ab2TuESNjCcnJkcv7ksbmi5PGAAi0IEfggYvQxGpNhfm5Lb4U2cJZMRUfhseqNtMTUfD7mQCanw0SsbkKArHD+lEMT3rn+uEHNt3Q/spPyOrp4dX5YHJDX6GVyT/n6S/GUliMfv20gQXJLewuI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS1PR04MB9359.eurprd04.prod.outlook.com (2603:10a6:20b:4db::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 03:30:12 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%6]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 03:30:12 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH V3 2/8] clk: imx93: drop of_match_ptr
Date:   Tue, 30 Aug 2022 11:31:31 +0800
Message-Id: <20220830033137.4149542-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220830033137.4149542-1-peng.fan@oss.nxp.com>
References: <20220830033137.4149542-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::34)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a599abd2-32fd-43ee-3492-08da8a37f249
X-MS-TrafficTypeDiagnostic: AS1PR04MB9359:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /nAj2JkIUupZ30bFI35IrqJDp6H4nSOp0++sPTHiB1DuIOLV/aEtoDJgYIUpGF3q3crA04cdixwi3+9mWWuoE25XvqdI7wVJdl3yaiJtOmc5kcnf8h/m8Y58w1WAub0W+gRYIxo6pF5lGSIX/S9vFeZiAbdpKvLu1gsxDitkzlGLcq9/MWr5B7gHnmVRVuBMc/CJ+QL1+ARr1mAQmag+q6q8kzVSKoAW1bOHCHJpWY2ieUJUn5eso+gMkeD04Oy9UroY8EUpXUdgqHDBluySwyO+ik5OWfWcPoJMvlibsWVu3l7wm/bH6Kvzkg9mW+rWng32y36BI8LmVTrAbmGBfjhS67KTPFzRzxJtceESkucXG7GcANg5DYF9SbpbMRKes5/r97PzyxvNKtGAJcUUu0XmMzK+MOIzfSZGPSvpTCet8i4NE114TTEb+2lah8TXREEOci/jRmPTnEplTsdIQZ5ytgrQIVeHeIffcvAxvsAj0sy1Zt5tm1IwW2qWYBnUE31rQgCv87+EcisM9R2wtDoA4Jc7a0U0F1WeafT+4dhA8ZDklkeWfE/itM9nKMAOq/RabUTvh/ZWlwNMwqBHW1kcwMCq9bWKqoH3mncSIzIx2Q6gAzv6sQCQNASLD341x25S41Dryguovl39HaoWxhEs8RraNBB18J/0RvsBtPIkUIjjOS4LsmsQuut/K9JQKTbPxUsmLHR49VOKM04MZ5/h6FJzFWON2AfZxV24dxIDo6tonBKvZFVwiEruS3ePR9nh6UK+hB30scHsdgZH3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(8676002)(4326008)(66946007)(66556008)(38350700002)(38100700002)(86362001)(83380400001)(186003)(41300700001)(1076003)(7416002)(478600001)(6506007)(26005)(6666004)(6512007)(66476007)(2616005)(2906002)(54906003)(316002)(52116002)(5660300002)(6486002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VlFI9TgibpZouTKnVKJ9pv2jWPwzln3DnixVFsjXRf4Anz0dlhs4kXKAaC5t?=
 =?us-ascii?Q?xht40OS9pkvJWRjQWv0V7tLn214Oknrt/2ixVRFV+OtAzPVkaZyZakbyID9m?=
 =?us-ascii?Q?mdhd8mRwC3r6sq8qA4arRmbw6FKHwtxPZ7hcZf/uf132Xh3h+Zeqcs5GMoWz?=
 =?us-ascii?Q?XAOljRS1Id0YF84bZQFEAhGBzxnO1+Qio2RVL2TJUdTpZod2PghEZI5V6FT1?=
 =?us-ascii?Q?dCzEgPOFPZQpn6ysJRMUnPX5A3dCYZiZfG+0RCh78OYjep9cKntJ07a7Ot2W?=
 =?us-ascii?Q?Y5TpazE7YqrLx+eB7yjrtteilwrEpMP3Py9NOV72iDZpjM5NYc8Bs5ZdwMS0?=
 =?us-ascii?Q?EsPnxI4FxiSbetWjmakWK8AoB0ttxw0WB7f+QmvMG8y8RHX61TJ7JUgCMCde?=
 =?us-ascii?Q?zd/YxIPfEth90ihrhiAoYiQLKq1Tpi6v24OHmgEkOg115+l3Jg3D4+WspASA?=
 =?us-ascii?Q?65bOVZfn/cpzMqgdtst9YJTY1hEWkSqtx6GDhtd/+Xap/96zH5UPQiuLXiDv?=
 =?us-ascii?Q?/rJCKG9rMm4ZMjjb2dq51q6GnSn9CP7IwxpT1UQqmUFvDNStoBI5mE5Ucf69?=
 =?us-ascii?Q?ArhR+mdwgVdI6uCl6we+JD5sRg5iXWT/EtJ0UEnzJaHrE8GGjXQPoVwUE7S/?=
 =?us-ascii?Q?WPjlMeVv9gmnOq2VUHVYboPp2mBY62C8qLrjPzC2LNLiP11xz+ig9T1yzgmn?=
 =?us-ascii?Q?hWaWkqHhqyRLslJ3K6v70DLC04GFkEU22h+ap/Y03a348dEu5pSZQxOpLv4H?=
 =?us-ascii?Q?8JPzOak2LlRAF/EN5T2pUrY9zT8493HwCjf/Rirdwpm/0yFzRAXCqFLS+yGg?=
 =?us-ascii?Q?eY26k35W3xFdZVcGnARhqr/wqeqAwd3BASpoaZCSZNsjGdIa75Dj3mNqJZtq?=
 =?us-ascii?Q?VTQz+bA7/XbsDxbXD5POykbgnfqWZN4ZdetZ+ZrTbOF2Qa+rCzbpBKdj9cjD?=
 =?us-ascii?Q?uVKoiajaYluK0MuiIw4gnAuBeHSrROK7Clpeurqb8haO6uagMQJq+01INmMs?=
 =?us-ascii?Q?SP0TXUpDNDAxXWBa0agGyJG1DH9cdmRFmUrQ/jg1sVnwe3VCKJfKWrsdoNbQ?=
 =?us-ascii?Q?NQi8JNfr1IkBkok9Ac/AQqAEIA5t8BONoZ5oQaBE2m95d1SwKuzOlV6OjB9e?=
 =?us-ascii?Q?fJKXU15xY5Vjzsie6Pd22UMdR1h7gWbD8D6E+MH3l4CubWqMFPam/geIrGw3?=
 =?us-ascii?Q?V//o0rejijAWD0OncM7xPaHf6cImgX8M//o+J8ZWsd6By0koK/KvWfqGkh+X?=
 =?us-ascii?Q?nFw3Z93SMdtSh2Ff3TQJEezAEUIo2EVC53CE8Veeg+CAEa9j4ITtE7CFJtu7?=
 =?us-ascii?Q?y3RkW4IlNgD3mizq4z7KkSPwj+LukAEk0XoGrkRbYfni250JTUHeLqdnYNjy?=
 =?us-ascii?Q?Ca40sytTRxeGGXx9CbyYglYJZtlDwJWpVWRncsqHq0Zuwr8DfZELFBGirSdv?=
 =?us-ascii?Q?naNj0StHoFDi0wg0c/ewsRqOOi7ko0xNRATflt35OXSSTgHdvvn4WTIcxS7A?=
 =?us-ascii?Q?a2wjr+Yf/PoqpofS3o40mqHYDmzkcSTqH94QHUJo/oAgyDZGmTmb7jYWegcL?=
 =?us-ascii?Q?VZE6cOy9xASr7cdHaFYBoRNNyPwIJJf3h5SuqscS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a599abd2-32fd-43ee-3492-08da8a37f249
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 03:30:12.2501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kDR/fC8zNtc+yeYhdw2+FF4Q9vdHyD6ciBKNSzr2wRwesQmUILHXcXtIarpzPqxQrJ5UoElT2oMVDd6SGiDveg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9359
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

There is build warning when CONFIG_OF is not selected.
>> drivers/clk/imx/clk-imx93.c:324:34: warning: 'imx93_clk_of_match'
>> defined but not used [-Wunused-const-variable=]
     324 | static const struct of_device_id imx93_clk_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~~

The driver only support DT table, no sense to use of_match_ptr.

Fixes: 24defbe194b6 ("clk: imx: add i.MX93 clk")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx93.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index f5c9fa40491c..dcc41d178238 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -332,7 +332,7 @@ static struct platform_driver imx93_clk_driver = {
 	.driver = {
 		.name = "imx93-ccm",
 		.suppress_bind_attrs = true,
-		.of_match_table = of_match_ptr(imx93_clk_of_match),
+		.of_match_table = imx93_clk_of_match,
 	},
 };
 module_platform_driver(imx93_clk_driver);
-- 
2.37.1

