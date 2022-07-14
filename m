Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9BA57462F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 09:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237745AbiGNHxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 03:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237483AbiGNHwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 03:52:41 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2105.outbound.protection.outlook.com [40.92.52.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B133A4BB;
        Thu, 14 Jul 2022 00:50:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJnwokEb4iDk6DPu6tVpqci4TqQpv/lKDk1Nub3gzzmCORvJdkCU8eS9itKhcHDGptqQhiok7gxPVCiX591TM9mz+PdQ4V7QUFEdh3vGcC+ygt6jMhpaHk+hsTc/HkgIjJappomvpmLEZwIEesc9zKN3kdni5C1zoTvv/TiidHEi2TvKZjEieFmuyAhDp9ZCQiyn9EA208g7zlhQFUSMY7h6YRMDVaIdKfZXZNB8hf2qBkCKqixoaxZVQ7EhwRnLUb1XbaYMvwLjpzdHA47PEE222+NPKT7LXvutQgsA3hE/mZFaykxGfBC52T1MhgPGHSsM/9fGRGo/gMxrW/Pu/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCVOEZuVVEIIiFr+VeSJhLx6Ktxcb/leOOhzZhDvrEQ=;
 b=Iqm7tD0qmXtfUDS62m3JOwmr/ldn4wneHom3jctLRg/bednEswIvFEiFzKfA/zpW3bw88DGQt8fX0iAGCB1SsLhVUNtr54M4oH7YcWIOnVSIY4OHXqXWVAqwtghDw+Pde3fABrUYdmB9ulCgV1f61hWBPNrhRNvVQWkq817hXNfFuCdGweH6pG85riUUs6Qy6CL8wvEXZM3RivY5sV1FAeLyYB9/qNwJsERrRkkvbxZlvySGNDaxf06lsMUv+XobK3/gabtvPOsuQ32B3LORN7XcNpnVlSKav2EnTMrr45O7x0XcisBozDie3udGgNkIOSrXY04XQRN2vo9Io6ILKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCVOEZuVVEIIiFr+VeSJhLx6Ktxcb/leOOhzZhDvrEQ=;
 b=eVwWpk3Ntq/UbLyPLPKHOA4uzMKn0lClqziKaGq3fpZDdAiTznFtn+bLO28GQud4aOgwgHkrVy72gfO622hIcNohYrDgu3PMAbxbXbMi4PvW5I37FyT+LapwngJb7EAqfaW+THHZit83A3pTiV8nJeerwdtVjuM00mKz9/MXVJwNr112QF5MitGK0Da803mvWPaYE6Bt9SJWTNDbl1JcqeSFOfO36YNzPsYy90GGVLBQo9h1B1LXRWZcVpCHRcl6kDgzRYA9PY9uKxkRiN4e/aNuwPuAtqlOdheKMXkIvhKeBagS7Zf7fJFI1hKFFW55hfuZsw6mi4fphxSFAlyrXg==
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com (2603:1096:4:df::10) by
 HK0PR03MB4868.apcprd03.prod.outlook.com (2603:1096:203:bb::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.11; Thu, 14 Jul 2022 07:50:38 +0000
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796]) by SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796%5]) with mapi id 15.20.5438.012; Thu, 14 Jul 2022
 07:50:38 +0000
From:   Jimmy Chen <jinghung.chen3@hotmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, Andy Gross <agross@kernel.org>
Cc:     Alan Huang <alan-huang@quanta.corp-partner.google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 2/3] arm64: dts: qcom: Add sc7280-herobrine-villager-r1.dts file for LTE sku in sc7280-villager family
Date:   Thu, 14 Jul 2022 15:49:57 +0800
Message-ID: <SG2PR03MB50066EA3AE8F8E98B67C920BCC889@SG2PR03MB5006.apcprd03.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220714074958.86721-1-jinghung.chen3@hotmail.com>
References: <20220714074958.86721-1-jinghung.chen3@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [hRoEbGhnfN7H9hIunFxZAzF6onFEsvBg]
X-ClientProxiedBy: TYCPR01CA0015.jpnprd01.prod.outlook.com (2603:1096:405::27)
 To SG2PR03MB5006.apcprd03.prod.outlook.com (2603:1096:4:df::10)
