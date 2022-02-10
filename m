Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548084B0842
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237382AbiBJI34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:29:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237335AbiBJI3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:29:55 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2101.outbound.protection.outlook.com [40.107.215.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65541098;
        Thu, 10 Feb 2022 00:29:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxvU6SHjj8ymU2hejdtjb6BkFlBBoeQ1p9VNC6jXHrgELfjXAg0RrHUF2D6pXglj7TgOdQxwIfkp9CRgjTzLhGWQbHcH6gf++EwQHqQfZBmRLkagwsSTRIRqbKk08r6VkujI8ptCQfyPg/UATjp6WdjkYI1fBU/zqagK/zYnjlAUBkJMmXa1p/cYVZCYz5bmtKvsF1PcPEezoXrAhsu53ZI48sxzGOov5okxtDZB7lHJm3pRzBSKPLG5Xq0zfrUyLR4K/dvpmFcKYU7TiqTwLSfxdDVPqKMK2wwuoqSlIScpv7C+KWP1bPipmTzKzPyV32IBQmDpJ3/Xm6rbJCegpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zTdH9OmQOVBYL3+63Hoblp0gCbAJct32sY54CQy0Co=;
 b=H9uLK0ybx0bTnSl/4JdNc2vq0bFgIZ4OaQdJj1Wj05SP0Ph5AdWzw2Kcutv/yOL9IY49mfyZAoyibReUgpZ6gAg2ScPqLM8eBpRln6wN9D+VArF/3HPCayLcszS4yEA+ZMQDbgeR2VpjOR8iam5U2ifL7pXGsHogbhnViS08/HPtAo7ztNrhddekg/IzC4TqBwZDg91tsMaJPLadJmJ8m8TV8Mwt2iNiCr9w0wGo/9BETsSQieTSvy74DvBQdMdW9XjougAUI+g5HzQXJIMVGXhsOCBa2dcH/DnGky7P31Ut0mzpHY7rrMwHnd/4S/CRsvAiFfXAI2Ex4+XUIhidWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zTdH9OmQOVBYL3+63Hoblp0gCbAJct32sY54CQy0Co=;
 b=VIyjbq0JHDhESFE0BaS4ndGZyKcks4Bi3HxDDC30vEP5ZEuubN2nwpy3xuWG3/vmM5mBg07XzpyF1vqoQUsWmy98aHIFVnIc2JlgmN//mtp10gCayYgyMhS6hML+63JqXRSaBy4HyKFcECvjogvHAUYYhxWBTJpe7akHcQgtM2w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by PSAPR06MB4005.apcprd06.prod.outlook.com (2603:1096:301:3a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 10 Feb
 2022 08:29:54 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb%4]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 08:29:54 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] clk: mvebu: use time_after_eq() instead of jiffies judgment
Date:   Thu, 10 Feb 2022 00:29:43 -0800
Message-Id: <1644481784-14524-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:203:d0::12) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 204def8f-4597-4753-6df9-08d9ec6f8363
X-MS-TrafficTypeDiagnostic: PSAPR06MB4005:EE_
X-Microsoft-Antispam-PRVS: <PSAPR06MB4005838C971FE27AD6477D81BD2F9@PSAPR06MB4005.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V+1SOAsVgVJD3xbaMM0O/2TZgEGKpSCk3UY5GLJJ2bnbJzqErZpXdBlrQswp+MkDls3USJyqJhrDtr525F2zCbbbj1tWwNrtTni6dvUPfOir26N5/FDcXA0/TY/aVHBlOvDWjTzmG6hha9YL400ZM7y/0fWBseExejXG47xSXAGxQRrwlNqq4BShN2B4nebD51spW7BIzpY6eLovuF4rAS36qvLNIRE+Eo0TjbhQaXt2I6bJTbrFxq9Y1TT0SOStwFR+kaFzoP1CQfay3QOkD2dQM/zN+3B6YgmTRNp9uZppkdsArIU+VTrJX0/tyHal3Lr6bek1OmBhAvASBcpQSNAlcMRq1Or9+BwhY2yKxKQT4KLyCIhH6SavIfuJrIdrtHLlsEcuIMu2SGwhEFERztIdECRWCduDjng8DvkRWo0t8V5jP3NPLUyDJJ8K7TspavooZvN82I0oq6QVZyYupb4McHXrDMHrNn+IpWeawEQ5BsyMow1zRwZj+w03q5pRtWezBOw2ZQRTmCaV6fkbbSeJpXouc4LE+w83ZLDeYzg4mOZVszEzIkJpKpCHHqmThOSVydH0p9dz/rIoBHcfe3dpPuHC9CLaRKFWSJsnYth+yiWJCLwoZKTrLS7zpyR8R6zmGcpijuVNHCdIP4LLkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(8676002)(66946007)(5660300002)(52116002)(8936002)(38100700002)(38350700002)(66556008)(6666004)(6512007)(6506007)(4326008)(6486002)(316002)(186003)(2616005)(110136005)(36756003)(86362001)(508600001)(83380400001)(107886003)(26005)(66476007)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: I+iG38xxuJuHcSbL7RoyeSJqMic9xXB86Z43oQkNf8TOP2s4dAJBcvIGGbLkk4WsFumEwvpbU3ynE68dLk8ETHqFIiqgVtNdYEpre0lZnTCkMznUk0sdtn0jwhp6//G2B0J9GYJiEVS0KNHb2wmIl0q0G0O8mpPG+0MEUSoVllu//3KEwcnfyjsz+oRu4H7VdeJRZQtAGUexEBwznaPjHhC0RJ3kN3laYhIm0AtBAbxqkveFHD9i7RdQoAA+6RX6GzJwYz1gw+3/Di0ONRhkIkUzaNh0zcAJkS7h6RY0fJtmvoa+x9PQoasMVTbCFSRlExe+HcSmai9/dxRGM0X84TEq3TSqf7C5eb+dlNh4DHrLS3NQT7jFCl+hrTUF9zAmDxXIajG0LNAwAb1UhRLt77xsfyLeGvVPzmsZs2Ra8pJzsRytTf6Wy0+ZOsVsPqch
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 204def8f-4597-4753-6df9-08d9ec6f8363
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 08:29:54.2460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9hOrpPN1qjQWs/Lno6ECgX4nt/RTyEwWvf4/zbB+AauzYHwAq6WnmoA3v/rC9QtH56eEOKm2RWvNDW4cK8Vj9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4005
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

It is better use time_xxx() directly instead of jiffies judgment
for understanding.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/clk/mvebu/armada-37xx-periph.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
index 32ac6b6..14d73f8
--- a/drivers/clk/mvebu/armada-37xx-periph.c
+++ b/drivers/clk/mvebu/armada-37xx-periph.c
@@ -25,6 +25,7 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 
 #define TBG_SEL		0x0
 #define DIV_SEL0	0x4
@@ -541,7 +542,7 @@ static void clk_pm_cpu_set_rate_wa(struct clk_pm_cpu *pm_cpu,
 	 * We are going to L0 with rate >= 1GHz. Check whether we have been at
 	 * L1 for long enough time. If not, go to L1 for 20ms.
 	 */
-	if (pm_cpu->l1_expiration && jiffies >= pm_cpu->l1_expiration)
+	if (pm_cpu->l1_expiration && time_after_eq(jiffies, pm_cpu->l1_expiration))
 		goto invalidate_l1_exp;
 
 	regmap_update_bits(base, ARMADA_37XX_NB_CPU_LOAD,
-- 
2.7.4

