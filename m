Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A02559D0EC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 08:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240402AbiHWF7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 01:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240386AbiHWF7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 01:59:19 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2060.outbound.protection.outlook.com [40.107.104.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614163D5AB;
        Mon, 22 Aug 2022 22:59:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9ZflhI/SShsj1p7PEpEXs5XbFocrRHw2Qns3i1oxKvDmKJKPUPgdOMf3f8wnIY6x4bVxSAO2dCTh20ZQoDOUM/laUfHsonvUIJIMpkUsCRT2CWe25yJCqYoNMbqEYvArh6hzRgvatZox2QL0n1giJaklIU/gIVi8Sbun7d9qzF1Ckd+d/mP1wCcLHV80QhAysSzjW2ffASex3Gx5iAFH/ueOlmGw1Xc2Wv2sBzOMBQGS19Mnbj2qX9Rssn6pmOz37MuPq2zenY1V9o8NgHS7NLYusSr4VHBCVXCi3Tjkwab+9qYi/w8KKohkwDAIOKmHp8iEW0FBeISfTb5jl9sLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39KXrkiXw73nSKgksJ6OWTVLg4Wj2uWgCEpZLvHXJLk=;
 b=Ig5TkMQS4mPBYONEMai7G4s6uHf4SaBCP7EXTz+gLbTq4oMDA479PXCoL8ZmcsmN2IhkRzEHwoiq9ag5Gb6X6m4wuUCssuhAmaCqFXnFtu1dEyPxLDY8WS4aUi2m5DezB8u3L307IHBXxEIWS+kuOIRvb6+9DXH8fIitGVMskFWLaPNUpCZfONlU7eZXlf5eb1xUZwZWSMTYBiHY+vwDD7MELafzicvC1/UheEGQPfmr8WdxhrHsSZ8HeCwLU4QusEcOY7fuiKvkn9lPkQPz/ZBCcyQrK5DoqzvDO11FO+kvjho8DKsmVTrRKrHA5zlxsoJytn5Ht8wv5O8PNYm6Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39KXrkiXw73nSKgksJ6OWTVLg4Wj2uWgCEpZLvHXJLk=;
 b=I52FXTGNnVMSoO2KDlSqjAGCvrHR5JOq73gC3c+X60qonZLfXpgJCeirjbbQy4M2tH+bBLOBfyfs4X8rT7MhlULCIRTTye/1I8WrJTQtFhaFkOHVIO9qpZrUY6WLVlH6oePgTGEAgyAwdyHL8OGmjrVdIok26uvXokCK6vi1u5s=
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by PA4PR04MB9247.eurprd04.prod.outlook.com (2603:10a6:102:2a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Tue, 23 Aug
 2022 05:59:12 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c%3]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 05:59:12 +0000
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
Thread-Index: AQHYsSoHMXeYIWNJpEGBMS17guc0sa26/1YAgAEHtXA=
Date:   Tue, 23 Aug 2022 05:59:11 +0000
Message-ID: <AM6PR04MB60533A1ABDFA1DEDE59BB847E2709@AM6PR04MB6053.eurprd04.prod.outlook.com>
References: <20220816043643.26569-1-alice.guo@oss.nxp.com>
 <20220816043643.26569-5-alice.guo@oss.nxp.com>
 <20220822140946.GC4087281@roeck-us.net>
In-Reply-To: <20220822140946.GC4087281@roeck-us.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2249d091-11e9-4fb6-1523-08da84cc9a1a
x-ms-traffictypediagnostic: PA4PR04MB9247:EE_
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pEZy+garKJOcLA6EoOfZ+u5h1mmnZnAfC72mXwJ02S4/K6+2wQQbFzK61jyY9DBKI2uyI9qoLcjL6xK2d32hfM3+sNrnZM05qqQdwImi8n8lBCieOrEA8JyZy3xIJ4Raospbu6Tc/qW0jjiBdp0eYDbdzX0uLkHn0uz54pUb7oTIHPPaGaB4ecNfTBLGZZLvxTwO++C8Xy6il5Dth7ok1U7wvxwXV5d5DaDDwbMOIv6cpj5Ug9GwfbkaQvr/SIxPWUDTJqT4EOltukoAwxOQ2fpE1kZB0LxdqosI8NspQhCdbMga7MtGZQOTzq1vvZ2KTrcO41J1uFRou0Osyo1hF1RgJOzuJJCZ11dXLdWbiWQ0K3vObIld2pLryyVV7l5k1wtFs9qrXVGftNwVQP73GgDnnaW/6JHf1ZfMSxqzzZVkPJujCDd29+7Jj+VvjyxfrB3xM9CO8EkgsIQb0lMvMwfRWPsNZUUuEXx/Vm1fWgqm8YqMEEjLshsfvlvjYORKyqNSf9DYXDGwkhhVtb6nKb/Y/5eKghhubtnuE8Dejg1JNPezoEYMUCzeLr0BEqbwhTzrP8krrJ3iN61cYXSA4oxUHVw2vAIcG/mcqUPjIyudE3M6KIlh7YvPRdIKLK0BlFcCjdfO9YBCkdsAuOAk5/R7XfF96sYX0WhLCqlv/4gwcI2jYGuwd0UuezUY2mdRXhIyJHJw8UAI2B6ZGnGh4ENcwgpowBQrUVrV3V2fHcPIxC64feT29QuCbZSnpzaPUI0kzZKyhX3l0m2S0ElC6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(5660300002)(6506007)(71200400001)(41300700001)(478600001)(83380400001)(7696005)(186003)(8936002)(26005)(9686003)(53546011)(2906002)(52536014)(55016003)(316002)(110136005)(33656002)(54906003)(66476007)(76116006)(8676002)(64756008)(66446008)(4326008)(66556008)(66946007)(86362001)(122000001)(38070700005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eR0YrfWdcReQCQITft7fTQnNSK+mWFGNWTnSHztRkgGVYmGGVT8KFrNyN1BV?=
 =?us-ascii?Q?Gknybw2EuxuBA/apwbgQ9H1V3iMslB4fYS1zHA/q8rmc+fOZkwtf5BqAZq8f?=
 =?us-ascii?Q?IOBzHCOIEO96msobnFCePLvIWOlLCeuvMR2YDFwsZm1FrFFF2Rr14ZbDRuVw?=
 =?us-ascii?Q?/bJHUmBE0pxe2kCNQ8c146DrXtmavkVmMdGKMqfpmTxuQFY5XT/x3r8dHmDp?=
 =?us-ascii?Q?CBvpRh8L4DAh9AfBiHYgeIa4ZElrBM2rqW4lrKWoe1m2/G2Uzi52vTRgwYyS?=
 =?us-ascii?Q?YWKFJUyVPJMe2s+yZm2qGyCtlxfYK+W/AJV4FiZBPFNIT1P4+IQB9G7lfQ2H?=
 =?us-ascii?Q?Oc0KNdUa1grjw7G1WO5pQStEw19OnEa6MfWouvkT70N8F712myiKdzQI0ZX6?=
 =?us-ascii?Q?aJoJDYG2+73FRRInnZ+fv8ZHbHQSHf7KmjiGyJBLxUnNP0wUjNhUyxG3MGMN?=
 =?us-ascii?Q?Ucn1eV2dtrCJ1yjmVjQHLFMfb/s+TVC50qCNDiBVgHfpGsBKxRaxfPBLUdPi?=
 =?us-ascii?Q?nP3KFJWJbsolST/kKUx1NyCJSp1JMh307BrfkHgZ1IAveCDr+v4896qSMhXy?=
 =?us-ascii?Q?YH9v7SgvtP8pzt5L51umnYOOCy3pKzPawBs/aEzTB3r0Bfzy0aUc9kExyXgR?=
 =?us-ascii?Q?wQ/UdnoUgY6/w9qFZlaXcGznxPDGBb0iiWQtAiq7pQoGiTZRbFBbh21xYqQN?=
 =?us-ascii?Q?weqvxHjXF8SnAj+ppZrStwM0nvR0Gca/lwT3ddWlKODWgiqiUCIWSZ/mgbKn?=
 =?us-ascii?Q?6pH7ue8Di5T8NQOuv62nCh6Tss+wF1fQimMa6z4DbFJuLy/83pJa5hotkwgH?=
 =?us-ascii?Q?tnYfGwh8WBmvCHIREaShMz81vG6tm7Ds/1M/4IfApSxgOm6Kmb5AYoOkdi+/?=
 =?us-ascii?Q?cHmP1EOL/LZW0aU30Kt/umDJikWrVm6MnSJb+9B0o/pO/yGxOxH2arslRYu6?=
 =?us-ascii?Q?pRmamaqN9mRCOxMM37zKQoUikc4R9wsQvZA9b0LoVptnZuBOhB2V19JcXcRa?=
 =?us-ascii?Q?llzEa9grWnr5VL7Jg4uiUPLjkkBCeYsmApraTSyEqTN220w936Kb/SOEi/R4?=
 =?us-ascii?Q?7u40h80RXhQ4UUYbn7ZUjaiTOuwPtymEoVWaEpiSEWiPY7ui9NIYIQkkK/It?=
 =?us-ascii?Q?tO4dlk7gJB1dR3inGmsCQaNCUGCxWCT3djhAmL1HwszCZhea0pv8QLqbon+K?=
 =?us-ascii?Q?mPCoBdib1J37lo13YhwFVD3d0l8ketP/ZN608TeQad3X9s4mEIv8egkTeR67?=
 =?us-ascii?Q?ZH3yPkp0jvDds9SwP6i2AOeiz2UyJONnCL6u0DWDLAccUIxGj4ecYG/+uSwo?=
 =?us-ascii?Q?tlFtL1xZg3wavQ1OLZV9nsjnu7K9lDQNIi/457ut93pY3SujLDj+MPjuTleg?=
 =?us-ascii?Q?CmLnnRoZzGzcy4aSzukxdlPzij+cJrmEsh+4hPaiiI8gvVJp0h/jvau0J21l?=
 =?us-ascii?Q?QXIQSxrx0c7v9qiShnbHI/XbT4pv69/qWWJbQBEo2CPmUACJiN0z9o9BrDDb?=
 =?us-ascii?Q?QoifN6gOYjUr7S115o2SL7WdmhGlB4XtW3Cj5oNQryJ4FdgsFYpNlSRoT30d?=
 =?us-ascii?Q?75OZ4SVD7jR2NVmfoxdCKVKDI6iBOi3WcFrQN+g7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2249d091-11e9-4fb6-1523-08da84cc9a1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 05:59:11.9629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 99MRHxB30g9ifa3rZVnFfnTlRFIsFOW6K/k2hFgUnev3fF/474jcfTNABXCPzJEC48XjyjY/K+x5TUd8/PW1Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9247
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> Sent: Monday, August 22, 2022 10:10 PM
> To: Alice Guo (OSS) <alice.guo@oss.nxp.com>
> Cc: wim@linux-watchdog.org; shawnguo@kernel.org;
> s.hauer@pengutronix.de; festevam@gmail.com; kernel@pengutronix.de;
> dl-linux-imx <linux-imx@nxp.com>; linux-watchdog@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 4/7] watchdog: imx7ulp_wdt: Fix RCS timeout issue
>=20
> On Tue, Aug 16, 2022 at 12:36:40PM +0800, Alice Guo (OSS) wrote:
> > From: Ye Li <ye.li@nxp.com>
> >
> > According to measure on i.MX7ULP and i.MX8ULP, the RCS done needs
> > about 3400us and 6700us respectively. So current 20us timeout is not
> > enough. When reconfiguring is on-going, unlock and configure CS will
> > lead to unknown result.
> >
> > Increase the wait timeout value to 10ms and check the return value of
> > RCS wait to fix the issue
> >
>=20
> You'll have to find a better solution. An active (non-sleep) wait of
> 10 ms is unacceptable.
>=20
> Guenter

Hi Guenter,

Sorry. I think this patch should be merged with " watchdog: imx7ulp_wdt: Ha=
ndle wdog reconfigure failure", but I didn't merge them. I will send v2.

Best Regards,
Alice Guo

> > Signed-off-by: Ye Li <ye.li@nxp.com>
> > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> > Acked-by: Jason Liu <jason.hui.liu@nxp.com>
> > ---
> >  drivers/watchdog/imx7ulp_wdt.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/watchdog/imx7ulp_wdt.c
> > b/drivers/watchdog/imx7ulp_wdt.c index a0f6b8cea78f..12715c248688
> > 100644
> > --- a/drivers/watchdog/imx7ulp_wdt.c
> > +++ b/drivers/watchdog/imx7ulp_wdt.c
> > @@ -39,7 +39,7 @@
> >  #define DEFAULT_TIMEOUT	60
> >  #define MAX_TIMEOUT	128
> >  #define WDOG_CLOCK_RATE	1000
> > -#define WDOG_WAIT_TIMEOUT	20
> > +#define WDOG_WAIT_TIMEOUT	10000
> >
> >  static bool nowayout =3D WATCHDOG_NOWAYOUT;
> module_param(nowayout,
> > bool, 0000); @@ -80,7 +80,7 @@ static int imx7ulp_wdt_enable(struct
> > watchdog_device *wdog, bool enable)
> >  		writel(val | WDOG_CS_EN, wdt->base + WDOG_CS);
> >  	else
> >  		writel(val & ~WDOG_CS_EN, wdt->base + WDOG_CS);
> > -	imx7ulp_wdt_wait(wdt->base, WDOG_CS_RCS);
> > +	ret =3D imx7ulp_wdt_wait(wdt->base, WDOG_CS_RCS);
> >
> >  enable_out:
> >  	local_irq_enable();
> > @@ -127,7 +127,9 @@ static int imx7ulp_wdt_set_timeout(struct
> watchdog_device *wdog,
> >  	if (ret)
> >  		goto timeout_out;
> >  	writel(val, wdt->base + WDOG_TOVAL);
> > -	imx7ulp_wdt_wait(wdt->base, WDOG_CS_RCS);
> > +	ret =3D imx7ulp_wdt_wait(wdt->base, WDOG_CS_RCS);
> > +	if (ret)
> > +		goto timeout_out;
> >
> >  	wdog->timeout =3D timeout;
> >
> > --
> > 2.17.1
> >
