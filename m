Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD8A575E59
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 11:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiGOJSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 05:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbiGOJSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 05:18:35 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60071.outbound.protection.outlook.com [40.107.6.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65959311;
        Fri, 15 Jul 2022 02:18:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBpvuyNHQMFFMYqCZz45cQUD7ujJsI6dn3x4+RauYa3PDCBnPupp76cOn5hahx6uPMSg0rqVzBBzjqjkfg1yFzZGg9yHnRFjq3YublCvsa8IZGBFAspfEouIcS6hFgWP4bEZdYZzKkAaF/PmkWYg5QncmPSYzgHykduDFBvCvCBGFmm9jRzR/is2s0XAg7RCGnfxDEZpbsHdx6e3cttvZmAlA0jzx3aI/1ITixPjNrn1DqbxFzk1QbRfrQcaZOFluYZdvW7nv+BZxZAGwXIAiEZgeDYU1SGaw/y78e8chQyAiL4E5j1D/2FQ+BK+ctlPhnjqHgkqTDACAteTy8B2tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCwXqJ/WuZb99GsovQBE6L0tF6GcBGTEg5s3MrlZIkM=;
 b=Bmm0QQWVJRvNpl99H3DAJkRwaC/6O3eWNoIgS2G/TSrUvdae1hM/OtgyDbpY7YIy0JTAPv4aRsmzAguwDLacQolE1iBW3oCu1n7KMTGt7O7Md0JIEIPyLfnAloJvElKh1eKHWI8PoIb5trsbA0xujm1hZpdjFuaFh3qVRgPzu/43fsW7z06B2SKWVi6PtYr+pq1SRlkh/ku6Whn9xPDxPIRWPWtaqI6KqtrCZxnYwXYf4t+YpGCePH9doxO+C0oCmVQjWkpAbsCBhYb0tlp9F9g4Gq0snb8XabxGwP07ukRih2Jn0JtEkqqIbpVGS4nfHOBxEs1k6CyBZ2M7toAMcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCwXqJ/WuZb99GsovQBE6L0tF6GcBGTEg5s3MrlZIkM=;
 b=jHim4oJnZX/jMEbbQ07JgKZ5c1a588Sl5ERIj468B8iia2hONfYyCz7PGMd1O+OyNKT5di1VC2nJoIvDCBRsV5efgLhEhfxdxH53e3tvMrGegL4Y9TGSC3WnA2GErcwaratsx50dynFGtkFve91mU8ZC6rQ2VU1/+lbR1LZPDCA=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by PAXPR04MB8096.eurprd04.prod.outlook.com (2603:10a6:102:1c7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Fri, 15 Jul
 2022 09:18:31 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3cec:d61:3836:2826]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3cec:d61:3836:2826%5]) with mapi id 15.20.5438.017; Fri, 15 Jul 2022
 09:18:31 +0000
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
Thread-Index: AQHYl/cqr4tzMlicFUS5QAVEdKaVoa1+/W8AgAAE7pCAAAp2gIAAEHKQ
Date:   Fri, 15 Jul 2022 09:18:31 +0000
Message-ID: <AS8PR04MB8404B8E3EB0FFCEE8ADDA283928B9@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20220715025944.11076-1-sherry.sun@nxp.com>
 <20220715025944.11076-3-sherry.sun@nxp.com>
 <509669b26b5899088e9b77ed94d103ee@walle.cc>
 <AS8PR04MB840448675E64E4FCDEEF91A1928B9@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <e2560f01fd1731ea2422d82c97efcc6f@walle.cc>
