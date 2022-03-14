Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801F94D7B9B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 08:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbiCNHdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 03:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236659AbiCNHc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:32:56 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2078.outbound.protection.outlook.com [40.107.22.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F348140A25;
        Mon, 14 Mar 2022 00:31:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4WOzDZL/kaTscOujJ4+TLQwvPzMCv0M3PE9xBKFbZqXVfJ6IZbl/8ZKxNzFTXmwgDRbSPGEz8uH/0wI4BMj5exqKzH559VdTP0j/PaeYhTmx+SpiI1x0S5eb5bkXEzRU7LzHOqs2gnRT9Ee011pibther43vIpjv/3WlevsyDd6+p1jMN/xhMzIHBHYHW1E6l0ezQym4R1o2ZSNK467YCOAtfFwHsQJ85Ck3MF++sBewLCDk/UIh4AmpRQAyD+fYFyUi/D/ZwnlH/ZpDuviR+BVpyqbintjP2wniyHSk7Vu4uJ6n2P2tpPveq9vFr25z9NZ9lpujFwGwyS5wPs50A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixebiNoEZOIfiY9KXQoiqnJS6JypdCk3YoWd7IAumEo=;
 b=Rty66hWO7Ov9jnRf1qx1QQUNCluLeFe1KZXNgbWkK/TYMisvcS5pEOyCXQFozRs+F8MEUXkqVOnTQd6wLs8AQVI/oKSJQwUtEFXQogq9G/EnidPhcrcaymZZANnRxP4ZVkIeKbE4+NZvPsg9Obz3SJheN8yj3JcElR+ozwGOxjAQlfcqYi8BXO5zvjNRS6rzug8JgLNoQK05a2lpQqWPiWQ/GxRSjlHy99sfvwaroTUUjIalhd3aht9y/jp41+7ayDCnYjmL07k3olXA0/dlGV4AYwVI9PZCWq75BcLCoi6Od8Ve/pfcAC1udW7Ll5nTI68FBOLqyg67JJFDQYVl3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixebiNoEZOIfiY9KXQoiqnJS6JypdCk3YoWd7IAumEo=;
 b=Sc59jEwyLLNrVAB3MaKHSS6PweAyjHxhp4RL8Nv/LcGz3om/OFyES51Xi4s+Rq3Pab4hJmdMDu9pSr7SurbooRQ+xKFiHIqrUgrGGA4stIC/OzFaT+b+5sixsMuBWVJLHMNFMfKC38CUk+zETor6P6kuwifmTO4saAuI05JrSsg=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB5014.eurprd04.prod.outlook.com (2603:10a6:20b:12::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Mon, 14 Mar
 2022 07:31:44 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7%6]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 07:31:44 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "arnaud.pouliquen@foss.st.com" <arnaud.pouliquen@foss.st.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 2/2] remoteproc: support attach recovery after rproc
 crash
Thread-Topic: [PATCH V2 2/2] remoteproc: support attach recovery after rproc
 crash
Thread-Index: AQHYMrLihGYki8t5pUaIEFqC+w9Eway6i3MAgAP35+A=
Date:   Mon, 14 Mar 2022 07:31:44 +0000
Message-ID: <DU0PR04MB94174193978D834B7C934E9F880F9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220308064821.2154-1-peng.fan@oss.nxp.com>
 <20220308064821.2154-2-peng.fan@oss.nxp.com> <YiuZMpTZ2eGebAxz@builder.lan>
