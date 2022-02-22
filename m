Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF344BF9D6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbiBVNwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbiBVNwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:52:22 -0500
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1DF986EE;
        Tue, 22 Feb 2022 05:51:56 -0800 (PST)
Received: from pps.filterd (m0174678.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21MDnXY2002424;
        Tue, 22 Feb 2022 13:51:41 GMT
Received: from eur05-am6-obe.outbound.protection.outlook.com (mail-am6eur05lp2112.outbound.protection.outlook.com [104.47.18.112])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3ed1208091-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 13:51:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjbtLrz2vM3vZgwJiyxUHvpIH1zUhWsTimJhDC6IUMrA18cI8F8uq/wU8A2ElntoFNVUDxczCAvHz7ZCj6nUOAi7LC30VZcKBSrFkiNGRl+S3u2QxB5rV/YATyYL54oZmblGp4/tHom1dgeDkm6fCUvyDAvxXwVVmUILfrIOgQSA95Pwg7ipOqT9b3iHe85H4U6TwunxSuba2oqKbnZkOLNiwgYSV5CLh4GTORnxVr3/jUO80mvvuc02gkZBr1xQtjjsmIq7IrLgVq2TmYn2zeHp1X7nXGE49AVOw1+rgEhlA+E37ilhisZMAO5Pxa62+pFbLACnBZiBsP1InLt+eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrlOHCKSPQCUz+hlMlwMm+H3yA7g5c9CJGwSHToY60I=;
 b=CSJc0URlP25FI+ACQSLejMWA2w/oz4xaMm7W0+01x4P6hsC+8daRG6ruDDHuhrEqb8DA5pWiybPAUw0TPEcTr904dxoejGeQ2XvyyW4XFjM5lZqtPJ/Gv0rGkH21taDRHEiEuuzQYVNI9lODJpaeSfF0s2ZeEQ4UjywSdKVmDccGU+RtkAqvGJcGLxvRAfJLI1vhb8XL3KdLImPfKMdf0Kj/2gbEfjzKVA9J24mpJBftLEAl1ah2RL0sEN3jlvVzLeMtAoo7HH1CS5wXYrMGPMUvzm6R4frveIuixqGI+J/ikUCeaS4hCxH7b2O5f7Vy6Pyi6oJ54uYznmwbnULNBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrlOHCKSPQCUz+hlMlwMm+H3yA7g5c9CJGwSHToY60I=;
 b=ghhA76q/IYHoRhDHkcCHSACgt/Z3O4xmqvaCILNEAHKd6xes7xGCMVNnIo3s2FkxG5HvAd0K1wSCLMMdLs3OgrU1GaZX2qUrI26OTuDB4abEqhWeglR4E86uFBV03KREhWa3JEpR9tH4lkkWGY6NJ9cmgfPr0yANyuZNKVW46DCk8gET046Pms1+I4zT+RhvpKgi4K5yi1n9B9y4vvlPhpfRTIxTtsV4FjU8PrOY4KZvzncQoxbTmpc80WHhuPRvnNKnNJq5k7/7vw1m5GJAmShTLnj4UzGB9bDlU5tXpYeSxCKv7tcKLU5t4PTVzh2Tmrk5Whibp8MbSIBmtucyvg==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by DB7PR03MB4794.eurprd03.prod.outlook.com (2603:10a6:10:78::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Tue, 22 Feb
 2022 13:51:35 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::c1c:f98:9dd:86e0]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::c1c:f98:9dd:86e0%5]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 13:51:35 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] dt-bindings: arm: Add scmi_devid paramter for
Thread-Topic: [RFC PATCH 0/1] dt-bindings: arm: Add scmi_devid paramter for
Thread-Index: AQHYJ0gzI98NnKSQaEaZikv/1tAERayfaB6AgAAv7AA=
Date:   Tue, 22 Feb 2022 13:51:35 +0000
Message-ID: <20220222135134.GA1597587@EPUAKYIW015D>
References: <cover.1645460043.git.oleksii_moisieiev@epam.com>
 <20220222110003.GC21915@e120937-lin>
