Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739D1513B66
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344978AbiD1SVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350887AbiD1SUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:20:41 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C1C6831F;
        Thu, 28 Apr 2022 11:17:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gj0RO8GTbW78MNsvyAsPfnLGN+jCYXcZhqVRB5b/oxXzvRwkq7+2kt6/wIDa7JS0D6slQecLVm2oI1rzEwmGemocP4oDa0i+FdNIhZjVUTDCEld0n9OByrATo8ngrcuDybMBP/DqoA+/SzkZi2eRXJ2S9jP+rbh+3UkngPYv3qxecYKE0z2xDfMNL2nNDUd9Y6L4SFKKghuAf3uytIfifUtTv372kv0/MuSf1M03Liez49UTj8j2AABeSiYY0U7ckTG8Ut2JxMDIEVYWEdrqvFxNf3AgsWoPRjGDz95HI/qROIhFs4CwnegdiB6yMLvdfj2iL8yvWOQAqJ9lZfuhUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/G4FbVJy1vmb58t9jLsF4M1WH+VulB0OMt29R0ndkc=;
 b=MIjwE+rIjzMN6nNEM8u8hn9H+kgKO+IjD4Ql4AXe0XNJqcFwF3s8f5FMj1R/VIwW8QLb9aKd/CTuRCrhcv3zRuSX0Qpjzxd0RK+kN4GfNgGhOhH8mGTEWeTaeXwfxQUiHiU0Ar/hO/3qeP37R1Kfcz4HMTBzolicCRv+Vjtw+OPh2syXzNjVmC4WlVtVpANoau/4wLuzruTSRBxYVR5BWXbKISku63Rjsos3Fj6YdI5RsNS36yg7qQPfwebiYc/hAtJb2pO4o5tNYspuThCP/CjnFRUtCYuuuVAEyRZfkWw7NWXHL3iTJAuJWpiUB6ZZysJjRijFIDSLM5Zpd/Bvag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/G4FbVJy1vmb58t9jLsF4M1WH+VulB0OMt29R0ndkc=;
 b=r64pHFnUCZWGRgrYzQ9eKRl4xf1gKES2Hlyglta14VSnD692EbnV/OnEDwKXxE/LntIUo393JsHblN4q5YopQP2a8G4Ca3/bhpzZhN/fOmwq0nvjPZO0qfItCK+wmH1AucGyn0nRcH7ygjDD9E7Xd4DRxabxzizqFZn0VNHctXB7dpA5jN/3DrH7jB9SUfxtOM2xEgOTlBPvZGqz74kcPRKLqEBmJJca5Ed5WXk3+67M2k+fiN4Fl4n2rVjpIHBnZIqGWUhtOsi/lv22gv1bxfc07WSOORQ5qpLZQPexVmCUwViejUqc+0aNlLtzknukcbP0sPs0flmgUuZg8ckkOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by AS8PR03MB6775.eurprd03.prod.outlook.com (2603:10a6:20b:29d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Thu, 28 Apr
 2022 18:17:24 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::a9d3:8abd:3f5e:a0c]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::a9d3:8abd:3f5e:a0c%5]) with mapi id 15.20.5206.013; Thu, 28 Apr 2022
 18:17:24 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Walle <michael@walle.cc>, Andrew Lunn <andrew@lunn.ch>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 6/9] ARM: dts: layerscape: Add SFP binding for TA 2.1 devices
