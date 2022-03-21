Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45A24E2187
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 08:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344977AbiCUHrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 03:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344917AbiCUHrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 03:47:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E97D580D7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 00:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647848742; x=1679384742;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9M5u2Nzqdaa8v+eRXV54sj2YqF3ap2YHzV+OmJwVI40=;
  b=YPofP/zseAUSKdZPTZovzfcGl87PtFI4/PSnJMYsjICdYyxCnIvNkJeu
   4J9LeqyokofcLxsoqHxFSFYvqEz20DAORrc1HOStlBQ/yMmkZCVdzjqYw
   CUJpD/4l2o7TaSI7/A3jSfcbZrZZTZSKOhSoQQ1gO021dTqvFX2953EwQ
   qLqm/KLwr0Qyrl6ygzkEAI8CKDPY58R7IgcgQNO8TgPUDbvXL+JrEtuac
   Mt/w9G9tEj9J/X/wGXekf9t1H6jmHCdgEmWhJz0Mq9MJU5s8O8r1zlfFE
   0fNd0PTSHehTq7SAvz5GqRk3rveHJf0okhatIXJ09vuNEctKURAEi1PQ0
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="343920168"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="343920168"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 00:45:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="582774556"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga001.jf.intel.com with ESMTP; 21 Mar 2022 00:45:27 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Mar 2022 00:45:27 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 21 Mar 2022 00:45:27 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Mon, 21 Mar 2022 00:45:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZJRh9hjIthVpKR5l4lGq3p1faE66/sJGwrDgsbAfgCEKyeNBMF68wfArDvWzpyS/6YZBRJUUb9S9Kw+dd1UQoE1RPoO0uN82yGKFP83PgvGcj3ap9+fKjBEcWrz5gryyCUJTwIHsBNcnZ4SP75hA4n054l2BYXPSsI7GazyyUZCAtp/fTWw+lGEKaQc1atoLrloCp9I1pyn4bp+Sibinh3EI99LFfeSUKNNBeu0Ppo19Ae6wqqRfL5ecCO7XMbMYAxEqlcM/mG2KsJhYj1rwOQvP8PhC6dsh4cofDjO7qQnSTFF9UEA4noeLncqIaPw/CgmhWP8q5xOObSQL7THxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QR+iW/yEWOBIx7qxyoIiTGesm0M+oVaK5xd2wA2bPsE=;
 b=VH7EDIiAshTUtpCVD3sMGBNuQ+30xskpALUrFnbXF1+zRMPmf9B4qmyvcTD1E6JjHUu01BYKduSTYS6ToUh0tFsjH6OeGVJoxe6wjIGlIPTilfwbvRK9Hvp/nUICgwoSPk+LBBCPRyoH39FVKBNw5mlqtHUVLwEsQWL6t7xlIiZDFAaEwMliH6Y/QXN5cX4DRrxUDMZmMPFWfUnKPRLVLKPhkX4QFTqcO9wm6W9RTPNVmjhykcYWDYbldMF1dOcWkYojAHx9mm0d0XI6mtZEZHQ5u8iR8AarV/hrN04OISx2WJuAh9DOvjQioi4GSIBHUKvZL08WtYZN8gtUZRspzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by BN6PR11MB1409.namprd11.prod.outlook.com (2603:10b6:404:46::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Mon, 21 Mar
 2022 07:45:23 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::b9cf:9108:ae17:5f96]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::b9cf:9108:ae17:5f96%3]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 07:45:23 +0000
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
Subject: RE: [PATCH RFC 04/11] iommu/vt-d: Add SVA domain support
Thread-Topic: [PATCH RFC 04/11] iommu/vt-d: Add SVA domain support
Thread-Index: AQHYPCW7n3yyOb6EL0eBNiWvmN63fazJdDLA
Date:   Mon, 21 Mar 2022 07:45:23 +0000
Message-ID: <BL1PR11MB527146393985BC3EE2EAF7648C169@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-5-baolu.lu@linux.intel.com>
In-Reply-To: <20220320064030.2936936-5-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f03d9ba-c183-4035-e42d-08da0b0ec1bc
x-ms-traffictypediagnostic: BN6PR11MB1409:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB1409FA02F3F8DC31D8F527488C169@BN6PR11MB1409.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cYHq6AaqfbUkm/8HeDh3kta2lmdUoCX4YoCtrNQ4mU3WdBn1evt7I4xoV+wsRDZFa+NMIG36Z4arSlxAonxkHVqr//1/3HqbOMKYThDLSuBMcZuNtdqCfo0d1Axl/dLp+WQpJw5vu6Gq/PlXYsu/LSGlgJ26zDeqpFn1mDL9p5p7+8ryDtAiNYPhbNfsxaYRpzTJ7ZN9e5SP9h5AiflxjprXM0ytPx3EuJXwQ6/QCft7ERcmUrOkD2J9ganAwPPhkTm0bUVSKPHyecHJLZPbCnCHQ7bEGDo/D/uktUgR4s53F3iR5qH7l0GhdzTYHAey4O3CAHZTeucp17wGtAHHIqfUNgwzyPVlXF99tCbG0oYoYuRchcgo+cLfnWdORyZ89nxwo87QpJ1gPX7+/IxKDmp0FrdtSBaMkSTeB5JRfox5gnj2eT5Aovh6h1xOwSXLUT7KiXkAIqC7MpY1aWlG6rEFl+vnbro9oPyUeUGoA+TJ2GETsoDKZeI6shFRc/q+k1vxjrV4IXzr6FujtrE6d6JJm3mYePE8cplfhTnzz7N0HRTTClswNapSbsMWSHSuOwg9zWKOZSRun70FfFVQ9zW0wOwnrxhk9MXxBil+kT4qnvjrHN8ica2/670tzioROI5Xz/g9nTgyiUNw4wR42p1WZxnvlOWbN7DaC8TBmXw9uiddSdImUFwLyP3e4l9BgwIIBZnXD/YuWvne50HOsA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(38070700005)(2906002)(86362001)(5660300002)(122000001)(6506007)(7696005)(9686003)(7416002)(52536014)(8936002)(82960400001)(316002)(38100700002)(54906003)(71200400001)(33656002)(110136005)(66946007)(508600001)(66476007)(66556008)(64756008)(66446008)(186003)(26005)(76116006)(55016003)(8676002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gDHM4pLuNYSKCrzE09WCwP7Pb2tNPr94sUBWZTluzSyrnxJ9ZquVQDS08a80?=
 =?us-ascii?Q?pBpvIsulpb3H8sjWmmyALx0ifjRRF9vJJc/OpQqVdRv8Bx8L5A9FF7kY6n1J?=
 =?us-ascii?Q?3zyK48iJAUyukmoZXsHtr/i9XjUawiJWdsrLHepiJmyvpQZ+K4xuwFr6OhnQ?=
 =?us-ascii?Q?GiAWH45+5V52IY3Y4IaCMjSzhxQo2/K+1JciI4t3w8Gv8nsdfTrmtC1rSIUz?=
 =?us-ascii?Q?DQtJ3CRDwevWYzgl5qvfBA8Aobs6+4XLXyGNx1EW7SUGy+DdH9wXF6bbq41w?=
 =?us-ascii?Q?drZIi9B+3s3HEgV12qjy5ppY/w8Cp7C+lMetkJ8pPE/6JLInCSlNNAv40oQl?=
 =?us-ascii?Q?vwLDh6cViz2fcvFTbSEaieMqnMAHbACxUO3pqGqPhDQJcw3vxJeIqNlD9fpd?=
 =?us-ascii?Q?bOE+SBOstqzKQfNzbPOTgzkM0IBAlEPUnLTj78DsgR3bSXmgU1Ebud8tivt0?=
 =?us-ascii?Q?k+3ISjoURE9khmjxqTZN747nr7IkYIvPZ8+G4LMpHmaRkfbTHViZpFPWDUku?=
 =?us-ascii?Q?wtaBUxcJR0SSfqATMlWDvl9ySpw5yK4+uNEfKz1l/nADScVkYYAbJ1f3mCsn?=
 =?us-ascii?Q?2ml9Wc3OVZi4ipn1Mvd+W8+mfqXmhOZfif75xendfCi0wUNO3J7ocr/iNxge?=
 =?us-ascii?Q?8lmtpHvukZAI/7WDYQJRwiE4Z33bUWKOw/VeDEQ2UTqg2c9rk8TGt4B3uaq1?=
 =?us-ascii?Q?2zzetHvTjaI5joOVvt0cJlPMWW3BNKawTQnll9GddmANvhCtVZf0ORb3XhZd?=
 =?us-ascii?Q?5XUOtivuifaz4bAvZ1b9K67sL/q0svqP0Ky5MkUwBG/pWeoYSxqflUN0pn1v?=
 =?us-ascii?Q?w649h+P/VrTVdLokHW0uLQajrtwGVLkTuNrTn5GjgK/txCpilaDau/LXPp/D?=
 =?us-ascii?Q?voZok4saGMp5/q6CUuOJc3cZf5VZ/M+M5YpX4QsH3+aMumRYh5Gfeq3TqUBz?=
 =?us-ascii?Q?hZxCfmnHAbZcG1F6KGvcuAMw2PCLZv7HtBQO4+pk0bY2tkpM0DUug9vZ7EcH?=
 =?us-ascii?Q?9vda8SW55hUf5kU76DdoVkMgxM6wKcWKaupk7q9aUnmdV8Z5l5IhJwUQcG/T?=
 =?us-ascii?Q?w/3EXmKfFbaqziayLRr/5qGip9jknG09ydWt+oF41Ks+Yz8VIAP+npkLeJad?=
 =?us-ascii?Q?xIdSnexyeuakKlAxdWJddUPA60iH0sLdR4LJz5HSmy+dCyFmJdJsnTr+SYsl?=
 =?us-ascii?Q?2hpTT1x8ylxXcTQl9R2DFBMxq8L1J0wnYeUbXPX6yzbBT0KatiiFRcdCZGty?=
 =?us-ascii?Q?LnORgn161e3vmOxU436zcR7yIVGJynmq8ymBORy6hz1xuYt8bwAWHsldUaEl?=
 =?us-ascii?Q?e+WpBpbycVq5nJQbKam5sxd0eVSjUJ9VS4mYQ0aDIqIgy0zdOHYI8FveMSjY?=
 =?us-ascii?Q?qWMDxUipyRSMi3Y5uGMoXxskUsE2wPf0euwJ9W5GUV1oCUa/xUqWsr8MyMjI?=
 =?us-ascii?Q?YNKIeUyVuvtscU74jKKKpQFD/wN5laws?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f03d9ba-c183-4035-e42d-08da0b0ec1bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2022 07:45:23.3538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZyIgL2d+7TTKJqOTfKaZSDeH2zwJxyv9IAjYmgC1WJYbry85Z151guBHmcdHuvWkkiew3o5ZYblJJsUIxjNjjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1409
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Sunday, March 20, 2022 2:40 PM
>=20
> Add support for SVA domain allocation and provide an SVA-specific
> iommu_domain_ops.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/intel-iommu.h |  1 +
>  drivers/iommu/intel/iommu.c | 12 ++++++++++++
>  drivers/iommu/intel/svm.c   | 34 ++++++++++++++++++++++++++++++++++
>  3 files changed, 47 insertions(+)
>=20
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 2f9891cb3d00..c14283137fb5 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -744,6 +744,7 @@ void intel_svm_unbind(struct iommu_sva *handle);
>  u32 intel_svm_get_pasid(struct iommu_sva *handle);
>  int intel_svm_page_response(struct device *dev, struct iommu_fault_event
> *evt,
>  			    struct iommu_page_response *msg);
> +extern const struct iommu_domain_ops intel_svm_domain_ops;
>=20
>  struct intel_svm_dev {
>  	struct list_head list;
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index c1b91bce1530..d55dca3eacf8 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4318,6 +4318,18 @@ static struct iommu_domain
> *intel_iommu_domain_alloc(unsigned type)
>  		return domain;
>  	case IOMMU_DOMAIN_IDENTITY:
>  		return &si_domain->domain;
> +#ifdef CONFIG_INTEL_IOMMU_SVM
> +	case IOMMU_DOMAIN_SVA:
> +		dmar_domain =3D alloc_domain(type);
> +		if (!dmar_domain) {
> +			pr_err("Can't allocate sva domain\n");
> +			return NULL;
> +		}
> +		domain =3D &dmar_domain->domain;
> +		domain->ops =3D &intel_svm_domain_ops;
> +
> +		return domain;
> +#endif /* CONFIG_INTEL_IOMMU_SVM */
>  	default:
>  		return NULL;
>  	}
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index ee5ecde5b318..b9f4dd7057d1 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -932,3 +932,37 @@ int intel_svm_page_response(struct device *dev,
>  	mutex_unlock(&pasid_mutex);
>  	return ret;
>  }
> +
> +static int intel_svm_attach_dev_pasid(struct iommu_domain *domain,
> +				      struct device *dev, ioasid_t pasid)
> +{
> +	struct device_domain_info *info =3D dev_iommu_priv_get(dev);
> +	struct mm_struct *mm =3D domain->sva_cookie;
> +	struct intel_iommu *iommu =3D info->iommu;
> +	struct iommu_sva *sva;
> +
> +	mutex_lock(&pasid_mutex);
> +	sva =3D intel_svm_bind_mm(iommu, dev, mm);
> +	mutex_unlock(&pasid_mutex);
> +

I'm not sure whether this is the right implementation of this callback.
In last patch you said it will be used for multiple usages but here it
is fixed to mm binding. Also the pasid argument is not used at all
and instead it is retrieved from mm struct implicitly.

Basically SVA requires three steps:

1) alloc a SVA-type domain;
2) construct the domain to wrap mm;
3) attach the domain to a PASID;

If we aim .attach_dev_pasid to be generic it may suggest that 1) and 2)
should be done before .attach_dev_pasid then within this callback it
just deals with domain/pasid attach in a generic way.

> +	return IS_ERR_OR_NULL(sva);
> +}
> +
> +static void intel_svm_detach_dev_pasid(struct iommu_domain *domain,
> +				       struct device *dev, ioasid_t pasid)
> +{
> +	mutex_lock(&pasid_mutex);
> +	intel_svm_unbind_mm(dev, pasid);
> +	mutex_unlock(&pasid_mutex);
> +}
> +
> +static void intel_svm_domain_free(struct iommu_domain *domain)
> +{
> +	kfree(domain);
> +}
> +
> +const struct iommu_domain_ops intel_svm_domain_ops =3D {
> +	.attach_dev_pasid	=3D intel_svm_attach_dev_pasid,
> +	.detach_dev_pasid	=3D intel_svm_detach_dev_pasid,
> +	.free			=3D intel_svm_domain_free,
> +};
> --
> 2.25.1

