Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E56B50BBF9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449357AbiDVPrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449557AbiDVPrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:47:23 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2037.outbound.protection.outlook.com [40.92.22.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7446D5DE70;
        Fri, 22 Apr 2022 08:43:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTLNk5OKdZzCivERffl6wcxMI3y+R+Y98HdrOF8gPcf5pcxREiK45gGISFs0fhxMWzIOmKrOrebZmd+jHpTcQ7/CnphOasyvPiazuuInO2S4Azheru+AYIFZ+q+kaHtpzYJnGDrnM1+Me6JrYtyCr2KIw3tpFeNmbbneSgizGNwnRpvB7McS3IJdTBf8Md2GzB5rHwtQnIVBsXofVHGMgHnjvXminCAmJnVXuhDCXKmxsV2M78DXz4xiXH/iSLpjs1RUEMwVeIyNRNDp1dHFhas4ymwXRgiFcpBkeI61Y/g1J+2wELBvIB9mxlGyIvnnwS2ZaBBUzu4xzzusAZzoRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hwPwmm1Naki9SlD1FS+XWEcKSGT/ruppg1T6x8D3Dc=;
 b=W+G0VQAH9MMcNXXjmO9eOYhJi7eRab5sZR2zeU7eQ8FoGRqF5KIZESqX2srM6TTc897IcPdOeueFXj1TFGlm16yaYpNAdPc8Vq3I7pL1yKVEIGvOKEmz77Dbwjo92IUWZh3oL8/bvZmjCeKk99Is/9daCKDcQHpuIMrkBJRnqCp7bAH8UgSHtP4UqL/+/OdNtbPgkMaBIMemZxEpRAxpA73ZntkAgX6CImcL4xIMLYv6CM95DtK1yDgCJe43D19aNWhln7U7pV9C9YwgoOpJaOOqr34IwLYvBxmyQZJlnUOp3qqoJwOGv715xh6VKcCLqbF/BXeTVZP1iRimK+TWkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hwPwmm1Naki9SlD1FS+XWEcKSGT/ruppg1T6x8D3Dc=;
 b=XOMgT7p2/QH0iFUYNPSlrDwrVHQo7FF9PKGkg74+tKDhWT8nMAjYrBleNm3vxmhnxQ+VH3nNGcsI3gahkNIfjBJmmu9F8zWbhoj9/1C/FchFAkW/mRCK9Q3LZDSCI+3HYHmE7rK3CSdNy82V8nmnMHGwgxF/q+WxR0iFc634u1fj7rEGzyT9FpEZZOmYNUELUGUDMSar1Z7gk8oYqPxLnDLpvF79BY13BH+upFU1EAgt3SqRxDQ6zR82zNxz5UnVN6fCA8LAQbJKdTmxZXYXj3VkCB0PJV3NL2/U9krHSvplp13cNBjTjmnidP3MtKlR1Iz8ssb5VEA2Bz/NjM8POQ==
Received: from BYAPR20MB2472.namprd20.prod.outlook.com (2603:10b6:a03:155::16)
 by DM5PR2001MB1836.namprd20.prod.outlook.com (2603:10b6:4:17::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 15:43:13 +0000
Received: from BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3]) by BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3%6]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 15:43:13 +0000
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
Subject: [PATCH 11/12] arm64: allwinner: dts: r329: add DTSI file for Sipeed Maix IIA
Date:   Fri, 22 Apr 2022 23:41:14 +0800
Message-ID: <BYAPR20MB2472DBBB3C601954320CA5A0BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422140902.1058101-1-icenowy@aosc.io>
References: <20220422140902.1058101-1-icenowy@aosc.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [bheGjnBqo1CElkCmUp2/72f3gTQs9jFj]
X-ClientProxiedBy: HK0PR03CA0116.apcprd03.prod.outlook.com
 (2603:1096:203:b0::32) To BYAPR20MB2472.namprd20.prod.outlook.com
 (2603:10b6:a03:155::16)
