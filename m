Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C184DD47A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 06:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbiCRFs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 01:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiCRFsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 01:48:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8095B2CCA19
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 22:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647582457; x=1679118457;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cMfBttPywW73k6oWmCnfe5vvsGoIxLxgLRVafd6aavk=;
  b=HJFGf9n/TtJNBmBU6I2KDYG1jZLIuk61iFixem8xpcGmg6txAFyQuZ/I
   Y5H1swo0DOLj7S309BfE6SXSAQg4bn0izLSRlyaKBcCvtwLfjvGGzTowT
   lrX+5cVYGVU1fOKprr912DytxlLiVJXws2c3Qux/FXRsZmeL1qPPTL2jr
   tANyKK7F3WCC5q6GiM/N55C272GUGP5spwZn0poJ2Fspty+0CZzyqRJj9
   WMFtkUH0Myz1a69GlL5UvIyyIvsvGfJxVwRw6krfnEz8pV95M3+E+Z7+l
   PE1qGrKnUK38Vx59/QSbe0VO516JOKe1Vs/lxy1lIyeCNBgHPe/YBSoVe
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="237001646"
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="237001646"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 22:47:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="647323924"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga004.jf.intel.com with ESMTP; 17 Mar 2022 22:47:29 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 22:47:28 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 22:47:28 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 17 Mar 2022 22:47:28 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 17 Mar 2022 22:47:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHG5cAIWgeK4Ce8pAF0D0+7vDb7tsaspVTc30xQO4XHZxJydUGoO6286fLoagH+9mICRPsU6AqoZ0i7jjhGBmQEy2t19W0vs4CvXLNHGdmLajB7OjUf7dBMAdzkmHM32kn5Vnquexl+J3NlRJscCpmmR7caYlBeJPg6AoBH/in4BGeGAPNKgjDYGiVX4RXso4av+OgZ8Jnmv1zfdCdZE/EPdZfUUIChWtWylKQdZ88mL8jwEHpf5GDPLKC7F4uXDQd5J+5o4p4aR29GzsAIMHteyIKHQKy4Vaz7CZj/aQkOifauGB7oeam2c4y2rSwiLizw/IzAsfTNxiRkoaKpmSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMfBttPywW73k6oWmCnfe5vvsGoIxLxgLRVafd6aavk=;
 b=Jn2NwOOI6AHEhlNECdzyAxGZBUdESnOl8ZB+BAlopHC6d8XjhBzXUHzSbITD/ZP8qgPwTRjUsnPYwjoai+VdYQuJgGN6LovIrILVTt+EJ80N5jzRGsTOk4WmEu5047NJ7vq/VYYHJfOGM7ZP4knYf1xnXdg2HrINCTj3De5wdSghyY2hxkDyG24jKlEmPvUHiw+igI8BevOq5CDBaZw99s57lh0ZTF9zhneOZXX2FGiDJmC/blGsI1hX9OTL4LdfVBtDKwDrgrZ5BBPvk07aFvHOwSuFd9dOQVjg/a44f4egpJKmEtHMSCb+Tv99gEzI2dNBy0GOetswIEGqeRla3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB4351.namprd11.prod.outlook.com (2603:10b6:208:193::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 05:47:23 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c8aa:b5b2:dc34:e893]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c8aa:b5b2:dc34:e893%8]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 05:47:23 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "Luck, Tony" <tony.luck@intel.com>
CC:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 3/8] iommu/vt-d: Implement device_pasid domain attach
 ops
Thread-Topic: [PATCH v2 3/8] iommu/vt-d: Implement device_pasid domain attach
 ops
Thread-Index: AQHYOCoddoPAbs8qR0GMuSnaaH7P9KzAguoAgACG8ACAAAf/gIABbKUAgAAX9wCAAAIfAIAAHCUAgAHuatA=
Date:   Fri, 18 Mar 2022 05:47:23 +0000
Message-ID: <BN9PR11MB5276FBE20A09F0D703FE5C948C139@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-4-jacob.jun.pan@linux.intel.com>
 <20220315143322.GW11336@nvidia.com> <20220315153620.710a30fa@jacob-builder>
 <20220315230457.GO11336@nvidia.com> <20220316135004.61ae1611@jacob-builder>
 <20220316221550.GS11336@nvidia.com>
 <17d73d88e08047f09636cf39edd69892@intel.com>
 <20220317000410.GU11336@nvidia.com>
