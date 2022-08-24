Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3257959F3BD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 08:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbiHXGoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 02:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbiHXGoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 02:44:19 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E514685FEA;
        Tue, 23 Aug 2022 23:44:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knAJN//Va/XBZuWk47ubm8r7/jaOSuAPAWOCGJi9eDdEOZXtjVJ4AGlImUXvHJLbI5QDRrQIvFFMc8ASleN7lS7WvddXAuW6gKqjs3bCGPcqjEBTC+ICtqR4+DE5+GdeKrlMZxbFQtuk+mLVHEFirOhKp1X1jToo3Mtayt6muyTJ42h6jZoAUZhqGrqfoEkVPrTKfYI1GepXc0TdFCuDkkyWdC16gSJE+U+ka2QEsrLv3BuBbUwXs2ayI47cqq46fum6ce/loRDtH89nX1AXEmdM+SNSJgUSaq2dGKTvrP45MzOeUzLe7KyDDYpjJDyN4SRpnqcekRy6ABZoO3vhzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QM9BlDQ67Aqw7MNcAUHb2hLKUAGmCOTSFCc9sh29C7k=;
 b=GOJoWLtozTmtrOm24VaxdgG+Vylhfk9er7L/rIMYDMVbHme5YQH+DrbvXAierqeeakj65+F8q9SNuxP1fTJE4r120dKtBxWLrF/YUD8qlLUSktJX/n/0gNW5vl5iahmy1USzs9NucGqH/LBAADnLTR810hmfcrRe4vVqca1lPgjvg8Hhsc4Tm7xHgPzWU3IZuabYFGEDQnIZZrRXe5GvEyuOYavTrAPAf30Z3XOARLDJRwY40sf03J/pTaiH9z/MYP0M3CNkc+Nv9X5TxSQwdVpaI0GjoddBYq+1ceZ7BoJ2ywWK67D86lfT5B60qOaU3zrfBnNOGFIVZ32NkJxa2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QM9BlDQ67Aqw7MNcAUHb2hLKUAGmCOTSFCc9sh29C7k=;
 b=PBL6f544S6lkny9tCmxkTUT9Ae0aLs3VQC1PsCeleo0hmjHl5i8dxlYZaLsso/C+eoUO8roaV2yXgBQ2RpYhe8lxzMHNNT1H/j6JUY2Kfd6gglQPzneLB44JxeSUMinVbRdBjo7XoOGRxvoOyns+9a155ktBnzUNIci9qB9IbXw=
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by VI1PR0402MB3373.eurprd04.prod.outlook.com (2603:10a6:803:a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Wed, 24 Aug
 2022 06:44:12 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c%3]) with mapi id 15.20.5546.022; Wed, 24 Aug 2022
 06:44:11 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
CC:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/7] watchdog: imx7ulp_wdt: Fix RCS timeout issue
Thread-Topic: [PATCH 4/7] watchdog: imx7ulp_wdt: Fix RCS timeout issue
Thread-Index: AQHYsSoHMXeYIWNJpEGBMS17guc0sa26/1YAgAEJRICAAGa/AIABMvYw
Date:   Wed, 24 Aug 2022 06:44:11 +0000
Message-ID: <AM6PR04MB6053113B803E27D11892C5A1E2739@AM6PR04MB6053.eurprd04.prod.outlook.com>
References: <20220816043643.26569-1-alice.guo@oss.nxp.com>
 <20220816043643.26569-5-alice.guo@oss.nxp.com>
 <20220822140946.GC4087281@roeck-us.net>
 <AM6PR04MB60533A1ABDFA1DEDE59BB847E2709@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20220823120656.GC203169@roeck-us.net>
