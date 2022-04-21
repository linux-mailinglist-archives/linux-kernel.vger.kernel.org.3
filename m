Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594CF50A79F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391093AbiDUSAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391037AbiDUSAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:00:12 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60084.outbound.protection.outlook.com [40.107.6.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989E246657;
        Thu, 21 Apr 2022 10:57:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agwc4/YkPZT/dHS9iJFHkQWQUllUnPQdm+j7T9pH/wPXiW9IN0Irrbp+6SvW66W3yvPrGdDgoWJ8JZ+QqKrBJ2eQPLy4dOzV/6Wx9ZebGtX/TVS9ETh/c7EltjoyVnSAX6szvXQTF/MQGxTjjlhjczlhqWmvXlYucVLw6t5l/yHTrxue4n237lEQ6TdI86mgZbGVUVXGwtP1AFSccBb5Kg3/zE1AomTmIo8/PBX11Dnudi7g86itJG/M8E5d7Zpp69WzcWvuH6YUHCwkxn2q3SlwKvGpDBmwy+7+w40pFrxXuEtFRKq3nBJVxlk8S/cC7UX2K9zIvIM7CLPYtnRbQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUmFSbf1+NfiXsGmszU19NV4Y7SCi4aP7dlBRcCsVNo=;
 b=Zb4O1sf9t5g8pSpdjRAUXOqVDuZptsFZadKl6+wqWT4PEpItpXFFVh1SRjovFfODIyLobeNhhVTwrlJrriKUU6JH4bG1HEnkGNEr7FQqQWpUciXwqcnKT2IuthYFRmSmMrEDgILzh//u6Z/q00yRixtekFFYgqx2oOholgofkjSvrabqHT8P8ygrO5bUWLlx9Y3Nrh+opW8fsMSxiVILesQ6VcSSVc95Tt7x/MJOZXBUB0iyRwaOgXiqQ4AUc+10iBDSm3afo/evMcbOm8ki2PZDu0q3ZM9fR3PyPdlRyJisO22ARUC0kjZWY16En42Jr5FwzYPWWFDaX5uvIVM83Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUmFSbf1+NfiXsGmszU19NV4Y7SCi4aP7dlBRcCsVNo=;
 b=J0ODExqiufTGonj/LUdVEQIyBIfZxrILKnUWU13ZhEWZE/Zku4RJP0OAyX8oEqbiJgIriBOVla3AFk/qpMMwyTP6FrltM00Oee/+CTctTv1c1N3kj+bZzhXnKKY1R/Av1zCWkeW1V6cZLkD43zUz9XMylwRP7bGRQGbkRZWsxOsesnVqtz/WUfi6toKAwUzaA0a6jxbSOecROJ43TbPFYpG0CfQOyyrJyboxjnZDJBD8CJezV2bsxi4n0lZbUmE9DixQBZiNvA3OUjc+g4vMjAa6FOq+mOa8BuTPnba4an2vZYxy0d1UubV86i5xmmUjIzNj3mEYenZ9rQrGSHLIjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by AS8PR03MB8101.eurprd03.prod.outlook.com (2603:10a6:20b:444::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 21 Apr
 2022 17:57:20 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd%4]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 17:57:20 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 7/8] ARM: dts: Add SFP binding for TA 3.0 devices
Date:   Thu, 21 Apr 2022 13:56:56 -0400
Message-Id: <20220421175657.1259024-8-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20220421175657.1259024-1-sean.anderson@seco.com>
References: <20220421175657.1259024-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0125.namprd03.prod.outlook.com
 (2603:10b6:208:32e::10) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1006afc9-0d47-4de5-da09-08da23c06145
