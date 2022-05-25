Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9305153346C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 02:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242400AbiEYAog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 20:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238161AbiEYAod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 20:44:33 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DB45AEEF
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 17:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653439473; x=1684975473;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mcbYPKDn/75h3zzrHCTJU7KOB2e1M9QDm8HIqfgO+oU=;
  b=TQIAt7gLBiVjQQh/f7uuxkY1qAfG6/lggsdBAg0TdywdeC2ejk6DRzS0
   F774gVRyfNdsT+ETxDFMPw9xlU0EFMfAHV+OyoiY6bnrr2pHnjoP+K7C1
   eaAoe2dHVp+JzFxNhjw+NFrm4fOl5W6mFSTKVm/py35KDQmSnpX1zcjA3
   cjVl5j1cViVc135sUvIWp4FDacpmCBrwLl3GHQiTIN0stBGP1gatiRsot
   M7Sc1PXpfTXR5D+G3nAwMj7xnq7JDMf931JWtIpHRo6xiAinKgcMS4rmL
   Jj8IooZYK3ZSWIQovP9aVy45RWYtzwFnNkxs7Or9OXsMYzUnGea7OOmdW
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="272502607"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="272502607"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 17:44:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="572916274"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga007.jf.intel.com with ESMTP; 24 May 2022 17:44:31 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 24 May 2022 17:44:31 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 24 May 2022 17:44:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 24 May 2022 17:44:30 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 24 May 2022 17:44:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTIjDpVNrQxUMkdfb7GM6KlMIk7RhY8BUOUD1a7glqyjndRqsDka32NN6v7Yfn5k8G+zVECVn0z0uE4f2/5tpyTGc9Na0fsTWqVt3Jqv7jU4PqIvr/ItFApUMXzOMVZNQpJEZmMIhHIHkAAJhgY9tro5jX8MhUuF+rCVvO4BS9QBV55J/0tR0phrQL1zzC8TlkHyBdXaJtpLvoHNlWWEvhE28nduI9iOLyrW1A2DXfK8FureW8Sd4sWE0yhZCpYsDuP+eRggIukUyKjUQgLi2/uBYXsBkdVzu3NYL0BfejUHVEnfh/Q1ve3x71c9PDqZDb2q+4ntH7E9dhc9bdxWXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBmnftpkNoZOGCLjvbtkmxaZkA1/XhdFIBpDJIMoShI=;
 b=cnzW/b6/Xwgqlkv36jkBhcT5ewYF+2lPpWcsaEdVv0Cgr8OLyUqOFuR1Zz9e/dDnjw9mFHg38asB/hkTUJwWwOAL2JZox5cnhyTmEDYpJdNJb8F1JIzr0kfMa3wpxOkp+SmeCyt5MAyE7v/3efxqditCSegVt+tkP/t50vcHaoCTOybD2ySIoJBTUSPT4oZFuw2sFfhmCiunEnq2CT3EkGtydShYkSghE3O2CLwab8ChqrvSQbF8w75TQH+w60OzSMQfium+H78DwEv0hkxSu3fdlE3S019cMKCvA+acIexAzK6EVcBIBO4aIKyu7U3aUokiekDULTItC+CJHmH88w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB4256.namprd11.prod.outlook.com (2603:10b6:208:17b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19; Wed, 25 May
 2022 00:44:29 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a1cb:c445:9900:65c8]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a1cb:c445:9900:65c8%6]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 00:44:28 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: RE: [PATCH v7 03/10] iommu/sva: Add iommu_sva_domain support
Thread-Topic: [PATCH v7 03/10] iommu/sva: Add iommu_sva_domain support
Thread-Index: AQHYa1GAWzo4qdZhTU6Id4ueE7eQ+K0tyd1QgABGpoCAALM2gA==
Date:   Wed, 25 May 2022 00:44:28 +0000
Message-ID: <BN9PR11MB52767C320271EC422B1D55228CD69@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-4-baolu.lu@linux.intel.com>
 <BN9PR11MB5276982C37DFF0FEFC45BDD68CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220524133839.GS1343366@nvidia.com>
