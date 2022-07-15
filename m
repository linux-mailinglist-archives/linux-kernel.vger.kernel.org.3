Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550CA575C3C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 09:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbiGOHU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 03:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiGOHUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 03:20:23 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50082.outbound.protection.outlook.com [40.107.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13367479D;
        Fri, 15 Jul 2022 00:20:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8dgnELEkopS8QaA+Mvz0DzkE86Q7FlZAP66EnHQTXn5s5tsW4lOxdlERjNd3Jd3VK9nJuOgu0yXgcNNzpjhT1pJMQ4+rnPJ42w70on9WDDf4j3B7/M6JeRLyzscqtrC6tE3W2zW+bd6ZegoxYF29bKu3xW0s8+4ZWZ5Obl7cVi4095BSJxSD0n4JRIEYB3PB7MEpdz97bNcsuVwJv+i7UiovNLR6QDhGUmsOF7pjZPgZJtPAPby3lKwPqg7PKXfwojnLDREelYXj3jgudWDf5KspRtKaJckuNxyvcCYCG/qt2UD3GoLjxavYeoOIIPbKAVFlzeE71HLG/FK7AOB0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVFtKtq+LHsz5NVwZmbHaVgVVm5MWxlfeLMyrtf87IM=;
 b=ZzmPa0ELwBrhw9YhAsnmqOqTzaSXyIo5e8TIxTnvDfspg06ftWgFKuSodE75rhuAuHfyciyMD0wF06izCCklQ0wc43g9ObbPRmEp2y1B4k2VuF9D7QgZkao6CDoysjwm6vwK9x5Yl5ikqVEs3B4a4z4WYKmOBJwmiQaY3FT5tETLVnCn7KkHppEPVJh9aq2QMwQnDVlQ/8yoKp2l/CZ+7xNdgJNal5CrFXkSeRldRL3/MyGFi62QuO0CS/M17eOitJRB5TWPrGhShu88rAXegZHv55bEXa+KuBzhm5vecWg823x4dijl2QlmvtHYlhs7oRMrPYg4yg1b6iC+EL1V9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVFtKtq+LHsz5NVwZmbHaVgVVm5MWxlfeLMyrtf87IM=;
 b=YmLXs6eENPTC3Q0Khga4jowsGB/q/0xwAXcGszhy4OpP5SH6sf0RprGaDdDtPLnbjmmRjC/f+iaBLxudB0V82QRJ+jnmMlleIrSrp50v1WW1ECoUpZwEz9rDulluKKSHYXi755fvyfzbsajNe01XZq+axNYay4x0aGsiL+Vuk18=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by PAXPR04MB8208.eurprd04.prod.outlook.com (2603:10a6:102:1c7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Fri, 15 Jul
 2022 07:20:16 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3cec:d61:3836:2826]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3cec:d61:3836:2826%5]) with mapi id 15.20.5438.017; Fri, 15 Jul 2022
 07:20:16 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Michael Walle <michael@walle.cc>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/2] tty: serial: fsl_lpuart: writing a 1 and then a 0 to
 trigger a break character
Thread-Topic: [PATCH 2/2] tty: serial: fsl_lpuart: writing a 1 and then a 0 to
 trigger a break character
Thread-Index: AQHYl/cqr4tzMlicFUS5QAVEdKaVoa1+/W8AgAAE7pA=
Date:   Fri, 15 Jul 2022 07:20:16 +0000
Message-ID: <AS8PR04MB840448675E64E4FCDEEF91A1928B9@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20220715025944.11076-1-sherry.sun@nxp.com>
 <20220715025944.11076-3-sherry.sun@nxp.com>
 <509669b26b5899088e9b77ed94d103ee@walle.cc>
