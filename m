Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD5E50A79D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391069AbiDUSA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391035AbiDUSAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:00:11 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60084.outbound.protection.outlook.com [40.107.6.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5BB45AEE;
        Thu, 21 Apr 2022 10:57:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cP7mqrfUn7QZ8xkg8yGb9FsdDw/Cn1R41Z5WBUBQqVkbUyoaoQwOeIOA2g9a8Tyy/Z5aCWWZXzRjv4i7Fkj7QS1NHJTei/00CXC0HnqU0mACgT7bnHC2wObKs7a9BqMlSVadDZaAujzCjM5SDduwSZoqqwafnNKCjyuc0aCR0z/HTKHHssw2DFfzro68QpWLLlP0QJheAFdhKyBWxKJY4dkP7x/0fTv+vxE7h9WAidMZWkgzR4eV3j1ZrpCP8W77h0Sf9JTMOYUqSETXlwKRE7Rl/QgqSd4oJYb99Iw7WuCCdWJQjoVhqI2zYfOchUNpOQpSEycopyk+eqUGG7CE6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFMY/ds85xOOoEB/ah67D9VphN8wcvzYwGsERQQjhNs=;
 b=P4NAHJHWQq7LZuwdYQCeFZ/tYUNnWEJywCXeqGam1miQv/V1iU8xCkNwvzF0Ry3dC7kx+8LNAcM9v4peLYG5esBF5PbYdpwoc0wQkQtF82ufGrumKsneKEuPTk4QC7IBg8OVFqlL4dcxNOIfSs3izoUKivq4g3TGZ9PVNt503RMC9+TmXB9KH95NMa14ZdEKnsXGMNhnodUVsdcgq/0uk9QRkipkdVRUtTktF35o/agwV0iDaCczrD7JFsG2fxNPt4jgTkPW/m9O8atMXg95Vi8ySjrrIlxaohjrY/JSsl2NiFvSr1F8cYeupV2NyqZAMSLQh1F97z9F48OwBObKFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFMY/ds85xOOoEB/ah67D9VphN8wcvzYwGsERQQjhNs=;
 b=NM/wsdbvdP6FAR7xU8YrvZmcug01mIgZf6AevPNuPkFO8NcsEj3Ia7umNOJCqJBO49sNErzAJrfTlDcVo8NTGmTUOU9UkYhz5eOUrJAoxJriOi+tE4HMVoEfftcq+K308ECpjL8o3MJ0vpuCASGYPzsxMUbqTT7iuzf2Px0wTRikHEjJWfD6kK6aPtaA/RuYOC5KU8THEYJxM0r9tEx1KBQ03OOHzt3NA0XAfXpMTSDNWmMaxMETBs3S+Ri+vqSacrfGHVhcTWKOEXS/j+MM/C2or114mE+ZlalQjoEDpdm0r5jc6K4TIXQjcjXeKqmRzJLMP7w2Ifj1//d67Qz5sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by AS8PR03MB8101.eurprd03.prod.outlook.com (2603:10a6:20b:444::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 21 Apr
 2022 17:57:18 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd%4]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 17:57:18 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 6/8] ARM: dts: layerscape: Add SFP binding for TA 2.1 devices
