Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA11A4AECB1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242294AbiBIIiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:38:14 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240988AbiBIIiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:38:08 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2124.outbound.protection.outlook.com [40.107.215.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB254C094C90;
        Wed,  9 Feb 2022 00:38:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZQajKs20hToZwcM+a3mEqWihQDGCuHQf+IxGnsToh9XDOMC7cPnhZBfiAhGjjnzdceKlkkXIxs41wytdrBTOvfATAQQv0C/q5JRJ8WvN2SrsHhltRx5GU9wiDiW9bSDVuU6c4hhU85eRc/bjuxVGbJZlZtwHK0IwabK3oZLk+ig9EJ5j3+W5HGqrZl8AZW3abzc0BSP+aiQLwClizFZNyXH+8FDWHJJfrTw67cFTYtLezAnG8zdpFY0bpE0NdM7qMed2RHPPz8OGu36VQUEWFafm+00PvMX6cyXuwfOd5gNPcyzSGJYZZeD/lPVvHgT6XIaNzxFwVdw7z0+ExTDHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0LHy+GofGQusxSnFPLutoG9mQjQ/JZ27NTktBKjobo=;
 b=cG/3jG48eY9R4ovgq1MkR2b/0w1J/A3CpzP8NneP0wmYlvwhvfqwpqTYXHMlp2J3AbULOyGTPcp5AMNFl8PFWGFb/TMuH5BimgSZgD0o9wPV9XATIbLf7Rk6axVIcdlZztt1Dq9f1jWgvJEL5q3172Bo22cGQJ118qPoa4kAdYV9Ou6jcokiyciln+VzZ7zR6WJSaKvPZfwU3Ce3EzwEHz09CHP5CyVMtbxCR9lhQjMat+kR6BR8yfN/xjkCAX/C/7oMehDHXHFujdzjVm4avGZAsyFUeYagpHG5BZlbsqMAAt6chmnwPAD6QeQiRPTUm+kLq7qlkdkaG/D8vHJmtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0LHy+GofGQusxSnFPLutoG9mQjQ/JZ27NTktBKjobo=;
 b=fV0yBbblEw9jIKp96IvU9LUk5rPsxJQf2j+17zi0WW9yRgUUa3D5ytORbacRZzcGx/xgbixAMraCYkO7nSnSBrnqKOQWTBb7fvDAlP6+RnC8RvjoDAbjBbH6VayjUR/WFFT5M0HSoPOWBbF/tfPKQMnkna8d9N2d9ec2yFly2i0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by PS2PR06MB3559.apcprd06.prod.outlook.com (2603:1096:300:6b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 08:37:07 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb%4]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 08:37:07 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] clk: imx: use div64_u64() instead of do_div()
