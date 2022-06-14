Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6341454A9D2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 08:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352528AbiFNGwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 02:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346654AbiFNGw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 02:52:27 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4B964CD
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 23:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655189546; x=1686725546;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=85e1UMqKuwuCoQhGLR/mqw6Vc/N2llCaCojAXh22SLk=;
  b=XHxEHG8q9ENvjUAS++ldEbn+1rut/gBIAwtN9yv35wyUKRg9PBc49l/N
   AIF1wqPmBcwDOpWfOOX65g/JfTP1V9+Lh7NvgEGHX2hHA9SHh/2EueeDB
   ouZ1R7FMIo+e+Wtq+/RKPkZFqDY1QvlaUbgrPc4APiem60CRIpprJK2hH
   kSlpvQjMDOMoVsqYyhDyzSdSaJnrA97IanCpKlCfWY9DZCXqS13YMdmnq
   Ft7Z3qgvRbBSsN7tKCFezotJI+W1engfjSscBSyC6/ScPdq5WTKGKw5JD
   5dLvJRMU45zue3yIuDUF3a4Yl7g4ERGoMmfx9Z8LLc7BuAt2LVGjzVirN
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="279245509"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="279245509"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 23:52:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="582567687"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 13 Jun 2022 23:52:25 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 13 Jun 2022 23:52:25 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 13 Jun 2022 23:52:24 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 13 Jun 2022 23:52:24 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 13 Jun 2022 23:52:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDMGR8JTcfnYuut8g59308Lbxtn7wD8dSsw/wfWwvQFxmmJmN5yvdnfZbxSszcDpwaR1c+fWVp7cdDZkbEJSh1SRy1lsxj/wtCoQu0NlWjN049UUcZuRFjLi4VmrTq3cQO/7QGLm9aH9zud2TFcYu+CwEhN0mj3Ci2HCQb6Pg/fZmE0kWmujy8fEEo0IfbJtuRpAUb/R9/H6I7XkjWFMun4iOv0FqmV3m1yReyYUXxucQiAdWbk8H0dpGS9saOdQ7/FvJJq6UTleTlxB4UrQrtRn228wmFTw9ycj3+2td4ghaKAPhWr4I4iJSFagBz5lXpWTmvrdLc728WhrGeXcyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85e1UMqKuwuCoQhGLR/mqw6Vc/N2llCaCojAXh22SLk=;
 b=eGu1EI29tqHZziQUARMObkNDmplyM6SVE8OYeGlxBPKOsEV5UynIZKaPdwtDpqfE0jVoUJYfTW2Q6C8GqA1k2UvU2TgiNzXt3LPvalWiemKcQE9O7i+EsKlvwLKqtPYMsesuSrC9dO3kT6x3TulHLVFJI+w/3TBrgA6BXmfkiyzR3Dzf+GOnjrcG2C3NB7TQHCTX/Ei3BkceZNIJKonDC+C7aI6jdsTgWR9xnfjC/V8Jtfon4vO9Z3PNne3ZUVo8SYOnejGmrp3G/vtJR8fEjx43TbNOsT/T0dpAnEH+NRZER7e/XDGhS6Qc2D2Qzquj9Ziz4KtLhy04rJNZQ084/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BYAPR11MB2808.namprd11.prod.outlook.com (2603:10b6:a02:c8::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Tue, 14 Jun
 2022 06:52:22 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::3583:afc6:2732:74b8]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::3583:afc6:2732:74b8%4]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 06:52:22 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Jason Gunthorpe" <jgg@nvidia.com>
CC:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 06/12] iommu/vt-d: Acquiring lock in domain ID
 allocation helpers
Thread-Topic: [PATCH v2 06/12] iommu/vt-d: Acquiring lock in domain ID
 allocation helpers
Thread-Index: AQHYf5pFYVqv0RHcw0ObtwmCOrPu761OdpjQ
Date:   Tue, 14 Jun 2022 06:52:22 +0000
Message-ID: <BN9PR11MB52760A3D7C6BF1AF9C9D34658CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220614025137.1632762-1-baolu.lu@linux.intel.com>
 <20220614025137.1632762-7-baolu.lu@linux.intel.com>
