Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A6F50AE54
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 05:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442136AbiDVDIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 23:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443633AbiDVDIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 23:08:01 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2738B6406
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 20:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650596709; x=1682132709;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EXpEtsVVhc8v8TpNKD8lPGJQT9y2uOj3VIKFQo+8Snc=;
  b=gTwA+bNRuSOb6nGKAA8uuHLYRcBofUbajQRemdZAD32/+jNZAfvwx7Rt
   gZ8fxciybNac4xqhIOHPVVM7urKt7QdVRJwjl9OUcjD0oBVleujxquwVe
   P4XMTN+27n/7pFeEtSkq5FaX1BhmR770A5z8t3RD7Yt98xsU0Ov07CbI5
   DdM1bGzO7fD5iDOxL1X2eqtBEnOgxFV1qE59RIZTzt1OlQ6SN+LoKFPMb
   8rfJ8CgUwdClwyPLnJg76caBLhV0dzVm4LVn00J42gv+XWThcgpvnjCYN
   hPBhG0/MnHgYYHQ5T2n1+usn/gs2/vHs0OVwbpelYs176ER8GuzM1mE1y
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="289670898"
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="289670898"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 20:05:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="577621979"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga008.jf.intel.com with ESMTP; 21 Apr 2022 20:05:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 21 Apr 2022 20:05:06 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 21 Apr 2022 20:05:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 21 Apr 2022 20:05:06 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 21 Apr 2022 20:05:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnQ6VbgzikBJIrBPGuTFhWf442yd7RDFURwC0+G1b/NUpUHuQjMDDOw1aRzhMBYb9m2iWyvXY7N3L82c2KzBGgStjtYLFXs2UZlptdrwBz7LTe2QEg3Hp67EoqBdA9xCNTs0Urv+GI1wQOQGe0q0s3+g/tFtQL3tTF4kx4dSR9rjJ3KusrEIHKV9dvpMaP4TZMa8hzOEMhm6cHudCwYJQyHlHPdm2dscB9PrwEJH8xYxpA345wEXRV1J9Ye4Z5Qm2Bzpz4swyKCRp6bUYlckp9Y40qObOfBLVcUEFzZbDLXkhN+3raGoVZo0ipnrrCYcSEZCIhRCmnsLWId/rt1d7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9HupCMbu7D1KCoWwWFmPCgheBioEqPRHPxkD9VTY/M=;
 b=jXSzKjGUlipzqvfEDMLKvhQlMBJM29E79KdZxlx6awo9zZN2fZYkyqYawMKaoCq3vNxYWSLnhB3zB+C0/3OuNSA8IWIdHBYPYBodt3TUq+Ts09eF8PjdzbzC4qOQDEU8l8YgGtOYFfk0GQ5zjHFnrpK9O79apkBGrJxsqhhnHVZBtqhEGki5LXPzj47H2c/vJxFGzEM2FlahL1fMTquN1IpYVcOFiv8H/SgK7RgjSNG36Bp1a3J+KSJeVCV9X/w7oLFWokms29056OGxuG150AaMdXlSKTdLhT/8Wy+cQX8FGtCg8XtV5ZjebS9tRP9jOh83CNg7D4Ilf7HTYQztug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN6PR11MB2606.namprd11.prod.outlook.com (2603:10b6:805:55::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Fri, 22 Apr
 2022 03:05:04 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 03:05:04 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/4] iommu/vt-d: Set PGSNP bit in pasid table entry for
 SVA binding
Thread-Topic: [PATCH v2 2/4] iommu/vt-d: Set PGSNP bit in pasid table entry
 for SVA binding
Thread-Index: AQHYVXRg8Nz8HbP3eUCCIZJcvbXpQKz7O+ZQ
Date:   Fri, 22 Apr 2022 03:05:04 +0000
Message-ID: <BN9PR11MB5276EDDABE40B6A6A67A0F4E8CF79@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220421113558.3504874-1-baolu.lu@linux.intel.com>
 <20220421113558.3504874-3-baolu.lu@linux.intel.com>
