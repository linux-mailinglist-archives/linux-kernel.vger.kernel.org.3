Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AF54EBB70
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 09:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243642AbiC3HHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 03:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243536AbiC3HHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 03:07:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B14E6C7F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 00:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648623926; x=1680159926;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=41r127F/UqUkDD7rVeZmHtVTKQXD9VOUvjsB3wXCNII=;
  b=D9e05ijHkKUue+fReIQaNKQpXqK3ss945dctt16GUKNB39mTV4CcadOJ
   aB5XswQ6owD5hP9EaskmTnmXQ4aMYku8vGCoI1S2kUCWoiQ/nZjewYHLa
   sDDZVeTrGBWj4DYpc3qqvE0VsZ+A2Z222yWfxLsar5SjAo+UjoTI68qYG
   GGYDa7vLBlLEvHX2n3XIXuEWb33o2KTAR31bF20AprsYuKgGiwDfh2qW8
   3BWh4nHxFes2Gd0o2P96l/raMVzTyKJQzOdOOoCVQ5uiqsNXUPM/QNw0f
   MGdm+3vg2QXZOly4v53ighPQUG97bZ/m/y8DIRzE2nbfYWd9YZqDYV0Ez
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="259180240"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="259180240"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 00:05:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="787902299"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 30 Mar 2022 00:05:26 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 30 Mar 2022 00:05:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 30 Mar 2022 00:05:25 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 30 Mar 2022 00:05:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gitlkn4LVmtudEkSMbUvoAuwg64GNV/CJwNW8rdfwf9MWmrHhIpia/gwMgiWQXGUwhKOb9dr4VMcaKDnvX9V51ZZBRDeyAOn/BRyqmB4jlQ06x8BCpfFXo9eXMK5bJ27dkC+aBR8iRl9ACpV4bWTIzS6G7503Y7C+dEqRNJJdfa8DdDSFeQEmrZB0VcC/YX3dhwAT1YR7FS6Uk/uIAbxmTdzf3lFv2+FTme3i5BXy6RZrweq20U7fYThyc4xymcUhr63iVJRl+8NaT6NWHRyTInYKv4FUrryA5o6ZJApFykgn6YizOUosxXwwvQk19/5+blpc5BVlrf5h2bAc4iPmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdPnrMtUTX/C+v1J/S0xblZkOnYyXTg0Vhtw4xJX5bM=;
 b=eKWl7c4e/OZq5fOBlyBjA22FcT8Xw18PFC7mTmUbHNK5hbiKVLGLJpRH3oje/AFPaoWQ0qP80k+Hf81REqGh7Z/cRle5bA2RpmKzJnCyXOatQhLFLxTPJ4x1ebPlJgIZVHHZmZXVoxdONbwPRMgcNW1uGbpW1b4C9Ur3f7E61KkcMLYyYBm4Ey9ZqkyDgzMEUOyGcXL7yFTA1wfVU1a8Vb4lsqUJPyip80FIDBxQLVIbOaL39w4EMNdmfHVU+PnhedjgiPt8E/CiCG5n39vNsAV9Af4smrGWkbwqWja+dkU2qaEOgxQx04kxvfnJTDkRBmy7EhOI9HmDZuz1l6IRyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5207.namprd11.prod.outlook.com (2603:10b6:510:32::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Wed, 30 Mar
 2022 07:05:23 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4df7:2fc6:c7cf:ffa0]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4df7:2fc6:c7cf:ffa0%4]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 07:05:23 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
CC:     Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RFC v2 01/11] iommu: Add pasid_bits field in struct
 dev_iommu
Thread-Topic: [PATCH RFC v2 01/11] iommu: Add pasid_bits field in struct
 dev_iommu