In-Reply-To: <e2560f01fd1731ea2422d82c97efcc6f@walle.cc>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9b57fe0-e96a-4e95-6f9c-08da6642fc3c
x-ms-traffictypediagnostic: PAXPR04MB8096:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tSD1iS5Ex0XDrBno/8JOWCE6o5nuyoXQsZzpUxSblQyUfVwyx8Ckxd2Oof/uUDbhErOl2sj01ZtSg/xAu4yg+DO2CA1D4RMqCcglIQ8VQLOenLGxpdSTBlhxDzJ+lT7PjNu6jYl4MD1+QMHAeYN7heE5YKSCgAc96sUZ83+iXgt7hI5NUzfzxB+rLQWOXwvO4HKuabRxwve/9kmR8oEzVwc7T/LMDcBvzdkxps0xWAmRXVnEKIydyUXPfwKHkl45aGJ5qL9gnuXAA3zMF1WJmu8hdXR9bec6z4tM4ijSidSPPvFUgyMQ13knsaQvFF1CQ12+J82iwkGUipDQ+T1kEg9zUSe0vdS9yhyzYeUOeLh7JFIxfoUB+XYj9Z/IA20dhLDufMNNtB0KVh6eh7Z7saU6peDXUseEqnXy7e1P+w3X2hNaS1uuz9FmvtO1kPtOJb7xM6frbMNJC8K9uPlMebqz9OKcLJ2nzdRuQ8HzeibZ8OOZxDmsmuHckHw2s2mY/wF5YQq5il70fWtuhif3ADVZ4nPQYKg/tCqxs1hzNQ2qnCSjU6OTVgxgigElhjKbmMYAIaK14ENe3zCs1huppqtZgMkzen1sKPUrS39svyfnZZGuF1RwJUHIKECkmvEeBo6uefrlIiuVzbBtF7BEly3ChcdRSWMwN8ev1YEt0lJHP5YfWoV3/tnX4cJqQzU2kMGi0ev1x8x2rSOZrJ2lSRN1hG0z/9kf+08jXB+x5SuNJvNqVGaVADpgWVe1v8Ra1F8KW0qHjngU9HiFEW9SdTGqGzNRU1EOyf0oQ2loe5+hdysVEKnlYf3An3lX9UTA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(4326008)(5660300002)(186003)(8936002)(66946007)(26005)(41300700001)(52536014)(38100700002)(7696005)(66476007)(478600001)(38070700005)(64756008)(83380400001)(66556008)(33656002)(86362001)(76116006)(316002)(66446008)(9686003)(6916009)(6506007)(54906003)(8676002)(55016003)(44832011)(122000001)(71200400001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZPM0lffiJ56UB7uAhrWJNlGd9d99GG09n+IrmArnF9j0ujhvU4jAeWvPmKFU?=
 =?us-ascii?Q?1K2IYag+sh1ttrFxxJ8PCyujfgN+Pl19xfLU2GTfNOT12I+OcxA1vgjZAFDu?=
 =?us-ascii?Q?mIxW2V2C7/va3JgAS7vPgKBedgjFjmVbJHvxwMKvfo6+xrlw86nOsHPjCZww?=
 =?us-ascii?Q?c4yYZODI6Y0Fp4cIxEF7TRW3VlRu03MZz1sD668gOggBNDsKywAJyjIl2orL?=
 =?us-ascii?Q?K+XIzbxM6Op1+6LdEMsz7Kw6yxmVWPcMJgRS+FPS7ztptXFrnHtGx0Q7znpl?=
 =?us-ascii?Q?M1Yd7DU5dsVfqM7k7EjRYwNkotxmEwm7dRNzYm2/iN64vqemCpgWehwm4MIX?=
 =?us-ascii?Q?AWIPfCq9HXddd/ca4YIpJu5lG7kWfuGlvsjrNqM9Z222jMjcbSmK6t+OmGZQ?=
 =?us-ascii?Q?E7NLicH1pTYXOj2ManRhU8MQpTnaN+Os5Ukb83dTubq2pfRNiGjCern2AlMZ?=
 =?us-ascii?Q?eAq8QnoHMViSG7J9bejcCFAFY1IHb8wo6Do5Qcr0pvvxcestoPQWyG0X68Da?=
 =?us-ascii?Q?5IKBWdbH0XJw247+8BcYf3jG6RmDg2NQ+qszaz9H86uP1tdtxk6rZIFQ/Io9?=
 =?us-ascii?Q?5AhtXct+ltjzmiwjvUNDs5hybk+e4TV18gT7teSdnquls4NeYeYI3HLtdWpk?=
 =?us-ascii?Q?DpEmuSVOh4JW7uK9GUFfKPWNEjTb8vZrXzVGN50+L6pUN/eSBmqOmuoeADlN?=
 =?us-ascii?Q?Xklw+xpQVFx5TLSuYXSirAa4vAiYAGexkuVprVddPMWirlR2m5bWHFw+kXMu?=
 =?us-ascii?Q?1w8FVsPghsrQOk9eOFklRGY7Tdgt9SsPEksNvMQ4cp5h6Qe117AeWrszodFQ?=
 =?us-ascii?Q?epWOgffr+s1YWs0wICiqfAjInyLnwTTF97DuwAke9mWmMTvreAFfEfH3ZUXa?=
 =?us-ascii?Q?8cQ2MsQu47GGo9f7ZH8DFH1oA2NSTe51zS3d2o/dvkHYsJohfy0ynBQlfPtj?=
 =?us-ascii?Q?BeVcPD95rYwRdY3NihIgttomI7l+Pef3X2mqQVcRGTf1wRRCvBJaAlte8195?=
 =?us-ascii?Q?EogHZA3PtvxXjnzC+uTSeWLVWV9uwHCZ549vEYIHgevfZUUHVYY/yyVHkpzU?=
 =?us-ascii?Q?4MVn64FAFqqjnnNgbszYSxnCYRG/6Yxg8DcF8R3fdcUOju1Ze8wxCTOe8KDE?=
 =?us-ascii?Q?uOjvlpppho/A1M/6AiidUdmLL4CWLsPxp2Q4Lu1n6s9e3g8VGu8TOG+Ko6pd?=
 =?us-ascii?Q?an/FXyKor0fHvjMyodnVsg4CM70Q7HKSNfg130qyWAL8LFeI1LXNgJb1btie?=
 =?us-ascii?Q?M1liJXsNe0dRL6quEcYcW2uaZItWYKvYy15j7tnPcN/pkcMtQAC4RqkdJ5Qm?=
 =?us-ascii?Q?RdzHLdpPy9EykT7vL/9MiJOblj5j8unj1yGzeBz49nyxL/7JtrE9DyhcxwyY?=
 =?us-ascii?Q?fngP4IiElHA7zqebU8E8z4CV//63rtLAM6Br3DSZ2uPJJZW1LOuVNZc/hiz7?=
 =?us-ascii?Q?p6b6eVfwBECEyexdGfZlAUfLBCNURD1xwsiO0K7UeINHm7TW9GXyEb82cbUo?=
 =?us-ascii?Q?zr4slrbUUdrH1o9rE1pvrzOO4u3LeA95GpxfpaVZhpyw2uL5qt6QoitHBsHO?=
 =?us-ascii?Q?MYn5BuYvqxRCq2aUSTth5OcI+vLndL5lbpGsdvlH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b57fe0-e96a-4e95-6f9c-08da6642fc3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 09:18:31.1884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J+OvSNk5Hjxi8X2nm6qFebN4GGIdl13rdi7hA1nar8ewAUwcY5PWQIzSngiihkqFr7XZfFagvbQVGwMgZknusg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8096
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
> Am 2022-07-15 09:20, schrieb Sherry Sun:
> >> Subject: Re: [PATCH 2/2] tty: serial: fsl_lpuart: writing a 1 and
> >> then a 0 to trigger a break character
> >>
> >> Hi,
> >>
> >> Am 2022-07-15 04:59, schrieb Sherry Sun:
> >> > According to the lpuart reference manual, need to writing a 1 and
> >> > then a
> >> > 0 to the UARTCTRL_SBK field queues a break character in the
> >> > transmit data stream. Only writing a 1 cannot trigger the break
> >> > character, so fix it.
> >>
> >> I don't think this is correct. The tty core will already call this:
> >>    .break_ctl(port, 1)
> >>    usleep()
> >>    .break_ctl(port, 0)
> >>
> >> So you'll have your 1->0 transition.
> >>
> >> My RM from the LS1028A says the following:
> >>
> >> | Writing a 1 and then a 0 to SBK queues a break character in the
> >> | transmit data stream. Additional break characters of 10 to 13, or
> >> | 13 to 16 if LPUART_STATBRK13] is set, bit times of logic 0 are
> >> | queued
> >> as
> >> | long as SBK is set. Depending on the timing of the set and clear of
> >> | SBK relative to the information currently being transmitted, a
> >> second
> >> | break character may be queued before software clears SBK.
> >>
> >> To me it seems that setting the SBK bit just pulls the TX line low
> >> and releasing it will return to normal transmitter mode.
> >>
> >
> > Hi Michael,
> >
> > Actually set break_ctl(tty, -1) then break_ctl(tty, 0) is only done in
> > the send_break() function.
> > If we call TIOCSBRK from user space, it will only set break_ctl(tty,
> > -1) without break_ctl(tty, 0).
>=20
> That is expected. no? There is also the TIOCCBRK which will clear the
> break. TIOCSBRK will just turn the break on.
>=20
> I'm not sure if the break is already transmitted when the SBK bit
> is set, though. Is that your problem here? I'd need to check that
> on the real hardware.
>=20

