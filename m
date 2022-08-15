Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2D259290D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 07:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240519AbiHOFUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 01:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240386AbiHOFUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 01:20:36 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBD32DC9
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 22:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660540832; x=1692076832;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yvoJehls2N1xgWA4A5x0BaZ5V0ifbZvFlKEVHp0P0Ag=;
  b=CoCZzO5KPJhCDL6/5dwUwOxF0jpWT97dnb3X9Gd5obObAVbEXFS4AOyE
   D4+MFB65pVpHuQiM3U5gTA4pwocNodFjpGzWESkJPV/hLP/eiMc2jDMMw
   yekpI+oYCJZJqK2mSyssJHymzFVdtk/0ksHSEgBsi25l9F4XLdhGQcXuL
   oB7Hh7FPuGvteRvo+h+R1JGZj1EKbqBxl3U2NYXkIlVa1B49SDVyWRJjy
   KB5rWmY5Ow+36eBJwLiuNfUMzruRrKvQJyoedHv8wnRcgk4j7gapXgTrL
   0PaYZGLWFB/lFOKx5P8hJ8xgBO2U7KNHWhf+SFLGqZX6e/YfbdAu81GPr
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="274947359"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="274947359"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 22:20:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="666542988"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 14 Aug 2022 22:20:32 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 14 Aug 2022 22:20:31 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 14 Aug 2022 22:20:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sun, 14 Aug 2022 22:20:31 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Sun, 14 Aug 2022 22:20:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjUuGUWtZpyXxMEg6CJ6PcQANao/5DSr2WoHgfFSkiDG5EFxu0ZBz1p4+JnQiPG2bPGPNI7TWIlZuHs30UjKHD9S9akrLXTjtzN90W46VWKPTIQpjSihxGohTzC7hQgThxLmoCGWu/F9w1nvDbDHybJBDDTUvGudbK1GnmPTPVKcgRQkBZr8zBNP9OhYR7ElLH6IMLt+6pIx3l7L/4iTThgCNL84k+1S+HWmwGgp81hT73fYwaIJq9SXqTdG0ayaa1ylP2wwkvcT0cFJ/t8JP3P3BFidkn9Wn/a2b0z3Nw5Qspb9YOMlqnJOASPn2BmgZhgLFP6tWY6tgQTybLKs9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZwOEUz7GM2zOgia7EVx4LWM2kec22QUUfjaWAX0SS0=;
 b=T7ltiJ00slckuacSImkqyx/AQaDIC5LWO+owfXtJ1m5EPiKPdhFyX+mQ2zCjhyqtiAJnRX8dqrqB8Q99bUgjUzdrZ2HxfgMw9IZPxMyOUbxBMqLYuMkd1UQsMVjs/PxNaPdHz1jLYEsfCibAlYa+TKTKgmRrRej/z61OF/og2pKsHob8dbpvJ6pDiiZvRgy+bFBLq7HRxrzqZ5Qb3kiYbeqgZyiEQrFQTsLtbu5tM0qyU1vSM/0EQlLq8CxZXaRyXWw0Ju0Nuq0QlK1UzkWEOjmU0xd+rKmazmBEwj5qPebr7YLT/xjlpa4PK0Eb2x3uAfhIJ2YTk8C/yMSh0tWs0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3495.namprd11.prod.outlook.com (2603:10b6:a03:8a::14)
 by CO1PR11MB5025.namprd11.prod.outlook.com (2603:10b6:303:9e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Mon, 15 Aug
 2022 05:20:28 +0000
Received: from BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::6133:d318:f357:48d7]) by BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::6133:d318:f357:48d7%7]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 05:20:28 +0000
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
Thread-Index: AQHYsEqaehDxLZhp/0WpLois8QzWXq2vXnsAgAADE2CAAApTAIAAALnA
Date:   Mon, 15 Aug 2022 05:20:28 +0000
Message-ID: <BYAPR11MB349505CD7A028D8132DB40B3F7689@BYAPR11MB3495.namprd11.prod.outlook.com>
References: <20220812084921.409142-1-haiyue.wang@intel.com>
 <5767084.K44AtQxeQl@nvdebian>
 <BYAPR11MB34954E0692FAD9FFB66FD2E6F7689@BYAPR11MB3495.namprd11.prod.outlook.com>
 <8348741.Rxym6mXZyZ@nvdebian>
