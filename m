Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A026351F623
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236167AbiEIHfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236689AbiEIHcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 03:32:50 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50086.outbound.protection.outlook.com [40.107.5.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558CB17CE63;
        Mon,  9 May 2022 00:28:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Px1GjLZgSUtkSKnwqJPBPTYNXDS+U/5v2EfVr6YOz7PQAGI00MmptJu851Sr2IbkzGuBPMLMpU1gD9SG4NwZAn+dM5HOMzJ96y2MOnWcaYdCz82VOTumL/6xV2eKZtOtTFNN3OafKJQNK3viUgtYU5cwLiOYKrNsN0Umb+GADnGPvLtX9acSHOhvG7fAd/9h34bv3TAsdP1L96M18Y7Yb00MZ9De0i43XAe6l0Tdi+Na5FgDnhLR2rXI5+gZBTWmFx1+iqiMN0/nvvl9wfmht3lQL8CkdfOd9RuWHIyryXYBIHJLC43r6mW2d4MwnUOfLFNqfTwqWHlL4fJi0lUSvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMKLoSwvPzyKLgsRE4QX/uAQhLgXU1vV9wLxhViXzKo=;
 b=KTF9PhJbFRA9DTpqVf23lzDdDB6azTzP5vLwiEsfX0YFr2QCPNi58Ixt83pUukgBSiTQws3I01FV16dyS3TaBei/5arfuLB8EzsO17QaH7YKw6+KupOr3/tvY/Kc9I21Tbg2uH4tyiFO66Kgm6p1QVc/Te3yUqJx6ButfkiurgWCY3l/o+8JX1EeRONYRt8uSIUUwMnsC2/4jLXcx/nCAVXrqYK4ZlBUk5F4DXN8pih4EYqPveR/zxOXsJKoITUR6wA1xmStl57eU0oPdZB0/nY6uEXFJwsJsibnzGngtwPq+FBtvk2GbIwjFn81ojMpsIAW+qSdO34Ksgnv3b6dnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMKLoSwvPzyKLgsRE4QX/uAQhLgXU1vV9wLxhViXzKo=;
 b=BBDBv0RyRiuOBcWYoq/MiaG90/L9mqHOrwqHUMEg3nopUq4CjPjTHxG5n2AkBj7JJn6+fX0A3bv0hJyntLoXGhS5K65q2h8ZdnI9TNtJopsSfu8Rpj5XS20jiT86j22uqSu+7a0EZghV87JA+7KNKFJCaxRBp0MBwJ8jGBrZ/80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR0402MB3330.eurprd04.prod.outlook.com (2603:10a6:208:1f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Mon, 9 May
 2022 07:27:27 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420%6]) with mapi id 15.20.5227.018; Mon, 9 May 2022
 07:27:27 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V4 1/4] dt-bindings: arm: fsl: add imx93 11x11 evk board
