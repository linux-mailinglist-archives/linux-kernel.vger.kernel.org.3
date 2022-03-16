Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E892F4DAC1A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 08:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354356AbiCPH4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 03:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345747AbiCPHz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 03:55:59 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED8A60CEB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 00:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647417286; x=1678953286;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UqbKtkUmo7teWEDu6KsOCtj/uH1NiqJV76bXT55cONU=;
  b=mesJzcmUMr46ocI/tsdbWMK+fvD8bl2x6WX5ec2P9WU4TpeQFHI3xe/+
   cctTTnbBRbz7GtjC7N0rTG+Fb71iQ//e901SXquCMSVe7KtBr3rlLOpga
   gpAV6VJqU3OGRYtimqe6dPqnV9+k8DIO+xjp4RzqcwlARtil5x4BfJfn/
   ibPeSPFiLdZsnAnVhM5qniQOzgm0KQ49JCcxdyZC+wa/gO63IbP13KloE
   +yi4ACYTIzHnTim33KYsglOY/yS6cHNw5xu9zloW8ltXPXSB1K4dLTC25
   krclQSzIEqKe/ty/93IIoYEbyVRhlhmDEFdVPAAJ3Rh/kWqU5oaCHwLVL
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256469757"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="256469757"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 00:54:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="646551186"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga004.jf.intel.com with ESMTP; 16 Mar 2022 00:54:29 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 00:54:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 16 Mar 2022 00:54:25 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 16 Mar 2022 00:54:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUBi01Gp6TLp41WIDhaAPJQ9ql+Rw+Jc75LzkHAB2YWNKiCfHIaSud5FhYaCQRDZEwzWJSCN5drq+gqR1bLJAum60m4pRSC1lk2wVx/1WqvGud3oF8zJvYijOI+Skr32TEXzFSUrR4e53wV3nQIt/krbOyu3pVS0LIQMhn3fmZL7osQBtxEPzD3U7jk5XqS/1vS/8BI/YhBaArLTJekohqFv6XJmjzM6x2ya5PQUcflFn01S3YdL90YwEbYz1BDtPQwXE755K6gI0UEWpNVTolQD8l9zG4+6zlXQlWpkxC7w+PC6MLELDZ8TZLiD2HdqpQqP1JrlW6eV2QEqud3hZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwHIuTz8tMZn1rgQLGzlP/dPxymqu78+cAtztLy7eL0=;
 b=MAiHzymyCJqA0zk90zO2fNXqSwTId09xcNd+6TmYv3+PBq2s3HFpaNedasC9ShckxUivqtif+79J9Unx9oixkHsqeuAXRC9Nc37a4CvTD70THlt+dRvM+6sPjhjLqYQqiDly28HcebAQ3B2L7VteATaDZniLkXHobdNAJ9/8Ho9H8ohgIoBY6z/wlc64spyZn1hCu/slwJ7QfgPCrmBzApv3mETBt2dF7GlAmoqRjVQaS00Ud/9ljkFj4q2AuD3/9iqbGxw0STXvQPS2apCEm6c42nT83Ox005lc8jpClaqtw6qO0WQ3FF69VO42ZVhUDwce6nIHIfVLV8Kw2Rf2Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN6PR11MB1682.namprd11.prod.outlook.com (2603:10b6:404:3e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 07:54:20 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c8aa:b5b2:dc34:e893]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c8aa:b5b2:dc34:e893%8]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 07:54:20 +0000
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
Subject: RE: [PATCH v2 4/8] iommu/vt-d: Use device_pasid attach op for
 RID2PASID
Thread-Topic: [PATCH v2 4/8] iommu/vt-d: Use device_pasid attach op for
 RID2PASID
