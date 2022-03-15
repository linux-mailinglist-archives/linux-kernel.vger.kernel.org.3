Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C764D9AA6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 12:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348038AbiCOLvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 07:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244995AbiCOLvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 07:51:12 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF9A506E8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 04:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647345001; x=1678881001;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zHMnp4Uv5Xqii/NVxN/gxrw4QoBid1upSS5ZUenXc1g=;
  b=fqg9Ii+zGFWgFiMLwWWUmaHvJm2EvqZmnK+K9Ft6jER19Dvlb7wr5skM
   WKEuqnhDHvgOVg4YUUb99p7zkS1jRF8XRNXtm7XyLka/ZTJ60/9tp+WCK
   6fXMTDDN9WsSHrDBXPjG7uWnTAuPCEA+0vHdyGZUX2u1Xp+X6Hf2nbNTP
   iiqUDt7Yagqerh2S29TDUnocLfI7A4WyOVrALFO9O3B9izjBVnCLfsjN/
   5RnbKyjr3joxS8Aop0++lULBeKCQ3KpfhNQ3sN3uZ0r0lSf+AF4dgWK6C
   JN7SMcnD43jRVDOg8DeQYj9c6a8Q6RwbMtGqwSMc7q4MP614eE3XRCqYI
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="281047367"
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="281047367"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 04:50:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="714125533"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 15 Mar 2022 04:50:00 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 04:50:00 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 04:50:00 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Tue, 15 Mar 2022 04:50:00 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Tue, 15 Mar 2022 04:49:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMVCzbuyHkG6ssZ8Bh6dPScY9KC05599PoY3ImGxFCkr7IeAyblE0e3ZAhUorx2RH19ZZNOV/kRFRDH62+t1GzLT9L3S6Jj5Qz46IP5atwhdrCeRQdAs710ev0IYY0+/eX5lzVfoaJ7c9RWJUCuAdxM5Ddt7CDLL4T2F03iKSl6/UA/7GIXhNrexg2USLU7l1YTOT6cOQMGkth8DGpQ9Ydqc6ACchLhV2p+mL+vLP32h5SUW2BWpQVxMAu0dft9gc3MQvxwBHlEEQCsxCPDU2tbEBZgkRWwQ4LYOdkW10w8NAU3LTgqidfl+xNm9CFD05l1cW6+wVcb6dR0mavyOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v259uTkQbFxC2uGiMSJpJpFBoM2OPdJkRGOoXPVcTJs=;
 b=J32qpf8t9Fwd811UoJYA82hDjuqVdtlAdSfDlVQ995KwstzK2OpuJEWNd694zsMVl4ieA8K2fc5meOxlmFPSL0S3PeygRBvJz8e4ZBccGaopPnFJdsEzGdGllSLko8P1fQDeh4gvk2svEGAf9XtJijlj4N0nJZwnh1qOsMT0ItnX0ksneYwOnF3XbKwskmLFRd1a3mzd1YLTPw2qlBlb/yJoVlL51unAc+THWw9X27iOJev1Rzz+3CoObXmmulLlnDzFk7oNYbnzQ5w7LrU35Pr2tuWxYaGSEpZZh9QQUcRYkYwERSuCB2vNSxMTU8/e9htuJV9xT9VWXpOUx3oQFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BYAPR11MB2805.namprd11.prod.outlook.com (2603:10b6:a02:c1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Tue, 15 Mar
 2022 11:49:57 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c8aa:b5b2:dc34:e893]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c8aa:b5b2:dc34:e893%8]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 11:49:57 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 2/8] iommu: Add attach/detach_dev_pasid domain ops
Thread-Topic: [PATCH v2 2/8] iommu: Add attach/detach_dev_pasid domain ops
Thread-Index: AQHYOCoYv35DknzN5kqPD8yptRL1a6zATtaAgAAEIvA=
Date:   Tue, 15 Mar 2022 11:49:57 +0000
Message-ID: <BN9PR11MB5276D5B88C05B509C2C790A98C109@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-3-jacob.jun.pan@linux.intel.com>
 <YjB4AyrgsnbUrlLe@myrica>
