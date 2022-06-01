Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCD7539EC0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 09:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347741AbiFAHw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 03:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbiFAHwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 03:52:54 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2135.outbound.protection.outlook.com [40.107.215.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B75459312;
        Wed,  1 Jun 2022 00:52:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZlfKI9WYTlhyttHAXZ78Hq9TeAfNeS+TP7IIPIFCqet85EpKwJmUS+N4qXyi6/84MHLQaPUJnzq5xdQ6LINw2zQsp3fRoKQHeHneH829hHn/m+1rGmNKsClhR4sp+QlC2HmPZT/rziX1nPTu/FTVgHR75c2TbiAG4X8xVP/tuGErUZxSVOWoFy3UDBlMuma4OIwfRXepgnRaKdmpioBuHSY1IqCSV9xKMDANJBRfCb4y8IVxbK7K4/JVaWuf/BDcMdW3cdEu5l4xWLeFTMmMzuEhpn7xPpMzLw3i2ybpAamxDCV0VUVNSEwlSIEba4EKyc2IY9hGl/yZPEfCmq2bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kGg4ITzUgCXE9l4DNEE6sxfeKDCN1pNy5aHUljywnk=;
 b=YezJm+UKaR8n8JQg2rt3SpLYqM8QR5qSMHBGncrikQAlWzlX6TXcq8+oQbXwNZ/N3DIzR3cRnXugnQ5ilWGk7wKIvwlmiD43X7KQw3LrK90LbNq2HgHRM3bkWe8vtMmmi0jQfdRU1n0Xvg/aMT1Bq9KM9pT1t5begrmsPIiFmPfTrblRTLO7UwHjYaWolRgnLmxBTFNhTlxzH39zOjqHdHDi4YbTywUHc/UasdmJF+A2UEcBxatMa1ZOmnCHnli97rIa7OBQPghZ7aDFBNZk+TP3/9Y4e9O64DNz3ZEKYuD8YeNxeeA+a7zKdh/Ee58TLZdcu2ZYngvJmqZPmo8Q8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kGg4ITzUgCXE9l4DNEE6sxfeKDCN1pNy5aHUljywnk=;
 b=Rqoh5dX0yIwraBWM9ukmTk/uyNjG1uFlzHRhqlkCcX8+kE2NytyDf37ZOr9a8OBGtNqZBcIC1SJcQPD8sD7scvyeRneZ2GXjjb/+piLP/IemYiyMLVIGeQP5Mm1tVG7r3Z5Umil9c0ESpyn54oF/7EhD/Nqv6P2vG9dF6ySwi5U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 TYAPR06MB2094.apcprd06.prod.outlook.com (2603:1096:404:20::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.16; Wed, 1 Jun 2022 07:52:49 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::ccb7:f612:80b2:64d5]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::ccb7:f612:80b2:64d5%4]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 07:52:48 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Pavel Machek <pavel@ucw.cz>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Wan Jiabing <wanjiabing@vivo.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] leds: Add of_node_put() before return
