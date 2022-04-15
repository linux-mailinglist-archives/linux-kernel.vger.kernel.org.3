Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1447E5020BC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 04:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348907AbiDOCud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 22:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348960AbiDOCuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 22:50:20 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2071.outbound.protection.outlook.com [40.107.21.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B2CB3DD8;
        Thu, 14 Apr 2022 19:47:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQj4NcUrBHAri3o6fByBMzudSqcEoWckCu7pxqDgtaibKfFGoFBRrpc/rXm81O+cqH530JH4VYRG9EOz6bntH2M12iiT6rxr1xx5lCiLfOEGuZEWurM+4J5kLznQvbwQXV8xEyuf3I5R6KqrHM6zOPhhKrXIIKlXWeyQwE8aFl60ujIasZeWVMs/KXayzwElZj43X3VQixRSVEhWhD9ILJTeUaEoimqVL8eoXWFItg1jP3+Cp7XsnsDOYc7W/1RbjUReNHtXk/BoUciQLgoPHDcFtNj19qL0j4miwNq9yELMvW59TlJ17DmAbU799jdQdQF/l240mPc9aqXLh2tVVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kv0JeiCHy2VZPsmEdsR+kpua0Qt/VkfmlyL3dMK4yEg=;
 b=NbOuSHUbHYU6GhbtUUFyFI0DQQNDlGdk7uFa3qIz3b9uBszhJZ5FEBuSgu3NWt8q1bMyzH4ACw1KIIhWDlyFYss+gp5AMTwDsdtUoLAfd54kDoDsbqq2peDWztqvFJg+/oFDdtXpyRIo7bZ52hVLxjj3C/f0IeV8gTRxygnSalL1WNPsAjNpIaRAhkmSHj8h5lpS+zqFQImHceb5RxxyxhkoD60v5q78SYS5vK0MgYtk7sPpMETZvNnlBHPbidjxOwxpZsHPQQgurfXPDDIlZ+RVmYWQf+5EspgbSztH1F3vOAE95QZ7OC/tySfk6xZydAgN4CgWjb2VZ9pnOVlHJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kv0JeiCHy2VZPsmEdsR+kpua0Qt/VkfmlyL3dMK4yEg=;
 b=sr5BdiBVtbq/e9ZO86p4oFYJf/XT0yGVLxoPF8h2xsqjNiJ4njsEA6+HjrVyRQn6A3/cwlYnE8T3SGYNV0JhpmKl+JyKnp6WXG3MajxtW7auqBK5qqq/EoGikQhN1Rmz68L81xdU0NDUd9SwPlvQP7F0hIQl+glbVqkqslLtIs4=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB7109.eurprd04.prod.outlook.com (2603:10a6:20b:117::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 15 Apr
 2022 02:47:39 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6%8]) with mapi id 15.20.5144.029; Fri, 15 Apr 2022
 02:47:38 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH V3] remoteproc: imx_rproc: Ignore create mem entry for
 resource table
Thread-Topic: [PATCH V3] remoteproc: imx_rproc: Ignore create mem entry for
 resource table
Thread-Index: AQHYRNqqPUw/yuiN8kyJqdOjFsHRtKzvqn2AgACw7nA=
Date:   Fri, 15 Apr 2022 02:47:38 +0000
Message-ID: <DU0PR04MB941769592D17F5E590803B3C88EE9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220331084007.2323377-1-peng.fan@oss.nxp.com>
 <20220414161003.GA698343@p14s>
