Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6BC532777
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 12:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbiEXKYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 06:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236067AbiEXKYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 06:24:12 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0658DDC8
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 03:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653387850; x=1684923850;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JqF4jo8XZ7qusmi/e7y4NbeuICkPsOQQxnNUaapGhLI=;
  b=OTdKH8vr4zN16ua6YuYUIaea1CXlvQRFtwUT7/febW3ZfKRo4kNNUIXL
   xuFKtAuACqoPMYiR4SDIfFf/Qoo80sTB7z5IJMXsApw6oHJr4b5/xSPQy
   yFpJDnoDXlO7mzLU4Sg3f1KAzpVE2qomc0ExxvVsRhkIaZirzmy+p1bxQ
   cxlH5r2YzgatPuYjr34iVW7RMIAMrOodjJvzo6ddvyBhsDUUfxydnvk97
   3P1g+Fq0gdcTZGzMI+BHjQO1fS35VFzhX27g53guNiGp56Ll2d86I4iY1
   JPo+erUG68MIhvLMDc98GzLU2wD10PDLLfMhI5KcYI3YBB6F7IP6q1ajV
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="336545157"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="336545157"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 03:23:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="820232893"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga006.fm.intel.com with ESMTP; 24 May 2022 03:23:47 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 24 May 2022 03:23:45 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 24 May 2022 03:23:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 24 May 2022 03:23:44 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 24 May 2022 03:23:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQ75HIseYpCKySZ7TpuLCKwr2IiADCck9azqZgxQtPhwENbDB/3gw1NCjkOw7ly7CnPhgv+AMf88fMNkSdwDz8JQ5fbRCAdzsyjHqkj8fmy1oGtVy5j1rbMdV4unthUTGUzyd8zXg6v9MkGMr93eRJfLXUwqHNscdw0K4xb8Roy7I3RB8Rtge63PeermFMLzYlGEajYoaxe5+Hd0fWlz/050sZy3qR+vrzVxMXBkHuTljjiut5E05Rdxip3i74jMmyGZuMk8jMmBJjlCkCNG/lmqrNqrrRzlZM0Mc1NFxdQw5iYtMeESeiGaO3dhK/BLfFGvjCDIrPBlFGvdOFWDRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6InVPIvXwFXLSl8dDyUIxyqyL1jp9l4d+GX9udybks=;
 b=XnBqv9mqudO/OWBrBsmcErstoLUD33d18x02Sq6Utv7IxTjkqr5vlf8nygr80yTUZ5bw+TBw7Ct1EnrTGVRxCIJLUpb0QSZVH0/CEtNJOrUwcxAOh5O5yH8q/hIE1bpjLas1pwYAbooMtLp4MJ9q6SeunpBOaz1TVymAp4ABshTlBj0EzEs+8s47f5CQMuG6OMcMHkx3LshYlkscyM8BL5U4QHBILf2kbY5k1Fsvt73yhmQKrodf4idXP5XPhiH/az+Kg+it2nHzmz+m7KuebNd3AKYSyQXqZINws3gfJv5FS5HbHfLLtERacwbJBVvSllIwegTVZVeN52zrTglrzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB4361.namprd11.prod.outlook.com (2603:10b6:5:1df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Tue, 24 May
 2022 10:23:42 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 10:23:42 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
CC:     Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>
Subject: RE: [PATCH v7 07/10] iommu: Remove SVA related callbacks from iommu
 ops
Thread-Topic: [PATCH v7 07/10] iommu: Remove SVA related callbacks from iommu
 ops
Thread-Index: AQHYa1GMMqs1UE4FvkmNvllgC9i5Ta0t2fMA
Date:   Tue, 24 May 2022 10:23:42 +0000
Message-ID: <BN9PR11MB52767B3706794273F23AF9008CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-8-baolu.lu@linux.intel.com>
In-Reply-To: <20220519072047.2996983-8-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 072d6e05-8b5e-4bee-24bf-08da3d6f7a17
x-ms-traffictypediagnostic: DM6PR11MB4361:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB436179A29A08FCD9415CD9DD8CD79@DM6PR11MB4361.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dLn/Tn/WYJaxohW+zUHxWcuDTRLmayeyWugUW9xwshh7ikbYS4lZFTeIhm73+tNTXX5XXf/py8HSOMO5YPixOeqF2BoWTNSCNCHftE1KQG0ZFb0eXGYXbEEMKRsp+bqbBwRC16CN+J0Ls1gm+g32UG2GoZ6EDoRbUOq0Uki5VBxxZqts7PnHP0r4deBDIrj+IlqYg0VQLXjz5z+psxKjrNplEoil7IG5p8eY3dDJ1RQ82LbMCn/nkNt5gkcYt6XZrSGIi1ATk1BXuGtpYBAGZNk/RO66TgBjhbfMLQ7VT6HNnzQ9pXxApNwXfVxtH3wlmpCclfEdY4IbuXfbrDKvAYVd/mGQUHYbo67pygtdCq3OR2SbuW8heYgGaaSrlR8p5M/fh/hO0LK826MgJudjJjJRsPIw/PM3lufRHmrDAkA4vY5sfFdWMO72EFc0wDxaLohebmH6409Dwx/2deXoDGMevtjUkW0wsd61xF2fLWWAwQl5+SRDhwoBcL+LEha5w74o1gQUU7s7YbZcl6c/WdupkdRqVGFFQ+sAdG+6UF0b8CZoQkZieziC3Bv0rKcjjqOrXzIUc6V22001SZXMHmDrzgDgtAvfbC1HRzQEIJ5Eua7t5WnPaOMzjGiUljjTVtka7Eyg+bQtEZINIB343oyK+y7F/OMYWucE2S7AnBsXrs/uMmwD8Aiv25lcjJ4kwwDkvavCR23o8u/zm/2YrfrQemrGLsJKtiIfGFMmOyk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(5660300002)(7416002)(38100700002)(38070700005)(8676002)(55016003)(4326008)(2906002)(508600001)(122000001)(82960400001)(26005)(9686003)(921005)(33656002)(316002)(54906003)(6506007)(7696005)(86362001)(83380400001)(66556008)(66476007)(66446008)(66946007)(76116006)(110136005)(71200400001)(52536014)(64756008)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BgVTX5dpWdsSzC1VePbK/QyV+90Uji/O07c5zKNch+kvazlUXKGwdW1dg5Wd?=
 =?us-ascii?Q?6RTPnsuJB+ese0vfNMh9maT2UMlSdavgzxm/EspJmjVXM15uSs6uLVS7y7x9?=
 =?us-ascii?Q?BnLpAC92C9ST8O8kPseZfx/zLAxyRvlWuuvsQw/E/nGYohJBsYvO6QkWS3oS?=
 =?us-ascii?Q?F1w2EjI+x28TtiGgSxmklxv0aNTmwP92Pb/sbOH8xC8HzbvG5BZHYsmShfEl?=
 =?us-ascii?Q?ijwYzrfdx9YvK0myhFLtWCZGRar6f2JsxJbCMBXJvzowf/Y9xMZZBrc79kgt?=
 =?us-ascii?Q?47doIWagKi9m9OGu++aNWmCU5yO/zRodjfBiOYzbPR2i2b8QvwXM6I0IKnfu?=
 =?us-ascii?Q?48GGS2twTEiReu8N9Dc1wGzCfs9kSbmniZDVmktNIL5ll/OT+/yFfLaSnM2/?=
 =?us-ascii?Q?/IOvgQHZ/bHcoDMhURCDnsLrs7hGJ9v63sE3pgEqv6Fvjnz3xGaLsIV3GACP?=
 =?us-ascii?Q?fwbgM0MTjgE7ujClvSPf2JLIfq6ga069xrDxFdTtft6LeAjhY+phh7TBNXUS?=
 =?us-ascii?Q?67skGAYx93tov/4eWKfFu+ve4vv5chEGBthNTza85UWSys893t8/zgTwW8PQ?=
 =?us-ascii?Q?d2otruuNGaPuJ74tfxVFQ3KwSl8fHDDapZszQ7jBacmwLKnPPZWnPljGsOvJ?=
 =?us-ascii?Q?9YZSMVMBELLe0THFNvVl04ISZVSBcBYOLSgFEfhZYesZ6nXuDwdHfePtO84M?=
 =?us-ascii?Q?16uDhVUFHdytxIokLzJxAEpFrDFDB6zNvtRZHy+RD18vB4ah/uQYVEQuZB7F?=
 =?us-ascii?Q?DkC+vDM45KjRsw4MUNfrA8vRgWGpYZC4nwHOn0A8w8qjmDSnBMa09nDPthLv?=
 =?us-ascii?Q?EEm69Gus6+liYhG6muSsOWoMgPRYlu3yJ8HMJ606Ib7OcGJZK9J2wG3S7sVS?=
 =?us-ascii?Q?u2luRDkSJlzPXEL/79KPXqZ3DhTqThY2K96a7eL7FvP90dD5XIynePsEZfxE?=
 =?us-ascii?Q?t3ZVkAACMqDza8WJ1U3N6Vw2t6eKyTuEEeiFHw96yk3pY9f9CFHg4f2UGdbh?=
 =?us-ascii?Q?vJEQa7sM+/oLrcz9g5NyCnQZ8YX3yLVzjqDB1MIFV0MJoAz/13tu45wfqSC4?=
 =?us-ascii?Q?qc5meEEUPlsqkwj14irVygqiQk2yu1cA78OC1j8T87ByKHAiFRDAPoipuWW7?=
 =?us-ascii?Q?7b3TFtDtmcaWdluKExbhYHwEDB53oTYOXb4POH8aLg0lbsGKLG6kBeipna64?=
 =?us-ascii?Q?L18oGVl0b/3NRjOoO6Cu8lfEzzvout2Dh/2L1haMoUIR9w/twVL+OJOhXR0n?=
 =?us-ascii?Q?9/lCFWxbjA+JM5R3c1kgZDJsOStZwiaR8lyUWefz0MtBuYcU82SmDbN3hwLk?=
 =?us-ascii?Q?NrT+NTeOwbsibHX67CBeZRyu8MPOQn3cX2x80rB62u2N6C6vPrhUR3vIfwUO?=
 =?us-ascii?Q?tFXsiWSvEuE1l1aaU262S8o4qvSISQGiAWFbDsK293Uk3VL5MgzBgxRuVAP8?=
 =?us-ascii?Q?qTPTQlYtdNW10giQDBb3L23slELwVYWlmf9jj7gjeWeFwAQCbAqzfmkc/7MX?=
 =?us-ascii?Q?Zl8f/Uael5aw/NiYGT1nV692hCIMVd44GbfO6WtZj3vejXrpVImPwMnaIvXb?=
 =?us-ascii?Q?4pKJNpcs5ooJnmRJOJeP76kpVF7epP1xVKNiYz2GciwWQPfmytYeE+jNWhge?=
 =?us-ascii?Q?rggZxGNpB0WPH+6i1hZkf9qD7vdb38mVT2eIsO1ewDsJVc5NyyhIsXjT/fmZ?=
 =?us-ascii?Q?MH60koKmua6/HLgHeieDO7J15Q5BrpYrqGkFlbSajUG87fd7g85iRRYMEWCh?=
 =?us-ascii?Q?a2YxwcVwuQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 072d6e05-8b5e-4bee-24bf-08da3d6f7a17
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 10:23:42.5191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rj/OqNU9vIh2JfE/lH/8mvMhi38EQQpw/f5u+ifHy013KGuLLFhxxANIwC4DSjVdO6TX71beHSEeqbnUW6JdnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4361
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, May 19, 2022 3:21 PM
>=20
> These ops'es have been replaced with the dev_attach/detach_pasid domain
> ops'es. There's no need for them anymore. Remove them to avoid dead
> code.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

> ---
>  include/linux/intel-iommu.h                   |  3 --
>  include/linux/iommu.h                         |  7 ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 16 ------
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 40 ---------------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  3 --
>  drivers/iommu/intel/iommu.c                   |  3 --
>  drivers/iommu/intel/svm.c                     | 49 -------------------
>  7 files changed, 121 deletions(-)
>=20
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 5e88eaa245aa..536f229fd274 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -739,9 +739,6 @@ struct intel_iommu *device_to_iommu(struct device
> *dev, u8 *bus, u8 *devfn);
>  extern void intel_svm_check(struct intel_iommu *iommu);
>  extern int intel_svm_enable_prq(struct intel_iommu *iommu);
>  extern int intel_svm_finish_prq(struct intel_iommu *iommu);
> -struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct
> *mm);
> -void intel_svm_unbind(struct iommu_sva *handle);
> -u32 intel_svm_get_pasid(struct iommu_sva *handle);
>  int intel_svm_page_response(struct device *dev, struct iommu_fault_event
> *evt,
>  			    struct iommu_page_response *msg);
>  int intel_svm_attach_dev_pasid(struct iommu_domain *domain,
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index d9ac5ebe5bbb..e4ce2fe0e144 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -212,9 +212,6 @@ struct iommu_iotlb_gather {
>   * @dev_has/enable/disable_feat: per device entries to
> check/enable/disable
>   *                               iommu specific features.
>   * @dev_feat_enabled: check enabled feature
> - * @sva_bind: Bind process address space to device
> - * @sva_unbind: Unbind process address space from device
> - * @sva_get_pasid: Get PASID associated to a SVA handle
>   * @page_response: handle page request response
>   * @def_domain_type: device default domain type, return value:
>   *		- IOMMU_DOMAIN_IDENTITY: must use an identity domain
> @@ -248,10 +245,6 @@ struct iommu_ops {
>  	int (*dev_enable_feat)(struct device *dev, enum
> iommu_dev_features f);
>  	int (*dev_disable_feat)(struct device *dev, enum
> iommu_dev_features f);
>=20
> -	struct iommu_sva *(*sva_bind)(struct device *dev, struct mm_struct
> *mm);
> -	void (*sva_unbind)(struct iommu_sva *handle);
> -	u32 (*sva_get_pasid)(struct iommu_sva *handle);
> -
>  	int (*page_response)(struct device *dev,
>  			     struct iommu_fault_event *evt,
>  			     struct iommu_page_response *msg);
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index ec77f6a51ff9..0f0f5ba26dd5 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -754,9 +754,6 @@ bool arm_smmu_master_sva_enabled(struct
> arm_smmu_master *master);
>  int arm_smmu_master_enable_sva(struct arm_smmu_master *master);
>  int arm_smmu_master_disable_sva(struct arm_smmu_master *master);
>  bool arm_smmu_master_iopf_supported(struct arm_smmu_master
> *master);
> -struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct
> mm_struct *mm);
> -void arm_smmu_sva_unbind(struct iommu_sva *handle);
> -u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle);
>  void arm_smmu_sva_notifier_synchronize(void);
>  int arm_smmu_sva_attach_dev_pasid(struct iommu_domain *domain,
>  				  struct device *dev, ioasid_t id);
> @@ -793,19 +790,6 @@ static inline bool
> arm_smmu_master_iopf_supported(struct arm_smmu_master *master
>  	return false;
>  }
>=20
> -static inline struct iommu_sva *
> -arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
> -{
> -	return ERR_PTR(-ENODEV);
> -}
> -
> -static inline void arm_smmu_sva_unbind(struct iommu_sva *handle) {}
> -
> -static inline u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle)
> -{
> -	return IOMMU_PASID_INVALID;
> -}
> -
>  static inline void arm_smmu_sva_notifier_synchronize(void) {}
>  #endif /* CONFIG_ARM_SMMU_V3_SVA */
>  #endif /* _ARM_SMMU_V3_H */
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index 6969974ca89e..8290d66569f3 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -344,11 +344,6 @@ __arm_smmu_sva_bind(struct device *dev, struct
> mm_struct *mm)
>  	if (!bond)
>  		return ERR_PTR(-ENOMEM);
>=20
> -	/* Allocate a PASID for this mm if necessary */
> -	ret =3D iommu_sva_alloc_pasid(mm, 1, (1U << master->ssid_bits) - 1);
> -	if (ret)
> -		goto err_free_bond;
> -
>  	bond->mm =3D mm;
>  	bond->sva.dev =3D dev;
>  	refcount_set(&bond->refs, 1);
> @@ -367,41 +362,6 @@ __arm_smmu_sva_bind(struct device *dev, struct
> mm_struct *mm)
>  	return ERR_PTR(ret);
>  }
>=20
> -struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct
> mm_struct *mm)
> -{
> -	struct iommu_sva *handle;
> -	struct iommu_domain *domain =3D iommu_get_domain_for_dev(dev);
> -	struct arm_smmu_domain *smmu_domain =3D
> to_smmu_domain(domain);
> -
> -	if (smmu_domain->stage !=3D ARM_SMMU_DOMAIN_S1)
> -		return ERR_PTR(-EINVAL);
> -
> -	mutex_lock(&sva_lock);
> -	handle =3D __arm_smmu_sva_bind(dev, mm);
> -	mutex_unlock(&sva_lock);
> -	return handle;
> -}
> -
> -void arm_smmu_sva_unbind(struct iommu_sva *handle)
> -{
> -	struct arm_smmu_bond *bond =3D sva_to_bond(handle);
> -
> -	mutex_lock(&sva_lock);
> -	if (refcount_dec_and_test(&bond->refs)) {
> -		list_del(&bond->list);
> -		arm_smmu_mmu_notifier_put(bond->smmu_mn);
> -		kfree(bond);
> -	}
> -	mutex_unlock(&sva_lock);
> -}
> -
> -u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle)
> -{
> -	struct arm_smmu_bond *bond =3D sva_to_bond(handle);
> -
> -	return bond->mm->pasid;
> -}
> -
>  bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
>  {
>  	unsigned long reg, fld;
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 4ad3ca70cf89..b74f8964cc13 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2852,9 +2852,6 @@ static struct iommu_ops arm_smmu_ops =3D {
>  	.dev_feat_enabled	=3D arm_smmu_dev_feature_enabled,
>  	.dev_enable_feat	=3D arm_smmu_dev_enable_feature,
>  	.dev_disable_feat	=3D arm_smmu_dev_disable_feature,
> -	.sva_bind		=3D arm_smmu_sva_bind,
> -	.sva_unbind		=3D arm_smmu_sva_unbind,
> -	.sva_get_pasid		=3D arm_smmu_sva_get_pasid,
>  	.page_response		=3D arm_smmu_page_response,
>  	.pgsize_bitmap		=3D -1UL, /* Restricted during device attach */
>  	.owner			=3D THIS_MODULE,
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 2b6a52c87c73..10e07d59d4c8 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4919,9 +4919,6 @@ const struct iommu_ops intel_iommu_ops =3D {
>  	.def_domain_type	=3D device_def_domain_type,
>  	.pgsize_bitmap		=3D SZ_4K,
>  #ifdef CONFIG_INTEL_IOMMU_SVM
> -	.sva_bind		=3D intel_svm_bind,
> -	.sva_unbind		=3D intel_svm_unbind,
> -	.sva_get_pasid		=3D intel_svm_get_pasid,
>  	.page_response		=3D intel_svm_page_response,
>  	.sva_domain_ops =3D &(const struct iommu_domain_ops) {
>  		.set_dev_pasid		=3D intel_svm_attach_dev_pasid,
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index d575792441f3..e412a442d9a4 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -313,14 +313,6 @@ static int pasid_to_svm_sdev(struct device *dev,
> unsigned int pasid,
>  	return 0;
>  }
>=20
> -static int intel_svm_alloc_pasid(struct device *dev, struct mm_struct *m=
m)
> -{
> -	ioasid_t max_pasid =3D dev_is_pci(dev) ?
> -			pci_max_pasids(to_pci_dev(dev)) :
> intel_pasid_max_id;
> -
> -	return iommu_sva_alloc_pasid(mm, PASID_MIN, max_pasid - 1);
> -}
> -
>  static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
>  					   struct device *dev,
>  					   ioasid_t pasid,
> @@ -810,47 +802,6 @@ static irqreturn_t prq_event_thread(int irq, void *d=
)
>  	return IRQ_RETVAL(handled);
>  }
>=20
> -struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct
> *mm)
> -{
> -	struct intel_iommu *iommu =3D device_to_iommu(dev, NULL, NULL);
> -	struct iommu_sva *sva;
> -	int ret;
> -
> -	mutex_lock(&pasid_mutex);
> -	ret =3D intel_svm_alloc_pasid(dev, mm);
> -	if (ret) {
> -		mutex_unlock(&pasid_mutex);
> -		return ERR_PTR(ret);
> -	}
> -
> -	sva =3D intel_svm_bind_mm(iommu, dev, mm->pasid, mm);
> -	mutex_unlock(&pasid_mutex);
> -
> -	return sva;
> -}
> -
> -void intel_svm_unbind(struct iommu_sva *sva)
> -{
> -	struct intel_svm_dev *sdev =3D to_intel_svm_dev(sva);
> -
> -	mutex_lock(&pasid_mutex);
> -	intel_svm_unbind_mm(sdev->dev, sdev->pasid);
> -	mutex_unlock(&pasid_mutex);
> -}
> -
> -u32 intel_svm_get_pasid(struct iommu_sva *sva)
> -{
> -	struct intel_svm_dev *sdev;
> -	u32 pasid;
> -
> -	mutex_lock(&pasid_mutex);
> -	sdev =3D to_intel_svm_dev(sva);
> -	pasid =3D sdev->pasid;
> -	mutex_unlock(&pasid_mutex);
> -
> -	return pasid;
> -}
> -
>  int intel_svm_page_response(struct device *dev,
>  			    struct iommu_fault_event *evt,
>  			    struct iommu_page_response *msg)
> --
> 2.25.1