In-Reply-To: <8348741.Rxym6mXZyZ@nvdebian>
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
x-ms-office365-filtering-correlation-id: c7019a41-9730-49b2-23af-08da7e7dddc4
x-ms-traffictypediagnostic: CO1PR11MB5025:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Ye0rC0/BqJrLzjV3hivvT3m8CLGFhjUe7y9ta/ppZrhBYkJXPcedZvEobEKpLmpXwMayQkIJCzIDZ3l9l4oJzVYOPeCrMawWUUmGlHJLB/eLZanj5FDyxc5dGInj+TMhjESO2WiJiYVEy7/CEQAtbf/LQcfJ53ORbaFqRTKTSqR7w+KtRMpZjOxxxfNP/vSn6wi2em+n9QIbmzVVeGZ/4jZHVlxTbOrdOafe/DVNal/TC1LoJGgZyHKfkiUK10UVYzhfRDR5bwEQ7tztWzdieIxCipzjORUiY1P0fPjoof0emT6eu34ZLOE3YIDNMk9gUaNBQkBcoKSRIkuQd07w6uI30Xu7cNRycXNEj7aSBzvsw+GvY/LGBjE+tqveppuHFjLSIj/pS5ebrRDqHNKsg3nYuZWczvEAHMC9W1SgfdgcLTRTeKrjiu1NzorS5hGXGQMykDvk0cHXBgZJGqNYQU3m2UlWVSkhRJUfCMwEoKEvJ0oIyUbrvltqRTjv1U7cUXcOqbmfbUStKHu7rItpH6eAENU92oSCVivWYR78kdqXZni0eOZER3jEsPuPJsAM0uEcdCft5/mBhmn1ruRr7Xg6vrb0IaoxuFrqIX85/LOKN3R68yX0RWqknj13IGm14vZFDVrIcGb+3sWvnmlQWMHic84qj8jlu+NOnr4qu0i6F08OgoYG4HsJLNSDaTLW3slC4j4U5I3DYTZRz9fRVFXLGQHU1cH9FEtPQbsoNXV/oYqka/PKMUwgUnbrbPKX5pYUrO6ir7rWU8PBPzTET+CiAl6oXVu58zeHZrjmz1fI0emGejjtFeFWyOxzGppCneZXyG9MarGLx5UEngIrA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3495.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(376002)(136003)(366004)(346002)(54906003)(53546011)(83380400001)(82960400001)(316002)(55016003)(38070700005)(9686003)(26005)(478600001)(7696005)(186003)(6506007)(5660300002)(41300700001)(33656002)(110136005)(8676002)(2906002)(76116006)(66446008)(66946007)(64756008)(66476007)(122000001)(86362001)(52536014)(66556008)(8936002)(4326008)(38100700002)(71200400001)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9H74/wn8xStXsiIbQ7NYBPR65l9rDdo0A9bHO6MSlVwwc6aEwF7QzhOTOZzh?=
 =?us-ascii?Q?HOEr+eHjmuwkCLoc1s6zlNnPsSmZM9gfEM/Q9qHp8OUilU8+XhqIYFzqEl+A?=
 =?us-ascii?Q?HjEmquIdCoZ87h0/XdTB/UPPueExLMlXr/J3CIkqbizr940kyCWolcSptoWH?=
 =?us-ascii?Q?7B5+4Hyg9Sgl/vFtux3xEhbqUjY3oEyFTGcmlB0ohRqQElrg8RoH26dW9x42?=
 =?us-ascii?Q?bHgXDBU4IpyEkI1E7dTAE3vd7Me8EJX7eIgAWm403aMoRZ2ym6V+kDy0sG+G?=
 =?us-ascii?Q?/UUAepba1ZKJvzl2fhjmJ3KJQnpLw6t4BF9rH4X44ZCa8r/lh4psNipGbCqh?=
 =?us-ascii?Q?zV9JO1ovkFmtLO8COFmtGkqHpcU8DXNvzhEboJIGTocl/VnojXULvsFbbrNM?=
 =?us-ascii?Q?rkSa+/p4ljn+GtWsFM287IHvEAoxDJVCRDouiNbxGkb9goH3t83ED2uw+rtX?=
 =?us-ascii?Q?tjo5CVn7YE9lqzSOhvlpTFBd2c3ynFILDfHHyX7OEqmfQPEhzwx+g2CtqKKI?=
 =?us-ascii?Q?ja0BpAOZXXzua+lhURooEKrx7M16WspynxQ+Q7/wDV+prd1GyIYGh1p8MJlV?=
 =?us-ascii?Q?nsrxsoCcjQnpDBWzjystDm1gwU91n3Ftr1vcLCCE24mefJF8x3Tzzpu53WGu?=
 =?us-ascii?Q?FvsCE67kyjQBRYcvUAA9aBPOdXDzHV3qNl+9ybnUmRQLcMAd4ni2kg3JWvQ+?=
 =?us-ascii?Q?cZxozqTOtEsK0Gd6VrAXYK/9zGsZmWkny9+9BEjX4ldQjCFOPtcG7H0L4WsQ?=
 =?us-ascii?Q?zDmXO5fFytxPG2jcIupOuehf+1ns72trnRgjVjXrfloa/d79j+mClH7YvHdX?=
 =?us-ascii?Q?n9KXEv9YJy2vzxGr92rv4TwoIVj1EFfZFAWzmYEuflCIQQE8hc7WWbnZhXPX?=
 =?us-ascii?Q?YHzAbfjoHaBU86AaYeMMQNsEInNy4TJkR9FeY7ewgeAR8k290fHp5UcYDb5R?=
 =?us-ascii?Q?M2LtDSk5ZYUrdQ8+uo4dK1rdJTmPitUOwzfs5Of4DuoYdN5mwlZog4xJNTMe?=
 =?us-ascii?Q?pSy7WU51wiVd/wyyk+RXCyidre5a4+I8+KP2Bioyma+N1NfU9fNFL4DIZgMN?=
 =?us-ascii?Q?8jbBXUEamSPZh1GUcaw8x/nsXEB/FkM9HsxgUWmOy0VBQ7WdWzRTjkkqDndD?=
 =?us-ascii?Q?0cjSb85NttPK3mxIV5mqQksUibTQVMe+mCtXtVvWkqR7808qwpX/xSx5l5an?=
 =?us-ascii?Q?efxYccE+p2I87oVzTx5O/pJUWd+chv+KDVUYrs+vzMACBIfnxQ317lEShC1b?=
 =?us-ascii?Q?obtPhU+JUsuWuxoK3eBR4OUyPONWXzicWldUeOAUSUSu6TvzulCj3FxbUqwe?=
 =?us-ascii?Q?pKjEg72jsX3NvR08aeUEJnf5P68DH6hSaBbH+NMJaXZzPD/4pc+y37HyAGLK?=
 =?us-ascii?Q?NTlEUIGgqgNdDEb1IScuBNbEjVU8a56seBA2ZWeCCgaEwie5t+/RpzoXgH52?=
 =?us-ascii?Q?uu2LITm6kdrKSLQIRyj02zaaw6o9JWen5QW7lAe8p17JtVqVABTqDwiL5LWv?=
 =?us-ascii?Q?sOJDjZOSFn9oQcSvg/vm9JoV9N1q7/R8yIhQFv0FTkwltmw2wbMBZULjiSsA?=
 =?us-ascii?Q?t8J+CClxvN/r1jwkLp8doAvtrqQgg/SwzRWSwlmz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3495.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7019a41-9730-49b2-23af-08da7e7dddc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 05:20:28.2508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BbglB/SluXls4+WXBKAPHsvfip/sWTt9CiiwcQxWDYd2Ae6y7+3q/ellpoHWA1ZgSaeltYF2E1F30IXlFzv16Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5025
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Alistair Popple <apopple@nvidia.com>
> Sent: Monday, August 15, 2022 13:17
> To: linux-mm@kvack.org; linux-kernel@vger.kernel.org; Wang, Haiyue <haiyu=
e.wang@intel.com>
> Cc: akpm@linux-foundation.org; david@redhat.com; linmiaohe@huawei.com; Hu=
ang, Ying
> <ying.huang@intel.com>; songmuchun@bytedance.com; naoya.horiguchi@linux.d=
ev; alex.sierra@amd.com
> Subject: Re: [PATCH v4 1/2] mm: migration: fix the FOLL_GET failure on fo=
llowing huge page
>=20
> On Monday, 15 August 2022 2:40:48 PM AEST Wang, Haiyue wrote:
> > > -----Original Message-----
> > > From: Alistair Popple <apopple@nvidia.com>
> > > Sent: Monday, August 15, 2022 12:29
> > > To: linux-mm@kvack.org; linux-kernel@vger.kernel.org; Wang, Haiyue
> <haiyue.wang@intel.com>
> > > Cc: akpm@linux-foundation.org; david@redhat.com; linmiaohe@huawei.com=
;
> Huang, Ying
> > > <ying.huang@intel.com>; songmuchun@bytedance.com;
> naoya.horiguchi@linux.dev; alex.sierra@amd.com; Wang,
> > > Haiyue <haiyue.wang@intel.com>
> > > Subject: Re: [PATCH v4 1/2] mm: migration: fix the FOLL_GET failure o=
n
> following huge page
> > >
> > > On Monday, 15 August 2022 11:59:08 AM AEST Haiyue Wang wrote:
> > > > Not all huge page APIs support FOLL_GET option, so the __NR_move_pa=
ges
> > > > will fail to get the page node information for huge page.
> > >
> > > I think you should be explicit in the commit message about which func=
tions
> do
> > > not support FOLL_GET as it's not obvious what support needs to be add=
ed
> before
> > > this fix can be reverted.
> >
> > Yes, make sense, will add them in new patch.
>=20
> Actually while you're at it I think it would be good to include a descrip=
tion
> of the impact of this failure in the commit message. Ie. You're answer to=
:
>=20
> > What are the user-visible runtime effects of this bug?
>=20
> As it documents what should be tested if this fix does actually ever get
> reverted.

