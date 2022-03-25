Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0614E6C77
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 03:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244664AbiCYCWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 22:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244651AbiCYCWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 22:22:47 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2137.outbound.protection.outlook.com [40.107.255.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991B4B188A;
        Thu, 24 Mar 2022 19:21:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=astcoqpozIxCXNF+sRX77GrHT61n9jbBJx0oX5z3fbXPZr8xCSmGmYa/45uM6UybVWRr5NCD/b8Wauqa71JFD961urubusR/d28Hw4Sj89WXP299MUj7QLKC48Gn4edJWE0gfd17WFSL/kFEvVT60rfEoy8nk0yDQBTu6DlQ+TULuJDaCZJQUwubuq6HjWFjhsUHmFEmPrkBWrk8Y3oyjGwbZnS2euKjTsw6rqkJs7TVOJG5S26rqyg9S4SUYy3UkEftIZcXxUKK1fIQvIHZ6hi5N4iEm/CccaFikl4uJTeg4iJrXOpGgdEBxANSRerFO7v7zs+Obny6HXkTdf99Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3mlccGpZGMnrg8RyoEjEFeAM66gDb9ojzhSp7QdL4Q=;
 b=leOgh+BYlTvHPhXOw35jbLHqkbZIEFy5efTTwbS/xe1oh/NbQHWSKbgAw/NSmis3aJmXXmOR0YlJX28Usnz0O3VYLskj8j3q+EF83QOEr4YzMc9fcVPW7sjbb1L1UdgwTHA0f/PxngSOQ6MKjcqBVIQBZ0ooDGd5Ds5X031l7sQyynI1HMYKKaRq2Q356FO8TwJ/z8XqwLR31+6PjVmxhMKkowDqBd+Ha3zYkDBdMITKTAG3gOgKJU9yiQcnDs7pf8bPWqwwWl/iRP/2JU5RsUUk9MDUzNpImKWwHlY7ptbcCtlttFozzPGjmZx02LFOMyvM1UfIaAH0SzkUwdovzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3mlccGpZGMnrg8RyoEjEFeAM66gDb9ojzhSp7QdL4Q=;
 b=x8bl/TkuRkbGRX3PQPXfTK1b89KdQWNSYIJDx98M70dhoGU1zHMyu94luD+7tCmlBcM0ZI12JtU/ni1cWT2g5wYxhvCpeHjcGBBskDnkqqHzEOas4QROnK7dHSotDMwlGwRqPVfvGqEEMIIIXvOUXAwAyHeyqBb6vodN4ZKbyfIxkkYDaqSiZNmjwQKeu4uwZDyJwmI9IJUJaaR0+fOCx8S8+l8KFnOFokzhGAEiN46OIY9LNVgZMDPnliCs20RabZzoaKIgDAlxGzSPYSy/8EJU9m9J1B1/MIsL31xvg3wnStv1lfa1RbXqHDWCR3UEgW2Y3mP/nJE6igR9WelmZQ==
Received: from HK0PR06MB2307.apcprd06.prod.outlook.com (2603:1096:203:46::19)
 by SEYPR06MB5374.apcprd06.prod.outlook.com (2603:1096:101:69::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Fri, 25 Mar
 2022 02:21:07 +0000
Received: from HK0PR06MB2307.apcprd06.prod.outlook.com
 ([fe80::e89b:474d:4944:ca2a]) by HK0PR06MB2307.apcprd06.prod.outlook.com
 ([fe80::e89b:474d:4944:ca2a%6]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 02:21:07 +0000
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
Subject: [PATCH v2] ARM: dts: aspeed: ast2600-evb: Support KVM
Thread-Topic: [PATCH v2] ARM: dts: aspeed: ast2600-evb: Support KVM
Thread-Index: Adg/68fK4pllKk/wTtW7PW2KKw5/Xg==
Date:   Fri, 25 Mar 2022 02:21:07 +0000
Message-ID: <HK0PR06MB2307383743B9AE1D714A899BE61A9@HK0PR06MB2307.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 944c993d-ef46-416e-03ae-08da0e061ed3
x-ms-traffictypediagnostic: SEYPR06MB5374:EE_
x-microsoft-antispam-prvs: <SEYPR06MB537468B184ED998BF187517BE61A9@SEYPR06MB5374.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qWx2p1g3n6yXIV0cheD3h7OR9MtvpD7Dt7z8oL+ZCAhqeRQz8lGxh4KnOn51O07zdOvyhY2+YZ44PPJmQR9b29qDdN4TcwRkEOy0a4N9f2nhUfGRxcTGop0uFb2p7RNj+JA5GlT9FKi3pBFfZn8IiEDmH1fzsQb0VSRhe7tm55GsZqFeWqV4RuT8fAatDpVHHhhUW5iAH1w+l7LVE6kLfpeleLqxClkTlOpcECNp/hKlcV7T+n/QlRiEqtMVLPOHCEgoHSgTKt53cLQPE18yUhlj7vbZDLoTTDIpekYI9t+WSlwwke8IYqNdexa2p2CUlPyq4TMGIxSCf23w8QZ8Md84Exi8PTHj/cV9rH94r7w6QlqSD7fVRg63a7tNRtE9dlIh110x93UiicBEftETwXWZxKirzN4rc/V+uS/vbBWO08svojh4AJAOmSkxwrVlpEjNSMxhXpsS/FnVVdzG6MzFc43uJX5GiQLGNfkpBL5HP4eE7x4x4d0x0xDKdmUDZOvLPF5B6o/QQ2c0QUELSjDlZJ/BKEwHWCaqax3cStFGcS0EELCOoezvI5ugNTtgvyQkqfHeazPa+SbM5+gzrJkuL44d9gDMPM13Go234lM5otK4Rvo4lV7yFdZsJQ/5YuSAAc6xCpMsW66ZBZcGiE05BuFbpD7X2GevqL7Syr2B1LQRitGOPeb3BxnkmzDKFNFC7YYdtYeS/Czdvw0aQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB2307.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(346002)(39850400004)(376002)(366004)(396003)(136003)(83380400001)(9686003)(508600001)(8936002)(110136005)(64756008)(38070700005)(5660300002)(66446008)(66476007)(7696005)(33656002)(6506007)(71200400001)(26005)(107886003)(186003)(55016003)(122000001)(66556008)(316002)(38100700002)(52536014)(8676002)(4326008)(76116006)(2906002)(66946007)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RfotvJ/iQjEEtv4nQnIxGt3x9/8PHyUvpJWJ26+78UVcTUUqM05Y81+IWfGD?=
 =?us-ascii?Q?UB4GwsFft5FDq49xWzyExts3MwRqopglhx09cfc2IgOep0LW3VzSKj7t+vKU?=
 =?us-ascii?Q?GMrTciLH+cq1IE5sakdr4+0LeWJ9w6YZHEAYWI4pM6MqcfJbC6vs0vrm4qCx?=
 =?us-ascii?Q?YC4aaJUEm4So/J0q1pFD8tGckbOqR+UfuCEzvXhUSbgWjaVy+5eycDAxrT0/?=
 =?us-ascii?Q?VwZ6vxh19MRMF9Qr2JzR1PnF2gW11fR+jYWcctTtn2ocB5Irh+Y5NcsSBy6Z?=
 =?us-ascii?Q?nSa5FFO4E23J8a+IZ6CEj5xQAYqkvV7JRq7tr8NPVExc0vVIy6mgYsPYDvi9?=
 =?us-ascii?Q?xmXHnBBYI1bphkty0DzEedfqE9ihRnCWe09oJhSMG19KD+ZF9gnqAjLmf3vU?=
 =?us-ascii?Q?/jgY5umKx92fYLSdb2y1PLInuMEDt8CdSdcO6bpI9w4Gw9HUfPVETbqkTjl8?=
 =?us-ascii?Q?tju5D10/igB/MwqtTr9f08x2mmGzWY7OIEf5z64pt5tvYj3BhHae30axeG9N?=
 =?us-ascii?Q?3VJCjFNN2WIJyed3kfMVn+MboiJjrHbDAOKq8tVrMkeIJ/EhUjguDVbqD3ys?=
 =?us-ascii?Q?j05R65RfutX/aZEbLO1GJ6JwBcHgIG6GAsuNCADCgVueCnimYJXU80LJcgvT?=
 =?us-ascii?Q?MKmRO8UM65TY7wXh0A3fTqp3fS00eHL0wVT7uwEW02001yeBHaguNi1hioLC?=
 =?us-ascii?Q?ovS3LISWC66FT/D0Tdti4/t7cUuBZQA96tTg07hJq3gtIpd2rHCPPJ+yG947?=
 =?us-ascii?Q?WzIkr8r2WdTk5FC1/IQUZ64Q94kUfXvQhkxai/hvocC0+sJ/522KcT7nDsRt?=
 =?us-ascii?Q?1Y58i9xC1AcI1F0ghVZipKXrwUiVEor9PEyUJnVGB0r9PCRZQLrT0fRiT6hx?=
 =?us-ascii?Q?SDCmeHg5qazjD6wBbEWw14cOkCxElymxiY7EQ4aANjcD87HJywy+uHqWJqwg?=
 =?us-ascii?Q?WfZhNS6eZLxs27Ou4r7xslrc7rEDsEonv/WxZaSOxeP+XGVku6J3+kEUgBqI?=
 =?us-ascii?Q?uuzT/jYdIZN/8r+jFTPo9KerCTr1qR/HqGY15IA8vLJVlHgs+xpf/UPxvEL8?=
 =?us-ascii?Q?9Sw0qUGxunP1lDTKyHDlTUZezA1DRUtwajDnNoEj+UMn1WzUMjwlnXNGobm8?=
 =?us-ascii?Q?aC/UXpxkQQVnuahGLq5YDgXclOHHryvMk0+RAPsujtfFDzb7ywAg3fkDCw8Q?=
 =?us-ascii?Q?eu9uu9+iJdpwG3K2Vee1YKNjbs1LPoxXRw+9PhSFztRLTcNWyGetiOwfBwTz?=
 =?us-ascii?Q?Og0/m6QmanXSfQ+qi3n8Jp+L5L1RBCYt35kNAHtetF90/kxz+AkOiZ5JMeuU?=
 =?us-ascii?Q?xwUc8XAQjDkoIzcvGvt9XXWE3knKpBL9H3ejrQd1ugL2v8GfLAOu/b/lvmiO?=
 =?us-ascii?Q?ovOrB9/POnC/2gfycxeLCJsrmvx2VpUbvy9C9Fd/wP+ZXZwh37UXKg/O47Wg?=
 =?us-ascii?Q?hsbrsLXFJqY4WcnUCUWfRgRhGQcfGF+d8fxw/JzqkhUiblLW9jvKaQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB2307.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 944c993d-ef46-416e-03ae-08da0e061ed3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 02:21:07.4834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nsGx7OksytZBpX/2wV3wF8jEleV+DKkr/RMqbPz/d85uHE0TpPS80rdctpMBLSi3Z9vymfd6Odk8UYL2JO4Rgq8UxD5S9hB5uWslhnNx2iM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5374
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable video engine and reserve memory for it.
Enable USB/vHUB for HID support

Signed-off-by: Howard Chiu <howard_chiu@aspeedtech.com>
---
Change since v1:=20
1. Remove video engine node and reset definition.

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

