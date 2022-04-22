Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562B950BAAA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448996AbiDVOzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbiDVOzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:55:04 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140089.outbound.protection.outlook.com [40.107.14.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91485BE7E;
        Fri, 22 Apr 2022 07:52:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qtgbv5qJ1s/uCIYH88C1Kv8K8OR/Ra/th9YldfES0Mb9b5zPrx50+L2oAUzOqNEfKdaRaiQHu35nAhqTbWSEL6TIHHnOQDVfPur8v3+mPWMAcXpyirwnSWVqQMU6Rq8nV6Ez3OUo4ZARrS/kEfHw9BXQR6bvj48o5TExx3KJTAy0pg2n23m41iLk8DjqdQ8s1XpBbadaaQXZsM/yr8rLaztMPsBWKWBHpuQEwqxW1YIMB6Jkcgn6qxVpwuXC69E9TpcNJfzw4LtoWMwbK+AgUH8MgFPeCl1hG8TgNT9o2fRrq7MDdTxquNMZZ+LNVfQ3UHacKbFsJN3/E5YMQokTpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/G4FbVJy1vmb58t9jLsF4M1WH+VulB0OMt29R0ndkc=;
 b=MoxMgp+hdL0iOH7fciIl8cPJbZHTamhAorzefWUC4FHJZUMvE8rsbQbNrgH/CHvMRISkc5+6Bnd7/EeOljIn2qGuYtE9DJCkOZsZ4oXe6jdhNI/jYHizStfYwnWjSDpvVSUTscOVotVz+VocvnD3bpZzex9C7+XlX3+lc9V2cEB17Opp4qdtoejQX+jIL36qnTBFwthUhZHtk3Pve8Uq1amdasUtblBPkzuoUBGrE5uaZ0dhtnv034a/6XqNpTjLWb7bcRwb5FjabLzL4pKITmaHvy3pEl+JliAIkk8fjvzcUi1uebbgh+TNN8G0wI3xKX2+Q7MN+ezhjRR86ySKWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/G4FbVJy1vmb58t9jLsF4M1WH+VulB0OMt29R0ndkc=;
 b=QkK8iinYf1vOm+CMInE5jeblrEFPGrAuxaucTs/u9ftx/n9jW/CqUT3QK7LPBA/kFDrVGLhSpoMlnr9msZ302VY0fhsBs36GfBFiUXeG8fIiFWt1FrKi9pbeAKDZCusnwv0VJvQcOupsM/h2fiDPLFQ+WkaJVsb102Si8jjduhMrHRZ8IQ+wEArhBmKwlAyT20DTd4VKbh+AnZzgyKZNbBaHu40mXZBr+EsqQDmGlL5Xq+mES3LVLrM5GrSTA9TK7sRe+G5dyk3G9nfcjThU1DdzJUO4/5F96ckxoybxYTqI1WpvdUaM+qbsFhL9MLNphs6y9X5VtPa5TmQiEMOpmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by DB6PR0302MB2792.eurprd03.prod.outlook.com (2603:10a6:4:af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 14:52:08 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd%4]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 14:52:08 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v2 6/9] ARM: dts: layerscape: Add SFP binding for TA 2.1 devices
