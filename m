Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CDB4B085E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237519AbiBJIbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:31:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbiBJIbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:31:11 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2092.outbound.protection.outlook.com [40.107.255.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B546E1131;
        Thu, 10 Feb 2022 00:31:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wst74PiRmZQtoglVi3tlFJGk9agSMMegjsOCkefqGLBkhr61n1YAWykfsTEY/C4V56hoo50D07sg4wQVD6qQtU7DBUN1EY6lhY4rwKdngBOBPdlDvx5ftQASRXkHTKDwnKyu81pDupoTl/4rRKnEa0qoWiRhKW2bpFyD62OARrhhqk6rQQvLeOi40l9yk7IV1iKe8ZzF0s2s/VH2O6IBftdCjmf5WVN3A7wLBpLU5T49j/P90wuYRnLeoI+rf4dg5iNL0QUVJM+OknI4jJ4Hk/2TSb8mfXwwFKuasmU4+xOvNnOWxaACLdgrK6WgrlXq5m4FmRdKW++YxCgo7M5/Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2gszOwt2VTisxx3KWwoKue287UJUfSWAqbjrvRfxvk=;
 b=GL/rx6m0jjyhFOOXYkmM0op/3oGlrq6TbcppNpK/4kWgUpC8kyhWs/tlGLshQ5eiIVV0uiHlfbyyzkI/n6LAdBuJTEwEF1SGMasvFKF4k5mCZz37Pas/omoBeZ9oCwe7axNih81krapNDj/QGqpA3zeAjNGsk1ms9WFVg41Q0vuc6Z0TrIyHtZ1DBhqzuhq+H8+0gdCsjm3TpLu86HEh6+GvJUrScvxG1cryyzk8H2qCqdwkQhhmcnws+2YwDuDuaHX0t3aOxuSjt51kdS4EtFZprCxhdDc6xkNjVZSK+Rf7J6gSed2/HcPJAltTJ//SKyWEshUQnbsVCeqBuTraPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2gszOwt2VTisxx3KWwoKue287UJUfSWAqbjrvRfxvk=;
 b=ZNzD9ugTcsZr7nStt8mgLsGFiJ0sa9bw0bIXSEnrkeBISS5P3Gotvd11PWAYkyCioIEUNkixjXde2ErO0PTz7Br0i6zgxDNKhOJHSMoe0oP0qLkCQpYbm1+HNIbWfecuL+N0aZt+DO9OhE8CbqGlbry9+1qUiv94pgI/u6jYmCk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by PSAPR06MB4005.apcprd06.prod.outlook.com (2603:1096:301:3a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 10 Feb
 2022 08:31:01 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb%4]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 08:31:01 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] input: serio: use time_after_eq() instead of jiffies judgment
Date:   Thu, 10 Feb 2022 00:30:54 -0800
Message-Id: <1644481854-14725-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0105.apcprd03.prod.outlook.com
 (2603:1096:203:b0::21) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e8feeab-ba2e-4d36-98a1-08d9ec6fab73
