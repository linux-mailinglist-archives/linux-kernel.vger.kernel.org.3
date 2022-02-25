Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F332A4C3B76
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 03:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236687AbiBYCKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 21:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236663AbiBYCKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 21:10:47 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150051.outbound.protection.outlook.com [40.107.15.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0DF1EC98A;
        Thu, 24 Feb 2022 18:10:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMR0gH83jNrIJa1EcqvAIICjnt6i88e6sD4aJXWTn8bagpz1xyRh2VgTaeKwf9sFsh7t1yHMHBFSl1Yrt4tctngOKYiezcTXHw90Td1H7BmdqFaHpCmrWo4dVjwWE832qVAltSQ6LeNv6AO7PFpYVZYTIVW1L6wrc7Wc/4TbeAFqC49eBzl3lkzGzPVZkdNceTHhDWhTi1ojlawF3RvMuESlhjieI6bd7+acWM/NvLc17c2Rvm02EToKm4V+CNlWKFMHr4L5fx5HifDhzk+btyViOc9fk0Uro1dyjyz846JeJQgm5ma3qIXeJE5HWWrOUrwg64PDLyZFQuAB6HtFAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEHw7OwYOEBYM84TYz+GI9//uI3JBS4Vg6+D6QeP6Zc=;
 b=U0EKpDQZUuzKJaQoCVUz36U3bB8HLUMi6qMF5Yn1J6u+VdCBm+UiulopkSStVHM8g0ezbBmIUa0HsnZinSgP898a4d79PewOpqmGIei5zf76EBPLMapurBykjtD0WyWHHMLjdza8pK09xYYrbJAGLjYjeyf7PRaHkLtq6qcOVTHeZ8ZqYgIVvIOCJda/2ET4C2uel+rHhEyq4Qj1TOMwzkjn+j0L/Nzq/dL4T9Vf20tiCnmk2zivyBIXYvHHh0w0IXzpYXRzWO8btH3eu8VhhSmHP7Xzwkc0RY0bTx2WcGjQ2yq2qnJ0vCQxR+mLiaU7BBhlRK7eZQZgd06xD0HwuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEHw7OwYOEBYM84TYz+GI9//uI3JBS4Vg6+D6QeP6Zc=;
 b=CfQLZeHwyTynSxD9KRGWJWMERCoBtqk2bICfNv7uNUjF5gW3d1ejtbdRQs+TPh5Hj7J57eTEpvUAi+8IF/385kJ9DUmbrY/V9Sfj6n/lYjPGLKeMTFrReTSDR72IoigifgURxPo1Bv1pMXOfkEPQpfYMWbfwuGDjdbGzPaZ9EKc=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6492.eurprd04.prod.outlook.com (2603:10a6:10:109::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Fri, 25 Feb
 2022 02:10:13 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Fri, 25 Feb 2022
 02:10:13 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2] remoteproc: support self recovery after rproc crash
Thread-Topic: [PATCH V2] remoteproc: support self recovery after rproc crash
Thread-Index: AQHYEpIEHEs++qV8cUuKksCGalsIFKyTf94AgA9q+oCAAMec4A==
Date:   Fri, 25 Feb 2022 02:10:13 +0000
Message-ID: <DU0PR04MB9417ED8CBFEE1C1FD4DFD850883E9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220126085120.3397450-1-peng.fan@oss.nxp.com>
 <67ddf940-6f87-d8cc-8dc6-29a39a022265@foss.st.com>
 <da6bee63-6a79-2341-e099-d26b53fb557f@foss.st.com>
In-Reply-To: <da6bee63-6a79-2341-e099-d26b53fb557f@foss.st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a8a5916-3b58-4fee-d99a-08d9f803f55c
x-ms-traffictypediagnostic: DB8PR04MB6492:EE_
x-microsoft-antispam-prvs: <DB8PR04MB6492F2175D1E671E42C5A324883E9@DB8PR04MB6492.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z4quZsGIqVKIC+LAeQiOyaXzZdXlmJB/JWazOAaI5CTwlPUwy7siSXGiAdqYTjCX5u7n0ynWwBi2cPyLukMJ7jMW6b8ZUV6jNb5/NQ0qtfIT36FhK31AEYNPopxuQte9M0EuYmwVQv7MR96VIKBnBXMBdFLlMikYaN0rOFRWS7o6QrsExLHDv5A/w3nyQ6DsA5SbBG6k18Fq50XRuyB2uWU80NDzyaJomh2YTu4s+kxWZY7HmJzG82U/RePFQppSDROCuk32bVF698eii7h9o7mp4vg3XdJYho0OaPNHnvtfMYuS6B5JtIcsSPk3ud3TtxnDj4nvvmHHskijH8VWKj1kQGjobUd08EsFoZ2MgPx56+NEE0sKmtHlqpUtzfzUQXytVoowbIOUBljmWit/1xDWEmwmTmx19BaZUuqoJxj5STnatR/zX+qfFH+S14LehjVyxqP58umMgmhgpii3GxMRA4iLQ1TAj+fmnDZ53CxkS6g/CwbTAW3pL/doOehqAmng3LqtYEGI3xkd7TabBAPn8Lrbr2C7S+84hS0sGI4FXqEjkjDzPLJlfn8NXyKp4tnZlDxVSzipAG9krH7nyvX9pdzfe4gJSbIuWC9V5iAtosTowNPr2TGeHsPjZ/Ug5lanavB7QBHwPVgRiuyivA8m6PKuIBsURpB6UhPCEIOOHf4pvMyhkxmMc0qoUJpt7nrE6F+f5ZCP8egdVKaEBY98WKm+4y4cxrD3/KoT1gafMMCePwQcozONwdcIXtOjJm3xhRwxCu+vI5kZAfGZYtU0yhT6e2jtGscOCNelzP0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(2906002)(122000001)(55016003)(38070700005)(38100700002)(64756008)(45080400002)(86362001)(966005)(508600001)(9686003)(53546011)(6506007)(316002)(66446008)(66556008)(66476007)(66946007)(8676002)(76116006)(7696005)(110136005)(44832011)(52536014)(8936002)(26005)(186003)(71200400001)(33656002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wsrC21QbVxo371FgxYMz8x+zAvrvox5TJUJYY52DaU6b3s4kZQ685rWtYQG+?=
 =?us-ascii?Q?qxXB4NQV3tjHX5KhEfDZDJp77yXrN+hDip8XhX4WHstUfBvgkYcZFtavZARq?=
 =?us-ascii?Q?QeLCVgjG29jY6c+oObttvUngEE+BrQGjQOBnV9hcv9QYypyBMI+6ypGv+SGF?=
 =?us-ascii?Q?25n5cIv6ij2DsSSR56vCxWqW59DjyGODvoUOijRcigmHzwZwt42ySR0pUrE4?=
 =?us-ascii?Q?PwT1wqoVGOOxDI1KXVxmH2RLKaYgrte7/fvwGfzSsF0mOl5L0yvXh0dCahxG?=
 =?us-ascii?Q?2lwJ3zFYNfDv+060jZho33UIPL+4/WC0Z3OzWMl6K72kMp855mBKdMqi+XJH?=
 =?us-ascii?Q?X3xOpDnUvpCNYP7nwMKo9CrGQowp5IsvwXaNNJP/N1idohcEKjHtKqMgrDP3?=
 =?us-ascii?Q?vPpQXR83vLSKW+PsyYZQjr+cDxTPs0t65pzUv+TCWVeUVBdaCsrX4b5nu3F1?=
 =?us-ascii?Q?FBgPrzrlns3RuUrJQoaCNXBzCq7nOAkOdjS78fE7gSkcsZSKryHkIwAH+oKI?=
 =?us-ascii?Q?crwwzAKSILJ7PRsW4aiIVlaJ93+lpo1sWBv1fy+SOXTSlU+Z5iHsmzVx1AY3?=
 =?us-ascii?Q?7s6aW6tcUmv3LaZ17tNS5QuQGNTzQkIGlhmhtLftQBNXUGlUxtJ7RLAMA2xv?=
 =?us-ascii?Q?2BjnZaIzN9M3fsxm/H76Kis3uawBSID7m/A85DTcTfzO3ATsZAsZgNd7/K/9?=
 =?us-ascii?Q?fMVESIPrHrAW5mb78A0dmzY44JhmhcapmEVmeHTMqPwUeF/oqBdBu4QrERp/?=
 =?us-ascii?Q?2351j/0Ku8WpaFy4W51Q/p36NgxZSt+ppfw/CHqAbcVYAgUKE6yjKw8eFYJL?=
 =?us-ascii?Q?OhxxyChrAY7KBbe0ToPn7L7a7s5qjsADjuBB4a7MqtHWDNa9n5ru/MjOdOgQ?=
 =?us-ascii?Q?su2qpisddzoWQDfk8Gje56pTYAvGZ2C/9hkP/Y1CbG2yQ8X4sLcm/5nv0wnl?=
 =?us-ascii?Q?mCUFN8w2mw23CbMOZM62p30/SwZy8wJC1KwxbumeKOeRGKyYoU0EDSJU0zk/?=
 =?us-ascii?Q?LyMyeHzVK1KRipE9UWZCmhq+/nxKEO4U6JlzNyoDyGC+8q8C3u8EZwGDYrSe?=
 =?us-ascii?Q?ZN67f5HGZKzNImobs893IbPBa2BQLEz+/XPG9a1Zsx5Ozh21QqG1lLytAX9i?=
 =?us-ascii?Q?9SBCg3r/9mToUgWjKT44jhiFxju9hRWIseW/pHIsylAv7bUcW/avGR90XYHr?=
 =?us-ascii?Q?qxVxRVsqUz6zwsblMj46Ee3E6+DebyXbnxO5z+blshFJlT5Wxhjm0BEoc42n?=
 =?us-ascii?Q?U8xTn0w4AARLoZmC5Y+nT91SETS0KJHCM1N7Lg3QupCiu8Fk2MQ1WBIJOHCq?=
 =?us-ascii?Q?xTqacsFVhtYYHUEKBsbwn5RurvIBxIwE1l8Pd/5Fn9PnS8I7C1RfWURz1Iha?=
 =?us-ascii?Q?PWvXQqSo2yUuz4ElmYfgfpFr19AXMfRJ4ZcL5pwlqG8Ziy1TU4t9N+fTm4w7?=
 =?us-ascii?Q?5SuqoSdGORVCMJYAkZyeh4/aYQSnuWHRidbEK1ZwmT9YDTPP9tmk7cQrZeNX?=
 =?us-ascii?Q?RIYzjvG5T+c4TVfY5wdi4y7qYwEJ+pvIFdC+sYK+57Aq7gij0ny0qilguZ6s?=
 =?us-ascii?Q?xRmvYP2/OfLWVOuXtkFFWcMbq6uxdP300NCSFibMm7uz4g6eb3Piw+JE/Ubr?=
 =?us-ascii?Q?+UinSRQTo0yq9w1GTrMg7es=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8a5916-3b58-4fee-d99a-08d9f803f55c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 02:10:13.3791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iGCuU3IM8TG6WobIJdOFuquSV8bd9xM02La+OQY8YayF3IF3fnkArhjVa/VJ0SPIy8fbQvzh60k+bCzK1Ntf3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6492
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V2] remoteproc: support self recovery after rproc cra=
sh
>=20
> Hi Peng,
>=20
> On 2/14/22 19:41, Arnaud POULIQUEN wrote:
> > Hi Peng,
> >
> > On 1/26/22 09:51, Peng Fan (OSS) wrote:
> >> From: Peng Fan <peng.fan@nxp.com>
> >>
> >> Current logic only support main processor to stop/start the remote
> >> processor after rproc crash. However to SoC, such as i.MX8QM/QXP, the
> >> remote processor could do self recovery after crash and trigger
> >> watchdog reboot. It does not need main processor to load image,
> >> stop/start M4 core.
> >
> >
> > On stm32mp1 platform the remote processor watchdog generates an early
> > interrupt that could be used to detach and reattach before the reset of=
 the
> remote processor.
> > I need to test race condition,but I suppose that this should works if
> > the resource table is not reinitialized by the remote processor firmwar=
e.
> >
> > Another option for the stm32mp1 is that remoteproc manages the reset
> > of the remote processor.
> > For instance this allows to save a core-dump before manually resetting
> > the remote processor.
> > But looks like this use case can be handled later, as mentioned below.
> >
> >>
> >> This patch add a new flag to indicate whether the SoC has self
> >> recovery capability. And introduce two functions:
> >> rproc_self_recovery, rproc_assisted_recovery for the two cases.
> >> Assisted recovery is as before, let main processor to help recovery,
> >> while self recovery is recover itself withou help. To self recovery,
> >> we only do detach and attach.
> >
> >
> >>
> >> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >> ---
> >>
> >> V2:
> >>  Nothing change in V2.
> >>  Only move this patch out from
> >>
> >> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa=
t
> >>
> chwork.kernel.org%2Fproject%2Flinux-remoteproc%2Flist%2F%3Fseries%3D
> 6
> >>
> 04364&amp;data=3D04%7C01%7Cpeng.fan%40nxp.com%7C3d617c5ddb8c42b
> 315f808d
> >>
> 9f79f2ac7%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6378130
> 8526949
> >>
> 0105%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu
> MzIiLCJB
> >>
> TiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DVKKrqOnFz%2BoXjr%2
> FGMKpm4
> >> yyqmRfApeYY0l2V8A0yy4Y%3D&amp;reserved=3D0
> >>
> >>  drivers/remoteproc/remoteproc_core.c | 66
> ++++++++++++++++++++--------
> >>  include/linux/remoteproc.h           |  2 +
> >>  2 files changed, 49 insertions(+), 19 deletions(-)
> >>
> >> diff --git a/drivers/remoteproc/remoteproc_core.c
> >> b/drivers/remoteproc/remoteproc_core.c
> >> index 69f51acf235e..4bd5544dab8f 100644
> >> --- a/drivers/remoteproc/remoteproc_core.c
> >> +++ b/drivers/remoteproc/remoteproc_core.c
> >> @@ -1887,6 +1887,49 @@ static int __rproc_detach(struct rproc *rproc)
> >>  	return 0;
> >>  }
> >>
> >> +static int rproc_self_recovery(struct rproc *rproc) {
> >> +	int ret;
> >> +
> >> +	mutex_unlock(&rproc->lock);
> >> +	ret =3D rproc_detach(rproc);
> >> +	mutex_lock(&rproc->lock);
> >> +	if (ret)
> >> +		return ret;
> >
> > Here we would want to perform a core dump and manually reset the
> > co-processor.
> > I suppose that a new rproc ops could be called here in a next step.
> >
> >> +
> >> +	if (atomic_inc_return(&rproc->power) > 1)
> >> +		return 0;
> >
> > Do you identify a use case that needs to test rproc->power to skip the
> > attach?
> > If yes could you add a comment to describe it?
> >
> >> +	return rproc_attach(rproc);
> >> +}
> >> +
> >> +static int rproc_assisted_recovery(struct rproc *rproc) {
> >> +	const struct firmware *firmware_p;
> >> +	struct device *dev =3D &rproc->dev;
> >> +	int ret;
> >> +
> >> +	ret =3D rproc_stop(rproc, true);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	/* generate coredump */
> >> +	rproc->ops->coredump(rproc);
> >> +
> >> +	/* load firmware */
> >> +	ret =3D request_firmware(&firmware_p, rproc->firmware, dev);
> >> +	if (ret < 0) {
> >> +		dev_err(dev, "request_firmware failed: %d\n", ret);
> >> +		return ret;
> >> +	}
> >> +
> >> +	/* boot the remote processor up again */
> >> +	ret =3D rproc_start(rproc, firmware_p);
> >> +
> >> +	release_firmware(firmware_p);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >>  /**
> >>   * rproc_trigger_recovery() - recover a remoteproc
> >>   * @rproc: the remote processor
> >> @@ -1901,7 +1944,6 @@ static int __rproc_detach(struct rproc *rproc)
> >>   */
> >>  int rproc_trigger_recovery(struct rproc *rproc)  {
> >> -	const struct firmware *firmware_p;
> >>  	struct device *dev =3D &rproc->dev;
> >>  	int ret;
> >>
> >> @@ -1915,24 +1957,10 @@ int rproc_trigger_recovery(struct rproc
> >> *rproc)
> >>
> >>  	dev_err(dev, "recovering %s\n", rproc->name);
> >>
> >> -	ret =3D rproc_stop(rproc, true);
> >> -	if (ret)
> >> -		goto unlock_mutex;
> >> -
> >> -	/* generate coredump */
> >> -	rproc->ops->coredump(rproc);
> >> -
> >> -	/* load firmware */
> >> -	ret =3D request_firmware(&firmware_p, rproc->firmware, dev);
> >> -	if (ret < 0) {
> >> -		dev_err(dev, "request_firmware failed: %d\n", ret);
> >> -		goto unlock_mutex;
> >> -	}
> >> -
> >> -	/* boot the remote processor up again */
> >> -	ret =3D rproc_start(rproc, firmware_p);
> >> -
> >> -	release_firmware(firmware_p);
> >> +	if (rproc->self_recovery)
> >> +		ret =3D rproc_self_recovery(rproc);
> >
> > If some platforms have to manually reset the remote processor (without
> > reloading the firmware) the name could not be relevant...
> >
> > Following comments are only suggestions that needs to be commented by
> > maintainers
> >
> > What about rproc_attach_recovery ?
> >
> >> +	else
> >> +		ret =3D rproc_assisted_recovery(rproc);
> >
> > and rproc_firmware_recovery ?
> >
> >
> >>
> >>  unlock_mutex:
> >>  	mutex_unlock(&rproc->lock);
> >> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> >> index e0600e1e5c17..b32ef46f8aa4 100644
> >> --- a/include/linux/remoteproc.h
> >> +++ b/include/linux/remoteproc.h
> >> @@ -529,6 +529,7 @@ struct rproc_dump_segment {
> >>   * @elf_machine: firmware ELF machine
> >>   * @cdev: character device of the rproc
> >>   * @cdev_put_on_release: flag to indicate if remoteproc should be
> >> shutdown on @char_dev release
> >> + * @self_recovery: flag to indicate if remoteproc support self
> >> + recovery
> >>   */
> >>  struct rproc {
> >>  	struct list_head node;
> >> @@ -568,6 +569,7 @@ struct rproc {
> >>  	u16 elf_machine;
> >>  	struct cdev cdev;
> >>  	bool cdev_put_on_release;
> >> +	bool self_recovery;
> >
> > This bool seems needed because we have lost the previous state before
> crash.
> > I wonder if a new rproc->state such as RPROC_REBOOT could avoid this
> boolean.
> >
> >
> > I will try to test you patch on stm32mp1 next week
>=20
> I performed few tests on the stm32mp1 with your patch.
> Thanks to the resetting of the resource tables on detachment, this works
> quite well.

Thanks very much for you testing this patch. I'll try to address your
previous comments and send out v3.

Thanks,
Peng.

>=20
> Regards,
> Arnaud
>=20
> >
> > Regards,
> > Arnaud
> >
> >>  };
> >>
> >>  /**
