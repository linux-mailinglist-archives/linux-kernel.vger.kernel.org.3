Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8508545FC9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348222AbiFJIpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348143AbiFJIp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:45:26 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9054D205E3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654850722; x=1686386722;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/yYfrawkVGbOgRlKWVIoqzH50YPYBVY6W5/n3FLDMqU=;
  b=AnV3ZcBwCbuoE7B/AkrqRVx5Tug642EuuBdErfa7qktpkiWd6bp5Bl2y
   Pt6eKHp6Yb4QcJmnVCIfnN1JyM2Wi2L66SmBwvEceCBsKn8cUI6jp6iWr
   AAgOZOShJNkeLYTPqu5CP8n6T9DUsIE9tpqFG1O1KvxhWffIm2+XmQZYh
   KQ1k5zm5/5t2maKwBZDVgQe9ruEezMrGsjrgWGRyzLwI5HfP89nJbLjNE
   IhAJO4p5F/xz/lx62kK6GragY9JnTZYp2yKxoSERE6TaKrM846SLRT1jv
   bcIpm/XAb+wMDlvF7uU2Hl5uAxBUrh6p1gmBttSuuSaoLKpQS4V/jCC/N
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="260684000"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="260684000"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 01:45:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="908805596"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jun 2022 01:45:21 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 10 Jun 2022 01:45:20 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 10 Jun 2022 01:45:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 10 Jun 2022 01:45:19 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 10 Jun 2022 01:45:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAUPFHSYNlaXRDg2VS+E3TlxHKCh0vSFWbym1V0P3xXdfxyahWRjCWguZ42obl8vG9QgYNdZhPwJrsZ7Mu9wXxxBzWZAIV/bzYM/BO3BEhK3RbGhEvvDbhPhtcHeQ/Nnnne6Z/2OUbhKcb8fbQ/TMFJ9L0jCnTvDw5eeuS/3HhQ7Gwr1hhbbYK6JuhUJ6E3d9kWsZyi9d1eZ37bwTlAaKnyVog2/4Cbb+GiEwPwEHQWL7Z3yDBy7jysws/xTAnqDXaK2sbwrCyZXJorBxq80TjWNhIkGiA0DNlLWKTN4e7ZSqVY+sUY5uKkLgn9ZAwuABAXCHcqRI/r0TrEVFlg0VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yYfrawkVGbOgRlKWVIoqzH50YPYBVY6W5/n3FLDMqU=;
 b=aUb3YFOcZMjKneTzrdcEsl7oiTC5rVcYBdnQY4aVi0wkIt7vDzZ94jYxC0l2C+3yQJ1O3pxBOsqD3mGwwI95Z6of7e3g6LDl2UCTtz5x2JnlpXjBVeJY5OG7lSJHhdde4DGcXxGyG8rGlPW4yRONjCPEUd4SyQMxKAj63UF8FTm38+TRMPGItBZ5fR34F/OgbIvdG6Wn9FzuxKs+MSnhiFPnyKLinPgkKqMUYmcL1+cBFukjmEzMIqj4ASLHDveJCGOZ8zdiYjngo2eUZE8Pf0sJPj65fC5EIIm9AJ/S6Z1JG2mUCSzvsLRJ5q0JV19U9dt9vK6v7B8SqJN8euC9FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN6PR11MB2541.namprd11.prod.outlook.com (2603:10b6:805:57::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Fri, 10 Jun
 2022 08:45:18 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::3583:afc6:2732:74b8]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::3583:afc6:2732:74b8%4]) with mapi id 15.20.5332.013; Fri, 10 Jun 2022
 08:45:18 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "Raj, Ashok" <ashok.raj@intel.com>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>
Subject: RE: [PATCH v8 01/11] iommu: Add max_pasids field in struct
 iommu_device
Thread-Topic: [PATCH v8 01/11] iommu: Add max_pasids field in struct
 iommu_device
Thread-Index: AQHYehFyJFBi3KBV+06JxIgOSDIrRa1HV8AAgABsOoCAAIxfgA==
Date:   Fri, 10 Jun 2022 08:45:18 +0000
Message-ID: <BN9PR11MB5276A62408BC06F685C4A3B78CA69@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220607014942.3954894-1-baolu.lu@linux.intel.com>
 <20220607014942.3954894-2-baolu.lu@linux.intel.com>
 <20220609172542.GB33363@araj-dh-work> <20220609235303.GC1343366@nvidia.com>