An short example *.c code to capture the bug in commit message ?

>=20
> > >
> > > Thanks.
> > >
> > >  - Alistair
> > >
> > > > This is an temporary solution to mitigate the racing fix.
> > > >
> > > > After supporting follow huge page by FOLL_GET is done, this fix can=
 be
> > > > reverted safely.
> > > >
> > > > Fixes: 4cd614841c06 ("mm: migration: fix possible do_pages_stat_arr=
ay
> racing
> > > with memory offline")
> > > > Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
> > > > ---
> > > >  mm/migrate.c | 10 ++++++++--
> > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/mm/migrate.c b/mm/migrate.c
> > > > index 6a1597c92261..581dfaad9257 100644
> > > > --- a/mm/migrate.c
> > > > +++ b/mm/migrate.c
> > > > @@ -1848,6 +1848,7 @@ static void do_pages_stat_array(struct mm_str=
uct
> *mm,
> > > unsigned long nr_pages,
> > > >
> > > >  	for (i =3D 0; i < nr_pages; i++) {
> > > >  		unsigned long addr =3D (unsigned long)(*pages);
> > > > +		unsigned int foll_flags =3D FOLL_DUMP;
> > > >  		struct vm_area_struct *vma;
> > > >  		struct page *page;
> > > >  		int err =3D -EFAULT;
> > > > @@ -1856,8 +1857,12 @@ static void do_pages_stat_array(struct mm_st=
ruct
> *mm,
> > > unsigned long nr_pages,
> > > >  		if (!vma)
> > > >  			goto set_status;
> > > >
> > > > +		/* Not all huge page follow APIs support 'FOLL_GET' */
> > > > +		if (!is_vm_hugetlb_page(vma))
> > > > +			foll_flags |=3D FOLL_GET;
> > > > +
> > > >  		/* FOLL_DUMP to ignore special (like zero) pages */
> > > > -		page =3D follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
> > > > +		page =3D follow_page(vma, addr, foll_flags);
> > > >
> > > >  		err =3D PTR_ERR(page);
> > > >  		if (IS_ERR(page))
> > > > @@ -1865,7 +1870,8 @@ static void do_pages_stat_array(struct mm_str=
uct
> *mm,
> > > unsigned long nr_pages,
> > > >
> > > >  		if (page && !is_zone_device_page(page)) {
> > > >  			err =3D page_to_nid(page);
> > > > -			put_page(page);
> > > > +			if (foll_flags & FOLL_GET)
> > > > +				put_page(page);
> > > >  		} else {
> > > >  			err =3D -ENOENT;
> > > >  		}
> > > >
> > >
> > >
> > >
> >
> >
>=20
>=20
>=20

