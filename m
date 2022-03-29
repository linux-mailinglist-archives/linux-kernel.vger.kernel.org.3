Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3DE4EA5F9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 05:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiC2DZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 23:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbiC2DZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 23:25:54 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2137.outbound.protection.outlook.com [40.107.117.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9824DEBA9;
        Mon, 28 Mar 2022 20:24:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+a08VsGtIqCky3KBGcaDftr6xYmo15po2jMrZLoNA+ZaX5njVwhScyRgmi+o7eoIhLy+GGCTcfJJBdOURufi490yZEqdMbBa0D6RoTF1Bj1/UOQSbm+7DXEL9JE2jGkLcZ7nqdzQyDwnKTb+HYZZPbGE+MlVWDfLUedfGn35mDA81hU47KT8MlhIk7AAuGrS8Uc5YzLReRSKMe2tFaxGBa+jrAIaQzQ7HhvvK0z3IXozGZHaE0bKZnMS/6RNzwDFFETZoPGCOa8+jHEaBBa20HJMjTCEr3V/7EHAgbC8WJgxgoaE0qUdBWm6yaiKuJjuvtyYCLWDZ19dptksXZUVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LwVfPl/MvK64SAITJDJQeWL2rVZz3g50cZXdLUk3Pw=;
 b=lj50G+2ypGZLVkANoOCUSfxe858W6iquD85nj0ER+yTWczQJ6Iizc1cs38y5CuVgMMxhUC/4Dq0oqzdXk3k9PEOiujcC+eN7Opw2hRDotBBhxu4P6TNNIVdVfUFh3Gj+5iO9QkjJRAGQPj4y+xJeJGU3JeOJa/vUDKliHpisGVgsgxwoHHLbjBzStztKikaZgs66ypE3a3szxSN0QcXGpdtYwhiL8ucMzmQOyO9ITAb+D9/jAtq2sMnrulfMXOtXUu1iYwF16XkgBMXz+qcnP2h3c1g1AW1SgFgF1OkNIzsboJXzf6fToq0dGCwcidN8WVxpBihxsSZbmhg2Kdc/bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LwVfPl/MvK64SAITJDJQeWL2rVZz3g50cZXdLUk3Pw=;
 b=1QNT040h72iGbMBxaiEd2IZjXz1Zd506m82rW9izNyneZeKBmf8sDgcikInKv76XLpPZ0/OfFmuYGqx1zVENwg7koEDe2fgN5h2PJsO6fusly4wAdGieR8GTZvwHFdFLUZYTaeWmfxOTeIuSNCq3T+s3TfR3nN0StvpIAnCWXC8RDSIiLR3kPoPfY0CzfwjfOlHipY4lwV6FKOVBkNI0lkYaenOromy4ZgIloa/hImKlg553URgbAITBiAp9pjDjW4+cRhELPsqJ9n9yhhvnBR4Hw8jgVzezU+r8hd1g4wkxJeyCt/pTwdkbFt2LbSSGDkWuxXP+CdhxkzAAc65sgg==
Received: from SG2PR06MB2315.apcprd06.prod.outlook.com (2603:1096:4:b::19) by
 SL2PR06MB3130.apcprd06.prod.outlook.com (2603:1096:100:36::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.17; Tue, 29 Mar 2022 03:24:03 +0000
Received: from SG2PR06MB2315.apcprd06.prod.outlook.com
 ([fe80::69db:d6a9:d891:e1fc]) by SG2PR06MB2315.apcprd06.prod.outlook.com
 ([fe80::69db:d6a9:d891:e1fc%7]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 03:24:03 +0000
From:   Howard Chiu <howard_chiu@aspeedtech.com>
To:     Andrew Jeffery <andrew@aj.id.au>, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v4 2/3] ARM: dts: aspeed: ast2600-evb: Enable video engine
Thread-Topic: [PATCH v4 2/3] ARM: dts: aspeed: ast2600-evb: Enable video
 engine
Thread-Index: AdhDHBAHfE2vG4trRFChvJL35pY5hw==
Date:   Tue, 29 Mar 2022 03:24:03 +0000
Message-ID: <SG2PR06MB23159B914BF7EF937FEDD2B5E61E9@SG2PR06MB2315.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d44deef-0dd6-4fca-00ed-08da113392e4
x-ms-traffictypediagnostic: SL2PR06MB3130:EE_
x-microsoft-antispam-prvs: <SL2PR06MB3130CADAA01EB54D0BF474D8E61E9@SL2PR06MB3130.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RvCTpFwzyW5sJ3e2uvULYkhNoA2x0aELsx22kAIgtoCDhXVgTt4mI9OYeZdFF8Q5p4t+f096doK9lGkT36lEJjvddNhv4nusTykrBN5vggecfOA5WJdDrB+OsK7/SAhTzOUd8EKipNObw3yjz+4B3xnwb2C2lbVSOxgpMdNC+ZwUtMwUues08/qUX5M7UtDCZrcrfa7nLi3NL+fg/B4cf3c7NYFfv3bHYPMOPLsEtEsMlIWuyZGktcvcuPMAiD6pmg7scHRE+ZrsNQMFsO4pwMqV+QqdjscknEDhMfb5p52iVVIB6xKs1K5+QBHT8pxos9FyTAzYT7nPAJc8bwhemyuGTxytwEDVGwolX8IcvgPOtU2N4fmDmGnP9Se3fJ7h3EwEhydNf4Oe5JmEgc7AXOOI+JDG/DsfopuPzrqmy+8xz64rJ2lu9zbOOd4XL2+d6VSO6yPaGO9DFTRwPveurf09Je1GwarH4c3M5JXPC7IAuWT8CgJ6DUJwd8rMWwiqzfG0VOCNgJG4JElkkvsBL/cAjeJRB7o9QDyc1Z0uzeZ/9t6k+iYkE3QSgcq43pZqTJc+es6uBtSfKDMdDHsZFEemMY0/pdNin2eUG1wPqTD98diK20Ab1yIwDHIhRZf/dNH5aVbA9qQQ/S0ezaAobxjjC6+4MzS7B3FsOu5gqScfQSBKwMFgBh0+/zUFMcM24kG5j23yxTI8OXJIOQjjPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB2315.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(396003)(136003)(366004)(346002)(376002)(39850400004)(2906002)(316002)(52536014)(38070700005)(83380400001)(186003)(38100700002)(110136005)(4744005)(26005)(9686003)(5660300002)(8936002)(86362001)(33656002)(66446008)(66946007)(8676002)(107886003)(4326008)(66476007)(6506007)(7696005)(55016003)(508600001)(76116006)(64756008)(122000001)(71200400001)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KoAHxHqptRvOYHBTF6LvdfilJR80jWjMJwl6kiZU9qqhrsAaAW96c26KTvcD?=
 =?us-ascii?Q?fafDEDfKguwpg0PL3+zvHXzMSPC2+RLqAA9FIhNEoRq58RrMJ5Pb6bRdcOrg?=
 =?us-ascii?Q?RkdtU5hHb+xYtPUpKahbRktjP3Pl+keUQrc2kza4hyrkRKu3memBi3YUnuxv?=
 =?us-ascii?Q?y90RRI7ro0QADB6wwDqf/8hF5AcJQpUEVq7LKuHlC/ZMu3n9lSITjeutv82i?=
 =?us-ascii?Q?OJIV8rcylTiyhOOD7VUOnKtl5ewDU+qFqR1qE5N/nBD6yfQ2C65MreXTHVRG?=
 =?us-ascii?Q?OVsdcrLiQBEEebtUc2AYBVzNbu3+/tqtq7oKxVthaGebhbOGzJPlg4nCD5qF?=
 =?us-ascii?Q?DdOKNeaVg3D0o1ft6qjcPc+22jNaBeu4dFF2/X67NY0f/s1xpqOVBr5vUalj?=
 =?us-ascii?Q?zmZRydelgPkDoBd/KEqeBSt4wASy0+Kxszd5YRh9sMM8Ha48MB5DcMOKLyAX?=
 =?us-ascii?Q?ArWy+JFxNtjnX3WzZLQl76ao8nbCvk7X5/L8QWEU1htKYW5oi5gqw+7wbnwG?=
 =?us-ascii?Q?RQY7veyRfJXjEC39PAwVnN40ZccTfoKwRRoclUbVAdTHZOuiowNhQiCIABa8?=
 =?us-ascii?Q?Cq123hvBoNczca68IjIM8YcF6E7XK02wAXdists3K/FETgMgSRfAXU7B5Wgp?=
 =?us-ascii?Q?o62HM0PxR4eAMTTnEmwE9GQd7dje+aDXsDfdrhJgPBtT4Ymovx/pzUGyJ6Pr?=
 =?us-ascii?Q?sk/JZvTONVqz0XfNJ3Qos5PjtMD8r8JkD6yxii7NxRDiPMijLy7e/B5U+iZH?=
 =?us-ascii?Q?QogQgKnaIaPDm6euFRL03lXoWWelbEm0Kd10YjeRcEYTVwkf/ThNKE1UMt8m?=
 =?us-ascii?Q?6TW8FF6tELNk4+i5x6bXJEfBSbQi/Jv3UnKZIBwll6AOiFgnJBgCxbyFCfP8?=
 =?us-ascii?Q?6Mi5CoZqDvL1VO3UhxOjdpPuUyJcfe4AujFnps6DUFvpVEq4kjTCamyDFg+X?=
 =?us-ascii?Q?mTkf0fWd1vn7bacCAGJUhN4zMywNe63BhIOqbrPHc+hkwN+wHJO9949nED1t?=
 =?us-ascii?Q?xS0syKo5BN3nvWuK9DAKQWd5Hsp7amu97LrllXOXa/hEdk/FC2oaWjoTC9fm?=
 =?us-ascii?Q?gc78rJ1gKMmJAYIf87QQFuDseuLTedsjK6I20Whz5/8Lj9L0SB2mqyt6J4IQ?=
 =?us-ascii?Q?Nccr1MKQCRDJHKGTJXHBajUCpG28ZRT3Q6LQKj1aqQMThqz9jGKysvs/fNKB?=
 =?us-ascii?Q?8kHlwfIezx4KQGY9q35IlNJWqqZ0y/bBjG6DFBV0OJsVDuYI69ENQus6jXQW?=
 =?us-ascii?Q?VaJ9kjaJHivMC4t9eVZ4MRVFmdCdcw/d0pJE3Mjb1LK2DTIBBjk7URxRCtnG?=
 =?us-ascii?Q?xfQ3Kl9nY3m9EXHSHNmChlhqplo1suR/xc12AjQTVD6rRUBebCWw2evEq7ZX?=
 =?us-ascii?Q?2f1kNY2SDKULuDhtepRsK7DDx5Bqy3IEOGkknF4TmFNNxdrIAuoWO3nFUkQQ?=
 =?us-ascii?Q?wgPuIbvmswU+N+BAM1ZWeAjwiS31nTSwK2pCu2P+jlk2MLhtPxCM6RPQoMcl?=
 =?us-ascii?Q?cagCLuXqh/oUP8ffO3QF3PZyC9Lo1DVVhf0ZM+P/1URs5W7JgwJxpcW2onMv?=
 =?us-ascii?Q?xm/WU+TYexOPy1aQRtTtJm515I51zoxBa4bNxwjyBU6JHD6aCtah/0Hnh8nl?=
 =?us-ascii?Q?UcE2OvW4EHNMLGQl2Y+ihaAAwPklOYpcQ6qxTvtrfo4l1JU+ap31aNc2TUm4?=
 =?us-ascii?Q?gO7cJjXY5SQ794SNOLGyV/YXeoRv6AfMQajzxYmghvVrI5Ihcpc5340cypxt?=
 =?us-ascii?Q?Wr3immasTIOqtz9xGzWZWC/T8ZKpeAI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB2315.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d44deef-0dd6-4fca-00ed-08da113392e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 03:24:03.0360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E8E72bFVIKPnqRzhHTbBnB6ihgPfFRoF76FXH8NaR4ojkIKWo8t72a/IMZLG67WVPoguUBgpSbKJJnDP82dJXblaeVbW4LjgHzOkXNjY5vU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3130
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable video engine and reserve memory for it.

Signed-off-by: Howard Chiu <howard_chiu@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-ast2600-evb.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/a=
speed-ast2600-evb.dts
index b7eb552640cb..158b88f38d2c 100644
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
@@ -300,3 +313,8 @@ &sdhci1 {
 	vqmmc-supply =3D <&vccq_sdhci1>;
 	clk-phase-sd-hs =3D <7>, <200>;
 };
+
+&video {
+	status =3D "okay";
+	memory-region =3D <&video_engine_memory>;
+};
--=20
2.25.1

