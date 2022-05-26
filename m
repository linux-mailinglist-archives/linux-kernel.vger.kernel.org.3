Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766BA534F35
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 14:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347373AbiEZMdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 08:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347332AbiEZMdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 08:33:02 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70044.outbound.protection.outlook.com [40.107.7.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B343A188;
        Thu, 26 May 2022 05:32:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRyATPuqukFC2KU4RGCGg0V8l7d4WMID6HdGMitSkqp+gk7tZvLQhTTtFU4rdFl8EY4Any+wKjre2hdcJ5WRdNiPRFSFO3J1LuA0EIgaHOyMvlcRZtwql+4vZCoTGhQfuZOEgK9EBMFOfqI8qepZT4v5Z3LsCrMmGybL+/tfGtBWJNBM6LN8sUVA2oG3kdEEid/XJIjnx8w5iPuEKy1PdqDUQzE+gm14BeHIE3SxGRw94RxRPVIt0vZEAk8vApIC9lKCv1rQuvDi+Xq5ZBpuGd/gS3TCLnbHezhip5DetNwigA4zQMF33L2YEnpIIBP3m7aczlIVSSuESpdWTZ6WQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvyBBWq/TULyYaW+qtbnBmvmh9ed2b54mEXSIqHerqY=;
 b=gHVfxPm0uyevMJL7KEdEs3U6EgXTYzfxoBLo+iPwyZFQwhVcqMHKhucYUA9iafTb8L0+XeV3dcBHC8Hy9Hks1ms26wVX3LbqM3yKT91gBnXXUP5UDB1ug/MkiTfgOcwVsd+mOuXRjXjjwO8IPwq96bLA1CKFnNkiW/vaDR7lIYL48olNJX4rhkjmjxl+rT2ol1oZfEV6uRBBzWOXca0QDj2MRqUoX2yZVpQ7oJQwRMBgL/EJ3ZW/2Jk09nMOKb252oQDXZThEIqD44ChEYwOH8scbxQk58ZFUnOnbUaqY9WEHyQL5xQG/pXFexgb2Or6b9U8y1d0ARTs/TDO4J90Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvyBBWq/TULyYaW+qtbnBmvmh9ed2b54mEXSIqHerqY=;
 b=inB291m3+MkgOjcy11nHMpmKd7+UmBpNkXSkJZ0qPDFyIr3ynbmJfBGja6E5QIdhteUJgLQQPSoNZC9GZ3y/QWosOR2ymmcguVDn9uMn1BgVgu+JlREDNrmNJ7e2NRVQJoB36KHImX41Xy35Jq0N2XXPBGkC7VstaYKoczCU1Nc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6515.eurprd04.prod.outlook.com (2603:10a6:208:16f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 12:32:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 12:32:46 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 3/7] clk: export of_clk_bulk_get_all
Date:   Thu, 26 May 2022 20:34:07 +0800
Message-Id: <20220526123411.270083-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220526123411.270083-1-peng.fan@oss.nxp.com>
References: <20220526123411.270083-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:4:186::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6d1715f-d78f-4443-465a-08da3f13d64c
X-MS-TrafficTypeDiagnostic: AM0PR04MB6515:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB6515BB06E051DA24C707B194C9D99@AM0PR04MB6515.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nChqFGHE+FNvUN2bOzNclsG1xOw/7mjMtQynLMk3q/nMKFoZzpfSO+s1CQZ3UGXeTqn7fJoScOSe5d5YBtv/aU9g2Y6RBZbFynwTX33LjE7I1qxI69T7Nk/d4RnXPwqxtAVtR9AGoknmWqNixdbLk+Nzv5/CYzgHpb8zZVfeP0vHYTB5zKQvcrh9tQbduNna2yzz2dTnVdfOQGvKx4S+RdsSESmIG/HUBE786VE3ZZzUfNIl/cHlIBrQc7CvnCxVce482RS8K+zgaSL50HDC12rOqZGJF4qDJjRtwEy5HW6eQEnEr8d6vswXt1ULV/oSj3dX6PYulSFlZbrj2j9aYa8SzJoiFhsSyeimhCXiuCbcUZWy3AUiTwGZjA2vj5XZ8n5ksoFKexLdFFRlvwCfS1cnuNUW5jnTL1pQP/P/uhqE/Vn6Yq8Iv9sLDYum8yRWU8oxkLaVCxdxlrLe6yZXekNq/QsVTXgVpOTDPKXYe2KdnPoTXF7igZn5hn5Z1wTSBeu2IFFPQvTdHKeqvV61LaJj45WHX5oUm4z4KWnDuCPeM7s4CXBbDKz43aMT9HKuyKhZ2uTsm8AxcubYAw82WxVdkdcLPDzs+fbQxqPtAplujO9nLGMo58RNZ4nvNVu5m2NXsZc6NsAmbVhgEZWgUE5KROlGCLTk4/RhNRDa95CFoaAahGZylNKUo8Xr+JezcKakOnjtPtOQVlcVD4vbmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(52116002)(2616005)(6512007)(86362001)(26005)(38100700002)(38350700002)(6506007)(66946007)(66476007)(66556008)(4326008)(8676002)(6666004)(5660300002)(8936002)(7416002)(508600001)(2906002)(83380400001)(186003)(1076003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ln7ZtKYmQdbwApD6wM/zErJfftA7RiRTuK4rsRpF6Yl2HLDLwSiBm3qV+mv9?=
 =?us-ascii?Q?+bvWszoSR3pjCUWG9RBI7sA6mqXnVGZ6Vv+hmKA4fXwPOnlX66sMdwbghiii?=
 =?us-ascii?Q?6rynoeTecVq+FVqI6jl7iTmz2X7c9VHgbdYeO4pSNmBHehgWmtif13MPjwy9?=
 =?us-ascii?Q?DO2c1Dn/fgNx7ie4M4hhAVJ/aE2iGRtrYb98zicfcEITcS1T7uxJjPxXjEq+?=
 =?us-ascii?Q?a3HWiaYQTF0hxQGWWTb1zuK6ASrMCT0sslmS1qFWuQnevbNSyZjmyQJwFJ0O?=
 =?us-ascii?Q?LxBfuepPHa+hdzn2RAV+c9WHlPeG0E+n3sMJRnBkJ4PuGhICrzugf3LO1KkX?=
 =?us-ascii?Q?5c0eReJU0DcrxlIOYD1MkiXGgk01W6ULUXeBDB8x/eFFpC3/RLN+68xe+ATJ?=
 =?us-ascii?Q?wB0iWd33TzbUvatKZHcnSkDqjoUgWevQZbpUQtozJzZcBj1w7odwbHoQFPPP?=
 =?us-ascii?Q?DOQvJe0k8+lDHbq4ms2q7/xISZsiL3g9RC8sKV9xzTbhv+z4+XNePIicAdnR?=
 =?us-ascii?Q?fTUHWYOxxeJo28MiCRhMsRMGl5BHLRsTfYni+BVT5Fr+IiYTUcWu/LNvcjCP?=
 =?us-ascii?Q?9ZriYt9MbbAPUoUPx4GNmbWURX0epYCAPFPNr1pkIhfT+XiBNPV7hAQziX7/?=
 =?us-ascii?Q?1aPoLu4rV7eZ+S7j5CRweukDIJavrbXO1V0mVUg3E6P3BC0NjBM2SX+OkO+Q?=
 =?us-ascii?Q?Zt0i2lAnb4h8pDvyqZ5aySb8cQbgloddWEmHlPy+wYw0vG7OijKQ1EiZgPw7?=
 =?us-ascii?Q?L7r/5JEq0JirAWhTcvBuVX/6gFHgHBEdNA9y/jP3jvMFDPDdYt+kevn7UtFx?=
 =?us-ascii?Q?M0+D2GycNNS63vRojWE9yg/wZacFUJFfSEd9N9njIJoY10nWlMD5QFJ7MsJS?=
 =?us-ascii?Q?z3OvURbkzpiW5W+VFAEokqYW9cb1NaBkJ+GD1SG2oGsXAtKm2AEO1hnGdoq+?=
 =?us-ascii?Q?WNEqdhfmPMnomE4EZSbDOlwRcUWQJD9WKrCkd1pmB85o0pkRt0w3n6txEYwN?=
 =?us-ascii?Q?DbWzISSYEQ4AtKZgAsoJVq5yVaAEWjP5rsd3WMNNVaXWWro5wBiEtcVdVyBP?=
 =?us-ascii?Q?BwhhVrJJSINVO4sTStx8VBvBdK7r+huMMvci3e+4DzSou5oFiiiVBAUtKwjJ?=
 =?us-ascii?Q?Ej4gcobZ41ceBy5r5XK3bpN4HW2FbXI0VgBI+bxo2amhGG77SjOtUrFKPGOW?=
 =?us-ascii?Q?oSH4PGq6ABhNkGhCxhd+HPXJvDJmJVxy49Fw/cckY15H5UYN1xeKMOs1c9pE?=
 =?us-ascii?Q?DGUxYE47S2Im30GoVqyC9D0nea0BYKfwQsT1xRwcuKOTUM+B4n5+o4mEqbAu?=
 =?us-ascii?Q?vv/QkLC5myugv4B1LhY+WoRD+n0VsMu1i8yDb7C1Khgl0TdlpWDimOrK2A46?=
 =?us-ascii?Q?QkUMh4+z3l0uBsM0c3FkIkjMDjXbLvioX7oj7BeYuEBUyFqG3HtDMHWnNDJj?=
 =?us-ascii?Q?HWc43hKemqvftPc2lNBSTbYDdrLtJK5Bb4P8nC7f+8yInjy9Y5Mtz0Enmhuq?=
 =?us-ascii?Q?mbpk2mWES4Sycfq7yXmTA/YEtBGR1BqGtS0YOiA0ERFgAFRoESojmppaZxVK?=
 =?us-ascii?Q?4ac/ltY2S5FewXsT0vRQVkPaPMyfmwVlitQzRh77L9sLGiwd9y2WQWFmLN/U?=
 =?us-ascii?Q?H9JhAODf9ITO3wbpyOfd6daQQA9rqVqQWh30WZNOqdJAPHX9771WMo8Ld6RF?=
 =?us-ascii?Q?byfgoqCnAALhwyB9mnMfcxX3N93QYAfid5FGSt/FWmuoJO7SB4SteUpovDRS?=
 =?us-ascii?Q?4iDSwNwRQw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d1715f-d78f-4443-465a-08da3f13d64c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 12:32:46.0941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BdNIM044JzxJQYmJXQlnx2Cjdbfjyv5PUkoWeTFK+I2uYOmPd4QvnquIbZh3YwM2O4sx2s8ZduenzIZRrwfyOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6515
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Export of_clk_bulk_get_all, so drivers could use this API.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk-bulk.c | 3 ++-
 include/linux/clk.h    | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-bulk.c b/drivers/clk/clk-bulk.c
index e9e16425c739..470155856b02 100644
--- a/drivers/clk/clk-bulk.c
+++ b/drivers/clk/clk-bulk.c
@@ -43,7 +43,7 @@ static int __must_check of_clk_bulk_get(struct device_node *np, int num_clks,
 	return ret;
 }
 
-static int __must_check of_clk_bulk_get_all(struct device_node *np,
+int __must_check of_clk_bulk_get_all(struct device_node *np,
 					    struct clk_bulk_data **clks)
 {
 	struct clk_bulk_data *clk_bulk;
@@ -68,6 +68,7 @@ static int __must_check of_clk_bulk_get_all(struct device_node *np,
 
 	return num_clks;
 }
+EXPORT_SYMBOL_GPL(of_clk_bulk_get_all);
 
 void clk_bulk_put(int num_clks, struct clk_bulk_data *clks)
 {
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 39faa54efe88..ca74f4e83d25 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -372,6 +372,8 @@ int __must_check clk_bulk_get(struct device *dev, int num_clks,
 int __must_check clk_bulk_get_all(struct device *dev,
 				  struct clk_bulk_data **clks);
 
+int __must_check of_clk_bulk_get_all(struct device_node *np,
+				     struct clk_bulk_data **clks);
 /**
  * clk_bulk_get_optional - lookup and obtain a number of references to clock producer
  * @dev: device for clock "consumer"
-- 
2.25.1