Date:   Wed,  1 Jun 2022 15:52:03 +0800
Message-Id: <20220601075211.2117596-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:202:2e::27) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6631bca-0049-405a-c9be-08da43a3b898
X-MS-TrafficTypeDiagnostic: TYAPR06MB2094:EE_
X-Microsoft-Antispam-PRVS: <TYAPR06MB209489CD477972E8D1D2CC8FABDF9@TYAPR06MB2094.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SsxMrdZJqgeTib2f+jwoX+d/FzX80/038CJzv2tK3paBUCy7+xXx6HAtE393h8uCPSlVgOMb20c6e0n/EONW6cxBtAAEQeD7MAAQ1ijesu+CDpscdfRqZvuhcde7yqby9WB+Dq5kzkrPHEVIpPTxXCug0KIQYBPO7V5Mq5TMDFwZf2j2U/nq6DTN0T6BMz06uqlrJTwA2B5yydeUkvHoz5dfscwcuh88bs1jhBvMcl2Fcv+qDF1/hVdvu2PFGXZ4OWhQctD5Z0pEqNUQKBOk6KQYsfHaaskuvK/eucNnKKD7X6Ea2CXII36MN5g0SgSdvn2ZnmS9dRytkgRXt3G6xSBG+gBuhTHfTKjMuhjG0oy6tDPI551xBa66DZNVN+ivyEr0bSoQkawY6Q0Ue6gg3wVnk204DuJmK33mn05ezpItEBPPxhaQhwpRRhBP77KjmzNY9OrlfmA01gPkhiGbToxot2s1e9WaezpH7C4VdtU7HqJGVmA/YYl2H6+aH9iyK3FnlOJ7h8OdsJyrdGOJPklaLgJAaj0ZquzX1Si7P4t87g5ctw6egeu7dlRu57LG3BjNde4j+jL0LHWAQ5ZVmpGhLyRfvJw4aMD1MolCs45ZHJ5oBLXHyLMiNyZ4wMrnCJ4pe57JiaL0NngqZPgD3Wp1F6kzvyANRM+sNu/UsRNxRY/X+Xm/NGPAJ1QrNY0NQiU5Msdi3lKeXD9vqOt6Og==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(316002)(52116002)(2906002)(5660300002)(83380400001)(66476007)(66556008)(66946007)(2616005)(1076003)(38350700002)(38100700002)(8676002)(8936002)(186003)(508600001)(6666004)(110136005)(36756003)(6486002)(6506007)(26005)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0emmY5vg7t7qbckatmpqC8vXTtq2nFITdx5jmcBYEYZZxL508D+9Fgh1Zx97?=
 =?us-ascii?Q?b3i70CXbSTUZDu0u2sUqq6PtpnJvcrvMVjlLHWYi7dKkdmt/6U0NeyTmQGkB?=
 =?us-ascii?Q?fajUOfvbqlObPqWvz2Kl8tKvOu5MyLe28hKtznYzj8BJ89qzK8LeqP6PsURo?=
 =?us-ascii?Q?SieTzvDt+sUMz1598G+N6yN0MAEGtzdL6unyVqB7z+0kKqwWz5UbQb4R0Wsg?=
 =?us-ascii?Q?F4U11lOtijDaeR+dop11hiD3U03PPw83BWkBbeOkPLVYPPmsEjpIimzSYta/?=
 =?us-ascii?Q?gAPo7vVRZkjkzo0lOzmb+c8src2XWGnrZTAX7zFHyVt/wm8mH3GZQOLP71El?=
 =?us-ascii?Q?GPQVeqQH7c5hUOTiZSMOoZSUcf2yOb9g0CyqV3IQKzE/DHsUsWa7xbKlAcR3?=
 =?us-ascii?Q?2kcTz52lDYmbP+d3maT3NtCwqAOoh5X08c/imyX8hjuG8jcb0QAjWlqkr7Eh?=
 =?us-ascii?Q?8/UbJUjs61xUPWJ0qi4prKQnqIob0cW3Ro544Rb6whgZwUVnG8X46AyYMytD?=
 =?us-ascii?Q?1i/Jbu2wj8x8JYtSCLI9gemv9rzxbkzdMaqK+ZvaSwrv0B5WpRu8Lpm1aFPQ?=
 =?us-ascii?Q?Xl4qsaZUPxeeERL2AjcR4ftFhJ+wendJjMO0V57B5xDMrN8YpASC2LCxnCR2?=
 =?us-ascii?Q?2p0Yy7fxrbf22lhY/DSJ8YJEceslh7ELyH7TeXNaigQEIs/xcjfASnGoEkaH?=
 =?us-ascii?Q?S0BSkZMQ+MU1JlXUtJlVYseXTJO1GiKyT+bGEJCNs3UtXANPFcnMj4dEXld7?=
 =?us-ascii?Q?zOb8fTzLFPSz+Pp3uce3ZYF5UWItOKNaTosmHHyI1VJA2RrOtSqEN0ilKv5l?=
 =?us-ascii?Q?AWEg6uF7ZjX6HNiA1l7lG0ZT77bZhG8OxdDBXIxb1II/0gZ/90c/eW5unjWE?=
 =?us-ascii?Q?SJI4ac5WHsVkVKm/5EdT7cZZaMW5QU7stwPoVBp0u773Gj3g3CZHfj6nEXTT?=
 =?us-ascii?Q?35eHpYbO1iCzF0MnMuKR/yDXICcUx06Say3/HmEtGbtWA5541LTAct4YMESX?=
 =?us-ascii?Q?cZJtcLvS3xz6oC1jEb3oolfm3z++gKPUrG0qs2OdliPK4SOKuxfjowDABAYA?=
 =?us-ascii?Q?p2mZ3nVGYioVNci9xk9104gJ1U14fFJMTJHKS5jMyGJ1MuZ0CoJQJCJ4aZ2c?=
 =?us-ascii?Q?2g5zBhvV/R5AGnhRhSWNgbrvHWZ7hi/eXIvgOIySso/JE4OFVx2K/mEdAYjs?=
 =?us-ascii?Q?vIWq/JFzPrx79q3hS1ogcCQqOQX8vQFl4WUt/KNH5g5OsvJCEFmh6uHGalmn?=
 =?us-ascii?Q?ut7aBSVJagdYmQw3M3C0IqyZeFQvCcJMu4PC8AcjyqTMDFX13lIFfOUxL49R?=
 =?us-ascii?Q?2lPxEbNgJOK2EOL4rn1URzQHK9Om/lemP2hW4zXtNeaiHDOFT1LjlfIIgkVM?=
 =?us-ascii?Q?z7b3pwvH77wXmhZfnK8bVekZmwGDVn+G4Mz6KTtDcPEqh+7+kP6AQB7pOX+r?=
 =?us-ascii?Q?7xMfLbvszAX8n8K2oBdCZGbzNPdcJxzUdJCgPNZ7orRszUuzcNWF4h/Q1TsC?=
 =?us-ascii?Q?05FwdbSiFYb5ZGAOfwVfi5o+aAdsubHsiEeTkcrEhvHRfaVbdlB6OU8+uZlL?=
 =?us-ascii?Q?iQf6SoaIrMHhAiTGHPxVnzWvqrgy/hLvKgX6FZ1dBHblglYFz3g/Y3lzeoHO?=
 =?us-ascii?Q?fgQvuaXWO0DXOFH+1hiNU9uQl515sx+zeFZPyDRS76IUB0AYsL+ba6yN5mxL?=
 =?us-ascii?Q?q3QJsoNAT2crDPusDfgOR2NjQ+271R3CicDfYXUECu0oS9QuxeagEAa8pPQ4?=
 =?us-ascii?Q?E2AY36hvEw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6631bca-0049-405a-c9be-08da43a3b898
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 07:52:48.5378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c7F4AByb1ev5By3qpnlebvR8gy8tjNmQKYcDr+qldgAM1d+HCH+Bv1+hiRuuzgktPeNfsWIUT+MI+xWJBD4p0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR06MB2094
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following coccicheck warning:
drivers/leds/rgb/leds-qcom-lpg.c:1107:2-34: WARNING: Function for_each_available_child_of_node should have of_node_put() before return around line 1110.
drivers/leds/rgb/leds-qcom-lpg.c:1286:1-33: WARNING: Function for_each_available_child_of_node should have of_node_put() before return around line 1289.

Early exits from for_each_available_child_of_node should decrement the
node reference counter.

Fixes: 24e2d05d1b68 ("leds: Add driver for Qualcomm LPG")
Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 02f51cc61837..05f064543444 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -1106,8 +1106,10 @@ static int lpg_add_led(struct lpg *lpg, struct device_node *np)
 		i = 0;
 		for_each_available_child_of_node(np, child) {
 			ret = lpg_parse_channel(lpg, child, &led->channels[i]);
-			if (ret < 0)
+			if (ret < 0) {
+				of_node_put(child);
 				return ret;
+			}
 
 			info[i].color_index = led->channels[i]->color;
 			info[i].intensity = 0;
@@ -1285,8 +1287,10 @@ static int lpg_probe(struct platform_device *pdev)
 
 	for_each_available_child_of_node(pdev->dev.of_node, np) {
 		ret = lpg_add_led(lpg, np);
-		if (ret)
+		if (ret) {
+			of_node_put(np);
 			return ret;
+		}
 	}
 
 	for (i = 0; i < lpg->num_channels; i++)
-- 
2.36.1