In-Reply-To: <20220222110003.GC21915@e120937-lin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44528038-0103-4a9a-f2cb-08d9f60a712c
x-ms-traffictypediagnostic: DB7PR03MB4794:EE_
x-microsoft-antispam-prvs: <DB7PR03MB47945A47AFFFB6161045B617E33B9@DB7PR03MB4794.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K2YYliZqMTyEjBuv0TlyNxM9DRpDQhlYjRxRXZJ4HpnNnnQOb93VIT58CXVysz68zqPaUGhcNfNoQ69RHgV/hjkAdgTx37Mrcptw1QPBRVznDjkvoUYdAm9e55zELliydOxJgOppiZHBwAbhkCrWxnvGlWTA4OuluQXmGyIJngkg46dTNNVP1Vou30TJjajnVeZrEyvfPBReB7fYcuxc2ODs9Va+rVijW+BvA0OdrGCesLRG3vCA1ez/8xIVTacmzNTQgZwgUDtEj+e6V0U+waKg2j4jUgYnTMIkQBUK/GzPd3V0MYe7+Tf1yhmL9ux5+ctZm5W3ZpEnqj0HD1NzAi8rjJywzFrFR/4s+W4/UV01PJa3Y8EJVFP9qUVv/yiMlJ9oDmO4gKTq0OpLWl1Ul1DAtM/5d5LL9VWFT+0Q/dHyLp3SChHGKpuXgXpL/lWurQM4ADS7fPilrCuT7AGIKZ+Yso0UXqiGtSPiW04stYrLT+Jj88D616L+M6baYyRtRc9b3bfNzPdwcqZPDpsHYzCaVIrOmaiDcMkzPIWZFQWkUrMmf0hxwGYIcG1PjYgLaK4v8Ktqq+Qo8A/J7jVkQntApOwkgItLrhWacFDJ+vvpjF5AlIU0pq4TZMV6awBpIkl3PmvO2LNA6R47rmZNdsXVnL/CnDprC1Tl9ce52N4juDw3L7oaX9UtgNM9FDoOvZnS2JgIH301SO1o7q82bJO1mFew54lwFvgCcuh4y4rOtE9VjA3Bfe9868QjxywQH9vQy6YkHAuCvFsRwPW2e24wtdbzV1p7lk+3eE+cCkg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(86362001)(38070700005)(66946007)(8936002)(6916009)(5660300002)(66556008)(91956017)(76116006)(6506007)(66446008)(122000001)(54906003)(66476007)(64756008)(8676002)(33716001)(4326008)(38100700002)(33656002)(2906002)(1076003)(83380400001)(966005)(508600001)(6486002)(316002)(186003)(26005)(71200400001)(6512007)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Lr+OAbqDrYpkfOVqvZrgeLIbjXVHA82pw9AyA/W+WzxEQg7bFQyuaOGG4r14?=
 =?us-ascii?Q?bI8ITsPJPRPRcUq6SmSDNeltuFu/UF1uXZ9nkYyqyIe3EOGdEBU0yUJ91yhD?=
 =?us-ascii?Q?JdfxyxmDWkK9JPcGoLSPCqU1psnBnK3gE7caiMW5ddwRiNBAwn4UkdRGrHg7?=
 =?us-ascii?Q?IbGysFv7FDcjaLdon/gpyJg0nfssKO29PIYC9gJoXHJ45DBS2fL7UH4q0GAv?=
 =?us-ascii?Q?xvMo+F9eG0Fa+ksFJeUda8l/cfvfLnujTiuR+1CRWyBFkjNlsYS2C13R2GmV?=
 =?us-ascii?Q?yOXY+0Ximjguv2iDCI0b7H2hmvOv9Rhu9eqlXYGPaiitSAShHv/ibk0OPmjD?=
 =?us-ascii?Q?bVstCCw0n+XTa5TQ2343NQMY+0V0H+BsjKrw2mHECPah1bv3HdxDpP3QuyyU?=
 =?us-ascii?Q?iRkIl5L7cwLbN4lS5CVw46FHgKfHWqHtJNCD9qm0pdJC3NqHKWnzn8pJj6m+?=
 =?us-ascii?Q?09hv3nOOWsrZ8bVO9znuLuv+cFLEc2IKpxUNRF9umzTKEFnYvwWQaWJoceHR?=
 =?us-ascii?Q?kKQUkmP9aXMGcu8yYnq/+TPyDzcmo1SrNunwihAblSbYNxWeKrQqq4A9NZu2?=
 =?us-ascii?Q?JyZvWg8fnuu0HiPguPnKDtvpEg8DukZ4/6GBfIbIg00YbRh0hmd5mk0AZOQy?=
 =?us-ascii?Q?rMwVVETUVbkJiPIJISwTkCOpVWfCbWRH+amo+RKX1N8FBggYuP2me/v8p5pJ?=
 =?us-ascii?Q?AR/nvnjso8BGrcfrlwxCoFzyj97amyhCc9plYHQsIoFHLEboFnN1ls1AUK+W?=
 =?us-ascii?Q?vqna6Yu6mXQylYUfPFY42CsrJ8VLSD+9lP147Qrx4VRh9zAPhuZezbxrfaiS?=
 =?us-ascii?Q?g40UiZ/qE14ffRrR1Eq1pgMawu79gRp+seWXOa9fo7FzyTmf+vZIfFVc0jkY?=
 =?us-ascii?Q?ufon/xYEQb7C5V2JOAjPuUrD/EERpNS3oCrEownmpBpWTE7mYYrwmdEISD93?=
 =?us-ascii?Q?8K/A99DvG4UsXezDVJoIIid645p0DGxeKSf6ilvn741CSKK+j2xlgktbUtCw?=
 =?us-ascii?Q?MEBfyfAWYJDLT165w181IPf0ycXlsiDDxyN/gY0m8soN0X6ZcyZgWM70qUU6?=
 =?us-ascii?Q?aSsUwsDHiu28Se8lNY+w34ce1/tkxswkYDh7qeRRRMO6yaUIL960XwdKcydd?=
 =?us-ascii?Q?LNoQVY3GrmhdRk9UTu7erUiiT9IatPcy9kBdsn2UxPPAC0bMGlxuD6GCsS9i?=
 =?us-ascii?Q?19D0HghCwiCvabfF8jjlxJ80vJf0gu+QBgEijWZsCCnsY5Jx/l2gnOC2/kPY?=
 =?us-ascii?Q?oa3rSS6E6LScinrvQyTHMj5R4PMFEDQAiGtO071b31s/Y1OQafnjal66Zfze?=
 =?us-ascii?Q?TA9a8jAOVE65DAlX2f926PVRjaVyiXou+cR0nUwUyHvLnBBnrQuqZWTaDWiQ?=
 =?us-ascii?Q?WLZK0wNoSf/4ZnqJRfNwNa2Hx5jpxkmOzjFfS8F9CD410p9Uku3CtGQkXUgD?=
 =?us-ascii?Q?Xf8Wpk8En6jAnKu1pqvErPRdMes5wU2eMG62/Et0JmhmXIA3WqfH4/pGUUHA?=
 =?us-ascii?Q?MJ4k84PZFuVbNRma0+GGWt3ZZpC+BGdAifNVSVwkP8dJiREhOlTK2QndbP/O?=
 =?us-ascii?Q?B18v23dQKA4z0EqA/qCeS35TcHZ0ojA71xkx1WenWeFkzr5Men2keeZCXT/j?=
 =?us-ascii?Q?zhB8VmwCIKNZtAJ7H96CbMIv5DiLiIxsxWr4Mr74TH0vVWidt/Ph0c47IHnI?=
 =?us-ascii?Q?mKuNzr5CJFnsVvXfkOf1Lw2eRsE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <97121B01EEF39C419E4CE1173CAB1804@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44528038-0103-4a9a-f2cb-08d9f60a712c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 13:51:35.7263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u9KPZzPdzfy+jE4D+qSk9/SwBmxN5wUANc33Tyn3bf6/WtWAQLLSQsU/2/hf6f0f2UyLJKc74gLj12T5CAV09Db2wY+iMK90UkskeRDPbwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB4794