Date:   Fri, 22 Apr 2022 10:51:44 -0400
Message-Id: <20220422145147.2210587-7-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20220422145147.2210587-1-sean.anderson@seco.com>
References: <20220422145147.2210587-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::10) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 690b7eaa-984a-4d5c-0c85-08da246facaa
X-MS-TrafficTypeDiagnostic: DB6PR0302MB2792:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0302MB279272B3C45F02CC4FDD4DF096F79@DB6PR0302MB2792.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ayRtPgG0yHP96JtGro3rjUUovA1zG/PWJ+eld8A/wZsZPtxjSgj7yn283dK6eEFb5SH1mcUPifenKz1mpQJB4iek3pUvhsVrTLUKaF5M1kUsjuVqvFUm/M45LW/LJPTzMAz5vUXqNG/A0uXvWeAHwMHFoET0PMe5lNILUi7NieIhv+kHfEhKlJ4OE9bSB5HXmSFt2AC5fQcQ2Q2RVPQC6FZUsI+eBETz/hZuiz7bWr/D1CZkU3QXHjIWrTa70DRadH3vShXsIdySJU92zXh+jTnSSzAraibExztzu7ByM57mueTYpbHVEAQdhXwaOqBNTPIJFpM7Vam0zw8G4koGxJKHPD6ftF0Bxp0HaW+SdS1z++VX01q6p7aSk9tsxAsmvMED7FaYREy1c8yy0IRA7zL3Pl4IHi+Bsf7VrbPHDDtaWcbk0uQzL1nUE+HM7qTjC/3Bw+CKx9d9yY8E3YfKdRHHqmYEeRTfjn3IVnV7vRrH5PYDyDp8gt7ubzEnu4AtSruuhjDs7KSx06WUOQOhRoC0urycz0c0p2/3QAZo5VoIL3jfhnpI8NIo0XQ7aMZNatrHrk7tqLlVScy42pvcHRyZ1ww9VPFreyyLsLqNIvTcETjCK/MBqeLR+XaylsFSVkNcTkPoKQJcbNYlQJFl7iKuT/J/0rJ/0pmKOeHzm1glfc4/7fYF/uJWdmDwg2RW+MfKi/5LovpKLiHtWD1AEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(36756003)(6486002)(508600001)(186003)(38100700002)(52116002)(83380400001)(8676002)(4326008)(66556008)(66946007)(66476007)(6512007)(86362001)(6506007)(316002)(2616005)(8936002)(26005)(1076003)(107886003)(54906003)(44832011)(7416002)(6666004)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jptDDVBNgluv3oNRzAG/rcP/02f/cIbnOHo3T+7mlwDNnMuVdTubH6UC7wNd?=
 =?us-ascii?Q?lWQHHphxwn/p2CPlHz99POjIFiLN97x4mMnlHtgq+DGfF11Pi6BjzXEV/D7M?=
 =?us-ascii?Q?4E3JalP3BiY3WHJ9SSOqtxf//HVcMQ+izvz56i70baYClPdIuhzxI2o1o9i+?=
 =?us-ascii?Q?amWuVFYEPsnXXqVo8wUBeE3QHx/U97B7G6rGQt42R6PrkvPlB++XX2jg3gd+?=
 =?us-ascii?Q?W0sT6jdEkJP3bd/zWEXBxnZFEn+W+dreb5IT80UKYtLMpgfKlJX4mCd1tBtz?=
 =?us-ascii?Q?dsrIdI8k1MRBGeL2JsWE+xbo1JUvzp1iJTz7ZDiHFrcaw1ivdlKn+Zt7wMxN?=
 =?us-ascii?Q?cFIu8kmgWfKGQWP5wBnGkln8b7B1BcpRWqcui5f2+LzBTUF8OK6SntWf36Fi?=
 =?us-ascii?Q?ujQ8Fp7uFu6QaHgjUdiAyClE2NzrMuog35VH28eAVAQ/4nKTKItH7YU41Pph?=
 =?us-ascii?Q?5k50SrqQ08YwltjiTlmcJ+91HbARMnAe7NP1KaR/LmFhKKwmjevqPSjLmV3G?=
 =?us-ascii?Q?IwMkj4CcFRQ1GGqNU31fQMXu8YrnzknP7Q6DBcsFjOOcaAgm06/IWs9Rapif?=
 =?us-ascii?Q?G+5pvgkheGRsX3Hi9IZtk2J4vuQ3vfcFBSO2xRNfS0P2pznRiTP7MXo55G5c?=
 =?us-ascii?Q?BxnNVgw0QHBTTTGByov3eVO1XKGUbQoyOuRjVCS5VnzRJC8+991rjsFALmz3?=
 =?us-ascii?Q?owAkFiH+SrNAeMsO/unndruSV2SvlPWkhf2yCUJnygxhIIBsjKWmdSktGI3R?=
 =?us-ascii?Q?xXO1AafBKlL2Y4NRXvOErByVb23ID6wu7Py9LJJJAlqoNfa8QYEygUwXuntz?=
 =?us-ascii?Q?rDxKCIkpRnOiOj7sf0fT5bA+W8cZW+4TAymBR1S1jgnisJNePwJ0u3+5qBap?=
 =?us-ascii?Q?/OXovQJscovTsu+g4gHP07QrEmjBpUEoCzAgchNIjVrI+uTi9FTDXSpHo2c3?=
 =?us-ascii?Q?cbgp96SCQwlSUCmBveW8TZ/1DaR28bkUQ34/j0slgGCtHtUbMI1ZuRNwCMVB?=
 =?us-ascii?Q?yvWXHbSr4jxGd/W7ZlU4vx/L9GJ5nY/B0w8VHY74btRnwDKnXDhxmQB7sMIq?=
 =?us-ascii?Q?OAl8CAQti520t+SEyAzv7IeXQF01UNCtc+75cNr0YT4D3WY4Oywp9HGKLC0K?=
 =?us-ascii?Q?0WS/IO9EJh+b/8KUTidzoPUlNXkIKIMjPU2ywYviIKIs03EVPnRcygAm47lh?=
 =?us-ascii?Q?GCT30Pu6sHz4ux1mxAJxgd7U+BNk6qH40HK27dgLviaDQwjLDI6oSk8RH5vf?=
 =?us-ascii?Q?uqdAUlgHcR4mi7btZX0Wv8tliNZy9Mcoz4OuaqSKqMv7/Ud3aiDx6Yi4ACAi?=
 =?us-ascii?Q?lbIrlqdy0LqQSRaLxJo7q4FT3H52BqRl4kCKxa74dash8bTJPPskJVnrlY3M?=
 =?us-ascii?Q?r62JD46fVLbQyF27lX4xOx0ikUmadVCEJgF/y0jpJuyXnJ/i42Fg1VT9Fo/F?=
 =?us-ascii?Q?CCMfb+AdcVw4sf0eJR95CC0NNosPxCSplaY+4vFQcr2FWbEeZaF4tXWDU64L?=
 =?us-ascii?Q?YZ0HknQFfE4QzXQWqdIo/E9qF8e1FVrWOWSFKLMly1bFt9oGddfzE+4MM1YJ?=
 =?us-ascii?Q?kOft5roJuND/1h3Xwj+IlqH8ADqlYb77JJKAf3tmVnUdHigEB7YZiQWLcS8C?=
 =?us-ascii?Q?qMxajmJOBDysL+m89bMCdUMjQTN/JcG8GXVWvgTYrqrMGk288stBU6wpAWjJ?=
 =?us-ascii?Q?zbHqHK6nYzlteE+aQqdUwSD7GevRaVY3t2cPmrO4AI8uWORC1f1FB1YQlEQY?=
 =?us-ascii?Q?o1iK4mwNubIfexQvajAxoGiEbyX61zA=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 690b7eaa-984a-4d5c-0c85-08da246facaa
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 14:52:08.5329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jfdn8mohylRm+G1Bmp+xhPk4d3mzBp2cOUpMBtc/dWzkL8dbXKmSXyKfZ0zv5FS+jYegK0XYiNljlw2b390LjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0302MB2792
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an appropriate SFP binding for Trust Architecture 2.1 devices.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

