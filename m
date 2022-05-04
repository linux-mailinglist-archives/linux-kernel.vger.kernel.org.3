Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AEE51A225
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 16:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351294AbiEDO2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 10:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351282AbiEDO2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 10:28:12 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2124.outbound.protection.outlook.com [40.107.215.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695382CE39;
        Wed,  4 May 2022 07:24:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKGgqyx5zu0NKsu9DzGBG6DIppvmvumT/UAm2EtCS/KSCpUafu4s/fhNcdFnyNUtc+yttV5Jmmo3V58zWfQ3q0V2qsCbq3uDDQ6NCdvMemHzuchfDkDpi5lvkCUtuj6cry7kuyJUv3uyB5B044WktoBVblZ4qL7Km38OxLhhb2hYIOPfzc3m5ND+oyFEwLVKLV0XLeq3e7iIuDXRnLQUqiBZnPe7gQV0MrTJJ7usmAg6/XyF8y5z8UKckjGcaZbD+MoSfpI1BzYohwbP9eBBQbXhFrb+pVWluAZ05I4IFQFcv1wt91yLylpcYeOaHDksYFcNlb098sVXIZjmUYFMFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSp8zA2yUNw26mRlupezjE0uvbku/BxOwg03kSvjh6Q=;
 b=XDAoY/EvQ96gRsLvchI3OEOcO/IZ/sjAbsVZotAf1VkHv7YJ+RqkK056t755ONm7EkmEf16Rsu7oYBJpkKAZXaEMhI9i8MPMTp9Yr/MVPUfJraD63bIfho3GYoCmXlytmU9sF+YAfF5w3X9M6R/c5y3a7F98PRvKZolaPXXyx6vi4khF2SVT6I3tSJoCtuUwLbgbiA8zHL64RUusM+WbA+4t0tTCm/CK3CFvq1lmAQMSFLofSF0ShjoL4zPIZq0Iz00PnIbelfpGYXZJLF1Qr6szpjOLuEZH+0R0JwtHjZ0zJxeSQKmLWH1WpbYL2rpUonP+CxCxgDmgZDncOblvpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSp8zA2yUNw26mRlupezjE0uvbku/BxOwg03kSvjh6Q=;
 b=o1AOMt0HQcZ37jFUZStUlDJHPRN7vbni3j5jvL3L7qEtLHWzCxHiys+Dy/8xVO4AlQMjhMvzDoaHyP18SIKOGPSYSO6uF4wsKnyGaosLRGAsvVSLGziDffygP5HWSIXQA0sSLcK/z8FODJR5yRlTIsuh2iun1J0Oa+sFk/H5VSA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by TY2PR06MB2543.apcprd06.prod.outlook.com (2603:1096:404:51::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Wed, 4 May
 2022 14:24:32 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08%7]) with mapi id 15.20.5206.014; Wed, 4 May 2022
 14:24:32 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     zhengkui_guo@outlook.com, Guo Zhengkui <guozhengkui@vivo.com>
Subject: [PATCH] clk: renesas: rzg2l: remove repeated data
Date:   Wed,  4 May 2022 22:23:33 +0800
Message-Id: <20220504142333.8844-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0100.apcprd03.prod.outlook.com
 (2603:1096:203:b0::16) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ecc0752-49fe-4fae-fac7-08da2dd9cddd
