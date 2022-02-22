Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451404BF8BA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbiBVNHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiBVNHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:07:52 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80070.outbound.protection.outlook.com [40.107.8.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F103BB0A3;
        Tue, 22 Feb 2022 05:07:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHsKAfEuhPGpkYaIfRIXI5ESLra56NpjG3Uw6S6zl/hfAxRffmkgDuBSwR3hRv3juBIYUdZtPoyoYp8clJGUWqX5wZUe8k0CrJlH6Vio4Gu9CxzTUpg9kfpqTbdIEhuEy5ScHtBb1ss5wzUVgIhwdzRmJI0MpEGMk0v83onrt17FOSj/eX+iXpVMvR4+x/UnVbBgVrxS9Tb+4LKS9HOfk9pjY/OheLOktL2y06gIc/dYrCKGlqnOF57s4UD+3+jY80Ibqenv3vY804eiWUvoU5LAdRXmNRb/mEs5mjgwPqNCWA8Y/vLha6YQ6++xf1LNTTPz3+d3pfLjzoQ/PUOlXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrZcjhmlyhgeEE+ISWvi1jmSfULjiEq472mKKg58aOQ=;
 b=JiUed1O4Y8F648rtEjo5Adm7RWvIle1YxO/zPY2YysoqfKIETGbYjrqzcycqXiIbUl64ov/LpUkhM09pJO/ZWO9F9RA8himTrgW1RimmbcEWvHvISitksg+QPmJb+v4F5P0VL5CIIJ5AoNgXuYzZ+HWWcnlE95AJBfXhUqH/8BE1Xq21V21nnhyDcbUJQeleyXm7doP0G0xK7J4mDgmc0IUu2WW4/RzbDqfbtpk//XdVGuYygHnLGPK3sA+v+ycdKHMuUReaaky2GudDrtM8ppfeq8AbihTQJz4xy/XwPQzpPjEoaTnqeYIMj9K887uv8KstxSib4J6MLajzUF8phw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrZcjhmlyhgeEE+ISWvi1jmSfULjiEq472mKKg58aOQ=;
 b=N2NWoiSFTnJteqAKAsiS154U4IX3e69eU1Ok7Sgwg+kXAoTdYpU81/4OaeICfTc0dEo1tUi6fh3J8g65p7f9Nhh20sGk4dpDiMG5AFGeGGRqU34QF3zdCgZB10Jvb5T1SXSmUSTnEA0GehxqXgzJHNNAEyMQpPVamRs0qHTprxY=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7281.eurprd04.prod.outlook.com (2603:10a6:20b:1d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Tue, 22 Feb
 2022 13:07:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Tue, 22 Feb 2022
 13:07:22 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Rob Herring <robh@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <stefanos@xilinx.com>,
        Bruce Ashfield <bruce.ashfield@xilinx.com>
Subject: RE: [RFC PATCH v3 0/4] remoteproc: restructure the remoteproc VirtIO
 device
Thread-Topic: [RFC PATCH v3 0/4] remoteproc: restructure the remoteproc VirtIO
 device
Thread-Index: AQHYEtE0wJ0OgErjykyAoYmEY+BNQKyUZypwgAAsywCACyAD8A==
Date:   Tue, 22 Feb 2022 13:07:22 +0000
Message-ID: <DU0PR04MB941704E0665A0E23D47B29CE883B9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220126162405.1131323-1-arnaud.pouliquen@foss.st.com>
 <DU0PR04MB941722D995004F877DC6171D88349@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <b483084b-59ab-4821-8079-4999236aec9d@foss.st.com>
In-Reply-To: <b483084b-59ab-4821-8079-4999236aec9d@foss.st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d35761f1-3412-473b-bd90-08d9f60443b3
x-ms-traffictypediagnostic: AM8PR04MB7281:EE_
x-microsoft-antispam-prvs: <AM8PR04MB7281F5F43978C84B35F8AFB5883B9@AM8PR04MB7281.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mwOiAPrtptLv9ZSCHuhniXyEYSESAA3lHBPaVgfGsZ0Wi39uom+iIimy1QPdS61NS/N2lrnT+sqa/y5SDnT/pSlWq/DxgRhmz5jg2TcUFeedyl2D206snncXmBGkLLuwcwEASle1v8al/iMyYovIJ0H5u7rMxYeDtbKp0ZNhop/9nHU2zAx12yjDTlgNFJG6oKElKGSdIJKhkKFg1o08kSinqpdxTz1rO7g/bfkYSgvpsEsohKLBlkMVs56qbX71Skkv+y7a3u1W9FAm+oLB5JR8JdVlzqrE38ONDN7/qKwfBSFqbnIpmvhUcvj92i8+cP1vzzu5mMG4NkyR71kchyx+hVgG3HFyCwRqoTGQFu3cYDwRGlrr51Gttzi7G93xkIBgbs2zjjeIbsd7/lzqabh+3hQ3CaP0O8BT79cfu70tG9jY2Zi+5XTo76iwm4iOwkQkgrPUC2tpACadCgB0smR15UF1qEstdnJqi7Lymeo0fkZo4MJoFcFXmrrUxiAyd+eAt5itO0fvzrMT7XLqjrp9/FdAa3enLwn+hTpCl5vQ8CBCmXCY6z4smFqbs3+amq72ctzDUxvfbLkNbeHHCky9HwoK36fqnvU8fy/wVGhGhZMJAeXnxBNn0vhlJ6HXd4oKFprjlKN/frkAc3RWwLfk6Jz/PLLmg8YRat0qEWUD7n+YSa8l/cugMNc9pZNmmM2TnSgvRQo8srN9ZCDVzbGJfTe/c0o6yUNo2mYoreEbeui5qtfCOVd8SfjaSnBGOcNG4ST+NiOIJ0l7MmRMjOCe4tiAbbUq2YbJmZWHZJLbeUnizm+YC8ZVU+Y9A6YlUaQuYb8acVmFeX0SRoE2HQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(6506007)(71200400001)(45080400002)(33656002)(38070700005)(966005)(508600001)(9686003)(53546011)(55016003)(2906002)(38100700002)(186003)(52536014)(66476007)(5660300002)(66446008)(8676002)(64756008)(110136005)(54906003)(66556008)(26005)(7416002)(316002)(122000001)(44832011)(83380400001)(8936002)(76116006)(30864003)(4326008)(66946007)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7hqRpi6DWQGYmbg9hi9sPeu3fUnRvGtF4KCjWvI+sMucjLvZVUmkHWm9Jj9H?=
 =?us-ascii?Q?LTrDDOO4yXWb6bqu8CdsIYnRD93Do0wGYoONgIaP4EP3CT3k3fVoEkl2WR9C?=
 =?us-ascii?Q?9SqlNuV7BFGQnIICYYu5W92593iTuPJ1Wt86oHSBLGl8J//AccukZ2Q5ptp4?=
 =?us-ascii?Q?aJIM822dC9gi7364I3HTjjune4GspuK2I8pDMvhRCeQdsO7Vg3by+wQ5G5M+?=
 =?us-ascii?Q?s3ydQMvjQ+dbOOjV6B5pio5xvWwjCfhNtc2mmRmwJ1heAd0uav47oJgmDsa6?=
 =?us-ascii?Q?2sVPbGe37+p1VE/XaAjBcn0o69wX7YrPPXOMeD5hnzJbfkkH7KINqqSkrDNs?=
 =?us-ascii?Q?tK2TW7xbIQa0xxd9FirNg1z/beUoTzMEGYPfMYqQJTyVXuq8mAS5lsrQCgzU?=
 =?us-ascii?Q?H1sMNB/zljEMW9Pz3g2KaiPB1TJRBoJ75kNWKeuOA6NxoeToU1wT2ZlYaMBu?=
 =?us-ascii?Q?Br3gukpx9jbmrk+IY9JduqrBmS3NchELGgPrHqvH5U6C4I4+rBmORgBm/Bo+?=
 =?us-ascii?Q?35zAU0cpk6VNa5GKx0+EAT0S3wqf+j9FYt5egdPS3NPXJpqDKgw1mFGkrOzt?=
 =?us-ascii?Q?osMa7zNiD8qKWUoEbn//LiWuHNQz1EFRlaih/s1aTGWA7SxQKLUJnLvnky9o?=
 =?us-ascii?Q?lf/CdqD/dGyP5vf/M4Wz7AK+OTbpmW5sH3U1GcJaKcMaBsOQ/J7eEvhe5snl?=
 =?us-ascii?Q?WHuZE4MfqP5vm2YTsLsjJ2oOgT2l6yJ6aujRTVkQFYnpOCZbKfzygjiy+Jia?=
 =?us-ascii?Q?R2lkEG0XB1OEoyp9xtbd0X6DpA7K9KMbKHpeIPAaJ7MZU4TPGezE3x5WcxVq?=
 =?us-ascii?Q?4om/8kIYo+UHRYr3TnOjpcNOOCzVHENrYMqHbCVeRGqYz2L6v8exe0d4YqXy?=
 =?us-ascii?Q?1FkGA9Qsen5DbvH9ss0iA/fKn0BnpEymB0KEHyT1IC/5tTaIQ0/5B6NWaHou?=
 =?us-ascii?Q?Gx57lNR1alRBxIet1rDcl0TuFGCuwJZZbtUF4S99UmqkZfUQuXqdulo4/OW7?=
 =?us-ascii?Q?UDNMwMbeGMTqwDpWOJ00ra+BCYqJLBayqvDvIhEqrC8f6uMpyNiwQfAS6xbW?=
 =?us-ascii?Q?wBaCLIMhh/I2yG/xNUNqG63DOe4pNvn/lM5WwziEBRUf84zKM9nkMKeEedP1?=
 =?us-ascii?Q?irXOjG6QRXK11ml4G0+s6cBKuMPhh00/SZlOBkSB6lFQyyUUSVx5W3LBxuBP?=
 =?us-ascii?Q?YVct+arMCuaaiLctVavpORZdVWJnWFxYoGJFQIxNBsIKbfBoyZkGep3X3YVi?=
 =?us-ascii?Q?CuIt3Q9bttVUiaWubGJLWTY6Hk/iXpDOpWH5VHdVW9WCKx4ByvZiW7p1a5A/?=
 =?us-ascii?Q?GlvZA9aWcwQmhPBxWA/E/1WNcdM5Zq+Lj0nQdWfuZKmQWYV89ysCE7PCbrgu?=
 =?us-ascii?Q?huKHSkRl3PYhhpObcdhNlXBBHNVMARB6E6y8wZ58+YZHBlqJfkKdITi0DXWd?=
 =?us-ascii?Q?4Z/a1BuZW3Y5DQMx7AwYFJWziW03h9xrayLad5khYsuW9XjZekNbSW+kvXFv?=
 =?us-ascii?Q?zSQvhDTexCBuGquK4pIF67HV9trDnSDzT4u4pGYa91f0g/V6ehH4T8xpkUo/?=
 =?us-ascii?Q?g3ZrL7ObjyU7oY5PCe8tBX+NtqgfOR+dZu4BTvMhUMBZ1Up9BEqyVAfJaINe?=
 =?us-ascii?Q?Fg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d35761f1-3412-473b-bd90-08d9f60443b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 13:07:22.4853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EDBldf/ZQ2tnEBrcYr9yk0vbAdSOmjFQLKUro5y+JYWCyGF3jzk/Nu7b858w9PcAdub/+PFM0hiAIJ2sakmg2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7281
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [RFC PATCH v3 0/4] remoteproc: restructure the remoteproc
> VirtIO device
>=20
>=20
>=20
> On 2/15/22 09:34, Peng Fan wrote:
> >> Subject: [RFC PATCH v3 0/4] remoteproc: restructure the remoteproc
> >> VirtIO device
> >>
> >> Update from V2 [1]:
> >> In order to better handle error cases and to have something more
> >> symmetrical between the functions in charge of rvdev
> >> initialization/deletion, the patchset has been reworked.
> >>  - Introduction in the first patch, of rproc_vdev_data structure
> >> which allows to better
> >>    decorrelate the rproc from the management of the rvdev structure.
> >> This structure is reused
> >>    in the last patch of the series for the creation of the remoteproc
> >> virtio platform device.
> >>  - In addition to the previous version, the management of the vring
> >> lifecycle has been fully
> >>    migrated to the remoteproc_virtio.c (rproc_parse_vring,
> >> rproc_alloc_vring,
> >> rproc_free_vring)
> >>
> >> [1]
> >> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flk=
m
> >>
> l.or%2F&amp;data=3D04%7C01%7Cpeng.fan%40nxp.com%7C31ba612e9d444a
> 845cbf0
> >>
> 8d9f073f744%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63780
> 5203140
> >>
> 739333%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2
> luMzIiLC
> >>
> JBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DMDamNuBkyFebgG
> BuP5shcU9
> >> aw%2FdMuM9GBTEEzffQQkA%3D&amp;reserved=3D0
> >>
> g%2Flkml%2F2021%2F12%2F22%2F111&amp;data=3D04%7C01%7Cpeng.fan%4
> >>
> 0nxp.com%7C9e663eefc30a4fbb1fdb08d9e0e855e2%7C686ea1d3bc2b4c6fa
> >>
> 92cd99c5c301635%7C0%7C0%7C637788110748757786%7CUnknown%7CT
> >>
> WFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLC
> >>
> JXVCI6Mn0%3D%7C3000&amp;sdata=3DbFfSxpPMpPRGYcMBcwxaQ152mRzf3c
> >> fwoFPjiJ0SIgw%3D&amp;reserved=3D0
> >>
> >> Patchset description:
> >>
> >> This series is a part of the work initiated a long time ago in the
> >> series
> >> "remoteproc: Decorelate virtio from core"[2]
> >>
> >> Objective of the work:
> >> - Update the remoteproc VirtIO device creation (use platform device)
> >> - Allow to declare remoteproc VirtIO device in DT
> >
> > This means not using resource table anymore with new approach?
> > If yes, would that introduce a problem that different M-core images
> > requires different dtb?
>=20
> The resource table still exists. The main difference is that the virtio d=
evices
> would be predefined in the DT with their own resources ( memories ,
> mailboxes,...) No need to inherit from the rproc device.
>=20
>=20
> On resource table parsing, the remoteproc looks first for pre registered
> rproc_virtio devices. If found then it uses it. Else it instantiates a ne=
w one
> (legacy method).
>=20
>=20
> >
> >>     - declare resources associated to a remote proc VirtIO
> >>     - declare a list of VirtIO supported by the platform.
> >> - Prepare the enhancement to more VirtIO devices (e.g I2C, audio,
> video, ...).
> >>   For instance be able to declare a I2C device in a virtio-i2C node.
> >
> > As my understanding virtio-i2c is a i2c bus, you could declare a i2c
> > device in the virtual bus without your patchset, would you please share
> more?
>=20
> Yes virtio-i2c is a bus, There is different methods to declare I2C device=
 on a
> bus[1].
>=20
> In ST we rely on DT to statically declare an I2C device,as child of the I=
2C
> adapter node.
> I haven't implemented the virtio-I2C part yet, but it would make sense to
> have such an implementation.

I misunderstood. Virtio-i2c bus with I2C device in DT is preferred.

>=20
> Which alternative have you in mind?

No. NXP use same method, we have a rpmsg i2c driver, rpmsg i2c bus node
and i2c device in DT.

Regards,
Peng.

>=20
> [1]
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.
> kernel.org%2Fdoc%2Fhtml%2Flatest%2Fi2c%2Finstantiating-devices.html&a
> mp;data=3D04%7C01%7Cpeng.fan%40nxp.com%7C31ba612e9d444a845cbf08d
> 9f073f744%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6378052
> 03140739333%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ
> QIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DC1S
> BPEtDhp7Y9XLB8wHgTLaQ%2BBE6T%2BD8eUr34SFRJYQ%3D&amp;reserved
> =3D0
>=20
> Thanks,
> Arnaud
>=20
> >
> > Thanks,
> > Peng.
> >
> >> - Keep the legacy working!
> >> - Try to improve the picture about concerns reported by Christoph
> >> Hellwing [3][4]
> >>
> >> [2]
> >> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flk=
m
> >>
> l.or%2F&amp;data=3D04%7C01%7Cpeng.fan%40nxp.com%7C31ba612e9d444a
> 845cbf0
> >>
> 8d9f073f744%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63780
> 5203140
> >>
> 739333%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2
> luMzIiLC
> >>
> JBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DMDamNuBkyFebgG
> BuP5shcU9
> >> aw%2FdMuM9GBTEEzffQQkA%3D&amp;reserved=3D0
> >>
> g%2Flkml%2F2020%2F4%2F16%2F1817&amp;data=3D04%7C01%7Cpeng.fan%4
> >>
> 0nxp.com%7C9e663eefc30a4fbb1fdb08d9e0e855e2%7C686ea1d3bc2b4c6fa
> >>
> 92cd99c5c301635%7C0%7C0%7C637788110748757786%7CUnknown%7CT
> >>
> WFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLC
> >>
> JXVCI6Mn0%3D%7C3000&amp;sdata=3DO2BZw5PCY19eD5xMGxrGUKC%2Fty1
> >> Sdc3LE6rhK4cSXvs%3D&amp;reserved=3D0
> >> [3]
> >> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flk=
m
> >>
> l.or%2F&amp;data=3D04%7C01%7Cpeng.fan%40nxp.com%7C31ba612e9d444a
> 845cbf0
> >>
> 8d9f073f744%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63780
> 5203140
> >>
> 739333%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2
> luMzIiLC
> >>
> JBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DMDamNuBkyFebgG
> BuP5shcU9
> >> aw%2FdMuM9GBTEEzffQQkA%3D&amp;reserved=3D0
> >>
> g%2Flkml%2F2021%2F6%2F23%2F607&amp;data=3D04%7C01%7Cpeng.fan%40
> >>
> nxp.com%7C9e663eefc30a4fbb1fdb08d9e0e855e2%7C686ea1d3bc2b4c6fa9
> >>
> 2cd99c5c301635%7C0%7C0%7C637788110748757786%7CUnknown%7CTW
> >>
> FpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX
> >>
> VCI6Mn0%3D%7C3000&amp;sdata=3DxqX50iDeL%2BtFBOgyADnEUE5HH4gogK
> >> C0MwyqZSxVqNo%3D&amp;reserved=3D0
> >> [4]
> >> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa=
t
> >> ch
> work.kernel.org%2Fproject%2Flinux-remoteproc%2Fpatch%2FAOKowLclCbO
> >>
> CKxyiJ71WeNyuAAj2q8EUtxrXbyky5E%40cp7-web-042.plabs.ch%2F&amp;da
> >>
> ta=3D04%7C01%7Cpeng.fan%40nxp.com%7C9e663eefc30a4fbb1fdb08d9e0e85
> >>
> 5e2%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637788110748
> >>
> 757786%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2
> >>
> luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DmvSm3wM
> >> LgQ%2BDFhqjXIkG8de58zFjwPSURzw55JhGNaA%3D&amp;reserved=3D0
> >>
> >> In term of device tree this would result in such hiearchy (stm32mp1
> >> example with 2 virtio RPMSG):
> >>
> >> 	m4_rproc: m4@10000000 {
> >> 		compatible =3D "st,stm32mp1-m4";
> >> 		reg =3D <0x10000000 0x40000>,
> >> 		      <0x30000000 0x40000>,
> >> 		      <0x38000000 0x10000>;
> >>         memory-region =3D <&retram>, <&mcuram>,<&mcuram2>;
> >>         mboxes =3D <&ipcc 2>, <&ipcc 3>;
> >>         mbox-names =3D "shutdown", "detach";
> >>         status =3D "okay";
> >>
> >>         #address-cells =3D <1>;
> >>         #size-cells =3D <0>;
> >>
> >>         vdev@0 {
> >> 		compatible =3D "rproc-virtio";
> >> 		reg =3D <0>;
> >> 		virtio,id =3D <7>;  /* RPMSG */
> >> 		memory-region =3D <&vdev0vring0>, <&vdev0vring1>,
> <&vdev0buffer>;
> >> 		mboxes =3D <&ipcc 0>, <&ipcc 1>;
> >> 		mbox-names =3D "vq0", "vq1";
> >> 		status =3D "okay";
> >>         };
> >>
> >>         vdev@1 {
> >> 		compatible =3D "rproc-virtio";
> >> 		reg =3D <1>;
> >> 		virtio,id =3D <7>;  /*RPMSG */
> >> 		memory-region =3D <&vdev1vring0>, <&vdev1vring1>,
> <&vdev1buffer>;
> >> 		mboxes =3D <&ipcc 4>, <&ipcc 5>;
> >> 		mbox-names =3D "vq0", "vq1";
> >> 		status =3D "okay";
> >>         };
> >> };
> >>
> >> I have divided the work in 4 steps to simplify the review, This
> >> series implements only the step 1:
> >> step 1:  redefine the remoteproc VirtIO device as a platform device
> >>   - migrate rvdev management in remoteproc virtio.c,
> >>   - create a remotproc virtio config ( can be disabled for platform
> >> that not use VirtIO IPC.
> >> step 2: add possibility to declare and prob a VirtIO sub node
> >>   - VirtIO bindings declaration,
> >>   - multi DT VirtIO devices support,
> >>   - introduction of a remote proc virtio bind device mechanism , =3D>
> >>
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu=
b.
> >>
> com%2Farnopo%2Flinux%2Fcommits%2Fstep2-virtio-in-DT&amp;data=3D04%7
> >>
> C01%7Cpeng.fan%40nxp.com%7C9e663eefc30a4fbb1fdb08d9e0e855e2%7C
> >>
> 686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637788110748757786
> >> %7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luM
> zIiL
> >>
> CJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DX%2B462681gcxe6
> >> 2GP%2BV7ji2nef%2FuTbQVvIlddcMQwtmg%3D&amp;reserved=3D0
> >> step 3: Add memory declaration in VirtIO subnode =3D>
> >>
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu=
b.
> >>
> com%2Farnopo%2Flinux%2Fcommits%2Fstep3-virtio-memories&amp;data=3D0
> >>
> 4%7C01%7Cpeng.fan%40nxp.com%7C9e663eefc30a4fbb1fdb08d9e0e855e2
> >> %7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637788110748
> 757
> >>
> 786%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luM
> >>
> zIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DeMlXgCgrV6l46
> >> h3Ywv1%2BCoX3gLBabdTZs9ybsm4t4ys%3D&amp;reserved=3D0
> >> step 4: Add mailbox declaration in VirtIO subnode =3D>
> >>
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu=
b.
> >>
> com%2Farnopo%2Flinux%2Fcommits%2Fstep4-virtio-mailboxes&amp;data=3D0
> >>
> 4%7C01%7Cpeng.fan%40nxp.com%7C9e663eefc30a4fbb1fdb08d9e0e855e2
> >> %7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637788110748
> 757
> >>
> 786%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luM
> >>
> zIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3D75hApOwihqMZ
> >> UUKz1VcitY2VPDc6KAIwAvH8enEZOPY%3D&amp;reserved=3D0
> >>
> >> Arnaud Pouliquen (4):
> >>   remoteproc: core: Introduce virtio device add/remove functions
> >>   remoteproc: core: Introduce rproc_register_rvdev function
> >>   remoteproc: Move rproc_vdev management to remoteproc_virtio.c
> >>   remoteproc: virtio: Create platform device for the
> >> remoteproc_virtio
> >>
> >>  drivers/remoteproc/remoteproc_core.c     | 159 +++----------------
> >>  drivers/remoteproc/remoteproc_internal.h |  33 +++-
> >>  drivers/remoteproc/remoteproc_virtio.c   | 193
> >> ++++++++++++++++++++---
> >>  include/linux/remoteproc.h               |   6 +-
> >>  4 files changed, 227 insertions(+), 164 deletions(-)
> >>
> >> --
> >> 2.25.1
> >
