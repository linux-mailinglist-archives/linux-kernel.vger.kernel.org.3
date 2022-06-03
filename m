Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120B053C6E3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 10:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242809AbiFCIWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 04:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241535AbiFCIWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 04:22:43 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2035.outbound.protection.outlook.com [40.92.107.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFFE6157;
        Fri,  3 Jun 2022 01:22:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzs90aKGCe3dnPaRQVv2yrs0xgiQkbGSbH0vdaa1bj2AxKrdk5eQw3V/sgZsqpa1Ao4qspRb84Es6fgN4vBD4MbPjnoyUIKYosFm45HpE3wyP532FwmWzMFtU0YXJPJZClfVwUxapG/Nc6WdxHAz3twQ0Ffo4nGkMXv4bOsbhz6yN6w3q0hA4yXqTc+AAMJOR7fNS7+FgGdYg7R/9lPkhuHE03dOUPYnzN6SyuPZ+qBWXMSaVDXQw00Yuacn2t6Udyk7R5TyOsHpOt2z5QI6LUZ1czV+H7OLByEiVddrlckYvr7hoJIFuo9urVZAcz0aX4bZvRkTGm3dxv43R6QjMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPPS3OM+oLcH+jHTaRIMptUGqVeEnRE352zDUXUidfc=;
 b=NKQ6e01VUs7E0giLy98M76oE8/xvzle42ZKicODkIgZyMQ+Y8vRKvuUOm3NTyTynOb7ywFOz35ZG5LYHdWZ4TXxPCLlwMe3YzNXaP7XQzc9bdSn4jQr9HZua3PmXzUr6Td8btXruEWjZNCjXZVo6ZqCbjWieG9cL+YZneZYklGv38lWuwY/ifTKg/g9sWAlGWVzBVKQ1UloPBhBwSevVu5ZzXq7EgQcSNHVotomnF0v15UBqeB+9HLFalfSRNPeMjZJwXaq+Iyqp9ceWjAcFlWFQSQ78AeaqnR9/FRg2reZxX4SAgh8g41z67ZH81GpJi5UrRuUVcTyj0KKKDHK49Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPPS3OM+oLcH+jHTaRIMptUGqVeEnRE352zDUXUidfc=;
 b=gQOSBf8elHQRlJ/f9MChan2B9joQMCc+0RXxcrxVT3Q9Qf3JiAUC9vu7PWhIoR+ZqViFUh5RPWCfMXUEy1lzTNcP8OrCfvUl7fTv+hN7BwsMYP4fmTduPrcIftGufOPx+J6sqmBv66Fq6xtwRiFAiFxuX6ot5dKukA+lKZDCjpExzwNZl/NX/FVbC1Ar/CvrwMpSubQuz2CrmpOBtmnAYnwmG4vWc9bwNb6a1Qsr2Gkkte5zDy6Y7i5Lb0ftYChIfugLUO5pwxS59mv5vhtNi2vpdA28bxPPMGeqt/ikM9icwuoNUvGf4Totf1Jeo8a5NgmTZxiIGJg6soOx7bB2dg==
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22) by HK0PR01MB2228.apcprd01.prod.exchangelabs.com
 (2603:1096:203:74::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 3 Jun
 2022 08:22:39 +0000
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::8120:57f0:a75e:1ace]) by HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::8120:57f0:a75e:1ace%4]) with mapi id 15.20.5314.015; Fri, 3 Jun 2022
 08:22:39 +0000
