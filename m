Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0528950BBFA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449550AbiDVPrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449618AbiDVPr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:47:27 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2099.outbound.protection.outlook.com [40.92.22.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE3B5E174;
        Fri, 22 Apr 2022 08:43:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/RPXY4cZvQxP8fLExszzZZ1B/pq5BSQZFZ0d6aXXm34ty7AcpJofT84egDNCqoLsN51UKPgyiYUbR4lT+9LOJyd7/5CLOTMQKuT1emk8pJNQpygOQv8BJRTew1wjsoMk8JctD/6Re66bwStMAqFFb997aSm/npAPl4Nmkc4pwImXg7InKBq47eXvTWzP/gGV+ArO9eGW7TXacaMaYVGSMisYaSFKPiAwOubHDXEV9nv+fqkbp3LZtmlwoWDTJ9F8Ilgk9zsiOsje8lYtp9thHmko6uOjWIyx2nrW3AYTv22SPGCJhO7XXmtbNPgncipDcmFdlz30pInfDr01C3jZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+bTY2ZVoe/uYb7D+uWnrBT52CTLm5pFsPRHeuvrRSc=;
 b=itczoN2K0+2YW2Xy6mS0/TSiEp4aQby0UKEXlIa8cjwKTurA5O4aaPhtmEdnZXSW3PLD8R14YK3u5ffc/Pgl9+qKqaRMsQKr57S7ZLmzLCyubx0d3nv4QHZm8yU/q82ZHtpmnDGrTTUnyUnlDsilOkI+ZWJueF0meu4cWLiW8B28Igt+0zf6lNvhV0J1HuYRZ63Acpj0EgHPXzugwr/R5QW6E95Qg1sPUbClLsecI/ewd5wdaDUU8DdZMCoV4OiozIy7yD0U8FhnD9IzHMRwQziHwTDJ7AV84BjUj8G6r/pHt58UlRiO5up/lh86GAJOYmdK5pGNfFl40gW6vXRAEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+bTY2ZVoe/uYb7D+uWnrBT52CTLm5pFsPRHeuvrRSc=;
 b=fQ6NeQeYLR5H4Vgb/ubCAV/ErinZkvsQ8HjsuCMgNoUaIcJsb/WGaAYWCTSsH7mcEoJmC/qlqhTzdPxNLFx/EcUbMlm1yqQy541RG4ueylznKQR79/GJQXYdQISvx89GA4j3crR/J97pQOyY+Yulbw5nyU2so6BNCKnpCJen+Z/Dtu2dhVZfxcCI81/eHmhVnxFFPDPvWtHDUobWvWh4ijF2u8iZABonr0OX5bxMTa6VR/i8czxkMOMDmyL9KN8t4geKQ24gzcIIIWa5S1+VW1AzKQPMxzwNeJa3CZA3EoxM3vDCzxvQxJUHXq0qeypXFWnAOCjnIkZC9FdhT3EAsw==
Received: from BYAPR20MB2472.namprd20.prod.outlook.com (2603:10b6:a03:155::16)
 by DM5PR2001MB1836.namprd20.prod.outlook.com (2603:10b6:4:17::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 15:43:35 +0000
Received: from BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3]) by BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3%6]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 15:43:35 +0000
From:   icenowy@outlook.com
To:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 12/12] arm64: allwinner: dts: r329: add support for Sipeed MaixSense
Date:   Fri, 22 Apr 2022 23:41:15 +0800
Message-ID: <BYAPR20MB247223406A5E8E97C9CEB3BBBCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422140902.1058101-1-icenowy@aosc.io>
References: <20220422140902.1058101-1-icenowy@aosc.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [aelFEiau9+SgNya5lSH1eLWQorp9uU4l]
X-ClientProxiedBy: HK0PR03CA0116.apcprd03.prod.outlook.com
 (2603:1096:203:b0::32) To BYAPR20MB2472.namprd20.prod.outlook.com
 (2603:10b6:a03:155::16)
