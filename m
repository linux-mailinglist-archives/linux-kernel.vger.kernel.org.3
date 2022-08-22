Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCF359BA9B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 09:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbiHVHt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 03:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbiHVHtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 03:49:25 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1ED13CD5;
        Mon, 22 Aug 2022 00:49:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIyAJfFIC5UxvrQdGd7AjWkN7dvZfiV/Yq2pK+Er7BN64HbD8Tq3jtMxtrdncERgcT4F18LEDMR9V9JjCQO2s//trpGbiDOWZdieVZKaWKQ0V2M+IQ/FvRkX4jQuz2lPZ0+X33nWLZYlFZQDJWrIVR5/oEOhnr9yj4bzbRm42p2eac+C8nDLW1AV5GKnS2+k1bdQx0fGsCbKg8WUHHwAIs3TGz7OotKWZEkcHBKEWQV8Ie5QyDz6Q6EGysF/yR/qPWIQll8snBwPjlpkUyoZVDWwJA3WLIS3UrtfLLYKyYjS9sUoYVRl3WDf7kI93iWONOoonahJQNsggHZ2d1Yl5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1RS6yCNOPqwWf3B5rJNrthzCvh5OfykrF2PWvKioYCg=;
 b=mAOpkOqbe2R4Q7jbPVHFvgh4+HGdG2dUKzdRuFlnSFw+cPeZEJ7l3U6b+Z6eNrie3KruEY5DqSYMoOWT4UpbazUQVMnBasXvb7CW++zF5So9S+tZ7M3g6M3JevMssA7PKsWDGEaKHUBu/z49xFP/4ADyLqqk2Zx95+6YBtiPLmb5Y5Uwl8mI9JN55iZE0OcczX4vD2jiO9NORdtGdmB3g74lokbRemGLjukAU0AeJOfNr4r/v5dW4T+7Yti4U955BnSMC/ccY5MzFxGb07XAJM9gnbj0qNsWGqrazKgs7k+2Ev1dUaNXDZUqZy4E806fILxnuAQeiOGWHE7GoQoQEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RS6yCNOPqwWf3B5rJNrthzCvh5OfykrF2PWvKioYCg=;
 b=cu3zK+KpjnxKqjbL7Ux2gJ4CyWZ4o5eYJGA3XLZrCqeBcTCjFFjmlgW3+JgSgxohYd2Lbsf1O8UVp9Nj+ZckoC64oi0z71hm/nB5U6OXe7GK4Fpew3SxJTUgNSfvGg6EXYQ91E+fJHOgUCvSIUZ7Hfca9ZE+NNIAviD7mdb5IxY=
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM6PR04MB6664.eurprd04.prod.outlook.com (2603:10a6:20b:fa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 07:49:20 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c%3]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 07:49:20 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
CC:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
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
Thread-Index: AQHYsSoBdxZHPlON40a5XuD6jrx4qK2xDxMAgAl1k+A=
Date:   Mon, 22 Aug 2022 07:49:20 +0000
Message-ID: <AM6PR04MB60537292F559EC012F0EB510E2719@AM6PR04MB6053.eurprd04.prod.outlook.com>
References: <20220816043643.26569-1-alice.guo@oss.nxp.com>
 <20220816043643.26569-3-alice.guo@oss.nxp.com>
 <20220816062330.z2fvurteg337krw2@pengutronix.de>
