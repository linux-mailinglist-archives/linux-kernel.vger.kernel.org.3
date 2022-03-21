Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81994E21AF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345088AbiCUIGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240711AbiCUIGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:06:18 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7486BEF7B7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 01:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647849894; x=1679385894;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CT3fgmgfp+hsFIdmOzo4PJcaeD/9Q4TXjzwV7aBwoXU=;
  b=OQwfuxkW9fOIx5p6PgtPadAvSJ+6IP9OwRk9FVM3LffNizMMt79icou9
   c/G7kJkk+9AZbFU39x1cF/o6D1EP0u6WgFWjokIjFV0Ly7SrH3Ss8mgWS
   bxAzDkbpCiPqLT7d6j/LcWipnFVvm/DfWuE4KkVZVAZ0n9TGzlXAtAsoy
   hOnzU8+sBvU3YLv77FcYQFDj7LCNqNoSTPtQpY/1XC32G5sMaE46EaDO4
   78XfFA4o0XGGBhz/gi75YhMhc6CMy/EsMlySlW1vaWBVhNEAndE2dcp86
   bQi+QgUkRKXQXXCDQXqJLUrZVt+DQzd64homlknyHQJVvyGnMtoC61Ab3
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="282320619"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="282320619"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 01:04:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="514855972"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 21 Mar 2022 01:04:53 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 21 Mar 2022 01:04:53 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Mar 2022 01:04:52 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 21 Mar 2022 01:04:52 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Mon, 21 Mar 2022 01:04:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lypsoZCv8TtwnjUR6srUQRdy8hk2vhmyPDXErb1lG9XTWB63BoIXnz2RiZbT2PDEst0V2MrLrF6DIjafPNd8VrZDQCG/fyou2a3Kl9BRlKc6dC86lJERGtauNJbWm08wM6DNPJ8uCKVdQlS/5n2NwY+iKs1qpiL5OVEeiaU/V860FqERKaMOIFYj8UUOwX2CB5YVoWpqpZeYlH1NMqvJSgxNppwhsuL2DYuttP79uEa7N8/SPDCXtQLAqIEdPn5ivF6D3HLJBvoUENOniD4438UOO0jV9ZMXn0fmP1u+/pLtmft7+FZW7T25r/gbscSdSxuqK1lBTytncvDPA/sRTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/FbNK/hlTJvGlZvrLdOtB9HB8yzbHap4esCyCEOXrE=;
 b=BsRgVuLmTteZt/qIqYY18O6onrKXL+9gTr/GXUEzcOb2NTSeEURN5VXI4zgXD9y3KZ2UgktLX/Uq+bw1tMVXxG76FuM4wuEod5Wlk0xcW9cIjbGMx7ivdsiHgc8rbduKr1JL+f9RNlDtQmAoSh3a3FH8mPe+giNuenw6b1/H2mROl/7G9B1iJslJcXTzrNjiwykzYFTdQUDri8NS3t5sTgFmynbbzx/VuwJN0a4AgOvBEks2BXADgC/ekl6EGXzL1MI3XqVmx7z7/cRU9FfV21YrQVAeHX2ruttAvH0Zm3kxw1kXbUq1vBFbXyXQn1UZjJVfsLO/qGBYHjyLngq4PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by SJ0PR11MB4783.namprd11.prod.outlook.com (2603:10b6:a03:2af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Mon, 21 Mar
 2022 08:04:50 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::b9cf:9108:ae17:5f96]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::b9cf:9108:ae17:5f96%3]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 08:04:50 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
CC:     Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RFC 06/11] iommu/sva: Use attach/detach_pasid_dev in SVA
 interfaces
Thread-Topic: [PATCH RFC 06/11] iommu/sva: Use attach/detach_pasid_dev in SVA
 interfaces
