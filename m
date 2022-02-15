Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B01E4B665B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbiBOImT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 03:42:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbiBOImS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:42:18 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41246CA726;
        Tue, 15 Feb 2022 00:42:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/dfkUKdXzJNzAnNCk9MIJW1sZgiV4H01t5w1gC0WgdpwfnTUYS/h7JGT/Ji0Zz9Ct7YtGOn+Gq813y7NVhQls5E9eFfwBUzkVYiDc5hDcWkA8FmBHoG3BQB9RYPGieVqAnvHcg/1jhhKN3xxzRCVkngkEdCoZtoAnr/Bsizxw3PC9VH1JTBJyQAapZZwDkbvUo+vfAyYN4j5wZooTR69Ao0xfdK+U3i9BbO0A6OqzpLwSY84FqCsDN3XDj44981+1vZvdMwkVAq/5ImErAXyPoz4+BbidzVCmJiyfOWrsmsP4Paymlt15d6gdZZGivvpmpwPPIDsw1sswti4kQXGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shQXwar4YbbVkZVk+npYoS4d6/Oxo71R0L9xFHsqtrc=;
 b=k20fiE43ob9KuMCyFFaH8l7uxxfbo7M1Gz8WNpVKk2I0qDv/cfVo9iIm6PG01DBWW21VjYdzphu5g+bCPq7P+yPYcpR+uMgOU3dCAi2vShYPV3JNsQCX7yP80J9vPxm/bqK//Z+k5jOh6JEdE5sZYPdzT/wW14sYuOTw9PVqvzm7vixnzG67CaEH/xmlZDWWuCHisugXpDtYrz/j5suqaRX3vKmYXMmsqnK576T+snGenQWB75psOs5bH+wksHHvFsEZ7Ui3py6PwMjiY5/23FIwYKuVu9xHWJzfswU3TCidVzfqSqPOlCAaSFElruSI1UJYwEtwgiSoCeeUVUrKrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shQXwar4YbbVkZVk+npYoS4d6/Oxo71R0L9xFHsqtrc=;
 b=R0MTPuCeeqD3XR5+rceDrgQ7JR0keF3rxfrZ/Fx6bfNH+68ZERQ2WCNVeHeX7x3AETDNtdqUnEiKr+b9dB0wDsrlJu4ehLX8oo/svDQ1Vhtmf9lOJiGfCaeU+BHwy5V/nfven97pUVD5uJZRpwAFCD+pch1UdEiOJo1/TnM0vQI=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB6279.eurprd04.prod.outlook.com (2603:10a6:20b:b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Tue, 15 Feb
 2022 08:42:04 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::448c:19d:ca9a:123e]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::448c:19d:ca9a:123e%7]) with mapi id 15.20.4975.018; Tue, 15 Feb 2022
 08:42:04 +0000
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
Thread-Index: AQHYEpIEHEs++qV8cUuKksCGalsIFKyTf94AgADoy9A=
Date:   Tue, 15 Feb 2022 08:42:04 +0000
Message-ID: <DU0PR04MB941782E74ED59EB3AA93860788349@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220126085120.3397450-1-peng.fan@oss.nxp.com>
 <67ddf940-6f87-d8cc-8dc6-29a39a022265@foss.st.com>
