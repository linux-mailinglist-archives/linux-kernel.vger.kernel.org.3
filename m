Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BE651F62D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbiEIHfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236715AbiEIHcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 03:32:53 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50086.outbound.protection.outlook.com [40.107.5.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B0C17996C;
        Mon,  9 May 2022 00:28:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHNkRaIco5YjAHLrHLrWJfezoANr4BCkhKmUNs1LH5QPbBOtzaZ0yukul24xVALPIdi5JYKFu1NZLgzacYjhZA4T/W3SFq7PhQegN9IZwKQETHh4yYog8mNUj3tlX8zDRvn5KqI4iecvc4sZ05T2QwFt3s6twldnsUcWxyuowul3oA+XRZ5zABTwHj+7J3ag/Ue0shUorSA7vv2f+npUstTXp8TA7By05wUpPT3Hd030iEb3pOOdQ+ocgoR+7qAXmgOqRhIL0Lqq0lQ8HNXEQr+Bx9Asb3L2BVvtPf4X7TwOZNIJbYVraFQicVAGcUi2nF54qS8Fkiw6wm+TvBf9dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1Si204KzoJDuCT+uL9JBJty1E9/kMqwvau08Xwe+0s=;
 b=lxTtSe2TFX6oWRUjQZJKBSQs+9WKQWqN68w/PwB21uV2TYi9WDOq/Rq8rCPFgZ/zpv230MitQ5vSs8IKPXab+xGwbsXsLkm00iNT9aljTHnCNJbxxQQvcHlA7RL46YkODOPnBBumXcoNDpMBDCb/zaCEvFrQkTeuRoGmIA7Alk1eX94qoGLST4pdw3Fz5GMY6QDYsXR6bFrDKqPBCcQiW93sRG+QoiyPStsVxC0uqnB3ETYwTRcNIV7OkhnlXblWqoegb2Hi/epLrSmz/X82+KwLTQVKmDRmEyJ3jd0+LiNoV+TOvPMePcZSrk7RRVcSlzfq9Yjw1NvSzkSfZlwSKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1Si204KzoJDuCT+uL9JBJty1E9/kMqwvau08Xwe+0s=;
 b=Sze2khkj/Aup/dMgMIxe2PtCHFwqW2kEaqNctyE+GH2CFUJCrO4shy/feu/YZDWlo2RYUaB5LXSd8pUKnNCGtqXc9ILWKN+1zv8i+X1O8LnjPXxhHib/SJm+SHUdxisDwYA6w56JfaCYw6/HGBs53h2/WKb74x9ukzEsVZTqmD8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR0402MB3330.eurprd04.prod.outlook.com (2603:10a6:208:1f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Mon, 9 May
 2022 07:27:39 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420%6]) with mapi id 15.20.5227.018; Mon, 9 May 2022
 07:27:39 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 4/4] arm64: defconfig: enable i.MX93 clk & pinctrl
