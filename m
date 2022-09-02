Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EED5AA5BC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 04:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbiIBCYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 22:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbiIBCYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 22:24:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D678AFAE8;
        Thu,  1 Sep 2022 19:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662085420; x=1693621420;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/xOiJqr4iq00aT6IU/HKRsfcxjL/kPxIwUDwrevr8nM=;
  b=I70N98REUZPzrKAM2DpX6ZxlwzlGWRlJTpQfDz1s+VMqHXSLAYOcxPDJ
   eikfeBb+qQ3BkturejTFWLZA15G8RnfI2nOJQrdkiMLVTIU8kmOllEhEv
   25Nu/PUijcSuT92Oiru2OcqaHYzVU/kf2BXlKxS5jCOms0RjKailu7Vxl
   CjN1H5kan5r+QIuPxiWGwnhf5QjaEIayNzEBSlFcMBYho9JzdgDAmFJZr
   qhPHaArByEurwF2NSrCqFq9CV+NPZa7lEzb4ovljtE7CHUVpArAOMHyoE
   5i1zVRUgEhaoMvRK8vIAOi8GWtfSIndcDNIfDyoOUqNReq52OMYe8UN2d
   A==;
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="111852363"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Sep 2022 19:20:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 1 Sep 2022 19:20:25 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 1 Sep 2022 19:20:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0AfjOzV1Xd3csLMO3Ox6DRWqqef27WifIMhhBlrPsiXQ46J10hR/60jfOISgRYKPlPFlMqpy1f/0J5e3HmsyF+cfWrl+99aHih3Klaojp4KOtBlhZf164EQBRu7l54UZVDMSEGZ3sNWfn1/JyGgP1ArhpMlrzmTlJ8qPmJWw29j8uDQJSNoCDHqhuPE6gx2bfAZ9UaQE7HMtjG6uXiXgtThGdi2SK4X46N1A1L8uQqXzWzNvoGi9vUTp8K+2h/tBP1mfQQvA8Vj+fD4i8o+2gd3fESaWQp0/RNiqTYba11+H+AL8LJGS60XU1Vl564oDyV10pCMBWk4VfHEKv333g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FiZaivl8UxpqEyr8aZnRaRRJI0VIKnNvCkXHKPz5jLs=;
 b=WRs3h7Sojik+odCn1oKx7RXWnfQnrO+HWRhHlwuXRKaH90p4hQX8X7NysvOb+4lgYH6RyW+hNg8n1SsjmHV7Z6hM8Pl1S8u1C+HWX4xdackF4zCjoDne9bOrlHyZq0ApHSm3cxPdFYo+/JgvuemH4q++UVLpJoR9rqrA8d6n0bngeHrD5GjOvAobD+Js3M6VMCCHcI987aqi/1hfx5EQmUCxIMH8Vhk4uP2tnO/CSPEWH20tL9pDmEfU4hC0ImOVCTwCUzMgeE/Uxcv2/c+npBkimffn7EiyUi/fayrJgSijoNUG5EbtztchcvGOVqnr7km5H2h0oXBsV0OveHlO9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FiZaivl8UxpqEyr8aZnRaRRJI0VIKnNvCkXHKPz5jLs=;
 b=KDcGoimvjiD76bh6VYj+8W1OYT1IV2PNMuRPfW6XyKDaNz6VdUic1G7PBdYMw9WS4GKtPnp9qFteTrB3Hd6/cK/BYj7G77HsmA+mIPXZdc9/3VYT7rPH51VhG1PQCU73OwpFDyMdEaWiC+0+EYTIZq4ZDNXJRbr8DIrz8ZapyC4=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by DM5PR11MB1403.namprd11.prod.outlook.com (2603:10b6:3:11::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Fri, 2 Sep
 2022 02:20:19 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::8846:b62b:5a61:746f]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::8846:b62b:5a61:746f%7]) with mapi id 15.20.5588.010; Fri, 2 Sep 2022
 02:20:19 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <ilpo.jarvinen@linux.intel.com>
CC:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <andy.shevchenko@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <johan@kernel.org>, <wander@redhat.com>,
        <etremblay@distech-controls.com>, <macro@orcam.me.uk>,
        <geert+renesas@glider.be>, <jk@ozlabs.org>,
        <phil.edworthy@renesas.com>, <lukas@wunner.de>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v1 tty-next 2/2] 8250: microchip: pci1xxxx: Add power
 management functions to pci1xxxx's  quad-uart driver.
Thread-Topic: [PATCH v1 tty-next 2/2] 8250: microchip: pci1xxxx: Add power
 management functions to pci1xxxx's  quad-uart driver.
