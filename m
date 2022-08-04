Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2E75895CE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 04:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238844AbiHDCD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 22:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiHDCDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 22:03:53 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBE35C9ED
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 19:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659578631; x=1691114631;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Mj19/HzOJSj99C/87Wni9gJKDkKNjOuWwuL8vtcILcw=;
  b=m5p66KbPtUDub/gON2TF9Jf8t70UjwN5gGEYUtBwyi5V/c70vHuiZ2XL
   +/M1tGrN200FSlN9IW39nBL8jHpzq3Zbz4g7ZQ6cFWVYzGYdWKJar/VCY
   CGnUTRRUbpzwXljZDkQWFlyg0LOsO5B/9K9/pD/ocufZJYsnuK8TBA04o
   dzuaRJURzCmLXiuG7RGnJCOBlJW5rzMyavmTBBfY0kTdj10wKLge5ENtJ
   Owr0eQBFPr30kD6JNDtJBkBhCJV3eTTBrlGe5ZZQYjsLTjwQcuG4X2vMz
   QX90u/FecyWqKrcdo5lX5og/fA3hrgmFmNamx9zO9koMqmXrc9wDFRVoE
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="376119217"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="376119217"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 19:03:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="606585036"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga007.fm.intel.com with ESMTP; 03 Aug 2022 19:03:51 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 3 Aug 2022 19:03:50 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 3 Aug 2022 19:03:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 3 Aug 2022 19:03:50 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 3 Aug 2022 19:03:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGx273FPj0zgejeBEYtQQBqU1rTG2hZOyav6/9wv/zCb8y68wXeJ3n5klHXQzDrIH14gUq7j31DJI2Gapxx26Nhq02y3xxCkCbyKZSSK/wz/wQhqNDrQFXWNFlHt6lyeBFCZ6e3R4JM2BWGMHQTKbokxzyh+h216FDmhHU8LA2GS3cyVCmtRLMRyJLfPqSvLQEJ+oazB9Fm4HEeMzAkob4V4giDe1eb1MyCz/fF0U714WHKo6E7nshj67jxycnEpBa/zaAWG3rOLJZNcF3pCpmdOoheqd8cqFTcZXymnNcgahm0VEqLk42sDnV3CWG/GbQq7NQ/johrJCf92wmdYKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mj19/HzOJSj99C/87Wni9gJKDkKNjOuWwuL8vtcILcw=;
 b=NOGAcDJblRQaDY5xUr1IOdvuenWM+HM7nWvxQtiYnfEA/sb7Bx7ttx/et9COpCjiJruV4MZXvDNeEIdGMbZGZqquOLJbDQVaxN3IncfKo/3zSF71cVVosFVg+0Wu2V5oXA18C8SqWeI5C486Mze05MlNouiXdfCka9psU2arRGWgbdUYIsncqNBkk/mu9tjWaP5RCWuz0A/4DForEw7tBZTV+QbwN5NopIgAIcq94VzYKRROvAhLKgRmxOdFnjTpL2B/yyHcv/SAb5xIbFmYQuJYC5eqx/FqjxMvgVZdox5oQs5D6sIDOWHDx8R+KYQb0oDVFHGrOmd+XFVIpuA+nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB6356.namprd11.prod.outlook.com (2603:10b6:510:1fc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Thu, 4 Aug
 2022 02:03:47 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::301a:151:bce8:29ac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::301a:151:bce8:29ac%3]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 02:03:46 +0000
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
Thread-Index: AQHYkC3GvF//WyZOvUaTLdl04LC2Cq2MG8sAgAEavgCAAhH3gIABB5EAgAB+1ACACj08AIAArKqAgAGa2ICAAGNpgIAAdMBw
Date:   Thu, 4 Aug 2022 02:03:46 +0000
Message-ID: <BN9PR11MB52768ECC49F90F37EE3462958C9F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-5-baolu.lu@linux.intel.com>
 <20220723141118.GD79279@nvidia.com>
 <686b137f-232a-2a78-beb0-e4373bd20959@linux.intel.com>
 <20220725144005.GE3747@nvidia.com>
 <6da27a6b-b580-4ba4-24c8-ebdfb2d9345d@linux.intel.com>
 <20220726135722.GC4438@nvidia.com>
 <806b1437-441b-253b-7f52-ee7a7a9053e9@linux.intel.com>
 <Yukac8X81CP7gDsM@nvidia.com>
 <3eb62531-fa1c-4c78-c1d2-526a3758a033@linux.intel.com>
 <YurGexaP/Q+N02dT@nvidia.com>