In-Reply-To: <YjB4AyrgsnbUrlLe@myrica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 130de06b-a1a5-4763-05f1-08da0679ed85
x-ms-traffictypediagnostic: BYAPR11MB2805:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <BYAPR11MB28052B7B0EEDC564002FEEAB8C109@BYAPR11MB2805.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xGQzFcCiFzqcBgZHmCaMqNX5RqHhk0+lUMNST9x2sjKpD7FXBNJP77wEjl0uv3OOf0HN/N6FomQDF9rE/AnK3fkXTFFWRNlpwhv6jNqTspu3YwPqusijFLLRqg0JPF/BojEo44PRKS7nM4CbNgh8asP12481cO5UTc8WL/PqTAfF9UQbYeSwjIwpGZkjFTGzubvNMojPoD994hyLqmoWYJirfQ4VXHLx89aSQ9LtAYAAmDLNrdv4CJlNd7gyadwNrawcM/7zvbqrIZ03DSXZSBnBBnRas/oe/xlgWbwr98tShObrZl88JAb0DejTzdKvbiaZotX+sjxw5r52qxdPUFxN6Tokng24J8CqOtRWRFX3lZTTemjt/QwFQGnuh+Jw4yjnv9D9Q2PTOBhYCoVmRQUMCSB8IeSRA5Wfbzt9JsMUjUJdbfIHNuuK+5aF3diMvJYF1mDNqDTi8szcW7rh11mPMRk9B3/ncQED4mg0aGb4bvYgUnENEFDozwS3VrJCKYf8GSTVhulXVvFG7v/bzkQ69SAgsYvp02adXL9ySbRPiH/82WcoiDnsoHqvbkHcPsbN0ar/WqSbGN9n6ubMq1Vc+FbHdeWltNJFU629gIeQB4NFiXVBVx7b4hVz0g+BpaPh4NRyaRjcmp1pcN/SHXFCvZpartloLsjvZTyjLiXehzZw3bt08CRhj2uq/3R0JZMRQkncrKyoMXEgv8GbnQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(26005)(71200400001)(82960400001)(122000001)(2906002)(7696005)(86362001)(38100700002)(6506007)(9686003)(508600001)(38070700005)(7416002)(316002)(8676002)(4326008)(5660300002)(64756008)(66946007)(66556008)(76116006)(66476007)(66446008)(8936002)(52536014)(55016003)(83380400001)(110136005)(33656002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K7fyT7Xxpy3js0XuNqQR7pVFdmwbAidD34bA6g0PCtluk4iZRQCBibMNCF0h?=
 =?us-ascii?Q?xxPAk+/vy9DhH6qgxreabfhX4+5kcStvTiPY0ddQKwca9N5WboVz6nisNtqN?=
 =?us-ascii?Q?p5+/3uhEz2P/dTxBUjkkjPDqkWeAwf04nM6Bvvz4wMPbcSaAMb2Dp2zl9glR?=
 =?us-ascii?Q?ocYc0a6QlWssSy0dJZLlq0XMf/aTLEDfT4cMv96ffjPR03ZGLJqa7qXzPeK+?=
 =?us-ascii?Q?iHY2CrQI1L55i7MVw68METPc1/jGu1ZD7X4uM6V4EmqKl4Fw5/WN3gkE/Up4?=
 =?us-ascii?Q?CtKD39tjaq/DMdKSwcjIEsxsgJYORlTvgyFkAUDes6kaqzKcDABzhvRbqId8?=
 =?us-ascii?Q?ZmyVrluHdZKiLcjtE0pRAnU45sf9AbrGa1/jx8TiTuDhnk8SQfRAECpjGB6P?=
 =?us-ascii?Q?eiracePQgFIl+kpKl3cwMVywqETr7Wfr99zpP+yz7AiqrOZgn7dgBH3hFN2+?=
 =?us-ascii?Q?DVjc6LY4EdpSaNAbPq/Qyz4EXzYNXfXUqgtXHLpcUaaRazY/IpEPmTYcOlch?=
 =?us-ascii?Q?ddI2zJ67hBqMbafTj3FxcUcIM5m2kHyJ+j1riUY19ZK5si3MMXh9r+fC/QrW?=
 =?us-ascii?Q?irUzyutYvkhlHdAZ+0cROaeOkLy4soLBgRhXyZ0VnIwtLI1icoa2eXXuY09x?=
 =?us-ascii?Q?CbTFQhZnwftEIxJNLN92nP8mdT3nqqHqhvn8wCY/NSWt3ZpRAUP3d/LVj9zB?=
 =?us-ascii?Q?DuZ/RNCDevuxL8bP9JBQAKTaR/9o69MDocegrIHFN9kLEaYYpQ3yy8YCFw41?=
 =?us-ascii?Q?0uZgda0vN7adbMTPdk1N2gHdIVdWRIy5APwbW/2C4DVSykk9+UD0fs7GvY1o?=
 =?us-ascii?Q?XSrqeVUHn8ah3HDkYqDnZ4RjgBqZ6epw+wHqJLNQDZDpQq3f6Hqq4DIYlIjD?=
 =?us-ascii?Q?VMalw2WyfZIl6ebf0JGMuY3z757t7omMwS2/Uj6OJoRPJ1PvIOyPFt782+u5?=
 =?us-ascii?Q?nKyYom3KELm2T6KyC2jnQ1Qb1Wi/u8wRIreWmrT6fYKx5FVmNgRqMU86RmOg?=
 =?us-ascii?Q?sfwITU+oPF12/ymFL45ZiqB3ShxpIt+iqD0bkeU6suBQf2Zsd7Myg78Q0TC2?=
 =?us-ascii?Q?o0lp1LETr81QaZe3Z10IeefJ68kIJvztna4ZGdUYkFC8k6lscDQaemmxKObh?=
 =?us-ascii?Q?jnkzDhUF/qcBlsMUQINv42grZmsObRoix0Jfde+4r8UiPiYuk2JIlFOZtrj3?=
 =?us-ascii?Q?/jvV1INN5rvqMtHXpe88EmZZ8OpBKellEdHUTrq1qvVSk1ayOCORT/3YENeE?=
 =?us-ascii?Q?CaEezXGWvXv1ZAACE96xMRJ7T6mwks3ZmHviRGpQpNNpxfDDqXIk1TpTNSk+?=
 =?us-ascii?Q?HNIuyZ9wPtR3M4IYHvT3TE8dc5bgBAzRsFhziaTMhr3avTvREwKP5IazTI1k?=
 =?us-ascii?Q?if35d3tajz1G8XTyFWWOFNO3aK0BxoRYprMka3ny9yepHqpWmwMKet6wlZwH?=
 =?us-ascii?Q?yGLqVGdd/OGdXQbsCyqtrPKDEodKHaoA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 130de06b-a1a5-4763-05f1-08da0679ed85
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 11:49:57.0667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PBIozWutrrfJlI7DGXGV9KQK/r1CjQX3DiTVd6bUSsSxdMdNZfUVwEzraaDowin36x++Z+an+EY0pnP4vghMDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2805
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Sent: Tuesday, March 15, 2022 7:27 PM
>=20
> On Mon, Mar 14, 2022 at 10:07:06PM -0700, Jacob Pan wrote:
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> >
> > An IOMMU domain represents an address space which can be attached by
> > devices that perform DMA within a domain. However, for platforms with
> > PASID capability the domain attachment needs be handled at device+PASID
> > level. There can be multiple PASIDs within a device and multiple device=
s
> > attached to a given domain.
> > This patch introduces a new IOMMU op which support device, PASID, and
> > IOMMU domain attachment. The immediate use case is for PASID capable
> > devices to perform DMA under DMA APIs.
> >
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  include/linux/iommu.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 369f05c2a4e2..fde5b933dbe3 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -227,6 +227,8 @@ struct iommu_iotlb_gather {
> >   * @aux_get_pasid: get the pasid given an aux-domain
> >   * @sva_bind: Bind process address space to device
> >   * @sva_unbind: Unbind process address space from device
> > + * @attach_dev_pasid: attach an iommu domain to a pasid of device
> > + * @detach_dev_pasid: detach an iommu domain from a pasid of device
>=20
> Isn't that operation "assign a PASID to a domain" instead?  In patch 5,
> the domain is already attached to the device, so set_domain_pasid() might
> be clearer and to the point. If the IOMMU driver did the allocation we
> could also avoid patch 1.

iiuc this API can also work for future SIOV usage where each mdev attached
to the domain has its own pasid. "assigning a PASID to a domain" sounds
like going back to the previous aux domain approach which has one PASID
per domain and that PASID is used on all devices attached to the aux domain=
...

>=20
> If I understand correctly this series is not about a generic PASID API
> that allows drivers to manage multiple DMA address spaces, because there
> still doesn't seem to be any interest in that. It's about the specific
> IDXD use-case, so let's focus on that. We can introduce a specialized cal=
l
> such as (iommu|dma)_set_device_pasid(), which will be easy to consolidate
> later into a more generic "dma_enable_pasid()" API if that ever seems
> useful.
>=20
> Thanks,
> Jean
>=20
> >   * @sva_get_pasid: Get PASID associated to a SVA handle
> >   * @page_response: handle page request response
> >   * @cache_invalidate: invalidate translation caches
> > @@ -296,6 +298,10 @@ struct iommu_ops {
> >  	struct iommu_sva *(*sva_bind)(struct device *dev, struct mm_struct
> *mm,
> >  				      void *drvdata);
> >  	void (*sva_unbind)(struct iommu_sva *handle);
> > +	int (*attach_dev_pasid)(struct iommu_domain *domain,
> > +				struct device *dev, ioasid_t id);
> > +	void (*detach_dev_pasid)(struct iommu_domain *domain,
> > +				 struct device *dev, ioasid_t id);
> >  	u32 (*sva_get_pasid)(struct iommu_sva *handle);
> >
> >  	int (*page_response)(struct device *dev,
> > --
> > 2.25.1
> >
