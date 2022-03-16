Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593D74DB7A0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 18:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349264AbiCPRzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 13:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240365AbiCPRy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 13:54:59 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9ED29C9D;
        Wed, 16 Mar 2022 10:53:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxmlhsPJEq3Hmq7ev58EMo8lm0Xj4tdJRlfAcretAnWdFP704srmGmq5Op2d8quPGM6aG2sGCiO4dPDuiusiaAKe+YxGRfZV13owRsCRQN/cF1LJ7KZdRAISf5BFiiWrIjjXy8c9Bjc1mdzQUz7Gaz4AiaKiLrxDkQmxErhRHjZKBK2sgDo9S3YVs/bjO2O77rqhTJM4OqGS4P5ZYqDvvmfD7I+BGlvScHIMRt1dKRMKo9aDjwo+4lF64kZjQwlJLCRf4TXWz/J/C6dxzvPLZl8dgePHQVBh79ugrpW0JdsG2330MRYq4O5x/6LhnVPY3Gv0q73v1UCx7IvklZ7UWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54k10UHs89HwQ9lyDnhHdOdzNhcCfQP6O8Lm5bzgL7o=;
 b=aFw1FF9xEI3A+PKZa/3ikhQZWLEr6RTh9d70HAXSZmRNge3Kz8w2IaDdxU6SlPanQ20KZ6Zv/gYGLf7+52h4Qic1pj/6vJJAmubdEXDml8/uHE/RcUJ1BNzvwxrC+O9Oo6X1AYC70xUZVUN7q80Ob3WjxYXkHEhmbjw3UKwZ+f/x50+PWJ7BfAzv0KWz4IAl7fZjGL9jX0yg8EsMMtqRDSdT4OFyeujWcJwmWpiOdLQ7KIDOGzNrcOvnJSzKY28qBkRyuHMMmLt4FRW5UaIAx2Wi+9AyeR71z3sTOVFhZsdsAB6RQjdUVMWk+KsoybynAlINvEQxltIEoerMR4Ubyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54k10UHs89HwQ9lyDnhHdOdzNhcCfQP6O8Lm5bzgL7o=;
 b=EC9eqzMG4II2Yd+vXQ2zVdc3yJN1Fg4Bdi9E+StjPHAwa6daZuPJqYiy3zRiHNAfwpjIteKlLqYCxmwpjJeea7/hZhzafHP3+f++/XIIZjzKobZtM1Fpl3LnSCT5U8kAXKSeS+KrJqx1hQI48b4IQIkjKZutF8IuSxFRG32hYUs=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by DM6PR12MB4942.namprd12.prod.outlook.com (2603:10b6:5:1be::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 17:53:42 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 17:53:42 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     "michael.jamet@intel.com" <michael.jamet@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
        "hch@lst.de" <hch@lst.de>
Subject: RE: [PATCH] thunderbolt: Stop using iommu_present()
Thread-Topic: [PATCH] thunderbolt: Stop using iommu_present()
Thread-Index: AQHYOSidJZwMFUwbGEibeELZIyT74azB9QiAgAAiooCAACnRgIAAAPcAgAAEJICAAANtgIAAAECw
Date:   Wed, 16 Mar 2022 17:53:42 +0000
Message-ID: <BL1PR12MB5157DA58C3BDAFB5736676F6E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <b4356b228db9cb88d12db6559e28714ce26e022e.1647429348.git.robin.murphy@arm.com>
 <YjHb1xCx4UAmUjrR@lahna> <16852eb2-98bb-6337-741f-8c2f06418b08@arm.com>
 <YjIb+XOGZbWKpQDa@lahna>
 <BL1PR12MB515762E68F3A48A97EB2DC89E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <YjIgQfmcw6fydkXd@lahna> <3bb6a2f8-005b-587a-7d7a-7a9a5391ec05@arm.com>
In-Reply-To: <3bb6a2f8-005b-587a-7d7a-7a9a5391ec05@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-16T17:53:39Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=a32c2a09-b0c2-4794-916a-a4afd648a123;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-16T17:53:40Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 82aebe48-d2e8-4d27-9474-70f6cad9933f
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c19e976-74e4-4f31-2f36-08da0775e8c8
x-ms-traffictypediagnostic: DM6PR12MB4942:EE_
x-microsoft-antispam-prvs: <DM6PR12MB49422DA337BB3BEE9A0E0D3BE2119@DM6PR12MB4942.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nSmVNX1lM4CgrQQxy3yiF8e5s9ONe1vhHMKj1rRzPa0EojHXMMETiTUNq4kR7GOmF6m2GbSjt8fFScYdsQWCNqv33E6a5GUGOFsBRsCpQd0vN+AF9JQrl8FFkitW2XVgHyp7YzVJ+pYgPLj83WUoNEIzxzZVkd5NVQhKcZWk8PN0ZpMbfE/uQwDQVqqUiLHHqtMnkJtKhNpFHSiAipavxNPupY3CBW6Iy1/OUJWw3okrvjTxW6+J28ckCMoYhRFjwwk6rCjGDO48hfWuLnjxnkexoarYy5PtOztFoG5eX38B271uw7c+FenOCRkXAXgdaOdnaHCdH1fqDfSqMbgQTcRgYdRl+d/M5nTwEAfogLHsk3M3sqAR7Oxe7Ix24PhepDmN4bZXIjfsxw0Sb+TI/al1dmf7CiHButUCNrxGvbTH0m27c0EkyA2DtyomE+GWVS2GUObacZYRo4xdwQRgjgMqCYrdkgQ/l7chvCMUX9mGHGoRtPDd6N9pCtunW1LBEzOkFVC0IonO2tFUN5iUTO6B87Y8F0YY0wzOZnEoeV487EopxXw8wX5iD8rh6Oo62OFXvrOOQSGrFHR/NWiXR0DTbE97WvcTnqQi6YugOZhc328HroULZvRous2rmE1GQAWuU2aiB2U4GTq3C/tnA1Jk8zXvxfdBDUVBksIZaQNj7jLcprkCPoV9qmhxQ03GOhV4yQJFiG98LjmHxC/kIty7FAYHBZD7B0dbCybBlD3YoEGdZNlDuBpDnNGrX1JZDh/cl/OhoZP5GQK15rmZVE9MiPU4Lb02dYi4e20D/ag=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(64756008)(76116006)(66446008)(66556008)(66946007)(66476007)(508600001)(8676002)(5660300002)(86362001)(4326008)(38070700005)(71200400001)(7696005)(45080400002)(54906003)(966005)(110136005)(6506007)(316002)(9686003)(52536014)(8936002)(83380400001)(186003)(2906002)(38100700002)(122000001)(33656002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XBdNkfy2Zep+5tuFqp/Jy6PDfGoLPI7AwsLjXPWAgWdjP4nAOXYTfVexJb2E?=
 =?us-ascii?Q?zFBNJTK56aP8uxCF/VJsyImjpgO+V6coDrmRAjrzJx+YjHZu+qByGu0qrvWg?=
 =?us-ascii?Q?TvBJjQ9e+wXl1ba+92Z313Z/JQE8m3/xmycaXU1lF/tB/6iLpkdoY9RgkHng?=
 =?us-ascii?Q?MC61q01WDFPNrpkOY5OgCVBAHkYKXIjjipXVveEQUr48VLmStmhh1H4a5lEB?=
 =?us-ascii?Q?YQF/xqnMtTJmXTxCIqlJgAgnqmc6uLC+7NWx5K5/SJrnXzTpdWk23+2N/NeV?=
 =?us-ascii?Q?+U0db1gGCEpHYAEWbe0sHD1VgAPTg1obwL8Bl4aWPk0mimMDGGzF/v3yja9Z?=
 =?us-ascii?Q?jbTPMXXYNSyEe+KWT+qkCgsWzFcw3KQVV6ZsijsW26Ts7IyNevztu95c71xk?=
 =?us-ascii?Q?ju5yuH6NRxdzaM8RhpoILCoI2Vj5ENlCB4HeWtonkj6QleNLMNDLsIRfK5xN?=
 =?us-ascii?Q?LJI2oth2XJEnX1ggQoLtjPnidq4cEK3TQH2jHeE4c/bwACKCRLElnS6Vi6Uy?=
 =?us-ascii?Q?GIC5//ztXe8jfKMaCHU3CsWmAXkOrCasSy3DSqGajrRJrL69CqatU+Rj6KPt?=
 =?us-ascii?Q?74hf0C6+ZCyx/u9JaVQEJeDUUl/P0Tn9cnbDsvya7REudpkFvCuWosgG9cuY?=
 =?us-ascii?Q?P4npc2J11IIa8mXHwjIkDJGk7xycpFdDsbUBOBmUSP0WAUF4qDlrpdec+5N+?=
 =?us-ascii?Q?xoBJzxHRqHWWsl5WMwTd2JvD1UD9KA5j3vW42xbLVO78c1nVF85E3KRxLXfq?=
 =?us-ascii?Q?YF0fIg/y1tAwV5TwOR/OaWL+9/dfgv5RIkcEu9fUmS9qbivDjfZQY8MtjoNh?=
 =?us-ascii?Q?ByjLGICBmEmYYzdW8EfZYgWBA71xfFzwB9Kqatqv3gRo/88/eyo1XRORhA2i?=
 =?us-ascii?Q?Cl9jTJVLyGuZYh0KwpLquFCHK5H4LiuEAuSGBaC2Y9s5jzmmIPqUSykGhQ6F?=
 =?us-ascii?Q?x9GCB/KmtJNJGknJbGHcvpjISMUZRmmsaZp+VhziYVNEMjxixbvvD4/cnDHS?=
 =?us-ascii?Q?1eEPwUAjNtbQ7wW8DZ25CfdMdrLAK1bvTIEgPG9HLpMnQOTXNSaP/j68uhjs?=
 =?us-ascii?Q?Y7o4Rd+g9bfLp5Mb/rKrheGlKv+PimqGVMNCSZ08eEBpIcttRXfl0kziXxsu?=
 =?us-ascii?Q?B7sg348xOza5339VutqNYSWsMLtx0zqtcozaL8S3GabJ8ZsKnR+93cW8Us5l?=
 =?us-ascii?Q?+JfEU6nmCnI/tCF3dDZk7QASh6fYUq920AsMVAWdP/Lz9qtofH1sLxw7Wovl?=
 =?us-ascii?Q?aFyzzQfvXPfs1IVFmt7zAz/VSoTM2r+yQyR+q0NIGGVCJ9LrVQZqt6EsY/sy?=
 =?us-ascii?Q?eVj1YMUkT6yy8OynISQJqzispK1Hl5Bd9C8E2bP35utJ1+zmDOwgWdftAHPg?=
 =?us-ascii?Q?N0yIM05y3Pa214xb4+M35tWfo9A9vpchCCaSiwhflGq6MX86Zzj9qlA/MibI?=
 =?us-ascii?Q?kGmuk1VwZ4ZUfGNUmDitYpPb1iyRTEFMO0XRoT825IF2FGHkcLat3/D987mb?=
 =?us-ascii?Q?8g/J98iSlRM/G0foccixN2qc/dhcuTn9dixF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c19e976-74e4-4f31-2f36-08da0775e8c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 17:53:42.3254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: keKHj1uALfB/TYYbj7/smWp9Wsxezvb+Zs1ACMuep4SWL9xXli6KN4/0sJTtDSXsZjP1xKxpQwwb1/ULT5brfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4942
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]

> >>>
> >>> There is a way to figure out the "tunneled" PCIe ports by looking at
> >>> certain properties and we do that already actually. The BIOS has the
> >>> following under these ports:
> >>>
> >>>
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fdocs
> >>> .microsoft.com%2Fen-us%2Fwindows-
> hardware%2Fdrivers%2Fpci%2Fdsd-
> >>> for-pcie-root-ports%23identifying-externally-exposed-pcie-root-
> >>>
> ports&amp;data=3D04%7C01%7Cmario.limonciello%40amd.com%7C0465d319a
> >>>
> 6684335d9c208da07710e7c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7
> >>>
> C0%7C637830479402895833%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w
> >>>
> LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&am
> >>>
> p;sdata=3Dz6hpYGpj%2B%2BVvz9d6MXiO4N66PUm4zwhOdI%2Br6l3PjhQ%3D
> >>> &amp;reserved=3D0
> >>>
> >>> and the ports will have dev->external_facing set to 1. Perhaps lookin=
g
> >>> at that field helps here?
> >>
> >> External facing isn't a guarantee from the firmware though.  It's
> something we
> >> all expect in practice, but I think it's better to look at the ones th=
at are
> from
> >> the _DSD usb4-host-interface to be safer.
> >
> > Right but then we have the discrete ones with the DVSEC that exposes th=
e
> > tunneled ports :(
> >

Can the USB4 CM make the device links in the DVSEC case perhaps too?  I wou=
ld
think we want that anyway to control device suspend ordering.

If I had something discrete to try I'd dust off the DVSEC patch I wrote bef=
ore to
try it, but alas all I have is integrated stuff on my hand.

> >> Mika, you might not have seen it yet, but I sent a follow up diff in t=
his
> thread
> >> to Robin's patch.  If that looks good Robin can submit a v2 (or I'm ha=
ppy to
> do
> >> so as well as I confirmed it helps my original intent too).
> >
> > I saw it now and I'm thinking are we making this unnecessary complex? I
> > mean Microsoft solely depends on the DMAR platform opt-in flag:
> >
> >
>=20

I think Microsoft doesn't allow you to turn off the IOMMU though or put it =
in
passthrough through on the kernel command line.

> > We also do turn on full IOMMU mappings in that case for devices that ar=
e
> > marked as external facing by the same firmware that provided the DMAR
> > bit. If the user decides to disable IOMMU from command line for instanc=
e
> > then we expect she knows what she is doing.
>=20
> Yeah, if external_facing is set correctly then we can safely expect the
> the IOMMU layer to do the right thing, so in that case it probably is OK
> to infer that if an IOMMU is present for the NHI then it'll be managing
> that whole bus hierarchy. What I'm really thinking about here is whether
> we can defend against a case when external_facing *isn't* set, so we
> treat the tunnelled ports as normal PCI buses, assume it's OK since
> we've got an IOMMU and everything else is getting translation domains by
> default, but then a Thunderbolt device shows up masquerading the VID:DID
> of something that gets a passthrough quirk, and thus tricks its way
> through the perceived protection.
>=20
> Robin.

Unless it happened after 5.17-rc8 looking at the code I think that's Intel
specific behavior though at the moment (has_external_pci).  I don't see it
in a generic layer.

In addition to the point Robin said about firmware not setting external fac=
ing
if the IOMMU was disabled on command line then iommu_dma_protection
would be showing the wrong values meaning userspace may choose to
authorize the device automatically in a potentially unsafe scenario.

Even if the user "knew what they were doing", I would expect that we still
do our best to protect them from themselves and not advertise something
that will cause automatic authorization.
