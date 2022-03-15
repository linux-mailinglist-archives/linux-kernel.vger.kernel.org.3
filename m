Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9924D98D3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347136AbiCOKe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347130AbiCOKeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:34:25 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCF06549
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 03:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647340392; x=1678876392;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HRY5KaTvOKbOc9yQZu6SSdEGi4Jg5eBaf81lm5PgVQM=;
  b=gOnyhx2+8/hJMckCtknAw0IAJtmBeU1SPhKd0JCUzU4DiDJw6KJ/RCnS
   X4PRYi6LjaoOXZf9Kcx3iGnNc8BATgnXFIvrIzyeph6hy8eN/N5ILPCxj
   Ki4IowhUUWUXg9wxLqj3nozouWTg9INgsz1c8TUsjnkkvBRSGxF1yGXFA
   AjiJSQGyYgz/2wovfFbff7UCJHEVZ0itZzvzKbtGrIW5Gm5w1Sq5/4t50
   wSwuUezM8sSQgy7aT3lBsFwnzKPJXSIIH1fM8vgjyXqug4CzWVVxSC9DV
   Rvcxj7rDDWoNpmwwtfyHCH/AHSOplOmluvsvXzZ0a5WGj0KRwkrSlF/kJ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="236212532"
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="236212532"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 03:33:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="644211463"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga002.fm.intel.com with ESMTP; 15 Mar 2022 03:33:11 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 03:33:11 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 03:33:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Tue, 15 Mar 2022 03:33:11 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Tue, 15 Mar 2022 03:33:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvksQsBgFSoxDRqAAuS2ct0JSln8fTwShf2UgnRCuX7aFQ12quNC8GY3rz2l+kFJNDFC3jM3Xw4LzyStop18eu8VKnMR0abRqFmV2g5131TNH1kKTUnU243dY1iIK1QDUr3FZmvobIaB2M3euLRi34wAbNLw1W5ipUuYomQl7EZL4IFDsew2ve1cCQV7LwnsnqZfuohASQXN4sQjeoRTtlf83PoQUgFueQkK+9uVjFXMaSoFUFOlvFOGAXgaydvFsfCi4jxcQthPwtqgTv3mB3zruwbNAtSgnhFNrogPcH1yXQ9NsZWUsbjBHu0kGHDc0BGw33zn9mdKc/KML28ZIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wvib42Np+Xwlf8RaSfKuxnC9nDkSI8rysRw+uNTq7Ic=;
 b=lDI0ovEEWMJJwQn7MK5Sb268nji939eCfSfWKIxwRxfN6379GALBuPbhoKi5cF8c4jDm+jy27Pqu671ZlYyB4aI6posQgBnF701wBIElt5NYi4vknd1YOiS2bjbc0/CPF47hCaSXyC/FhJKw0wF7RZTHp7BFMN1025z3u6wramu5Ln7Dm7KplW+4Py4V8R6D8iewEx01E1rAjjDXnW6ys3c9YFfiu1rIWwa3J38+FVWQ7gpYqTj7K0MI9bSQj+cXbXMiDw2EPAvQg9TCQhtG7tezM2ftHIzh+CMHu4oHKgBdvN/ay3sKetGMykUbgVtY9wjazDEkCcfQw+sdQAudfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN6PR11MB1873.namprd11.prod.outlook.com (2603:10b6:404:106::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 15 Mar
 2022 10:33:08 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c8aa:b5b2:dc34:e893]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c8aa:b5b2:dc34:e893%8]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 10:33:08 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
CC:     "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 3/8] iommu/vt-d: Implement device_pasid domain attach
 ops
Thread-Topic: [PATCH v2 3/8] iommu/vt-d: Implement device_pasid domain attach
 ops