(no changes since v1)

 arch/arm/boot/dts/ls1021a.dtsi                 | 7 +++++++
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 8 ++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 8 ++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 8 ++++++++
 4 files changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 2e69d6eab4d1..c1e94a317cba 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -129,6 +129,13 @@ ifc: ifc@1530000 {
 			status = "disabled";
 		};
 
+		sfp: efuse@1e80000 {
+			compatible = "fsl,ls1021a-sfp";
+			reg = <0x0 0x1e80000 0x0 0x10000>;
+			clocks = <&clockgen 4 3>;
+			clock-names = "sfp";
+		};
+
 		dcfg: dcfg@1ee0000 {
 			compatible = "fsl,ls1021a-dcfg", "syscon";
 			reg = <0x0 0x1ee0000 0x0 0x1000>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 50a72cda4727..47ce525e0a72 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -271,6 +271,14 @@ rtic_d: rtic-d@60 {
 			};
 		};
 
+		sfp: efuse@1e80000 {
+			compatible = "fsl,ls1021a-sfp";
+			reg = <0x0 0x1e80000 0x0 0x10000>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
+			clock-names = "sfp";
+		};
+
 		sec_mon: sec_mon@1e90000 {
 			compatible = "fsl,sec-v5.4-mon", "fsl,sec-v5.0-mon",
 				     "fsl,sec-v4.0-mon";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 35d1939e690b..b0ab0b19de7e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -383,6 +383,14 @@ sec_jr3: jr@40000 {
 			};
 		};
 
+		sfp: efuse@1e80000 {
+			compatible = "fsl,ls1021a-sfp";
+			reg = <0x0 0x1e80000 0x0 0x10000>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
+			clock-names = "sfp";
+		};
+
 		dcfg: dcfg@1ee0000 {
 			compatible = "fsl,ls1043a-dcfg", "syscon";
 			reg = <0x0 0x1ee0000 0x0 0x10000>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 4e7bd04d9798..c30056afc02a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -413,6 +413,14 @@ bportals: bman-portals@508000000 {
 			ranges = <0x0 0x5 0x08000000 0x8000000>;
 		};
 
+		sfp: efuse@1e80000 {
+			compatible = "fsl,ls1021a-sfp";
+			reg = <0x0 0x1e80000 0x0 0x10000>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
+			clock-names = "sfp";
+		};
+
 		dcfg: dcfg@1ee0000 {
 			compatible = "fsl,ls1046a-dcfg", "syscon";
 			reg = <0x0 0x1ee0000 0x0 0x1000>;
-- 
2.35.1.1320.gc452695387.dirty