Date:   Thu, 21 Apr 2022 13:56:55 -0400
Message-Id: <20220421175657.1259024-7-sean.anderson@seco.com>
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
X-MS-Office365-Filtering-Correlation-Id: e88bda90-bfec-411a-0ea4-08da23c06074
X-MS-TrafficTypeDiagnostic: AS8PR03MB8101:EE_
X-Microsoft-Antispam-PRVS: <AS8PR03MB8101133AD039B4B19B451D8596F49@AS8PR03MB8101.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SU2ty/Y0yWfA77zJbKgoXlygc6bUYcBneTyULN2ZXHFWa7nvu7ya3AtbBhF4NToCZEosPBSLE9oD0//2hKrGxyqYgTdgMoNRYzz48wCimxDrvP7gIUoshoyUFsuHVT8iEm3MrOgAC8HmpGFemtPf/NA4KGr9w1FWStRRWw/EZcO8HSTdOYCriVsP63ZUS57XuXmKDEkWOmS8am3CdXxhPSUP+2UI+q7Pn8a2mybefUV+h28xdhsH44bJ/WCrF25h40m9BLg6Bq87MSrqfx8qUFOU7ZB2fub6B9i46JPxtwqEfT/D6or3wEKade7Pt7zFBnxPMCvpHezaqT51KPSUovrwH63b+pZUB7gp2Tx5r3ogD7iU6ssQjTwTAEIj/U78ctjaglJdGGM/DKigA1FhOiYBdA6fe54dBvRUw25RVSO46OvHpHPdVkwxS/+m9ucC+Z1gszLqe8GZJpnwFiLOc8oa7LEiLlvqIOTC6cMXrQW2PrUi6fuhvKZ5zyHEDhjimNHtIl1vxXeKeAfipSgkcad2SduZrWVL/52eAAjxKf9cSi05tJhiR5ZL0Oi47MF166utAkcgghay1A+025sewTLWom2fqKFnJT368FWnJ5lsGwWpO+e1FYZgErxkwSp7fK4NrQIIt3t3KL74zESp9uBG8Bb4cGQ3eeKvcBtx0XbmDt2y4Vdn9+/abVBhoJ/rKwExPggfNbkPIwy+n6ND8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(52116002)(86362001)(6512007)(2616005)(5660300002)(44832011)(6666004)(2906002)(26005)(1076003)(107886003)(8936002)(54906003)(186003)(38100700002)(38350700002)(508600001)(36756003)(6486002)(316002)(8676002)(4326008)(66476007)(66946007)(66556008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iwt2ClzkffOguryxwklpDSqi0Pm/AaHTQLPLAnVzIBuw6Ky79w2LVPksKgTt?=
 =?us-ascii?Q?l3rHhaKa1XMHNXFgF5oQ2I38bin3m3Hsocwra3yAJmz6nTH/E3LOStM6GjQW?=
 =?us-ascii?Q?G4HOmxhPMz7AqBOvAf7S3l6B5U2tkkcPMBHYDbs4rCF4ZrCMmF+DU4sTSMn7?=
 =?us-ascii?Q?gq5KjsWHgntqjJZ+0oE/8frQgNWRmoZAJr/bBeYEqBWB6z3lRp2oTSVd+tYH?=
 =?us-ascii?Q?M4YU6IPD5NwlWZTBhafqwZ5KvQFGHJ5SLFJ/GBqAIeMyFSRZtfdTG5v9xu/v?=
 =?us-ascii?Q?qOk1WV9C81NZUTj2U4HN8SvXyrPHUGQi3db9r+Dpwzl55cRmFAPryqg2NfYV?=
 =?us-ascii?Q?a6zpPZ1pCLTbdMp+979fnJH7lmAUnX+2BXPQcpVbPfuLFIFXOQXEGmcbf7kt?=
 =?us-ascii?Q?ONW6V2HYQIlOCFpAAJGGeRHPKXVIzbFDf80gg/MmfJLWsHnbkEX6O4kK8X4w?=
 =?us-ascii?Q?1z0iM+cH4a68+Hb+OJuB1BLtN//BCYPucy8N0D4HGFzCiI2pShChPmdwUU7U?=
 =?us-ascii?Q?SqsZIhq+r2PJkDthxRdHjWWaXvr8lOZspJLchImlYKErkHbSSB7l/x2HFxg7?=
 =?us-ascii?Q?9HqG4AM5cpCOw/0U0q1wabd7hSpjdmfadj1dbO7d3tv/tHzcD0h5lo/xYh7y?=
 =?us-ascii?Q?IbW+FPJUtg6SY1Am8jeY9Rn0EZ2wgvwoxuPddIeOPrvMbrX2/kboSIeBoeyg?=
 =?us-ascii?Q?+bxeeX+Tknsp3WR3zyy4Pq82CswIQ6kGlbDd26MqPkS8cgdB6zkRzzIjBSDJ?=
 =?us-ascii?Q?BE1PqplZccnUdmUp02QhxSF3dcJY0q41MZK5NWRXWnr1+jqOvY1zEddwV95e?=
 =?us-ascii?Q?ADwYfDgjytdHdJ3Wzq79zmCzVJ09WHmyrFhBfH7rbO/fm9FxdYTUd0sGdYm3?=
 =?us-ascii?Q?JOyBnEyLsULQHwhKDKIPDyoOiVcx7oY7lYQ+Ri7tlFBnJ/CUnYhSxXOnqUSJ?=
 =?us-ascii?Q?uLmI3LG/F2Epm5wWXr0jUejXUKs5hJx3lTiefJ2kyhFffOeXK8sUwkv2IgiD?=
 =?us-ascii?Q?Vc9dRjoqy4aLIKEsz7F2J2RnuxwsNZhAVCw8ic4y0699eW+P9h8HLd+kQKac?=
 =?us-ascii?Q?88Pn80zUXwSt9MPKy7R8dztUEwRhea374uHumV/hw4w/7E9rYyZIy/xzLdcu?=
 =?us-ascii?Q?+VDx31O77HOGuA9YMBt0B9TU0D6vjaOotfA/YYU4oyvq+JlM+e2rgB95fyfN?=
 =?us-ascii?Q?JBXFGN23Sbf2W+m62Rr8RwMXMrWEsHHaRd1bD5cC0Z4oIOF/RaQhKSUBrjgu?=
 =?us-ascii?Q?MWL/YxVtO3A697crS4oLsWgYrTkEYObIUnBlGkRWoOBC4DmnlqDWgPySFynX?=
 =?us-ascii?Q?QN2Ft7VFRrYHF9Ah7Wc77Y+b/+sCyYfYomk0guBZ1TRxA9CswZO6Htz9jvMF?=
 =?us-ascii?Q?q3fPsKjfb3gvkHl7A7I1z4vlQYHbLTwbUJIEFnFqSwTxVU4VYneh3ec3koAr?=
 =?us-ascii?Q?qGnt5ox+r7RKm5iXxordOhMYraotxvb6nN9pm3O44xx2Kwl5Ux9m/kJaz7q+?=
 =?us-ascii?Q?QIJT+t63M575T10UwuKKVdcsJIJiHRsQwtS2DSc1HbJpKJHYY4U03xg4S0+c?=
 =?us-ascii?Q?fMYam3RkvwBMzFpWP/JWmo9+8Lq7wtbjQHs59nHf4FwdJ/e0XVvTQ+XrvIIR?=
 =?us-ascii?Q?/KudkgO27Fs8ekYAy4UHu7Z06iGgacDavsTk4vupMcF6MNAAVwKPv0CkjNQq?=
 =?us-ascii?Q?oDSq4EbPKxprefJRzmNvOd984dyJrEwo9IEdpRKIJC67gSEwYJI9Ntp0CjNN?=
 =?us-ascii?Q?L5L3VnMuLJxcElvWqMsYLpkM3gQkP/U=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88bda90-bfec-411a-0ea4-08da23c06074
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 17:57:18.6508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTxRNJY4cBPXr3BHigma+TN71KKI0hEuO8pBnOhqHJAhbP9nEOCjDc5jUHHxdxealKFHeLLMHJ2m4eJ2AzZyLQ==
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

This adds an appropriate SFP binding for Trust Architecture 2.1 devices.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

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

