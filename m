Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98738466115
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 11:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240993AbhLBKG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 05:06:58 -0500
Received: from mail-eopbgr70041.outbound.protection.outlook.com ([40.107.7.41]:30357
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241366AbhLBKFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 05:05:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGKILKzGyADe/Y28NoLFsqRoujZBqVNgWT41JmS1kx7tFHS22TyDnkL2vFNcsZX10UH3Rkv+C9ovVnHOEe3zd0S4UL1C2/00eDM6wkVkWpHCzQ1uUi98mB0VhToOPVUsxcvEnsxjDsvzt7v5JtSoR9EXxrr/TjZVlPuuJS+w+OyXofGcn4Teva4NpGFOJwxOrpEhFoqYmL0mbV5BrVak9WZSyjmy3Ry4w24mpDvfh0fGgeiLNqjtNxVLIZ+MPnJEll+i+IKw9xdfRVRJEf9oKj0gS5v9Ljmie/v1x10ziHS1puV2nJqEe3ulopOObjSj0/dp2SnQ5kG34i98ozd3cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SArGvltweCF0hwoB30VyWb6QS5ePzYtUc8bSWLTSe7E=;
 b=VuD3lykthu+Vjx7zpgWcztFwoSNpWpJH5QekgJiYoPuqDjUDBhmAZ8SHeE5l3v4IMwbRQp7EogbnkhKt1QJEwW7Xf9G4mxq/9SMtCEN0AokYm2DG/DQP05rQli4bdCzlCYrRfXZ4SgHHQEgsFZzg2lEiMPKOTn6uOrTxzbBuz7ATzB1OWOL/YpChd8ibzOBvQEau+3jxhJoOwAPs7bJLNWyzBkDNAtH1dxzrZywgTZ/agzBMMroki07LCzIPL4qDS/bEKBfh19C+/e5Oe/zU/0mXbVchlor9O2icn0X53T6AO+fQYYTQcWXWG1TC31272XmLeciA6+yhsyT088/IPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SArGvltweCF0hwoB30VyWb6QS5ePzYtUc8bSWLTSe7E=;
 b=BjQo1vSY793tZXJ4mE75chlpgBehpwK8aGERuk0kacyVPLROEhcCrTvVD889Pdd9gIGLUaIRpwTfwpsyNPnCtXRbBpoDlHOQD0OyDxdC+YgPvm2zzzCHSAAYIOeZwVZj/QvmYW9OnJTOCyrVqcy/8OtKoDvqbkjwATzMugqlnLg=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM6PR04MB4888.eurprd04.prod.outlook.com (2603:10a6:20b:12::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 2 Dec
 2021 10:02:10 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::fc3a:8aea:2c92:3886]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::fc3a:8aea:2c92:3886%5]) with mapi id 15.20.4734.028; Thu, 2 Dec 2021
 10:02:10 +0000
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
Subject: RE: [EXT] Re: [PATCH v13 02/13] media:Add nv12mt_8l128 and
 nv12mt_10be_8l128 video format.
Thread-Topic: [EXT] Re: [PATCH v13 02/13] media:Add nv12mt_8l128 and
 nv12mt_10be_8l128 video format.
Thread-Index: AQHX5c0Gh3fkRGnlWEe8ccPLrNH4T6we9XKAgAAFtYA=
Date:   Thu, 2 Dec 2021 10:02:09 +0000
Message-ID: <AM6PR04MB63415D65DA4EFE923BCE62D9E7699@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <cover.1638263914.git.ming.qian@nxp.com>
 <c7a7bf7a1d3c10a0e28064e37a472cbd45470e82.1638263914.git.ming.qian@nxp.com>
 <3760b86b-b146-3382-595e-cf6483a883c8@xs4all.nl>
