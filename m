Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A934EFFB8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 10:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239402AbiDBIpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 04:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiDBIpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 04:45:14 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7351707C
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 01:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648889001; x=1680425001;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TkDiW/anLOaRiPFv16ntoOgAyr0SfL+vvo5umfcQcWA=;
  b=F+6WM0uFwWpE5zLXygfdOQ3NFB6B9EaJWf4DiJ6+cHtO+7/o1Pi/ubXV
   rUpolh61lO9soxtGaAGwFFDMCJZmJTt1QQI2w8ECv76K6datgbj+nGiiB
   ynVhQkoaIz1o36KzAcVBYXehjnqJiXuMgBY0C8TIQIsRc70KrlgiwFaDF
   LqwqYX+wOyYEg7rKog/cR5TSjM1xu/J5HW0T6u6bk0noyo+i/TlIUU6VK
   H5EIX/Ae3p/qWoUSQ9DWE5CoKu0iD0PilUW6LcqVAGOkWq1ZN8o/3pWXv
   eKXZUnlKFgnLkHpqRHxlggX8NPqDKFpkfS6nyJXCQXuBcveqTN90ZiYhq
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="259988449"
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="259988449"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 01:43:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="523044340"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 02 Apr 2022 01:43:20 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 2 Apr 2022 01:43:19 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 2 Apr 2022 01:43:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sat, 2 Apr 2022 01:43:19 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sat, 2 Apr 2022 01:43:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afIM6/ZfC0lgDXUviepdTafOnam05rdBjXcaYyce8mfcwrW4knO+qC9mnJIFCBax56Z2a9qGi5CsPxGsNQlmP/MczOarY6KQbVRDoOdGhll5OQSoxBx8AMZNcSPPv2uh5meg8022Dp+Tgakk3iM1drtxhPHnn7x8qk2m8WfW5X0uM4jjhi0t3irHlXcUbiajoZBR1JGqtBssJbP0egPtPOjAoRWlIXIGyLhmL9UGZfx84xad26mEu016Hya2fplNXAQs21/PhjgiWLS/YqRiBPfb89bS6ZVbrm08KMg0EEHASJD/JpVj8Z6BuIPkRwPkmfth30jA6DkVi3HCkqqNiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqG9aC5TH4KFefAokUv0bzWecEEaFISsaYx/0+beqUw=;
 b=eK1Y4E4pxNtmv5jYLCmsvDHjMYFcX6FRvLNdNe5IC8yohRdi5n/35b88n0A/jPnlfSopUjfyzJJID1cpOKUWWktY7xjXdXIcO9zKSy2FYsVBDRvYLhgcI1QWVB7mF1uc3DpFHM1JJLiUVIw6GPu976HGFdlhfy+oN39yaQGcFGJSHi5estnq+3MDkgnZnqHdT/Wpe8g6oaLEBKROS+VeS9ZcYGkQun7J2yQtjXA7yRyUNfnuVdIZLumbm8jxUg6qp+AyjGlqH4rnYamvsH2pUQ99aYxSQKo93xLAIbBy2uk721HK/Ysf8lEGy5Ax70TJo7A0HHG9zAL3EDYoAOMOcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BYAPR11MB3493.namprd11.prod.outlook.com (2603:10b6:a03:81::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Sat, 2 Apr
 2022 08:43:17 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e%7]) with mapi id 15.20.5123.030; Sat, 2 Apr 2022
 08:43:16 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RFC v2 03/11] iommu/sva: Add iommu_domain type for SVA
Thread-Topic: [PATCH RFC v2 03/11] iommu/sva: Add iommu_domain type for SVA
Thread-Index: AQHYQy+FIia0eWaSv0yH5HJtvKyQTazYSueAgAQE+8A=
Date:   Sat, 2 Apr 2022 08:43:16 +0000
Message-ID: <BN9PR11MB5276A39F481E2E31B0FCFEAE8CE39@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-4-baolu.lu@linux.intel.com>
 <20220330190201.GB2120790@nvidia.com>
