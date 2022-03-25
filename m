Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAF74E6C4F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 03:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357638AbiCYCDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 22:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237272AbiCYCDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 22:03:47 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70084.outbound.protection.outlook.com [40.107.7.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA5BA1462;
        Thu, 24 Mar 2022 19:02:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Da2aYzKqKX97FDWAGAfnS8QP7EHPiqZelituDy1YlhhDJRU8J3ICAN4k3lfPM/GTYtAyFB9silLNtIYNm7Dgld4rpDR5YRYCzsxCcEvz0MpCwfa6VMg+3lHexmJd5InQgukxd6cyBfrmLOZdsgThmtkhzdyop7twbxncqsWaZN2SMof3iRNhI/n5/DHIaQbNRU6QpeXMK2/nXVXL8Yg7S5p5cJSWzYTyG59ZhWRpCuf+I0BdPQ5NATKMzxgL6rGZhPzkTZ958RPfIZSbIOsW++iw4rn16d3PDPeakHxpslk53kLyz+ozf/DZtX+g23Opy7DkymyhdGowXrzbBgKJyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=diTd2lh682f67gcBdTWlV25AJdlJaOipLdl+2uxAT+Q=;
 b=VrKvf/PSCPhjSUXRfIyKfxcm+9nynJ0PbahLkPgz1XaakCrVgCMyICQIF6piuMhHrUkV7SaAu812c4JTn/HKXqseRIvkhOweklo7DnNTHGrcNP2ObWyt45dBOB+Cve26Qpk6bRX+GpI10NhqnqInZ7r09qu+hxI7BAyiCHdzopbAhFOGNOYfqbxat2wHt7Fcvfi8YnXlSJelHutN68jUTvGyxZsaY+C4srnVQRYZvJsuQJ1l8uomi4w9IbrJlAK3RCxm9fMWO6H8SZ3rKBkFsMBj2PWRqjT9qShEjYnOKi9Dc4/bfZhgKH9nHOI1Mn0Xs9rp0JhKJSHSApXnuHuRxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=diTd2lh682f67gcBdTWlV25AJdlJaOipLdl+2uxAT+Q=;
 b=dVkH1Lnzyu2W39d2NYIx/298BAvEG9X28GZg8YBl6u39UqeUyD4nubmFy2oR3Y4T0EZEGXsHPjRrWJr1tz48/4ERsbiFTtZHwsH6TCynvZNrWGoDRc+YY8EJHP0ppm1Cy/JnyLVTdQbBhlUTz5e/3fzxg2DKzGYnVA8oUJLKk4o=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6516.eurprd04.prod.outlook.com (2603:10a6:208:174::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Fri, 25 Mar
 2022 02:02:10 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1d8b:d8d8:ca2b:efff]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1d8b:d8d8:ca2b:efff%3]) with mapi id 15.20.5102.018; Fri, 25 Mar 2022
 02:02:10 +0000
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
Subject: RE: [PATCH V2] remoteproc: imx_rproc: Ignore create mem entry for
 resource table
Thread-Topic: [PATCH V2] remoteproc: imx_rproc: Ignore create mem entry for
 resource table
Thread-Index: AQHYMrQ3WJ3UeNc+okuz81vxgHqt4KzOvXsAgAC1LqA=
Date:   Fri, 25 Mar 2022 02:02:10 +0000
Message-ID: <DU0PR04MB9417991BDB9564321FC30EE7881A9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220308065754.3355-1-peng.fan@oss.nxp.com>
 <20220324151132.GA3514576@p14s>