X-Microsoft-Original-Message-ID: <20220714154940.v4.2.I6db94f0457f5d2b3b0cf7cceb08acdbd500b877a@changeid>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27515790-7629-4566-a262-08da656d8b14
X-MS-TrafficTypeDiagnostic: HK0PR03MB4868:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: im0zO+inu3IKyA4htJu5oPOu/rEOQmwzsvtwZ9w4qgbtdjq4Rd0GzF3QwZVBMbDn/5opOmbr+TRNBliTgQ0gtdJDdtd8x2UQH4L7PAJxHZSKWsPqJigvXl063qFnIZiRJf5WMy4BHSU7IF/Fg2KgAYVRlpGyNS/YDL/xf+WOUaqWgNV29bVGVNeJDKbXvSKlcJEPmBMuHQfLi326dz4R4IyU4i9ovtzP9B6eswbXBTrq6/KrhvUoS0sY/CcgigpjMgr68oipUZmMA0pUirGrApSF77VTIvAp0dO8SIynsczwmA1TUjRi+5oHOPZKDuxQIrWahyQaWt2D2tmBb7TaWNtwK+9ezk7juw10inRUEBY/No25ncUIyzCu86lyMjI9rgvFg7JzBDT1CoXYlujz4WQbGcu0zZtpUCJCRQBU1s2BmsybC93yBEET3qukqJ7LFnpsJpHzuRnl1zlFrdzSReUGSRdH0tVyYf9aRipXygbNmvyevxPZrDuqsWCaHoLvFAFikvaY7ylKqp1P4HXBU4DILHAAS5fgRcBwYMO1Pt1eb6ONPy8+OZFjGIEueorW4/42yNF0Td+W9JbEqsVtQtsM9ksPmi2eUC7eth7b9OyzKyT9vGv8ePzJhsc5dOvtS100U7g0lzLo/6dwGp+t+X/kVgZ0jZbLEMFby6sHII2VBlRX3lHaXv5eGb95yO81lXmQsMg2FPe9hZOn72Mdig==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xdMUTznBK/outMdO8SV6iNM0oJ5WxYSxE0VfFws3Gjkoojqsjthe7mYIzY/N?=
 =?us-ascii?Q?M7nAnM8/cyP23rsPcXXVk+hzV2kg1By+Tc2z/sHnykxAtN1Ge3ZEppjGOFfr?=
 =?us-ascii?Q?Et6FUKxOplIstz9oj70g0dgl1UBm81jlJot5H7HimQQHDy/JbQhCta0+yXa4?=
 =?us-ascii?Q?Jv/k0/I0yaFkQUjtJ7KJoB8G0loSKkH2TXHyMKaPIJnco7dH9i6WkK5kMu8Y?=
 =?us-ascii?Q?ZW6949f6FHVQk9xJsMDp7Ozlh4UdQR/IgT2tbBE4jK6YfYWcUmyeJ40gs7GC?=
 =?us-ascii?Q?OiF+WS3rTt4CEtuKlI3otg6fOzBRVnGxYY7ytq9dKXxLQwllFhyT5sjMnIRm?=
 =?us-ascii?Q?YxwyRKmTo8rLIUVAUMqui1B9LIa/fofig7bC9zK3odwUHQfLkVsZhRvfGq6y?=
 =?us-ascii?Q?aXdHy9I9/d4WOwLmfgLS05KmXZK6Mm0OvATnonIvx8rdbFIJMVua4lhu0MXs?=
 =?us-ascii?Q?nBm/qQHXo3auy+mWrIVrjuWlMYIEWzAQtgaDrXEvYi5LaIjy+FNtQBfS9aRr?=
 =?us-ascii?Q?OxUA+u5cw4PriQGzPqSVN5xyAI5TsXeEFcFRRF4NniH44XEC78aOkhhEzaLt?=
 =?us-ascii?Q?CmGEvlgGL+v6v9CVc4Dny7ctBUeGqyabGX2SJFS4EOnGRmfgONYhNQsn8eCC?=
 =?us-ascii?Q?tpWyABlFfpQTMVXTVYdIODqu1dsUIEoAyE6KAto8nd7eS9D1sugdEj5/nW5b?=
 =?us-ascii?Q?ocwymgUFQSdVPcXgrdwhE+mjLgtyQWV1UbTYuInlDmazMtksbUIA8Z+TIn1X?=
 =?us-ascii?Q?mIZsSYfCVmNb8czqmkMitgRneS7pnrQaD9dGY5YbcN6o6HK5x9Mu2c1kxMPX?=
 =?us-ascii?Q?AaAo65LSJarobQeOZ5wFTpTPip1RO6GS38scFvkekV1UMggVZU5KGjQ7bt6K?=
 =?us-ascii?Q?QSbLs1dLUlK/rCmsGeTiANO+CG/EYumdsv28AWPhw1m5xtsJxI4AmsOfGnt0?=
 =?us-ascii?Q?8lqxyD5NZBGAzy3EWKn9anBOh7mjXS5hgdGPTETmi20tHPN+fC8jvTyZV/nK?=
 =?us-ascii?Q?/6rfAk0D8Ju9zG+wOil2cTdGCLVvhC9hX5H41B7MXFmW3OzaCpPvvjhZ4bIu?=
 =?us-ascii?Q?Kk4hyx6gwdB19l5boVW+eEakb7AakmX8MyAfc7ThWPwHWV8L08WSmSwsVZqn?=
 =?us-ascii?Q?OZvLnXqS7q2bzTUCBNoIy267eGb32q48rB2FqBZo/q1fegG7GPHJqsj6/aFo?=
 =?us-ascii?Q?ArdHUMHXeq4e1Cs/YuhYcqy2pKq755kVWhB+1dhJjJikJsNSOyiHfqbmgFCR?=
 =?us-ascii?Q?2csMhpDyizAajtZpPhoU1jjGDW16LFr2Mn+Z9qa0xEWYyO1ynCqVIfcjtfGE?=
 =?us-ascii?Q?6/U=3D?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c0b75.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 27515790-7629-4566-a262-08da656d8b14
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB5006.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 07:50:38.8072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB4868
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds sc7280-herobrine-villager-r1.dts for villager device tree files.

Signed-off-by: Jimmy Chen <jinghung.chen3@hotmail.com>

---

Changes in v4:
-Add this patch

 .../boot/dts/qcom/sc7280-herobrine-villager-r1.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts
new file mode 100644
index 0000000000000..c03b3ae4de506
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Villager board device tree source
+ *
+ * Copyright 2022 Google LLC.
+ */
+
+#include "sc7280-herobrine-villager-r0.dts"
+#include "sc7280-herobrine-audio-wcd9385.dtsi"
+
+/ {
+	model = "Google Villager (rev1+)";
+	compatible = "google,villager", "qcom,sc7280";
+};
-- 
2.25.1

