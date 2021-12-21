Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6321747BB00
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 08:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbhLUHXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 02:23:23 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:1216 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230057AbhLUHXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 02:23:21 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 1BL3taY9003819
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 23:23:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=a08j1CatzpxNOpkUxnx8XTUjcC7W+4i/GFTMyOYtMxw=;
 b=UUhuZ/A6QcaO5ZVqxzzHV5ie0yWGhkPzrzES3to4Q+5LQ/KYQO3q0FRtZ38oMJhlLDN8
 2HiiO/sCp5J7KI91hxfaJOt2fLH2AUCdPfSM7VUzxc4QBWIM8dYEN/iOKvQcQ4gz7zfH
 ipg1UzZWRoMCe/EdCa4yCROgV6pt6FNzNSk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3d37efgy0r-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 23:23:20 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 20 Dec 2021 23:23:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=linENd+mAshkmfXLMsMzvuvTdbiJN1xkscTifU0LzRSGezC+vzOixQECU9nwvlivjB876YFk85+k7dx3/r+3WlfHFsfjJdQF4gWSo+FESV6aHIuc78DPkjVtx0KiIngVVglY6bAwXWIQwBCh9/oMQT7ofKEuRXLQPVrPArj1fDlOgAjogoiVQz8JBfOtj6xr1aVt19fh8INrk0gBmBxgDSyWOA5scUNoSWc1xvRRQvwoUurx+8uu/0xrM1PHzV6uBQ9z+nZwxc3ZODVDQeG1sd3OUOoixb1RMjbzhkwhjLYZqwkQciIRAeoHgyss9o/Bb4ptKEfteorifsFaMKugkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a08j1CatzpxNOpkUxnx8XTUjcC7W+4i/GFTMyOYtMxw=;
 b=b5LIeGtS9L3bvLm/GxFbYnXJdP3LC+il0GuH27M0laR2zzCIkNgI55LAxGR4xmfnNwCm0uydeVhFyR4b9OhvTJHRzBLg5u5UGiiQyECt1epgBQiu9lS1dhyRKKIrqOVaJ2YiYPQZVWZSKuTCAl1qcKIVL6pncKpre1TNiiLBkT4AxTQ96ith63oMlVtVKFOow8V0I5Vcz7tAsWDgSdGUoDj4hsU+qeRS+OtDj1iGx/HQBOnhakuXdQkCAeFBie8n79anLdtQ/jb9tQjm/lJLjCXeM/XwYdrXE4eGKlWhW6MGmVZGFx3HgcoVuBXKUEboWz7J/hiEPZTMJC/Hw56I9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5062.namprd15.prod.outlook.com (2603:10b6:806:1dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Tue, 21 Dec
 2021 07:23:17 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::f826:e515:ee1a:a33]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::f826:e515:ee1a:a33%6]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 07:23:17 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Ian Rogers" <irogers@google.com>
Subject: Re: [PATCH v3] perf/core: Set event shadow time for inactive events
 too
Thread-Topic: [PATCH v3] perf/core: Set event shadow time for inactive events
 too
Thread-Index: AQHX6ipF/JnJvZ9n50qVJHJ8Sj4PjqwqCucAgACqDoCAANmCgIALZWAAgARvmwCAAT9zgA==
Date:   Tue, 21 Dec 2021 07:23:16 +0000
Message-ID: <DC7F1B1E-99DB-4121-91C5-EEB51FBFA7A9@fb.com>
References: <20211205224843.1503081-1-namhyung@kernel.org>
 <YbHn6JaaOo3b5GLO@hirez.programming.kicks-ass.net>
 <CAM9d7ciJTJB1rumzmxGeJrAdeE9R4eXhtJRUQGj9y6DBN-ovig@mail.gmail.com>
 <20211210103341.GS16608@worktop.programming.kicks-ass.net>
 <Yby8Su+fVA1lqVjT@hirez.programming.kicks-ass.net>
 <YcB06DasOBtU0b00@hirez.programming.kicks-ass.net>
