Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850034AECD9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbiBIIk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:40:27 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiBIIkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:40:24 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2138.outbound.protection.outlook.com [40.107.215.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465AAC050CED;
        Wed,  9 Feb 2022 00:40:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KtKeZKWQj014yUplJMbgakoaNZ1UoW0icI5puBt3XQqs3uh+W20ih0vlZN/IMkY8ESZLuU3EaNP4CXUO03XyVKCYtgSSZqrqm82Cx2bUw25tZdKvPFMURw31OhNq/tDYAi9cAeWIxppz0O3CNsVk5NAAcR+ztUd/NXaUHY+PIZ0MMEEhNcjg3rMybUzi7FSeaQGGEWSfmg64eU82EX+vXX6tA748525IqM2fwF8liIyBp73BRfYxNfruzB4bcPBwNDaFY1j9i5ncn2zXm0a8RlZ+Y/EX5Xip1vtDRHnpfv/KoRVJn5L5ZxFn89HXZfzGYzogwBeQ8KPk4BG4IQFyPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBZAQv64fQhA4g6Q/EFUcbKcNmSFPoGs3j3lOgLLGQQ=;
 b=NSvrtr+Rx3t5G6kr1H29wmJKQRTZUvvNxuvgG98wO3IzvKYZIoqmqp1eF5J+cpmdieqTMsoTlq4PU2tfi2jgnttYZE2Nx6gG0bZVl1zdZhezNJ9AS0aHO+YpnwprxyK4p0geOIrXRyAJ/tkhcO0b2FmRwrea8ko/8KDpJKaoy7IJidmObglLeeX0aWTMURiejpJDX2O4EjAJNzWrsETBnvDufqEEhUvCfZB4pgKN4G2s/8ZASxvSDN45uAya/87IYw9lp+dHPpT349iCsvXOMKEpkR8VPBBGUUlyz+v31kEbBlKiwI0Nup8e27SnJGe0y9M3f7Kahb7Kcb7dF7GwPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBZAQv64fQhA4g6Q/EFUcbKcNmSFPoGs3j3lOgLLGQQ=;
 b=ADGV3cJwhQK5r/fs1gX4RBRw4jfn7Pb9zDKZ5c2A/wp3wNkmkcvtJ8Hg8gcbwTsBjW91f1yWKRNTxEnCoZNLLHAzjAI8nWOy8fJZ1HqMkk6l6F3tEO2S7p+3PT+x7sZYkMlSn0iZc+oc7AXUaEJRAzF4ai+lKtVDuuWo2ax1IRk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by KL1PR0601MB4387.apcprd06.prod.outlook.com (2603:1096:820:7a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Wed, 9 Feb
 2022 08:38:56 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb%4]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 08:38:56 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] mmc: mtk-sd: use div64_u64() instead of do_div()