X-MS-TrafficTypeDiagnostic: PSAPR06MB4005:EE_
X-Microsoft-Antispam-PRVS: <PSAPR06MB4005488F537A23C4B2B75088BD2F9@PSAPR06MB4005.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zfvBF4y2K0TmRgsW3kNvRkFKD+m0SxRl/iDppOuh7snDg/s//YqHBVwt80EQtGkX+YrGCLlzAZuNkyc1aelFgI0FLQaSN97BcoRRA/nNVhvfTun+f9RwXt62s7J0Y7Oxrb5djU51H5d1nA1pWNSAIfT2RKZqifSYLADKwHGi1TSIfQTr6j7+JNQOqfBCs3wRkxssbw5IyoCQ1tWAJgE0RLJ5UAXvbVSzp/Hx3uMSEsnx98j8kCH59te37jWguSXQjzW/8uJeIV1e7qnxd2/gLxlKnqj/yqDyGEm9i7pccTkoyvVwYnKZ90eZAJy/ECKP3g6VGo6lw8H8Ch8emqTnW1UbJgVBPABBA7O2YM2kV511a0e+GH/nmElVO0trg+9rRtkfqFkE1l9td9QwUPpcaKzr1AeHF1kTYfjEe3b217RxdnZtuRFcdaN7skNTJ3UhKyNDtSPFMMSj2f8jU2xysVY+GLB5eSZoy4CkgN9nuRCoSsf06+htV+Dv0Ipxj+Wma4uOhw+HqnDJr6KQr+MPJbhg9oEiXTfnehuGPRknGsz6VeeOLxdjKb/W/NHMo1DjPmO76MN1j0Aq8kNjbnzOc3ONDE5aSUolCoChUCO2tczp5Pp7a3DbA6OxiFecl3lCThwZpnvOBLCKNjFw3KFMdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(508600001)(86362001)(316002)(6486002)(186003)(2616005)(66476007)(26005)(83380400001)(107886003)(38350700002)(66556008)(52116002)(8936002)(38100700002)(6666004)(6512007)(6506007)(2906002)(8676002)(5660300002)(66946007)(4326008)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: d4mulukw82gQMBkJziUiv/2DK2IL0CqDWwlwZzQnQDOGpLKaph/z3DAnJZwa2iBLBS6KWGOTPWFAVz+ltCkOF0jkR8Rs1++8APoHxz+Sqrw8TcKMC5XHl2p9IyCOJdIjhZln+fIyhVXeRnbaMohvAUd5NZr2aIGWmbKSl4xC1ysGWFlpgNcwwApXv0o58LN6WkMk3jrQfQiop6HcSPFgImEf+VaJjAX7z5WbJIeoR9Thq8jX1VAohrZWa+kZudWw3E1HZpzH7RpSKPsFsG3a467t3pPHgd9ort7CC/jSNXPvo7mWPeq/sqga9GZUTNUeaE7XC5WdrCWjKP2mxgFdpYvdYqeQoYhZmIs0hY7HY05abdF8Jju6P0TgcG0Gt5DnR3I9A8wOzpTH49fZ94vArjr3Tv2UDf9x/2H3+hzpJBf6BT3vZnQGi2By+iM8iqJs
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8feeab-ba2e-4d36-98a1-08d9ec6fab73
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 08:31:01.3984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k1OJ8+VCcespCfoNrMj/WXaIG1PxzD0GsyrlQ9hCmKAzdmPrUHbfyILvE9W51p9/l1CwT+3q7zu7ziD7mYgM/Q==
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

It is better to use time_xxx() directly instead of jiffies judgment
for understanding.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/input/serio/ps2-gpio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/serio/ps2-gpio.c b/drivers/input/serio/ps2-gpio.c
index 8970b49..7834296
--- a/drivers/input/serio/ps2-gpio.c
+++ b/drivers/input/serio/ps2-gpio.c
@@ -136,7 +136,7 @@ static irqreturn_t ps2_gpio_irq_rx(struct ps2_gpio_data *drvdata)
 	if (old_jiffies == 0)
 		old_jiffies = jiffies;
 
-	if ((jiffies - old_jiffies) > usecs_to_jiffies(100)) {
+	if (time_after(jiffies, old_jiffies + usecs_to_jiffies(100))) {
 		dev_err(drvdata->dev,
 			"RX: timeout, probably we missed an interrupt\n");
 		goto err;
@@ -237,7 +237,7 @@ static irqreturn_t ps2_gpio_irq_tx(struct ps2_gpio_data *drvdata)
 	if (old_jiffies == 0)
 		old_jiffies = jiffies;
 
-	if ((jiffies - old_jiffies) > usecs_to_jiffies(100)) {
+	if (time_after(jiffies, old_jiffies + usecs_to_jiffies(100))) {
 		dev_err(drvdata->dev,
 			"TX: timeout, probably we missed an interrupt\n");
 		goto err;
-- 
2.7.4

