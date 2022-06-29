Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A650555FEE5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbiF2LkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiF2LkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:40:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC113DA6F;
        Wed, 29 Jun 2022 04:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656502818; x=1688038818;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vuayWTqNLEjwBVlsLmihf+SecU3r+4+qZ1/E50QD8b0=;
  b=09UXklTQ6sndPPJXaCEgTNCR9fTLaIZdFTtMA8MNQnX4M3PlYoNc/l35
   45MFESftqM3Smo1WkkYUpDlpTaVIBLyj+ofn7yrNeszYyiE5yzR5pB405
   TDDQpwwr8YIU79ZOdgwioIpiT9vHPfcsfztaOgsecR0PyZtTaT6wLWM4M
   iT5wy5WYf0bzKLl0nx+ChnexWVTzHGh+0P51iEFyU549ETMc/jL5sTLhu
   wTVWyKoRdX/WtIrE1dAcGEvCBVCT57lykRbJQ9StkAwuBtWoKmIt3MieB
   ZUmi1Wytkrwd5CNjF7/NjhagelOko3kWykDUoe9igvKtAMQw7Jaq3Je/i
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="102259910"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Jun 2022 04:40:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 29 Jun 2022 04:40:17 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 29 Jun 2022 04:40:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=deqc+DsZ940NQ2ydBj5NgdAJBzhGUVnronLOd3XiWcGoGxZc44bJRfICSQ31llykFN/2MiIJ86Lujf/vkWZh4X/vzPWbdrdwxMC5nkdUV/s0UXQs2ja320MHADbzG6z/3QUmhb/0JWmX3xRbCGJu7oRg1AQzHkDUAu5oAsYVc6qGjdnBCsyQHzyVIDTcf6aLaK5Ht/D3NviQ0YlC+/d+0SmLVizIg0axSZL2xHrQf2SZz6iNe83VKgsSgPA3dWb2ujA8rErDRduSdSBLsoCoviruIHoT5VNMT9TaEXYXBdH32Je7V3db699B48g/7AWtbG/w31MmzbN6hN0aWSlkTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njITWB9NvicT3yf0pgfWZN3L0W1fP8+c4rFcP+A91U4=;
 b=Gm64Vk67srO02nFKWsN39xdoElnR4gbOKVHv8y75PSY99CrB/R8CHT4o4D690UFQ0ApyOyGQCAzNf90eHHBpOxgBwaisZVW+rLjxZP7GhWHXXbQDku1ldZuw3xq4QeVLooLxJ42WoiEorJGnfgyVK2Bzf5ksgjeNu7QtWxthpuyPiBM2NRkpA5kbs+KWnqNiUWM/Y+3P5HSoctYGvH3KeVLZf59ekPTY7QD7ulmtMbj8f+PO/KMBb0Pm3YpwImhQBK+OxpGAvJS1eGiMp8lfZnTd2FBEeFjxDcJO/eat0csdO9u5jjdowG9g74dFjQreNzoWJXJxLIBhUHWDaVxtvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njITWB9NvicT3yf0pgfWZN3L0W1fP8+c4rFcP+A91U4=;
 b=ERT30i84YOWwv+Qhlli5d7aEcD0bCd39r3e5vS3Le8RLCdNGHf2eg3EoW7gdC6KPoZx9Ntd446QqEzbbFnBW9NSXNoMwfnyk88odOWcFq6SlnuFMb1tXaDMD0PP7o1A26XcaXJFJ0c3+Fq9VFE+XJRU+8ih1UIurOp8zynF8Nk0=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by BL0PR11MB3169.namprd11.prod.outlook.com (2603:10b6:208:69::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 11:40:15 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::e80a:618a:2b58:f2c9]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::e80a:618a:2b58:f2c9%8]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 11:40:14 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <michael@walle.cc>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ARM: dts: lan966x: fix sys_clk frequency
