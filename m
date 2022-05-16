Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504AB528013
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 10:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242003AbiEPIuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 04:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239384AbiEPIuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 04:50:12 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2092.outbound.protection.outlook.com [40.107.215.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FCE12A96;
        Mon, 16 May 2022 01:50:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODEygzhUyu/jDrxxoX9u5oSmW8ir5QfClmyr6MncFfsJ2Q4PINbviR2ECwHFVpFO/HnrSGnAbm7blNlXaZTo+NWr4H+Ef0VXFgOsMvSkeopZKv8mu9QwU+uM2y4hCgIxglTIT3wROwGCFewQegFC78RRe1FK/g3GyR9lQ+YobH+Sx8D9uBdlVQHKw8vTBUuKV5zGPY3DuBYCAmCL0b/kVBz9jzKi7SRBPrnffBT0qXF4LB+7AkSs1AG79BO2axoQ1B7RVomqj+QSVX9LzuHQtPm6868YyDjTyp2s5wu71HVBZirPmyTsR7MXVrtQayCIa3ULee9knHbDl+4Uzkw0fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZoJzoLL29L/yWw73l0oO8lQJGy0l/bIbvEwWsTxeLw=;
 b=YeW0La4f/vlSehXGibmlEkZ1GLkEEBSr1CViIhRXER5EBYW8KceE7ySXPKzmEhhbhfytxvbh8NxfySCgxlhZWNsdyOn5tjEbJ8s1UXcmManOrS9PcrJXvF5Y/o9CP7oWz6EQbqWRYylfkXyOzj7HFJc0QZo+aEDeWVHrvP3cJt3ZIZBO5xJR97ZCd6NFJRCra31Z3kRxEGRtFJC8GLDfu4k/U3ItTmrKU0nESl2Af3OUepy4K9RtjT9JvbJaEoM1BWhdG86mccKaOEzXsjRTAZ/2kNli1MigYFiHIwff8uASGB82IXvDQRXshUCjKDGe9oSPQzMkFxpiB/OYF1/jAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZoJzoLL29L/yWw73l0oO8lQJGy0l/bIbvEwWsTxeLw=;
 b=EmX1Qx2JEckLRWcyoNZG2z1OTedhS2tjeiBpHk+GzDTpNknJSeAI9yQV1qOPL6SyQZpgMTdMiv10gULX2V0Y2dWZuH/QIsf2SDbfGKgWDdH0iIBG33ikI59pBTOQW9yTBRpCvyxXPquOTgs+6fj5E/+rfKm9hzroijwpC74Ma2U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 HK0PR06MB2433.apcprd06.prod.outlook.com (2603:1096:203:60::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.14; Mon, 16 May 2022 08:50:08 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::ccb7:f612:80b2:64d5]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::ccb7:f612:80b2:64d5%4]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 08:50:08 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] gpio: ftgpio: Remove unneeded ERROR check before clk_disable_unprepare
Date:   Mon, 16 May 2022 16:50:00 +0800
Message-Id: <20220516085000.9861-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0197.apcprd02.prod.outlook.com
 (2603:1096:201:21::33) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1e2f99d-8bde-410b-f707-08da3719149d