Thread-Index: AQHYOCoddoPAbs8qR0GMuSnaaH7P9KzAPgkw
Date:   Tue, 15 Mar 2022 10:33:08 +0000
Message-ID: <BN9PR11MB52768A46ED515D2E02FFEF5D8C109@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-4-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20220315050713.2000518-4-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a67615b-f505-4125-68d1-08da066f327c
x-ms-traffictypediagnostic: BN6PR11MB1873:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <BN6PR11MB1873451F4AF4F5FAD2FFA43F8C109@BN6PR11MB1873.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AWI74FyFbHiQZ4gzh0SAdyaggtZojIpKs6uHNcf4upKBzAzrB81C47IX3J1Qu8DHfKVMGkrOnyCtQgAgoGFuDEev9cHf5E/OIg2rFwo/egm2SPICFcebUytancrMMbJHzOozwqS5DCGx+OT7z8z3rbo7Q3GDhfc0qRiDkmgK/IVzpmZIIwYlHqwzWf/jeu5BuGcjZ46+zfbpURdA8NbtteLyTFjd9qP0lqKODMvFV157iUzfVUp2TFAxItJYZ5TPJE3t/R/+E0rvraQKyurKq+CUubGF5WBm0gEopoEgPOmsqxyqFBNYsJzA/iT30V29BGAWLEav8qH1xNzEZ7yZR5eLhD/wNmD2bTV17YS86p7SYiPIWPL2brxDYAQuYI0iizDJ/B1ZzpUP+XTazYkSnfxCCes3sLjyH5l9eDZBlzYNiEIACbWXZDdCTF7d6fO011Xm9fT7uHokWgQcNMQohBTSzQV29PBMwLtUA3oXsbzdyaLJXgVwHHJ1AvA3Zj3gHnv1OaWrDzJfzpBVm0Fk0IF8AjVYpSDvd4QZkCneIYTxf6CUxIKxIMxF6IQyR/Y5Ta7MzDm1FpXSb+f/rG9jYkdjUeu4t95d0NhRNZzrzdbUhxJ+YLsRyFs2yVD6/ycgUJZWviK1rYBWofgQASTWwlK8835dDlpxEDuNC/pX4RMwh91o3tizhvzP6uWhAN8VUs2Vp7I3E7rs+NGGZ3I3bw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66556008)(2906002)(8936002)(66446008)(66476007)(55016003)(64756008)(86362001)(6506007)(7696005)(9686003)(508600001)(76116006)(82960400001)(122000001)(38100700002)(71200400001)(110136005)(33656002)(5660300002)(83380400001)(186003)(26005)(38070700005)(8676002)(4326008)(52536014)(316002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VN48KfmfN+5iU9xgOwgVEnldgjAr/kYGIBtb1r9/vTDnVawEYxyYer0v8ZCd?=
 =?us-ascii?Q?ackJMmfgyL6DA8IX5+pZaaoFkGx4yAz/d4EdfMHxtAiv4mTUnIxT2zG8K6qQ?=
 =?us-ascii?Q?fimPKx2KWbCgDWxaAVOTd2ph4y4jiM6REcJSmXaKQ5Cvv8shT/ZdEiiAhjXb?=
 =?us-ascii?Q?7t7BFnmpMinlvE40riHdNhyvLEaZGcxyE3CiHGFfybIjU77rCqi/x0nQ3XzJ?=
 =?us-ascii?Q?B9taDlMq4ZJ4wLbvZl+YK5+UOvvn976OmlZrudGJKuRvlwOTqPO8XOt6q3ck?=
 =?us-ascii?Q?DrO3BVpDNXvo7xSmx+3uzrkOaQC2dxRMR5XLp0BfTkxTf7w79qQwJnjke3+I?=
 =?us-ascii?Q?h2mrg3UL6dwIixggz9xgKzsmWxlLzEifUA9718xvMecrOqgmhzw41upEmo8d?=
 =?us-ascii?Q?eZqyELZyK2pvKn6RHs/fbSlG0kIrvyXzL6Wp1iUoJk9Bo3nG6IsdZ2SbHicI?=
 =?us-ascii?Q?bDiCkitz39f4Jdj7TP6Jv7JwwX28q+VAcAuO/9+rdHpcMWUZxngPdsxGFxyL?=
 =?us-ascii?Q?TRCmvTZPArO1lSl1DYoI9QIxYjt9Ud1vbUsBUlc2XxQVMb72SGg1sT86lsR1?=
 =?us-ascii?Q?sCZZ8i2VWVsdrM7eW+Zn0ITv78cM1AmyMEpTH7GmQ51PzqoUEiYmKtRdQYtR?=
 =?us-ascii?Q?ln94fgqufJhzc+02eEhYVE99V+lyBFppq8JJOK9W+sKz+ivd/kvmbSpRmJmw?=
 =?us-ascii?Q?Qy4tRhZZYKfNBlnJVsIUFOGoVAMeqr72UxBqxOiMoch9jRlyETZFKd6vFxpY?=
 =?us-ascii?Q?DnJUeK29pwzuuVgJ5LK2qe8TH3gcs6evupsiRfLHv3AQeIH1L3krcMaLt5Xs?=
 =?us-ascii?Q?a42DugqBJHE6UwRtlBlsrMNoX+j0t3LICjoiCZARAi8LK+GJ6nUYz7/J31JM?=
 =?us-ascii?Q?Q5rMMEBI6Wz1ztEpiyIaoVUAR4Eiz8v27DwTvCjd89YsLB9j+q/SJyoN1L+T?=
 =?us-ascii?Q?7LAYHGCt90x3TH5H/4cP5lNJoOGAzPx8GgfXHkgjXqGQtrwyWnmzdHuxSwlL?=
 =?us-ascii?Q?OxLawa+r/OfUxnlURBKNGO2Y69OI5YhuOmQuwtisgqBa/QaJhNuBxRmIEN6+?=
 =?us-ascii?Q?V9ufwWk1rwL8+rfgHShc5+sij+r3EgL/nsmTt2xHHwW3naTBz/ku04SfPtY7?=
 =?us-ascii?Q?iq4IHV7h5m5hZABsEa6KXyuWZV3TKzqPtEI9JicauwznNR4zry2g/Kb1/0aa?=
 =?us-ascii?Q?Ppc7CIDAFiam1hsU+nL2ESsDClfQiq+5A0XhoKu8aFZ12VvPizqu26yBxDyI?=
 =?us-ascii?Q?yP0QJexBQ7a3z9GNCO4UpLarmy/7tXu8n5gZHM7pzhd1dx9D/upyYtgUUmxT?=
 =?us-ascii?Q?rFR1xDQCdmc4kMVonXyK2I/jnUEi2cYKV42MXYowEY20y91NrMbCW2T6mmv2?=
 =?us-ascii?Q?7U1ygHlp3eUJlCZ+UlAGyG6YqJ+rINJyoJxg40VN1V7uYmin9MsEfSwd6wvL?=
 =?us-ascii?Q?WboiHLRfofI9s+PIjgU5bK5LdD2LuKvW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a67615b-f505-4125-68d1-08da066f327c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 10:33:08.3872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i7OEx9BNLmjYVzaeIIxWGB9J1/ldkMyt6/mHrCyAps0BtXKQlkA7Chu9xzIHYZ268+7drRh2Zz1mxIyOx4G2yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1873
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Tuesday, March 15, 2022 1:07 PM
>=20
> On VT-d platforms with scalable mode enabled, devices issue DMA requests
> with PASID need to attach to the correct IOMMU domains.
> The attach operation involves the following:
> - programming the PASID into device's PASID table
> - tracking device domain and the PASID relationship
> - managing IOTLB and device TLB invalidations
>=20
> This patch extends DMAR domain and device domain info with xarrays to
> track per domain and per device PASIDs.  It provides the flexibility to
> be used beyond DMA API PASID support.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 194
> +++++++++++++++++++++++++++++++++++-
>  include/linux/intel-iommu.h |  12 ++-
>  2 files changed, 202 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 881f8361eca2..9267194eaed3 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1622,20 +1622,48 @@ static void __iommu_flush_dev_iotlb(struct
> device_domain_info *info,
>  			   qdep, addr, mask);
>  }
>=20
> +static void __iommu_flush_dev_piotlb(struct device_domain_info *info,

piotlb is confusing, better be:

	__iommu_flush_dev_iotlb_pasid()

> +					u64 address,
> +				     ioasid_t pasid, unsigned int mask)
> +{
> +	u16 sid, qdep;
> +
> +	if (!info || !info->ats_enabled)
> +		return;
> +
> +	sid =3D info->bus << 8 | info->devfn;
> +	qdep =3D info->ats_qdep;
> +	qi_flush_dev_iotlb_pasid(info->iommu, sid, info->pfsid,
> +				 pasid, qdep, address, mask);
> +}
> +
>  static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
>  				  u64 addr, unsigned mask)
>  {
>  	unsigned long flags;
>  	struct device_domain_info *info;
>  	struct subdev_domain_info *sinfo;
> +	unsigned long pasid;
> +	struct pasid_info *pinfo;
>=20
>  	if (!domain->has_iotlb_device)
>  		return;
>=20
>  	spin_lock_irqsave(&device_domain_lock, flags);
> -	list_for_each_entry(info, &domain->devices, link)
> -		__iommu_flush_dev_iotlb(info, addr, mask);
> -
> +	list_for_each_entry(info, &domain->devices, link) {
> +		/*
> +		 * We cannot use PASID based devTLB invalidation on
> RID2PASID
> +		 * Device does not understand RID2PASID/0. This is different

Lack of a conjunction word between 'RID2PASID' and 'Device'.

and what is RID2PASID/0? It would be clearer to point out that RID2PASID
is visible only within the iommu to mark out requests without PASID,=20
thus this PASID value should never be sent to the device side.

> +		 * than IOTLB invalidation where RID2PASID is also used for
> +		 * tagging.

Then it would be obvious because IOTLB is iommu internal agent thus takes=20
use of RID2PASID for tagging.

> +		 */
> +		xa_for_each(&info->pasids, pasid, pinfo) {
> +			if (!pasid)

this should be compared to PASID_RID2PASID (though it's zero today).

> +				__iommu_flush_dev_iotlb(info, addr, mask);
> +			else
> +				__iommu_flush_dev_piotlb(info, addr, pasid,
> mask);
> +		}
> +	}
>  	list_for_each_entry(sinfo, &domain->subdevices, link_domain) {
>  		info =3D get_domain_info(sinfo->pdev);
>  		__iommu_flush_dev_iotlb(info, addr, mask);

Thanks
Kevin
