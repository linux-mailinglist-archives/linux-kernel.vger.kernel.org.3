Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640784E8F31
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 09:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238897AbiC1Hlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 03:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238899AbiC1Hld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 03:41:33 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2126.outbound.protection.outlook.com [40.107.117.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0852452E47;
        Mon, 28 Mar 2022 00:39:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d48UX0rC3bbK3ym8aK0WVuim9KH19JsQhfXrSyYq/2e4FEyO2a4KfaoozPkqvA7S5czZdb+CqyJdM1CSkejIBgeI9higvwb8CAT9k5ZgY7XdJH2RKWOSk7PGnz84Nx7Li3VoozbY2qJZc1MHKr+p4VbDsKSzmtX22m6FnnUz2JhCPuyGMFfsjfAgns1TyLWnCvcBmbJ8cnhMNVQ/SbDM5zQkz+6y8OvP+9pNckHu6iVfx+UyNQIZWN/v2mEV/hnEDP2a+zFI6YZnNPKMOqlNYR9JjMFENk9sSs7j4wcXHb2Yod96k9DSYZLIa2ME6RxTyPe00thl7k8p5baeGEnYvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yF3PIG3tKyoANPJokcNO+T+/IpYLNXtTX2IzlOtc1RE=;
 b=eu526xX/SbXZcKd5eyYZZXjlmMcsbcuJYJ2Jqpc8R8g0hxjZC5dKlNDrD4tksCzHn/6uXmiQxqb4czi84ag9A6GpwTfalfyZCpXRU3SBQtGIfIVIQkjyQZmHk4A2GxEXSs8ULoc1PBDK6nSso/Elsx8uicTOQtv5gXui+wfmBUE0KY8gv8mN0QemvrN175XmbsBO/LDxpW3oNFKjyjQDkJbKb+rdfJs7vVmcx4efp0FofWmih3cTJjfv9GYb46bd8jqZhDqmg12uOqfy7W9Xo0kzQGwF2+7ZcvQ+lVGH5rx8g5ISB88GuLhejPIDcVRbxbIsd8NWa+CrFzdJ+pXnlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yF3PIG3tKyoANPJokcNO+T+/IpYLNXtTX2IzlOtc1RE=;
 b=RJmL3DTlNZHatasjveoypWioEzTSCwDH3E0FRKATg6AbrhDh45JeGSYTmVFO8qOtMlD8IQOm1qhXF/NfgO9+kDyckTLfXKFBxedHZ91qXDquc3ryB2zIhOLI2LRJ2wY+J+Srg9YGqcLV8DElp/40cYsiDCj9C0LmLg+bOJLUCaY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 SI2PR06MB4427.apcprd06.prod.outlook.com (2603:1096:4:15d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.18; Mon, 28 Mar 2022 07:39:44 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732%4]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 07:39:44 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] clk: sunxi-ng: fix not NULL terminated coccicheck error
Date:   Mon, 28 Mar 2022 15:39:31 +0800
Message-Id: <20220328073931.36544-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0018.apcprd03.prod.outlook.com
 (2603:1096:202::28) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d9569b2-ccec-4c98-5013-08da108e1fe9
