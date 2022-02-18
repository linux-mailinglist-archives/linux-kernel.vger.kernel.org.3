Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB7E4BB17A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 06:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiBRFfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 00:35:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiBRFfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 00:35:13 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2121.outbound.protection.outlook.com [40.107.21.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E076819E0A0;
        Thu, 17 Feb 2022 21:34:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7zo9GNnfF0zk1VonjXT7hw3RR0VcBGzAJQRhTKkW5QdpCP/9Y74/6TT0LHAWzSArCEo7taPxcY4AECY13mIrXdFg1vxihy3fMqWlFHrr+YbVcKQVNr5n7d81fns/P7o6AKwcKzbc25j89SERw0CeJoZG4eQgLFb504FqQTOF/uNAlKzjXZfvAw04TVBoi6ScgkeACcnphwyo6pgZFrCLMzBdTVFejLyyrz8lvyd6m64Y/rfZkQhXdT8wPwY6gYq7vQIWIBZp159I+wsilXcOFDMjhFdCz+6vwXjvXTD6pPyrFdLQkf2tl923LQGOamweu0d0OO1wWijybWPlZ9pgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgM30240XNSxlIR4qK/1WzuseiUtWt8wAiYUtTQRSt8=;
 b=PEkrGR5zlCPfGfGgpZgjwdLhcXvvAwnPdeNXDD2JqfO72uxg4ft8r4FMNfETcEueos0r2hY5xVSlUsBjH1N0h+RFlV7bM7W5JyEE9r3LJT3guj2wt4WVN4+gDwglk+AEPVj3zs//sLY0FslOn/EqoUh4g2sS+johyiMwr1UHYwpMdznN3LFT9rjdPprwT8orj64kBRX+nVk4oKVQf0X7Ow8wGDoJnLmvIVZeP41pg8gxcrxtbjH0wvh/xi+1QAL1B09UthTz8BZVyqFS3aFsNfVMrUxr/p3JA7prXZnfTOPgazwTxXGQBqBYLys8Jp9gbL/Rk6DwwGsEp28GdJP07g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass action=none
 header.from=leica-geosystems.com.cn; dkim=pass
 header.d=leica-geosystems.com.cn; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgM30240XNSxlIR4qK/1WzuseiUtWt8wAiYUtTQRSt8=;
 b=MRJ2m7sqs97VQ36ngf6hqdyRLYVgcTrmBRQ///T2HYbWpcdYUcM7K2kCXtq0GUX/5ZhlGWmRUDv+3pj/nS51Uo5nFSQkoVmax9Q+3H7YWe7Gvq1lJN33U0k59Nsgo2LXLKZMmYn0Hwxji0+/NqCtrjRprH1my6wplos+QO6iJII=
Received: from AM9PR06MB7844.eurprd06.prod.outlook.com (2603:10a6:20b:3aa::24)
 by VI1PR0601MB2656.eurprd06.prod.outlook.com (2603:10a6:800:84::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 05:34:48 +0000
Received: from AM9PR06MB7844.eurprd06.prod.outlook.com
 ([fe80::49af:32ea:4fd0:4933]) by AM9PR06MB7844.eurprd06.prod.outlook.com
 ([fe80::49af:32ea:4fd0:4933%6]) with mapi id 15.20.4975.018; Fri, 18 Feb 2022
 05:34:48 +0000
From:   LI Qingwu <qing-wu.li@leica-geosystems.com.cn>
To:     Rob Herring <robh@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "tomas.melin@vaisala.com" <tomas.melin@vaisala.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        GEO-CHHER-bsp-development 
        <bsp-development.geo@leica-geosystems.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 1/5] dt-bindings: iio: accel: sca3300: Document
 murata,scl3300
Thread-Topic: [PATCH V2 1/5] dt-bindings: iio: accel: sca3300: Document
 murata,scl3300
Thread-Index: AQHYI8dlgBAnLkHEfkK43/i+MVs3uqyYXaSAgABs41A=
Date:   Fri, 18 Feb 2022 05:34:48 +0000
Message-ID: <AM9PR06MB78442036A5C52FCC5E248AD1D7379@AM9PR06MB7844.eurprd06.prod.outlook.com>
References: <20220217062705.2867149-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20220217062705.2867149-2-Qing-wu.Li@leica-geosystems.com.cn>
 <Yg7US2LIBFRWq4OA@robh.at.kernel.org>
In-Reply-To: <Yg7US2LIBFRWq4OA@robh.at.kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com.cn;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c99e337-77af-4c67-80d7-08d9f2a06127
x-ms-traffictypediagnostic: VI1PR0601MB2656:EE_
x-microsoft-antispam-prvs: <VI1PR0601MB2656BA64ECCF4943FA889C8CD7379@VI1PR0601MB2656.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m4zcyZFoBtw/PZFEepT/onGkoyiNO0t85f6iZwyrx+lpVav3vw7Y2nMEQ26EhAiTvBsGkC7Jwo0etIaJUMkXKYiodYh40L1BnZsNQX+ySLKuWIcJRas0w17xjgZRMXCF8ktTc800eAlG049XdB00HOsZBzPpQSmtqv7aUhQHm4iNHci9H469SUG8L+gVoE4Hfqfj5LCMkug6RKdxKHLpaCAJDPKF0LnlWhKwR5EC4P+Q8eRPQH+rCiSPzM8omBBHj8OuLIF2XVRaeJ6BkLWb56MDkXiJB7TY6jPYZToQvYPxPNpvVFgN+I47XbfIrdnfN3MQ3L1wcUZRpqB8PKShVro7AiNxjJMAl080nS2TgHiydXm+bEXLikEPB4+qgVKitriCfuuOHKClbY8BoJj4jrq3VfPhjGBC4kNjgsj+XSyyRf1nkfWP2qeApP/gi11cZ+A/uBvEjHsOS+0oiVdkz9QSQfVLz4dpu/ZTQZ+R3Paet+OtxvxJGl4zIbghLoNjaxqWfKejtiOGbtERmx0JIMwXxjAL5JKFU9mUisEjBbclspshu6H8WNMmfNVgxL3aBkl43KtjO8j/7uPrL3mw1W2D9budb8pt/B2aOp4daORa+jI+KxCrUDQyWkXnCQ9K9QHJ2oIylgmR11ClYVauzCAfEoI2VTz+JlH8Xc9iq7H1GGrJxPUjGW8KUJ6BaGwu5eO5Jl5lc4L6Pfhuvq1jJfUwS/fJ5TcZf65IXnFEX9KHdAUss8KOCtB+PNeY6b3W
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7844.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(38100700002)(122000001)(55016003)(38070700005)(9686003)(7696005)(54906003)(6916009)(6506007)(53546011)(966005)(508600001)(71200400001)(45080400002)(2906002)(64756008)(66446008)(86362001)(66556008)(66476007)(4326008)(8676002)(26005)(76116006)(8936002)(186003)(5660300002)(52536014)(66946007)(33656002)(316002)(10090945009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HnDqJvN7batKIjeG359IF0zVILOZrXLFj5agp87uU09AksMsSY3yAeGDu7Mf?=
 =?us-ascii?Q?lVns7WgMG8NdjqpRVBxxp6WENddMVm3FPI2HQIbLL1cC/YSHTodLDqOukjXW?=
 =?us-ascii?Q?27E0glPRs0m4OV5+VCleG16D5oOvFOeeAp/jy/iyrKCBiNwK/TengQ/M+JLb?=
 =?us-ascii?Q?meU2rinag5qdw9lAoo1LI2++Z23CePhylvIspCq6zeHN+PsB/4zfpjC39jua?=
 =?us-ascii?Q?ZpokWA5KJYBy+9ZrdRZbYCiDSMZdBKAeyeCuquPeXpkPcwSIY0GKs0vikofz?=
 =?us-ascii?Q?yd/RVuTGVbOotBAtgJmdu23sf1lo11Y1WZvUbqTABmplGFYQQd66M88LmdTI?=
 =?us-ascii?Q?Umii8QoC4KBRx1jdmZ97p2WF7ahqs/J7/6vrG2hCtohUGZNQjRosCcazQEPT?=
 =?us-ascii?Q?AlcoTHesFiQUfYnVz7szob32VpWPxS/mtZunUXQpgVsBEAhZDcMdqIr83SfH?=
 =?us-ascii?Q?8C4DkzhiyAycnJ3qLnJZD48/rS/8+l5KGcmnOi1qWBC3p7D9xfS133Xt6LUI?=
 =?us-ascii?Q?yTBsQZDSTVNvewOvXLQVrS/I4G4IcmrjDKuAYAvfdBvkJwYGEnHk6si6PPMR?=
 =?us-ascii?Q?pgv1k/nsSW0lYXBzOQFLof1xlvCCaNjrQjrSONA7DrxqzlgZpTsMg0ZX+mb+?=
 =?us-ascii?Q?zIt1hhc3uEyJgpgfOWbdN8vRGwt8lF00gT0rbTWRRu6OSJ4O1LtVyQOioqjX?=
 =?us-ascii?Q?n3CWiSl2jsFfK+2L6YuZeSmA2o+AiMLvBvkhLPdT3cR84nD0NVRRvbMw/72t?=
 =?us-ascii?Q?JWKO+BT0p9h32c2JBQYg986SSwTmAquZhYhj9+DjgHZuHguJCUEO1SwHyNLq?=
 =?us-ascii?Q?SHG1PyWKtkxhk3TMvB9svl7Yrtx0nEvMD6JDSCK5OruL4/k+m/MkSrYv22j8?=
 =?us-ascii?Q?IIK9wxo1cdWQO1flq6Pli1uOrZ9Lgmx+Rylr9KmAHLW650ktVupghw4e0yWO?=
 =?us-ascii?Q?dmgbxDwmJYfQvApw5zSlx+E6MS5e+yvBCOSIKgZXWbv5RhSpUGqN9uQWgoey?=
 =?us-ascii?Q?FhEbtiTogcriUATymf6W28PKxi6db7feuRWBgsWEawHYoatybvCo6U1XzRD9?=
 =?us-ascii?Q?Fs3OY1kp2tWW9UavpgBDmyWe/F1O3LcfvDM9Ci222Tua1Pd9sF3pkmK9wnfg?=
 =?us-ascii?Q?zoO0vAgONl4ay5Oqn3W+R5+bc4VSGt0CYkIAozpvtAVt88+LApFLLfRN9giF?=
 =?us-ascii?Q?D3cNqFPuCC5PWY2n6ySsAvTvJxcnAdyq/qpREXt0OINbEWs9izMeMrcS8OU9?=
 =?us-ascii?Q?EhX2qCDGrbU3RcwWe2yN3X0rlLNiJJvNcRRWUjxpA3i7t3/Eepn7XIO+M+wQ?=
 =?us-ascii?Q?trbijxpxLFImARhogGuhTTB/tdF3aRHGa/2Ix+yzrWVlcQ5bdCURBnYDlXTE?=
 =?us-ascii?Q?61a/fBetTZTsISspybt/buiZ8WWRgJtR0Pi7OQFtlq7o5/t9/xFklYoDj1dS?=
 =?us-ascii?Q?n7JI5BBVdzUzGOm1+uQUGEetewWw6K+HzHm3XJHMNtuoUMWp4IEkW/JQBFPd?=
 =?us-ascii?Q?nB5PJQCrrdvHvs0ZQWMmP4Ky6ZvgU8qTbXmN/lNz5s9sS9tJEQK1WXhXTL70?=
 =?us-ascii?Q?ST6phhsiIZn9Dz/y7V0J3QI+JIqbjJ4VOAqZiHBu1jSut1wReGIdwizuTSTI?=
 =?us-ascii?Q?gzAAEWO1+tsQoA4lpHjVT7keW5XC1h9cKvU7fo8vd8eqpdbMDbsjPnvKqYiA?=
 =?us-ascii?Q?HtkaNcbp3mPQGJxh6GOQZO5EnI0/IZjyx1hcjVgGM9VQowcMDvl0/SP4WVol?=
 =?us-ascii?Q?q0A65JctYA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7844.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c99e337-77af-4c67-80d7-08d9f2a06127
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 05:34:48.7522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zmEa97PIpWGy5AmQOm6xxNxjYIsGlTv6jldVGb4pwiWb3YbSaLVZsbWNYzTBxejIqWw9ycwAs0M+KIJzyvhnrcfP591lPuHJvncBC64d3LnmlQmavSv6HhEvF/hepVPL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0601MB2656
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hi Rob Herring




> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Friday, February 18, 2022 7:04 AM
> To: LI Qingwu <qing-wu.li@leica-geosystems.com.cn>
> Cc: robh+dt@kernel.org; devicetree@vger.kernel.org; linux-iio@vger.kernel=
.org;
> jic23@kernel.org; tomas.melin@vaisala.com; andy.shevchenko@gmail.com;
> lars@metafoo.de; GEO-CHHER-bsp-development
> <bsp-development.geo@leica-geosystems.com>; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH V2 1/5] dt-bindings: iio: accel: sca3300: Document
> murata,scl3300
>=20
> [Some people who received this message don't often get email from
> robh@kernel.org. Learn why this is important at
> http://aka.ms/LearnAboutSenderIdentification.]
>=20
> This email is not from Hexagon's Office 365 instance. Please be careful w=
hile
> clicking links, opening attachments, or replying to this email.
>=20
>=20
> On Thu, 17 Feb 2022 06:27:01 +0000, LI Qingwu wrote:
> > Add DT bindings for Murata scl3300 inclinometer.
> >
> > Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> > ---
> >  Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
>=20
>=20
> Please add Acked-by/Reviewed-by tags when posting new versions. However,.
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
>=20
> If a tag was not added on purpose, please state why and what changed.

Thanks, I will add in v3.