In-Reply-To: <20220816062330.z2fvurteg337krw2@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24e7f8c9-9116-4415-6600-08da8412d2d6
x-ms-traffictypediagnostic: AM6PR04MB6664:EE_
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EecfZLh9Um7wLHN7jSR6UXRH6QnGyej/Nm41nP2Dw837JI/iqqHanoELMq+9T3xUqrmPRCFoTOBv1UpgkN6Qbt1zdhX2KXPYV7NWAct/zrMxcBJI8B3ru4CI4a/s/aCflDvTBLRtFCXI2OVbcnwI+Tc3ld4Vjg2ow8kf9M0FFby938L53cfQTygfUgTUU3170B6PPcW16dxETnPcb1XkhJ1oJjAjCu0UP9DUniZvf4y9m+iUGXCw5oodiBIddf6bWCuZ98cV5avmCr5nCDOsdJoqUC9RU/8OebrjjkAnG524e7ejoQj96KdP2C4uQ2WGujmtgadz0BB5dKW2JGhTnWgV2Sk9xmRG6wfME28k2MvCDjtEOgG9g5kGKu/dfBWnCanX0Tr0ZSaSyQlinb5Ojbvhh/CE/Np4Vyo5SviuYLEOKEvFUDQfkgRudATvwvNPrMSVbWnw1CZ7b/Tgd7WybcKTrQINY/gSXcIAn0IpB0z9NCi7yx15aaAJ+Fj/XxI8h1/t1t0GihwLLZS/zubgIZpipMRUz3CnDJSkyQWNLXjSlDHTYjLQ4+K6cQW5Cm4oBLoggvNmX6NJejaPBRklvEp87I0G50DuDsNkUlr0L3+rmJKnJqlyNBfyLUhe3rY7U4DoVHgALXqXMIT6FS73c8GGX4g+Z6layQJ6B4Y2+f/cibvcvYe8o6VOrNv69YmIadeh6SYOZC0Mywxvw2L5bkOC93tthZuhELleoumsQjkMe+S4UffA24M3vCFINaL/DnbDnbBOH6/m+vVUpT5LFQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(39860400002)(376002)(366004)(122000001)(38100700002)(2906002)(38070700005)(52536014)(8936002)(478600001)(71200400001)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(316002)(6916009)(54906003)(55016003)(186003)(83380400001)(41300700001)(7416002)(5660300002)(9686003)(7696005)(26005)(53546011)(86362001)(6506007)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O8419l4zXw3yj0A9qPEkf7J1jJ7mXjvqjs9WRE/HenRsGnCONrZaAGQiVDSr?=
 =?us-ascii?Q?M5JRO/GxsTj9axttOvP1r8ufZ0TCDfJLyrvEI9H+Mtxle+dhyGCrE/FD1AWr?=
 =?us-ascii?Q?sU0pur8k0chc77VKwGlY0btjkQHqdDPH5fJe2rp4/1OmZ4TcGgCr4XM9cbqM?=
 =?us-ascii?Q?jAhcguASJx7L7k7B0RLud3W6fDCjc7CA2OESeRpvKZNvgozPYLyTyimcWOcw?=
 =?us-ascii?Q?Dnrcde/8ygc6cZdjPX/ZYU7dFtkMFkwe+8MKUjTc6skqQIWNHCQeUarxI8LK?=
 =?us-ascii?Q?cY1VkpvCg5M07NwQCd1QA2mtFmx3BFgU3uYYHjfulvI1UPbhQc1MEaCz14mh?=
 =?us-ascii?Q?MA8m1Ktq0UXrBL/O0Nktpll0j5C1sjaCbdujkkRoitd9XdDYCai6dCb/IS0u?=
 =?us-ascii?Q?0P4b2Bd8640cV8wrugiUtd8QCjTTIS/yT1UKW11vA3hOk6azAeoruzYW7FN7?=
 =?us-ascii?Q?JRZjn8PuN8rOfnJPn495ChQkLzuX0bLC+qXrXF4yI13gx5shGl4yZJ8HTiIY?=
 =?us-ascii?Q?JdZ6XqXFqFbIWQC4Kf0wog3/HStpAE7QTd1jbYFLxMJhrLPZ5WLDo2E6sL/E?=
 =?us-ascii?Q?SzwJFWXaBZpE6UCJigD1SBDXhXERSHEXO3WrIFCQpDm0HNnRoDe3lKfTMi9k?=
 =?us-ascii?Q?/tRmkPjZ0X14jA1xlDEUhZXth1s1capIJ5xYt1W+jpVaHNCDNbzwHQoB0O7y?=
 =?us-ascii?Q?drJoKzBhONmnC2CtRMapbDO0iLAfFPfApUA3S/Zb3Uuv9c6rKltbOyfgIixV?=
 =?us-ascii?Q?PbNBBpMKyn23OdB2alhtwUmA8WaSjS60dMuo/SETmodA36KT9fnzVIHHBWKh?=
 =?us-ascii?Q?oVk7lKMql3x3P+sT5KNzFZn6viNPQqqXkIRqBmC9/KT9jyTEAqRct9McSZAv?=
 =?us-ascii?Q?M/xhCWaHr7piZ3kOu5eZjIhSou2Yegmp/JSH5CPZFclQj7OlyriLnF64p1ct?=
 =?us-ascii?Q?9QUujSuJMcqDC+PYb7dHiMxvnfLsHsWGoD41/stNPPiwCYiQ9Pl1UeI7owj/?=
 =?us-ascii?Q?6tRig3uB5y7YhxhOkbLoqeV/WGLvVvDGRGim/lqLHEmaR3WGCANgKMzcjKkH?=
 =?us-ascii?Q?43FS/SKzfWkLPzr7U8Cvs/ukeOKvtpnVSMBpeohpohwAdB2F3TPW1zDen5KB?=
 =?us-ascii?Q?K/fVzZLpWLv35PgPPExbtomK6XDnvLTmlwrWpnUwe3hqB+uyl2eCh/bevlV5?=
 =?us-ascii?Q?aFiKd8TUDDi5XXRn22RjqHjyNzpZ9UDYVW1nEhxnz/RNk4nvV7n9pLgQL78Z?=
 =?us-ascii?Q?DwxqlECV/kVPouY7thsnXHdeJtOIGerPvTgK0lhbJHaJkqn6WS5VM9xW4OLs?=
 =?us-ascii?Q?QP5zpkuF8kY/MirEyOUsbWKkYOgZMfCJ7xHlSSzhs8ueGZPAJ3hp4i4xziMy?=
 =?us-ascii?Q?XbfmggBfa9TrzM46/4YZDDDsELmcnb4EvXs1TBGYimHZqtbRdTgZ6+b6+CS5?=
 =?us-ascii?Q?YCWacNMEl6EGgqMIhpE2Kh3nuDK9maFSVNAm45hqCHdlU0Mla3B0pXHX8McO?=
 =?us-ascii?Q?9k3+oLRN+WJ6A5BBbgg/BAwtysTFx6vYrVcaTyGaCCcLfj3sX72WZ9yjGhVn?=
 =?us-ascii?Q?oes5aKvQzCD2y/Zw34/Z9nTFU0NtaPL93USCjxbi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e7f8c9-9116-4415-6600-08da8412d2d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 07:49:20.7734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zqrNQXRk2IhyfSWf0zUkreYFG6afSbWw64oJhhDE7f6YME4TbCoQAxTiy5i82SS3TzRXKy2zKYu8MJjp7ghjbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6664
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Marco Felsch <m.felsch@pengutronix.de>
> Sent: Tuesday, August 16, 2022 2:24 PM
> To: Alice Guo (OSS) <alice.guo@oss.nxp.com>
> Cc: wim@linux-watchdog.org; linux@roeck-us.net; shawnguo@kernel.org;
> s.hauer@pengutronix.de; festevam@gmail.com;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> dl-linux-imx <linux-imx@nxp.com>; kernel@pengutronix.de;
> linux-watchdog@vger.kernel.org
> Subject: Re: [PATCH 2/7] watchdog: imx7ulp: Add explict memory barrier fo=
r
> unlock sequence
>=20
> On 22-08-16, Alice Guo (OSS) wrote:
> > From: Jacky Bai <ping.bai@nxp.com>
> >
> > Add explict memory barrier for the wdog unlock sequence.
>=20
> Did you inspected any failures? It's not enough to say what you did, you =
need
> to specify the why as well.
>=20
> Regards,
>   Marco

