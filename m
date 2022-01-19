Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D134932DD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 03:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350796AbiASCVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 21:21:55 -0500
Received: from mail-eopbgr50053.outbound.protection.outlook.com ([40.107.5.53]:54215
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238636AbiASCVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 21:21:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCzTYCUMDIeeWXGph/Q0IsipV/wt80ggcu+GmqJOTTL3CKtYlENRL0Zdpiz4HSAN+mrLTYl+6l8Noa/mZUEADNvqF+dt3723I57LJ+6Ex8q3ZaVePU6bwFUq/uPgpYTCAbK7zqyYvYGJzXucPZm5LtukRmtI+wfTqjtkpmkyeC9EzBiG4XLOEXXi9jjYU3ACVzrGJdLMPZ0qzq7vAMwNvC76rP/qiFymxM/rEDgIMih/Y9+vOyycj5dUDyLiR4tNxTfG4rw+DFwCf54ngWJuRhfzg2/pqbfF7njHc7sfw6RIZnzOs6DNKrFezLdqjW63fzU66oZSq7o7IixQtXXlKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pim4kdSjJOdke+QhrnuQaz10MVCGeFidEsPkw20yZbI=;
 b=LPeWguKb5FppDPU/OyXSFulH61KOGx1HGNRVjTN5UH+m4X+Gu6LfUQFB27FJzbcfJjmvkxuHb6Gi7R0rHIIXKb/6kOYKwmYOl/IFNoj4qlWEh0QTAPnfzR6ePyGw9s1xIY0lUow/Xq9snj+0v5NZBF8WcFpAzhSvlwQ7e82j0c0k81mMIRbo1zLYKguxKqC5huIJnKjijDI6SEpnWNAk7LDGgKZfGVMtuXH4IN4j1g+x52Z5ufKWTZ7/nyzTAp+kJCETuNyuiNtchFXPTm8/U8/KpqSeu2/+0IFQZcvGm5IMHgXTbDox+u5FDpKwsGDewa0aPhw50090t01C44W2kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pim4kdSjJOdke+QhrnuQaz10MVCGeFidEsPkw20yZbI=;
 b=TYl6exDpC8vtV0wgxA+rvzGmoP2uO+6wnbykPEersYYxiXF1B6XOj875qKeCJpAgvhSkB+7JFoneOsaIZ93JnQKvpEMOcwqQQFxyGmSkYKpP+70ksyVFq3Gee+qVhKj2UTRqmE24o6T5WML+dCzeXHqH21sA3YfrwuZeoI8FTto=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB6PR0402MB2694.eurprd04.prod.outlook.com (2603:10a6:4:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 19 Jan
 2022 02:21:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%4]) with mapi id 15.20.4888.013; Wed, 19 Jan 2022
 02:21:50 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/9] remoteproc: support self recovery after rproc crash
Thread-Topic: [PATCH 3/9] remoteproc: support self recovery after rproc crash
Thread-Index: AQHYBpwuyCEa2pv3vECsE+uXdwTL8KxpKb2AgAB/ZKA=
Date:   Wed, 19 Jan 2022 02:21:50 +0000
Message-ID: <DU0PR04MB941748388F7BF5DF9CA0C4AE88599@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220111033333.403448-1-peng.fan@oss.nxp.com>
 <20220111033333.403448-6-peng.fan@oss.nxp.com>
 <20220118184453.GE1119324@p14s>
