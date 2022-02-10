Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6EE4B094C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 10:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238343AbiBJJQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 04:16:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbiBJJQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 04:16:48 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130071.outbound.protection.outlook.com [40.107.13.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8358AD94;
        Thu, 10 Feb 2022 01:16:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8UPbP9LR1M+yoeYQb2q6HUwt2/w+zWSfd4VAI+LMrzSYtEQiqLrd3noeNolB1AjM2R51l1Ws5vbvZNUt1aA/U4KkOgeKKDmbGpmQgpfQGzgAzwivLFEFB75M3+sVnsUYo1hm48PIo4Pqs23sW7PzKAz6icpKwhv6fj/iS4uaujofV0S0K4lSIGv/YIlm7cXmWn+73Y9i5CdEWxgeBXKGDPMTaqR0i2dLVmp1OBQ4Hk6l5AR6TkLD/+ofhTqKpK+1w5+IV2el/skQWZ9HjgQaTpkJhitQJFEwP/kowmX5X2R4HR1hwCYEq+WI2LTnTxFtcfMZXbLtJcHnKk7KzkDSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qq9nDl2xn/6W2NMC0feIEtiZB9PruNcejzC/q0Ycp7Y=;
 b=Gx4wlYk3SAgK5kWD7ryfSsPPr/5LIsebxyjXu1Bs5XI3rhyCFS4NvdlNWedAsuL+PA8uycvKO7LK3tX6eExz8IO/Gecl1lliGd6A0U2SoY6tYkcTxocaQcJASbBGaSodc4WYDPsXm/RiR0UEH/R1r8ubAcCPReKr0cNAizOUgHdYxLZjMWLxzZnZZ8YHHPoEpWlzbkNRMzKe66n82P05er8JtvGTq9rX5ilj3o9sAabxZBIkjvUli8lQdahKtEm7cFyCZBl2J1mo+S2P4mDEA0vuEKoBc+sZymdp8ap9yK9jT8Wq3J7JV0zGRZANdEJXNUIpoHpwhvnxlKX1b80dhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qq9nDl2xn/6W2NMC0feIEtiZB9PruNcejzC/q0Ycp7Y=;
 b=EP019Rmd76aNRTidnydUeLMkSjkjaIy3O5fBbHLTQphpxVyokr3Fk8GNWX8TAOpQLqwUVjXhOCpmv0KeJKEV6JI6e8ljuIQE39B10fSwZLrdXo+04MOM8oJUypuxohb1MFV7nzSBY4Qr9msRYLF6UZFUyB3CRCkmT/umpK/LlLI=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM0PR04MB6770.eurprd04.prod.outlook.com (2603:10a6:208:187::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.13; Thu, 10 Feb
 2022 09:16:44 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3d7e:6627:fdd0:9d13]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3d7e:6627:fdd0:9d13%5]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 09:16:44 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v15 00/13] amphion video decoder/encoder driver
Thread-Topic: [EXT] Re: [PATCH v15 00/13] amphion video decoder/encoder driver
Thread-Index: AQHYEZcP5odYPhjDek6I9NUCitJBAaxzpSmAgAAE9oCAGO5j4A==
Date:   Thu, 10 Feb 2022 09:16:44 +0000
Message-ID: <AM6PR04MB634165281D459916A12A01C0E72F9@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <cover.1643077283.git.ming.qian@nxp.com>
 <2c3fcd05-35da-02e4-cd69-4a6e369d7005@xs4all.nl>
 <1f886665-45c4-a94d-a417-d75504fcda44@xs4all.nl>
