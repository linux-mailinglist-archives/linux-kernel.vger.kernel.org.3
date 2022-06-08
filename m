Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C215437D6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 17:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244810AbiFHPrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 11:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244786AbiFHPq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:46:59 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914C8265E;
        Wed,  8 Jun 2022 08:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654703217; x=1686239217;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jj5dzTAom3ELyf3uQImb8gy8RTzzmoMO/ZpfuAA82Vw=;
  b=nPIPn8v0halloFBMGljvwtvfyRFN63mJwszxqf2f44h6PddSHOuI6aJJ
   WN8qbmtVchCPthzBYMJr2ykNT+/ju9Qe31Ok4xtMFs+GjPvGFhSqPR/hh
   5IVunePI3+npgfSj7DvnQVkXKT/pgDQH4S/O/cGzq9bKcFaJ2j2h2v4ZI
   YFFYSrEtDL4fO7iTfsfMhdvQXh7STSnHgujijUeAJe7l7slRPpYec4sYV
   KY1689pFTtFki+0oiIDuusPCn+bRNcnBt+yyWUkqCT8QADUoASqnTLDLF
   1+jlJ7SKvgmjBDYeH2Gau0zQ5Yk8G7Fnc+furdNYLriw5FRgk1t5tLZvO
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="278111222"
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="278111222"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 08:46:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="670626063"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Jun 2022 08:46:55 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 8 Jun 2022 08:46:55 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 8 Jun 2022 08:46:52 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 8 Jun 2022 08:46:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMB3dIjOSltP2sAf21NPZ7X/pKN3FkCXAtpttU2JDIywsfD10fYwjGR4liQZz20wQFQOhOx5pFzJ2rEegw+6HjINzTAoeeBGWrsHUkPGW9uREKA8oqvVpu9/32c4nnAP6h9sQ4xgltYH1mOS0jHQSvLJgxv0uCMtKcx8/OI3vOcW13EjjL0t9t/j3COIFjaSBic9+3jnEDmdT8KznW3JXwYd2EF9JML/ke5oV8GVv9LbMbaaKuNYVVaBF/9LkvonlV2efmklI3qJ6pP259p4bIFTQT7p6W9qJZcJg4I3ZhvG0MEpJY7u2Ljt1xu5tqZHsOIpsh0JgJrvkKpAQgGtJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fXUxezkwutjfyGBXdbS/G8Rv4tBgxYMM05X5AVGCuo=;
 b=OT+4guYF3Cn72j2o6ngDC69lsK9UpolBMejEPlxg9bMk3ma+09HwL58bVW1T0NqmaG9PwuRS3oVyDuckHIwu1EDb6HoLt+Zirhpq51nou7k1EiQvqFXjU7dU696Q/2b/SiqCdFgT+2HDQ/H6Z1CIsH+bO8UhK5eOoLBrrWRlPZZQ7UoRBSGRBO3bq4nUYRSSaDiwEpTmA+9228R80yqr4F//ZUKk/U6yy8g+Jgq/IvayRqajnruU7fm/kyTPHnkt1mPC5Z0QM0ftuIqQZ+OS8X2MQxsx0c/LDhGYmLfm8dc7+blKmo02cVPBIHTx9nELJGeUDf0oJ5GxhJGkTWqVeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4138.namprd11.prod.outlook.com (2603:10b6:5:19a::31)
 by DM4PR11MB5375.namprd11.prod.outlook.com (2603:10b6:5:396::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 8 Jun
 2022 15:46:49 +0000
Received: from DM6PR11MB4138.namprd11.prod.outlook.com
 ([fe80::e9d2:8b69:bb48:b305]) by DM6PR11MB4138.namprd11.prod.outlook.com
 ([fe80::e9d2:8b69:bb48:b305%7]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 15:46:49 +0000
From:   "Xu, Yanfei" <yanfei.xu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: RE: [PATCH] perf/core: remove a meaningless pair of
 rcu_read_{,un}lock()
Thread-Topic: [PATCH] perf/core: remove a meaningless pair of
 rcu_read_{,un}lock()
Thread-Index: AQHYexxJIp65vUVEWkqJ1eHLcUUC761FpFMw
Date:   Wed, 8 Jun 2022 15:46:49 +0000
Message-ID: <DM6PR11MB4138B6E8265A903DA8F68E4EF0A49@DM6PR11MB4138.namprd11.prod.outlook.com>
References: <20220608090938.2178624-1-yanfei.xu@intel.com>
 <YqBvMWwc1T4ZdKCg@hirez.programming.kicks-ass.net>
In-Reply-To: <YqBvMWwc1T4ZdKCg@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68eb997c-f97d-4743-4e81-08da49661996
x-ms-traffictypediagnostic: DM4PR11MB5375:EE_
x-microsoft-antispam-prvs: <DM4PR11MB5375D2245A2F4D5EDE737058F0A49@DM4PR11MB5375.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZN1BZmHrfxLi2zq8Pa2LkltNjTPIyiVac+OG7+Io+z1FBzUhEcVJ/BIroaXHcI19HdEygW+zO5zbCrm4zuRf97ttISYAyOV1Gv4uG1pqPJPXd2WpaFqychlU1QmFMCYDds+tseyZZ0J6onJwh2hO//k7xJB9gPyxGIDN6AVkhKPr/sRoza6uNHF/mG8t0VNbbiqZ0SggPt8qzky900CcGJmddb8NnHZQaVyECGg0D+a75snv2X8236XE8TkdA9UFiAUDjN4icAuNSHTf0tsIpft7pomxO6Id8115DjvqAxZXf3s5iXqeVKAUeU0oDYV2kNOW+7OL/mRNwfI1Bp0nhmLMU7xddA2hnJcqvov3I9UZAHF5mhS54BTdNjcDyHaaMl3pj35Vu2DtAILw8KZBoAbLALAd1N7VcEeUHKRipnOqWufNbmvbuP429oMBE7opuVRix8m8LSRinHE9/5+8o22+g9JrZSMGCLhaZIR6LcHKgyM33I1RjbepcUoFCmv3677OUetpghhfifl1RiM8BrEfHkDmjiAJYshQ/o8sdd2xwT4FAJ1OSGvA4bnnGgCkDRXRuXgaRVsi8zd2p400yVLZ8NGjZg5ZpbcXjR/Th1QQU2ZpBB1vE58WF8OdnaI7VGwrN/toj5/phn5FpHo851X+mZLofoNBM8VShnIr3DlFonr/sGCB8lSZHLiXKgCN9d//rZSxG5cZKugq+dyXdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4138.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52536014)(86362001)(508600001)(83380400001)(55016003)(38100700002)(33656002)(6916009)(186003)(53546011)(54906003)(7696005)(9686003)(26005)(71200400001)(6506007)(316002)(122000001)(5660300002)(2906002)(4326008)(8676002)(8936002)(82960400001)(66476007)(64756008)(66446008)(66946007)(76116006)(66556008)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aUSUZp337FLgq70jZr2uR5mCx4SYXa1xZJUxOJkXCg1y9uTUEhJHDu7XFMvk?=
 =?us-ascii?Q?47SCJqJ06mK9xcVPeZd23loC46yrPCuCW+KXs1I2LMIeMTRPDUpc3tJGLYn4?=
 =?us-ascii?Q?aOfywzdcUZ5To41zAmU/JIS1+mx1jLyGmcMSuJw5S7h3TMT26qOLE+Lezqte?=
 =?us-ascii?Q?tTSh8Qy1gxzpg5OsGJa7Rb4aXTmB34y2J+Mxtk55YiKgp3eHBZDFCqoy8Z5m?=
 =?us-ascii?Q?Sxl0SFMYeddE4Lvta0YUxHZL/gXLjnIkyOHamryQk/g+nICOZJboskObPX2h?=
 =?us-ascii?Q?4SLX5tl8gjRrO1loRRULDXwuGB1iXYlk5fd5gct4g6sp0aVH+UgVYb8cotrW?=
 =?us-ascii?Q?D785qkMphXqFtohl4oRgdQ07JZFOcCCwqjVDavGiwNymNvfF68763EeksMlS?=
 =?us-ascii?Q?Mc68Ds0rrbGydvm6cOXn0i6qW5CjThIkQWYMbnCKfmnohyDeK5AmV2M4y/wh?=
 =?us-ascii?Q?f2SBmGmxvK2pVt5nkpSTdm35sZgayyOdVXvM33eVRTxksUcMIjyia65dfEIz?=
 =?us-ascii?Q?0KR5s//yBQuR/uYaRppFKZKOiRalmlksHEwEL0F0/RR1GyHyBsjZJUf81KCq?=
 =?us-ascii?Q?DB7rXoklCKzv64vVNubMphfaB8+pTXHQOQE7Ei0N/2HSOS3iz62pVCh7mLLE?=
 =?us-ascii?Q?/MN7ck7TI52ec9tz0Oo5WBD0RunYk+SioHN5+V9J7o3/z95keCYBR/L1aRrv?=
 =?us-ascii?Q?8BvB5oG0q5lhgQZWz1hBL4fwze+y1yEcdBvdMQMY2ERHrodZBw3A/5EbQ2yx?=
 =?us-ascii?Q?92Q2hB0jc32rk6989u2H5zRZvfZNZ/noT2UfR1i69G2Cum0RAbhTF/qZJqSV?=
 =?us-ascii?Q?DF0Zdd75oUDBmeEqSPt0416LgcAuu8Gw0HUluzT1OtYEKDeesM0pBbqnrLAW?=
 =?us-ascii?Q?0MxMiphNWEcYqOgNrrn+S7RP9f0vNqLQS1wHoZevD1ew67FPskk1s67m09wX?=
 =?us-ascii?Q?u+IlNxy7OtSfNeq9CLBoV9b1rhZSWlP8x9a9fojWPTGfHcUgLKcSWi6W6wlC?=
 =?us-ascii?Q?2+jglrIQkCAPXYr7E1f6IgoyjUMfYo7Fi7aUnQMbu1ykMDBalzL55mNW03TM?=
 =?us-ascii?Q?MaeIpo2Q73ckU8aXX3HiQvFm6L9XcJHQTL/heY9dupFW8CNYWbLH14W5Iue8?=
 =?us-ascii?Q?jTZfkYyW4n9zQ+GDIM0hhHy9afHwUK3vo+SyoqtZUyeqdrelYaRS6Qr10ypO?=
 =?us-ascii?Q?UfS2NzEhFgfkr6VMQ20BDoT7BWmXe+5bRnk0h7SuTg2PqmZi6hmIsEOQ45Gp?=
 =?us-ascii?Q?lPj0xSFLsRqmKtlUYbTzCdW/eKdIOxHN9PEDaqStF7tpKAB+3jgmiK+lH923?=
 =?us-ascii?Q?uoYAVYwAu7M5tNDMcNsPfNgUP6zOUB1E0eoTwGJO3PqzIYiBymqp28Hm/V1R?=
 =?us-ascii?Q?INQ1s9eTIqUa8bEp9IhOpbF+cHbVTjUWe4q/1VrUdYPA3wKrA8xlJZVl4gH6?=
 =?us-ascii?Q?R6b17NeY3eDKzL7bEnnRssLjmakODfh7KTuc4hn2IQ8FW3QK5+ZV8MTPO6r9?=
 =?us-ascii?Q?fPpF6rvUO79+k23BmMb6EfIHjdSN4hNeUMcwRqfgLAqnkuA7wD6eKP/ho1Kz?=
 =?us-ascii?Q?CVuT0xifIqcfP1ly5y9852hOewt0C7V28cgVaY3/UNd3NKwSQRtPcP22LQhL?=
 =?us-ascii?Q?nTxQgeW5hgJ1uhHUo3UH2GXbmkgXboGl2EAmmypOa+s3cMZzl2nVx5HsNtl7?=
 =?us-ascii?Q?y3HWPdviVfzwJHot/mBLZg9MMCU2FS8nmU5a5PL1XloCN+OX38p+eIvw7y0j?=
 =?us-ascii?Q?A+j7Em2GeA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4138.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68eb997c-f97d-4743-4e81-08da49661996
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 15:46:49.0494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h0FllOks/1i5lR9CmqdL0QDZJ6Lsb9coPBRkP6lwmChobkkLRZmKlSDF26bC3zM3KsRvI6d55hITdHQIh20kjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5375
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Peter Zijlstra <peterz@infradead.org>
> Sent: Wednesday, June 8, 2022 5:43 PM
> To: Xu, Yanfei <yanfei.xu@intel.com>
> Cc: mingo@redhat.com; acme@kernel.org; mark.rutland@arm.com;
> alexander.shishkin@linux.intel.com; jolsa@kernel.org; namhyung@kernel.org=
;
> linux-kernel@vger.kernel.org; linux-perf-users@vger.kernel.org
> Subject: Re: [PATCH] perf/core: remove a meaningless pair of
> rcu_read_{,un}lock()
>=20
> On Wed, Jun 08, 2022 at 05:09:38PM +0800, Yanfei Xu wrote:
> > Per the codes, this pair of rcu_read_{,un}lock() protects nothing.
> > Let's remove it.
> >
> > Further, the variable "pmu" is safe as it is in the SRCU read-side
> > critical scope of "pmus_srcu" and perf_pmu_unregister() delete it
> > after calling synchronize_srcu.
> >
> > Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
> > ---
> >  kernel/events/core.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c index
> > 950b25c3f210..36b0df6feab4 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -11296,9 +11296,7 @@ static struct pmu *perf_init_event(struct
> perf_event *event)
> >  	}
> >
> >  again:
> > -	rcu_read_lock();
> >  	pmu =3D idr_find(&pmu_idr, type);
> > -	rcu_read_unlock();
>=20
> You're mistaken, this is required for the radix tree internal nodes.
> Without it we can't safely traverse the radix tree without full serializa=
tion
> against the modifiers.
Thanks your reminder! And after digging and learning these commits: f9c46d6=
ea5ce ("idr: make idr_find rcu-safe ") and 452a68d0ef34("KVM: hyperv: idr_f=
ind needs RCU protection "). Now I understand it.

Thanks,
Yanfei

