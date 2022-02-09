Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9A24AECDB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242955AbiBIIlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:41:19 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242580AbiBIIky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:40:54 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on20716.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::716])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8AEC0045ED
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 00:40:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOhoo/GPZcJAiorSGGuqds7Yjs9Vylv0jp9K1YW4ISf1GTPWR2o1z60W6n2+Eu6eu3B7oajnjzYs1O4Wjmgo93iuCj+sXf7R5s5LV7+nieMBrFkv4I76WxyzDadrB8iD07Clp/Cxqdzms7WfCAjrMUHv11tHVF4akPiHIRiTh8izpcQMmO6hxfkWzGGJomrvRTGEAOiC+Wv9OKRolkJB8+ze6Z8hfD000Ep5WGGY55t4A0LGvduhENUOv6/pok4Y0UsJ6JBeSAdGk67hZj20nosB4MbIs04AGiz6tf0asxfs7/P4qP/q75HuYCNzX6w+YukO4aSBhxhmbyIxBLJTXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lh7Du9veCEuOTOQ3okKfTiJS0bn1m8Wk+eE9Yx5CcHA=;
 b=TNJu240bFMaqLgGT9JOkkNIMIS4zVrH4CbH/NeqFQPk9ukvyG3oa0NxibcQIYW5aJ62TB0p5CHk78pKQ8YjJeFPZyBAdTog6W9DJb/OQA7aJHurPELVWdcHcsI9w7n70mtMCkzp7Q4y8UxI2AHtUx6j1hdhiIVZEUYBP2L7WCuFcfMTnbA1ZBooVSF2fRpnAfh8Ss25ceDU6GmdA8XhoLX/ou94wbIIVrN0fscw5cLjZ6KLY23iipvrjTINoK+BSnq8iA7HYa9SS6lGKtYsCBjogKkB7gI6RdboAWXOeDzV3DwvcZHKY3/AYAZCxDL3plSMxlJUxe0OzYJd3O9d+RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lh7Du9veCEuOTOQ3okKfTiJS0bn1m8Wk+eE9Yx5CcHA=;
 b=OWH8T9amzIju6HSumpavTezHRGrEQRWLkV59waIatWWtLk7FdvPV/+zkIQC7fA6BBG/7KjeeUkDAI/gTtDA6ZX2bByG7HV692dCCA7Kj01PbBYdZ25DflPurF1HQaww0vUuRWBhkJ6YI2A7trVoMKsA50sPL99QJcc28iZneNgU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by KL1PR0601MB4387.apcprd06.prod.outlook.com (2603:1096:820:7a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Wed, 9 Feb
 2022 08:40:17 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb%4]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 08:40:17 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] staging: pi433: use div64_u64() instead of do_div()