Date:   Thu, 28 Apr 2022 14:17:00 -0400
Message-Id: <20220428181703.2194171-7-sean.anderson@seco.com>
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
X-MS-Office365-Filtering-Correlation-Id: d3944ff9-a2e7-48b2-479d-08da29435819
X-MS-TrafficTypeDiagnostic: AS8PR03MB6775:EE_
X-Microsoft-Antispam-PRVS: <AS8PR03MB67751759FA88D6BFCF577C8F96FD9@AS8PR03MB6775.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C293wkdUwS+tPFggnThHaDa8p/uETbpJ8v4j3gb9R58qrsAIHoNl/g7HYmpFFo/xd0TOhfsYrMzNw/cjzERjwBW7MH/Pk2Yj3J4VKmnQoabkwMdru5QhpEfzjW6byBl08fTu4iLlgxGO+8fk49lLT/sITtJYB+8B6gZpoQJmXiMgFgl9I2vSnBT7szi5Kr9ec081GndYfIOMr9DaoSyroSXn7C9ACIxCNlON+Gq6n621kPZ9oDuvpTUegreuzPI6ts4lVNjpjfbiuySy9vLzkr5giemyVN+ELsfm6ldkpVXaCFfnUQxH5Pxxs9nMGwrjzW4n4NIdekr64i61sisvpTsPrI8voykgcFXCJ/omOLyONcXj63CDiJpYwO5m0qEAeuQ90ORRu6AYmV00KO4wkjHvuh9HboYKucIPtKtD3BClyDBhatqF4smqtub2MeddO/FKSb5hIfbzox9thMpov/Y1TrvrgSAZQvYvNTlzSxb3JCjG97Y4IoHD9TASU2KaBNH+YmAo9ZtNg7uz5UfkPgymNChuZM7NNpRz/VtYhhdMnaVV/52cGMpA9AOBaTYy9K17+JjEfmGcfhx6vp/lzhrlDr5fuRV7TFXGikyMkF5msYyqBUyCSKReFtIL11HPpJIAPz64UHfZVh3oOw52XM9TuU26ABwLAzJEUTQ9k3I6t8NCMLNAyrSpMDcUSIiBTIyF5atnW6a3e2tJwhAung==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(8936002)(6486002)(86362001)(6666004)(2906002)(44832011)(1076003)(38350700002)(508600001)(7416002)(83380400001)(38100700002)(316002)(66946007)(186003)(66476007)(8676002)(66556008)(4326008)(36756003)(6506007)(54906003)(2616005)(107886003)(6512007)(26005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bfHAmhl6G8UZdun4JL3ysP0zBsgupDNtMccay5ZYdZyAMWz5bQ8klBpFu0yq?=
 =?us-ascii?Q?K3zv/yl2mplhs05IPCLXkNTikOzGJX9rVR53m5XM9wlaP2B3fzrAe4rMCSoO?=
 =?us-ascii?Q?UmDrA/VaHpfM8nFDeVGIng90pxJTgfrMQ2jaT8NlAmpiQJlj5+xT+GL3c8pE?=
 =?us-ascii?Q?Ymp8oakXEHVPBdCbOUvNzPUqAdGRElDjp3Zhpwo4VWyURPSA7sPEIrQT68To?=
 =?us-ascii?Q?iWuIu7aaHpUSB2G3I+qymjGiD7BWjGnXkun18mCq66IUWCzS4pUpyQVOX2iv?=
 =?us-ascii?Q?eydQdNwhBv4+OzsmWmO9ZyFjNN3+9vP9F8pRTdP3rm8TUdL83FZZQumDFk/U?=
 =?us-ascii?Q?TELD+yNA82UKsMv1+htvg/OLn8LOGNSVYV57+clCevBnrC+tiwwYJs2tP/TB?=
 =?us-ascii?Q?pF01u4iEizcdwmhecx0N28bZ1XxQUIvOlqbnnOfMZL3D3tr5SMWLijW8A+n8?=
 =?us-ascii?Q?k4ehQCOS9GDG4JICQB1ep8hgOf/FIqhSEgYa1qwJHabPIhajAp6WmD4jb0Wn?=
 =?us-ascii?Q?oEE7jR/bR1iRPSIY/kWN2VvLWFweM8mKWZNuvki45/W1Mu7L52+JOKBCsJMH?=
 =?us-ascii?Q?7aux0z2k/32jrQ0ZIeqI+vPOPzFAKs984I39RbNRDk+KKkIL8nUTEZKU+IM6?=
 =?us-ascii?Q?rU0fBqFXGL8PisPodfx8rzFkJbTY23aZZ0A3zwtKr4uRq1OYHCk9NTsBRs4+?=
 =?us-ascii?Q?uEcz6aKDZzxrgeV1xzs9Lxb+8QmVwIvWdGBC60gRqMumxjqUNzDw23qaM5g2?=
 =?us-ascii?Q?ApmoBMlEkCh347Dh2QSEDUDRyQcQZMUoTYnpTEK6KmK2iC67MlF1pmrCTBTU?=
 =?us-ascii?Q?/4SCGuNRmXLnMySFAhaTGoEv3u95O7K8QVdlGcI+A62Ns2paag7LGz/WZX9i?=
 =?us-ascii?Q?EUFDioTqoFZlfG3M3DSSgtlEYtF7eOg8Zxc9DgtvH7tkyiYv07j8kFXwMQhn?=
 =?us-ascii?Q?iERnyboY/Wf829Zb1NIwUioy+qw+R2XIf435zKDq7drrMiyws2Dcxy0fqC24?=
 =?us-ascii?Q?ptD/pbA94brjWwfAo9wAI1u5+JZG6ym/L0kAT/lK0/nMp6HctVQLmlYpoTNz?=
 =?us-ascii?Q?Dwn18/+Ip4rGk14S2CdXejIK11N5nmy7K7skRoUQmKSlecBqGevsMsq0ruNb?=
 =?us-ascii?Q?JPmVc6TIcGs9WRUPJVygp3HLTVwQ8NzmjTpMD0d+tBB8h3lrCGuZicOHypHT?=
 =?us-ascii?Q?Z0ODmui5W9gTsT6XsFiPxNn4Po1uaKzNDMCAhsjese4/uzd9DkEYHi6lpXj6?=
 =?us-ascii?Q?FI5EyZRh9NzRpEbDjsfz0FI7Hdh7jT7KnP5HNShtAD/D8ZHcUrCb6MK39BZO?=
 =?us-ascii?Q?Ji9T5FkiQ2+6m5O8FpNtSx+UnuSKinLIAgsBhPx+gCmzjYMMI3rvIdrPb4lE?=
 =?us-ascii?Q?ShaOuj87pvsfa3jtFW3oP4nAtR70Tfm9ef5kOBtwjs9i/mp6hVhQKfly5GYq?=
 =?us-ascii?Q?1+3YIBGKceRFXEfG9H5xO7CeD3rBoyYoO0cpPK/oGUBycmWICilpzIvTSeQM?=
 =?us-ascii?Q?Me4EC4cceS4FovtY5d/iuFmSyS4sZqNw8yQo8bJ/HgsIPs/zs0zJCk8Kqenm?=
 =?us-ascii?Q?kjNNSk/P4Or+qxGjqpvaN+mR0a98/Wd05hdUhH7tpp03O1LW50qXBRcQ4TeZ?=
 =?us-ascii?Q?AFpcHCQ8HRXsswta4/FMKPueVUF3fdb3eva2mEHEJ092CQ/dhEZijz1bxz8p?=
 =?us-ascii?Q?+q3FwTWZxp7FFKQgOFcKgbq+AvHQRL8XwiVsAxD8tAJ5awuLhuAKMv1e3xJY?=
 =?us-ascii?Q?yIQpSM3DBMqsRYqveM238aH4XVuAp2E=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3944ff9-a2e7-48b2-479d-08da29435819
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 18:17:24.5664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JxtfJ+A+IKsFVRP3vE9M1tAPkbljp/bCAdOrvreIxYbiuDgqBSg5wYTvRsGipk3kAXx2Zxz8J71Lpqomq2X06A==
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

