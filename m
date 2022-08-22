Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C9459BF08
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 13:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbiHVL4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 07:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiHVL4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 07:56:16 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F383219005;
        Mon, 22 Aug 2022 04:56:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDtowKFEcxNjXHKnUVVo0/f8ql84rxk61W4eN3l369LKortuw4Mm6ke2AxpvjLqZAogB2cvC52VaCp0+FiCrsFvbW7u8yHu5KaqmkpOzO1SeQti8S2trzO68E5hmRIMhhvMe5aME6sd2v+p2JgQfN2iJGiWi+xa2SM24pXx3ijR5GkmwXzHIlTLrQSsyfCujpRKjnZHfFom9g+jCyVkoNimaPUpaI3X7bssvKP/GPkBqhpRc6+bNfI1ALAiX+oflFzpmxJPFe+XP/aomyyVPdx3xHaAn9uCU9UjyiU7zv8RQIB9SyG0jU2IynT6lDcKq6l/1cNcRdukxtxtHpGLuCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGA86ndM6YXspJWsNIYXHhzDEdRrT5uKHyEuExuBlh4=;
 b=i8iPMYnikfdTLrdy/e4c3h2A82+dEK/JuRe8dDoKTaJMQ57WsiZrIOc46+X0HZFAzy3RX2dOuF+sHpS0nXTx23qSXVBJJVh5sUikiOCvF1FGB+FhayZCxIZUK3vcqn84OCY8SpPR6TlqelARxuuaQaswsC697WA7Mku5VxLSHUCaTd0JRMTFE72Wj8rU6rnMBUXYQiiBphNJzxSekW9k5fK5mN1cbFCe0sM12VLeNoG/aaTcD6019N0lR+TzBCurQMaykgerU0kO7eKY4x11Q9LGOrpa7kYTjcpz+1YvXJwKJox2ki1yBMM3KBevDsI+BgEd6SyFOVzmadTXhArprg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGA86ndM6YXspJWsNIYXHhzDEdRrT5uKHyEuExuBlh4=;
 b=k2FgT4yamF5YbhlqhirHVaTGTe88ONb32c2iNmLSslWV7YlkVeDJmrX9LlkgFjQQ0Y/tFYPUXYZJRzNgU8DUHo+MeYaRWUBW2dHcTnbNSdRjzgk23miH+XGopbz7L+gDDMYKj5+zdLqf1j3Z/wvQkBQhbqIVKB34HJWvNZDgDL0=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB6PR04MB3224.eurprd04.prod.outlook.com (2603:10a6:6:3::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.21; Mon, 22 Aug 2022 11:56:11 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c%4]) with mapi id 15.20.5504.027; Mon, 22 Aug 2022
 11:56:11 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
CC:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "X.H. Bao" <xiahong.bao@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v4 2/4] media: amphion: tell and handle
 contiguous and non contiguous format
Thread-Topic: [EXT] Re: [PATCH v4 2/4] media: amphion: tell and handle
 contiguous and non contiguous format
Thread-Index: AQHYq7vKlvLkxGBCKE6M1xb7c2cV8q262eeAgAAGmQA=
Date:   Mon, 22 Aug 2022 11:56:11 +0000
Message-ID: <AM6PR04MB6341A3B117F6FDB818DAB5E6E7719@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <cover.1660027440.git.ming.qian@nxp.com>
 <4af9766eb664a02d1c5884cb48fadef24dec142f.1660027440.git.ming.qian@nxp.com>
 <20220822111655.GA17530@tom-ThinkPad-T14s-Gen-2i>
