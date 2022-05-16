Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD09527FBE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 10:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241760AbiEPIdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 04:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiEPIdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 04:33:09 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2138.outbound.protection.outlook.com [40.107.113.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8985E09C;
        Mon, 16 May 2022 01:33:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QilfbesBVmy+UnARDKGdDaZDYdKkXkcwWvYS33UJ6Wm1prYXxLBTN8IrkfJzEOTvjS5EAFZhmPNxzQ7UCSNBd++WZb2HCWhleT26j/zlr+CsxpZsywV8+/QOx+6IM/ZsMGtibPYB3LHJCX31Tde7UkoGh2289bc9ySwhkGmcakSMckeDDuvUKpyTuR8w9LQnuEV9tS8V3RcfIvA5phK6PskzcyoYLXCcexlfJD2gw9sdzUt7CMDGZPblZ4VU9iJaZWRK34RI3fvkbJHrnxvbNBT1V6BtTocFK3ejfdV+mhtd0y2gmw/6Ojg7QfvwEcmNJIlTImVVgdSWEAs8eQxflg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTRtrwsewfNRrysdDKCxv1MXkrltvowX3VtBX+LjIJw=;
 b=mqwqQZQbOhJq7lgU9bMyyH5gOmCc3Gw1mFTP8jkZ6p2VcEsxoGLRw6bsjqM9vhDkbTPwy1IYUQCR/SA6cdo/P7MLeMGyYI8FGjK8AOkqA/f0OzjhdcNVmHUZJu8kbG0sJZwcu0OavjEKP2iN/fUjk3gLwOYyXGTF7IU1iKSPCdZGzwpkkRIj/RIKFuH9JRSEZ1XHt2ySdZWy6PIz9TNkBGYde+PqzKwtKdjsWAFSqFP0zYuP23x2087EcgdlIF5H03KYflzl2DmC7gEDPFm8sPceesZ/6qgkdz7A2DNAtYGA4IywkbR5RryJgDcH8A+uYZqQP1ChUmR5fKBECqSUCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTRtrwsewfNRrysdDKCxv1MXkrltvowX3VtBX+LjIJw=;
 b=CB0O+OCju6T/EdR+7tP9240OgDAHmHpUgZSYOQy97pC+w5SKKcwe8Sv7iKX5W6ev1NWkBNKePfHopkM+geUFObORmDRvcb3nPcoHts4nJUYRrfoT9VwJ4GYy/EpIMfu16tAsdfrIzUPnO62F9ASS5AmDwfqk+Ej5594LTYQoU3Q=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSAPR01MB4001.jpnprd01.prod.outlook.com (2603:1096:604:5f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Mon, 16 May
 2022 08:33:03 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%9]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 08:33:03 +0000
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
Thread-Index: AQHYZWWEBd/euhXmSkarEpD10nkci60a2/SAgACm0QCAAN7IAIAAdeAAgAAJi4CAAD6IgIACRgWAgAB/rgCAASkA8IAAIc+AgAAAN7A=
Date:   Mon, 16 May 2022 08:33:03 +0000
Message-ID: <OS0PR01MB5922F84DA086D2C7F69BB6B386CF9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
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
        <OS0PR01MB5922C5E362A582509A814C1586CF9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <87pmkd6gda.wl-maz@kernel.org>
In-Reply-To: <87pmkd6gda.wl-maz@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aacd214f-c183-424c-54a3-08da3716b1af
x-ms-traffictypediagnostic: OSAPR01MB4001:EE_
x-microsoft-antispam-prvs: <OSAPR01MB400114C961DFCFC94684D3AD86CF9@OSAPR01MB4001.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8IXPbQvmI6MSZTznGeQDrtQ/uJ86aPQZ2CQ9NykWz2QMqrKo0TaOvd9xTwb2hbe/OPaye42X87voNEBrJIj4RGme2914505CNDssgmj0BnC+dpGm15bsS9iHo99vNarEe7ALzjbB4gZid8W01iunIe8paNf3xFOdqsCaDlM/jjstKmAsghjkPhu+Nq+UcQcGsWuhvBcWO63N+h5+CuSuo8kFO8hmwWOvQIIt7AVOgIFB2TmTnAsyYC6oDwemigt+DVFqi3yPL4T8anDUSBAFevNFb0JjEv/M3vY+HhzYl9nl3Q7yBEqzzHTpgqAyNtQwTZ732NyBmWWNaQvPl/2qVX6mpzfKbbwFsFTb5vhnfVGUHhwRSL3fLmGxK8yiqpuC5nge3YaKJTMS6RFYpNci71igHVI0JQ5gYdBXSxGTYSy5jhORYmtvRda8CPXR9DTw9CeEaJ8N6J59ArqyOZWGQDlCyuLCTdoU3oDxJk9M7iu3UOsCKIR3Ez3K3OUvC1Q2DWMnFuV2L6N8GmVmyZd/UAVzX4trk72Kb7uu9tCRx+eHk5dJR9vaqsbREbA+pKdoavOGy42yRMPaud9sqIyRtWXcXWEdCRKOwouRnskAL8PNcQPEvkekiFmA5m+hzAi7R0G1dUbmsyIpS+DyV82kluihY415n9GKt+NCeFm4lI1+1pyJMCxlh/vBGO6HMFyjFFI974+pC/9piy1ZZdsMif7Lh0Xms/HYkwHwliAIrjI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(54906003)(107886003)(66556008)(76116006)(66946007)(9686003)(26005)(64756008)(66446008)(66476007)(83380400001)(8676002)(6506007)(4326008)(55016003)(316002)(7416002)(71200400001)(38070700005)(86362001)(5660300002)(508600001)(52536014)(8936002)(33656002)(2906002)(122000001)(38100700002)(186003)(7696005)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?17pmn2BEiw0FS6lTHeorTsrZjfz41O6c6T7aaju9WU6wdOP6z9HVUpkfwgFb?=
 =?us-ascii?Q?sYuganTAWv1r6RfHxM7vlUsSoZgBVjpKeMlRrRy4EM39XrvFw+yyGrSR0w/b?=
 =?us-ascii?Q?QaO73WXHAtEr2R+Rp4lAP0zoK7LtIrs3giEKUaPEZopwENgY+ZaoDGNugto7?=
 =?us-ascii?Q?SYIkUA97S9AnV+C8zkTFEqbiPPGitwDTkF4FFW4rsYGLwumE7iXcYgNfcUns?=
 =?us-ascii?Q?sg1WsU7b39qG5pSBjsGUZcQEEt9sm+EuvqSnACBLZsNC5oEjM3aaNZFfvNJH?=
 =?us-ascii?Q?2IO6LLVAan0lmvDDuuIDfAPnjheGioQXG+TaDVY/7Pf07nULB4mvly7DVqS/?=
 =?us-ascii?Q?nJpCVkbM2ETYW6vWDeLp4SnjBl/+mpB2LKQt8Ztixr2KVISwjaYrf93VOfs4?=
 =?us-ascii?Q?RKWuSu3uqDnRMxi2hTeCyiVn8OlA+ClhuAjh/41B7Gk2JhE6WhZ9Nutkq16H?=
 =?us-ascii?Q?eLefjSF9xRbMMiS55oMbNHJrR9QVu2Vn6t5RyEovQQvqmAWGAJ2ZL754Gio0?=
 =?us-ascii?Q?JZn+S5qqQPenvHwzLKDFhg8xgAfnAmRxZDG8gCnTsly3KYVwoAGDwYYVAIbQ?=
 =?us-ascii?Q?QbL7btUkVf0jIdzi8tg4/FLrp8oqVKX3QT58JXqfOmzXzDVb21q9vl2WBC32?=
 =?us-ascii?Q?b/ueeAfOYBpsPzVn6ZzznATvEvQaHO0X43zq5ofK1oj27lOesfMcoqScMC/R?=
 =?us-ascii?Q?dSxM6/vtGib1r5EVZptevcvEX8ZPCrNz1QvyFIyoLugiZyZQXvYgYbS9bJQj?=
 =?us-ascii?Q?a11GHrq600v1lbJ0pmPNrzMBGdQ4tHMPRtlYKdquBLyHtcMzgglB1hJb7ePW?=
 =?us-ascii?Q?XRqo8gL6KiK9kqjCcR/iwh7Y/wJ4NiYbL2czHXd/zh3ctDPA4DrXAF3of9XJ?=
 =?us-ascii?Q?irHd9RpO11TbrKPT+nflP3jb22n+LATjHgSL3scz1eeHdD2SOHx79f4C1zIX?=
 =?us-ascii?Q?aEgwrZHC0EMt0tNjn/Mz4yHGaFvlqRRgiHWW+VrMmpq6O/LbU2glnuNJ+ISM?=
 =?us-ascii?Q?LZJzHfM1KOM4nmXJAuScO/meAdJSbeFyy/TUI11znm/BgZQQS+/q8RicfEdm?=
 =?us-ascii?Q?gtxYTmZMDggKh2/l/FSBkM6rzNflubHphJdI/HIQAx3909wvGb3GynSaDQC6?=
 =?us-ascii?Q?2qImCylH94FCijmAg0GLid2ZO+BrQjEG2eZ6Q4Sq4WEQYx/XL9/OJ8nppBda?=
 =?us-ascii?Q?jkaDXvg37Y5tRKEyO0ZLikYJKe+IJCDtSYs33enXMErBxIuPiKi2lYe+48vZ?=
 =?us-ascii?Q?k7SNM3QBn5WJEABdXwyQA5+kVARtKebMIRH/yaX2LImzDtTmjsRgPamkpX5i?=
 =?us-ascii?Q?JriL2iyA9yL2U8aO9cKmoemnjdDs5cR5Fj2UiFwXk6ypFSlsa5oaQwHkSGfF?=
 =?us-ascii?Q?hqCvxwXr6nUQtdPqlH9vQP060ZY/J4Z6uzOrOZX33fzoyYmMeFO8NbKG/tgZ?=
 =?us-ascii?Q?o093waSQMSZh92I7QVmo7I/RPCUWJ/D3zt3ybLwQ7iWypwB7v04yYlGuEQSd?=
 =?us-ascii?Q?JbaiIh++PTjYlZnzKZvyTpVtyc+U0+8T5q3laOJ2myYDxNN9/9FNhdBbXIs6?=
 =?us-ascii?Q?U8ma5sIz5SKilXLS/W+umq971GCSBAD4kxNpK+IvtSKggi3gAzW4symEh14Z?=
 =?us-ascii?Q?BIWszsQDaw/xcSk71i2acZAHOYc5BnVWiZlwNIELWIMbfUoZSyg0JAFXoJtd?=
 =?us-ascii?Q?zV/hfmDyqfvB0jxvgLjepj0ck5bI/XLUkBcNPsFQQ2wAFWbkl84sEWjKn+NB?=
 =?us-ascii?Q?dy2xv/LD6Y5NvZHyZIGs9c0fYAWx+HI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aacd214f-c183-424c-54a3-08da3716b1af
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2022 08:33:03.5743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W4zB3AnOnEorFl0Fo13Q+60x8AbnrghMlWRaTugXV99WpLj522cRDUXGUo99YRRp29TnKyBrNvKGUFSHeORbNM0fqHv0wRpxYt4ribb03yc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4001
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

.org>; Phil Edworthy
> <phil.edworthy@renesas.com>
> Subject: Re: [PATCH v3 5/5] pinctrl: renesas: pinctrl-rzg2l: Add IRQ
> domain to handle GPIO interrupt
>=20
> On Mon, 16 May 2022 08:20:47 +0100,
> Biju Das <biju.das.jz@bp.renesas.com> wrote:
> >
> > > >
> > > > I believe from interrupt statistics point of view, cat
> > > > /proc/interrupts should report actual gpioint number (0->122)
> > > > corresponding to pin index for SW1, SW2 and SW3 ??
> > >
> > > No. There is no need for such userspace-visible behaviour. Userspace
> > > has no business tracking those. The required information is in
> > > debugfs, and that more than enough.
> >
> > Ok, So far I used cat /proc/interrupts for debugging, since I don't
> > need to enable DEBUG config for Enabling Debugfs for irq. This Debugfs
> > irq is new info to me.
> >
> > Our hardware manual has below info for usb-phy irq
> > 2H0_OBINT	126(InterruptID)	SPI 94	IRQ 94	Level
> >
> > cat /proc/interrupts matches with GICV3 Interrupt ID/ type in the HW
> manual
> > 113:          0          0     GICv3 126 Level     11c50200.usb-phy
> >
> > Debugfs is also showing similar info like hwirq and interrupt type.
> > But I don't know which field corresponds to number of interrupts?
> >
> > root@smarc-rzg2l:~# cat /sys/kernel/debug/irq/irqs/113
> > handler:  handle_fasteoi_irq
> > device:   (null)
> > status:   0x00000104
> > istate:   0x00000000
> > ddepth:   0
> > wdepth:   0
> > dstate:   0x13402204
> >             IRQ_TYPE_LEVEL_HIGH
> >             IRQD_LEVEL
> >             IRQD_ACTIVATED
> >             IRQD_IRQ_STARTED
> >             IRQD_SINGLE_TARGET
> >             IRQD_DEFAULT_TRIGGER_SET
> >             IRQD_HANDLE_ENFORCE_IRQCTX
> > node:     0
> > affinity: 0-1
> > effectiv: 0
> > domain:  :soc:interrupt-controller@11900000-1
> >  hwirq:   0x7e
>=20
> 0x7e =3D 126 =3D 94 - 32 -> SPI94.
>=20
> What else do you need?

OK, similar to GIC, I thought for gpio interrupts,

The  hwirq should match with gpiointN  mentioned in hwmanual. That is all.
Any way it is minor thing, it may be not at all needed. Please ignore this.

Eg:-for gpioint0, it should be

root@smarc-rzg2l:~# cat /proc/interrupts | grep SW
 82:          0          0 11030000.pinctrl 0 Edge      XXX

Not like

root@smarc-rzg2l:~# cat /proc/interrupts | grep SW
 82:          0          0 11030000.pinctrl 120 Edge      XXX

Cheers,
Biju

>=20
> >  chip:    GICv3
> >   flags:   0x15
> >              IRQCHIP_SET_TYPE_MASKED
> >              IRQCHIP_MASK_ON_SUSPEND
> >              IRQCHIP_SKIP_SET_WAKE
> >
> > Now coming to current case,
> >
> > Currently GPIO INT 0-122(123 interrupts) corresponding to
> > 120-511(291 interrupts) with same invalid lines.
> >
> > From a debugging point, If user has put same irq name for gpioints(cat
> > /proc/interrupts case), then how do we distinguish these interrupts??
> > (using hwirq??)
>=20
> Yes.
>=20
> >
> > For using Debugfs, Do we need to first execute cat /proc/interrupts to
> > get virq and from there we need to use virq to get statistics, right?
>=20
> It depends what you want to do. /sys/kernel/debug/irq/irqs/ has the exact
> same information. The only thing /proc/interrupts has that debugfs doesn'=
t
> is the per-CPU accounting of delivered interrupts.