Date:   Mon,  9 May 2022 15:29:11 +0800
Message-Id: <20220509072911.3268668-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220509072911.3268668-1-peng.fan@oss.nxp.com>
References: <20220509072911.3268668-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9aa73a8-a5d5-421a-0ba2-08da318d65c9
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3330:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR0402MB3330F3A68853788C6F54E373C9C69@AM0PR0402MB3330.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lWHrxJwiGmB+HbkRFziPCqbuWY8tNpdQaLo6bnrkHwp0GfVxTkOQW2PZsClNCEAs3xTC0QI35Kqumm0vQ5Q4Rq5eTUUEkB/cWZ9tE5xUHGl9Cuee7UxWRNjHQkjPnE7aGPLafpxf0gutGkiFJn2y57AZuweeezMMFSkLt1tFeenF8QDwt/zHyppYXYO4xbl7dcEZrEVSxqZBbjywQURgL5nOGZO0617gmSuGxGxuQ1/2AUZvGAXKfZQ4W15HnnqV/LYzYNK+EQSPS70JYUaA9Beo8JFdye7CYdCbbqpp6hvcix3N9PYaLd4JF0BcZ5mo6wo4dIxn4w4atbxbCVAbv0b7yBf8cdqnsxeqJEl3cVn0yR8sYlVidkHp2sZdJo8myxHtJ/GPUckrp19Kv6TE0rUUgqGVdQv2smYKizskfitQ9/lKhtAyEFqsUZgmhQsEr8Rcj01mlyl4Xi6KbNgTICakBE4XX5a1qmVwzrWGe0XMDQlWWuENhNMBWQo1Y19OthXjoHK4wWTAPsge0rBycv8x/rQ8I9B+FxtUZPtDqqlmeSHImYaqGJtmDSwZlPnS0gAc6cUwVq5Z7xJA7LIRP+V+iP50V/b/iYKPCEEg4IRNzELLSKhHb2KJdDQoYJKRRCGokpqT5SIcmMZBJv3/n4OKtD1Ygff1B2VN/vvMsFM0u8BmT8mCS7h1RKhSUm1kOOq6f21fnuUGwMjSM4zcsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(6666004)(2906002)(6512007)(8676002)(4326008)(52116002)(8936002)(86362001)(5660300002)(66556008)(66476007)(26005)(4744005)(2616005)(66946007)(316002)(6486002)(508600001)(38350700002)(1076003)(38100700002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KZW9d4Kq/j0WtUzQ6QGrqg4Phczo7qQmwLQqdZxPhHrRNGuisoiJSC5zXAwd?=
 =?us-ascii?Q?aJM4bAUMVTzawXzIF9Y5orypnwzgUKEbHfa9mM5hn4AcWz5xfT6svpvqNTZZ?=
 =?us-ascii?Q?CRiUzKYWyG99cU1CjWvtpCYSMrkVDTnCf/08gYRgvTUqboAg6q6PK4dhbhxy?=
 =?us-ascii?Q?UEXU1Hf6YJdN4De8xd2W8+/befviskpZra09yL7xR3prHF43WnyGFCKK4f08?=
 =?us-ascii?Q?GM5QI6EFZb1oz5uQjIGSKBCPRmSWE0xSsmKkdIe4XQAO5RBuQGFDNloPfWlW?=
 =?us-ascii?Q?o/ohKF8VcflDP+aYH4YCVKBebP/DkmXS4OSGWGqjmE85AMUjmTg3+wKmAYst?=
 =?us-ascii?Q?WTAGJ3O9EgFwZP+yeH19vr7PV5v0Tzo25qV5C6ymx5Zht8QyuBAo6sPFsk5I?=
 =?us-ascii?Q?YxBlcBi4+gdjtM6kw6rmgMzKKvQzSGBTwlPq603zlO2S0zW8+nmzX8t+7DXT?=
 =?us-ascii?Q?v1USvV2Nk9XAgQYvOlq3N6bfT19vAXQsbY/5vWyWm4IRgbU/IpQm1iDt63bt?=
 =?us-ascii?Q?+ejR5PbLvJs+zZXTgbh/7JYFHI1AykHOsVfV3pJgy2FP//cu4jtD8VrNNDGK?=
 =?us-ascii?Q?nSNffxxbnPH/IIhC8RZ4hPgNKezDQhXid0h/6JRp2QEuL+ojgrTB24+CQKPh?=
 =?us-ascii?Q?qOHpJqqmK8p8+/mSU7z96WSdd6hRTm8srOuivey6BaA4LcEc1SAqWS8KT5Ys?=
 =?us-ascii?Q?M2rSaR74JTz2XyfH22qlwiSIpjrOY41VeQDS8wjanzOdYE2DyJ5YqfjD1HYr?=
 =?us-ascii?Q?UXlJeL20cSqjxHUUxuEKy/Av5b0edUa37yWjLeq+KTnjoj7vbqj1YYv8RL04?=
 =?us-ascii?Q?LMPf5LvrWAsLz3E9rZ1Nc6dR9YBZ5EguD1d/11C6v4/jJpa4VJtM8dUgOLwE?=
 =?us-ascii?Q?THQrVHpKEyXF+SjLCZceRJGbZGickdGOMuA8V6x8g/Fz/K3oisupS7yBjBEK?=
 =?us-ascii?Q?7yrjG/yNhjTPqoO2nSBEgM3s+C4tZmpVD+ujkJOJpv0U6TCOtqrgqZvKWZPR?=
 =?us-ascii?Q?3fGOl6U/6HJOnGf5dhsvpJT9o5vjksivnQIg4YbiStDoq7pG0uHfP8jo+Chl?=
 =?us-ascii?Q?O/MYD80zJv9MVZSm49X/60ZYv/0QJ9VYul8gIujhvCoJgu4U8Ikcr/DvJnKR?=
 =?us-ascii?Q?oa1b6G6t/Zs6HU7YkLm/06ulWEQEtvm1OPLPPkIe+GE06Pcf1eRx6t0oRSZw?=
 =?us-ascii?Q?tmmyTYXZvJiFNUX7yCaIPtiokkL1obcRkLx7663cr3JUvWBJImVshJye97sC?=
 =?us-ascii?Q?pndz4GWbDy9DrKfGqX8tsdLv2jmwa+bQVY7WBIfElGWFUlLjdEpzcPVKFZl0?=
 =?us-ascii?Q?iiq/tfeYZBnN2VEf5caR0nUNsagT4nGzdpjDSvebH0dmbgY7FDsSkdvpH2hf?=
 =?us-ascii?Q?JYQqyjDKoGPvTnmKrkBw4hrRgNUvsn84UEohCl3NEeaMZ3i1seW3SXV/ARDP?=
 =?us-ascii?Q?SvLnFCwsbGuiBW0xhTErAo2OmEPLF7X02jMRF9DysJVrb/6Ks6n0pp3cSsC8?=
 =?us-ascii?Q?b7YAPCTRBv8/S0PGayGgI1+R6h6Ldu0FdS6PtV1C5PUnxCMN87wwxjlDicdJ?=
 =?us-ascii?Q?KjiH4/FIzdeDdOAn/TfdHGcRq4uEA2ZiJ2KARu7egj+TrpcF8kjwoCQJWmwC?=
 =?us-ascii?Q?bJ0nKaWG2kMppBtt0lj3AIh2SuJKJAZscTDzl6P+1yottNQDGFXart5teYby?=
 =?us-ascii?Q?p9jT1hiYmqsBNoJaIizgQS7l5SLXtwbfQ21/sEqQUf1RO4V9yUEu/a9atGhh?=
 =?us-ascii?Q?ts81LNZOrQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9aa73a8-a5d5-421a-0ba2-08da318d65c9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 07:27:39.7295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yad3HL59Mt1uRtx5zQhRnJEAo31Fx9/vOjSuALlr4wouewpMKDMHrldAINyL/6e4RJrAzbyPOLvbugMWuMsu3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3330
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Enable i.MX93 clk and pinctrl driver for booting the system

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e0aa3a924eb7..148cebd0224a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -520,6 +520,7 @@ CONFIG_PINCTRL_IMX8QM=y
 CONFIG_PINCTRL_IMX8QXP=y
 CONFIG_PINCTRL_IMX8DXL=y
 CONFIG_PINCTRL_IMX8ULP=y
+CONFIG_PINCTRL_IMX93=y
 CONFIG_PINCTRL_MSM=y
 CONFIG_PINCTRL_IPQ8074=y
 CONFIG_PINCTRL_IPQ6018=y
@@ -1006,6 +1007,7 @@ CONFIG_CLK_IMX8MP=y
 CONFIG_CLK_IMX8MQ=y
 CONFIG_CLK_IMX8QXP=y
 CONFIG_CLK_IMX8ULP=y
+CONFIG_CLK_IMX93=y
 CONFIG_TI_SCI_CLK=y
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_QCOM_A53PLL=y
-- 
2.25.1

