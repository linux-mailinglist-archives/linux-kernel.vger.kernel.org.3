Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43120524643
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 08:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350634AbiELG6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 02:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350636AbiELG6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:58:11 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F311D0C8;
        Wed, 11 May 2022 23:58:05 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BJ0EJc031119;
        Wed, 11 May 2022 23:57:32 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3g0at24fpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 23:57:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGttbPKSmO4tSmweeYmrO1MVB+iCe2cuXvrnwaoiuthKWyc2UVRybt9cBRhCrgkEXF6N3LS3DJsv3QY8E7Knas8+rbkkuODX5nZ+E9JSDRH2UCt8CzKY61wh097V4QGI5vHVjVVhf4F0JRSfGKY9z9bSFtalp4wkqOjjU3Q/VskPRRsXMs1xAwi2r9qPH8pTad1bh8cneccVMSuayaoQ2QbIfuohYThAdtjj0lkVovMyMj5VmYMS25ro+VolY7l9IHdiczDL0WI9BETRUIHAisxOONWpsexwc0rDFyb9QwrwKjGQSxgR2QsOheLMUAo0BnvvfSQQBxfUWxghe6xa0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZ/oxJmBwnVB91S2E9UAUE8+gAQ37o39uWCyZUQq4j0=;
 b=dRpQYZ5OvkZiCi9ukXJQCyXPFfGH/ANLGG6bAo5gTkTkoKOWpPHP1Jx5yfn4cAFP8Nq28RqTva/oEpcMNNxIDDZKJ1ngdwuGWEk+n2d9VSMy+6Y2p3+OKrS1cL+2BThCzPvsYy8NI+5hH+JlFYcO8i1nIBJQ9vPMyzi80OfLF8apgM1rdy4dLmYYQWt4cvjGHETSTGAmcadtv3oDmoBh43vB472ZtrYveb9CMr8AuTwQLML0KPYWfsFwzKJ9hgzexGQSDSOTEAQ3LBcL9y9JyaPRO2UhtC6zVREJ95c34Om40rMvhBc1ImXb897oTafXLp+XNJFDahD9Yb5TNjCJVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZ/oxJmBwnVB91S2E9UAUE8+gAQ37o39uWCyZUQq4j0=;
 b=NoOsegqgYzZm0FWSkG+8Ph+FE21Suc33n3Y+jDR/Kc295+T23oeZcBtG5XsuAS8MpcucI1suk9TCMLPZh9VuaPwAyQ7AC0eEJUUjoGfel+j98ZNjFQwOunxLPxPsqIDLNfNeKQ+1vjJD1bGbwluUtb38aXaBONsLigRalXbn59E=
Received: from BN9PR18MB4251.namprd18.prod.outlook.com (2603:10b6:408:11c::10)
 by CH0PR18MB4115.namprd18.prod.outlook.com (2603:10b6:610:e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Thu, 12 May
 2022 06:57:29 +0000
Received: from BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::953c:a1c:42b2:460d]) by BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::953c:a1c:42b2:460d%9]) with mapi id 15.20.5250.014; Thu, 12 May 2022
 06:57:29 +0000
From:   Elad Nachman <enachman@marvell.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Chris Packham <Chris.Packham@alliedtelesis.co.nz>
CC:     Vadym Kochan <vadym.kochan@plvision.eu>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        Kostya Porotchkin <kostap@marvell.com>,
        "robert.marko@sartura.hr" <robert.marko@sartura.hr>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v5 1/2] arm64: dts: marvell: Add Armada 98DX2530
 SoC and RD-AC5X board
Thread-Topic: [EXT] Re: [PATCH v5 1/2] arm64: dts: marvell: Add Armada
 98DX2530 SoC and RD-AC5X board
Thread-Index: AQHYZYrOD+CvCHNCg0KtkO7ZfX8hka0aZoAAgABm1hA=
Date:   Thu, 12 May 2022 06:57:29 +0000
Message-ID: <BN9PR18MB4251F84C9D4C538DB6D63CFCDBCB9@BN9PR18MB4251.namprd18.prod.outlook.com>
References: <20220504044624.951841-1-chris.packham@alliedtelesis.co.nz>
 <20220511161003.GE10145@plvision.eu> <YnviMOtXX+us+IA4@lunn.ch>
 <c781f7eb-86f2-16c4-1380-b08b974900ff@alliedtelesis.co.nz>
 <YnxXWIloDzfg8bh0@lunn.ch>