Thread-Topic: [PATCH] ARM: dts: lan966x: fix sys_clk frequency
Thread-Index: AQHYQUllEhXoxvVKzUCVMtm162QkMq1m1zwQ
Date:   Wed, 29 Jun 2022 11:40:14 +0000
Message-ID: <SA2PR11MB4874148E216CF66072104AC292BB9@SA2PR11MB4874.namprd11.prod.outlook.com>
References: <20220326194028.2945985-1-michael@walle.cc>
In-Reply-To: <20220326194028.2945985-1-michael@walle.cc>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3f0625a-9735-4fae-0822-08da59c42235
x-ms-traffictypediagnostic: BL0PR11MB3169:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m7c1Meum+u4gWljkNJbkzXIRuZoZbUplGDz5YkpwpsC3S/D+Z38FK+o8VZ82XHJkz5b2nTVmHzs5oAbRGmU/UvuqVdmHXO4PsOApgU00PyHUtjGWXf+T+fJ2rtdQVG0aBcwmr7SbxigyvmA5/cojs4NJ7yGZIlpPn9rokNry68ljPIULblW/DE0aipQrfqpSPMv2RSVrfRvcDHPQ1gY25JnlIaJHOP7VjVG+JlpkJHxZA8eDyOotJ23qaGbTi/4CEnja1G1Brff74ss9nthdLF6VQAOg330751F+Pio4ipnFvt0Jgb9czVxYwLjR1qbNqP7BweRVWeQuzwS3DpXpGgVmeW3ska9j4ABPU05u/boTjz28+VFgwCCrnQKoT4NCTOMJJQRK2Ec6cVQirKaFf80nRztg0gzGja8UCNBvkwSYyYxEZ6PVlTVyxYpGCOBwfGcaVxHEBNieNkn9H6Y5invriXP7i+/RrpZzTqO2TLYnJbP1lCITix1BL8WyUe25mt6kxiA4LB6YwJvcjKxIEnMXF3zoZaJZYYcUebPT9xQtSdSjnwnpqOFqmAnlrBX2EwnNfwJXPjzXIjhAWXV8cKOOn9+sBjvIm9rNlHtXD8Z7lwFQ5ZJFIjfWvQ20/7N6waC8mYaSZYNJ/POMYnB7ZlYWLCCAgh+PIq3AoltwgakRkpXDqHHCyCC1s1eoqYPa8p42mfqQJSLvNFn9IVwCfhdAOOhsutKI5piXQ6+XW5HXzrbA4RaKZIRk9IBEXPVHITOMH3QM0axgrih1KDKDUWGPhfF0PLSm/5+YFyWk/Pk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(366004)(346002)(136003)(376002)(316002)(76116006)(66556008)(66946007)(38070700005)(122000001)(38100700002)(6636002)(8676002)(54906003)(66446008)(64756008)(66476007)(4326008)(110136005)(7696005)(478600001)(186003)(41300700001)(6506007)(26005)(8936002)(83380400001)(9686003)(52536014)(2906002)(86362001)(55016003)(5660300002)(71200400001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q2pPoMqFnkInNyLY92a/AkjTQ4VBj0w2UF3b41fyFzWqZB8GvB1OHCoWx0v3?=
 =?us-ascii?Q?cmJ/YQZ7FZ5xQBtY3+xGJr4TSm7qQ3bTjy2ic3l0iUP7cgG3r1LT9t5tw3Er?=
 =?us-ascii?Q?Fb/x/DuGoD/nDAcyFnMkwNKD6ZlBO2bWmyHoySVE+CwpM8UnliKi3tasaf+h?=
 =?us-ascii?Q?zgocUfTv81ahOJ7+RgIfaCjm1joADToWMEX2L4+SfcI5OcP/IK07i+MPTJXN?=
 =?us-ascii?Q?4qF5MMNO0tobV68BTV1Gdj9jrWzjGg/sFkbvReST1L+py9z6lEzeopluyzJM?=
 =?us-ascii?Q?YrVIZ2Jx5PvNVS0o5k+rb1RDQVRZ93vy+X2GoSh9rM9xLgUJmXH5MxHBx1E8?=
 =?us-ascii?Q?YT9bK+fKV/GynFxQeXzxPjwhCP7pm5Ru7IVLWzsNNNKxSv6H51oP+xrgnYCi?=
 =?us-ascii?Q?7bozschFsUlu9GkhbmD5U7YKvIz2hntZvihrAamoZ0r8qNX6dmbhRjAyX8/P?=
 =?us-ascii?Q?KtjrSNQQamzk6OOesivkkvlOD6TcOrnKK7Z56RrM+GZzGC4fn70CbbF52OCA?=
 =?us-ascii?Q?eDd6Facyeo2qy8/7ZQuCh0TlIgW8tliNvYPx2FWBTqW5BxKc1TnUbCJlGYug?=
 =?us-ascii?Q?f8hgdw3YCL8REMsjl7SSc1NGMEYHUaO8EsGRdR72bXksK9x/Az4FcSW/jIW0?=
 =?us-ascii?Q?qZWDsdfhXAJmpEilzIr2uSk2aCKRYElZCRw1CpjeuOG0ypRVt8MkKjeY9lJ1?=
 =?us-ascii?Q?dPPfosJWMmI9VUQp/9QvivaO3WfSGhAwLayZYdHdwG8vXpvXI7aH80FlKFl4?=
 =?us-ascii?Q?6UcPG1o1TkVvFOZIgjAeipeceA171Y6yOWZRPHpmjk5ktEkgEV/PUJZwhwqi?=
 =?us-ascii?Q?7K2IH9IensdPRgU03y6A0UDJMSXbpAHwk87+M0qCS+25A0hYB8c4lHMRTDAD?=
 =?us-ascii?Q?jtNcmnbaGVBc124Vk61k/CYnDesD4xqA05v/nyH6xcOUKMDaIGk4KrXrWgVQ?=
 =?us-ascii?Q?wHZ9fs3sgW62JjdNh1fLoN7Q34cAYKUv18Qn3FZBf6CzwhBpQHK18wKpji/G?=
 =?us-ascii?Q?L2Fg9yME2ZwiNVTEeXvr+ARX/sejvWXirSmSF5bXKD+vyJKq3vqELvYNsYsu?=
 =?us-ascii?Q?2OWD8CINz5pGM1oEP4mM9Si+tOR/RBRfrvU5rPMonesRBE16cZoc3KdVjALn?=
 =?us-ascii?Q?KJxFEdDzJfwLulU6/45nQPFuIfg+fgcQ3B/xqNs6aQlcH9pBrzbgA9JRUZra?=
 =?us-ascii?Q?/wYqURjKkY69HRrSwIxejUWFRVImXpzj9HcTEsei5hJ2PLRX3Ac4sYJp3a4K?=
 =?us-ascii?Q?yowOW6RaIGA8mvKn0IRujgJi/vTBrig+1kgmd1vT5hyVxPkvGRtNky/6eFQq?=
 =?us-ascii?Q?z9A85YzND037KsFXUYjE+lqE80ZfkJrlcsLFuYXpmLAN3Y+LofLtMUGY5s5O?=
 =?us-ascii?Q?lD4qIrbnfn9fxI40cnN1Lro7f2lrHZvf43h4MTa4yZKvJH6byaNV4dZaK5jv?=
 =?us-ascii?Q?/W1aOK3YaybnrhQ49U6K22CPVQGt1YkM94Ggf/roOYSrxURj++aVCnjszPti?=
 =?us-ascii?Q?En2YtcnOqPgKnHjbdjwUyvZooL8wfLR1icq+wjYImWpSZTdG1AH9q81GeI5Z?=
 =?us-ascii?Q?uI22Jm0KsGPlUiWHcaclPjGuBR6W4pUIt0jLOXhNsuqLJTiWSZelsANw7Xgm?=
 =?us-ascii?Q?Hg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f0625a-9735-4fae-0822-08da59c42235
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 11:40:14.8553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8uDIoufNEdZ61+tyXk7vPM0P9q3y8EmOBrS1y4a/OyjCUY6+VKllOozXFbKtWtJuoOE7Q1Y56fq+TXF7w044ldZXZRlTnRJA3Z59CWVIuom3Fe7+N+Q6F1ZiWnL/Zsri
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3169
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The sys_clk frequency is 165.625MHz. The register reference of the
> Generic Clock controller lists the CPU clock as 600MHz, the DDR clock as
> 300MHz and the SYS clock as 162.5MHz. This is wrong. It was first
> noticed during the fan driver development and it was measured and
> verified via the CLK_MON output of the SoC which can be configured to
> output sys_clk/64.
>=20
> The core PLL settings (which drives the SYS clock) seems to be as
> follows:
>   DIVF =3D 52
>   DIVQ =3D 3
>   DIVR =3D 1
>=20
> With a refernce clock of 25MHz, this means we have a post divider clock
>   Fpfd =3D Fref / (DIVR + 1) =3D 25MHz / (1 + 1) =3D 12.5MHz
>=20
> The resulting VCO frequency is then
>   Fvco =3D Fpfd * (DIVF + 1) * 2 =3D 12.5MHz * (52 + 1) * 2 =3D 1325MHz
>=20
> And the output frequency is
>   Fout =3D Fvco / 2^DIVQ =3D 1325MHz / 2^3 =3D 165.625Mhz
>=20
> This all adds up to the constrains of the PLL:
>     10MHz <=3D Fpfd <=3D 200MHz
>     20MHz <=3D Fout <=3D 1000MHz
>   1000MHz <=3D Fvco <=3D 2000MHz
>=20
> Fixes: 290deaa10c50 ("ARM: dts: add DT for lan966 SoC and 2-port board
> pcb8291")
> Signed-off-by: Michael Walle <michael@walle.cc>

Reviewed-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>

> ---
>  arch/arm/boot/dts/lan966x.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/lan966x.dtsi
> b/arch/arm/boot/dts/lan966x.dtsi
> index 14c9cb3c0f3b..03045ec4aca4 100644
> --- a/arch/arm/boot/dts/lan966x.dtsi
> +++ b/arch/arm/boot/dts/lan966x.dtsi
> @@ -38,7 +38,7 @@ clocks {
>                 sys_clk: sys_clk {
>                         compatible =3D "fixed-clock";
>                         #clock-cells =3D <0>;
> -                       clock-frequency =3D <162500000>;
> +                       clock-frequency =3D <165625000>;
>                 };
>=20
>                 cpu_clk: cpu_clk {
> --
> 2.30.2

