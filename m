Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EF0595298
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 08:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiHPGhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 02:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiHPGg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 02:36:59 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E999E50194
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 18:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660612346; x=1692148346;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qfi2w9hQNVOVcqPD0nKJ69SE2QJsPvqYIt+COwmLgWw=;
  b=gPcEYrFdQSnVFOYO4jlnzaz8lrNrA5WByZ818QAPLj6VP8co3fP7ss8U
   Y93+crY+sWoPDUXylPT0lt8fFGck0lMaMtoOCX9mwdyVHQLX3aFjX1Vl8
   DLJiONPMRGUUGBVmQCXG9Qxaum98Em8ZgUPTJJGSjvwpIs/EY8R6BZ1c8
   s5okOkccp2MhLThdfrm2Zf1Jy1orQvvGqEtGixxQqajAapMTTh+uiFQaG
   goV7wxhdw8k8ui7hc12u8agwkvhVjzd9o5hPIRD5chMrMnGCg9sD9F6Ha
   4ePVXUk9Cc8GA/tGsPIrBt5j7qq2DQnbDXF7qUMBVjNtNBJYUZBKRRr0N
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="272487649"
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="272487649"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 18:12:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="606845043"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 15 Aug 2022 18:12:25 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 15 Aug 2022 18:12:25 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 15 Aug 2022 18:12:25 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 15 Aug 2022 18:12:24 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 15 Aug 2022 18:12:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxQG9M6v5dveeD3eOGOXPsaL0K/FMicdq7omla2uwpfpOFaRU/Twb2L2bpbwIJOEg8yeFdsDVQmxi4DaGnwpxlIwd5FJKgvvH+hfvUMHmEtLSdm5suqsetdQdbYjXYR+Fdt2qeKt+T88lVPBv1lPbZAszSEg8WZEJlvrAG+ZTl3LA9MMhHoPMQPrOZRcZTjxCU+bD5ykuRr04RTUhriqOLjIT4d9n1ahyrMkkKxRIP5qE3EQPL52tUD3M8n0fwRKqt1OVDsKcCgFKeGSQAISN3fhdXdRVHs6PBWYYIje71rWQ/shhHqtiATdM6gz3RrcysJyYNQNqSbx1BuJW5766Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuJuCanXY0UJMTZmDYPmuNUTU1s+vqAzhpAJw2oXkiQ=;
 b=eQ5jNI4TgRWOxwJfQinex8zOrcmZOHuYlpd24eecEeqzHGn47ivxHtrtgAQSaG7iPUmHHdEUMTJlfa3G5bSDkI9kBhI314TV9T1s8/bkjTyBG/1SKEFVHx+moz67+S8YV4XaN2gvpHJml0SFaMAEKOjnTkbFIj+KQv5Jwpiqae2AG6F/kpX/PwJ68taII6wF72jd8Jg9HqEZoO3uKKIdaG7L4Xs8Ix0a9Z95PLVIUWxnVdPjAg3MIHVTBG/nor5KsS13ba5kOXQvzNPXKdJzOFw0potpytzwJcj09ErtBFAvbJYmfyt311fMEMIGo4cDu/T89PnYd6hPpnecTZ4oDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3495.namprd11.prod.outlook.com (2603:10b6:a03:8a::14)
 by PH7PR11MB6030.namprd11.prod.outlook.com (2603:10b6:510:1d1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Tue, 16 Aug
 2022 01:12:23 +0000
Received: from BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::6133:d318:f357:48d7]) by BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::6133:d318:f357:48d7%7]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 01:12:23 +0000
From:   "Wang, Haiyue" <haiyue.wang@intel.com>
To:     Alistair Popple <apopple@nvidia.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "david@redhat.com" <david@redhat.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "naoya.horiguchi@linux.dev" <naoya.horiguchi@linux.dev>,
        "alex.sierra@amd.com" <alex.sierra@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Subject: RE: [PATCH v5 2/2] mm: fix the handling Non-LRU pages returned by
 follow_page
Thread-Topic: [PATCH v5 2/2] mm: fix the handling Non-LRU pages returned by
 follow_page
