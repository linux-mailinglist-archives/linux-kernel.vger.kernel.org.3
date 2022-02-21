Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26744BD591
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 06:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344644AbiBUFo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 00:44:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244043AbiBUFox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 00:44:53 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C4D31DC3;
        Sun, 20 Feb 2022 21:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645422267; x=1676958267;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=beM4MDF/aH+gjBCCSoyEAjZAfODLuVb29cAQcwZSWTE=;
  b=JRW2YNJhtcivf5ixV5fvlzHQea0dxN1E/66E6YN6JwmUonhlhqKUPrlb
   RfihvdfLd1F4n6Mwe8aIkV8pBRhV1BMidvkg9cXKgDH10fJBxDPZQzgrt
   w0XSaJ2zDdRj0oER7M9KE6H+OPAF7TGOI2UccMx0dn8D+7wSj4FmmrK8C
   UUDrnMeqa2YSv/EGfjf4ES5HyfRA+cRxmj+a4FL8uMttPMuJB2CltiRE3
   hSNab7aiyMWVjm5kvnOLBK1PYsqaCfAcYPVXa1dyuqwpC/tD4dkTZxwtZ
   XrsuR4PkkeDTEK5NXlJWB9xnCLkSDNRCqKNEFnDrNUHhvyhDLhgrr8F79
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="149387131"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Feb 2022 22:44:26 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 20 Feb 2022 22:44:26 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Sun, 20 Feb 2022 22:44:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5eA3q2/gQualOJh4dtY6sUi1xdgkdoPyutrHD5GgHvdrw7LKot5BJKtbekhEvlc0U1cB9SIYk7/Ld0OX2lwF2dA8WSj6zNW/MvdmQFhua6bUPgyTlyjzz01Xg5utCAJGVIIwAHVcBKe9b21RVlHAUE/I7qD1HJcwBVDRYZaahaT7WC5OH7QjPRwgKjocRq4mmcpaMQaQ8MpkLLlx78xqbKsHt7nWEb6uQKJRLX4g25jYW7sWw95MzeKw630zOYK9ViEiLultsnFop5ezIUyPWHx0LtUZBu2PV1Hn7n40Sl+1RopF1IVVXVhJQLLfZ99MLi4fiT0tOwZXXOzPIJqIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4133Qh7rHwCoRtdJPKGCXjN0Wfew4MZE7yotOJYGOc=;
 b=T3VyHsgUOHAG8C5T4y4HYHInvORIvWIs7BKwqmmrMeA3xUirQkAdX+b/lLMiezh6ftkeuAVSo7RwEa142jNSIX/gzeMoAnyraoiM5hivWkxxq8syVuZUJmjHw6vt4XygVZ0oJwYQpUXdGqsdPDL6EsHh9G9f4nhpXUuGOaAPJPJ7C4fuDeuAid5G78fNo8tBtod6Q9Z3MfF7m9AQukYBK6lhLmAKu5CbPxrc3nMFdb2ER7nZO/x+6TpoUcdCopSaUlUsbPlSmvejibLhY8eJQEcC3hHeWH4Lv947X3HXGYuHsMDJCCF0EbLA8G1EDyDT+8xEeSLdGiJOpiWHbFF0mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4133Qh7rHwCoRtdJPKGCXjN0Wfew4MZE7yotOJYGOc=;
 b=B8jrMP0/O7madwrQTVdTkLf2/vDzYO2o34RFrNd4hE2iTFMwaW56/Q1toiwQkP+/Llr8Dou8ucNAelh7P9/dVAhPyDxFul99cpOX0rkmvCmnW+IFXtt1bNQiyp6SBUPJYPub/wnzgDLrBW7/M1LqB7A0DP2bSv3M6pNI/QNbpHk=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by BYAPR11MB2805.namprd11.prod.outlook.com (2603:10b6:a02:c1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Mon, 21 Feb
 2022 05:44:21 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::25bd:b3c9:a714:cdce]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::25bd:b3c9:a714:cdce%6]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 05:44:21 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <michael@walle.cc>
CC:     <Manohar.Puri@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <alexandre.belloni@bootlin.com>, <arnd@arndb.de>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>,
        <olof@lixom.net>, <robh+dt@kernel.org>, <soc@kernel.org>
Subject: RE: [PATCH v4] ARM: dts: add DT for lan966 SoC and 2-port board
 pcb8291
