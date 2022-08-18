Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BDF597AA6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 02:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238891AbiHRAdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 20:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiHRAc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 20:32:58 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B92DA5C4C
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 17:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660782776; x=1692318776;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xIbJTw28fjSxpUzgZ2gD+j6TkAB7oglnnUvYlaJg0xU=;
  b=am6dKEayVLeaBevHoxGvbug9/qN2ZYx2kqjuogGOBdkWesgGy8/sbGF5
   udWIPhXUKKsSy3LTEUP6Z23oElEqjfHMMcWF0URilcL0/uNleRGywVMyg
   q8eLl0VauTH9kNhedCd0OgTv5oZOfGqD61B181edKaFHpij2+/b+XBUiU
   SEECLxfP/EsuuI7mnfGRBgohXjokQtgShIK9XPP6gV68EupnQf/oBha1I
   iIXgH45S2Y2I/1ALMOUV2+2l/Bu/ZrLRD2HVJ+WH1VmI6rz1YU7lQGBjc
   cNX1NzqIyuCU0JH2/x3i1xXEzUDU1n0YJw3IDLJPZojGP/zYkr08hf8Mk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="354373358"
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="354373358"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 17:32:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="675849723"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 17 Aug 2022 17:32:54 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 17:32:54 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 17:32:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 17 Aug 2022 17:32:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 17 Aug 2022 17:32:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csfJFDvLDV7i++j0pOIJBgFlUzl91cG/Og9dqZPnaTSf6sZO124xJG5UvtP8cj56fReuLewGvx5oCgRDC5OK9e47VJ923ckuzshbQzE3n9QOmkUCHyyfawJuyTRjkkIWUquz9KqQ2cJgoti549IYt3e1OznKl/tVYqQ/uOwf+pBvsNH09Vhw4iWWt+fwPN0UFEUjRBcO0n2PDCvKIGj97IezWitZe9rkOtxiTjv437pn270EaYcHqQMIfCTomfzqbBlodfh+WbsJzdgQ3RRmuylQMw1j+E4ypzPJGUMla41EBrkTL+fz3DsTWoLju5rO04LkaOwEuggJReBfFWC/KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nxwPWhsxFTZWYg1Ne/BTgVLpiqlFiejN1x4Cd/E3ys=;
 b=WupX4VCJZVoK1ul/Toy5i6R9O3BDCskmU3PXjDYrRjpRysmUK0PYNbX8Z9aSXQphANjODliinH9aNNSTOdw3g99Tmz5DlXTk7wOLkLgeTVVaIJ9xRyLtQKMREKIjccW0LUxbEwJhbHgTFcIKSENLnfgO1+fZkdgG+9WB8iaeDKONF5wlSNhEkE8TNgb2Uba0l22zTlF1ilM1UhF7U1Zakwah8ZDvbDBGogbBkhVaMzPynFmKuLSmUYvKPUbr2txanJxEaQoYDL4zArolsHq/8Saibo9bqJepWfUaAmRG1j4T8OfueDbi7pvgi56XAl7x1jhNnyPx6Gqm8ijUwcmFpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3495.namprd11.prod.outlook.com (2603:10b6:a03:8a::14)
 by SJ0PR11MB5133.namprd11.prod.outlook.com (2603:10b6:a03:2ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Thu, 18 Aug
 2022 00:32:52 +0000
Received: from BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::6133:d318:f357:48d7]) by BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::6133:d318:f357:48d7%7]) with mapi id 15.20.5525.011; Thu, 18 Aug 2022
 00:32:52 +0000
From:   "Wang, Haiyue" <haiyue.wang@intel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "david@redhat.com" <david@redhat.com>,
        "apopple@nvidia.com" <apopple@nvidia.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "naoya.horiguchi@linux.dev" <naoya.horiguchi@linux.dev>,
        "alex.sierra@amd.com" <alex.sierra@amd.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: RE: [PATCH v6 1/2] mm: migration: fix the FOLL_GET failure on
 following huge page
Thread-Topic: [PATCH v6 1/2] mm: migration: fix the FOLL_GET failure on
 following huge page