X-MS-TrafficTypeDiagnostic: HK0PR06MB2433:EE_
X-Microsoft-Antispam-PRVS: <HK0PR06MB24333BFF3F41B0853EA22921ABCF9@HK0PR06MB2433.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oAnnNM/MQmQ96sdKSqqA3Qs20nXGAuhCqZIl5fx1b+OAI1foRgMIS4htGqldeHzl2rEHSSSMKTpUrwmnvqQxGRtBZbGGxkgKuazImg4NuzAygW4odSFTYdOqxLicqDvzeZmklKv3Go+XMCyclW8prLklI/FLel7kPZitUvjYfOAZYaW5fb6yMbpFRnz9dhboM4wPiLoF9bU9qYXYlMit5qIgaFDyE0aRzZCwaes7q+kuVPMqDBCbjZwg/vmfWBzR/DSDyeNSrg3exAMNmqY/0JDDFiiKH+yjvfGIdv9pH95LheA/agBkkAM1oXtcdu9rJvt6Hm5hwR2H/D2EH8QO72CTJLLz2Ro8uFKMK8uIY7zVWZE/BFfvp9VrfVsYhSExmADl/H7fw51eyaavz2Kk7OBCgggIOjueLaK8m+cS0dkTlEbG2rdM/FnPif8m+1IF0cw/zVeQA0K/Ixkz6j2KU46Wpy2PtM6H1umCY7GI0XLZK1e9Y4Q2E0EO/PrsJPQ9gwjNTBzCmaki7cNG5B8obZb7Cbrk85TTEEn3ZsQjBycEaz/dNmtVrUrFpAziMXsdjbMW163pcPJXaXqrr2bmjwk03iDmz/0PNMDDGq5I/Fw9FH2zy/VoO/OOqKk6Au8ZRWRJRfqil9F0N8wIRUKVLUM2RTi/ocOx3VdFJyz1hJd4fqehfmUhCCX9AiXsH/nQGByG294M2Pnij43m/OBQBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(66556008)(86362001)(2616005)(8936002)(38350700002)(38100700002)(2906002)(6666004)(66946007)(52116002)(4744005)(66476007)(26005)(6512007)(6506007)(4326008)(8676002)(110136005)(36756003)(316002)(6486002)(508600001)(1076003)(107886003)(186003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vpuScBugjw2eZxJzLJM0lnm0+6kDxn0gIFmDflo85EvGW3pFDXXBToHfXFJB?=
 =?us-ascii?Q?yGEHnShXqXCUMg5o7wbTCbrsmxfzSY4iHhoLIPEg208yCce2Ow4S/YC4VVD8?=
 =?us-ascii?Q?Ezyz42n4FQQDlU9sRTgraD6wrcbBlR6vxdIePiQL71mn//1zubF3mhAUHZ32?=
 =?us-ascii?Q?S6SyvIWTSno2L1d+j3nZ0Xil2s5jV0MUpu/QI8c7kq1eqkX9rs5xJ91NtrAb?=
 =?us-ascii?Q?bgmkVxjsIBj5OaDtZhnpbrPD/w1bU0ogudL1T+AOxv/N2f/Vf1xbF5y2DjkV?=
 =?us-ascii?Q?BBOdyXlEBbnvqfsyiZKrijyfroB5bqwMQ0/fqqmnibm6BbHUf/i9Zsp7FxJC?=
 =?us-ascii?Q?4bzDQ1/HgVlFLOeytSql1t4waodxkpnK+oSwN1w0cQth84uw4okfhiqaUkTu?=
 =?us-ascii?Q?G1WxTiislww1f0SmEykuk0PerSOWZrPj2k+hLOvvZBSypI04NCZ3XHQgEz9c?=
 =?us-ascii?Q?ZLPyBrnCrstxExzBa4lHVqitMopE8o0EfxIUA5waZRWcgoUHmIF/R4jxfrmB?=
 =?us-ascii?Q?21T2RsA7NLRNg7ZRfpLwi8PV0cf/fcOBwuNU5H+EdZScS3OZ9Ah1MnjlqC7y?=
 =?us-ascii?Q?46YwfX+yZ7DrdxOgnFtzV35JW6fsP+LPOTD7pCnTCWov06U6417KrCzODSg5?=
 =?us-ascii?Q?0hzpR5A3+Rof3B95CCXkCsfDM8lwQo/r1aSmz9/gSZGdMyqbcpVDuQnL4jtI?=
 =?us-ascii?Q?EIer8ie61V+Zoqy83NhBI/UUjoPwahWKVWDfJ8c5S6ktaNF7UxO6/CPc/yTx?=
 =?us-ascii?Q?9vKreJmUKm9j11cy4djGU/F4OX4rx7Dt0hfB9lCeDLc15inRJ+98rgK2sdFu?=
 =?us-ascii?Q?OsFmR/DQF/ODqpVdzqv8KuwbOrY178LL7jzQuJbdWSYWAtdvcxBcZ+ZUNuQs?=
 =?us-ascii?Q?EyVDePKrn3eJUDT11XObLw2Fs8U39EjDT8VPOhCWTuJK1pRtmxGRiOnbHoYa?=
 =?us-ascii?Q?cNmUhVbWtLNpODYMm+63hiiMJVtpxucSnBkuSrCseFPAgZKM3Eba03FzpfBO?=
 =?us-ascii?Q?JDIbz54DCImyCLnjqWYMQ53PsOUuT1X9dyK+h20kvQv1YMpkq8Ep1TyxfR1Y?=
 =?us-ascii?Q?bQH+KUxcybpdVPMlu4EJblYiWbvSicMygsdxgTOZGbM8OyT9Jd0/90Va8haE?=
 =?us-ascii?Q?vrCdCZi7DdmS1IynIEZgEDS93Ovukfe/QrI2hCwJOX/IMQRkiHfaHFrHLO5I?=
 =?us-ascii?Q?gw1Bj7fN5NSUuIo2yhw7CtgHEiYnSzyIWE5aPpCvUKWWjLVuTfKXZ24/xdzW?=
 =?us-ascii?Q?Tkhi29YxdE2iAZxyg8726p92h8r74rqHEAXo9NFvTYOHytmQvDJ+SJ5GPcMM?=
 =?us-ascii?Q?SLb4np9ISjKKotVw995qeDdVVm86eNdVNN2Us0Mnw1SipftU8K1Cm4AFXmGa?=
 =?us-ascii?Q?sjbh+w+cQ9lHFCF2dnI0rAuQ6Yx0Lfnyns1/UHdStgQRJ5fpXbV5PFdpnspg?=
 =?us-ascii?Q?LrkWeHOCHHiUDOJ602XH37R6oik9fn9RfOBzy34D2EQMhHSzmL0iOK4ayxjh?=
 =?us-ascii?Q?Vyef2zkU+xnNbtu3xULvjGxUsf0cSLPi2T9yfdIIVf7E4dKqGS8Pqz/Wnqn0?=
 =?us-ascii?Q?LHUEn7TC0YIydjdIKAT1o0CMNN88ptF5eOLr7HUeolVSg2IUO76pBwt+H6Fo?=
 =?us-ascii?Q?JrqjR76gxXcg+Sdobm9Qy9BdcRG8aKULfstmMEjWEVUiU1dC6WQ0ACglRJIM?=
 =?us-ascii?Q?YWlcgmwC4II7xyiRSzBTsCgG5CnhiWNUwux9AULrNMBy05dhv6XlKHxPchte?=
 =?us-ascii?Q?7/0L36gnkg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e2f99d-8bde-410b-f707-08da3719149d
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 08:50:08.8296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQ4YWBGG7S14MkOPrEUaQFSYHtF6+OG9R8fdXh11dHbgwjGvNukLpd1vM8QeHR/ZXHSfog86rANnRZXqb6E7bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2433
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_disable_unprepare() already checks ERROR by using IS_ERR_OR_NULL.
Remove unneeded ERROR check for g->clk.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/gpio/gpio-ftgpio010.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-ftgpio010.c b/drivers/gpio/gpio-ftgpio010.c
index b90a45c939a4..f422c3e129a0 100644
--- a/drivers/gpio/gpio-ftgpio010.c
+++ b/drivers/gpio/gpio-ftgpio010.c
@@ -315,8 +315,8 @@ static int ftgpio_gpio_probe(struct platform_device *pdev)
 	return 0;
 
 dis_clk:
-	if (!IS_ERR(g->clk))
-		clk_disable_unprepare(g->clk);
+	clk_disable_unprepare(g->clk);
+
 	return ret;
 }
 
@@ -324,8 +324,8 @@ static int ftgpio_gpio_remove(struct platform_device *pdev)
 {
 	struct ftgpio_gpio *g = platform_get_drvdata(pdev);
 
-	if (!IS_ERR(g->clk))
-		clk_disable_unprepare(g->clk);
+	clk_disable_unprepare(g->clk);
+
 	return 0;
 }
 
-- 
2.36.1