In-Reply-To: <509669b26b5899088e9b77ed94d103ee@walle.cc>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6f75b81-0bab-4aec-aa34-08da66327751
x-ms-traffictypediagnostic: PAXPR04MB8208:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h/bq8oc/8Mua7xpkJHzNiF1EpivAOyT2ryPhnyv8UdpPjUzKcUn9PTeFqSuBfQJxpdlBrbjsiHbtVeiCf+MjQnoDEDSU/9C570qsZOtkt6+/YmQ5vHa9vqMeA9QNKXRaJJlnb8mjEzjrgg8qmiT6dx+0Nhpzu/3WFeyubQ6Zk5LYwSuYFdnODQrq2mjfYlt16WdeUxT/q86RhhoAIaEbDuPEajt9GLiaolrcu50BtUTCv3v/2i6sWTC1e0pVQwYuQha5wUsDhEwWF9xTK2wEOIceGXgRvuqIqUm23O96byCg92zGFMUbeuXc7c2PeFgxxJRW048+1vvIEzVxoylqzTTvpzs7Tteb1F2ouQaZTihmS3NOXJr+MyrbVBNP1oNYNcT8kBuZ75ZCTR3YJUHr0Ts6CnhksGPZHyqPV+KiH4Ly6a7en9ToqeWhJhsnJ57SpvfjbJWY2vdZ2wo0i/+7anTjP7tVvXExAdrK6DJ23bSUEK+g1YOPI242VprzAteiigYrmqm49GXAclzjHI5r+H6i8I5VnxEfg6+hwtMgJtvHJODrJhALmWOgjo/jNnkQiA3oeA9WZjmkX/SAuge0dKDhpF484GsBukak0Wp5nGboGfoUVU9dPR9e9wAWhnswd5cVYaeR+eQJylEckn+yYqg11kRf/Q3l9l8bvCND2eu9cnBcOezLTwTPvDQRmTlyF3tqw3WPC9pby6Wm4WGg55FGTLUekoQ6MedpyyYvBW6AEfwnhT4aZxil6o3ZvsKvC70Bf0sAdwdz4iuUXPqONmwE/c5cWCPPl37DSA9cGdPuh+qff77cd5+ND1pLP7OW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(66946007)(86362001)(33656002)(52536014)(26005)(71200400001)(9686003)(55016003)(66556008)(2906002)(41300700001)(66476007)(83380400001)(8936002)(186003)(54906003)(6506007)(478600001)(122000001)(6916009)(316002)(38100700002)(64756008)(76116006)(8676002)(66446008)(38070700005)(4326008)(5660300002)(7696005)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eaLkOvih/ZYhMVKXGeIIfffZ8Xt4v/RFWnPqd2FEUqKXLUP/92Fppgj8agRs?=
 =?us-ascii?Q?0Qc07XcNDVmQVDxpZgWSSojICxbMvAf1ITy3iVnscZ6BMwku+UKVaD2V+GML?=
 =?us-ascii?Q?iXzH8chWm4frBqBBHYrB7dK7G9hvwSPwNvEEdxbkcp2sUktByHd+Uf8cs7/E?=
 =?us-ascii?Q?uGnOxoGPBejUCytFz399xIzHd9RXUYHILsmIG455wKhWVP7JzxuhhCq5uRze?=
 =?us-ascii?Q?6xTIFbPyWC96zW/9u1QVUlO3M7HepsumtT+Civcgxltpa7aV2COyzNyqS0Hu?=
 =?us-ascii?Q?o/GjPzK+1q5Z1zbsh1IEDg18NgQPSsyCfrjjPrhIyeVTVk8GAlQPVlrcJmYV?=
 =?us-ascii?Q?Mve+N8M3F5lsaA8/E+HnkvRV2ZC3lG5WFH+uXC16EjN0qgkJrsDr7c11iww4?=
 =?us-ascii?Q?tqZL+wZxouJKK+ouq0ZD7Nu8FgdsgTG8uNI1szXPGIDFcGDrmx4w0knhV6tN?=
 =?us-ascii?Q?vuwX+VSxfeiq6GETSrRBVZBpmhfYb4W2P8R0iIQis6XE6mXI8vLnxBljORL7?=
 =?us-ascii?Q?FAVrRaRs8+/Ir9o+nBgGd/uFDqUO6cG1LWIEbrEDWbHM3gGa2lOgLHSIY7UQ?=
 =?us-ascii?Q?GVXP1OU9PrY0dXt4SAX7TrzQ3Jf55s36s3PaTCdt/m7IQBMp/f7EP9C5cD5g?=
 =?us-ascii?Q?z8ldubLO76immsUN4LQ/Qj67jFn42LPVcO6S3FBDgdO54/6aqTQAhAr2S8+/?=
 =?us-ascii?Q?tSsFNy570h5DInQ6+CUkC0qY7Pk9OUEBI366psW6EVtmFBLjV+JiW9OtfNen?=
 =?us-ascii?Q?yxedpWEC4pmxqhfoOBv4+yjF7e827egzmIh+6xM0OU0wML/NWR7dYGR1NW3R?=
 =?us-ascii?Q?BdYIT8A6kOhH1jAiioH4oHw1EyyFxmPGXDCFfoo9BwnsAoti5izSJBcgCTNX?=
 =?us-ascii?Q?Jk2A3qKPy/30H/yS5FlOtbtCJzrMD7AjZgQvUMJYKrMxLHgjkVxZxNANIu2h?=
 =?us-ascii?Q?jaddOzszilgavWvxHQHNeonfTfWhcggA5fFKmtrWsOksjkqFo+dEecwEukul?=
 =?us-ascii?Q?EVAX0Dl7yafG1TQlJ+ACEMH3nwpyJ3DeKDZyYRNU148ua1+YL4+LB7GT6Pxl?=
 =?us-ascii?Q?vS9yYKk6AStUbwy73MsGb75EHUB9bAmdfkY61fUmttgV2rl6ggomJdQnN6DZ?=
 =?us-ascii?Q?6R8WdkBjFql3egEUQT7wfd7gE/VWj8WkLRIB9ZKmG7LU/o8owrLmJBHCzgNF?=
 =?us-ascii?Q?ABiQ3hG07lcCIHg5crEU0fLvP0on8Y6u/3CKrVcgNDOSPZyn8pCwp6DONq07?=
 =?us-ascii?Q?IhkxPPFfVuvGifikKpZ31MIYAtiw7Xwp8yCpwLHjmRJj4i1UymK7gSgZDe/o?=
 =?us-ascii?Q?D654em6yP/2mY2RLYJ3wPq2VkSEC6O0UszIhROLwfhbZwno7Inn4z12Vo1jR?=
 =?us-ascii?Q?X5zJOBiMOdyjoTXmoQuB6HG27egL23i7BCTFxg+0aHAJqplI5R25GTwdBAxq?=
 =?us-ascii?Q?bTmPo0St0MevPSluJOBgV3M0/i8vSggq+mAZXcr6KxeLlOcoz0N54I6/JQdZ?=
 =?us-ascii?Q?elAFL4QW1h1CzILcKglHVqBQ3+CmxGT5II2vopWT639SThcfw8VYLp9FdoyO?=
 =?us-ascii?Q?J67ciS+pDiuk2fq5Hf+tCVv7kru9gxOkLnsi/fOh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f75b81-0bab-4aec-aa34-08da66327751
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 07:20:16.2272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P1n6Aw20O0OgeV5EIvh/amphCk2cPLClx1K/OFOJLWSXtMwMZUKTXEpQs6xPAyFgGGBNCpQ3AcOFphzjzxlmeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8208
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 2/2] tty: serial: fsl_lpuart: writing a 1 and then a =
0 to
> trigger a break character
>=20
> Hi,
>=20
> Am 2022-07-15 04:59, schrieb Sherry Sun:
> > According to the lpuart reference manual, need to writing a 1 and then
> > a
> > 0 to the UARTCTRL_SBK field queues a break character in the transmit
> > data stream. Only writing a 1 cannot trigger the break character, so
> > fix it.
>=20
> I don't think this is correct. The tty core will already call this:
>    .break_ctl(port, 1)
>    usleep()
>    .break_ctl(port, 0)
>=20
> So you'll have your 1->0 transition.
>=20
> My RM from the LS1028A says the following:
>=20
> | Writing a 1 and then a 0 to SBK queues a break character in the
> | transmit data stream. Additional break characters of 10 to 13, or 13
> | to 16 if LPUART_STATBRK13] is set, bit times of logic 0 are queued as
> | long as SBK is set. Depending on the timing of the set and clear of
> | SBK relative to the information currently being transmitted, a second
> | break character may be queued before software clears SBK.
>=20
> To me it seems that setting the SBK bit just pulls the TX line low and re=
leasing
> it will return to normal transmitter mode.
>

Hi Michael,

Actually set break_ctl(tty, -1) then break_ctl(tty, 0) is only done in the =
send_break() function.
If we call TIOCSBRK from user space, it will only set break_ctl(tty, -1) wi=
thout break_ctl(tty, 0).

And from the definition of .break_ctl(port,ctl), the callback is used to Co=
ntrol the transmission of a break signal(Documentation/driver-api/serial/dr=
iver.rst), if ctl is nonzero, it should queues a break character. I don't t=
hink it is reasonable to call break_ctl() twice in order to send one break =
signal.

Also I have tried other uart IP, such as drivers/tty/serial/imx.c, it also =
queues a break character if we call break_ctl() once. So I believe the brea=
k_ctl() in lpuart driver should be fixed.

Best regards
Sherry