In-Reply-To: <20220324151132.GA3514576@p14s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ce1e2f7-ade0-4ef0-ca1d-08da0e0378d9
x-ms-traffictypediagnostic: AM0PR04MB6516:EE_
x-microsoft-antispam-prvs: <AM0PR04MB6516DE6720385A9AA08A2872881A9@AM0PR04MB6516.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tN9X4jB4RTK9HUgxLYHOU8IkAXad8OUrvYWJBalqHUMB8LYM24vzxSvV3BOnVrmpdhZUYBI7QfsbIHecBTjy7Yh/dEGbC0DS1KFwlxkT+J24+4ce6z3rkMTGc4q52Jp+0lLZRXm7cQCKmmr7+RnNvVLOVk76xo26SbFTTVkctBJWT4eKmiV51R/TxGTdseB7u48HHM3px5bGJyN5xHjKgwbNEzzpJwTDKuhEyyVlbyXXHE+kT+P/7JYk1uNIexgwY821IclPv8jPyw0dWXBJEwfU+xPr9eXM265t+5TxSoV/cqq0saaZadpVF6Eh0cEyku91FhUvFDJIn2sMegLPCpgxDhgaeENra9rWsHv64vZas+eOG57c0+js133PpFVRspym4bSaq4fRNogCbMPHkX5Mq4tectTolJIBJ6eFYClJ48HQytoMYD9XEjKuq/udNhYN49pOSRZKr/i8qvXpC4I8nYfHuf4qm9Fq78BrNKSpn6A1Q9BWNnNcyaVpxq+hS2lgXLJDAhIqwfpbjLK2ovcCD4FCAwhxWtNTHpnQL7+7eSYiUYGN2lWY0n1ymmVhXIXcDHA5BL0aO7DJVrhWMrf94YAd9+xz1Id119mAc0PuOBskm4nIFX5snuJS6MEOH+sCR9Ng1LUrTo3YuF0z3hzeMO/hDLi1H0DSMd5wDK6Lcsh3IgOFfmaWtv85zgXt4bDbvDurZ0npIWTzut58PI0w59mRycXRnZPFlCP9ROp+tNIOHNB7Ws2m20MpcmhLfLINZ8bwRxI5DboHIdUQ/y0vvyrRpKdbUJFZ6FblcLs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(38070700005)(5660300002)(55016003)(8936002)(2906002)(66556008)(26005)(110136005)(508600001)(8676002)(186003)(33656002)(316002)(966005)(9686003)(6506007)(52536014)(54906003)(7696005)(71200400001)(76116006)(86362001)(45080400002)(122000001)(44832011)(66476007)(66946007)(4326008)(66446008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Bvnf8NxPArB10SlPRW5ZbD+rfW4LzaM01QeghmgrZb9IXGD9jQF0QFa9NNlw?=
 =?us-ascii?Q?6P/Qag71pPuczcvllIYt3hKmKjYbkdSqnxFVGSLy4FAryOAwsNP+A2RWoL6N?=
 =?us-ascii?Q?KCLd/1SAzl8JKPm4jeGBTCzQhHzynICkU1aa4kVuKZmkvENplqgxYIk5na0N?=
 =?us-ascii?Q?4KAgXzhkSw5mA8itBmxUZLYv8+zCOhySuhlUml2GCn2LRPBT7/8mrdbasF6P?=
 =?us-ascii?Q?SHAKDnX67t7lrLkeqK09GYfr5cOnMb/8dOQT2yN5y+VuJ+L4txMDqNSgk+X7?=
 =?us-ascii?Q?807n09Ku7rwaDXsmSPKCP9Ctj/BGdCsCpBjmqQY2Q2Om3Bpg0jJe9WcJhj1b?=
 =?us-ascii?Q?uGGc8qwSwLKOYsuo0qC6J2TZZHzriYxKGbintcGaTU/cHwrxg6vmkNgYYJvu?=
 =?us-ascii?Q?AbHFe9vNJqssqE2HXzLanSyNLhiwfA22nGR25Zs7F877NnEyu5n0+tfEHydZ?=
 =?us-ascii?Q?9c9DockcpRIBXfdqf1chyKa1GP1NRP1SD7vgAhsAx5zfGkPVYyLuaA7IIU2c?=
 =?us-ascii?Q?xrLM1CaR16qSjGe5ryq/RpDAGYUNuyRgUwZ8j9ZD96TQkuSlROQGA9xSZ4x6?=
 =?us-ascii?Q?f+UVbp2KRQAshAde06yI3jo2qrLBgqpsmD/gkI9fFI725QjEulP84hprVbNY?=
 =?us-ascii?Q?VDWR1EZHyG8NqvPNS+tX6tXVmxcjaLxnmRg7xtS4XjKtWfZ4B5dJlam5gDI3?=
 =?us-ascii?Q?0dcjuNydUYM5iuxDGw8pL4VXgrBzOIM0WSXUVDJDdUyHjYYwKbLpPIwcTlBK?=
 =?us-ascii?Q?ri5WBeM4kG5ZYxqsAxb+4Ylfz06EnJElsF0AfMjjE3RSPisqqDfvt2G96Ohe?=
 =?us-ascii?Q?l2gxiQq+9GgG0sdTHBbBro6Ui432wRYy/vK6JW0xeGmD8H6gSFN2CLk2SQjj?=
 =?us-ascii?Q?Cis1c0QS77zsTMZrEqIG11ZOdIXRfdKaFYwbUwjeHWxc1GXcdFCzr2jcJHEo?=
 =?us-ascii?Q?TNh6voRaARZJTe2lQ7LlJ/FjPBscXbFXiz6IFKupelHruYoV1s4wCzE0JTyK?=
 =?us-ascii?Q?F2t3kjdwvmzP8NJMF0AD8DMzrSqGM4yUEbJ+SJ/kUz13zrIHa2Xg36qJkKGb?=
 =?us-ascii?Q?mS3skJq31uaI9FkRAlswF7bvwbuBecsi12EiJZvlDAPZ9DtLqheerrS1FJ73?=
 =?us-ascii?Q?e1j+9Krx90Z4MaKclClM8RKQu8Wh26IpY/e7NqovcchRpAtBRsUtLfyMIWPG?=
 =?us-ascii?Q?cO61jOZiMtRhSbNX02AY/7DW5x+TclOEToLru9fSy30+7mWeCjw+xTxa+Fsm?=
 =?us-ascii?Q?/Em7nh/DqtU36BTjyydCb67wwsk2DJ919mXOmLqKRSuffsSDkrSs4FWyRmiL?=
 =?us-ascii?Q?o5vALzZ9BwoX0iN9vG66KVWiAKGgXo7uxBiTAhCB1+RnJfbm3UqBWS8J2mW4?=
 =?us-ascii?Q?TjtCTLhpKs4s0SdHxYJOv7pGpA8Max/HH/+u4v9tYkZorx0hYD3Igw1mjtQV?=
 =?us-ascii?Q?2VwzDwqGFO4IGrEhwhHiof1nSd+wpo+Vmh3fzCzQy5s1cDpFg6u2xmkjVceA?=
 =?us-ascii?Q?JioQOIfXliE9k+XCUCSNAH92m+hr7PUVuDrBcGXilr0ffBMJfncIagucmLAR?=
 =?us-ascii?Q?/AAUpLTuHE32VFaS6xLQ02O1/EIcgRfdyz5JexvTA2y40zXTpSorwhsVbJx2?=
 =?us-ascii?Q?q9zk6RHH/jrkOVGg7zX3GLPdhtZI6d6YoKicJBzB56ICfEO1S9mQyJv8FQVz?=
 =?us-ascii?Q?j/nsZbHrEJvs0IflF5omnWlheacYegK+HYcz/7Ptx+DRY4WiJUXg4I3Wj1N5?=
 =?us-ascii?Q?rPIeKJ/bEQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce1e2f7-ade0-4ef0-ca1d-08da0e0378d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 02:02:10.0638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y3Kaq5TBei9CxheLeDREHxHRRFDbkIokdGHZjwD2rsdturcwv9a6xJ/QzUVPfCs9wx6cZ96YCMegYd5XAZW7bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6516
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

> Subject: Re: [PATCH V2] remoteproc: imx_rproc: Ignore create mem entry fo=
r
> resource table
>=20
> On Tue, Mar 08, 2022 at 02:57:54PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Resource table will not be used for memory allocation, no need to
> > create rproc mem entry.
> >
> > Fixes: b29b4249f8f0c ("remoteproc: imx_rproc: add i.MX specific parse
> > fw hook")
>=20
>=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Felixi=
r.b
> ootlin.com%2Flinux%2Fv5.17%2Fsource%2FDocumentation%2Fprocess%2Fsu
> bmitting-patches.rst&amp;data=3D04%7C01%7Cpeng.fan%40nxp.com%7Cae62
> e633010048f972db08da0da89836%7C686ea1d3bc2b4c6fa92cd99c5c301635
> %7C0%7C1%7C637837315009092474%7CUnknown%7CTWFpbGZsb3d8eyJW
> IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
> 3000&amp;sdata=3DXod3YxSRW8h2WXdnpu1WX4DzRpCTnYE9gVlt9HXMlnU%3
> D&amp;reserved=3D0

Sorry, I could not get your point of which part conflicts with the patch ru=
les.
Please clarify and I'll improve.

Thanks,
Peng.


>=20
>=20
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V2:
> >  Add Fixes tag
> >  Separate the patch from
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpat=
c
> >
> hwork.kernel.org%2Fproject%2Flinux-remoteproc%2Fpatch%2F20220111033
> 333
> > .403448-7-peng.fan%40oss.nxp.com%2F&amp;data=3D04%7C01%7Cpeng.fan
> %40nxp.
> >
> com%7Cae62e633010048f972db08da0da89836%7C686ea1d3bc2b4c6fa92cd
> 99c5c301
> >
> 635%7C0%7C1%7C637837315009092474%7CUnknown%7CTWFpbGZsb3d8e
> yJWIjoiMC4wL
> >
> jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&am
> p;sdata
> >
> =3DCYL9grwXHpUud4qpzFAEijOWv%2BehvefwyZ4aU02wJnw%3D&amp;reserv
> ed=3D0
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
> >  		rmem =3D of_reserved_mem_lookup(it.node);
> >  		if (!rmem) {
> >  			dev_err(priv->dev, "unable to acquire memory-region\n");
> > --
> > 2.30.0
> >