In-Reply-To: <YiuZMpTZ2eGebAxz@builder.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 378d97ec-4e99-4f7a-bc1f-08da058cb0db
x-ms-traffictypediagnostic: AM6PR04MB5014:EE_
x-microsoft-antispam-prvs: <AM6PR04MB5014FDAE183EFA7D9CB33A46880F9@AM6PR04MB5014.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vMFS4cSu6cDTXaRnhvRodcMF9JSmB/BFJeAF2uC6wvN4Bxhi0QvOVHGk4RdTBvt8Y0ifvjKS+0qZcBK8j6gM5wJ8mW+XRgdC3/1TcsLlvQwjK2QKYl/DJENqRwEOwWai1oH3wPk61asbzJmfidlJXPEf/nepC2O5CxOeEbukwQE96O/OwVWfiCD1rSClbPqfMglwz0mCW5KY/tfvZWI4Th04SxVWes/pOTAtq2iFINSNkpfDFziKyPHyTrohq9YZ5JLFfT5VpDE4mzwomaWRQ1xoyvNOZfLM+6b1mNSHMwhsrYMO+u9RjeZthjx6NC5M85X9kZZBG0otiwNgdL7nJnF7TyS6D2OLY43EepKXfCo0ftidkJVjXYThIdBiF5o2CgXcoBumBAnyJfT72oz11eSZFDxUv8s8biooafQsxh7XGU2u84//vj++TXXmpIyYBraGvWUAT78OO6Y0T9ZwYdFAdMpLkrQT3eNyD/kgwy3ZIkgLdXr/dGa9rCrXHTdE/iofDX29y5Fy195POyX1uN9Abg1wPuPfQf1QDxq8TGwNIfsvaT1PtDk3hv9YDNgaVpoiwq3TWaMHcQlSv1KGApFJy4aNnibFDwrdX3MBrWopG7c0gv6QM+GCKSch7L46HLz2Et4ytiafCbYe5uieoJ09J5ivbFn0x99B2QAKpkOEJGUW9sx9LKoEZZ/7F3EqWFt+uCx6G5r69b2CrFSUGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(6506007)(83380400001)(9686003)(5660300002)(52536014)(55016003)(33656002)(2906002)(44832011)(8936002)(38100700002)(86362001)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(38070700005)(498600001)(122000001)(71200400001)(4326008)(26005)(186003)(54906003)(110136005)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?26u5fiNvCuqIb2PvFC+cvLUpYQan/ohfnOJHXss5IE8+Aql0u1WX2AEme7Xk?=
 =?us-ascii?Q?xlKV7FxQCHJ1FjoZI55yUATT4OAFFxD4uk3imHKtBIRflvebHEsL7s0OOfVA?=
 =?us-ascii?Q?0gWjHArxMrLhFqQVunD7siaHNakIoORn/Z7KEC2OgSeFyT4SfxiLaofZRcJ9?=
 =?us-ascii?Q?8RYn/8qmtoia185UssS27UZ++/ZL/RX+nyEOfSDXU7Zzbmfxs3bh10NjJ0Ru?=
 =?us-ascii?Q?rhB+P64SHud/13R0/GHM7dkLUiC+A3GG/deUqItDtMiTaN4G17hjiaqz4Vjl?=
 =?us-ascii?Q?u91jbfAY0a5XrNi0WHHEIAqIDfA11scSm05GrkK0ohTB1JmJ1F1KjSEBODHs?=
 =?us-ascii?Q?wpXP7o2cdDgGqB5uAi11LGyc7ReoKMJQBTvuCHuGcqWjjAXO92Wa97u9zipT?=
 =?us-ascii?Q?sQSPxv3GjINN2tvBp8NEdB8ExfmdgTW5ntYujpV3fj6VUS6kRpiHnKTRrMKq?=
 =?us-ascii?Q?PBPo9GVSNl1Ae0fzMFyAal4N98n+mypMLuZkB5bSsgiaHJdENDjZkOYixOvt?=
 =?us-ascii?Q?SWZkyF7icsvDMU7dCbtw9/j3ZjaiBDwrTEYYsXTFdfBf4BqMmliNTh73x9Md?=
 =?us-ascii?Q?iup0idwkF+PBqlfgG5jTI6psnrEqX8BMxZ381n7QNo8HddL4cvglk6jWbMiC?=
 =?us-ascii?Q?6SOwTyyWN/m3tz67qyORPLfd5IjNYhvnei0NeQ01lfoB1IEJpiW5nqqzWjKR?=
 =?us-ascii?Q?rqfLTbuZWog8glHZJkzd97ERjus0ZTRA9MSDf/I2i2FlzOWrv4b3hUzeozvP?=
 =?us-ascii?Q?hOW8cwIMkaOXOYoJaxKgu9C/Usi6iahYN63UL8Vpo0I4xTprR6scFZOI2hHA?=
 =?us-ascii?Q?bjih4ZTq+m6UI0V5b3tWi2a0ScqhUOqglSC2wmypQ8jf+Ffx8VAT5oWIHrMj?=
 =?us-ascii?Q?vKBuula11IUTFdTApzsg7mKi5Dvr3TdJU6Yd4opyqoZ7GyNcfm/VUd/9/2lc?=
 =?us-ascii?Q?ezGBqvhnhkuf9wrYJHhbcGjg1LSdT/sg04cMc152qKMnZkYMK2EBJfVlCbRt?=
 =?us-ascii?Q?JA3g5B5L/GHDGWvxwE6uHxz9yIRE94B1noBn25Z20ByeDgRvHKgZTsi3lgMt?=
 =?us-ascii?Q?XgJyqHTl/lapJ4siWqV9EzasPkMzIlkozpZNUViPUeIODiTlsJW1bxz1/zJl?=
 =?us-ascii?Q?PjlICSZato6RHDxKeCFXw6tyw8DEJ5SipIw4YZxeOzGGq5iz76xBEEM7cxvA?=
 =?us-ascii?Q?80zd+EgVo7U3OrYBdh4QPXtNrm5MTWXelyalWjX6rRFojmut/jJtaZj9AA6O?=
 =?us-ascii?Q?4wNF6XOwe7pMpRjrkRrLIbamLhtbBBiiplpq3ojWuT68vbkm6YJcI6MTBopG?=
 =?us-ascii?Q?9aN3bubnUfZh2oAVXoaIYBSfNKDFbHA9WoIfAFyzb8GlFbsK618DjrMUqmIl?=
 =?us-ascii?Q?iSS+no9jkkKCUBbv9TFQA0LKLZmAMxfwmyasTWt/knx3spMDwIlMn0rhnxH/?=
 =?us-ascii?Q?awqLPakcqYY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 378d97ec-4e99-4f7a-bc1f-08da058cb0db
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 07:31:44.6003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yv5JVU52inqyz09SuXJ39iHwT4iDGnNfI2k0D0LHQGVUoXMA5JBDHSBE6fT+bybJwUcMuJWtAcFk8BRl20pYtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5014
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V2 2/2] remoteproc: support attach recovery after rpr=
oc
> crash
>=20
> On Tue 08 Mar 00:48 CST 2022, Peng Fan (OSS) wrote:
>=20
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Current logic only support main processor to stop/start the remote
> > processor after rproc crash. However to SoC, such as i.MX8QM/QXP, the
> > remote processor could do attach recovery after crash and trigger
> > watchdog
>=20
> Does it really do something called "attach recovery and trigger watchdog
> reboot"? Doesn't it just reboot itself and Linux needs to detach and reat=
tach
> to get something (what?) reset?