X-MS-TrafficTypeDiagnostic: TY2PR06MB2543:EE_
X-Microsoft-Antispam-PRVS: <TY2PR06MB25431158C2A5916ECE74CEF2C7C39@TY2PR06MB2543.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kHJ9/uZKpopP7MYgNVWNdzCf5cEsN9rKb9mqcVtC7izUb+d/WXy2/jZY0dM1pNLtukD2HybF+szYZpwSmxwAnjiXmbdhv5Zu6ezlURXXBvoOvHgiKVwI3jhoh50YY/Wwr3mjutK0x7zige3kkGLNt8LAiR0JZ9u8zlKq/xzme7gf7Qbt63EIcGyYOylpF2BaCWfCdh+DXIB6ta1pEScBAnCbFb4rZ5eF4w8gGKBShfROIzGb3G4sAiJgrQcYrvsdwDNS579wdSYdMo5t5O0xdRB1YPUTQAav+GPGbudnrtPKKpNcwnUtm6nnvPyBGF9sKRiizGtX9/zk6MmatNiyEvz+PSEwWu5HcGx6alD7uIaeyx5JStbFUkVkovCLzMQLVFO9oBm643R5alxnRpSot5U4fSuxsfl5prxuJTb5xbj4nX7XYeZCdrcEYIgbpaArEIvNA/9tTRinw4LRxmO41E6bwrX+1/DflOEVML9cGrdUbWHePR25saHmu0yH6Qr7lGXGfzU13Qd9g4SQOskE1g2OKeciTv6YqDtCY6juP1+eBKkbEG3tDkI6uN750rbGGXB9vg9MICA+97DhHOtrwIIuE46kPNt/WMHov02awbfkCGh8lTDs0MtZWJDSawQ0f7pKR6j3tubR3OuNGvk5Rlc+4GRxiNAbiw8qttjCnNCuSiH62i4/rFW/OwGJAd6Lq58UmyPEEfAt9vDcDc80zg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(1076003)(6486002)(110136005)(2906002)(8936002)(5660300002)(36756003)(83380400001)(4744005)(66946007)(8676002)(4326008)(107886003)(86362001)(66476007)(316002)(66556008)(6512007)(26005)(38350700002)(6506007)(38100700002)(52116002)(508600001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cICQU3VcPZjUYIZ3BdfLTmPJqTXULJjkC7a5Zi/EcfmJWHG7pL7qNhAAtm1Q?=
 =?us-ascii?Q?lXK9zvxB/H7wN3hVwudRPKvca8hnAFHGg6ubjv3vqrSSRUjWujaPpUnzmH4D?=
 =?us-ascii?Q?4qG8qiwO7MLRlXPDEllNbtqwBsg9WJ+qTD66yw0rJMP4J08IF8k7zvICUHUL?=
 =?us-ascii?Q?J0KhkK2gXH5exNNWA/tq49ejtEDV6md9eWUOKEgDoQtPB2U3AP8JXYp++izL?=
 =?us-ascii?Q?TpZTvtCkkNvwh44Ybhyh7VCCqEWi4L9vBgphwlmbSxPQ3HLjvNOuDyOTr/Fw?=
 =?us-ascii?Q?SfH0ZIXYVKjMEXKldEpg6nhPMoDtgJSkLUVt3ukuNTJCiiuyKUdDnogWhyz0?=
 =?us-ascii?Q?OnINszgV0SjkwLDjZAs+OBtFKY5f+GZ/mPy8NuLHL5Qyj55x3JJSMYGPQuwa?=
 =?us-ascii?Q?n+qbeUUHfV8mlctZsrxsgwACq2aAo1uqQA7bamkHttj7Z7dAI4+WO2qyW9cG?=
 =?us-ascii?Q?ATi+IF/chnvQaaRaxRI6Tl+kExeurvmE+bnUaRiG/IL9m4jVz3BS9sfTg2Sr?=
 =?us-ascii?Q?2U/6LSI9OZ4vE7kcTrGb+doTVplpkGlJQ6MUBCCn0haWDZNHVJixTKoilXyy?=
 =?us-ascii?Q?/GyA6pEvxfYt6WJ/zJ4LqB0WN4lhhZ0p8NNIkq3z791c3Dq4UGun1dISc7l3?=
 =?us-ascii?Q?D202xWHuJlFC3e6YPWrtAmmPBTupS0p5eqkJuw6pKPbabfRc7dwFDdJyhJDR?=
 =?us-ascii?Q?B6W4WW5cwprQsz0eg0bOFtF4aaXwOqiOCCbickpAxqF1oeGgMkkAGlJhyeJW?=
 =?us-ascii?Q?dtlzXy3X0GWUXlC845xsuRqRZMMLsthRqSy+GNM90RP9Gr4EhiS4WARlR4dB?=
 =?us-ascii?Q?aOBGd9K2AwkSll1YENqAct4uI0PtGmJcspZdrgGJC4rMdpVWRbQ0sPB0bbJ6?=
 =?us-ascii?Q?AqRqjo06y7dvzMF/ldfMKzIENIgIcUIpaxmttwjCFqEkruXHLLh7RyxXxC6/?=
 =?us-ascii?Q?nS5YUdQBRB7kWWMppYAmKLtZKuTSGQIPvcVL9cURpIGDsul88Ug7PLtxTUHl?=
 =?us-ascii?Q?J3WBBcwqaDPVZsy02fL0tOo7ZHKCrymaoyAzSzdQODBSZkQhH6mPPUQiYHNA?=
 =?us-ascii?Q?rEJK4KKa9QoV48wRAcTaaagYB0xcu9eh1At8Fey3Hg+jH4ICttVrGt06wvEn?=
 =?us-ascii?Q?yaQQoU2e+nNcdOlKxZ/B28/7+DprIuhyKbKEQ9GvH/U1Yi0TXFRzSy4RBKiz?=
 =?us-ascii?Q?PPT7L8HR97D1+6Ozvg/UIIGiH8vjHlfQFpiTMVChXxxZifHfc3QhK369Thcv?=
 =?us-ascii?Q?mrDZoEENtbMK6xYdBBVqSLh/ULRHTCl5T2BjOJgraIvo2pY7gKV3nvqA2E9E?=
 =?us-ascii?Q?/7cvRNmArWOdLOXNBd+AgElgbxvqVWeqeHNqLJ03JF4Sv79uQrPynvny3kCt?=
 =?us-ascii?Q?mDhqJwysGlwDBWPgJ0Rc9JgbAeSRoGLlGhP+Gftp4jGmDgmxZFybUjNbPggd?=
 =?us-ascii?Q?tbYRHJbcZW2TXdocrf8pzEhUczoLIESOwjbRlCEGk+X+/hFPAGimddf2ueG4?=
 =?us-ascii?Q?KGNQ6ouKS0T40JfLka/1y7fCENSM6UVfinPgcy3jWKbyzTXFetNivm7/GYaG?=
 =?us-ascii?Q?t+iF5gwS4oqwjaNLzA3BR4+5JL4Y8nndwXIe1czGdBCKG1Bo5HzR4+rRQnwC?=
 =?us-ascii?Q?PBKQFbnxjPfYKX2K39QWzlkKhFCSjr5AFdtoTRTRUT91kZtt1M/PrNbxRqFM?=
 =?us-ascii?Q?CUz6d+F78+58BU5jw2y4fQrYGn18o81QLDVbnY6H/xG+uzzcykM/D4UtWqwC?=
 =?us-ascii?Q?5+NV0zUgyQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ecc0752-49fe-4fae-fac7-08da2dd9cddd
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 14:24:31.9657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9BkRevZ/tndf5NW7jcAyuCqGFs2YrKqoHCtj5aCVDK8YTh2mXpXImn4IuHWxjbuEr085V/vFSR9vxSHGEhvavQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR06MB2543
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a repeated CPG_SIPLL5_CLK1_REFDIV_WEN.

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 15412cc58337..24d752ca1906 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -601,9 +601,8 @@ static int rzg2l_cpg_sipll5_set_rate(struct clk_hw *hw,
 
 	/* Output clock setting 1 */
 	writel(CPG_SIPLL5_CLK1_POSTDIV1_WEN | CPG_SIPLL5_CLK1_REFDIV_WEN |
-	       CPG_SIPLL5_CLK1_REFDIV_WEN  | (params.pl5_postdiv1 << 0) |
-	       (params.pl5_postdiv2 << 4) | (params.pl5_refdiv << 8),
-	       priv->base + CPG_SIPLL5_CLK1);
+	       (params.pl5_postdiv1 << 0) | (params.pl5_postdiv2 << 4) |
+	       (params.pl5_refdiv << 8), priv->base + CPG_SIPLL5_CLK1);
 
 	/* Output clock setting, SSCG modulation value setting 3 */
 	writel((params.pl5_fracin << 8), priv->base + CPG_SIPLL5_CLK3);
-- 
2.20.1