In-Reply-To: <20220823120656.GC203169@roeck-us.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ed83bea-7b95-4b61-b093-08da859c0dd0
x-ms-traffictypediagnostic: VI1PR0402MB3373:EE_
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KExSTw65grRf7eZyoWUrSYtaoAigtVDBt8nNWlVTfL4Rhp5jkXoMP3/bkfQ3UKZZudMnWJshWJIgO9auBMiJi3r8oWv7zfSnrrq6o35nS7vcTdbNO1fgOs3ggG2V9ZsTcYuSi3gCQuAvDcAYRYNGR9cxs2zAyS83hY2uRVXxqyN+ZSoZ2E7Dw+rmGsfLXZOV212KuL3qddWuA5ZtR75oMl2dIK321zy6v7yQIi28PSX1z3aui4TKgoiBhpB9fBBmdSbaPvWLsCGxFSvw4UFNp30+WBgGM88dw73rWsxFApKsb+7IvhhTmvE5c04kFG+6gmqvRHj96R+JNDTwEoJN0u8OstTYK5/EqE+gaDlgFDzei7QJmQetFDcOaSb4qb79l8nhp4t9cdD7SaXLgIn+JHLxPMqtKopSH0MEe0BF97hb48e7oGPOO9yaDcr5Z0LPHHd8SJzkgQsBqE5HJQSI9lHYNbfXZh9Zzi1F0GOWjxXMDKrAMet/355n7YfE4DhcnL9SNIelTpQJCc0yWbLYveB7+sFFFUwFN9Kv/Oz6xnEl8zOUfmwjmyfysKnbNk4YgT7jvZB/qGG8pI414cGOxWooLXJEgZZBB+uxR0eXPDcNJauXl7u8274FismblZnK8qXPx8dn/WrIo9X3W/QFYTVjQzZo27qXqSt6jhDSseJAL7zmv2n6phz3wZ/zMoP9H7pFw1smUc4tggpV1rp2K9RZ5dII3DWVZiBUpyDwDE3JN12aprU6YGDQ2VBi76pnOMNKahMDJpH8Xqo3WxUznw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(186003)(66446008)(66476007)(64756008)(5660300002)(41300700001)(8676002)(86362001)(66556008)(71200400001)(66946007)(76116006)(2906002)(26005)(7696005)(9686003)(6506007)(54906003)(478600001)(52536014)(4326008)(8936002)(33656002)(53546011)(122000001)(55016003)(38070700005)(110136005)(316002)(83380400001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hIal5Q9pw6NO/7N7uiydQf9GKNCznUYQTQEDr7aldYUpqVyCT8LFOoFlNOhf?=
 =?us-ascii?Q?3KgmC79+RiRvNML/1L/S1v742RTMoZyLVCWLcldTcpW2uMPPQQoH4wGeMfwI?=
 =?us-ascii?Q?XyLSakD/IraVNSoiRKzW5rIZ5kv3HKIXLzBpf/dS5BTFOxznIcepYDPz+kw4?=
 =?us-ascii?Q?fST138po2aLM77lEbzuZz113KiSFuN/75EHEwQcjgjWjZfca7NeTXlHjicPy?=
 =?us-ascii?Q?aOPls8YWggQhXNwrMkKAUpRlHc1JBLEVEUknvW8csuzwTM3YwOc9ODItlTZ3?=
 =?us-ascii?Q?rPE1g0jTkXthZWS8u1SSO4aOSnu8QTBl9oCoF6g5kH68NlJ1digRd27wUZ5w?=
 =?us-ascii?Q?XVYKDmL2wNMCY1m0WWYBC4besXAEnzJrTHPpUtVUVgjcraajXl8Vsywh0KyS?=
 =?us-ascii?Q?3fOK37VcbZTga0fYK2aI1peNCGaOt/yBKneWFZO92JbyR6dJiWJ5siM5ZJD/?=
 =?us-ascii?Q?OgKiyK9Zl06FzzdAO90tVx4wO8vpp1ZdtXBsEDgeMeMjIUaA6+z1uT/A2dMQ?=
 =?us-ascii?Q?i+QJZ13zzKeNwUSpuR+UN5AJxQrv1DzJ6zKv/L0NqmQWwB7y8YgoL4EPMyLL?=
 =?us-ascii?Q?PFcgVeJqAK5/s6wmy0CyfTKzzGsle7WnHtQsx6sW8zzDuytTYzIS6SU0N30z?=
 =?us-ascii?Q?Tfumxm8XTS0dX4zkIKtMqhZ4E67WGLHFhasgNLKvdIQ+bZjmJ4fSfwFST7MW?=
 =?us-ascii?Q?4+YfueGEwKzT6Xz+CXysoO4FDQA/8J+1egMaty82crNnU0hOXccd/mxCxM9E?=
 =?us-ascii?Q?bqV3CioQjqxS6qpfkL99wQQXSzvHnOaM1tGVGHkk9aBU3d5FJBDKiipSJqIX?=
 =?us-ascii?Q?JHDtH6Hltdd5Lil6G8vMvxMslw0orVGFbFc3YGwGKylCawbSmE3MRvJb1F//?=
 =?us-ascii?Q?NtBvIwCUDxQl2qfD2QO10iYS639gSpOqZRfkaY2UdrVsr2fwWeSN4peI6Lmf?=
 =?us-ascii?Q?OpC656uWTo68fPDLVPNWxs4R8B1vLAFEHi8LkcOvEZa4qnHVVhxBXcFHnpOx?=
 =?us-ascii?Q?K3JqsoHDp5RNsJbaWVLgIZeIW4rzbC3uxilYv3eERacT8tefV4AQ4hdOUIx+?=
 =?us-ascii?Q?yldKqyh4Lhl414v8y/3a/7yCvtGDlhP7vRM/qeGzBQbpDCJuX2nhd5jpxS++?=
 =?us-ascii?Q?dD2tHIILrVjppIYAPoD8mQ0vz4rA4wPYPQFI+T+q8l9wqdYChzST3fEE2oEJ?=
 =?us-ascii?Q?tYzW6iVkp0vpe4FVJNS3OGqsELiVZUGhdeBrh2lUe1d8Ii//u0LdKp4bGINT?=
 =?us-ascii?Q?kqd/9Etaod73q5nNMvYeKYuXO3URuS+L/XAbLDU1qn3nkNCU+j+ahwbJk1E6?=
 =?us-ascii?Q?AZcTZGkmfVuvJ5Ts6zbuuWUCC4Z9F2UDe4uBh83zG72g9a0MtvdIn/1PGADO?=
 =?us-ascii?Q?rXlgVLNym2GSuEKjlM+0XUgy3mk8uCLywpvfaBodwGxS9IcusEoNzRsgQuCm?=
 =?us-ascii?Q?db8PelcQX4jh6s+qNl14p1jJb4KK1GGqx1ORsaKUfYrXX7BWcbbdcgrWvOno?=
 =?us-ascii?Q?D7/PYZ4++mXgLb+HNC8dnriS/M0UKBXzoRqh3PLooTDN7VuEDJTsCpwK+Fyo?=
 =?us-ascii?Q?xvOvX5y3w2riSQhiRenytr+3gyuOOWafoqMW8hvz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed83bea-7b95-4b61-b093-08da859c0dd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 06:44:11.9206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qfJc6bRRYgBQHP9jinGTbf1fzqt0YhAjJ89PN1sW463TqNx6IbV6UbMfHnBEydprFVtuTrEOZAB0HTUPBCrYFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3373
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
> Sent: Tuesday, August 23, 2022 8:07 PM
> To: Alice Guo (OSS) <alice.guo@oss.nxp.com>
> Cc: wim@linux-watchdog.org; shawnguo@kernel.org;
> s.hauer@pengutronix.de; festevam@gmail.com; kernel@pengutronix.de;
> dl-linux-imx <linux-imx@nxp.com>; linux-watchdog@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 4/7] watchdog: imx7ulp_wdt: Fix RCS timeout issue
>=20
> On Tue, Aug 23, 2022 at 05:59:11AM +0000, Alice Guo (OSS) wrote:
> >
> >
> > > -----Original Message-----
> > > From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> > > Sent: Monday, August 22, 2022 10:10 PM
> > > To: Alice Guo (OSS) <alice.guo@oss.nxp.com>
> > > Cc: wim@linux-watchdog.org; shawnguo@kernel.org;
> > > s.hauer@pengutronix.de; festevam@gmail.com; kernel@pengutronix.de;
> > > dl-linux-imx <linux-imx@nxp.com>; linux-watchdog@vger.kernel.org;
> > > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH 4/7] watchdog: imx7ulp_wdt: Fix RCS timeout
> > > issue
> > >
> > > On Tue, Aug 16, 2022 at 12:36:40PM +0800, Alice Guo (OSS) wrote:
> > > > From: Ye Li <ye.li@nxp.com>
> > > >
> > > > According to measure on i.MX7ULP and i.MX8ULP, the RCS done needs
> > > > about 3400us and 6700us respectively. So current 20us timeout is
> > > > not enough. When reconfiguring is on-going, unlock and configure
> > > > CS will lead to unknown result.
> > > >
> > > > Increase the wait timeout value to 10ms and check the return value
> > > > of RCS wait to fix the issue
> > > >
> > >
> > > You'll have to find a better solution. An active (non-sleep) wait of
> > > 10 ms is unacceptable.
> > >
> > > Guenter
> >
> > Hi Guenter,
> >
> > Sorry. I think this patch should be merged with " watchdog: imx7ulp_wdt=
:
> Handle wdog reconfigure failure", but I didn't merge them. I will send v2=
.
> >
>=20
> That doesn't change the fact that a 10 ms hot wait is unacceptable.
>=20
> Thanks,
> Guenter