In-Reply-To: <67ddf940-6f87-d8cc-8dc6-29a39a022265@foss.st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45c7aa6b-2335-4544-973f-08d9f05f0ac5
x-ms-traffictypediagnostic: AM6PR04MB6279:EE_
x-microsoft-antispam-prvs: <AM6PR04MB627903D77054ADAA9275A3CF88349@AM6PR04MB6279.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pIp0ssAPy29bsaIjZRwbCLaRcXbGOY2a7LymiP2uzGVoIaTMK+tZpcCCUX+uTop6sje0iqRvJnB8NdVA+UvuyZajhGNxm78oMGZYyhUFySFejw9mkv9hXmf+0vUrTPa8E2np1roAuqz/Ug6clRpYqV0ZjXFTkEV3wF69fjB8uiRO8AiwPMme+aYV0tSKCbvFfW7MpRtdH4gHtH9Qp4Yg6Udyq9i1uHFL61G1bszjvUPRA4p6IImAsPsYOz/VqUzZFrtFWIPOSKxv0ORDEy04LgJT/YuWHubY6+7QhEEPu0kPULuzwkmGxNdJ9RwAU65y5TMFj4zigrJo16c9ShCa4bSvZfDzTVqKZ49M9CY72leVDQNYCfSq0iQQOseOLpmrq2BZPzDHkJKk9BeaMWQCqRtd+0OrDaLGKq3zHvR8RmPoG9gfh5Yyzgs7ImXAUGVbN2PeoG3XZWUgcn0dtnmP1f2gJjDHHY6Sfchabj16LaSzdWjGALahcUbosY37WxjstOcV3VOeObp00YVrpl+mgn4BUQxeQaO96Op0mYdCwbY+Y0jfSYT3/gVFplR+LXNrvNWxavkDNmcDbvawEO7K5NNrfhN/CLekgJuzAd/fv+le6aBcFSP46xj/mONZG73dNAtXhIUjBRAQEdRxjPr8cAlOI8UK9cwI8q7Z5s6/hRuGYkR3eEZjmIizRzD5PowJKYR4f7OYliFXFIJdZzWXi9ejQIKq7Cpkea8IErYVEUA/nxN2UkrLsRiMZ8VOZqzd33oirAbP9aosLgy3SuAUGpY0XIzP+Qe2d0eQZGCjh8U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(8676002)(5660300002)(66476007)(64756008)(6506007)(66556008)(45080400002)(66446008)(52536014)(8936002)(7696005)(71200400001)(53546011)(76116006)(508600001)(38100700002)(44832011)(316002)(110136005)(966005)(86362001)(26005)(186003)(9686003)(122000001)(38070700005)(83380400001)(2906002)(33656002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Gr26Fi+NMu5uZwJBJiiD/rddNFidYcLWI2UxAHxdZlh9h3IYRDWLv25UvHUe?=
 =?us-ascii?Q?9/w2vNppxBbrFjL/NP+ESbb5UzDcfdWHji5M0gqw6Z8excc45CevtWI2X0Al?=
 =?us-ascii?Q?GVjaqZmVJa2VY5x8T1c+Q85wmE0VJtTmVoHFMfbHoRO4MbToLDFWCR0hRglC?=
 =?us-ascii?Q?rgSj2hGngOthFeQAQB+0Giqgz4yc7hfXxJYJqPwiFXSN0PFNbYkHnmz0ueIB?=
 =?us-ascii?Q?d6ajJ0CKyBI3bhBD6xQy8vGVQIlpBXv1muDqC7nYv3VRPb/KdsADJSanUkmM?=
 =?us-ascii?Q?fK3Q/IRr0w3G6yJTxFQYDr+uBUUS37iC8t91y7ahk6b3xbWtgJ2IZA5iL9s/?=
 =?us-ascii?Q?J6LEVtr3T3EjRm5k2LdPZtgcxd0v8gaMbFN3+E3wdGDkPtwZVhK3BCDCvPDR?=
 =?us-ascii?Q?EUymoD5eP9pl/KLHfwp+ENx89zyiT/qy/kNCV45UZi4adtHOSrAod/gQJUcG?=
 =?us-ascii?Q?ujfxkKNUlS8S/nMrEX6MvegHKA+Nm2kGY8RQctAFyRJuz8+8NbIrl/OfJz0+?=
 =?us-ascii?Q?8XEXfCmGkHEY2V9DI/yOgYv6L3Vf0hLAIeB3jhDlCpZxTYunOM61HIXnUf4F?=
 =?us-ascii?Q?NmU0xLGEtq//oru/Amf4G3wv2JBof8dWvuCRqf6ICppDcMyTL3pyYgL6KkFX?=
 =?us-ascii?Q?fxxNwU9FFlMrWZ1sOvZ2BcTWiYk0O2WXG3YJbDNttyHdQn+4dH4raV5DNKUt?=
 =?us-ascii?Q?cLz00GtXRQjkQydR6Yg2m1UFnf/IoaJ24uxDERXanX96+wHka82wUDo65hmo?=
 =?us-ascii?Q?OWCV69Uqds18UbdheKN11Nkptu+GwRQeFTqVdMBMCyZRpoIkPpwTP9DEc8AI?=
 =?us-ascii?Q?haQKjn4DOMSXAwfAShPLzeWi0piihJC0gEw7jFGChFC+V2pvGH7VNB7HiIg6?=
 =?us-ascii?Q?jZx2QABKxahlSCXe6F6PvZPuUWkJapRccVaXirMhlkVe4zVkTOkTaS3qN9aL?=
 =?us-ascii?Q?C4TeStM46Fq7Y2bsUSOY8qIVBorhGjSTK9qScYIZ5p1dODwBh1hvO4ctVQyS?=
 =?us-ascii?Q?GjdcHWv3jBww25w5q6PqoEdZyHXBXeKCp+S09PMk6hDs/QNffVt1E3nNlyxC?=
 =?us-ascii?Q?teb4Rp8pDRwohGToxmUg6tDy5h1gRLhV7veJSTvXYOyCJ8OVeJYZNxTSKg14?=
 =?us-ascii?Q?ShFZ//8HSt+3NcKQpA48wyT87pehLZyo7SBnPNsW5yqg4CZUvXdD7XC+G+Mt?=
 =?us-ascii?Q?V2qFMW8laAGrhUlizXz0jYFv69vmAhchv19FbnvbfvIc6ijePRrXdKoe46z8?=
 =?us-ascii?Q?wMOUpq424uDN0ZrPmzM2vK39geRC8SKCsgLj23e1ZifiMYIYWZJEnH8KYPLE?=
 =?us-ascii?Q?CTHeZZOpyg8+LVPSvSIoibYLLjzaYWSSePqil1EDLv3zoNUk3ssMZbXCpEdu?=
 =?us-ascii?Q?VrktUpGyks/4VSfeEx4tA2xWU3zCZnO+d4jPnIJjB1xzRxzF/7bwoUvmxeoi?=
 =?us-ascii?Q?I2u+nJx3duHRUvVYaycMj0hranhvH5W5i26P1p3zY4cZdHCdiB9HENeFdH/g?=
 =?us-ascii?Q?H/BG4wdpoXx6Rx3IYD3VOe4clukus1fQLfWMZQwZxDWPdjTVM0oa9xIe+R6a?=
 =?us-ascii?Q?IUxDF0vt5YKizWdP+t7PA26fdqXhsrS47Hs9Ha9fJA52gf6DzcxBLpSW3f+H?=
 =?us-ascii?Q?dKQNGNqkTVH6HG+MVTXGelI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c7aa6b-2335-4544-973f-08d9f05f0ac5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 08:42:04.1510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qAxb0DTSKwpaTyu0p21KRy0hL8MylIYRUt4EwCttmJuuGjoMvwmotWQdIbHaQuKxUJP18advket3HxDijxJivg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6279
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
> On 1/26/22 09:51, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Current logic only support main processor to stop/start the remote
> > processor after rproc crash. However to SoC, such as i.MX8QM/QXP, the
> > remote processor could do self recovery after crash and trigger
> > watchdog reboot. It does not need main processor to load image,
> > stop/start M4 core.
>=20
>=20
> On stm32mp1 platform the remote processor watchdog generates an early
> interrupt that could be used to detach and reattach before the reset of t=
he
> remote processor.
> I need to test race condition,but I suppose that this should works if the
> resource table is not reinitialized by the remote processor firmware.

In i.MX8QM/QXP partition setup, resource table will be reinitialized by
remote firmware.

>=20
> Another option for the stm32mp1 is that remoteproc manages the reset of
> the remote processor.
> For instance this allows to save a core-dump before manually resetting th=
e
> remote processor.
> But looks like this use case can be handled later, as mentioned below.
>=20
> >
> > This patch add a new flag to indicate whether the SoC has self
> > recovery capability. And introduce two functions: rproc_self_recovery,
> > rproc_assisted_recovery for the two cases. Assisted recovery is as
> > before, let main processor to help recovery, while self recovery is
> > recover itself withou help. To self recovery, we only do detach and
> > attach.
>=20
>=20
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V2:
> >  Nothing change in V2.
> >  Only move this patch out from
> >
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpat=
c
> >
> hwork.kernel.org%2Fproject%2Flinux-remoteproc%2Flist%2F%3Fseries%3D6
> 04
> >
> 364&amp;data=3D04%7C01%7Cpeng.fan%40nxp.com%7C9e8a4ea774124a896f
> ed08d9ef
> >
> e9ac6c%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637804609
> 168765154
> > %7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzI
> iLCJBTiI6I
> >
> k1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DewUl7diAOfkomSQMiPDQ
> o5A6c2Hklgo
> > 8xYbMBk5A4Ic%3D&amp;reserved=3D0
> >
> >  drivers/remoteproc/remoteproc_core.c | 66
> ++++++++++++++++++++--------
> >  include/linux/remoteproc.h           |  2 +
> >  2 files changed, 49 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/remoteproc/remoteproc_core.c
> > b/drivers/remoteproc/remoteproc_core.c
> > index 69f51acf235e..4bd5544dab8f 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -1887,6 +1887,49 @@ static int __rproc_detach(struct rproc *rproc)
> >  	return 0;
> >  }
> >
> > +static int rproc_self_recovery(struct rproc *rproc) {
> > +	int ret;
> > +
> > +	mutex_unlock(&rproc->lock);
> > +	ret =3D rproc_detach(rproc);
> > +	mutex_lock(&rproc->lock);
> > +	if (ret)
> > +		return ret;
>=20
> Here we would want to perform a core dump and manually reset the
> co-processor.

It is self recovery, not needed manual reset from main processor.

> I suppose that a new rproc ops could be called here in a next step.

Not very sure, but core dump could be added if needed.

>=20
> > +
> > +	if (atomic_inc_return(&rproc->power) > 1)
> > +		return 0;
>=20
> Do you identify a use case that needs to test rproc->power to skip the at=
tach?
> If yes could you add a comment to describe it?

Just to avoid some error path. I think only when power is 1,
and self recovery could attach again.

>=20
> > +	return rproc_attach(rproc);
> > +}
> > +
> > +static int rproc_assisted_recovery(struct rproc *rproc) {
> > +	const struct firmware *firmware_p;
> > +	struct device *dev =3D &rproc->dev;
> > +	int ret;
> > +
> > +	ret =3D rproc_stop(rproc, true);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* generate coredump */
> > +	rproc->ops->coredump(rproc);
> > +
> > +	/* load firmware */
> > +	ret =3D request_firmware(&firmware_p, rproc->firmware, dev);
> > +	if (ret < 0) {
> > +		dev_err(dev, "request_firmware failed: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	/* boot the remote processor up again */
> > +	ret =3D rproc_start(rproc, firmware_p);
> > +
> > +	release_firmware(firmware_p);
> > +
> > +	return ret;
> > +}
> > +
> >  /**
> >   * rproc_trigger_recovery() - recover a remoteproc
> >   * @rproc: the remote processor
> > @@ -1901,7 +1944,6 @@ static int __rproc_detach(struct rproc *rproc)
> >   */
> >  int rproc_trigger_recovery(struct rproc *rproc)  {
> > -	const struct firmware *firmware_p;
> >  	struct device *dev =3D &rproc->dev;
> >  	int ret;
> >
> > @@ -1915,24 +1957,10 @@ int rproc_trigger_recovery(struct rproc
> > *rproc)
> >
> >  	dev_err(dev, "recovering %s\n", rproc->name);
> >
> > -	ret =3D rproc_stop(rproc, true);
> > -	if (ret)
> > -		goto unlock_mutex;
> > -
> > -	/* generate coredump */
> > -	rproc->ops->coredump(rproc);
> > -
> > -	/* load firmware */
> > -	ret =3D request_firmware(&firmware_p, rproc->firmware, dev);
> > -	if (ret < 0) {
> > -		dev_err(dev, "request_firmware failed: %d\n", ret);
> > -		goto unlock_mutex;
> > -	}
> > -
> > -	/* boot the remote processor up again */
> > -	ret =3D rproc_start(rproc, firmware_p);
> > -
> > -	release_firmware(firmware_p);
> > +	if (rproc->self_recovery)
> > +		ret =3D rproc_self_recovery(rproc);
>=20
> If some platforms have to manually reset the remote processor (without
> reloading the firmware) the name could not be relevant...
>=20
> Following comments are only suggestions that needs to be commented by
> maintainers
>=20
> What about rproc_attach_recovery ?

Looks better.

>=20
> > +	else
> > +		ret =3D rproc_assisted_recovery(rproc);
>=20
> and rproc_firmware_recovery ?

Yeah, better.

>=20
>=20
> >
> >  unlock_mutex:
> >  	mutex_unlock(&rproc->lock);
> > diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> > index e0600e1e5c17..b32ef46f8aa4 100644
> > --- a/include/linux/remoteproc.h
> > +++ b/include/linux/remoteproc.h
> > @@ -529,6 +529,7 @@ struct rproc_dump_segment {
> >   * @elf_machine: firmware ELF machine
> >   * @cdev: character device of the rproc
> >   * @cdev_put_on_release: flag to indicate if remoteproc should be
> > shutdown on @char_dev release
> > + * @self_recovery: flag to indicate if remoteproc support self
> > + recovery
> >   */
> >  struct rproc {
> >  	struct list_head node;
> > @@ -568,6 +569,7 @@ struct rproc {
> >  	u16 elf_machine;
> >  	struct cdev cdev;
> >  	bool cdev_put_on_release;
> > +	bool self_recovery;
>=20
> This bool seems needed because we have lost the previous state before cra=
sh.
> I wonder if a new rproc->state such as RPROC_REBOOT could avoid this
> boolean.

REBOOT not able to differentiable self recovery or firmware recovery?
Anyway I'll check to add a BIT instead a bool.

>=20
>=20
> I will try to test you patch on stm32mp1 next week

Thanks,
Peng.

>=20
> Regards,
> Arnaud
>=20
> >  };
> >
> >  /**