In-Reply-To: <20220614025137.1632762-7-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f2f5f14-d421-4e2c-776b-08da4dd26ed2
x-ms-traffictypediagnostic: BYAPR11MB2808:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BYAPR11MB2808309C76AA9840AEF7012C8CAA9@BYAPR11MB2808.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IlqV38Ak+3bG0DANPQxbOFlBEcMCYv9VNM3v4pQJfrXjTOqy8ABquaIcc5g2jPbwJG8h6FqYppZQHZ8n1Q2KsiiS04SDaP4Z9wnW9XXVjGe4gERPrt/1tfWl4uiBEIGGjcPqRO27axj6EaIduk8Wv9BgGWSc9juzGwpQH036x6gtdYM48me7p7gJYzElC6U6CKCi1FIEkztsMhm9h+sxrCnDBiSpJWHUa4cSbaL1JNd8DinF7JC1BKGPeL5qe1bE67bQ1I/XQ3cF68yXtTaEwq/dX3A93vpYkOJfbFCT4mjqhnRivjqbihY2Au1LdKTLsovqwCG25vZ35BvfGhTyDDbuVytuQGdpyVwuB5aq9k4dMLKO3ASZOV2LbSRGymg40q/SvxS4VKY5OzCGD2AIJN6uuHmMyw2oPHKBz1kBhGaOVzaSjPPtoZWlm8JSbYqbMDcEPI5kFZo+yD47Rxs7t87cSEfhDjpdU/LhydFtfGEE/JWV6A80/6JZNvj2EZAQM3hsaF7qPRLv1WuSONGc6x55kOtcpuz3oHqfkhAJnA7ZtAShKV96Y92OmAOaoJaHO0Pzg9GTLZsTzfUBVqLO40ENt+0uqq1qMw0cUrM0cOF0b5TrAellP3yvzeW0gOdJ9gWrfJXddG4jn8PTSY1WoI0lhTyVIBWre4MZ2trkkFgQrkHeH7cuoFDZtS0Y4oV1jlTsmXf/7So1imQvsQsUXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(8676002)(33656002)(86362001)(64756008)(66446008)(4326008)(55016003)(82960400001)(4744005)(122000001)(5660300002)(66556008)(110136005)(66476007)(66946007)(2906002)(71200400001)(316002)(8936002)(52536014)(26005)(38070700005)(76116006)(186003)(54906003)(6506007)(508600001)(7696005)(83380400001)(9686003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uETHKWNiduX1qS3cSKy+uKEnptSEMi1v8l/1+2TPSNE6gWKiYlXRksrPvkNh?=
 =?us-ascii?Q?GuVFPUhgKiYgBaEewc233ljD+g5/pkLKNKFMHgPVoyZvQ9ch+fSM7PWgUOpO?=
 =?us-ascii?Q?aOa+B8HyXjKndLRLAXd6xx+f2x6IlPRgimvwVQtJFm/mJoUwLGFetRPJ89iP?=
 =?us-ascii?Q?tecTuSL7vcil8fpXWvTyDXjDvFDpRCk3zOCw7UzugkI1f9I7Y3g0YJ89iaBv?=
 =?us-ascii?Q?Pcuy2HujcrMW1ZH7O8sq52171CmfyuVKEO9UIRhCzH7tDfmj2WDTrg5Qv789?=
 =?us-ascii?Q?0I1TshsYfF/DXvqjL0k5R/9TvOn+uRzcc51gPQJy9h7ZXh8xGQge0djBEpjV?=
 =?us-ascii?Q?KBIworXI/T8wSDNo9BQhpgL+G281Oe06OXCfZ86E3WiAWLU1emKWDa5+nqOn?=
 =?us-ascii?Q?HVRod3UvUuFl15dHOPBOaftM87b6QJHjj6qUX5IBisX2gsjd3fUnk33Qhay2?=
 =?us-ascii?Q?Rp396L/l+0gMEs2mYhzhgZamVa/UY2nZkVTgXR+o+/boXVk/kXjTu6Zo07GF?=
 =?us-ascii?Q?pdoEWXJWfnPo52oP43elnyrlVQcjK2kbIDOJsVNlt8qVih8eIwKEsLDbYQWh?=
 =?us-ascii?Q?CkAwhh+0ZxfWwScR9BcaFoMnZ73GVPFWcc6HYagfPV7O/1U+y1dgWq41cXeb?=
 =?us-ascii?Q?XeGMWh/CVfwfXg1KVz/zZwoEXi8iN1xcTyFmgSBPT/s3qYWeMG6tH14dZ704?=
 =?us-ascii?Q?xp7aaAPcXyr7mUBdzwMiEP7Ol2Idzwzmcb8kiYuY9HpEUwxHziUkEYB+QD8Y?=
 =?us-ascii?Q?POTt5jLjTajHoFbF6hZxtmDPDOhPgPPulBewca/JG/7QpVKTTd5mGovl2hp5?=
 =?us-ascii?Q?Xo0IGfECsHNCiheyBLF8xzxt3WEqGEumsD+FyCxNbM/mcaa7hq7vsdGGRZ+Z?=
 =?us-ascii?Q?BkODqO9aob0DkBdacwg9fGB1ZPykNq1ZkVGwMYVDyGA1IYUzNWMo2fXdCfIe?=
 =?us-ascii?Q?1kRif/uDrMiA3XdLPsaQ4ZGY+BPlwXzK/YtbCZONK7DHx9j2qs+HjpPbHz5f?=
 =?us-ascii?Q?OgTlqw3Ks2okELAN6cuw4g53FWnFe9LC653iooH5m4U/stth7DTTeFlI0mFj?=
 =?us-ascii?Q?Fr3OVgLCHAKtXggUa7wdISVviuok8rDImwmRu1h7lAOF7DxnliAnwHnRjvtP?=
 =?us-ascii?Q?12bGOwkLt8+SLQZ543m7Q00k0TonQRgKarUK2QJFeo3jfMcrJrj1xlCENSoK?=
 =?us-ascii?Q?G8ZQK/Hlfx8TIWGnBL8tyPp6jMnPBkIAyttFn8wrahs/Sq1Wj8RT8kuxEwXr?=
 =?us-ascii?Q?nrWrO7j/+LceLOtSUpKC//8aWMHCoMiVDc34Y7ywh4l9w2vLMKl4j0vxkXQD?=
 =?us-ascii?Q?efBV7XOIqOxuZnJI7OILlgRIq3hRnE6osu/DFMEhzi+r+Y21A2GFQZdgTwZ2?=
 =?us-ascii?Q?+96GxoKENJS6GZL0rsrRr15YvoV/HL9hjBvC7/Rvi+s/1ckJzB+JFljLGxnA?=
 =?us-ascii?Q?L+r5rEi4y2HRn2v0y9MUDzMcv1NXSplheKE3nTJc/orGP1253yfeTEFd6ys7?=
 =?us-ascii?Q?dDUYo52sLjDX4WkhABVTmcR8Uduv76vvEm3HiL9Mcj8xNjzitNMEQn7C6hdv?=
 =?us-ascii?Q?AjLq/vdo4KwtaQslH88kaANBZiLlFkwihOeG2obksBmvUwSZlZ+ZYdweC7QM?=
 =?us-ascii?Q?xlcNjG9Ioxnojsx017QO9k1nrNbPm8psWgY+HnbYR8Lg3zBbssts/qfekRbR?=
 =?us-ascii?Q?MMYcA7xJEZ46BbCDjyAf0jEAJM41kbBoRS+Mb8fjJD1Vmjozqh8Swwdhsg6T?=
 =?us-ascii?Q?xZT/MM8ygA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2f5f14-d421-4e2c-776b-08da4dd26ed2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 06:52:22.3948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ocARgZkFSpxDO2veeTIWXKhKIbqRbDsRJEKmFK59zu8aDwmbKL3emWKAaJ/DPRpycir/22+5+BCrKXCOfmZ7BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2808
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, June 14, 2022 10:52 AM
>=20
> The iommu->lock is used to protect the per-IOMMU domain ID resource.
> Moving the lock into the ID alloc/free helpers makes the code more
> compact. At the same time, the device_domain_lock is irrelevant to
> the domain ID resource, remove its assertion as well.
>=20
> On the other hand, the iommu->lock is never used in interrupt context,
> there's no need to use the irqsave variant of the spinlock calls.

I still prefer to separating reduction of lock ranges from changing irqsave=
.
Locking is tricky. From bisect p.o.v. it will be a lot easier if we just ch=
ange
one logic in one patch.

