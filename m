Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F405697AF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 03:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbiGGBvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 21:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbiGGBvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 21:51:33 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E750A2ED7A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 18:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657158692; x=1688694692;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p0yHLeaqfGgJnGA7BLooPjPidWo/p5NZTTSuSg+lzK0=;
  b=LcPOAAft5Teer86J9qepoZxzILlXNyRVvMVw9uikqsXA6zDwxAXrtWP6
   f38MwW+6UtpEREBlIxML+hwPxRRF3n+Me5MiNyNPBNQGXIkXdgFmp4Sya
   M2mpL630b8D1R8m9fLM+5YDKSzi6hQ/+SPNv1nQhnDstqOoeJLyKZuJmp
   gry3Vyx5/HGK3pJJAC0uFMSOnH5pj1qDYenJLSug53ctSO4EPobnncXl2
   BPASebetmaeBoVy7P8KWjMhIjScg2j7/G8unIZD/n6E1KP/cbKOsec54N
   0c11ep85ILSaJEyQyTYuoZkMJbEAuaKVTAiz2O2aBroNE3E6lBPXI24pN
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="285032262"
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="285032262"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 18:51:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="696333936"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jul 2022 18:51:31 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Jul 2022 18:51:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 6 Jul 2022 18:51:30 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 6 Jul 2022 18:51:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhSE+81f7PugMQ3iUsdfBO/19IvPg2hfDZKzDNQaU4E/E+ieuUAXT2iIbJ7jq2E7s1yYBXRqXFAg0WxAmpk9CIfT0zrzCnyT0mScFNQ72zDfUwa4CqxFH/0bCSICtXOu7SPJWb3kDwVlebnXdp+qqIjoet1MqMk1t2qXRUr/R4nX9tLVtbeVLHddAdXCN3/eL32e4xFShRN79WKLZsBrUkuCSjPi5Ydwx4R26jDRhJ8ZcbJumB6JYkD2BurX/6SpSejIXDcaZSf5k2KMxcm+Ecfxqb3m55ws+FcthNgAk0prAFQolJldtTwOY2x5VFBOkzKJ0fHtzYlC9uGe1vKSrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWWBQcZEVN3X87J4Fq0dbgO+F25eSAzpLTke/kc/8mU=;
 b=gcc8vn7tP1sdmustXZfyIIPXQxJ5RzEHaT9lEBHhYjMlygJb1+rssKdGsktHlp9RIwQdHBqB2rjkUkiPqWL0gGdqhg4KECLihBuJN1emb6MDdtR2A0Z/qoOzTL3+W1+B5P4UtLk0jhD0l8QEjAzmzTGIaBsaR9kYzGbJCvDP+BeLBj8dYZ87Nq0XMUs4MXlDD1AQNDD+g9oYH7JlZSXp81Bha4ea48iDyw4GnUGdiOhMuxmehYpCQgVNOERroPprNCRtQqsaCE4JtvGsBPaRDpRS3TRDtGhg+hgjgBMsgt8RbHTaYZ39NP00a5DVhmz+nA09va1nAFBB6uiE4DtiNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB6240.namprd11.prod.outlook.com (2603:10b6:8:a6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.21; Thu, 7 Jul 2022 01:51:28 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 01:51:28 +0000
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
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        "Zhu, Tony" <tony.zhu@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>
Subject: RE: [PATCH v10 04/12] iommu: Add attach/detach_dev_pasid iommu
 interface
Thread-Topic: [PATCH v10 04/12] iommu: Add attach/detach_dev_pasid iommu
 interface
Thread-Index: AQHYkC3GvF//WyZOvUaTLdl04LC2Cq1yJ63Q
Date:   Thu, 7 Jul 2022 01:51:28 +0000
Message-ID: <BN9PR11MB5276BBE3580F689BE4548F978C839@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-5-baolu.lu@linux.intel.com>
In-Reply-To: <20220705050710.2887204-5-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92075269-7da7-47fd-0ecf-08da5fbb3573
x-ms-traffictypediagnostic: DM4PR11MB6240:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zr0pN6C5ecWjVQceaaTpsqTnJKRU/zdPEmeGEVeLrhOqYBq5gPOtWkMNCUKP2ADCETT5zF8B0X1yhmgrl2PNSRcOOYSW5wjx+WOHBzUpPcC48Lhr/+iDW7izHa1Y8//tny09h73Npkbdelh5019nH3ZBjGFPUQUGQYPHT6jLzsLEO8aO5njeTw4DJqAiJXzJMo3kuKVe37nTzQJQbp8Zgc0Au3+RjI+lPx/WGLSYNVAbftGTjIfm0prRz45ib17j/im7xqFQr5xXJH5u3RLS+PygIUT3eU1dhCyiVrPGNdA7+xAbFNXt/yGngbNJdBvoQtJTsGzSV1irAl7ndcrB4DMoPkJf+SXcFS7kUzcMaNML5km62Fq1a+ydfx69Ake0iLOaYBVY1Z3yeY2jnLPSKqEv1mgaqNIbh8gW/n8H1ZnMLVHHuJXOEbRZWsWqjrTdN9xCqpRe9AoKuOEUXQGuPhxoutfFZLc2zg0jfAwzUOLJYsBJdKhDuQ4104VW+eUy/02a5aCgCLM8jDch9MeeMerRLPePQNdUhuc/piKWrDfd4yzvaYdiFH5nmvgYkKjuRKS3dtQyIlu+j9vNXdoBiroaLTPraROILd0gipsBp9w021skQrnPNNkGxMrU7383xcmogWLOfdGYu1AspkEeT6uaCniRZmmvvv3HRxQ/daD3AyCeQVzHJnpazsh1Vj0fhgZloZ+nrKFpS6LR/o82B0EqD4yJxlD7grre9HuoG7O5vpumICgy5f19XHkTYAZ4TFP9dsKXcAsZ4jtiOsfNfgF8MkDh2Ag7u4KBFKExBVm5ycLCKSOEf6GEatI93Ua7qyG/FsNKV7Cp22cKev3ywg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(396003)(376002)(346002)(136003)(8676002)(4326008)(478600001)(66946007)(38070700005)(66446008)(66556008)(71200400001)(64756008)(76116006)(83380400001)(7696005)(66476007)(6506007)(41300700001)(9686003)(186003)(82960400001)(54906003)(110136005)(316002)(86362001)(26005)(2906002)(122000001)(38100700002)(921005)(7416002)(8936002)(52536014)(33656002)(55016003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hridtA7Ld1hcwOLhUrhMJIQsTCMYpyWvROzcoXRXum+8MjkeuimfEoQptNGD?=
 =?us-ascii?Q?24EJwvRCT7a7Ha5+hyqvxa5CCpM1Mstsl2hORJTBTD2DSRLiWkHr8lUWls29?=
 =?us-ascii?Q?Cxf8y7PP2hY3L/tEJeoXqXFid2B+qlbndAQHEI5RVYb5WpOezPK2XtKIFGCz?=
 =?us-ascii?Q?a6Ym8DhsP+BbMZtIkLnvbOQgq6Ku68Xk3Bz55Ki6oZONEaI0CDWdiEsaURd0?=
 =?us-ascii?Q?vpDkBn6mBJmfApRjqGVSYG3CNq1eBCtJGG+zFu2PQY6jd7o+RZvMYraQOaJO?=
 =?us-ascii?Q?mx+4rq5zaf2+++MqeIW3tRhH6UgQufEuOqet1K03FOptcWgYiPOQtyotjTTG?=
 =?us-ascii?Q?mHA/fRfd1MhmG2rIm3qbM9e5X9JdyFUQhRAIQwQ4T5jaNIXEGI9JC4b2E3Ea?=
 =?us-ascii?Q?AAvJt+JK7TjOVZaTMCMAneXWr7JbsdKfX6KJTSFfh9i+0JOrJdTESF7+0Hvv?=
 =?us-ascii?Q?1xHK2HH/4MuiVsUHBirxzZAMYHGvGGitc7DNNyquPzYR2fUspUgAXlsr4VJx?=
 =?us-ascii?Q?ZrJhKK1QM4FVD+E6rCUq9OUMHirqKRFtiP9WI+FaXu45hFZ5XchH3xJ6/D9L?=
 =?us-ascii?Q?picumck6hFTXbSlYS2l8uz/nSWs+4/5cpJtPOzruek43/A9eX/1hQvnK19TI?=
 =?us-ascii?Q?r9KZT+AVqoytzTSM39qll1ouvzg1lBg9oi3U6ZizRd/5b2gsPCLwmhMLQ+Ct?=
 =?us-ascii?Q?5lEww/WeVS+zCp4EgLZUmg5d1PWu9ukhcygyiYt8qNe+HmHaYWJpUonwtljz?=
 =?us-ascii?Q?LPy+a47TLv7AEzJ9ckiY6wIFDbbreala4FFGjCd39GhJa3Vq64QGBfon9f1s?=
 =?us-ascii?Q?DhxN6C8F+yPlvqqip9bIOKvkpbEtmaU6UUgXbfXmWBskomS2eRLtmCcD+79W?=
 =?us-ascii?Q?DXw6ttx/fNl+XNpIXCqszpS65kAxa0+nisGZhzuCcknzAfuFubus8EyRkECZ?=
 =?us-ascii?Q?tQr8lQ6Wb7v9521h7At8+mMaWSzQPJoQh1PjHBjTI4Zv+nMhPPTwgjBXBLBq?=
 =?us-ascii?Q?zEzGZIarmNR+9yLHHlA8mCjYNJRryJDtopy5P+id31tbFXyWWPqxQZ6yTJCB?=
 =?us-ascii?Q?iUo6gIUtMMh1ZIGGwrDIe65CZXgJu93mXM1v0gTzzmPIGfEFqeLb2bIFJuRz?=
 =?us-ascii?Q?4qPMgZjq31LqfMgrDzDlIVD3ILHxf+CxJurwApVTWeAErbvHZkgLHaD5ytv6?=
 =?us-ascii?Q?UufwrxP717PZgPcrgkQdFiCSKQrsei/nx4jn698B/jenqOfRi2GyB+bE5KWl?=
 =?us-ascii?Q?+nphsVuQTk5Gh3SdZEnTMvPdvaf3OaeExRcjgvp6uSKuBdthEvb5NlH/vCci?=
 =?us-ascii?Q?u7msN3iZbstObt0EuSj8CDJ/tnldM8Et4bk1dy7kaJaVy2tQueYhRxf0f4gg?=
 =?us-ascii?Q?zhpfX9xOn9gpuiNwo7idbLF1UhME+b6Rp3hnwnwzr1sah3x73YZaRyZuCSne?=
 =?us-ascii?Q?eIxGNlshl8RJkDN/OR128fPgpqBqhaPeuG2UA/jlcvTMaeo2J5UtsXNiyU/l?=
 =?us-ascii?Q?ux/HEf7UsBps6ncrNY6Q7t4vqBDljKcsojFPB6Fq4esW5/dF6msqJjzIyFKc?=
 =?us-ascii?Q?m7osPlyUCMUyYMo1eufzvKHivYymvOcrJDPBt1Lm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92075269-7da7-47fd-0ecf-08da5fbb3573
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 01:51:28.6132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 51bWYXfFzeOojmlz636AD8TNOVND6SJFsOOeGLAJlCclig4Un8fWTv5y9RvEcAO9BhRjqOHEPFm2hF1g2VakLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6240
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
> Sent: Tuesday, July 5, 2022 1:07 PM
>=20
> Attaching an IOMMU domain to a PASID of a device is a generic operation
> for modern IOMMU drivers which support PASID-granular DMA address
> translation. Currently visible usage scenarios include (but not limited):
>=20
>  - SVA (Shared Virtual Address)
>  - kernel DMA with PASID
>  - hardware-assist mediated device
>=20
> This adds a pair of domain ops for this purpose and adds the interfaces
> for device drivers to attach/detach a domain to/from a {device, PASID}.
> Some buses, like PCI, route packets without considering the PASID value.
> Thus a DMA target address with PASID might be treated as P2P if the
> address falls into the MMIO BAR of other devices in the group. To make
> things simple, these interfaces only apply to devices belonging to the
> singleton groups, and the singleton is immutable in fabric (i.e. not
> affected by hotplug).
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Tony Zhu <tony.zhu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