From:   Kushagra Verma <kushagra765@outlook.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: dwc3: Remove the checks of -ENOSYS
Date:   Fri,  3 Jun 2022 13:52:15 +0530
Message-ID: <HK0PR01MB2801E19D4FE569545BB7592DF8A19@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [7EKs9Wk5oJZOJQ3iW1pGKTt/EHqmoFvT1f1od4vCRbY31ZyFKnXvjhNc4DuRsZtkrEnJ62sLMak=]
X-ClientProxiedBy: PN0PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::12) To HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22)
X-Microsoft-Original-Message-ID: <20220603082215.15147-1-kushagra765@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c98be837-2ea5-444d-da28-08da453a38d8
X-MS-TrafficTypeDiagnostic: HK0PR01MB2228:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LDmtGCeQFjFFzLsGIkNQItxMOVAoyNdEhaaf+ihVe5KUUDzRfqgm6vSQjAsQny7WXgx4ZNoMqLmnBVjkT+gbeUOQca7c94maH6+0wYF3tRx/vvO30SOgO/O7bz+ELFqwzgjiXK454N+MdrFk1NyqBL27hOElLSBYmXSiqRenZXfUgufBRUIQjFJJErauCB6mGVnX26YetvyUQcBLaALi/wTfdYD3/ysmVlswj3CWubOJWZXfVu6F7ZQWnSsVLQaMfBrxoCfFXG38PxdPEeeMrlhEATaVomYtIc91KpBTzFuzfsMxjZUZD+0YquzLp0/gPWKdOpgQYqY4MgLjSczkpK0sp0nWx/4aBgYAR6NrVDoRdRmfld1r7JV7A2NMQUomQXj/RV4c2oLSp6v0rXOCFi1jPAFm/iSDqMn84kTpRz12J5szGdOfhLT9BlS0OgeVh0J8VSylAKBdlllyr8GZsJx4ozqy+GGvIsHRpFHpWQgWOMM9a1+SLLDG5d8gr2TR0pxC2Dc0SVqS08pYZnRG0IQ/rXZ8v966mI23FzBxeK7LOonFBZSaU4+Czj02+TxbLO0uYC/D2Cdl4qPWMo773Q==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zncvrg+xy7dJoJ5rFbnGQ6NZpo03mgaCCsEmE7++lyYIWlKH9DC/xl3Ve+Wr?=
 =?us-ascii?Q?Xw2Uwq5BvLac4mKH6b1iv8/ai4P/egcyQKLXmqJ3Qvwsmo0HwFJ/FRwEhA/U?=
 =?us-ascii?Q?qL3IYMeUvgSoMKnUW8vBnNiiGyFsAghMLW5AzbOJ1qF5aydzanMIk5i0eAq+?=
 =?us-ascii?Q?UFz6HSLIZJ6mZ9NRB0bAqwXKovOifh7VIizPilVxpoh3/1eBEmKfPpiusmxW?=
 =?us-ascii?Q?hKlZQoa/Ii/82otdwnkWp0mvM7zAyOWy5QLLqTQIGa/NAnxF3+XumYtjYji8?=
 =?us-ascii?Q?P40GYzsOT4vUC8EISAR36saxTU3deV8HkMQPsj3bP8LoH2yKlmqgi87rvSCi?=
 =?us-ascii?Q?hFupkHqhpM9AgGEbDTcjU9qZHDpeeXexyabmAVV1kdTaNTsKUVhManIQmSnT?=
 =?us-ascii?Q?49iGQCX/ZRyGgw/aH3T3AuRVa0iWOhO/eHj8eQLiyfssHxjOvvHmuhOAMz9s?=
 =?us-ascii?Q?EfINdd3rj1Iet0BitxhRwOYMbvpLZQzEMBD4ot6Rz9tEuoC6KyPjb58D1kjB?=
 =?us-ascii?Q?WIfd58hPHuwf5P19weOPccTRCITDvcHLuE2obShd31YAgSPIe52uGz0ZhOWU?=
 =?us-ascii?Q?ebd0PUZhaHIg2N1w94UAxjht96aIVj0hSfXoArU9Tijo0thJ8KquYN3kRXa/?=
 =?us-ascii?Q?NnoYlrSWPtcGZBqM1YRM3hLL0SXP8CgCU8Dkwt0ZGMRIfzGfn5sWRutZ4qKP?=
 =?us-ascii?Q?z5MQqWTCIlJ5M2pidxIfjivxDENkP0u5ih8XDnXC4AtOICP7YeR1txYftMZi?=
 =?us-ascii?Q?9HZ0nvDmY7Fy7G4qqKsR0tu+Qrq+tNCpVCjaI0yeGaqu0yvOevxPZI+r3J5A?=
 =?us-ascii?Q?sCVjb4UmPAJZ4aewdp5Z7xIaQ9+L6tXwXjMPkykjtBO7zqjsap92W8ZEa+du?=
 =?us-ascii?Q?WOc734MPAYfF+Akc3pf1B0v5fqLG+RKQXlkukvci+ofIhqekiPJaAfEZtbaS?=
 =?us-ascii?Q?z+91+L79yLcM3WEYphS5zv7R/49kZaIfA9XYDvzZ/YvUepctOpHX0jdztTdp?=
 =?us-ascii?Q?R9+Y5LDSDioKfwuqE7O00ThqcxESAwSMcWhXEjJ5WBA/tWCgxdyO+W1vArle?=
 =?us-ascii?Q?8yxCNuUiDckE4Kqi8TICdV1B+MbeY/5n/y0YZTJumLIW6uFMFymQEv79GFts?=
 =?us-ascii?Q?7Gs0wJ9JRTXOYoX9+4irx/Npd5HJNVSkIs2f9wqGwRLp1xrVMnIEvlAEOhAH?=
 =?us-ascii?Q?laVrP1LfyVra4jyHq6t0XFqPKAB/wodcHS7bVbIGKwL7N0Q/tn6/FpMyad7m?=
 =?us-ascii?Q?Oqb4J7uhlvY7ldluS+b5x0/LAx/oR0EgLfvPn6d6j5EpDB5gVUNy6HkezPyh?=
 =?us-ascii?Q?Ab4Yx8lTsThhXfV4WDQDxKLakGM4GPbomX0SCtlrc0t1ogkAbtFWvEQXk7yd?=
 =?us-ascii?Q?t3qAnnG6BhYBXwIuP2r7wJmtmqidK0OGy+tcI9/IkOnQM4y0eJlR40GBfAjO?=
 =?us-ascii?Q?Kg3FyRWAMw6a7sn4FssTh+JWn1itryQ5CCtWDNf+VYfGKxR0IioKyWjhvLMy?=
 =?us-ascii?Q?u028xMTxiRuIt1cXvipZj3EEwTOG4vajy4HI?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c98be837-2ea5-444d-da28-08da453a38d8