X-MS-TrafficTypeDiagnostic: AS8PR03MB8101:EE_
X-Microsoft-Antispam-PRVS: <AS8PR03MB81014DF10B6CF30436684FCB96F49@AS8PR03MB8101.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WciYlbnCRM/mTKsLY5a4llJdR4QKMPZchV/RSbx2Ox+g3Tdi+mzqrLPUzyWCodlrjrHBYo9qpvCLIIp4G1QDAolYohQbJ7ujaSj7ASRGPGOTA9+b9DZT6/Oh1zEY1J2joa3PZ1ergZDKbMqn/l3HKdUujThqVeky74rLkoyeHrkGJ53A2azfAx6NmI2xtJBMx4tOMCB6F7RLVqr2fTyV2ZS8EE5XsjZd2h8z3TNpi4+K0/8hIucgNlsJrQAg+DQxwO/9Ji0Ovis2YHCX6MW0bN0/cz6I/5l1iE1lfs/ilGTXJXQlRh7OS+09AnVR02aVk325UH90sev4ERHWFdep8Maucjjs1SVcgB2J9/hGc8gpX4G82ZZ/q4RGFNp0popktBqRp9KcvVN84U1ekUE4Z0C029HzRpRa60Rvw+UN11EQTzXd3XBQdUbEPwOfcH1IopYOmLZ1xRNvsVmWXqiMyZCiqDcBxhgNXBiqEZyPlFGnjKMVMHA8nvucemXqS0Jhe3mo7jTO4sMbnAxPOP68qRImB/BGCMYHKWRAfbXnFHc0TlymC/QvDqFnmHAI5uOxRrXMJ6ofYzy+dSO+zHssqtn465pV1BfF/Lxb9B/Mz8eWCjxD5qc/iutzYD30TPfLS5dD3v4sxj/vnQkofHKOVzer0UD2KbbvNHesqSKVWetLQr/LlRRNlrDP7ucIvw3vPE9/GWpfxBJImVcFCHREgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(52116002)(86362001)(6512007)(2616005)(5660300002)(44832011)(6666004)(2906002)(26005)(1076003)(107886003)(8936002)(54906003)(186003)(38100700002)(38350700002)(508600001)(36756003)(6486002)(316002)(8676002)(4326008)(66476007)(66946007)(66556008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UOGN/MK4lK8INILLwus8ScXZggAcLJEpdCVBfaPABw09HRtpQtkdQds0fBrn?=
 =?us-ascii?Q?BRgXTBFqXw+tecCCav4s3SLvnYouAlQkFdRIhNL6A0Qg16wnbNYlC4aq6LPl?=
 =?us-ascii?Q?IE75bpVPspC1Fa7FfiM1bv0jOTPu3qwQ6wO9VMcfaC3UbJVuVR5meih9s4WN?=
 =?us-ascii?Q?iVcZV5X/X5W5/i/QtLn/qGLwGkzWSRuo9H3VVrKuH7jhCUltJSFFKiwsjD6O?=
 =?us-ascii?Q?/czFQDRU+Xv9BAwAbktCi6agaHZQG0gxBmjdGYsf63ZnPby29l9ziIM1ZxJn?=
 =?us-ascii?Q?oN+6dtnZVVNt0JxM+BZbNQKf75hsEwcj8jAzwc1t0jDxLfZY4+TQC+YIYVM/?=
 =?us-ascii?Q?t6LFJEnMTlyejjfnJoxcrowR2WYYnrlbFEC69qwK5qm9t1dVdQ0iup15Knoo?=
 =?us-ascii?Q?FjmBqz4AoMpb5hWxhr/2JyJfEjs5ga+QTDXY9Z0cnUyKtMXKtRD+AgqCeX+7?=
 =?us-ascii?Q?3tvZZgNf68TIVdr8dlxCdSZpVIaVvEC41JA6bpgeC6O150DAwe4VlGOhO7Js?=
 =?us-ascii?Q?3EOtE2UpgvfEcnMqLPBAw+piKGNPzxHpd5B43MpNBHoYu7/E8Y8840b1LUCS?=
 =?us-ascii?Q?TbK9EcoKVA7khD4UaV8fKeyJzb7dH8AdxW1EvDZiWkuSo2bQ7VVC/kqsl1O9?=
 =?us-ascii?Q?g35PVpk8aAsAfSyE5GFUQsMXPhe+7UQ0owlP5OcXYEnv1oPDIJGbO2D5Z5g9?=
 =?us-ascii?Q?Um6gkAC1b0YbZeKcCClnc2kLWyr5hcMp/pBbs5SRvRxzV1839iHGbO4dyTiY?=
 =?us-ascii?Q?Glf4xr+5LEOSBoD9iRsyYWNBCsDTClRIh9N9Agl9PoQYnrplkX77b5bGiTis?=
 =?us-ascii?Q?PjX6SAfcVdQ9AWPjvrHIcprdoAu8x2Q1O52XQmhsOhARK5TPC75wXc1dFgl7?=
 =?us-ascii?Q?q2yfMtNWvTKp6Gfc7tTuHDb9B96OQFi+oDv6YuYJmIT11GZBDmUa02ruAQAi?=
 =?us-ascii?Q?dImd4SLa0nVWVwsleyhzA/yMYW43GHE5+tzcou8CbhsJN8g8SW0Pstr3XAkr?=
 =?us-ascii?Q?wsppK2IAQN5++khz1aEiWhCV8qnkimjQYgeI7RFvCv/w5rbxyIGDkOT9/vup?=
 =?us-ascii?Q?XJ4o+IhEf5yjh41vAnG3ifDAGrqypIXmEmAPDqPZLPxuS/4C7kxvHgGOC+nD?=
 =?us-ascii?Q?7CK9IXgVSZUj898BiQfqwYV3gEU3vrviW0KzEtXuy18GuwZvRBzP0oEoPAtF?=
 =?us-ascii?Q?tliC2WVw5zNHEp03ezz13CRx0cpwHNHgIIXC/a56+PXWBr9aJOAF6bfUoPQR?=
 =?us-ascii?Q?5KuiJdCJIMgy0jD+u2TTLjfR3cGBIB9R8El9LXc/mNWhfDLxdsqGYQIEHM04?=
 =?us-ascii?Q?iTp+YZp1PmMgVdR1WBNr6oF+GCbQH0voef7Nm3xHAMXXhzQHwpfsYC/nIzId?=
 =?us-ascii?Q?vEm9tNav+ann+Ql2ZPwIa/qxnh8OcMtDJAhoA0OVRAYVyv/LTqZctIpAudFq?=
 =?us-ascii?Q?2Qi0wb34kmcKNXZPtlyDAC23VXCtt34JOLSgWiIhYALiIGHLXtckHEQdpVYW?=
 =?us-ascii?Q?Eb5m8X0tjU3wcG4GhjKV3U3eH0Sfr+/J586X8d50J52ck0aoPUpMdpWxRujN?=
 =?us-ascii?Q?EPEPtgUj8XYPJK2KZ7VtVYU+5NSez8UmdfFrOoiMUiYwFWRj/8tUc4SUUV8I?=
 =?us-ascii?Q?EqfoDPh1ubUEsQFyWP6bHm6K0iqs99CQLLq/0HqQhIUdd5EyFDsmssoKzvz5?=
 =?us-ascii?Q?5Kd59Iv+sbM4+0e/wdmFLI8IBX95iT9PJop2maNh5kgZXl5K2qD6UAewykHm?=
 =?us-ascii?Q?EyAC4UBoRp4y7b+BkcHECc70SKH0rrA=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1006afc9-0d47-4de5-da09-08da23c06145
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 17:57:20.0725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4uIp+prEjDwfBdxeBIZUw4RM5/HrIPi/fP2FPVyzd5WBY8Opy9u7PK9/N9BO+Us5GNwWoQFL9lxp5HHTVsYNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8101
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an SFP binding for Trust Architecture 3.0 devices.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 8 ++++++++
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 8 ++++++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 8 ++++++++
 3 files changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 18e529118476..1a58e8671047 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -269,6 +269,14 @@ extirq: interrupt-controller@14 {
 			};
 		};
 