Thread-Topic: [PATCH v4] ARM: dts: add DT for lan966 SoC and 2-port board
 pcb8291
Thread-Index: AQHYHaYU1qtS5sG/10aA2sqGSWL+96yLj0MAgAD4oLCAAAQRgIAAFAoQgAARrQCADJaDQIAAA5+AgAREUaA=
Date:   Mon, 21 Feb 2022 05:44:21 +0000
Message-ID: <CO1PR11MB4865E667CB963C8B5DE5000B923A9@CO1PR11MB4865.namprd11.prod.outlook.com>
References: <20220209111318.21112-1-kavyasree.kotagiri@microchip.com>
 <20220209184600.1230365-1-michael@walle.cc>
 <CO1PR11MB486534A2987684CC7402CE06922F9@CO1PR11MB4865.namprd11.prod.outlook.com>
 <97bcfa4417d5f8c41cc6aa1e411c8747@walle.cc>
 <CO1PR11MB4865E913D083C1D80D4E1F80922F9@CO1PR11MB4865.namprd11.prod.outlook.com>
 <b98f40575f88a0bbf205d628f73cccac@walle.cc>
 <CO1PR11MB4865B205DF4490D37E96524792379@CO1PR11MB4865.namprd11.prod.outlook.com>
 <426e31325066cfa9f0ab50860289e12a@walle.cc>
