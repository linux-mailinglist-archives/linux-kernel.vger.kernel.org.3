Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DDD4C84BA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 08:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbiCAHOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 02:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiCAHOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 02:14:32 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A379A60D90
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 23:13:50 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2216x1KA013873;
        Mon, 28 Feb 2022 23:13:25 -0800
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3egn96x76s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Feb 2022 23:13:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUc77sABJOsX9G0gk+l+z3NiXoayhtFT25O9LdrxZg6MY7E8hmn+Nhqy2EuhvBqNuklfASE7sM54oJrD5CSDUsh1sLXGK2WQcuVXwetyZvRhIs3WOqu06aZOySVmGvEeZeTNI1NowYl6cgfvv/sNUfDaPY4p+jprizDSfZ92qoVpnBeLyszgSdKwY5A+Vi+hDMHmwwku5/bk08LFfXwtJt1A1Xnin2rQsPk/dQoGP/xHVr/fZAcOSTr9JM0Pb9UNPePxkrAvxVMpeY7WsETtvn4ApgT8GVa3zX1a5dS0njYllI9Uqr4ny/nwHaCgNpo444IVUFNINtt0j7GkyP5Mlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UIBHY3ZzHlHoXQLZtlZjP4hOCdXu75E0lYDlW8hibg=;
 b=IXdmccu4jLU8lPiTrrjHTthfnPk2hIL52jL7U++LztVWnXvzHshtDTzAS+4tfRxrF6AEB8qGM49cnordxq9eA29n7/aU6y93/FTEds81oT0z+0n89GzQ7qcLJzv26ztIK5Amy1OVIbPYOud0bPzVsZV6gqxYhm6L3VJI0nz31aRYvVFNs3a/HB/S6z+bDnlXqnCnAkzCru9SgaZQFmqeA3hKw+/iJ6qitPNuiW5eyR8XLN9jWbZhqqu+NRUlK3TAt0o8aWteSKWzMtG22DRP0nZZr+JnL3KD1KYyf1j0bJO8qDvW88LhHjnjpSdMkZHlS9tmBQrHnqh2IAUE+ACpSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UIBHY3ZzHlHoXQLZtlZjP4hOCdXu75E0lYDlW8hibg=;
 b=GUl3TnZiw8SrJdm89PLYkw7ROJsbNtVynyw77uBiSHjodpl/LkwbxSdtOcgq5IAH8LkHR9UDNx1TVCsXqEbVRqnxeZMigOL5ySMtMq9Hi67bhcy6aAt6nONFrCWlhV2tNISkFElGBudUezR68B+jK19yIxazrrGY0HHeP2aR7WY=
