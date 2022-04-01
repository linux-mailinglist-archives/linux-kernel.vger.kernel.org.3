Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431E04EE8B1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 09:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343590AbiDAHBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 03:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236804AbiDAHBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 03:01:03 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2092.outbound.protection.outlook.com [40.107.215.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F244DF6F;
        Thu, 31 Mar 2022 23:59:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJYglbPrblvDPa1jONrWUoubt1u7hVaj3/Imi0baLMSdtHy2pkrtBtXDhScpoRHJX+j72keBwL6tCbpW5h14IpA2Rfkd2XS5nJ5dXjuIwkHLEjXdWw27ZpC6gwq9P8Z8C+ctAsVHYi1/INe7lDs+fZ3fz7iVwylBgtPsF22t6VTIbbosfSFCqwhLwls+9pfyjWvFZCm0Phxvxq27MRk8AK4yVEd82Cqa3wR3wEHvQremRnJhVntRQzxHwLNAYu1e1OCRxKvlRAoz9T4H3B2kCplcI3HS0l5lv5l/D0eM4ySzZudSBv1wkRgDZip3JHrftW8ji00GwvbHKshyKivRIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JC7tMFJ/MmxZ/u6S7JZQPeW1PjJnOR+pOhPELMddWZo=;
 b=auyj7IaqkS9w+1eIOy/8Mc67lMXvURFHLFaT0ADNimVogd9ScekLUgJf4nCUa3H32/GIjct3FOMYGAMrioKvTw5Stl+sRBCBmJHz1pLS3fMGW7HmxJCO0YsU5uzhTXZ22BgEZwoQbrssoHTUZeJtMDphev+emqbMGb8PJyy98j7ZTXOZg89MW4Qm/OSLrQGHUfa3nt6iP/EfT4jZl1fJiySLeUv0gK9dhWS4MD8lpPWyYHne1G0a3dHXXDai+nCf2cNT6JBYsWyEqzfRdJOz/wfxW00KbTyXwgcGfjOKl+nTCKErjJdP4iv22uH2iIYfFJCt1e3uffRgUcrPBf5aCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JC7tMFJ/MmxZ/u6S7JZQPeW1PjJnOR+pOhPELMddWZo=;
 b=10zwgEef+3Wgc2bxI3KgdND5hwHXf81+VzCr4PdZKzEu6hC/JUgXPMBWjRoCzWY3Fs9au4FYbancyhjytyUrMMMaZEAB/nslrcygiy4EXosVgWDXWjm8ZAykajMftd/v8jLjGjVWK5zWDZ5X4Wzy6R+SVwwzvY5L750JJh1Wlv2J46VZz1YOs4/uDL+w/HeSgqxFcNgbns0muiTZHI+sckIBancb0cL4ejN2w+CDhkbsFDX1Ae6sx93wgOABhFavG74yiQIKHTHDijbzhaWbhYdy/v+asTDUTLavsB+xINjMXror/HB213bn6nTudWzjgzsT7RWgTMnMJQjlnG+T3w==
Received: from SG2PR06MB2315.apcprd06.prod.outlook.com (2603:1096:4:b::19) by
 HK0PR06MB3043.apcprd06.prod.outlook.com (2603:1096:203:87::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.25; Fri, 1 Apr 2022 06:59:06 +0000
Received: from SG2PR06MB2315.apcprd06.prod.outlook.com
 ([fe80::69db:d6a9:d891:e1fc]) by SG2PR06MB2315.apcprd06.prod.outlook.com
 ([fe80::69db:d6a9:d891:e1fc%7]) with mapi id 15.20.5102.023; Fri, 1 Apr 2022
 06:59:06 +0000
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
Subject: [PATCH v2] ARM: dts: aspeed: ast2600-evb: Enable RX delay for
 MAC0/MAC1
Thread-Topic: [PATCH v2] ARM: dts: aspeed: ast2600-evb: Enable RX delay for
 MAC0/MAC1
Thread-Index: Adg6q5SUIZgpr960SrG6YRlAezQpnw==
Date:   Fri, 1 Apr 2022 06:59:06 +0000
Message-ID: <SG2PR06MB23152A548AAE81140B57DD69E6E09@SG2PR06MB2315.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47555155-3619-40f8-30ed-08da13ad1d23
x-ms-traffictypediagnostic: HK0PR06MB3043:EE_
x-microsoft-antispam-prvs: <HK0PR06MB3043DD62001FF84D5DADE6B1E6E09@HK0PR06MB3043.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ulkJGHn3pDNNfsG3PoNYuTztle24AJQaTTlneUE2L7kDm1egkAs3Tkc/K6BY76KidcqbbxOdyCr3vPRXrQ/jUaX89aT+jnXpOegejO3aD+V0UECqFkhTZ1um9nGpW2kOOZE7vyfg+NQRymn2NWJxVLhLvdIpVwOMpA5To6LgxnDjK3rpBQ+o4jcWlmVndmuB1WTU2SJUuZ5+W1cDrWkplCeJyXMrytSwxRSkeIGViUdgWmSninnP0HrKbzwmAUEXH7xmrbf9Z/gCfKl/08D24Db76zJNfr/clQ5sRmkFNoV0q1CtTX9TrntSzFZ9epNtVNoQtE6q30RBqDuGFCdH9niDnRI8Vr7IiO4QJvqFU41a8PbFSoBWKERRf3N/wDdBSpDu+XLN4Vp4TgtTpQBBiKXoSwR8VpCzBN0+2qqyx9pHPk6rI7L9+gspS4TzaveUEfs+lVfo7o6kdkm98QuGKqyJJmewT/nlM7CK+mFfONckmSqIxHR8e6ht43Dhk+vyfjaPb//ljDuEm5bH9OwJaLSTrWM4iNVpsuXFcOq7o81y15MLPh5T4qAbGaC28gLuHHeSanFRcgl39qbGRkpsKYnE6deSalI7HiBNGzKD1RXfoqqffERCKXJN20Kb6dzj/33uG9SCvjVtlfQoC2/lsz9Iukuw4vu4FT1ifzQJNIkBqVSXI+Nbm9WQep2LwLKa4a3dTfkI2khoUmB9HODra2s0ME0RF5JmIUs/yFPKbY7WMCxeZztOSbAwY6pM3l4WDhR9V5epNO5xtkXW0DhsX5sr4yegE+Bcbf8+oGEacL8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB2315.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(366004)(396003)(136003)(346002)(39850400004)(122000001)(508600001)(966005)(9686003)(7696005)(86362001)(66446008)(6506007)(66476007)(2906002)(110136005)(66556008)(316002)(64756008)(38070700005)(66946007)(76116006)(5660300002)(4326008)(8936002)(52536014)(38100700002)(71200400001)(83380400001)(55016003)(8676002)(26005)(107886003)(33656002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SJpDP0lfjVwXJf4QPzeUYaWAqTP6rXcIoL4/MOJJsFoDd/JZB0U4ME4ICooV?=
 =?us-ascii?Q?W/+EG6fCvDYxUguIqkpZevR8B8W47HCjWS1jJh8CJTjYRRpjwDifYk7mim/j?=
 =?us-ascii?Q?fVO0UBR0GPsJfLOgu8DJhWUxnYfzbVjicVG/Wk1FP7wlMP59qhuNrURkwipf?=
 =?us-ascii?Q?vw6Pb1IygH6SlAB+lIPDNRPC81KO1zUqJ6N33MdvPh3jDsYWhKzg+dQjvuMs?=
 =?us-ascii?Q?+Gjlv2A6HmIG8jZ6DChVGeSyKkdb30beUQpN9cH6xc3CTzkQ/lJ3q+LHtf9P?=
 =?us-ascii?Q?cvUIp13KVwv0ly8WO0WSVE5DK4mNgrKULzKbf1cRIRaswBprwq9jn9+YYPUL?=
 =?us-ascii?Q?/q4heifZ+3EAdbsKqtT7UNn9a1w5NMZBsjjHzba6RDMAMKl6jpm9H/srgjAq?=
 =?us-ascii?Q?DiwBpHwt0Vt6TsgHTs3VPz6oHGxDlAXOplGrn85g6XMi8Zjm5+qfsCsUKavC?=
 =?us-ascii?Q?vDqlyzkaz+oLXz8G1oJ7K/DgowtFDm9g/HjGOIDm/GEiXeNcsrWFQcWOwHln?=
 =?us-ascii?Q?scaU3rAUhsLnRjIFA6N/UjSw28hMOsf4jlD76kgbuVr54hXtdSq99YgHsvIU?=
 =?us-ascii?Q?JdnoHHPfEeLYSrMat8boQ7clkEYrZTgSVZ2dawXl2jwlEEoByqEKdfQ6nyjc?=
 =?us-ascii?Q?/rWlPC08/KQaVwQ4PNmo2yNxiVbM4rK5q0z1dckl1/puYX2TL3e4cY83IPrD?=
 =?us-ascii?Q?VUOqlcZ45aW4jY1yLP5IsDAAgwKzurDbHadsFZkA4IKkgo8oWyAaUETcsj20?=
 =?us-ascii?Q?uFRfmptJPqWl88fsBdDk2hNTiXLswJBOtfQ+dC1iXIEDFiKR7emZg/r0xD7o?=
 =?us-ascii?Q?9Mh8iTJFHk5aSvmCCGkbWElGErbl0fkLfnmpQH5gVYwCKLfgVnnFpFo1dJkv?=
 =?us-ascii?Q?EVSYaL+HeAEchch/zGzhmqxV/TxL0KFl0D6xfes2nwnCdXxwqlaGurejfb/y?=
 =?us-ascii?Q?8jkO1ZW7eHAb2FrCvQMwhkGOdgkwSu5CH3aE9LpH5C/kXWS+c27UOAEdUjUC?=
 =?us-ascii?Q?2fyCaTgVslrLgyDR9L+vjmQLC2RxhxVkLThHE/wKjEbeVsQ7Tfr6PPNETlDT?=
 =?us-ascii?Q?YEOLvCwG/TOcO4fqtHxvMZ/sp3TU3RzgyApNhqQQg7e5IwBZX+W+uB+yrvc8?=
 =?us-ascii?Q?l7a8Om7qewMwWQ5+jVNIQ0IcBT4hMSN+iGf8SO3vHGeskWy5KYXWkglygfMk?=
 =?us-ascii?Q?41uBzDwrF/7IdvotJBg6MEc++o5gn9hfytz22ZP8RY4eSibl/PplfIFtvRJv?=
 =?us-ascii?Q?K0bl2SEbz+pFdi/bCqaFD1k41X30wTZYPmRE++balpNR9upQqn/P/b6cCd2X?=
 =?us-ascii?Q?qO/pvicn/fuGcyUTOKjWXj27OZ0kYqoj3eXW3tp8xatTx+mFqV/JJ+BfMCc5?=
 =?us-ascii?Q?QsXpRJ5EXdLtTHjehLrTzp0MVASVLUmUTWKzQKYFdXUeooWlt3jGnnOJQ3Ei?=
 =?us-ascii?Q?xO9DfWP2JmQOG4HE2fKIgyAzRgPKlUM73ljROCDO0o610nMezZPm2ez5DU6+?=
 =?us-ascii?Q?rzDhKkLb1RY7aJeLQi83w/qpQbhBo7b6YkZ2JRlqMcZoiWMcNPACllwN21H0?=
 =?us-ascii?Q?6RDQu4ijQvc8HRMkj0h7wyR7tugr7XeXsV/xKqCB5eeEi+dETDGcOo+kd+E2?=
 =?us-ascii?Q?gMw7c0ZFQiSZZHgctaLMCBtBwIpBm9PRjmwI2z/e4taHEiwfMc+fqlEyHKri?=
 =?us-ascii?Q?0Qu5x0uQWdodXcwG7bdG0T2j6oPg/HDwzZgi2GNVGJrhQdvZ/3AFUI8uusn9?=
 =?us-ascii?Q?Kv4AW0IMsUJe2cVCL8EVWgeKulEndF4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB2315.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47555155-3619-40f8-30ed-08da13ad1d23
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 06:59:06.1399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n4impXghB+Z1100hg6Eiudls4vhvdv533QS8xV6oLoPpf5HZvOSRN/Bmt37uPUcTNZLhsPlO1ohU7nNE6oilaSxd2SMvhP9DnYJhumsbrjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3043
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

Signed-off-by: Howard Chiu <howard_chiu@aspeedtech.com>
---
Change since v1:
1. Remove mac*-clk-delay due to lack of driver support

 arch/arm/boot/dts/aspeed-ast2600-evb.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/a=
speed-ast2600-evb.dts
index b7eb552640cb..788448cdd6b3 100644
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
--=20
2.25.1