Thread-Index: AQHYQy9/UVY7D5gKo0W74jOQFA9+b6zXgkEA
Date:   Wed, 30 Mar 2022 07:05:23 +0000
Message-ID: <BN9PR11MB52763DAEC605FD1B21EE4EAF8C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-2-baolu.lu@linux.intel.com>
In-Reply-To: <20220329053800.3049561-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d627d143-72de-4c22-50f7-08da121ba8e1
x-ms-traffictypediagnostic: PH0PR11MB5207:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <PH0PR11MB5207E2A84DD214906FFFD6048C1F9@PH0PR11MB5207.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x3AUd7XUtIfGMmKm8ZBhTgKVnhZRIs1S/FM5H+fT4dXb5KVdAbqCjdcbs14qgbu0Xfc9KOxZYfQBSMy3ynG5Bi8dr530doMgHLIwyHQBxP73H7Du1Aikf20jpEPaRIxHT0NwvwfsHccbw9+HG4SyxXDu83M28Svhx9GiQGHefDaEubXlIxCu7Z2DcsPHB7xT8A0N1suXvKhWc0nXpUvkwT1CNexl34E8gbvlBUudXAWirpu4CDK2sNU2gDzQvI1VqJ9qw2xjvWQ5tczUy5bY+lFG0YqiZy8cRTCu8xXqNeFSN3TMre7/kADD8dYi0CNKPOeAF7gLG+gLTFvDyUTkZFNVlpcWpz0a/hy7NOJZmiYcej5jsx7z9oUoj7T0ZnCKoT7PxKybJTgPEHJ3v1ycchMl+yNWp46CSOYp+66Ab34Z7Sw4NqHQCLIu+wbMoJjPJ7WdtVnRHJRjjxJLkECiz+Yz5d4ZwiMqMhvmSNOGSts4YuC7pRH6bN4NKkxJNu6JFiSFdtXqtLn047YBanN9J9lZDP/QP9f5UAvSs+2gV9oQlnVf/RAF+TmorK2J2M/wPLR3xPLI7eE9Y3qmg7C5jzlkdcXpS0ZtQfF0Aa3v6RHl2xMwUZaQqfa2fTPd6a7lMb4UVXLodGTZPtv66qkG8xb/7sWqMbG/qzHd0pAq10xVCqjo6+PQ8eYtRhFiQT7q91MZQgW7zjzkL+0G32ZVZWobLxBJOUgPRTWHFBGOry4P9lXlIgQBmRqdJiD/iI+LVJIn1QPUHys8nguVc+iG/kTVi6Y1HWwbyJLU4DZX+zo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(55016003)(8936002)(2906002)(52536014)(7696005)(6506007)(966005)(83380400001)(82960400001)(122000001)(86362001)(4326008)(316002)(71200400001)(38070700005)(33656002)(54906003)(38100700002)(110136005)(508600001)(26005)(7416002)(186003)(8676002)(64756008)(66446008)(66476007)(66556008)(76116006)(66946007)(9686003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H3oeZUhUjvU56xtLPLwoiEKGKlIJdiijkazk29a9Zp1Vovcb1MiATZF0cvab?=
 =?us-ascii?Q?5E8lYR/ZMJZAyVLTS4j3Mwh864aJMTqDe8r0W+rzruM4ydQ+Lb96Mc3AM+Cl?=
 =?us-ascii?Q?etDXs7B8jIrG28+ylrydDhdJXsxSMWQZVwaJAWazxM6cILnPNlTHp1A1cJyC?=
 =?us-ascii?Q?HRPSB5bD4zoCxHald8mRokg0zH6INFCJ7W8b2vxPswfv52pogqZR3TRPX8Gb?=
 =?us-ascii?Q?hW4lMFvMNHIBnw85pEcMjTCJdb9fpzKeqYGhKe3hZjmOqpc8OQqwCf/yUNGm?=
 =?us-ascii?Q?Z8TS0r++SaJ7oDAxTUHy9TqqMTgjF30ukU9MKX8LXDGvvKPe05srU0bEBzQr?=
 =?us-ascii?Q?uMbhAOInNKiXJD4Ns4cQSLQYdakw+82CsKNjlDCD3wXDPrH0su/oyP7dqBIs?=
 =?us-ascii?Q?IaY28pwESudIQ2CQTs+9Z2RR87z7NZtirjAp2rRzH+iB3a+R7+6qFJrP4ABY?=
 =?us-ascii?Q?55EcNJe5YjUSqLArXTUAlXxlr4zkjRJwDf+fIIDu/JSMZALgHIRiMFWMkErW?=
 =?us-ascii?Q?jwKXVuecWGU3CBjMdIe8kRIFGMSpvIoL0W0xTQUnfGGd1XLP+RZgyxi8QLao?=
 =?us-ascii?Q?1Zbe4mRwfzWcCvqNwBXFHzVYM5VILnKS/eXJFuGqLp0i5GhQQDqb7gxDlq0T?=
 =?us-ascii?Q?682rDbbb8pE1d6WLEe+b0tic/tijyrKk/UHPLEYN4+QGnNkFviuvVX7VbsNt?=
 =?us-ascii?Q?Xp7I6/HAYVefdSTPyWNRxRZrl4Q/9TLgpBQJLPjOit2AZGAk4F+X+Ayc6RyX?=
 =?us-ascii?Q?K0aTTIkvQXlzI48PDAvsPVZuTpV23AOu97vn9fuMyBvybOmnM0EShYiv+hIx?=
 =?us-ascii?Q?4ibkHWIbahYHafZtYBM0K1+pfJbtgFQXGqzdZVU5lWX8v4u28Nx/WpYUXydr?=
 =?us-ascii?Q?QT5GNVD01HANwMnDv6TRC/2/ABixMRHg0e/Fci1jDKVw3Yp2ovmQqxwB9viR?=
 =?us-ascii?Q?uenRmwkvgV018mxYZHE++5UjgWVm1M1HgBpjjR/9GX21LvE0xwoA5KPBF+pO?=
 =?us-ascii?Q?C4pfBHNJtWFRuPyy5asDffd8OAohqGqf8eCSkJ9FUUpIafpaDJBm8Yc1s1qP?=
 =?us-ascii?Q?gTNz/SvnW9DYwhptLM+Nr0/M68Qi550mvJIGBI5G8xZy+vppQu7O6O0wSIEp?=
 =?us-ascii?Q?VvBp0obsWsene4tqHxrDFsRHr/tzThRamlrDhxySsEIn0hFVpyhgI8eqi7af?=
 =?us-ascii?Q?QglxhjVt+Ge0SlDMIPE6TnELfP+yL/AJuuBrQf/mM3GsHFMUDtrvBfZ6nhJs?=
 =?us-ascii?Q?Vuatc0H7ZL7SLTP7fqYtqQ9W1254fp98OI5sPrXmPFHUZh2Q5pF+668lB84+?=
 =?us-ascii?Q?IFD3cuhh5FbKJznlY1h/XoaNHcjzLxO48iHNG43YqokDAiTag0NBG+WjMBod?=
 =?us-ascii?Q?cjXpQqZAZpdE9Eo0wwDmNHdVwIuNJZ7+iqow+i3QXU4CerF3HfiAinoCGFpV?=
 =?us-ascii?Q?bTPIpUJudLu2/8tTplcm9PbNWp50z0uiFZFOzq7Kq9owAoGLG9PI2sDW4Ufh?=
 =?us-ascii?Q?NPw1Mx/NAC4tTGJ7p/Vq1IIGLuWi7zxp6AWBsAgkWVKeH98QeSRQ8KUBrrLD?=
 =?us-ascii?Q?KMzuhRy0D1m1HRXaCiCDc0ErY9yJeee/0nCRAyHrrW2CV71Ebpj8qofR0Jxv?=
 =?us-ascii?Q?9H4buorjwwZOv0hjYXmzP2Y9k5WtqhFniBri/vzLXQq1Knp7rcGansEBv/Qi?=
 =?us-ascii?Q?OaHBYTqog7tcGkuviPB9pQ1OoQy9yUeoRCYIZLXGsKqbad/s9jjeejCtGl00?=
 =?us-ascii?Q?51MqTjAXpQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d627d143-72de-4c22-50f7-08da121ba8e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2022 07:05:23.1852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3TT9ili6iravj2rY0XZ9IGvMkjv9RonNkpIAbvls+zVq31ylbXBDZRY35P5GV8//X5qc3KUdh9ZNCE21dj62Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5207
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, March 29, 2022 1:38 PM
>=20
> Use this field to save the pasid/ssid bits that a device is able to
> support with its IOMMU hardware. It is a generic attribute of a device
> and lifting it into the per-device dev_iommu struct makes it possible
> to allocate a PASID for device without calls into the IOMMU drivers.
> Any iommu driver which suports PASID related features should set this
> field before features are enabled on the devices.

Miss a clarification for non-PCI SVA as discussed here:

https://lore.kernel.org/all/85d61ad6-0cf0-ac65-3312-32d0cdeb1b27@linux.inte=
l.com/


>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h                       | 1 +
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 ++
>  drivers/iommu/intel/iommu.c                 | 5 ++++-
>  3 files changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 6ef2df258673..36f43af0af53 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -368,6 +368,7 @@ struct dev_iommu {
>  	struct iommu_fwspec		*fwspec;
>  	struct iommu_device		*iommu_dev;
>  	void				*priv;
> +	unsigned int			pasid_bits;
>  };
>=20
>  int iommu_device_register(struct iommu_device *iommu,
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 627a3ed5ee8f..afc63fce6107 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2681,6 +2681,8 @@ static struct iommu_device
> *arm_smmu_probe_device(struct device *dev)
>  	    smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
>  		master->stall_enabled =3D true;
>=20
> +	dev->iommu->pasid_bits =3D master->ssid_bits;
> +
>  	return &smmu->iommu;
>=20
>  err_free_master:
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 6f7485c44a4b..c1b91bce1530 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4587,8 +4587,11 @@ static struct iommu_device
> *intel_iommu_probe_device(struct device *dev)
>  			if (pasid_supported(iommu)) {
>  				int features =3D pci_pasid_features(pdev);
>=20
> -				if (features >=3D 0)
> +				if (features >=3D 0) {
>  					info->pasid_supported =3D features | 1;
> +					dev->iommu->pasid_bits =3D
> +						fls(pci_max_pasids(pdev)) - 1;
> +				}
>  			}
>=20
>  			if (info->ats_supported && ecap_prs(iommu->ecap)
> &&
> --
> 2.25.1

