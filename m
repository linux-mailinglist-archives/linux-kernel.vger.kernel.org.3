Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A124F5608
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 08:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbiDFF42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 01:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiDFFqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 01:46:25 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2129.outbound.protection.outlook.com [40.107.255.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8941933DF93;
        Tue,  5 Apr 2022 22:03:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCD/RK2HTrvNG5J/fYIJdb7Xzill6jv+jibBVK98GriglHTBVvUI212tTP+5y1xuP8rkw4gtBAr2dy3oH95qtz0GgyDW8JVwmdqW3rPuRWwDkhLgUKWIlVb+5Kiu9vwR4HfF6IzDewlZpJEbP+2RXS5QcswXRasyZxoemKwxeBcdCjbkWMzbhDrF5cCVLYXiDKg6FiEOA5aEVVFtn2wORbUOaXpCReX3Biq00ypGM+Qx/FTybGcECZipAEta8QoxLVzt2LzEhS65BQGQnTqutBt3OHuvtXxr0IErX6JpTGDZZqIPIsZbLA7scHA82cNcGvHfESmjriL5fYO7aAc8GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dU7mKko5H8aGk6E8AhPmTRXLz/s5sLANcIJwi2Bc7VI=;
 b=Hx6GapS/Eu9MeX+qf4SXoNiuHiIlf9DMHU+9tFD0QyraAFwb5oRYivfFKcm/+u0ccCfRpqMWjjSlAUZbCorbWAZ77+XFLiHIbEehqw3PR/mZb1gXxk5Uhq1SmbVRuvo94IVJy9IPEzXDRHeF+S2/DONl35YtyhgRUPGTMxtq32IS+8GE3WZkBDImaf9cSPSbPTIB2hU/aZSbMNf5kUnu3ia4kl2EyY/qghelz0abi2vjceT2qWi3abNmFcag+l20YfY05RK1RMaGjihzXKnlz3jRWJ8U8v+HVZ9PALL3cU1RdI9LDfa+dQ+LjqdJ+M4knoC3d6sQmzQ13iGRj/BSRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dU7mKko5H8aGk6E8AhPmTRXLz/s5sLANcIJwi2Bc7VI=;
 b=SvecOorKAyHSqOQKf9vu9bOmdYaY7k6Nlcqd1hiVtT0fGoDUtyxeIK/d1xyzAx0Tft3SWiG1jWKXLXjCzhtlhmgEVjTY3HxhiLA7TXlkKBT/HkZ6f6e1uG0X4sOR2IJNUltlFNU0CUdOr7Xe1ZeQsVZ8fkz/2UiuryNW5a0z3nI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PS2PR06MB3493.apcprd06.prod.outlook.com (2603:1096:300:63::20)
 by SG2PR06MB2490.apcprd06.prod.outlook.com (2603:1096:4:5b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.19; Wed, 6 Apr
 2022 05:03:49 +0000
Received: from PS2PR06MB3493.apcprd06.prod.outlook.com
 ([fe80::98bc:c4d6:61e2:f84]) by PS2PR06MB3493.apcprd06.prod.outlook.com
 ([fe80::98bc:c4d6:61e2:f84%5]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 05:03:49 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-kernel@vger.kernel.org (open list:ARM/TEXAS INSTRUMENT KEYSTONE
        CLOCK FRAMEWORK),
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK)
Cc:     zhengkui_guo@outlook.com, Guo Zhengkui <guozhengkui@vivo.com>
Subject: [PATCH linux-next] clk: keystone: sci-clk: change `struct sci_clk **clk` to `struct sci_clk *clk`
Date:   Wed,  6 Apr 2022 13:02:32 +0800
Message-Id: <20220406050321.26177-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0129.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::21) To PS2PR06MB3493.apcprd06.prod.outlook.com
 (2603:1096:300:63::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36fffcb8-f05c-413d-fd86-08da178ad5dc
X-MS-TrafficTypeDiagnostic: SG2PR06MB2490:EE_
X-Microsoft-Antispam-PRVS: <SG2PR06MB2490F45276AF91403370B90CC7E79@SG2PR06MB2490.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: weN/L+qoXTqG0ivZwD3hYdpkWLv5u6Ne6j54y5HeID055vhJ/9ylJHV4zo/HuukM7Z/r2WjElMtkq3B6SNMLh6TUeUD7YumhpiZFPiLRDL2uxQsYGwNzajKOLDhjmWqdb3ezmwZ+wMIl82uw8kD5SVCWARLFqM1MHoT0/+6E/Nu3GiVY1aYVO9IxyCNOaDEE8uvosZikQq5cWuDh4Okab5BQhciel9EgOerU+Kexdfe7NDY6Z3QWBozZn/xAO9ROmF1d941KIsU1GFdQfY6tyBn9TEQ5DzlVOm/tgScAbf7yRInvV7sQ90uxSEW0DK9K8FDUZYGxHNSJOddcUL8Ffio8VAX1cWwUHXIRITaDixhOS/wPx8vbImrzmqKHTLFpa7ACFrsj4LuRYC8JFGylfnu50GY8F2nz7MaBkg9KYlEDlE576PsxHZDR+M3C2RwMS8PtnFEbnT2alVBTfG1MNf28WvGF+hfUX3QDMB/1eHcoeJ75r71K+gdjUxMFrEVVIeeyEQSkznnhkiwm4A9+uLfCRCERTb3wOZ+USEWLgKbUApJnGx5m7Odmg5ynemD96UMxp3chXazsS6ZpWO6Z8LeU55FCunh6qbAi1fS/p2YB1v8d2P7oihFBkdUDF0EnFWycy3goEPQ/KILYwQPHiGAYU8+A6TAhQW0B2raiflhMfLQ9AfpZW6Fgo9jE1NLwWyxujZzLeOgavsQ1Lj7KoCgH2j+cJMK5Vrr+LEcemT0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2PR06MB3493.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(110136005)(1076003)(2616005)(8936002)(107886003)(86362001)(316002)(52116002)(66476007)(6506007)(8676002)(83380400001)(66946007)(36756003)(508600001)(6486002)(5660300002)(4326008)(66556008)(2906002)(38350700002)(186003)(38100700002)(6666004)(26005)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9uNctrYJJFamgHnbsZyNg+fCgbrnjiZBRUNoA7APvsGRjsSQtwY8e3O5elK/?=
 =?us-ascii?Q?iOYx1kvnX0YQaLc3hkPnoiHtE71dGBUZqLFHlweyXpC84uj4d/1BhIoQgos9?=
 =?us-ascii?Q?mlic0PQcl/jeb23POfdSQSupHQZl/UX884OmEt6Tuw1LyQkBG8ZPuf7FarqL?=
 =?us-ascii?Q?Xk9SoABanHJopSNiTm/36OYbDFm43hI/cEsH5poGu0v9hkcTg5A3NPz5xGgV?=
 =?us-ascii?Q?gCDy8c7U9pt0rDBV1iCwsEMpeWzS4QD2eqQUJKKWgutdxLWxW5TTRLutEAyj?=
 =?us-ascii?Q?1T1CXe252NISRjmUpnepboj1R2BB0risblQPfd0YD5+ybBnrxU2CG/Y6EHWE?=
 =?us-ascii?Q?uvQ6hoVTcq1oKoYZ3KU4TIqRdPPzAZ3hHU+PegKTJsW2oINl3ZSdQaOHlHHs?=
 =?us-ascii?Q?8UCtTO/UAyI0K+TuTCrOtT3oeEZGXgVSaDvi8/nxWr9rUc9w27+wNfNv0cdf?=
 =?us-ascii?Q?5/km67sktbfUwdDg8UOakFy8usnLSmUiUlm0BxZl2E2POiuGLEGPs9qlgbXu?=
 =?us-ascii?Q?UYTYCUxzweBtx+elHFCjAVvp5Sum4jC++EMkxYI7BWuuJ5WZIwdI6HsIuoR1?=
 =?us-ascii?Q?Ve6csph10VkW+3UaGnhyVwVs4IrkF8sh+VyZ0BXiT4AzgBPs2g1IuJwLvOIf?=
 =?us-ascii?Q?pQa89H4qAeaoB/o3pHoQ8G1x9PLxwBvRaWl81GxssbFOuKXUBV0TIrVbAfAE?=
 =?us-ascii?Q?eZTs8/ZyL9pIIefpSyemH3O/vAuv89w7h2iSZy3NaQ3M/uXbYvfAjh1fSOZ4?=
 =?us-ascii?Q?yxP9PQyaZtLUcjfxUQVuPhL3+Jszk8fEP9pRXHKOjXGlTavKT0HkXMfn3pZK?=
 =?us-ascii?Q?hKENLLYJqDtYL/CX8tn0vjxqHp+PmVEvGjMz/r2hP/u0wy2OHrE2fBl7CsbW?=
 =?us-ascii?Q?8cwlhOfG/AMMmqRitrVS0w/bQlgEdaUEdsq9/joLNNUwmjA3xHmCnApDwe2u?=
 =?us-ascii?Q?qiID17yPBk0uNbbzlaWfI0KUYNIHpDXKScxf/dK6iNPsik46NjzzNvzdgWz/?=
 =?us-ascii?Q?36ayFnGc4FruvBtNeN9tXI6xlZcM2WqSVXleIR1lSCOYUXf4Ysng1hsLCC7C?=
 =?us-ascii?Q?9hYxFYOr7KgpnSbSYmh6kMJGEFRFeBfa7PtNxXL8t4Eyhc0hxG78ve7kibdB?=
 =?us-ascii?Q?mECynuAGJyx1IbDBuqI/5KSZ0q0wKIQcnSdi1ZDTceDihTwl0h0Hgrf92sI9?=
 =?us-ascii?Q?hO4dFuT1ITs0L5b2pI7RENQCOU07A/klB6VRaTNZT/E9N1Byp8nSl/C4859q?=
 =?us-ascii?Q?ZGTXxqD3wtBYangc7QGL7+0LXgIRkV5hHwDFt/Joqf6yt+WZj0kLk1BZzcsQ?=
 =?us-ascii?Q?A6pZgBE39w069cGMMSK0BFo2NtlnaShniQ5nrW52Awab2cYtxDpzZnCjhegQ?=
 =?us-ascii?Q?r0pt7zFV1JTvuX0i4LssNcBRARtDov+Rmco29y0fGS6Y/nJB/raRJCNvUML/?=
 =?us-ascii?Q?oGIlYLFLBYitUOXA/uZQ8hhfnelbeVnKOhN2G03Xwo9srmn2XpcRqIYuLU4r?=
 =?us-ascii?Q?XRzK4XSK0tRD/87D7ZxGgxJkHOeZMa1WNnPLX5RpIvbJcJtQ8FaJvizJsP6n?=
 =?us-ascii?Q?9rxxBp7Y5j8kVZzlOcMp5ks/s3UCpKQ9sSyE0aztRRkVDvcMAOJ5QV9qVQzR?=
 =?us-ascii?Q?4xQNfYuK/h3tldKK7mBJYkP2EBG/r43SZbLYyt4nli08KRJS7G4rFAKICnRn?=
 =?us-ascii?Q?z3xlB/ECud+6hNPclBQABQjQPlIbLsQgi9PqPnMgHuTy7TLzq8Yy/2XQo5eR?=
 =?us-ascii?Q?Y9RX9SzvIA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fffcb8-f05c-413d-fd86-08da178ad5dc
X-MS-Exchange-CrossTenant-AuthSource: PS2PR06MB3493.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 05:03:49.0270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8qcV8JSjEhPl/MLyUr9VBtKp4xbpJqHWC3q1jIJYO+Mdj3ifejuQL99udq+If2HDBc34CHyTlp0AF8FscAxmcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB2490
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`struct sci_clk **clk` is unnecessary. Change it to `struct sci_clk *clk`.

Also fix functions relating to it.

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 drivers/clk/keystone/sci-clk.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
index 7e1b136e71ae..2c3e4fcfd441 100644
--- a/drivers/clk/keystone/sci-clk.c
+++ b/drivers/clk/keystone/sci-clk.c
@@ -362,7 +362,7 @@ static int _sci_clk_build(struct sci_clk_provider *provider,
 static int _cmp_sci_clk(const void *a, const void *b)
 {
 	const struct sci_clk *ca = a;
-	const struct sci_clk *cb = *(struct sci_clk **)b;
+	const struct sci_clk *cb = b;
 
 	if (ca->dev_id == cb->dev_id && ca->clk_id == cb->clk_id)
 		return 0;
@@ -385,7 +385,7 @@ static int _cmp_sci_clk(const void *a, const void *b)
 static struct clk_hw *sci_clk_get(struct of_phandle_args *clkspec, void *data)
 {
 	struct sci_clk_provider *provider = data;
-	struct sci_clk **clk;
+	struct sci_clk *clk;
 	struct sci_clk key;
 
 	if (clkspec->args_count != 2)
@@ -400,7 +400,7 @@ static struct clk_hw *sci_clk_get(struct of_phandle_args *clkspec, void *data)
 	if (!clk)
 		return ERR_PTR(-ENODEV);
 
-	return &(*clk)->hw;
+	return &clk->hw;
 }
 
 static int ti_sci_init_clocks(struct sci_clk_provider *p)
@@ -509,7 +509,7 @@ static int _cmp_sci_clk_list(void *priv, const struct list_head *a,
 	struct sci_clk *ca = container_of(a, struct sci_clk, node);
 	struct sci_clk *cb = container_of(b, struct sci_clk, node);
 
-	return _cmp_sci_clk(ca, &cb);
+	return _cmp_sci_clk(ca, cb);
 }
 
 static int ti_sci_scan_clocks_from_dt(struct sci_clk_provider *provider)
-- 
2.20.1

