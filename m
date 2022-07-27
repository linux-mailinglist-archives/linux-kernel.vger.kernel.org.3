Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D141581E2D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 05:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240286AbiG0DUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 23:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiG0DUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 23:20:33 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA40DF2C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 20:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658892032; x=1690428032;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LSNh9U7A04Li197e2F9QMs7xSOMs+NB6yh6gf+9LUJ8=;
  b=IMT0afb1n3YjaDW9QLMuf2Pw+aE5F/kXJkk5BSgvoHBibi6aDo/OebKY
   R8Uk/XzH8k9P77hsbd1A4iVYalGYfbSqVm7jlD+ZGk6TkxLiLP0dvX4Cb
   G9hLMjYPhXVtbcl9enZMFayjws8bUeKA3BTgOwywvMtvOtvU1M7uW8Tdy
   zqC8y3OoBET933U1xJnz954ZoNUW7tlJYol4D25s4XRTpUWExo9L8G3Lq
   Khr96B17DFpLAnyGmStaFczBDDZbg4fG6tGj/CK1zlUlN0J3PaAdsGyFE
   Pjot2yVSKUeMHm+TetscOlKtJ8GelVEJzoiUFXHQnfDS2pOpN/iGYdciI
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="349835811"
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="349835811"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 20:20:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="668166579"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga004.fm.intel.com with ESMTP; 26 Jul 2022 20:20:29 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 26 Jul 2022 20:20:28 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 26 Jul 2022 20:20:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 26 Jul 2022 20:20:28 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 26 Jul 2022 20:20:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWDPTJ7f7A+xUOzdGCSE/xWyYeVoZTHD5lq6BZjBJYqF0rILLI5RCq8mWfsdxH+Gey4vjJW61GlYaIdQ1EvQ8WU5fQeu3TGH0+2oE/ZJsD3ucqTaVXxfL0GlkuFWa7RJ8Qz3h6cISbglUJUpOCOBNkb7a0AxSfyDpV47r1NUo7RgGYOWHIHYn6F3m8RAIQx5KSNco8dDdlVzi2DbfZl4E5mb/1otQg8FgSyVXowFNpiBr3u3OIxmQHIAxvFxpOZhvTYi6r7qj7qmwD12zgqIckpqhcs4gGFK3SftCaF0urEmfYWm6cnnOKR3EXdevYnLm4LrujoYk3+jKd6fsnptJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQMcM9CR5CrkELKgYssEfUqwQY7XN2Rs3j4BNc6J56o=;
 b=iHh7kvi/8GEOxI2Matyf+a/5kQv0+KcRB8GXZVdUoeTye7ji0RvN/WW/xi0F5D57ukmkqZQw5fdfmajzH+V6Nc6PqelpZktfCVnL0dyCvONNgmq/BRoLAyMJFltiaHnjMoiGGKefCggT9jwlKrlglus1X7fdC4zINuFA0GeO8TYpLnZYgym9Wj07BP80OAMEKVjKHJn/d0YM1AtzH/mM068gHsWUI9yOi4LXrGbgB1VfCJRy9byF6uQAIzWnL7jwSeCO3C+8OsNmFpXVIsXainSVwC1gMq4DhOay0+UpKDnxWc8hbB9g9vLZhqRdavSwpdbZ25uF1BRiPbNwhjpoUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB3513.namprd11.prod.outlook.com (2603:10b6:5:63::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Wed, 27 Jul
 2022 03:20:25 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 03:20:25 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Baolu Lu <baolu.lu@linux.intel.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Zhangfei Gao" <zhangfei.gao@linaro.org>,
        "Zhu, Tony" <tony.zhu@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>
Subject: RE: [PATCH v10 04/12] iommu: Add attach/detach_dev_pasid iommu
 interface
Thread-Topic: [PATCH v10 04/12] iommu: Add attach/detach_dev_pasid iommu
 interface
Thread-Index: AQHYkC3GvF//WyZOvUaTLdl04LC2Cq2MG8sAgAEavgCAAhH3gIABB5EAgAB+1ACAANqooA==
Date:   Wed, 27 Jul 2022 03:20:25 +0000
Message-ID: <BN9PR11MB5276974ABA5981A7361953708C979@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-5-baolu.lu@linux.intel.com>
 <20220723141118.GD79279@nvidia.com>
 <686b137f-232a-2a78-beb0-e4373bd20959@linux.intel.com>
 <20220725144005.GE3747@nvidia.com>
 <6da27a6b-b580-4ba4-24c8-ebdfb2d9345d@linux.intel.com>
 <20220726135722.GC4438@nvidia.com>
In-Reply-To: <20220726135722.GC4438@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98a26d0d-b5ba-47c5-2d27-08da6f7ef2cc
x-ms-traffictypediagnostic: DM6PR11MB3513:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZTIHpZONRhb7LIX7T3SLrO8f+BW+lHwrBAh23VWIcrqICSQS+/8Jd+Z0tdNUBE2bzgVog+4UFR00HF45k8LpNeX0eoe86yQrR945oMt/fN5q0rJv2cmeP1jkLR75rZ69fJF2/g3VLsdP72Dz+RQ19mJKRQtFbGBUasG6Co+NUZcb2ojSq9M2GZz+fORIAkSrrin15X36Utod9CSkHSLWpgakxMVgOY0gk5ajesJyjr3Xx8OEFS6ml1B4W7+/jPlpsbmg5JghqH9ifFp6Jd22svNjvxn6I805VuMio5CtJpHoJ6dULut/pZfkkTdrubpgavGym8omxYz0HtSVdvLH7mEHhX4HEHqZ6ThZfZFbO+aVIV9Ddq9KNljVmq8WlaesSXVwlew0kOJi1lMbrm0ACs1L5cY6IS2AhJzOu+HefdNqFkTonD7rgbUBWqfBLJcM5ylxTVqTIJ1H7q9wdePHL+cQ555D0orQiYQ0CIkLmXt0SvRX3O/Xis0cswV2fhs3ldub5+NLi4b87Rra70knv22NvHjAhlc6HZ6KR/7yMqnkS4BymKrlxIyPRkgIjuWixx/oUkmpP9vio+7Nh0wAt40YNsySRXsWQoUzKnT3X2886DcC1vzytfmA8B9fMQEU9kr2144YDlliB/kpGjJAdzkqI6Git5ZF5lO/iTH22hrUMe6GNxvxrj5TZBpuOJTzsI4e6KnfCov2J+TNbR5VXaFAEzjeboNnGBVSR31gc7yB7miEAPymC1RlIXYr7vSGrDa6+pd9uT8/Vb6+Io1d5RiniB09l76GHLibD2/WCcJB74WfQQCPRyzbv4g5SW4h
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(39860400002)(376002)(366004)(346002)(4326008)(7416002)(71200400001)(82960400001)(38100700002)(66556008)(8676002)(66946007)(76116006)(64756008)(122000001)(38070700005)(66446008)(66476007)(54906003)(7696005)(110136005)(316002)(55016003)(26005)(53546011)(186003)(9686003)(6506007)(83380400001)(86362001)(2906002)(52536014)(5660300002)(8936002)(478600001)(33656002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FI7wI7E61sr6cKfYZc4/GlandHTdPXfB0g7aTL7mlm6VAjZF8LAgaeWJ3NjJ?=
 =?us-ascii?Q?uJa065TN/AsXYekAFcWqxjwjqrN3aU2pnF50VOTR0M+dsfx0q00vfUZK6Cbn?=
 =?us-ascii?Q?Wu20UX8Gi8KzQxtHGWMV5Vaup802DuvFG4Pgx2HHT3TDp6NqrzErVQ9wT22P?=
 =?us-ascii?Q?xwGigDz0KIN05w9uZ+QfN7G3H5DTxFmcU9A7NEAjipjX1SsNwgcmf0effcDZ?=
 =?us-ascii?Q?3WVb9+JapSuefNyzgaKGdCm8jvwco5GqlWz+Nxx3EHUUHu8J3iUI4LTJY7g2?=
 =?us-ascii?Q?CPrmWoMPmy1tZAM+Y7c5gdrf3fGY0CPerSPkhAT16dP7DoShax8tnZxAJNGm?=
 =?us-ascii?Q?472mWmLWeqJKHjkvfzB1t3MVOJU/uTkptsCfo8N3lMop+vEaD4iB+MS/l5vt?=
 =?us-ascii?Q?TTgP1ecJKOVrrpriuZaVZsphwgR1m68jdqqP9PofDA7j+uZ8LzyDhR184Vx3?=
 =?us-ascii?Q?UkuNJIQDYs5noV+aEFpFXKFg5rX7tSvYtwv2xRj/Uzbf8jst7JwsD9KqsKtO?=
 =?us-ascii?Q?aR6k8/kOyfSOzh1IwxjhaLM0WoLLNoe8CUONkmpbQ3mQKxWDoW5or9nWGFf2?=
 =?us-ascii?Q?lUbVXPqipYo7TgJHb5kQ8p/t/4dRoFDFULLMiBSEIgWPXU/+yQipDQbrXmJX?=
 =?us-ascii?Q?pjT20HOdIfEauK4zqz2yFnVTIGeGY+KTWePh+igsg2RdT9ZZlUkcti9KoVvw?=
 =?us-ascii?Q?KJlKwfi3VK99chTn7scozRLggnPLcnixaMVr5scpePAatSV1oM1mX5EUIiOT?=
 =?us-ascii?Q?dxLwgvgAv8Tr/2Rhz+XGBk8+Ty8MMOKJ+93BeosdCnxcOQveAkAyiYBcB33J?=
 =?us-ascii?Q?8yOlSViVx2akSHc2duxiA8tNseAUZhQ12gHRTtPHwWhawtYKFW9kZgUv/VsJ?=
 =?us-ascii?Q?nKGpNH6gHJvWEq4mKJZkWAM35XCziViX7EqjWNuultTp8sUE090XxRMWopQ+?=
 =?us-ascii?Q?vWj6JqoUqM+CulJrmfRPq8ihdtO4HQBQS56zS30q4AYbHKsc+clm0U8fPIkA?=
 =?us-ascii?Q?fxZ7yTLM7YQdYRr/XafkYEySs8aBOPbTgo7mfupKqLzRiQJw+KKDAHQdYFRN?=
 =?us-ascii?Q?xChQ/GqmM7VFfJUb08w8Fsgxd8baEcJxFsjNVAId5IhghtVtu+C/Ktp0tOI3?=
 =?us-ascii?Q?RESfeharB80I+qtcPcrW8rxux4/XcpLnBuRx8I982NnGl/JqU0uROgz6Hrs+?=
 =?us-ascii?Q?Y+4tzlvliwRkX6nGDy124D4E6kmQpLIL/hHPqV+x90LRI9jN9hcUP6DqpuMD?=
 =?us-ascii?Q?MJ8HjuL5JWsiwn8LKrMSV3PYm1ik3B/WJuv8imuLekMGyD/Qr+bKlHBXo6tB?=
 =?us-ascii?Q?YI2IeMFso6KQ5k78KYdzkas9V9oEGK6QCFTzNCTxmeDc1ftofpx9+Bh8A6Zm?=
 =?us-ascii?Q?o5WeDKYwsbqqOQgd3udJ8cL5rSdbAoi4rC2LGn2QcefUiHusp/1UjS6yb+bh?=
 =?us-ascii?Q?RCnkqSIy/RAAt6vk4Ovab83vXq3Bk6nhGijJk0Mr0//1vnwivU4T8BSu3x+o?=
 =?us-ascii?Q?5FotF0arfjrHrKISmjXciMOLONh+cAs1JejZQctU+vabkq+60wNn89emVNTi?=
 =?us-ascii?Q?gEa9FEOAxvheZPJG0LdPVXbWUV9KbUjptbZbgQfz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a26d0d-b5ba-47c5-2d27-08da6f7ef2cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 03:20:25.5907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LDeuN7x8jry2aGLibnrEkVpkjlHwb8jP4N83EHXiTWFgJQF2WzZHOLYPkXU+geOAI6YUemsy+FNL5NlD7W9ZYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3513
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, July 26, 2022 9:57 PM
>=20
> On Tue, Jul 26, 2022 at 02:23:26PM +0800, Baolu Lu wrote:
> > On 2022/7/25 22:40, Jason Gunthorpe wrote:
> > > On Sun, Jul 24, 2022 at 03:03:16PM +0800, Baolu Lu wrote:
> > >
> > > > How about rephrasing this part of commit message like below:
> > > >
> > > > Some buses, like PCI, route packets without considering the PASID v=
alue.
> > > > Thus a DMA target address with PASID might be treated as P2P if the
> > > > address falls into the MMIO BAR of other devices in the group. To m=
ake
> > > > things simple, these interfaces only apply to devices belonging to =
the
> > > > singleton groups.
> > >
> > > > Considering that the PCI bus supports hot-plug, even a device boots
> with
> > > > a singleton group, a later hot-added device is still possible to sh=
are
> > > > the group, which breaks the singleton group assumption. In order to
> > > > avoid this situation, this interface requires that the ACS is enabl=
ed on
> > > > all devices on the path from the device to the host-PCI bridge.
> > >
> > > But ACS directly fixes the routing issue above
> > >
> > > This entire explanation can be recast as saying we block PASID
> > > attachment in all cases where the PCI fabric is routing based on
> > > address. ACS disables that.
> > >
> > > Not sure it even has anything to do with hotplug or singleton??
> >
> > Yes, agreed. I polished this patch like below. Does it look good to you=
?
> >
> > iommu: Add attach/detach_dev_pasid iommu interface
> >
> > Attaching an IOMMU domain to a PASID of a device is a generic operation
> > for modern IOMMU drivers which support PASID-granular DMA address
> > translation. Currently visible usage scenarios include (but not limited=
):
> >
> >  - SVA (Shared Virtual Address)
> >  - kernel DMA with PASID
> >  - hardware-assist mediated device
> >
> > This adds a pair of domain ops for this purpose and adds the interfaces
> > for device drivers to attach/detach a domain to/from a {device,
> > PASID}.
>=20
> > The PCI bus routes packets without considering the PASID value.
>=20
> More like:
>=20
> Some configurations of the PCI fabric will route device originated TLP
> packets based on memory address, and these configurations are
> incompatible with PASID as the PASID packets form a distinct address
> space. For instance any configuration where switches are present
> without ACS is incompatible with PASID.

This description reads like ACS enables PASID-based routing...

In reality PCI fabric always route TLP based on memory address.
ACS just provides a way to redirect the packet to RC, with or
without PASID.

So it's simply that PASID requires such redirection hence ACS
because only RC/IOMMU understands PASID and related
address space.

>=20
> > +	/*
> > +	 * Block PASID attachment in all cases where the PCI fabric is
> > +	 * routing based on address. ACS disables it.
> > +	 */
> > +	if (dev_is_pci(dev) &&
> > +	    !pci_acs_path_enabled(to_pci_dev(dev), NULL, REQ_ACS_FLAGS))
> > +		return -ENODEV;
>=20
> I would probably still put this in a function just to be clear, and
> probably even a PCI layer funcion 'pci_is_pasid_supported' that
> clearly indicates that the fabric path can route a PASID packet
> without mis-routing it.

But there is no single line in above check related to PASID...

>=20
> If the fabric routes PASID properly then groups are not an issue - all
> agree on this?
>=20

IMHO if the fabric can route PASID properly, and according to
above once such redirect is available it applies to both non-PASID
and PASID TLP, then the group will be singleton in the first place.

Is there a real-world example where the fabric can route PASID
properly for a multi-devices group?

Thanks
Kevin