X-MS-Exchange-CrossTenant-AuthSource: HK0PR01MB2801.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 08:22:39.3782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR01MB2228
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 57303488cd37d ("usb: dwc3: adapt dwc3 core to use Generic PHY
Framework") added if statements that check 'ret == -ENOSYS || ret ==
-ENODEV', but the function phy_get() which is called by devm_phy_get()
returns the phy driver or -ENODEV if the phy driver was not found. So,
remove the check of -ENOSYS in the if statements.

Signed-off-by: Kushagra Verma <kushagra765@outlook.com>
---
Changes since v1:
 - Include commit description and write a better changelog
---
 drivers/usb/dwc3/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index de3f52a63595..adf655d685bc 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1284,7 +1284,7 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
 	dwc->usb2_generic_phy = devm_phy_get(dev, "usb2-phy");
 	if (IS_ERR(dwc->usb2_generic_phy)) {
 		ret = PTR_ERR(dwc->usb2_generic_phy);
-		if (ret == -ENOSYS || ret == -ENODEV)
+		if (ret == -ENODEV)
 			dwc->usb2_generic_phy = NULL;
 		else
 			return dev_err_probe(dev, ret, "no usb2 phy configured\n");
@@ -1293,7 +1293,7 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
 	dwc->usb3_generic_phy = devm_phy_get(dev, "usb3-phy");
 	if (IS_ERR(dwc->usb3_generic_phy)) {
 		ret = PTR_ERR(dwc->usb3_generic_phy);
-		if (ret == -ENOSYS || ret == -ENODEV)
+		if (ret == -ENODEV)
 			dwc->usb3_generic_phy = NULL;
 		else
 			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
-- 
2.36.1

