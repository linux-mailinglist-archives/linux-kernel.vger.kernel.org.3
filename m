Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90620532302
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 08:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbiEXGRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 02:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbiEXGRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 02:17:33 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497DC344F9
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 23:17:25 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NKcWQp010138;
        Mon, 23 May 2022 23:17:15 -0700
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2040.outbound.protection.outlook.com [104.47.74.40])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3g6ykm17dm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 23:17:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JaIzRmujSZJiVIcsDmPkd7Aegl9VhWj1WGJoADahxVl60fTsKLJ6VzMZvSytZaAhoeM2lLM+PYFaGhIGvT0+Ban7mPjsfDDL15AhTsllKQSIkRpUiKFkJ5KL7CHD1H6Sq6GV8Eea0cL86xtcSfLYLxDwI7Ed3HwGguTtJZDJ6lfW414NHvnuEh6Cpz+6uKli0nCj3CbesMusKvlua+np9pIHRQwJNDOBxl2lrPe7lQ46nLZZ1eF1uTUwqbiwioSOYpxNmyieLx38RVeM665/NsV1qrqELK20PNkqyXUJ/PPnAqOREP1qDTPM6T+ajy4trQiCsiuRomDXwwd2wAdRUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bq8NSlx0eQ7XFPYgudlJW5qpvufvId10iPvrYlhGmYM=;
 b=VCdCAcBCW+Iu50GPWZB0RdnLK63c8vz0V3PdOSQA/2E/BzFVmVMOSyc5ig//PW4BS7ItI+jqFelcp48B6wdPQxaQrxyV02EyPHBQiy89eGC4XiymI0aSAnq97d3W5rE/xUGMcv9JlNzHxFeOCobj8kpFH9xziPl9BsbnS788M6BXJHc7hm9epvh9ETAoOauFeZWmJAfM6slWRBiIZEXuGCsNm9yvW4BmOzbY4enLcKdOCFc9aGahK4angeE+ersBGQ+CqSdNMdG9sDcfjmjIX/2RE60Gq+kKl8/Ab9g2XguLOcfe8chnmZF93PLSplynf0U+3xFH0y0EmGMeAjPsdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bq8NSlx0eQ7XFPYgudlJW5qpvufvId10iPvrYlhGmYM=;
 b=B3hYcF9/5aPgdGDqHOG0xnp+6NEPx3LG5qNc7HFN1Nbi6JYj4RY4iyxq6Zuja+Mdux9QypBvNJ0ttKiydJWqVq5sF2QLvUq3f3X4XGfqpSnBrjYPjUWe4wLdOtpYlfvWDa1FTmwYywzss7mxsRnYribD/2SYMJzH7C5fL31rFOc=