Hi,

Two 16-bit writes of unlocking the Watchdog should be completed within a ce=
rtain time. The first mb() is used to ensure that previous instructions are=
 completed.
The second mb() is used to ensure that the unlock sequence cannot be affect=
ed by subsequent instructions. The reason will be added in the commit log o=
f v2.

Best Regards,
Alice Guo

>=20
> >
> > Suggested-by: Ye Li <ye.li@nxp.com>
> > Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > Reviewed-by: Ye Li <ye.li@nxp.com>
> > ---
> >  drivers/watchdog/imx7ulp_wdt.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/watchdog/imx7ulp_wdt.c
> > b/drivers/watchdog/imx7ulp_wdt.c index 014f497ea0dc..b8ac0cb04d2f
> > 100644
> > --- a/drivers/watchdog/imx7ulp_wdt.c
> > +++ b/drivers/watchdog/imx7ulp_wdt.c
> > @@ -179,9 +179,13 @@ static int imx7ulp_wdt_init(void __iomem *base,
> unsigned int timeout)
> >  	int ret;
> >
> >  	local_irq_disable();
> > +
> > +	mb();
> >  	/* unlock the wdog for reconfiguration */
> >  	writel_relaxed(UNLOCK_SEQ0, base + WDOG_CNT);
> >  	writel_relaxed(UNLOCK_SEQ1, base + WDOG_CNT);
> > +	mb();
> > +
> >  	ret =3D imx7ulp_wdt_wait(base, WDOG_CS_ULK);
> >  	if (ret)
> >  		goto init_out;
> > --
> > 2.17.1
> >
> >
> >
