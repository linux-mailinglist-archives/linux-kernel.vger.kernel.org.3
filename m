Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA7F4921F4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 10:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240540AbiARJFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 04:05:01 -0500
Received: from mail-eopbgr130042.outbound.protection.outlook.com ([40.107.13.42]:38037
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237269AbiARJE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 04:04:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4Ib4/b+u+pnKQ+DHnGY/NSbRtLhJGgPS5JGG4duhbhO3grePFG9/9Cgnq9NTiYskayK/PprXgvF3sLki1sT8NcW6rCwyQAkSgSf1noUBanFubaB76mT7U5Y8myHStbvo6kAg4IxYO6MWCaOuBeAUYNnZgYZ6Qxk8lY/8GR9TIHXZEC1YEvnWffNGP7G0aZgRv3Rv6d+KRfKfIhOp0gEUNbz/HHYBYFAvtu/hOALILc8Elcs0583be+JbBWXm5n9QoOCX/fIZtOHDUjK/kf9zFOLvA+rqM9hPsJhsofbpraKrs991Wd5KDmGUWtPu7RXhpga8Hf1n1k1hbyMnUEiRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15Wf18LQlGhw2bECG2vFy7wIFRk/r/L1bz+1PBkMNF0=;
 b=gN/KbKPfJHcuqClp8SFc7ICi5AUITHcPQw3Irlk0jNYacoiyHPir6Ek0Nv4agK5E+IZG5NSL92vGLYux6epKkEE8jslisE7OkHe2SsbpBSAqwiveUvb/3SrZJWkKdE+ad5NZ6+5uusR6UsjL2NcOELdSYnvZEuNlTCJxXElcoMBntkdx65+mIjeSXeXBh3vSWb1Y28AxmPOGYJdl7Yq0v68ATb2xEs8OaOjC/gzP3g5Z+7W7Dc+gqROET9miT5tsjcTkLqmTN7T7V5W9UWNP5cAEo4wngDVMTtp2v6MluW1OVer0GlsSF6Lvkm6YK95Lz52iF1ljTZL/tpr9o2IwiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15Wf18LQlGhw2bECG2vFy7wIFRk/r/L1bz+1PBkMNF0=;
 b=Q1+TJ4MjaQCOBkIY/AWiXPRa8CdtQwOvnRJuQ6Rwgbz8aOc8ka2Ew8vjadHfHHzNDvlAUxTdV4Kv6l2fNHzG8xFA7NuQPWCJYzEGuSHK3WstdX4XgVtIAA+LQq2fpFopDrd0aX9f4pHjS0RvQeHgHDRbCfRhW2U5YjKXPEkIw20=
Received: from VI1PR04MB5342.eurprd04.prod.outlook.com (2603:10a6:803:46::16)
 by VI1PR04MB3072.eurprd04.prod.outlook.com (2603:10a6:802:b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Tue, 18 Jan
 2022 09:04:56 +0000
Received: from VI1PR04MB5342.eurprd04.prod.outlook.com
 ([fe80::ceb:f79:2700:ba2a]) by VI1PR04MB5342.eurprd04.prod.outlook.com
 ([fe80::ceb:f79:2700:ba2a%3]) with mapi id 15.20.4888.013; Tue, 18 Jan 2022
 09:04:55 +0000
From:   Gaurav Jain <gaurav.jain@nxp.com>
To:     Petr Benes <petrben@gmail.com>
CC:     Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        =?iso-8859-2?Q?Michal_Vok=E1=E8?= <michal.vokac@ysoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Petr Benes <petr.benes@ysoft.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "robert.hancock@calian.com" <robert.hancock@calian.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Varun Sethi <V.Sethi@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: RE: [EXT] [RFC PATCH] crypto: caam - restore retry count after HW RNG
 failure
Thread-Topic: [EXT] [RFC PATCH] crypto: caam - restore retry count after HW
 RNG failure
Thread-Index: AQHX19neHowqaTNf00Kheozf5e35Yqxg5qfggAAANICABsDngIABF+/w
Date:   Tue, 18 Jan 2022 09:04:55 +0000
Message-ID: <VI1PR04MB5342501C1EC2AFDC4447122DE7589@VI1PR04MB5342.eurprd04.prod.outlook.com>
References: <ea3906acc2c8d6fb56eacd94b9531c18fa7cb4dc.camel@calian.com>
 <20211112152705.90513-1-michal.vokac@ysoft.com>
 <DU2PR04MB863088F218774551FA254EB795539@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <VI1PR04MB5342237C91A2ADF239B05711E7539@VI1PR04MB5342.eurprd04.prod.outlook.com>
 <CAPwXO5aPNLSWiOgUCh7D_MwgeE8+4LO6Q6U1yVjTT9GukCCzDw@mail.gmail.com>
In-Reply-To: <CAPwXO5aPNLSWiOgUCh7D_MwgeE8+4LO6Q6U1yVjTT9GukCCzDw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5da55b9-55d3-4555-34ea-08d9da6198cd
x-ms-traffictypediagnostic: VI1PR04MB3072:EE_
x-microsoft-antispam-prvs: <VI1PR04MB3072036A45A95FB8F53712B7E7589@VI1PR04MB3072.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3GYPHfoUnooPtXd2ztPMEznA2wn2FzuJhWroVyE5uN4XHQOo94mq73wffkOgVbQTFPEvaxk4KEl08tHXale/bjtCmfZCd1NGON3QM7hjvNWyi7JoFqR1Bk864SZxYhgUHVUDZ9YvwMZucBVTyq9qDK48CvGo0eAFhT3vIbrHM5P67s7+Xq6xJGyrrzeaTDXeCILqHbF0dren3sqvZpAmfz1Xs2tNLm+0Zhirl8O1EdXstOHSNVuoPip7aRHavRVJYp9RFEO0HSERMYvrtAuVgoEcT5/w4trYotp+6MpILdrm6rwzBWuvmhmeXhfhp3GpSooTrRjgBAgzd84Y6ZwE1L+1V2MDtPeoEggnkw1C30+FHVPPsKB4uJz80lPjnUln08/bg/UJkgZTIsge8+PllvYWdzI/Rs9lFLVjG/VjIFWl9qSJpW/wmYRIjRqXvmMRzTBuTXuJZUCb+UvmURXUCg/VCsu+8vGOdlf4muyZJBXKeOn7TLfivlBIK3r2Jgv+3bjnEL7sbWuGrba2mJZvVkisoLCYX0AEeQGorBgQL7+AqwepWBBdqR1fCpjQRgteS83mp4XNRDAOXTPUf2/VCwetxpupK7lxK61+MjPX+K677aW0CU6ixSgZ6aDw2i+NpDRCn3V/2BikranL0bDvbJ2P0QJJlJNzHrRBnaQbUoLQVKA6umZWSFagh3nSQFPLBE8faXBXolULiGBDdqbnClKn0wJNAo3wxcBZGl9Yt8BEsoX7khbj6A1c6PCq8vNfwgEPteS/RJKwfR9mB+p9fcapw66AQ1jaEqWxELtJsI62dHQRp7ScPEPaLCBoY5IZUvVOzGjHoL5W0SOVSsnIdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5342.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(45080400002)(38100700002)(966005)(2906002)(6916009)(508600001)(44832011)(55016003)(186003)(71200400001)(26005)(66446008)(66946007)(66556008)(66476007)(64756008)(9686003)(76116006)(122000001)(6506007)(52536014)(83380400001)(7696005)(54906003)(5660300002)(33656002)(8936002)(8676002)(4326008)(86362001)(53546011)(316002)(55236004)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?pjsv1LcNhubRnEcOsFkzv6ktf+oCXzoR2AKio9JpXVrb4YwKAkbShyx3yr?=
 =?iso-8859-2?Q?pUhtCisTJib1tdPptXB/gsnfX7MyHRaqGZgo7GCEguhB0dz8bizp6++qjD?=
 =?iso-8859-2?Q?7r1Q5ya2FVNxi/rWKRz4W/aAWFiJf/7yH+L2QyP5zW1RfcZAJGmBQBFBuo?=
 =?iso-8859-2?Q?baxXO4SmVGLUR4bBd/HGKunqOIF9shFE1de6ljk/ISO4o0EACnyz1q8Eup?=
 =?iso-8859-2?Q?mklzLu1h5/Bh3Pd0dq6Bw7/p7PJGql5CrV7rvu38Wm/ofoW2Bt3QQK5lF8?=
 =?iso-8859-2?Q?zZ960mgf4bT6okqEgm5EL48hrxZZ48inaOmQj1ycYBiLBNSlEsCarzGQD6?=
 =?iso-8859-2?Q?QuXDo54tM7lUUuqFdGapkhA/XnXQW8/ZCe0qVWEXMZuHjlWp546BFgafC7?=
 =?iso-8859-2?Q?XObFlB66L/VCvzYb4OcYZQe0i334afcD9bki3CTZ/jSfoH3gXjO6vwi2l+?=
 =?iso-8859-2?Q?r+CP4Q/xgzZqc0wdcBf2Fu810V7m/YUm3BdD486wBlppecQ80JARQzgoji?=
 =?iso-8859-2?Q?PLCPwbf/Z8WhwS9OU6OmjO0/QgOwcocpRWg5lJ6eBAKQBOUYI/+bGk+EQH?=
 =?iso-8859-2?Q?rEGWlRnjTq9BG5qHnlGv64c9M4z1CA94jlTx8XYJQrlBeQrn9bOWFK1zcA?=
 =?iso-8859-2?Q?z2xtyhnBO9/NSCK6BCpnSRh1MxIH7CGoW4i5oQbjUJNi8l6bvCWAINoC1v?=
 =?iso-8859-2?Q?x+esnxNnK3wHFWYHZacTR0EHE9l2VQreEXrrgXf72NQZXOUhCBa9bT9tv5?=
 =?iso-8859-2?Q?AUPCgNKbTVe+VSJzZeC20Qb5C7Asszr+Ns0GwWhW3z4NHz5mbT0ge2YGlr?=
 =?iso-8859-2?Q?rkcfF7FWLJM/3HcvId4FUR82+tbTlgVraHvZMztfzavT03LnFV1ya8NB8f?=
 =?iso-8859-2?Q?rONVvVwgJZXXfA5pHIUmEwq6S97+Yedq0IGphNDwGy3UZKVwf4Twug9Upg?=
 =?iso-8859-2?Q?O627nTPChNsGSC+vAcm6b45UHLCzEbwuqcI6fDszvLCH0gZawzbXip6F6r?=
 =?iso-8859-2?Q?wHatBzJzRoaXYglrhkC7PNJ2264VY9tPBCl9fXUMewK+31ZJxVQ++EOSle?=
 =?iso-8859-2?Q?hTmG8g7ESd+i+Hrrwjr6kwgYLVZbLp+YBWKzixRkTU+XswimJaZZWH/ZHj?=
 =?iso-8859-2?Q?+ab0EfidTz1DAJJ+Q1hO2SG8l1R6wR5beVez8iul8H2iy2wvegyvSHY8WA?=
 =?iso-8859-2?Q?cb1Sot5KUT4txdjHFaVZXftANpThBrN1YrmZJcJJbRUsQbds8FeNacMwZw?=
 =?iso-8859-2?Q?gIwWSZiQDs+E0Cp41n7MV4EkyDrkep1xgKpSp9z//I+siBerPKA2jd/083?=
 =?iso-8859-2?Q?5EK2G7si1hIZtw9gvfTMttLgUwC12hupUdnp6f1EDMRrCWI36/Sazuze6R?=
 =?iso-8859-2?Q?V0QvSYJ9XjWQJDzIsE5p5lQ39ugJ4wtOx8e7rHFxpaNmX9LkEYERcxZEOF?=
 =?iso-8859-2?Q?6OM7tQc08xuhdcpjgmq3LL/tseWLop4o+tVlYGgcTubKrkoDIdp4DpaxUL?=
 =?iso-8859-2?Q?mhI1wAeUB41p+nbd/JHjr7Be263WBB5G5fDdwys7g08KBye7p3Uta/+V2d?=
 =?iso-8859-2?Q?uL6bxenTHZmfYf2DmZy3oeP9OGYL82SZe1hHzJdc9aSe93s4B8IwGJf+qL?=
 =?iso-8859-2?Q?Qd4PVaTMj0NTvYuwKK4YwGcOHhYwnGUtYJksJTMh8qQmxVMKoz3HSrxESM?=
 =?iso-8859-2?Q?YUwkuWFVVlFisfSazjA=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5342.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5da55b9-55d3-4555-34ea-08d9da6198cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 09:04:55.8029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mEoSs9nXwmwlZRsONqh8CTYY9SizTbQNj6VdaTGCea786Ll/MHxfr1DhG/zaI7tA7i4Qeti2ohGX041ovqPkOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3072
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr

Recently I have sent patches in upstream uboot for adding caam driver suppo=
rt.
http://patchwork.ozlabs.org/project/uboot/list/?series=3D280725

if possible pls add this series in uboot and try to reproduce the problem.

Problem with armv8:
ERROR: modpost: "caam_reinstantiate_rng" [drivers/crypto/caam/caam_jr.ko] u=
ndefined!
make[1]: *** [scripts/Makefile.modpost:134: modules-only.symvers] Error 1
make[1]: *** Deleting file 'modules-only.symvers'
make: *** [Makefile:1755: modules] Error 2

Regards
Gaurav Jain

> -----Original Message-----
> From: Petr Benes <petrben@gmail.com>
> Sent: Monday, January 17, 2022 7:39 PM
> To: Gaurav Jain <gaurav.jain@nxp.com>
> Cc: Horia Geanta <horia.geanta@nxp.com>; Pankaj Gupta
> <pankaj.gupta@nxp.com>; Herbert Xu <herbert@gondor.apana.org.au>; Michal
> Vok=E1=E8 <michal.vokac@ysoft.com>; David S. Miller <davem@davemloft.net>=
;
> Petr Benes <petr.benes@ysoft.com>; l.stach@pengutronix.de;
> robert.hancock@calian.com; linux-crypto@vger.kernel.org; linux-
> kernel@vger.kernel.org; Varun Sethi <V.Sethi@nxp.com>; Vabhav Sharma
> <vabhav.sharma@nxp.com>
> Subject: Re: [EXT] [RFC PATCH] crypto: caam - restore retry count after H=
W RNG
> failure
>=20
> Caution: EXT Email
>=20
> Hi Gaurav,
>=20
> I've resumed work on this issue. I hope I'll get RTSTATUS and RTMCTL soon=
.
> Meanwhile, what is the problem with armv8? I'll try some build for armv8,=
 but it
> will take time.
>=20
> Regards,
> Petr
>=20
> On Thu, 13 Jan 2022 at 08:23, Gaurav Jain <gaurav.jain@nxp.com> wrote:
> >
> > Hello Michal
> >
> > >
> > > -----Original Message-----
> > > From: Michal Vok=E1=E8 <michal.vokac@ysoft.com>
> > > Sent: Friday, November 12, 2021 8:57 PM
> > > To: Horia Geanta <horia.geanta@nxp.com>; Pankaj Gupta
> > > <pankaj.gupta@nxp.com>; Herbert Xu <herbert@gondor.apana.org.au>
> > > Cc: David S. Miller <davem@davemloft.net>;
> > > linux-crypto@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > l.stach@pengutronix.de; robert.hancock@calian.com; Petr Benes
> > > <petr.benes@ysoft.com>; petrben@gmail.com; Michal Vok=E1=E8
> > > <michal.vokac@ysoft.com>
> > > Subject: [EXT] [RFC PATCH] crypto: caam - restore retry count after
> > > HW RNG failure
> > >
> > > Caution: EXT Email
> > >
> > > From: Petr Benes <petr.benes@ysoft.com>
> > >
> > > Each time TRNG generates entropy, statistical tests are run.
> > > If they fail, RETRY_COUNT value is decremented. Once it reaches 0,
> > > HW RNG returns an error, and needs to be reset.
> >
> > The least-significant 16 bits of the RTSTATUS register reflect the resu=
lt of each
> of statistical tests.
> > Can you dump RTSTATUS to see which test has failed? Please dump RTMCTL =
as
> well.
> >
> > Have you tried to build this patch for armv8? For me it is failing.
> >
> > Regards
> > Gaurav Jain
> >
> > > RETRY_COUNT could be programmed in RTSCMISC register and is set to 1
> > > by default. Hence, we are left without hwrng after the first error,
> > > which could happen even under normal conditions.
> > >
> > > Cc: petrben@gmail.com
> > > Signed-off-by: Petr Benes <petr.benes@ysoft.com>
> > > Signed-off-by: Michal Vok=E1=E8 <michal.vokac@ysoft.com>
> > > ---
> > > Hi,
> > > we are also experiencing this issue:
> > >
> > > caam_jr 2101000.jr0: 20003c5b: CCB: desc idx 60: RNG: Hardware error.
> > >
> > > It is happening on both i.MX6S and i.MX6DL SoCs we use.
> > > On Solo I can reproduce it really fast. Sometimes it happens right
> > > after the board is NFS booted, sometimes I need to stress the HWRNG
> > > for a while (generate few hundred KBs of random data). On some
> > > DualLite SoCs it is happening at least once a day.
> > >
> > > We are using the v5.10 LTS branch but I can confirm that this is
> > > happening on all kernels since v5.7 to the latest linux-next.
> > >
> > > We also tried to increase the RTSDCTL_ENT_DLY_MIN delay as suggested
> > > in this thread [1]. It helped and the issue never occurred since
> > > then but we are looking for more universal and permanent solution
> > > suitable for upstream, hence we came up with this patch.
> > >
> > > Any comments will be appreciated.
> > > Thanks, Michal
> > >
> > > [1]
> > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
k
> > >
> ml.org%2F&amp;data=3D04%7C01%7Cgaurav.jain%40nxp.com%7Cbda11e9702e1
> 428
> > >
> 1fc3608d9d9c2e529%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6
> 3778
> > >
> 0253361778015%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQ
> IjoiV2
> > >
> luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DPe0skMXk%2F
> epS
> > > AnqjZRZ6tLKqO4SKbDvX3ysA0w7W6y4%3D&amp;reserved=3D0
> > > %2Flkml%2F2021%2F8%2F30%2F296&amp;data=3D04%7C01%7Cpankaj.gupta
> %40
> > >
> nxp.com%7C5d6bf460b260415aeda008d9a5f0ffab%7C686ea1d3bc2b4c6fa92cd
> > >
> 99c5c301635%7C0%7C0%7C637723276775699794%7CUnknown%7CTWFpbGZs
> > >
> b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> > > %3D%7C1000&amp;sdata=3DVxN9MqDFbISptW3OX9XTtZ%2FwQTsEbF6dETxX
> B%2
> > > BHrywg%3D&amp;reserved=3D0
> > >
> > >  drivers/crypto/caam/caamrng.c | 42
> ++++++++++++++++++++++++++++++++---
> > >  drivers/crypto/caam/ctrl.c    | 13 +++++++++++
> > >  drivers/crypto/caam/ctrl.h    |  2 ++
> > >  3 files changed, 54 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/crypto/caam/caamrng.c
> > > b/drivers/crypto/caam/caamrng.c index 77d048dfe5d0..2be5584ae591
> > > 100644
> > > --- a/drivers/crypto/caam/caamrng.c
> > > +++ b/drivers/crypto/caam/caamrng.c
> > > @@ -21,6 +21,7 @@
> > >  #include "desc_constr.h"
> > >  #include "jr.h"
> > >  #include "error.h"
> > > +#include "ctrl.h"
> > >
> > >  #define CAAM_RNG_MAX_FIFO_STORE_SIZE   16
> > >
> > > @@ -113,6 +114,35 @@ static int caam_rng_read_one(struct device *jrde=
v,
> > >         return err ?: (ret ?: len);
> > >  }
> > >
> > > +static void caam_rng_retry_reset(struct caam_rng_ctx *context) {
> > > +       struct device *ctrldev =3D context->ctrldev;
> > > +       struct caam_drv_private *ctrlpriv =3D dev_get_drvdata(ctrldev=
);
> > > +       struct caam_ctrl __iomem *ctrl;
> > > +       struct rng4tst __iomem *r4tst;
> > > +       u32 __iomem *rtstatus;
> > > +       u32 retry_count;
> > > +
> > > +       ctrl =3D (struct caam_ctrl __iomem *)ctrlpriv->ctrl;
> > > +       r4tst =3D &ctrl->r4tst[0];
> > > +
> > > +       /*
> > > +        * There is unfortunately no member for RTSTATUS register in
> > > +        * struct rng4tst and the structure doesn't look stable
> > > +        */
> > > +       rtstatus =3D (u32 *)((char *)&ctrl->r4tst[0] + 0x3C);
> > > +       retry_count =3D (rd_reg32(rtstatus) >> 16) & 0xf;
> > > +       dev_dbg(ctrldev, "CAAM RNG retry count %d\n", retry_count);
> > > +       if (retry_count =3D=3D 0) {
> > > +               dev_err(ctrldev, "CAAM RNG resetting retry count to 1=
\n");
> > > +               clrsetbits_32(&r4tst->rtmctl, 0, RTMCTL_PRGM | RTMCTL=
_ACC);
> > > +               wr_reg32(&r4tst->rtscmisc,
> > > + (rd_reg32(&r4tst->rtscmisc) & 0x7f) | (1 <<
> > > 16));
> > > +               clrsetbits_32(&r4tst->rtmctl, RTMCTL_PRGM | RTMCTL_AC=
C,
> > > +                               RTMCTL_SAMP_MODE_RAW_ES_SC);
> > > +               caam_reinstantiate_rng(ctrldev);
> > > +       }
> > > +}
> > > +
> > >  static void caam_rng_fill_async(struct caam_rng_ctx *ctx)  {
> > >         struct scatterlist sg[1];
> > > @@ -129,8 +159,10 @@ static void caam_rng_fill_async(struct
> > > caam_rng_ctx
> > > *ctx)
> > >                                 sg[0].length,
> > >                                 ctx->desc_async,
> > >                                 &done);
> > > -       if (len < 0)
> > > +       if (len < 0) {
> > > +               caam_rng_retry_reset(ctx);
> > >                 return;
> > > +       }
> > >
> > >         kfifo_dma_in_finish(&ctx->fifo, len);  } @@ -145,13 +177,17
> > > @@ static void caam_rng_worker(struct work_struct *work)  static int
> > > caam_read(struct hwrng *rng, void *dst, size_t max, bool wait)  {
> > >         struct caam_rng_ctx *ctx =3D to_caam_rng_ctx(rng);
> > > -       int out;
> > > +       int out, ret;
> > >
> > >         if (wait) {
> > >                 struct completion done;
> > >
> > > -               return caam_rng_read_one(ctx->jrdev, dst, max,
> > > +               ret =3D caam_rng_read_one(ctx->jrdev, dst, max,
> > >                                          ctx->desc_sync, &done);
> > > +               if (ret < 0)
> > > +                       caam_rng_retry_reset(ctx);
> > > +
> > > +               return ret;
> > >         }
> > >
> > >         out =3D kfifo_out(&ctx->fifo, dst, max); diff --git
> > > a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c index
> > > ca0361b2dbb0..e421f8d1982b 100644
> > > --- a/drivers/crypto/caam/ctrl.c
> > > +++ b/drivers/crypto/caam/ctrl.c
> > > @@ -339,6 +339,19 @@ static int instantiate_rng(struct device
> > > *ctrldev, int state_handle_mask,
> > >         return devm_add_action_or_reset(ctrldev,
> > > devm_deinstantiate_rng, ctrldev);  }
> > >
> > > +/*
> > > + * caam_reinstantiate_rng - reinstantiates RNG. Intended for a case
> > > +when RNG
> > > falls into
> > > + *                         HW error condition. That happens if TRNG =
fails statistical
> > > + *                         check and RTY_CNT value set in RTSCMISC d=
ecrements to
> zero.
> > > + *                         It is exported to caamrng.c
> > > + * @ctrldev - pointer to device
> > > + */
> > > +
> > > +int caam_reinstantiate_rng(struct device *ctrldev) {
> > > +       return instantiate_rng(ctrldev, 0, 0); }
> > > +
> > >  /*
> > >   * kick_trng - sets the various parameters for enabling the initiali=
zation
> > >   *            of the RNG4 block in CAAM
> > > diff --git a/drivers/crypto/caam/ctrl.h b/drivers/crypto/caam/ctrl.h
> > > index
> > > f3ecd67922a7..26ff5a49a865 100644
> > > --- a/drivers/crypto/caam/ctrl.h
> > > +++ b/drivers/crypto/caam/ctrl.h
> > > @@ -8,6 +8,8 @@
> > >  #ifndef CTRL_H
> > >  #define CTRL_H
> > >
> > > +int caam_reinstantiate_rng(struct device *ctrldev);
> > > +
> > >  /* Prototypes for backend-level services exposed to APIs */  extern
> > > bool caam_dpaa2;
> > >
> > > --
> > > 2.25.1
> >