In-Reply-To: <20220524133839.GS1343366@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bf768c8-9b04-47f8-f97e-08da3de7b9b2
x-ms-traffictypediagnostic: MN2PR11MB4256:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MN2PR11MB42565CFA32EE6ACFFE0BD9DA8CD69@MN2PR11MB4256.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xp3r7Gekz4tB9udea6LAr1wP9DE3pOHJojjib9YwXQWTcHkemNNhsAxEZTfZKSANEcz9sLyufLjjhSgMyX5G/iz6uwX0IiKe63VuwOTXNZrwTv+CbHlHUvfodOfwosHLXVsStuLXfeQl4fdC+sWiqr4kiD0j9bVINN63CYyxCKLqDg5nz5jyc1C88KVGePCcfmNJ/T7bOhy34HDXgerSMbNQFBRdKEEZbr+Ame0k2IXQdXVBhtn+1UFE8LEPaY4VSlc5Kd/FsMGfYkQUVFk7L7t3qqme2F+FUTMdFNmYXbYKd293hJUH+Y6bCPiDdWPAehKEUf8slhY02foMsxX1AhgBrqbSkmdvtrEZPKjgqh+TGLElKwkTGKg/TMkMpa6pY0tJPROzlhnlkcbDmLCANRiI9wKKfQAu6QtmVGdnzYKztWMZ9s6+KsOSi04h3ZEiiJSgFqfvCL6gN5JHy+rot+WK7wNDaTJeXc3S3YJkkUOlGKbzknYKa2xvfGRBJnJTmYB6jS2nDefembrsTqA671z7cVQ335EByN7DkYRvn3aUN0vRQMPs2nqvV4xoWWu3MKIIjOk3Q0XxuVJFhs4cy/UANRk6Oq/dQKil4g1Q0gJPSgRpwzoiQVe94w82wBMFSge+OVZTKDjPBanuSyb+gU0aQmGTd94g7Mh+R1Ghii65RdY9yQbWDULf9TXjutbghLCtQ8eR5qrsBLFsI9JtZh0BcxhcjpxUxjKq5Z9u8NGs8R2c6PX95NSnaOk4j7SGTCyvHn+Q59SyxMiPVRbG2I6mx390m/bo4FNsFY+86fo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52536014)(8936002)(64756008)(66446008)(8676002)(7416002)(5660300002)(186003)(71200400001)(76116006)(508600001)(66946007)(66556008)(66476007)(55016003)(54906003)(86362001)(316002)(6916009)(4326008)(7696005)(6506007)(966005)(38100700002)(9686003)(26005)(2906002)(38070700005)(83380400001)(33656002)(82960400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+xeYM7VILk1QNh1tQuHSqPc8zva5jo4lBPdmg4YAD7jEnMo+xLS+3QcLpyz+?=
 =?us-ascii?Q?vci04vf3mvCSc4j80Mv8mevGlAddwvxzj+EGkLDODz0jnC972V+CT5fqvTPc?=
 =?us-ascii?Q?c6AvYqLOvS3fUy+AdNbWXlbKWNXVDFVUarSfo0Tbw2WdRZ72wkGZbzctVhc0?=
 =?us-ascii?Q?X38yCcBuqN1BCcyLRdr8E6mZZCafDJsmwjbyk2OWCxcDmG3O8nVE02PeZbVV?=
 =?us-ascii?Q?UqwYVJOoWN2NJykXfdDQ5t73RZwbYYM8eBjxjVuO4zFSYc6lhPY+LG0lxHq1?=
 =?us-ascii?Q?VJd9iNcdg9+akLT6NCQ8Ebwhr2L1yiF7vgv09OzehFPPEeUsksCnjCrIxmBv?=
 =?us-ascii?Q?9T2d0KSii4WIivsDnxSunA4MsYulWEbEBy7J4tDl3zCdtdEAsBbL0b/Y3yS9?=
 =?us-ascii?Q?TFWTlQwU5nKwuOzaNaHherdhBDnoA8JJa1roncZQGQ08rea9X8aPNHZNoArX?=
 =?us-ascii?Q?twhnuKq+2gC8K3ioC3nCYYgqtXZDnpD2mDpw/6mu1s5KVaJIhs+7Lco+gfBm?=
 =?us-ascii?Q?RPH54dPvaGhLuwfEJHyQmxnma6fwnDOihjjmuLH39QsPOebwaHfCG5O2kW1Z?=
 =?us-ascii?Q?eLJfH57uRv2Sb9Zra1XMI4bIXElav079f5nnzDW4FUCxSuiEi/WtJmQQ6iPv?=
 =?us-ascii?Q?DC8vnCf+XKpM3BEZR4Fx+yxXoFubgUn2lRZToMA5730OzvNCC+x14FIr2WCC?=
 =?us-ascii?Q?Cwf903ogTzNObViXWUk8GzEEtMO929UeBRKfkrLl81rxu27PNbCZtMjaM+9u?=
 =?us-ascii?Q?GYVxPGd67+d3+g2Egif+cyOSxpaouB4N83SV8VMiizsLYpd4QI0rGjqDFLMN?=
 =?us-ascii?Q?1QJxGmjM7xxCEdRF+P53N+ViLuF0sKAS8wh4sGd1sE6xc61KldT8o3GWiyGc?=
 =?us-ascii?Q?apuxcxQSpVzZOWxxgNxHEF8i6SHrSUG6G4Jelx22yVfihYiov5enWu8JsjSH?=
 =?us-ascii?Q?yLgRmOHtPtBhSoTgg7Xm8E18GNwbtEUKFZ/gJJv3o/JbDGPQ2URlHD8FEQSh?=
 =?us-ascii?Q?BHn0qORYb+JvgAkYDtv0qAQb1yAT91uvu8wUXLFKjMSF84t0cFM6kgB9Sw1u?=
 =?us-ascii?Q?DGCaqZ8FlyiGmM91ffMv45iPdkiSo7NZq+5q9XN1bnKPvDFl5DyI+qFIRzfN?=
 =?us-ascii?Q?MPVuBsr9DlDP2g3+RhSyEBQdewafs8EkFdXBO+xbqQzkxE3uMWghRrc/xl5i?=
 =?us-ascii?Q?bjdBcBXoXHRY0lwts/XaFsn+8FHgXb9TrZAG4dkHZcpNA67j2Pn317sZkudW?=
 =?us-ascii?Q?9IQh2coWFQjhzUtRWlbZaoWfNx+6AkkpfUfANyuTzjCozmH+QBluQrWSJcBv?=
 =?us-ascii?Q?hMsZ14TMyXODv3HtjQuFR6letyw/xxeOQSwdPe61yHjZmg0d/YYn7HbZG2Ze?=
 =?us-ascii?Q?Yp1idvKGWiOOo8/oWtQpEmnKj3Y8NF0OU8aWM/unK8bhkaXPeuQ8gc4UZz4A?=
 =?us-ascii?Q?GJko/98yyBQsXRRwmz0kVWMgpRoMu1gQ/dCPuiM31x80Kka2LOonweGF6vJc?=
 =?us-ascii?Q?x1vFxZh62d0Cw/QlU3SI5TupgXBPHL4/6tCw3M5QrCiu6+oOCtcSQgxxmKZ/?=
 =?us-ascii?Q?1HEy3874C74yrFxRF4m6wRDp9cSx3qtUrv7vxGo+CmowiZan28rpVQxb59AH?=
 =?us-ascii?Q?e7NafeyHTNonqUSflADLuD4QZMiXSE+FoWf4pPEiAc17FxP42z1q7rBsJR2S?=
 =?us-ascii?Q?dlxpez0V3Aeh19UIn1Ww9YK0ulR90jIO6B5HPhexKziuTdd+91Zj3GA0wNmI?=
 =?us-ascii?Q?kAzQwcPl9A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf768c8-9b04-47f8-f97e-08da3de7b9b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2022 00:44:28.8444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XKyBsm0jpD42WejYkHHcDAo1BKZVTA/4JhBUSKg9eWBpktAA6KIbiBnXVAF+CJY+pZ7YPrmWO8fSBc6jGKM5Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4256
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

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, May 24, 2022 9:39 PM
>=20
> On Tue, May 24, 2022 at 09:39:52AM +0000, Tian, Kevin wrote:
> > > From: Lu Baolu <baolu.lu@linux.intel.com>
> > > Sent: Thursday, May 19, 2022 3:21 PM
> > >
> > > The iommu_sva_domain represents a hardware pagetable that the
> IOMMU
> > > hardware could use for SVA translation. This adds some infrastructure
> > > to support SVA domain in the iommu common layer. It includes:
> > >
> > > - Add a new struct iommu_sva_domain and new IOMMU_DOMAIN_SVA
> > > domain
> > >   type.
> > > - Add a new domain ops pointer in iommu_ops. The IOMMU drivers that
> > >   support SVA should provide the callbacks.
> > > - Add helpers to allocate and free an SVA domain.
> > > - Add helpers to set an SVA domain to a device and the reverse
> > >   operation.
> > >
> > > Some buses, like PCI, route packets without considering the PASID val=
ue.
> > > Thus a DMA target address with PASID might be treated as P2P if the
> > > address falls into the MMIO BAR of other devices in the group. To mak=
e
> > > things simple, the attach/detach interfaces only apply to devices
> > > belonging to the singleton groups, and the singleton is immutable in
> > > fabric i.e. not affected by hotplug.
> > >
> > > The iommu_set/block_device_pasid() can be used for other purposes,
> > > such as kernel DMA with pasid, mediation device, etc. Hence, it is pu=
t
> > > in the iommu.c.
> >
> > usually we have 'set/clear' pair or 'allow/block'. Having 'set' paired
> > with 'block' doesn't read very clearly.
>=20
> I thought we agreed we'd use the blocking domain for this? Why did it
> go back to an op?
>=20

Probably it's based on following discussion:

https://lore.kernel.org/all/c8492b29-bc27-ae12-d5c4-9fbbc797e310@linux.inte=
l.com/

--
> FWIW from my point of view I'm happy with having a .detach_dev_pasid op
> meaning implicitly-blocked access for now.=20

If this is the path then lets not call it attach/detach
please. 'set_dev_pasid' and 'set_dev_blocking_pasid' are clearer
names.
--

Looks Baolu chooses this path and plans to use the blocking domain
later.

Thanks
Kevin