Date:   Wed,  9 Feb 2022 00:38:47 -0800
Message-Id: <1644395927-4138-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::32)
 To SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5015582c-614a-447f-1cf5-08d9eba79c20
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4387:EE_
X-Microsoft-Antispam-PRVS: <KL1PR0601MB43872092D72523F085B02C4DBD2E9@KL1PR0601MB4387.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0qWy5TNevJg1bKR47Uc8wMrk6hK7w8su6ruybikYWC+nmOj9C9V0k4FVPkUos2yuY+w0axYi6m5yYzQ4g5qWNOe/aRc3TCneuGVywEys9IKkW7rjIn4quekruAIEN8scatVMgBBZv1Du7EGvQS91FBDgVfPt+wmLMdOyA58rV+Rj+JEtSxRsbslVFxTLBkdDZDunjKcrPrEPR6/KNpUeCMYRUOvEa9KIVJix8lwLoc9kYPHz7MPmoytYmy8ZFyqxvrxYWZBynQsWHzy9QDg80W2p4rnQz0yy8fHLFX/YAvlZyfT8MXOKixhdkEMqbntYq0fhOFr3OzY44+8Xd9MglCZCaCxUh6YG8k7IFLcyPKpsXWStrfDE3M7MFG/notp395d85OkB355Sxay3hoFWD3iBUH+vlJt4MycB0wBOxx6xMjTgZCO+8hl+Je2FqJXH1DMZObNQNA+BWIV9pKSppjeMoCZ3LwErwlT9UBrjKXPqzOzQyIY1GpgJg3d4e5rnYV3YnPdcLbTk/G3KtpHM7vGtBd2TUDNBCeMprrgx/aIVKdkCP/nKcouUNLiqsrlgg3E+IDuHQiMHMoPa50N9S+pBDljt05zAPAEamO6mkcwkdnIAzHiwE+JbhLsqYaEz0B5p/f7tqS20225PytuemaNjB3rsRPHYlAkUnkPrmEeVVAp8eTkLYe8an1zCQIGhgrM4CG7PzUGcPsK+ezt2KQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(4326008)(110136005)(6486002)(66946007)(66476007)(66556008)(8676002)(86362001)(38100700002)(38350700002)(8936002)(2616005)(2906002)(107886003)(36756003)(6506007)(52116002)(5660300002)(6512007)(83380400001)(26005)(4744005)(508600001)(186003)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VLIfnNXpsYMXam2laekwIiyrPXxYCECn0miQdstKlZRiuxZxip6vW4+s5iJ6?=
 =?us-ascii?Q?QC3f2W6crXY9mwFQSA10qa9UavvolGcY9CTwf2uOIH2UVHxfrAeQp8O/cEKt?=
 =?us-ascii?Q?zG+F8Pke8jzI9pk0ao7fRVAIex7nGDTBnYzZxyaLHyAzmQh5n5e+sHEf6Fzq?=
 =?us-ascii?Q?rH1NXyK3a7fXXtZHGyl5fyxSkKaoz21pEqwozEVVS7WOtTS4gQPlIcj6RZ4Z?=
 =?us-ascii?Q?uGUAPdoLdQQJmf1hUsM+p72eiagRX07t3Iy6DGSjaU1ffhZ8gsf2MTc91S4n?=
 =?us-ascii?Q?5QViTZDadG1X02j9KMP3Uc4I/HRcfmLHQ9K24hu4CSbCjYyksTFtVo6NG4a3?=
 =?us-ascii?Q?557JtIf+EcI6h/GqBIhog9+9KmTmOJF/6sqRY+ZJO6YkVi5/XZ4KG4ZOSv0B?=
 =?us-ascii?Q?5LWV8pco+CchFh3ItWveCzY/tW0bIGKVZWLmSMiAnpWXM4uQSKYTPI+q89Sr?=
 =?us-ascii?Q?Ik05OfUoJGcX+Gh2C+CgugWYCcsvDhpMHgn9RHpWT2jH1TZB6V1rkMY8uYf2?=
 =?us-ascii?Q?WZyyakT8GrILFsaENaZjrLJT5K+gK1PAGxwoAU9IfEi1nU6LLqZpr9MAC+Zo?=
 =?us-ascii?Q?ZKMflboyp9eEkwin8tmSLzgm7StOIo3et1lj5ISuWfWMWePv1nlkn9e7RH7g?=
 =?us-ascii?Q?8VEilXZqQJ1SXMLPB/Vfi4Sr146dJUyay8HxmGOMUxd4QHvHofOD+j8VwR3e?=
 =?us-ascii?Q?3NKgqGfhx50Dny5A++vzzC9XxI96dVzA/y2+QxrGeLs7PUuOskm/8elaKGwU?=
 =?us-ascii?Q?FbyE4aDrn0AAUJe0WeqhbBeavSt39kncvMgH1Cwb+uYPa3yFI0PxCN9rj7AD?=
 =?us-ascii?Q?H/jGTBXh8Y162j7PqNjALpIfjSSEUE68yUPLx55Dx6D8rLGx+va59g1YZ6OA?=
 =?us-ascii?Q?y1eNXs1jFMbvAeRMNutNGIV6ZdZe1QndKW+sRW/Vh3hfe83T+hzc18kj2DfR?=
 =?us-ascii?Q?N8Kr9V6idT5T9NGPc4bnDG+fnhPObX9hQGnidHpkjCL1ax7LRL8w5Y3rQsIC?=
 =?us-ascii?Q?1NP1+d1x3/qM8j8u9ZRJFAnKS45eIcC2akLH5TbRPgHj23NSUbN02UnfxdEv?=
 =?us-ascii?Q?veM//BDJgZmh1UidumDjXJZ9dPJdtmNEaFih8Qbu+K2POiypfAEaCMsCfneo?=
 =?us-ascii?Q?Ns8ChYswtDHHtffGIKNXnSoqjPGQfapPbhFX8b2ckZXqfBOPasJLnDr771P5?=
 =?us-ascii?Q?1lVhAUuLd9Fx28a3F7PP9+9UbnEN5Yf/gHBBort4m8K0wEE6sCAXlEcggimK?=
 =?us-ascii?Q?AdaecCXi5KiblUWgSBzjWUrduKFxXQijMGOHwNyJ2JAsg0YAjMVH2c6L5Yuw?=
 =?us-ascii?Q?RqUG0w1kRCmQGv6D2EeW4oMtId0avcTdjPiaTA++EXs1zq0/bwL3TgBwP9mr?=
 =?us-ascii?Q?QIAJePSnxfsZ2wCvcjel41abqM9fiKR1bbRyjoEZy/J2V2jwg/71VV1l5p4/?=
 =?us-ascii?Q?m26BI/LnzCf0OR4gh0CSrmwIZCleuD7I1AT82dEcipfv6BX5JTThIHByXvt5?=
 =?us-ascii?Q?zLRYeUXFihnGwcC/35mvtKGrK4u2PeyB3KLaO96zf2cD3k2+ACcOLdCtIUS+?=
 =?us-ascii?Q?LNjXo3KN5ADtHTglQ2yf25155Pg2dS3p8GcsY3e8v81hJRQO3cGfQDJrS32e?=
 =?us-ascii?Q?IkY8/JWadoPHL44G3R3jG9k=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5015582c-614a-447f-1cf5-08d9eba79c20
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 08:38:56.3083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZR6Fnlgn/GSCORerBuinnucTqJJ0/WJN9ovP8FQ2ixwEup9darXTrWdbUGIIw5h6zkyAY5hKy3/RsHCqNoBl9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4387
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
do_div() does a 64-by-32 division, please consider using div64_u64 instead.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/mmc/host/mtk-sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 65037e1..777c9a8
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -766,7 +766,7 @@ static u64 msdc_timeout_cal(struct msdc_host *host, u64 ns, u64 clks)
 		clk_ns  = 1000000000ULL;
 		do_div(clk_ns, mmc->actual_clock);
 		timeout = ns + clk_ns - 1;
-		do_div(timeout, clk_ns);
+		div64_u64(timeout, clk_ns);
 		timeout += clks;
 		/* in 1048576 sclk cycle unit */
 		timeout = DIV_ROUND_UP(timeout, BIT(20));
-- 
2.7.4

