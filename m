Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C75513B56
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350935AbiD1SVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350903AbiD1SUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:20:42 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0ABD63521;
        Thu, 28 Apr 2022 11:17:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKuB7/9ciN9//JGf7DFeygkg5kj6aDJodwYdR4NHBxi4fL9S2kAsirzjvY/YKdXZGd70pdeEQ+njo0GvP1AmNRaTfskwLuH82EZcHUqQJdbE94d2foyvyVwTxJH2aN1uD6/NCDwu9P9yh5xLcYxYiuYOkpR5NHwlYtXqWxeG8HsqyRUIAQCJrC+ymwDECZcrAUuUvtrR2QyZPoqwOaUy4CJfrbBnd1QGnoQWfkNyhb2nkGh9P3S4eJqE7pcVOHcjhJj9cRy+4RqRc+k+QgmVObERustfiUs34wBWMgjvSldDuvLiSRTBuNwg4JZvkvAw6A6kGP6vk6QY8QfJeVJx3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3yWbO1eNmobBvHk2WqT+h2o6a/lggZukvnhHN1hLFY=;
 b=aE31s/lEVT9WZyWUgwjonPQhx0weZrpJ15+wUJ6h9lZAp6bwt5dabWoQC+38BSaTUF666RCF3RnAMN4iTwtPhwSdlcLToKKla8vF+OvDIiWadmZHm0/Rfipz8YwqeQ4dZSz/6mP+SiEpvRLWXjCIVB8vfE+s8MPlbik5k7DxSNXY3wgBTWigi9qo3pPjAUXP99mVch/8FtKgSphH1hP50Xut2nyYZuLhFHPVXDd8lf2pCFFHSiGea8f7kb76cZ6mekBrfhFZGUwjoIctT5mqY3U4Xpee8fVyuYVf70s6v/N03akZxRSSQtEQk88LJsI7GZJ+0ryLbY9Z7BjePWGvYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3yWbO1eNmobBvHk2WqT+h2o6a/lggZukvnhHN1hLFY=;
 b=M1HiIvP6GWEUnF+WXhwT/WExh0V45GhP1bK+KMULnVCkar40lFnM+4aEmqJhMNg8VHf94vxLZ2nvHykcHOKP1+nGte8tbrRoijMhONoAWSzXeJ+rCp0OfFtv/7kXEOzsUWeEJYfMaohLDDi2at+w/1Tspxe8yVfAd1q9nqGgVCYQOYDEgOcV24eKLqFsTgs4Kbe9pjViZ+MuwMPuzqqmG0RywvrflEqm0iTZBLO0pkDzB3PRt31LkhzYD8f1UoK7KhCZ6WzzQdRDdlplnNZGrXdFyD2Bs2Pvs3S54Xt6Fj6CcfwVFjfOe+Q+9sogJaHhcnHBt9Qv4vTBBnXBGqd20w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by AS8PR03MB6775.eurprd03.prod.outlook.com (2603:10a6:20b:29d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Thu, 28 Apr
 2022 18:17:26 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::a9d3:8abd:3f5e:a0c]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::a9d3:8abd:3f5e:a0c%5]) with mapi id 15.20.5206.013; Thu, 28 Apr 2022
 18:17:26 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Walle <michael@walle.cc>, Andrew Lunn <andrew@lunn.ch>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 7/9] ARM: dts: Add SFP binding for TA 3.0 devices
