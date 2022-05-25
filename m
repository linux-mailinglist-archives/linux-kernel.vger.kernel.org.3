Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A532533520
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 04:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243336AbiEYCE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 22:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbiEYCEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 22:04:54 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CCE674C8
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 19:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653444293; x=1684980293;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Hu9kyGLAZULbCDMBxUOmLEpuLSoiyNnJnDM4+AanrCY=;
  b=QcZRALTgNH06Ymagd+ZD+ljfyTjORJc/AhYVgqan34Kro79MCTdbHsdT
   YX4Epyb4Pt/gmWfU5ZnTGgCeYR6Kaw09bynjBYxjl/69oVnGlmoP5EA+j
   8R1MDo+47IPO4PQh98C/vVuw2nXQ/M7JsYasL8tGa2h4kmcg1nqP4eNZf
   xqE9zGwHKK5YFs5CESCpfx1f9sQ2PwsstmTrFxQfG+cMl/9lU8PqWyUET
   R+q06hTWNOvgN90sUfQbqtALT0wG+6BJRn9SDBCQqIjciOjRhRjA1TnWP
   pAyiNkBXti/Qde6ZzGtTLHaQ/qIi7HX18sxhrhf39j/hai+bungd9FGH3
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="360084975"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="360084975"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 19:04:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="630143523"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 24 May 2022 19:04:52 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 24 May 2022 19:04:52 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 24 May 2022 19:04:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 24 May 2022 19:04:51 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 24 May 2022 19:04:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4jD6q/ri9gwAbTUtGpRWaFCWbNhMC2blKuFNAUlES+X+HoWxD0pMrGG8kaILJc486VEMk2yiANqv20B1PhEXPBEG5tBMH/qFr+6n8f1gryKLezYRgEF53LoOhIYMiVp/EYJnaVlc+6siMz+mA6B+ANPF4G7RR+gkeQRFkDW9WtRXt9ZPEpi1guSwqA4Yv3uX5dY7HdcmnALWYCCH1eLEtrubluk/rELApt31tXkMvUUNgmVLdIz5g4aQnHerv3rnSjjrx9QpEUOAI71DHygaW/vxJIH1skJTzNnAaw4FawmP4CaHHic2PBLNRe15EmFaiu7GaDCTeb6+1ltxbMfcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVl8HJ+UuM9lBaIhxZqDoiIa0sGkhPS2Z01tZZsdKes=;
 b=Owo+5+3H607smm2YQlr+ZVv6kWVSIGP+CF+NN5i9z/uIzHIO+ZfJtK87Yd6pRM/YheLyEEk9X5T7eYfJ5lL4MsH9sqK8v0Vgu0KHSbP53fQDFlDHatpBpPYUQbbDGnk1zlNfl7xcSe2Vp71mKa+P/+SEj8BlP1zRCEX9wqVPGkRKWlQlR7jWeDnCNvQZzcOxVNADGyQ0Yx4PhbHH5j4C72sz47K3OrQnHVAV15sJOVHNsxY30GPb8nn21X8IVxjqouxkcy8F47YbhZY92VEeFyaDqUNHaohXFXjShqMs8AsXUEFuyyt1M/su4BPXmZTGFVNoKQbAzy/nSZvNKNd6fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH2PR11MB4408.namprd11.prod.outlook.com (2603:10b6:610:4a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 02:04:49 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a1cb:c445:9900:65c8]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a1cb:c445:9900:65c8%6]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 02:04:49 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        "Eric Auger" <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v7 06/10] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Thread-Topic: [PATCH v7 06/10] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Thread-Index: AQHYa1GHkRXh3WJ3kEuCY8op0Mm4AK0t2DnwgAALZoCAAPxJwA==
Date:   Wed, 25 May 2022 02:04:49 +0000
Message-ID: <BN9PR11MB5276FF0D52CF82942CB84D608CD69@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-7-baolu.lu@linux.intel.com>
 <BN9PR11MB5276E462E3B32DDE54DD66418CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Yoy6NxroLLZup0sE@myrica>