Thread-Index: AQHYsRbS1IjgnpM1/EaZo6nPqIEeuq2yRsoAgAAoZ1CAACcnAIAAxGeAgABL+wCAACmt4A==
Date:   Thu, 18 Aug 2022 00:32:52 +0000
Message-ID: <BYAPR11MB34955C296ED10CF23D372607F76D9@BYAPR11MB3495.namprd11.prod.outlook.com>
References: <20220812084921.409142-1-haiyue.wang@intel.com>
 <20220816022102.582865-1-haiyue.wang@intel.com>
 <20220816022102.582865-2-haiyue.wang@intel.com>
 <20220816175838.211a1b1e85bc68c439101995@linux-foundation.org>
 <BYAPR11MB3495F747CBF95E079E8FC8A5F76A9@BYAPR11MB3495.namprd11.prod.outlook.com>
 <20220816224322.33e0dfbcbf522fcdc2026f0e@linux-foundation.org>
 <Yv0ku1mn4LBzg/zG@monkey> <Yv1kePLTUJbJkpUW@monkey>
In-Reply-To: <Yv1kePLTUJbJkpUW@monkey>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c4b7d43-3876-46ff-4768-08da80b12fa1
x-ms-traffictypediagnostic: SJ0PR11MB5133:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9qreTSlDeVGl5jENCCzXlAGAMTTCszl7kWRIfyqixDVNPWP1pikP3EOIOtTSID7ksYiQLf/ncYT5hlWJm6RVe4yLaQvkSf1csGNA7Js2vhCn97Nzfi8ZTXYdB4m9ST6vxexxmQjhW+J5ulMf5xhNxE+vx1MjE7oK6C7NFKdYZm+8+L9W+BAXzpoFgejtqdzVNJtq+6xtit0vl7qtbNhsQ+tniz8hKNh3oL74Irhhfo9bDKNcBfoLGMgC+KnK/8RBbevuJQq6kgPlGz9ifGDRKEge5j5K08coIVZQnqZtBX9qQIZ6qRXG8hJWoZSma+21B/iCrKjHPFPG5/qr7c3Bp+0FkTqrBYLSC1t9DvJLKf1dvTXi/Dz71CW5AHZjCHfksZCeCBYIR0dqE1Jq2AMyaty530Y3qvWR659byh9fQPQlT6Tj7wyG4vlTgFekkc8Glto2pHNmzEI7+Grxr5LXmUCtIUZFQcF2nxld1rXNSSPgT1l4kqXdw+UFvQQRXwpMmd57yNlkWUAIh77Jn4YF+tGu+kF64zgWVljjCnRUl4lbazArWeA433SZHxivvmEPzHhnO3ErMtlAvkhLEPdCDE8dVPe/zhj/8pLHrTAKFTMAtMEb0onargvZ/I5WV20NRIcxL6K8rm1srmed5SSA7c+uPnVoNZmJuBSNA7NS5mSNNk5uRtizfLOcWIWH6HOplY1qauBvH2Yi1ZLawyV9SIkN5ZMPEc27IMqFXoT4EKF3peTB85GlK4/qxknvgzVaYruBK654+VE/ZpcGls6JW0DMaNGeYqfN5qEwO/boxcuC/jbEgnkYkY0AWMrd5QJJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3495.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(39860400002)(366004)(376002)(396003)(76116006)(8676002)(66476007)(55016003)(316002)(4326008)(64756008)(66556008)(54906003)(66946007)(2906002)(66446008)(8936002)(7416002)(38100700002)(52536014)(82960400001)(5660300002)(122000001)(86362001)(186003)(41300700001)(38070700005)(33656002)(7696005)(6506007)(966005)(26005)(53546011)(83380400001)(478600001)(110136005)(71200400001)(9686003)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HbBtZn8IQZDBASaSa9W+KZ1CGVTktJfGo5oDsTWcqaKjXjAH9ACP22m37zPs?=
 =?us-ascii?Q?77otZQDJkh+15qJp2xvrNc9rHUPovtmUl7iI0B0JfYsgGJTU7oP+nrAQo1rD?=
 =?us-ascii?Q?vJIQcb/8XzNqRMalAQCTS0LxQShrJr9+yelarMMR7aIXod77goQXLiPulOI2?=
 =?us-ascii?Q?GeVrdykY2Zp1QeIyFzENVCxcHYsfUgrsp4DWLE91ArUB8KKAb/jzL+b0+zYJ?=
 =?us-ascii?Q?BAFOiO+cBQjGFzYhPd7fU97OihbvWt2BmTJvwaEHBbLKsaj2goTnxXI7gsXs?=
 =?us-ascii?Q?zAR9yAwQOI0L+J3LW59Xv5TE2nvl1+4JAwtn+ILjFeOosP6/zBgMkhSL3Jgs?=
 =?us-ascii?Q?6E+Oby7GJUdz1vFZ0ih3+vdRu/3FDNU8r7fBMOlE+i4Wo/A0mLGL8RHoYjAX?=
 =?us-ascii?Q?BHeN+sqT2W7DOQ4W5Z7jvcaI2wvYPBAqxD6O54Ttd2wzzp7RbaNUP12joeN2?=
 =?us-ascii?Q?qkWXP8q6iu3rtyuNVvMn1PE0d6crzqU9nXgZOYM3gzZramLY9Dttx7RwPVYu?=
 =?us-ascii?Q?Gj2e1nWGBGLMhE+V0ym64el9kqv2pQ9dvj4VBKS2t8tINfcnkfPF/EhC1fQL?=
 =?us-ascii?Q?G3ukH30VCRtKpEJIJzsOFKbbCHb0uBcnkFbv+maTG9f/j/+iRr4aNhYQhtSA?=
 =?us-ascii?Q?cR5CdZlFvXQ/BWNRhGNImOYCjl/IcFj5mOZg7YONBAprdxRPZn3bY0PKiKQX?=
 =?us-ascii?Q?gOIi743efLqUVOXBQB/ccZzqYLPOJRZ6DH9xfCKKfcM7YYK7rAPfUWie2nRw?=
 =?us-ascii?Q?KN/lTESpc3M8hIDvTFcH9p9W0tuhXvWfUAtF3V72CfJybV8GJDaqAQ4g7aas?=
 =?us-ascii?Q?+v02gYezIv5NoavwqLgazINYdNKDwzlQlo2x6NqeGzI6MTNmTx/WzwPc9USI?=
 =?us-ascii?Q?MkPZFUf3jibJGPxEnuePpDxnMgC9IDyB19bW8R3U+0DJG3Uqr+1Jm4R/Amq2?=
 =?us-ascii?Q?ltVyiKmRoYTjCC1k+SDc3BOLZwjkMHuK/+W7SBOzazfS9AwAqFPtZVpAI8Yx?=
 =?us-ascii?Q?fK+q4MFTrmqE/18w5nGLEaAL6t6DFP2opdtbqz2laoi59l4o6sLfnpPiCkw5?=
 =?us-ascii?Q?O4H+GHlcmcJnij+dCStcA79tltqo6RSpgI1yHQFx4KZoNsLC82/I3dprogCP?=
 =?us-ascii?Q?oFWmcSDdAahXapAmm6hXMjpil6C8VIHIJO9eHiq5hMUVmAcE51c3Tia0Mwa3?=
 =?us-ascii?Q?ygZLzNxCfBq3kTaJP3bDFQEOcQDnEJ3p9UA6z2P+qOlBG906jFRg2Tr3LrYX?=
 =?us-ascii?Q?XpJ+lINNEGv7zBbOD1XiG4h7A5tGsc+FSSC3nqPWqJV2VlllR0+JtEbjnITh?=
 =?us-ascii?Q?/gAK1PTqyZhCvzV+YV03xtsTBIFSVjx7dWpzlF1foknbZhW+x2jpZSMHbt1F?=
 =?us-ascii?Q?KRoAr0BDShGm7k3nzaaAEnmBDvi0YeVkM+lFjUXPXqBy9JB1afRppQpYcfFF?=
 =?us-ascii?Q?oJVlQhlaeFBRqgTUOA6VvoygtYk0U/EgZVNUrotOrCHV7bcXDt+FcdpiTSSD?=
 =?us-ascii?Q?6v4a2wjsE6lO3tH1Vc7VJ9G7Ohflas3H0bLCMdQW4CIj7OUlaVTjAm6dbNT0?=
 =?us-ascii?Q?3jK3x9IxaPAkfzllLSH1ao5/w7zFR+fKC/kdBbB5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3495.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4b7d43-3876-46ff-4768-08da80b12fa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 00:32:52.2387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TH4x5o4+VQo6Hu99LFJiWuolQLbg2x5XQpLI9YIVlCwQVis3Rb3+ZGHLPzc8MfB/JWq8pecMq+xos2mI8Tw/ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5133
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Mike Kravetz <mike.kravetz@oracle.com>
> Sent: Thursday, August 18, 2022 05:58
> To: Andrew Morton <akpm@linux-foundation.org>; Michael Ellerman <mpe@elle=
rman.id.au>
> Cc: Wang, Haiyue <haiyue.wang@intel.com>; linux-mm@kvack.org; linux-kerne=
l@vger.kernel.org;
> david@redhat.com; apopple@nvidia.com; linmiaohe@huawei.com; Huang, Ying <=
ying.huang@intel.com>;
> songmuchun@bytedance.com; naoya.horiguchi@linux.dev; alex.sierra@amd.com;=
 Heiko Carstens
