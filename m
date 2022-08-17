Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2705A5967BD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 05:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238145AbiHQDbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 23:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiHQDbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 23:31:42 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FB480F6F
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 20:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660707101; x=1692243101;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SIpas9hHBynXoDmmiy4TB+YPp+HKO5kfY+djQtt2IBQ=;
  b=aEW3euQ67mBflJ9sQgnfP9pg3d6/WCEw3dh54d06N439LrfDsw/h8CE7
   d/SMcCk1WX5MNY1XgBgFxrH9Zd3+e7ms8OPFGgKtq7Qb+RvS1scIbXMdJ
   tW0iTMTXXHoStQvB0SiivFRa2+KL2sbWnrHs3mHkMXEsyOgQx+FTNMY4N
   Tq15DrUG2E/ChWGZ34kFkbuGM5fRI63+c5nsHkrJzFWfTJG63xjgX8Tvm
   PBqcwYz2WPQVK+kjbOk8xz08xi/tIstozqPwnOgb6Pgz+taaLFJs2VJW2
   Lr56oMnqdWvHnDiRWcUEPFJdHRMFed7iI0XPu7mUV9vzplUL4toaW1MHg
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="291142718"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="291142718"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 20:31:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="667416368"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 16 Aug 2022 20:31:40 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 16 Aug 2022 20:31:40 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 16 Aug 2022 20:31:39 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 16 Aug 2022 20:31:39 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 16 Aug 2022 20:31:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hj/Za1La7G8PjSyfbaL0MEf529Msspd2/M1O/84ElNK22xCpZCPa3odfXSFIGCOTpZavJ3teV5cTPMvCY5Y9f06Zz4GP6Y+ZOZletJU4qV1ZR4nlW1MyBcZVSsnqj5+dWs7qeEmAmXAtififRa/QiwvgMAyVyHV0qYBXP3B2h/Eh3q+REXeJgtspNEkbJv69zWoDi3jlXly0PY+khY0WY8dGeWu20D40VvPCXUWL44Ue/TjcHg6jFHH92RbBgGDCJUcgPHk5N9rYemFo95h2oiXXYMMrlHDTqQWgnWyt9VNBrm/O9M8FDdgwIr+k9XSzFzjKVDBQdpasj30vS5ev6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4NahZRuX+752zHGXVIAQXP+gWv2q3YnBixLblDQXFs=;
 b=TK6csR8Yb8B/rSCzwdBOjsGMWL6ZZsv7UQA57KGMngIY/VbKVikdzSPew03SATIQ8ZagH3rlWlntJpiCf4cKK0JSef2qYfKTxW1z8JCuE8FPQEiAYLZHMu0RxsGySa4p7P7h3OWFm1L66Mf41E304hxV109ro752g/W8oxQPYTX7IjAUwLdFgYL6qmsiB73L24Z9rD6yW65oqm4lAQ5DfFyCwHQJgLrKtB2uDet/dbVD/EwEJ7Z0fizsAemhN+pxSUt0fkRzqexvcisitBR1pUL0cdvu3G+N538Eicjttu9zyf1Iw70U3NeTtcdajakV/eNB4N6x0oFCZuKp+jrkMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3495.namprd11.prod.outlook.com (2603:10b6:a03:8a::14)
 by DM6PR11MB4028.namprd11.prod.outlook.com (2603:10b6:5:195::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.23; Wed, 17 Aug
 2022 03:31:37 +0000
Received: from BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::6133:d318:f357:48d7]) by BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::6133:d318:f357:48d7%7]) with mapi id 15.20.5525.011; Wed, 17 Aug 2022
 03:31:37 +0000
From:   "Wang, Haiyue" <haiyue.wang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
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
        Sven Schnelle <svens@linux.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: RE: [PATCH v6 1/2] mm: migration: fix the FOLL_GET failure on
 following huge page
Thread-Topic: [PATCH v6 1/2] mm: migration: fix the FOLL_GET failure on
 following huge page
