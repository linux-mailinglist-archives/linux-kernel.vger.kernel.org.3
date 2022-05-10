Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B50520A69
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 02:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbiEJAzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 20:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiEJAzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 20:55:46 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678D52532CE
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 17:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652143910; x=1683679910;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DgL+Yjf04GyVmDsUAj9vZ+JvuJKGNllLlCArJa3vQsI=;
  b=MeX6sFv2F9D6gY0VvgzgctcOeC+SEUukNvrWL+gWFPLlHLXWOhzJxvfE
   G9aPT5YMKpr2RB5P7gxqSC1YT8S1bsmikXdvePf/yoP/EijGIa1tYBeHm
   xeJtehURqY/BRcvNLqtZe3Xca8/NmnBecNHctgAmBEGLITeoa6Dq0Wv9Z
   UWB/TiNFuZSaRTUiRZxlu0VAOghk9qUFxIQ4XWzR0elFuYLluLGcHsZUC
   1mzFHzVXeqX9NUHlLGm3QSV8uT7rasH1bR1I5WIe+SGGQ6qouW+JYqCY+
   9b3/YuEIPr7cMjwTOVqtN6BcbzFdi97FQIGkSZKxKOWR1/o3S4E+Upy/D
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="269148175"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="269148175"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 17:51:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="593176391"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 09 May 2022 17:51:49 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 9 May 2022 17:51:49 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 9 May 2022 17:51:48 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 9 May 2022 17:51:48 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 9 May 2022 17:51:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLvq2+QFVrEvhMoC98jjqCqJQYJdqFXIGgcVO5HppJM3hib9xbRb8oBkMjSB+LiVB5BU4n9kVUHitlt6+pJzigqry4i+7lLAfJ3A9PEkfsFu5AMfE/ZY/i/TjG5mZRZPYR7LkgTNCntgAToeHRCkapfmZW1Ea6FATwdE4YaiWf3leLaUtYiYk8Worx+6kk8pnz0MRChrWQBfEusIElH+nUtMnR8iVVvTsPE1EE4iwN0uB7fgBDYVfoPjuMUZRgRWDwbMuenaD9+vDGler46qpoSZZJtWMOwEk1GcW49+xq5qNXx9rJtNcc8IA6MBopDxNU2vSP2nkQJ/iuDLMurx7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sHXO4OetxnL/gLLoog4JTfn2XAzWV1gSjWun36s+hA=;
 b=IDgKRtb4bJbXm6tld3CpIWDt8wiipuFguHuH3p7FAvigiiWguay8iI0sV3zozMkfiIw9zeQPqi77/DS2Ifhno7c42+05IYAdHsyAiaFsej49GTkXPp71qwT+yfOaz4LmxgUscB3Ozfq9mB3h0+EuN2+6QLI3UWLFJJAtIfWz/C4Qqm3noSxZJCvfvsMAd1Y4IR3AIiIXwDokHSa1QLU3G86dRNO51nxTiizTmtieLTJL11LCM1m6NULMEtQujWU3qxM0T77BVyjajBp6nOyNxmCJeb6abZUNiixgasvWLT3Pf5vsjo2YMqFlS5Qh4IIMVmsdzSzQPROtJ0sNovy3Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA2PR11MB4986.namprd11.prod.outlook.com (2603:10b6:806:114::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 00:51:46 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 00:51:46 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>
CC:     "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 2/4] iommu/vt-d: Check domain force_snooping against
 attached devices
Thread-Topic: [PATCH v4 2/4] iommu/vt-d: Check domain force_snooping against
 attached devices
Thread-Index: AQHYYtiNPxbYJ4Uiy02hj5zMDVazTK0XSm3w
Date:   Tue, 10 May 2022 00:51:46 +0000
Message-ID: <BN9PR11MB52764D8783A4C9F742A76BC88CC99@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220508123525.1973626-1-baolu.lu@linux.intel.com>
 <20220508123525.1973626-3-baolu.lu@linux.intel.com>
In-Reply-To: <20220508123525.1973626-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0cf7cc44-27e6-48b7-6f6c-08da321f4291
x-ms-traffictypediagnostic: SA2PR11MB4986:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SA2PR11MB4986BA63BD4F25071C8735348CC99@SA2PR11MB4986.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: izsP+J3mQWoswdijtZGpPl8dcg+c9I8/SDzZyXtfrMG1q+hJ3m21UMoLBeLXZwjagBjRYnHVuXZtmxZHbHFG2FtCIQIkwz1slAMOC+BL+S/P7i/Pg39xYHClb3M8rDYwS2gQPDsFCJ9+LmK+h4sPlCcJNfoiIZ7j/f8t/fxcx26Sus/w0CcKFFi1fbGcRLvIVS+FVwawd69CUnrfCGb6hFOe+4xZkU0GE8StDeBXowQJInKhxxKS178kj2Bbayck1NgUnS9tQ8yb/3MU957JzOXRAxks2NkPfB5VCP1TYVnCITwkaSQaYu8g5cUx9VrHr8p26da15nUzI6ZY2GCIgId8K6EcW/ZwynzUPC9yDtf6Bcf50l4Sty9oW0r0tSKX+yVRG8hMt91SAtDT7MarkLlQZsHiHUk8VaQWKbnTry/sisr8uE/e9KhQAs62dfk6Y7IHduRf6P2fVefkb48O7aZHj9QUzCv/Jmxeb5efreSKDnO5zflDHMAp+r0Noky5i/lFVho6Yd633RqThPJo34Mdmll4o9c3BNVCR5d8P/46alJvaTCKPcy2UT6jLo8vK+1WKptSsrEqP3keV+IRUfUiiPn0SKJwm1/lWBpcW44POk3rQ6srYGBfN2791WCPdM3OQbeRIYY82mXv7kU2902IzfyBbmCw4dSpMVHSK0v3PtQ98IALbp1rzga5kU/K
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(33656002)(8676002)(66446008)(66946007)(76116006)(66476007)(66556008)(64756008)(4326008)(83380400001)(508600001)(316002)(9686003)(86362001)(26005)(71200400001)(54906003)(6506007)(7696005)(110136005)(55016003)(82960400001)(52536014)(122000001)(2906002)(8936002)(5660300002)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V1oKoT4GAC+QndAnLFvkltHZQb9RHhiETrlFjwpcyyHayCnUylrQYOIJdgvz?=
 =?us-ascii?Q?RMtsEBCa31vUeXBT8lefC2j4XnHtTN3L2K8o7CSHbXwxpZpJ58ec4jYD1dSV?=
 =?us-ascii?Q?5EuDOWduWBj3czuLBrGwOgkqJRZHi7gM+oqK0voOIPBDvw2JPjSNWxOyKZkq?=
 =?us-ascii?Q?uJp23EwpLawJc4rZBbOMsRaidIBUPz1tR1wJQJ6bodYHSJ98mogZ3QYzCSfl?=
 =?us-ascii?Q?kDuxd1vNvr9FD2kxTkaVOlDtYds5yskszN603SnRSAQkqGhh7IPCM3EimSsz?=
 =?us-ascii?Q?T/yIZDUzSryU1m0tzk/CUZ+AaCvTHPpVwZcNrLzkaMaNdbI29IFoBrtt52fM?=
 =?us-ascii?Q?u6pXfIeCCsXlLN86Zx9e0s9276dUWI58J1plDpfcKlTG5BK4fCsKws0SBAly?=
 =?us-ascii?Q?Keer5mp5GyvIwOeWtJRvO52EYh7DkbrwA5TmZM/nMiUrHwoBZmYa1503MsGo?=
 =?us-ascii?Q?0gRGOjzeffa8tq/ebCGOptatXlFGstT6oN/y/7s0Wj/FKzfRQVRIfzqYs6Xk?=
 =?us-ascii?Q?DxlAODMWGBn2eVxvz7wEc1496C5YuLel2JgRyj7t1tJR4DKFVXUsobOmqjjt?=
 =?us-ascii?Q?gaEHv95+ruQ4TyHKccoCIYozzMfp3ucXG22r1gv/Hccq0x3379kMFTetjpYU?=
 =?us-ascii?Q?z/Ra4TFiNMScCLJz4ggHLbvfXduaxmkz9ZwKFlZ0j46uDh+qmLBbAsQLRoAv?=
 =?us-ascii?Q?GGtiTxSNgQ1Mzj/BP1ZGgFZFH858Sl1jbpvD+VxwUEpB/7P7bXgwKPJLsKLZ?=
 =?us-ascii?Q?LbiPknl4vGpuMnBmCnrObc/74UrmlvWGTF+lmJDlUAJ+pZst2jwvJVI2mhOU?=
 =?us-ascii?Q?4PdfuRfguANI/yjfcA61FcCJOlZp3OGE5B+i6Kz34lWGTh1fE/1eS3E1LnlX?=
 =?us-ascii?Q?N+z5AlZFbuDbhGwnBQmKVofzfxAa2HFiLtRnWznna/23VGIecJ21sVBpJINm?=
 =?us-ascii?Q?wnMLi3t8KeZ7nWreAYZEuxhgHe/ZTHKzZIsylIa6k51Foko62A0eGGWUbMJr?=
 =?us-ascii?Q?PetGwl86Qp9LRFJkJilS8sqCuRU44DhWPlbUVUlbz6pMGe5uLPLzHsP1G50Q?=
 =?us-ascii?Q?WQ91I71vtaMvUpUqU3NyCKzUtXadaYTh6PpgGxIZGNNtlTJcLYFW0uMHkZ9q?=
 =?us-ascii?Q?FFcoeb7yLOofINQ8fWztnxpImuS/MQy1c5GtlsV3V9w/5oaIMztjLMfxvQLz?=
 =?us-ascii?Q?F3WAQTSnCm4uZkFNli9zcypiZqUAghFod/KZS9PvPc2Bz0IhY101YPrq8EJu?=
 =?us-ascii?Q?OG2O983ZEq3kUVDL2mqFzG4hxCr/w40EHRMlRIRivV9jLCsNQJcOGbMtWngc?=
 =?us-ascii?Q?S5zyDS29JL0TzJQmZh0NiEDjJZTv6H/G+6T4LS0AmPL8kC0TuNRhhN9jRGyF?=
 =?us-ascii?Q?YtsziuR6AREK91md6nCMzNy50/CHMLRLoMcKHRyTzfQQAMCanCATRE2cd+ER?=
 =?us-ascii?Q?DQJEnS3cFBPjnyzExNQ2jepjbnN+mYTkBqEUrbf4KkdN7pqoAebf4pLjXahn?=
 =?us-ascii?Q?PLUGNRXkXfoPAdxw3kpAj66H+nyKbg81CJRCnAlIvsgQUvrjwfuGRbMAytIh?=
 =?us-ascii?Q?iQTMCc4COnqGm8bf+RvvlO0ZDrofJ8OBwSij1FhZq2BhxhEIdZYMPEIQLuqm?=
 =?us-ascii?Q?UcGYPqSssqYo5p3IDMDb8EwH32LIeDkq4sFKB/Jke7WxFl4YwR3/4U/0m7eM?=
 =?us-ascii?Q?xbUG/hwmmI0OZe3yI+9G+cDcdpkAyJlTNs6NA4Kbj7kzKVndiX6eHVt+SuGo?=
 =?us-ascii?Q?5NuXqEcqFA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf7cc44-27e6-48b7-6f6c-08da321f4291
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 00:51:46.8080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pUrzR6eBFQHIXkV6GvKtr3DU1N2Zyx8g8oQsd6AS/UjuGDex5GXB8K84yzB3sUr3NVl4UwTOB9AF2oLaI+yc3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4986
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Sunday, May 8, 2022 8:35 PM
>=20
> As domain->force_snooping only impacts the devices attached with the
> domain, there's no need to check against all IOMMU units. On the other
> hand, force_snooping could be set on a domain no matter whether it has
> been attached or not, and once set it is an immutable flag. If no
> device attached, the operation always succeeds. Then this empty domain
> can be only attached to a device of which the IOMMU supports snoop
> control.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

> ---
>  include/linux/intel-iommu.h |  1 +
>  drivers/iommu/intel/pasid.h |  2 ++
>  drivers/iommu/intel/iommu.c | 53
> ++++++++++++++++++++++++++++++++++---
>  drivers/iommu/intel/pasid.c | 42 +++++++++++++++++++++++++++++
>  4 files changed, 95 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 72e5d7900e71..4f29139bbfc3 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -540,6 +540,7 @@ struct dmar_domain {
>  	u8 has_iotlb_device: 1;
>  	u8 iommu_coherency: 1;		/* indicate coherency of
> iommu access */
>  	u8 force_snooping : 1;		/* Create IOPTEs with snoop control
> */
> +	u8 set_pte_snp:1;
>=20
>  	struct list_head devices;	/* all devices' list */
>  	struct iova_domain iovad;	/* iova's that belong to this domain
> */
> diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
> index ab4408c824a5..583ea67fc783 100644
> --- a/drivers/iommu/intel/pasid.h
> +++ b/drivers/iommu/intel/pasid.h
> @@ -123,4 +123,6 @@ void intel_pasid_tear_down_entry(struct
> intel_iommu *iommu,
>  				 bool fault_ignore);
>  int vcmd_alloc_pasid(struct intel_iommu *iommu, u32 *pasid);
>  void vcmd_free_pasid(struct intel_iommu *iommu, u32 pasid);
> +void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
> +					  struct device *dev, u32 pasid);
>  #endif /* __INTEL_PASID_H */
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index b4802f4055a0..048ebfbd5fcb 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2459,7 +2459,7 @@ static int domain_setup_first_level(struct
> intel_iommu *iommu,
>  	if (level =3D=3D 5)
>  		flags |=3D PASID_FLAG_FL5LP;
>=20
> -	if (domain->domain.type =3D=3D IOMMU_DOMAIN_UNMANAGED)
> +	if (domain->force_snooping)
>  		flags |=3D PASID_FLAG_PAGE_SNOOP;
>=20
>  	return intel_pasid_setup_first_level(iommu, dev, (pgd_t *)pgd, pasid,
> @@ -4444,7 +4444,7 @@ static int intel_iommu_map(struct iommu_domain
> *domain,
>  		prot |=3D DMA_PTE_READ;
>  	if (iommu_prot & IOMMU_WRITE)
>  		prot |=3D DMA_PTE_WRITE;
> -	if (dmar_domain->force_snooping)
> +	if (dmar_domain->set_pte_snp)
>  		prot |=3D DMA_PTE_SNP;
>=20
>  	max_addr =3D iova + size;
> @@ -4567,13 +4567,60 @@ static phys_addr_t
> intel_iommu_iova_to_phys(struct iommu_domain *domain,
>  	return phys;
>  }
>=20
> +static bool domain_support_force_snooping(struct dmar_domain *domain)
> +{
> +	struct device_domain_info *info;
> +	bool support =3D true;
> +
> +	assert_spin_locked(&device_domain_lock);
> +	list_for_each_entry(info, &domain->devices, link) {
> +		if (!ecap_sc_support(info->iommu->ecap)) {
> +			support =3D false;
> +			break;
> +		}
> +	}
> +
> +	return support;
> +}
> +
> +static void domain_set_force_snooping(struct dmar_domain *domain)
> +{
> +	struct device_domain_info *info;
> +
> +	assert_spin_locked(&device_domain_lock);
> +
> +	/*
> +	 * Second level page table supports per-PTE snoop control. The
> +	 * iommu_map() interface will handle this by setting SNP bit.
> +	 */
> +	if (!domain_use_first_level(domain)) {
> +		domain->set_pte_snp =3D true;
> +		return;
> +	}
> +
> +	list_for_each_entry(info, &domain->devices, link)
> +		intel_pasid_setup_page_snoop_control(info->iommu, info-
> >dev,
> +						     PASID_RID2PASID);
> +}
> +
>  static bool intel_iommu_enforce_cache_coherency(struct iommu_domain
> *domain)
>  {
>  	struct dmar_domain *dmar_domain =3D to_dmar_domain(domain);
> +	unsigned long flags;
>=20
> -	if (!domain_update_iommu_snooping(NULL))
> +	if (dmar_domain->force_snooping)
> +		return true;
> +
> +	spin_lock_irqsave(&device_domain_lock, flags);
> +	if (!domain_support_force_snooping(dmar_domain)) {
> +		spin_unlock_irqrestore(&device_domain_lock, flags);
>  		return false;
> +	}
> +
> +	domain_set_force_snooping(dmar_domain);
>  	dmar_domain->force_snooping =3D true;
> +	spin_unlock_irqrestore(&device_domain_lock, flags);
> +
>  	return true;
>  }
>=20
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index f8d215d85695..d19dd66a670c 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -762,3 +762,45 @@ int intel_pasid_setup_pass_through(struct
> intel_iommu *iommu,
>=20
>  	return 0;
>  }
> +
> +/*
> + * Set the page snoop control for a pasid entry which has been set up.
> + */
> +void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
> +					  struct device *dev, u32 pasid)
> +{
> +	struct pasid_entry *pte;
> +	u16 did;
> +
> +	spin_lock(&iommu->lock);
> +	pte =3D intel_pasid_get_entry(dev, pasid);
> +	if (WARN_ON(!pte || !pasid_pte_is_present(pte))) {
> +		spin_unlock(&iommu->lock);
> +		return;
> +	}
> +
> +	pasid_set_pgsnp(pte);
> +	did =3D pasid_get_domain_id(pte);
> +	spin_unlock(&iommu->lock);
> +
> +	if (!ecap_coherent(iommu->ecap))
> +		clflush_cache_range(pte, sizeof(*pte));
> +
> +	/*
> +	 * VT-d spec 3.4 table23 states guides for cache invalidation:
> +	 *
> +	 * - PASID-selective-within-Domain PASID-cache invalidation
> +	 * - PASID-selective PASID-based IOTLB invalidation
> +	 * - If (pasid is RID_PASID)
> +	 *    - Global Device-TLB invalidation to affected functions
> +	 *   Else
> +	 *    - PASID-based Device-TLB invalidation (with S=3D1 and
> +	 *      Addr[63:12]=3D0x7FFFFFFF_FFFFF) to affected functions
> +	 */
> +	pasid_cache_invalidation_with_pasid(iommu, did, pasid);
> +	qi_flush_piotlb(iommu, did, pasid, 0, -1, 0);
> +
> +	/* Device IOTLB doesn't need to be flushed in caching mode. */
> +	if (!cap_caching_mode(iommu->cap))
> +		devtlb_invalidation_with_pasid(iommu, dev, pasid);
> +}
> --
> 2.25.1