X-MS-TrafficTypeDiagnostic: SI2PR06MB4427:EE_
X-Microsoft-Antispam-PRVS: <SI2PR06MB44275E168101441F5BB57C74AB1D9@SI2PR06MB4427.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PCm2Pg9iwGMIoa7p8BPLAJbiV+j3gG59bY9QI8QJ5Nq/g5uwo47Z6PKRcbkh8FkEFoGitvBLE1imC3c/XMHNp4FVfnIHahPCwOR3qieezG1Xo9UZfGxKEhU6ZUQKIms49r33cvfeeQ5mHLwy3g3/zsrI0MHEXCENXe3363idC9wXIg4ycA0GL2BofbG6IlT5woykdhjAML7zq+cg9CGYrGrOXy0lrn56PRTIuiXDBMQCnBRaSg/qx+4YSZeMTkK2MUen6AkwYCxqU1KfYf+YcyfDzExkpMDuLY56aqG+0kMDd5EXOTSBKKPdkxF6VLRTpyIfh/nw56K1MgTqqIogyJ7Tq4TgvIB5ijVjxNLXL5k/eo5sS/oDS4RaINUhwP+VoTqgiUaJNF0LiCaIzb1e7Einl4TDLn7JL7bYR9SpI+jWuObwxIVYHzbPGH0L+JzFHdPlY8Vsu4Z9Wo16lVi32+99lN+9Wlya9nfkuNbj9aMJ73y7Btqb6X7udxppTNXOIsBrf4hHPxnxl23Y/T09pxmwWGBY0c/98c24ywstLjyeHIIdSzFsg4/lf2w7la70/R1h5Tyzgx5MprFX384+yGNF/GNm6nUrFDWGyxR0549wW+yprv1ApeD/RUVf+S3/RyyOK53D7S6mDtsd+wzEVr1NLmFzHwlHN4Q/xV0nmk9tnARHqCDsFlbOcWDKlCCeMreqeMvw6j+FvuI7JaUDdyEXgXL03GM3TDjJFyJHszY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(38350700002)(38100700002)(86362001)(6512007)(52116002)(508600001)(36756003)(2906002)(107886003)(316002)(6486002)(921005)(8676002)(1076003)(110136005)(186003)(4744005)(83380400001)(66946007)(7416002)(4326008)(26005)(6666004)(2616005)(66476007)(66556008)(6506007)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dtZHwFGUIH/X8EG+HZsJSqXmF7WOR2KJUgqkSL3NjlSia/U5klQQWiLNH2wa?=
 =?us-ascii?Q?w8SyNq29sM92/ftCHQIutWQLxoL/J/RMP9CIx69UYooMWCnh/974IIXNduzt?=
 =?us-ascii?Q?0ivN7QsrR8/2rsbXDigWJxh3buN/SVsA4OeSwNrFJrOT/Z3iDFf3MzF5alO5?=
 =?us-ascii?Q?aaz90u35gLc9o+00vRVYIBEM05qaCb6lZYcK+Tlt+Yzz0AxcNwnnV/O49M7s?=
 =?us-ascii?Q?h4XSc6qE/8X1zI7QMfCRVNe46MISdh2Fka5pR9HzmmwPPWaOBEg1zigGNhBz?=
 =?us-ascii?Q?X8+nq/wwH2pAY/0fJaUMSu6PkfAKmkjXK0xWVr6D+xzIAZMPlQgpdmePdwzh?=
 =?us-ascii?Q?tG8Nm5NhBjxjz5kZcM0f0OJXPC/Z8FAyQW3w0nFnNwUh1+vUUEsMZu+Wp08B?=
 =?us-ascii?Q?Wo1v+y+idWW+VXYJhw9WHEg2FwxlFYY2dXzBmLfsKtEYNTUuVzfaYBo1bh9G?=
 =?us-ascii?Q?77HVANFv4wEhTGU+L2LEiT1yTSEPfSEnzT/iiSujTE+3Mb2xq06ZiLzIs7gX?=
 =?us-ascii?Q?2qDp0sBC4iiLFLFJSYLfcIjAMUmxJbskzAJleYMsmSyNmpb7oNt+FNMoofoE?=
 =?us-ascii?Q?oj/SKA+xL6O6bMHy2K8NfZf3kd3aChe3QuZ8kxboATQVA36V1OzvQIooysOq?=
 =?us-ascii?Q?3M/wyg1XgKO40fc5XaqWW/jFU+1adC879rp6+Be5Hs06aKVk80OM3i5/PksW?=
 =?us-ascii?Q?0hDHmpM2xtYoiyOFYtDlwvO+l6gz2spziF/mLvXP4jk8j7AJKJODUfTglRiz?=
 =?us-ascii?Q?jf/elbiLtqninacZA0/x7OsMAA66vjPN3PhDHDBU2vwsVdbuBgahbSN4pyQc?=
 =?us-ascii?Q?KR0/v3dHkhik9eg8S8SZGZuqfnxQpapXP5xX1cX+dmeWjK1/Hh5jK/9b2Lxe?=
 =?us-ascii?Q?7/gdKNas/glEc3SvNvscg+iV/1OXipU6pmDDi8lCV+pj7qk1gotjdRuwbtur?=
 =?us-ascii?Q?b76LK7nGGF6mHKEkF9KLMOyAfm/Q/wmk/QSsyPkpK8sun2JmsI86mtmLHA4h?=
 =?us-ascii?Q?1K1dGsQjYHwNrf3cQ4a14XVW1zR4t76h5nOFmpzHKW6/7qCKgPEuwSKrag4D?=
 =?us-ascii?Q?ocz4cQMfW19sFRFKftvzlx6rFg3UYHEui3zc8eYGG2Bn08EHNOoKcmMHZKnJ?=
 =?us-ascii?Q?pCJk6JPEddLGmXkmmn3DB5jn+13DaIjzxdOjZZSxVf+0n+lFZ0sNWvGQVdvd?=
 =?us-ascii?Q?KJxwYf5vTVjZUkvPYzHRqvELOACfGjnrkwuaMMFm/xG9IsQ73FbRtHeA2rRY?=
 =?us-ascii?Q?2uZqs7rRRB5BgPZZYqOdy9z9AmoUVpS5xvwJWdohGKtjKIVprcDJpgAvzPPe?=
 =?us-ascii?Q?oc6It+OXEjvECy13/9xn2cbv+tlRvJ2jPpyUyaoFnYNgM1ueHY8YDmm1XDz+?=
 =?us-ascii?Q?ljOxkaUkUtfxOeitXkkCxSH+SvE4onPQ123uKkLEYtkW7tVx+sjgmi1jWwdX?=
 =?us-ascii?Q?lShlbUuxNkm+8PuxLFw4C6D+0ZsFBBnpe05hhrUTs035Cn/34B0MKeOREPdj?=
 =?us-ascii?Q?KBPN/B8hXdBd6xG4MWYctVO7+ccYGqf4pRSmxey/ai9YTO0ZG01BNGn4dZcZ?=
 =?us-ascii?Q?k6flj9eI3PThizSNhvF0UHi/Ed4flfWIAF5Nu8y9RGPsJ/HU/ntQ7Jq4M94b?=
 =?us-ascii?Q?u7+evZzl39IfP31aFGP+ZrlE4oEoegaDb0FwArB5sP2jSji7xYMoyKf7iH19?=
 =?us-ascii?Q?MYP1+tsrdIUypz9U549enyW7QbNPvj3nOBpE7B+bXRJAZyeXqVe0ABH9TrIp?=
 =?us-ascii?Q?csWeLQTpUA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d9569b2-ccec-4c98-5013-08da108e1fe9
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 07:39:43.7505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fhdCGlQtUlGjjJbMfMo21RzRoW8SmyXwpd48/U4AxKBTCGRsM6E15phQXvGZ2b5InvwG8pNa5r15/+ZgoxHdJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4427
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck error:
./drivers/clk/sunxi-ng/ccu-sun6i-rtc.c:348:1-2: sun6i_rtc_ccu_match is
not NULL terminated at line 348

Fixes: d91612d7f01a ("clk: sunxi-ng: Add support for the sun6i RTC clocks")
Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/clk/sunxi-ng/ccu-sun6i-rtc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
index 8a10bade7e0d..ffb72d9a9c36 100644
--- a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
@@ -346,6 +346,7 @@ static const struct of_device_id sun6i_rtc_ccu_match[] = {
 		.compatible	= "allwinner,sun50i-r329-rtc",
 		.data		= &sun50i_r329_rtc_ccu_data,
 	},
+	{},
 };
 
 int sun6i_rtc_ccu_probe(struct device *dev, void __iomem *reg)
-- 
2.35.1