Received: from PH0PR18MB5002.namprd18.prod.outlook.com (2603:10b6:510:11d::12)
 by BL1PR18MB4232.namprd18.prod.outlook.com (2603:10b6:208:316::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Tue, 1 Mar
 2022 07:13:22 +0000
Received: from PH0PR18MB5002.namprd18.prod.outlook.com
 ([fe80::493d:175f:17e6:8e8d]) by PH0PR18MB5002.namprd18.prod.outlook.com
 ([fe80::493d:175f:17e6:8e8d%3]) with mapi id 15.20.5038.014; Tue, 1 Mar 2022
 07:13:21 +0000
From:   Linu Cherian <lcherian@marvell.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linuc.decode@gmail.com" <linuc.decode@gmail.com>
Subject: RE: [EXT] Re: [PATCH] irqchip/gic-v3: Workaround Marvell erratum
 38545 when reading IAR
Thread-Topic: [EXT] Re: [PATCH] irqchip/gic-v3: Workaround Marvell erratum
 38545 when reading IAR
Thread-Index: AQHYKw0hdiBMETrdGk6GaWO7R7nwoKyl2YUAgAL5ndA=
Date:   Tue, 1 Mar 2022 07:13:21 +0000
Message-ID: <PH0PR18MB50022049AE4CF3203E0318BBCE029@PH0PR18MB5002.namprd18.prod.outlook.com>
References: <20220226123332.29988-1-lcherian@marvell.com>
 <871qzp7n4r.wl-maz@kernel.org>
In-Reply-To: <871qzp7n4r.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 250d271e-0295-4113-3d52-08d9fb52f822
x-ms-traffictypediagnostic: BL1PR18MB4232:EE_
x-microsoft-antispam-prvs: <BL1PR18MB4232241B5D7C3FC31C62C785CE029@BL1PR18MB4232.namprd18.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9gIZ5HkUYFztvGXfaazRh8nYB9w7PnLghOz+fkY08OebmrWauzYTbxa0obI/ohcIh4UAo2GsCsDyt7k7s8jX4PYlShbgDqrSWJQ3VqEGbJL8++2s24kf3OQsgu5wc45DTpXWZp8qK4E5Tw7ZVQdygFJy135pz1C+mouQuZ4DQg8vfF9zH7CTdExkpcjmQTj+GLXqZ7dOj1Gu6WQwNaxMKKNkKo7DDTYWuu2dna23FqZ244jvZ/ocRRHOe4tTtmSCgOQ+OyRtWqZ0CIt+QpIGZIf+It3qD+o+bWoMpDXXTGOsj/Eu80BWlaOlA+Wx3gdoIhgGb2okr3GV3dyhxLQXj5dw1u9a72CeNz8oRugfAfvS3SCXNmmPufoZz0vy5TSK/oPQ1DEQB+ncVPym7ttDZTXJTSDrH0h4h+EsuxyFAU1Q2jafDSHt+CQEGUokYhCkUHbUeFVL+iEVj3NnfbbSGfuMfRlPGdO5agtZH0ROoxAC0rJw5DES7S1JkBzva3Np/zktwqxmeBB/qsY3cxu4FDPuaThk1CQViEcH8SqKhTa7nHMTpn6YCneRM8HDFqBlur8BWdMCS1PoAEZMsRPTvqiModb08+ZZX6ODdUC4MAtT9lnUBkbCsLyb2MxrVtJDh4/BkMKMN2Xmb8xSIz+VEvDqi7RCFu4eb9HRjbV8TPwRiZboWzkjDImNilcosOfqQo9JfASFhfJ+yMoXUU9mog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB5002.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(30864003)(8936002)(26005)(86362001)(186003)(55016003)(5660300002)(52536014)(38100700002)(55236004)(53546011)(33656002)(6506007)(7696005)(9686003)(508600001)(71200400001)(38070700005)(6916009)(2906002)(83380400001)(66476007)(316002)(64756008)(66446008)(66556008)(4326008)(122000001)(8676002)(66946007)(54906003)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IiVNBFBF7uevCeTmIHBgqCXRZl4iPHBqRRUv7MpgDerGiaEG/IvPasiu2UGD?=
 =?us-ascii?Q?UZQBFBVlBJ0ssUGp1EgHFRbWHwuNUEcIWqNtJqTPhZSi7BAH5EHFD6hWyAeS?=
 =?us-ascii?Q?bWzJ97zVGgJoG+lYd8E4ioO6PT+RouESoF7OZgBaUWzEll8uAlPUYsU3pZFp?=
 =?us-ascii?Q?y/ytwLriMO03u+fY7qOfLxvD9Eo1ofA9JoUO1ygJYQ30p0nLDg1HqoaJ7ScB?=
 =?us-ascii?Q?ANsZfHZvCGwlyqDQ5i1CtYdQO3DJr7f7VSTtmDqA+VmY817IF4mr6gvDhiXg?=
 =?us-ascii?Q?H0gjtKnFgdmDX3PLkcR7gkCyt2JUGvcreeCVjiK0gpGrJpTM1YLUwUQtIdRm?=
 =?us-ascii?Q?86ckXZkLOp0T4CXJDsQalbQxbJzMfZnMsh0vQtXlpO7ig1NUzGOTLqVaTWUA?=
 =?us-ascii?Q?clxipBVwprqYHu0wLsP9NMdT0gCkGZQ/42xbQUqswcG9C9HvO0o//o64K9RX?=
 =?us-ascii?Q?VtpO9RxIXq+6ej6cyYanvBJbT5fjYt8o0PK6OMyoceT6AZ9CVVq2shfgINJM?=
 =?us-ascii?Q?I39fol91/EKfxSa6uQerVx7AvDW54VFsRsa229xFom+h9HkRTMY+3569ivlg?=
 =?us-ascii?Q?NZY2rCED2nMJ2MWX2Boimj04Ge9rKiKdNDPKIQ64CrFyfYIZlcP6LHSQpbv9?=
 =?us-ascii?Q?BvvHnPgUxtASlQ7fpDLs4D7n+V+AFeBi8vmlJ647Qtv7/o8g1HA0dx2luBGT?=
 =?us-ascii?Q?NWORFnMLOaLu2myu2+nCJPTT7XWTftIM3ovEpTI8ZWjKFruTxmUE1aFn1sGs?=
 =?us-ascii?Q?Fj7v+32jfyjMB/fxrNPLcybZYI2n1dCYVhbURewNUytZtk0h1J1xOt3EUFZh?=
 =?us-ascii?Q?2gSMBaE3drp+V5EtJww8Xx+ZV3C17nlsPL3CdGaJCCRaG/y7k/EKo/8ZZtMv?=
 =?us-ascii?Q?JGvYuXxL35+D/4OaqrtI4hJrPcVI1CynLh8G2PPTmamZWzx1tyBM+7Wsdy4H?=
 =?us-ascii?Q?ppi1fTUgSjOBlKTm8y+B72UAi0kEppnvhvV+ZqTtFQHLtzX6yfTpge3tDa+9?=
 =?us-ascii?Q?2fXp9CmBoDjhl4nyCG4ZQ3EmlebAe4cUMeGG4dkb19VgaCO2AbVz27hjT9vK?=
 =?us-ascii?Q?IIoN+nO7ZjY0Vk/RJ35TtB0HXGSNlZmOn5Sq48tqM7dGcDP9QxIAqCoD+g/n?=
 =?us-ascii?Q?Iu7a//1k0RCjQ3deIUvb8bJ2t4napxa1Wo9hLsDmV7MMx1Dn6lbL6JMEGpYq?=
 =?us-ascii?Q?oEgVDj3JL9esEaeilnJ78DIxn0oZZFMKKgHxNfb77oQzkbKjz0gKsoqTRE6q?=
 =?us-ascii?Q?WPi0BJWY5Q9jFqVUgX8CIw/F6wIY+keVT37SaGweUSCYXV27+j68ZH7nFWr4?=
 =?us-ascii?Q?Z+4d39aYMkZJvFVOS9jE6JVqcPmaEkOwUIOpEAdU62DPIUCrLcSmAwKFoaPS?=
 =?us-ascii?Q?WV3j3RuK+BHKwE1EHFNXHEr6NjesbCmmXVWYqIHBA5hhR9tAtdTiG+CJVOX7?=
 =?us-ascii?Q?6L/v7IiQgFJqtBDw8zblOvzglzOgYFyPGrEbfESvbyuItIG5TSr9qyv8R5Wb?=
 =?us-ascii?Q?JJPw162fA01TsRuzMp1N8i3vW2uA0pH2SJCOBxWs76YWeCDpGvZZHwI064ck?=
 =?us-ascii?Q?5HDF7YCeQJIT4ZgTsiK7d5dqA/wibfaxyu8ABC/Ba/WCgmkI/dLqnb6ZdpOK?=
 =?us-ascii?Q?CaaUB/Cez4nPJ1yMfIXmYkw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB5002.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 250d271e-0295-4113-3d52-08d9fb52f822
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 07:13:21.6957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 45hOAUPhBn2O8HwQPnhCCx1iWmAblSX50Uab+kpVaFkmA8ltiTFC8AGD8qova9wj9X/tcVg+xvaYN97UVK84lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR18MB4232
X-Proofpoint-GUID: wQFioDKwkpq2lUqfMZBE22JXqGKB7hA_
X-Proofpoint-ORIG-GUID: wQFioDKwkpq2lUqfMZBE22JXqGKB7hA_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-28_10,2022-02-26_01,2022-02-23_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

> -----Original Message-----
> From: Marc Zyngier <maz@kernel.org>
> Sent: Saturday, February 26, 2022 7:20 PM
> To: Linu Cherian <lcherian@marvell.com>
> Cc: tglx@linutronix.de; catalin.marinas@arm.com; will@kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> linuc.decode@gmail.com
> Subject: [EXT] Re: [PATCH] irqchip/gic-v3: Workaround Marvell erratum
> 38545 when reading IAR
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Sat, 26 Feb 2022 12:33:32 +0000,
> Linu Cherian <lcherian@marvell.com> wrote:
> >
> > When a IAR register read races with a GIC interrupt RELEASE event,
> > GIC-CPU interface could wrongly return a valid INTID to the CPU for an
> > interrupt that is already released(non activated) instead of 0x3ff.
> >
> > As a side effect, an interrupt handler could run twice, once with
> > interrupt priority and then with idle priority.
> >
> > As a workaround, gic_read_iar is updated so that it will return a
> > valid interrupt ID only if there is a change in the active priority
> > list after the IAR read on all the affected Silicons.
> >
> > Along with this, Thunderx erratum 23154 is reworked to use GIC IIDR
> > based quirk management for the sake of consistency and also because
> > there is workaround overlap on some silicon variants.
> >
> > Signed-off-by: Linu Cherian <lcherian@marvell.com>
> > ---
> >  Documentation/arm64/silicon-errata.rst |  4 +-
> >  arch/arm64/Kconfig                     | 10 -----
> >  arch/arm64/include/asm/arch_gicv3.h    | 24 +++++++++--
> >  arch/arm64/kernel/cpu_errata.c         |  8 ----
> >  arch/arm64/tools/cpucaps               |  1 -
> >  drivers/irqchip/irq-gic-v3.c           | 56 +++++++++++++++++++++++++-
> >  6 files changed, 77 insertions(+), 26 deletions(-)
> >
> > diff --git a/Documentation/arm64/silicon-errata.rst
> > b/Documentation/arm64/silicon-errata.rst
> > index ea281dd75517..f602faf4bf82 100644
> > --- a/Documentation/arm64/silicon-errata.rst
> > +++ b/Documentation/arm64/silicon-errata.rst
> > @@ -136,10 +136,12 @@ stable kernels.
> >  +----------------+-----------------+-----------------+----------------=
-------------+
> >  | Cavium         | ThunderX ITS    | #23144          | CAVIUM_ERRATUM_=
23144
> |
> >
> > +----------------+-----------------+-----------------+----------------
> > -------------+
> > -| Cavium         | ThunderX GICv3  | #23154          |
> CAVIUM_ERRATUM_23154        |
> > +| Cavium         | ThunderX GICv3  | #23154          | N/A            =
             |
> >  +----------------+-----------------+-----------------+----------------=
-------------+
> >  | Cavium         | ThunderX GICv3  | #38539          | N/A            =
             |
> >
> > +----------------+-----------------+-----------------+----------------
> > -------------+
> > +| Cavium         | ThunderX GICv3  | #38545          | N/A            =
             |
>=20
> Cavium? Or Marvell? I can understand the identity crisis, but you should =
pick
> your poison. It also seem to affect the new TX2 rather than (or in additi=
on to)
> the ancient TX.

It doesn't applies to Tx2(ThunderX2) and it affects OcteonTx2, OcteonTx
and ThunderX.

In the V2 will rename this as OcteonTx2 to avoid confusion with ThunderX2.


>=20
> > ++----------------+-----------------+-----------------+----------------=
-------------+
> >  | Cavium         | ThunderX Core   | #27456          |
> CAVIUM_ERRATUM_27456        |
> >  +----------------+-----------------+-----------------+----------------=
-------------+
> >  | Cavium         | ThunderX Core   | #30115          |
> CAVIUM_ERRATUM_30115        |
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig index
> > 09b885cc4db5..889cb56bf5ec 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -890,16 +890,6 @@ config CAVIUM_ERRATUM_23144
> >
> >  	  If unsure, say Y.
> >
> > -config CAVIUM_ERRATUM_23154
> > -	bool "Cavium erratum 23154: Access to ICC_IAR1_EL1 is not sync'ed"
> > -	default y
> > -	help
> > -	  The gicv3 of ThunderX requires a modified version for
> > -	  reading the IAR status to ensure data synchronization
> > -	  (access to icc_iar1_el1 is not sync'ed before and after).
> > -
> > -	  If unsure, say Y.
> > -
>=20
> This is starting really badly. Why make this config option disappear?
>=20
> This is both useful for documentation (in the absence of a public errata
> document from the silicon vendor, I *really* want to know what I am affec=
ted
> by) and for people who do not want their kernels to be encumbered by
> support for broken HW.
>=20
> I actually want to see a description of the *new* errata in Kconfig, wart=
s and
> all.


Ack. Will revert this.

Let me clarify the reason why it was removed.=20
IIUC, there are two ways in which errata is managed in the GIC driver.
1. GICD_IIDR based quirk management
2. CPU MIDR based quirk management

Somehow I overlooked the virtualization scenario and missed the point that,=
=20
GICD_IIDR doesn't reflect the actual Silicon implementer in a guest unlike =
CPU MIDR and=20
hence wrongly assumed that the errata will take effect in both host and gue=
st.
=20
Opted for the IIDR method(option #1), since it was contained within the GIC=
 driver.
Will change this to option #2 .

>=20
> >  config CAVIUM_ERRATUM_27456
> >  	bool "Cavium erratum 27456: Broadcast TLBI instructions may cause
> icache corruption"
> >  	default y
> > diff --git a/arch/arm64/include/asm/arch_gicv3.h
> > b/arch/arm64/include/asm/arch_gicv3.h
> > index 4ad22c3135db..bc98a60a4bcb 100644
> > --- a/arch/arm64/include/asm/arch_gicv3.h
> > +++ b/arch/arm64/include/asm/arch_gicv3.h
> > @@ -47,21 +47,37 @@ static inline u64 gic_read_iar_common(void)
> >  	return irqstat;
> >  }
> >
> > -/*
> > +/* Marvell Erratum 38545
> > + *
> > + * When a IAR register read races with a GIC interrupt RELEASE event,
> > + * GIC-CPU interface could wrongly return a valid INTID to the CPU
> > + * for an interrupt that is already released(non activated) instead of=
 0x3ff.
> > + *
> > + * To workaround this, return a valid interrupt ID only if there is a
> > +change
> > + * in the active priority list after the IAR read.
> > + *
> >   * Cavium ThunderX erratum 23154
> >   *
> >   * The gicv3 of ThunderX requires a modified version for reading the
> >   * IAR status to ensure data synchronization (access to icc_iar1_el1
> >   * is not sync'ed before and after).
> > + *
> > + * Have merged both the workarounds into a common function since,
> > + * 1. On Thunderx 88xx 1.x both erratas are applicable.
>=20
> This is new. Are you saying that TX is also affected by this new bug?
> Experience doesn't seem to support this statement, but I am prepared to
> believe that this thing is even more broken than I thought.
>=20

Yes. Thunderx is affected by this new bug as well but got identified only w=
hile testing
 on a OcteonTx2 hardware. HW team has confirmed that it applies to the olde=
r
ThudnderX and OcteonTx Silicons as well.


> Also, what is the story for virtualisation? Does the ICV interface suffer=
 from
> the same bug? I can't see why not (23154 definitely affects virtualisatio=
n).
>=20

Yes. It affects virtualization as well and the errata is applicable to ICV =
interface.


> > + * 2. Having extra nops doesn't add any side effects for Silicons wher=
e
> > + *    erratum 23154 is not applicable.
> >   */
> > -static inline u64 gic_read_iar_cavium_thunderx(void)
> > +static inline u64 gic_read_iar_marvell_38545_23154(void)
> >  {
> > -	u64 irqstat;
> > +	u64 irqstat, apr;
> >
> > +	apr =3D read_sysreg_s(SYS_ICC_AP1R0_EL1);
> >  	nops(8);
> >  	irqstat =3D read_sysreg_s(SYS_ICC_IAR1_EL1);
> >  	nops(4);
> > -	mb();
> > +	dsb(sy);
>=20
> mb() *is* a dsb(sy). Why the change?

Agree the change is redundant.

>=20
> > +	if (unlikely(apr =3D=3D read_sysreg_s(SYS_ICC_AP1R0_EL1)))
> > +		return 0x3ff;
>=20
> So you are adding extra overhead to all TX platforms that did not require=
 it.
> Why is that an acceptable outcome? If all platforms affected by 23154 are=
 also
> affected by 38545, why are they treated independently with separate flags=
?
>=20

Basically we need two IAR workaround functions,

#1 That takes care of both  both 38545 and 23154 (For example ThunderX 88xx=
 1.x)

#2. That cares of only 38545=20

Since the only difference between the two is  12 NOPs, tried to use a
a common function for both the workaround to avoid code duplication.

Yeah. Agree that separate flags were really not required.

Will keep #1 and #2 as separate functions if that is preferred.


> >
> >  	return irqstat;
> >  }
> > diff --git a/arch/arm64/kernel/cpu_errata.c
> > b/arch/arm64/kernel/cpu_errata.c index b217941713a8..79beb800ee79
> > 100644
> > --- a/arch/arm64/kernel/cpu_errata.c
> > +++ b/arch/arm64/kernel/cpu_errata.c
> > @@ -423,14 +423,6 @@ const struct arm64_cpu_capabilities
> arm64_errata[] =3D {
> >  		ERRATA_MIDR_RANGE_LIST(erratum_845719_list),
> >  	},
> >  #endif
> > -#ifdef CONFIG_CAVIUM_ERRATUM_23154
> > -	{
> > -	/* Cavium ThunderX, pass 1.x */
> > -		.desc =3D "Cavium erratum 23154",
> > -		.capability =3D ARM64_WORKAROUND_CAVIUM_23154,
> > -		ERRATA_MIDR_REV_RANGE(MIDR_THUNDERX, 0, 0, 1),
> > -	},
> > -#endif
>=20
> NAK. See below.
>=20
> >  #ifdef CONFIG_CAVIUM_ERRATUM_27456
> >  	{
> >  		.desc =3D "Cavium erratum 27456",
> > diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps index
> > 9c65b1e25a96..3f751fe4fec4 100644
> > --- a/arch/arm64/tools/cpucaps
> > +++ b/arch/arm64/tools/cpucaps
> > @@ -62,7 +62,6 @@ WORKAROUND_2077057
> >  WORKAROUND_TRBE_OVERWRITE_FILL_MODE
> >  WORKAROUND_TSB_FLUSH_FAILURE
> >  WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
> > -WORKAROUND_CAVIUM_23154
> >  WORKAROUND_CAVIUM_27456
> >  WORKAROUND_CAVIUM_30115
> >  WORKAROUND_CAVIUM_TX2_219_PRFM
> > diff --git a/drivers/irqchip/irq-gic-v3.c
> > b/drivers/irqchip/irq-gic-v3.c index 5e935d97207d..a3b58bf4fce4 100644
> > --- a/drivers/irqchip/irq-gic-v3.c
> > +++ b/drivers/irqchip/irq-gic-v3.c
> > @@ -35,6 +35,8 @@
> >
> >  #define FLAGS_WORKAROUND_GICR_WAKER_MSM8996	(1ULL << 0)
> >  #define FLAGS_WORKAROUND_CAVIUM_ERRATUM_38539	(1ULL << 1)
> > +#define FLAGS_WORKAROUND_CAVIUM_ERRATUM_23154	(1ULL << 2)
> > +#define FLAGS_WORKAROUND_MARVELL_ERRATUM_38545	(1ULL
> << 3)
> >
> >  #define GIC_IRQ_TYPE_PARTITION	(GIC_IRQ_TYPE_LPI + 1)
> >
> > @@ -60,6 +62,7 @@ struct gic_chip_data {
> >
> >  static struct gic_chip_data gic_data __read_mostly;  static
> > DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
> > +static DEFINE_STATIC_KEY_FALSE(gic_iar_quirk);
> >
> >  #define GIC_ID_NR	(1U <<
> GICD_TYPER_ID_BITS(gic_data.rdists.gicd_typer))
> >  #define GIC_LINE_NR
> 	min(GICD_TYPER_SPIS(gic_data.rdists.gicd_typer), 1020U)
> > @@ -235,10 +238,19 @@ static void gic_redist_wait_for_rwp(void)
> >
> >  #ifdef CONFIG_ARM64
> >
> > +static u64 __maybe_unused gic_read_iar_fixup(void) {
> > +	if (gic_data.flags &
> FLAGS_WORKAROUND_MARVELL_ERRATUM_38545 ||
> > +		gic_data.flags &
> FLAGS_WORKAROUND_CAVIUM_ERRATUM_23154)
> > +		return gic_read_iar_marvell_38545_23154();
> > +	else /* Not possible */
> > +		return ICC_IAR1_EL1_SPURIOUS;
>=20
> Not possible? What does that even mean? And what is the point of gating
> things with a static key if you have to check again with an extra load?
>=20

Please see below.

> > +}
> > +
> >  static u64 __maybe_unused gic_read_iar(void)  {
> > -	if (cpus_have_const_cap(ARM64_WORKAROUND_CAVIUM_23154))
> > -		return gic_read_iar_cavium_thunderx();
> > +	if (static_branch_unlikely(&gic_iar_quirk))
> > +		return gic_read_iar_fixup();
>=20
> You are trading a static key for another one describing... the same thing=
. What
> is the point?

The real intention was to avoid an additional if check getting introduced l=
ike below for Silicon
not affected by both of these errata.

If (cpus_have_const_cap(ARM64_WORKAROUND_CAVIUM23154))
	return gic_read_iar_38545_23154(); /* Both workaround applicable */
else if (cpus_have_const_cap(ARM64_WORKAROUND_CAVIUM38545))
              return gic_read_iar_38545();  /* Only 38545 applicable */

So tried to use a static key, gic_iar_quirk instead.


>=20
> >  	else
> >  		return gic_read_iar_common();
> >  }
> > @@ -1614,6 +1626,16 @@ static bool gic_enable_quirk_msm8996(void
> *data)
> >  	return true;
> >  }
> >
> > +static bool gic_enable_quirk_cavium_23154(void *data) {
> > +	struct gic_chip_data *d =3D data;
> > +
> > +	d->flags |=3D FLAGS_WORKAROUND_CAVIUM_ERRATUM_23154;
> > +	static_branch_enable(&gic_iar_quirk);
> > +
> > +	return true;
> > +}
> > +
> >  static bool gic_enable_quirk_cavium_38539(void *data)  {
> >  	struct gic_chip_data *d =3D data;
> > @@ -1623,6 +1645,16 @@ static bool
> gic_enable_quirk_cavium_38539(void *data)
> >  	return true;
> >  }
> >
> > +static bool gic_enable_quirk_marvell_38545(void *data) {
> > +	struct gic_chip_data *d =3D data;
> > +
> > +	d->flags |=3D FLAGS_WORKAROUND_MARVELL_ERRATUM_38545;
> > +	static_branch_enable(&gic_iar_quirk);
> > +
> > +	return true;
> > +}
> > +
> >  static bool gic_enable_quirk_hip06_07(void *data)  {
> >  	struct gic_chip_data *d =3D data;
> > @@ -1660,6 +1692,13 @@ static const struct gic_quirk gic_quirks[] =3D {
> >  		.iidr	=3D 0x00000000,
> >  		.mask	=3D 0xffffffff,
> >  		.init	=3D gic_enable_quirk_hip06_07,
> > +	},
> > +		/* ThunderX: CN88xx 1.x */
> > +	{
> > +		.desc	=3D "GICv3: Cavium erratum 23154",
> > +		.iidr	=3D 0xa101034c,
> > +		.mask	=3D 0xffff0fff,
> > +		.init	=3D gic_enable_quirk_cavium_23154,
> >  	},
> >  	{
> >  		/*
> > @@ -1674,6 +1713,19 @@ static const struct gic_quirk gic_quirks[] =3D {
> >  		.mask	=3D 0xe8f00fff,
> >  		.init	=3D gic_enable_quirk_cavium_38539,
> >  	},
> > +	{
> > +		/*
> > +		 * IAR register reads could be unreliable, under certain
> > +		 * race conditions. This erratum applies to:
> > +		 * - ThunderX: CN88xx
> > +		 * - OCTEON TX: CN83xx, CN81xx
> > +		 * - OCTEON TX2: CN93xx, CN96xx, CN98xx, CNF95xx*z
> > +		 */
> > +		.desc	=3D "GICv3: Marvell erratum 38545",
> > +		.iidr	=3D 0xa000034c,
> > +		.mask	=3D 0xe0f00fff,
> > +		.init	=3D gic_enable_quirk_marvell_38545,
> > +	},
>=20
> I love the fact that you are checking for a a *CPU interface* bug based o=
n the
> *distributor* IIDR. What could possibly go wrong? Oh, don't worry, this o=
nly
> breaks... *all virtual machines*.
>=20

Thanks for pointing out. Will change this to CPU MIDR based checks.