In-Reply-To: <1f886665-45c4-a94d-a417-d75504fcda44@xs4all.nl>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9a917aa-4b03-4068-69aa-08d9ec760eaf
x-ms-traffictypediagnostic: AM0PR04MB6770:EE_
x-microsoft-antispam-prvs: <AM0PR04MB67705689007E76B37DD18174E72F9@AM0PR04MB6770.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mjJAsTVD1fKbmwZD+44zPlYfsOGOJqjgs4ck/E04O9y0bKMruANhhC1xRGymBqvn6HCPSstd2MWppItx3VEfFuYhgqSFPs4toMJpmSimOPPp+jHbkEkCiiyIbewPRF6wl0TRPrWhz7EyHHv0JSyfyCS1Q15Yo53/vpOn0VUoeZdlfa9tmbFlax8k9oBz6piXtcwajaqgAVgb32pF8UU00MhvWSg8sKTG1C4Z+8YfZcP768IvpsRhRCorCJr3OUSP/+eZUsuS1nDHcm921hGS/zGhUR3hA4q+ZwTDlpLDrHs8HBoAPobd7Xf2Rsvngk0MPLuCXcuFwem8fsx3eqVytTURFkm/CI2qLHw+LLRBij2AFqBO+ULVI2ASNm9ZJKNhWrzQtXNxsJ5dl28FEAFt5o9Zq1SU9mhse95KBPGLeQc9qAAOijOuM8sT03+4e3q7mqC2WJhyXwbeKAWVcMUZ6HojwLqwf25ZhM4TgcW+tS1ELKq9/Y+z/6HgO9gzyEYNRw9D6m172BXuG0uyyWRX4zxFI9ad5OCEcn4O3lfGn1ZjWDtJU4RMvzgwwuR7ZRjTI2QaqiPG/+Fvam/RtJvV9KaE8qifWCsbT/+Z4r46je7iq22oNxwD9SaBHTT2GZ3VGA63sYK4YwU14WR1gLyEMwjJ1xsafcRRyXI6jtqAxFdkCHA8QCmJ+4FMUweRWFB3GqPHUhnuBO8h+jL+cfp1DJVBBox0qrNNPJKwhGMPJvto5c3CMq7izkpGKMAI3fSVLnuyQNBFb5+aBc86Mu/O10ijwQZKuEj4NxRZmg3zeIkW44qhl/yQyIEY22PltgWY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(38100700002)(122000001)(8936002)(33656002)(52536014)(966005)(186003)(26005)(316002)(54906003)(110136005)(4326008)(8676002)(64756008)(66446008)(66476007)(76116006)(86362001)(45080400002)(66556008)(508600001)(66946007)(71200400001)(44832011)(38070700005)(53546011)(30864003)(7416002)(7696005)(6506007)(5660300002)(2906002)(9686003)(83380400001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W8OtKFtW3SFvMK/R5Gt3dRTHKs7SQAq/HOnzx+Ww9Uw8IBlNW/v5TasQ+yp+?=
 =?us-ascii?Q?1VYWReMLCnKcU4NeTWMuIbiff6UssthuyL8Q0czbzsKmhvyYjLSGr7/N0w/o?=
 =?us-ascii?Q?5GrITcKWawAtvq3s/tx4z1zJUh5vKaKz55GqWlQIkvSPHJXxLCpQlSEMeu7F?=
 =?us-ascii?Q?pjOLMK9qh0VoKzM2hGjGx/CHm4TtJ8LSqE/l0/BfVhPzcu8HQiMOal71nvSO?=
 =?us-ascii?Q?xkl1Ps8b+/7J5edqMlOcNvD3DX1qhsp62HagL/GttAxZfHDuotA2tH+C06sz?=
 =?us-ascii?Q?QrwSvs9FhAvOmmkXT1gADQz+BSyhycXqlbBznK0zA6SPDMAsLVUrjUMo/aps?=
 =?us-ascii?Q?8YlEeXSS1bvFyMEebMBBcWplFL309HOWFZPl+JtgMgBiSB4NmcHGcSxK4poQ?=
 =?us-ascii?Q?nrbb44bV0b4anU1AJVPm4aT6nsQE9iXG2Fknqm1l5iAawHvehxHCXi99Fgkr?=
 =?us-ascii?Q?/1NIayC1VJ3KfDT4sEiYo0/QtON2MzfNorgg+ZNYjdRxN/jbM24OO1sAgGK6?=
 =?us-ascii?Q?bVCKBS7yZVN4FN3mPbpVVWHBObKI77oB2R1vR0zDe3cCgJ/V8pWeEJ+qMhFG?=
 =?us-ascii?Q?NRRifyctjKoFor51BmHYod6qD+Y5MGGofVEQPwqc2SSL5U3AEv3XSeqFyRjJ?=
 =?us-ascii?Q?EJWdekIHBl+ps0bKgq3/Yo5kdnWeE7YRL1ESB8fkoG12IWx19cgw3bH+FqQJ?=
 =?us-ascii?Q?WyQBWYo0XZ1QY9Mwk0xU6vDyvpsXksJyVHFRNWz0r+b6xxEjsGWZ7R8oYyvI?=
 =?us-ascii?Q?HoGhPQodff4f93Cus2rez+53nGnnBbSo7EceCj6pmZqsxSEFkIBVBTiH+N8f?=
 =?us-ascii?Q?gSwc/0s0/k/8b3cz4HRWSkFiD+8+kG3rBy9SB65CMCniUwRUGvwPaeWEVfcg?=
 =?us-ascii?Q?uj+HZZFbK1kvT3gFoG1n0JJ7IZcyJpghEt/AyfVFGeE1mP0Fjte9lmnNWwQ9?=
 =?us-ascii?Q?ugvMJegOYuMv5N2I/8egofP5SSlRIlVGtxvKJp47JGkL3pK74dEQ3ILqZIEu?=
 =?us-ascii?Q?awLLdiS81vyB06f4KMcjMi9Y+utT7y+nG0moWA4G/1I+lEXbN5XOo1WAVtZ8?=
 =?us-ascii?Q?Jxz4yrEcuV012g3c0NW+YIL2Wmaru0rq2a4vM11FbSZoZKGl2K+kz3RNmHub?=
 =?us-ascii?Q?KbZZu7PFCZZN0eMnn7ye+6O1o8CTlASMuwA1J3SWMoXBK82jVTxSHZkiG5sI?=
 =?us-ascii?Q?jbxw1rHSv0+TYSmyXmbkvTImQHynMPLulsQvbNAYAHl2f3o8A3FQY0peonlg?=
 =?us-ascii?Q?Lw9lZ2PfzCJpzDm/5UflziOzhtG8RqePTmX+zt1uEMNj5pG93sviRtAsK6D8?=
 =?us-ascii?Q?R+kUHrzF8TGrI6A30DjwoBRfZwFXIlcjoNadXDX0iy2fEhjzK7izAguUbHRj?=
 =?us-ascii?Q?9zkM+/QLrrsFfkxnv8Y5PI+KNIBAemYwkT7EatvExK0TG4NTJirgEMtypzTc?=
 =?us-ascii?Q?3jyAdHV+25mfUglR2HPw2rv9XqC+tZaB9xOoDy79v5eISFbG7dtfMVf0nXih?=
 =?us-ascii?Q?3F2S5PIaiBimySDrpk4lWmMnhSBTthMVDfrSQs9OGQDw3ihQpfw+LzrfrUQz?=
 =?us-ascii?Q?OjoMxjvHFWlfEBbYjDJFIyE7aLyk/TS5wDmsBLtBRS6BA4znfwmT1Y8LCddU?=
 =?us-ascii?Q?iw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a917aa-4b03-4068-69aa-08d9ec760eaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 09:16:44.5371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qrlYOgZaXg5q9H7yekUKPJa6hocu9R00+JiZa0SvwvPeml2fWQjnRdFZY9P29+jpnxddbxiZXsHfxK1ZNiR2JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6770
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Hans Verkuil [mailto:hverkuil-cisco@xs4all.nl]
> Sent: Tuesday, January 25, 2022 8:26 PM
> To: Ming Qian <ming.qian@nxp.com>; mchehab@kernel.org;
> shawnguo@kernel.org; robh+dt@kernel.org; s.hauer@pengutronix.de
> Cc: kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx
> <linux-imx@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>;
> linux-media@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: [EXT] Re: [PATCH v15 00/13] amphion video decoder/encoder driver
>=20
> Caution: EXT Email
>=20
> On 25/01/2022 13:07, Hans Verkuil wrote:
> > Hi Ming,
> >
> > Can you take a look at the kernel test robot warnings? I suspect
> > you're missing a header (linux/vmalloc.h?) for vzalloc et al that the
> > alpha architecture doesn't automatically include.
> >
> > If it is just adding a single include in a single patch, then just
> > post a 15.1 for that patch. If it is more complicated, then posting a v=
16 is
> easier.
>=20
> Follow up: checkpatch.pl --strict is now OK, and so are sparse and smatch=
. So
> it's just this and an Ack for the firmware patch that needs to be resolve=
d.
>=20
> Regards,
>=20
>         Hans
>=20

Hi Hans,
    The firmware has been merged to the main branch of linux-firmware.
The commit is as below link:
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git=
/commit/?id=3D6342082c115e76ab5efe3f93c4c1ac6d01a3c7d0

    And I have post a 15.1 of this patch set.

> >
> > Regards,
> >
> >       Hans
> >
> > On 25/01/2022 08:11, Ming Qian wrote:
> >> Hi all,
> >>
> >> This patch series adds support for
> >> the amphion video encoder and decoder via the VPU block present in
> >> imx8q platforms.
> >> Currently, support for IMX8QXP and IMX8QM is included.
> >>
> >> It features decoding for the following formats:
> >> - H.264
> >> - HEVC
> >> - MPEG4
> >> - MPEG2
> >> - VC1
> >> - VP8
> >>
> >> It features encoding for the following formats:
> >> - H.264
> >>
> >> The driver creates a separate device node for the encoder and decoder.
> >>
> >> This driver is dependent on vpu firmwares.
> >> The firmwares have been submitted to linux-firmware.
> >> The firmware patch is since commit
> >> b563148fd28623f6b6ce68bb06c3dd3bd138b058:
> >> linux-firmware: Update firmware file for Intel Bluetooth 9462 (Fri
> >> Oct 8 16:30:14 2021 +0530)
> >>
> >> and it's available in the git repository at:
> >>
> >> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi=
t
> >>
> hub.com%2Fmingqian-0%2Flinux-firmware.git&amp;data=3D04%7C01%7Cming.
> qia
> >>
> n%40nxp.com%7Cdea7e88956c940f884b008d9dffdca47%7C686ea1d3bc2b4c
> 6fa92c
> >>
> d99c5c301635%7C0%7C0%7C637787103382561738%7CUnknown%7CTWFp
> bGZsb3d8eyJ
> >>
> WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> C300
> >>
> 0&amp;sdata=3DiNkfYyUSW6kdlEwOfo%2BveQK7rU0zc%2BDM0CuDFvvXBcU%3
> D&amp;re
> >> served=3D0
> >>
> >> for you to fetch changes up to
> bb3eee4f99589d4910dee4c053a3a685546b5dbb:
> >> amphion: add VPU firmwares for NXP i.MX8Q SoCs (Tue Oct 12 15:09:57
> >> 2021 +0800)
> >>
> >> encoder is tested with gstreamer
> >> decoder is tested with gstreamer, but the following patches are requir=
ed:
> >> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi=
t
> >>
> lab.freedesktop.org%2Fgstreamer%2Fgstreamer%2F-%2Fmerge_requests%2F1
> 3
> >>
> 79&amp;data=3D04%7C01%7Cming.qian%40nxp.com%7Cdea7e88956c940f884
> b008d9d
> >>
> ffdca47%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637787103
> 3825617
> >>
> 38%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIi
> LCJBTi
> >>
> I6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3D5oXZi7JTCq09Tk%2FXhzX
> 87NDAe
> >> U6InqOKvI6gcSRqXBY%3D&amp;reserved=3D0
> >> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi=
t
> >>
> lab.freedesktop.org%2Fgstreamer%2Fgstreamer%2F-%2Fmerge_requests%2F1
> 3
> >>
> 81&amp;data=3D04%7C01%7Cming.qian%40nxp.com%7Cdea7e88956c940f884
> b008d9d
> >>
> ffdca47%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637787103
> 3825617
> >>
> 38%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIi
> LCJBTi
> >>
> I6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DUVpNFuz0fF00D4k4rp2Q
> yE8J4mp
> >> JbhuBYTLoH%2BF8mBw%3D&amp;reserved=3D0
> >>
> >>
> >> Tested-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> >>
> >>
> >> Changelog:
> >>
> >> v15
> >> - fix issues detected by "checkpatch.pl --strict"
> >> - encoder add ctrl V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE
> >>
> >> v14
> >> - fix some errors according to Hans's comments
> >>
> >> v13
> >> - make a workaround that avoid firmware entering wfi wrongly
> >>
> >> v12
> >> - support reset decoder when starting a new stream
> >> - don't append an empty last buffer, set last_buffer_dequeued
> >> - improve the resolution change flow
> >> - return all buffers if start_streaming fail
> >> - fill encoder capture buffer's filed to none
> >> - fix a bug in calculating bytesperline
> >>
> >> v11
> >> - fix dt_binding_check error after upgrade dtschema
> >> - remove "default y"
> >> - add media device
> >>
> >> v10
> >> - refine vpu log, remove custom logging infrastructure
> >> - support non contiguous planes format nv12m instead of nv12
> >> - rename V4L2_PIX_FMT_NV12_8L128 to V4L2_PIX_FMT_NV12MT_8L128
> >> - rename V4L2_PIX_FMT_NV12_10BE_8L128 to
> >> V4L2_PIX_FMT_NV12MT_10BE_8L128
> >> - merge two module into one
> >> - fix kernel panic in rmmod
> >>
> >> v9
> >> - drop V4L2_BUF_FLAG_CODECCONFIG
> >> - drop V4L2_EVENT_CODEC_ERROR
> >> - drop V4L2_EVENT_SKIP - use the v4l2_buffer.sequence counter
> >> - fix some build warnings with W=3D1 reported by kernel test robot
> >>
> >> v8
> >> - move driver from driver/media/platform/imx/vpu-8q to
> >>   driver/media/platform/amphion
> >> - rename driver name to amphion
> >> - remove imx_vpu.h
> >> - move the definition of V4L2_EVENT_CODEC_ERROR to videodev2.h
> >> - move the definition of V4L2_EVENT_SKIP to videodev2.h
> >>
> >> v7
> >> - fix build warnings with W=3D1 reported by kernel test robot
> >>
> >> v6:
> >> - rename V4L2_PIX_FMT_NT8 to V4L2_PIX_FMT_NV12_8L128
> >> - rename V4L2_PIX_FMT_NT10 to V4L2_PIX_FMT_NV12_10BE_8L128
> >>
> >> v5:
> >> - move some definition from imx_vph.h to videodev2.h
> >> - remove some unnecessary content
> >> - add some documentation descriptions
> >> - pass the lateset v4l2-compliance test
> >>
> >> v4:
> >> - redefine the memory-region in devicetree bindings documentation
> >> - use v4l2's mechanism to implement synchronize queuing ioctl
> >> - remove the unnecessary mutex ioctl_sync
> >> - don't notify source change event if the parameters are same as
> >> previously established
> >> - add flag V4L2_FMT_FLAG_DYN_RESOLUTION to decoder's capture format
> >>
> >> v3:
> >> - don't make vpu device node a simple-bus
> >> - trigger probing vpu core in the driver
> >> - remove unnecessary vpu core index property
> >>
> >> v2:
> >> - fix dt bindings build error
> >> - split driver patch into several parts to avoid exceeding bytes
> >> limit
> >>
> >> Compliance
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> # v4l2-compliance -d /dev/video0
> >> v4l2-compliance 1.21.0-4859, 64 bits, 64-bit time_t v4l2-compliance
> >> SHA: 493af03f3c57 2021-10-08 17:23:11
> >>
> >> Compliance test for amphion-vpu device /dev/video0:
> >>
> >> Driver Info:
> >>      Driver name      : amphion-vpu
> >>      Card type        : amphion vpu decoder
> >>      Bus info         : platform: amphion-vpu
> >>      Driver version   : 5.15.0
> >>      Capabilities     : 0x84204000
> >>              Video Memory-to-Memory Multiplanar
> >>              Streaming
> >>              Extended Pix Format
> >>              Device Capabilities
> >>      Device Caps      : 0x04204000
> >>              Video Memory-to-Memory Multiplanar
> >>              Streaming
> >>              Extended Pix Format
> >>      Detected Stateful Decoder
> >> Media Driver Info:
> >>      Driver name      : amphion-vpu
> >>      Model            : amphion-vpu
> >>      Serial           :
> >>      Bus info         : platform: amphion-vpu
> >>      Media version    : 5.15.0
> >>      Hardware revision: 0x00000000 (0)
> >>      Driver version   : 5.15.0
> >> Interface Info:
> >>      ID               : 0x0300000c
> >>      Type             : V4L Video
> >> Entity Info:
> >>      ID               : 0x00000001 (1)
> >>      Name             : amphion-vpu-decoder-source
> >>      Function         : V4L2 I/O
> >>      Pad 0x01000002   : 0: Source
> >>        Link 0x02000008: to remote pad 0x1000004 of entity
> >> 'amphion-vpu-decoder-proc' (Video Decoder): Data, Enabled, Immutable
> >>
> >> Required ioctls:
> >>      test MC information (see 'Media Driver Info' above): OK
> >>      test VIDIOC_QUERYCAP: OK
> >>      test invalid ioctls: OK
> >>
> >> Allow for multiple opens:
> >>      test second /dev/video0 open: OK
> >>      test VIDIOC_QUERYCAP: OK
> >>      test VIDIOC_G/S_PRIORITY: OK
> >>      test for unlimited opens: OK
> >>
> >> Debug ioctls:
> >>      test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
> >>      test VIDIOC_LOG_STATUS: OK (Not Supported)
> >>
> >> Input ioctls:
> >>      test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
> >>      test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> >>      test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
> >>      test VIDIOC_ENUMAUDIO: OK (Not Supported)
> >>      test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
> >>      test VIDIOC_G/S_AUDIO: OK (Not Supported)
> >>      Inputs: 0 Audio Inputs: 0 Tuners: 0
> >>
> >> Output ioctls:
> >>      test VIDIOC_G/S_MODULATOR: OK (Not Supported)
> >>      test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> >>      test VIDIOC_ENUMAUDOUT: OK (Not Supported)
> >>      test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
> >>      test VIDIOC_G/S_AUDOUT: OK (Not Supported)
> >>      Outputs: 0 Audio Outputs: 0 Modulators: 0
> >>
> >> Input/Output configuration ioctls:
> >>      test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
> >>      test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
> >>      test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
> >>      test VIDIOC_G/S_EDID: OK (Not Supported)
> >>
> >> Control ioctls:
> >>      test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
> >>      test VIDIOC_QUERYCTRL: OK
> >>      test VIDIOC_G/S_CTRL: OK
> >>      test VIDIOC_G/S/TRY_EXT_CTRLS: OK
> >>      test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
> >>      test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
> >>      Standard Controls: 3 Private Controls: 0
> >>
> >> Format ioctls:
> >>      test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
> >>      test VIDIOC_G/S_PARM: OK (Not Supported)
> >>      test VIDIOC_G_FBUF: OK (Not Supported)
> >>      test VIDIOC_G_FMT: OK
> >>      test VIDIOC_TRY_FMT: OK
> >>      test VIDIOC_S_FMT: OK
> >>      test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
> >>      test Cropping: OK (Not Supported)
> >>      test Composing: OK
> >>      test Scaling: OK (Not Supported)
> >>
> >> Codec ioctls:
> >>      test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
> >>      test VIDIOC_G_ENC_INDEX: OK (Not Supported)
> >>      test VIDIOC_(TRY_)DECODER_CMD: OK
> >>
> >> Buffer ioctls:
> >>      test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
> >>      test VIDIOC_EXPBUF: OK
> >>      test Requests: OK (Not Supported)
> >>
> >> Total for amphion-vpu device /dev/video0: 46, Succeeded: 46, Failed:
> >> 0, Warnings: 0
> >>
> >> # v4l2-compliance -d /dev/video1
> >> v4l2-compliance 1.21.0-4859, 64 bits, 64-bit time_t v4l2-compliance
> >> SHA: 493af03f3c57 2021-10-08 17:23:11
> >>
> >> Compliance test for amphion-vpu device /dev/video1:
> >>
> >> Driver Info:
> >>      Driver name      : amphion-vpu
> >>      Card type        : amphion vpu encoder
> >>      Bus info         : platform: amphion-vpu
> >>      Driver version   : 5.15.0
> >>      Capabilities     : 0x84204000
> >>              Video Memory-to-Memory Multiplanar
> >>              Streaming
> >>              Extended Pix Format
> >>              Device Capabilities
> >>      Device Caps      : 0x04204000
> >>              Video Memory-to-Memory Multiplanar
> >>              Streaming
> >>              Extended Pix Format
> >>      Detected Stateful Encoder
> >> Media Driver Info:
> >>      Driver name      : amphion-vpu
> >>      Model            : amphion-vpu
> >>      Serial           :
> >>      Bus info         : platform: amphion-vpu
> >>      Media version    : 5.15.0
> >>      Hardware revision: 0x00000000 (0)
> >>      Driver version   : 5.15.0
> >> Interface Info:
> >>      ID               : 0x0300001a
> >>      Type             : V4L Video
> >> Entity Info:
> >>      ID               : 0x0000000f (15)
> >>      Name             : amphion-vpu-encoder-source
> >>      Function         : V4L2 I/O
> >>      Pad 0x01000010   : 0: Source
> >>        Link 0x02000016: to remote pad 0x1000012 of entity
> >> 'amphion-vpu-encoder-proc' (Video Encoder): Data, Enabled, Immutable
> >>
> >> Required ioctls:
> >>      test MC information (see 'Media Driver Info' above): OK
> >>      test VIDIOC_QUERYCAP: OK
> >>      test invalid ioctls: OK
> >>
> >> Allow for multiple opens:
> >>      test second /dev/video1 open: OK
> >>      test VIDIOC_QUERYCAP: OK
> >>      test VIDIOC_G/S_PRIORITY: OK
> >>      test for unlimited opens: OK
> >>
> >> Debug ioctls:
> >>      test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
> >>      test VIDIOC_LOG_STATUS: OK (Not Supported)
> >>
> >> Input ioctls:
> >>      test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
> >>      test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> >>      test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
> >>      test VIDIOC_ENUMAUDIO: OK (Not Supported)
> >>      test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
> >>      test VIDIOC_G/S_AUDIO: OK (Not Supported)
> >>      Inputs: 0 Audio Inputs: 0 Tuners: 0
> >>
> >> Output ioctls:
> >>      test VIDIOC_G/S_MODULATOR: OK (Not Supported)
> >>      test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> >>      test VIDIOC_ENUMAUDOUT: OK (Not Supported)
> >>      test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
> >>      test VIDIOC_G/S_AUDOUT: OK (Not Supported)
> >>      Outputs: 0 Audio Outputs: 0 Modulators: 0
> >>
> >> Input/Output configuration ioctls:
> >>      test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
> >>      test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
> >>      test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
> >>      test VIDIOC_G/S_EDID: OK (Not Supported)
> >>
> >> Control ioctls:
> >>      test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
> >>      test VIDIOC_QUERYCTRL: OK
> >>      test VIDIOC_G/S_CTRL: OK
> >>      test VIDIOC_G/S/TRY_EXT_CTRLS: OK
> >>      test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
> >>      test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
> >>      Standard Controls: 20 Private Controls: 0
> >>
> >> Format ioctls:
> >>      test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
> >>      test VIDIOC_G/S_PARM: OK
> >>      test VIDIOC_G_FBUF: OK (Not Supported)
> >>      test VIDIOC_G_FMT: OK
> >>      test VIDIOC_TRY_FMT: OK
> >>      test VIDIOC_S_FMT: OK
> >>      test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
> >>      test Cropping: OK
> >>      test Composing: OK (Not Supported)
> >>      test Scaling: OK (Not Supported)
> >>
> >> Codec ioctls:
> >>      test VIDIOC_(TRY_)ENCODER_CMD: OK
> >>      test VIDIOC_G_ENC_INDEX: OK (Not Supported)
> >>      test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)
> >>
> >> Buffer ioctls:
> >>      test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
> >>      test VIDIOC_EXPBUF: OK
> >>      test Requests: OK (Not Supported)
> >>
> >> Total for amphion-vpu device /dev/video1: 46, Succeeded: 46, Failed:
> >> 0, Warnings: 0
> >>
> >> # v4l2-compliance -d /dev/media0
> >> v4l2-compliance 1.21.0-4859, 64 bits, 64-bit time_t v4l2-compliance
> >> SHA: 493af03f3c57 2021-10-08 17:23:11
> >>
> >> Compliance test for amphion-vpu device /dev/media0:
> >>
> >> Media Driver Info:
> >>      Driver name      : amphion-vpu
> >>      Model            : amphion-vpu
> >>      Serial           :
> >>      Bus info         : platform: amphion-vpu
> >>      Media version    : 5.15.0
> >>      Hardware revision: 0x00000000 (0)
> >>      Driver version   : 5.15.0
> >>
> >> Required ioctls:
> >>      test MEDIA_IOC_DEVICE_INFO: OK
> >>      test invalid ioctls: OK
> >>
> >> Allow for multiple opens:
> >>      test second /dev/media0 open: OK
> >>      test MEDIA_IOC_DEVICE_INFO: OK
> >>      test for unlimited opens: OK
> >>
> >> Media Controller ioctls:
> >>      test MEDIA_IOC_G_TOPOLOGY: OK
> >>      Entities: 6 Interfaces: 2 Pads: 8 Links: 8
> >>      test MEDIA_IOC_ENUM_ENTITIES/LINKS: OK
> >>      test MEDIA_IOC_SETUP_LINK: OK
> >>
> >> Total for amphion-vpu device /dev/media0: 8, Succeeded: 8, Failed: 0,
> >> Warnings: 0
> >>
> >> Ming Qian (13):
> >>   dt-bindings: media: amphion: add amphion video codec bindings
> >>   media: add nv12m_8l128 and nv12m_10be_8l128 video format.
> >>   media: amphion: add amphion vpu device driver
> >>   media: amphion: add vpu core driver
> >>   media: amphion: implement vpu core communication based on mailbox
> >>   media: amphion: add vpu v4l2 m2m support
> >>   media: amphion: add v4l2 m2m vpu encoder stateful driver
> >>   media: amphion: add v4l2 m2m vpu decoder stateful driver
> >>   media: amphion: implement windsor encoder rpc interface
> >>   media: amphion: implement malone decoder rpc interface
> >>   ARM64: dts: freescale: imx8q: add imx vpu codec entries
> >>   firmware: imx: scu-pd: imx8q: add vpu mu resources
> >>   MAINTAINERS: add AMPHION VPU CODEC V4L2 driver entry
> >>
> >>  .../bindings/media/amphion,vpu.yaml           |  180 ++
> >>  .../media/v4l/pixfmt-yuv-planar.rst           |   28 +-
> >>  MAINTAINERS                                   |    9 +
> >>  .../arm64/boot/dts/freescale/imx8-ss-vpu.dtsi |   72 +
> >>  arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |   17 +
> >>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi    |   24 +
> >>  arch/arm64/configs/defconfig                  |    1 +
> >>  drivers/firmware/imx/scu-pd.c                 |    4 +
> >>  drivers/media/platform/Kconfig                |   19 +
> >>  drivers/media/platform/Makefile               |    2 +
> >>  drivers/media/platform/amphion/Makefile       |   20 +
> >>  drivers/media/platform/amphion/vdec.c         | 1694
> +++++++++++++++++
> >>  drivers/media/platform/amphion/venc.c         | 1364
> +++++++++++++
> >>  drivers/media/platform/amphion/vpu.h          |  356 ++++
> >>  drivers/media/platform/amphion/vpu_cmds.c     |  436 +++++
> >>  drivers/media/platform/amphion/vpu_cmds.h     |   25 +
> >>  drivers/media/platform/amphion/vpu_codec.h    |   68 +
> >>  drivers/media/platform/amphion/vpu_color.c    |  183 ++
> >>  drivers/media/platform/amphion/vpu_core.c     |  870 +++++++++
> >>  drivers/media/platform/amphion/vpu_core.h     |   15 +
> >>  drivers/media/platform/amphion/vpu_dbg.c      |  495 +++++
> >>  drivers/media/platform/amphion/vpu_defs.h     |  187 ++
> >>  drivers/media/platform/amphion/vpu_drv.c      |  260 +++
> >>  drivers/media/platform/amphion/vpu_helpers.c  |  413 ++++
> >>  drivers/media/platform/amphion/vpu_helpers.h  |   74 +
> >>  drivers/media/platform/amphion/vpu_imx8q.c    |  271 +++
> >>  drivers/media/platform/amphion/vpu_imx8q.h    |  115 ++
> >>  drivers/media/platform/amphion/vpu_malone.c   | 1625
> ++++++++++++++++
> >>  drivers/media/platform/amphion/vpu_malone.h   |   44 +
> >>  drivers/media/platform/amphion/vpu_mbox.c     |  118 ++
> >>  drivers/media/platform/amphion/vpu_mbox.h     |   16 +
> >>  drivers/media/platform/amphion/vpu_msgs.c     |  385 ++++
> >>  drivers/media/platform/amphion/vpu_msgs.h     |   14 +
> >>  drivers/media/platform/amphion/vpu_rpc.c      |  257 +++
> >>  drivers/media/platform/amphion/vpu_rpc.h      |  456 +++++
> >>  drivers/media/platform/amphion/vpu_v4l2.c     |  720 +++++++
> >>  drivers/media/platform/amphion/vpu_v4l2.h     |   55 +
> >>  drivers/media/platform/amphion/vpu_windsor.c  | 1169 ++++++++++++
> >>  drivers/media/platform/amphion/vpu_windsor.h  |   37 +
> >>  drivers/media/v4l2-core/v4l2-ioctl.c          |    2 +
> >>  include/uapi/linux/videodev2.h                |    2 +
> >>  41 files changed, 12099 insertions(+), 3 deletions(-)  create mode
> >> 100644 Documentation/devicetree/bindings/media/amphion,vpu.yaml
> >>  create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi
> >>  create mode 100644 drivers/media/platform/amphion/Makefile
> >>  create mode 100644 drivers/media/platform/amphion/vdec.c
> >>  create mode 100644 drivers/media/platform/amphion/venc.c
> >>  create mode 100644 drivers/media/platform/amphion/vpu.h
> >>  create mode 100644 drivers/media/platform/amphion/vpu_cmds.c
> >>  create mode 100644 drivers/media/platform/amphion/vpu_cmds.h
> >>  create mode 100644 drivers/media/platform/amphion/vpu_codec.h
> >>  create mode 100644 drivers/media/platform/amphion/vpu_color.c
> >>  create mode 100644 drivers/media/platform/amphion/vpu_core.c
> >>  create mode 100644 drivers/media/platform/amphion/vpu_core.h
> >>  create mode 100644 drivers/media/platform/amphion/vpu_dbg.c
> >>  create mode 100644 drivers/media/platform/amphion/vpu_defs.h
> >>  create mode 100644 drivers/media/platform/amphion/vpu_drv.c
> >>  create mode 100644 drivers/media/platform/amphion/vpu_helpers.c
> >>  create mode 100644 drivers/media/platform/amphion/vpu_helpers.h
> >>  create mode 100644 drivers/media/platform/amphion/vpu_imx8q.c
> >>  create mode 100644 drivers/media/platform/amphion/vpu_imx8q.h
> >>  create mode 100644 drivers/media/platform/amphion/vpu_malone.c
> >>  create mode 100644 drivers/media/platform/amphion/vpu_malone.h
> >>  create mode 100644 drivers/media/platform/amphion/vpu_mbox.c
> >>  create mode 100644 drivers/media/platform/amphion/vpu_mbox.h
> >>  create mode 100644 drivers/media/platform/amphion/vpu_msgs.c
> >>  create mode 100644 drivers/media/platform/amphion/vpu_msgs.h
> >>  create mode 100644 drivers/media/platform/amphion/vpu_rpc.c
> >>  create mode 100644 drivers/media/platform/amphion/vpu_rpc.h
> >>  create mode 100644 drivers/media/platform/amphion/vpu_v4l2.c
> >>  create mode 100644 drivers/media/platform/amphion/vpu_v4l2.h
> >>  create mode 100644 drivers/media/platform/amphion/vpu_windsor.c
> >>  create mode 100644 drivers/media/platform/amphion/vpu_windsor.h
> >>
> >>
> >> base-commit: e783362eb54cd99b2cac8b3a9aeac942e6f6ac07
> >