In-Reply-To: <3760b86b-b146-3382-595e-cf6483a883c8@xs4all.nl>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d7c6c38-bda4-4e4e-0b78-08d9b57ace44
x-ms-traffictypediagnostic: AM6PR04MB4888:
x-microsoft-antispam-prvs: <AM6PR04MB4888928877D0A560F7EA2E6DE7699@AM6PR04MB4888.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DcffrK8qcM3Fh6ff4DO8/OEflUbt6SDgdZfdBUwjEynEv7iOLulKoqE9QlX+vVEzJp4u0WTymBeRLQtxIKVriE/TfHJn81QA7gQejjXHPsMYFJMZT6Pfvfy6fjKM45GHU+asdTMjrNjVE1wdrgt6n+fOj20PUnPGrsY098QGC0w0V8lxgbMGto7igNAh9R8SKbkzAWvSIWXrIpRIwGjzEj0vKur/kL3ReeCq5y6ngdI0SXjrO5LDqm7Ue6Fi4nBGeVla1pXu6ijOOE1kJIIrCjvA0mxClvr2YZZVBNq8XTXp4F6Vp5LltxgN7blh4DpeJaasEjlMRFoDYo1Fr9gEB8+iLCR64iF0xetMBhbRpVaKVKJmrELt2O9seFiNs8iMrzgt47vjJIUxjHjiV14hR4HsbW1IrOi+xzNEOJFCqXyF89wyITcmEnWBOrbsDuv3P5pXJXIIhxR0QPcTAkt6DFlh+cFvqu3rwJS2wYQvRkmFf86qpF75d/XvFB5Uwv7XAM/1XzBC3cVdioKuHrHnMLLt6l63k6g7WPvwVbhGovzpFH2kcP10Z/f6YlIojAdAsq67yIvcXUSkNF9JBTY0/A9FvgVRtfRy7+rJLskkcwX53/5uBwpUxzEkdyfUKQLtshyNkElDiSISbsrqQoNYb9yilO9MVjVVUm+QfUNZmnh3osexm93hA7IV8zO86NHaqaUabn2uRVGGWEECYebaLR9mH/DO5nNGj55aLpJFSTpdrl9pcA8Bi886otmGnrpkhMxveatvjnWnzBndoXQuGtA4DlWNfsGh+mIHAj/1yTo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(5660300002)(110136005)(6506007)(4326008)(8676002)(86362001)(7416002)(122000001)(38070700005)(8936002)(66446008)(55016003)(9686003)(966005)(45080400002)(7696005)(316002)(38100700002)(508600001)(83380400001)(44832011)(186003)(66946007)(52536014)(76116006)(66476007)(26005)(54906003)(71200400001)(33656002)(64756008)(2906002)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fP/QfyyFxN5XgQZWe+3x4Khcndcmg7qu6izv9PqEEQKwOTmlIQ+ZaoDch3cQ?=
 =?us-ascii?Q?66xjsFYYa8uC2RouZ07a74Hd24ARmtkHCuuqie7Iwx7rJD+1QJVp3IHbv7KY?=
 =?us-ascii?Q?0Sfw87sD6EJlf+coKNGcGcYklY9iSs4zCMGUTCxOPVpkxZWoVlfv8OKGYuCU?=
 =?us-ascii?Q?x/5reEHz6HDyjSiFg5oCHAu4NvSTc27XyChxhSVbO9FDJ3oMs7GZqeKzY83z?=
 =?us-ascii?Q?hv9/LJD4H4CLfpgOB1/cYgbC4zjeZ9Ld3UFkYCZ0+6uy6AAF+PVFxP/DmJ00?=
 =?us-ascii?Q?kzPojRTto4+4O0/QiYnCbXFqiUEvyNjyh7uHMGJSl6/o+jvYUE+yL6An9ZS7?=
 =?us-ascii?Q?OozPvbAbPmv8QSzjSDhqgWG9GjAKET4uAyhd7dY81xZ+giQ2mdcNDkm57R7X?=
 =?us-ascii?Q?LqSL55VGG5fjOTJC9LxrV3I/gqo+RpsN1/Nwk6N3qOrMyFBKoPpoSXKyPxby?=
 =?us-ascii?Q?iduWGZs3fwGMv48u3SUb0kjnBitGEbVUDxCnf+lPy1QtKOsp8T/AQ0LzxVTQ?=
 =?us-ascii?Q?aQa4MOm/b+1KhfAnDh+4BEkuBMbLV8aDeGusLqT99UbJ2FSppN8mg4wpxUhX?=
 =?us-ascii?Q?4pb1vGnDBN9+ieOY+eH54nE+0EpNZTXDidbJ2zlufWpgq/fB4IEJfZvoYdoZ?=
 =?us-ascii?Q?lIhV774Cb+ny9Cclp77d6LDA8khZnPhNV9UJgTQwNZpwFaJVYRdj1Hh4X3HM?=
 =?us-ascii?Q?e64phSo+5Wj5XC0KJlZ1fDHnY9U52QwRvzEeiJTf6GwKN0W8qXXP5Bc4NjqX?=
 =?us-ascii?Q?I5Wag4py0+rZlLIJp7ZfKZFEly8RZ+rlU+OVKs+moJqbz7LKFnJzVFjzQ44q?=
 =?us-ascii?Q?BNi7Bss5b8Td/ObHnB3AINiYkDX1DF6qnj6+YYesgHXxJZIMbejUKBXltA7N?=
 =?us-ascii?Q?GX/XdjrjrAX7oDPdPB4szOVuHinLAjDzCHgH3RIP1mL0mP20VddP9ucLNya1?=
 =?us-ascii?Q?WOCMYMg0G0v7XkEE/YAdqzSJQMPXdj87R5CxWAtM/XIfP4uDBqM1oLvW380l?=
 =?us-ascii?Q?bjHv0jvTSUS3H41HY8XfaCd7xHy8epEUjRXMvZQR0K3gEsamyj7JHNtedvgS?=
 =?us-ascii?Q?zKMAMiEGPL4NORWgFNDQzlr7QrZzOLefOyLTt4R34SrfcwxtSSh0KSArD8LB?=
 =?us-ascii?Q?nUe9LG8IQbmcUDitnKpUX5c7Ni6tzkjiVs4x4ZDNKfmI1F2HSGlDQRlwIb5h?=
 =?us-ascii?Q?1iSzyXHkCgkCQ/CIiA7B8ozBHxXEi93dfPGBP3v+/ho/jinxUBU5ltJDKbjq?=
 =?us-ascii?Q?FocsKY0U4wkWu+sSJFl3RNE92gEfZbBhhHLGmUhSsEJqp0ba9N2JzIZaSvyE?=
 =?us-ascii?Q?c7en7S6QjbId9h3KmzOhWf7h5C4mdfr0se5kK+biKu7aLeQvHKFsm4wh4K6l?=
 =?us-ascii?Q?tNKYJrIH124i59sxWOBFZbOt1jUGrTHghXSRSsvBSRwkHt7G+p6kzTYeSrsp?=
 =?us-ascii?Q?g+6hzJ8NFM50RkEc47v+qKcOS23WBPcsmkGNSlglOvSJwxI9I/Qrm/tgDy7q?=
 =?us-ascii?Q?WkvJEKfErVg2mwc9FXVLvXQ3r1Za/fr4c7zKTw6I62ZUEg35L+6gBYH8OfRM?=
 =?us-ascii?Q?iBH/B6sC0vAzaTRwj1NDEkVrQGul4VVOdwHRgq3PCh3WFQE+MPLoSUbcu90A?=
 =?us-ascii?Q?Gw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7c6c38-bda4-4e4e-0b78-08d9b57ace44
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 10:02:10.0149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WlRRP4QmqCcU0q3mmVcXgXkBWvMVp+KaCy4EqsN+RscCyg4la0HPYGZsvnLNPy+2Iie0sjpaVHmxKJGkX/dM/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4888
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Hans Verkuil [mailto:hverkuil-cisco@xs4all.nl]
> Sent: Thursday, December 2, 2021 5:40 PM
> To: Ming Qian <ming.qian@nxp.com>; mchehab@kernel.org;
> shawnguo@kernel.org; robh+dt@kernel.org; s.hauer@pengutronix.de
> Cc: kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx
> <linux-imx@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>;
> linux-media@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: [EXT] Re: [PATCH v13 02/13] media:Add nv12mt_8l128 and
> nv12mt_10be_8l128 video format.
>=20
> Caution: EXT Email
>=20
> On 30/11/2021 10:48, Ming Qian wrote:
> > nv12mt_8l128 is 8-bit tiled nv12 format used by amphion decoder.
> > nv12mt_10be_8l128 is 10-bit tiled format used by amphion decoder.
> > The tile size is 8x128
> >
> > Signed-off-by: Ming Qian <ming.qian@nxp.com>
> > Signed-off-by: Shijie Qin <shijie.qin@nxp.com>
> > Signed-off-by: Zhou Peng <eagle.zhou@nxp.com>
> > ---
> >  .../userspace-api/media/v4l/pixfmt-yuv-planar.rst | 15 +++++++++++++++
> >  drivers/media/v4l2-core/v4l2-ioctl.c              |  2 ++
> >  include/uapi/linux/videodev2.h                    |  2 ++
> >  3 files changed, 19 insertions(+)
> >
> > diff --git
> > a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> > b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> > index 3a09d93d405b..fc3baa2753ab 100644
> > --- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> > +++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> > @@ -257,6 +257,8 @@ of the luma plane.
> >  .. _V4L2-PIX-FMT-NV12-4L4:
> >  .. _V4L2-PIX-FMT-NV12-16L16:
> >  .. _V4L2-PIX-FMT-NV12-32L32:
> > +.. _V4L2_PIX_FMT_NV12MT_8L128:
> > +.. _V4L2_PIX_FMT_NV12MT_10BE_8L128:
> >
> >  Tiled NV12
> >  ----------
> > @@ -296,6 +298,19 @@ tiles linearly in memory. The line stride and
> > image height must be  aligned to a multiple of 32. The layouts of the
> > luma and chroma planes are  identical.
> >
> > +``V4L2_PIX_FMT_NV12MT_8L128`` is similar to ``V4L2_PIX_FMT_NV12M``
> > +but stores pixel in 2D 8x128 tiles, and stores tiles linearly in memor=
y.
>=20
> pixel -> pixels (note: also wrong in the text
> V4L2_PIX_FMT_NV12_4L4/16L16/32L32)
>=20
> Shouldn't this be called V4L2_PIX_FMT_NV12M_8L128? The 'MT' suffix seems
> to be specific to macroblock tiles and not linear tiles.