Date:   Thu, 28 Apr 2022 14:17:01 -0400
Message-Id: <20220428181703.2194171-8-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20220428181703.2194171-1-sean.anderson@seco.com>
References: <20220428181703.2194171-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0117.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::32) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 630c15e7-095a-43aa-c129-08da2943591a
X-MS-TrafficTypeDiagnostic: AS8PR03MB6775:EE_
X-Microsoft-Antispam-PRVS: <AS8PR03MB6775A1ECEA06D843A962C18796FD9@AS8PR03MB6775.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ztFBvKYw2eRYgsheiBfLmr7Xa243U2Nh71He7VgJ/oRygk8npSLhDQIFg9PrneLnOUxRP7abzllCjUUIjug+6YOSKS3Du6vBLnpHjcEBIr0Fzgmc++Qo/ZnGlz9hGy+PmuSuZN2A8rkzzAGK/Va67P8ce7yguqJxMnImh3a2SBsr0LGhsEeoi9jgFpBKtj18USbRqJYWgqv7CixddAqS0byQ3nIEXNq2MqpJx/HLjW04VMd/p2M9mH48WcSCLL9UQaAZLJSqhd0Fja6jk43BDTgJOGXQ4AG/Yg5n6jK/8pz6Jkh3DUd5pW4h69ofJ/tf4CmkP3mht+yNRNhCCYMhhjldJZHZ4f6YntBCZVqKZFOOunr3rBrOQNM8rE67o8xDTjIpwGrdON1Qk10itMtlD+tVMnaBRIfdb6GgcT/f8u11Ayoq+V7TreEa4qYLrh+xwyxHWazqzGMeOthMX5qKMC3RloxT443fUTcP/emU7IYgcNjq/SpcYrtxio+LohkTC4LvC9tjmFUTGQwkwhXi5Mu4m6QyTug1cV49agqyWUv/+NgsqfCYTHa2xMZfovRHZ2VNvtlv+hMeyxcWgIoyfxQVhsY4CE71rh2DonJcB0LBRWTG7iPjtQjmyTChNn7Wbhtk5KbKYCjdNCh5hwYKmj1uHh85lyGHTI+7fsAWvs5DeMuXg2mbd0DswYL9cVpr8hz/UAZd05LwjftT7pfvAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(8936002)(6486002)(86362001)(6666004)(2906002)(44832011)(1076003)(38350700002)(508600001)(7416002)(83380400001)(38100700002)(316002)(66946007)(186003)(66476007)(8676002)(66556008)(4326008)(36756003)(6506007)(54906003)(2616005)(107886003)(6512007)(26005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zA3q1C1fokIjjdeFtJTZL5pmGVqZSa3IS1OTE+D4zUe7Wd1HMVdW3DYprcXO?=
 =?us-ascii?Q?0SEbPo/lmU6DIgUQOQQWc7cTWZk1wpU6pNd7Mz1rgZAWrw85kutn1u5Bq+S7?=
 =?us-ascii?Q?7pLBtcK6Pfxx4K1PI0zaIdedw/OOUnLt04GVzD3UefWDrvZ9KEYLxHiVAEz9?=
 =?us-ascii?Q?koSVOxT76GvOLPXBHBTzZvO2d3wone1R4jTlcIpVaLh1tHeV8zjZqGuzIHA5?=
 =?us-ascii?Q?O5Kl4wHbFEB+8uklsRL3u+Pw77901nnw3VIYVDzM9DF8k+kpt/lt5VfUhcea?=
 =?us-ascii?Q?vVyq3cRhTcysEf4mUga78aGOpV6/NxfAfu0h0HFVzJcpVszn3qFk+/AHJrgv?=
 =?us-ascii?Q?qDq43Ht+hD/YpLPaS32wtPVUWnJSPG32eFRWhs1R6JNYc/ZkGcLJs0gLMPR6?=
 =?us-ascii?Q?ta9a4kHFrafEf9GMaHsl4//Bykz7S0RC53J2oHrqA1ZWj2HieS6yYSfwDJ0I?=
 =?us-ascii?Q?ZPsfSb+y9vF70KluhekPIxVE5nPz38xIWR5IqG1IieFWW+z272pOf0BWjqAo?=
 =?us-ascii?Q?pbOlqfIfwuy8aaFvwqObDj5hekBLtJ3Rl5uRvTOPBE2/JIel3fDPCpSkU6kL?=
 =?us-ascii?Q?M+jCBKEaZWhmBWaYqFf947H7AHt2VyyPwtqWROVdaSTwO3pPZRvPBpO3BHgi?=
 =?us-ascii?Q?N8PeDi12eu9mTwluR4uu/G7RgVq8NM9rVc6ZCxba0PZheqFO4IWGwlcYkxig?=
 =?us-ascii?Q?7hgn47vvaMXY7mec5QLpTrP9bykKFx5tXZ2NjeBuugKu+OP6NdDvg97POQK0?=
 =?us-ascii?Q?IPVG1yD2xxb5soc2Y/GUc5YvlShhqIfE5oXf8QWZgzgLsctVui9bvGOjQggR?=
 =?us-ascii?Q?Ag9lTN6xV924zqYbES3SCc13ElpPVtsKOT62Mv0iRBWtwfSAUJIqUxa3vflf?=
 =?us-ascii?Q?WDzbzj9rtjQi972G9lpxRDGwXtrHyTrRUkjPYHUGfdBRLmMyB+vtRTualRiY?=
 =?us-ascii?Q?pRRd3X6guciaRkuV5NajbPEtW2QV/ZGXRRDylTTHY9tyNHJ/2IvakC+kIm0/?=
 =?us-ascii?Q?IV1apYN3YMauVoH4iXnIkIUT8g1P09WNzP08MjqwbOwrtN1ShDKNR/Nq6QXJ?=
 =?us-ascii?Q?rQ66wS96bPn2mybxolItnDwjP1UvelMesGKcyziHMGY9vnNbrKmYUuLaGoUn?=
 =?us-ascii?Q?xJCt7zEOcJdVQgZVYKtKEO7yPXtCmSbu575pHRe7W7gVMhhtl/E485rFkiH6?=
 =?us-ascii?Q?VrsMraKjEB1zrddX/8x0TzAUgbxCHZqD7YJ8niZaLrWQEhEcVEMJqH4CO5Ur?=
 =?us-ascii?Q?UQoyeqQsU+FEj9+HLQlGs0Nf/6L4xxn3WUgT2GMtj5UrEMI8o3SdETNXW4iW?=
 =?us-ascii?Q?MMGD46nJtKotcZEvI6nKM7b6YVjbxIWy/V+084AgzbgT+zN3DtszmfdWaJXY?=
 =?us-ascii?Q?wSNkUpAQH3pEbBMH0yb92uG/PARnX4ENpuUH5avOY4CDzowIPXC84BKxqXJM?=
 =?us-ascii?Q?zMI+gQdGM7HzjBBVanTsJXUV6sp2M1a5ddkqvf6zSNA6A6bI2OxUSaaOTjim?=
 =?us-ascii?Q?d1+gR8zjXPsTl0aFCDyNcfIZYcq3A9eJhQ60FBnU+Rbi5HE8X//2KGNExeC6?=
 =?us-ascii?Q?Jp6M6XtIXdp4flYufyd2dUvP/A5mLrUAmsdq9JChPaiP2o4RJV3OpaIqF960?=
 =?us-ascii?Q?7s+DqHEO4N8WNA+9ro1rsW9Wm3CCK3tHngvVE97ItwNrIwGWNRkx4q2FEHkf?=
 =?us-ascii?Q?vnfglN+60nSO3GSzrWFPvWaLkW+UZ/IORhwg5bZrR6lpdhFwcDSyAzugYanH?=
 =?us-ascii?Q?5ORcs1oK9WBA16tR96M65UVMWKJhNW0=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 630c15e7-095a-43aa-c129-08da2943591a
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 18:17:26.2069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MfBZ5g50lxCu/gGK+ONKk3j1vJ+kprFCe26IT+ZeNxKLhJy6iFaSnEG75dw3vV49t3oNziqJwwcDjRTNE/hx1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6775
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

(no changes since v1)

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