In-Reply-To: <20220822111655.GA17530@tom-ThinkPad-T14s-Gen-2i>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9c31d40-9157-4d26-6c20-08da84354eb7
x-ms-traffictypediagnostic: DB6PR04MB3224:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uZ8ucDX5VWCCJ193dBR1KbdoyzyDvhxDk2FRCVmN8lhqUsWnRwpUPaXaBhQPdszq6EqpNtr2Zx5P3ErRJliFdhRjpaGmZm5jTFO46dzsrTKit0yHsro7PSD1x/IDtXbxGXd/9Y4xoUCJ5T7OWrFGcVo6nxPjrDfDJikCWzVvunKRFWuVmOVJ7/lhO7Z8bnmH8PVEzeT16hucCGluPbgUttZSUE+s/X84ClUEWcvQ86CF9IAPWNkNOzLPizLCUr5cOkYXmvRVOLeuGyyH2OgVSuWHAKiFq8V6N1ChyonzizpW1nqxK97TqOXAHfoLHCdMaMC35KAMRiqRPldZ6toKWI5kKsaKUUS882aq0H51PtRhzqpRh991ijuOTvyyyhDRxDg+b1tt2POgaXgIRNJpcdetiXWprF9O650+EFa59GzhomoYQPjYP4kNvRqqxpkR7rdjGlIcC8Br1X2zMlJYRz4hninJAcBn+Us7twoC3VS2x5Hs/4ApZmOJSxg7biVu+j0cBMgLFvgeaqemeVurckw25/f1DYw01ty9O/FMI5dv3/Up7GGd4ubk5YaliMPWud9P2fyGLhKipVpd2Qb0EStwEdDa/EKPfuL3u1jwoSz+pMOc8Y7mKifBfz7IDYUnugSk2NLWJCsZmloePg1MTDZnDg2ffZZyeRjZnj2rAMPu2pGCtVNTjUXl2/5Nwp/oNyL5qOfQV05y1mgvZchY6v00Qc1vXVdZ6/SIr7bMkmF2pBPcshw6ySTs9JM1Eh0NEPnG04kICWyD9ZimOL4krw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(38100700002)(66556008)(8936002)(4326008)(8676002)(76116006)(64756008)(66446008)(66946007)(66476007)(71200400001)(41300700001)(44832011)(55016003)(316002)(6916009)(52536014)(478600001)(7416002)(5660300002)(54906003)(6506007)(7696005)(9686003)(2906002)(26005)(86362001)(186003)(33656002)(38070700005)(83380400001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wl+7P9OhVqJbITIYkHXqSw/v/p3Yh3qyplDArQw7rrh3jfuQXAnKvRLZmffk?=
 =?us-ascii?Q?YVpuBfOqX9PExs/YlenJScAERQ4j2pnh0j9vAQuy7dhVasoMeSqJ7rmYnHHC?=
 =?us-ascii?Q?vF24AVwrgcIHryRWYcHslIaqf/Rt5oLxbwSKZ69tghY6T6wv27WeF8USxXIM?=
 =?us-ascii?Q?602x0yiXvneFqMGfl1qGd8yukGXnqAn4OW51dE7j2jRExwWj/k8OaYbGYQGu?=
 =?us-ascii?Q?+XjVJS0AANN/OljEisglBEuWOedJG+OmGeOvlPne5HokTpaaXNB+b5uBBkxG?=
 =?us-ascii?Q?uuWJhMFPOJTmCGBTbJazrheLPTGO6t0vRfkbH29xnQBn+q6m9Xxy4V/Yh8z5?=
 =?us-ascii?Q?ThT5wvTvlc05uWqBJ6pXzY7c/Bq3cG4HMNF6VQZMLLe96HULGZHe2eJJgeoQ?=
 =?us-ascii?Q?sHE/gTUHG9IEt9Y3x6SOx3Q8iOdPw1cJZwpbvmpmAGiCAX+l/jpAlGsRAIEr?=
 =?us-ascii?Q?v357ds4D9JDoP8wUXI54ZS/TlCza7OpyBt0oMfzAxPynEIsouel+6eRYrsFU?=
 =?us-ascii?Q?NqxlL3PpHNpTnevkYs6whT9qGkiatYNajTzG0jQfR4Nye4oF7W5UeMks7qeH?=
 =?us-ascii?Q?g8w2uCeXMNLVEbj2npw1Q/ViAG6WREac1IP457KzUpzLRaTRD2Ilro+2jgJ+?=
 =?us-ascii?Q?ctlO0jLSXZ9gZe2Yp/KrgvtOve+CgBeRpYoKBbbBUZoqq+bURQT/+/m2x1XC?=
 =?us-ascii?Q?fJ1tqMilgP2ywdaqiVsnpasuIani/as7nU2Wz9fv00N5F7QUAIUEJ1DtWk0M?=
 =?us-ascii?Q?rk+bS/GWgZ+m1hl9rTMdktp+LmiKRSOeA7nI4egA5gVaZXLapjuyB85dR/QD?=
 =?us-ascii?Q?CVF4HQj+RL0EpBCvEHq1tAd7Uhyw/CPzUAPdWTQzJTrFX12VYpIGr7A4oq4C?=
 =?us-ascii?Q?keCHECAPxBz6AfKQi58DnB4VjJN/LaGuycDFNCcRSEiuKfxb0fCYMLkKhlKM?=
 =?us-ascii?Q?khCmReCGXREFYEnoEKTh2V7qnNHBcnSfcm56OP2wHJkKdYdHpib3YL63hsI8?=
 =?us-ascii?Q?TItLn/Nzw77EJwHHXqNg+X9XSYVDnsVBVKhs9er3Bf8hoDV4iVMlevDFah6f?=
 =?us-ascii?Q?ahGETStPc6Hb/kBHsPHVsg08MMCU1JQJk6Y+Ic6mn3gXwSe5WlvhY3ONlHM7?=
 =?us-ascii?Q?xxSeVNoiZIsDK22fKo3aZUW/i8DHBTJBL7Fo4Ld8A3ypeAZzk3e2S7Ux0c0f?=
 =?us-ascii?Q?bJmehzQYqYri1OcqN28a266kSaYZ3WwG+YKiiWKrBNRXEhBY/zPm6a5T/Ndp?=
 =?us-ascii?Q?hwPdmlkbFNLwgPcm1i145qekEadPMwUzpVb/K5Oztw/4pggH2j7uRZ0/AOVP?=
 =?us-ascii?Q?McJ5WmDzjwj1Oz6N9qFB4Z9HOC9W8ejiAvEhZHWGjm3rJYTKxGr32WfeL0WZ?=
 =?us-ascii?Q?xvZOFl5bpvwtYxkv52R1A0A1ncZg7bO+/3SvJc5QQdwF1Q1vwC45ChcNDrII?=
 =?us-ascii?Q?O8Z+Gtu9jUC4DGcnSsc41HWLqhOCOZmecGyBBAa50+gZto7XmujuNO3h7xcd?=
 =?us-ascii?Q?w9W2AjZfYr+dOMDk1Hc//7S+IU2LX6U/x/MfxURo+FTi9d1dppfQrFKxD8ee?=
 =?us-ascii?Q?QULEQSoRazFvo+j7wc0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c31d40-9157-4d26-6c20-08da84354eb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 11:56:11.4810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Omd/1rJDT/o//LI/Ndf2P7iddHzoRwqYuA+jgndO6dH8+4N3utoHzR16z5V62gIXZ+Ob7IUhMkUHfDk7HOt7KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3224
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi Ming,
>Sorry for delay. I'm on vacation last week :)
>
>On Tue, Aug 09, 2022 at 02:50:39PM +0800, Ming Qian wrote:
>> Driver should tell the number of memory planes and component planes.
>> the amphion vpu support non contiguous planes, but for compatibility
>> with other device that only support contiguous planes.
>> driver can add support for contiguous planes in the same time.
>> Then the mem_planes can be different from the comp_planes.
>> driver need to handle buffer according mem_planes and comp_planes.
>>
>> So driver can support NV12 and NV12M.
>>
>> Signed-off-by: Ming Qian <ming.qian@nxp.com>
>> ---
>>  drivers/media/platform/amphion/vdec.c        | 187 ++++++++++---------
>>  drivers/media/platform/amphion/venc.c        |  33 ++--
>>  drivers/media/platform/amphion/vpu.h         |   4 +-
>>  drivers/media/platform/amphion/vpu_dbg.c     |   8 +-
>>  drivers/media/platform/amphion/vpu_helpers.c |  48 ++++-
>>  drivers/media/platform/amphion/vpu_helpers.h |   2 +
>>  drivers/media/platform/amphion/vpu_malone.c  |   3 +-
>>  drivers/media/platform/amphion/vpu_v4l2.c    | 168 ++++++++++++-----
>>  drivers/media/platform/amphion/vpu_v4l2.h    |   3 +-
>>  drivers/media/platform/amphion/vpu_windsor.c |   8 +-
>>  10 files changed, 299 insertions(+), 165 deletions(-)
>>

[snip]

>> +const struct vpu_format *vpu_helper_find_sibling(struct vpu_inst
>> +*inst, u32 type, u32 pixelfmt) {
>> +     const struct vpu_format *fmt;
>> +     const struct vpu_format *sibling;
>> +
>> +     fmt =3D vpu_helper_find_format(inst, type, pixelfmt);
>> +     if (!fmt)
>> +             return NULL;
>> +     if (!fmt->sibling)
>> +             return NULL;
>> +     sibling =3D vpu_helper_find_format(inst, type, fmt->sibling);
>> +     if (!sibling)
>> +             return NULL;
>> +     if (sibling->sibling !=3D fmt->pixfmt)
>> +             return NULL;
>> +     if (sibling->comp_planes !=3D fmt->comp_planes)
>> +             return NULL;
>> +     return sibling;
>> +}
>
>I think we can limit the use of "if" statement here. What about this?
>
>const struct vpu_format *vpu_helper_find_sibling(struct vpu_inst *inst, u3=
2
>type, u32 pixelfmt) {
>        const struct vpu_format *fmt;
>        const struct vpu_format *sibling;
>
>        fmt =3D vpu_helper_find_format(inst, type, pixelfmt);
>        if (!fmt || !fmt->sibling)
>                return NULL;
>
>        sibling =3D vpu_helper_find_format(inst, type, fmt->sibling);
>        if (!sibling || (sibling->sibling !=3D fmt->pixfmt) ||
>                (sibling->comp_planes !=3D fmt->comp_planes))
>                return NULL;
>
>        return sibling;
>}
>

OK, I'll apply this change in v5

>> +
>> +bool vpu_helper_match_format(struct vpu_inst *inst, u32 type, u32
>> +fmta, u32 fmtb) {
>> +     const struct vpu_format *sibling;
>> +
>> +     if (fmta =3D=3D fmtb)
>> +             return true;
>> +
>> +     sibling =3D vpu_helper_find_sibling(inst, type, fmta);
>> +     if (sibling && sibling->pixfmt =3D=3D fmtb)
>> +             return true;
>> +     return false;
>> +}
>> +

[snip]

>> --- a/drivers/media/platform/amphion/vpu_malone.c
>> +++ b/drivers/media/platform/amphion/vpu_malone.c
>> @@ -583,7 +583,8 @@ bool vpu_malone_check_fmt(enum vpu_core_type
>type, u32 pixelfmt)
>>       if (!vpu_imx8q_check_fmt(type, pixelfmt))
>>               return false;
>>
>> -     if (pixelfmt =3D=3D V4L2_PIX_FMT_NV12M_8L128 || pixelfmt =3D=3D
>V4L2_PIX_FMT_NV12M_10BE_8L128)
>> +     if (pixelfmt =3D=3D V4L2_PIX_FMT_NV12_8L128 || pixelfmt =3D=3D
>V4L2_PIX_FMT_NV12_10BE_8L128 ||
>> +         pixelfmt =3D=3D V4L2_PIX_FMT_NV12M_8L128 || pixelfmt =3D=3D
>> + V4L2_PIX_FMT_NV12M_10BE_8L128)
>
>^Here are we using spaces instead of tab or I'm wrong?
>

It's following the rule of checkpatch.pl

>>               return true;
>>       if (vpu_malone_format_remap(pixelfmt) =3D=3D MALONE_FMT_NULL)
>>               return false;

[snip]

>> +static int vpu_calc_fmt_sizeimage(struct vpu_inst *inst, struct
>> +vpu_format *fmt) {
>>       u32 stride =3D 1;
>> -     u32 bytesperline;
>> -     u32 sizeimage;
>> -     const struct vpu_format *fmt;
>> -     const struct vpu_core_resources *res;
>>       int i;
>>
>> -     fmt =3D vpu_helper_find_format(inst, type, pixmp->pixelformat);
>> -     if (!fmt) {
>> -             fmt =3D vpu_helper_enum_format(inst, type, 0);
>> -             if (!fmt)
>> -                     return NULL;
>> -             pixmp->pixelformat =3D fmt->pixfmt;
>> +     if (!(fmt->flags & V4L2_FMT_FLAG_COMPRESSED)) {
>> +             const struct vpu_core_resources *res =3D
>> + vpu_get_resource(inst);
>> +
>> +             if (res)
>> +                     stride =3D res->stride;
>
>If res=3DNULL stride=3D1 it is ok? Or we need to return some error?
>

If res is NULL, it means there is no additional alignment constraints
So it's ok to set stride to 1 in this case.

>>       }
>>
>> -     res =3D vpu_get_resource(inst);
>> -     if (res)
>> -             stride =3D res->stride;
>> -     if (pixmp->width)
>> -             pixmp->width =3D vpu_helper_valid_frame_width(inst,
>pixmp->width);
>> -     if (pixmp->height)
>> -             pixmp->height =3D vpu_helper_valid_frame_height(inst,
>pixmp->height);
>> +     for (i =3D 0; i < fmt->comp_planes; i++) {
>> +             fmt->sizeimage[i] =3D vpu_helper_get_plane_size(fmt->pixfm=
t,
>> +
>fmt->width,
>> +
>fmt->height,
>> +                                                           i,
>> +                                                           stride,
>> +
>fmt->field !=3D V4L2_FIELD_NONE ? 1 : 0,
>> +
>&fmt->bytesperline[i]);
>> +             fmt->sizeimage[i] =3D max_t(u32, fmt->sizeimage[i], PAGE_S=
IZE);
>> +             if (fmt->flags & V4L2_FMT_FLAG_COMPRESSED) {
>> +                     fmt->sizeimage[i] =3D clamp_val(fmt->sizeimage[i],
>SZ_128K, SZ_8M);
>> +                     fmt->bytesperline[i] =3D 0;
>> +             }
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +u32 vpu_get_fmt_plane_size(struct vpu_format *fmt, u32 plane_no) {
>> +     u32 size;
>> +     int i;
>> +
>> +     if (plane_no >=3D fmt->mem_planes)
>> +             return 0;
>> +
>> +     if (fmt->comp_planes =3D=3D fmt->mem_planes)
>> +             return fmt->sizeimage[plane_no];
>> +     if (plane_no < fmt->mem_planes - 1)
>> +             return fmt->sizeimage[plane_no];
>
>I like a space here but is my personal opinion :)
>

OK, I'll add a space line here in v5

[snip]