Date:   Mon,  9 May 2022 15:29:08 +0800
Message-Id: <20220509072911.3268668-2-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 596f6d50-9eed-47f4-ceb7-08da318d5eb8
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3330:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR0402MB33308F09351038CBC7FAC659C9C69@AM0PR0402MB3330.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xpMGEp6rUQX8GoWwA54x1YkMc+ctznh7igQ1Dj6pGJDwrvGHe/J7bOslspoAbdWf7MPJdv2WhE2JJcp7JpcYj8WuowhABT+vd0zYb728DgVrOTjkJs9lQgbeSoTsuq2qtJH24FVlOt7qTaO65hGDB4MN7YxnqtVfE2Jkh/ayI+UZ52A0ok2RYi+XzXrwpu+pJQpeDuq4QhrqSoHLUQcoyRftpvZ2qY9j3EiN25W97Z+IIxyDhuL2iRgerrNeTFnCdfprSKnie849/pwIMMCL+azznLGcvJBQcKQtiusPTLRyvktUgIWPnL0bq0r9G8X6Nl6q5SCiPtFWGo2M1t9czwngNDHHraEgNmH1zE8R4no3XLYCcvQzaTlb5EWLq8Prh7MKHH4+z85TIldxQzk+POmSIR+VPSTPMcTGrKf3/UuG4CwunhINvbZx8e96Emx92ZhiELqQvcRMapAFFqlPlhPznJp9vqy0Vulxyu9OdcaJBJAFsXi2KHgzYJKQTyWOcQg/cYwYkA7h0TZSEUOXZxwolafO28sO4m4dp/BMucj3yOAmoeHjhjqFNyTBun6VVaZ4vBP1AfsD2sS8UsX4Z8cv9fx0q+1olGi5/7uaYO3F3kWJCi20b0cPLmJI/h20F+tWvSMOZoQzRa4p7LFuRmr5pntRBGpotLw8RC7xufH+N4L0NtqieAxzwEK9HPHnz2yuhhoRnj7VKlLyeXgWQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(6666004)(2906002)(6512007)(8676002)(4326008)(52116002)(8936002)(86362001)(5660300002)(7416002)(66556008)(66476007)(26005)(4744005)(2616005)(66946007)(316002)(6486002)(508600001)(38350700002)(1076003)(38100700002)(54906003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9u17GTB74/fGxs+ZNBjGznB1O4Qb85sRm2HNZ0NO40GtiUFFPdg/JoeVlDV5?=
 =?us-ascii?Q?u+3bdl9chyiA/csQ+U4+UWftXtsZkhlGSxYHekrX1c9fTqcnmxBbDYPeB6hb?=
 =?us-ascii?Q?ar2vxc71wEi9qjm8938Z9EyCwYJ9TWPeEoF0oFDXZJ68IxNgkLg2oeK2RhUj?=
 =?us-ascii?Q?/0bKntUYNGFqPJRSG5gFOF1dF0PxoR0xoaUwp3gKR1oHV7cux0X99DMkU/gP?=
 =?us-ascii?Q?5iDMCtvv2VyEoB+coLqrw87rqTkJedBIyt8vP6Dl2tBBtWZ2yHKs8SI+lz5d?=
 =?us-ascii?Q?l3zDlqcsU3DPSIin00b2HYh7PiGazlt9rOoZe+oq1SC2zlLvRzejspQ9RhUx?=
 =?us-ascii?Q?oAUTCVuvEvA4d5kKKVlcFAHxJHfQpL37qHSrPyoxBEJhff9vyYPgmsdIbVaW?=
 =?us-ascii?Q?NTaniovdu8YmG6NkKZn+e+f19ESDw1p6KQ/7WJoBjHvCZHPwFgy8tfX1XJYs?=
 =?us-ascii?Q?QkecHDsLmtWuxMgQQahhBzOunmlhhCNWjyusfTgLMjIciTd15aPkf3OlhPIw?=
 =?us-ascii?Q?Z+AP5hrqcxH2AhsLU3F0kUR4APwd34RF6fOg6i+pyRZYwJA7WzHgtIdRylUd?=
 =?us-ascii?Q?EQnpNo6hSUuQtfqMvUz/0FOSy6xMSbZsRcd4hLSsPkhm7kUScgHARi4Bzl8q?=
 =?us-ascii?Q?NtwgkMpnhnbsqDEP4xJVUy3sXH6QKC+61KLKfDybLpZQvaBSx4EIh45XRtzX?=
 =?us-ascii?Q?g9Clj31Hh7JUkm2CNQTCy0dEQ+m80/8ZVWKBhpvnxZZURkF0uUkU4mpknzzM?=
 =?us-ascii?Q?TKyRx1hKPjd+4UsApCD2jPVExebSTp6eouST/lWD/u+lCnMcgm1gvbamYUYj?=
 =?us-ascii?Q?yujA+xowNNQcyaPmnI5R/qoS7dDvn4o5omAvxPCNWnM8IBoHNSVsZ4xuTeYs?=
 =?us-ascii?Q?YaGtsy/xZC5YzpcoPbAqF9q1nCONSCXnTgXOAMlcWVEpmLkNL1BGweptxx3L?=
 =?us-ascii?Q?wAuW2PEXjEJ+hFtrlJ/dmd6S8zWUffiaLkl9K9YL0SFajn7+e4sOS9GWZJBr?=
 =?us-ascii?Q?J4HOU+tTUtQkVmVdzpbzQ2pDBnu2AKUtZViRECo2lcgsMj+2h61kIm5BNoPU?=
 =?us-ascii?Q?rtbJIiYATs93bM5JxD4CKfRNbAvG+BmfW39wMejW4nFn8yor3I6mIndF8GxH?=
 =?us-ascii?Q?o4/ML++4StLWWoqDXFVaa/TeNcMDc5efvvaJ57eWcLsQxa7yqloHVX12l2D0?=
 =?us-ascii?Q?ZXDRmLdLsb5NiIuyO4oj1k1KIUFNrv5FXw1MEPw5CTYXCgXMu9dtG6GvYUKN?=
 =?us-ascii?Q?AHupH+6HSm5RyDfoV2NXIk/d0pl8AYZPn+xZzbPIUyASxDPGfHA7CkpfTFdB?=
 =?us-ascii?Q?QwhNP9KWAINbxvbM6clmKoEWyc7RzG//BXHH2fOxAJ+Edy8hG29rsnzUsu8l?=
 =?us-ascii?Q?muyi2Wl1UirKynXcearnVsG0IPwGTyHofMmyl2bI+LpEJBre0Zems2gEmQVk?=
 =?us-ascii?Q?Z5EcG0xcYNtMfKce00Ct1oTAxlTIVMJpT2iObxE6DGt6ioS+1Eea6fyBMICc?=
 =?us-ascii?Q?VF9IejrXihCHnZFMuORySWXRH5MKGAFdvl5y78MXXLVsMeB/T+ne7RCkBspi?=
 =?us-ascii?Q?UUF+jQOhkJXEkZbTywYCW555bby2BUO6+GH51uwrIilwX2CRqTYdm6S0Iloy?=
 =?us-ascii?Q?zI5aguOBhdKmd52MaifkpHlUo5H5eAzw1QL4KxFWg9TjhIcmTpZtaz8Hv9hn?=
 =?us-ascii?Q?NxAcxCiyLJYFWZKa6NOzifjiDTLgUqZuPPyJuEPuePaXMDNcgl4hJIJ/Pvc+?=
 =?us-ascii?Q?Qs3+aLm5sA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 596f6d50-9eed-47f4-ceb7-08da318d5eb8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 07:27:27.8946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0x/IUw8NnVRhNQ/ywQ3akObh4s52VNlRUBQImnlrmobBGdb4X8qTXlcd8Qvw8pbe6mXuk+WXrmmEEbP4CQeqxA==
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

Add the board imx93-11x11-evk in the binding docuemnt.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index ef524378d449..9e5d5725df65 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1020,6 +1020,12 @@ properties:
               - fsl,imx8ulp-evk           # i.MX8ULP EVK Board
           - const: fsl,imx8ulp
 
+      - description: i.MX93 based Boards
+        items:
+          - enum:
+              - fsl,imx93-11x11-evk       # i.MX93 11x11 EVK Board
+          - const: fsl,imx93
+
       - description:
           Freescale Vybrid Platform Device Tree Bindings
 
-- 
2.25.1

