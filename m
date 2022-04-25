Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18EE50E1FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbiDYNib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiDYNiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:38:23 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20069.outbound.protection.outlook.com [40.107.2.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FF4AE6D;
        Mon, 25 Apr 2022 06:35:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/2QbM/ZaY+ehJHpycwktQ9gIB4F6Syo+iN0Z5Zf9bAmnn6tSvDl0ToM4wQoSqVJJ4XdyZPQTtvJIPL4WHMMclo8k3xUDXfYfEM9Zh6Kjqzr/cYTvwWg+zH0C+aSrbWh/xZrJvzjFF6lrWRekzsDOwzKQlcukrFc18j70xH89fTjzE7ZZNGC11N7xY1gaQq/dj2HTWLnyhh1ZoGiNXVBl296MHUKEzhdDQTlROR8oM0BuA1VYB5PhF0F3plP7z+ZKKOrjWNbuX5PBlTuK74JxYFJuz1B2vbsuoLRw5BGv5xzPzCF5Fur4Ac+OwbaHPWJfAFY5okty2JKPXrDsCuLaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ha7HXl1DpJKi8/Shq6VVkl2fVMjGimdoLaSKMmHwE6Q=;
 b=gzNx4h9PcDwrG1/ZK1KxRUxAYed0DhisyG8SZmwndCGS70z0pmrptqXNojzGRIzzVU8fnmJ/PYrrOjx0lJDXinsPieiL3ng8bt8U1yGCyCdsAdH4hkMDeEVUMerqV1eTzJaBNfhDyHYC0goNDxEiH/4SiUDuGfFBoW+JNU6Jcg/3aOx7Sedco+c0LlIueFQQveAVsMXH1svUoEHh4jXhwH7IR3R5+/CxJhlGQ5NecDLYqiJRVGgfttPnXj1qpykfuPO8OMefAKV1GTSFqsgkt+0OGcsaA35NReSsAUqREOvfKFL+cGxsEi/0lTP/QeN6ZyRKlZEVcHMYmUK3coYBhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ha7HXl1DpJKi8/Shq6VVkl2fVMjGimdoLaSKMmHwE6Q=;
 b=B0ON5lX024dO6RoYGCJga8yu1SbxAsscl0u6ij3VfToz2wQZMROqnhsoxmh4d6xHX+rU//rZpO2wVvkIVnn7PwhDrOZP8ltby3fvO8pRUrAwftqrdgx1NCTjtQnXMHFkL18+OeZiiwLIJ55F8EjkC1n/0IG2DYVX55R1uZGX4Dk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by AS8PR08MB6453.eurprd08.prod.outlook.com (2603:10a6:20b:31b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Mon, 25 Apr
 2022 13:35:15 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::3de2:62a:3915:9d6d]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::3de2:62a:3915:9d6d%7]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 13:35:15 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>
