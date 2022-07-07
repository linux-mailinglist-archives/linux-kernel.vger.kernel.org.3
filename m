Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A375697B0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 03:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbiGGBw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 21:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiGGBw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 21:52:56 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900682ED73
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 18:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657158775; x=1688694775;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2CLiFLj/62tSwIV9s4YKOYJUdadfyqi8Hkdui8Veibw=;
  b=YrnPChJyY2I2jCZmGA2y57tvnYkArZaBd+DRK2BxO+LSomMj2o/xOr9y
   HIvTbjiFHMpuINf/opI0/TEZMo3P12+WfKCXC+bcZhF7l3dODgvRDyhP3
   YlhOlnwxJJt9HlqNSMXfPJxA/HJyASpSibFD6Zijgd5UTU5SNQH5roXcv
   zvGLa9uqSN2U2dRSe0mU/yuVLS7zlEILYm5fY7R/cgdnW4RKL3MWCE4od
   DK7IEM7cekWdiSU09p86DfJLMQZ15J4SRyGRITBE72eeMY6UmkIpfy/q4
   JRIl2Zayqsq5m4N1mxw5YJcgpxIrrguXIe2rt7ljjHrpwJinqZJKY3XIs
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="309464295"
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="309464295"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 18:52:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="650918408"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jul 2022 18:52:55 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Jul 2022 18:52:54 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Jul 2022 18:52:54 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 6 Jul 2022 18:52:54 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 6 Jul 2022 18:52:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejYcO1ID6pmnuw3yXl1OB7J6+7jFPYqFHNsd+TVOELTnxmedQ5Fj572mmz2fafwW5ilrDPqsBsfT+U4tLNkpSXCLVwG3ISH8KWPN0gGbvrMrNuzqyp8P7te3xy/ZoEXliff735AYuJGaJy4wzatSjtF44chQ+e30vz8g6r7nPRTUXKA88rB+NQjSJcSG8/n7ImLdfndMHkx/hVXYsKluOP9QCYQQsvER3UuEXpa4lT3tviE60p2/mEXMt3ONrBk1TyoWbRYV0vYQYKpMHxggQFLGjAxd24wAVIzvYwsLZHz6JfHJOEdO/hdaD3Fg/GmJIuszASTJZ7IHF4ba5U5cFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IffypCPGCAMQyVvYvhIzZ87fJT6bn/FMXA/IXJzYhGI=;
 b=KmS5+mP2LtcJ2Lpe2nfO2OD3cKWcd7/6AWvvHIvJaY5YLTAOLoQCW8QX+AquQc3ooZmNFKA7U3GByJ3NZnE8vntNCpWPVZiKe1jJjBQL+ii8yAroN0iappnk91gEXf0lo6Aze5PXGz1TWLv/CVGL3oTR2ibhjoxVA9UrqFqdGvE5VcnsrcWceaviq859Tph7ho9hLKPwMAAO0vcV5JspFaToORMgnkPZJY+FZ++jXnDCrYZHBf2OCDQOziy/9nBkMnPj9tTnYfH67JQcSuJwM3XfRxYsx6bonBSnrCN5qK6fGJi8oSmDUE0fxeKMsDu7v1po79+JnPKc7OsvS+A0RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5577.namprd11.prod.outlook.com (2603:10b6:510:eb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 01:52:50 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 01:52:50 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
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
Subject: RE: [PATCH v10 05/12] iommu: Add IOMMU SVA domain support
Thread-Topic: [PATCH v10 05/12] iommu: Add IOMMU SVA domain support
Thread-Index: AQHYkC3NkeyAwkFSQUKaf+gY7qZd5q1yJ9/A
Date:   Thu, 7 Jul 2022 01:52:50 +0000
Message-ID: <BN9PR11MB527676D80CA7348890320BDE8C839@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-6-baolu.lu@linux.intel.com>
In-Reply-To: <20220705050710.2887204-6-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af35626f-a22c-428d-76ac-08da5fbb6665
x-ms-traffictypediagnostic: PH0PR11MB5577:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jnvVy+Sh/3FaLBpuktAH4d2QVlTcksTbzBuHZvWmY3faiYhTH7j0XPwtku9UKnrZguX1fAAOFpkFmfxm7dk59vmNAqMJzbt6gnraif83PMwwymUom1RUqRJowO3sHQeSum+1tSWFDGC2WRKNpcBWJY+9/31+rQSLfCMj87YoofFZJSzgn2kKmDp1T/k+BB3X15ko5BNY6uWsIEHbeUChH+jxgFMguWvUcIa3awEDlt4uE4e82danruUg+FwanT9HgCTiiYp70K8bOY9uFxGxlxRy8WInOeH3WRsCrMC4BeZekk3avK2vcL6GyFMx3QP2eDyXDQ7fMuMqSqjRiy04+kj38yY2wSGbe7utzm832yHpABSahBRLTgxs4XYpY6F8/NrxLXAzjvcrb4Pkz+JjAJh3pT7egjGHP8vBazl2VJ1seLVis+V7BbDQ6qXUmr80lhGZ766LuwXNGhXFTKyYqDoE7n7nTfeLBlUM5hQbdp+cHsd81RsdBLL51DgO4h7cLQg8wGtb8UbBZCmMhnv6YYxBx6NZomf3H8YWrGkKOovh/BgMifoEHICstBInCxlCkr7Js0C8Tq71Ps7Vlf+RS5SqHHGHRgwxfKPn49tc1kiuRadmGgwI803Y/knKdE2CrGP/VNO4EwL3RPF6njJY+JZShZcbfe9NbUBF8R2M3feN5VHFieSZ/y8wA4LcKDD9bgY9/UZSqALq+mOIBjQLDa7a9oGivw19FPUdN9I+KMpT6YEyMYLUrsnuaq/eJ8t67ScxnOmQZwrbB5H3q0rYGpDQrqk7n/CMORtIPAgrH0z7n/wzFxA1JWgG2Fnwb3ClkPmcydaLf73GnoVR4LpItg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(376002)(396003)(366004)(39860400002)(38070700005)(921005)(82960400001)(86362001)(54906003)(5660300002)(122000001)(8936002)(7416002)(55016003)(316002)(64756008)(76116006)(66946007)(8676002)(66476007)(26005)(9686003)(52536014)(4326008)(66556008)(66446008)(186003)(478600001)(38100700002)(110136005)(6506007)(33656002)(7696005)(558084003)(2906002)(71200400001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v6NZhDRcfMMUNnh6S93ZYikT/zZY6wl7tU7Yo8Z4NZ3FeWi8/NNEjcgK15eU?=
 =?us-ascii?Q?Tx1Iyx6P5ctH2zZx3+TZkaOV5j5tPcT6GF5fCx50+wMuFTwNzZEPkGq55awp?=
 =?us-ascii?Q?82Jf+wFWXUEsfMRM0KgoQZDu1gQmxLqakHjplUZsn838452EbqqZ9ZsnQ309?=
 =?us-ascii?Q?N8yxyaS27JO8T7EF3F7lfQ4l0si98MH1tzIu2qgNU0Cwf5dFJ+0aaDTDNU/1?=
 =?us-ascii?Q?2EJ4zus19vgDQs5pd2atZuOAgAcr1XszeBNkSvDSvEWrHkpJzM8+skpez8sf?=
 =?us-ascii?Q?6ilJkHGp5xPAr4KB8G5VB1tJhhVaXIgmsI7HOg4KtXmpKekZ5V9DBTculevu?=
 =?us-ascii?Q?p9sO6oE3DdK1acR9zYrzJfCiDnC1YcHPByDz5EKBXXSxbgATLs88KbH9YtYm?=
 =?us-ascii?Q?YduVOXpYLWBUiyhTZ4faZoLIzeKRlHN3x0tsBrJSYZ17+ad+zRxRDHbLBr26?=
 =?us-ascii?Q?gV1iMQhOQvXqnzloJxe4tBPTaJhih1oqJOX1865H1nxor0l7ap7cQo3WGdce?=
 =?us-ascii?Q?jOGlid9fUx0NxykDjTeVr5R/f9VlNxpZIQ338M0iDNEnlsnWWsqcW/914z6p?=
 =?us-ascii?Q?Iv+Ik0iGV+jIgvBoT37YqPYZ+1oOKQovbK2wv1bdXx1i3ms1ep/CsIXfIqcE?=
 =?us-ascii?Q?OMFzC0bqFhiY6+793qfOF9/5veGQbAeztviFfUYYqXx6Vmvxzc2LBxG82OKz?=
 =?us-ascii?Q?k54nGmebva7OhXSMyNVdoNNt9/9NfyiaC8W1lLdqoOQQ297CZdC8kw/yHKcP?=
 =?us-ascii?Q?9TKcw8IoCmxN3yW0F6JKMHnpjMcRCZCrS1Xi5xUf+yAv8F+k/x8Ip/unsnQE?=
 =?us-ascii?Q?avKtq2apv3kDZd6ziywWKDt1kBiT9IEUCCWN/1s+dI5ky58l9jnbWTMm9iYl?=
 =?us-ascii?Q?3+KjQcna4Gc9di76XthI7HGPY/t/vPKtb2vwPqbOB2BVU2rIIN1hpqACKCD6?=
 =?us-ascii?Q?H0TMRwuPREH50SF2o3gmen7wfYoGF5YCh7hFzyzXFv2IjqQMjwc/yXWGQjEy?=
 =?us-ascii?Q?tzMMoIdh2Ajuum9gzJO5o8n5x5MSf96hcU5P8fKTjGo5UuDCCPGO/zW05maP?=
 =?us-ascii?Q?D+AOEzA7/UCCNJaL5/2c8T2ZuQM2Rj/eL23Z8xmq5VOocSJkCTJU6q78Ywby?=
 =?us-ascii?Q?z30f3sR3ahFaIIB33PjnLNC00cBKLRSU863PkVwalz+1cmUsOxhnQZ9JuYow?=
 =?us-ascii?Q?ytcaQ3LHrPiC0jFv8+OPJcwcZgUCMrSKY/mOzNPbSzQnmvSMmYvla7sxEX9Y?=
 =?us-ascii?Q?jMe2BkNTKxW731fa1ko7kQgPWn1e2SaOTAA/6Dccv7gIR3OHBrIAQ674P5Q/?=
 =?us-ascii?Q?mQLuO8eb6Z8zwMBZ/j4EtGx2GD2tnHKiNTlCu0nA4mtL0679CrsvJKBif2Gj?=
 =?us-ascii?Q?1fXlyh0ZE1D5dkM3tDXWwfp+3mxIgVnwEOWxr92/AzjVpnk6yevXJZuzBJiV?=
 =?us-ascii?Q?lH+IQqr9SCWEpjAdxqxWwjdv4BUg3D+kEWnTWUsTLBv3VVxTPVktCzyNig1k?=
 =?us-ascii?Q?Qa1TX1yDKh+p5RTRFBBF5T49Hu0qfwUUW0Ei2+cPFl8zNq62BlyIuO08SAm2?=
 =?us-ascii?Q?7P6ENPkpuXQRxOL6w/rYsTmhys0CLsJ9yLdDQPe/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af35626f-a22c-428d-76ac-08da5fbb6665
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 01:52:50.6711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4dPQUoedC0nzcM5YDLOf7VyyOoa286Bi6YDBBX/b+Dd9uYjFaIXiwfIui01vPzMgI8Y28qzGRBXBVljbcrgxSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5577
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, July 5, 2022 1:07 PM
>=20
> + *	IOMMU_DOMAIN_SVA	- DMA addresses are shared process address
> + *				  spaces represented by mm_struct's.
>   */

s/address spaces/addresses/

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
