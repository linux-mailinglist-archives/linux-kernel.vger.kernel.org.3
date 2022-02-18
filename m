Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856574BB925
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbiBRM2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:28:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbiBRM2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:28:30 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACD23335A;
        Fri, 18 Feb 2022 04:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645187293; x=1676723293;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rH8+2i2sqtVp1LhueITK9rAPR4aRVvv1C2qMq82jYNU=;
  b=fMCkhR62iRLVd+MtSyRvNAgnN2+GgruetW5IZhSgTeTvmI4qRnl3HcPM
   8Ir59EATXSCC1HMn5nkkUCYoJCtEUc7gZEd//YxP6fGpI4AUzKvOD6Bql
   MbI0xcsYK+IpLPfph53onbl/tDGqRN8M/15n2/4loq50WQtMuihlZnseu
   AWx91/jQaePD4lXzMqpH8uedCpnZElq7XxMUIJ1L8evbbgTpT9DK4zZ+F
   DxK9owvB+8G0zJOEkA7twVRgzMPsgE7IWbTZj6zusFpfHK19jJ7pIZSpd
   YKjtGEd+W5uXD4ec3YIIHDlL1fwli6LK3xHgB0NSIEuMz03shGbaQTWLL
   w==;
X-IronPort-AV: E=Sophos;i="5.88,378,1635231600"; 
   d="scan'208";a="162776744"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Feb 2022 05:28:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 18 Feb 2022 05:28:12 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 18 Feb 2022 05:28:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMMq3WW/FbZm1wo/qNee36pmvsLtORxgD92CWPwxRHYy9ptb/0WTRsa9ngRqSLG0mXGfpxISAiFyyXcM9gbUpwKTMMNMN8HbEq6OxG9Ulpz01gBdxdWsLmi0NbmhWvqizT/p2ZSqY3HhEOPZjLgGMoyWplDdAV3V7rfGeUFYzRkwXIg5ZPVjqWKbAahVjf3/sbC/EbpnLzL3Jz9D1sDTJi46J/yh0uN8HUWfA0eEYFQF7wBFTPyxT38rR+a14OXL1yaszLPL8/xsPg4UfB4X4RNqnBYwLjRp/YrI1NZw3Xh7qq4nLMiuFDFzM/4lpVp7Zlq1Mr19DKLivqqKCmJ/Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCqomZN606Qvux2Ju5g4p35oZEm65XiXLCAGKjl0b+I=;
 b=Q8X7+9JQu1tuPUsISf296jhh8OqGqSDqtYOmjRHmKp2M66tM8TFFs/a4P+75GFXd6eUKEaxsHFbXRYra7YeGLHRVHdjer1SoY+77Gt26FCyKXyeAFqdhUBHm+N8UB5BxvfIZOO2yJNU+8p1otLUzwZ0wAnaffRVU/d0AUZ/7oQ7ioqVIYjw0R9zKzmrsEoxEwGVu+4FLD0YnvQ0wD3DlmaJpmTpYVDp6EnP3jCcyyNzMyThtEAO219M/k8RXSebQzq2Ni3vgY01FypIDf/IM1iV0+yr1nMjiz2ZtRG6+6qK8IjjeWQRHmtKr/NClxaM88b51rl4U7Z4naij5tpV2UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCqomZN606Qvux2Ju5g4p35oZEm65XiXLCAGKjl0b+I=;
 b=N5S/GI10jeX2nfhhg81W0fe7LDH5PPRUAaNRfZug0s0zi7xFBtA10VzcEwzc0haELAB+fcfv3mwQy1Mz4nBmjiH85Jn/TDDL0G4nigmUU5lWpCXz9q+KyCoTauj3GEL70R2UljWggkU/zU3YJeufI09hOgnDbRTLa4OGP0/WuSY=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by MWHPR11MB1774.namprd11.prod.outlook.com (2603:10b6:300:10a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.22; Fri, 18 Feb
 2022 12:28:06 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::25bd:b3c9:a714:cdce]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::25bd:b3c9:a714:cdce%6]) with mapi id 15.20.4995.016; Fri, 18 Feb 2022
 12:28:06 +0000
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
Thread-Index: AQHYHaYU1qtS5sG/10aA2sqGSWL+96yLj0MAgAD4oLCAAAQRgIAAFAoQgAARrQCADJaDQA==
Date:   Fri, 18 Feb 2022 12:28:06 +0000
Message-ID: <CO1PR11MB4865B205DF4490D37E96524792379@CO1PR11MB4865.namprd11.prod.outlook.com>
References: <20220209111318.21112-1-kavyasree.kotagiri@microchip.com>
 <20220209184600.1230365-1-michael@walle.cc>
 <CO1PR11MB486534A2987684CC7402CE06922F9@CO1PR11MB4865.namprd11.prod.outlook.com>
 <97bcfa4417d5f8c41cc6aa1e411c8747@walle.cc>
 <CO1PR11MB4865E913D083C1D80D4E1F80922F9@CO1PR11MB4865.namprd11.prod.outlook.com>
 <b98f40575f88a0bbf205d628f73cccac@walle.cc>