In-Reply-To: <20220330190201.GB2120790@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d16866f3-d24a-4b95-028c-08da1484d500
x-ms-traffictypediagnostic: BYAPR11MB3493:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BYAPR11MB349362CCC9A20E59B6270AD88CE39@BYAPR11MB3493.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i+/fJILPof9BjgOcmj/C+vMxxomV3nch4KQUaEUtrpUjstA090+8MQQTltcsQmd99WIW1MipWOCNqVlhyUFKGq7uPEzsNLvKUlPlwuFjOkgD5TUPjRcmcsfxZEBEh/B+eT3A8GYMiDTlKqhQJYnU7yDu2affOM6TDG4T8fNbMmZjK74GLuB9XFzc4pcWkYPS+FSDCMyAFSlSPkSYzfJa4nvG11q9t3l3VjKqwXzJO6Dcti+AThza2VotvrU6q4TME4P0ZI+Y+QeCxu/XnGIpCSQWth0pVB9JXsJ/R2XnlJrKyrXjtg7/6o9IkTMbEP36sAOb24bQ4EkU+xXYOGeIyryg9Bwsd64h+mWbcL2bzaQYUmo/wPPKTaTtka9Aopyx2lbQKyOVECleA0p82JDDFKuU++iTrZD9wf/kcN+jbSAqDjvOCFQ5EQjc0Y878BopTHsrBl1tOjVYR/Z7kwHL1EUiueAhrqjd2eAhZbk2CElSsinJmTVo1YwiPwhE7iojFojhSdnaEzXfi0JAV2r3hqvXYnnc3bpgd0cJqDy38ueVadtQzDo6nZvLexby+W7Eewp8cZuABHdXeFNlwuuvatSW37XQG2CdVZhnTLDYwkRDXa0k4Dby7iRDfmbJqsmWxL4Q/oFrH7uLz31FZLOxF30te7v+MBECLOLW6Qk9DmgoKsujhmHAyaFVe7dvD/8O0rXQlK6n5rE4VbZX+picvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52536014)(55016003)(508600001)(316002)(5660300002)(38100700002)(8936002)(82960400001)(7416002)(122000001)(9686003)(86362001)(71200400001)(6506007)(54906003)(2906002)(110136005)(26005)(66946007)(186003)(33656002)(76116006)(4326008)(64756008)(66446008)(38070700005)(66476007)(66556008)(7696005)(83380400001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z666uw6NdGuWRgtBBXgGzQU/dYYPUV/to/CUi0UVQmYqzfHGbJMDeKCXyEDk?=
 =?us-ascii?Q?hGip0gogLzP5KhGxHcayQHScHe4rQlr3Sabr+QjeaHgtvoZ3vdFSwzv7/KgX?=
 =?us-ascii?Q?VMm4jGF9aboMUTVJ37t+Ct+g3AxfM5MqnaSrMhg/3NJkdxp82y7qfU4JeEPZ?=
 =?us-ascii?Q?cdmNcqTqoScju5bvYM4TNoF/8ELyJRyRByAOqbNHRiX7iw6mO6QWJb5WZTQf?=
 =?us-ascii?Q?T9vZwLuTjkGcJlbYf7Ivhlc4mV/Qbj1NlEj/1QrMnxyCVdC0GFS7zygHxw3b?=
 =?us-ascii?Q?HmHLpcNk39y3NYg0zLqlrmtwBIy/1xRrv3dWCSFf+/ajuzLu9p74GlTIqYKq?=
 =?us-ascii?Q?ZwG9hXtiBheAVI6uX4unJ8piAH7u76PNzPSodgwaSX8vRZu+MQmLOE1P6kcq?=
 =?us-ascii?Q?iCmIscF6mmf5Q3wtpdoIZ7hhdKLqjD8skm5djij+ZLyc+JPrARA8+EaH8neD?=
 =?us-ascii?Q?MHITdzJ6JRR8XjIuPNMtBr9XXXojCcViXmUzN2ZDf6ySRm3YC2G1H3TUC+kG?=
 =?us-ascii?Q?a3LoALB+r0ULYS1ku2ejSr2OcSx2LXMK1zxXkbMOtgJ/LB6abf789iKuimYH?=
 =?us-ascii?Q?lx/Ql9GjroJyPDjSzGaCyj1ewjwNKbCzQq+hzeqTIG1p8Jei80zFbYlumPCD?=
 =?us-ascii?Q?pVUoT7E+YDn3IeXhZYkv3vbkPW7vSDuempSDV83xOxWW2DtvBIg9urNThGNb?=
 =?us-ascii?Q?XmclE4YDjz+Sx40iiFOJ5enVkxqvuIR3yZFDTxGqTk83T6HoIYr0i63c/86x?=
 =?us-ascii?Q?hRsseURLkmlC+yYF+8dJPXIDzxU6BuG9ALkKhLYbNC16iE2fFbmfqsPuL1GC?=
 =?us-ascii?Q?k8GZPeMWe1UXJrqKW/mzEfZRWY1q0gMkIPWbsu+WhyucGAAQ+4seebu4eOY8?=
 =?us-ascii?Q?s7UCWoWyrJ8J26ho9yADAE5hmaN9OliIBTWS9sTozlawDPowwIlDgCNWObAu?=
 =?us-ascii?Q?+w12QDySUCq8pkbnHoy+YP4lK3OitutORwsg4fpBswTTZSfOxLvwN8A2iEVr?=
 =?us-ascii?Q?LijHbuMhX8LgbSuLJmEYqfwfj8SVs73A7gQPelvG+P0Dgo1nSLI7Sjj5HRAw?=
 =?us-ascii?Q?GyV85L1dzBEcwUQsP7c6DT2/8Cl+jZs0/FaSHgdTwLLCRFa7tTnOJrvCYTB+?=
 =?us-ascii?Q?PA0TwmzNquQoq+lQ6lJvTFd402w6TKY6w6xZ62o6PMwyKPTg5sZwICKiw2J2?=
 =?us-ascii?Q?9Q5CS8jKb+qAbGwO0xwBvNZxEW65A1Gnwh9EU3PQ9X5oCsax/TGpDZKUlzQX?=
 =?us-ascii?Q?E6nv+S3RdMdANRtGb76GH/XrHVsoccBrpfu2tKJNAIX22eEmoQIsdtcWCwow?=
 =?us-ascii?Q?XPFxeH+9qDAJowA88wlgrBIR6XH47OLh9ynCS0WoobfWUUxQf+wC2w2ct2GP?=
 =?us-ascii?Q?YdJMepG0BcqpX1kvB5rsLSni7zMsVwCgEj5dIJAYuwzCQsTYi83Pf1rf3M2e?=
 =?us-ascii?Q?nCJ9G9lwZIXjiBn5zw2voUPX1/eGvwr3eSF66I04u77esTqTtk10AySNx2X+?=
 =?us-ascii?Q?KWdRFrFtsmFjNFT6Cy1W1xILfDXnb2WyDipJxxX9R/SSjGZnRbvvA25viblY?=
 =?us-ascii?Q?KuQ4sMoUZH7qNH4JTxAKrUeDKrgFIJLJmrQ/h/Zsdt/dI9OhhavMfX9LfWf1?=
 =?us-ascii?Q?G8jqZrWCCatYVCa7K8haoFQlMSKJS328mRNgEo/DSeul4pfJ4u186rigSI3J?=
 =?us-ascii?Q?IkpN/2Ot3HnBsbfNIoTBqfbI05ca3ndqaD37TfBfGJfy17DbGvr+qyVB2zoE?=
 =?us-ascii?Q?GIvxPyRsZQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d16866f3-d24a-4b95-028c-08da1484d500
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2022 08:43:16.2341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /+A0FPuu11GK/TuoYPXlx3nCXMZsCx14/3ggXBv/UmVYSzh3tMkJJVwhg02o0tBWxrmeZiOvj8jv5vnNyxa0MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3493
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

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, March 31, 2022 3:02 AM
>=20
> On Tue, Mar 29, 2022 at 01:37:52PM +0800, Lu Baolu wrote:
> > @@ -95,6 +101,7 @@ struct iommu_domain {
> >  	void *handler_token;
> >  	struct iommu_domain_geometry geometry;
> >  	struct iommu_dma_cookie *iova_cookie;
> > +	struct iommu_sva_cookie *sva_cookie;
>=20
> Cookie is still the wrong word to use here
>=20
> > +struct iommu_sva_cookie {
> > +	struct mm_struct *mm;
> > +	ioasid_t pasid;
> > +	refcount_t users;
>=20
> Really surprised to see a refcount buried inside the iommu_domain..
>=20
> This design seems inside out, the SVA struct should 'enclose' the domain,=
 not
> be a pointer inside it.
>=20
> struct iommu_sva_domain {
>        struct kref_t kref;
>        struct mm_struct *mm;
>        ioasid_t pasid;
>=20
>        /* All the domains that are linked to this */
>        struct xarray domain_list;
> };
>=20
> And then you could have a pointer to that inside the mm_struct instead
> of just the naked pasid.
>=20
> > +static __maybe_unused struct iommu_domain *
>=20
> Why maybe unused?
>=20
> > +iommu_sva_get_domain(struct device *dev, struct mm_struct *mm)
> > +{
> > +	struct iommu_domain *domain;
> > +	ioasid_t pasid =3D mm->pasid;
> > +
> > +	if (pasid =3D=3D INVALID_IOASID)
> > +		return NULL;
> > +
> > +	domain =3D xa_load(&sva_domain_array, pasid);
> > +	if (!domain)
> > +		return iommu_sva_alloc_domain(dev, mm);
> > +	iommu_sva_domain_get_user(domain);
>=20
> This assumes any domain is interchangeable with any device, which is
> not the iommu model. We need a domain op to check if a device is
> compatiable with the domain for vfio an iommufd, this should do the
> same.

This suggests that mm_struct needs to include the format information
of the CPU page table so the format can be checked by the domain op?

>=20
> It means each mm can have a list of domains associated with it and a
> new domain is auto-created if the device doesn't work with any of the
> existing domains.
>=20

mm has only one page table and one format. If a device is incompatible
with an existing domain wrapping that page table, how come creating
another domain could make it compatible?

Thanks
Kevin