In-Reply-To: <20220118184453.GE1119324@p14s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9143bce-0a20-4efe-fa0c-08d9daf27350
x-ms-traffictypediagnostic: DB6PR0402MB2694:EE_
x-microsoft-antispam-prvs: <DB6PR0402MB269482E84F7ECC902E7706F388599@DB6PR0402MB2694.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kmfhAWtP5bHx501qtmQNemS06nk+ECa9itwqVXTe2kv2ktr9ZypT9z2g2sU5A6uueVb5EBzbLUpLXS4P2vo6cqKkruZ6ucBSz7R/0UcRHN6Sl3ydBfjdk+e2geAvYTWVkV1p+/wttqgXGaIQ9MfkFR00jd/wvvW3zhiyqH60TgrwyLEvcrTrPJs04KSCOsX0035ZS4P4uBY5t/yBHyb6wmwmUZUh2zoC43YW4MmB+doYYT7hMwsMsyG6R4wbbRhrYmEL7MAS2RwJgnzwIwXDQmgDyoCSRUNe+k89QUsXNJqguLOK940czc8BNOoUj/9mVVRX6BsJdUqcXtR3mZM20BHMN58x44vpCSiO+N+6I9BqjduA6TZeR4UUDzYqsvK7B1YNdgHWKxqb23NMtqkhqZDEOSrVhWt5m8SEGdBC9LsZ5SZX2HxOWW0FO7EWtxrpKeEl7EZDW79Qai89oXCPQ8CLdWIe9z8/5Cc+vSfgO9zQ6PHxh1bT2+ab5OZwl0LTz9zUljrwL56SoXqHz2nd5awVUY1IYXwMu3TOm3oTsw8FaQN/C0dqR8Nawp9xVth5ZdwVXjKkCtyB6392EZaQ5CMeT6U9MFYGv+wsBry4DrWVSKYqZBcsGWaI94/GJIUhwxxdeHlrmKgOOwI6WUNqpGw8Y4BXCRxECo6nf6Wdt+lbqRUNxtgcxIE651FMUDS+g5Nczx5cDzS8Aq8WzJeNMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(4326008)(8936002)(5660300002)(122000001)(7696005)(44832011)(83380400001)(55016003)(9686003)(508600001)(38100700002)(186003)(33656002)(26005)(6506007)(86362001)(110136005)(54906003)(66946007)(66556008)(76116006)(66476007)(316002)(66446008)(2906002)(64756008)(71200400001)(52536014)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kBD53rt4HhDUAylKCBVoqm+3wKdW0Q7DaGc9yHQx/FrbmBVz64uZKgiVuxKp?=
 =?us-ascii?Q?2iS+rvyajvJzOkNkgFRvM0IibwGl0KF/qaJMzjrq9TfQE0ay45xzJKYtW8RH?=
 =?us-ascii?Q?AZH9bL4DEG23FEBFTk5ciTiUOFLYg/yh7sVJhQqcjNTjGc2QWkJhvq/TMNlz?=
 =?us-ascii?Q?q7x+38dyZi4OTN/gOog5dDJ4yhL5lX+a8RyJDywg0SPIseALGrXdD8MScs7T?=
 =?us-ascii?Q?gxL0wWgUARXF0JF3IrYoSsjWc2DXPEwEboCfYmUCy+CRs1ZkG8xtpXLd3WnO?=
 =?us-ascii?Q?H/nYtFjDCtAZBd4E+m/VHZTO+Oy/lykPLrwkSYmleR82Mzzp2KlSDhToVdFW?=
 =?us-ascii?Q?YjpFYHFHb1fL0dG4fU9aSrL650SNHNv8WpPVvS2azT1zYbLx+7r2I0oZq/gJ?=
 =?us-ascii?Q?LYPxaobBVFhiGJRslhmqZ6l4leyKRRotXLEWn8zwLo2hOu7iygzXPTEBmXyK?=
 =?us-ascii?Q?C2Hf7VNeQag+5GiKTX/CTMYuz4UU4TvR1AjGzxISRtsku2e6Hnb0goYYYZqY?=
 =?us-ascii?Q?cwEs6Afzt1xyhQM+U5HTHLegSFfgshts8dmZSNZE+6urPiWwiGRzsjnEH6Ra?=
 =?us-ascii?Q?CfiHwSk4J6RzVb62EfyV/ddaHmaJjX1z8XVQyPBVW3rAMyC8abXCTE0PXXnp?=
 =?us-ascii?Q?bV5JKUcr1cEt449zgDAmnl3SoFctA9jlHllqUXG4ntwOP7ab7ZkyC81EdIQr?=
 =?us-ascii?Q?6hTCOOVv8f6rSpnCNlKXWf/NEeDjUFOrv3E6DmMWwZH26MAYvOvkNnU9igUV?=
 =?us-ascii?Q?I7aMaYIvkGLFsinAJTWY383WGgRk9137nMe6EzABZiq8kydh8cr+B0UvlVyi?=
 =?us-ascii?Q?QaBA2XBK5/oJdR30kUQ/9jYivjtt4pwqKTW20ukmU0MsEfup11piSh1WSTsB?=
 =?us-ascii?Q?4Az7mJOqtIPfMv//CmbNi3FzVykplHgk/ixTJQWztKobqUJzdyCCe87XA7Cs?=
 =?us-ascii?Q?uFJvasIMpX31H/xDTUb0ve5rSvGFbOx4Jf5igkhmwT0NhdlVqr10J4ThSvDP?=
 =?us-ascii?Q?e5vG+xMLVEk0OJpDDAoIJQ3faQi+qYgUm0VfYDoRPuqs3RyuU/ZCTjCug+vE?=
 =?us-ascii?Q?lhTBjrExkyMJWyL6Fq66kVUkbE0zR7BoeG/VtGN9atQw/u+nL8ORNUM+yvOg?=
 =?us-ascii?Q?4J6+OXe7cbT4DQ/1k7Q0aaJnD66ydWi1Obc3hcyd/znOT9xEjpKy0CaFu5qj?=
 =?us-ascii?Q?ChNA0rm+DFBmqEjGgUGFCrHHO6rpV7MhYZc+Azrzni5zdxPk7jBBWiP29PGL?=
 =?us-ascii?Q?DBBOUkUYViXwNWLL3UjeYcsmzOvuXq3TgK5omizI8ip7jwM/KH/vrf8RP6Ot?=
 =?us-ascii?Q?4mIQJh9Ymu6V/IHETz04kdOF9VgVIAEkT9jIe9kqotSLWZmM8qxu0thfnzbW?=
 =?us-ascii?Q?UY+MLVlhVSmvP64J5WDWlrpZmUqYbRV/st0+w1c8W5cmNSgzFABDOvCPD0qI?=
 =?us-ascii?Q?FAKDzUkIf2Px/FRwO6jhCWfBtjCLZesF8stXN710ntF6AWUy/1zJI4zmE69s?=
 =?us-ascii?Q?kXlNGQVup/H1NlMjp0TvrT08mU5KRTL6Lr6nVgPxvkBYr9pz97rgHFNUPUiu?=
 =?us-ascii?Q?qEr91IJvgTlydmwJF2AmJw+ifOP77qpvNBRrL4O0+cY8yTTZBuKkM45TpJZh?=
 =?us-ascii?Q?kuouZ+lfzmAoGJjdD+Y0MWY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9143bce-0a20-4efe-fa0c-08d9daf27350
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 02:21:50.0638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H2J+n1hMjzwBeg71patFRrkhUBaSLmznXxZYHRwY0AZ+041FFtL/2zVwV4fLQbCAiOmJL/s+7sPYAu9wivMLIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2694
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 3/9] remoteproc: support self recovery after rproc cr=
ash
>=20
> On Tue, Jan 11, 2022 at 11:33:27AM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Current logic only support main processor to stop/start the remote
> > processor after rproc crash. However to SoC, such as i.MX8QM/QXP, the
> > remote processor could do self recovery after crash and trigger
> > watchdog reboot. It does not need main processor to load image,
> > stop/start M4 core.
> >
> > This patch add a new flag to indicate whether the SoC has self
> > recovery capability. And introduce two functions: rproc_self_recovery,
> > rproc_assisted_recovery for the two cases. Assisted recovery is as
> > before, let main processor to help recovery, while self recovery is
> > recover itself withou help. To self recovery, we only do detach and
> > attach.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
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
> > +
> > +	if (atomic_inc_return(&rproc->power) > 1)
> > +		return 0;
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
> > +	else
> > +		ret =3D rproc_assisted_recovery(rproc);
>=20
> The problem of how to handle crash recoveries for processors that have be=
en
> attached to is difficult.  Finding a solution for that should be on a pat=
chset of
> its own so that people can provide input.

ok, will move this patch out from the patchset.

Thanks,
Peng.

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
> >  };
> >
> >  /**
> > --
> > 2.25.1
> >
