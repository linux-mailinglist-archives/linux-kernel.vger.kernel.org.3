Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939915917A1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 01:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbiHLX04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 19:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHLX0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 19:26:53 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00079.outbound.protection.outlook.com [40.107.0.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8944A59A2;
        Fri, 12 Aug 2022 16:26:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCmjXuHZ3JVCv7mPucXqWLEBCe6uDPzxqqrzT1VG0dOcCm1HVfUHdh9XAdTtIctX8j4Vf2DvfjeTkLmjNHucWeiuh/V59bLOYEy8lMnKgmB/SMuktTx3mg/7UIO8QIqbmuVy+d0mfI9N0m7BWBKH2qxrT6ZT7z9Ie5uYNXm/ejXTgErfqJdQXFL9fJH8Atm00O4wvWLdnezyOXqvKUzUcc+LzEVhRv3mw233r1Vb2Oqsb2/tlC21iaGGB4T/1q9GzaqdQCHHlXjVkf1FxQL78sxN23G5D9fM35/CssHxLfjPhBqlWQzKhi4Dm6F6OUbk+EoBbYFsJvZS7U477hV0pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnDhJs9DGNCaPrmpmJtz5hNDs99OcwPUz0ytjyxb08c=;
 b=L3w7C1wmy5KRhHS8tD1P2dnfgIyKYREXpMzPIglk2dHMc1YLWAJi6y2tudKcF3AAwB9xmfdP2TlmJorPdUDdTlerT/Hch5HvX2lD/tARNetSPj1VMpQTzQndY6CznHrSwEdi8vtGg9WBNtoFVezMKI5XvHG77VUo1QcECxIO/FzwmexvrvZ7FfEOd4a+dh0i+FRexwVfunEUfZL/YshigmARnkB98ioButVV7B0B0+wsusSvHudeBt/AEOZQc14EKKHTSMrOSfbuapa6YGAImFj6rVKC5/+eRQPOQK2OvxDBKqdPuFy3Z3RbC3u6qSKcv4EYR8kntEAqe9vFz3B8nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnDhJs9DGNCaPrmpmJtz5hNDs99OcwPUz0ytjyxb08c=;
 b=DeYfQC1u18dwhQSP4K2gpkd3v137+TP0a9Oh2GMcXTP7mJ6Mlig12QnNdRiWlk1xwvKstEfvvcqBb96zzt9ug2TKb1fFdZN74bdbmeJG0oqHoYi0oI1CNSzK6ZMM+EVu82Jkuc31cnee34BWnFgTvLhsYlCT+68DqMef2CTiBCg=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM6PR04MB6504.eurprd04.prod.outlook.com (2603:10a6:20b:f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Fri, 12 Aug
 2022 23:26:47 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c%4]) with mapi id 15.20.5504.025; Fri, 12 Aug 2022
 23:26:46 +0000
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
Thread-Index: AQHYq7vKlvLkxGBCKE6M1xb7c2cV8q2q3vqAgAEOQ+A=
Date:   Fri, 12 Aug 2022 23:26:46 +0000
Message-ID: <AM6PR04MB6341F83548F23C67B5B2B451E7679@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <cover.1660027440.git.ming.qian@nxp.com>
 <4af9766eb664a02d1c5884cb48fadef24dec142f.1660027440.git.ming.qian@nxp.com>
 <20220812071455.GB5705@tom-ThinkPad-T14s-Gen-2i>
In-Reply-To: <20220812071455.GB5705@tom-ThinkPad-T14s-Gen-2i>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8649d5fe-003c-4a36-c24f-08da7cba1fe7
x-ms-traffictypediagnostic: AM6PR04MB6504:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gc84SFZBGu4VzBOgOxzn2i8/R8dJCm45YXfgPChw+guvOKlpiKsCyMF33G/lKY7RHK6DGZJN/oxOiqm+Hu+TdD5ig0r5Xk7aMou/o4sayKE/wUwADP//pgnd+3llHmlbHURwd1GU1FmOwSxeN/8chhpRBGIqgA+TuKwVWBkFdNwInczYw9mGWLeMLXDsY+Iwr4xG4bwCPPy7HSvNNhr8lzsRMXf0C+ykTSiAsOGDNn0Il5GDYvJImRs08JyjyE2HM5Dy9bEjeaNReHItk1RmA9IMwOVcw/3ro1tb2BFVgopMA4v6B7R4sTAZKaIfjw4MZzLPcrNNXZo2v7QDG9fa1jprkwdcXPIxdZwvHtEHcrs+VXqhkt2o0wX/ovOEl1nz4MGOrSIiLutvtZEOeDZEmRxm2Jn6Bv3AfrDrUhZocANetg8opsbpopdCP0/0+1IG+Ti2DPOnHJmvdvh7BoCgxIaVjt6b+YxVzzSo8BVsBV/TzTXbToENMJCrIp4y865YPaIrQ8iiiwx5QW1qUyfaiD/rRXJgx0AGC+kYEgRUd7lQGho6oT+/g7WmCnKsCN09GDE00xmXieOUWk6zsulv6YdpOCDVqtpWivJtehJgC5WtJNjQ5+h+1HoSTHWDe8E6Z+4/nTQ9GfrP04A0BTaqqx6Zsyb74DSLCa/FjkwNYflGQwpunG1Nllbc6fMW6DZ3XWkUq3MfBrzo/mxY/mcWymo+FRq0H9DrfqPe7elV0MNLtVXoJCh5L7viMW6alF20gOE2BQS+AJ3AV684Y2Trmu2iW3rQfB4PN+X9FklHOLSxcn6zuI0ziUsHzlVvEMlb0XXXGUrSE4dK1Xw3JLvcRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(66446008)(38100700002)(55016003)(40140700001)(66946007)(66556008)(64756008)(6506007)(8676002)(26005)(76116006)(45080400002)(122000001)(186003)(66476007)(41300700001)(2906002)(7696005)(30864003)(8936002)(83380400001)(71200400001)(4326008)(86362001)(33656002)(478600001)(316002)(7416002)(38070700005)(52536014)(44832011)(6916009)(54906003)(5660300002)(9686003)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eLtExorGiAW1wIHk1Oohpy/OuUWthfrv968d7vlzraz/+5vWOvhxyegReEpe?=
 =?us-ascii?Q?pR0pvOy51+OHpk7oNwYTTHtDpGsouTsRy5fX5kut4f7/OZFTNDbjLDVWkZNQ?=
 =?us-ascii?Q?UOQh5cRUTqGVHbB8XpDYbvDyGrrH0q6gBf7t1Q83oVizYgXa7r4C8vvdUR/H?=
 =?us-ascii?Q?/HNhywsGN93Vyg1oeOgWmCoBazHidomwZcFLIxUY2taWjZZrjqoNUYKIW+og?=
 =?us-ascii?Q?6giU2nMN1WqG8XfvUrOiUsPM/SA6KvORpcTipyMt3uQREQJSubs0YqQfU7tu?=
 =?us-ascii?Q?sitDngLBcH/zGkNyYo5jMOQSYiRMc1mafzvuO3GQH1EspMOVhh2D5f7RlXgF?=
 =?us-ascii?Q?nUBOATpkexEDaXBaAOXRSe5ajcCAnVD/fkeQQ7Xkx7YKVgQRxBrHixirIJY4?=
 =?us-ascii?Q?kJlDYnmlOKS2Jo+aMX+PQTfM+mbELB3gTscJcnEGVWJTLc5aK4mZ/j6QlkbS?=
 =?us-ascii?Q?tOQVcBxEJIEju4bnzmcqj5poRMWGotcdvrs5XjzAch0Ojd8hT4xhI8j5BgXx?=
 =?us-ascii?Q?mquhSR29iWUEtipb/H5ChYoyRNPCl6LI8c7tCLctQcCrqBqVvr0u37No+Yz6?=
 =?us-ascii?Q?krP1CJTvgQLlrgakBTiVpa/TUQvtcw6Kgs0Mtjzso8e7Sc/4s4ZdZ+VjnmWF?=
 =?us-ascii?Q?5K71J69+u8iQXIz5ahIyw1RPeIuYuFb2yXe0CiedQCYOd4KrbFi0DjuWiM+T?=
 =?us-ascii?Q?2BQBf410Ffw+6YYiqgY/jH8ZrOr9axnwu6V+t+RHcf9eFF40DwYFwRInMPBl?=
 =?us-ascii?Q?zJYftl6MDGk+sxupUWKR7xAcedSITs7d91KhlmOV8dniBGJnJ4kT7U62YE3e?=
 =?us-ascii?Q?75vpJyCZZIQLFiMgBcWQ5cw3D/jexDCSNZitO3m+GKv9hSSvRbCfZYvu1JBS?=
 =?us-ascii?Q?JPPeXZpADEICdqNq4wEQOknFCNMjjAtgVgU58uBbQMbHTfeINcDydCY6aREA?=
 =?us-ascii?Q?DUh3iBJnIimL/dWtuzM/6/ZSzrlysQW1NXPzGIeqKZMQuBOjIck4FqweCPS8?=
 =?us-ascii?Q?CHRSdL5aNXjf/73NZMNQ8aGvchuvsMpDZ/rU9ryYzATEJdlhjQMJEQ8IVZfv?=
 =?us-ascii?Q?MNfjSbys09vBkznus5myK8f2KAeRhjnh1x0lD7kdfFUVsnmehpUgL29ST9MV?=
 =?us-ascii?Q?K+wBvKvtNB+pQmG69FR0ZqxIdYu/5ebhb3je1Ge86CINq/gLY77ZjGcaKGeP?=
 =?us-ascii?Q?eKqeEhzN6Wusy+t+pUhUYcfogTCFLOn0nTOpHsiF0Sq8SVprEEom/3VbxoJ+?=
 =?us-ascii?Q?MRdxIzSoubTReRQeU4KNGc61h6+RgOD7gImlQjX+wZB+vy8LWS30Aht2QwYy?=
 =?us-ascii?Q?Cbdqi82r5tFpuvC1++BzMRDX9sw8Cr09/W/RDuw/Sd40s5oXg0EtUz7WzZPc?=
 =?us-ascii?Q?c3LJ8r/e1yTrCzT4e6Y/46JEtArm92/P9VqInqL3b8CKBTXmAJcP130KqGVH?=
 =?us-ascii?Q?G2v+ELgZMK8ygj8IQ5y7ghy6j0Zr+H+LAcz0uAy4A9YbsW0CbJ4LqkriFJmb?=
 =?us-ascii?Q?wC4fmd0RJI88d7htayulwNkDd/V8gUgLNenGNnoFZsuM30LByni79Wj2Zlb6?=
 =?us-ascii?Q?syx0qcNsGenij19iB1U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8649d5fe-003c-4a36-c24f-08da7cba1fe7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2022 23:26:46.7077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 40OYr+dXG4Qysu5OgOvsPFK6Pe62lOKiFId2+1Sjhq8l7+4/DQFlAC0CB4G/p4WO8yB9D3gEBwjJI7LFlK9g4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6504
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tommaso,

    I'm sorry that I didn't notice this patch set is dependent on the follo=