Thread-Index: AQHYsHUAsdqcAiEDdEqE2PI2IKO5la2wpY+AgAANwTA=
Date:   Tue, 16 Aug 2022 01:12:23 +0000
Message-ID: <BYAPR11MB34954F8869F88E8BD34035B0F76B9@BYAPR11MB3495.namprd11.prod.outlook.com>
References: <20220812084921.409142-1-haiyue.wang@intel.com>
 <20220815070240.470469-1-haiyue.wang@intel.com>
 <20220815070240.470469-3-haiyue.wang@intel.com>
 <874jydvxfh.fsf@nvdebian.thelocal>
In-Reply-To: <874jydvxfh.fsf@nvdebian.thelocal>
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
x-ms-office365-filtering-correlation-id: c2327b8a-feae-4b76-a772-08da7f245fe1
x-ms-traffictypediagnostic: PH7PR11MB6030:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZW5wbHQrybIz83uzptZhLbUXFEl315yfbOnm+rnn9oG3TEb+rVS848O6vap6RM6RQDLlm8Yqtq1tAeVRce5lta5zv4FoczDZiVonOgRmfvGIeGzr/gav6OfcNMM5F4pff0kBu4k11DBFIAMVbGqYV0E+VolsfZCnX5HbPNhoF6UjJtHXTwR1NKUZfjWl/r70ufb7LP0I3jjMkflpuBTdHjYJQ3/BpoGaDkJUisXDYK2bvIKaSdBgZM8sAVUVtVDVgwzXdwWFkCePcrUsNymO2wM1hri+Z5INPs45B0cQuizBAHdmJqxxnrLRZnSnO77uZfxGrnu56oSu5FBUMLcrvisFUJzSse/0imBLnzcveMGQ/jIWiLRssnMo6qrYF6TZ9ediN9zzUk3yw+lwmSuEcs3u3Qc8Q/PaZ5pB+Lf0KkeZZ/TWleRsB7cSbOLkUda5vNW4/2OB9areyqvx6qss2DsE3feP8dFtlhwWVGAfIBHYJZfxnnfFuM1vnFkoxmn7YDylmGztVt9pDwbJFBLfo3FeMAyfNsxOnCNDkz/94y8UgXpkbgOIX5dCFS5wm1vho9VVN0U9pD8AqA1Z2g2VIkTEe/Uofbz7s/tkyyA/Muus0OtVM2mXmfAyETADm9zAYsyWcRLtf09WopRK2b+7BAaGNXzizc3F7RJfQuhSm4BATBnpPaabpiMscJ/IZ9HacMaRfiNeg0gaBvqTu73crAafGpv58/3K7Nzlx0aNXMyGT0edGlGuPgiBRXEZJjtJZBzyrgyIUc3q+LWhWDjTBfgySaVfyAqJhc7P32UfruJt6v1x6SmdY7fsc0fx2Pd9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3495.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(366004)(136003)(396003)(376002)(8676002)(55016003)(76116006)(41300700001)(64756008)(66556008)(4326008)(66946007)(83380400001)(66476007)(2906002)(66446008)(54906003)(186003)(316002)(6916009)(122000001)(38100700002)(26005)(9686003)(82960400001)(86362001)(5660300002)(8936002)(6506007)(33656002)(38070700005)(7696005)(478600001)(53546011)(71200400001)(7416002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vgtcuqr/70TJ3elE8WExyieX5sUfUrLLc8G7iCD+ujfvK/EE73vslZwnUnrF?=
 =?us-ascii?Q?OM0CxdAg17sl/wTAZsfow+M5/1S7FG7MvbwV643XeZtJslFoAMeBH2XmyA2p?=
 =?us-ascii?Q?3r4B32ypIlphIK1J9sBhuL2L4Ng07Dc7MId0ae4c0wTOGW8fyMrWys+3ijcj?=
 =?us-ascii?Q?4n3WxDkMCc9efYFHcZIv8y/EM8K+FRpjgDFoOClPMz8MhLqBV1XjCGBp7T8b?=
 =?us-ascii?Q?V0KnOGoe3w/W4gibte7CSfiZfB2sunBlu8bA8FPKhf85PAxwq92DHpxzfalB?=
 =?us-ascii?Q?hksD0ZioCJA0BQBWDcNiZ422Jr22hDAqLEqxSkOavQlbw/QylA0qKSraexyJ?=
 =?us-ascii?Q?Lcv747kKb5pVYspsNsB1xUe3wxrYKhda2EEp29eMyeA3yp7MY66CdbXNdIKC?=
 =?us-ascii?Q?crky4YJYoBRdU9puJHoaRG2tKUg2oK75myUR2aFtEONXUetjNHkTskfNXxzT?=
 =?us-ascii?Q?4D3X+hSnjiJggvoARS0/1RkqNGfIwHTMc7IoboD4SQh+tEJQMlTgvcAfh9Js?=
 =?us-ascii?Q?KoXemmYV6nmUTey3mud/WbhuxaoI3nnZbdJIPntFJghNNANHxIXI73QaOydA?=
 =?us-ascii?Q?Ku04Obu9VIySneNMQ2S0ryK49MC4bchgxA+2kxXzo1tz1y9vCVgis1XkVvDb?=
 =?us-ascii?Q?LPOdAAWxJTr5iE5SI22Uvhw3/547jFFBAnUI+UQB6AOO1iQxApnfayd/LipC?=
 =?us-ascii?Q?jgcaullUi62jzbPLPOtvD7UtMzjp0Xu4T0o9wD/4J+C17IVtejr4VN2Rg2Ik?=
 =?us-ascii?Q?/TeKuZ81QcRYaWXePeBzj6GI3RgLkwVtQoua0UF9RwWMawVsdsyPcEWhpQp7?=
 =?us-ascii?Q?KPgu4cUWNeU62Q/DPpB5c/XEeGQaRWZL2+PZ3sj1XifBZsXiCSQbjJQvxQ6q?=
 =?us-ascii?Q?7ciwOdTe+RUqz7jeMK5ixKR86B1MtVh/Ly4TaB9g26Hz514sQmGeyim3rxFD?=
 =?us-ascii?Q?fq3cKK8G9PVwpp7I1UWSGLNd2lCZwnfJoTurtrwKcS9CKyJphm46vp08dnrK?=
 =?us-ascii?Q?B3CjVfPzlQHYoV1PB1XsfZo9X6xrfw+zin3O6niZONC3yexyWTY6q6K3X1G8?=
 =?us-ascii?Q?zccizXpiqXjYFoqpt0XDp0SuSec2sEeH5qfDGeEGETN/puMx2aKcIdOy1g1L?=
 =?us-ascii?Q?K2x7ZEvw/WZA0riJtKT9+Fc8WE0e4Ez+MdiPSI0a8YSoUBzAmUTwICPNepOC?=
 =?us-ascii?Q?xEG01uIhba8H53c/OxjE7WVcF9Oyz3V6GadTcT3L1HLVofXls4OTTUPu8hCY?=
 =?us-ascii?Q?H/So3I9BHM/CPccK6IUjMutsLYp25Xnf4ek7553eoZMyI0Ucrf10S+iUmPd2?=
 =?us-ascii?Q?S6BEcjEvz+SAjUrsoNfzIWbZMvCJ4SC4A37oQCfyCvPR0ghcgchn+T7w8A8X?=
 =?us-ascii?Q?2fAAPCC6I1oc50DftpJdymHuPT6aRyrUZADTwuz9wihL1jn6rXhVzsGLMSHG?=
 =?us-ascii?Q?XwVvtYLwZ8qFveDtwZ9SkxtzioNR9kcOFFbCMf50C1JiJhosZvgUDnWL3zOT?=
 =?us-ascii?Q?4nLLQbPA1ufEMin9/6GD4A/TIaSRQbtumR8Cfd1yCaicPVpYuv/s7cDFASPu?=
 =?us-ascii?Q?ZROIe6o0S7piWql5yTD7jtjJFB2Q+R4QmArrNKAX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3495.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2327b8a-feae-4b76-a772-08da7f245fe1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 01:12:23.0364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jR7PLnGYdYcP3/6b+F8qgC3RQWRRkJw5YoRfKwBXy38rD1rBOeaZMpYmbEFmYAP0WlGHW7V5oWs4imVZw+0c3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6030
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Alistair Popple <apopple@nvidia.com>
> Sent: Tuesday, August 16, 2022 08:01
> To: Wang, Haiyue <haiyue.wang@intel.com>
> Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org; akpm@linux-foundati=
on.org; david@redhat.com;
> linmiaohe@huawei.com; Huang, Ying <ying.huang@intel.com>; songmuchun@byte=
dance.com;
> naoya.horiguchi@linux.dev; alex.sierra@amd.com; Felix Kuehling <Felix.Kue=
hling@amd.com>
> Subject: Re: [PATCH v5 2/2] mm: fix the handling Non-LRU pages returned b=
y follow_page
>=20
>=20
> Haiyue Wang <haiyue.wang@intel.com> writes:
>=20
> > The handling Non-LRU pages returned by follow_page() jumps directly, it
> > doesn't call put_page() to handle the reference count, since 'FOLL_GET'
> > flag for follow_page() has get_page() called. Fix the zone device page
> > check by handling the page reference count correctly before returning.
> >
> > And as David reviewed, "device pages are never PageKsm pages". Drop thi=
s
> > zone device page check for break_ksm().
> >
> > Fixes: 3218f8712d6b ("mm: handling Non-LRU pages returned by vm_normal_=
pages")
> > Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
> > ---
> >  mm/huge_memory.c |  4 ++--
> >  mm/ksm.c         | 12 +++++++++---
> >  mm/migrate.c     | 10 +++++++---
> >  3 files changed, 18 insertions(+), 8 deletions(-)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 8a7c1b344abe..b2ba17c3dcd7 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2963,10 +2963,10 @@ static int split_huge_pages_pid(int pid, unsign=
ed long vaddr_start,
> >  		/* FOLL_DUMP to ignore special (like zero) pages */
> >  		page =3D follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
> >
> > -		if (IS_ERR_OR_NULL(page) || is_zone_device_page(page))
> > +		if (IS_ERR_OR_NULL(page))
> >  			continue;
> >
> > -		if (!is_transparent_hugepage(page))
> > +		if (is_zone_device_page(page) || !is_transparent_hugepage(page))
> >  			goto next;
> >
> >  		total++;
> > diff --git a/mm/ksm.c b/mm/ksm.c
> > index 42ab153335a2..e26f57fc1f0e 100644
> > --- a/mm/ksm.c
> > +++ b/mm/ksm.c
> > @@ -475,7 +475,7 @@ static int break_ksm(struct vm_area_struct *vma, un=
signed long addr)
> >  		cond_resched();
> >  		page =3D follow_page(vma, addr,
> >  				FOLL_GET | FOLL_MIGRATION | FOLL_REMOTE);
> > -		if (IS_ERR_OR_NULL(page) || is_zone_device_page(page))
> > +		if (IS_ERR_OR_NULL(page))
> >  			break;
> >  		if (PageKsm(page))
> >  			ret =3D handle_mm_fault(vma, addr,
> > @@ -560,12 +560,15 @@ static struct page *get_mergeable_page(struct rma=
p_item *rmap_item)
> >  		goto out;
> >
> >  	page =3D follow_page(vma, addr, FOLL_GET);
> > -	if (IS_ERR_OR_NULL(page) || is_zone_device_page(page))
> > +	if (IS_ERR_OR_NULL(page))
> >  		goto out;
> > +	if (is_zone_device_page(page))
>=20
> Same as for break_ksm() I think we should be able to drop the
> is_zone_device_page() check here because scan_get_next_rmap_item()
> already filters out zone device pages.
>=20

The 'page' for scan_get_next_rmap_item() is from 'vma' which is NOT MERGEAB=
LE:
	for (; vma; vma =3D vma->vm_next) {
		if (!(vma->vm_flags & VM_MERGEABLE))
			continue;

The 'page' for get_mergeable_page() is from 'vma' which is MERGEABLE by 'fi=
nd_mergeable_vma()'

So they may be different, and the unstable_tree_search_insert() shows the l=
ogical:

 'page' vs 'tree_page':

		tree_page =3D get_mergeable_page(tree_rmap_item);
		if (!tree_page)
			return NULL;

		/*
		 * Don't substitute a ksm page for a forked page.
		 */
		if (page =3D=3D tree_page) {
			put_page(tree_page);
			return NULL;
		}

		ret =3D memcmp_pages(page, tree_page);


> > +		goto out_putpage;
> >  	if (PageAnon(page)) {
> >  		flush_anon_page(vma, page, addr);
> >  		flush_dcache_page(page);
> >  	} else {
> > +out_putpage:
> >  		put_page(page);
> >  out:
> >  		page =3D NULL;
> > @@ -2308,11 +2311,13 @@ static struct rmap_item *scan_get_next_rmap_ite=
m(struct page **page)
> >  			if (ksm_test_exit(mm))
> >  				break;
> >  			*page =3D follow_page(vma, ksm_scan.address, FOLL_GET);
> > -			if (IS_ERR_OR_NULL(*page) || is_zone_device_page(*page)) {
> > +			if (IS_ERR_OR_NULL(*page)) {
> >  				ksm_scan.address +=3D PAGE_SIZE;
> >  				cond_resched();
> >  				continue;
> >  			}
> > +			if (is_zone_device_page(*page))
> > +				goto next_page;
> >  			if (PageAnon(*page)) {
> >  				flush_anon_page(vma, *page, ksm_scan.address);
> >  				flush_dcache_page(*page);
> > @@ -2327,6 +2332,7 @@ static struct rmap_item *scan_get_next_rmap_item(=
struct page **page)
> >  				mmap_read_unlock(mm);
> >  				return rmap_item;
> >  			}
> > +next_page:
> >  			put_page(*page);
> >  			ksm_scan.address +=3D PAGE_SIZE;
> >  			cond_resched();
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 581dfaad9257..fee12cd2f294 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -1672,9 +1672,12 @@ static int add_page_for_migration(struct mm_stru=
ct *mm, unsigned long addr,
> >  		goto out;
> >
> >  	err =3D -ENOENT;
> > -	if (!page || is_zone_device_page(page))
> > +	if (!page)
> >  		goto out;
> >
> > +	if (is_zone_device_page(page))
> > +		goto out_putpage;
> > +
> >  	err =3D 0;
> >  	if (page_to_nid(page) =3D=3D node)
> >  		goto out_putpage;
> > @@ -1868,8 +1871,9 @@ static void do_pages_stat_array(struct mm_struct =
*mm, unsigned long nr_pages,
> >  		if (IS_ERR(page))
> >  			goto set_status;
> >
> > -		if (page && !is_zone_device_page(page)) {
> > -			err =3D page_to_nid(page);
> > +		if (page) {
> > +			err =3D !is_zone_device_page(page) ? page_to_nid(page)
> > +							 : -ENOENT;
>=20
> Can we remove the multiple layers of conditionals here? Something like
> this is cleaner and easier to understand IMHO:

OK, I will try it in new patch.

>=20
> -               if (page && !is_zone_device_page(page)) {
> -                       err =3D page_to_nid(page);
> -                       if (foll_flags & FOLL_GET)
> -                               put_page(page);
> -               } else {
> +               if (!page) {
>                         err =3D -ENOENT;
> +                       goto set_status;
>                 }
> +
> +               if (is_zone_device_page(page))
> +                       err =3D -ENOENT;
> +               else
> +                       err =3D page_to_nid_page(page);
> +
> +               if (foll_flags & FOLL_GET)
> +                       put_page(page);
>=20
> Thanks.
>=20
>  - Alistair
>=20
> >  			if (foll_flags & FOLL_GET)
> >  				put_page(page);
> >  		} else {