In-Reply-To: <Yoy6NxroLLZup0sE@myrica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd6a4ad0-9051-452e-7f19-08da3df2f2f3
x-ms-traffictypediagnostic: CH2PR11MB4408:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CH2PR11MB44088331C800AF76172E13888CD69@CH2PR11MB4408.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HfmI225K3CqmouLGMqNf+GOjr+ng9aqLtNyUnrAHlfhHvJytEK9PB+XvunRTKWqXlfjE4KQiLgnAk/X/S2kJThw2jOCECk3folrYRO6zxVl9yYGnsk2IRtKZZOLHr2SnkKwt5uS3U+Y0vtxBv58Kn+HXDl7cpwO3qV74m2sgsONBqJ5N57xseiTdz5nZ6dlEeTEQbpf1QBlaj4OBJ4NyrOEhFD/9lEkmvoIQnVvsx9lOBLV2DqvhiJTBezQ0STjaSiUs9DamBaDdRQRN41YPD+f8Cj6rN3HRNJnW0Va1nTIpbe9gX2vtPVgIXvBFyNxITCRB4berF1nJJlEQUXiARvd3KP1+H3z++ZH4mAh563BPAefC2U6ViSDrag67KTCB5iILWGbZe/GsbTKqBrr50ZkYQrirN2bELIb1SU7bIgpAuBqhNtbBvdBO29heusw0jbHCslVdfXOQijMFDSPkxYGDtO+3eg3J8Rz8k/kGVT971gUHQz60Y8cV67WZNdYpr2tfEvZ2LUOiLke6gGB+EOWOgF3JADhcpQiqNziMj8iwaueujJtP6J21g3i3D+NFNU/JZzZ5Fy04BZ0CFvZmCR9Bk9Sza+trsdXGSF1oRcCcGvDdIx8kp3vxvnGnaFf7bpInZF+Nf2JQsKJVeE+7eEjzOUtNQjCGtzOE+9+shhnlfdYuwuQ2bSj1x4DFX5MIWOCBIUCW6MEAh5xueo3uWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(38100700002)(6916009)(316002)(9686003)(5660300002)(2906002)(52536014)(66476007)(8676002)(64756008)(4326008)(122000001)(66446008)(66946007)(66556008)(82960400001)(38070700005)(8936002)(7416002)(83380400001)(7696005)(76116006)(6506007)(186003)(26005)(508600001)(71200400001)(55016003)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A9nozbHkvGmq5GhfVNNyp+PAxmk/SjS6HiiPrBRWe///yKLudQ9+P70MgA/u?=
 =?us-ascii?Q?Me7FTs5yOgjkcm63T9a2NqUzMsWX4nFaOWMscXJ+QgJzlB7QrX/WTQbXV+I+?=
 =?us-ascii?Q?hRuihs0E+3OsO/P/WwTDEeaifSzD6PdeYfHA5i0LDma4r53NYwH86zDp17AF?=
 =?us-ascii?Q?GAr0YP2hDpDNj07fcqzw807iF+YUfFiJVpznfLvsIWsgRdjGTi8mp6d8lBU5?=
 =?us-ascii?Q?QDVSGumIu6SgdRIhPXpQ5MjXto8rqVvqR3GXgtIvEO7nBBkjYiqWTd+oZegl?=
 =?us-ascii?Q?4y+f6oS+XLR53/MJHnA3Ax4Vxd763AXFCekOH9HmGOif8GSJXj05uzPUOR9c?=
 =?us-ascii?Q?AY6d9muLByGUpqkI4saZm8+54Ej4EKMRWxaTMIQF5uLZKVypP7R8BKZNlk10?=
 =?us-ascii?Q?TJhxdtmzJbNzyddymsHCN4G8Y4BrPPJ0O3sdJBq04O4XEOR/OoUs9IedqslZ?=
 =?us-ascii?Q?05xat0biVw5UlVO7bPYTOX7hsLAb130gT05K4ov8C48DX9PbO6mGj4o0wLOU?=
 =?us-ascii?Q?1G+jmfmMCbcgrq0rCI00K0Huo6YqZ91g6PpErDyJAwOdKhp9wsdP4NzqVxAc?=
 =?us-ascii?Q?a7H0GtwJn56GgVjJY73uaunQvhE0rvhQ3qknEuQ8m/yeEoE7qT5g/Dtxqyce?=
 =?us-ascii?Q?rfgpX1LQOBvirub4nTm8yl/yzjhAkhaQ0OfaIJ3d9KOp4zIjNK4CMk4rAz6U?=
 =?us-ascii?Q?iu/gqbOpramFcPKucGVFNLqy61XveGiY4ecLsMU8nhUwB1PCGS4KJjxuhYxR?=
 =?us-ascii?Q?I1CISRV1YYPq29T898+O4iPgywn3x+vU9XtO1XZYNguUhVSQfS0YaEsE+R9b?=
 =?us-ascii?Q?DLQTx4eiITg0ibivBim2b7Ywzj98z9gWlCP/OhXCJKAMZlmq10pUxvyf0l+d?=
 =?us-ascii?Q?d2BPSMVZ7YZ+OkZyYKnfuBjRgvTOKT6XrqAF6kyhcpm7DIRH5Ribounhogm+?=
 =?us-ascii?Q?FQB0qRhK4NI35ayAC2aobA96h4Pc0WwW/UiiSl7aYrxJJf6ukOjIpmf0hUEE?=
 =?us-ascii?Q?Jg1VSUAtMctBbEXsMOiIqo7EWrX4Xze1yQs2X/TwGF0i12D3DCLVfYoYOEKx?=
 =?us-ascii?Q?L/AnJja5VzDDsO3G2oGUAR9USwltOCX7jLaQQVq8IWKM882VmhFyYyBDoP8R?=
 =?us-ascii?Q?bwBlfR889VUTPYW7iWagbI6Y1oAtJrR76Y9ecKNIMxKoO/Tq8VuGO8R1Bdjd?=
 =?us-ascii?Q?TsfULsKfj6p74J8+3n6f7tFBD1rb1etN6OpJ0K+zfFvO6n3GB06oNjK+8z0A?=
 =?us-ascii?Q?aLV4neDryPPQ1GCkpzIruZSMvlXvk+Mca6azJltItLHpAVItlpy11Wl7bvD2?=
 =?us-ascii?Q?uPJoru9W8muVIm5vFNa3T28IeDjs7Chx0KG7PY+b5xmLq4WgygxS4nT6+QX2?=
 =?us-ascii?Q?uTe7J3F+Xg29wsyzxVXmFIjH/vr0UMa3TfgWJDcRwrp4Qqlen4KcKLnygWx4?=
 =?us-ascii?Q?NxsOSR3/pc5q8XDWHqjYTXZxdRwlEHjtINft69ZbjBnwkk4ZMsIKYnJcFlNN?=
 =?us-ascii?Q?t6/HBox8p+xkypx/0hOEuT/89YWTDqqy/WAxT4/wVyLlgaVr7eqmfG2A9Jll?=
 =?us-ascii?Q?AaI+R6mqC+0TsmydhoKrpg1PnQYbMc0v+a3sf7OT0kvaUPxKxJG66xXUZ7Bj?=
 =?us-ascii?Q?hjydHPn8yQ1TPO0zWNYwdY8YyJ+TdvwuO7Eh2hVaCeyLIftYA0VK/dj7rcfM?=
 =?us-ascii?Q?WOu0iGt76EYfdAdrUKwLwqGE6Tx8f9kZTFa50YOXRmssV0dG2XaF49j1YJ/l?=
 =?us-ascii?Q?tNkb2SovOQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6a4ad0-9051-452e-7f19-08da3df2f2f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2022 02:04:49.3301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DLeJlTAaaElKRJED7oH5aUZr1sZNnnYza+9XYs16zY8VRYlVcg9fjlNoSmIQHEIkO+URPymol6anKlRnHzDUTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4408
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

> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Sent: Tuesday, May 24, 2022 6:58 PM
>=20
> On Tue, May 24, 2022 at 10:22:28AM +0000, Tian, Kevin wrote:
> > > From: Lu Baolu <baolu.lu@linux.intel.com>
> > > Sent: Thursday, May 19, 2022 3:21 PM
> > >
> > > The existing iommu SVA interfaces are implemented by calling the SVA
> > > specific iommu ops provided by the IOMMU drivers. There's no need for
> > > any SVA specific ops in iommu_ops vector anymore as we can achieve
> > > this through the generic attach/detach_dev_pasid domain ops.
> >
> > set/block_pasid_dev, to be consistent.
> >
> > > +
> > > +	mutex_lock(&iommu_sva_lock);
> > > +	/* Search for an existing domain. */
> > > +	domain =3D iommu_get_domain_for_dev_pasid(dev, mm->pasid);
> > > +	if (domain) {
> > > +		sva_domain =3D to_sva_domain(domain);
> > > +		refcount_inc(&sva_domain->bond.users);
> > > +		goto out_success;
> > > +	}
> > > +
> >
> > why would one device/pasid be bound to a mm more than once?
>=20
> Device drivers can call bind() multiple times for the same device and mm,
> for example if one process wants to open multiple accelerator queues.
>=20

Is it clearer to have a sva_bond_get/put() pair instead of calling
bind() multiple times here?=20