In-Reply-To: <20220414161003.GA698343@p14s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b20066a-cc7c-4e7b-56b8-08da1e8a4dd0
x-ms-traffictypediagnostic: AM7PR04MB7109:EE_
x-microsoft-antispam-prvs: <AM7PR04MB71092D6FB75E5B02382010A288EE9@AM7PR04MB7109.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qPa0RhKYmf8rVJtUYJHh6qpohItP0rPIXP6oZ1nKAXE7NMg3IRLJCunMSFWkz5NtN5veoO7lhiU9oR6jvfDkJYPu8IBD0/imJ0G+XJ4j4jB6kZgE0svxhCA1tt0klzaRYCOAaQLtUIxGmAG/WIA1qS+9Dsv8ecW696fcwe+QY7VT4PMluDXvxVdjkmw0Q7KiAO/wNnxvc07oO4oiGqbE9ogb7wKjdxQIgl4OG01lGGmcXobThTF6ev+JUnTXRxF25twK9t0VC5fR3GQV4sNvMPca2r76KelphGRo+a6Oi7npUNQBmqvbE+4NIxcj8bYwBrMsJ7t7PQPlprqra67TOdwLuebrISs5k2HzRM2kiVw3je8wb0FYZz5cvpn3Pw+jq06DH47NezU4zQZFq64uQziAmLqSVE+n2alRXNJocuEQKXO8DsSO1KS66kGjjysbleYiLdZSzkYIiC0QyXgv33/WVOe/oXF9jTbaRyGMV2s7kBZjsB4/IdKYZrnEGozcQtI75GAn/nOA/ww4u6P/gB5mvPEq/2U6zxz8/A3ROm15nbGRJfg2hCL70qquJa/DClwEX9kywKT1zCVoZqmRubOSqVIf9pYdVwwfumrcOE7wQwNLeW3ng+Fw3v+IEPrKRfjbIaHuwKdricnaI+fUTKyMIFUPZ51nQDn9s/6aHzwBcRfpyywAZI3pXf9lq9FwBVWZISsmb0/6ZoMohuPxyCvVXqddpmUmTOWqB6lUMPo/jlXhwg7BTSi3JQTbk/3Wx7FeoGpquoJo6zMeXKQPW1tXF+VuaaIfTWcAxOcQiLk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(38100700002)(186003)(26005)(7696005)(66556008)(83380400001)(316002)(44832011)(2906002)(33656002)(4326008)(45080400002)(122000001)(508600001)(8936002)(71200400001)(38070700005)(52536014)(86362001)(55016003)(6506007)(66476007)(76116006)(66446008)(66946007)(8676002)(64756008)(54906003)(9686003)(110136005)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h+oxFfGJjTq4AMI4TR34+/y2B5r245MmL8RA37Aoxy1dB9Q45L1R1glzQMRo?=
 =?us-ascii?Q?6T0zX50uceLBY2FOvcd/yRlwpL6sXM4gTQQY/58ofyKS1dGqC08vvmg6ORpu?=
 =?us-ascii?Q?f/fd/iaZEfEn9y3krxlaO4enc9IQaPzZPQo7bhhsK+Hr+c412954cx4Hz+Cd?=
 =?us-ascii?Q?vF3t4tm1EwhmKY5VFeJkam1Y4d9JiDX3FK1BmwluSmGrNvbcaaILNChupt6P?=
 =?us-ascii?Q?RCt2JT/M3rULSCWCFlBM9NsvNxervWs/VEvY7j+zQ+YSmjX1ahRTFjoKcrIK?=
 =?us-ascii?Q?vYcAMms7D4uNcdEslTSrU355ZbUYKT6O7g1Um4v9rjxbtW/AupU2dP01anIl?=
 =?us-ascii?Q?GWNMAFdhz6yEqatRIDVR+tkmZbmh1QxmaLsIlx2ZdlENAJXL8XkjCPR1KGeq?=
 =?us-ascii?Q?aO9pkIm+Gi5blz00EVLv8Efwioa4htgiYluXFXVyqPFz4cBzA4V2tjI9COyS?=
 =?us-ascii?Q?8Xla+a/kF7fPBhIrlNbdFq2rxaEoBqQbFTb4bP96X8cuqWIZCzVjwLc9nljt?=
 =?us-ascii?Q?mcnZqWedgPaECnuH5nr/ywQGBqdM2UR6xMO58sGWq1dlfiJvYMZ42O191f73?=
 =?us-ascii?Q?4cROA3505NBagZP4B84oE214WhQjBe5je3TYxMjK9KTHIjQvFrzPOsY0eaZJ?=
 =?us-ascii?Q?l4a+vR0WtItSIdKy0+cYNPldu49Bx8YPTPwDQRSIb4RGdSpXGReb9fjJjeSj?=
 =?us-ascii?Q?psdLRz/QKpf2NS8aLBgqEMN6rULAqgijf5hrrbAaQUEdSFCKYwh8zW88oFrc?=
 =?us-ascii?Q?EiHJ/RMdvjdGfHNfA8oi+A6zV7l/dDn0yxl/JeWhFNOzzlpxPhaN7g4IGZ+4?=
 =?us-ascii?Q?YyxZT3VhN/tqxwzxDBUnpmwR6LIwbFjgI0rvXTW8KJtHCrQDUDRwfpepfAem?=
 =?us-ascii?Q?SH5vCACF8kgMWlghOfWOWnxWDc1cqShB4zgTiEr7ocvyUD3gCKLTAKmtBk6z?=
 =?us-ascii?Q?fX5WHUlnDvCQ9sKc6x2pLSAJ7YyGYQcQ5agB5T1MT9bZ/MCIjGB/f8tAbUS5?=
 =?us-ascii?Q?fcTzuIZ0jRLY6WmqQlRBwxf5aid50Ph7iZXVL1jNDyqQFUINw8oOpNbA7FKV?=
 =?us-ascii?Q?K/aEUKvlDUfHu21R1wyetxKvQZXbNc50fOhnntbgI+moFjRXg9nXmiuhi+J4?=
 =?us-ascii?Q?qW8n7Wtlr8yQxOOB1nKDm3UhyethD7N0duYs60gDSsHxEljtA//Pv0Q3Pgbp?=
 =?us-ascii?Q?kFRarM0ISb+Z2za/NSjIYuZiaqQjc79zyKM4aYHGEyVgcX5zVmEkqSZV9s7n?=
 =?us-ascii?Q?WLBW/18UZoL9nH1tdD2NyfoONxpYl3Zoes/919ZRR4JKqOJMX2JIqrG4gtwX?=
 =?us-ascii?Q?Zxc1WmhG5U6TS8wKmZTG9IRChIWjoLstVlQ4oMbbnfc3Jfm2XOA4n8Hg1bRO?=
 =?us-ascii?Q?rS/ct4LPHv9J0Md25CthmOx5ZRMNUjcy3TJFRVIsvnCGR9pFd9oM2a5H0ass?=
 =?us-ascii?Q?zDCCJs8WZn1g7ZmzfNIYCLDDc7kxj941nVP7CR0H83njGbTKVPZ62UWyni2Y?=
 =?us-ascii?Q?KApZiP52SExMkbYZNgz+9Ixi8bkzpQ5rFZijU0SW20EnzP3wToOt8bMf2asm?=
 =?us-ascii?Q?FObQW4BJZl1CCHn81DqHOla5RfiLjJN1YINRBRqVd8v+PKrlw0IQc/LJkEPZ?=
 =?us-ascii?Q?vCWhdv4shmafqLxjpA+pXasNtZ+lJGQ7k18BsOJNkeLoOuoylzqg9/3gt2il?=
 =?us-ascii?Q?FrAl1t5TZRhANHyBOhNbgmZSYBZMkVOjedQzXrHOgTK94weE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b20066a-cc7c-4e7b-56b8-08da1e8a4dd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 02:47:38.4759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xF2wukaUuRmzPvOa+TSrHIxSAXtkFAMVMch7ukxEB1abMRt0pOEqvC9ZK7IcMxTYls1n77GT3nHm8okApXtjiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7109
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V3] remoteproc: imx_rproc: Ignore create mem entry fo=
r
> resource table
>=20
> On Thu, Mar 31, 2022 at 04:40:07PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Resource table is used by Linux to get information pubished by
>=20
> s/pubished/published

