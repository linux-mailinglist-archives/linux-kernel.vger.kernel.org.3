Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B964DE402
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 23:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241296AbiCRWbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 18:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiCRWbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 18:31:21 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1618C1FF23C;
        Fri, 18 Mar 2022 15:30:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QlG/iy3WFbIgzCK/j149acMfN4WJ+Ol8b4XYXkDxULjaNhTwLDTMtnrTjP3TwKfESRDqY4RyMI4J0HClBv4petncy2Sw10LA/27NacJt/FPAOARH7PM6whlRr6hGeGO7EWUW7+ffttF88HCjXmQ1McfEWKSigOBEikGTchmZoFAuDw265b6HUOEG/64f2dTMbo1WtptmNGGkMvObFDWjg0CkmerRWhA/1ywUgyuzK16DVaiGXlN/z7Hl/eU6+eKjilF35blvl5eN7vHsZ1mQMtNz+rPI3B5FFBQkoNWMmEdYR4bAtb/4PI/fYiyYc3mE+fR8vWWPlngDe38sPAFLzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCNK0SsDMfKE92K0kNO3Lnq/dcXd6fjZvSMeRr5iEIU=;
 b=I5uY0weaWfz79tSakSpAKbpKh9zGL3DXxofBXSHKELt+pms7eStc8sfw9fcD2kC0dEPfHywwVxPSCcupRva1LjtAoiGoQo4k7y7U0zg2bSlRNTZLpGZFBUQMjczlcvwMgflOhvjAMiEPb/BqM+MiZq3LEsfAs+2fMz6RM756rc82KeDVb5ZUI4ITxkcHbLli16uQVkUuYMcxlhJyPBaBbup+m+ejPPqLQxEWaYczgeV9wInyyoAccjyMot6giEKz+C2eXRQrfsR+VOsmwXfVPIPD24RZsd4sVkFAV2Y7vrO1LUsm0Ay3/d3oa4kPSTO/Luo4xb8IhFq6qPOrEAtkPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCNK0SsDMfKE92K0kNO3Lnq/dcXd6fjZvSMeRr5iEIU=;
 b=jfM90mUvX+bfFRylFWyzP9cmTXeT+ptFEOG3Cvkt3OUWREj1b5MDP1c4exeFo1+2kz/9YLzGfGfNvobR7CaNt6apUb864VsQC8u+Llm50TBw2+TeQ5EHFVOwaE1C6Is7hvZ3LCTGHiAsIoTRprPivUdtPdiYa7bWG5KgDKzAHHs=
