Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F724BB756
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 11:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbiBRK4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 05:56:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbiBRK4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 05:56:17 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6EC237E4;
        Fri, 18 Feb 2022 02:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645181757; x=1676717757;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kDwtqhHCH7IkgMztYszHrKxEh/4gSZuaQHT4TA+pqmY=;
  b=xz/UUZGGlh7FKk0rgsE0T9Mf4k9Ewshregx7VVxI6+AmTSPN5BAYxmMY
   siuON04JZ9VBCZODl/v4IQ7pNfg0HUb86EAzodmqHrN6tmV133WBhMhr7
   LSkz0NOrxoz2w7mcrjtYlzVlHRnEe7xuiy+FY37jXjaG38yiFImCZnAJe
   EE1Toatf7e4GYd8/se6m719omMOFqxU0aL9T967VBkh/ViG1b4bf0Qppy
   aBl6KhjFDqLggADX/sXudsx5RAVmzBdjaWiNSBYbaD9i3Nr9C4Wwf8fAa
   ar/yASDxbJaksYQMIWbwT/YHjhup8vB4t68iuiqhihvXI++1X8beG5I7e
   w==;
X-IronPort-AV: E=Sophos;i="5.88,378,1635231600"; 
   d="scan'208";a="86232341"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Feb 2022 03:55:56 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 18 Feb 2022 03:55:56 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Fri, 18 Feb 2022 03:55:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwSLYoClxtwaEQ0CV1hh1LPEVHURjehVEgg7u2omW9+CURBwN+wadfqJAU+iye2+NkWf4Xb/wGHml/HQUwab+ZmOyuutnGTO0rLPL46nm2Y6MBqEoVGssEr8fBvJM0N0YBoOwyoioiRznSnIdP/k0sJoCrLVcdHC76AFnYBtmzvoEOrnc/iPkNLIKKKID6BND7h0pedXxR7CaaV1fHXas8k9bV66WyhTuemUUlRYg2IUAAacnfjeMjukJwWqyKI96QRb4qr1MP0hVKXDZ/xGBTN7N+hlRqQhfqSs7wvma9MHQEBhW8fmekey7cVl/+8qvpxW9maIdEztPoamHOvcNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/gU7qbM8N7yYLR+LNIQqGr5XegAHFaKDC9G/wp3Upo=;
 b=empf1efJUslHmIDH3UAKw8hZrMgC7vBsWJwi/3T21iRZg0XOx459t4uFl5AuknufAsO+uijlryctvVX2IbkhaAteOKNTwbQwURe55PlPQkumszvDQXpTg+DzYEOC2GTAJ3PcWObcbazH8f59ybr0GwaL8NT0lpzK2N7ad2NAgF1YC5DQF5s09nplj0PbxRRVEFVCfRDIj2xg7Ytbz0BpIp9VYqV79Gnnh9LmB62+cMYO0FGfhkh8O5uxWH/ICS/pZ5+t1z1plSr1UOpJTHNS6eta8BWiyEY32NRoMNIqQfqTd9F1RwVV9wSsXxHU9H8x8Yj8cCcR/kZzA5lXxR7AGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/gU7qbM8N7yYLR+LNIQqGr5XegAHFaKDC9G/wp3Upo=;
 b=PMt3jTE90Y4iPkPW1wcUcwrI9cIY7pSVPmsDob4HKx+hqvSmNOWjfcagU1uNjykwXvBQVxg+6m4OoxbUL/EIL2rNWxHHQTEINEtCTHK9M6eAgSfoHdbE/uvY1snAgLdJIwHBAaA3q4NMS3W80UuM5EUlqt3kkjXJylmq8KwbuFQ=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by BYAPR11MB3080.namprd11.prod.outlook.com (2603:10b6:a03:8c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Fri, 18 Feb
 2022 10:55:51 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::25bd:b3c9:a714:cdce]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::25bd:b3c9:a714:cdce%6]) with mapi id 15.20.4995.016; Fri, 18 Feb 2022
 10:55:51 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <michael@walle.cc>