Thread-Index: AQHYsRbS1IjgnpM1/EaZo6nPqIEeuq2yRsoAgAAoZ1A=
Date:   Wed, 17 Aug 2022 03:31:37 +0000
Message-ID: <BYAPR11MB3495F747CBF95E079E8FC8A5F76A9@BYAPR11MB3495.namprd11.prod.outlook.com>
References: <20220812084921.409142-1-haiyue.wang@intel.com>
        <20220816022102.582865-1-haiyue.wang@intel.com>
        <20220816022102.582865-2-haiyue.wang@intel.com>
 <20220816175838.211a1b1e85bc68c439101995@linux-foundation.org>
In-Reply-To: <20220816175838.211a1b1e85bc68c439101995@linux-foundation.org>
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
x-ms-office365-filtering-correlation-id: 61c5980b-a690-41b6-9ea0-08da8000fdc4
x-ms-traffictypediagnostic: DM6PR11MB4028:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G/K7Smlf352Idcp9V+pbu9iTe+MAfUNFewqypZKzPMSLcGa7cjKW4TTPvM+nG2rwLUUw936kpLOk03tRfR9LEZcL7hMHtoQABsdXl/6+QOQGiQKd6lBjgwKwAUuOlDQCi/qp00DxJgk3wv84EdVNXyv66/bZvOBGoR8SjT/+Fnp0+epR00vpHRlJf0YV3CAwH3EprWKtDahzOAoRqaPF4Yl4YzNkkI/iajT/g0+O2r3inK7bq5DXQiMMyWDjJRMc2sx09KTeHErXPV/xhsGt71PTBzp8iZ4u45wfhfTD8uz7ke4J9pMUSxW086YZiJ2N4v48cVHnnBhru3Nkd2O1dR9+/ipseDntHFJIjvNoT0Pj1x/8LtUWjC7J4YzjcVD7qJnM22vPQUdQmLbF7ga7LnGFb80As5+xK2WOTCcd3+1OYRdegtMVtG8wLxun6BKuhbq2c2zw6RbQvZHo1Rz71q0dVZMvwtUz1HDnFcV+F81/79lXnjCgqlBvm9gvTpVQjLoMjyJESvwkkZC+le2ocdbkHvzryjdc6DdDsTxHfvi3JCKqv3qBv+KYjJMBuJI5y9gLmLzkKAAvTk0q5PqpWAT9ERMLGE3iKHePfUiur+AHMv3f0xUWzKtRMfUytesb1HgVObb6TzWTPRXoqsSmMS1AUgW7/IJUn8384Rv5MgaNNMYIatpkF/qRYo3zyeRXtheIygNBGVTpK67itDGU4yF3Lxv1pSHy4pnbpzVUQz+/ZuWWyqdoLUO9yUyRfu5GuFk4NdzNBcSMK2CFPiZrDumr99aLofxDnAum+5hL3o0S6pUFouFBv6CEIgk61dZ8OJHQpVKkRowkMi/hoC2/cPmLVdMBbWYgg2MJpihlOzgZIXu1MKnN/8gR8pqPa+z5pTTj4osAJIq7POsTZPuFZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3495.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(136003)(366004)(396003)(346002)(64756008)(66946007)(54906003)(71200400001)(66556008)(76116006)(8676002)(478600001)(966005)(316002)(38070700005)(7416002)(4326008)(8936002)(66446008)(82960400001)(5660300002)(66476007)(6916009)(41300700001)(33656002)(53546011)(122000001)(55016003)(2906002)(7696005)(26005)(6506007)(9686003)(86362001)(52536014)(38100700002)(186003)(83380400001)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UaupdEkgDaSsvpuBthPAQGu8nYjWX5WK16swD2Lt24h7sg3pYWiS+10ehdam?=
 =?us-ascii?Q?wwTbv/BUe03zd5cpKkOgQk7U7q5Mmiei4B4YtmCYveEnYV1G6DaSnSK3Iv/G?=
 =?us-ascii?Q?OIRtAXm/Me3ezuWfU9qNkm8RQ/mr4UbkYk0rypGeol5669ulm8+HKhkgfcSa?=
 =?us-ascii?Q?DkqYIc+MEKHWib0L+NcGHUH5vzZZQmcXUIxEhhcShYTpzA4yXsnUZ+wMSbh4?=
 =?us-ascii?Q?158OagvXkKxktO6I/vwnPtwM8meuwNQstM4sFIxoQOBZzl9JBPrBxCrA4tuz?=
 =?us-ascii?Q?MMwHlfGZB/WTa0CG01OWIdWP9wq8peVsemayrzEQd7UjVYoIT9yfCrwecQzR?=
 =?us-ascii?Q?vnb38EYZArF+8Tq7FUifuDcXm9TKeUR7oilOYjyicKXYUb/kpyLvl53vA05B?=
 =?us-ascii?Q?o2imBw9zQJ+rXyZoeJC5fXnqYHqmLgNIGyYmN/THcNKywjcrEhwtoccjr93u?=
 =?us-ascii?Q?k+pCUtcgjIjORahk1djtm+PJp/z/D781Q9nqox3A28fygw8N1W/HLcj9F+lN?=
 =?us-ascii?Q?+azOHYjHkiSk06PmeiN5xrINNY9AgM2HU+90Y+R6VPv7/5zvWRnKima2YNgr?=
 =?us-ascii?Q?Xbq0TdPMOvkwhphpAPiid4IH+Gj7l5iu/Fc81nUY9166LPTRtnHpuoPD9OkU?=
 =?us-ascii?Q?o4lWowUtY8Ww3WIiQ4jqt2wJIGG0AH+Dy1IY2Y8R0mAppVRZCU8zUneCwUzj?=
 =?us-ascii?Q?uOkXEMpHq7pAQFCrqAb4HMI3BInInKdM4okv/OhI1gcuQeHVF07C5YXe9bl2?=
 =?us-ascii?Q?VhP3Wl/Zx285iy/O4UxmfiJQBKYrj0146djSXCAErZ42lFmrPnJRo6IUQqzs?=
 =?us-ascii?Q?6xofHfiNiZfoQRaLfBTq1AL+QNzHuWAfwVvwf8AEqairhVuExoWHVC6OJ6H8?=
 =?us-ascii?Q?5p4QSA/FXwZk5ggXeYlzBvjJrNZJWsfXwdlO/W3La6ADMNaI2z78+pEm8Ijz?=
 =?us-ascii?Q?1faavciivBDVZoahIzGD5tMo0YPatJnVxuqMdI5fsA70KQA+88y1q8oOoapx?=
 =?us-ascii?Q?4FFEI28/S1mqYLXXgBs1UJPKlLPY9ou8x7kZK7QljuRXlsg/crs0kVYCtyK2?=
 =?us-ascii?Q?XQSOKM66MoNUltqfVhkJFMeey2XPJjxdeg9ldjnQuWFFRbwai95g9C+9yEkK?=
 =?us-ascii?Q?yKla44MLqv1WAT/X6A7/b+KiD2ozzceURGILfKsH/gbHWZABBkxlgVW0KBtS?=
 =?us-ascii?Q?xGOt4R7o68HLjeYeHcnUFd8kFwGczjIW9rSrdd/EXGhHNYNHL2Gu45Y+SJTa?=
 =?us-ascii?Q?V/GkhcWxHnT3fhzk38Fz9ME+MbK0d9Au515o9FzaWziTWI3He4ceDBFHfILf?=
 =?us-ascii?Q?oyl0ReOJLVYD6aqOMpivbHCxBY0bYFjZ1LdK7VxUZg+kELVsrEyJXoopRub/?=
 =?us-ascii?Q?hZW0eIN6i+GjOJAQmgDL+pt03PpTvlSgA8TXaAlVsvcXl8Ok3YUM4YY7T9I8?=
 =?us-ascii?Q?m8apKJVdY4iQGVW8fFVpX904++ruFK1dlNHi2BXxwxZf6Cm4pKLlqH2jYzWG?=
 =?us-ascii?Q?6Hd7crE9LIwOqg6bAcXOI4Q7EozsV60enTaci7pWtQhzPb8eBUiw+mqzW0bc?=
 =?us-ascii?Q?4XHNW9y1qgU92N2RWZR/eCFcigGFkinauCtm/1/B?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3495.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c5980b-a690-41b6-9ea0-08da8000fdc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2022 03:31:37.1910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QmWwxhCFLVNK+/P23JC2nmDHmZEDOU3ERymCLPfE72JhTc8Gmd7WwO2XgBtFSdaP36I4/FCrVV7qe91QGKqFbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4028
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
> From: Andrew Morton <akpm@linux-foundation.org>
> Sent: Wednesday, August 17, 2022 08:59
> To: Wang, Haiyue <haiyue.wang@intel.com>
> Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org; david@redhat.com; a=
popple@nvidia.com;
> linmiaohe@huawei.com; Huang, Ying <ying.huang@intel.com>; songmuchun@byte=
dance.com;
> naoya.horiguchi@linux.dev; alex.sierra@amd.com; Heiko Carstens <hca@linux=
.ibm.com>; Vasily Gorbik
> <gor@linux.ibm.com>; Alexander Gordeev <agordeev@linux.ibm.com>; Christia=
n Borntraeger
> <borntraeger@linux.ibm.com>; Sven Schnelle <svens@linux.ibm.com>; Mike Kr=
avetz
> <mike.kravetz@oracle.com>
> Subject: Re: [PATCH v6 1/2] mm: migration: fix the FOLL_GET failure on fo=
llowing huge page
>=20
> On Tue, 16 Aug 2022 10:21:00 +0800 Haiyue Wang <haiyue.wang@intel.com> wr=
ote:
>=20
> > Not all huge page APIs support FOLL_GET option, so move_pages() syscall
> > will fail to get the page node information for some huge pages.
> >
> > Like x86 on linux 5.19 with 1GB huge page API follow_huge_pud(), it wil=
l
> > return NULL page for FOLL_GET when calling move_pages() syscall with th=
e
> > NULL 'nodes' parameter, the 'status' parameter has '-2' error in array.
> >
> > Note: follow_huge_pud() now supports FOLL_GET in linux 6.0.
> >       Link: https://lore.kernel.org/all/20220714042420.1847125-3-naoya.=
horiguchi@linux.dev
> >
> > But these huge page APIs don't support FOLL_GET:
> >   1. follow_huge_pud() in arch/s390/mm/hugetlbpage.c
>=20
> Let's tell the s390 maintainers.
>=20
> >   2. follow_huge_addr() in arch/ia64/mm/hugetlbpage.c
> >      It will cause WARN_ON_ONCE for FOLL_GET.
>=20
> ia64 doesn't have maintainers :( Can we come up with something local to
> arch/ia64 for this?

The 'follow_huge_addr' itself just has interest on "FOLL_WRITE"
struct page *
follow_huge_addr(struct mm_struct *mm, unsigned long address,
			      int write)

And arch/ia64 defines this function 17 years ago ...

But I found that "WARN_ON_ONCE for FOLL_GET" was introduced on 2005-10-29
by commit:

[PATCH] mm: follow_page with inner ptlock

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Ddeceb6cd17e6dfafe4c4f81b1b4153bc41b2cb70

-	page =3D follow_huge_addr(mm, address, write);
-	if (! IS_ERR(page))
-		return page;
+	page =3D follow_huge_addr(mm, address, flags & FOLL_WRITE);
+	if (!IS_ERR(page)) {
+		BUG_ON(flags & FOLL_GET);
+		goto out;
+	}

>=20
> >   3. follow_huge_pgd() in mm/hugetlb.c
>=20
> Hi, Mike.
>=20


> >  		}
>=20
> I would be better to fix this for real at those three client code sites?

Then 5.19 will break for a while to wait for the final BIG patch ?
