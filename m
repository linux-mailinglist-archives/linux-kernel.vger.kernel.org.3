Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D974D3F09
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 02:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236237AbiCJB4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 20:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbiCJB4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 20:56:36 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60063.outbound.protection.outlook.com [40.107.6.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67133127D76;
        Wed,  9 Mar 2022 17:55:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtMPuHoQ2cKas44xjTe/unIpV4HOwV28MYIHdYQ23iCmJTjnleIg7tSKminGUH0pKGPcPyLYfmoDOtYvJQn1GevFj41cKx5NOFBiTEoG/A1yIiee99UgYAhYOaZPZwwl9peT+V+TwbQOMGmGAKwRmMXLqOyNlVLEGBbGJfVpbJUwFSBEJCczTkxy2X5MiLh7P8G2NYXygmL+9p1gI2QlXYYyx2308ZFG+UDtFfmtB2AssircaAXNyez9liW0jUOPRbMGrD8sUfOWEPm9atiZ3NbZ06tEsljnyOIDi4E9YT1/FCCvvujbo5xkyjEnK3KI5VRIyhwaVbcYYDB1M2Pl/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vitq4zTCmNGEnCRl4d9WGugAVbzJOMxmnkVxHhyhUMg=;
 b=CLfNtu/mBJjAOdltC+tC1vjod8lZX2IuVEqA6BhXxkjzcUqs1RMwudRhkh/kidqYxu83GvebdhEpW2H/m8MoRJksl0hjiqmBN+8XKcR4kol6X5Lsx3n4zKLlQsrQbbcntlX6L//5Y4z5hvgL/E/wtUEpO0zhP+Mgajp4CJDkwfR0KsaBF1IK0ew5YEhrY5IauLLlk77jF5SvqJNIxttEI9p4Qn1SS+aC3Y9+YG6K+XZfyPkZVCUkP0ihVyMy8yq9KzA5FejHJ48238AGhqyyssFTjpPOn3wGRnC2yKGemiWfDdhWghVrPH8+2x1ZBruyk20UG8ggpbaIGXMKtFUEtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vitq4zTCmNGEnCRl4d9WGugAVbzJOMxmnkVxHhyhUMg=;
 b=gxQYSh+4d5DwxdCa54qXvkxCh8u9fFuf+9DlBZNWG8KhrC3AMR/SLI4khn+IJoOifrFQx8WSc2h3c6vyCBGcV9gW7osZi03vry8Cfk/iJky3QrSPl4CteKcHHD4eU7CRxxJxh4pjEa73ZWDRSgyVhC3VrrRXPptKWng12zd0irY=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB3PR0402MB3754.eurprd04.prod.outlook.com (2603:10a6:8:6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 01:55:33 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 01:55:33 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v18 06/15] media: amphion: add vpu v4l2 m2m
 support
Thread-Topic: [EXT] Re: [PATCH v18 06/15] media: amphion: add vpu v4l2 m2m
 support
Thread-Index: AQHYKSkysBAlcdqrbUaZjaHXcN2sx6y3AOkAgADwUkA=
Date:   Thu, 10 Mar 2022 01:55:33 +0000
Message-ID: <AM6PR04MB6341451D5139D2EFFDAD44DFE70B9@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <cover.1645670589.git.ming.qian@nxp.com>
 <8af3c8cb6ab6b02461ad67ce21b8058f5c5caf4d.1645670589.git.ming.qian@nxp.com>
 <20220309113420.GA2592@kili>
In-Reply-To: <20220309113420.GA2592@kili>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e528246-b46a-458f-e323-08da02390fff
x-ms-traffictypediagnostic: DB3PR0402MB3754:EE_
x-microsoft-antispam-prvs: <DB3PR0402MB37542560F14EFBC9433F6FDBE70B9@DB3PR0402MB3754.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aMEJZUD7P+uV1CVDOrn5LKBq7stEj9+ejQCvNxkF/I8J/iXE5Kz41ncFkq1hKPqk9jM0fI543dB31zW3XaNcXdZJ7yKbqlMxmKvaGDigirbQYaTdx3rsT/H0u8mmQbUvzclV05HeaW9rJq4syFlbz3awyEptvwZoMTM89Bk7hhnAovPWNrTUKgGqNM6qPCYOm2gj9G8UTYnlBOTtIFSuZwg5DtG0b1w9ictNpdUbeKcTKwJrDIUfIao9pQAW321I5KZyH1hIQFj/KdQB7SHPspGVv9oSDicXwu3NdCQUSRCPNDwRxIckHIUlZH8n6FUnJpHvltT5J2BJam1vtSYkXA5GKkLpSDSokjyJxbSr3kfI3OGD0t3lx6oiNIDc6z0qjGliwZJ5UN/XkKmLlCu9VMMJqGkcQJ8/lIdkaAPODuu8EK3T0O3XYRxIw1XrPDAXyz+WiJ/hsNkU7j4tnFRC+dYrQ/gSug9cPhoGpPMGPHqAibEZenPDYqdrBQX3HTZS0LaK6KHvDX24H8HLdBphkNpUZSrWnbAeXr9mTW9KQLZvKBSU4cbBM88C5WIt/1ksLOWOxhrZCg7F5k9ACQRkyBBW52/zkCSBE4OfbSEMOlJg877Q8TLJE1UP7CU8dAJl8wQB4aM1os+NJhF8ixV4z0X8afjFuUnEnL8QNTjr8iX7AKcdhQlQJIj1ooZi3dCjmsDqXzLNAHFklYeSRXDDfVz2bRudO+806rfNj6cVqm8ReHOFaW+h6XQ9rsiJ++5x
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(26005)(186003)(4326008)(8676002)(76116006)(122000001)(64756008)(66946007)(66446008)(38100700002)(54906003)(53546011)(316002)(6916009)(6506007)(55016003)(33656002)(9686003)(7696005)(7416002)(8936002)(5660300002)(52536014)(44832011)(71200400001)(508600001)(83380400001)(2906002)(38070700005)(66476007)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g441ZZYOMrXSaBh3StvuAATj67spX5KKHVh6YOSM+xIwAXTnxufYNeXwkJlt?=
 =?us-ascii?Q?Ld+ik1kGX11wMtovpL7qcrJdCIUmtWkbz8yOY9+MMt3Qv54huTkfWk9Wi70A?=
 =?us-ascii?Q?AqlyNdDYEwc68ahvNwMkWD8soJgkktP80Lu67+7FPcIPj2IP65cbX5uEVIY/?=
 =?us-ascii?Q?BA0SlndThb8epi8+lWe0DWr4x4Hqa+z3dDyKlq6czuJvM7Qgvebjk/RwG0qa?=
 =?us-ascii?Q?FKJ44h/e1YVbaxRuwzSFenLlA/GKC/y3/duGqjCxw4H4CGNF+v3WQjE/yiU1?=
 =?us-ascii?Q?LNGYf+lzuXPTMGMQdkpByyOCM6/Ro5Jn7s9G2V3gfJdR1Dt9mHNmNC5NUoCc?=
 =?us-ascii?Q?ZJ+8de/dCCi+xbQqRVM705ZW53Kl3dTfc01VnRZtobePLdH8pSVHdTAdhUJZ?=
 =?us-ascii?Q?LF4L1Zk/ss/MNNdfz/pRec8FrgmA67/ttKcxfZudsTbofAJwSc0fxElTyWMr?=
 =?us-ascii?Q?xSfIkkujinFcUnkwUbXn/1neMpgu9aY7u54cOM8ZoiL+97nuzgsvK1JUNY/W?=
 =?us-ascii?Q?+PEo/OISrAkOji1hxuGxzC/4E5oTNGbisyohf6oc7vXJo+Rng+NuBwioanqX?=
 =?us-ascii?Q?5jSKB2L/hfLmiynYTK7Qz8YSLslMnWsdYii+DkMHnX6j/g1H7xa9rOMXrZKC?=
 =?us-ascii?Q?njQ3zm8AJhqrBI5ZW2cKWLL1dlKLzGKuL0z1vFsrHhZyapyE7V3uVV74IkIX?=
 =?us-ascii?Q?C6tM9PcplTTXSpsjp/mW/6y64TXWZwQRFCS3HVlZ+Fd1jREg6wEtmv+JomFj?=
 =?us-ascii?Q?oXWLqu0zrzEmvh/NeBPpwpQ93oczNOvYd0vukEvu3iz/+MC/GjC0JrASf2C0?=
 =?us-ascii?Q?MHrna8rZVPOtLrAPhXsDpIni56yttWpVlgb53v8Mk4uumW5AO/BEO2t91bfs?=
 =?us-ascii?Q?kq52xYqs4bwql6pniT4lnOmsbXM2tJkvJZHEiy92KAtcAH81qsAg5qLG9cMb?=
 =?us-ascii?Q?tv1PRnwxhvoqp9Mp9Vth3AIZDMmkAMNSM5/uHdSqgb/VOS1bFSmOqm9BJEF2?=
 =?us-ascii?Q?f8CWZp1HlBv8s4nEQ7/ek2xnNw/xocneL/WctJb6mCa+sZQ58nz5yrHzDiAn?=
 =?us-ascii?Q?b3yibVtQ22Pnz/Z7NqH9NreIw9SADiJhYARR07sQu7HajRDtkPpAhNYpX7uu?=
 =?us-ascii?Q?lkRU47GInE/WxCVPaoif29flpBczBfbFaOguqeBaxumbZSSvktpgDoelRypG?=
 =?us-ascii?Q?aCTUCJ4XFddnr2kLa0oKFcNk7B2Tbfd+R5pLZ8mvctu9jCWdD9rxmeeHB+8n?=
 =?us-ascii?Q?7H6gsiHBSFIjJITxlCE3UtfisbKvDoUCsj+imYdJN5OoX/j8KIaHFqBCz1q1?=
 =?us-ascii?Q?zZFwQM+AM2jug5PyRgWUf/ja0a1TbvWIFocmqW9UhmWIyeeb3KziavpaGOnu?=
 =?us-ascii?Q?GMkJdzf6Pzq3miXcJlYWXIpSdN6yUJdlX5PdcrPugLBLXF2C9prQvnZ+aWYh?=
 =?us-ascii?Q?5cJxeaJBzhwu4UROUedcOopPZOJIGMnjUqO6C0daBqOxsz2yohEgs7y+dXYF?=
 =?us-ascii?Q?tC8tMxIKgJTjhSFDapRECQWXyEyC02/i64XphK14ACo/OZB+z6AXW1d2twNx?=
 =?us-ascii?Q?DhmX4VdVn94Me2jKOCeaxYPmGUku7oayVEWqZghHcKP0yMxA1o7dNqcvnp+6?=
 =?us-ascii?Q?mg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e528246-b46a-458f-e323-08da02390fff
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 01:55:33.0541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Aek/JmKfSITOjT3AMk5AvDdIpj1Aab1c5pc8xET5MiefdZt9ju5oYjJoutfnxjKncvgobBCofXiQDl0o9lkhvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3754
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
> From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> Sent: Wednesday, March 9, 2022 7:34 PM
> To: Ming Qian <ming.qian@nxp.com>
> Cc: mchehab@kernel.org; shawnguo@kernel.org; robh+dt@kernel.org;
> s.hauer@pengutronix.de; hverkuil-cisco@xs4all.nl; kernel@pengutronix.de;
> festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>; Aisheng Dong
> <aisheng.dong@nxp.com>; linux-media@vger.kernel.org;
> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org
> Subject: [EXT] Re: [PATCH v18 06/15] media: amphion: add vpu v4l2 m2m
> support
>=20
> Caution: EXT Email
>=20
> This code has a serious case of the u32 pox.  There are times where u32 i=
s
> specified in the hardware or network spec.  That's when a u32 is appropri=
ate.
> Also for bit masks.  Otherwise "int" is normally the correct type.  If it=
's a size
> value then unsigned long, long, or unsigned long long is probably correct=
.
>=20
> INT_MAX is just over 2 billion.  If you make a number line then most numb=
ers
> are going to be near the zero.  You have 10 fingers.  You have
> 2 phones.  2 cars.  3 monitors connected to your computer.  200 error
> codes.  You're never going to even get close to the 2 billion limit.
>=20
> For situations where the numbers get very large, then the band on the num=
ber
> line between 2 and 4 billion is very narrow.  I can name people who have =
over
> a billion dollars but I cannot name even one who falls exactly between 2 =
and 4
> billion.
>=20
> In other words u32 is almost useless for describing anything.  If somethi=
ng
> cannot fit in a int then it's not going to fit into a u32 either and you =
should use
> a u64 instead.
>=20
> Some people think that unsigned values are more safe than signed values.
> It is true, in certain limited cases that the invisible side effects of u=
nsigned
> math can protect you.  But mostly the invisible side effects create surpr=
ises
> and bugs.  And again if you have to pick an unsigned type pick an u64
> because it is harder to have an integer overflow on a
> 64 bit type vs a 32 bit type.
>=20
> Avoid u32 types where ever you can, they only cause bugs.

OK, I think you're right, I'll check and fix it according to your comments
Thanks very much for your reivew

>=20
> > +u32 vpu_helper_copy_from_stream_buffer(struct vpu_buffer
> *stream_buffer,
> > +                                    u32 *rptr, u32 size, void *dst) {
> > +     u32 offset;
> > +     u32 start;
> > +     u32 end;
> > +     void *virt;
> > +
> > +     if (!stream_buffer || !rptr || !dst)
> > +             return -EINVAL;
>=20
> This function returns negatives.
>=20
> > +
> > +     if (!size)
> > +             return 0;
> > +
> > +     offset =3D *rptr;
> > +     start =3D stream_buffer->phys;
> > +     end =3D start + stream_buffer->length;
> > +     virt =3D stream_buffer->virt;
> > +
> > +     if (offset < start || offset > end)
> > +             return -EINVAL;
> > +
> > +     if (offset + size <=3D end) {
>=20
> Check for integer overflows?
>=20
>=20
> > +             memcpy(dst, virt + (offset - start), size);
> > +     } else {
> > +             memcpy(dst, virt + (offset - start), end - offset);
> > +             memcpy(dst + end - offset, virt, size + offset - end);
> > +     }
> > +
> > +     *rptr =3D vpu_helper_step_walk(stream_buffer, offset, size);
> > +     return size;
>=20
> This function always returns size on success.  Just return 0 on success.
>=20
> > +}
> > +
> > +u32 vpu_helper_copy_to_stream_buffer(struct vpu_buffer *stream_buffer,
> > +                                  u32 *wptr, u32 size, void *src) {
> > +     u32 offset;
> > +     u32 start;
> > +     u32 end;
> > +     void *virt;
> > +
> > +     if (!stream_buffer || !wptr || !src)
> > +             return -EINVAL;
>=20
> Signedness bug.
>=20
> > +
> > +     if (!size)
> > +             return 0;
> > +
> > +     offset =3D *wptr;
> > +     start =3D stream_buffer->phys;
> > +     end =3D start + stream_buffer->length;
> > +     virt =3D stream_buffer->virt;
> > +     if (offset < start || offset > end)
> > +             return -EINVAL;
>=20
> Signedness.
>=20
> > +
> > +     if (offset + size <=3D end) {
>=20
> Check for integer overflow?
>=20
> > +             memcpy(virt + (offset - start), src, size);
> > +     } else {
> > +             memcpy(virt + (offset - start), src, end - offset);
> > +             memcpy(virt, src + end - offset, size + offset - end);
> > +     }
> > +
> > +     *wptr =3D vpu_helper_step_walk(stream_buffer, offset, size);
> > +
> > +     return size;
>=20
> Just return zero on success.  No need to return a known parameter.
>=20
> > +}
> > +
> > +u32 vpu_helper_memset_stream_buffer(struct vpu_buffer *stream_buffer,
> > +                                 u32 *wptr, u8 val, u32 size) {
> > +     u32 offset;
> > +     u32 start;
> > +     u32 end;
> > +     void *virt;
> > +
> > +     if (!stream_buffer || !wptr)
> > +             return -EINVAL;
>=20
> Signedness.
>=20
> > +
> > +     if (!size)
> > +             return 0;
> > +
> > +     offset =3D *wptr;
> > +     start =3D stream_buffer->phys;
> > +     end =3D start + stream_buffer->length;
> > +     virt =3D stream_buffer->virt;
> > +     if (offset < start || offset > end)
> > +             return -EINVAL;
> > +
> > +     if (offset + size <=3D end) {
>=20
> Check for overflow?
>=20
> > +             memset(virt + (offset - start), val, size);
> > +     } else {
> > +             memset(virt + (offset - start), val, end - offset);
> > +             memset(virt, val, size + offset - end);
> > +     }
> > +
> > +     offset +=3D size;
> > +     if (offset >=3D end)
> > +             offset -=3D stream_buffer->length;
> > +
> > +     *wptr =3D offset;
> > +
> > +     return size;
> > +}
>=20
> regards,
> dan carpenter

