Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5B25928E0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 06:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbiHOEkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 00:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiHOEkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 00:40:53 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C33BC9A
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 21:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660538452; x=1692074452;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=51itgDytZ8NXq2s/aCzyZ3K7kG9b2Cvnwp4cknFAByQ=;
  b=KwWs2AgHTGm2nEmMdaiqIFrV30e+I93vUHBRAGxcHq/qTibOdu5+0EvA
   EuptDhjY49VFwocnd4BQDFpihjzXDg8wNwNNtCaPAuGKxItWdd2nhohWT
   yTK/hzIU3yT59n8PCEnp5Jmv3nEBHF8mBBrQiRARypmwqlu8uJvjfaPz3
   T2j7lcEO+x+GaMFfPa/Txyf31W1IPBG/00l7fP0cedUP4CsHtVy4ab6y/
   7UEHVAv8RqIYW4KkKziQZYbQ85EmLBrpBgWaHhQklQ9mIi6NJiWjoby4b
   zL8IdRIcH30IN1fhqOLrZTCYxhOvxCAQERkXwg2pFtQ0VowM5AWTHnEPT
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="278847782"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="278847782"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 21:40:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="674721310"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 14 Aug 2022 21:40:51 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 14 Aug 2022 21:40:50 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 14 Aug 2022 21:40:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sun, 14 Aug 2022 21:40:50 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Sun, 14 Aug 2022 21:40:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTkcWh72k283rVH5/ds0XO8HWOsQRVY9HgUnHBHcwWvb0GCAzovStMpKQyQDzAnL/2wlxp115umSyyUHtbTnwrjnzyoAytmx8rAWRNW42lum80OtMh2ELCVgkoiMVekfxaf38sXBrChqsXBVQpSE2AdanlMhB2n8g2EvDWgWJVOCKVPqRChcIbpqALxympKOPn/DqKwhwwQTbKU2P0dTakuvLXAgpcFZlidM0CZvbZ5n+dLp9Vq3t0hL+2BWpG+hpsohwSuC+Hb49we0PnRrOd2WusOzk1++myzcDsaqbZdAnjLGfoqi2MQnZFqS2n/CyACb0kigWlKK4GMgl2vB4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LA37uHzr99PhwIDRkt1J2/zm4bGaUWKngGx/JVqZR8Q=;
 b=LUBKisnrcnEwhAVtBg0UXq8iFplOC00C+L/JyPAO75HhBR59F0go0ePNqYhvWG/i9517d5GwKlT7CMZcJmFMTIldo6SK/n1GIm7drlceeIGXf+Z/K1cMUMtAc2r0ktuQVzZafqc7R3AT24rjTtmSiNXFUm3VYXE3EiaHEeAkjx/HxohWvgW9AWK9Plj+GDOI0hvpAoPgLUSyVOGChaufIUWsL+8jJ526b5qHHyHoG9Vl+toR4HTQQNcqjv0P9Lk7uY7K3ds8xRI7uwC99UpUhjd55zx7248PR6gp0g9+leVnFWfTArR5VAV8BVvt4cLW+6zfymYZzhLEU9TOfy4+4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3495.namprd11.prod.outlook.com (2603:10b6:a03:8a::14)
 by MWHPR11MB1917.namprd11.prod.outlook.com (2603:10b6:300:112::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Mon, 15 Aug
 2022 04:40:48 +0000
Received: from BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::6133:d318:f357:48d7]) by BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::6133:d318:f357:48d7%7]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 04:40:48 +0000
From:   "Wang, Haiyue" <haiyue.wang@intel.com>
To:     Alistair Popple <apopple@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "david@redhat.com" <david@redhat.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "naoya.horiguchi@linux.dev" <naoya.horiguchi@linux.dev>,
        "alex.sierra@amd.com" <alex.sierra@amd.com>
Subject: RE: [PATCH v4 1/2] mm: migration: fix the FOLL_GET failure on
 following huge page