In-Reply-To: <YurGexaP/Q+N02dT@nvidia.com>
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
x-ms-office365-filtering-correlation-id: 49080e61-7004-4a78-747c-08da75bd90e4
x-ms-traffictypediagnostic: PH7PR11MB6356:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0dt7UpcESwH+H9dCINJqffbE5xn8RMBarUhsSX6g4YJLQBcJDJVdnoW0Hr9g/Z9DFA7eM3bvkeXX+RHWLGfZVYkWXjGQQoE1Di/T6q6QVFFpnU617FMi4xbyj7bR2vi9iwO1SjN8gXbN3hD7CUeUHhFWuE4sibaOCcTzINMEyTTexT+vQX52sf6kjF9eyO2odsIsLEFv/0oM35OLycT9cfjSoJnlGUB90vT6UKE5aEcvn7C8XaqemKNy0D3Qi972FuKsOvDdb7Dl9KuL7V0F9RQzg2kTl/MhJuzfqgr7SYMD1URrVsBGE53Hwdn6qawQsW29fhGSADzuZ8UO4KmCaGE+oViYjk23wgKhxxxz21TCEROyF1NDmDjFARjSYQbuJFhvUwfKS7VI8+W7gJnMwWxp+6y23oscvSWSWJGSIRfyEt0SwRPM/K6LW+MvLVKuHDqFvZowrpTVrRUSfW5etHBWyzFDTphsBAs745yp0238cE8ZskhCApxvWGhTehW7gJLoCaM7dB9gC1a70QlMRL6Vo6IaK0Vz8hgy7C32+Dx5DWXSWkcqZ+ly2FG/1kmjCWGrTV6ziXpiHPRZRo9qDYEB9hpVuens3SJEXy+7UB+ghdDs0AiBU5yN9izQz5HDn+Ved2tlfitY/hLWOQg7XOnFhcQtOmQiiuBoMANP5i8UpKuEWzcwghTamp9bmSdwuYnTizt7kmrY1FBMyLYOxLfJaoInCXQLj/aeKHZYm5W9rJ2/kYhxGA8sIzdQBGlgPHHcW1EmZ8FBFdABfGZgn6MMGm1+caAOQgMBRThYACU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(376002)(396003)(366004)(39860400002)(2906002)(478600001)(66446008)(186003)(8676002)(4744005)(26005)(9686003)(4326008)(71200400001)(33656002)(41300700001)(52536014)(6506007)(7696005)(7416002)(5660300002)(38100700002)(76116006)(66556008)(86362001)(64756008)(55016003)(66946007)(54906003)(110136005)(316002)(122000001)(38070700005)(82960400001)(66476007)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p4YI5dHLbAa/Ub8zoGlyD8FLtxm0K3gTXOIKs+W3zj3iWSk3S1H6g7gssQ3S?=
 =?us-ascii?Q?jfoNUNqiNqL9GF1oARDuFxfOmI1qU3CuUWnbCr2flyyuZD3VTjB0GcM2diVy?=
 =?us-ascii?Q?riobQPcJxL7kE4rkpLDjULZj/NWEuFF5yQR3huOGZMIojnEAA8scC3cMhcck?=
 =?us-ascii?Q?FI7H7+BKmv/U9lv8OCwtJ/dHa9pOw5O5cNSS/RGMxDC/3KxC7k2pU+sn2u6z?=
 =?us-ascii?Q?MX34BAHO1LzJ71lJLeQTAHplgnICW4eDfdJRCImex7RIkaN0Xc8VESIE7kq8?=
 =?us-ascii?Q?cVpXJXlhmLos2SdW8sPr+Jza/xPpDq1b6DD/Rh43r0MSd6Ssr+c/x7b7nVJX?=
 =?us-ascii?Q?fgzvA3HqrItI3beDuMbEpma5vFbmvI26IX7/cRNz8oSlG2d7XLKmUNNzKHYt?=
 =?us-ascii?Q?djayln3gCf/hgWTU/2CboIx8mDMwLDuloQex3kX3FlSj4m3pg9WKxRLOhmVb?=
 =?us-ascii?Q?JMgMQrnsQDWPckyHcNSIlCylfaCqn6eocKd1vnszA31vx19Q2aIZ+qaHB/KW?=
 =?us-ascii?Q?hbXfgWMFNzjK1K9ohkxxrQUZlItmIAUrbnoO2dvQQnH0n/de/doPcadz3qtp?=
 =?us-ascii?Q?GwqZfEs79Tv+EZLAr8ogvMOTs2ppSKsK0g91dbSuHHPoIaDomK6wl3B9e8no?=
 =?us-ascii?Q?yvLtLXT6+4p7txC2Cw7ETgMaXTBprJ62dx5mzZdsKRe6OyElIFdxMbYso6Xg?=
 =?us-ascii?Q?oO02PSntNyClbuaSC3m1S009uGy4lxM0TO6p9QanywP7dp5gUQNcGVNWSJ11?=
 =?us-ascii?Q?rrzA7w8j43cJaPoCFvMAp5Vgw163lOCQXh4KnbJrGc7uGN420w8SXXpVetv0?=
 =?us-ascii?Q?dgI8N/QyVpQsjv2Nvu8JXPZCcaob9PE7hfhF6nZ1gfFfaVh8Dzcb11V/6i0l?=
 =?us-ascii?Q?mvMK1sTRLUggKpBk4jUS6yTJFiepl5etid3H46TSTfVnoldTmyi35LK7uCdv?=
 =?us-ascii?Q?Yb0osudBlr/NciMgCNZGtAqKnHXTX8S2yiwafkqVcFw7zM82YGcDLFADXD0f?=
 =?us-ascii?Q?nWp381fu/wRotVKULzRFzuNNSD8opLLJPWTE/n7wWiRYPLWR6VG35k1TLdEl?=
 =?us-ascii?Q?XeN2KPke2y2uHeZad79DaEbWe00rROEJ1S2FXqhb++psYWA0NL5AuLKXzfJR?=
 =?us-ascii?Q?BJ5pLToKCZsDjhk1JpdSW60fIgsVhGXG72ZIie4fZTVNjNkMdggvjjJ00iNo?=
 =?us-ascii?Q?wBD1A/psDwkRc/sSEhy/QvpQZNo95O0ihHhE3933apC3Qf+qfQ04ODAgXq0X?=
 =?us-ascii?Q?GLznPGXe8NpRYwVVrhwaE4VLTkChGJUrpIcEhfIDgKc77LJRGhA3n9PwsSmV?=
 =?us-ascii?Q?KAtseugOWmbalxep+gxTx1YHfJ3BWrnn4I3i5qDhuq9OaSnct1jGYXDQpWq6?=
 =?us-ascii?Q?qe5gOXrvrXJ4nPPm7Ka0RJGawnhI9c8NhBSvNsujOsT6fbAXEFbgzdou3SWb?=
 =?us-ascii?Q?4m0Gh0lQi+Inzybhz/1SCSZQNKw3QBzFsYGjVUfqZ6sQCVR5IoPGJQDAPP89?=
 =?us-ascii?Q?L2fno4fo1UQ8WoC/kB9GqOWkn9ZYNeuNJYfLa0PrVmNb5kz+aOrC2NZ9fIv0?=
 =?us-ascii?Q?ZBV7W+1nSPRiNGGVp/nb1U3L15w7iy+mGNGmi7Rt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49080e61-7004-4a78-747c-08da75bd90e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2022 02:03:46.6350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JC+1SWrpwWjXyefdLOcZQsILtbJSLYcXVv43Z+ItILkRLQIGk9IxoUG3yUPXUIt7/jIi9WdwbQ33pKLxqi1hqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6356
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
> Sent: Thursday, August 4, 2022 3:03 AM
>=20
> On Wed, Aug 03, 2022 at 09:07:35PM +0800, Baolu Lu wrote:
> > +/**
> > + * iommu_device_claim_pasid_owner() - Set ownership of a pasid on
> device
> > + * @dev: the device.
> > + * @pasid: the pasid of the device.
> > + * @owner: caller specified pointer. Used for exclusive ownership.
> > + *
> > + * Return 0 if it is allowed, otherwise an error.
> > + */
> > +int iommu_device_claim_pasid_owner(struct device *dev, ioasid_t pasid,
> void
> > *owner)
>=20
> I don't see a use case for a special "pasid owner"
>=20
> PASID is no different from normal DMA. If the calling driver already
> has the proper ownership of the device/group then it is fine for that
> driver to use any kind of IOMMU attachment, RID, PASID, whatever. It
> doesn't matter *how* the attachment is made.
>=20

and pasid already has an alloc/free interface which already implies
an ownership model.