Hi Guenter,

I plan to use readl_poll_timeout to wait for RCS(Reconfiguration Success). =
I think the sleep_us of readl_poll_timeout can be used to avoid a 10 ms hot=
 wait.

Best Regards,
Alice Guo

> > Best Regards,
> > Alice Guo
> >
> > > > Signed-off-by: Ye Li <ye.li@nxp.com>
> > > > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > > > Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> > > > Acked-by: Jason Liu <jason.hui.liu@nxp.com>
> > > > ---
> > > >  drivers/watchdog/imx7ulp_wdt.c | 8 +++++---
> > > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/watchdog/imx7ulp_wdt.c
> > > > b/drivers/watchdog/imx7ulp_wdt.c index a0f6b8cea78f..12715c248688
> > > > 100644
> > > > --- a/drivers/watchdog/imx7ulp_wdt.c
> > > > +++ b/drivers/watchdog/imx7ulp_wdt.c
> > > > @@ -39,7 +39,7 @@
> > > >  #define DEFAULT_TIMEOUT	60
> > > >  #define MAX_TIMEOUT	128
> > > >  #define WDOG_CLOCK_RATE	1000
> > > > -#define WDOG_WAIT_TIMEOUT	20
> > > > +#define WDOG_WAIT_TIMEOUT	10000
> > > >
> > > >  static bool nowayout =3D WATCHDOG_NOWAYOUT;
> > > module_param(nowayout,
> > > > bool, 0000); @@ -80,7 +80,7 @@ static int
> > > > imx7ulp_wdt_enable(struct watchdog_device *wdog, bool enable)
> > > >  		writel(val | WDOG_CS_EN, wdt->base + WDOG_CS);
> > > >  	else
> > > >  		writel(val & ~WDOG_CS_EN, wdt->base + WDOG_CS);
> > > > -	imx7ulp_wdt_wait(wdt->base, WDOG_CS_RCS);
> > > > +	ret =3D imx7ulp_wdt_wait(wdt->base, WDOG_CS_RCS);
> > > >
> > > >  enable_out:
> > > >  	local_irq_enable();
> > > > @@ -127,7 +127,9 @@ static int imx7ulp_wdt_set_timeout(struct
> > > watchdog_device *wdog,
> > > >  	if (ret)
> > > >  		goto timeout_out;
> > > >  	writel(val, wdt->base + WDOG_TOVAL);
> > > > -	imx7ulp_wdt_wait(wdt->base, WDOG_CS_RCS);
> > > > +	ret =3D imx7ulp_wdt_wait(wdt->base, WDOG_CS_RCS);
> > > > +	if (ret)
> > > > +		goto timeout_out;
> > > >
> > > >  	wdog->timeout =3D timeout;
> > > >
> > > > --
> > > > 2.17.1
> > > >