Thread-Index: AQHYOCobRQpdbzm40keSv22Ad7pcyazBpIhQ
Date:   Wed, 16 Mar 2022 07:54:19 +0000
Message-ID: <BN9PR11MB52766909013F9CC71A61369C8C119@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-5-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20220315050713.2000518-5-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f79dd6d4-bd8c-4189-c037-08da07222d90
x-ms-traffictypediagnostic: BN6PR11MB1682:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <BN6PR11MB1682744235BABF81AEE3BFD38C119@BN6PR11MB1682.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2YXpPT2lnVwUh6Ztsp/cVqB47gLt0+O02+qkTRlkD7XO2GmJkRPKPhu3f2HhmSzDEj6zpvIZKWeDdSGpS6ucAPiagj4lb3zeYGs4VJ0yskctC2xIk36+nfbrrKAUOiDwrkAklX03uyY2dKXPbc/v+gfTlo5+T87UUxtWBGCRmCKpYDkSoWJzyS3zDBvVBye7P2r8eKPXmeLvrona3I9R4fRvCAak+DgfMmsn9aGIZLHwIomBTQY+3Tb/VXNqDI8ABEQik4YGeDRK5vHe9Ln1xfsuLlYfuUHJ5+wtWLaZFdOn+kZozIp2XMUGEnu4Tt8JWlChZHxfAkA4ysovLZsJ/RMiVJfswwGFbkD9c2vLmmeOR0/WYmsqV3OxBchkvpASBNdQabH4OPJ6ngoePMkoJnorBMUx9CSy/DtEFcWUXy05iIKY6xo88K+0A3uqCQ1ck79MfNQFUNjrm5I3gw2SMeqzzMUxgezZuZlgfx8zS50ILcYOs8w0rVn6EnzjMLTRpI4qDlFwjlsD+RSdcj9DVdxK70uWmOJoZD6aUPHZfuBdQtuJ9p27zNyFVXRH7vp1n7+rmBjJcWGH8bD2ioCLt2iquA6mBFWYKNPoy4Nm+Gh6FbHHhq+wladSvwIoiNbVIB5Wc0Dryqiw1bkPQRM/1FbzYYuZzEwY8fhzXmLl9wJyd9CJ0ge3+wCueqSvSsTEZJD7qIw9JFoYoFATKxOxLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(26005)(82960400001)(7696005)(5660300002)(6506007)(38070700005)(71200400001)(86362001)(8936002)(83380400001)(54906003)(110136005)(66476007)(9686003)(316002)(2906002)(33656002)(508600001)(38100700002)(52536014)(122000001)(4744005)(76116006)(55016003)(66946007)(66556008)(66446008)(8676002)(4326008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jK9DSD07T88Rs2ix4UnJhcVnCff12QzfzrfFoJc6fvXbpPlXidmBkzFqdk3F?=
 =?us-ascii?Q?f/d1Xbx/F1cJgWxaUqLGTUZm84h5yTrfCQXHAGy0F3DAPWUnUoWB6e2m/57s?=
 =?us-ascii?Q?HmFB7agVyYUw59cU8SxiwCmPsFH+cZoZK39s16qYlNOrYQIx5uSh8A/oyWhy?=
 =?us-ascii?Q?XgfguoMhnGzBNjdwtvp5fUYg6n9seWTQn2Yhq88AF8vZwynzhUeZ+KBpmZQl?=
 =?us-ascii?Q?1xiZQD6TlbKebitmO8Y6UMRXzMn/Z7HwYw7u+lJO6U7ZIkHN/2LYEfO+EWw/?=
 =?us-ascii?Q?2QlREbJwHq30KvZvz4hT0lVzVrudh0eNT0cP0P+/8nFjrwxHQNHXTQ2ghJfC?=
 =?us-ascii?Q?youVxmwkBRVhkH24ItUeRVmZTLEemyqV/CFMRHIZlZ0Y6vVW3fDN7epxdSuE?=
 =?us-ascii?Q?G0BN/rzdraqUMsKzeLznslqjotsDeIq4p9PUg3wWqWCHyfeMFjItHOWtYmhD?=
 =?us-ascii?Q?kMDd5WMLDYKj1ELpvnjRgg09pnhDnwj6rSJulH3R5wqKWQmMxhsn80nqz1qy?=
 =?us-ascii?Q?KTVL7wModR98qoGqn0EjyWVlw6D3xv1uxpO7NEixWMpR3lAb0bj/PP8b57bn?=
 =?us-ascii?Q?BN3Z0+DH/0ez3s0tzCS7I0aqsy7vzPS+vjL9WPoTkX7qlzfik0269qZZOXQk?=
 =?us-ascii?Q?iGdS804qfjWH2rTfQ3OrPkusFn9t5QpMDdKfd0yXurBw2doZXRK22afOziFc?=
 =?us-ascii?Q?FJjxIteuXsnUuQRhwxNm+F/lKXO1B1lobLsR+qOFJHhRFBNQuh/aD2wkb3ax?=
 =?us-ascii?Q?7C7LzzeiLOI8wN1GaleCZBJJMQM/K7wvBftGWtQxb6zR4E6uwFCrkm0AkjWl?=
 =?us-ascii?Q?y1+LBrdHa8b9X7I3IvqSE0M2Of4LOQNJZjFErtuCRLMiJ9Hw0zAD1aUryAZq?=
 =?us-ascii?Q?wW15XSMoJB8g9W/AOMIpnBpPqQ2UAmCgmM7lMKT1qykx3Kztghj4lxqyNk6i?=
 =?us-ascii?Q?fnEHqCd2ZfQSp4JdR0UhCxLJ4CO9jdQgw1ge3Y4FOWQ/icCYH0qKPuWo68ME?=
 =?us-ascii?Q?uZUWy2Eng5uzHZtRPbRudlQQ+16EtM+FTsB23faC4uVKjwl3SlnLRKhAKeRq?=
 =?us-ascii?Q?5Vs7gqmPAfeDuI950Pv7J/y9VWBZH3mHAk6sPmh/MpOHcJiWGUX95cBujl/0?=
 =?us-ascii?Q?rAHKIRQoTH2H/TMS1Za0KIJ0rzoOOdMBX5TG6Q1rx9+GSG7yRlCdVYAUSFfm?=
 =?us-ascii?Q?EMdCzmewONUKa9K0lItXSxq6HAZagXaeTVd+gQeT1n8DVD7UJqDtQ6uGvUTV?=
 =?us-ascii?Q?ur7Um3dPhS6w+BkbXt5dLnGATwAMpul8kXqRaaTE4abvkpZJxpuDGVRqdXc1?=
 =?us-ascii?Q?zx81EfIJAvxfddo99ng+F+8/qETKkubcYwfeWaBoyLxX8iulidnd5H4kHJVk?=
 =?us-ascii?Q?n64rbngUvMACLc2TrqB/wVQkByDt/cKDPNk6EjQIeuEkLPMmiy6fVd7gPJ3R?=
 =?us-ascii?Q?BrJIsvrr+tNHBONN0beq0sJL8J7SQ9Ka?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f79dd6d4-bd8c-4189-c037-08da07222d90
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 07:54:19.9527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LtOBIb/CXaDp7e+GUj1O/N4DJT6E3Bos1ffs2wm6s01Vxcv777jMgqumDtHG8iNLVCLPyM2Noa9PrRYHTkFh8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1682
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Tuesday, March 15, 2022 1:07 PM
>=20
> With the availability of a generic device-PASID-domain attachment API,
> there's no need to special case RID2PASID.  Use the API to replace
> duplicated code.
>=20
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 9267194eaed3..f832b7599d21 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1683,9 +1683,6 @@ static void domain_flush_piotlb(struct
> intel_iommu *iommu,
>  		qi_flush_piotlb(iommu, did, domain->default_pasid,
>  				addr, npages, ih);
>=20
> -	if (!list_empty(&domain->devices))
> -		qi_flush_piotlb(iommu, did, PASID_RID2PASID, addr, npages,
> ih);
> -

this should be rebased on top of Baolu's "iommu cleanup and refactoring"
series which has removed the entire domain_flush_piotlb().

Thanks
Kevin