wing patch:

    85069   New          media: amphion: don't change the colorspace report=
ed by decoder.

Ming

>Hi Ming,
>Just an info. I'm planning to help to review your series.
>On which Linux tree are you working?
>
>Thanks in advance,
>Tommaso
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
>> diff --git a/drivers/media/platform/amphion/vdec.c
>> b/drivers/media/platform/amphion/vdec.c
>> index feb75dc204de..48ab664fa7ef 100644
>> --- a/drivers/media/platform/amphion/vdec.c
>> +++ b/drivers/media/platform/amphion/vdec.c
>> @@ -69,72 +69,85 @@ struct vdec_t {
>>  static const struct vpu_format vdec_formats[] =3D {
>>       {
>>               .pixfmt =3D V4L2_PIX_FMT_NV12M_8L128,
>> -             .num_planes =3D 2,
>> +             .mem_planes =3D 2,
>> +             .comp_planes =3D 2,
>>               .type =3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
>>       },
>>       {
>>               .pixfmt =3D V4L2_PIX_FMT_NV12M_10BE_8L128,
>> -             .num_planes =3D 2,
>> +             .mem_planes =3D 2,
>> +             .comp_planes =3D 2,
>>               .type =3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
>>       },
>>       {
>>               .pixfmt =3D V4L2_PIX_FMT_H264,
>> -             .num_planes =3D 1,
>> +             .mem_planes =3D 1,
>> +             .comp_planes =3D 1,
>>               .type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>> -             .flags =3D V4L2_FMT_FLAG_DYN_RESOLUTION
>> +             .flags =3D V4L2_FMT_FLAG_DYN_RESOLUTION |
>> + V4L2_FMT_FLAG_COMPRESSED
>>       },
>>       {
>>               .pixfmt =3D V4L2_PIX_FMT_H264_MVC,
>> -             .num_planes =3D 1,
>> +             .mem_planes =3D 1,
>> +             .comp_planes =3D 1,
>>               .type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>> -             .flags =3D V4L2_FMT_FLAG_DYN_RESOLUTION
>> +             .flags =3D V4L2_FMT_FLAG_DYN_RESOLUTION |
>> + V4L2_FMT_FLAG_COMPRESSED
>>       },
>>       {
>>               .pixfmt =3D V4L2_PIX_FMT_HEVC,
>> -             .num_planes =3D 1,
>> +             .mem_planes =3D 1,
>> +             .comp_planes =3D 1,
>>               .type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>> -             .flags =3D V4L2_FMT_FLAG_DYN_RESOLUTION
>> +             .flags =3D V4L2_FMT_FLAG_DYN_RESOLUTION |
>> + V4L2_FMT_FLAG_COMPRESSED
>>       },
>>       {
>>               .pixfmt =3D V4L2_PIX_FMT_VC1_ANNEX_G,
>> -             .num_planes =3D 1,
>> +             .mem_planes =3D 1,
>> +             .comp_planes =3D 1,
>>               .type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>> -             .flags =3D V4L2_FMT_FLAG_DYN_RESOLUTION
>> +             .flags =3D V4L2_FMT_FLAG_DYN_RESOLUTION |
>> + V4L2_FMT_FLAG_COMPRESSED
>>       },
>>       {
>>               .pixfmt =3D V4L2_PIX_FMT_VC1_ANNEX_L,
>> -             .num_planes =3D 1,
>> +             .mem_planes =3D 1,
>> +             .comp_planes =3D 1,
>>               .type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>> +             .flags =3D V4L2_FMT_FLAG_COMPRESSED
>>       },
>>       {
>>               .pixfmt =3D V4L2_PIX_FMT_MPEG2,
>> -             .num_planes =3D 1,
>> +             .mem_planes =3D 1,
>> +             .comp_planes =3D 1,
>>               .type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>> -             .flags =3D V4L2_FMT_FLAG_DYN_RESOLUTION
>> +             .flags =3D V4L2_FMT_FLAG_DYN_RESOLUTION |
>> + V4L2_FMT_FLAG_COMPRESSED
>>       },
>>       {
>>               .pixfmt =3D V4L2_PIX_FMT_MPEG4,
>> -             .num_planes =3D 1,
>> +             .mem_planes =3D 1,
>> +             .comp_planes =3D 1,
>>               .type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>> -             .flags =3D V4L2_FMT_FLAG_DYN_RESOLUTION
>> +             .flags =3D V4L2_FMT_FLAG_DYN_RESOLUTION |
>> + V4L2_FMT_FLAG_COMPRESSED
>>       },
>>       {
>>               .pixfmt =3D V4L2_PIX_FMT_XVID,
>> -             .num_planes =3D 1,
>> +             .mem_planes =3D 1,
>> +             .comp_planes =3D 1,
>>               .type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>> -             .flags =3D V4L2_FMT_FLAG_DYN_RESOLUTION
>> +             .flags =3D V4L2_FMT_FLAG_DYN_RESOLUTION |
>> + V4L2_FMT_FLAG_COMPRESSED
>>       },
>>       {
>>               .pixfmt =3D V4L2_PIX_FMT_VP8,
>> -             .num_planes =3D 1,
>> +             .mem_planes =3D 1,
>> +             .comp_planes =3D 1,
>>               .type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>> -             .flags =3D V4L2_FMT_FLAG_DYN_RESOLUTION
>> +             .flags =3D V4L2_FMT_FLAG_DYN_RESOLUTION |
>> + V4L2_FMT_FLAG_COMPRESSED
>>       },
>>       {
>>               .pixfmt =3D V4L2_PIX_FMT_H263,
>> -             .num_planes =3D 1,
>> +             .mem_planes =3D 1,
>> +             .comp_planes =3D 1,
>>               .type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>> -             .flags =3D V4L2_FMT_FLAG_DYN_RESOLUTION
>> +             .flags =3D V4L2_FMT_FLAG_DYN_RESOLUTION |
>> + V4L2_FMT_FLAG_COMPRESSED
>>       },
>>       {0, 0, 0, 0},
>>  };
>> @@ -256,23 +269,22 @@ static int vdec_enum_fmt(struct file *file, void *=
fh,
>struct v4l2_fmtdesc *f)
>>       int ret =3D -EINVAL;
>>
>>       vpu_inst_lock(inst);
>> -     if (!V4L2_TYPE_IS_OUTPUT(f->type) && vdec->fixed_fmt) {
>> -             if (f->index =3D=3D 0) {
>> -                     f->pixelformat =3D inst->cap_format.pixfmt;
>> -                     f->flags =3D inst->cap_format.flags;
>> -                     ret =3D 0;
>> -             }
>> +     if (V4L2_TYPE_IS_CAPTURE(f->type) && vdec->fixed_fmt) {
>> +             fmt =3D vpu_get_format(inst, f->type);
>> +             if (f->index =3D=3D 1)
>> +                     fmt =3D vpu_helper_find_sibling(inst, f->type,
>fmt->pixfmt);
>> +             if (f->index > 1)
>> +                     fmt =3D NULL;
>>       } else {
>>               fmt =3D vpu_helper_enum_format(inst, f->type, f->index);
>> -             memset(f->reserved, 0, sizeof(f->reserved));
>> -             if (!fmt)
>> -                     goto exit;
>> -
>> -             f->pixelformat =3D fmt->pixfmt;
>> -             f->flags =3D fmt->flags;
>> -             ret =3D 0;
>>       }
>> +     if (!fmt)
>> +             goto exit;
>>
>> +     memset(f->reserved, 0, sizeof(f->reserved));
>> +     f->pixelformat =3D fmt->pixfmt;
>> +     f->flags =3D fmt->flags;
>> +     ret =3D 0;
>>  exit:
>>       vpu_inst_unlock(inst);
>>       return ret;
>> @@ -289,14 +301,14 @@ static int vdec_g_fmt(struct file *file, void *fh,
>struct v4l2_format *f)
>>       cur_fmt =3D vpu_get_format(inst, f->type);
>>
>>       pixmp->pixelformat =3D cur_fmt->pixfmt;
>> -     pixmp->num_planes =3D cur_fmt->num_planes;
>> +     pixmp->num_planes =3D cur_fmt->mem_planes;
>>       pixmp->width =3D cur_fmt->width;
>>       pixmp->height =3D cur_fmt->height;
>>       pixmp->field =3D cur_fmt->field;
>>       pixmp->flags =3D cur_fmt->flags;
>>       for (i =3D 0; i < pixmp->num_planes; i++) {
>>               pixmp->plane_fmt[i].bytesperline =3D cur_fmt->bytesperline=
[i];
>> -             pixmp->plane_fmt[i].sizeimage =3D cur_fmt->sizeimage[i];
>> +             pixmp->plane_fmt[i].sizeimage =3D
>> + vpu_get_fmt_plane_size(cur_fmt, i);
>>       }
>>
>>       f->fmt.pix_mp.colorspace =3D vdec->codec_info.color_primaries; @@
>> -311,10 +323,19 @@ static int vdec_try_fmt(struct file *file, void
>> *fh, struct v4l2_format *f)  {
>>       struct vpu_inst *inst =3D to_inst(file);
>>       struct vdec_t *vdec =3D inst->priv;
>> -
>> -     vpu_try_fmt_common(inst, f);
>> +     struct vpu_format fmt;
>>
>>       vpu_inst_lock(inst);
>> +     if (V4L2_TYPE_IS_CAPTURE(f->type) && vdec->fixed_fmt) {
>> +             struct vpu_format *cap_fmt =3D vpu_get_format(inst,
>> + f->type);
>> +
>> +             if (!vpu_helper_match_format(inst, cap_fmt->type,
>cap_fmt->pixfmt,
>> +                                          f->fmt.pix_mp.pixelformat))
>> +                     f->fmt.pix_mp.pixelformat =3D cap_fmt->pixfmt;
>> +     }
>> +
>> +     vpu_try_fmt_common(inst, f, &fmt);
>> +
>>       if (vdec->fixed_fmt) {
>>               f->fmt.pix_mp.colorspace =3D
>vdec->codec_info.color_primaries;
>>               f->fmt.pix_mp.xfer_func =3D
>> vdec->codec_info.transfer_chars; @@ -334,7 +355,7 @@ static int
>> vdec_try_fmt(struct file *file, void *fh, struct v4l2_format *f)
>> static int vdec_s_fmt_common(struct vpu_inst *inst, struct v4l2_format *=
f)  {
>>       struct v4l2_pix_format_mplane *pixmp =3D &f->fmt.pix_mp;
>> -     const struct vpu_format *fmt;
>> +     struct vpu_format fmt;
>>       struct vpu_format *cur_fmt;
>>       struct vb2_queue *q;
>>       struct vdec_t *vdec =3D inst->priv; @@ -349,36 +370,30 @@ static
>> int vdec_s_fmt_common(struct vpu_inst *inst, struct v4l2_format *f)
>>       if (vb2_is_busy(q))
>>               return -EBUSY;
>>
>> -     fmt =3D vpu_try_fmt_common(inst, f);
>> -     if (!fmt)
>> +     if (vpu_try_fmt_common(inst, f, &fmt))
>>               return -EINVAL;
>>
>>       cur_fmt =3D vpu_get_format(inst, f->type);
>>       if (V4L2_TYPE_IS_OUTPUT(f->type) && inst->state !=3D
>VPU_CODEC_STATE_DEINIT) {
>> -             if (cur_fmt->pixfmt !=3D fmt->pixfmt) {
>> +             if (cur_fmt->pixfmt !=3D fmt.pixfmt) {
>>                       vdec->reset_codec =3D true;
>>                       vdec->fixed_fmt =3D false;
>>               }
>>       }
>> -     cur_fmt->pixfmt =3D fmt->pixfmt;
>>       if (V4L2_TYPE_IS_OUTPUT(f->type) || !vdec->fixed_fmt) {
>> -             cur_fmt->num_planes =3D fmt->num_planes;
>> -             cur_fmt->flags =3D fmt->flags;
>> -             cur_fmt->width =3D pixmp->width;
>> -             cur_fmt->height =3D pixmp->height;
>> -             for (i =3D 0; i < fmt->num_planes; i++) {
>> -                     cur_fmt->sizeimage[i] =3D
>pixmp->plane_fmt[i].sizeimage;
>> -                     cur_fmt->bytesperline[i] =3D
>pixmp->plane_fmt[i].bytesperline;
>> -             }
>> -             if (pixmp->field !=3D V4L2_FIELD_ANY)
>> -                     cur_fmt->field =3D pixmp->field;
>> +             memcpy(cur_fmt, &fmt, sizeof(*cur_fmt));
>>       } else {
>> -             pixmp->num_planes =3D cur_fmt->num_planes;
>> +             if (vpu_helper_match_format(inst, f->type, cur_fmt->pixfmt=
,
>pixmp->pixelformat)) {
>> +                     cur_fmt->pixfmt =3D fmt.pixfmt;
>> +                     cur_fmt->mem_planes =3D fmt.mem_planes;
>> +             }
>> +             pixmp->pixelformat =3D cur_fmt->pixfmt;
>> +             pixmp->num_planes =3D cur_fmt->mem_planes;
>>               pixmp->width =3D cur_fmt->width;
>>               pixmp->height =3D cur_fmt->height;
>>               for (i =3D 0; i < pixmp->num_planes; i++) {
>>                       pixmp->plane_fmt[i].bytesperline =3D
>cur_fmt->bytesperline[i];
>> -                     pixmp->plane_fmt[i].sizeimage =3D
>cur_fmt->sizeimage[i];
>> +                     pixmp->plane_fmt[i].sizeimage =3D
>> + vpu_get_fmt_plane_size(cur_fmt, i);
>>               }
>>               pixmp->field =3D cur_fmt->field;
>>       }
>> @@ -678,9 +693,11 @@ static struct vpu_vb2_buffer
>> *vdec_find_buffer(struct vpu_inst *inst, u32 luma)  static void
>> vdec_buf_done(struct vpu_inst *inst, struct vpu_frame_info *frame)  {
>>       struct vdec_t *vdec =3D inst->priv;
>> +     struct vpu_format *cur_fmt;
>>       struct vpu_vb2_buffer *vpu_buf;
>>       struct vb2_v4l2_buffer *vbuf;
>>       u32 sequence;
>> +     int i;
>>
>>       if (!frame)
>>               return;
>> @@ -699,6 +716,7 @@ static void vdec_buf_done(struct vpu_inst *inst,
>struct vpu_frame_info *frame)
>>               return;
>>       }
>>
>> +     cur_fmt =3D vpu_get_format(inst, inst->cap_format.type);
>>       vbuf =3D &vpu_buf->m2m_buf.vb;
>>       if (vbuf->vb2_buf.index !=3D frame->id)
>>               dev_err(inst->dev, "[%d] buffer id(%d, %d) dismatch\n",
>> @@ -707,9 +725,9 @@ static void vdec_buf_done(struct vpu_inst *inst,
>struct vpu_frame_info *frame)
>>       if (vpu_get_buffer_state(vbuf) !=3D VPU_BUF_STATE_DECODED)
>>               dev_err(inst->dev, "[%d] buffer(%d) ready without
>decoded\n", inst->id, frame->id);
>>       vpu_set_buffer_state(vbuf, VPU_BUF_STATE_READY);
>> -     vb2_set_plane_payload(&vbuf->vb2_buf, 0,
>inst->cap_format.sizeimage[0]);
>> -     vb2_set_plane_payload(&vbuf->vb2_buf, 1,
>inst->cap_format.sizeimage[1]);
>> -     vbuf->field =3D inst->cap_format.field;
>> +     for (i =3D 0; i < vbuf->vb2_buf.num_planes; i++)
>> +             vb2_set_plane_payload(&vbuf->vb2_buf, i,
>vpu_get_fmt_plane_size(cur_fmt, i));
>> +     vbuf->field =3D cur_fmt->field;
>>       vbuf->sequence =3D sequence;
>>       dev_dbg(inst->dev, "[%d][OUTPUT TS]%32lld\n", inst->id,
>> vbuf->vb2_buf.timestamp);
>>
>> @@ -747,15 +765,17 @@ static void vdec_stop_done(struct vpu_inst
>> *inst)  static bool vdec_check_source_change(struct vpu_inst *inst)  {
>>       struct vdec_t *vdec =3D inst->priv;
>> -     const struct vpu_format *fmt;
>> -     int i;
>> +     const struct vpu_format *sibling;
>>
>>       if (!inst->fh.m2m_ctx)
>>               return false;
>>
>> +     sibling =3D vpu_helper_find_sibling(inst, inst->cap_format.type,
>inst->cap_format.pixfmt);
>> +     if (sibling && vdec->codec_info.pixfmt =3D=3D sibling->pixfmt)
>> +             vdec->codec_info.pixfmt =3D inst->cap_format.pixfmt;
>> +
>>       if (!vb2_is_streaming(v4l2_m2m_get_dst_vq(inst->fh.m2m_ctx)))
>>               return true;
>> -     fmt =3D vpu_helper_find_format(inst, inst->cap_format.type,
>vdec->codec_info.pixfmt);
>>       if (inst->cap_format.pixfmt !=3D vdec->codec_info.pixfmt)
>>               return true;
>>       if (inst->cap_format.width !=3D vdec->codec_info.decoded_width) @@
>> -772,14 +792,6 @@ static bool vdec_check_source_change(struct vpu_inst
>*inst)
>>               return true;
>>       if (inst->crop.height !=3D vdec->codec_info.height)
>>               return true;
>> -     if (fmt && inst->cap_format.num_planes !=3D fmt->num_planes)
>> -             return true;
>> -     for (i =3D 0; i < inst->cap_format.num_planes; i++) {
>> -             if (inst->cap_format.bytesperline[i] !=3D
>vdec->codec_info.bytesperline[i])
>> -                     return true;
>> -             if (inst->cap_format.sizeimage[i] !=3D
>vdec->codec_info.sizeimage[i])
>> -                     return true;
>> -     }
>>
>>       return false;
>>  }
>> @@ -787,27 +799,21 @@ static bool vdec_check_source_change(struct
>> vpu_inst *inst)  static void vdec_init_fmt(struct vpu_inst *inst)  {
>>       struct vdec_t *vdec =3D inst->priv;
>> -     const struct vpu_format *fmt;
>> -     int i;
>> +     struct v4l2_format f;
>>
>> -     fmt =3D vpu_helper_find_format(inst, inst->cap_format.type,
>vdec->codec_info.pixfmt);
>> -     inst->out_format.width =3D vdec->codec_info.width;
>> -     inst->out_format.height =3D vdec->codec_info.height;
>> -     inst->cap_format.width =3D vdec->codec_info.decoded_width;
>> -     inst->cap_format.height =3D vdec->codec_info.decoded_height;
>> -     inst->cap_format.pixfmt =3D vdec->codec_info.pixfmt;
>> -     if (fmt) {
>> -             inst->cap_format.num_planes =3D fmt->num_planes;
>> -             inst->cap_format.flags =3D fmt->flags;
>> -     }
>> -     for (i =3D 0; i < inst->cap_format.num_planes; i++) {
>> -             inst->cap_format.bytesperline[i] =3D
>vdec->codec_info.bytesperline[i];
>> -             inst->cap_format.sizeimage[i] =3D vdec->codec_info.sizeima=
ge[i];
>> -     }
>> +     memset(&f, 0, sizeof(f));
>> +     f.type =3D inst->cap_format.type;
>> +     f.fmt.pix_mp.pixelformat =3D vdec->codec_info.pixfmt;
>> +     f.fmt.pix_mp.width =3D vdec->codec_info.decoded_width;
>> +     f.fmt.pix_mp.height =3D vdec->codec_info.decoded_height;
>>       if (vdec->codec_info.progressive)
>> -             inst->cap_format.field =3D V4L2_FIELD_NONE;
>> +             f.fmt.pix_mp.field =3D V4L2_FIELD_NONE;
>>       else
>> -             inst->cap_format.field =3D V4L2_FIELD_SEQ_TB;
>> +             f.fmt.pix_mp.field =3D V4L2_FIELD_SEQ_TB;
>> +     vpu_try_fmt_common(inst, &f, &inst->cap_format);
>> +
>> +     inst->out_format.width =3D vdec->codec_info.width;
>> +     inst->out_format.height =3D vdec->codec_info.height;
>>  }
>>
>>  static void vdec_init_crop(struct vpu_inst *inst) @@ -966,7 +972,10
>> @@ static int vdec_response_frame(struct vpu_inst *inst, struct
>vb2_v4l2_buffer *vb
>>       info.tag =3D vdec->seq_tag;
>>       info.luma_addr =3D vpu_get_vb_phy_addr(&vbuf->vb2_buf, 0);
>>       info.luma_size =3D inst->cap_format.sizeimage[0];
>> -     info.chroma_addr =3D vpu_get_vb_phy_addr(&vbuf->vb2_buf, 1);
>> +     if (vbuf->vb2_buf.num_planes > 1)
>> +             info.chroma_addr =3D vpu_get_vb_phy_addr(&vbuf->vb2_buf,
>1);
>> +     else
>> +             info.chroma_addr =3D info.luma_addr + info.luma_size;
>>       info.chromau_size =3D inst->cap_format.sizeimage[1];
>>       info.bytesperline =3D inst->cap_format.bytesperline[0];
>>       ret =3D vpu_session_alloc_fs(inst, &info); @@ -975,7 +984,7 @@
>> static int vdec_response_frame(struct vpu_inst *inst, struct
>> vb2_v4l2_buffer *vb
>>
>>       vpu_buf->tag =3D info.tag;
>>       vpu_buf->luma =3D info.luma_addr;
>> -     vpu_buf->chroma_u =3D info.chromau_size;
>> +     vpu_buf->chroma_u =3D info.chroma_addr;
>>       vpu_buf->chroma_v =3D 0;
>>       vpu_set_buffer_state(vbuf, VPU_BUF_STATE_INUSE);
>>       vdec->slots[info.id] =3D vpu_buf;
>> diff --git a/drivers/media/platform/amphion/venc.c
>> b/drivers/media/platform/amphion/venc.c
>> index 37212f087fdd..060a1ee78b17 100644
>> --- a/drivers/media/platform/amphion/venc.c
>> +++ b/drivers/media/platform/amphion/venc.c
>> @@ -69,13 +69,16 @@ struct venc_frame_t {  static const struct
>> vpu_format venc_formats[] =3D {
>>       {
>>               .pixfmt =3D V4L2_PIX_FMT_NV12M,
>> -             .num_planes =3D 2,
>> +             .mem_planes =3D 2,
>> +             .comp_planes =3D 2,
>>               .type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>>       },
>>       {
>>               .pixfmt =3D V4L2_PIX_FMT_H264,
>> -             .num_planes =3D 1,
>> +             .mem_planes =3D 1,
>> +             .comp_planes =3D 1,
>>               .type =3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
>> +             .flags =3D V4L2_FMT_FLAG_COMPRESSED
>>       },
>>       {0, 0, 0, 0},
>>  };
>> @@ -173,14 +176,14 @@ static int venc_g_fmt(struct file *file, void *fh,
>struct v4l2_format *f)
>>       cur_fmt =3D vpu_get_format(inst, f->type);
>>
>>       pixmp->pixelformat =3D cur_fmt->pixfmt;
>> -     pixmp->num_planes =3D cur_fmt->num_planes;
>> +     pixmp->num_planes =3D cur_fmt->mem_planes;
>>       pixmp->width =3D cur_fmt->width;
>>       pixmp->height =3D cur_fmt->height;
>>       pixmp->field =3D cur_fmt->field;
>>       pixmp->flags =3D cur_fmt->flags;
>>       for (i =3D 0; i < pixmp->num_planes; i++) {
>>               pixmp->plane_fmt[i].bytesperline =3D cur_fmt->bytesperline=
[i];
>> -             pixmp->plane_fmt[i].sizeimage =3D cur_fmt->sizeimage[i];
>> +             pixmp->plane_fmt[i].sizeimage =3D
>> + vpu_get_fmt_plane_size(cur_fmt, i);
>>       }
>>
>>       f->fmt.pix_mp.colorspace =3D venc->params.color.primaries; @@
>> -194,8 +197,9 @@ static int venc_g_fmt(struct file *file, void *fh,
>> struct v4l2_format *f)  static int venc_try_fmt(struct file *file,
>> void *fh, struct v4l2_format *f)  {
>>       struct vpu_inst *inst =3D to_inst(file);
>> +     struct vpu_format fmt;
>>
>> -     vpu_try_fmt_common(inst, f);
>> +     vpu_try_fmt_common(inst, f, &fmt);
>>
>>       return 0;
>>  }
>> @@ -203,12 +207,11 @@ static int venc_try_fmt(struct file *file, void
>> *fh, struct v4l2_format *f)  static int venc_s_fmt(struct file *file,
>> void *fh, struct v4l2_format *f)  {
>>       struct vpu_inst *inst =3D to_inst(file);
>> -     const struct vpu_format *fmt;
>> +     struct vpu_format fmt;
>>       struct vpu_format *cur_fmt;
>>       struct vb2_queue *q;
>>       struct venc_t *venc =3D inst->priv;
>>       struct v4l2_pix_format_mplane *pix_mp =3D &f->fmt.pix_mp;
>> -     int i;
>>
>>       q =3D v4l2_m2m_get_vq(inst->fh.m2m_ctx, f->type);
>>       if (!q)
>> @@ -216,24 +219,12 @@ static int venc_s_fmt(struct file *file, void *fh,
>struct v4l2_format *f)
>>       if (vb2_is_busy(q))
>>               return -EBUSY;
>>
>> -     fmt =3D vpu_try_fmt_common(inst, f);
>> -     if (!fmt)
>> +     if (vpu_try_fmt_common(inst, f, &fmt))
>>               return -EINVAL;
>>
>>       cur_fmt =3D vpu_get_format(inst, f->type);
>>
>> -     cur_fmt->pixfmt =3D fmt->pixfmt;
>> -     cur_fmt->num_planes =3D fmt->num_planes;
>> -     cur_fmt->flags =3D fmt->flags;
>> -     cur_fmt->width =3D pix_mp->width;
>> -     cur_fmt->height =3D pix_mp->height;
>> -     for (i =3D 0; i < fmt->num_planes; i++) {
>> -             cur_fmt->sizeimage[i] =3D pix_mp->plane_fmt[i].sizeimage;
>> -             cur_fmt->bytesperline[i] =3D pix_mp->plane_fmt[i].bytesper=
line;
>> -     }
>> -
>> -     if (pix_mp->field !=3D V4L2_FIELD_ANY)
>> -             cur_fmt->field =3D pix_mp->field;
>> +     memcpy(cur_fmt, &fmt, sizeof(*cur_fmt));
>>
>>       if (V4L2_TYPE_IS_OUTPUT(f->type)) {
>>               venc->params.input_format =3D cur_fmt->pixfmt; diff --git
>> a/drivers/media/platform/amphion/vpu.h
>> b/drivers/media/platform/amphion/vpu.h
>> index f914de6ed81e..998591fa5b85 100644
>> --- a/drivers/media/platform/amphion/vpu.h
>> +++ b/drivers/media/platform/amphion/vpu.h
>> @@ -84,7 +84,8 @@ struct vpu_dev {
>>
>>  struct vpu_format {
>>       u32 pixfmt;
>> -     unsigned int num_planes;
>> +     u32 mem_planes;
>> +     u32 comp_planes;
>>       u32 type;
>>       u32 flags;
>>       u32 width;
>> @@ -92,6 +93,7 @@ struct vpu_format {
>>       u32 sizeimage[VIDEO_MAX_PLANES];
>>       u32 bytesperline[VIDEO_MAX_PLANES];
>>       u32 field;
>> +     u32 sibling;
>>  };
>>
>>  struct vpu_core_resources {
>> diff --git a/drivers/media/platform/amphion/vpu_dbg.c
>> b/drivers/media/platform/amphion/vpu_dbg.c
>> index f72c8a506b22..c41c9896912c 100644
>> --- a/drivers/media/platform/amphion/vpu_dbg.c
>> +++ b/drivers/media/platform/amphion/vpu_dbg.c
>> @@ -89,9 +89,9 @@ static int vpu_dbg_instance(struct seq_file *s, void
>*data)
>>                       vq->last_buffer_dequeued);
>>       if (seq_write(s, str, num))
>>               return 0;
>> -     for (i =3D 0; i < inst->out_format.num_planes; i++) {
>> +     for (i =3D 0; i < inst->out_format.mem_planes; i++) {
>>               num =3D scnprintf(str, sizeof(str), " %d(%d)",
>> -                             inst->out_format.sizeimage[i],
>> +
>> + vpu_get_fmt_plane_size(&inst->out_format, i),
>>                               inst->out_format.bytesperline[i]);
>>               if (seq_write(s, str, num))
>>                       return 0;
>> @@ -113,9 +113,9 @@ static int vpu_dbg_instance(struct seq_file *s, void
>*data)
>>                       vq->last_buffer_dequeued);
>>       if (seq_write(s, str, num))
>>               return 0;
>> -     for (i =3D 0; i < inst->cap_format.num_planes; i++) {
>> +     for (i =3D 0; i < inst->cap_format.mem_planes; i++) {
>>               num =3D scnprintf(str, sizeof(str), " %d(%d)",
>> -                             inst->cap_format.sizeimage[i],
>> +
>> + vpu_get_fmt_plane_size(&inst->cap_format, i),
>>                               inst->cap_format.bytesperline[i]);
>>               if (seq_write(s, str, num))
>>                       return 0;
>> diff --git a/drivers/media/platform/amphion/vpu_helpers.c
>> b/drivers/media/platform/amphion/vpu_helpers.c
>> index e9aeb3453dfc..db8f471b9187 100644
>> --- a/drivers/media/platform/amphion/vpu_helpers.c
>> +++ b/drivers/media/platform/amphion/vpu_helpers.c
>> @@ -59,6 +59,39 @@ const struct vpu_format
>*vpu_helper_find_format(struct vpu_inst *inst, u32 type,
>>       return NULL;
>>  }
>>
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
>>  const struct vpu_format *vpu_helper_enum_format(struct vpu_inst
>> *inst, u32 type, int index)  {
>>       const struct vpu_format *pfmt;
>> @@ -123,9 +156,10 @@ static u32 get_nv12_plane_size(u32 width, u32
>height, int plane_no,
>>       u32 bytesperline;
>>       u32 size =3D 0;
>>
>> -     bytesperline =3D ALIGN(width, stride);
>> +     bytesperline =3D width;
>>       if (pbl)
>>               bytesperline =3D max(bytesperline, *pbl);
>> +     bytesperline =3D ALIGN(bytesperline, stride);
>>       height =3D ALIGN(height, 2);
>>       if (plane_no =3D=3D 0)
>>               size =3D bytesperline * height; @@ -148,13 +182,13 @@
>> static u32 get_tiled_8l128_plane_size(u32 fmt, u32 width, u32 height,
>> int plane_
>>
>>       if (interlaced)
>>               hs++;
>> -     if (fmt =3D=3D V4L2_PIX_FMT_NV12M_10BE_8L128)
>> +     if (fmt =3D=3D V4L2_PIX_FMT_NV12M_10BE_8L128 || fmt =3D=3D
>> + V4L2_PIX_FMT_NV12_10BE_8L128)
>>               bitdepth =3D 10;
>>       bytesperline =3D DIV_ROUND_UP(width * bitdepth, BITS_PER_BYTE);
>> -     bytesperline =3D ALIGN(bytesperline, 1 << ws);
>> -     bytesperline =3D ALIGN(bytesperline, stride);
>>       if (pbl)
>>               bytesperline =3D max(bytesperline, *pbl);
>> +     bytesperline =3D ALIGN(bytesperline, 1 << ws);
>> +     bytesperline =3D ALIGN(bytesperline, stride);
>>       height =3D ALIGN(height, 1 << hs);
>>       if (plane_no =3D=3D 0)
>>               size =3D bytesperline * height; @@ -172,9 +206,10 @@
>> static u32 get_default_plane_size(u32 width, u32 height, int plane_no,
>>       u32 bytesperline;
>>       u32 size =3D 0;
>>
>> -     bytesperline =3D ALIGN(width, stride);
>> +     bytesperline =3D width;
>>       if (pbl)
>>               bytesperline =3D max(bytesperline, *pbl);
>> +     bytesperline =3D ALIGN(bytesperline, stride);
>>       if (plane_no =3D=3D 0)
>>               size =3D bytesperline * height;
>>       if (pbl)
>> @@ -187,9 +222,12 @@ u32 vpu_helper_get_plane_size(u32 fmt, u32 w, u32
>h, int plane_no,
>>                             u32 stride, u32 interlaced, u32 *pbl)  {
>>       switch (fmt) {
>> +     case V4L2_PIX_FMT_NV12:
>>       case V4L2_PIX_FMT_NV12M:
>>               return get_nv12_plane_size(w, h, plane_no, stride,
>> interlaced, pbl);
>> +     case V4L2_PIX_FMT_NV12_8L128:
>>       case V4L2_PIX_FMT_NV12M_8L128:
>> +     case V4L2_PIX_FMT_NV12_10BE_8L128:
>>       case V4L2_PIX_FMT_NV12M_10BE_8L128:
>>               return get_tiled_8l128_plane_size(fmt, w, h, plane_no, str=
ide,
>interlaced, pbl);
>>       default:
>> diff --git a/drivers/media/platform/amphion/vpu_helpers.h
>> b/drivers/media/platform/amphion/vpu_helpers.h
>> index bc28350958be..0eaddb07190d 100644
>> --- a/drivers/media/platform/amphion/vpu_helpers.h
>> +++ b/drivers/media/platform/amphion/vpu_helpers.h
>> @@ -14,6 +14,8 @@ struct vpu_pair {
>>  int vpu_helper_find_in_array_u8(const u8 *array, u32 size, u32 x);
>> bool vpu_helper_check_type(struct vpu_inst *inst, u32 type);  const
>> struct vpu_format *vpu_helper_find_format(struct vpu_inst *inst, u32
>> type, u32 pixelfmt);
>> +const struct vpu_format *vpu_helper_find_sibling(struct vpu_inst
>> +*inst, u32 type, u32 pixelfmt); bool vpu_helper_match_format(struct
>> +vpu_inst *inst, u32 type, u32 fmta, u32 fmtb);
>>  const struct vpu_format *vpu_helper_enum_format(struct vpu_inst
>> *inst, u32 type, int index);
>>  u32 vpu_helper_valid_frame_width(struct vpu_inst *inst, u32 width);
>>  u32 vpu_helper_valid_frame_height(struct vpu_inst *inst, u32 height);
>> diff --git a/drivers/media/platform/amphion/vpu_malone.c
>> b/drivers/media/platform/amphion/vpu_malone.c
>> index 51e0702f9ae1..69d9a2269fce 100644
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
>>               return true;
>>       if (vpu_malone_format_remap(pixelfmt) =3D=3D MALONE_FMT_NULL)
>>               return false;
>> diff --git a/drivers/media/platform/amphion/vpu_v4l2.c
>> b/drivers/media/platform/amphion/vpu_v4l2.c
>> index 8a3eed957ae6..87cce552e906 100644
>> --- a/drivers/media/platform/amphion/vpu_v4l2.c
>> +++ b/drivers/media/platform/amphion/vpu_v4l2.c
>> @@ -140,51 +140,135 @@ bool vpu_is_source_empty(struct vpu_inst *inst)
>>       return true;
>>  }
>>
>> -const struct vpu_format *vpu_try_fmt_common(struct vpu_inst *inst,
>> struct v4l2_format *f)
>> +static int vpu_init_format(struct vpu_inst *inst, struct vpu_format
>> +*fmt) {
>> +     const struct vpu_format *info;
>> +
>> +     info =3D vpu_helper_find_format(inst, fmt->type, fmt->pixfmt);
>> +     if (!info) {
>> +             info =3D vpu_helper_enum_format(inst, fmt->type, 0);
>> +             if (!info)
>> +                     return -EINVAL;
>> +     }
>> +     memcpy(fmt, info, sizeof(*fmt));
>> +
>> +     return 0;
>> +}
>> +
>> +static int vpu_calc_fmt_bytesperline(struct v4l2_format *f, struct
>> +vpu_format *fmt)
>>  {
>>       struct v4l2_pix_format_mplane *pixmp =3D &f->fmt.pix_mp;
>> -     u32 type =3D f->type;
>> +     int i;
>> +
>> +     if (fmt->flags & V4L2_FMT_FLAG_COMPRESSED) {
>> +             for (i =3D 0; i < fmt->comp_planes; i++)
>> +                     fmt->bytesperline[i] =3D 0;
>> +             return 0;
>> +     }
>> +     if (pixmp->num_planes =3D=3D fmt->comp_planes) {
>> +             for (i =3D 0; i < fmt->comp_planes; i++)
>> +                     fmt->bytesperline[i] =3D
>pixmp->plane_fmt[i].bytesperline;
>> +             return 0;
>> +     }
>> +     if (pixmp->num_planes > 1)
>> +             return -EINVAL;
>> +
>> +     /*amphion vpu only support nv12 and nv12 tiled,
>> +      * so the bytesperline of luma and chroma should be same
>> +      */
>> +     for (i =3D 0; i < fmt->comp_planes; i++)
>> +             fmt->bytesperline[i] =3D pixmp->plane_fmt[0].bytesperline;
>> +
>> +     return 0;
>> +}
>> +
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
>> +     size =3D fmt->sizeimage[plane_no];
>> +     for (i =3D fmt->mem_planes; i < fmt->comp_planes; i++)
>> +             size +=3D fmt->sizeimage[i];
>> +
>> +     return size;
>> +}
>> +
>> +int vpu_try_fmt_common(struct vpu_inst *inst, struct v4l2_format *f,
>> +struct vpu_format *fmt) {
>> +     struct v4l2_pix_format_mplane *pixmp =3D &f->fmt.pix_mp;
>> +     int i;
>> +     int ret;
>> +
>> +     fmt->pixfmt =3D pixmp->pixelformat;
>> +     fmt->type =3D f->type;
>> +     ret =3D vpu_init_format(inst, fmt);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     fmt->width =3D pixmp->width;
>> +     fmt->height =3D pixmp->height;
>> +     if (fmt->width)
>> +             fmt->width =3D vpu_helper_valid_frame_width(inst,
>fmt->width);
>> +     if (fmt->height)
>> +             fmt->height =3D vpu_helper_valid_frame_height(inst,
>fmt->height);
>> +     fmt->field =3D pixmp->field =3D=3D V4L2_FIELD_ANY ? V4L2_FIELD_NON=
E :
>pixmp->field;
>> +     vpu_calc_fmt_bytesperline(f, fmt);
>> +     vpu_calc_fmt_sizeimage(inst, fmt);
>> +     if ((fmt->flags & V4L2_FMT_FLAG_COMPRESSED) &&
>pixmp->plane_fmt[0].sizeimage)
>> +             fmt->sizeimage[0] =3D
>> + clamp_val(pixmp->plane_fmt[0].sizeimage, SZ_128K, SZ_8M);
>> +
>> +     pixmp->pixelformat =3D fmt->pixfmt;
>> +     pixmp->width =3D fmt->width;
>> +     pixmp->height =3D fmt->height;
>>       pixmp->flags =3D fmt->flags;
>> -     pixmp->num_planes =3D fmt->num_planes;
>> -     if (pixmp->field =3D=3D V4L2_FIELD_ANY)
>> -             pixmp->field =3D V4L2_FIELD_NONE;
>> +     pixmp->num_planes =3D fmt->mem_planes;
>> +     pixmp->field =3D fmt->field;
>> +     memset(pixmp->reserved, 0, sizeof(pixmp->reserved));
>>       for (i =3D 0; i < pixmp->num_planes; i++) {
>> -             bytesperline =3D max_t(s32, pixmp->plane_fmt[i].bytesperli=
ne,
>0);
>> -             sizeimage =3D vpu_helper_get_plane_size(pixmp->pixelformat=
,
>> -                                                   pixmp->width,
>> -                                                   pixmp->height,
>> -                                                   i,
>> -                                                   stride,
>> -                                                   pixmp->field >
>V4L2_FIELD_NONE ? 1 : 0,
>> -                                                   &bytesperline);
>> -             sizeimage =3D max_t(s32, pixmp->plane_fmt[i].sizeimage,
>sizeimage);
>> -             pixmp->plane_fmt[i].bytesperline =3D bytesperline;
>> -             pixmp->plane_fmt[i].sizeimage =3D sizeimage;
>> +             pixmp->plane_fmt[i].bytesperline =3D fmt->bytesperline[i];
>> +             pixmp->plane_fmt[i].sizeimage =3D vpu_get_fmt_plane_size(f=
mt,
>i);
>> +             memset(pixmp->plane_fmt[i].reserved, 0,
>> + sizeof(pixmp->plane_fmt[i].reserved));
>>       }
>>
>> -     return fmt;
>> +     return 0;
>>  }
>>
>>  static bool vpu_check_ready(struct vpu_inst *inst, u32 type) @@
>> -389,10 +473,10 @@ static int vpu_vb2_queue_setup(struct vb2_queue *vq,
>>       cur_fmt =3D vpu_get_format(inst, vq->type);
>>
>>       if (*plane_count) {
>> -             if (*plane_count !=3D cur_fmt->num_planes)
>> +             if (*plane_count !=3D cur_fmt->mem_planes)
>>                       return -EINVAL;
>> -             for (i =3D 0; i < cur_fmt->num_planes; i++) {
>> -                     if (psize[i] < cur_fmt->sizeimage[i])
>> +             for (i =3D 0; i < cur_fmt->mem_planes; i++) {
>> +                     if (psize[i] < vpu_get_fmt_plane_size(cur_fmt,
>> + i))
>>                               return -EINVAL;
>>               }
>>               return 0;
>> @@ -402,9 +486,9 @@ static int vpu_vb2_queue_setup(struct vb2_queue
>*vq,
>>               *buf_count =3D max_t(unsigned int, *buf_count,
>inst->min_buffer_out);
>>       else
>>               *buf_count =3D max_t(unsigned int, *buf_count,
>inst->min_buffer_cap);
>> -     *plane_count =3D cur_fmt->num_planes;
>> -     for (i =3D 0; i < cur_fmt->num_planes; i++)
>> -             psize[i] =3D cur_fmt->sizeimage[i];
>> +     *plane_count =3D cur_fmt->mem_planes;
>> +     for (i =3D 0; i < cur_fmt->mem_planes; i++)
>> +             psize[i] =3D vpu_get_fmt_plane_size(cur_fmt, i);
>>
>>       return 0;
>>  }
>> @@ -434,8 +518,8 @@ static int vpu_vb2_buf_prepare(struct vb2_buffer
>*vb)
>>       u32 i;
>>
>>       cur_fmt =3D vpu_get_format(inst, vb->type);
>> -     for (i =3D 0; i < cur_fmt->num_planes; i++) {
>> -             if (vpu_get_vb_length(vb, i) < cur_fmt->sizeimage[i]) {
>> +     for (i =3D 0; i < cur_fmt->mem_planes; i++) {
>> +             if (vpu_get_vb_length(vb, i) <
>> + vpu_get_fmt_plane_size(cur_fmt, i)) {
>>                       dev_dbg(inst->dev, "[%d] %s buf[%d] is invalid\n",
>>                               inst->id, vpu_type_name(vb->type),
>vb->index);
>>                       vpu_set_buffer_state(vbuf,
>VPU_BUF_STATE_ERROR);
>> diff --git a/drivers/media/platform/amphion/vpu_v4l2.h
>> b/drivers/media/platform/amphion/vpu_v4l2.h
>> index 795ca33a6a50..ef5de6b66e47 100644
>> --- a/drivers/media/platform/amphion/vpu_v4l2.h
>> +++ b/drivers/media/platform/amphion/vpu_v4l2.h
>> @@ -16,7 +16,8 @@ unsigned int vpu_get_buffer_state(struct
>> vb2_v4l2_buffer *vbuf);  int vpu_v4l2_open(struct file *file, struct
>> vpu_inst *inst);  int vpu_v4l2_close(struct file *file);
>>
>> -const struct vpu_format *vpu_try_fmt_common(struct vpu_inst *inst,
>> struct v4l2_format *f);
>> +u32 vpu_get_fmt_plane_size(struct vpu_format *fmt, u32 plane_no); int
>> +vpu_try_fmt_common(struct vpu_inst *inst, struct v4l2_format *f,
>> +struct vpu_format *fmt);
>>  int vpu_process_output_buffer(struct vpu_inst *inst);  int
>> vpu_process_capture_buffer(struct vpu_inst *inst);  struct
>> vb2_v4l2_buffer *vpu_next_src_buf(struct vpu_inst *inst); diff --git
>> a/drivers/media/platform/amphion/vpu_windsor.c
>> b/drivers/media/platform/amphion/vpu_windsor.c
>> index 1526af2ef9da..a454f142ae17 100644
>> --- a/drivers/media/platform/amphion/vpu_windsor.c
>> +++ b/drivers/media/platform/amphion/vpu_windsor.c
>> @@ -775,6 +775,8 @@ static int vpu_windsor_fill_yuv_frame(struct
>vpu_shared_addr *shared,
>>                                     u32 instance,
>>                                     struct vb2_buffer *vb)  {
>> +     struct vpu_inst *inst =3D vb2_get_drv_priv(vb->vb2_queue);
>> +     struct vpu_format *out_fmt;
>>       struct vpu_enc_yuv_desc *desc;
>>       struct vb2_v4l2_buffer *vbuf;
>>
>> @@ -782,6 +784,7 @@ static int vpu_windsor_fill_yuv_frame(struct
>vpu_shared_addr *shared,
>>               return -EINVAL;
>>
>>       desc =3D get_yuv_desc(shared, instance);
>> +     out_fmt =3D vpu_get_format(inst, vb->type);
>>
>>       vbuf =3D to_vb2_v4l2_buffer(vb);
>>       desc->frame_id =3D vbuf->sequence; @@ -790,7 +793,10 @@ static int
>> vpu_windsor_fill_yuv_frame(struct vpu_shared_addr *shared,
>>       else
>>               desc->key_frame =3D 0;
>>       desc->luma_base =3D vpu_get_vb_phy_addr(vb, 0);
>> -     desc->chroma_base =3D vpu_get_vb_phy_addr(vb, 1);
>> +     if (vb->num_planes > 1)
>> +             desc->chroma_base =3D vpu_get_vb_phy_addr(vb, 1);
>> +     else
>> +             desc->chroma_base =3D desc->luma_base +
>> + out_fmt->sizeimage[0];
>>
>>       return 0;
>>  }
>> --
>> 2.37.1
>>
>
>--
>Tommaso Merciai
>Embedded Linux Engineer
>tommaso.merciai@amarulasolutions.com
>__________________________________
>
>Amarula Solutions SRL
>Via Le Canevare 30, 31100 Treviso, Veneto, IT T. +39 042 243 5310
>info@amarulasolutions.com
>https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.am
>arulasolutions.com%2F&amp;data=3D05%7C01%7Cming.qian%40nxp.com%7C39
>82ab247a5043fd1f6608da7c325e21%7C686ea1d3bc2b4c6fa92cd99c5c30163
>5%7C0%7C0%7C637958853015002900%7CUnknown%7CTWFpbGZsb3d8eyJW
>IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C30
>00%7C%7C%7C&amp;sdata=3DIg20cUBTsVAOcR7blwbR0mWrGhZp7iQYUO6ZaH8
>L00I%3D&amp;reserved=3D0