Received: from DM4PR12MB5168.namprd12.prod.outlook.com (2603:10b6:5:397::8) by
 CH2PR12MB4120.namprd12.prod.outlook.com (2603:10b6:610:7b::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.15; Fri, 18 Mar 2022 22:29:59 +0000
Received: from DM4PR12MB5168.namprd12.prod.outlook.com
 ([fe80::3429:e62f:659d:2049]) by DM4PR12MB5168.namprd12.prod.outlook.com
 ([fe80::3429:e62f:659d:2049%2]) with mapi id 15.20.5081.019; Fri, 18 Mar 2022
 22:29:59 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
        "michael.jamet@intel.com" <michael.jamet@intel.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>
Subject: RE: [PATCH v2 2/2] thunderbolt: Make iommu_dma_protection more
 accurate
Thread-Topic: [PATCH v2 2/2] thunderbolt: Make iommu_dma_protection more
 accurate
Thread-Index: AQHYOu+lUdyxWySMNUuJeS+suvjzA6zFr+rw
Date:   Fri, 18 Mar 2022 22:29:59 +0000
Message-ID: <DM4PR12MB51683722CF9A553563D0C721E2139@DM4PR12MB5168.namprd12.prod.outlook.com>
References: <cover.1647624084.git.robin.murphy@arm.com>
 <0dd14883930c9f55ace22162e23765a37d91a057.1647624084.git.robin.murphy@arm.com>
In-Reply-To: <0dd14883930c9f55ace22162e23765a37d91a057.1647624084.git.robin.murphy@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-18T21:55:37Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=6c14bde3-e375-4a06-a5f0-44786e0e29fd;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-18T22:29:57Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 60cc1a25-5819-484e-b6da-54701a36bb04
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f879f581-2d21-4c1c-7cfe-08da092ed64e
x-ms-traffictypediagnostic: CH2PR12MB4120:EE_
x-microsoft-antispam-prvs: <CH2PR12MB4120B6AC651A50E1EB640944E2139@CH2PR12MB4120.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lq4hfzW+8oLG0y9D/3ohohJbyoXIOKCW8uZntrR11RA1O/CuaU3T+g96jLKCRp89Gs7niBGSshO0xa431t0aUC/+ZzP0EpIqnxfNgCIS7kF9JeMFfSqn/32iL0oTXf420fl1EnITOlCVXK+TW3MnKTvnqsfSlXNp3M60uBd8LCzTLDNoJrWxmVMZUMsKl60vnEKv/jcFlwJmWr17AFyunTzaZ8GO2qrED6VlXJdHSBBDMdljAqe8/I3OfMdi/5WVgBtA74Co+46VnPY695nl/oW9c0QIv3OAaxeRzchs5QJ+tGrOFLUou4tvVgLzD8t/sFrOASgx3R/1fsecnGIDgAXQ/T7CY752mk1PjZeHZu8j8dycvBoZHtj3G50HzsZ40JqNZtuBuafooDOEZUYWDiWjJRRU6SFud/F4m+pgoFINo1eeSTVdU+fwy+okGt16Cs4NOyMDVwka39rR1DUDN3HZa1qKsJd0vYNSGTvInCc52HJMui3mEB4WwmJQpQc73dR+axJzVD0TtcgmiUZX2fARufJin6K9p0PQ+NQleYxtn1F/sgyCDDwLMI0qHsusUfU7ak6e/tQj0tEeT+lWyfpXjU0ljfapEAX3/mBJ8X8MZc3cbwd5HXTWiL2VSX3Y1mkjvdowlR+3mW34JxrPUOungW58vgQwB8g6wyfeey/9tqR5XWQc1OXckwpnvTt6ZgeAchP6x8+2+A/naXgdnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5168.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(8676002)(66476007)(66446008)(66556008)(64756008)(8936002)(33656002)(52536014)(4326008)(71200400001)(508600001)(86362001)(122000001)(110136005)(9686003)(5660300002)(66946007)(54906003)(2906002)(38070700005)(316002)(186003)(26005)(83380400001)(38100700002)(7696005)(6506007)(76116006)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p66uR+0/jdhDwPVYG/t11hQrZNtRjYvEFRWjruu3cA0ijqXL7U8e7/JEhV0D?=
 =?us-ascii?Q?vBTdzAD4LZvr/31qzxawQGXn5OCi9TsYzu4lZXC3VUVbn0jbX1r1JqD1EWOe?=
 =?us-ascii?Q?DMl8DupSf4oUH3icCGkMmeQlfHAkW+4hj3WghSKJlTpciKxQKmFJplFrdvWf?=
 =?us-ascii?Q?/J9sVSaQb2ns1cOLE80nTy9IL1l3OJRQvwYuNOqH++L8i7FQkK8I2Rx1e6gc?=
 =?us-ascii?Q?YUa0i1w7uQrhV4kAr09L7PS8T5leCCpCLgobMFZpefQ2tn4ndJNEfNw2I51p?=
 =?us-ascii?Q?USIt/cV/PLdauLe5e/EHf4LCNl+WeD/Tzd4expvuQhc/DMzbLezqy8YpK9js?=
 =?us-ascii?Q?BSRwbvVmX51uhLOyYN0HWp84nbhpL0sjIWqhEem7Nhcb2n1aDhsJPepBTHA2?=
 =?us-ascii?Q?twtxg3XtVP6xbX3sjg17ntO0exn5h7vdbCUjfN6EhLVtZCx/mvRpnVxDMp8w?=
 =?us-ascii?Q?O052LCVcrcW099u9hDaUynY+FjF6mOY1oXXeCCD3NJqN9y8xXE3FY376yh8C?=
 =?us-ascii?Q?eHRH1QsmVm3LdavEqIgCJ7yfgn48dIvAXs23DcO7ef30WvUcppAdraJTUlTq?=
 =?us-ascii?Q?WDyHgNfhmpC+yZUmDQ2Vjc0Th58CIfJVQ3QX0DwarpVNpm7yPHd3vbjxTpbC?=
 =?us-ascii?Q?fpNEOJBslPBwwk9yZcSULc6BqaoACWq6HD9kETUcV/Am9TneOuhGIT+oVnSf?=
 =?us-ascii?Q?w2aNjvA21liggeklkNoxC+Efh/f51wG4OT+UzR1eJhRIe+v+iXgHwy6AQcuO?=
 =?us-ascii?Q?xyQ97PsP2A6tQxdPGJ785n/CInmzA05eAM74oXBd1t5Pimufp1E+yOLwTxoS?=
 =?us-ascii?Q?hCa/sPbMgKNFvT21D9qI54yghqef+6qmG/Pk1oIo57U2XcWt9HhTONwQcqwk?=
 =?us-ascii?Q?00Y1LalHkXlCmg75isXxTgPwa/Psdj+aYy0X+uNZ3gY99ChZdHiwFMBu9Nwv?=
 =?us-ascii?Q?D7O/rVekQB0ARiVeMMfQ0MSKrM00htqprr0r0q/7nrpS3+K6P1oL9C5xn1BL?=
 =?us-ascii?Q?Qi4WqBzH6CTaS0PTxY39hEGbnKVqjrNQ0Pz1wLx9anLMR+1HQQYvWPDEQ+vZ?=
 =?us-ascii?Q?1EQ4USbqYcItyHKgq7W8D8ugC5aOQDQaI+PI0fxtnhbl6YqIp47ILlvC735Z?=
 =?us-ascii?Q?xpvuPIA4ZiPCYnzRM1+HFPToblV9JPXy89/j6dXTLZCBms2dT12y2yhcYPx6?=
 =?us-ascii?Q?Vigq4FNFeSnrYtDtgF2GSP1Sz0B5tcgjRcvFAEAO63CjMJQgc2MtbuHCoIxK?=
 =?us-ascii?Q?f61VtzxpUvii4KM1E7gPDjNmgoHW9CjF+rD7PC3PunnYwf8DT64lhutPVi/M?=
 =?us-ascii?Q?Xh+p2M1dPWrh/FY6UFtFgYh0Sg0lqlnsRSBgZzlYvCqJsUwPFE4g1w2R8mZK?=
 =?us-ascii?Q?mgLyJzvc+uIJdepmE+wUdtUXJEz3QYo/QsuXBi6C4/86mNMJLtUWom6gpSAW?=
 =?us-ascii?Q?tZx06Hck6bV745RfjNcOAgwruzWELPyi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5168.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f879f581-2d21-4c1c-7cfe-08da092ed64e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 22:29:59.4335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aJGhldJmJRoNK+pCnpPkInjXAjvLFqZgycwFldhEF/qwNUoU2/KvKaV9yHsP3E/I/bsRfH6DD2eACRBfgdg3sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4120
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

> Between me trying to get rid of iommu_present() and Mario wanting to
> support the AMD equivalent of DMAR_PLATFORM_OPT_IN, scrutiny has
> shown
> that the iommu_dma_protection attribute is being far too optimistic.
> Even if an IOMMU might be present for some PCI segment in the system,
> that doesn't necessarily mean it provides translation for the device(s)
> we care about. Furthermore, all that DMAR_PLATFORM_OPT_IN really does
> is tell us that memory was protected before the kernel was loaded, and
> prevent the user from disabling the intel-iommu driver entirely. While
> that lets us assume kernel integrity, what matters for actual runtime
> DMA protection is whether we trust individual devices, based on the
> "external facing" property that we expect firmware to describe for
> Thunderbolt ports.
>=20
> It's proven challenging to determine the appropriate ports accurately
> given the variety of possible topologies, so while still not getting a
> perfect answer, by putting enough faith in firmware we can at least get
> a good bit closer. If we can see that any device near a Thunderbolt NHI
> has all the requisites for Kernel DMA Protection, chances are that it
> *is* a relevant port, but moreover that implies that firmware is playing
> the game overall, so we'll use that to assume that all Thunderbolt ports
> should be correctly marked and thus will end up fully protected.
>=20

This approach looks generally good to me.  I do worry a little bit about ol=
der
systems that didn't set ExternalFacingPort in the FW but were previously se=
tting
iommu_dma_protection, but I think that those could be treated on a quirk
basis to set PCI IDs for those root ports as external facing if/when they c=
ome
up.

I'll send up a follow up patch that adds the AMD ACPI table check.
If it looks good can roll it into your series for v3, or if this series goe=
s
as is for v2 it can come on its own.

> CC: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>=20
> v2: Give up trying to look for specific devices, just look for evidence
>     that firmware cares at all.

I still do think you could know exactly which devices to use if you're in
SW CM mode, but I guess the consensus is to not bifurcate the way this
can be checked.

>=20
>  drivers/thunderbolt/domain.c | 12 +++--------
>  drivers/thunderbolt/nhi.c    | 41
> ++++++++++++++++++++++++++++++++++++
>  include/linux/thunderbolt.h  |  2 ++
>  3 files changed, 46 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
> index 7018d959f775..2889a214dadc 100644
> --- a/drivers/thunderbolt/domain.c
> +++ b/drivers/thunderbolt/domain.c
> @@ -7,9 +7,7 @@
>   */
>=20
>  #include <linux/device.h>
> -#include <linux/dmar.h>
>  #include <linux/idr.h>
> -#include <linux/iommu.h>
>  #include <linux/module.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/slab.h>
> @@ -257,13 +255,9 @@ static ssize_t iommu_dma_protection_show(struct
> device *dev,
>  					 struct device_attribute *attr,
>  					 char *buf)
>  {
> -	/*
> -	 * Kernel DMA protection is a feature where Thunderbolt security is
> -	 * handled natively using IOMMU. It is enabled when IOMMU is
> -	 * enabled and ACPI DMAR table has DMAR_PLATFORM_OPT_IN set.
> -	 */
> -	return sprintf(buf, "%d\n",
> -		       iommu_present(&pci_bus_type) &&
> dmar_platform_optin());
> +	struct tb *tb =3D container_of(dev, struct tb, dev);
> +
> +	return sysfs_emit(buf, "%d\n", tb->nhi->iommu_dma_protection);
>  }
>  static DEVICE_ATTR_RO(iommu_dma_protection);
>=20
> diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
> index c73da0532be4..9e396e283792 100644
> --- a/drivers/thunderbolt/nhi.c
> +++ b/drivers/thunderbolt/nhi.c
> @@ -14,6 +14,7 @@
>  #include <linux/errno.h>
>  #include <linux/pci.h>
>  #include <linux/interrupt.h>
> +#include <linux/iommu.h>
>  #include <linux/module.h>
>  #include <linux/delay.h>
>  #include <linux/property.h>
> @@ -1102,6 +1103,45 @@ static void nhi_check_quirks(struct tb_nhi *nhi)
>  		nhi->quirks |=3D QUIRK_AUTO_CLEAR_INT;
>  }
>=20
> +static int nhi_check_iommu_pdev(struct pci_dev *pdev, void *data)
> +{
> +	if (!pdev->untrusted ||
> +	    !dev_iommu_capable(&pdev->dev,
> IOMMU_CAP_PRE_BOOT_PROTECTION))
> +		return 0;
> +	*(bool *)data =3D true;
> +	return 1; /* Stop walking */
> +}
> +
> +static void nhi_check_iommu(struct tb_nhi *nhi)
> +{
> +	struct pci_bus *bus =3D nhi->pdev->bus;
> +	bool port_ok =3D false;
> +
> +	/*
> +	 * Ideally what we'd do here is grab every PCI device that
> +	 * represents a tunnelling adapter for this NHI and check their
> +	 * status directly, but unfortunately USB4 seems to make it
> +	 * obnoxiously difficult to reliably make any correlation.
> +	 *
> +	 * So for now we'll have to bodge it... Hoping that the system
> +	 * is at least sane enough that an adapter is in the same PCI
> +	 * segment as its NHI, if we can find *something* on that segment
> +	 * which meets the requirements for Kernel DMA Protection, we'll
> +	 * take that to imply that firmware is aware and has (hopefully)
> +	 * done the right thing in general. We need to know that the PCI
> +	 * layer has seen the ExternalFacingPort property and propagated
> +	 * it to the "untrusted" flag that the IOMMU layer will then
> +	 * enforce, but also that the IOMMU driver itself can be trusted
> +	 * not to have been subverted by a pre-boot DMA attack.
> +	 */
> +	while (bus->parent)
> +		bus =3D bus->parent;
> +
> +	pci_walk_bus(bus, nhi_check_iommu_pdev, &port_ok);
> +
> +	nhi->iommu_dma_protection =3D port_ok;
> +}
> +
>  static int nhi_init_msi(struct tb_nhi *nhi)
>  {
>  	struct pci_dev *pdev =3D nhi->pdev;
> @@ -1219,6 +1259,7 @@ static int nhi_probe(struct pci_dev *pdev, const
> struct pci_device_id *id)
>  		return -ENOMEM;
>=20
>  	nhi_check_quirks(nhi);
> +	nhi_check_iommu(nhi);
>=20
>  	res =3D nhi_init_msi(nhi);
>  	if (res) {
> diff --git a/include/linux/thunderbolt.h b/include/linux/thunderbolt.h
> index 124e13cb1469..7a8ad984e651 100644
> --- a/include/linux/thunderbolt.h
> +++ b/include/linux/thunderbolt.h
> @@ -465,6 +465,7 @@ static inline struct tb_xdomain
> *tb_service_parent(struct tb_service *svc)
>   * @msix_ida: Used to allocate MSI-X vectors for rings
>   * @going_away: The host controller device is about to disappear so when
>   *		this flag is set, avoid touching the hardware anymore.
> + * @iommu_dma_protection: An IOMMU will isolate external-facing ports.
>   * @interrupt_work: Work scheduled to handle ring interrupt when no
>   *		    MSI-X is used.
>   * @hop_count: Number of rings (end point hops) supported by NHI.
> @@ -479,6 +480,7 @@ struct tb_nhi {
>  	struct tb_ring **rx_rings;
>  	struct ida msix_ida;
>  	bool going_away;
> +	bool iommu_dma_protection;
>  	struct work_struct interrupt_work;
>  	u32 hop_count;
>  	unsigned long quirks;
> --
> 2.28.0.dirty