I mean the remote processor could re-run without linux to load firmware/sto=
p/
start. Linux side needs to detach/attach to communicate with remote process=
or.

>=20
> > reboot. It does not need main processor to load image, or stop/start
> > M4 core.
> >
> > Introduce two functions: rproc_attach_recovery,
> > rproc_firmware_recovery for the two cases. Firmware recovery is as
> > before, let main processor to help recovery, while attach recovery is r=
ecover
> itself withou help.
> > To attach recovery, we only do detach and attach.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V2:
> >  use rproc_has_feature in patch 1/2
> >
> >  drivers/remoteproc/remoteproc_core.c | 67
> > ++++++++++++++++++++--------
> >  1 file changed, 48 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/remoteproc/remoteproc_core.c
> > b/drivers/remoteproc/remoteproc_core.c
> > index 69f51acf235e..366fad475898 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -1887,6 +1887,50 @@ static int __rproc_detach(struct rproc *rproc)
> >  	return 0;
> >  }
> >
> > +static int rproc_attach_recovery(struct rproc *rproc) {
> > +	int ret;
> > +
> > +	mutex_unlock(&rproc->lock);
> > +	ret =3D rproc_detach(rproc);
> > +	mutex_lock(&rproc->lock);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (atomic_inc_return(&rproc->power) > 1)
>=20
> In the stop/coredump/start path the code _will_ attempt to recover the
> remote processor. With rproc_detach() and rproc_attach() fiddling with th=
e
> rproc->power refcount this might do something, or it might not do somethi=
ng.
> And with the mutex_unlock() it's likely that you're opening of up for var=
ious
> race conditions inbetween.

Rproc_boot will inc rproc->power.
Rproc_detach will decrease rproc->power
Rproc_attach not touch rproc->power.

When do attach recovery, the logic is detach->attach. So I add one
inc rproc->power check to avoid count mis-usage.

>=20
>=20
> PS. Does anyone actually use this refcount, or are we just all holding ou=
r
> breath for it never going beyond 1?

I think latter usage.

Thanks,
Peng.

>=20
> Regards,
> Bjorn
>=20
> > +		return 0;
> > +
> > +	return rproc_attach(rproc);
> > +}
> > +
> > +static int rproc_firmware_recovery(struct rproc *rproc) {
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
> > @@ -1901,7 +1945,6 @@ static int __rproc_detach(struct rproc *rproc)
> >   */
> >  int rproc_trigger_recovery(struct rproc *rproc)  {
> > -	const struct firmware *firmware_p;
> >  	struct device *dev =3D &rproc->dev;
> >  	int ret;
> >
> > @@ -1915,24 +1958,10 @@ int rproc_trigger_recovery(struct rproc
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
> > +	if (rproc_has_feature(rproc, RPROC_FEAT_ATTACH_RECOVERY))
> > +		ret =3D rproc_attach_recovery(rproc);
> > +	else
> > +		ret =3D rproc_firmware_recovery(rproc);
> >
> >  unlock_mutex:
> >  	mutex_unlock(&rproc->lock);
> > --
> > 2.30.0
> >