Fix in v4.

>=20
> > remote processor. It should be not be used for memory allocation, so
> > not create rproc mem entry.
> >
> > Fixes: b29b4249f8f0 ("remoteproc: imx_rproc: add i.MX specific parse
> > fw hook")
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V3:
> >  Update commit log
> >  Update Fixes tag
> >
> > V2:
> >  Add Fixes tag
> >  Separate the patch from
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpat=
c
> > hwork.kernel.org%2Fproject%2Flinux-
> remoteproc%2Fpatch%2F20220111033333
> > .403448-7-
> peng.fan%40oss.nxp.com%2F&amp;data=3D04%7C01%7Cpeng.fan%40nxp.
> >
> com%7C091803e93988488b2cbc08da1e313fe7%7C686ea1d3bc2b4c6fa92cd99c
> 5c301
> >
> 635%7C0%7C0%7C637855494116073554%7CUnknown%7CTWFpbGZsb3d8eyJ
> WIjoiMC4wL
> >
> jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;s
> data
> >
> =3DTDWgH8DNxGTQsen64f6Bqvr5t%2FmB7bA8qOF6Q9TlP34%3D&amp;reserved=3D
> 0
> >  Address typo
> >
> >  drivers/remoteproc/imx_rproc.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/remoteproc/imx_rproc.c
> > b/drivers/remoteproc/imx_rproc.c index 7a096f1891e6..f2bfc9077c19
> > 100644
> > --- a/drivers/remoteproc/imx_rproc.c
> > +++ b/drivers/remoteproc/imx_rproc.c
> > @@ -423,6 +423,9 @@ static int imx_rproc_prepare(struct rproc *rproc)
> >  		if (!strcmp(it.node->name, "vdev0buffer"))
> >  			continue;
> >
> > +		if (!strncmp(it.node->name, "rsc-table", strlen("rsc-table")))
> > +			continue;
> > +
>=20
> Any reason the handling of vdev0buffer is using strcmp() and the resource=
 table
> strncmp()?

I thought rsc-table0/1 maybe there for cm40/cm41, but rsc-table should also=
 be
ok, will use strcmp in v4.

Thanks,
Peng.

>=20
> Thanks,
> Mathieu
>=20
> >  		rmem =3D of_reserved_mem_lookup(it.node);
> >  		if (!rmem) {
> >  			dev_err(priv->dev, "unable to acquire memory-
> region\n");
> > --
> > 2.25.1
> >