Thread-Topic: [PATCH v4 1/2] mm: migration: fix the FOLL_GET failure on
 following huge page
Thread-Index: AQHYsEqaehDxLZhp/0WpLois8QzWXq2vXnsAgAADE2A=
Date:   Mon, 15 Aug 2022 04:40:48 +0000
Message-ID: <BYAPR11MB34954E0692FAD9FFB66FD2E6F7689@BYAPR11MB3495.namprd11.prod.outlook.com>
References: <20220812084921.409142-1-haiyue.wang@intel.com>
 <20220815015909.439623-1-haiyue.wang@intel.com>
 <20220815015909.439623-2-haiyue.wang@intel.com> <5767084.K44AtQxeQl@nvdebian>
In-Reply-To: <5767084.K44AtQxeQl@nvdebian>
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
x-ms-office365-filtering-correlation-id: 4617a8a0-d01d-4ab6-3efb-08da7e78535f
x-ms-traffictypediagnostic: MWHPR11MB1917:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VdLv8CgohDae1kZvEkswyO+HXSt2XAx9clMMflk5QkDVt2ZzqDgu5Mj/BKAsOoD5eS0GbLMjGiziNc2jHzreIjzoOqBOAc83kp6uTgSEeF1fk3sqtMfz3MJLlhzbtQq3fs/k9xRLr+eZZaRDywb3qFVsMvHthfCrSdqp1rCbFRxqkIml1hBGZQdxQRZRsUFMwgAeu1SAQeCEHJRPC38S9/+DhVCn0Jh6q4saZ85WxmZZduH/7NhNg+x83jA2PTCQtCmiPpz+v2v3/FXCsP1O6KgXdwcL50Nenfdpxn5mGXVqrXERC4FWDCSvfGeCdP6Zb7HWaNUu4MKERWAUVQzlr6MxbruS5jHysFegAECljKFQrzSZQxq1Ubwp8ITVTn73r5hE+2osHEKB9V+LY8d+Mp30h8J7A4wGz9VFA1HQZeFqtM+Tth0xyoNPc5wWG3uN4xBWWFTkZZSpu7iGlLsIFdctM+hyf0ytNo64fIq004T2gUTMwzQIDu9CsdqARWGdmieDbJnjTEEYOMSh8TfLcGQoH7Zi0j0c4UR18OIYxIo/g+rHgKmxugCPzvBDrJgesYa5TbZe/xsqlOHEYz4iXSdngA6nPawY+gz5JkSzObSulKB6dWt9ZGElPIGdahBZizjTLleKyCdGodOC53Sc0nD6c1sXh9XGPxAE93NK+xeQSjV5wC63XYKXONRnyA0mLFOJMv5T3nzPhy/fxhEgalFlJO3dyy4nGh69O0VEikFdRqLALWYC0CYx/BjKwlSGTsH/2Yxorc5LrWhi1C/oYT8iMU0hsTlqG10HINNUKy8d/W7z0uOwncLvB7f9jATxKzEXD9crjiHiMipO3qcVYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3495.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(39860400002)(136003)(346002)(366004)(55016003)(186003)(41300700001)(66476007)(76116006)(2906002)(83380400001)(66946007)(66556008)(8676002)(64756008)(66446008)(4326008)(54906003)(316002)(110136005)(122000001)(38100700002)(9686003)(82960400001)(26005)(86362001)(5660300002)(8936002)(71200400001)(38070700005)(33656002)(7696005)(6506007)(478600001)(53546011)(52536014)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5mZNo7iy+8wTMbXNO8cSsdAji13Hgo4TdJcPpbXyMOYErr1hwvMQ8ZrLSdMu?=
 =?us-ascii?Q?9sz8qTRs6XorJ8Ny9pCxFljZkv1j5hNZ+tBKYjxRsOU9OxUBRY7TM4idJ/TE?=
 =?us-ascii?Q?5rnhib0lohY9jIVmtsdbnAybYE0OeM1lkJtc8EJ6NAm6aWnOMtX0+8PxNu1/?=
 =?us-ascii?Q?BmhTq9FiB6lgGh9Ggpf+QreTT4jZbWX9mpDWwQR761HCWYB9fR04iOFlD+tt?=
 =?us-ascii?Q?/BDZaccRjbM7+V352KCzzVKbMyOcWPZXR0D7vS6qqOepdBp5s55LC+369VhZ?=
 =?us-ascii?Q?Tx13OrCeTRxPKEYt4au7xtKTcGuCCFiiVt3DFJVb/mXX/w1KhD2oi7hGaoln?=
 =?us-ascii?Q?Z+ntaOp4Pt92ibmq1BfTXy+4/j9hxRVWnGyfuu9TEyk9P2twW838wY6GUnBk?=
 =?us-ascii?Q?1FouzNeFtwGMeYNgzVgd0LJNvdp/+Q2xjE4QZZ7PgUpzcCgWeKg+PyfXNy3l?=
 =?us-ascii?Q?9W12njKNhZH1mTyTBm03Z+YX/qVtrDMKZydsl+kpgcn1Gh9FK1qTnRdT0rZM?=
 =?us-ascii?Q?kPuFJPJ5ADAS5R1+C3AR+QbxSyrOwYHDTAwegQwVSWGHTgpmF44wDyZAUi/4?=
 =?us-ascii?Q?4qrGk8Mv5f7GvbbJJLUZ3CaDI7Wh2KvdACDL9OmLgrSP45ChqXXhYIVd9gct?=
 =?us-ascii?Q?B4yMQ2PIG/JYLVDGavrQDSM0IOKfGx65HYghh5EO7XgSphzd5Aspho05iHeR?=
 =?us-ascii?Q?gGayNp6OhBC8SyGN2EG7K1NXAobTJakW2B6JA8JTYE/m7q+2IvGbA86sVF+9?=
 =?us-ascii?Q?0FL6Tn9Z4dRfsao+kK2yUhV4MeEQDaH55zgWYDH4UuTRRiy/NNnYj9jhSnM3?=
 =?us-ascii?Q?j234oD9YulA1Dfg6DmxweW5Tu9PyLZnUFPklIax3wyoN5PoDYmiH5Rdc4BNs?=
 =?us-ascii?Q?zRpSJDfZeRD717kZMO069X1uNnDFnV9K4oV+yHvY0ZUiVfQdVdT0fctB51Au?=
 =?us-ascii?Q?cGkYQ0v8p+0XlVWi6JLEMXX+HEnftvpWwjJBIDs+rYHhR8n/yySVizGWF6jY?=
 =?us-ascii?Q?wyHUzGzpoqM4yg3ZcX6mDtAPlU8IXZOx/NddCHpddT0X7r59vl/asbi/P5Lg?=
 =?us-ascii?Q?wq2/pGeQB/BIHeEtgaeDcqzbWtrR7Vz+0F9rcZ9ok6bkNUK6UXUMiNWR3S8w?=
 =?us-ascii?Q?CtzdoJNM7QOLcMuvxn12CSn91XIWJZfHY32DuUMAGp1YiUlYv6RAv9RDeWu4?=
 =?us-ascii?Q?cIsY7Yh+FSQg7Cb+Q+W+OA+cUIcavZZmCQNdX+017upHGnJXeVaWtH7VCEK8?=
 =?us-ascii?Q?7yLFTALuHvoYz6mNn1Al4f5xuGQ8tZdo9o/RXOo+/e44HBWP8+vwrAMsG2rH?=
 =?us-ascii?Q?mleCvueAVIAPBDAYMjk5sUxi/j5jDZ+pzeFsAhei3CpgmnJVU63iDAYWw+qJ?=
 =?us-ascii?Q?c/FAoRrd+y1zL0flLLLgC8V1+fS3bMvRl6i3bVlgINh8gmmtrccEDySN0klD?=
 =?us-ascii?Q?WFBFzg0IRY0T3jcaS5gvO2/bupK2xxhHVo/0LqXbfxMyQldImBhW4oatOeg3?=
 =?us-ascii?Q?KRrUzHnJ+IiJTJbLpVP+gn66vH1jTltPjCfTpHPlSfZ9f/mwfynGJlQuj7l5?=
 =?us-ascii?Q?RUwULdFlrdtQVzWlCd/vFyc4gzn2CeX1hg+wiImN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3495.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4617a8a0-d01d-4ab6-3efb-08da7e78535f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 04:40:48.5647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6HAW42aI7deEnaenjJqQkDvd/yXCR2AElCYWTSxgMT8PPk78qNe4SSCuaOmxNYuE1oQovrU7H5gx4UEr9WqP0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1917
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Alistair Popple <apopple@nvidia.com>
> Sent: Monday, August 15, 2022 12:29
> To: linux-mm@kvack.org; linux-kernel@vger.kernel.org; Wang, Haiyue <haiyu=
e.wang@intel.com>
> Cc: akpm@linux-foundation.org; david@redhat.com; linmiaohe@huawei.com; Hu=
ang, Ying
> <ying.huang@intel.com>; songmuchun@bytedance.com; naoya.horiguchi@linux.d=
ev; alex.sierra@amd.com; Wang,
> Haiyue <haiyue.wang@intel.com>
> Subject: Re: [PATCH v4 1/2] mm: migration: fix the FOLL_GET failure on fo=
llowing huge page
>=20
> On Monday, 15 August 2022 11:59:08 AM AEST Haiyue Wang wrote:
> > Not all huge page APIs support FOLL_GET option, so the __NR_move_pages
> > will fail to get the page node information for huge page.
>=20
> I think you should be explicit in the commit message about which function=
s do
> not support FOLL_GET as it's not obvious what support needs to be added b=
efore
> this fix can be reverted.