Subject: [PATCH 1/3] arm64: dts: rockchip: enable otg/drd operation of usb_host0_xhci in rk356x
Date:   Mon, 25 Apr 2022 15:35:00 +0200
Message-Id: <20220425133502.405512-1-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0010.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::20) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d32a4f17-2d7f-4b63-2740-08da26c06e51
X-MS-TrafficTypeDiagnostic: AS8PR08MB6453:EE_
X-Microsoft-Antispam-PRVS: <AS8PR08MB645360C83ECB0BCE24A45D61F2F89@AS8PR08MB6453.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BKt/psDQjclbpLqS5KylnQQtcbNcWCIDZoxk8u53WAeKaZkDTctq7GBjvowLVKtlHEBrWg0RjGcLCfLXAdpOuiB7jFHizzBGNXvM2TLLFFRC8WaFXxM7e0QwOM2NA9OdNcHtIJS1gDteke6A1IEDKXTIyUcQ1duAOOJRKGz2eiIdBpCgc1/VuP4rHYWRYnPQ1CxbSFHpjlGdUpmIeZiOog43ca2bWdUcAk2ERCpByvA7vsFUl0gBW5k2nsglXf0fPdWrltiNvc9c5xSoEAsa8xvzZhAzb5MewNpCGXX/H+uRG1UBXalpYc5C12z6ieWjfI+Xp623GMpjulaWkyr8MDi9zmaodZB3Pz1LU2KhHyDUoTvOrDoYtR4N0Wj+ZQdzuqUA+3MlYw8u4UiyEVLyUR/mPyb6R9nwFqd4tiBIcRb4Vl1UFiGGvG8eDqf33Ybz71aiwbz9LljgGpvz9BedvAd0pTu7mrBWQvkQ07LwNYPjwI8+kglcWEfXjqyEzHxa+ukKgU38kLSov0IvJ47h23yEpPsBhNJWxUY+BqXwdivA4rMm+JSHc6tBQd3nk6OAmH84TgX7fgRkC95AZOJVzOW2peImzAeRLYXeJzMSM/QH+yTJN+6u9M/02XOCMsJ02iD9SxnMbiLgyRV/BZiuVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(396003)(346002)(366004)(376002)(136003)(39840400004)(316002)(2906002)(54906003)(508600001)(186003)(83380400001)(44832011)(4744005)(6666004)(52116002)(36756003)(6512007)(66556008)(66946007)(7416002)(66476007)(5660300002)(6486002)(86362001)(8936002)(4326008)(8676002)(1076003)(6506007)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BUTDMUcZC3cpxczXiD6ePeZ4k9DhnnICPFKHC1wMOQIMOnXbIXDwvZXZu9Su?=
 =?us-ascii?Q?dN52xD+8d/lePNeVSCR5x7saEN53AWJ64alRJ37VjTLrpVDRKDQcQ0aZ+fIR?=
 =?us-ascii?Q?N1madiZQbNxHISA15y0cc53tgrS57S95fr90w/pGW1mAOkOdquH1ExKYtjaY?=
 =?us-ascii?Q?eRA0z0NN6ZECBEj+r5bCaTaO40couRN/Q3qMOOdR+qerfrmnqO5uM+prbveQ?=
 =?us-ascii?Q?th1gPPc3BInN2L/8OD6uy2uY66jC6oD7tjt63hGurXlslrw0+Cbgz79wss3L?=
 =?us-ascii?Q?YUtmIE4RUsxObB0jpQQq3FRWsbkxlyuNf0HgM+IViQ+mJErdWyqM7mvnRyig?=
 =?us-ascii?Q?KMhISLjBey8I7YsuV38ailunp5ECkLoNDl39LxbmLY/P2qqw3FZjuxgyb8iR?=
 =?us-ascii?Q?OEXF49cF0abcnppC1ZtAiuQDr9IRDjBR7zuFIrMdIQmX0vzfqWuIJx+TeCQP?=
 =?us-ascii?Q?lNCi0OXeiBzlnn01dG39HOScD8VODRx9de/xtmQYMYDFYEMXxQKRnmsHwCUV?=
 =?us-ascii?Q?0voyGUEePW4J6M+wXW+vqiIkPi4vi+gkvG3QDSBt7eO+kdrRSClzTw4VNUav?=
 =?us-ascii?Q?Rx/eLlpktxATswfO9fSaQqGj6LK5d+sLOqyqFwVFfd7BhR8eQdq5/EAIpDKq?=
 =?us-ascii?Q?cDqm37Ka14CZtX6HiyEpOhx5CFJmWuO538oA8FlZVVm77lTR/R2rOeRyzlvE?=
 =?us-ascii?Q?6QDYf8KOZeCncucV9xouJFCgLkwIa7G5EyFlFiLvF7srFeR3I58jdIr/Rbyp?=
 =?us-ascii?Q?3lIMZDFItYAp/Vg0vrlA/UqbwcrWY9usUwVOh6hOmxQVrtzKJwZ5sTuoxNhT?=
 =?us-ascii?Q?OvFHsjdUEWMT0tUNcVdXpRE0KwBOi/x32Ukv2qwixFJPjQdxOP/aEqbmZmSa?=
 =?us-ascii?Q?lHvHgi11ZBap/fi1kpHyboIaoHu0bgVjffeNe0mWW2RQ5KwA/5NLtpFFukr9?=
 =?us-ascii?Q?a1MTWx+3lt/E87gpMe6cJanLM9ChHBKg1RnP54rF3kb++8Fi+L6J6FOM2jRL?=
 =?us-ascii?Q?KlmAQq0Zghtm1SM7BiF8UqxbE41JgxxsqYFYGi/ye/igSgdtm3+bLDzzO07G?=
 =?us-ascii?Q?bW+vM/aTYJV8nbnc07KUTmzQWk4s3fyqgW9V/DmFJ8FR3vqCJnSCns5QiIKq?=
 =?us-ascii?Q?1yqYs1EpP+xPCjyQEamEiRi0okUv1huZA/foLiA9OunyEQqDOz7Uqa5sWtln?=
 =?us-ascii?Q?eyvkfUdcmKA1cTq9vgmswz1YaANDUtSAdz19G2tZQSzx0Uh9ZI4esJEqL/EE?=
 =?us-ascii?Q?QksZmsnd7QB+eQVLCFO8/K0zcFmzxyUnD0wQM2/p67Hfei1pqPsZLAEoOB11?=
 =?us-ascii?Q?Cy2B5Dg6Wkm0gFhQb4PyHraZCbSnrwwQ4RiVGOuVxuJqAehGm0b/RTRlOmN8?=
 =?us-ascii?Q?fI0p5nlaCCxOLMIruhFGspbPwDuu6Q1l57aS6ar9v7w9V4oirHV+CzPZgbRm?=
 =?us-ascii?Q?a9cHrdKID4zbpwAozu0hqJ0KCeOKAR5FJdwad/Ngji/Jx4l1o4A8FD709XSt?=
 =?us-ascii?Q?IPPX4G+ydkiFgL4zPXocKIMtFZ6SOqxH99Mk1pgIoeocTRZMjaGvhMJsCrtH?=
 =?us-ascii?Q?fvLuzk25SpiN1zQVKaNFa/1k8ZghhC4wN+esZ+orfYREydzCfjB+Dltqep7s?=
 =?us-ascii?Q?LAzV0JqW19nT7UXdjbdgyMZ9+WbGHHiTVAkhr9wc7UC+WbFzTm0OTkmLLU4U?=
 =?us-ascii?Q?w1Hm9LpApuuv77tdDCZyoulZfQQMMhKssOJgLYzIV9wL5jGUZ0Ix2mfxAvJ8?=
 =?us-ascii?Q?9BBfKIRpkRpxIBLXWlYsXMGmXyrR87BrK/tbkrxr5itobKVMOwgsItCtOCII?=
X-MS-Exchange-AntiSpam-MessageData-1: 7PBgHvRpsjZmYg6wieaDdg0W2T5puZY9pU8uwbfNPxT7WRX/A4kS7gjX
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d32a4f17-2d7f-4b63-2740-08da26c06e51
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 13:35:15.4766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H8X98+tKYjTp9oZlqlISuH0KZBKvABp4ezbQkR34H2Mm8Q1uJnHpsmk8IP6j/WDDHYHjDWelg+hIw64qoAPqygcOIBFeETRCPgnWa/jzLCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6453
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This USB 3.0 controller is capable of OTG/DRD operation. Enable it in the
device tree.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 55e6dcb948cc..f611aaf2d238 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -266,7 +266,7 @@ usb_host0_xhci: usb@fcc00000 {
 			 <&cru ACLK_USB3OTG0>;
 		clock-names = "ref_clk", "suspend_clk",
 			      "bus_clk";
-		dr_mode = "host";
+		dr_mode = "otg";
 		phy_type = "utmi_wide";
 		power-domains = <&power RK3568_PD_PIPE>;
 		resets = <&cru SRST_USB3OTG0>;
-- 
2.30.2