Date:   Wed,  9 Feb 2022 00:36:58 -0800
Message-Id: <1644395819-3791-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:203:d0::26) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3bdae0b-a8e5-4356-12c3-08d9eba75b48
X-MS-TrafficTypeDiagnostic: PS2PR06MB3559:EE_
X-Microsoft-Antispam-PRVS: <PS2PR06MB355914259AF11D1DA55B1B65BD2E9@PS2PR06MB3559.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: StT3r4WFL7kxB1ti29fZtmMnvoK7YRoxMMznIgdHaNfK3uvmBjsT5/JWSF3SjsV79pYPOHH6IjOgrYBKC+gLKdCIo5nm4axXhSIyR2+1bCvRK9ZCr6V+u3Cpf6iLlBRjh7soMtR7Z/fWJ4Ck0wm+JqNbaEasd8z124BT7iwvlKs/QmPidofw+MeXFCSGNzM9d9Ecc8PzA9/IfQazJ98cZzYGqaQqUYQzyYOgIUrWF3HDLim60XpnJ6ctLtvUBUoNZtp1oTFpzc3hm3z1D2bdzfgTRuM9XfXN1612Yrs2vTFVMNL5ZsdMJkpF0N7fS0s/PiXId629j+Nsw9eF+VtHwZdNdR0sYI+vo3mVRkE/5WaqkRW3YKhE+LmvmtG/iNl966cZI7uuhaoeddr9zdEsErixPoBHFPf6j1OELjo3jyadoG3r6umx18jg9VaU2Ku+r4VxlllQ3SvMT+IxDNvK/PQzMCuPevbc+GXDIdkCF8lFf57YQCYXrt6RhfRGsz+pJVAhcxtW7e1Jo9ZGFA6GinvlWDVTiGWI19qUov9Lhk68JsmDBcPEK42RouVXxMZBWV+uX4K0gc+PJ32byOFUrX+3MlOd+4E1Vge/PM6YJP4ojwEgB5Pjh9/lxnv0uXNXmisVWsAvWHRDW3VTsR5cUI5U4iUTIWQxP1/zA8xWO6/vsmSU6AvonGXEbfam5BcZN1jhbDSEfTzbwMwXW0OsRzqljgMLlUlT2aPHpa6VEQ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(8676002)(4326008)(66946007)(66556008)(66476007)(186003)(26005)(6486002)(107886003)(6512007)(38350700002)(6666004)(921005)(86362001)(6506007)(38100700002)(316002)(110136005)(8936002)(52116002)(508600001)(7416002)(36756003)(2906002)(83380400001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vJAMxgGHKYItJKZpBweQ9nVFIUivcws6iS63HK5XFEZHD/j1zunH5Mdisrh0?=
 =?us-ascii?Q?BkT3dYPHr3t2yCpUt7kEtJKknpzmBAJj1ha8aSpT381Vk1k4HdWiqODM9CyB?=
 =?us-ascii?Q?gkryXMesU0Xb5bfojIWo2+oNgeewE2xLO0/Z74mVlqLH5oH4Qkl9AOTdNM/R?=
 =?us-ascii?Q?UFOzgci/3S6RPvlhTmuUgNDWHHhaC4mv/cLFLtN9Ul6Y7hewQgDH/uJE0Zt9?=
 =?us-ascii?Q?SmXy3lSvnN4jcqNNx8ecrU7BEQxNbZPrJyieHdGS+NJyAHj7MGCeekney8IX?=
 =?us-ascii?Q?LFc/QBCgY/LZepmFSD8cNsIsKDvnReuFO1G37ZLuVR4L7kblF1AiPkXX6wlU?=
 =?us-ascii?Q?J40Mc7carM9v2nal3MK3/dFlz8t4UqgxlR2qS59a03dX9EzzyXFd+oL7n5JB?=
 =?us-ascii?Q?dDUt9w806tMSbHqijS/TKPcVcV4ypM6M65yY9t4o/2HXUVpBkD0glDrSdSQ+?=
 =?us-ascii?Q?8WiNxjgvmglMrwOa1eYpaqD9NCgRrqCWyWNJYRrRQwsSwbOYYFBFn16g7rxz?=
 =?us-ascii?Q?azxYr21gFM3/BOfmiI5jyFe5xUJj51BPl3Akn3tqzhX0GWKnyAcqQwJ8yb76?=
 =?us-ascii?Q?Zl0ob1dBOjjnhLiOJe/u15AQVJq4p3Ck6OqcNuBNEUgDCdmaQEE0jthuLPKT?=
 =?us-ascii?Q?be1xuyOXlXyrrOumGhBtP58f15YJpMxvF05rT/H/4+tSwiDIoQKLWs5NAz9C?=
 =?us-ascii?Q?1iaMn8DV/V8MWEYvThlk6KkIqMzjuh8XRiqjYEhKtjCapBstIps8Py/YT8F+?=
 =?us-ascii?Q?yYucqTPdxHLPs9H6AGhbddD1mkm9nh4OLjbmK0rV9S9aW1S4/0xIZQ44xfxG?=
 =?us-ascii?Q?QQJxpQcGBFP+JzdmX9EXo3wekOMhWIXfe+MrSuQEy9xrtWrtJsodGegpoM5U?=
 =?us-ascii?Q?WPSkgnwiWC/lV5wwva9cXxDxx/dNKUDHs4ZuW49zBvPaOt+3gJq2FLd0CYu3?=
 =?us-ascii?Q?R5X3ONDwsN3trmKvmseKy6oACsEKxlS6U9WTcQQ/KKgume2nRaVEq1GXbJN5?=
 =?us-ascii?Q?pU5r8mpDm+vpakVWcuDJYg8pDDd774G7FcE+0FdQS4wm+BXisFzW+nfeCwT/?=
 =?us-ascii?Q?7Qt/YS0B5sN57mYmhmYwE2D7/4ZQJUpT89HkkNVqPKe7JKMOhLxKZTZ+itoj?=
 =?us-ascii?Q?TRBcvAd+DRwGm/6a+ebueFl5Utkqqg6mIewphZAuDUTDYJOvtTlqkwuMlV/k?=
 =?us-ascii?Q?CxSsgoOE922gboVza9KVg4I8pbZyCJ5mjWAmlbpDZjILjMo4e0X90UvUk+sk?=
 =?us-ascii?Q?vQDil1THOJ0izmVX+vFJEHLYD+EpOaGZdkApWE70iBDret9pjjyvX/ME0h54?=
 =?us-ascii?Q?wr3nyTeKrGpPqMcYjjcypexEkXe2fypEkRIqAby4/SOvlWxH9WjzEpsrwYyM?=
 =?us-ascii?Q?7o2SzWaicpAc1y/dN2idprY0kAJrJmjI+KcQZ8wzZ9gLmlQ0VugKY2oudn+Q?=
 =?us-ascii?Q?yzfFcOX5/xow4ozQqJKOPFDVl+OihYWeiULK0odOt0cQLOxaqzfsM5nTtCjl?=
 =?us-ascii?Q?XhewCVCeV4TsYrJb4p0oeSNKuRR0aNeU51UAY+9PQ7YwnSFzCZ+V3SCCBPnw?=
 =?us-ascii?Q?LCA5fgNj1IAz5i8/vQox2vXhEyfaTnTD8yNp2xJ+PGcgeLeTpUEhIpq+IKQX?=
 =?us-ascii?Q?Fi6/zYeVQL4nq/86eE8y4rQ=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3bdae0b-a8e5-4356-12c3-08d9eba75b48
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 08:37:07.4870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rTNN0me2TVM6wTfiGgqrr6MunzDxxixN0xwdZAGrOAQkDVZKgdNjNe4AFN2n6vyCS1koiVQObSwKMiVvK4Rd2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2PR06MB3559
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

do_div() does a 64-by-32 division.
When the divisor is u64, do_div() truncates it to 32 bits, this means it
can test non-zero and be truncated to zero for division.

fix do_div.cocci warning:
WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/clk/imx/clk-frac-pll.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-frac-pll.c b/drivers/clk/imx/clk-frac-pll.c
index c703056..90b25e3
--- a/drivers/clk/imx/clk-frac-pll.c
+++ b/drivers/clk/imx/clk-frac-pll.c
@@ -129,11 +129,11 @@ static long clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
 	parent_rate *= 8;
 	rate *= 2;
 	temp64 = rate;
-	do_div(temp64, parent_rate);
+	div64_u64(temp64, parent_rate);
 	divfi = temp64;
 	temp64 = rate - divfi * parent_rate;
 	temp64 *= PLL_FRAC_DENOM;
-	do_div(temp64, parent_rate);
+	div64_u64(temp64, parent_rate);
 	divff = temp64;
 
 	temp64 = parent_rate;
-- 
2.7.4

