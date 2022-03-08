Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C974D140C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 10:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345562AbiCHJ7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 04:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345549AbiCHJ7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 04:59:34 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140079.outbound.protection.outlook.com [40.107.14.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7CC37A8B;
        Tue,  8 Mar 2022 01:58:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNMhYUb1BnWw2dQ/Gnp93ix6Cxe6aDo3t1wHKcTp1ECiu4WNN7LIG79YidnJSFmQXczeMZQ8Ph2P0F4iuydW5PRct2NveSEBzGbgcI6hO+Liq7f5+hm1ohpxoE5Pz/++YqDDX58uIi/ycURA6U0AtX4NmqoGFYLXLVsEt27KCkrIQbR3ww9NV+d2/0URRWVSti/CdxgU36f4UAnOAwLh7UFIVlfqlcxGAbV78B7oTNj7Ydwzv4Fmv4/Hmi91zF13hmtKfYpdWY0Am9exKcy3BAdQkxaNunDkcHmfDtr35LoZZb2PwihQzk687SQiQ8mH3KINqdpy6M771juljsOb3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7AscIZGwZVm4DMCPM3CepwWLLjglkUPGCgA15DyslY=;
 b=CO1gMAWI5JXC4SWnIIwi18p07HTI32ASOW8nV7YGxIxJRAFoFKWOBKM2F9XTtJgdI524gSP5+KGdX7d/2cYlPsMFxSYbN4UADlDCqobS50VSG4T7QQ7N/7xe5Ocz/cdxet1Ntg4OadaoqKsVPD0rQfpSRlENTjmy6C2IVuRI9bzDTOJZ95gvdOp+fsDU3y2YFy2z3RsE4DOYBHqS56ugZDik/jnUvL3fLbBPnl0otL7az3MbMc4BUF83y3Nlp1n/+aLZDkijnmGMdRWy1QzLB0610RTliHM6A2ezKb+yfVX4OnYganrvFlR0RUVonwC4EhaWIrz9ZJdJu2LhGlXDoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7AscIZGwZVm4DMCPM3CepwWLLjglkUPGCgA15DyslY=;
 b=YuL57MTrcl+RoamvGAvwPgHOUL8jYAmyvvF7631pNGSvZ2+Uq9UrNTJopwvzFQ6XjK8FdK+OkUmeOeMWGGKmOSmctPsDN7sQG49jejjD9CZWKs5rbuUvS/BUebCRZa0NJYiTFfOJQhUwlodU2tb3lkOTTDC0B/xX9ybeZvxJu4o=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB5568.eurprd04.prod.outlook.com (2603:10a6:803:d6::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 09:58:34 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 09:58:34 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Shijie Qin <shijie.qin@nxp.com>,
        Eagle Zhou <eagle.zhou@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: RE: [EXT] linux-next: build warnings after merge of the v4l-dvb-next
 tree
Thread-Topic: [EXT] linux-next: build warnings after merge of the v4l-dvb-next
 tree
Thread-Index: AQHYMsSoZPUMxFCFvk6WsVheH3I+1Ky1QDUA
Date:   Tue, 8 Mar 2022 09:58:34 +0000
Message-ID: <AM6PR04MB6341BF70FDEB420DBB5B7C68E7099@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20220308191511.7fa2ddba@canb.auug.org.au>
In-Reply-To: <20220308191511.7fa2ddba@canb.auug.org.au>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5d0162e-02c8-4b94-7ad7-08da00ea3577
x-ms-traffictypediagnostic: VI1PR04MB5568:EE_
x-microsoft-antispam-prvs: <VI1PR04MB5568F425843BB8EC987C0D9DE7099@VI1PR04MB5568.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XamQg0NOmB0gMw8PSfpmt7q0GrmgUbYXNUYHKb2GMkjfYH3vJgeJw3Y7PRxHmKyvHVNM72+w0/a/yorXfW0x3/oFORAKtDP9MVeCn4EKBjo5a3nu4f8raZaIGDwW7q6rL9rSBMxGE8gnp4j5OiGqFgFsVrqgRhm3JlimGhrdgbsTvHTMpcmI6VgqMbnoKNtj4u9VBuMEAj5GG8ouO0idBAXV9eZVGyXPGNBW1jsfWX1oFMjTpBm9BehH9vKR9njZGf1hZDag9R27eCH4T+W+LJoirORzl/UzjWk1qpizpJba3ceYL+Q37fR0qzsEsO/pP5gDTSweHG6Fy1uhs+g3u7Hh0vHsjdSQiwbPY+5KGKdELD/pPLC8nTa5586F3oP2ARv4a/wqJwnbKqiC/2IUnmQk0CoAdk45MQcP+EZ00DDH5t+twTPO3CMXJLG3WhQBdasoEP2pVX1w4cgC27DedWgx72kf0hYQzth1QVUiTwPsGBK9roIwtme5ILxLx0tbOHVKw+FAp+z9+5mpGDzvstuadrD+VZOm+7K6xdyzJ+q1b1wECpGasoTe0Adq6bc3YQWKhFMtwBBdE44RKTcrs4LOFJJ5zN9HAZ84GcJKvQeFYn55WpPVaJ1jKSIUZoe4zopXdFx5a0D3qH6MnhwClWR9udX57yKBzgF1hXm/y+rV3dZUGGo6KkNLB4RVySOCjr2saepdA290mPlkwtp1AA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(7696005)(6506007)(9686003)(54906003)(122000001)(26005)(186003)(44832011)(53546011)(55016003)(52536014)(76116006)(64756008)(66556008)(4326008)(110136005)(8936002)(66946007)(316002)(8676002)(66476007)(33656002)(66446008)(5660300002)(2906002)(71200400001)(508600001)(83380400001)(38070700005)(38100700002)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A3iBvLhkijS6s0mv1OxRBxyoaKlrpe21dHVclyyJazZlkGZa6YtgKb6MMNS+?=
 =?us-ascii?Q?z/wr8QKxO5zy16WQp4WjniZ8zoA83Ps1G3AIgV88cwycx1qmL9Rk74Orf27Z?=
 =?us-ascii?Q?FcXWoHDxBMYfbE4BIHSRTXqZI6Q8ZPe/mXr3E5W7qlV3oTqbY6oAd9wVVwJ0?=
 =?us-ascii?Q?s1Btu1YXj5KqhLhG8qzOBwO8PvhKonkKycJEPezmdRslbo+ExF7IbhQO468F?=
 =?us-ascii?Q?9ZlXbNX96CzZ8GXiTUsm2bNlAzHIlOdRr0gdh0UX6JdCfu/QUtwqyMUefhDf?=
 =?us-ascii?Q?1ACXG5KFiQD5ZxriB52HZujmYiRqHtAutUH/Nbf+5T8NomNCd8fQIZMd5v5J?=
 =?us-ascii?Q?vH1t7QI+IuVFDtLiwjn4iN6H+NIUd6Gn7v/z18PosIwyjiMQ8qGVz2SmRm3S?=
 =?us-ascii?Q?Q8jMMEjuh0mdUlwARe1pQsbnWf4mfryONYPU1rU6wRsm/7J27ZRuu+efMqXp?=
 =?us-ascii?Q?CRTiDWMTeMtHtssSeRc0A+7WAdLCsb9lPbo1miw8IRnfd813xngMbwJqcd8l?=
 =?us-ascii?Q?+eiWh9lxrrfNzn0lwTd6sfZfWmXWTdCEEUCn0SHi3+HgOwWXHPBDDjGxQASe?=
 =?us-ascii?Q?OKmnTJlRc8vjPPFk+sCFy31LAB8Nfu972q968i+pNSmbyzQNgDmFEPv0ogNQ?=
 =?us-ascii?Q?P1FF+tpEJo801G6xTVy8m1tVxlm2wUM2bbCBs5N9/woFBqPHTHjxa0NtYZ/E?=
 =?us-ascii?Q?nRa0UKMI9jaANpcOliXGI+W6dcCZLPrePxzlVyfE4E3TU9D+5Kwi8jb+8WNB?=
 =?us-ascii?Q?/QCa0dNRTkdDajQN+Q9Y9HI6TVNpGh8t64/zD/hJrHq5t07onQGoZvC2aO9+?=
 =?us-ascii?Q?If7jIioh6M7m8Pk5w9MbWeYVLmi7H9eluNFYElKGkLVNyjo6x+aCqr8JFf/+?=
 =?us-ascii?Q?IgE0faiOKWIT5e7jwhis+kuMQPzdPcopyy66EB2Stwpx1sKtwmPD7uXD+bs2?=
 =?us-ascii?Q?bL74hQD8b5wc7WDCaEqd9duVvyr2gw+cCFaddCPnm/NirhAKkvjHI7oq9tXF?=
 =?us-ascii?Q?MTlPb7KRUKMAkaRxBVS7ukV5FI0HuTuvKiIrtoqCL/h4b667L8iZwQ4XLVzH?=
 =?us-ascii?Q?ughi09diEM5zlOTVfvj00S32g9RlqvjmydCSjYRlT99gaXA66/lTAcHW4o/x?=
 =?us-ascii?Q?BMMNfoESSm6AtwYp9jTtWTFCFq2IoATv+30FTftbLOuZlTOqOrBL/EE4GMbv?=
 =?us-ascii?Q?t9T/ruBn9lvhmenwCh4sCURhJKbHgvxRf64mnD/Q+l+j8QfM6sHd73mlYlrx?=
 =?us-ascii?Q?eEbhMyzsH1WtEKhAhJ5OgKfsbSDFYhyVeundRaMF9vl4UeAbaIG+AMANfdlq?=
 =?us-ascii?Q?SsnfGmS+uqXH6Fd+e7hmg89vUbQQS9a3iVBTI1V5vI6ub6KQNDIrtK3f3Hyk?=
 =?us-ascii?Q?jlPHDP7GQvtPrX7akGzHVuW8fSiK4RTK/bHbPNzK4E8p1e5hUx7cDQxuIsgl?=
 =?us-ascii?Q?upntJIFp2gWvQ0hOn6CRzTVOOzC7TSXOHyxp1wYvF1YSWfrFIhUgX+jZiXag?=
 =?us-ascii?Q?TIa82Lr1jGhxhggq9zK2MQnKRuaUXrQb6XJf1mnpyNjgaWJbRuHe9S2NuCtp?=
 =?us-ascii?Q?HOD4vWEccHwwl81iOwtGjxa1gAt+XnMnwvINp6Cc9evg1lzIJaMu+4i3SoWJ?=
 =?us-ascii?Q?RQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d0162e-02c8-4b94-7ad7-08da00ea3577
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2022 09:58:34.4935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Y7B51FtSDG+gNJntDooB5dr68ftLT13L1T1uHHnyScL2ropUzzBD4f83VnMJvZDW4osHRgkN/FFnvTaqi47dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5568
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
> From: Stephen Rothwell [mailto:sfr@canb.auug.org.au]
> Sent: Tuesday, March 8, 2022 4:15 PM
> To: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>; Ming Qian <ming.qian@nxp.com=
>;
> Shijie Qin <shijie.qin@nxp.com>; Eagle Zhou <eagle.zhou@nxp.com>; Linux
> Kernel Mailing List <linux-kernel@vger.kernel.org>; Linux Next Mailing Li=
st
> <linux-next@vger.kernel.org>
> Subject: [EXT] linux-next: build warnings after merge of the v4l-dvb-next=
 tree
>=20
> Hi all,
>=20
> After merging the v4l-dvb-next tree, today's linux-next build
> (htmldocs) produced these warnings:
>=20
> Documentation/output/videodev2.h.rst:6: WARNING: undefined label:
> v4l2-pix-fmt-nv12m-8l128
> Documentation/output/videodev2.h.rst:6: WARNING: undefined label:
> v4l2-pix-fmt-nv12m-10be-8l128
> Documentation/output/videodev2.h.rst:6: WARNING: undefined label:
> v4l2-pix-fmt-mm21
>=20
> Introduced by commit
>=20
>   72a74c8f0a0d ("media: add nv12m_8l128 and nv12m_10be_8l128 video
> format.")

I define the label using underline, not dash, it's my mistake.
I'll send a patch to fix it.

>=20
> --
> Cheers,
> Stephen Rothwell
