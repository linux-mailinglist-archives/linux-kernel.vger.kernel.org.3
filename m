Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A04527E74
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241018AbiEPHUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240694AbiEPHUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:20:52 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2111.outbound.protection.outlook.com [40.107.113.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3ADC654F;
        Mon, 16 May 2022 00:20:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtE3Mgr0jslYJUZTThuGRuu4kmkgHvuwnhxY90OhaFWYhMv+3RqP5Rai0d+7wjCMippAVIWOuC1TYyfYCpifiSt/r3Iyc4C5KkhxOzm+/wGtceyxE7OHEjWhuMy1fBjLW89pjknUsvUs1uLod3zACdm3pUff3HHWaZvu+jORT5hX/3dnZz/zluu/HT+s4J3JXSRFiafKh7VCn80wOUgrQx4nXK61Hhw8ll3nxmNiOhny0TKtc4jafUjBrzIMfJpfNHU2B0tVWCJBmyEh1dpoQIKYyeTBCCuWWA605SDBvdpNpRb4QlQt9vhI0duCoUAdZ3xvd4Sh0wN43NP1SdJe/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqrgogblptlkWmTU0QClGN41mCfpTgAPEgBKXNSd864=;
 b=ifpYZB6J97I+vVur2b3j/L7SObUhe6lvvzwiEAa02YPPhHMsMoZNlEQQJ2e6j7bkvA3ZzAyv5Uek4k6BMqT9GwtApI8bgsdiq7dw09JOpjtt/WkMtErl79ZTBqbYS79Qu0XQ3NTok7c0QnULOyi05YmqWZfyYFA051t7fk5D7lOSAmvS2UMsenZWtlbDJiAfMukcsZmJlRokykZ++6/AyJo36ixCCB/Fzre1o19hb+Kvkd5N6nPAu1Yy/9JALe/JK8kPDa5mySz/U1/tCMOG4QkHTXESK71s1loAR9okIEfVEOWollQhSmAVLXGwxdKVVJrR3M5mTsl9BNSzgON6Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqrgogblptlkWmTU0QClGN41mCfpTgAPEgBKXNSd864=;
 b=gibQgG8oBhfAw0HOrZx4EKJDCx4Sjua8kVjHUdBowZckphvpoAd1wvzkZ7aJnW4IOLPyE9qug9PP6hyMC0sUJfhDlu3kr0K7v8hV9IDeCT4VTt+qhPUS1a0Rr2gMwXwxOa8w6UZoArTpn/iO0CwXHcCGc2CbmzdOwV5CBZcIGkg=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB7080.jpnprd01.prod.outlook.com (2603:1096:604:128::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Mon, 16 May
 2022 07:20:48 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%9]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 07:20:48 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: RE: [PATCH v3 5/5] pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain to
 handle GPIO interrupt
Thread-Topic: [PATCH v3 5/5] pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain
 to handle GPIO interrupt
Thread-Index: AQHYZWWEBd/euhXmSkarEpD10nkci60a2/SAgACm0QCAAN7IAIAAdeAAgAAJi4CAAD6IgIACRgWAgAB/rgCAASkA8A==
Date:   Mon, 16 May 2022 07:20:47 +0000
Message-ID: <OS0PR01MB5922C5E362A582509A814C1586CF9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220511183210.5248-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
        <20220511183210.5248-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
        <CAMuHMdXDQ+eECWwvAGOb-MaN16H17qm_v_1baZ7PdT8qx9McSw@mail.gmail.com>
        <CA+V-a8tNrJQtAQYoUKVwH9w4QOyA9JUWNjiYDPUPsj6UuJ4vaA@mail.gmail.com>
        <CAMuHMdVazy9y_U6Nva+B-3vuX1Ersq+QirXDDgSh28pj8s=EJA@mail.gmail.com>
        <CA+V-a8s2Gf22MPLoZMJS_5uDwzOboJ2i8rZ3KdRFy7a7wv8pGg@mail.gmail.com>
        <CAMuHMdXHJ385isGd-x8u4sFm1w=rxOC89SUryYbSd34bijkb0g@mail.gmail.com>
        <CA+V-a8uXakF45TLvpsfeAY_EZKDGHr-wfgqLR_LTz1ZAo8FYmg@mail.gmail.com>
        <OS0PR01MB5922C5DD97F922396CFDA6BD86CC9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <87pmkfm0v3.wl-maz@kernel.org>
In-Reply-To: <87pmkfm0v3.wl-maz@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9bcfe90-f2d9-4686-4cc5-08da370c9979
x-ms-traffictypediagnostic: OS3PR01MB7080:EE_
x-microsoft-antispam-prvs: <OS3PR01MB708018523EE94DA35FCEF1DD86CF9@OS3PR01MB7080.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XCqDWfnTgqe69Kcdc0UVAoCKBQcSPNNcnxPRlsc660Dn6+nBk/AGhBrE55GyNkaU26b5DiPhMKrAsSFSFExdciGCUV2dqoou3VqWXTs66pFOHxVGji6ggzptqGFnjDoECCgH12WOBEU5eXoXUmQYWPAt11YtfWSIFh+dHIKI++MQON1AO0P4goPcHZKjX9lRxXxa6fT85fnrjsIE+Mc0DWamTqPb4hoPfZpYvwuinP6hIfiOtbs1GTAqNz0LtzjpzR7zR3pGk4l70s8R2nc3UBP92AMyj99NUp2WU1g38oYtGONXb9eqweKVPAqdSMWJl+MWo3AGf8qlm3FaIt8eBAMv7kkHuHMmaKaORwz5v2Y7PmqcawP6PZzmHYseF9DYbi0RulJYGT/TprwFTLosiwDrT5/CDwbJD4fOnEPU9Wlt9tsomOw5dq2b/pVj6muntA561EO2oT5lzzsKjjn4b+0BKMwGFYqS/e1/E4GUPUNZUY9vBBCBgfT6RBjk/WV4mSRdDgiDM3zXOTSqvgsVFf2zj9UdufpvIHt0IdMSy0ekffRMgflQyH4kH0foh9eWJgRxC3RC0/ooIHrTVjCujjuSOZK3sCfTvSw9C8hGo/sxciMVAzH34CQD9Ic5kNmqVloT2n903nJLtsQEokBo+ee/yzZxma0VZrx1KCJG+Kg2JvPEw0B07wTMJII/vaLlEUTI1Opl4N+lWsNS8EnyrA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(6506007)(55016003)(83380400001)(38100700002)(52536014)(7416002)(26005)(33656002)(9686003)(508600001)(54906003)(6916009)(38070700005)(8676002)(64756008)(122000001)(86362001)(186003)(66556008)(8936002)(2906002)(7696005)(66946007)(66446008)(76116006)(4326008)(5660300002)(107886003)(71200400001)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/IUsfHv6xnJBJIuljixvv2CGyBvPtYteGx7dHCPhoUx0BrSUe6i+MN8VzkVe?=
 =?us-ascii?Q?XpmpMtetyqzv8rLVGiITLvYT0nei7D/YIaOiSyqnthuol5PSL2PJgXqK8Jfl?=
 =?us-ascii?Q?P9loyRZ7UtOXsS+233k/PFlbf3mRWsa5gafl6aCUsUjEmbxC7aTKRRe5an3B?=
 =?us-ascii?Q?YDA9zbGrbcizCNqOWWdSxKhYWe3xv0tYUElwQcFjM0zW1ibbIpy5WFAD9itE?=
 =?us-ascii?Q?erqgQjbu5uxP4uNWMJrZxXdX/mlpXTCrYmnzDOOwGdv2CFynYfTkr5KqFeNS?=
 =?us-ascii?Q?G1xPNJw6QucCv+Doe5G0tmE1NI75DK+RBvEAseO9bSdUvNLwAu4uYNxhEbdR?=
 =?us-ascii?Q?5kJNHHmCigwOmrVXvNOxd6aP1PMY0atVpaitoZVQS2hnJAzjh02bRjA8enWO?=
 =?us-ascii?Q?/kxuGvk+J8SxrU2swTUMcwFRBzp2UeiO7vLhO3FKZTV+gjAlB5deKC5kuQ1F?=
 =?us-ascii?Q?6rVa3IKkRcPDrdYsKXlXr2OWk7yWixegI0TtpzdzncoeFibkjVxwjj392HF4?=
 =?us-ascii?Q?RKr0qvS2RJfrPDG+KF5tW2lWcrt8/+bRSdUuqwWLkCaqn9c2dmkc7NgQYR8x?=
 =?us-ascii?Q?rHvUH4Ja0BJar/LADIDD9lwoXFB68KRyk0f4EJfKSajcu5xzRFf5YRjDR3lg?=
 =?us-ascii?Q?+vSGIcCmEeYFfFbxQvMg8ZtjoA6E6/M9xe9cgfpdXzGcMqPvEtN42g+DZC8x?=
 =?us-ascii?Q?ldQO1W39H8QLWDH47TAcPaSZAWfcAFNkLhPPKw6AdgcS/j9UYjvvmk8wqdzY?=
 =?us-ascii?Q?jtqtUA9Wso6KVwAoioojW0qxxW8YXCFKnRaDEuIDWOVLTKsRM9M8yrYlwUG7?=
 =?us-ascii?Q?SF+mmT8KJZenZxfTvmz9SwIP3ZTkE4YRtg1kPMGanhzkUnuWz0L53kj3Bw36?=
 =?us-ascii?Q?YHg0PV2cFEW/NjJAXG5ri1nbjmsxTkB9yitojLcMCavcQxITNIUtk2js6STH?=
 =?us-ascii?Q?rNBTGWRgat0T5pJjrtP9qUz9lbJ9F9m41mdEH7idIH4OPkL2lNY2A5cNmIX8?=
 =?us-ascii?Q?BdTfd9KQZ4TuAKcJ3OSjUNuWgr4h+UtdYklPtzqcNXmleO6AzywpA9pIF852?=
 =?us-ascii?Q?mqYpFlkQM/5TNvlrzk3rSlB34s48c7fHXmBz5+xREocGzelL8o4cooHu/Voi?=
 =?us-ascii?Q?XPckOg5S/ezl1WFTfdTFKlYqif5TX3BZleDPNO+YrpbKskjhoTUfiKpaGubu?=
 =?us-ascii?Q?A5vl8A4UasCnBy57o2tP8QpGsxpGCzCpyXB/QIX4gtHtgu8rC8CddHr8D9EE?=
 =?us-ascii?Q?xIZvNTvAlHQuYYjynaubk/ma/qo0aYzDN7QRfJlwRaGPQcvCrL5vBen97Xha?=
 =?us-ascii?Q?puGaxAX1MUoSfOItP/W7awE8ESRrRSItuK7KXZJ6GQn2lDyU0JcC7CUT9z0Z?=
 =?us-ascii?Q?z1fda4rlpuVdmCDd5Plns8tWGssPA6OL30jeMk2OEnVR2jfE6f3QZQTVRP4D?=
 =?us-ascii?Q?PTrgf40FylQBHfFDiVIDV2+DQz1LYYWY62T/bPdJFIoAFiZ8fZ+51o0YLZeh?=
 =?us-ascii?Q?3iU+q0xs3EpeC2f7PskQQiywhWAegv3DylJ6TZZQn3kwjCrI6wGESPzp8OMe?=
 =?us-ascii?Q?gvt73TD1HoGLehfgF1VqsVB+h5LmaT3uyb9mbmDHjU2sWrLM2LF0mbAXnTef?=
 =?us-ascii?Q?vl1SzBUyLSzeWv5O3GFjnTCkL54hQtssuEn//ZyH7io6WD3k7QeXk7x5xu7M?=
 =?us-ascii?Q?syMMnRc5slBpq01q8JB2IEmDb83FeG3ECAKFMKj3gcm+CtdSHid/b+poVK5P?=
 =?us-ascii?Q?ZCDuHn4KClHt7p3n+DEb39PeCcaRNwY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9bcfe90-f2d9-4686-4cc5-08da370c9979
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2022 07:20:47.9876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y64Z0Plk5PComjs/ffxu1aogcETKLWzQpsTNEMYugVNLEtLVPVpLoJpTEfqpO1yQnLA8WxeJAPqS8OeKx8KX6AqfIpNREoyfNRQdW2gs1kg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7080
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

Thanks for the feedback.

> Subject: Re: [PATCH v3 5/5] pinctrl: renesas: pinctrl-rzg2l: Add IRQ doma=
in
> to handle GPIO interrupt
>=20
> On Sun, 15 May 2022 06:13:22 +0100,
> Biju Das <biju.das.jz@bp.renesas.com> wrote:
> >
> > Hi Prabhakar,
> >
> > Thanks for the example.
> >
> > > Subject: Re: [PATCH v3 5/5] pinctrl: renesas: pinctrl-rzg2l: Add IRQ
> > > domain to handle GPIO interrupt
> > >
> > > > But "offset" is a number from the GPIO offset space (0-122), while
> > >
> > > The "offset" reported by kernel is 120-511:
> > >
> > > root@smarc-rzg2l:~# cat /sys/kernel/debug/gpio
> > > gpiochip0: GPIOs 120-511, parent: platform/11030000.pinctrl,
> > > 11030000.pinctrl:
> > >  gpio-120 (P0_0                )
> > >  gpio-121 (P0_1                )
> > >  gpio-122 (P0_2                )
> > >  gpio-123 (P0_3                )
> > >  gpio-124 (P0_4                )
> > > .....
> > >  gpio-507 (P48_3               )
> > >  gpio-508 (P48_4               )
> > >  gpio-509 (P48_5               )
> > >  gpio-510 (P48_6               )
> > >  gpio-511 (P48_7               )
> > >
> > > > irq_find_mapping() expects a number from the domain's IRQ space,
> > > > which is only 0-31?
> > > >
> > > Nope, let me demonstrate with an example, I have configured the gpio
> > > pins as GPIO keys in DTS:
> > >
> > > +       keyboard {
> > > +               compatible =3D "gpio-keys";
> > > +               status =3D "okay";
> > > +
> > > +               key-1 {
> > > +                       gpios =3D <&pinctrl RZG2L_GPIO(43, 0)
> > > GPIO_ACTIVE_HIGH>;
> > > +                       linux,code =3D <KEY_1>;
> > > +                       linux,input-type =3D <EV_KEY>;
> > > +                       wakeup-source;
> > > +                       label =3D "SW1";
> > > +               };
> > > +
> > > +               key-2 {
> > > +                       gpios =3D <&pinctrl RZG2L_GPIO(41, 0)
> > > GPIO_ACTIVE_HIGH>;
> > > +                       linux,code =3D <KEY_2>;
> > > +                       linux,input-type =3D <EV_KEY>;
> > > +                       wakeup-source;
> > > +                       label =3D "SW2";
> > > +               };
> > > +
> > > +               key-3 {
> > > +                       gpios =3D <&pinctrl RZG2L_GPIO(43, 1)
> > > GPIO_ACTIVE_HIGH>;
> > > +                       linux,code =3D <KEY_3>;
> > > +                       linux,input-type =3D <EV_KEY>;
> > > +                       wakeup-source;
> > > +                       label =3D "SW3";
> > > +               };
> > > +       };
> > >
> > > root@smarc-rzg2l:~# cat /proc/interrupts | grep SW
> > > root@smarc-rzg2l:~# root@smarc-rzg2l:~# insmod gpio_keys.ko [
> > > 925.002720] input: keyboard as
> > > /devices/platform/keyboard/input/input3
> > > root@smarc-rzg2l:~# cat /proc/interrupts | grep SW
> > >  82:          0          0 11030000.pinctrl 344 Edge      SW1
> > >  83:          0          0 11030000.pinctrl 328 Edge      SW2
> > >  84:          0          0 11030000.pinctrl 345 Edge      SW3
> > > root@smarc-rzg2l:~#
> > >
> > > In here 82/83/84 are virq and 344/328/345 are hwirq, which can be
> > > confirmed from sysfs file:
> >
> > From your example, Looks like
> >
> > I believe from interrupt statistics point of view, cat
> > /proc/interrupts should report actual gpioint number (0->122)
> > corresponding to pin index for SW1, SW2 and SW3 ??
>=20
> No. There is no need for such userspace-visible behaviour. Userspace has =
no
> business tracking those. The required information is in debugfs, and that
> more than enough.

