Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F58056261D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 00:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiF3Wch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 18:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbiF3Wcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 18:32:32 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10048.outbound.protection.outlook.com [40.107.1.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D5057231;
        Thu, 30 Jun 2022 15:32:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHFJ72AxT0b2rrbA1dsiRiRpCnQv1lha6O67H1PuvxzQyEIL1R/HmhbnnGCU+KERqR6ylcP7bn9QzbjQgdCjX8Bcx5ZeR0jcw7M604ycmvn7vVj/y3avqGSkrbUjsUzoKfIYedT0P2Nq+SgZBc27caNh5lLZebMwJIoMtkzfM0K46VTIdU8cf9bDr06cxjf6em+duzH7c/pTPXyNQGDu50ct4XPs7lAvNymP6NJx8YF9uCka9ePvBPFq1H9Ve9E52i1GpXK69pFK9BSVIyT8KtbkUJJj6ij/D3aoFj4kcFOCxjRx+0wfRev+6N5iZkLdzH5mhuMgNSl5otdEvqa/UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahq4Q8hnypAnE9yw+WEScHVZsnpByAODk4LUBGBst6g=;
 b=oTdUC+t93nyLi7OPfFLt+A6vNruq27mbhJHp+tYokTvhYVRh0GPpP11a/ilM1NPM0ioGzSwYs98qXakKpdGxKMTjCZu5x+/8w7y8S9J5+WhFB//iBm1TAdqTeXfVw+xSaZj5kqsNis+9wollBBbwe6haL3LSVPuRVeE7rBZqJgabymvYjztzwuSEHiN6EQQaLBBIlcOZR1F2O+9ukuGtmxLF0q7jtR838cROStcp+ZhoHL6+5tP6+6CtBfxoe2o42CrXnzGM1dVHIs7KiDhGXqpHX8YETUjYVT5J9yd3r+bweikUaFdqh6X9hQW95aJzSKCR7sJNjkoEu7YKRy0vdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahq4Q8hnypAnE9yw+WEScHVZsnpByAODk4LUBGBst6g=;
 b=vMzXLUyJGTbGjn5fTde+QIaJf/Zbcii9ro85M5cl1TO7LhIFZYSOtBsjla/HQjAw+qg3iK245gJTAMLe0ZbgQaipg0CwResTMMVlGabJ/N3linYP1nv98GfkQ0dTvIgA67NBFw2GX8GKjgKV+ojb7VTtQwFvTvk3bpNfMfQtEffAUWuknLMEfS31smjrntVPVV6yS7ETP7gpC4idsIe91xfywAlYRR+J/4Yyb7/WfJ9OUBYUTXvsTCJ0KwFEss2tg38iNzXYpwxW9D8P+rcwEJ9ax1ad6qMKy7h8Wn9y1DLYkig6sNXIQ7UyxLhBI+vgnsNcdHNvLqNEVZgRftgXlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by DB8PR03MB5884.eurprd03.prod.outlook.com (2603:10a6:10:e3::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 22:32:28 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::757e:b75f:3449:45b1]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::757e:b75f:3449:45b1%6]) with mapi id 15.20.5395.015; Thu, 30 Jun 2022
 22:32:28 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v4 1/4] arm64: dts: ls1028a: Update SFP binding to include clock
