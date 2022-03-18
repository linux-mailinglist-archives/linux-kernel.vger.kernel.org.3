Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFD74DD5D5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbiCRILE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbiCRILC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:11:02 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2132.outbound.protection.outlook.com [40.107.255.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02648C7E4;
        Fri, 18 Mar 2022 01:09:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APp85Mg0nBONQApPOWzyiJ2OP53QXEiyCiEbeY8QxaEeBUqZdZoAeg5632bVGAyISesTJ2stW8jSHKLjVUPFhfvMVD82L7/4EBn7eyvJv2apPU4Tu02O0ct7bCfFOKafIVvAPneUfj7Sl+M8EaLo/KQDslJxjZtBUo97D0kZ5B5g/bp54DOfaPbbOLswy7RrquCFHa5/9fVgqg+i8Nz/RLG6CzYhbaLOSDF/EUclZp+YvAJefBVr8hiEwHMHKQbgyNOqo+oKEZlYbYbg23MDCsm1G/LHzSmglfXARqQkcFkkViBbObO2Ii4xhj7eNc46NMKKwxjU8eOBr8yNIAUGFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5Jqp/4gcFrm3UGXbXyrognXL/xFgjXEti9YxUQ6Ot0=;
 b=B1yJvjzXsTbk07/xscsL7RZ0cN9BBdhDN24tuHqE4Ui6qoNYHDHkxlb2YnBxLN2YPFBmCQ8OgvfGiR3kna4BjUaLMVjaDfrt/WQ0LrDwYW/Pq1njcYqnvQXIoglHONLW7Dv2XbUxIAIJPq1uw0fFoHRBNrLNZp86DseWTMZnSTJ2DoudYk9wmCzOtV8arPiyC8wz2PF+Z1o6hQWKK0IdQUtfsB46lrq6SqVcv+i7ZRuE3265U1580Fze+OB0wCH+8nVqmz9WSewtrMrWORLLWVMPADXqCnEIEJ8OLjCsvLy04yll54/J4pIE+1qy+01Ak0N5Asc2nwqsjJ/aYMHoVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5Jqp/4gcFrm3UGXbXyrognXL/xFgjXEti9YxUQ6Ot0=;
 b=DYuugi8nkD3XQVUn6zRU3XI9LWK8tyxdiT4xL7IKMYPKwRpiBeTwe/fnw+Z8MvqsKvtrCV41MbXLNWcrvhG5h5jFOx0z4JYmmeyNCb83Tq3zzgPjoucKmMY0z94C2mFAa1Ovo3RIz92cFLL1D7zdgzsEsn8HccwnXRTAK2xpECmXUXBfcjBbTBo/hX/fiWZFHaXGEQBciOjiX4sk006YJdiLbAayVin68ls64/3aPXr8XAV+w1q0ScC0stT2ZN+pOeErr7Ni2voeBSBmKgIqRp8qbtul1eg30aZFpjVvHG9MlGviPPBAufQo8+rwbuYDSuH4X7PocggmbxOu1f65EA==
Received: from SG2PR06MB2315.apcprd06.prod.outlook.com (2603:1096:4:b::19) by
 SG2PR06MB3823.apcprd06.prod.outlook.com (2603:1096:4:ae::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.14; Fri, 18 Mar 2022 08:09:35 +0000
Received: from SG2PR06MB2315.apcprd06.prod.outlook.com
 ([fe80::ac36:fcaf:45dc:f830]) by SG2PR06MB2315.apcprd06.prod.outlook.com
 ([fe80::ac36:fcaf:45dc:f830%6]) with mapi id 15.20.5061.026; Fri, 18 Mar 2022
 08:09:35 +0000
From:   Howard Chiu <howard_chiu@aspeedtech.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1] ARM: dts: aspeed: ast2600-evb: Enable RX delay for
 MAC0/MAC1
Thread-Topic: [PATCH v1] ARM: dts: aspeed: ast2600-evb: Enable RX delay for
 MAC0/MAC1
Thread-Index: Adg6mrvEVaC9ZcljR92LSXIT/D+xfQ==
Date:   Fri, 18 Mar 2022 08:09:35 +0000
Message-ID: <SG2PR06MB2315A7BAE2F1B384CDADB57FE6139@SG2PR06MB2315.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c959ac70-e38c-4975-7afd-08da08b6a3f2
x-ms-traffictypediagnostic: SG2PR06MB3823:EE_
x-microsoft-antispam-prvs: <SG2PR06MB38237FF7F2923AA7D081DA22E6139@SG2PR06MB3823.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lQamRmCZhxvGDqOdCYOQYcHRs1iI7ko+iEwl8qwFYc2NEZIrTr1/oCfmumScL9aMhc4JMayBgEYKHIHYqW0ocoamOmjM3h3A4JnL4mfKC6Mx1SmV2qGL9Im4fsKUtRjqnCiFGMoGO6i/LJUor8HsQHQ6CiA9a9ZUIPVJWsel0H8lYp+V11nw59+JomFzK79ck1kKYCi2goJmZb2CMNKfyO3aMxD03HP3YaeBOQOg/ayx3aPsNbqQV+shWGc024pYBLm/5g0bK7gBRr0iQBFNLT4kmgPrbNBI7SrDhjQ+4cpNyy1azEKGMv4w44V4l0DqyqMG5uk0APgDPyc1o/NH/HPWP0QEBN9fCXacJBczUXPIKe2D5jUSsVLG6Z9JA0T9pCu/LF8WITCMbuI1jeduMVixGv6OlE6hxrbr+lmjWnDQ/+aRg7NHLOMFyKhc1Yhtpuciro3wfJiPsOPuTumV+Lxy0/hvnCvY+ureqbmav8FeN3C/hH1AsX6HICso4S5eVJ2WFVf8epnVBPsiIPnaEDOxvRcwI7qR2h97DoAHfh4RUzaVz7O59U3mYDjNdPJncQMroAnMt6W8gAkRWqt0/CafD0fRV5p9IJ+xttTg5KrNgi6PmsfvxM9Hz1r+OL/av5LSGvipoe2jdl/UGBeotaoBs0jPspqX1NbZDE5rsqW8TQ7o8VRexZFJ41eTBFceezielBTHBlwavYngloqEqDCURC7DW2bM3yV8OR0QXPY3WXzYQmYUJH4qAZ10bNdhohVPA8FauojmfZY8xtQFfocQJ31QGsMBBBCg7oCyFbk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB2315.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(396003)(346002)(39840400004)(376002)(366004)(136003)(508600001)(107886003)(76116006)(66446008)(4326008)(64756008)(66476007)(66556008)(38100700002)(66946007)(8676002)(26005)(186003)(71200400001)(966005)(9686003)(7696005)(6506007)(38070700005)(122000001)(55016003)(110136005)(5660300002)(2906002)(316002)(83380400001)(33656002)(86362001)(8936002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DlYvnwgb2fbAmpS7DF9UYGORFClbZKvIB9hHZDE0WGBDarVSeOt/LY83oFzo?=
 =?us-ascii?Q?b7vODTTBSA5dopGqtlgrgvR2HCJ0tt1kZUCycz6Zzt016ttqvfCvl86bzKDY?=
 =?us-ascii?Q?nGiUEIhvop0RuU3tCcwejItFkiQf687/VRqxtddF4P0m7fxQ0lr11gytYPeo?=
 =?us-ascii?Q?Lc1bhhwa53j/O0DdrQWp0TghzjWmLiFT4r8YqLixwGA6wMdyN6A1dtTSeAEV?=
 =?us-ascii?Q?BpR2eFiy2z0afevhlWc0GRRxLPDptUHzBjThYcKH96jLyG5BAbq4kG9X8JYY?=
 =?us-ascii?Q?Pu3i44WWvEAKrhxiq61KYbEBR7QV0XwONkgjt5n77wSLxDBEfcCHt0vtm4e/?=
 =?us-ascii?Q?rsR32auj5MvNlnvcxX9N8o2aZ97RF916R7ZUHdu7eVe8a4G9NK4NVzg4A211?=
 =?us-ascii?Q?Fy67UdS1NBMHDz51SA6tXOuC3cQq9J6PfD3T6hg7OWhDvbHTZbc977ljt7pw?=
 =?us-ascii?Q?9lWCI2EaIu3yUs9uQEKRbU6hp8X7B/yAAsK5Cq5xzZzL56TQBIWw44qJe3tM?=
 =?us-ascii?Q?PCYt6bYksqlBRwlHkVC+rFO40eAPO+9qAjGD6yTH9ibUWbamXx3hxjXqtt05?=
 =?us-ascii?Q?fTS01vNILDaKiwSdmiptWeT6wLy/9L0ShwH+FU4oqWUih/hQlhrhOyTTI8Qa?=
 =?us-ascii?Q?qtQioWU/UZsRZzT2Q7kcsSZlZ/80TGBBTmheIXg/aaEoD0h9swil1zB739yB?=
 =?us-ascii?Q?xkUHVG7tRQhCyPwyz+oTdXkZEd6p7jAeFHQODI90fdoLrctB6+BfAt34YWE7?=
 =?us-ascii?Q?O2h8mm7X34RbV499B3VxGLDiMu0pS0O0jlqAizUt4JKqqZl0xrIkdybf9Jds?=
 =?us-ascii?Q?GzL0u3AcScZ1Fz1dhuaiBAwyjamCJUFefsxJzDsF9IYxmYOOMWEm3nnSGgyu?=
 =?us-ascii?Q?TZVGf4U7T3SpzUrRh7uTM/seUfzBiuc0/rsG4H9YRmq+HeolbgMU6jXHjOX1?=
 =?us-ascii?Q?hsgB6LNw4aiGyZRG0127XFYxHSC44/1QYnDQI/CWqOIIrria4AGjJWKaCI87?=
 =?us-ascii?Q?wAh0sAZ3BayOoYNkelCz8X6xlZSkXm8DCy2vTIO6BBkPm/spfAJm4KKyx6vm?=
 =?us-ascii?Q?DQegYd55iCzQycL1Bzevh2C2v9xufArOdJOgD8pX8//+dZ9/bKeMDQh1QKyv?=
 =?us-ascii?Q?oigpFxoqyH/p9uECs7D8Xk9tWt/8Z9LXAmoY8NGt4nIfv3QzdcWDZkK1OC/n?=
 =?us-ascii?Q?zIECuWqVX5UnB5sRiG8Zn4XjyF5jriXZDanRY3lGrVMHKx6BEps9cY/vmfrT?=
 =?us-ascii?Q?Ojln3QLyVNosuhpWb22zA/3UU3RIujgZNh+iHLL46RSaLagArjuVNaIB/wbR?=
 =?us-ascii?Q?mixgJWQpykqoJ5LSiP1dt91FikSQHDmpNgjvP/ABVOQPlhb8tZxgh5d9L0VL?=
 =?us-ascii?Q?igesNBZAG7wU6SSbhDKpnUDEGHdtXe5i4CIIqrNxh9nyaxv0zlBQa2I3NCAO?=
 =?us-ascii?Q?avr8z7vb3+EJsoe7v+dmKdYa2jSRkUVF254Y7zSoUHbqMuAy9oPLFA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB2315.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c959ac70-e38c-4975-7afd-08da08b6a3f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 08:09:35.3681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NsNaXlU/GOh2uLkxy6wWhLCZERr/y3+n0SNLMJTSG2z3qS+q4ReNOFx6hVbFTQuQ7nOYbmKNbUCEuCH3PieuIlyOnQYeEuROJEskcHZTteQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB3823
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since mac0/1 and mac2/3 are physically located on different die,
they have different properties by nature, which is mac0/1 has smaller delay=
 step.

The property 'phy-mode' on ast2600 mac0 and mac1 is recommended to set to '=
rgmii-rxid'
which enables the RX interface delay from the PHY chip.
Refer page 45 of SDK User Guide v08.00
https://github.com/AspeedTech-BMC/openbmc/releases/download/v08.00/SDK_User=
_Guide_v08.00.pdf

Set mac delay according to the mactest result.

Signed-off-by: Howard Chiu <howard_chiu@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-ast2600-evb.dts | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/a=
speed-ast2600-evb.dts
index b7eb552640cb..db16ba307e97 100644
--- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
@@ -103,7 +103,7 @@ ethphy3: ethernet-phy@0 {
 &mac0 {
 	status =3D "okay";
=20
-	phy-mode =3D "rgmii";
+	phy-mode =3D "rgmii-rxid";
 	phy-handle =3D <&ethphy0>;
=20
 	pinctrl-names =3D "default";
@@ -114,7 +114,7 @@ &mac0 {
 &mac1 {
 	status =3D "okay";
=20
-	phy-mode =3D "rgmii";
+	phy-mode =3D "rgmii-rxid";
 	phy-handle =3D <&ethphy1>;
=20
 	pinctrl-names =3D "default";
@@ -141,6 +141,21 @@ &mac3 {
 	pinctrl-0 =3D <&pinctrl_rgmii4_default>;
 };
=20
+&syscon {
+	mac0-clk-delay =3D <0x10 0x0a
+			  0x10 0x10
+			  0x10 0x10>;
+	mac1-clk-delay =3D <0x10 0x0a
+			  0x10 0x10
+			  0x10 0x10>;
+	mac2-clk-delay =3D <0x08 0x04
+			  0x08 0x04
+			  0x08 0x04>;
+	mac3-clk-delay =3D <0x08 0x04
+			  0x08 0x04
+			  0x08 0x04>;
+};
+
 &emmc_controller {
 	status =3D "okay";
 };
--=20
2.25.1