In-Reply-To: <YcB06DasOBtU0b00@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.20.0.1.32)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c59aec59-ed7b-452f-77bc-08d9c452c1fd
x-ms-traffictypediagnostic: SA1PR15MB5062:EE_
x-microsoft-antispam-prvs: <SA1PR15MB5062EC63BCC9BDCCBE614D4DB37C9@SA1PR15MB5062.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5FoJGHUSUh+RYvnHpDgkSjrKMfeUSNPPI/NJX4xe82p7W6LfqpnehHfeSkcbgAUYVXn9+1KlGYggABSjaeeKH86uZzX6iDE3QIv3kGoltEhJ6ePFsdzQMH6yMN1AfE5p7AJ3FnKLKjYEz1XkMhvCg8MIR25CcAL+6FLZa+34BUxInuHpcnRL34bDcBAsBLz5RYDmgVWIf9NCkXZ4bkLgaCR2B1Dkth2iHtJeUpOwGsBqvyg2v/+3NowYCExgYZbXx7ba1H3dMlWltjS+nWRJZuffVItqBbn1bMst1E0BFRYIjkYue+1+yxIwGlfUo1KmLEvJ4EPSgcTiZqWQIwQJVqd/mG+/LYHe24ojFjWuNB3yyfBrfio99ld5XsWB5EMvcnlsWyJTFj1Tg0yLc6HKyJhkVReKl4RwJ+LRo7be3ZVRgQGPjMeNDsoUbP69jMW+FktMGOTpLtAK4lkXN7nEw727DzfxqNbDU+MeJmG1xoHVkF2ItJf8JoIjM6DdM17I8ikW0GdSwzSKZyo8wN2tMNPI+wmO5S4iaUeLYJSXy1O1aTzkhSuRkjmydyqT1Vb38YseZhD5ULbTpfzx1COuFobffVzGuoML4EU4am0+SqZeAcEWC3gKGdIvPayALlvPAklVesQqf9C8bEFNnweCN3QVHY1CV26vMfsU63F6250Gumqq/1D+ojNrm1Ce3qJKADc7C3qq7bs/UBGnfIVSZSA7T1JMZEZwCiFbeh2cJl4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(66446008)(66556008)(71200400001)(6916009)(36756003)(6506007)(66476007)(2616005)(38100700002)(66946007)(76116006)(4326008)(33656002)(186003)(6486002)(64756008)(5660300002)(8676002)(83380400001)(30864003)(508600001)(86362001)(8936002)(54906003)(316002)(2906002)(38070700005)(53546011)(7416002)(6512007)(91956017)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YOLoI+YgTYclNB1m+mx9MTwY/4468vNW/O8xldb8c1/DGDhWxDsjYU3g6g/P?=
 =?us-ascii?Q?71oRZ5qmDN4j1wLIo9bY/7ZWE4qEO4yKyOzpCrwENiwW6WDC9pnLcoFBnfVJ?=
 =?us-ascii?Q?f5+qMa+ZMny1E9AtXFvbraHWQ6BT76ZWAzzHnYbzXZUVY6kExtDmGyiz9Wb/?=
 =?us-ascii?Q?tF0phOvfrtjcQcacLUgT2Y+y85/jRUbHRvjp/QAuVnC93q32uq8iwPc4/7iX?=
 =?us-ascii?Q?5pZiLQeT4Xo3ZoyLVVuJ0OrvbLXVn0kTGvPLLAOhMjjOPqhtTM+7mz1ikIV4?=
 =?us-ascii?Q?GYyymskm+bedybnGa8afZlThPF1gb5ODlyOZOf7Sb3r/EwrGW+qOlgQ3rYHV?=
 =?us-ascii?Q?B13pRrTfSr8LDVoENXje7qvQQHDynQ779j4FaNFsqHKNnRFpPlKsae5wWE+t?=
 =?us-ascii?Q?Y6IqfUnvwAA+8DCPK/btLNCilBZcBBsCBSGKA8k4lVLGDHlDwl0S3aXkBrpH?=
 =?us-ascii?Q?wqMr7A1TbRxq3vAbtLtR5ElUGcdt6W6A2u2JiVh7K+uMKuw67cwjZEyFHQ8S?=
 =?us-ascii?Q?5++Vn3lAAgFohUIhKKtwcsxJSpSa1JIKhIvCQL6VHOaq4oh7LDhnC53bsOGn?=
 =?us-ascii?Q?CZIC5W/94/gMM8cU2282PtNcjHRdDKm9cq/11O64ZggbzsigvkvoUUQxeF4F?=
 =?us-ascii?Q?hh/1PxtGUP3k/reYKKzpKT83PqN7Hc9yPvOfABuY/KTVmWa8y+RAoMp31v6A?=
 =?us-ascii?Q?VDCbFkDlu6BBqJ/W80lzTyfcSzhKsbWA7zgAv5SXjz+FNwCu/QZ78Sra2nGn?=
 =?us-ascii?Q?iQv9FXBqatVt/Xy944/ccmUFxdE+B2fj2k0uazqxW2aC3Bi8KhQl5LTex2+/?=
 =?us-ascii?Q?rq5BDgC4tRM76wgafUd21EWzRjm3uZ7eLNhwyKIZCVc/VqmP8OAWOFOjEcz3?=
 =?us-ascii?Q?gwyzN6Yv1xAD+zGzg4OMZnI7A6k+1maPi776k61ld+rlayRxaSxcDw6r2kPz?=
 =?us-ascii?Q?d4G0uYcM8rGYKva829nr45RvXgylPz5Qg5wiR3SCZ5Gd9yTiGNBdS1DDTxn0?=
 =?us-ascii?Q?7ZZDjr80gUFmOLVHSNIrp2b8zpOX/E1Qua7Dd12ALSxE9YdoBvslALHuAHzT?=
 =?us-ascii?Q?XSm1nXDRO0d0cgcWaqWCwaVJo1PNzm5wExjPMBmcoDFX+PBGZ56qZbHuUcTU?=
 =?us-ascii?Q?aS+6aFpeFamv2xku4tnaKSx91V0T/kOg8cRNnuhezqDT1syitSJo28SmJLbl?=
 =?us-ascii?Q?q4YLe1VFEEKEuyv11CroQTvMJFxoDPCQc4hmeVK7R1wd8X8I+yNJbm2qZ1rn?=
 =?us-ascii?Q?DayUVx0Afqd4MyygTxdoRxpyPl5jPc3Q/Bys+CeGfFa3BQkRP80qJ8a594Ds?=
 =?us-ascii?Q?fWP8wixLNPxxmwNbcdZsDp+HsCFvSopqnyxu9G8NADTE2dSCp+GOLRGTinYA?=
 =?us-ascii?Q?Q1rRxQJW5M+V5TjBv6rRQ0vGi3ud3o9b18vNHx6x3PzyBLjxUZAX9UEvh5KL?=
 =?us-ascii?Q?VcIfllZnXwH0/q59dKdVbglbARQwGGpGm9waaYDwmUT/KMksnvj1YlzrsyxY?=
 =?us-ascii?Q?j1y6WqAMoWJ4sEMgjM+Q0M/CEi4hfFTJRE5SjOiGf0x1aE+jfuIpHzNE3l7j?=
 =?us-ascii?Q?wW4s4r5IOVYYRbODwBhPSQ3vOJn5fvvqNxJwTMc4DbJbHqlW//Sgsd/UIHTT?=
 =?us-ascii?Q?0rAZgPPIsyQEYoMmix0jx/WfCm53z0DE53encEqwmw2EdltG899anrBBEJGt?=
 =?us-ascii?Q?CI0iTw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1AE6F4BDAF7FAD4E97FB44093E5CBC98@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c59aec59-ed7b-452f-77bc-08d9c452c1fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2021 07:23:16.9248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T9Yfuhx/Sy5kHB8biKSS4U5+EPVssYImO8J2P97mSxFoTgwLcSrjBzpytG4FcJlawhHYZrkXYWlYP9PcWp4odg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5062
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: DiVlMn9lcEu6nHcr9gGnygaozjAeYO3W
X-Proofpoint-ORIG-GUID: DiVlMn9lcEu6nHcr9gGnygaozjAeYO3W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-21_02,2021-12-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112210030
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 20, 2021, at 4:19 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> 
> How's this then?
> 
> ---
> Subject: perf: Fix perf_event_read_local() time
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Mon Dec 20 09:59:47 CET 2021
> 
> Time readers that cannot take locks (due to NMI etc..) currently make
> use of perf_event::shadow_ctx_time, which, for that event gives:
> 
> 	time' = now + (time - timestamp)
> 
> or, alternatively arranged:
> 
> 	time' = time + (now - timestamp)
> 
> IOW, the progression of time since the last time the shadow_ctx_time
> was updated.
> 
> There's problems with this:
> 
> A) the shadow_ctx_time is per-event, even though the ctx_time it
>    reflects is obviously per context. The direct concequence of this
>    is that the context needs to iterate all events all the time to
>    keep the shadow_ctx_time in sync.
> 
> B) even with the prior point, the context itself might not be active
>    meaning its time should not advance to begin with.
> 
> C) shadow_ctx_time isn't consistently updated when ctx_time is
> 
> There are 3 users of this stuff, that suffer differently from this:
> 
> - calc_timer_values()
>   - perf_output_read()
>   - perf_event_update_userpage()	/* A */
> 
> - perf_event_read_local()		/* A,B */
> 
> In particular, perf_output_read() doesn't suffer at all, because it's
> sample driven and hence only relevant when the event is actually
> running.
> 
> This same was supposed to be true for perf_event_update_userpage(),
> after all self-monitoring implies the context is active *HOWEVER*, as
> per commit f79256532682 ("perf/core: fix userpage->time_enabled of
> inactive events") this goes wrong when combined with counter
> overcommit, in that case those events that do not get scheduled when
> the context becomes active (task events typically) miss out on the
> EVENT_TIME update and ENABLED time is inflated (for a little while)
> with the time the context was inactive. Once the event gets rotated
> in, this gets corrected, leading to a non-monotonic timeflow.
> 
> perf_event_read_local() made things even worse, it can request time at
> any point, suffering all the problems perf_event_update_userpage()
> does and more. Because while perf_event_update_userpage() is limited
> by the context being active, perf_event_read_local() users have no
> such constraint.
> 
> Therefore, completely overhaul things and do away with
> perf_event::shadow_ctx_time. Instead have regular context time updates
> keep track of this offset directly and provide perf_event_time_now()
> to complement perf_event_time().
> 
> perf_event_time_now() will, in adition to being context wide, also
> take into account if the context is active. For inactive context, it
> will not advance time.
> 
> This latter property means the cgroup perf_cgroup_info context needs
> to grow addition state to track this.
> 
> Additionally, since all this is strictly per-cpu, we can use barrier()
> to order context activity vs context time.
> 
> Fixes: 7d9285e82db5 ("perf/bpf: Extend the perf_event_read_local() interface, a.k.a. "bpf: perf event change needed for subsequent bpf helpers"")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I think we need to forward the declaration of calc_timer_values?

With that fixed, this passes the test for enabled time. 

Tested-by: Song Liu <song@kernel.org>

Thanks,
Song

> ---
> include/linux/perf_event.h |   15 ---
> kernel/events/core.c       |  224 +++++++++++++++++++++++++++------------------
> 2 files changed, 138 insertions(+), 101 deletions(-)
> 
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -683,18 +683,6 @@ struct perf_event {
> 	u64				total_time_running;
> 	u64				tstamp;
> 
> -	/*
> -	 * timestamp shadows the actual context timing but it can
> -	 * be safely used in NMI interrupt context. It reflects the
> -	 * context time as it was when the event was last scheduled in,
> -	 * or when ctx_sched_in failed to schedule the event because we
> -	 * run out of PMC.
> -	 *
> -	 * ctx_time already accounts for ctx->timestamp. Therefore to
> -	 * compute ctx_time for a sample, simply add perf_clock().
> -	 */
> -	u64				shadow_ctx_time;
> -
> 	struct perf_event_attr		attr;
> 	u16				header_size;
> 	u16				id_header_size;
> @@ -841,6 +829,7 @@ struct perf_event_context {
> 	 */
> 	u64				time;
> 	u64				timestamp;
> +	u64				timeoffset;
> 
> 	/*
> 	 * These fields let us detect when two contexts have both
> @@ -923,6 +912,8 @@ struct bpf_perf_event_data_kern {
> struct perf_cgroup_info {
> 	u64				time;
> 	u64				timestamp;
> +	u64				timeoffset;
> +	int				active;
> };
> 
> struct perf_cgroup {
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -674,6 +674,23 @@ perf_event_set_state(struct perf_event *
> 	WRITE_ONCE(event->state, state);
> }
> 
> +/*
> + * UP store-release, load-acquire
> + */
> +
> +#define __store_release(ptr, val)					\
> +do {									\
> +	barrier();							\
> +	WRITE_ONCE(*(ptr), (val));					\
> +} while (0)
> +
> +#define __load_acquire(ptr)						\
> +({									\
> +	__unqual_scalar_typeof(*(ptr)) ___p = READ_ONCE(*(ptr));	\
> +	barrier();							\
> +	___p;								\
> +})
> +
> #ifdef CONFIG_CGROUP_PERF
> 
> static inline bool
> @@ -719,34 +736,51 @@ static inline u64 perf_cgroup_event_time
> 	return t->time;
> }
> 
> -static inline void __update_cgrp_time(struct perf_cgroup *cgrp)
> +static inline u64 perf_cgroup_event_time_now(struct perf_event *event, u64 now)
> {
> -	struct perf_cgroup_info *info;
> -	u64 now;
> -
> -	now = perf_clock();
> +	struct perf_cgroup_info *t;
> 
> -	info = this_cpu_ptr(cgrp->info);
> +	t = per_cpu_ptr(event->cgrp->info, event->cpu);
> +	if (!__load_acquire(&t->active))
> +		return t->time;
> +	now += READ_ONCE(t->timeoffset);
> +	return now;
> +}
> 
> -	info->time += now - info->timestamp;
> +static inline void __update_cgrp_time(struct perf_cgroup_info *info, u64 now, bool adv)
> +{
> +	if (adv)
> +		info->time += now - info->timestamp;
> 	info->timestamp = now;
> +	/*
> +	 * see update_context_time()
> +	 */
> +	WRITE_ONCE(info->timeoffset, info->time - info->timestamp);
> }
> 
> -static inline void update_cgrp_time_from_cpuctx(struct perf_cpu_context *cpuctx)
> +static inline void update_cgrp_time_from_cpuctx(struct perf_cpu_context *cpuctx, bool final)
> {
> 	struct perf_cgroup *cgrp = cpuctx->cgrp;
> 	struct cgroup_subsys_state *css;
> +	struct perf_cgroup_info *info;
> 
> 	if (cgrp) {
> +		u64 now = perf_clock();
> +
> 		for (css = &cgrp->css; css; css = css->parent) {
> 			cgrp = container_of(css, struct perf_cgroup, css);
> -			__update_cgrp_time(cgrp);
> +			info = this_cpu_ptr(cgrp->info);
> +
> +			__update_cgrp_time(info, now, true);
> +			if (final)
> +				__store_release(&info->active, 0);
> 		}
> 	}
> }
> 
> static inline void update_cgrp_time_from_event(struct perf_event *event)
> {
> +	struct perf_cgroup_info *info;
> 	struct perf_cgroup *cgrp;
> 
> 	/*
> @@ -760,8 +794,10 @@ static inline void update_cgrp_time_from
> 	/*
> 	 * Do not update time when cgroup is not active
> 	 */
> -	if (cgroup_is_descendant(cgrp->css.cgroup, event->cgrp->css.cgroup))
> -		__update_cgrp_time(event->cgrp);
> +	if (cgroup_is_descendant(cgrp->css.cgroup, event->cgrp->css.cgroup)) {
> +		info = this_cpu_ptr(event->cgrp->info);
> +		__update_cgrp_time(info, perf_clock(), true);
> +	}
> }
> 
> static inline void
> @@ -785,7 +821,8 @@ perf_cgroup_set_timestamp(struct task_st
> 	for (css = &cgrp->css; css; css = css->parent) {
> 		cgrp = container_of(css, struct perf_cgroup, css);
> 		info = this_cpu_ptr(cgrp->info);
> -		info->timestamp = ctx->timestamp;
> +		__update_cgrp_time(info, ctx->timestamp, false);
> +		__store_release(&info->active, 1);
> 	}
> }
> 
> @@ -982,14 +1019,6 @@ static inline int perf_cgroup_connect(in
> }
> 
> static inline void
> -perf_cgroup_set_shadow_time(struct perf_event *event, u64 now)
> -{
> -	struct perf_cgroup_info *t;
> -	t = per_cpu_ptr(event->cgrp->info, event->cpu);
> -	event->shadow_ctx_time = now - t->timestamp;
> -}
> -
> -static inline void
> perf_cgroup_event_enable(struct perf_event *event, struct perf_event_context *ctx)
> {
> 	struct perf_cpu_context *cpuctx;
> @@ -1066,7 +1095,8 @@ static inline void update_cgrp_time_from
> {
> }
> 
> -static inline void update_cgrp_time_from_cpuctx(struct perf_cpu_context *cpuctx)
> +static inline void update_cgrp_time_from_cpuctx(struct perf_cpu_context *cpuctx,
> +						bool final)
> {
> }
> 
> @@ -1098,12 +1128,12 @@ perf_cgroup_switch(struct task_struct *t
> {
> }
> 
> -static inline void
> -perf_cgroup_set_shadow_time(struct perf_event *event, u64 now)
> +static inline u64 perf_cgroup_event_time(struct perf_event *event)
> {
> +	return 0;
> }
> 
> -static inline u64 perf_cgroup_event_time(struct perf_event *event)
> +static inline u64 perf_cgroup_event_time_now(struct perf_event *event, u64 now)
> {
> 	return 0;
> }
> @@ -1525,22 +1555,59 @@ static void perf_unpin_context(struct pe
> /*
>  * Update the record of the current time in a context.
>  */
> -static void update_context_time(struct perf_event_context *ctx)
> +static void __update_context_time(struct perf_event_context *ctx, bool adv)
> {
> 	u64 now = perf_clock();
> 
> -	ctx->time += now - ctx->timestamp;
> +	if (adv)
> +		ctx->time += now - ctx->timestamp;
> 	ctx->timestamp = now;
> +
> +	/*
> +	 * The above: time' = time + (now - timestamp), can be re-arranged
> +	 * into: time` = now + (time - timestamp), which gives a single value
> +	 * offset to compute future time without locks on.
> +	 *
> +	 * See perf_event_time_now(), which can be used from NMI context where
> +	 * it's (obviously) not possible to acquire ctx->lock in order to read
> +	 * both the above values in a consistent manner.
> +	 */
> +	WRITE_ONCE(ctx->timeoffset, ctx->time - ctx->timestamp);
> +}
> +
> +static void update_context_time(struct perf_event_context *ctx)
> +{
> +	__update_context_time(ctx, true);
> }
> 
> static u64 perf_event_time(struct perf_event *event)
> {
> 	struct perf_event_context *ctx = event->ctx;
> 
> +	if (unlikely(!ctx))
> +		return 0;
> +
> 	if (is_cgroup_event(event))
> 		return perf_cgroup_event_time(event);
> 
> -	return ctx ? ctx->time : 0;
> +	return ctx->time;
> +}
> +
> +static u64 perf_event_time_now(struct perf_event *event, u64 now)
> +{
> +	struct perf_event_context *ctx = event->ctx;
> +
> +	if (unlikely(!ctx))
> +		return 0;
> +
> +	if (is_cgroup_event(event))
> +		return perf_cgroup_event_time_now(event, now);
> +
> +	if (!(__load_acquire(&ctx->is_active) & EVENT_TIME))
> +		return ctx->time;
> +
> +	now += READ_ONCE(ctx->timeoffset);
> +	return now;
> }
> 
> static enum event_type_t get_event_type(struct perf_event *event)
> @@ -2346,7 +2413,7 @@ __perf_remove_from_context(struct perf_e
> 
> 	if (ctx->is_active & EVENT_TIME) {
> 		update_context_time(ctx);
> -		update_cgrp_time_from_cpuctx(cpuctx);
> +		update_cgrp_time_from_cpuctx(cpuctx, false);
> 	}
> 
> 	event_sched_out(event, cpuctx, ctx);
> @@ -2357,6 +2424,9 @@ __perf_remove_from_context(struct perf_e
> 	list_del_event(event, ctx);
> 
> 	if (!ctx->nr_events && ctx->is_active) {
> +		if (ctx == &cpuctx->ctx)
> +			update_cgrp_time_from_cpuctx(cpuctx, true);
> +
> 		ctx->is_active = 0;
> 		ctx->rotate_necessary = 0;
> 		if (ctx->task) {
> @@ -2478,40 +2548,6 @@ void perf_event_disable_inatomic(struct
> 	irq_work_queue(&event->pending);
> }
> 
> -static void perf_set_shadow_time(struct perf_event *event,
> -				 struct perf_event_context *ctx)
> -{
> -	/*
> -	 * use the correct time source for the time snapshot
> -	 *
> -	 * We could get by without this by leveraging the
> -	 * fact that to get to this function, the caller
> -	 * has most likely already called update_context_time()
> -	 * and update_cgrp_time_xx() and thus both timestamp
> -	 * are identical (or very close). Given that tstamp is,
> -	 * already adjusted for cgroup, we could say that:
> -	 *    tstamp - ctx->timestamp
> -	 * is equivalent to
> -	 *    tstamp - cgrp->timestamp.
> -	 *
> -	 * Then, in perf_output_read(), the calculation would
> -	 * work with no changes because:
> -	 * - event is guaranteed scheduled in
> -	 * - no scheduled out in between
> -	 * - thus the timestamp would be the same
> -	 *
> -	 * But this is a bit hairy.
> -	 *
> -	 * So instead, we have an explicit cgroup call to remain
> -	 * within the time source all along. We believe it
> -	 * is cleaner and simpler to understand.
> -	 */
> -	if (is_cgroup_event(event))
> -		perf_cgroup_set_shadow_time(event, event->tstamp);
> -	else
> -		event->shadow_ctx_time = event->tstamp - ctx->timestamp;
> -}
> -
> #define MAX_INTERRUPTS (~0ULL)
> 
> static void perf_log_throttle(struct perf_event *event, int enable);
> @@ -2552,8 +2588,6 @@ event_sched_in(struct perf_event *event,
> 
> 	perf_pmu_disable(event->pmu);
> 
> -	perf_set_shadow_time(event, ctx);
> -
> 	perf_log_itrace_start(event);
> 
> 	if (event->pmu->add(event, PERF_EF_START)) {
> @@ -3247,16 +3281,6 @@ static void ctx_sched_out(struct perf_ev
> 		return;
> 	}
> 
> -	ctx->is_active &= ~event_type;
> -	if (!(ctx->is_active & EVENT_ALL))
> -		ctx->is_active = 0;
> -
> -	if (ctx->task) {
> -		WARN_ON_ONCE(cpuctx->task_ctx != ctx);
> -		if (!ctx->is_active)
> -			cpuctx->task_ctx = NULL;
> -	}
> -
> 	/*
> 	 * Always update time if it was set; not only when it changes.
> 	 * Otherwise we can 'forget' to update time for any but the last
> @@ -3270,7 +3294,22 @@ static void ctx_sched_out(struct perf_ev
> 	if (is_active & EVENT_TIME) {
> 		/* update (and stop) ctx time */
> 		update_context_time(ctx);
> -		update_cgrp_time_from_cpuctx(cpuctx);
> +		update_cgrp_time_from_cpuctx(cpuctx, ctx == &cpuctx->ctx);
> +		/*
> +		 * CPU-release for the below ->is_active store,
> +		 * see __load_acquire() in perf_event_time_now()
> +		 */
> +		barrier();
> +	}
> +
> +	ctx->is_active &= ~event_type;
> +	if (!(ctx->is_active & EVENT_ALL))
> +		ctx->is_active = 0;
> +
> +	if (ctx->task) {
> +		WARN_ON_ONCE(cpuctx->task_ctx != ctx);
> +		if (!ctx->is_active)
> +			cpuctx->task_ctx = NULL;
> 	}
> 
> 	is_active ^= ctx->is_active; /* changed bits */
> @@ -3707,13 +3746,19 @@ static noinline int visit_groups_merge(s
> 	return 0;
> }
> 
> +/*
> + * Because the userpage is strictly per-event (there is no concept of context,
> + * so there cannot be a context indirection), every userpage must be updated
> + * when context time starts :-(
> + *
> + * IOW, we must not miss EVENT_TIME edges.
> + */
> static inline bool event_update_userpage(struct perf_event *event)
> {
> 	if (likely(!atomic_read(&event->mmap_count)))
> 		return false;
> 
> 	perf_event_update_time(event);
> -	perf_set_shadow_time(event, event->ctx);
> 	perf_event_update_userpage(event);
> 
> 	return true;
> @@ -3797,13 +3842,23 @@ ctx_sched_in(struct perf_event_context *
> 	     struct task_struct *task)
> {
> 	int is_active = ctx->is_active;
> -	u64 now;
> 
> 	lockdep_assert_held(&ctx->lock);
> 
> 	if (likely(!ctx->nr_events))
> 		return;
> 
> +	if (is_active ^ EVENT_TIME) {
> +		/* start ctx time */
> +		__update_context_time(ctx, false);
> +		perf_cgroup_set_timestamp(task, ctx);
> +		/*
> +		 * CPU-release for the below ->is_active store,
> +		 * see __load_acquire() in perf_event_time_now()
> +		 */
> +		barrier();
> +	}
> +
> 	ctx->is_active |= (event_type | EVENT_TIME);
> 	if (ctx->task) {
> 		if (!is_active)
> @@ -3814,13 +3869,6 @@ ctx_sched_in(struct perf_event_context *
> 
> 	is_active ^= ctx->is_active; /* changed bits */
> 
> -	if (is_active & EVENT_TIME) {
> -		/* start ctx time */
> -		now = perf_clock();
> -		ctx->timestamp = now;
> -		perf_cgroup_set_timestamp(task, ctx);
> -	}
> -
> 	/*
> 	 * First go through the list and put on any pinned groups
> 	 * in order to give them the best chance of going on.
> @@ -4473,10 +4521,9 @@ int perf_event_read_local(struct perf_ev
> 
> 	*value = local64_read(&event->count);
> 	if (enabled || running) {
> -		u64 now = event->shadow_ctx_time + perf_clock();
> -		u64 __enabled, __running;
> +		u64 __enabled, __running, __now;;
> 
> -		__perf_update_times(event, now, &__enabled, &__running);
> +		calc_timer_values(event, &__now, &__enabled, &__running);
> 		if (enabled)
> 			*enabled = __enabled;
> 		if (running)
> @@ -5806,7 +5853,7 @@ static void calc_timer_values(struct per
> 	u64 ctx_time;
> 
> 	*now = perf_clock();
> -	ctx_time = event->shadow_ctx_time + *now;
> +	ctx_time = perf_event_time_now(event, *now);
> 	__perf_update_times(event, ctx_time, enabled, running);
> }
> 
> @@ -6349,7 +6396,6 @@ static int perf_mmap(struct file *file,
> 		ring_buffer_attach(event, rb);
> 
> 		perf_event_update_time(event);
> -		perf_set_shadow_time(event, event->ctx);
> 		perf_event_init_userpage(event);
> 		perf_event_update_userpage(event);
> 	} else {