Thread-Index: AQHYvJqN/ryPjdVWCUu2JC5qz9dINq3IxeGAgAKi/EA=
Date:   Fri, 2 Sep 2022 02:20:18 +0000
Message-ID: <BN8PR11MB3668D24337821FDE00FE7BB2E97A9@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <20220830180054.1998296-1-kumaravel.thiagarajan@microchip.com>
 <20220830180054.1998296-3-kumaravel.thiagarajan@microchip.com>
 <8a47735-82d-809c-9b8c-a8d9d9a8d5c5@linux.intel.com>
In-Reply-To: <8a47735-82d-809c-9b8c-a8d9d9a8d5c5@linux.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5eaff1a9-e661-4db6-227c-08da8c89ae76
x-ms-traffictypediagnostic: DM5PR11MB1403:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F6i+Dd9rF0fkNY22Rk8frEKtFIJuNvhsg+OQt/++hxqQVAk8oGh5Lsld1rs1elxmnLRRW5UKm4BNm8ZuHX7OMrM5ms5mAEs+vXvFyFIWkeMhj7ObotvDzKbC/QdpXoDjnCWlCElrxEdJsoyzt1SZ8ubh6ay5W7Oy24KnRzsMCFEcNkaup6lwdhcZfdFDc9HRGzbK4XVNqoK3ROxAnmXeKm/4rEOHyYmkegFajnc2VfZQJ6/U/uqA+i0Ugbm7yHqS2z3h/zzJJPPJr/jji1p1cRx+wLCnZnCpPQhRdEk+jNQSc0D0VggJ4gD4kafJ9CBM7lOW7/MkGI4WtOzffQSosWJddjsrbbH81DzztC9Bwq/W0YM+2mtBYkQ/wuwTzF0/WiCnGGFeACooufSFd/kPfD/z64i13K+wiKxIAxyEk2DwX3D73JAe+Yz8Cq5m1MOIAERzB6tr9zN6xNGop54F3ePoXSjRa/ElBn7USQrGL6VEPw3fdcTp4hO0YUYEKTDQ7T3wryCkdbyxIRjuJ8I0yfankSQewVawNT8UT2dbdG2vSfnKySqPFvQQWxtgDltPCRD8MXje3ptC6vqbx04snjLG2473VZMrlKIjzvpE0pg+O4LuKpuLMlimK37MZOfUNYHHnu+Heh4WqI1c/HvScvwtDohEprD24EilqwMFrs1Y2YPT88jzc/t1wtsatTfBEQOjcC2G8CIVYRpB8SE79zOdp6aER22buFJS7HgKTH8EnHcyEKLzgv7WURtoxUFpucNDkcHiD2zvSsHenM4NJHGkogymki407ASmtDab97k9qmy/lFQJZmClQKRrr5yJS0ohKCq9mI3n1HlHlpx0W1hcwieju4sljgMOFOEJVA4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(346002)(376002)(366004)(396003)(478600001)(8936002)(66476007)(316002)(122000001)(86362001)(7416002)(54906003)(5660300002)(55016003)(6916009)(76116006)(66946007)(52536014)(66446008)(64756008)(71200400001)(66556008)(38100700002)(4326008)(8676002)(38070700005)(107886003)(53546011)(2906002)(26005)(186003)(6506007)(7696005)(33656002)(66574015)(83380400001)(41300700001)(9686003)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lI6g/orZorxUzvoAp5Ds+hxmUhH9N3azcKC1zn9p3hI/9OoZw5KTfysMO3?=
 =?iso-8859-1?Q?6HNXY1r2zd3DWVP0vEtKJORvRzf6+c6jwdhgGYjO2TqybHlsSKYkJeocWC?=
 =?iso-8859-1?Q?1WeWvvE/XMC3Jm7fMTiivVleco3IdJFzxA8+CJQf65YcSms9VZBcIcauar?=
 =?iso-8859-1?Q?l9NMiHA1WQsmErkSetA7za7AzkOrbwW1V9UADdYeBWnAkxdwIWU2pp1nxL?=
 =?iso-8859-1?Q?SRhoGD5+chAgfKCyf6vpdhYhpU1zIx5k7Nr7rJ07vyV/f4J//pP+Hl7AtG?=
 =?iso-8859-1?Q?By24SgvqFnYDo7txTf+H3EH9g1zgoM7Nw3cIj22BKVlbjNm5bDX6qC3amu?=
 =?iso-8859-1?Q?a+glbXMbeZtMv/HUkBLteYERuGHQltenweg+Z6th6371RGi2llA1LRZW2W?=
 =?iso-8859-1?Q?Lq/+40Y9uhq0tF2IeA05lwMJNJqqkzl0tSENcmungeOx6Ll7zbaLdiqo48?=
 =?iso-8859-1?Q?gcTbhUO70e0FkAjDrwuVAwpvd/2vlcnryn/dN+Yb2PobUG19XlQ4uE3w5L?=
 =?iso-8859-1?Q?4FLPDds8JDSaJ1o8HU2tBi0ogryEK9bRAfVayD7yc0irqD2lZpgFpQ72NL?=
 =?iso-8859-1?Q?KIQxFNWvnQsPI8CRGXOv+QhKQdjqyq3HFvE1kGZksbr4SVwuAU6qDg6dVT?=
 =?iso-8859-1?Q?KCW8lcJ1xc1nwb0TRgDodODtjXGw4L5tjhbX8iYOd6NKDsw+l+TsV6z8z7?=
 =?iso-8859-1?Q?XgR3C1hKmIh1JUDohVIsZvqxiiQyW+ybye6Hk+Tkmce0cljY55EVTVHUmP?=
 =?iso-8859-1?Q?e/J7rVpy6LyE8cO8jqE1jX8Zvy/BPwZfiAxI+WP0QFZMSofzEkA4X8EUa7?=
 =?iso-8859-1?Q?T86PiCMLjXpRjBuQhbx7UyOdre4P2OeNBbebJUaJ+y/pbHzgdtK67bYQHZ?=
 =?iso-8859-1?Q?OJwrk+x5AYGT82BJKVs3lz/8SouFz2K3QeBDZYfTXSNI2tawOU/SLPmwmM?=
 =?iso-8859-1?Q?aMA5/5cfwQUGnrqGtB64lV8QRl7Y8uNj3mRijsZwJpDHX6HCYMpWWzydPw?=
 =?iso-8859-1?Q?S5jvZW1L4kNBj8GFZso/FgdXGT7P7bCTMJ/nLZMnt0TFGFH4nUUCvWpbEw?=
 =?iso-8859-1?Q?3PFx89gADrH7HSPMniQ6uNIkaEgkeqPhScTprqYcRJ9yz9qgWABCrUBE8G?=
 =?iso-8859-1?Q?7kBYW6e9vojVPWW3IzTsjN1gMK9/ZBtdQROAdtlfQZiQokBzVkush+Lfwi?=
 =?iso-8859-1?Q?QCzoQV7DFazlytPlNqdBkQBsrxTLWGcWeqsdICQd8fNP7AYEo91HobmdKC?=
 =?iso-8859-1?Q?XorrxOqIO4m6v+sA0x6Dqv62YXJ3gqllRPjIAC1UxWjD9tX+gdErBHfo3o?=
 =?iso-8859-1?Q?MZtUSZFBfbu95DfCRd1OV8M2HvkPRQSDrU6pL5opiWwQf76AGK8oPDRFo4?=
 =?iso-8859-1?Q?l/fwPNlWrbyYuqwnYcEO+9Ftk6u9p46Z56qW8lHxfIrmANxsqN7LTz752F?=
 =?iso-8859-1?Q?Hd1XS6FmmBkcKyibyTYDiixxzFZneNGhJCbrEJ1ofFgA2J36NOzOlMJclN?=
 =?iso-8859-1?Q?8cy7n2o5WxXoLI5rqqW7/eMGYuyOTmfEDalwuBRWWaPtcGMLizA8Gxt2b+?=
 =?iso-8859-1?Q?QK6lIutJGiui8VVii3Es+yrUKo82n31WrLyiQU8ZgvRRzn4jD1X6I0kDqy?=
 =?iso-8859-1?Q?Aou13bcAuXlj3wY3r+PpNoy5yt9+k9xguvPij4OzGySEqHGtMjv3/q1NE9?=
 =?iso-8859-1?Q?bkcRsrwqqa+JgzPa29I=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eaff1a9-e661-4db6-227c-08da8c89ae76
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2022 02:20:19.0013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: taELrWQi2BEyUDCKhDQ+NRKcjf0HvQ821KOx4L1z+4uNVjdMA/0ni1kWC9wBFetOJkD7x5eFc7TRevzKwz5hJFEcemxmjLscjndbEfw+HVJZlkG1eci8XGoT3gR6w+Hq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1403
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Sent: Wednesday, August 31, 2022 3:24 PM
> To: Kumaravel Thiagarajan - I21417 <Kumaravel.Thiagarajan@microchip.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Jiri Slaby
> <jirislaby@kernel.org>; andy.shevchenko@gmail.com; u.kleine-
> koenig@pengutronix.de; johan@kernel.org; wander@redhat.com;
> etremblay@distech-controls.com; macro@orcam.me.uk;
> geert+renesas@glider.be; jk@ozlabs.org; phil.edworthy@renesas.com;
> Lukas Wunner <lukas@wunner.de>; LKML <linux-kernel@vger.kernel.org>;
> linux-serial <linux-serial@vger.kernel.org>; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>
> Subject: Re: [PATCH v1 tty-next 2/2] 8250: microchip: pci1xxxx: Add power
> management functions to pci1xxxx's quad-uart driver.
>=20
>=20
> On Tue, 30 Aug 2022, Kumaravel Thiagarajan wrote:
>=20
> > pci1xxxx's quad-uart function has the capability to wake up the host
> > from suspend state. Enable wakeup before entering into suspend and
> > disable wakeup upon resume.
> >
> > Signed-off-by: Kumaravel Thiagarajan
> > <kumaravel.thiagarajan@microchip.com>
> > ---
> >  drivers/tty/serial/8250/8250_pci1xxxx.c | 122
> > ++++++++++++++++++++++++
> >  1 file changed, 122 insertions(+)
> >
> > diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c
> > b/drivers/tty/serial/8250/8250_pci1xxxx.c
> > index 56852ae0585e..38c2a6a9e5d5 100644
> > --- a/drivers/tty/serial/8250/8250_pci1xxxx.c
> > +++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
> > @@ -70,6 +70,7 @@
> >
> >  #define UART_PCI_CTRL_REG            0x80
> >  #define UART_PCI_CTRL_SET_MULTIPLE_MSI       BIT(4)
> > +#define UART_PCI_CTRL_D3_CLK_ENABLE  BIT(0)
>=20
> Reorder.
I have ordered this like - Register offset followed by individual bits from=
 MSB to LSB.