Received: from PH0PR18MB5017.namprd18.prod.outlook.com (2603:10b6:510:11c::22)
 by SN1PR18MB2206.namprd18.prod.outlook.com (2603:10b6:802:26::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Tue, 24 May
 2022 06:17:12 +0000
Received: from PH0PR18MB5017.namprd18.prod.outlook.com
 ([fe80::59b3:4b47:a2:bf02]) by PH0PR18MB5017.namprd18.prod.outlook.com
 ([fe80::59b3:4b47:a2:bf02%4]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 06:17:12 +0000
From:   Tanmay Jagdale <tanmay@marvell.com>
To:     Rob Herring <robh@kernel.org>
CC:     "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Amit Singh Tomar <amitsinght@marvell.com>,
        "james.morse@arm.com" <james.morse@arm.com>
Subject: [PATCH] perf/marvell_cn10k: Add MPAM support for TAD PMU
Thread-Topic: [PATCH] perf/marvell_cn10k: Add MPAM support for TAD PMU
Thread-Index: AdhvL9jChvPY9vxZQ7KHsS40IZqAQA==
Date:   Tue, 24 May 2022 06:17:11 +0000
Message-ID: <PH0PR18MB5017A072E3FBA35785282FE2D6D79@PH0PR18MB5017.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0302655c-681f-4d87-74ba-08da3d4d0a3b
x-ms-traffictypediagnostic: SN1PR18MB2206:EE_
x-microsoft-antispam-prvs: <SN1PR18MB220619B030C0FBA6813D0A70D6D79@SN1PR18MB2206.namprd18.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x96Yj+2EERJQmjX0Nh6iKW4Dz0dqE6F4p1k+OzY0ekRw/kOuykPmG+GOUe6mXjuXoPxmAD0vBQXjaOqvFd84Jsl+fZ5d8nPQFpwIGzfetNd+RsRK9GFsugdSwZ81vHwx8bZKnRSYOUmRyIYTB0tz/junyOJPfe7xBrbysWuuarACa2A+a6/WV4hRgXTQGLlWQtqDJ4rbaiaS/atUqrCU8JBI28O2N0hHTUi+7orXyBxpso+mOP1c6IZ0wAtvh2bSYpgP6ufmoXuucDPVxa5X/ZvEY1o7/U83UoZErba9Edo3T81BbltaRS5KSBGu0744VBrOtPCWqhTvgBpblZXUZdzxxflhJksx7TCKmEO7Y/z2fJcO3sQ3jLy0RzYiQ+gKqGSK8UmZCsbP/I/91QCIKUuxXTGmBAPM9VJuTlaNeEQmhxksxUP+wxSJ+kKagVxIFFIE+6RdVZaFjdYs4JMXbrMduNb9fmQvh0TYQgj+6Sakh0OIJP7wjEpFdv8YqArJLrGSlpH2NKBpvzNrrZ+7JgxsUPptiQ03zVzBrJ/hQ7EA3KnnVEOB3fmz719DgOFnraPUeHlmmtvZz2NFmkElrhL/F6C2xfa+djVbEku+rIAit6UFSXQzjPceOFTCQJcAMHcGkiDcXTVWySyDvWSSt4jVZAzpjFNpEICn4srdj0Lba/SbrFuaLmTeD3gXGSMKQDZY9ojZApBmCVPUdN4A/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB5017.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(186003)(86362001)(7696005)(6916009)(54906003)(55016003)(38100700002)(71200400001)(508600001)(33656002)(83380400001)(66556008)(2906002)(66476007)(76116006)(66446008)(66946007)(64756008)(6506007)(55236004)(52536014)(38070700005)(122000001)(8936002)(5660300002)(26005)(9686003)(8676002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2mHaJ7xg8JpvoRx6DmCfwpNdeVSliS2aqiJGxr9frB1q7anrmNFeqJnLkJ/a?=
 =?us-ascii?Q?Vs7wJNHLijqoxeWAufnDlwB8c1ARTib+DoAszd28jtSWCNG/G9h3guYEDQGf?=
 =?us-ascii?Q?mTYiJVnEEiqdT91W49IM5L+QipJHIYUIq+UUfa2SJOSYyKWl4rxWVF/aMijx?=
 =?us-ascii?Q?vkm8N/VhhOghylpi2EeJQJ3U1Pzj3vHxF5AASXfkhIipGFvghxMWkwXKdxip?=
 =?us-ascii?Q?yDux1/v+3WhLrBxqZ8WhEwOkk4y5iz+QJyLNizi1qZ9JTmQXe4tdyOvJNRM/?=
 =?us-ascii?Q?7HoyPs/iYAQonrSjV0nPvqsxH3SWJXMBLFEx0v+cJiTxugqcPFDdZeb+p277?=
 =?us-ascii?Q?wppvcp/p4s3oTWVm14aLOh5epGgYdeQb1fgDTp9Sz6a0YxFuwMEEocmzkDfG?=
 =?us-ascii?Q?21qfIkDmk2F3bsGAK8dR52TbducMlBeFb3YPPLk41PS23oRTtkSsisEIdCKM?=
 =?us-ascii?Q?4kvA8nWZWtCScriSHvXXm3kEqBRpDbAoOckfgj5NTmKhQQytQPcx+y6XUiho?=
 =?us-ascii?Q?OWQXVTN0TqCKClA6jjKLqhjo20jGF1JEFfOIcFemBz/asj9Ps2Gbvgq3zkby?=
 =?us-ascii?Q?tTUtjeaeW9APgXCU4n/8s/S18xXZu7yw2x+E1PE8ZQYtjRoLBP/3zd4UNs/g?=
 =?us-ascii?Q?acmASSDT8hek68Sxca7ENiDZILjIqjp/czjgEnv4bTGi8u5t7S5MfmsbxOJq?=
 =?us-ascii?Q?ARDFpN/lo4rCY7vV4f8JDvYAuyhfb0gzo2K5gCijc2heS+otPwIHqdUIcv4K?=
 =?us-ascii?Q?wW66uWT6wmrn2MgrjA5OjrU/yZcHK7zQEvxgO93eDBpL7bKwEbCrwBJscaUc?=
 =?us-ascii?Q?lGnT2F67kCLEg3ZsGvqiPKkv1VaqiL5uVu6O5c6S27c246mRwZ8cdO5bJRuj?=
 =?us-ascii?Q?RvK2k4j+bkq0LYPnxtqaY+n4rczPfv29kOZn7L3GxRA/fJgvp47PirFI/68V?=
 =?us-ascii?Q?2U9Gj5ZnLE+EGC3l5+D4PV06O4ph4gihiX+DbueqzRFkw6RWLmq2vryp78s7?=
 =?us-ascii?Q?jtVNIJlypM50rOqyNC3/Ih1PzLSMh21sLtXsXutu3pHGIXRR2aMSWfY6/wJu?=
 =?us-ascii?Q?p2Rp+Ufd4LCKfZd6NrP6pBJwFWufbqI+gOr7XV9WeXz+3IWf1qB795vEQRrr?=
 =?us-ascii?Q?W0jr8sopow4CxlJ5so4RQy81fLqi9IQrOFRMw9FtOmgn8yD0v6dJzjBTAa0Z?=
 =?us-ascii?Q?OIp8h09ZLcNLlBzmZdH9Dc0VhpsruArP7omcu9et96IwCuWePZ2f9nSVb5cD?=
 =?us-ascii?Q?ATjOWJHmNWjDy+UB56ZZIZFO1t5AOSwd3duU/pNWhMypQQSjVjDuNjJ3htrD?=
 =?us-ascii?Q?3Lo7Hps/SU2RdUgA+GiSgLiIbsryvg8XjItuHQscGyq+WC7Ke4FDZ5i/Ilwz?=
 =?us-ascii?Q?5tQ3NGWzPkijMrOGI090b1KkDiBXNoDP4wzhCS2NUb9jmCnMU9vvd1KtRwAs?=
 =?us-ascii?Q?QIThLTdKkx8EK/ryLlsp0IxftTys06skgqfFJ11LRENKDFnlMTlEdv+YZx5J?=
 =?us-ascii?Q?0VvjKAOeJCfuwYshK4PYWOe7l/NeiWuJxJPOKAY4cxhT16iXevV6eG827QHG?=
 =?us-ascii?Q?cyl9+So8Q2Szwlgy8Se7eh1VGa4mXkas+C19L3sywYQBWWD6prTAbkvXG/t3?=
 =?us-ascii?Q?tHs1vEF8fBjBr2NGXG9ey2Ber5KlXrPKP/6woxQ2UleS/7ZgY1YQbSBuUkw5?=
 =?us-ascii?Q?ys+BPD80HsczaWXStIlW6HNhBeEJD1Md4YvOO73s4ADJ/xh8LHueenFGn40M?=
 =?us-ascii?Q?yxiFdIc94Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB5017.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0302655c-681f-4d87-74ba-08da3d4d0a3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 06:17:11.9166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N/LRPA86aDwVxbGcYOygmTzaGwqupfO8/SLs4nl64+N3ITBqcXjCwSW2dVp6I8El0siZ0XYncSuBzf21UWIn1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR18MB2206
X-Proofpoint-GUID: 8QFB2RpmsmS3thCTeOinaT_stTsn6bIC
X-Proofpoint-ORIG-GUID: 8QFB2RpmsmS3thCTeOinaT_stTsn6bIC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-24_04,2022-05-23_01,2022-02-23_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,


> > The TAD PMU supports following counters that can be filtered by MPAM
> > partition id.
>=20
> How are you setting the PARTID? There's no support yet in the kernel to
> set it.
We have ported MPAM support from James Morse private tree to test this.

>=20
> >     - (0x1a) tad_alloc_dtg : Allocations to DTG.
> >     - (0x1b) tad_alloc_ltg : Allocations to LTG.
> >     - (0x1c) tad_alloc_any : Total allocations to DTG/LTG.
> >     - (0x1d) tad_hit_dtg   : DTG hits.
> >     - (0x1e) tad_hit_ltg   : LTG hits.
> >     - (0x1f) tad_hit_any   : Hit in LTG/DTG.
> >     - (0x20) tad_tag_rd    : Total tag reads.
> >
> > Add a new 'partid' attribute of 16-bits to get the partition id
> > passed from perf tool. This value would be stored in config1 field
> > of perf_event_attr structure.
> >
> > Example:
> > perf stat -e tad/tad_alloc_any,partid=3D0x12/ <program>
>=20
> How would userspace get the 0x12 value?
It's up to the user to create partition id and use the same id here.
For testing, I had used the MPAM resctrl infrastructure to create
and get partition ID.

>=20
> >
> > - Drop read of TAD_PRF since we don't have to preserve any
> >   bit fields and always write an updated value.
> > - Update register offsets of TAD_PRF and TAD_PFC.
> >
> > Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
> > ---
> >  drivers/perf/marvell_cn10k_tad_pmu.c | 23 ++++++++++++++++++-----
> >  1 file changed, 18 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c
> b/drivers/perf/marvell_cn10k_tad_pmu.c
> > index 282d3a071a67..f552e6bffcac 100644
> > --- a/drivers/perf/marvell_cn10k_tad_pmu.c
> > +++ b/drivers/perf/marvell_cn10k_tad_pmu.c
> > @@ -18,10 +18,12 @@
> >  #include <linux/perf_event.h>
> >  #include <linux/platform_device.h>
> >
> > -#define TAD_PFC_OFFSET		0x0
> > +#define TAD_PFC_OFFSET		0x800
> >  #define TAD_PFC(counter)	(TAD_PFC_OFFSET | (counter << 3))
> > -#define TAD_PRF_OFFSET		0x100
> > +#define TAD_PRF_OFFSET		0x900
> >  #define TAD_PRF(counter)	(TAD_PRF_OFFSET | (counter << 3))
> > +#define TAD_PRF_MATCH_PARTID	(1 << 8)
> > +#define TAD_PRF_PARTID_NS	(1 << 10)
> >  #define TAD_PRF_CNTSEL_MASK	0xFF
> >  #define TAD_MAX_COUNTERS	8
>=20
> Does this h/w block follow the MPAM specification or just uses PARTID in
> its own way?
No, these counters are not as per the MPAM monitoring specification and we
use them in our own way.

Thanks,
Tanmay
>=20
> Rob
