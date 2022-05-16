Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C798852811E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 11:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbiEPJ6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 05:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242047AbiEPJ4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 05:56:40 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2118.outbound.protection.outlook.com [40.107.113.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A04DCD;
        Mon, 16 May 2022 02:56:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqLIUFu/cdbe1ikMLyZLrAeXeGWLvZB+WXF9vJOBlf1kumuWWaetRV1InYyBY+kb+uSGRaMEWfvA74vAGmzYNjnpN2NvdjeHVyGVqCi3YHSoC7TgmanYYcM8/I8lmh2p/xALo0QskpPtiX6KDmCPI0fV2aeoo9M+tkl2dqxm8dYfq9IJl2250ozvpze5jCdsqEVLkW1PaNeOuaFNnZvn1j2A9K86boUl34j18IixGC7Q9u8Qi0t3ejgZwUMN58cCL04DmKVQoEO0nAcw7CjKQLylBzO7uRaEgPs1J/LTlRs+hCbK5Y7WXlZVybMWtQbnzoFKvL5I0Fzuo2yoKZq3Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVOF/41T4t07VmUqvyKLfiHuwdZJlDJScvx0g71m/5I=;
 b=GLxH3mckZrAH8OFmBHuC0JXfdxKUJIgl8NnIo/RVjFVSwNyv0lcOfWc7LXbsN7x/Vm7cjCCVNoiKpqcfWRNfutrHt1gOy+c1QeyKG5dJfeXi2g2nSrhOV5Eesz1ZI+IezFsdcJYBEhOIZ91xc43c6JGp5WURLuH+mOtD0gffpqf8k1b9AN3UivmNwaoKHBhsKyUXD/3ek5hpdMOMkPk6nGRGetwQ2hAl43d4lBk0b+vZH0TJBYE/3in7dKC2PhmKWyZeIq5ASBigoD8SeQ9bNyGCpJcXfHDaCNtnAVFjJnsaRrQJ4rBmur1QqNCQBERn0qml5EX1EC1f1TmvwFgCIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVOF/41T4t07VmUqvyKLfiHuwdZJlDJScvx0g71m/5I=;
 b=VQTCqLUiTs7Wi6Lv7yAYEVX7nnAxrjGvDT9uWfToXebNeisMV9mD79cpdPEVWCFr0dwRVA7xsMllPKHFz4bPiLuwx+p2PRiPPvNRnQvadH5aCZJ2XCpUBbpk87KVqmrlAAz1S4t5p5TFHtTaLVdU8iBzpk8+VrclzypdBuZ3lQA=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSBPR01MB2040.jpnprd01.prod.outlook.com (2603:1096:603:26::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Mon, 16 May
 2022 09:56:33 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%9]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 09:56:33 +0000
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
Thread-Index: AQHYZWWEBd/euhXmSkarEpD10nkci60a2/SAgACm0QCAAN7IAIAAdeAAgAAJi4CAAD6IgIACRgWAgAB/rgCAASkA8IAAIc+AgAAAN7CAABavAIAAAN2w
Date:   Mon, 16 May 2022 09:56:33 +0000
Message-ID: <OS0PR01MB5922E1334896347568BA2E7A86CF9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
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
        <OS0PR01MB5922F84DA086D2C7F69BB6B386CF9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <87o7zx6ckp.wl-maz@kernel.org>
In-Reply-To: <87o7zx6ckp.wl-maz@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9160f971-0866-4468-a1dc-08da37225bba
x-ms-traffictypediagnostic: OSBPR01MB2040:EE_
x-microsoft-antispam-prvs: <OSBPR01MB2040520EAA9C85E477567CEC86CF9@OSBPR01MB2040.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QGipmutRexJtpPFzzMrhv8ru5itylhDcgW9HnuPOc5RSRAXmsm0rq/KP7NI+4RURsVS09HZdirNBM6JXQLVQVWjy+Stbq3UifWISkKamHmjhkVSTDvElxEcPCtlMdtT3vQhmxtIyy7YSg2viN6prx4IJhd5JxV2OKRlrMjpp8nqkId/kug8PY7BslKSGh/IId4NbmlzaVVXtGH+2dago8uHE1vbwCwVCrNn+e6QWJdIn+oHawv8Gm0wCnSSdyys3HmeFk3uLysnYmWjxibHdoo92sPwGyz1WaEwrF5xPMgALzuBvoST6e16kWRDZ8Vl6faZogU/9TvaOzWfctGvLRJfd4cI2SFzDXc7z8BulQ03piB1/MFV6cQxMIMNi/bLAVUunB6rVRdcGuvFg4Ples/6t7wL3ptvvkGyU5FSvLDv54rD/8uTJgbjU+03dg1POcmQbuoTMQb1L5DxWAU53Oe86JJSqF1hIrK2Ei3Ek3m8y8PbPtqg9Xfhdn86HtOuScNFK/YnCXCn8eTBrrphKZMvwCXvutaaIGf3nv1wQTBNGV4OAGyxIG2gHYsiPsWrIrQqNd4+2TbJQBT6RrwEKtxHPT1Ep8yAZvZF/MjdckoH2HXN4PcTXjhkW1TXF5VxkhMNAKNMOqEjotXXeYtEBn6YKs53g0I7SR+nl24O2jlWq23XQvmU15UgMiAsy/BB7xJ7ZeYt0ZcnXlQ7Ngmdi/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(7696005)(7416002)(86362001)(38070700005)(6916009)(508600001)(55016003)(71200400001)(6506007)(8936002)(9686003)(26005)(52536014)(107886003)(316002)(66556008)(4326008)(64756008)(66476007)(76116006)(8676002)(66946007)(122000001)(54906003)(66446008)(186003)(83380400001)(33656002)(2906002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0T04gnBFWGLsMunYbD+V2HjgEgx+LouTqsRwYrf93ZTmyt+NkQAB0l8zXLy3?=
 =?us-ascii?Q?OT4q1VLgXmRoZCZDhxBxwZBc+Q59Sz4nGGbXewujlTgG6C6gZC4bOChMrehR?=
 =?us-ascii?Q?YThn+HghFbRpPSNVzWk6MdJKzL7Bk2ZSVeTnFz/y/sSTE+39DuSbJDF5NLsY?=
 =?us-ascii?Q?8JQiAVb4n5EVhvfOJK3ZICBeuwIaJxuHQ1TRkdXeYipNfPR34zByTOUfAf1W?=
 =?us-ascii?Q?e3xtXf5zg54nv3iaUtcxN4wQavqjtZCiDQXWWWt2lkJ2GH3GIzmdjyXALD/D?=
 =?us-ascii?Q?XWkU5KIb8lkd21Gir9FtGqlsQKVDKBVIA5hxQU6vSRTymrYROWgibXaaNM5I?=
 =?us-ascii?Q?oJ6rbCZSdNaiCgBTpJViD1x/EgG1GismIIklULHeK+wG7j5W8JPnz+n3+Vle?=
 =?us-ascii?Q?cv//E/lRJ6ctucaBdpS9bXpQhsOcV5DqdN/eZ0AZNjH1SYuDHg7yhrAw7Vy3?=
 =?us-ascii?Q?mLYhUOSzaYWol1nhMnpzbO2ZA6lFYBuW8+yCy52x0Vj+249xj03/4p4JvvEY?=
 =?us-ascii?Q?irnrKwDtB9MX2HRFhGisRhYiiQUprpdcSQwRU8fKXKvl3kHMoIRiRzhjebSN?=
 =?us-ascii?Q?xnhDgvJ/reLvc3Kay8OSiRTqw5/oQpNmAd5QPJ2BmDNpZ8CuyQYJ9Q8OEj0F?=
 =?us-ascii?Q?FV1L7gkLkYUeSuLv8djL8a2Vo1Ri+Gc6bqiKlMg6jXEh1HOx0+1p/QxAYGC7?=
 =?us-ascii?Q?hpkl/VyXzj8QZQn4oIGOzIT0AXhgyjJGq/ej911jvJ6JheSKpQ9sAMHcsxZq?=
 =?us-ascii?Q?fgIjnBD7Uc21FyvHhoDpLS+slq4UnjbgCwOeuSybHNPRdSz4H7ktBiNvn1GF?=
 =?us-ascii?Q?y3fWd5JB4+vDfnzyY68JWkTPoJIRCMo0xiUqYPqgWitADEb10KBvq8XVcvv7?=
 =?us-ascii?Q?FFMJDmTtBttpTc//Poos2Wj5MWZX1MK/eIjS/aCDJDQ5Ju7O657sdBeccbt2?=
 =?us-ascii?Q?pRstH5BIA4qv2p9ddh6UBbVV+lcwZSWkabFtiJNd1A8abHqBtvMzRUfarCV8?=
 =?us-ascii?Q?qvIk6raPuIRmjdTCEZm6yopyvX6Wclbmp5NZgIbdYGkigznO7/21fnoEBT5v?=
 =?us-ascii?Q?etyQ5yEXHLqqR8g5yqZoZHB0sexq5Wj+RA7dj1HKoEODfTWQEpSgH50Q1fWh?=
 =?us-ascii?Q?1eH3JObG6LlVuOk5OuD3GLfbbtZjoRNF6WWtBigvDRNRdArF6+0NWOiB/EOy?=
 =?us-ascii?Q?HN+FITAJGwsFF8wDZEYzSRGTy84jidFh39EHQ8yOeOCGKzZcmJt4+AdG9mtl?=
 =?us-ascii?Q?aW/1pbPr7CfQhQLcn8mAoJ1hqYiP2mivFMVmyaWvXGgAMSbGGtn5S8eSoD0G?=
 =?us-ascii?Q?Yf3jKIIue2B9QyttpW1KObhl9ktHmVBNfizhM+j8yi5pDnrg+mtZ0ESHbu+x?=
 =?us-ascii?Q?y8DVkx2XoYddQvjj2qt5x1HKt8CQ+NzefREwfmP9Hvgvpr2UT8aO6v5glcNP?=
 =?us-ascii?Q?4B+k+AAevznxGdU9NGehkAHtEVIkKJ/cPTDaUa6myUwhtuZwCz8wTQOPWIQd?=
 =?us-ascii?Q?sEBbk+23eUVERNgkpOBNEYKDmUtwGa+rbYi2WmCm/6LCDd5+u11pGwZBEFIJ?=
 =?us-ascii?Q?XyVpcCaKpGOlDmChgr4vCd6bWPv6DBQINBHH4ji0IbIr/E8XKrVbm4JbCNWh?=
 =?us-ascii?Q?cfZ6812jz829O88+1LVLjfAPW7IJLhQmb01G72jH3WZwpM+TP08cNJjWPOqu?=
 =?us-ascii?Q?oSuzVTibMtuHw8hWOYmS4foAkILk1Mbc2uKA+p7NLwUwITLyIJb4JIKdaNVq?=
 =?us-ascii?Q?28h60+/xN1Fdyqc1+JIboZ3KgM+FhdQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9160f971-0866-4468-a1dc-08da37225bba
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2022 09:56:33.3563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: slL12vdKWRx/aAKcRpphIB3MFq6fc2Ru2KQWcPgTinDhOZyAJW2RaKWu8tElDMzuzLB9CMjXqAItOCeikX6HYLxsrQoyyW6bD0hNihh1lc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2040
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

> Subject: Re: [PATCH v3 5/5] pinctrl: renesas: pinctrl-rzg2l: Add IRQ
> domain to handle GPIO interrupt
>=20
> On Mon, 16 May 2022 09:33:03 +0100,
> Biju Das <biju.das.jz@bp.renesas.com> wrote:
> >
> > Hi Marc,
> >
> > .org>; Phil Edworthy
> > > <phil.edworthy@renesas.com>
> > > Subject: Re: [PATCH v3 5/5] pinctrl: renesas: pinctrl-rzg2l: Add IRQ
> > > domain to handle GPIO interrupt
> > >
> > > On Mon, 16 May 2022 08:20:47 +0100,
> > > Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > >
> > > > > >
> > > > > > I believe from interrupt statistics point of view, cat
> > > > > > /proc/interrupts should report actual gpioint number (0->122)
> > > > > > corresponding to pin index for SW1, SW2 and SW3 ??
> > > > >
> > > > > No. There is no need for such userspace-visible behaviour.
> > > > > Userspace has no business tracking those. The required
> > > > > information is in debugfs, and that more than enough.
> > > >
> > > > Ok, So far I used cat /proc/interrupts for debugging, since I
> > > > don't need to enable DEBUG config for Enabling Debugfs for irq.
> > > > This Debugfs irq is new info to me.
> > > >
> > > > Our hardware manual has below info for usb-phy irq
> > > > 2H0_OBINT	126(InterruptID)	SPI 94	IRQ 94	Level
> > > >
> > > > cat /proc/interrupts matches with GICV3 Interrupt ID/ type in the
> > > > HW
> > > manual
> > > > 113:          0          0     GICv3 126 Level     11c50200.usb-phy
> > > >
> > > > Debugfs is also showing similar info like hwirq and interrupt type.
> > > > But I don't know which field corresponds to number of interrupts?
> > > >
> > > > root@smarc-rzg2l:~# cat /sys/kernel/debug/irq/irqs/113
> > > > handler:  handle_fasteoi_irq
> > > > device:   (null)
> > > > status:   0x00000104
> > > > istate:   0x00000000
> > > > ddepth:   0
> > > > wdepth:   0
> > > > dstate:   0x13402204
> > > >             IRQ_TYPE_LEVEL_HIGH
> > > >             IRQD_LEVEL
> > > >             IRQD_ACTIVATED
> > > >             IRQD_IRQ_STARTED
> > > >             IRQD_SINGLE_TARGET
> > > >             IRQD_DEFAULT_TRIGGER_SET
> > > >             IRQD_HANDLE_ENFORCE_IRQCTX
> > > > node:     0
> > > > affinity: 0-1
> > > > effectiv: 0
> > > > domain:  :soc:interrupt-controller@11900000-1
> > > >  hwirq:   0x7e
> > >
> > > 0x7e =3D 126 =3D 94 - 32 -> SPI94.
> > >
> > > What else do you need?
> >
> > OK, similar to GIC, I thought for gpio interrupts,
>=20
> Err. This *IS* the GIC.

Yes, tint0-31(IA55 driver) is connected to the GIC which is backend
On the frontend(Pincontrol driver) where we have 123 interrupts (gpioint0-1=
22) is mapped to tint0_31.
So parent of a particular gpio interrupt can be changed during insmod/rmmod=
 operation.

>=20
> > The  hwirq should match with gpiointN  mentioned in hwmanual. That is
> all.
>=20
> There is no such need.
>=20
> hwirq is whatever the driver decides it is, and userspace can't rely on i=
t
> one way or another. If the driver author decides that it is more
> convenient to number hwirqs backwards, that's absolutely fine. If you are
> debugging, you have access to the driver code, the DT, and all the debugf=
s
> information. You can trace things back and forth as you please.

OK agreed.

Regards,
Biju