Should I reorder this based on some other criteria?

>=20
> > +static char pci1xxxx_port_suspend(int line)
>=20
> Why char???
I will modify this to bool.

>=20
> > +{
> > +     struct uart_8250_port *up =3D serial8250_get_port(line);
> > +     struct uart_port *port =3D &up->port;
> > +     unsigned long flags;
> > +     u8 wakeup_mask;
> > +     char ret =3D 0;
> > +
> > +     if (port->suspended =3D=3D 0 && port->dev) {
> > +             wakeup_mask =3D readb(up->port.membase +
> > + UART_WAKE_MASK_REG);
> > +
> > +             spin_lock_irqsave(&port->lock, flags);
> > +             port->mctrl &=3D ~TIOCM_OUT2;
> > +             port->ops->set_mctrl(port, port->mctrl);
> > +             spin_unlock_irqrestore(&port->lock, flags);
> > +
> > +             if ((wakeup_mask & UART_WAKE_SRCS) !=3D UART_WAKE_SRCS)
> > +                     ret =3D 0x01;
> > +             else
> > +                     ret =3D 0x00;
>=20
> Is it a bool or should you name these it with a #define?
bool is the correct data type. I will fix this.

>=20
> > +     }
> > +
> > +     writeb(UART_WAKE_SRCS, port->membase + UART_WAKE_REG);
> > +
> > +     return ret;
> > +}
> > +
> > +void pci1xxxx_port_resume(int line)
> > +{
> > +     struct uart_8250_port *up =3D serial8250_get_port(line);
> > +     struct uart_port *port =3D &up->port;
> > +     unsigned long flags;
> > +
> > +     writeb(UART_WAKE_SRCS, port->membase + UART_WAKE_REG);
> > +
> > +     if (port->suspended =3D=3D 0) {
> > +             spin_lock_irqsave(&port->lock, flags);
> > +             port->mctrl |=3D TIOCM_OUT2;
> > +             port->ops->set_mctrl(port, port->mctrl);
> > +             spin_unlock_irqrestore(&port->lock, flags);
> > +     }
> > +}
> > +
> > +static int pci1xxxx_suspend(struct device *dev) {
> > +     struct pci1xxxx_8250 *priv =3D dev_get_drvdata(dev);
> > +     struct pci_dev *pcidev =3D to_pci_dev(dev);
> > +     unsigned int data;
> > +     void __iomem *p;
> > +     char wakeup =3D 0;
> > +     int i;
> > +
> > +     for (i =3D 0; i < priv->nr; i++) {
> > +             if (priv->line[i] >=3D 0) {
> > +                     serial8250_suspend_port(priv->line[i]);
> > +                     wakeup |=3D pci1xxxx_port_suspend(priv->line[i]);
> > +             }
> > +     }
> > +
> > +     p =3D pci_ioremap_bar(pcidev, 0);
> > +     if (!p) {
> > +             dev_err(dev, "remapping of bar 0 memory failed");
> > +             return -ENOMEM;
> > +     }
> > +
> > +     data =3D readl(p + UART_RESET_REG);
> > +     writel(data | UART_RESET_D3_RESET_DISABLE, p + UART_RESET_REG);
> > +
> > +     if (wakeup)
>=20
> It looks you'd want bool instead of char here.
Yes. I will modify this to bool.

Thank You.

Regards,
Kumaravel