Date:   Thu, 30 Jun 2022 18:32:04 -0400
Message-Id: <20220630223207.1687329-2-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20220630223207.1687329-1-sean.anderson@seco.com>
References: <20220630223207.1687329-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::24) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14aee598-a3ac-4dd8-6cd0-08da5ae869b5
X-MS-TrafficTypeDiagnostic: DB8PR03MB5884:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o5pW/sTStcOpv4sXPb3zfm4t+mj2D7TeBEriSV4vtQpAHbc9tDtg1Vety/5KCi3U6SBcLorH70ep6ck1ug/i4+W/ctysEceZZZoH/aR+DvrmCcmyucLdWvKHEx3tQB/MO7bg0nU6u2r8kHRSSa8ehkbav6O40aQ7kgAX4wygC9aKRkOOF1p/Pus8s07b5E80T+zZyfH3Qx+4oM7hi3QziOobbXkX/rFiZeZGRIFWApAAXpfqMc3ncv6WhOefS5PBX9whZKo/0+3aJwH1WTiKVb2GE7yAOT601z5yFTFuI9+WQedWiru3CYtq2DENwV9VNdNDB2jKCh+NbBD1K2sb4tOULyUlCK1yO3CgJCm7ZbT0FAC5PGLfm10So/iPrDQF9rl6Y7/2pDgdYxSIchx3+xExkEyc6cxMjgb19EkpYIkYVqZWU5/cPDEYTj69WUHn+Fp2Xirf0n6icTCMhjDb5zG2iTIwREfG579k72WzL+I6Hvvv/IDzaCSVB5CPH5COReGBexsi4eD7o5WXGCaaQW3YohWazX2hb1IpdfZS1ClmrtdDV2Lcia5Ls3qaxImPuUHl0xhOr0nYzLbsodE2QWogrJEcf7tfVWMyNYzl3fQYoAWsPiixlEW48ns1PNfxZgHqpuVPMG6lopyckokghUiDr4UvWrNNw9yJ0S+ey1iQVyxy0EXBRzT6lTsMkZUPhLCAn7LGh6Urmd4chMIk+jojy8aJcf/PouyQ8mQS8PnGL8sIrS0nWG8jxrvf8Qvt7mY9J0AtrVOIt4MQXb2mId8BEFCbvkaQ2QIP6yZOlxS4iz4cvW8f8R74onnOYFFP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39850400004)(136003)(366004)(376002)(396003)(346002)(107886003)(38100700002)(66476007)(52116002)(316002)(86362001)(1076003)(8676002)(6666004)(4326008)(6506007)(26005)(5660300002)(6486002)(38350700002)(66556008)(44832011)(478600001)(4744005)(66946007)(2616005)(2906002)(41300700001)(36756003)(54906003)(8936002)(186003)(83380400001)(6512007)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a60VGS0x8SLR7BJvoGwkXbH8n9lAjFTpFndhEwN9T81fB1v5wuFS7R3WrD8e?=
 =?us-ascii?Q?dpC+e6LOX7U0CnuljN4ZEz5olFwH461Fp70ZkDxF/2PRER04+r3pTZriXk+Y?=
 =?us-ascii?Q?aEIZWXuMS9ALhCLVMNGxS5voZdtEsuOnuenLvb14NKRN3HNNx/+VniFqoZ2a?=
 =?us-ascii?Q?XK2JeXfJtZBq4YWdB8xAEK8bCzNDfyRtLAcAwjJd9+DiZrKluEyHXOp1wMeF?=
 =?us-ascii?Q?cBSvUOxDcjUirGpsluMX0hdYkEP3LKGaKludg6OYQxJ65ZL9XrFvI3MyF4xn?=
 =?us-ascii?Q?dYZsdaXpnNo8HY2JQZvv/L6l3Ef3aXLE6T6tHW4ILw9j6LN+wZ/sjrnAu0Su?=
 =?us-ascii?Q?g3i3YxPxu+xdzVI92AbYPUtkkW7q+vkobmRiZ00YmagXuteK0H4X+6cFM6fg?=
 =?us-ascii?Q?uxeDz2XuI082nr5Tg40P0c5pH15kI1AJSBgr8TH8NR71mOpkywFIgi2xAt8Q?=
 =?us-ascii?Q?Y/p6iItLGxI05BCQPcGrOq5YrbCiiFvY96+jURJhpkUq01IEDb9/twp5nIVt?=
 =?us-ascii?Q?D+k2NGn5BhYalFerXE9thruWObjLV++Gq7mNNkj90LQuq1ViPefvMykzfpB1?=
 =?us-ascii?Q?l5uetd6T5Z5orGaGMQ1g2RYSei5Od4O2QJnrdFFlBnt6sCO3+x+DeyJGtsP/?=
 =?us-ascii?Q?hPNqerp3azi7LvFk3kEscW0BdBBGumk7ZiRVmiO9hAma2giCkDO1/aM7beAq?=
 =?us-ascii?Q?is2V6mQ8tldfrCuj9aeDCnUT6bvhnNPi89U5E0rqVDrNmYmT0MPb7Cz4MDxr?=
 =?us-ascii?Q?57Sr/QFSBAehVPXOS59mQwV3ogRmwshkUpWJFKkVc15DkWEUmD7zZv4X4KI7?=
 =?us-ascii?Q?Xrj+nwXHxByVsmlyGFEs0bU8I+B57TmNevhTsyJCESwkdJdAYMDuSrbRI2rE?=
 =?us-ascii?Q?C/KECaOe8xiO3T14rZdiyjbzJnQRaeR4zygSYu6yqBJx/4Wj2q6l1e6fARXU?=
 =?us-ascii?Q?axrH6EKReB2waPWMLynHgSsG6TFTur5pEqbPc7E+qdLCZlVXxlPDkvHh8roK?=
 =?us-ascii?Q?S7v3XxvRTW8nMaDsrCfwG77aNsC8KuambuRwuOoPOD83gnpC2RMPyRdT5Upe?=
 =?us-ascii?Q?ZIW3m24TjTvP311Om2X9CQl5mXfvTeq/aWE0VKiy49DZvGU5Bd6cmrBoPM92?=
 =?us-ascii?Q?AG+eGTIuEM91t9umI9ZJ227KZ9+pHiBB67AVBglpgAJ0+0jU3GZT8zb6tvVW?=
 =?us-ascii?Q?JUA8+IIvY7MfnCuHSvfRHjePFuJeTaSauLet3ym8qoA4Zp73zv90rcz/iJ5A?=
 =?us-ascii?Q?BMRG/w1oeuA3mUpmlQcTX5OUAClyD2bt7mhFbDiu3ufWE+XHzHWYChN4U5Pj?=
 =?us-ascii?Q?8geZ7AnVPc2p1xEBNRDt4MBPdxGKnaQg9HozFrepyMsAMWiStdLCkKJ8wY1L?=
 =?us-ascii?Q?ZTieH8AF0Dsoijh1OJFYOfTZqero05HHF7/zvuonQBQTtgy7/TnBB4QwTyJp?=
 =?us-ascii?Q?JyRsFTyB5TRoJTwNNEcncl8V1m6y6fzso+Ybfp8J/vhSuyNjmmgwUxypMzcJ?=
 =?us-ascii?Q?i58xS5YOjd3x/VEqgFngWCIjA7ILjh1ElvvuKZCsCbxoKLNEolRqFEga4T4c?=
 =?us-ascii?Q?Kjp7FLdwxPcARWnwbN6LumFwrc0Xv6d9cDhdmdpLqzY6PMgUbHQPjcMI4qkj?=
 =?us-ascii?Q?cA=3D=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14aee598-a3ac-4dd8-6cd0-08da5ae869b5
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 22:32:28.1256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3D3Yj0Zr4SqM83Ozqni6vxnOkEvYPPvUVSyPdAWz1Nsk/vq8KymapDqtt7qi7OIWXWA5sWo1twAs2J0+HTT5vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB5884
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clocks property is now mandatory. Add it.

Fixes: eba5bea8f37f ("arm64: dts: ls1028a: add efuse node")
Signed-off-by: Sean Anderson <sean.anderson@seco.com>
Reviewed-by: Michael Walle <michael@walle.cc>
---

(no changes since v1)

 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 92465f777603..d5cdd77e5a95 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -224,9 +224,12 @@ rst: syscon@1e60000 {
 			little-endian;
 		};
 
-		efuse@1e80000 {
+		sfp: efuse@1e80000 {
 			compatible = "fsl,ls1028a-sfp";
 			reg = <0x0 0x1e80000 0x0 0x10000>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
+			clock-names = "sfp";
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-- 
2.35.1.1320.gc452695387.dirty

