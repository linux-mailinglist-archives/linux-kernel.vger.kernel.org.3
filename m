Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D811509172
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 22:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382114AbiDTUbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 16:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353413AbiDTUbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 16:31:33 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2116.outbound.protection.outlook.com [40.107.113.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8423B28C;
        Wed, 20 Apr 2022 13:28:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2ZZdKMhDu4ghBURY9nYWFI6hRu0qvS38FK6+oPaROLMKtJj6mEp6KrC6uTGb+WhHbmF86clzkg+xeU3/KuxSpBRucnwgAO2SgKVh1gwbudLMRByD14POu9mMmRZpTsOf3qGqiKYmSenbT0FWKVCRGbINWxSP1sjxsjnYLsgDnKP7roM4Anvt6dd0BzSN2gNUZJoktCuvLeZ0JINi8ogd9SLaCHbk3OfVqkwvlmZV/NmKdxyCeYv4nnVamPAnHNethFmulhdWXZ0dd9XsZ8heuLBapxjZlyPnjHgNpOKE+j/m9ozb2m/yze4thqXnmBCF0ySbQhNz155IHTyKm72jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXyQo7GyVuVo5GkVjtumelgHfr7tlmu/0WqgA0y1nz4=;
 b=kYTVBd8TEaIvDs9fTmJOndwHiR9sDeixb++CGC6k35K6sp9lgboVVGxD1i8LyGrb6JGpVTISnnUyT/y/LdRZav03bARqljc58e8LujaZvtt1BJCSdV86sPDl02BRUQGgudpxtRVTM4dUs/OyHh0YfV/gzVmSB4b8T1YPuxxzdV8w2XOLdl5VICVbxjiqs8wZL9S3krRDawb1cCypeIatM81TsZ5x1j5NxCwxlYYG23FjtQU/xwgDyYE9QRP09mISm3p3IRNwAZwiVg1a+ifB6UYwNkESkOfXMCKv7yin6q6CWQUfA/mxH9HksXDBitHr6j/cFVUMMoiQ74IjShzJcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXyQo7GyVuVo5GkVjtumelgHfr7tlmu/0WqgA0y1nz4=;
 b=UwmoFKsJ2jX8IZ/+K1XSmQYknCm6PtBPff4bNzjnDrZef9LrVD/fPymdZo/1NXfXNCHLDxQ/0z6dbM1fxfKImIvQdJUOm92siQQVZmR6gwYnd0IwrW0hKFWS2+1zOLwM120SyVsqT6yeOe0PwiXpNOtBRQTR0yf61ruxt5VG6Ok=
Received: from TYYPR01MB7086.jpnprd01.prod.outlook.com (2603:1096:400:de::11)
 by TYCPR01MB6640.jpnprd01.prod.outlook.com (2603:1096:400:9d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 20:28:42 +0000
Received: from TYYPR01MB7086.jpnprd01.prod.outlook.com
 ([fe80::7120:d44f:518:6daa]) by TYYPR01MB7086.jpnprd01.prod.outlook.com
 ([fe80::7120:d44f:518:6daa%8]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 20:28:41 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 00/14] Add new Renesas RZ/V2M SoC and Renesas RZ/V2M
 EVK support
Thread-Topic: [PATCH v2 00/14] Add new Renesas RZ/V2M SoC and Renesas RZ/V2M
 EVK support
Thread-Index: AQHYREx+KCdmySc6EUmO5txhFJSXa6z5XQUAgAACc9A=
Date:   Wed, 20 Apr 2022 20:28:41 +0000
Message-ID: <TYYPR01MB70863D0C83AA776A2E48C58FF5F59@TYYPR01MB7086.jpnprd01.prod.outlook.com>
References: <20220330154024.112270-1-phil.edworthy@renesas.com>
 <CAMuHMdVV=PBfboHUk-wi1coAy7rcpDngKGSTqDWh-5vnSc91pg@mail.gmail.com>
In-Reply-To: <CAMuHMdVV=PBfboHUk-wi1coAy7rcpDngKGSTqDWh-5vnSc91pg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9aeb63f-5247-4337-4f96-08da230c5bb8
x-ms-traffictypediagnostic: TYCPR01MB6640:EE_
x-microsoft-antispam-prvs: <TYCPR01MB66404C861C820578FB177D10F5F59@TYCPR01MB6640.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C4VhqE8CPZid1V5BBPwrU5dFYIrALBdgoDW7Z3LYSMzbOJM+Owr175sbZjJkds+WQIuHURMc3v4WeK4Ng8FAXkXW6rBxVtfJNCPUwAXm04D6utURUr0Z+ITStAlxpeGPWEOdW8L4iaAhy3RYqg6bfQFO65i1jgs+Ht2TWH8xc+Pr6hdtEl8akGEI39tFj7Wq+nXiI+UUsXE/u51R0Hfqn1m0axdZvO9SYl9O2ETzsMgSWWPtJtpspdwcNesH9ElQ4erf94s7M0Mh4V9jHf6nR5Z6wtCXSx6kJEjGEzK9e0ivKC8kcDX9jJYH2yze6v6ZiXzsBvBGFVM275eTkMgUvJR0Gdz+fdTrQMGUL1PNI9RvkFw2W49VgsNqrlfBTLX2S0KuywdyISIz5ri/VWmUSKpaqZMu6Oz7Tthd41Zd+BtYmdqguU+ifhjEOpmK7zD/FOPsEc2tAFqbz19UWKabxrDEezpfb4tYiXj2ZePx1KeVTrErMMqMu5HYSJ658njWG+sPv5yzmfMO+0REesBhVUKH6vqdibIdfuCe7Fv/Yrc0jMFvY8stham+QjTUIzCJ3Kr6efFpVSxSSHDzIU+Iwx3gbLHJ/C7u56di7iLpXwxyC1RcZJ9cAWrCzml9mFkrbJ89vbYr9wwHcqniHjXm+5WGG+K43qt9QOjX96apMlIQ1B0nLshJg6j4p1nAgM/uHVEW4YOP+4Zix1G3CI6LwE/zKjSeR/ZsHgXJzitLroNT1v/FhFgmGh/FD317v7lpkSNONqjdClj9ek0C6RR1FZ0yG8jkdU6dFpsBsYGx+PQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB7086.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52536014)(6506007)(53546011)(8936002)(9686003)(5660300002)(66946007)(7416002)(64756008)(76116006)(8676002)(54906003)(186003)(66556008)(66476007)(55016003)(26005)(86362001)(4326008)(66446008)(316002)(6916009)(33656002)(508600001)(71200400001)(2906002)(44832011)(38070700005)(966005)(38100700002)(7696005)(122000001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?agtsnkUy0NBTVgAZWxG4mk2B/oGNm/bqpd0HeMJ2ilOBajHC3OxU7kQcx/t4?=
 =?us-ascii?Q?RKYtUzap9KXEMDg37TltnnIHzMqc0XKvi95WFaBK32hjfHpjtquF+JganEjx?=
 =?us-ascii?Q?xv0wclRahaQ1TuGQelQ4tNjxNACB+OAv47YW1n7SbQkobhb9e6gPGQVIpZ1Y?=
 =?us-ascii?Q?keeUfNU4gQcJITLkKn3/OPIGiNWdg4FOJUR4bzwtWoCkebUjTD5ZRC6Ylm0v?=
 =?us-ascii?Q?6oZFxY4rAQ/HUzaT9gRxS8gf14rw/A80VVFLFlebJEGAydRmI7ckkh/sE0NF?=
 =?us-ascii?Q?N/650vey1GgpBs4KEZ00B0DLmSrhlZBlsXosUxry8EBRYSU6SdSpwnBXX3rF?=
 =?us-ascii?Q?41fDx2UIgxEJ0wUWS2xC/AkRuuCP1rRcuCs+rbFx76iRLkuJ+G10pFUFJOnD?=
 =?us-ascii?Q?Nx0QpQKbx/iwDlGXYpuJZBGgl+ZykInzT853mJncRX8Q1EKlwHM2sr5UkBoo?=
 =?us-ascii?Q?clsiVRn8qzFSmdG0fBl4eFq+w7iWDLNI8cN1AxZzO7waJsGxfK3eu5ymFmMo?=
 =?us-ascii?Q?ugJuaWHvaUdNPb26dFRkEH9YPi4NYNRRNk1xHFhWgwYzz96c1RNCFvh91Gc7?=
 =?us-ascii?Q?jukDwHohIH+E3KnD/FcnTyQF9IOt444SZV4vWu2fX64+8bnPk6F1br+E8cDN?=
 =?us-ascii?Q?2ecro+xjd6JoxtOoov6HVQ5mFU6LOQzg40KYjuOX7zFDO/Smsw5zgQESrNi8?=
 =?us-ascii?Q?6JNcZUBTuTHvJ80aFSMyfDcHznCTh0g0GMGBZ/CplOOse6R+tL+hqi4/8UQm?=
 =?us-ascii?Q?FwfOSxR2c4/fEYY+bOhzciFUIqInudHxW3yGBmESXXmCIhS0duAbrbAtk9AD?=
 =?us-ascii?Q?XX0csScoMYCmxSJrDp/pi93WD/j5qWEvj4ehkqMGyUxSdtVgAHe7z7cjuCsf?=
 =?us-ascii?Q?5fCZA0/uFTketu8j8NOIQC/ubHDVt/mCB6JMew9zatVuEn6PCl7xglx4Xnqb?=
 =?us-ascii?Q?XhVuO/TRdXmgSRG7OFmcvBJXROEeAD51wmjrB4mMH09cnrB7MLRwNAZjdd+l?=
 =?us-ascii?Q?nb3MTH4oCWsvlt0YnuuHOxGtjRwHPCXhIhv5W/Sm4+uoJnz/bNALiznP71mo?=
 =?us-ascii?Q?UDSRGekrCHTz+QxWmWXB7vudMnZ1liXVL4sUrC41LlmG1kiufwKmY1tquY7Y?=
 =?us-ascii?Q?KyFADKjK+31jQYoqlMzz2NVxKTh0UVIo7UaAUuf/UUnoDxeSOKJLwy1w+Tyf?=
 =?us-ascii?Q?4rA0+rzApZtmIZF8175xSjI3mruo54jXY5KDey8AY5laI8I9nZ+YHAXePSPY?=
 =?us-ascii?Q?D7oASrCp6Grc0K6EEM3EPx1pO/BzME4Reanr1UgAhhH05tzXnRZuBIfMKjG/?=
 =?us-ascii?Q?W2yt/QGDNjlbKeBezDUGn2TnsylvpIYvrftIhiPM6WPzXuHcR2bWOZ+VNqW7?=
 =?us-ascii?Q?d78n2Ib819TCxHqLjQHZT8xdQ2WTstfYPjJ5bCdyGSgKzKOR/w31T24pwrIs?=
 =?us-ascii?Q?Y3DN0SVn8G3sXj1b9NWCjxRtDOvE1MpeoScqxdnMEnJUKoK2EV+56HzIdrzd?=
 =?us-ascii?Q?SBXrPnw+k4mOal9i109e5lIhu4MX30dpkHlqxDF2GMBEYe3oODgCkhPf6aNS?=
 =?us-ascii?Q?jzQf24a8WRQVXGmHP5SkkVL3tCE/xAwpUNeoQgc0U74x9g5UxgCAL4PkFrrU?=
 =?us-ascii?Q?hUnSYqLIYbmNciWAtr/1Lgp56jdE+kEndemvK4nmYuMmhl28cXJszhvXvFOh?=
 =?us-ascii?Q?vFcloK36quwsMbmLNtDuzpD59nI+GrQCVG9eTjVM9PdzVCiroBeKqQmZsdXw?=
 =?us-ascii?Q?uUirV0fmdyS5d+C2DcYTkGK3JB+zbzM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB7086.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9aeb63f-5247-4337-4f96-08da230c5bb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 20:28:41.0950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rsmt+w0IQ0OatMlg1/9RCbgN/P5k1LTKsQSgRdddCTTwgd+VU3orwbqd3HKjKSthd2bzxZwOx76im/EusANu3hFJ/SqRib7zaMvkve4/H2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6640
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 20 April 2022 21:11 Geert Uytterhoeven wrote:
> Hi Phil,
>=20
> On Wed, Mar 30, 2022 at 5:40 PM Phil Edworthy <phil.edworthy@renesas.com>
> wrote:
> > RZ/V2M has a dual-core Cortex-A53 (1.0 GHz) CPU and built-in AI
> > accelerator "DRP-AI" for vision, which is Renesas' original technology.
> > It also has a 32-bit LPDDR4 interface and video codec (H.264).
> >
> > The RZ/V2M is used with ISP firmware that runs on one of the Cortex-A53
> > cores. The firmware is an integral part of the SoC such that the HW
> > User's Manual documents which of the peripheral modules are used by the
> > firmware.
> >
> > Initial patches enables minimal peripherals on Renesas RZ/V2M EVK board
> > and booted via nfs. Ethernet is broadly compatible with the
> > etheravb-rcar-gen3 driver, but interrupts need some work so it's not
> > been included in this patch set.
> >
> > Below blocks are enabled on Renesas RZ/V2M EVK board:
> > - memory
> > - External input clock
> > - CPG
> > - UART
>=20
> Thanks for your series!
>=20
> > v2:
> >  * Removed SYS dt-bindings patch and corresponding SoC identification
> >    as we only used the LSI version register. This can be dealt with
> >    later on.
>=20
> That patch[1] also introduced the ARCH_R9A09G011 config symbol,
> without which none of the new code in this series is built.
>=20
> [1] [PATCH 07/14] soc: renesas: Identify RZ/V2M SoC
>=20
> https://lore.kernel.org/all/20220321154232.56315-8-phil.edworthy@renesas.=
com/

Ah, right. I should have said that I replaced that patch with
"[PATCH v2 06/13] soc: renesas: Add RZ/V2M (R9A09G011) config option".
However, looking back I managed to send that patch only to myself.
Doh!

Thanks
Phil


> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-
> m68k.org
>=20
> In personal conversations with technical people, I call myself a hacker.
> But
> when I'm talking to journalists I just say "programmer" or something like
> that.
>                                 -- Linus Torvalds