Hi Michael,

Seems we have the different understanding of the break_ctl(port,ctl) callba=
ck. The original break_ctl(tty,-1) in lpuart will not send the break signal=
 until we call break_ctl(tty,0). Per my understanding of "If ctl is nonzero=
, the break signal should be transmitted", call break_ctl(tty,-1) is enough=
 the send one break signal, now my patch makes the behavior align with my u=
nderstanding.=20

And my understanding of break_ctl(tty,0) is that it will terminate the brea=
k signal send requirement which has not been done instead of cooperate with=
 break_ctl(tty,-1) to finish one break character send behavior.

   | break_ctl(port,ctl)
   | Control the transmission of a break signal.  If ctl is
   | nonzero, the break signal should be transmitted.  The signal
   | should be terminated when another call is made with a zero
   | ctl.

Best regards
Sherry


> > And from the definition of .break_ctl(port,ctl), the callback is used
> > to Control the transmission of a break
> > signal(Documentation/driver-api/serial/driver.rst), if ctl is nonzero,
> > it should queues a break character. I don't think it is reasonable to
> > call break_ctl() twice in order to send one break signal.
>=20
> Maybe Gred can correct me, but to me it seems like the .break_ctl()
> will set the *state* according to the argument, that is either
> turning it on or turning it off (Except if TTY_DRIVER_HARDWARE_BREAK
> is set, but that doesn't seem to be supported by the ioctl interface.)
>=20
> > Also I have tried other uart IP, such as drivers/tty/serial/imx.c, it
> > also queues a break character if we call break_ctl() once. So I
> > believe the break_ctl() in lpuart driver should be fixed.
>=20
> -michael