X-Microsoft-Original-Message-ID: <20220422154115.1068642-10-icenowy@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b48b6c1d-f524-4925-ad14-08da2476dcdf
X-MS-TrafficTypeDiagnostic: DM5PR2001MB1836:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GAaI8+cj1+02jsPbmH9NhjFPBwRdFMV9IDolRftLrJX/QENyzqH8XHA4lgbAdHRGozD5epUSAY5RNnapuKNJMp0o9k0EuQJ5aM6sXDHIJDFwrc0YfvkkLsTtMUuyXWnb6LzYvryJfLMeBWtAmdCkg7paMLfz5AgVVI2wK+3MOgEJbwgmGeAAJw/EoYlYIRDlrbvBjrp0fziNQg+njghZwHfR4/M9WHPv5I9KusgIaLZNKYqEpXvPynTaLvxsS7ug915fIifvDtxEsNvVzs2TJU55tBAxls0as7Uy/q4qa/2RkEE+ftnpvxFDij7tCfruo6mHCu1166gxL9Mw6ShtEIN8uWK/5kFoa2PtnhGrbRpC7QnKbq7e5hAuM4aJxF2KlKZByfiDJ3NSH4M13wiBphOj/4pcpTwthJVtXqERrX/FBr1M1wezJU5g/kN7PzCAwdNBs8fWj7wCKZ2QYsLoyCq1c/Y2ClqGNWpRF14pKwJ8ToEKP/FqbB1I0uCdXgOEtv+3sAUlaLAupbl2pDUQ96z7vjkmR2Y4IW9qvD63xgzSsDYweeAUJ6WDSD0E7lmVOyi5mxiRSO8MR4C6HJwMmQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kMMbtJ6dsQTBd3j7Z6gaaG5HUhffU+zYHNToyYCavladsYUdsmWrMe5RGixT?=
 =?us-ascii?Q?a0AYK2cw1PVpzjNPEguJ+ocoBFWmGgMJsdKcopQm6G2bYlMsY7QNoqnhTvdT?=
 =?us-ascii?Q?AwdyHztv67waCym+BS6GMEV0zDbqsCkJWWCs4lwX8NG5KGMx/1oMbXqutWEo?=
 =?us-ascii?Q?cY7iPny0Dlrhm3VmVEtjWTCS/ClzeKqGBoIU3nVeBunGGzfIus1QYBHUJ4ce?=
 =?us-ascii?Q?GodsQniKWMeVRG271JnzRl2xSKgdp8vwRiG7ABbJjsfwN92dwVyz/WaNkcpy?=
 =?us-ascii?Q?dzVHXcLOCQ3TmnvXhdmhidUaD5VJ2V6NzfPBVySyY8oIAmz63qv2JCHosH1z?=
 =?us-ascii?Q?ZW3CXmHQpZNqhgoGirvb4pvHaHQXicjZv2gIWprvihYYj6HwvUSfRxma/57n?=
 =?us-ascii?Q?CnmGuJimvuNFJfHzzJLKE0XJcfdPvvy8IcMKRSP2UhYVAmO7JQPBMK2AFQ0j?=
 =?us-ascii?Q?lI6H0LEgVJ0B5hl2BIie6PLoQjd6JrRw6RTD2pfob8YDBc3daEhlGRQdGfUy?=
 =?us-ascii?Q?k+A2o4sl+SiAQZE4lnjpefcFA8NAIVLQuVsgD2KtPTZIQkbbHyg+j5MQTOiy?=
 =?us-ascii?Q?basG7IaNwW58deOfVOe79Uv4bfOWCgKwtrZAObIWTyBTuCJfC0P/2vAPs3cv?=
 =?us-ascii?Q?3wqcsVRy2famyhiDB3KWklJYVKxaCjGU1eOy+5Dw9AHwEKAfDO2pktjra9WO?=
 =?us-ascii?Q?Ixg4agYXwvsIOvHhhXBQDtlAbXl/BLsSiGVbO49cAGWnipEHovB+CsTAaBQ3?=
 =?us-ascii?Q?tq89o/6AC/X5x0OOM0aUteiSmP0PfN001Da0vuhGeX5Tgb9dPQGuZDKxbh4f?=
 =?us-ascii?Q?X6I/QhlpthBHd5WKKpjFU4TkMnbTR4nDYQfSNraJFCTDxSj+LjMrNNimzExg?=
 =?us-ascii?Q?lBkq5Mn1qxlNXBJxR/JZQD+GRrlLsUgQnav9U15Urj7+Ag6S0kmI33HIA/Jh?=
 =?us-ascii?Q?ENDO02AsCBij6R8qvUAI6vxXAsTa3rzHG7mYsfKhoLoxAPUWRfukw8O1RDX3?=
 =?us-ascii?Q?+n6FInBRmg0nmDBnS/GulD7p3q8jj7QWWM00MobH1MCI5lFoap6gpG1fKx6Q?=
 =?us-ascii?Q?3BAgrhFPUYyycODyy96j1+49DrRvEN9lvXjdOYwurVLCBA5gE6GeEbtHgmBY?=
 =?us-ascii?Q?YKEiMisN42NnfPMAw6SCal1BfO5xKvWndu4RgCGZaMtce5CwxbVG73Zn1JXJ?=
 =?us-ascii?Q?GMkZGO1aAeHVW5L7a1ir4oJncgLMJZjMcoj+9o6FuR4u6UIicW/iQOxqk5Sg?=
 =?us-ascii?Q?HaIU+GvmyI2AxLFPwCybk7sgQ79pnHuyDKoOI5GpXBPCAj3135Lghsvg3Otu?=
 =?us-ascii?Q?UCnjDQD/4KPgjGAiEXxeHe3WJLRtVPq3/VYfY3w0sJn5J0ihBmaHCFnWw1Qa?=
 =?us-ascii?Q?xqYwqBgV/xIBEO0LaJbtcNnGTEd44H+KmzBaoJ7A1W6mU0Mz3N0syYlAqXmK?=
 =?us-ascii?Q?gUfORZ/NGh8=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b48b6c1d-f524-4925-ad14-08da2476dcdf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2472.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 15:43:35.8764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2001MB1836
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

Sipeed MaixSense is a R329 devkit based on Maix IIA SoM.

Add support for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/Makefile        |  1 +
 .../dts/allwinner/sun50i-r329-maixsense.dts   | 37 +++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-r329-maixsense.dts

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index 8fa5c060a4fe..81fe954ba2ef 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -38,3 +38,4 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-model-b.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6-mini.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-r329-maixsense.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-r329-maixsense.dts b/arch/arm64/boot/dts/allwinner/sun50i-r329-maixsense.dts
new file mode 100644
index 000000000000..1876b9d0b080
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-r329-maixsense.dts
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (c) 2021 Sipeed
+
+/dts-v1/;
+
+#include "sun50i-r329-maix-iia.dtsi"
+
+/ {
+	model = "Sipeed MaixSense";
+	compatible = "sipeed,maixsense", "sipeed,maix-iia",
+		     "allwinner,sun50i-r329";
+
+	aliases {
+		serial0 = &uart0;
+		mmc0 = &mmc0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pf_pins>;
+
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pb_pins>;
+	status = "okay";
+};
-- 
2.35.1

