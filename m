Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84A45A7FBA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiHaONs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbiHaONW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:13:22 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD86D7D12;
        Wed, 31 Aug 2022 07:13:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMUiZHNLcR+d3iztO/LyNZEgutMKzk8SmSvSzeKMxva8m6SURLnLNxqmMSugBVSrO7UwGMQ63WojHALK+VSDgo6lvTILPgKhlE4XO3XbY7S+CnRx0jyhUMLoG+Vyt4KNhW/ctNwGyUcPgqGQMkdh+ItscFQlvm7gYlMPKV9lxS2Kpms42EpPy3FJKbuhqx3PkPYA1aEL8/ptucIAx19+ysNs76jyGDp/VpLcXqN60qKVFAFZKlTYWzBoxzvh6Hi596Pw372sEj0oY9QXRQk/e131g669uyRMbq7Hu/Og49pX9zemARCei3mMWFqc3pXP0gMZqpUE7lu54ZviSfX0hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OubfWbUuNpJVynbWNmE4fImUxV7pdGQhem0qikWI9E=;
 b=lQP4zuY19LPBFSoBBgpSW9fDQLauaftBimm1XuwJqcklF8RaAsZAn7AWyERt92GcsYZJ9vW98IOoSddsgA5c6r5p1vP4m2ujfFQ0V93ugSr6HRQcWBa36CpyX3moXyZ4BOHtzWZNfxv+rEueXaLCeIhZq7vhEkK2ktX/+449jcG+iqLoxyBEukxHlTKUVz2VLwquqms6RIEeQgjvINXBOdyidE70jAzZBEfxR8TNLDnlKZ7Ojhl129FSl2r2sAG0aSdyTMmvaeJNw7F3u15F9k6SA8TA6GguIpEQlO5ZP9QJloWJkF8TahlNcKhcw8JCAaUilF4rrETwwUer803XVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OubfWbUuNpJVynbWNmE4fImUxV7pdGQhem0qikWI9E=;
 b=FpH36MhVy66+r7O1NmyD0jv4iAe/InEZLggsYikq3LXzlj/jVPdqX2oNJnmrt9Yd55O8zO7bIHCcnhxBcnEvwxWq0lkv6tQn9HOWMAj8juM0tM2w2+sB35TU7ND8VUAVL/nhnKH/E6PGOOcS6jRddjir9ybVGI1/wkmCHbDwY78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7355.eurprd04.prod.outlook.com (2603:10a6:102:8f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 14:13:07 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 14:13:07 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH V3 6/8] arm64: dts: imx93: add a55 pmu