CC:     <Manohar.Puri@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <alexandre.belloni@bootlin.com>,
        <arnd@arndb.de>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <olof@lixom.net>,
        <robh+dt@kernel.org>, <soc@kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: RE: [PATCH v4] ARM: dts: add DT for lan966 SoC and 2-port board
 pcb8291
Thread-Topic: [PATCH v4] ARM: dts: add DT for lan966 SoC and 2-port board
 pcb8291
Thread-Index: AQHYHaYU1qtS5sG/10aA2sqGSWL+96yLJtgAgAGTrACADHZnEA==
Date:   Fri, 18 Feb 2022 10:55:50 +0000
Message-ID: <CO1PR11MB48656C16015281F79675809D92379@CO1PR11MB4865.namprd11.prod.outlook.com>
References: <42662481-51a4-2a4b-e39b-d3b8401cbb2c@microchip.com>
 <20220210123704.477826-1-michael@walle.cc>
In-Reply-To: <20220210123704.477826-1-michael@walle.cc>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 470853fd-55e5-4f23-2110-08d9f2cd3a8f
x-ms-traffictypediagnostic: BYAPR11MB3080:EE_
x-microsoft-antispam-prvs: <BYAPR11MB3080853B6269352B742F4A6192379@BYAPR11MB3080.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5S4a9/CISrRKf8h7OWF0h2/ozKrrHWSPWniezzsD8cOh/aOYtgAdyFEn2mG2p8fcwS/xlT24hiPUZvFlYWFlFfGyELcW5WQdBz2UCvBpLRwIwvr9ZGWcIyPdY2X9xc5i7+qM1w6Nv+cD2jocurJfOb7LwK/lZaId2qsZ54hygMbrDZJYkz7WwFsgtNR/fnbCRdAgrptKZGTsJA/hPVkSlIVKTJwst4Zb2WD1xlgWTqx71+GiysHKD163KE6RKGQ45OcySv6ZoF4ndSmqGV3NOsFEHTDpdBnuUZXbgmQcKOJ6E/g494E6s6UDy0pzpD5IxmJOPPoBZUZUDUbXuAVSU4KigMW8WOCe/TGeolIvNsyNKzSFptjlu7uQBxrXiXGxdQQu98ilUHv0v1fESmi5xqm6KXlrpJpZW2o2K2O9ynFKFKb7Eskxj+BkrfEXHSUX2CrKHyKlOfO+Huuv4QKDjZy8tAqXmGjoRF1hASwQGZDb2IjO/t4V6tDiKRkBz4k5kWspCL/XMVAUCP8FU6gO1xF9uS6qaVzqqdzSlXThr8aFOoCBKeb19c0nZI2tX0U8IVloIn9aW+FWUGrbmZZ193IwBSYEAih9xG5TSaUY3xnxtDIcjjyVSEdpoPHC1RveJg/VZPJLWGFONQBFQzgLXEuPhmu5SFySKIRFdIcLYz0Cqairvv6ruLyLp1EzIQY5ABLnLS467jAb0K1Kn+Z1NA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(8936002)(107886003)(26005)(186003)(83380400001)(76116006)(8676002)(66946007)(64756008)(66476007)(66446008)(66556008)(86362001)(38100700002)(6916009)(55016003)(38070700005)(2906002)(508600001)(5660300002)(71200400001)(33656002)(54906003)(7696005)(6506007)(4326008)(9686003)(52536014)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xvXWYwLFFTQkfcBzQ0iveer3Z2Ep0Fa9cbTSmQjGIQm/1EenmnNU/qCpnBbt?=
 =?us-ascii?Q?BtwU8G4Ha7Nlfb2qNhKajFkQ2FGuQfbKMW4u2NKe4BC4gVYAPURbEy6xexKy?=
 =?us-ascii?Q?5XIF39hEKnwPQ86F0IHzpaNJarbNYvi/mKGHQNPwXdq/H+2W2hR2nCnnS9O+?=
 =?us-ascii?Q?NNxA7zguq9VYK9Io3c+slu1CXobAASOvia2hox5od3gGJQweU0EGWpY3dcSx?=
 =?us-ascii?Q?jLoX+21cR9x5wwsAdfYJtmpZzsLWka8STeTKY3D0S1aA7G+YV7fGHvid+Y//?=
 =?us-ascii?Q?avmqFpDIsIgQprdq13xVYn9EE7JPSacylPY6KwRIxq58Lx1wufu2AsGe04cq?=
 =?us-ascii?Q?3xFX+A0iRSlPkYvz9dw6Fmtvl71mLz7MNPYJuiB/YtUuf23cU8QtHiZ3pEbs?=
 =?us-ascii?Q?7iyAWA62kYZNSO/ZZe0PnSqBUlv5kYQ1Lc6pJCULl771WU0nCD0HD5MpXliE?=
 =?us-ascii?Q?5jyHn4pWidtwBoj0PcAKZnr7bWscoTShFMezetQgvHIcg6seJFqqsEA7/Woh?=
 =?us-ascii?Q?coHZPbu/XAUseo5A9AkbZhug2onjgmCbShkM7jn9fL5b+rSk6XFx9V4bdiRW?=
 =?us-ascii?Q?Ky8l02cVseExRq3GrpRLeQoiMo/jAvOnZPOhypoCyKo6Yg38lycc05+4bo/t?=
 =?us-ascii?Q?SE3kOqS3AvTTPqJE7WThkYIM42fGKzZbJgcZVatVi0+Sls0sMnX5nuYQnfi5?=
 =?us-ascii?Q?IgiRicJ3ODUcLh3v00nnLWzlOEqYRFk67IG9q7T5sRBmj89lzp0i8qfN+HAd?=
 =?us-ascii?Q?aeVSQmy3ZWMn+rncs/Zw7EPoB0/F6/vCy5FqKLLrns4RbB5BBZ/Jz15V6rPw?=
 =?us-ascii?Q?eVUbymCs/nzH55Aa0ykBCgj41ysqSVqHADxwVovKMLRnkEeNAP9q6h98ROTK?=
 =?us-ascii?Q?hSOA88780o43j1U/8XBlPoQ7scKTEloLmJt5oZZlkB5i9ld+y9Gnr5WWriT4?=
 =?us-ascii?Q?dDSAuZL2oaz+QQUXfS9HjvjzeGrWiEfJNqU6l/+5/mPOpeNXEWCXT/cmB9Vs?=
 =?us-ascii?Q?hLoSNMmEDOq50S3ZhI8en/IY8C0D73M4Hf4v+02A7U1bLsI2/rhjsz2HbjJP?=
 =?us-ascii?Q?u4qRhZ1ZkPYoNMskIRtyRjXNIgCHRWoTtU7WhIAoycOHu/R0zvWFuVZ89i21?=
 =?us-ascii?Q?qMf/TtqmIz6JEkZGp7KAgqEcdRtI8Rp+vAI07RC3xlgIDNzKnJIAu9H1V77u?=
 =?us-ascii?Q?vYmYNFUpzApw04RPkiKRzt14+Gsrqjor2w51J5EWystkK1FMmJGTX8agXRog?=
 =?us-ascii?Q?pTlP3rF2gB2xply+C7mZ5Fif+0Hw3BAfhJ/j1sdqBvu2ttvMtjn3y4mYJpYW?=
 =?us-ascii?Q?Ku5v6TutCMkaE2jRBLooxcISuxKOQ/n8zG01WfepqmL0I/KNKeyzrY+/hkcY?=
 =?us-ascii?Q?IwM2WxmSC0igMq/syq00NGLnR8mOdipFOg2DUHY7KDMxRavnbUEU1lfxbtPW?=
 =?us-ascii?Q?dmiSW0vmmH1KfpYQN+RjM183gtIF4ro77/EJLpZvoWxdab/liTw0TfdTXdGH?=
 =?us-ascii?Q?vJmIxmhL/c0iiqWaG/jKez/Q+6dIHaZzr+3nOlQsGgkWNpr+vb7XxmvChczx?=
 =?us-ascii?Q?8Ii9CWGz5QC0KN9h0cXNfIXLmtwI1+p0gDMz4z5kbXQOsizleMfiL+1RdSc4?=
 =?us-ascii?Q?n0XW34ChS3T99kNTREo8B6SZSFEHHQi5NMedl+Wmv7+gCmUk7t1kelGdSx5E?=
 =?us-ascii?Q?Wr5NwWzRLojVbt7oCuCKK/nYk8tLHLXODnXp775ZLqYMzdjz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 470853fd-55e5-4f23-2110-08d9f2cd3a8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 10:55:50.7750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RPd7orgOCZSZKEmld3/b+LaVB/QcryJoBIE59OKU8MGWmFV1pYO9QfI2dUGt2ME1QvrOt2X4nJn3boPCRYhE0kionzZZ9gGw5hz4oX5yAumGmJ6Ah9AlYRPOetT6wQ3/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3080
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> Hi,
>=20
> >  arch/arm/boot/dts/Makefile            |   2 +
> >  arch/arm/boot/dts/lan966x.dtsi        | 237 ++++++++++++++++++++++++++
> >  arch/arm/boot/dts/lan966x_pcb8291.dts |  61 +++++++
>=20
> Please rename this to lan966x-pcb8921.dts. All (most?) of the device
> tree files use the dash as a seperator between the SoC and the board.
>=20
Ok. I will change it.