> <hca@linux.ibm.com>; Vasily Gorbik <gor@linux.ibm.com>; Alexander Gordeev=
 <agordeev@linux.ibm.com>;
> Christian Borntraeger <borntraeger@linux.ibm.com>; Sven Schnelle <svens@l=
inux.ibm.com>
> Subject: Re: [PATCH v6 1/2] mm: migration: fix the FOLL_GET failure on fo=
llowing huge page
>=20
> On 08/17/22 10:26, Mike Kravetz wrote:
> > On 08/16/22 22:43, Andrew Morton wrote:
> > > On Wed, 17 Aug 2022 03:31:37 +0000 "Wang, Haiyue" <haiyue.wang@intel.=
com> wrote:
> > >
> > > > > >  		}
> > > > >
> > > > > I would be better to fix this for real at those three client code=
 sites?
> > > >
> > > > Then 5.19 will break for a while to wait for the final BIG patch ?
> > >
> > > If that's the proposal then your [1/2] should have had a cc:stable an=
d
> > > changelog words describing the plan for 6.0.
> > >
> > > But before we do that I'd like to see at least a prototype of the fin=
al
> > > fixes to s390 and hugetlb, so we can assess those as preferable for
> > > backporting.  I don't think they'll be terribly intrusive or risky?
> >
> > I will start on adding follow_huge_pgd() support.  Although, I may need
> > some help with verification from the powerpc folks, as that is the only
> > architecture which supports hugetlb pages at that level.
> >
> > mpe any suggestions?
>=20
> From 4925a98a6857dbb5a23bd97063ded2648863e65e Mon Sep 17 00:00:00 2001
> From: Mike Kravetz <mike.kravetz@oracle.com>
> Date: Wed, 17 Aug 2022 14:32:10 -0700
> Subject: [PATCH] hugetlb: make follow_huge_pgd support FOLL_GET
>=20
> The existing version of follow_huge_pgd was very primitive and only
> provided limited functionality.  Specifically, it did not support
> FOLL_GET.  Update follow_huge_pgd with modifications similar to those
> made for follow_huge_pud in commit 3a194f3f8ad0 ("mm/hugetlb: make
> pud_huge() and follow_huge_pud() aware of non-present pud entry").
>=20
> Note, common code should be factored out of follow_huge_p*d routines.
> This will be done in future modifications.
>=20

I found "Anshuman Khandual <khandual@linux.vnet.ibm.com>" submit the simila=
r
patch on "Apr 2016 11:07:37 +0530"

[PATCH 03/10] mm/hugetlb: Protect follow_huge_(pud|pgd) functions from race
https://lore.kernel.org/all/1460007464-26726-4-git-send-email-khandual@linu=
x.vnet.ibm.com/

> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  mm/hugetlb.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
>=20
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index ea1c7bfa1cc3..6f32d2bd1ca9 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -7055,10 +7055,38 @@ follow_huge_pud(struct mm_struct *mm, unsigned lo=
ng address,
>  struct page * __weak
>  follow_huge_pgd(struct mm_struct *mm, unsigned long address, pgd_t *pgd,=
 int flags)
>  {
> -	if (flags & (FOLL_GET | FOLL_PIN))
> +	struct page *page =3D NULL;
> +	spinlock_t *ptl;
> +	pte_t pte;
> +
> +	if (WARN_ON_ONCE(flags & FOLL_PIN))
>  		return NULL;
>=20
> -	return pte_page(*(pte_t *)pgd) + ((address & ~PGDIR_MASK) >> PAGE_SHIFT=
);
> +retry:
> +	ptl =3D huge_pte_lock(hstate_sizelog(PGDIR_SHIFT), mm, (pte_t *)pgd);
> +	if (!pgd_huge(*pgd))
> +		goto out;
> +	pte =3D huge_ptep_get((pte_t *)pgd);
> +	if (pte_present(pte)) {
> +		page =3D pgd_page(*pgd) + ((address & ~PGDIR_MASK) >> PAGE_SHIFT);
> +		if (WARN_ON_ONCE(!try_grab_page(page, flags))) {
> +			page =3D NULL;
> +			goto out;
> +		}
> +	} else {
> +		if (is_hugetlb_entry_migration(pte)) {
> +			spin_unlock(ptl);
> +			__migration_entry_wait(mm, (pte_t *)pgd, ptl);
> +			goto retry;
> +		}
> +		/*
> +		 * hwpoisoned entry is treated as no_page_table in
> +		 * follow_page_mask().
> +		 */
> +	}
> +out:
> +	spin_unlock(ptl);
> +	return page;
>  }
>=20
>  int isolate_hugetlb(struct page *page, struct list_head *list)
> --
> 2.37.1