Date:   Wed, 31 Aug 2022 22:14:16 +0800
Message-Id: <20220831141418.38532-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220831141418.38532-1-peng.fan@oss.nxp.com>
References: <20220831141418.38532-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::22)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b47f9a78-94a7-407c-32ca-08da8b5aecfb
X-MS-TrafficTypeDiagnostic: PR3PR04MB7355:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u10+a5DR3f94MAivmz2fgGwOK31Yt7bBhL3qVh4IMOemAiCyxADVGYCwVc/VQPhfQK5FQETA5XZv/v5witS1qrcq5GpXe0nTQU3Z8760eQs5qwc7wyCWblpNzlzoXfRihGeZPyoc4lA6Dj1bzMB3v784mIsXsBqLBhM85tXquUMkQhWvWgA6+vaUyAKAmX3YdH7SoeB0p1oy+NF9PRtcfxHOiOGvtGyot3zvwQsBdZtxGB1lRIMIYMs1RjxVrm8yXATokwKSJnkGYqUq02cShjcYsjxBGG7paNtg3PPQ3yJ2C72BPsoeTVVG+rfmscdD+BjqU4Pw/CP/BqIRgzfKRQjyVuRT4IUpp4PEjWRRXyzvrBrd9FKKazPsXtWHRlS0jL6StW4i78rL1lPV7wTQyoryqmCnQqrCnTz5zZalZ2Abe6CMXT4/vGhFLNOuTsU5lTK9agtfWG1dmz3h3him4nuWschQ2q68hzZQ7rM3RXqv4eAdFTu69SzMcGzJziCovOf3zVQqVvdJtgr1KM0UhOcIPly/1ytwoglpfe9KLhZyk1iPMFBfJsVFLBCPhSZRLRXezxfCt9oJrpf037FRonhKGUdkS8aB83+UUcZtlOU+TD7SpmSnBVdRD5MYloaENLuNqktoIEg7gJldpR9hz4m+yQgwqpIL4ZlW+0QKgmTw9Z2rdUBEMSlN/CEjp0ME77PdrPKBRsMI2RYoeKewHSur1Oz3+NPJlEcQYEUIuKiOtFmrenwnVlTCnnPZGzvWaOXsqjzOZmOOLPCoOo1Esg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(8676002)(4744005)(4326008)(66476007)(66556008)(186003)(1076003)(2616005)(5660300002)(6506007)(52116002)(316002)(41300700001)(38100700002)(66946007)(26005)(6512007)(6666004)(86362001)(6486002)(478600001)(2906002)(54906003)(38350700002)(8936002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cpib1Rj47uPnDSlT3ClrSON/YyvoN7gD2kbPLgczWP8rtAoUfW/eDrcA60I9?=
 =?us-ascii?Q?9Ro5SHon5lV4yAzKo/Wk8iPEsQXosttzkjJnolDephkjS3nvefGDRNhzK35Y?=
 =?us-ascii?Q?RTFzfM5/UfH7E/Ixv2uUOD533Bj05sLMN0YU4SImtWZDaR7DcXiJssQnDYMU?=
 =?us-ascii?Q?ryGuKiMmQKBzqxIO5qgWfNxIvbY46oKNcUFhNeMetQpFuHqinC3bqKNSWnlq?=
 =?us-ascii?Q?oik1/KbbqirwVr/77/JDmzVysk412y8LQHKMoSmAsi4hSE8Ew6eVCOc4FqFv?=
 =?us-ascii?Q?js0zvIGiw31s1Ws2hhNTIdej/ti3U9Q15aC1Ur+vpyQyh4rzEc6/42cMdzL8?=
 =?us-ascii?Q?uGip9z6JQ+xU0I5i+qbTo8vF9ppjXjipRjwPDFX9qHTjE0zR4+k24oiT/PDk?=
 =?us-ascii?Q?b8znThxqIRMHVOqw8KoycxavNkNZXIAAhxSOcmSLQn/1kQT8CuiBf2hqPIrt?=
 =?us-ascii?Q?fmKac/DyGhMrjClMhcR/CqJ1qEFafzhJxH71qHXAZI88mT4S+cp7NcFX3lRe?=
 =?us-ascii?Q?bGgupOswTIGRHnxfwiILN7Xv3111ZX7lR+oXyKQfg20oxlNG41u+RrvZVCAi?=
 =?us-ascii?Q?Ot6YKYrsLd6mJaEZFIwwmC6BIeRNCzxGPEwTd1aZo0Ohs90b+ZdGDm/uTVBy?=
 =?us-ascii?Q?ojfehMEIBigMKdt0/ZXCWF+0J3DdmM3wDO23hbu/c3yE4gVZVd8J8JIOfvIW?=
 =?us-ascii?Q?DXN3lfGbB1Ka4EdPvXRG6RGaQgMUCVRasJPTCV3ijEiPuAYjhuHNkD3XnLjb?=
 =?us-ascii?Q?taH0CvMR8pjJV2egRMz7q67EngSQYgowvDrXo5hXoIWzFHMRvxE7GQFirOqW?=
 =?us-ascii?Q?MqQ0lwNOB65o/6s8mE1R19RAoxbTTgouFUvlVdFYmQudVb2Tj/VJ9ez86OEs?=
 =?us-ascii?Q?/S8D/rY+heGnFuC9EpLRurRl7xX0Fsi0az6lYEWSq1i2NJMEWGKo1lhj6HZz?=
 =?us-ascii?Q?N9rwE3SE7ql+a+EPXKiaAxeS2QHPv5jCCZh8j5msHcNFQBJ7YjLrtUr1vdt4?=
 =?us-ascii?Q?CeopSvPU+FSOZcPzPJqABhG2HFkjNRPAkK3oHU6CEPLSNe4iwQlSEELsdPRP?=
 =?us-ascii?Q?QHoLskNG9Cw6ankHgRXIB5EjctZcXHMQ2k2bUJa98Uw3x84Vn1K1fMr2Udj7?=
 =?us-ascii?Q?tBiFYig7jCcLfFGfun5iHl9/MWFUnjyryN9nZTf+G5qEeMJXIThseS4Sjtcr?=
 =?us-ascii?Q?4Bv1BnaaQdjWwb+P2AlFATJ/PHKZvoTO4J8wPhPPTY6TwUFA5/fq3JNqIZnZ?=
 =?us-ascii?Q?swOIOl0n2sjLjsBIpkwiymGSsj9cHhYpoVEGfoJcnpweCEc5BVlc73584Tv2?=
 =?us-ascii?Q?LnwTrfj20br1N79xAXIfgP414Kw21jZX45Ujo4oc6DGdDFV0byTQAnEjZKKq?=
 =?us-ascii?Q?k32oqsWGZpqswJMDMRKi2gWcTNYYPgIfn1smu+XryePtWbHlkW9N+e3DDAJV?=
 =?us-ascii?Q?TbLRPDBVL+XXp5jwdnjAnHPx7FfXc/72QMQiaDLHPB5NL9nalmZ/c1Ki2oCq?=
 =?us-ascii?Q?kLgHZKIOYZ+nDSijZM5DNSif6xyyLJPCpdqmYqRIDDmZKB22G1KzdFnkZ1Y0?=
 =?us-ascii?Q?I92ASjZ1ZGyJGrIEZRuSSCwIcHYEDdBUZsYygyln?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b47f9a78-94a7-407c-32ca-08da8b5aecfb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 14:13:06.8842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y9BlJpoqcEVBdYP9zbXmhGTXcYB123RGX0zE4yAr8PfirpfqY0H+Ibop2Vr6BEhtodsN5RX5m02BI16lJFv0zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7355
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add A55 PMU node for perf usage

Reviewed-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 47f98c634365..f007314d8f1e 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -72,6 +72,11 @@ clk_ext1: clock-ext1 {
 		clock-output-names = "clk_ext1";
 	};
 
+	pmu {
+		compatible = "arm,cortex-a55-pmu";
+		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
-- 
2.37.1