X-Microsoft-Original-Message-ID: <20220422154115.1068642-9-icenowy@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ca515eb-cb7c-4fd4-28e8-08da2476cf4e
X-MS-TrafficTypeDiagnostic: DM5PR2001MB1836:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A4537LKjE+iJfKftnhOzBQJforoIUuEhrkya9RLk3cuizL9xhZQfaHfQb/4OStCih8yDYgCXtPglpUHKxhxiEd3QfoTfYGEr/tFwnaO7pD7mdqaeOss+hfSDdW2q0nrIhv5H9aUBaW98TZ8unJGLjV5lfmlx2XwZMhAVxFi92iW4gt11ofh0AYyU5eb8s0QYQo30MnnWTLQhI0f6uoYeoyJjCrNlOvNZ2OHv5MfiK30Aa54i9ESwY3nkEZe/kS9fLw5c38sJDYfE8jPhVWKi3Nkw8TXcj/UMT6dgxVJ/cZQ21VQ+b0L+gG06azfi9u+olvysoEUi20rIsGba4jM0DR71M3yxCvSlYizU4hOwB+YX36612NntU4egFaol/hDHtciK0jxsT21Ptgm/cwvw7v4xR2eJ30+3ABojzEgXA9J8DIv9UnzzvzHJqwumFIrdQr+x1jwdoTSHnoAdPy7VYcQ9pYVFvTb33qpxUOQWFIldqMxw68GcBawZn3q/yEI6xvMgu3/zBJt+GtnMxqHIfDfoPQJPBjUVm0cIJN4eEV1yv+gUbPz3sd1LyIRsSwP2nTsrkrEdXho/WrhYuuqx+g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I2bijud34T2D2VAPx3SlBU1wQH4c2euRfO7iCjcf2SBW8Dadd0TexOBBATE0?=
 =?us-ascii?Q?EyvsyJ16jjoPLnGxdRvoXMXO+w6G/l5t+MGLGRCbU77MMs02t9MRMbu+lsnJ?=
 =?us-ascii?Q?DdCXGsYUOawJYTlv2S9ljC744QiXQ8J8LCyizaR39DV0GvZyfpI4XZ+wHYtq?=
 =?us-ascii?Q?7a/hMr74STxW+8F5CWBlztvpdBT4D05ryhXmnDSil4bMDNZBTdEsZXQ9M4CL?=
 =?us-ascii?Q?13T3milCPzG60FfHLFRQy8WzIvB9zQX45v+JB3c6DvK6KNXpgdRTIDiji59Z?=
 =?us-ascii?Q?glPfstMxNvuX0k/tI0VCw9yaIkOabJCnzqW2R+G8YIkY0MniDJPXobdG9A/e?=
 =?us-ascii?Q?jtPZ1x9xpr1BVN8tL1isHSth7dmnOHmgEznJx4PcAOjPk+VwnCUqBe4sKUI4?=
 =?us-ascii?Q?LEUo521kdgDZCDflj0Nd0j6GgZtNJTs9Q4RBmLuUWBk1YUsLLFTvY+LjFgNV?=
 =?us-ascii?Q?cWKzGAD8DLYKkhO6Xcoq6W0R2RGVf6KjrtKIbAfYD6YAnywjb7mOT+jbPDT9?=
 =?us-ascii?Q?S9rvNyihgUmHUkIEhr8TRie+TN9sKSpEqDnDZBddGd9mh8zx/qoVcKjAOQK+?=
 =?us-ascii?Q?ySruULmz/KrqJnPZuNBNULsGZYrUhkK000dA4QUamzHyxyIzBz40BORQJK5t?=
 =?us-ascii?Q?N0SAYDGZWcvQD+UaKWV8OCcRxw2f9mvuB3TPSjLkZkLL02EveUad+zDFmvwr?=
 =?us-ascii?Q?SNPGLbPWPa2X177HKT1MJSBmNLPKwtzinex0VZ/hv76vL0fJK27QfFnMyKWy?=
 =?us-ascii?Q?sC1o6buAQ16SBuUdHZdW/L19TxmjX8iEMlNOlMbCdjjC3VjFC/VAM/1sh4aJ?=
 =?us-ascii?Q?sCT53mZBYx1cP01BSRPgFICVM/dRtWO5H91LGXlqB5gS4g+JM8h5PhMo49MI?=
 =?us-ascii?Q?9BbcsHmTzhLRUjFMln2MosHciltEY9QqwoShEmYzDj0OPdMSbTmmRk6LVz/d?=
 =?us-ascii?Q?s7Lh1uUCw40CMoZ87jjPnRnuRbspQk7YBtJdKCfv+jCKk2cIb3rMjdtUmGgF?=
 =?us-ascii?Q?UsNBmyIDU0jJopxHjceR2igPNNkx1KVMHEKbK3z1v6B/nhgzmCPU5C6va/wR?=
 =?us-ascii?Q?xW8ncZ5KZwAFjNFhWJHYwkCHbGFg4H/UOjqlZI3v38OIPNYwcOBHaliNYNZs?=
 =?us-ascii?Q?/JR/O+PUQfR6fn678fX9Vcy9thJuSz+QupLgkhCdrmdMUPj3mBsKMU+udVcN?=
 =?us-ascii?Q?EbutjZNW3qiD4XkyEJ3KwZSffIPWbOC8JqKe3dP3/uqrrNb5yF/VfVU7NbpX?=
 =?us-ascii?Q?oK9mKTRnrT7flTSkK4P4FkBTVESYxUIOFAzaL0k/px+O/gSXeEBQupgqOhUm?=
 =?us-ascii?Q?Al4oeViQnFH0hRVd40CB2hCsKRMPakhrJzgj7MKQvO/rR+GLOQU/1cjlNGCF?=
 =?us-ascii?Q?19VwJ8AKzbprduWLacVDEwq1CNKvP8RI7YonUlRYexadlfAfWdm3b858Q40+?=
 =?us-ascii?Q?CdjHXy1Lh1E=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca515eb-cb7c-4fd4-28e8-08da2476cf4e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2472.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 15:43:13.1905
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

Sipeed Maix IIA is a R329-N4 (AIPU available and 256MiB DRAM) based SoM,
with a Realtek SDIO Wi-Fi module on it.

Add a DTSI file for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 .../dts/allwinner/sun50i-r329-maix-iia.dtsi   | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-r329-maix-iia.dtsi

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-r329-maix-iia.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-r329-maix-iia.dtsi
new file mode 100644
index 000000000000..15774f8a5445
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-r329-maix-iia.dtsi
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (c) 2021 Sipeed
+
+#include "sun50i-r329.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	reg_vcc3v3: vcc3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&r_pio 1 0 GPIO_ACTIVE_LOW>; /* PM0 */
+		post-power-on-delay-ms = <200>;
+	};
+};
+
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_clk_pg0>, <&mmc1_cmd_pg1>, <&mmc1_d0_pg2>,
+		    <&mmc1_d1_pg3>, <&mmc1_d2_pg4>, <&mmc1_d3_pg5>;
+
+	vmmc-supply = <&reg_vcc3v3>;
+	vqmmc-supply = <&reg_vcc3v3>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+};
-- 
2.35.1