Thread-Index: AQHYPCXAmeLFDLK/6UCyaIIcRanx56zJe+yQ
Date:   Mon, 21 Mar 2022 08:04:49 +0000
Message-ID: <BL1PR11MB52714F57E430FCBE97DDAB478C169@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-7-baolu.lu@linux.intel.com>
In-Reply-To: <20220320064030.2936936-7-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1259c51-a62d-4f30-6648-08da0b11791b
x-ms-traffictypediagnostic: SJ0PR11MB4783:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR11MB47832EC72822B7C6414839298C169@SJ0PR11MB4783.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p90ggl+vk5pshkCGo0zOml/CD/QgulSh36ZETzgMEBeTv9OotYQ7Ut/o6TJ6yzxSK9m3ezUVZfyeQZBH9f4kj6wNB1bION5f8FGJyW+dgTRJ3y9OFcS/ZU1h4WNr4lo05pcNKzCyPLHaxashzIj0uk2Lr58PTJ1UdzQSyLQhP5q0YzXN/WqYONmvoaUn2eUN8jy+fQWJ3h30M+8Ux+eQ0ElXIcVOqeinf/PYGWlnpqJStD1fvVqOBaCaeEaHbncCBVu7MO4ZDm+hR0VPp/lSpLqUvwr7XL87zK7Lhc6RGvXadlUR3b3nGuHILLPMWL6aFrl1SELmFut1vizYdHJSpL7vzOyRMLBW6FY/NCXav3gprLbxn9DGezQTz6hxG5fG1J5r6TmqPy2Nd77fDYRXoqlhLO89w6wy25WK9ARMJrIPRBjhbg/sfeBbVocp8faeEB7WKAXBShJ4EIO5NGgWGEtsIhuisbJS7ARYeJ50T0FvXhEoIoRzfFo3/O6I1p+YBbVwwfFhEH5ZJzgN5z8Hs6wpgAq+uhDEUAUGbaacfWoAIxxHt1AZZKJD0NFbe53K42yxFWw5d8diFo8ZgIn5IuemxQK1bfAg8kS3jsBEfFKVCL1+DtgKfYZ8UVTuYWnQ38eEMzpIojOVy35aZMaRIAKL8QWZQvyebGcBbFNAUvm3lZRH6p4qoMBJTkKFV7W4JoUvqP4RT6hhLtLrz0E7Tg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(82960400001)(26005)(186003)(38070700005)(86362001)(55016003)(508600001)(6506007)(7696005)(66946007)(110136005)(316002)(54906003)(38100700002)(76116006)(71200400001)(66476007)(5660300002)(4326008)(8936002)(64756008)(7416002)(52536014)(66446008)(8676002)(2906002)(4744005)(66556008)(9686003)(122000001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+QeZIM2UQNR9sTHqX5XgANHaSrqGfa+Wu/GIdASXgiR3Pw76cpynew+Zdv5g?=
 =?us-ascii?Q?jAKMK32vDxur7VWGRGy5gzqBjoJg/B1pdcqoFNQdDh0U4F1q/VWI5wLWecLZ?=
 =?us-ascii?Q?5XZee7lss6pv/3hI1f+nv7lH83GkxnFgk2Lz1ko+gFN7KN1FxUpMcEsngaYr?=
 =?us-ascii?Q?Qhpu2Hpq5z7iKrEg9uHG7G9C2/4XYLCFPd2d0w7Hv9gwVs/uEUbDR3uHWgL+?=
 =?us-ascii?Q?P0vVp5zcqo+ecvkA6yUsuOZM75Ghc+pCs19VihAHr5KVgozkCWg50m1VojFG?=
 =?us-ascii?Q?UlUEiB1gePgKO7AHpGQmfUVi8ylTdMJvoVQ25M5MaN64BnhQnAdGGSYKK3jL?=
 =?us-ascii?Q?2qQgTRyIo3d2nYUVtsw/zJAYik4ojuI3fR5LoxVHEW+8U561XFylefZh1vhy?=
 =?us-ascii?Q?TohTAGtxCkFqDHm6mAdROigeAsp6rHngCI03a3Pa8j3HIQVsWMoklfs1qsBC?=
 =?us-ascii?Q?z1oP0CZ1H4vgqyVTWoZhny1sl/eUHe+ymPedpQvNnIAbwgvtHyXohamuhDg+?=
 =?us-ascii?Q?hBPtHR9m6vv8WBvVzziHGQsQKLLcKlv21rf/GSqVYoG4pmdykND31WFYNkLv?=
 =?us-ascii?Q?t7fVXU/liYJSIvvm7RzwSruCd/UsYl4qIWFAi3gpP2RH4i3K5eZTFOmhm9Z7?=
 =?us-ascii?Q?cwrErXdqYj4wC6Busf4W+lak85TMkthJU3v4uWsXFBoyYZP+AeiwGb7MWrWj?=
 =?us-ascii?Q?MWLenXDObN0uFOxw1NJGPMFfdmnk0suk26vZ/YyH/AQ8G+xof+NaqD/wgE1z?=
 =?us-ascii?Q?IMczBqDoR7l6P7bXAYMDdXTpAEUkkecPXeNHU7BDmj/52idDwqAEIJ+RJnYV?=
 =?us-ascii?Q?7t/BqHTSqAc2NergGsPoo4xvkAl8IjdS90MBGDQBfj17Lbk5mZFz9QeenubM?=
 =?us-ascii?Q?9QMfJcYv8z9+J7QgWQKb2XArZTVFClz0G5icfYrlZiclFd6qwJxumS9b2R5O?=
 =?us-ascii?Q?MuCsxgfjW5+j6IrZH9lHvknDJbRF2Hi4RVSOvx+4/a79uacIVvGvsppN8Nsj?=
 =?us-ascii?Q?/XKHSthxuze8WG9rH7H9xu7W0MhS17CI3T4hnCVU5f+yNoVeL1OWUQreaRR3?=
 =?us-ascii?Q?ggbI6jgjkfXqy0zkcANmMX+ssqAPbvV0QgZ1fyWjT8ZO5CsHWR7gbTjHQGqv?=
 =?us-ascii?Q?sTsO3nWBUvRzdxeEI6whNb45DBgTgqepv2et4u3+g7hwO5aVUKdJriPr+sxT?=
 =?us-ascii?Q?GWa46j9vaKFo+DQ81iohScfSpefj6ndJeabcfP4m12Ym/rRq6FktvcbRRlg0?=
 =?us-ascii?Q?v/B6UUdP+41Q+jHioTRXTpUKq/45Q280SY0dmCeu4jABGIAVheVMGV7xe6i9?=
 =?us-ascii?Q?g2CIZDVveY9vhqX4CEr4Oi9dW8x7aM6Rho/1iOnjp1lg+EaK5//WsVSFA3BP?=
 =?us-ascii?Q?AEjYuLNKzF+uUM2th2dZ8McqMO/YkGuP+ivnRN1lxmCKm81aOWO4MeTLV0oh?=
 =?us-ascii?Q?PFTp4C2CzZbFiONlOQPgbi0D8t3wWUHr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1259c51-a62d-4f30-6648-08da0b11791b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2022 08:04:49.9597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OTKWfsFUbynWSDENynAZZjvA9H64cQzXqpWZWGinBWIt2ykpDYb3qbEz0UFT61i2somvG7HNLx4nuY+aCA7tLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4783
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Sunday, March 20, 2022 2:40 PM
> +struct iommu_sva *
> +iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void
> *drvdata)
> +{
> +	int ret =3D -EINVAL;
> +	struct iommu_sva *handle;
> +	struct iommu_domain *domain;
> +
> +	handle =3D kzalloc(sizeof(*handle), GFP_KERNEL);
> +	if (!handle)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret =3D iommu_sva_alloc_pasid(mm, 1, (1U << dev->iommu->pasid_bits)
> - 1);
> +	if (ret)
> +		goto out;
> +
> +	domain =3D iommu_sva_domain_alloc(dev);
> +	if (!domain) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> +	domain->sva_cookie =3D mm;

one domain can be attached by multiple devices, so this should not be
a blind alloc.