In-Reply-To: <20220317000410.GU11336@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb1acf96-5417-42b5-f5e1-08da08a2c691
x-ms-traffictypediagnostic: MN2PR11MB4351:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <MN2PR11MB435120AC9659C3C72060B8D78C139@MN2PR11MB4351.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7QHovU1MmPJ/Qx99aiEy10icpMGlrXBV35z6ohn4FaECOQ3Yu6PCJFfPrhS0cgYqM5OCs+lTZTNer6VqFt4ENfvZs/CmfO7SX+g7LNPs5cyKNPhOhT4ZHtnCz5xx2xi7zewhrwGaKqH+thRAYiTEdyPRprLOo1qFYQaQqMNDluDp2R4hRgM+DbUk7WmjJp78PMYL49y/sgcFrTprqM/h9FsaQJsixhp5YwfoPtkl1iBDeJsGueZPW/NrZgVf6ad/5TfF2PQCJgeSdbFBHh1y3BtisKS/JcMHOVYCHHaZTtJKQfbztnhREc8LZknfNlbOrRVOBA2EvEc0mlFiuGlwOPUpFzvW+eIOP8ok8XHQFmQ6DF6HR/71fYc0YbfynTBMA1ZKmlAsc54Km7m+E5Qb13r1y7KPIaBqmE20ryCYCD7Acd/9dtk89WAXVNWYFm1FGJVmjW3iN+XvGe7UbuxQEUqNQ3xRARIkLI1bltUSEMADnUj6qyvKLOGDKsnRjtCuSHArMFv2+cOzmB2cihEiTFy0cfPW0+BoyaQ9smhHzF0ezV8oU9Pfd8twb7VLHZUan+H4rcb+OltlZtEeT6wkuDPkstvdpVdRISptqrHCJLxkIQRoJJ2Fc4+Z9VqgAnMS5+KVyFHBHIFRZEfEBCPYthNLa0b66mKKH89g6FEmCD/VpTdXeyY7gxVFUUArtT1PTlFK5HW3U09DdSbguxxI4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(9686003)(76116006)(4326008)(26005)(66946007)(508600001)(66556008)(64756008)(66446008)(66476007)(6506007)(7696005)(8676002)(5660300002)(186003)(33656002)(8936002)(52536014)(83380400001)(86362001)(54906003)(110136005)(6636002)(82960400001)(38100700002)(316002)(71200400001)(122000001)(55016003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y9u0jXmWHNgdoxN77SSqoyHAaCEgOyQkYv9VALzq/rq1A3uqlUfz7nfJuF+z?=
 =?us-ascii?Q?jHwVSfl83tyRtzrR9mcxr5bMjLKRJT2QLxel2abwMXGSCdG9075g0RKW1LcR?=
 =?us-ascii?Q?E6bvjL/I36w5s3AB14uWtyjiXObWlsDuhKJvAxjk5SuMYsCg1ZhSb8ykIVtt?=
 =?us-ascii?Q?5irNANkjlkI10tLV5/M+9xa8M3ptv2pGq3yuTpul+Fc4/ExSVZ6Bwwkt/TOi?=
 =?us-ascii?Q?Gcfeue0AgJVXNcD7raj2YAeHX8iU5mxja0u1yfmgZccljv8/FJkgmcCnXIPd?=
 =?us-ascii?Q?ntBQA+YlwwF+exsLqwzWOnqBsOF2xHYYBP4GO5sG4L4JfVz7usfjVp2RR8qy?=
 =?us-ascii?Q?MnJkQtHL04w4/G01yNmgmNB32KZTMAhqoGXJgnq5rZrFvPM7aM9eHDYGXod6?=
 =?us-ascii?Q?CQdzVZGZrpWE4HTNTL5xa37L3AsDAUQ3tY35eoI61aWnxjRHMCUce0xE+rkY?=
 =?us-ascii?Q?E9gonl+xwfbX6eidpVd9wwRfgrbyz3a1gOCUe2+g+ABZp+Tq5HGT4Sv8e354?=
 =?us-ascii?Q?IpRJFPO9fT361tk7NtVKa9Dzvs3bB6gzZnULoGA4KNh4+KSh1kY94rmFVT8T?=
 =?us-ascii?Q?6V9AHcs63beVOWVc+nS3gm8MEet85yt2btE8GqA5BD68vLng3payL8TwZeFQ?=
 =?us-ascii?Q?Zj/+09c+xPy3CI2vuyISPuSoM3UNOYvQcw52z0KxFwXiJRSwTlK+I+aFZ3Ob?=
 =?us-ascii?Q?F5nPw9TT0qWDgnrwtSvtDGgy6vGB+437UpBPGnD5b71ffl623MA3u9EFr+eA?=
 =?us-ascii?Q?x8FBzIahQWnk8WXQLu4DKawmN2iz4W/0CLzVsWWdpyxnQaZcUd4H0FbrLcSE?=
 =?us-ascii?Q?270dtZ0educb2vmtJcMKwV4Qpbqvqo5wUaTPqMZuNiZt+755InhOC4auRdgB?=
 =?us-ascii?Q?QhbFlrpJ63ny9JK2+lpuOoibSf407P1zwba9QRkubGca63E3WzSRI8uBfrC8?=
 =?us-ascii?Q?MO0txoERMmlxTXWL2tSHtdbL/+r+wadcJVZOKXEGdxQS9FbRHu54m1/lunAN?=
 =?us-ascii?Q?ChgVLvRKDvKM6gO5QytIcK+pYTj7tLHTxtTbItg6wKApRjxs0g7sJWUfasns?=
 =?us-ascii?Q?oeo+mJqhuARpsT6Zxn8gOt67uMbXNGNT8GDnJ92quG/pFeBZdgHsenxkoF8x?=
 =?us-ascii?Q?iXdoCe30vZ61QBB6M4aXYDnCzFUuWI6yV/TJXN/zwrnRf754Aoxb6VYqhEXX?=
 =?us-ascii?Q?a0FvR+JBeYr1gDpzCeWUt9HY2LMYYDp2VSVNcMuW2bsLOIb0WneroW1LzLQ5?=
 =?us-ascii?Q?EiQk1untYQXtXc5PDZH0OaAoqsyjxayTmzblzeqQVD+PEGL0YSjvtC4aaAni?=
 =?us-ascii?Q?0bHYJ+XFZYEXyAEACcrPoGXDhegfUWtb9cpiCdP4z6SW7u74ASC7gqQMcurQ?=
 =?us-ascii?Q?Op5GxcEI3loBhkAnyphS5btdVpH3oAeHoeq6fajPLjC/sF5ePKS3V+0pCs6o?=
 =?us-ascii?Q?UJmZ1fR+4dHsRRExatk6cw8egkJGJTlS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1acf96-5417-42b5-f5e1-08da08a2c691
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 05:47:23.4119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sKITXmdHnMpj32SPN8Xe375P5/iUoJPpoVPf3Ws1G/UrqMUp9nuDqORKKJRgiA5Bi1M4rbugzV48/4ucxkYzdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4351
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, March 17, 2022 8:04 AM
>=20
> On Wed, Mar 16, 2022 at 10:23:26PM +0000, Luck, Tony wrote:
>=20
> > Kernel users (ring0) can supply any PASID when they use
> > the ENQCMDS instruction. Is that what you mean when you
> > say "real applications"?
>=20
> I'm not talking about ENQCMD at all
>=20
> I'm saying I don't see much utility to have two PASIDs assigned to the
> same device that perform the same IOVA translation.
>=20
> So I would expect the list of attachments in an iommu_domain to have
> exactly one device in it and multiple PASIDs to the same device from
> the same iommu_domain is a oddball corner case we don't need to
> optimize for, beyond being able to allow it to happen.
>=20

In theory we do have one example with SIOV.

Say two mdev's of a same parent device are assigned to a guest and
each mdev gets a unique PASID to tag the vRID requests.

Then the guest attaches both mdev's to a stage-1 IOVA domain via
vIOMMU, e.g. when it further assigns them to an user application.

In this case the host iommu_domain wrapping the stage-1 page
table is attached by two PASIDs of the same device.

However iirc there are other tricky issues blocking this usage (Jacob
may remember more detail here) and we didn't hear strong interest
from customer on it. So this is just FYI for theoretical possibility and=20
I'm fine with even disallowing it before those issues are resolved.

Thanks
Kevin