I'll change it, I thought the t means tiled

>=20
> > +The image height must be aligned to a multiple of 128.
> > +The layouts of the luma and chroma planes are identical.
> > +
> > +``V4L2_PIX_FMT_NV12MT_10BE_8L128`` is similar to
> > +``V4L2_PIX_FMT_NV12M`` but stores
> > +10 bits pixel in 2D 8x128 tiles, and stores tiles linearly in memory.
> > +the data is arranged at the big end.
>=20
> at the big end -> in big endian order
>=20
> I assume the 10 bit pixels are packed? So 5 bytes contain 4 10-bit pixels=
 layout
> like this (for luma):
>=20
> byte 0: Y0(bits 9-2)
> byte 1: Y0(bits 1-0) Y1(bits 9-4)
> byte 2: Y1(bits 3-0) Y2(bits 9-6)
> byte 3: Y2(bits 5-0) Y3(bits 9-8)
> byte 4: Y3(bits 7-0)
>=20
> > +The image height must be aligned to a multiple of 128.
> > +The layouts of the luma and chroma planes are identical.
> > +Note the tile size is 8bytes multiplied by 128 bytes, it means that
> > +the low bits and high bits of one pixel may be in differnt tiles.
>=20
> differnt -> different
>=20

Got it

> > +
> >  .. _nv12mt:
> >
> >  .. kernel-figure:: nv12mt.svg
> > diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c
> > b/drivers/media/v4l2-core/v4l2-ioctl.c
> > index 69b74d0e8a90..400eec0157a7 100644
> > --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> > +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> > @@ -1388,6 +1388,8 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc
> *fmt)
> >       case V4L2_META_FMT_VIVID:       descr =3D "Vivid Metadata";
> break;
> >       case V4L2_META_FMT_RK_ISP1_PARAMS:      descr =3D "Rockchip
> ISP1 3A Parameters"; break;
> >       case V4L2_META_FMT_RK_ISP1_STAT_3A:     descr =3D "Rockchip
> ISP1 3A Statistics"; break;
> > +     case V4L2_PIX_FMT_NV12MT_8L128: descr =3D "NV12M (8x128
> Linear)"; break;
> > +     case V4L2_PIX_FMT_NV12MT_10BE_8L128:    descr =3D "NV12M
> 10BE(8x128 Linear)"; break;
>=20
> "10-bit NV12M (8x128 Linear, BE)"
>=20
> >
> >       default:
> >               /* Compressed formats */ diff --git
> > a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> > index f118fe7a9f58..9443c3109928 100644
> > --- a/include/uapi/linux/videodev2.h
> > +++ b/include/uapi/linux/videodev2.h
> > @@ -632,6 +632,8 @@ struct v4l2_pix_format {
> >  /* Tiled YUV formats, non contiguous planes */  #define
> > V4L2_PIX_FMT_NV12MT  v4l2_fourcc('T', 'M', '1', '2') /* 12  Y/CbCr
> > 4:2:0 64x32 tiles */  #define V4L2_PIX_FMT_NV12MT_16X16
> > v4l2_fourcc('V', 'M', '1', '2') /* 12  Y/CbCr 4:2:0 16x16 tiles */
> > +#define V4L2_PIX_FMT_NV12MT_8L128      v4l2_fourcc('N', 'A', '1', '2')
> /* Y/CbCr 4:2:0 8x128 tiles */
> > +#define V4L2_PIX_FMT_NV12MT_10BE_8L128 v4l2_fourcc('N', 'T', '1',
> > +'2') /* Y/CbCr 4:2:0 10-bit 8x128 tiles */
>=20
> Use v4l2_fourcc_be to denote that this is a BE format.
>=20
> >
> >  /* Bayer formats - see
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.=
s
> >
> iliconimaging.com%2FRGB%2520Bayer.htm&amp;data=3D04%7C01%7Cming.qia
> n%40n
> >
> xp.com%7Ce303b4acc4c7478171bc08d9b577abe4%7C686ea1d3bc2b4c6fa92
> cd99c5c
> >
> 301635%7C0%7C0%7C637740347869679174%7CUnknown%7CTWFpbGZsb3
> d8eyJWIjoiMC
> >
> 4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&a
> mp;sd
> >
> ata=3DDJGu6nhkZwiJlVD7oqXG0ZUOGBMmrILtiYirX87MyEo%3D&amp;reserved=3D
> 0 */
> > #define V4L2_PIX_FMT_SBGGR8  v4l2_fourcc('B', 'A', '8', '1') /*  8
> > BGBG.. GRGR.. */
> >
>=20
> Regards,
>=20
>         Hans