In-Reply-To: <426e31325066cfa9f0ab50860289e12a@walle.cc>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd320299-093f-4d69-d4e6-08d9f4fd35a0
x-ms-traffictypediagnostic: BYAPR11MB2805:EE_
x-microsoft-antispam-prvs: <BYAPR11MB280504D83A4EED2C216B02F2923A9@BYAPR11MB2805.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cFDm05Iv6kLm2K7LnZMdljpE3UiEpVcIicmyL1WRztJzwBxJFirXSEi16bEgvOB1WoalPsfLMJAsPhEDGMYtW6eq8T7C5MlEa0n+I+by+yIJ6+6vOl45HjudBoKa4C9NqgHrtc/SyJXUf+aTpmd7WqXnM6+O93jhhqGhMdLeEOZiwUp+EPLErqFLIyeVGRK0+aA7bm2G9XdWSWhfZyuGDRM/rHiblbsqm+9Zxv8qf8WFa3t5GsFO4kTGM3g+YsVoPCoOrL7FeMUHkmt9fcAnbCvSn5r4WpFe/nJQv/UnFoYrPhxwbs6XxyFH89YK10IebL2ZYzUBWEIk23L/0dTII1vXiF17p537tH6yTLqGfUkBHB8HFTayIpWxWi+Gr3zwEeaGv+PtKed44avp9sXpTpBOcjiEZ5nGSpYGf5QbXYY6QMwU7Ghk2p+N20uXNh2Pv1asX0UpSxywowkE5gGAtlrlf7ZUJPejHPmdxXx4yeBUha7GfILylQf+zbd6tnu6nM2hO4aEtr2O+gNF6vV9sWA8gZURoAbpGNJsrfiYCfnjkC9OvdzgGXARe9z/59zyMHpbJ1G5jM/WLyXFEzachjPt00WJQ2P/bmNPU2ZqO3pdZRfl2GFcOHgAksEArnv/3JDwDcRmcnjrHirXi7UaGSiyUyWdPoPwndcFsbT0zAEnVMpzohjFJz2CNUwlgSYsmEkjK+0vk5q0Q2eMhx835g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(316002)(71200400001)(26005)(6916009)(38100700002)(33656002)(86362001)(508600001)(66946007)(9686003)(7696005)(6506007)(2906002)(55016003)(186003)(64756008)(83380400001)(66556008)(122000001)(8936002)(4326008)(8676002)(52536014)(76116006)(5660300002)(66446008)(66476007)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JuTiTn6jIRctDyK+XuNyvVN/9SBx88Ix6/OwQZZ8cPHxZR8wkMt4sy+M3FMo?=
 =?us-ascii?Q?TO/RmGcCUxMOSoIATdHR+aa0/Wjo8iYLsOkGH1JVGbamfzQu2FEjDIF/iJQL?=
 =?us-ascii?Q?uYHRmiGkb3/X0waolJKhibmNfi8BnZX9hHdlfAxIXXFj6WVsEbGx63WJfvW8?=
 =?us-ascii?Q?Ei5emWojOIp7eAfkM9QP/779+JmNfh4aHR0LlmbecuOEZ/u2C5H2Yyawv/63?=
 =?us-ascii?Q?v/UgffmwZ9OkY6k8y7HD2gV5RnTCgTc3sfpN4ko2s9DB53rmxzPKCWHc2uo1?=
 =?us-ascii?Q?ejCbBl466qnsxtunDHUbaSvX9WIU+kjvoYzqWaN7xiz/DYNki5b4TVtEHzXR?=
 =?us-ascii?Q?/XfL8lvVLwJ1ly4SUmNep63EFU+5PAvb3Zya0bext4t2EZx4bcRhwldjk+v7?=
 =?us-ascii?Q?L1Q0pDRz+amwvsy9YRgnISSl4vm2HwPp3y/9e0OGs6R2BOrUABm5X/2penhQ?=
 =?us-ascii?Q?g0aeMUgiEW8Lv3QMsrpq3ykHQ+39TQuefYnaK7e43erWG9zsJzKOghTBbsDS?=
 =?us-ascii?Q?qeTX0KHX9sAQhA29wkwyX30ru0w+p96V6VocvftVL4XZ7J5OCEWL8y/U59hj?=
 =?us-ascii?Q?yrcZMZBdu577un3R9m5NMq95TCbL0yYAYf4PX19e/5QV44yFJI7U3a+eVW6R?=
 =?us-ascii?Q?WOVqPQzJcWpy1UEJdf4o5OX25Oz2O6l55vbH9szR+qa2Nsf+KtZfA+ou/b56?=
 =?us-ascii?Q?I9bCa3t5J76gdzZqKX7LqGdFlHhwN0hP4xDj3LcLaRBIwoYGzL8tROTpGURN?=
 =?us-ascii?Q?mumJ9Caf6P0bN4z7dny/csZ6nbuyKYq0nQkxegBc4Zzw/YlOZmpwP0yUkURC?=
 =?us-ascii?Q?LUYv/pIRcWr7/n8JMAmfegmslfaIAm3a+gCIKlY8AG2MLRHeckrnlaOVn1pk?=
 =?us-ascii?Q?VvbVwQajOFaoqxe9fhWGG/l3RB9bCpxrTGcWKhzvdN0guCh/o5yx0u1WZCOH?=
 =?us-ascii?Q?AoOQyLaJvehgxFa5wGhxzVhusZ60Cs2bJO5mjyWFX7xAxyzKdgRKQIkeU7tl?=
 =?us-ascii?Q?mOhmdenvvacE15bfHFXbjfxgDQ+gUtDLUy8H+rNXfXGX2TkqutlHU+P5CVn3?=
 =?us-ascii?Q?+08outozbacG4ZLNeQYtEDeLLZAtG/Eu8WiL17vNM6SQZ1vPXwqfPbgKlsaB?=
 =?us-ascii?Q?cj1bG0vRJZ2MtYASvyovjXp4tGGyzMGOPxgEyymig4nsJyfE68THl8/8L8zN?=
 =?us-ascii?Q?sh4U4cJyul9WPT4cwDU+eGso54daKb1UzNmT4nWi0oRuSKCS+/RSqecQWnF0?=
 =?us-ascii?Q?gurNVQTW8CQThm9iBPC6qPSpMCNEgP5wEP0lw8beRWOybwyrgyg4RsR/Tc5J?=
 =?us-ascii?Q?PwgCAR5MUGIfZ3rgtpcN7DJCQ5J8bsZZfy28R53cfhUgY5Hqq0Bl7gWaz5s5?=
 =?us-ascii?Q?jxZMHhOvyWqbB5zro3xpwheurHB4RPtXFJYQh7v1qnIcy7jY8xp5csAzI+KZ?=
 =?us-ascii?Q?x8SY1jCteSYZH1ToxrOzmhL3yfiSToQqqu7c67LMwRZC8K1gw+SGYV2rUG6J?=
 =?us-ascii?Q?YW/q8EfGdiLI3pVZncexweB8lvEFGvOCIMunXlDrawUPX1GpRnFzTsWE5t66?=
 =?us-ascii?Q?WO1XTS1rA26UIYGuuSLP9Mkvbh9QY3Q844IP4XLuax7PETNEA/LirYeBnq4A?=
 =?us-ascii?Q?p0WtUkQNax1ua0e7FMnGWIHFftH5nW9p+G//JSYwigprqYrCVlSLWTbx8CDA?=
 =?us-ascii?Q?/CrWmhP7orlZ4QLeLTRUNhwtlqdB4g2MQA6jWSN9P7qSKIzb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd320299-093f-4d69-d4e6-08d9f4fd35a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2022 05:44:21.2020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y05qH8e3Z2wZY8BOtZRBpWRi60dlhlnFQQszsHgwxq/cCG/bZjw2inriC+yaJlN4jWneYnnVTgQUP9/bBwAkqDCIqWAb5kliGTBs3VsZDc+yc1QExgPouwr8lq83wR2n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2805
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
> Am 2022-02-18 13:28, schrieb Kavyasree.Kotagiri@microchip.com:
> >> EXTERNAL EMAIL: Do not click links or open attachments unless you know
> >> the
> >> content is safe
> >>
> >> Am 2022-02-10 12:52, schrieb Kavyasree.Kotagiri@microchip.com:
> >> >> EXTERNAL EMAIL: Do not click links or open attachments unless you
> know
> >> >> the
> >> >> content is safe
> >> >>
> >> >> Am 2022-02-10 10:40, schrieb Kavyasree.Kotagiri@microchip.com:
> >> >> >> EXTERNAL EMAIL: Do not click links or open attachments unless yo=
u
> >> know
> >> >> >> the
> >> >> >> content is safe
> >> >>
> >> >> >> > +     clocks {
> >> >> >> [..]
> >> >> >> > +
> >> >> >> > +             nic_clk: nic_clk {
> >> >> >>
> >> >> >> What does nic_clk stand for? If I had to guess, it
> >> >> >> has something to do with network. But..
> >> >> >>
> >> >> > NIC clock is the clock used by AXI, AHB fabric and APB bridges wh=
ich
> >> >> > connects all the peripherals.
> >> >> > It is named so because the AXI fabric is based on NIC400 IP from =
ARM
> >> >>
> >> >> Ok, thanks for clarification.
> >> >>
> >> >>
> >> >> >> > +             watchdog: watchdog@e0090000 {
> >> >> >> > +                     compatible =3D "snps,dw-wdt";
> >> >> >> > +                     reg =3D <0xe0090000 0x1000>;
> >> >> >> > +                     interrupts =3D <GIC_SPI 38 IRQ_TYPE_LEVE=
L_HIGH>;
> >> >> >> > +                     clocks =3D <&nic_clk>;
> >> >> >>
> >> >> >> Btw. can we disable all nodes by default and enable them
> >> >> >> in the board dts files?
> >> >> > I would like to have only board specific nodes enabled in dts fil=
es
> >> >> > and rest of them in dtsi file
> >> >>
> >> >> And how do you know which ones are board specific? E.g. I would lik=
e
> >> >> to add our board which is also based on the lan9668. Maybe I don't
> >> >> want a watchdog (or whatever node). Of course I could use
> >> >>
> >> >> &watchdog {
> >> >>    status =3D "disabled";
> >> >> };
> >> >>
> >> >> But IMHO opt-in is better. At least thats what we are doing for
> >> >> the layerscape over on arm64.
> >> >>
> >> > Basically, I am disabling only the nodes which have pinctrl settings
> >> > in dtsi file
> >> > and enable in dts to make sure there are no conflicts on pins on the
> >> > board.
> >>
> >> Thats not what I'm asking. I would like to see *optional* nodes
> >> disabled by default. Whether the watchdog is optional might be
> >> debatable, but what about the usb controller and the qspi
> >> controller? They don't have shared pins AFAIK, so according
> >> to your rule, they will be enabled by default and each board
> >> which doesn't have anything connected on these pins would have
> >> to disabled it.
> >>
> >> Please keep in mind that this .dtsi will also be used by boards
> >> not manufactured by microchip.
> >>
> > I agree with you - "disabling optional nodes in dtsi"
> > I have gone through all the nodes.
> > Confirmed and moved enabling optional node watchdog
> > to dts file.
>=20
> Great, I just wanted to get to an agreement how the optional nodes
> should be handled. If it turns out, some are still optional or
> some aren't. It is easy to just mark them disabled and enable them
> in the board dts files in a later patch.
>=20
Sorry, I didn't get you. Do you still see optional nodes in my dtsi?
I think GPIO controller, Interrupt controller, XDMA, timers, AES, SHA, TRNG=
 are
not optional. So, I keep them enabled in dtsi.=20
Please let me know your comments.

> -michael