X-Proofpoint-ORIG-GUID: 8K0I5mzbzlcRFrM8OJEarjymN3HJANh6
X-Proofpoint-GUID: 8K0I5mzbzlcRFrM8OJEarjymN3HJANh6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-22_03,2022-02-21_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 impostorscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202220084
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cristian,

On Tue, Feb 22, 2022 at 11:00:03AM +0000, Cristian Marussi wrote:
> On Mon, Feb 21, 2022 at 05:26:46PM +0000, Oleksii Moisieiev wrote:
> > Introducing new parameter called scmi_devid to the device-tree bindings=
.
> > This parameter should be set for the device nodes, which has
> > clocks/power-domains/resets working through SCMI.
> > Given parameter should set the device_id, needed to set device
> > permissions in the Firmware. This feature will be extremely useful for
> > the virtualized systems, which has more that one Guests running on the
> > system at the same time or for the syestems, which require several
> > agents with different permissions. Trusted agent will use scmi_devid to
> > set the Device permissions for the Firmware (See Section 4.2.2.10 [0]
> > for details).
> > Agents concept is described in Section 4.2.1 [0].
> >=20
>=20
> Hi Oleksii,
>=20
> I had a look at this patch and the related XEN series and I'd have a few
> questions/doubts. (adding to the loop in CC Souvik from ATG and Vincent
> from Linaro since he's working on similar SCMI virtualization stuff)
>=20

I'm aware of what Vincent is working on.

> > scmi_devid in Device-tree node example:
> > usb@e6590000
> > {
> >     scmi_devid =3D <19>;
> >     clocks =3D <&scmi_clock 3>, <&scmi_clock 2>;
> >     resets =3D <&scmi_reset 10>, <&scmi_reset 9>;
> >     power-domains =3D <&scmi_power 0>;
> > };
> >=20
>=20
> So this SCMI device ID is meant to identify an SCMI device, viewed as a
> grouping of SCMI resources (clock/power/...etc) so that a Trusted Agent
> can issue a BASE_SET_DEVICE_PERMISSIONS telling to the SCMI Server
> platform backend (SCP sw sitting somewhere) which SCMI agents on the
> system can access which (SCMI) devices (in the Normal nonSecure world):
> basically, if I got it right from the Xen series, your hypervisor acting
> as Trusted Agent (and recognized as trusted agent by by the SCP) tells
> the SCMI platform server SCP (via SMC in your case) how to configure the
> access to the devices for all the other (non trusted) agents in the syste=
m
> (other Guest OS/Domains instances).

That's correct.

>=20
> The SCMI spec does not indeed cover the discovery of such devices and
> the related associated resources: it indeed delegates such description
> to FDT/ACPI as of now.
>=20
> AFAIU in this scenario I imagine:
>=20
> - SCMI Server platform (SCP) knows via its own methods (builtin_config
>   FDT...etc) the list of defined SCMI devices and related associated
>   resources like:
>  =20
>   deviceNNN -->> clock_X / power_Q
>   deviceYYY ---> clock_Z / power_W
>   ..etc
>=20
>=20
> - Trusted Agent (XEN hypervisor) in turn:
>=20
>   + is configured/recognized by the SCMI Server as a Trusted Agent (based
>     on the channel it uses to talk to the server) and as such it is allow=
ed
>     to issue BASE_SET_DEVICE_PERMISSIONS (by the SCMI server)
>=20
>   + has knowledge of the same set of devices/resources allocations (via
>     its own FDT) as the SCMI server
>=20
>   + can issue a proper set of BASE_SET_DEVICE_PERMISSIONS telling the
>     SCMI server backend which devices can be used by which non-trusted
>     agents (GuestOS) ... even dynamically I suppose when guests come and
>     go.
>=20
>     Xen:
> 	    BASE_SET_DEVICE_PERMISSIONS(dev_NNN, agent_3)
> 	    BASE_SET_DEVICE_PERMISSIONS(dev_YYY, agent_2)
> 	    BASE_SET_DEVICE_PERMISSIONS(dev_NNN, agent_4)
>=20
>     and in this scenario the same dev_NNN could be made accessible to
>     two different agents, it will be anyway up to the SCMI Server
>     backend to armonize or reject such requests from 2 different
>     agents around the same shared resources
>=20
>=20
> - Other non-trusted agents on the system (GuestOSes or other non
>   virtualized subsystems...e.g. WiFi/Modem...etc), described in their
>   DTs (for Linux GuestOS) as using SCMI resources as usual (without SCMI
>   device id) just issue SCMI request on the basic resource and those are
>   routed to the SCMI Server backend by the Hypervisor UNMODIFIED:
>=20
>   example for a shared resource:
>=20
>    - Agent_2 set power_Q ON --->>> SCMI Server - OK - powerQ TURNED ON
>     				  (allowed as configured by Trusted Agent,
> 				   powerQ hw was OFF turn it ON)
>=20
>    - Agent_3 set power_Q OFF --->>> SCMI Server - DENIED
>     				  (disallowed as configured by Trusted Agent)
>=20
>    - Agent_4 set power_Q ON --->>> SCMI Server - OK - powerQ ALREADY ON
>     				  (allowed as configured by Trusted Agent,
> 				   powerQ hw was ON nothing to be done)
>=20
>    - Agent_2 set power_Q OFF --->>> SCMI Server - OK - powerQ UNCHANGED (=
SHARED with Agent_2)
>     				  (allowed as configured by Trusted Agent but shared with
> 				   another agent)
>=20
>    - Agent_4 set power_Q OFF --->>> SCMI Server - OK - powerQ OFF
>     				  (allowed as configured by Trusted Agent but shared with
> 				   another agent
>=20
> So in all of this, I don't get why you need this DT definition aggregatin=
g SCMI
> resources to SCMI device IDs in the Guest OS, which is an SCMI agent that=
 does not
> need to now anything about SCMI device IDs (at least with the current spe=
c): this
> would make sense only if the Linux Kernel was the TrustedAgent in charge =
of
> configuring the devices permissions via BASE_SET_DEVICE_PERMISSIONS.
> (in fact you said you won't provide any code to manage this scmi_devid
> in the kernel since those guests are not trusted agents and the won't be
> allowed to set device permissions...)

You are right. The idea is that only Xen in our case will use
scmi-devid. I thought that providing this parameter in DT-bindings will
be useful for the future usage, let's say for some sort of the scmi
backend, running in the different OS or for the different hypervisor.
That's why I've decided to open discussion here.

>=20
> The only tricky part I can see in all of the above is agent identificatio=
n, since
> the agents are assigned an ID by the SCMI platform (which can be queried)=
 and they
> have a set of dedicated channels to use, so basically the platform really=
 identifies
> the Agents looking at the channel from which a request is coming from and=
 AgentID is
> not carried inside the message as a source and cannot be spoofed.

That's a very good question. I've raised it in Xen mailing list:=20
https://xen.markmail.org/message/jofia74b2s4jprqa

The main question for me is how Firmware will know from which channel it
should read the message.

In current implementataion we use SMC Client_ID (reg7) of SMC message to
pass channel_id from Xen to Firmware.

I'm also thinking about the alternative way to generate unique Func_ID
for each channel, so Firmware can get information about channel_id from
the Func_ID.=20
In any case - I will be happy if you join the discussion about agent_id
in Xen mailing list. I can CC you if you intend to take part.

>=20
> > Given example shows the configuration of the hsusb node, which is using
> > scmi to contol clocks, resets and power-domains. scmi_devid is set
> > equals to 19, which should match defined id for usb in the Firmware.
> >=20
> > Trusted agent will use scmi_devid to set the device permissions for
> > the Agents. Guest OS should not have an access to the permissions
> > settings, so no code to process scmi_devid was presented in Linux
> > kernel.
> >=20
> > We are currently contributing changes to Xen, which are intended to
> > mediate SCMI access from Guests to the Firmware. Xen uses scmi_devid to=
 set
> > the permissions for the devices. See [1] thread for details.
> >=20
> > [0] https://urldefense.com/v3/__https://developer.arm.com/documentation=
/den0056/latest__;!!GF_29dbcQIUBPA!ipwkZidQn94BuaF7b6AopvUjQJGLSkgQm6QnAqOa=
evFBqCYEYEQZVOq8CGFd5j8_JWEz$ [developer[.]arm[.]com]
> > [1] https://urldefense.com/v3/__https://xen.markmail.org/message/mmi4fp=
b4qr6e3kad__;!!GF_29dbcQIUBPA!ipwkZidQn94BuaF7b6AopvUjQJGLSkgQm6QnAqOaevFBq=
CYEYEQZVOq8CGFd5seDaFDv$ [xen[.]markmail[.]org]
>=20
> IMHO, but I could be wrong, looking at the current SCMI spec you cannot j=
ust
> gather messages from a set of GuestOs talking via different SCMI channels=
 and
> then pipe/route them through a single channel to the backend server,
> attaching/spoofing some sort of Agent source ID to each message like you =
seem to
> be doing in the Xen series

I think you misunderstood my approach. We're not gathering messages from
GuestOs. Each GuestOs uses it's own channel_id to communicate with
firmware. What Xen does in current implementation is intercept SMC
messages and set channel_id to SMC Client_ID parameter (reg7) and
redirects it to the Firmware. Firmware parses reg7 and knows which
channed it should use to get the request.

In the new approach, which I suggest in Xen mailing list (I will be very
happy if you share your thoughts there) doesn't require SMC messages to
be intercepted by Xen, so each GuestOs will have it's own channel with
the Firmware.

>=20
> " Also XEN is the mediator which redirects SCMI requests, adding agentID =
so
>   firmware should know the sender."
>=20
> I may missing something though, not really a Xen expert here, or maybe th=
is
> agentID identification trick could be considered something not covered
> by the spec and strictly part of the transport layer...not sure... the gu=
ys
> in CC may have different/opposite opinions so feel free to redirect my
> blabbing to /dev/null at the end :D
>=20

SCMI spec describes how agent_id should be passed only for Message type
3 which is Notification (See 4.1.2 of DEN0056D). SMC spec say that
Client_ID is reg7. This Client_id is what I've used originally.
The new approach I suggest gives ability to get rid of Client_ID and use
Func_ID to determine channel.

Best regards,
Oleksii