In-Reply-To: <b98f40575f88a0bbf205d628f73cccac@walle.cc>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d88acbc-0273-40e7-a85b-08d9f2da1da4
x-ms-traffictypediagnostic: MWHPR11MB1774:EE_
x-microsoft-antispam-prvs: <MWHPR11MB1774F113F4E00FD2F4F8D2F092379@MWHPR11MB1774.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +gLKep4+XGuBcpmW9RaAaPAxNoyeL8d6aaycmDicoNf+Pfert8dBA8RbnZB+F/cYPOmYFBkqPcf1RCuvG5eu3iT7Z8gCL6+0Nw5D7q6cWluhEbLxjF+5avnbXAEAlBGb1eHMKiY/ju2kaqUSijzRc5hiYyFS0i7osLto8ERPleeqt7jqKzDqTVJ6luXFxixoSpBuH5XiIaGYfOp4OE16QkpsXLxdXEfMNrSLmGkuOxouUaVOfCcWF3yrMC9RPgNAqN+xjSSIEhr5/lKwMQzwCC6mLRuU9vDNOMx2c+xEl3g+ctqunSjxfNDrF+c/mB6c4bY0YHur/cbjMUScxXPNDoEogabu6jvos+s7kMHusHKWQ/tTarMCC5+kg35WeiBw9JIBbAA3C3o7CjTRFjOJ/VdpW2mxD2hmye8PYXg/UJGxOU8w0FmksUMPcm/zlVSWcmeAF0vYAhNz8XiqqSobob7iBs0cm+4cd2v7xMl0YJsJnVuZDcycHHe0QJz2//sc9d007bwTmHPRsTmvvLC5yn873gNT9nxj3jkbXH6efO8c3uGt456aKo5dN6Dvigbx57xYD6Lqwpf6XsmWKcLAJhAWSPlUBDQbyVZDHBz9HBJfjfvuwwAYhwyeqk9/1TQMV9keik/IFip9jJHId16ze6y4+9oRzJYxewl2HHhi1BVy7tRMmza9nYEhnHEb3K6+zMgPWCjfg+fBnA/9aTRFaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(508600001)(55016003)(83380400001)(122000001)(26005)(9686003)(6916009)(38100700002)(54906003)(33656002)(316002)(7696005)(38070700005)(6506007)(5660300002)(86362001)(2906002)(52536014)(71200400001)(8936002)(4326008)(8676002)(66556008)(64756008)(66476007)(66446008)(76116006)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?90xxLg6iNzQpxCTehte42yVhZC0KgCsCBe+JmjnhPAdrrNt6h6fxn7BO1Z50?=
 =?us-ascii?Q?IL9M5l+HsyHOHBuaqBAfDqzDEy399TeUMJLAhqADA3NP5++KTWR19+5cXWBB?=
 =?us-ascii?Q?3Au2JjgOds1qUKNQK8gymJ+6zqil43QRJ2VkZ/u+s18WCgsn32GD2ZREGfyB?=
 =?us-ascii?Q?e8oYTYk4BwFlL8mtF1Udx9toPltOXPzfIUcaEdOPn4s0OXiW4Eu7mee2zKR/?=
 =?us-ascii?Q?d3CSMVSYRkTzT22KNnadW+CR0ygq0WcDJ8dcVbtrRi+XRz7O7nKVPASjpWg2?=
 =?us-ascii?Q?IPB2yE8OUmdydoot/j/hIFKPCUUfVwc5ik1nxFzIXKNc+zlrsHBc+pPrdXf2?=
 =?us-ascii?Q?dIZdVo6vBi4Qj8+shPumQ+5g9yCdYyuIg+UZ3w6sVFPtjlGvNC09S4Mhf7m4?=
 =?us-ascii?Q?70afHkWi15CuDDRhzrgiACmEB4IR6wfbpwXfgcTg9pQMtl4SdIKaHdHLa3Eb?=
 =?us-ascii?Q?IFyvPNbc4LPn07NSaM1Ix0gDQ3cEyymgjeA84zc5D4zRtGVgrhyKdtB7BK23?=
 =?us-ascii?Q?/MIR0N9terrnCxpLU3u+Y1ZONH7G8duzzLIgqeBJ9BbWIhKZp/Is2Y87vFS4?=
 =?us-ascii?Q?Bk2L0+3MdExPcgEURArmeyEJsZ8UQpWMVvpBSCWhHI1pAFRZVaP/tvddUSoo?=
 =?us-ascii?Q?5pJ3X0A0cq60Y6F2F4wMC3RSs7yChGdb5/XihR/ZbjG2BSaBBx7rLdtsuwHe?=
 =?us-ascii?Q?niN5xsbKOYpb8O5W5lubo/0stXZRCE/E27Ax47ej9k/gH9jwFo/SrXyg6/vf?=
 =?us-ascii?Q?qBRsbKcYq9V+8V26KU0dLclXQC3Z94f4ZluYmGJPMvUEByuxJXP7k8iZaAwu?=
 =?us-ascii?Q?Acb+UhQX/9iSANYLGiEU3PluQkKoa977AkYqg7jjSO53DkgSV7vFT0H31gh8?=
 =?us-ascii?Q?MIv6kyd2otmrSo9ARCC5rIYrTTJpkDT3rHwII+HyEHBGDG4LyMcqVayXquF+?=
 =?us-ascii?Q?N1kXIOLHax0DUYJtGpLkgc6TOkWLWu1MyRDSLdrRQRzIJxVy+0sVhcZCzBk9?=
 =?us-ascii?Q?aGMzlxGf69zjYcCeyKF7sfKJG8jGdVHr93lmKVKE40beYxKa6qsR8x3j0L01?=
 =?us-ascii?Q?f9E/QbrBXMVOU0xzzZFvrACJDztPs2T2Lt4flDmoCIcC+4s06vhlXDs2Xfgf?=
 =?us-ascii?Q?AI7mtZ2yFh7v3wRij/sMOl4g1tKqU8dGnXofaXWxYWscfV+x3ljkCVxoji5T?=
 =?us-ascii?Q?n6Na4bJzAqb11P3/ptC3WTibs66bd8Vi4ddDEenAnA9XnFZhhd30+4eG4R2F?=
 =?us-ascii?Q?I7aHRpKg7nOR9aSsypjGbHPMsa6aOcLhuEPBpT+fN20hhzCISvYFlL9Dv7je?=
 =?us-ascii?Q?cu4OGuXja25NCeH7qGcbYtf5wseJZiIl2s3Y/0rfWpeGWBrw3dv+Vgw8iWvP?=
 =?us-ascii?Q?yxi3okIpRF03mhSEL/laNe4ZlVxYyQrStV3G17iH9sahPV50wd/8ynqPdVjM?=
 =?us-ascii?Q?KbKKYB1el30ro/CwO7keoTZ/4+PfmidZ6poIdXCEjhrOx9TMv94PyPfFY01v?=
 =?us-ascii?Q?nh13Mr9wXD9iMt83mTSUNhUofou/9NnWmcOOB8MKl5pMr/LR+qfFjeAVmxUm?=
 =?us-ascii?Q?E0Lz5ByWHOe17yRLss2xiMljo8GjSErFvVzw0o0BSCueOQ2xzds6ncrX9YAz?=
 =?us-ascii?Q?0aYl1j6fGdbRVBbd9lzFBMXDDXAaKBHmPwaJEuGMtudKDnBMMAHKcXYkEli1?=
 =?us-ascii?Q?HRYnvLslzoNkNshsN0wX2TQ/j7vDsxpyJP+5IMVwVnzqQbBI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d88acbc-0273-40e7-a85b-08d9f2da1da4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 12:28:06.2821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mDlrhxyFumXh4yranC41nIK9MCMRZI41QKqxIjkBp20sQsMkvh/m0RBWmswbb58VyQDfQb9xe5yggHFUh2j3uqYBYiDRIjCPVneElRtx4WEMXBR/6gD+XnHysOAaGnBy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1774
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
> Am 2022-02-10 12:52, schrieb Kavyasree.Kotagiri@microchip.com:
> >> EXTERNAL EMAIL: Do not click links or open attachments unless you know
> >> the
> >> content is safe
> >>
> >> Am 2022-02-10 10:40, schrieb Kavyasree.Kotagiri@microchip.com:
> >> >> EXTERNAL EMAIL: Do not click links or open attachments unless you
> know
> >> >> the
> >> >> content is safe
> >>
> >> >> > +     clocks {
> >> >> [..]
> >> >> > +
> >> >> > +             nic_clk: nic_clk {
> >> >>
> >> >> What does nic_clk stand for? If I had to guess, it
> >> >> has something to do with network. But..
> >> >>
> >> > NIC clock is the clock used by AXI, AHB fabric and APB bridges which
> >> > connects all the peripherals.
> >> > It is named so because the AXI fabric is based on NIC400 IP from ARM
> >>
> >> Ok, thanks for clarification.
> >>
> >>
> >> >> > +             watchdog: watchdog@e0090000 {
> >> >> > +                     compatible =3D "snps,dw-wdt";
> >> >> > +                     reg =3D <0xe0090000 0x1000>;
> >> >> > +                     interrupts =3D <GIC_SPI 38 IRQ_TYPE_LEVEL_H=
IGH>;
> >> >> > +                     clocks =3D <&nic_clk>;
> >> >>
> >> >> Btw. can we disable all nodes by default and enable them
> >> >> in the board dts files?
> >> > I would like to have only board specific nodes enabled in dts files
> >> > and rest of them in dtsi file
> >>
> >> And how do you know which ones are board specific? E.g. I would like
> >> to add our board which is also based on the lan9668. Maybe I don't
> >> want a watchdog (or whatever node). Of course I could use
> >>
> >> &watchdog {
> >>    status =3D "disabled";
> >> };
> >>
> >> But IMHO opt-in is better. At least thats what we are doing for
> >> the layerscape over on arm64.
> >>
> > Basically, I am disabling only the nodes which have pinctrl settings
> > in dtsi file
> > and enable in dts to make sure there are no conflicts on pins on the
> > board.
>=20
> Thats not what I'm asking. I would like to see *optional* nodes
> disabled by default. Whether the watchdog is optional might be
> debatable, but what about the usb controller and the qspi
> controller? They don't have shared pins AFAIK, so according
> to your rule, they will be enabled by default and each board
> which doesn't have anything connected on these pins would have
> to disabled it.
>=20
> Please keep in mind that this .dtsi will also be used by boards
> not manufactured by microchip.
>=20
I agree with you - "disabling optional nodes in dtsi"
I have gone through all the nodes.
Confirmed and moved enabling optional node watchdog
to dts file.

> -michael