Date:   Wed,  9 Feb 2022 00:40:10 -0800
Message-Id: <1644396011-4450-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0059.apcprd03.prod.outlook.com
 (2603:1096:202:17::29) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78eb992a-7aac-4b00-4117-08d9eba7cc75
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4387:EE_
X-Microsoft-Antispam-PRVS: <KL1PR0601MB4387639700B96B8B2C4335D1BD2E9@KL1PR0601MB4387.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VQJn8uizQzpvjk1mIAW55YsbDA92sqCS//qyJDL+8Lm9o+0ypcZugT04qcCClVkT69VEnKknsoI6i+QRO9limfnQioDZ6SiJ9fLgXVK8zkjLsslSOve2uiFn9ZAYtW6964P+FR7GN6HkpSwUFdhrmQXrRtZqx7nMX8wzQz0WMk78i1X2qnR7meylIZ7ZajS/IT87JLKwQookdn3v5509UJEGKHbFzQKrX7xByhEVUZ2mkewpwqmtu9id+k/UpNogPvNpXGguGQiS8/N6anYKSnBXb9ybRkNf0O9cM3ObveRvqs3qFx3JbuhKYv8arv/Wm5FrhYA9rtvgDgayxyGOahn0vjDUpvykpbAIe/HrR/s9Fm+41M2zz5CPU+A2dcAENF7zvd6LEgbGerarIL+rRSwpXF/ofJc0V8AB6UN4Do0AL1jM2aGPHYOSLWWXXz/0Bjxr4AR5c7mkoOHAe8F0o6AjFSIriY3Zn6yxOaij+73qfIOGL83GR7VePz76vnYpETC2hYzCljnoKt1ggIV8Jek3BZJOIm+nflPIJQUyTV1eAjsIsZrNYY43Y31cs/n2ExyM6PS3FXASDahIx8V7eqKbP6i0MV1KzZKgqDLsEHlCxBIRHHXtwuuz9IclvXwcwMG9XHunhBGUHkyQV25MvX9dvXgDl/bkkCLs+SmSxa65rEcoXFBbjGnW3VtGsTDnLDKypxgUFvR/y4U+HLwUQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(4326008)(6486002)(66946007)(66476007)(66556008)(8676002)(86362001)(38100700002)(38350700002)(8936002)(2616005)(2906002)(107886003)(36756003)(6506007)(52116002)(5660300002)(6512007)(83380400001)(26005)(4744005)(508600001)(186003)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OvtbvPdlSTM+P7wpEntL36reX33pEHXg7dCSQnjderZmuAdkurHKTNfSXAfd?=
 =?us-ascii?Q?d7BkkbO8CHhBuMd1zfETTAEcJIsq3meF3FH6XPe9B4IzFAFPzkT42MMMWEAn?=
 =?us-ascii?Q?vHNxhuV9lbapZw2NYwOvqN/1jvFeUKFSWe6dUqgJCeWWYs5amLP/teE2MUr/?=
 =?us-ascii?Q?KbbKcreFDHSNrCWLFtUAaUb2C6JslgaU53FbWx6VDO+w/Ha27eXjInnTJCxy?=
 =?us-ascii?Q?yaimiOvroqnMnrdrJVhG9aqPKk8ecKqOaSGQD5KuD5MpswRqAyNsqRniR6CN?=
 =?us-ascii?Q?SHRM7vwxx4txUD3Wag76wJOO0U6W7a9ZvoEbMxgZbsgMOsugR7mRL6hS9IId?=
 =?us-ascii?Q?lt1bbydinjbex3yXDFyR7dy4etNE4WTJtClhRmMa0rlU80CqWW0zslyKaRUT?=
 =?us-ascii?Q?cbUwC0vqfAdmmvWmxw7pNNoF3SKApySmYtwRxFhaQxBfg1PwXtU2fO/ZBZiE?=
 =?us-ascii?Q?Yt5Vy8uRUC+7NakobUsaee6CWfCPN44jGy8zlhMWk04rF34KxDRm55icZVjk?=
 =?us-ascii?Q?iwbmI2uFXH+eph7M3joWIiOpRNJp/V5ZofIrhdtC7sEB4xVUjl3sVSEkzsRA?=
 =?us-ascii?Q?hNdAQ4wYh7jsJH3mrOWVhjO+g/PpWsVtQ+jmtP9oRGyZXLWv2vc7gNQw0Fky?=
 =?us-ascii?Q?MVZZCO0ta6IIQoFsbqzvpOlhNg7Xs5OU4UUkzvSeZ9ZPRqD4VK1H8Y0jzAam?=
 =?us-ascii?Q?esHIF6dByVpsTKnMZ1Ok4QSE/waEXeFt+uUSZgoswqG7e/XZRvxvS1/XITuZ?=
 =?us-ascii?Q?ZP+J6GkvJWAkh0H1yOqRSKWeT5JVqw1PY3NLQb0vjKqpZXiat9kUsOpfchur?=
 =?us-ascii?Q?rxCjzwhJD9wci7WsRGCnXXdlws/NemfO7YdVR0DPv7KmFk1MQrEPOiH5XaVZ?=
 =?us-ascii?Q?FdlSt/aQOzh7mA5AI03H+MhSS0Ex31DXPCqdkFFjg1Oatu7Ixa6YN2+GX1eP?=
 =?us-ascii?Q?75zmK7IxzTjSG29+iNQFRLVFLhCVPnjICqMw75Rne6QKXhRXWa0xiFCJ/ko6?=
 =?us-ascii?Q?BeGhTHiO5R72xOD18dHd3iqO3zQ/F5G8JBK9I8vMF7QnFGOAHc8eSiksP9qD?=
 =?us-ascii?Q?umn5wohMjaWLU3gNE5ehqsm+ITpvrxF8oJVrZsJ3xWlUIgARfNpSqN4AEYrX?=
 =?us-ascii?Q?MaZupVGLpDYIM8QLZ3gjJMuQJpjl2tvsRyqXO56bgQlwiR5XVFEoajgyUlIO?=
 =?us-ascii?Q?A0/C4ZD8+sdwXrIoIi4U9YN6EJtL3/K2qOXGn1beqOs+uu75W54grqGCkuP+?=
 =?us-ascii?Q?ZHt/B/O4CpNpeOfWPSnbSaf+WuvUF+58I+zVGS9r7lhKg3QQiitrPOY0HOSl?=
 =?us-ascii?Q?sUIklQw4UqQxfqfAqSZmbXK4L9HLJH2MsikCq0Mo6m0rG49ScPFXfFwYmLXt?=
 =?us-ascii?Q?25Kbvyboqt6yXxNvTJ3KGgHmSWQKEFTDAZjhR3ZyM4O9U6xs7pmdj0odYUFe?=
 =?us-ascii?Q?w7E+wRopaGRG8azHUZsW9sKW55IW5LgL+9kHVfxTxe5OzZZftNDwHT28HNAu?=
 =?us-ascii?Q?UOipELZJxoj9ClBHOA8UOgi48rxYVr3XKEq1xl29fFYSqZQWVGTrsgNVxkkB?=
 =?us-ascii?Q?rZWJQsLVSBbdMxyY7XdlWlPbHblxp+FWhVkfZ8cn0AbQ/hnCsyQCdlSn4X9/?=
 =?us-ascii?Q?OfHX/OuFVmooshrp9RzYs5Y=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78eb992a-7aac-4b00-4117-08d9eba7cc75
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 08:40:17.3656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GweKGyjKNf1izdHWfZmjJW97RyEDtHIZCkzCGXxVZWDJofzuMSkzoXb3n1suB8iqOEkrCWU8OCwoIr3+ghjzdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4387
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
do_div() does a 64-by-32 division, please consider using div64_u64 instead.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/staging/pi433/rf69.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index 2ab3bf4..cef542d
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -294,7 +294,7 @@ int rf69_set_deviation(struct spi_device *spi, u32 deviation)
 
 	// calculate register settings
 	f_reg = deviation * factor;
-	do_div(f_reg, f_step);
+	div64_u64(f_reg, f_step);
 
 	msb = (f_reg & 0xff00) >> 8;
 	lsb = (f_reg & 0xff);
-- 
2.7.4