In-Reply-To: <20220609235303.GC1343366@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40dd05d7-b33b-4cd1-f972-08da4abd8be6
x-ms-traffictypediagnostic: SN6PR11MB2541:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SN6PR11MB254169D8772D144FC3F7FCCA8CA69@SN6PR11MB2541.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2WR6RbGBg2pWAwJakDFgrrx66PgHL8pexfM70n64vvxK4vraIsQGFbi3Eq58bWjFvAqvnV2/UL/GOj+s/h8Ebw/8jB7LE7+VXZhLn/ycADC/ZnwIgCd/eAm3F80dp4BdLHvszR0Rg+CZ3BgWSmENrg/JEJ1yF4xQQvZZJXCyu+qTua90CvBPND9nwSCVRnmfvuec6tfBMW59dam2Q1fwb/t4gg9HmrkE6v74BgSxZbszdO3CjoL4Y66EMLoTozWW8l8bdnHE5i9E8D95XemI3DP9qb6J5FaWij7xTFy7LTrMiiar3U2gaX2eaU4TAOnNh2Ewzs1fxnnP/JTNo7XzFjz3O9LN3OkjgOtujgTFEnXspgju+Wd2lu60BMAEuUQ/40Oz9IOuJjiFYHgagEbLEHz6nQ2oimWPoLVGojfXAHr52vK8GKp07xb05mUf0avHqlV+aAEVagmmN38pdY/THjGDKOcwDZrYogScMWFvIWdbezCBHuanS0+tvMZTs/+sVogiJZUUutdJL2m6/ef0T6jna+EosizmuK+uwrVa2u1WWYLui7TiI1InwA0pRa8mvF9V5V4d15ntMuD6asxHGs1pcEMz43uqjWBsqvHSqKN8qdsMhGlKQIMzvQCuGhpjoTcGIynf1CUilYpQlewdld4RKAR8MqNxuVlst600LF2cyK9p5ZFoq8ShE/gxp+Z4MxRzTHzaxhKy7261kP9NrQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(52536014)(2906002)(9686003)(26005)(6506007)(82960400001)(110136005)(71200400001)(86362001)(54906003)(508600001)(316002)(33656002)(38100700002)(6636002)(55016003)(122000001)(76116006)(66446008)(7696005)(66946007)(4326008)(66476007)(66556008)(8936002)(186003)(83380400001)(8676002)(64756008)(5660300002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZlFPejJwmSsN4XBgWIHz943Q2Px2O5bPHk8BEVg/+AJQUSlZn4v2KX3EIGMu?=
 =?us-ascii?Q?1ymTLKciXGO/XdlLK0VD+uvoCVKaRROGW0Jp5wbEGpgcN8NE9QiyGA5OI+P8?=
 =?us-ascii?Q?zIEvAO5kAOqqV+gLASP4F4wdo98uSM6G4Fvm+ytexR90cGC4O70jTW2mrmIp?=
 =?us-ascii?Q?DRQdjOmadtMO7z9ILjt1TrLN9tkIyDeCVQA5qL2VdpXPtfjU1dOLPwz8vcwl?=
 =?us-ascii?Q?L2Gg8jA/hWQvel00MYl/L/Qb1Btl+dKc9qD7G2odG68teI5qP0kJmh9XEZB5?=
 =?us-ascii?Q?F3OP/gY1NusSw7tf+ioSbdbrDvrZZlftSixna4UC0HWTShiFbkJl5RcFiEO7?=
 =?us-ascii?Q?IPlEZbQudovvKPepq5Uhfnmw+lUH/LM3F5u7BN9F3FtXnNSIavRxrx+78t0C?=
 =?us-ascii?Q?2kR8vuSvf38lmcs3yyVBvuqflhN0F/rYtkNAgJSs51bd0H6GDAI9isty+Ehh?=
 =?us-ascii?Q?2Htzjc9ly4OEu5rTqzJ1yukwbuGKhHYOpnZTuxMdwmzbwBrBROXBUbwfHs9B?=
 =?us-ascii?Q?ISIp9Cs6/du5aTk0ZOg3f19H+9/wX8GTyTwxBou/EiCiJw4lAvxb1YGI5Af5?=
 =?us-ascii?Q?QLlME5L2rBBXFHY9L3hc3Tr+DJFFYkHbByjRBqnsB0gJTIPSDHrVNEFWmD1K?=
 =?us-ascii?Q?aTuHpptbCOyxYl4N0smy++HcNme3M2UvOpOvu+V/EhhL6la75ePZ6vKMZzEx?=
 =?us-ascii?Q?2/B/b8hfJu0hCSWTVeHGXrk9BoVWy+o2R/Fo2qAnrPS3Ptv5bF2RXWftFvu5?=
 =?us-ascii?Q?VJTQWW3aqSq9LTpcAEvAhogKkD9mwRd4iZkuTo8+rY83QZZyYEttjDp1Wh9C?=
 =?us-ascii?Q?GoZvXWr5iTs9ngTaVmJHF5IvgWKp/dG64TYTeEpT1RpekMJmt9nldgzUdXHv?=
 =?us-ascii?Q?q5Itd2wf/UhkPGbx6sxgOH5whZiSK55H80Tj3UfgjDVomSocPK2E7B46qDSj?=
 =?us-ascii?Q?AQa3khkQSz2ab/LBlFIKDZSfpXHk7cw/at86URjWaniqS2Obfwidnx/D63L6?=
 =?us-ascii?Q?eIrzSeoZsN4DSxyWFGs7wQkAtsKZiwVIHMYAajn+rxB9+spXuv6NnD7YzHqp?=
 =?us-ascii?Q?5syVo5nCHEW/o5l4eYrtqDEkwjtkcgsFWDG4B4CsUQoKrw/nBrZGw6jt4qIL?=
 =?us-ascii?Q?nKQpkx4LOu9D8nYJutCssZkoj04p0X+g08HHUaZNo0bpbVIU+npD3Z2qlpZs?=
 =?us-ascii?Q?Y/RDVULZwyzbBzwMs/UbxdzcRwAtnJiZKU7bcydzFvUuxJRCyMtwv26Q0I74?=
 =?us-ascii?Q?r7CWrghT2TSdQcBTL0ZD937HL6RPfx0Bq9LODXWk734kZU+hnwihLchV/sCr?=
 =?us-ascii?Q?tmoH88TE0g2S+4UkgrRXnMB3OEsfvg1VTNeLmmK+v/YijqmAa3nIjhAds6ek?=
 =?us-ascii?Q?1Fb5jA40SyYCWolAMKF2TR+o8PwKb1Yy+2C2hcw4pd1u6X4ayuisQcLAkBpo?=
 =?us-ascii?Q?MhgN7gatbmZVmTYJ+nrmK+bmnvOY7JZ7lHnu7c7HR/JYskg6DDg0IrgmgSD5?=
 =?us-ascii?Q?2XQZDXqkzsdcoystWF0XA1+us8QgtletBjhyVjjFHUcqBUMaIrfpjufqsaev?=
 =?us-ascii?Q?8297csszsQl9m8P9EbBJgdK1L9VytV3d9UOd9Fi5AOSS6YDFvvAvRio7Bi5u?=
 =?us-ascii?Q?kc/Nx4i7Y6egbgAZmsrT53jWYapGFmSXLLrWkliyxmTqoOPAgTvk+doJDTbf?=
 =?us-ascii?Q?iHa+xeln3HpS5I+RUbzXVU8uKqpDubqOR8OABOXUVhwEv0idcioiu4OuYm0v?=
 =?us-ascii?Q?WzdHSOEWiw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40dd05d7-b33b-4cd1-f972-08da4abd8be6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 08:45:18.2166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pyUMfj1CvfRK7AVPlBD+/iV9lMFv3tW0oafETuq9owZ9Rl43WWZgEThmzf6x5HLFNzv7zpFl9+I6Z3U9+Ovdzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2541
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, June 10, 2022 7:53 AM
>=20
> On Thu, Jun 09, 2022 at 05:25:42PM +0000, Raj, Ashok wrote:
> >
> > On Tue, Jun 07, 2022 at 09:49:32AM +0800, Lu Baolu wrote:
> > > Use this field to keep the number of supported PASIDs that an IOMMU
> > > hardware is able to support. This is a generic attribute of an IOMMU
> > > and lifting it into the per-IOMMU device structure makes it possible
> >
> > There is also a per-device attribute that tells what width is supported=
 on
> > each device. When a device enables SVM, for simplicity we were proposin=
g
> to
> > disable SVM on devices that don't support the full width, since it adds
> > additional complexity on the allocation interface. Is that factored int=
o
> > this?
>=20
> I would like to see the concept of a 'global PASID' and this is the
> only place we'd union all the per-device limits together. SVM can
> optionally use a global PASID and ENQCMD requires it, but I don't want
> to see the core code assuming everything is ENQCMD.
>=20

Agree. and I think this is what this v8 is leaning toward. The core
code simply populates the pasid entry of the target device w/o
assuming the pasid is 'local' or 'global'. Then sva helpers actually
decides how the pasid is allocated.

Currently only global pasids are supported which is how sva works
before. We don't plan to change it in this series.

In parallel Jacob is working on per-device local pasids which will
then be used by his DMA API pasid work and also iommufd.

Thanks
Kevin
