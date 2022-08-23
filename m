Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B7D59D09C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 07:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240178AbiHWFiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 01:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235968AbiHWFiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 01:38:12 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140043.outbound.protection.outlook.com [40.107.14.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1E85E32D;
        Mon, 22 Aug 2022 22:38:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F20+y74AuPkqCGc84xRy2fc8DZ22cUijb1VvlWZhI7moGUgAAOdoHjIh0ACZb8rFAhqp+VfHlRlVWMPP+h88ZoccZym2TLUVIWVead81VfA9Xe5Nyvf2U/aWuq1/hTHOI6lD+09eS4+SVXqiUi13HQFKBqwgZmQlkRjuMphsFPUX1XnOQAhiASlNVpddWGFuBrSuv3WjlW2ryTU8j7I2JEJPkBfGwMqwSoq1Pf1kmIrfLcY38yK9oVm6+UeAKE6To7yBC6/sx0o7toshQngpakO9yBrFPnrN9u/YkKPwpak0aDilqhNaOPYoeckAmhEKfdmTiD7CkBO+vHm+Bo7qmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+5q3Psl0fZ38WkoLqBtI0mjTov9/Divm/MACjeck8A=;
 b=fU90qRF0CF+foWuy1qdGJq8CEeCzu8wsN+VbFC3XBlN14gqX+zqbP36ZCK0AnZRWSzWTvC+QgJsFua6WIZTc7800EjiE1JB0Kh4RKEzVG1Rilb+tfMZlaJk2VtcoUzOer46w0rT/37FU1aCrZQTfC0b32SwBBXFamv+ZIfRqS21rn2KwB+p8QTpEtS/ArSXLnkacpBYTnCC/+evO+XIirsvmMmJsfmGgE0JHFyjMo/wnhT4s0mLKhnEfvQMMg9uf1Cv2TGPI2HZdP2GBJvsKxPaJa5ouGVZG0308qTeyhGuZg7wWjkoSvxq/jQZsaRtfYus5EWbz/Lap7u2cbDVRhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+5q3Psl0fZ38WkoLqBtI0mjTov9/Divm/MACjeck8A=;
 b=W7Y2/oMqni2wSWKe7rF9nqYYeBUeCOCuiFek/nMIPZ1fmnHd7UytcmZlsK6gzQI1kxHUSqk/HsBuO/6vNBcWM48GTuzw2c38b7tY41AMzi04AhDUTFcezWVIOKNIjTDZj0iRd97EYzTYORFSOjrxlOQ1GoPs12hMcVG83gpjwrQ=
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by DBBPR04MB7883.eurprd04.prod.outlook.com (2603:10a6:10:1e9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Tue, 23 Aug
 2022 05:38:07 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c%3]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 05:38:07 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Marco Felsch <m.felsch@pengutronix.de>
CC:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: RE: [PATCH 2/7] watchdog: imx7ulp: Add explict memory barrier for
 unlock sequence
Thread-Topic: [PATCH 2/7] watchdog: imx7ulp: Add explict memory barrier for
 unlock sequence
Thread-Index: AQHYsSoBdxZHPlON40a5XuD6jrx4qK2xDxMAgAmF+ACAAAMHAIAAZZiAgADdrjA=
Date:   Tue, 23 Aug 2022 05:38:07 +0000
Message-ID: <AM6PR04MB6053E26CB59410EBCC2C93AEE2709@AM6PR04MB6053.eurprd04.prod.outlook.com>
References: <20220816043643.26569-1-alice.guo@oss.nxp.com>
 <20220816043643.26569-3-alice.guo@oss.nxp.com>
 <20220816062330.z2fvurteg337krw2@pengutronix.de>
 <AM6PR04MB60537292F559EC012F0EB510E2719@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20220822080010.ecdphpm3i26cco5f@pengutronix.de>
 <20220822140347.GA4087281@roeck-us.net>
In-Reply-To: <20220822140347.GA4087281@roeck-us.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2b484d7-e5cb-4a0b-1f67-08da84c9a877
x-ms-traffictypediagnostic: DBBPR04MB7883:EE_
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OlWSCmcoHKs/NbYyyVNmuka2xFVUIKCdmN6wn3I40vCyJv9e/XjCyvI66HX2X8TL82MAoy5fZo6KG0+433PGF2Y4ufrkOMuLg+ZDFdP3VYzyoarlLvn3fBe4za+rSdjjB0oNzW4Ro0mh6Ioq/1wj3CVJkG642NSTEGOwDNMVMO/4fPZDP9PmqjXvnyncR74xwSxe6jJECuAy9YIx1KDdvdmlkwIT2NaoysULsUSxpYzXnF3g6w4YeFUxS8221a/pmfIDe/8GZuAX9k237lTaAkhK/cSDC4x8Iu3u8tvmW9iLjaxaMnGofcgqE3XXcTU+Vb9WrOMmdKSdHHUC7ny0umDGJcXucTMIhLcOZHNh1Zo/VSBUKIDBcJHVnT46GqQV5pmkYkDYWOn23riOPVrQ9H1H7H3UtWzl1QH2rOcPmHa+Cg//8bSQeLdbxLL/CKN9gs9qWCpeKMr3qM0ekzqMSvBl0KYSZOVxi6gHgFT6gxGtkBIuQ8sflkBGV615z1B5/flhvpez3E148wNaW225VuFPB8kyepY1BPMVELdBkKxvJ0MIJ01E4D43OxI0aB4zYAAjXnnyPKpMlK41vpGsRjXc2EOyMIfqIW66nMOWQ2V5wyUT0X4pRR0fIUEOSk+FjOto47tDuebJ/IbOgOoFOyzRqcYoOtKqDM+KxCqNliSlC+XY8+6s4+UK+dQBH7p77+YzAGMgOjCEo5JsvzCMp99IueV4WjtMVLMI93xi10yE63mkPj0j0cnTs9vKzuUAP6o6IvhvGpS7bgt89PymIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(54906003)(64756008)(110136005)(5660300002)(26005)(66946007)(76116006)(66556008)(66476007)(4326008)(86362001)(8676002)(316002)(55016003)(7696005)(38070700005)(9686003)(6506007)(53546011)(66446008)(186003)(478600001)(52536014)(71200400001)(83380400001)(122000001)(41300700001)(8936002)(2906002)(33656002)(38100700002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AI1M1iTF5fFDvHTf9Y3SeAa/3z0DUs/rqr2kCQ5E8qyVSYAUZyQwlcbt9JGV?=
 =?us-ascii?Q?znMhltitgwhPiHU/oGRSECW8cyRhmSeYUOCVAx9474YvrFuewzMeFSceFk+G?=
 =?us-ascii?Q?1CLywz6xO4bm8jli2MoVfyWkMJxnX6cBWm+J7OY8/APGRBTiPWP58YgY3HRn?=
 =?us-ascii?Q?lhqSSC7UTlypI0BlUO1VnFd+QjJNFWlLMFJ8Yrxf0c9FA8KZD6Q1BQSy5Rzp?=
 =?us-ascii?Q?/nMlHeHhdVU9gw6JJULM73rj9CiYU4YTcK9EkasgsoD4ODmNfHSI5RzLC+MH?=
 =?us-ascii?Q?eMWrUfnW6ClH+2repNGUqtDq08cLr/tp5daMahAwOwHm5wqlhaPy7/aweBpF?=
 =?us-ascii?Q?3dG5GOnwly8OOD4uEdmnWeQ7OL7YBMW/tETaC7D9rVzuUCYyGjDMhtc+q2Ml?=
 =?us-ascii?Q?0aiZstb1Q2/mN0U4z9LK6Mo0EcvSfjmIPfBBGc5Fwq7NutlJ6HmCYhISDAt0?=
 =?us-ascii?Q?P1KH+t137c7P+4d8QNaHbF8SiZ7MT3N1A0qHJp8240D9hGr3VD+fLuywQqIS?=
 =?us-ascii?Q?yHNzooFTArsJvWQZpq+81e05ViIoZuvz6Jp9pPQvbq+9Hv+8gO66YcLcQJzv?=
 =?us-ascii?Q?2T38urGphRrahTzN55OZ8c68vtkaXUhQ5daGzmX+3km074wpFo3QtCMYOT0+?=
 =?us-ascii?Q?a/6dJUsJ/yF3avDLrVeMogZgsgx5xk6RcD+KGtnj3czNNuof+lg+9TxocptL?=
 =?us-ascii?Q?EBuJ74u42aVSE3QQzSJZBXS88UYUHVTkJ+gaodbRDC0bOGBDKynWWsGpRuZg?=
 =?us-ascii?Q?M74l1qO8mxhmk88UGI1wmJTqv6v4ueGAcIikmlNew9j/edGIt66rCerOdhxZ?=
 =?us-ascii?Q?tPYE4Bgs6KIPhsMCmI+lXAtOkBe6/kR+0wfiA/7YaV3ewbxl5bvg9OehK8qF?=
 =?us-ascii?Q?CEcmuHnEpxJoX6l9FbWjAELtwkzIQb9HyNxjmg/LKCuj2Hu5zydas9ygntWU?=
 =?us-ascii?Q?Uvpc+kXye7IMU+8ciDaZXms9qH6hhDZaYR8fVpZZb5bVMGVKw1lQOuO8X7sy?=
 =?us-ascii?Q?TgfQgoHA3HOVfCDC/e+6LoyHuVUUULNhBsKjqm5PaeY5p4qcmB9qLs8hxJns?=
 =?us-ascii?Q?s+ITuEdxob/yDls95imXEsfJb8qKW7xPBd3xgWi81/3cedsFnHZPgwTHpGrr?=
 =?us-ascii?Q?iNnRURlX8ustVa0C+aWu3AzYLjv3UQNs29W+0wJ/5aG71VaDaXNk0ft52JZs?=
 =?us-ascii?Q?O5KH/G6eWnEb+vJ0gAXMxAnAxfpm6IDEQJ7/3YnJb6SYzjWVFHrNvae3twVl?=
 =?us-ascii?Q?0P8jsncLrMlSYZofBozFPn2qshL7xLnldR2rlMey2/SWhDX+KNP6AukrsI5V?=
 =?us-ascii?Q?e30eNMxto3+0OPgRc5o32rDKDMHcEr25lu9ntHvgRD2idfefyUombu/shbb7?=
 =?us-ascii?Q?3Z0Zaft0LS9eUnBPwLLdXKxSxL3xebUbCFUuhVP1/B1HMryYMpxlH4wHgHhS?=
 =?us-ascii?Q?Lpgzsk8X2rIh5lnN3vMP41ha4V0T7XDtK9bMBt3ZH4C7yg4GrhZVrSmMapTj?=
 =?us-ascii?Q?JqnQX/ESqhAc5CNunJai67WMGo0jl6oDlNMS//9EYnkxc5AWl2u1xuiANHgv?=
 =?us-ascii?Q?j50ISSHZYZTjzl0EGWIxyBMHRJIOR4qdPUHmlv/p?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b484d7-e5cb-4a0b-1f67-08da84c9a877
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 05:38:07.5549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M7NJaTgTfjYZ+whlYDbpy60Ch+A9WtptH7q8yvTrVhn0dcMne/C64dT+G1XP9O5NcQJ3cOeIZ/VQnIThirJs3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7883
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> Sent: Monday, August 22, 2022 10:04 PM
> To: Marco Felsch <m.felsch@pengutronix.de>
> Cc: Alice Guo (OSS) <alice.guo@oss.nxp.com>; wim@linux-watchdog.org;
> shawnguo@kernel.org; s.hauer@pengutronix.de; festevam@gmail.com;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> dl-linux-imx <linux-imx@nxp.com>; kernel@pengutronix.de;
> linux-watchdog@vger.kernel.org
> Subject: Re: [PATCH 2/7] watchdog: imx7ulp: Add explict memory barrier fo=
r
> unlock sequence
>=20
> On Mon, Aug 22, 2022 at 10:00:10AM +0200, Marco Felsch wrote:
> > On 22-08-22, Alice Guo (OSS) wrote:
> > > > -----Original Message-----
> > > > From: Marco Felsch <m.felsch@pengutronix.de>
> > > > Sent: Tuesday, August 16, 2022 2:24 PM
> > > > To: Alice Guo (OSS) <alice.guo@oss.nxp.com>
> > > > Cc: wim@linux-watchdog.org; linux@roeck-us.net;
> > > > shawnguo@kernel.org; s.hauer@pengutronix.de; festevam@gmail.com;
> > > > linux-arm-kernel@lists.infradead.org;
> > > > linux-kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>;
> > > > kernel@pengutronix.de; linux-watchdog@vger.kernel.org
> > > > Subject: Re: [PATCH 2/7] watchdog: imx7ulp: Add explict memory
> > > > barrier for unlock sequence
> > > >
> > > > On 22-08-16, Alice Guo (OSS) wrote:
> > > > > From: Jacky Bai <ping.bai@nxp.com>
> > > > >
> > > > > Add explict memory barrier for the wdog unlock sequence.
> > > >
> > > > Did you inspected any failures? It's not enough to say what you
> > > > did, you need to specify the why as well.
> > > >
> > > > Regards,
> > > >   Marco
> > >
> > > Hi,
> > >
> > > Two 16-bit writes of unlocking the Watchdog should be completed withi=
n a
> certain time. The first mb() is used to ensure that previous instructions=
 are
> completed.
> > > The second mb() is used to ensure that the unlock sequence cannot be
> affected by subsequent instructions. The reason will be added in the comm=
it
> log of v2.
> >
> > Hi,
> >
> > I know what memory barriers are. My question was, did you see any
> > issues? Since the driver is used mainline and no one reported issues.
> >
> > Also just don't use the *_relaxed() versions is more common, than
> > adding
> > mb() calls around *_relaxed() versions.
> >
>=20
> Agreed with both. The series is a bit short in explaining _why_ the chang=
es are
> made.
>=20
> Guenter
>=20
> > Regards,
> >   Marco
> >
> > >

Hi Guenter and Marco,

1. did you see any issues?
This WDOG Timer first appeared in i.MX7ULP, no one report issues probably b=
ecause few people use i.MX7ULP. This issue was found when we did a stress t=
est on it. When we reconfigure the WDOG Timer, there is a certain probabili=
ty that it reset. The reason for the error is that when WDOG_CS[CMD32EN] is=
 0, the unlock sequence is two 16-bit writes (0xC520, 0xD928) to the CNT re=
gister within 16 bus clocks, and improper unlock sequence causes the WDOG t=
o reset. Adding mb() is to guarantee that two 16-bit writes are finished wi=
thin 16 bus clocks.

2. Also just don't use the *_relaxed() versions is more common, than adding=
 mb() calls around *_relaxed() versions.
Memory barriers cannot be added between two 16-bit writes. I do not know th=
e reason.

Best Regards,
Alice Guo

> > > Best Regards,
> > > Alice Guo
> > >
> > > >
> > > > >
> > > > > Suggested-by: Ye Li <ye.li@nxp.com>
> > > > > Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> > > > > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > > > > Reviewed-by: Ye Li <ye.li@nxp.com>
> > > > > ---
> > > > >  drivers/watchdog/imx7ulp_wdt.c | 4 ++++
> > > > >  1 file changed, 4 insertions(+)
> > > > >
> > > > > diff --git a/drivers/watchdog/imx7ulp_wdt.c
> > > > > b/drivers/watchdog/imx7ulp_wdt.c index
> > > > > 014f497ea0dc..b8ac0cb04d2f
> > > > > 100644
> > > > > --- a/drivers/watchdog/imx7ulp_wdt.c
> > > > > +++ b/drivers/watchdog/imx7ulp_wdt.c
> > > > > @@ -179,9 +179,13 @@ static int imx7ulp_wdt_init(void __iomem
> > > > > *base,
> > > > unsigned int timeout)
> > > > >  	int ret;
> > > > >
> > > > >  	local_irq_disable();
> > > > > +
> > > > > +	mb();
> > > > >  	/* unlock the wdog for reconfiguration */
> > > > >  	writel_relaxed(UNLOCK_SEQ0, base + WDOG_CNT);
> > > > >  	writel_relaxed(UNLOCK_SEQ1, base + WDOG_CNT);
> > > > > +	mb();
> > > > > +
> > > > >  	ret =3D imx7ulp_wdt_wait(base, WDOG_CS_ULK);
> > > > >  	if (ret)
> > > > >  		goto init_out;
> > > > > --
> > > > > 2.17.1
> > > > >
> > > > >
> > > > >
> > >