Yes, make sense, will add them in new patch.

>=20
> Thanks.
>=20
>  - Alistair
>=20
> > This is an temporary solution to mitigate the racing fix.
> >
> > After supporting follow huge page by FOLL_GET is done, this fix can be
> > reverted safely.
> >
> > Fixes: 4cd614841c06 ("mm: migration: fix possible do_pages_stat_array r=
acing
> with memory offline")
> > Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
> > ---
> >  mm/migrate.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 6a1597c92261..581dfaad9257 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -1848,6 +1848,7 @@ static void do_pages_stat_array(struct mm_struct =
*mm,
> unsigned long nr_pages,
> >
> >  	for (i =3D 0; i < nr_pages; i++) {
> >  		unsigned long addr =3D (unsigned long)(*pages);
> > +		unsigned int foll_flags =3D FOLL_DUMP;
> >  		struct vm_area_struct *vma;
> >  		struct page *page;
> >  		int err =3D -EFAULT;
> > @@ -1856,8 +1857,12 @@ static void do_pages_stat_array(struct mm_struct=
 *mm,
> unsigned long nr_pages,
> >  		if (!vma)
> >  			goto set_status;
> >
> > +		/* Not all huge page follow APIs support 'FOLL_GET' */
> > +		if (!is_vm_hugetlb_page(vma))
> > +			foll_flags |=3D FOLL_GET;
> > +
> >  		/* FOLL_DUMP to ignore special (like zero) pages */
> > -		page =3D follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
> > +		page =3D follow_page(vma, addr, foll_flags);
> >
> >  		err =3D PTR_ERR(page);
> >  		if (IS_ERR(page))
> > @@ -1865,7 +1870,8 @@ static void do_pages_stat_array(struct mm_struct =
*mm,
> unsigned long nr_pages,
> >
> >  		if (page && !is_zone_device_page(page)) {
> >  			err =3D page_to_nid(page);
> > -			put_page(page);
> > +			if (foll_flags & FOLL_GET)
> > +				put_page(page);
> >  		} else {
> >  			err =3D -ENOENT;
> >  		}
> >
>=20
>=20
>=20

