Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F82E4EA4B4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 03:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiC2Bkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 21:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiC2Bkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 21:40:36 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2137.outbound.protection.outlook.com [40.107.255.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8EC3916D;
        Mon, 28 Mar 2022 18:38:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qtutm8mg6kVq3tGmXXJ7XJLCrXweuXo5NU7VLLfuMGGh/Z08Sa99eaXQAkEGAPBFKpobPWmyHMNO5ntWlkwD9FAJskjEuvDfKXpTD5J8O6/uiF1UtNG6fJem8sVua2nxjTeyxpy39z3XrlDdwBYiojq3DS8d0CYrZabYt+EIDspo2YkyAfNYmZbqhiNW/Ts0mNjVEsV2EMaXwQLMJUW7+q/Wfx08oXCk8alFqZiRnH9wQLmo/rzXugAfD8O7C1tsCmkD+9k+oAkX1X6Sq/TWBXPwHbebRIIALO3mORPUjAxshx+lvX4EEyOBaR5kbrzgCpNeSogqoo0/cQf2Fp6yEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+g+Em5Xa3RrgDn9g5ZJsmiWRwQB3N7ffdf7z54/muo=;
 b=Ejvz+zKagKELKgdtItnI+JlXZvECpNkGfLJFRQp8JKUOBr2C3KcLfjcgKkVimSFYh0oxO69s6hcQWbrCs28WIbX6xSR5A3m626AacrR5X+F7zAFGfC8NZfq6lQr1xv1aTRgs0KgSGbKvWwSBTz+iK4OSFLGVezK4JkGBGLrnfFaor6rsVXQ+f0wEluTZ7gImorw3q6svc5X8zhgf5tZxGWySyvs/VU+OxpQdbgA7ixJGb+YN6rdv6/VtvX2IpujSOi1X8Ga8rmflnnGWFNjjqgj0KI0ZA4FD7s7+I1f5amubCjtZ3adPnA8XhjcdEW0SVzjZpf3ZR+Bm2pr0nDls/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+g+Em5Xa3RrgDn9g5ZJsmiWRwQB3N7ffdf7z54/muo=;
 b=1iArCCmh8T0weBIwCjyaLJx20cVMnHmFEUJbUz6QGVTdl8JpgRL4WVt9x3/yU8VNnYJ9LMSx/GSrOb/i1LNLKwSob+lpUjsKSWQtQ5m/ca61gMRSGizxc6x5eKz0gd7W3dEzz920BznwfayW9RJxjPO+dYA+0coLMv9dlsFAM3apMMgBBl6RiRsgRYYrHNzMEmxfF1fNXAnGMWcsBUgOqjnOoPpxvZ4009x5OmZ9qn+7jR9saOO5zh+ecX6fkHWMZ+kcfy3VYamfiGwriexGS1tfDloisDCphM7YwIB7Cxq0ZHRmH+yRvyfOgBcRtWQsXXnRbL2PLbwAuAjsDbah2Q==
Received: from SG2PR06MB2315.apcprd06.prod.outlook.com (2603:1096:4:b::19) by
 SEZPR06MB5414.apcprd06.prod.outlook.com (2603:1096:101:65::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.16; Tue, 29 Mar 2022 01:38:45 +0000
Received: from SG2PR06MB2315.apcprd06.prod.outlook.com
 ([fe80::69db:d6a9:d891:e1fc]) by SG2PR06MB2315.apcprd06.prod.outlook.com
 ([fe80::69db:d6a9:d891:e1fc%7]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 01:38:45 +0000
From:   Howard Chiu <howard_chiu@aspeedtech.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v3 2/2] ARM: dts: aspeed: ast2600-evb: Support KVM
Thread-Topic: [PATCH v3 2/2] ARM: dts: aspeed: ast2600-evb: Support KVM
Thread-Index: AdhCR/KuzsKY1nhTRLG729StfBMpvQ==
Date:   Tue, 29 Mar 2022 01:38:45 +0000
Message-ID: <SG2PR06MB2315F24A708B71CA594F8DAEE61E9@SG2PR06MB2315.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5f1362f-ac6b-4975-065d-08da1124dd69
x-ms-traffictypediagnostic: SEZPR06MB5414:EE_
x-microsoft-antispam-prvs: <SEZPR06MB54144EF6EE066B5454C9AE1CE61E9@SEZPR06MB5414.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z54QCbUorg8ftCLguJ+hQnmRrjDO6H93D0S9J/3hgQQpbFhj2aXIPgj7xcwR7z/X/eU+oYmHzDAVhnBxWSYp10Ismt7hI3B79yr8XwzWTNNxt24Geog2Aa/UAUeMW6vmEkStYozFYsl5tcMie2DMEOJiZziYhpHnA5M7BfjMxBNR20SNCQy30qHGIpvKbsJ2HXGWX1472OPbHBsnHur+Atkn/+eg1v71b5Jz+jERO+A5nOI/gaR2irRlXtZjuVwz+wDlQBQuDWaGTR5mjZvpr6vZzuLl+itTsjb9bJEsjZ0fyBwiYkz9OU4DXIna53F3bkLRMFTWr0RH+bqzbpwU5jWYWiPMaYYOlO2vXHJG0Of+vSmu2Du6go1NubYkaB2+jpijlVi6W1uY1vpmWibYwhF3rE0+JFq27jrmSfK93mhnAzAQ8CJ7Lma8lpuNHiXxAgD3tCSqXgt9+0nSs5TUXDz8OTc1fLOFbqe7f8Td0TOwAToBt81tIvolbWuz/Jcy4M5Vwqc2OVV8ihEivvMFLpVEm4x9ItT6aiRv4L1gTUnHGEutN7GOAgF61S/tkHZOahI0VT8BtLVU/XRgISd15X2SaAY3ILNIFVlcnT3g7H+WprUF78sj7ymq6q8ebv0T0BWogSMDMxNuLUm05IX6r/L5y2MyNAHM9tkQPtbUzgvgch4I1EPsTISlitRxf+60LXY9pTAHfJuxbcW/9a2MUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB2315.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(136003)(39850400004)(376002)(346002)(396003)(366004)(5660300002)(38100700002)(86362001)(316002)(8936002)(38070700005)(33656002)(122000001)(52536014)(2906002)(4326008)(508600001)(186003)(107886003)(71200400001)(26005)(9686003)(6506007)(110136005)(7696005)(66946007)(55016003)(76116006)(66476007)(64756008)(66446008)(66556008)(8676002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3YHcVBG4J5FVCocIiAXbv3wPpK7uz9ZZOEazc08ANZ8QBkpgse9un/YUo2ZH?=
 =?us-ascii?Q?9Ye5e0ZqsFUEVbS1QZKyD0E/WOQEHU6s2FiOMUHZV0t4U9qPJ9BdfqXcFEGW?=
 =?us-ascii?Q?Jz3+U1oXbeN4e0u9B2oF1nBxobwAHQ8uUxaW9zSHaOpRI+pQoTfBwoc7csy/?=
 =?us-ascii?Q?09wTkf7r4AEWfbwzT3x+JkXZ5ydjY04jA51MZoBTVOkZ0K0UeL+6SRTpvKIc?=
 =?us-ascii?Q?VYhMCqrg4uETKFnQ/HfazKhC0AfgPyQKskhh+IAnw2c0GUe4zvWs6PXhwOB3?=
 =?us-ascii?Q?Cefcy9eg47W7hgX9s/z7WUG5OUEW1RrSzUGlxPCU4nWKc7l6DO5j2DBhGV3u?=
 =?us-ascii?Q?3KIugOjyqAZagvNBmBVmBFLb+S3r8f/2vU2+b1XmS+x90v1eKKuYk2IxtWh1?=
 =?us-ascii?Q?JrfxyO/VFERnYh3lsGmw4HGAtDUGpQqgkId76/R42Oh5LRxJluLVNcUSKNfI?=
 =?us-ascii?Q?ahTVYRpSmPBsG+6CKh4tydJaygLWJ0maxzyR51gYw9PrFmokg+e0d8RdZckD?=
 =?us-ascii?Q?xRtepWsRznGp8TU/DcrRqyTIQ2ZL4nzXOooKzusWQIt9CTKjbXSR9f/JQm2z?=
 =?us-ascii?Q?ygkmxl/Iw1r3PE+Ko6VkshHCDNhod/VfRqWxNjYxjXcKkIJcDYC0mCp9Wc2t?=
 =?us-ascii?Q?n/9oohtu183vxy3wBokbhyq5+1HR8EZkLOkK2n4U7/sV7wtLOiTBLp8hmapv?=
 =?us-ascii?Q?fIPZBrCZlg1RqjhyznPFwnozLFNvPtNEHdANLWuhVcuEZTro6KTeyJ7A2ls9?=
 =?us-ascii?Q?9J6A5lhDIVimie8Mt98u35ebFmx187eErr7gjdY1dW1hPep1v/FEQxv7iBvE?=
 =?us-ascii?Q?x2b9y/5shVHzHP0Llg91z12E+da9ANmTdF8hFiLtZIgDXSHRYaOs7K+SzD6g?=
 =?us-ascii?Q?V+msDO2ojrypGHcLqsQ97kDSqO/bdIAeM294/XzrkOxD6385fSU1AQYDvWwt?=
 =?us-ascii?Q?cEQK7oHflsWshxObiX4uCeZScFZzfO8pseKpSw4D6BxzYQw2/VNY6DWlIJED?=
 =?us-ascii?Q?8TaA2s4okVD+AD82zUWCSEqaK7NrRtvjbaD3WuvHL++Z5qxV6h7KlPx63xOc?=
 =?us-ascii?Q?hUfp+3dPyFq5nIc9eMMLvpoWNIj1k1j+8uqKnQTJ+Ks0WhVvQzMg1pokorhm?=
 =?us-ascii?Q?DCl+IeXHn25UaqvWAeF0MaTX9d5gEX/baWXv8Xujkl5tWUYKSDmrr76uPQ4z?=
 =?us-ascii?Q?MKZO3RIqZubG/vTIUZTZgu6s0HQ3wScvWLUJfyGJSMbATWjgWNuNlRSgzHUx?=
 =?us-ascii?Q?YGTRMiCz/v5TznkQEdYEZMjjsAximRv6IonZx4ZRO1jWsNCnHPyrz3c1vgWj?=
 =?us-ascii?Q?LsY9E6+LRwWuLaBwrXlVlHYJBedtoFiXfsSAs5To/F3Zj7iXKV5MmM1xUnyo?=
 =?us-ascii?Q?59s02QkqMtZx4egXQPnaAz3LS4VQfeJt92zn1fKqNR+AWyIRTQtJSXiDVALx?=
 =?us-ascii?Q?bx13WSE2LPl3McTTYx/Kx5zDjS2lzCd8Gd8veFTDmusb56qMXeYXORn2KMsQ?=
 =?us-ascii?Q?u3n2sTzFX5EQjuf4uGCKQIpkFkAt6MnCsXI7EGSkXqKp+YPUV9jbzJuri5P1?=
 =?us-ascii?Q?DqYAyTMUABEd3X6HhtjBneYQ2dohHqV36IqRUhvtCVTRcTobBg2yRkux2hmq?=
 =?us-ascii?Q?RJDWSd3bsc1BHmUzb8YT9hgbkFX0tIhnZb83idv/YIE8LqCi1j39NXzBQ6kC?=
 =?us-ascii?Q?P4ODL8h354r8zxo1VcJJyTmD7vy/q/EhgwZQc41PbUP0jaQWKnkX88Sb+z+e?=
 =?us-ascii?Q?WkeciElenKKKTE5rbvQXlyzAxyBIgh8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB2315.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f1362f-ac6b-4975-065d-08da1124dd69
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 01:38:45.6239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3S8mKNOUSOLEa1vH2T1BVKyI66KPntCcNYBi5reJKMblKx5aii3wNmFXh68iyjTNlEJkFLo7chZrxt3XiY73eDNDuM1WsKWWKTgmXe0BkGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5414
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable video engine and reserve memory for it.
Enable USB for HID support

Signed-off-by: Howard Chiu <howard_chiu@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-ast2600-evb.dts | 39 +++++++++++++++++++-----
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/a=
speed-ast2600-evb.dts
index b7eb552640cb..d535a711bf5a 100644
--- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
@@ -23,6 +23,19 @@ memory@80000000 {
 		reg =3D <0x80000000 0x80000000>;
 	};
=20
+	reserved-memory {
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+		ranges;
+
+		video_engine_memory: video {
+			size =3D <0x04000000>;
+			alignment =3D <0x01000000>;
+			compatible =3D "shared-dma-pool";
+			reusable;
+		};
+	};
+
 	vcc_sdhci0: regulator-vcc-sdhci0 {
 		compatible =3D "regulator-fixed";
 		regulator-name =3D "SDHCI0 Vcc";
@@ -250,14 +263,6 @@ &fsim0 {
 	status =3D "okay";
 };
=20
-&ehci1 {
-	status =3D "okay";
-};
-
-&uhci {
-	status =3D "okay";
-};
-
 &sdc {
 	status =3D "okay";
 };
@@ -300,3 +305,21 @@ &sdhci1 {
 	vqmmc-supply =3D <&vccq_sdhci1>;
 	clk-phase-sd-hs =3D <7>, <200>;
 };
+
+&ehci1 {
+	status =3D "okay";
+};
+
+&uhci {
+	status =3D "okay";
+};
+
+&vhub {
+	status =3D "okay";
+	pinctrl-names =3D "default";
+};
+
+&video {
+	status =3D "okay";
+	memory-region =3D <&video_engine_memory>;
+};
--=20
2.25.1