Ok, So far I used cat /proc/interrupts for debugging, since I don't need to=
 enable DEBUG config for
Enabling Debugfs for irq. This Debugfs irq is new info to me.

Our hardware manual has below info for usb-phy irq
2H0_OBINT	126(InterruptID)	SPI 94	IRQ 94	Level

cat /proc/interrupts matches with GICV3 Interrupt ID/ type in the HW manual
113:          0          0     GICv3 126 Level     11c50200.usb-phy

Debugfs is also showing similar info like hwirq and interrupt type. But I d=
on't know which field corresponds to number
of interrupts?=20

root@smarc-rzg2l:~# cat /sys/kernel/debug/irq/irqs/113
handler:  handle_fasteoi_irq
device:   (null)
status:   0x00000104
istate:   0x00000000
ddepth:   0
wdepth:   0
dstate:   0x13402204
            IRQ_TYPE_LEVEL_HIGH
            IRQD_LEVEL
            IRQD_ACTIVATED
            IRQD_IRQ_STARTED
            IRQD_SINGLE_TARGET
            IRQD_DEFAULT_TRIGGER_SET
            IRQD_HANDLE_ENFORCE_IRQCTX
node:     0
affinity: 0-1
effectiv: 0
domain:  :soc:interrupt-controller@11900000-1
 hwirq:   0x7e
 chip:    GICv3
  flags:   0x15
             IRQCHIP_SET_TYPE_MASKED
             IRQCHIP_MASK_ON_SUSPEND
             IRQCHIP_SKIP_SET_WAKE

Now coming to current case,

Currently GPIO INT 0-122(123 interrupts) corresponding to 120-511(291 inter=
rupts) with same invalid lines.

From a debugging point, If user has put same irq name for gpioints(cat /pro=
c/interrupts case), then how do we distinguish these interrupts??
(using hwirq??)

For using Debugfs, Do we need to first execute cat /proc/interrupts to get =
virq and from there we need to use virq to get statistics, right?

Cheers,
Biju