In-Reply-To: <YnxXWIloDzfg8bh0@lunn.ch>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c65ed9ae-f4cc-4027-1b50-08da33e4ae23
x-ms-traffictypediagnostic: CH0PR18MB4115:EE_
x-ld-processed: 70e1fb47-1155-421d-87fc-2e58f638b6e0,ExtAddr
x-microsoft-antispam-prvs: <CH0PR18MB4115503DE79FC1DEE8D1D681DBCB9@CH0PR18MB4115.namprd18.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uF88iKrBKhwxu4lwkzh5uF+DYCHpGOWyoe7rbzNlX+sfXBgWEkYsGY3gw58NOBoWTXAW0nfufIjk7xliQEQlNrxI8xkw1L4YVryoERMHS+h644i7BGGwG3QYmNB/4CxToICOpyooH5lt5TrjCryi7P30gyox+0v2p2XvRBLiEJ6pSSUXixPLT/ruo4+27iiH6ZFDSnqxNCxQ2BCwzJEcZmZeOy9g0r2bMDeUm8q4elQOLoywinx0JoE7LzDibA550fxmbR6A+rm7Os8jMho0uwEpaSjimQPK995pX7l0bFeB0jHvrj0plxg+8AQhE4moE75xxzEMbRU3e/8s2dJPM2qOYXGT8eoSbOFDdRs20rANM6i1w7deZN0DNrJuKMY3QNoE+EpqlDc+6e6wZ15DaLtmkKwobCJbVPIe9xNMnXpmOU8KKIMcrKGSMV/0ylyS5LItJQXb4Nn63BCcBV6xWxIHBbNc86JWDriD45TIdSriZgnMNF4tKZZyKeJfTJSfF3Llmn0Ghigh9nqn915+VBvEoa7/pyfBwLCrE0bTMFopTCyVxurZT5np1TEOLTNT2Ne7O6TyfhcsJZHZauRT0iaVA9d0QPox0K2qoYdQZMctFQ/2LP/vwmwkQ5G/sdZKTXuBgZzvY4jluC2Z5kMJF91K9QitojUlC88SoQF79ycgZ4Jfm2vmSyKyxRrBS6StbtXb0Kjias5vd3m3UAgCng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR18MB4251.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(9686003)(53546011)(6506007)(26005)(54906003)(66476007)(33656002)(8936002)(7416002)(2906002)(52536014)(55016003)(5660300002)(66446008)(64756008)(38070700005)(66556008)(66946007)(86362001)(508600001)(110136005)(4326008)(8676002)(316002)(76116006)(83380400001)(186003)(122000001)(71200400001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4o+kH3sH6Acknlxn9Yrs3Eyza1kMlZ3vgYdhmRBsUDvOnuFhZq/8DqbUmR2J?=
 =?us-ascii?Q?xaSezk2Il0XLQhGqritE0ZTZSs0DY2ujJwb2B7H3fZ3T+VS+a0V8MthKF+AU?=
 =?us-ascii?Q?ptVjG2gX9ksgWibDVCXlA3g1vY4nMfusY8JK2gF392950subJbbSLg220gMF?=
 =?us-ascii?Q?vRo893BcvEWEv3FV/KKfcclAEUZjMIWovkXhsCjzgwkPMgGqAfxzKS+F4XfS?=
 =?us-ascii?Q?sn9v9hbIwnYKKQbQL5oSO5D1lbGDNe/A4GhBDM9pJCvoOnH8CHixBS5LKQLd?=
 =?us-ascii?Q?4Je8gNpPeImhe2I8I4QNBmUN4ARF/6OY+OWJzHNBZe5Sm9cZUufjVT1Jmzlx?=
 =?us-ascii?Q?AMl3i+VAkMsb4ntDpHM9EuwaXgAmqZEIIAjVuqdmtLKVqZN4pfK8+z9m5nvd?=
 =?us-ascii?Q?dRjNl9JGKddNU5Rs3PzXCQ6yWqWKswe0j9uXawT6IKHRetd+sIl2N1bcgFlH?=
 =?us-ascii?Q?EQXlkPCP+zPjakBO4W2PO9SduRkyzZnmXfQzxbpO7XC0EfaWwZCWuIE9afW1?=
 =?us-ascii?Q?mgusRYHRxpXuprBdFNijI+I163XBs5j3fEg53Gl1fbqRoJzLnqnlhO/x/X1m?=
 =?us-ascii?Q?Kn75JmoI16BMVEPm03Zwul5jJsxvCOE3gnKR478hYXWx2FweCxqeeZasixPA?=
 =?us-ascii?Q?1Xm9RrAlndY+wkbetE1nKGLdWAtr0X0VpdT+VFMMA4bpeWfcOZQo9cWEXVto?=
 =?us-ascii?Q?Z2nMhhGvUuej4p411paHuwLlgcrQjAvsIE2+qgqM/tenHrj/H0P3MFCea5u/?=
 =?us-ascii?Q?OfvScDf8QooWT6exJnmaHBEfA7jUjLVqxMd26wgEngRvm8nOt82GtWE8V61r?=
 =?us-ascii?Q?/4HORcUJwOcDhwfxCxqjy+p+gei3nQHLbc+N9BhKA3Q0eypNL7YIYljy24Uc?=
 =?us-ascii?Q?pQJZNxT73wVKA8IN3oa742+0/FhzP/2zZ9IVaCw+UJRH03bOABTLC5smvo9o?=
 =?us-ascii?Q?k0azwDohbSuIY6Ln26Z4ALSzc0ke70jhOgzitYDHivYdolewD89JkkAx3W3A?=
 =?us-ascii?Q?/DHaIp/guI9AbRuAqho/D6lw9Tbez/jSvIr8mv9DuwmMI/SXYnRGGWR/nwl5?=
 =?us-ascii?Q?vnrXQCNwqw/y303p5ezRUpGtB9MdaUXVRIM+98ZSLkd0Oz841C6iqr5YWp2l?=
 =?us-ascii?Q?JSY2+kxXl/Hks8sYVKgl7QQETMdA4s99QlmAlQZEUkAAAGm9m5w9c67I8A/0?=
 =?us-ascii?Q?p9iTw57rvW54ss6EscH4xM1Iwzmymgx+peRSQEA46IdbM5h6V7dvQy179cv3?=
 =?us-ascii?Q?8cmI+DSKWxVevyXA9FT80HJArwbh2yvneOrPHnr3kmieWiOEIZ+uXDtm97ja?=
 =?us-ascii?Q?gPQvKp/xLR8ghZdnYj0/5QrNNFTgmLOlECltxtItOkJLGi2mFFHfm+RXCG00?=
 =?us-ascii?Q?dPLACGVv2R+mpb10yT8JakNOZnA+X1c6DU+QxXq/hGXJVlepCej9puvcEvqU?=
 =?us-ascii?Q?zDLbqC3/vSZOgSawBsRMrtThq4k2Gp9hlZPO4vuUWRvuj96+P5NpXgL8iRzm?=
 =?us-ascii?Q?Xnf8Euybkv2HSqucCcgIvAqKWlFmQtzOlqBrDWDqIIWhB1zjOBfS8sZ+HVXy?=
 =?us-ascii?Q?NwyD1+k9NmV2tAuinxvjCCAPvKzwTUWOcMI+/umwNUscYjfGukNd8SLXhQww?=
 =?us-ascii?Q?LEnT0Nmn/j2ODNclePfuR5VHYqvArzeY7e+3Z4toZYWcKNEyvjutiqVfPvPH?=
 =?us-ascii?Q?ElOT21FX94yce2WIW5XkpGGZCu7R+tNN/fGxeY4PKAoVlSWBxJTfkFhLRMua?=
 =?us-ascii?Q?xYfh5+qriw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR18MB4251.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c65ed9ae-f4cc-4027-1b50-08da33e4ae23
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 06:57:29.2974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZogThk/Yvx9gNoEH86a5IEuziOTrEBJ/vqfl9kCulwXr//SVV5GDc7yL2qaftgyslFTRj9S0LjHt8a/DnD/PsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4115
X-Proofpoint-ORIG-GUID: 7XVJXxOz5LrGWkPjrYD5Sv_UffDu_e8m
X-Proofpoint-GUID: 7XVJXxOz5LrGWkPjrYD5Sv_UffDu_e8m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_07,2022-05-12_01,2022-02-23_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Thursday, May 12, 2022 3:40 AM
> To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
> Cc: Vadym Kochan <vadym.kochan@plvision.eu>;
> catalin.marinas@arm.com; will@kernel.org; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; gregory.clement@bootlin.com;
> sebastian.hesselbarth@gmail.com; Kostya Porotchkin
> <kostap@marvell.com>; robert.marko@sartura.hr; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; Elad Nachman <enachman@marvell.com>
> Subject: [EXT] Re: [PATCH v5 1/2] arm64: dts: marvell: Add Armada 98DX253=
0
> SoC and RD-AC5X board
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Wed, May 11, 2022 at 10:59:37PM +0000, Chris Packham wrote:
> >
> > On 12/05/22 04:20, Andrew Lunn wrote:
> > > On Wed, May 11, 2022 at 07:10:03PM +0300, Vadym Kochan wrote:
> > >> Hi Chris,
> > >>
> > >>> arch/arm64/boot/dts/marvell/Makefile          |   1 +
> > >>> .../boot/dts/marvell/armada-98dx2530.dtsi     | 310
> ++++++++++++++++++
> > >>> arch/arm64/boot/dts/marvell/rd-ac5x.dts       |  90 +++++
> > >>> 3 files changed, 401 insertions(+)
> > >> Marvell is going to start the upstreaming of AC5X boards support,
> > That's good news. I'm probably the customer that's been nagging the
> > Marvell support team. But I'm also impatient hence I started working
> > on this series. The pinctrl and mvneta changes have already been accept=
ed.
> > >>   we have also patches with similar .dts(i) files but with
> > >> different naming:
> > >>
> > >>      ac5.dtsi
> > >>      ac5_rd.dts
> > >>      ac5_db.dts
> > >>      ac5x_db.dts
> > >>
> > >> What do you think about to use these naming scheme ?
> >
> > Personally I thought they'd be rejected upstream as being too vague
> > and generic.
>=20
> Agreed.
>=20
> > I'm not against changing if there is a consensus. On another thread
> > the idea of armada-98dx25xx/armada-98dx35xx was mentioned. That
> might
> > be a reasonable compromise (although technically there's no difference
> > in the CPU block between the 25xx and 35xx).
>=20
> Until we find there is a difference. Marvell, can you confirm that the sw=
itch
> really is the only difference?

Basically, the cpu-subsystems of Prestera 98DX25xx (AC5) and Prestera 98DX3=
5xx (AC5X) are the same.
There is a very small difference in how the default memory map starts after=
 boot, which is reconfigurable in u-boot.
This affects the switch (not part of the device tree anyway) and the PCIe.
The PCIe window still overlap partially between AC5 and AC5X, however.
The original Marvell DTSI overcomes this by defining only the PCIe overlapp=
ing part in the device tree, resulting in a single device tree which works =
on both AC5 and AC5X.
The DTSI Chris proposed had the PCIe portion removed.
We have PCIe support for AC5/AC5X so we would obviously like to include thi=
s portion in both the DTSI and as a patch to the Armada8K PCIe driver.

>=20
> This might also come down to ID registers. The DT could be enough to find
> the ID of the device, the rest is then done in the drivers, not DT.
>=20
> > > However, now that i come to look in arch/arm64/boot/dts/marvell, i
> > > think most of the current filenames proposed don't match the current
> names.
> > >
> > > armada-98dx2530.dtsi fits the current pattern.
> > >
> > > However, Chris's board files should probably be
> > >
> > > armada-98dx2530-rd.dts
> > >
> > > and the other files should be
> > >
> > > armada-98dx2530-db.dts
> > >
> > > armada-98dx2530-x-db.dts
> > >
> > > What does the x in x_db mean? Does that refer to the board or the SoC=
?
> >
> > The x is from AC5X so we'd actually have armada-98dx25xx-db.dts and
> > armada-98dx35xx-db.dts. My board would be called
> > armada-98dx35xx-rd.dts or perhaps armada-98dx3550-rd.dts.
>=20
> armada-98dx25xx and armada-98dx35xx does help with the naming.  So it
> probably is worth having armada-98dx35xx which simply includes armada-
> 98d25xx.
>=20
> 	Andrew

Elad.