+		sfp: efuse@1e80000 {
+			compatible = "fsl,ls1028a-sfp";
+			reg = <0x0 0x1e80000 0x0 0x10000>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
+			clock-names = "sfp";
+		};
+
 		tmu: tmu@1f80000 {
 			compatible = "fsl,qoriq-tmu";
 			reg = <0x0 0x1f80000 0x0 0x10000>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 1282b61da8a5..5705ec554bf9 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -278,6 +278,14 @@ dcfg: dcfg@1e00000 {
 			little-endian;
 		};
 
+		sfp: efuse@1e80000 {
+			compatible = "fsl,ls1028a-sfp";
+			reg = <0x0 0x1e80000 0x0 0x10000>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
+			clock-names = "sfp";
+		};
+
 		isc: syscon@1f70000 {
 			compatible = "fsl,ls2080a-isc", "syscon";
 			reg = <0x0 0x1f70000 0x0 0x10000>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index c5daa15b020d..53dd8c7dc048 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -671,6 +671,14 @@ dcfg: syscon@1e00000 {
 			little-endian;
 		};
 
+		sfp: efuse@1e80000 {
+			compatible = "fsl,ls1028a-sfp";
+			reg = <0x0 0x1e80000 0x0 0x10000>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
+			clock-names = "sfp";
+		};
+
 		isc: syscon@1f70000 {
 			compatible = "fsl,lx2160a-isc", "syscon";
 			reg = <0x0 0x1f70000 0x0 0x10000>;
-- 
2.35.1.1320.gc452695387.dirty