In-Reply-To: <20220421113558.3504874-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23bc536c-82c0-4b08-5218-08da240ce626
x-ms-traffictypediagnostic: SN6PR11MB2606:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SN6PR11MB26061EB1EA0562D7CFDDCBDD8CF79@SN6PR11MB2606.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mn+sGFKEmZjbubpoBAeMwihBz1iul8qXg2lfwDVP2ZPSZneyDwnyaXBcG160nI1osKLSH2NZ8D7KM0AEmp2o5Etr9T8ZuHKRLdzpKu8pLsenzzlprQgGkooVjuIN2nz4yJTtcmc1v7iiiQ7hS6QSRQTp2zsFd77X06KfRTwDizsUwzgUGtMen0Wvs/EhoSXYo5kYvHEh0ca8LzP204kcPsCiKPY/hs0oPoal59bz1h1CvX+LSxEJO1/hrqDjmBHnHz6a6IPKebHj8zmNbScIhK5lD31rwuGzvMNEhzrVeULlGpc+GtgOwfcz9WJSFsTQkMCirseP6zwlSAn933qb/U8nDLVnj9McRAThnkqDkdQf+TVTwTjkBDWAjnFT+awXpUTIlRFCegPHsLr885y67xGJpTuRTIc4zhzF+hc66xhe2Yb9def75fX5rFX2WnMJvyXoLbOr5Wo3IOhvtqhCBUZymE7ggxblk1a9azOGunUPLKETZyth+1QnYbWPpmNP9ypTBNb41Mf0ECaKyqcFf4bFPZm2mLXmABaObxIdntk3hMruirnf79JjQURBpKREFQfDkie4hp1uU9iaNJAg7v0YOhgu6NeAmtZSzTlLHmXf7CeQ2qiZ8lLN/4me6zBATec4P2YHGGLxks5gu/x/aw7VxHPgSRiYVNvdXazjqh/P+k9AftJ/mnlzKd63Z/17aC6nUGxVi06WrEdRetTu2g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(55016003)(508600001)(186003)(8676002)(5660300002)(33656002)(66946007)(66556008)(66476007)(110136005)(6636002)(54906003)(83380400001)(66446008)(76116006)(64756008)(316002)(26005)(71200400001)(38070700005)(86362001)(38100700002)(4326008)(9686003)(122000001)(52536014)(82960400001)(6506007)(7696005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hDHcZkM02YLIlMo7KJzlFhNPNJVyvPGPrwZz8uF1ptYiMkmmgxk6JxGOrJq1?=
 =?us-ascii?Q?0hLmjZlXD0KodK54S8pkLwnB+iYp+jj6lIkutgfnxkGyXJXk+yurorCBti8N?=
 =?us-ascii?Q?6vEHWhHtv1SecW3+yC8lm1xaIR5dCmzDLZQOdAe+u2GsOH48ysQdzID5KbA6?=
 =?us-ascii?Q?l5YuBpOMpoh7Oa23rrZZxZBWuBtYhUmXfKMELx1vC/V8n+Ip2v/4Mg5BZzdQ?=
 =?us-ascii?Q?n6w1Ge2oxIutamgz/KW54DFraI19vnWLRYOzZ4pPHHJyYFx0LCWrjvSs8B5N?=
 =?us-ascii?Q?Zit76JdrxSJnmw61LRb1PxkV1bq8IYtakk6xIh9bin/oDXbAj7UgtATwgIRg?=
 =?us-ascii?Q?kEJHXs/vkFOBEMb1FzS8GtfSRd9gtMC7qfPRvx7Xs7WUFYh+JsWUfftfSVXy?=
 =?us-ascii?Q?b8W223eM1f2E1pqFgqs96w0tsjyZA32zlUt2F35UbmBlFHwb0PZe3bPTWUZz?=
 =?us-ascii?Q?VBTbJrlCqOYGozIG8k17kymqnGwU6oUUIv0X/DaVdHG6EwB/NQVUaKv4D58E?=
 =?us-ascii?Q?goqF/sENGL/U3r2eMqJroyWtQjnNmvocH+GBlUiFLABuV5nXTwrmQVudWVeg?=
 =?us-ascii?Q?UGwUlaybzkfFSDhfaLOPBOr4VAWkZvfb3Xhr7fPNxbjWVF33qqf+VQCmSwgn?=
 =?us-ascii?Q?qKNMVdHL+7hIUt0uX5kNDNzPVyP6hE6sVTckjocxyXIsrJCSuXp5XAcj7l2a?=
 =?us-ascii?Q?7kEEfDDdPZUM8W9uf5hlH4le/Gy9BQVkPuAAcIx3cGoytFZPIXVCRrQfVIkw?=
 =?us-ascii?Q?+DGlgUKGR42QWILQbUNHphTXslw+rC2XT9vAk1ic+ScySNX+3+EsZVlUmGG6?=
 =?us-ascii?Q?Eaes4fFfYP8S6vmx9UF9Q2vYBjJaUBjkfVCHkX9mpAiHr9U4u01zY++T2tfR?=
 =?us-ascii?Q?hpUbpINO/FZDWJeQpKHy2tQCOoDPGg3YTpvubEfdbuAqF9sep+G2KUClKqKE?=
 =?us-ascii?Q?ce6+LPWchFUsziuZ77Et19UsRkjryv0XmEXgMZmBJuPuPXaAPxo3dK9cPC6W?=
 =?us-ascii?Q?XCJWJgjxmiV9rvzxX+T4Cs7WdXh+UztmnuJ4fhXvBJ/rkz7tWw0NVIifrt7t?=
 =?us-ascii?Q?8M2jQUiGCvDE5sV86tuU9fe4wkLH9f2RzgLR3xLUXZdpN4pSRK/3XrbwtBUa?=
 =?us-ascii?Q?pV+x3q9MUufZX4EaFjHnkPIA5nvqOdI9k0ZX9DOm8VY6v7Nr9Lgh6EOeNS6u?=
 =?us-ascii?Q?Ogx+pv/Nno93MvRC/GM2YotzIR8jEnptsVSrxwcAslZU/s3woP3YpNakiuVA?=
 =?us-ascii?Q?D3CP91D4vTo7GYn+5P6vh96qrTfIzk16c4AQ5+irspbym0Qdo7hQD7mvUhFx?=
 =?us-ascii?Q?3gxDNnC5YNIPLZKeJx3/g+ExZc8IMiTFuNOI5xyEZbK9PUs/79WztVo/AL+v?=
 =?us-ascii?Q?EDYcwgptl4NN9Z8J6D4byXoOQWGilHl5kTB6yIjYp3F/hMR6SFZhe3FJMujv?=
 =?us-ascii?Q?7pw1QBExuGkBWqsml3dN5b0OiuLKAE+wUiRkbQbAOWiZHx0XvhOsCy/Fgtm4?=
 =?us-ascii?Q?IvDQ/kgG95ajZ6R0CG2aA195Uk8dj5P/fgB+3jVOtX6IsIcEnFen+9j3uZ2J?=
 =?us-ascii?Q?72HsGa71EQLpCb7BQ52AmOirexLfwUSvLcASuinTMZK335fjns/1HSESogke?=
 =?us-ascii?Q?5NPqzawGQiwyW4STsJ0mPioGHEqDwoWR4bEXe2u9UP0eHm3JR/2jmBQvBkwi?=
 =?us-ascii?Q?SryMr1NdMwo6aR7yesOJ3itVA30mdpjrjvlw5mJZppF/lbcpUus/6T4zUCvc?=
 =?us-ascii?Q?Lfa2JlBTAA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23bc536c-82c0-4b08-5218-08da240ce626
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 03:05:04.5200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 63bpG1TbvHLNIB0fpPD24XaH6Zs0hDtmKboBvkUzua8Gmhh4vcCSACCTw54Qnt56uZxt1C2cf7ZvT0DZ0d7bEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2606
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, April 21, 2022 7:36 PM
>=20
> This field make the requests snoop processor caches irrespective of
> other attributes in the request or other fields in paging structure
> entries used to translate the request.

I think you want to first point out the fact that SVA wants snoop
cache instead of just talking about the effect of PGSNP.

But thinking more I wonder why PGSNP is ever required. This is
similar to DMA API case. x86 is already cache coherent for normal
DMA (if not setting PCI no-snoop) and if the driver knows no-snoop
is incompatible to SVA API then it should avoid triggering no-snoop
traffic for SVA usage. In this case it is pointless for IOMMU driver
to enable force-snooping. Even in the future certain platform allows
no-snoop usage w/ SVA (I'm not sure how it works) this again should
be reflected by additional SVA APIs for driver to explicitly manage.

force-snoop should be enabled only in device assignment case IMHO,
orthogonal to whether vSVA is actually used.

Did I misunderstand the motivation here?

>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/svm.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 23a38763c1d1..c720d1be992d 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -391,9 +391,12 @@ static struct iommu_sva
> *intel_svm_bind_mm(struct intel_iommu *iommu,
>  	}
>=20
>  	/* Setup the pasid table: */
> -	sflags =3D (flags & SVM_FLAG_SUPERVISOR_MODE) ?
> -			PASID_FLAG_SUPERVISOR_MODE : 0;
> -	sflags |=3D cpu_feature_enabled(X86_FEATURE_LA57) ?
> PASID_FLAG_FL5LP : 0;
> +	sflags =3D PASID_FLAG_PAGE_SNOOP;
> +	if (flags & SVM_FLAG_SUPERVISOR_MODE)
> +		sflags |=3D PASID_FLAG_SUPERVISOR_MODE;
> +	if (cpu_feature_enabled(X86_FEATURE_LA57))
> +		sflags |=3D PASID_FLAG_FL5LP;
> +
>  	spin_lock_irqsave(&iommu->lock, iflags);
>  	ret =3D intel_pasid_setup_first_level(iommu, dev, mm->pgd, mm-
> >pasid,
>  					    FLPT_DEFAULT_DID, sflags);
> --
> 2.25.1

