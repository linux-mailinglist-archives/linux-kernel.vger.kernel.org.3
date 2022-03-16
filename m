Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CC84DB3AD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 15:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347295AbiCPOvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 10:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356881AbiCPOvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:51:03 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2062.outbound.protection.outlook.com [40.107.95.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967F83B574;
        Wed, 16 Mar 2022 07:49:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrhYjRZtV5lLFFe9IVvB2U3I63/KRa5GTZOWsTS6Ly2+4nIXAf5rz6O07QQz0ZRQkl3MZtdP3dBUCn4gkAoahumdGiBa6qnu6WCPiLZBwfJ+4AZuAAs6AlwZ2KYcMWrWibQKeXfFcDwFbEDxNJN4jlYcO8XQZZlUT8TFCWla3TyKcB9u+ySeXgqYilsQj/knVDnvdBbs402NMkPU52qM03/awu9kz2Na8MA9jpwJcHAsYxyU6iCjm1QTtqBvvJRG1OUwjWujmjtkbbOfBy+GTUCXdXcf7fb+jFtI/xqsx62NxgIWjooCmILa8fEzjCjKhh94YK+qK+9oIFn/4eWphg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkhOpsDClOyQyTqCx3wpvZQj2kPrB2HQ7fcDHzeWrYM=;
 b=JtsrKPkgl8sTxpmalIhQWPCYA6Ixx7vV+MUwMvhdu25MwYIOd3xyEwbd4EP/iK+LvvPOdFDylatBTt0nEl0jiEHJWTbRlzPW4luDYPvEboJ40x/WkkksZ8S03Rpb9SFPZxS/gc0P0KDuaXQZBnzWvii3cCDJaBDzB2aDZyCzA0PbembxSl+s960qM0SNYl/pbh4sEcgV4PueVLal8wPa8QDRdlhuy7kIQKlDYKovhSYM04FxNDKQVjE4t9i8oK6jZSw5Nso4FDf3uXqh3WDuUSnIl3Iaunr3eyGd0zka8wQXPEoP+mKw2KyVOzvbwhHrE+Ot9YxDWl6BD2lHv4S5iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkhOpsDClOyQyTqCx3wpvZQj2kPrB2HQ7fcDHzeWrYM=;
 b=gGJKpq9Qcnq1Ca/87mQ1M7SxuyfILEKaWAXw2uz6EaFy6dLMY+l5SrqJEwxLWOBr3JjoSXJvKPcStiN3MKe1jcncAHBqY0CP+MV3BHdnuPWqpXPkCK0zSjAbYPpXEIsQ5a/s0c2MTwxOgSJ+ldDi2gqmOeLeLbL/eliJoB9BOW0=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by DM6PR12MB4926.namprd12.prod.outlook.com (2603:10b6:5:1bb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 14:49:45 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 14:49:45 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>
CC:     "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
        "michael.jamet@intel.com" <michael.jamet@intel.com>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "hch@lst.de" <hch@lst.de>
Subject: RE: [PATCH] thunderbolt: Stop using iommu_present()
Thread-Topic: [PATCH] thunderbolt: Stop using iommu_present()
Thread-Index: AQHYOSidJZwMFUwbGEibeELZIyT74azB9QiAgAAcdKA=
Date:   Wed, 16 Mar 2022 14:49:45 +0000
Message-ID: <BL1PR12MB515799C0BE396377DBBEF055E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <b4356b228db9cb88d12db6559e28714ce26e022e.1647429348.git.robin.murphy@arm.com>
 <YjHb1xCx4UAmUjrR@lahna>
In-Reply-To: <YjHb1xCx4UAmUjrR@lahna>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-16T14:27:08Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=6f364d29-d35c-4aa5-94fd-8b1414711f0d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-16T14:49:44Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: abca931e-ec87-4507-bc30-2b107d28ea0f
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58302072-b144-4bd9-8553-08da075c366d
x-ms-traffictypediagnostic: DM6PR12MB4926:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4926CF9571BAAC1CF9805E46E2119@DM6PR12MB4926.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jjHmWZTeeCDX83/rkN+U6D7JxobXhYfkwtZLWD07mLQDh0Am85sT9hGA+xhVLntJ+QIFdxuWzzh3h43CReP+xjRJ/YabnLnCm7USVkpCR9rtI8sIfdUO/LfpMVwBTUfw90oT07L9zXjYDUi7YzMewNjwFcragkDTuU3kltH8IJVTeD1FqX8UipNK2+cirlFgtAc8QcjcESO9lqkkNCaQWXgUePlHO+wu6iCDBf2PHPduNyG5FnHn1w5QLW2w0+j+s2+uBf0V6zU+3frZmzQYKJvGXLy+KazynbgodBHcKHYhIuY1myNRc9hvtUiBvA4Mpx7HKxgU4kGCGj/fr/TMU67X7JYdlNPMcG8qpKbicgL+4Udi4KV/Z3gQc6R0MMkH0W/CM4v9Aqd+4DOjnnKp6H81yxpEQZpxZqX7MX4ye5BDJmmVoV98G6ODWgacht3o+s516PtFOAY6+Yeg+ZIz+/UstJSCXl56G1S95J6RGntf6jSYdQ66ZqgsITbGTysxAUm86bxLIvGXEVfCEQZuvIExl1daU4PqmS0KddF1alvufg37Lyv07pV5ooDfgdgu8t3KoEda+kIhwknODGMud+fUBLjRblirn5U2ygMFHwudSGsL6VvF+Z858fLAYo/UPeWuRO2ZP9g/WF3OKZzBqXCyVPpWQ0gtN3uwtdtEHqsuPhicPBANJEVvfYVed1nt/cB4eL0Lh7s3sQ4eKYMHJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(9686003)(7696005)(6506007)(71200400001)(508600001)(33656002)(38100700002)(5660300002)(2906002)(122000001)(316002)(38070700005)(110136005)(86362001)(54906003)(52536014)(8936002)(64756008)(66556008)(66476007)(66446008)(55016003)(4326008)(66946007)(8676002)(76116006)(83380400001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZnXQN99fdwfKntvZYtO0m9EEecIdi/RLnf0Hfg1PSGkUJX20xMhhKrWHojiL?=
 =?us-ascii?Q?rh8z3AyPRtqBBUi9XhhJyye1PRon+bLKB21pbbdnRUNFsryh0VdMmW4KdCzm?=
 =?us-ascii?Q?8RuBCkkF6IZrv+o7PMhnF82fgi2czkond87+6gnsWP4HD8bTKhKVMDnBN4Bx?=
 =?us-ascii?Q?3uRqvaAILuEoZtTWBPhWQlX7QkBhNX9KTGgfVenxeyvNYO6mQ+edUCL6lr5q?=
 =?us-ascii?Q?eE/ynhJFs3JXFLLvuvKL6OIY80HmzZ1ze5Co0UsNHFWFv7zvXoBsLHeYDNHt?=
 =?us-ascii?Q?TOOwnpLjV0p7F8PE91+z/Xk5Rocje4uUCi7QfinFP0ZIcEXdAf8dn5K3i25X?=
 =?us-ascii?Q?fSItPHm5sahf8x3wWRxjUNlAdj0+N16u5YvhQ94gKiTTu382/dmu9vrI84dR?=
 =?us-ascii?Q?ll2CcYiUZWv1Fv5F8lc7H0EosjW++x1+r/jrMb33WMmAqW0rxggDFvqGqxNL?=
 =?us-ascii?Q?7o3/hlHBr3N3vwWqJnkg+dmlK1ozAHHV4zta0mVnffB3J0DiFtnBVjEX0+KW?=
 =?us-ascii?Q?gOAZPHpE9G8+hVyEB+q98AL01wPfPKqtoThePLHJVBALz5IQQgw3ubYWrab4?=
 =?us-ascii?Q?hDqXi+A87S5QYlhRvNDim0OERMPxobyCpbN5ugxKxeARCH7dzU9fYWcMU+Kh?=
 =?us-ascii?Q?H9Mdh2Bmo6PJTfXJk+7gV4FfQv1AjqrCNsoXtC+wOqyWP7V02fFR05ZzVkl8?=
 =?us-ascii?Q?AtHWA0kBmJAgdOX1JiFPiRcIo/fV+cV8q/P26t+PPrYvRDaLkML+G4bHu4Ap?=
 =?us-ascii?Q?uQUp+NFkwfiUlXX/v2Bkrr3uf2a9ViG9XvBxNhNQQmjUp+2uC1xJC+NL9pGy?=
 =?us-ascii?Q?dCVybhmgIBHMa3soXYt4VUIF7uEV6YQzGOHzDbxUIwdd0oKPpw9C6lxTtEb0?=
 =?us-ascii?Q?eUDOVjWbgrye5rq3Njl4Uta3p8gyiGtT97w7ikfErjZ+IyKzV4biTH9u32NM?=
 =?us-ascii?Q?0na8flPCEJ73meXtmOXBqnGJwoRLH1ND/2riI8tBCDIWCPHruKAhuw1nx4lU?=
 =?us-ascii?Q?Yt+14t1BoejayyOF2zRL+OvslTuB4loVGiwjxaxA684RLj/di7xR77QEsRoq?=
 =?us-ascii?Q?FbJ4ZcaDwEqKIq4oN/EJGhsiFg6q7550uDy4M/upxsrF5em/qkZrvBmuuY9r?=
 =?us-ascii?Q?LKNVKNaSpsSC/PcGMFGDdp71kEp/8sfy68apDKcOHRzMaROR1ie35Ln9ABK2?=
 =?us-ascii?Q?wpkRUT8RwLlw+W3dd5HoPrBh8BdEUmwJGqquSoKXQ7pvj+kTpdV61pnSL2V6?=
 =?us-ascii?Q?MpFvi6tZR7h6jwK8NvY22R5I4AqWBZ43KyBBAIskq8ynUwx4pQkZc08pLaSz?=
 =?us-ascii?Q?Lv6F9w8LNIaIbWj7grhJ9QOTgugObcofzPWxwf9kjO06ulEbsHCYwTtajL3f?=
 =?us-ascii?Q?+iU0je2Jrmgd6PRGHvU3TRIp6GxTR9cWbNm7DzOdb0Wb92J0pUgk6X+CV2zn?=
 =?us-ascii?Q?kl9jkI4VR64izwGcGAx4GWmtWsjqdPMHFcCTL0haC26ocYWiwi4l4SNTblE2?=
 =?us-ascii?Q?DNyKJ9ih3OePIr3E619lEfoWoZfhGnpy7TnE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58302072-b144-4bd9-8553-08da075c366d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 14:49:45.6617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KRW5ZdzuORSYHoTxGGtVfR69/TJO+L3s5Ub2Qu8yyqgAhNnCWpYjQGXpngMuq10+7VqLDykSYCFQwM2In2DnrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4926
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



> -----Original Message-----
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
> Sent: Wednesday, March 16, 2022 07:45
> To: Robin Murphy <robin.murphy@arm.com>
> Cc: andreas.noever@gmail.com; michael.jamet@intel.com;
> YehezkelShB@gmail.com; linux-usb@vger.kernel.org; linux-
> kernel@vger.kernel.org; iommu@lists.linux-foundation.org; Limonciello,
> Mario <Mario.Limonciello@amd.com>; hch@lst.de
> Subject: Re: [PATCH] thunderbolt: Stop using iommu_present()
>=20
> Hi Robin,
>=20
> On Wed, Mar 16, 2022 at 11:25:51AM +0000, Robin Murphy wrote:
> > Even if an IOMMU might be present for some PCI segment in the system,
> > that doesn't necessarily mean it provides translation for the device
> > we care about. Furthermore, the presence or not of one firmware flag
> > doesn't imply anything about the IOMMU driver's behaviour, which may
> > still depend on other firmware properties and kernel options too. What
> > actually matters is whether an IOMMU is enforcing protection for our
> > device - regardless of whether that stemmed from firmware policy, kerne=
l
> > config, or user control - at the point we need to decide whether to
> > authorise it. We can ascertain that generically by simply looking at
> > whether we're currently attached to a translation domain or not.
> >

Suggest you include a link to the discussion(s) that spurred this too in co=
mmit message.

> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > ---
> >
> > I don't have the means to test this, but I'm at least 80% confident
> > in my unpicking of the structures to retrieve the correct device...

I did check that as a result of this:
* Turning IOMMU to pass through leads to iommu_dma_protection of 0
* Leaving IOMMU enabled leads to iommu_dma_protection of 1

I suspect you'll respin this on the below comment, but if you do keep it:
Tested-by: Mario Limonciello <mario.limonciello@amd.com>

> >
> >  drivers/thunderbolt/domain.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.=
c
> > index 7018d959f775..5f5fc5f6a09b 100644
> > --- a/drivers/thunderbolt/domain.c
> > +++ b/drivers/thunderbolt/domain.c
> > @@ -257,13 +257,14 @@ static ssize_t
> iommu_dma_protection_show(struct device *dev,
> >  					 struct device_attribute *attr,
> >  					 char *buf)
> >  {
> > +	struct tb *tb =3D container_of(dev, struct tb, dev);
> > +	struct iommu_domain *iod =3D iommu_get_domain_for_dev(&tb-
> >nhi->pdev->dev);
>=20
> I wonder if this is the correct "domain"? I mean it's typically no the
> Thunderbolt controller (here tb->nhi->pdev->dev) that needs the
> protection (although in discrete controllers it does get it too) but
> it's the tunneled PCIe topology that we need to check here.
>=20
> For instance in Intel with intergrated Thunderbolt we have topology like
> this:
>=20
>   Host bridge
>       |
>       +--- Tunneled PCIe root port #1
>       +--- Tunneled PCIe root port #2
>       +--- Thunderbolt host controller (the NHI above)
>       +--- xHCI
>=20
> and In case of discrete controllers it looks like this:
>=20
>   Host bridge
>       |
>       +--- PCIe root port #x
>                 |
>                 |
>            PCIe switch upstream port
>                 |
> 	        +--- Tunneled PCIe switch downstream port #1
> 	        +--- Tunneled PCIe switch downstream port #2
>         	+--- Thunderbolt host controller (the NHI above)
>         	+--- xHCI
>=20
> What we want is to make sure the Tunneled PCIe ports get the full IOMMU
> protection. In case of the discrete above it is also fine if all the
> devices behind the PCIe root port get the full IOMMU protection. Note in
> the integrated all the devices are "siblings".

I think below is what you are looking for (on top of your patch).  This che=
cks the NHI, and then also checks all those siblings Mika referred to.

diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index 5f5fc5f6a09b..b17961ba1396 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -259,12 +259,25 @@ static ssize_t iommu_dma_protection_show(struct devic=
e *dev,
 {
        struct tb *tb =3D container_of(dev, struct tb, dev);
        struct iommu_domain *iod =3D iommu_get_domain_for_dev(&tb->nhi->pde=
v->dev);
+       struct device_link *link;
+       bool protected;
+
        /*
         * Kernel DMA protection is a feature where Thunderbolt security is
         * handled natively using IOMMU. It is enabled when IOMMU is
         * enabled and actively enforcing translation.
         */
-       return sprintf(buf, "%d\n", iod && iod->type !=3D IOMMU_DOMAIN_IDEN=
TITY);
+       protected =3D iod && iod->type !=3D IOMMU_DOMAIN_IDENTITY;
+       if (protected) {
+               list_for_each_entry(link, &tb->nhi->pdev->dev.links.consume=
rs, s_node) {
+                       if (protected && pci_pcie_type(to_pci_dev(link->con=
sumer)) =3D=3D PCI_EXP_TYPE_ROOT_PORT) {
+                               iod =3D iommu_get_domain_for_dev(link->cons=
umer);
+                               if (!iod || iod->type =3D=3D IOMMU_DOMAIN_I=
DENTITY)
+                                       protected =3D false;
+                       }
+               }
+       }
+       return sprintf(buf, "%d\n", protected);
 }
 static DEVICE_ATTR_RO(iommu_dma_protection);