> > diff --git a/arch/arm/boot/dts/lan966x.dtsi
> b/arch/arm/boot/dts/lan966x.dtsi
> > new file mode 100644
> > index 000000000000..91ee9e0684f4
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/lan966x.dtsi
> > @@ -0,0 +1,237 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * lan966x.dtsi - Device Tree Include file for Microchip LAN966 family=
 SoC
> > + *
> > + * Copyright (C) 2021 Microchip Technology, Inc. and its subsidiaries
> > + *
> > + * Author: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> > + *
> > + */
> > +
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include <dt-bindings/mfd/atmel-flexcom.h>
> > +#include <dt-bindings/dma/at91.h>
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/clock/microchip,lan966x.h>
> > +
> > +/ {
> > +     model =3D "Microchip LAN966 family SoC";
> > +     compatible =3D "microchip,lan966";
>=20
> Undocumented compatible string. I see that the actual board
> is documented in
>   Documentation/devicetree/bindings/arm/atmel-at91.yaml
>=20
> But as Arnd mentioned, this doesn't really make sense here
> as you have to override it in the actual board dts anyway.
>=20
> > +     interrupt-parent =3D <&gic>;
> > +     #address-cells =3D <1>;
> > +     #size-cells =3D <1>;
> > +
> > +     cpus {
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <0>;
> > +
> > +             cpu@0 {
> > +                     device_type =3D "cpu";
> > +                     compatible =3D "arm,cortex-a7";
> > +                     clock-frequency =3D <600000000>;
> > +                     reg =3D <0x0>;
> > +             };
> > +     };
> > +
> > +     clocks {
> > +             sys_clk: sys_clk {
> > +                     compatible =3D "fixed-clock";
> > +                     #clock-cells =3D <0>;
> > +                     clock-frequency =3D <162500000>;
> > +             };
> > +
> > +             cpu_clk: cpu_clk {
> > +                     compatible =3D "fixed-clock";
> > +                     #clock-cells =3D <0>;
> > +                     clock-frequency =3D <600000000>;
> > +             };
> > +
> > +             ddr_clk: ddr_clk {
> > +                     compatible =3D "fixed-clock";
> > +                     #clock-cells =3D <0>;
> > +                     clock-frequency =3D <300000000>;
> > +             };
> > +
> > +             nic_clk: nic_clk {
> > +                     compatible =3D "fixed-clock";
> > +                     #clock-cells =3D <0>;
> > +                     clock-frequency =3D <200000000>;
> > +             };
> > +     };
> > +
> > +     clks: clock-controller@e00c00a8 {
> > +             compatible =3D "microchip,lan966x-gck";
> > +             #clock-cells =3D <1>;
> > +             clocks =3D <&cpu_clk>, <&ddr_clk>, <&sys_clk>;
> > +             clock-names =3D "cpu", "ddr", "sys";
> > +             reg =3D <0xe00c00a8 0x38>;
> > +     };
> > +
> > +     timer {
> > +             compatible =3D "arm,armv7-timer";
> > +             interrupt-parent =3D <&gic>;
> > +             interrupts =3D <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) |
> IRQ_TYPE_LEVEL_LOW)>,
> > +                          <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) |
> IRQ_TYPE_LEVEL_LOW)>,
> > +                          <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) |
> IRQ_TYPE_LEVEL_LOW)>,
> > +                          <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) |
> IRQ_TYPE_LEVEL_LOW)>;
> > +             clock-frequency =3D <37500000>;
> > +             arm,cpu-registers-not-fw-configured;
> > +     };
> > +
> > +     soc {
> > +             compatible =3D "simple-bus";
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <1>;
> > +             ranges;
> > +
> > +             flx0: flexcom@e0040000 {
> > +                     compatible =3D "atmel,sama5d2-flexcom";
>=20
> Are these expected to be exactly the same between the lan966x and the
> sama5d2 or do you need something like
>=20
> compatible =3D "microchip,lan966x-flexcom", "atmel,sama5d2-flexcom";
>=20
> for the case when you need to make SoC specific settings/workarounds?
>=20
Yes, it is the same. No workarounds required.

> > +                     reg =3D <0xe0040000 0x100>;
> > +                     clocks =3D <&clks GCK_ID_FLEXCOM0>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <1>;
> > +                     ranges =3D <0x0 0xe0040000 0x800>;
> > +                     status =3D "disabled";
> > +             };
> > +
> > +             flx1: flexcom@e0044000 {
> > +                     compatible =3D "atmel,sama5d2-flexcom";
> > +                     reg =3D <0xe0044000 0x100>;
> > +                     clocks =3D <&clks GCK_ID_FLEXCOM1>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <1>;
> > +                     ranges =3D <0x0 0xe0044000 0x800>;
> > +                     status =3D "disabled";
> > +             };
> > +
> > +             trng: trng@e0048000 {
>=20
> Tudor already mentioned this..
>=20
> > +                     compatible =3D "atmel,at91sam9g45-trng";
> > +                     reg =3D <0xe0048000 0x100>;
> > +                     clocks =3D <&nic_clk>;
> > +             };
> > +
> > +             aes: aes@e004c000 {
>=20
> .. and this ..
>=20
> > +                     compatible =3D "atmel,at91sam9g46-aes";
> > +                     reg =3D <0xe004c000 0x100>;
> > +                     interrupts =3D <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
> > +                     dmas =3D <&dma0 AT91_XDMAC_DT_PERID(13)>,
> > +                            <&dma0 AT91_XDMAC_DT_PERID(12)>;
> > +                     dma-names =3D "rx", "tx";
> > +                     clocks =3D <&nic_clk>;
> > +                     clock-names =3D "aes_clk";
> > +             };
> > +
> > +             flx2: flexcom@e0060000 {
> > +                     compatible =3D "atmel,sama5d2-flexcom";
> > +                     reg =3D <0xe0060000 0x100>;
> > +                     clocks =3D <&clks GCK_ID_FLEXCOM2>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <1>;
> > +                     ranges =3D <0x0 0xe0060000 0x800>;
> > +                     status =3D "disabled";
> > +             };
> > +
> > +             flx3: flexcom@e0064000 {
> > +                     compatible =3D "atmel,sama5d2-flexcom";
> > +                     reg =3D <0xe0064000 0x100>;
> > +                     clocks =3D <&clks GCK_ID_FLEXCOM3>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <1>;
> > +                     ranges =3D <0x0 0xe0064000 0x800>;
> > +                     status =3D "disabled";
> > +
> > +                     usart3: serial@200 {
> > +                             compatible =3D "atmel,at91sam9260-usart";
> > +                             reg =3D <0x200 0x200>;
> > +                             interrupts =3D <GIC_SPI 51 IRQ_TYPE_LEVEL=
_HIGH>;
> > +                             clocks =3D <&nic_clk>;
> > +                             clock-names =3D "usart";
> > +                             atmel,fifo-size =3D <32>;
> > +                             status =3D "disabled";
> > +                     };
> > +             };
> > +
> > +             dma0: dma-controller@e0068000 {
> > +                     compatible =3D "microchip,sama7g5-dma";
> > +                     reg =3D <0xe0068000 0x1000>;
> > +                     interrupts =3D <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
> > +                     #dma-cells =3D <1>;
> > +                     clocks =3D <&nic_clk>;
> > +                     clock-names =3D "dma_clk";
> > +             };
> > +
> > +             sha: sha@e006c000 {
>=20
> .. and this one.
>=20
> > +                     compatible =3D "atmel,at91sam9g46-sha";
> > +                     reg =3D <0xe006c000 0xec>;
> > +                     interrupts =3D <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
> > +                     dmas =3D <&dma0 AT91_XDMAC_DT_PERID(14)>;
> > +                     dma-names =3D "tx";
> > +                     clocks =3D <&nic_clk>;
> > +                     clock-names =3D "sha_clk";
> > +             };
> > +
> > +             flx4: flexcom@e0070000 {
> > +                     compatible =3D "atmel,sama5d2-flexcom";
> > +                     reg =3D <0xe0070000 0x100>;
> > +                     clocks =3D <&clks GCK_ID_FLEXCOM4>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <1>;
> > +                     ranges =3D <0x0 0xe0070000 0x800>;
> > +                     status =3D "disabled";
> > +             };
> > +
> > +             timer0: timer@e008c000 {
> > +                     compatible =3D "snps,dw-apb-timer";
> > +                     reg =3D <0xe008c000 0x400>;
> > +                     clocks =3D <&nic_clk>;
> > +                     clock-names =3D "timer";
> > +                     interrupts =3D <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> > +             };
> > +
> > +             watchdog: watchdog@e0090000 {
> > +                     compatible =3D "snps,dw-wdt";
> > +                     reg =3D <0xe0090000 0x1000>;
> > +                     interrupts =3D <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
> > +                     clocks =3D <&nic_clk>;
> > +             };
> > +
> > +             can0: can@e081c000 {
> > +                     compatible =3D "bosch,m_can";
> > +                     reg =3D <0xe081c000 0xfc>, <0x00100000 0x4000>;
> > +                     reg-names =3D "m_can", "message_ram";
> > +                     interrupts =3D <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
> > +                     interrupt-names =3D "int0", "int1";
> > +                     clocks =3D <&clks GCK_ID_MCAN0>, <&clks GCK_ID_MC=
AN0>;
> > +                     clock-names =3D "hclk", "cclk";
> > +                     assigned-clocks =3D <&clks GCK_ID_MCAN0>;
> > +                     assigned-clock-rates =3D <40000000>;
> > +                     bosch,mram-cfg =3D <0x0 0 0 64 0 0 32 32>;
> > +                     status =3D "disabled";
> > +             };
> > +
> > +             gpio: pinctrl@e2004064 {
> > +                     compatible =3D "microchip,lan966x-pinctrl";
> > +                     reg =3D <0xe2004064 0xb4>,
> > +                         <0xe2010024 0x138>;
> > +                     gpio-controller;
> > +                     #gpio-cells =3D <2>;
> > +                     gpio-ranges =3D <&gpio 0 0 78>;
> > +                     interrupt-controller;
> > +                     interrupts =3D <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> > +                     #interrupt-cells =3D <2>;
> > +             };
> > +
> > +             gic: interrupt-controller@e8c11000 {
> > +                     compatible =3D "arm,gic-400", "arm,cortex-a7-gic"=
;
> > +                     #interrupt-cells =3D <3>;
> > +                     interrupts =3D <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> > +                     interrupt-controller;
> > +                     reg =3D <0xe8c11000 0x1000>,
> > +                           <0xe8c12000 0x2000>,
> > +                           <0xe8c14000 0x2000>,
> > +                           <0xe8c16000 0x2000>;
> > +             };
> > +     };
> > +};
>=20
> Overall most of the referenced bindings lack a proper yaml version :/
>=20
> -michael
