Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D83455DD0F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbiF0KOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 06:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbiF0KOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 06:14:31 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72146433
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 03:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656324869; x=1687860869;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MadHbI8B33u3chNPruPqUdCr7o5UXB2Kd9mogTTBAZE=;
  b=cBimU8oDiNuL3BU8Lb1+kTF0hJngGevLWrskdJYuLNbqXile4oEozu8G
   RwYx5ul32X6hHsdzoYcwhO0ko3YQCyKIxdcBJ2UyvUg3w4gqpPe576Fuk
   3Q6lNE++qtxVYkakaT+a5E9V/R4m0Ug1Yfz5hjqTi4P93CptCrCOIBVID
   OexJr84BAUGKd7asCTc4kIn2kSKuT5IQR2Yig+gQK638Ah5w4rDUhLSha
   aTSCqWDWyT099SW7oP1wzwZ5ivtEMJnS/1+nAXSaXJOCG74MfcBb5X8io
   QS0fNpHGNX0101O/KHoYTIN7qPJ8NzkA65clS5LGWpeJcYn1716r+xKm0
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="261830289"
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="261830289"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 03:14:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="564596975"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga006.jf.intel.com with ESMTP; 27 Jun 2022 03:14:29 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 27 Jun 2022 03:14:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 27 Jun 2022 03:14:28 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 27 Jun 2022 03:14:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ldaju6rPYd5S9RjvTD+zKTe+s3nlUlFCdW39EXtKMcMni3OC3Edua8kIyRXQHtIxyMeNTJ70bhbH7TCqSmMXLbjPLU21mdOh2EOyNoCSK3fM/nZfKdChVCZ6xt0mXjghnrO73fKigwFywzCNod8a5NWX4SP+qCSmGYZ115LcEYf4UUwWjUr3RSVXw8IAzauYGg1AprRn2o+KFGa+CFD8lZfRnNZwyr5ZCYVNluYj+R/dwp2k7xG3X8X9Omz7W15S7uA+L8j7TnvRybSp/xxADw2hTO+QStxa/WPF7p/g+Mt0o8qoZT4/RUt8WP8aH+wSprXScwj6fQu425z3/XY0gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlsNWbWmFf1nQMnS0Bopa6ZasLU9oLT/FzckOyWLV48=;
 b=lbi/jyaKWvxFUNIXfZRM13EDzi+ViATwZEQIXaK9uYPceMmjy+qLalqdzWA1tItRosSrKHkVmoc2s6PFkXrq9iG5pRGTeSpBHkxjNCdT8az6W9ux3b1rTHxbrAnLbe/OAT409rPmqFuT7geCfWMas7PjHZIXH/Q6DSLsbBkTbeUWU5bbp0GRMeLsgyrV/ETkMM6679TpHDwPpQ1gQm5wR/c0QuEEnowLRtZq7bSsamFDaJd4GKuNUyDlaTHovbMMjO3WJ3MenuimRSp1j/cSCUcDmoopOneHKXts4fsA8sjEpM7MFuy7S9nM5gY25nXTfhlMAHBVcV/wpDNxVrQJmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB4611.namprd11.prod.outlook.com (2603:10b6:5:2a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Mon, 27 Jun
 2022 10:14:27 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 10:14:27 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
CC:     Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v9 07/11] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Thread-Topic: [PATCH v9 07/11] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Thread-Index: AQHYhX4BFOtH7b1yFE6Yv4ZQbmv7RK1jDeug
Date:   Mon, 27 Jun 2022 10:14:27 +0000
Message-ID: <BN9PR11MB5276297FAEB8C9774AABAD208CB99@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-8-baolu.lu@linux.intel.com>
In-Reply-To: <20220621144353.17547-8-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00fb832a-6b4f-4eaf-0ef4-08da5825d145
x-ms-traffictypediagnostic: DM6PR11MB4611:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X/TuAj5y4JzJ8s/6Y+W19xL38Sk4FxXst+MggRINEmpc0RVarj0j9FxBVqqHRC4uir3qtHuU7i/S3/cnXe8e0YOrbJ2FLM9roJLG23e9bs10KZQyHFqA5vaZXsPkcdb0GLDeQoKTswLT/jNQtqmFVmF6kGlaxODSBVzUj0PmI/MiItyGUKqso6brk2WM912HOJc4Q/Q05x8Uvqb3WWe76WVpY/3WgN78M4sZw49wXX6fp/DbL5dPNLGj47kocvHf0iyvjQT9MGGm5jtF0mAqttlAzt+w89hQlkDY1c4Hpidjz/rwgfFUuAlg8kfcVO/7NRgI6DZ7aznt3+x7u3w7yk+kW6R1EdK9UFZ/INukV4oEhKahhmPr0N0XlLuHMSNjXxEnSZX+r/td9jwarIei7cEHg3UUruPqcSJFcf8voFmZR8NnriHk8BuL19kcZLxSneToaSm58hkGkUzFyyQZfOb8vwJXrvvTUxmkdF1r469xHwkFYTBwA23IcOy6sYHZgLVIhe5VkIk8X6sMH5r+fMQ8+3nGTFenmZ7vHiZLV+WNhS/rvqTc+Nrv7rp6K/jrcqWQGFzMGbpS6ULHX6Zy4cgm4KMtgGcaqbaFihTXI5vQBoYWrwhNk//4BVazm+Heif0dWzVW4OR/J0mXVZIP8yQ4Ii4fXqoCKSBZtnA3PfFRpMSzT0EtjNHzvJ3nMDFvyzKh+tVwunfZmm+CXIOOcvyy6nluDSXuGWu5Hg/AXW/Vgf40orykstK6DGj3BDJntr5EEygnC68HoAIGeQfPNsTOjJVevywPHbE6N6ZKAu8zX50JtAKp2t85Nz37+4s7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(346002)(39860400002)(376002)(366004)(5660300002)(66946007)(110136005)(9686003)(83380400001)(478600001)(921005)(38070700005)(7416002)(52536014)(33656002)(7696005)(86362001)(26005)(8936002)(4326008)(55016003)(41300700001)(8676002)(186003)(76116006)(66446008)(66476007)(64756008)(82960400001)(38100700002)(66556008)(71200400001)(316002)(2906002)(122000001)(54906003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1lBrLXCZeFxAgxYSaVw/ObjMJCK2K74E7WKvqvgiOsyGEFk/lxBevqiSJofb?=
 =?us-ascii?Q?8ipKZxDMR2RHIJELKKBZwvi1CtaYZeDf8hR00aGuCm1NtIjyH3qCbJLBYF2V?=
 =?us-ascii?Q?V1pX8knnh9GIp6F+i5d4qFLLh6bng5XrzXJgYn/0U/3n0L0oVmZEB3br+Lzh?=
 =?us-ascii?Q?jQaoK091hcVoh7g8u6Mpn02HpsisKgFKclpZwtb0MS0obnZO23xNMhXafM12?=
 =?us-ascii?Q?LWXKcKAUWZ69E7M8WNfCFAtTmEYDFWfbIbh1wUZvKLlhwG9/YvPEvGP1hBRy?=
 =?us-ascii?Q?Lapy/NaC6w0b306FW6O1XqADUT5vnIDv6gvXSMeHPG5tHSgDrrCAGVuDwZtE?=
 =?us-ascii?Q?NP0DOeZQoeUhAnaTec8HnSoI+ybjSIcik4xmMpm/x/CGz6CZHBXehx1Fgnd6?=
 =?us-ascii?Q?Cq5+/UbZF8kKDxQQelYRh0Z69m5G/6bSQBkEGiuCpI13GQQFUZm/ltP+uw9u?=
 =?us-ascii?Q?9Q+pPCrqr/jbzvxWjTZtHhmu2EvIFpXWWSBVdF8RzFqZuMigEgXIX2bluu6o?=
 =?us-ascii?Q?5ID7lYmE6DuHe+oMcWfEB/Juu06icYngftjxB1GiQL4TGHbl5nSL7nTLpj5R?=
 =?us-ascii?Q?WFxCqi2HH5hh39w36gthFskIy94OEIhIJ6du26oa7hDYl6nB9tjTxjjDSU48?=
 =?us-ascii?Q?TvJtb9ILP/j07jS+KcgKt6sGO4ojT58qpFmI/IY/0pT7GAuUUuwAc/DjYEa/?=
 =?us-ascii?Q?28eIRItpwjQDpLqp9GILVggWy8Xp/gCTxlBwd58vMbUVZpfL0iTlRy92CfLR?=
 =?us-ascii?Q?IzvCdOdxJ+SxoEI9VorNHU2AXjsfNaqvqGl2bJdPyTVMGccTNrIpZnbcz7F1?=
 =?us-ascii?Q?IzN0u2KoGaMLqMK5RKnegY2SauvW8FE89Z4Rp8tN6aXcDlGYdTRYUlPTTN0u?=
 =?us-ascii?Q?tIN2K9oRaTrNuqUOOYHuomT8ti8k+fAd3FgE9PTVV8cPBRlp0I6ADaOmR0eR?=
 =?us-ascii?Q?C5NEMMsFXiq3k87nm2Wk+qAKJRgrDA+FUus3hwTsMGDr2acUH+89/5fwrGVh?=
 =?us-ascii?Q?+1pDNFZch9HungrF2LfltrjVzYvunYwiv0/wG3Jgz5t6avlnmcBGL+/thLcD?=
 =?us-ascii?Q?ozRWcav34831Ts80e+qVYetKnuSUZXkQcS//3G1BsBv//vJYUiDKEZKwreMP?=
 =?us-ascii?Q?ClKP6YCiu6mo22OPFdQsWz4fEfg49+pINmb4LnUIfBfOlmMlGprMbU4Xn/ZG?=
 =?us-ascii?Q?4HE8udRLcsy22hHEx/heeo8PMZIafk//sD7vuIQ7Vax+288+PKZNVi4LzlN2?=
 =?us-ascii?Q?kdx3c4q0cUqFflWFJOG9dtYLABfRVbBs/JmmiLR47/DVpN/H+cQWKZ+VoAJb?=
 =?us-ascii?Q?DiiE6O4gF5fr/OwuXUMa1/B+4wUJ/ccWeBbUohCDdOB4L3zOlB6VHKYvIauT?=
 =?us-ascii?Q?FUMZXFGU9cROkuWGh0VIHXwJfzfacAuNbqB/sX2XytCNgWzTEt4w51r8Ibal?=
 =?us-ascii?Q?WbPqk5Z9tfC99rOxXgS6zorm4gRMzS8fj6buAZSJ3KgKLIAD3QUGXXjigF0f?=
 =?us-ascii?Q?F6ufcpHTYvMlWp3+TLfWTL3E0N0RV+UiSozosqR7H9VKznLhzotmy+a3vtA3?=
 =?us-ascii?Q?JthAYqNcY7Ayx7SRa85tZcLWaeMNsN1c89ow25af?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00fb832a-6b4f-4eaf-0ef4-08da5825d145
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 10:14:27.4032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y54qXgbFG1N0CizHx8TDU859Nwp32jjaQ28eCN0s8gWvuyQf4sbre04Tu4zAiJQefoJf7JZgb+YRrSus1XnmcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4611
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, June 21, 2022 10:44 PM
> +struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct
> mm_struct *mm)
> +{
> +	struct iommu_domain *domain;
> +	ioasid_t max_pasids;
> +	int ret =3D -EINVAL;
> +
> +	/* Allocate mm->pasid if necessary. */

this comment is for iommu_sva_alloc_pasid()

> +	max_pasids =3D dev->iommu->max_pasids;
> +	if (!max_pasids)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	ret =3D iommu_sva_alloc_pasid(mm, 1, max_pasids - 1);
> +	if (ret)
> +		return ERR_PTR(ret);
> +


...
> +void iommu_sva_unbind_device(struct iommu_sva *handle)
> +{
> +	struct device *dev =3D handle->dev;
> +	struct iommu_domain *domain =3D
> +			container_of(handle, struct iommu_domain, bond);
> +	ioasid_t pasid =3D iommu_sva_get_pasid(handle);
> +
> +	mutex_lock(&iommu_sva_lock);
> +	if (refcount_dec_and_test(&domain->bond.users)) {
> +		iommu_detach_device_pasid(domain, dev, pasid);
> +		iommu_domain_free(domain);
> +	}
> +	mutex_unlock(&iommu_sva_lock);
> +}
> +EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
> +
> +u32 iommu_sva_get_pasid(struct iommu_sva *handle)
> +{
> +	struct iommu_domain *domain =3D
> +			container_of(handle, struct iommu_domain, bond);
> +
> +	return domain->mm->pasid;
> +}
> +EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);

Looks this is only used by unbind_device. Just open code it.
