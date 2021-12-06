Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3360F46AE47
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 00:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377022AbhLFXPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 18:15:08 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43300 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376866AbhLFXPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 18:15:06 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6Mk7bA010850
        for <linux-kernel@vger.kernel.org>; Mon, 6 Dec 2021 15:11:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=laR16DL5tjTAFm1KL5B+iaABQPXGXe/+oKuG2uj8Qxw=;
 b=fv2T8dfRD12tvQWH0PHI6Nf1u1inZrc3xLir8smTZ+t7jh8mKP4h155KMQdDpsVs1T0v
 xB5Qudo65x8If/IgSKugViqTYW13Ql8Q2hDyVN/9dpQ3LhMJKLfpmsYVyM2BXcyqHsIb
 0ecS2xLSyKDjE1+NsaGXpNA+QtjpydOWEUY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3csqyq9rcy-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 15:11:37 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 15:11:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsQ6V1unl0NR/G2wYHJDv83vbBG0rYp7TLhn9ZMLiG7lAX+NMY8opMOuH0X+rc+owYN/KQUzbbPJ8Au/+mv2Q9ZQbmB072nxE4pUkX/FeO1n6mDWLTExTqdz5pjKa4az/PuogfVbOIgGvWbmxyKy8TT4+nBZNtPplUZArswdotOgZWcSTgpzl0gnpWEW/ezSGBVFXZmjnWWBMDBKIulctX2Uc36NFjQgBd+JE3vi0pOq0UMAvUj7/enqXpAO4pbvTRisAp1woR+fQEk4VasKA9pHl3y1B+iOE+4pCtGiZS8T5hFLu/bGtEbMzYj+ZwtxPJPpFj176UGC0TXNj/wmQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laR16DL5tjTAFm1KL5B+iaABQPXGXe/+oKuG2uj8Qxw=;
 b=Ati1rHpLSu+hbbKwAxfbjbruOTxr6DW2fBlTsTxPVChDZxOsIpXmAS1x3Zwp0iINdZpd4112Ov+ml5M0qe2GAV8CMRg6Kk7y01Qo/TFyG5b1p7t3HiW8VwD5FvLKp+s0cSnAojtXkgQOp2WCR9jjm6hERTFEPk38TClnpLQ9drWOnZAggxtVDlXLzrevwrHcftVrwKOoj96bpUSjiY/BQYNNyW5LZcXP82NtCYMqua88fx/klA6aSMS31RiA7ZndYm9iQFnecYNeItuElCmXT2y7dDJ/V6LLxOIAiaqjVWsE2uhMCk4kdrXX+5Fg4512MdDneJ5W2VUvmf8Alvm4Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Mon, 6 Dec
 2021 23:11:34 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::f826:e515:ee1a:a33]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::f826:e515:ee1a:a33%4]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 23:11:34 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Namhyung Kim <namhyung@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
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
Thread-Index: AQHX6ipF/JnJvZ9n50qVJHJ8Sj4PjqwmGOQA
Date:   Mon, 6 Dec 2021 23:11:34 +0000
Message-ID: <A629A4F4-1BA4-4DCF-B4F0-F0E80B55738A@fb.com>
References: <20211205224843.1503081-1-namhyung@kernel.org>
In-Reply-To: <20211205224843.1503081-1-namhyung@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.20.0.1.32)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d96d98f-073a-46ff-98e7-08d9b90dbf71
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_
x-microsoft-antispam-prvs: <SA1PR15MB5109E0EAD714622EDD44B4E9B36D9@SA1PR15MB5109.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IQWWXOw5hnuGoqcbqrJcvllrK4i2QexdQTIS7DkPfTCLWHzOjF49zcZ9Y9EUhSUQnIX769hV71eh1BC0hwwxnkr+WO4isdkEm5czk4EZUuRobxdkB12UyOO8PHw/1cx17bNvXJweygkaU8LK0zAt4mx7QXzcuilm31wHmWwL5XSd9grUmPb8sj8Wv9i38F8o+qcZ6D6eAzdcXKZvmKhL+0s0j4W5MEB2uR8S6HpOOK4JLOCrubv0kTwWxtR3MH1p3tnFI8frenoEYMBqxtijhqGtxar+jl73ZBnj3gwqNxFxadw8Tv30l4oHFb2ITG09Dt489sDevGqVRlliHS2N2465fGRZxRZh+v6WUxYU9JSlh+zEnbu1zwFCvea1lcIm4tSFs9Af8KQehueUM71o8sMxNSCr9TZehVxhBI66UO3HLuNbB1Y+6JvF5FivJsaIYtkDipc5gLLHgZ8o5f1XtOTEISudlk41LJyCTvDsOwH95LV8cEFKanDy76LI0UcJ6itQFQsqdkBPAKy8L1VdVt1PHza5uFuV3chJaKOrx1c77IV4EZgtRoIUgFbdKXjUILi3GqFrdWpuLOKMbxY9LQV1lsPgQBvyEB+ZObtlOnRd3+nNzVdXqHJ2wqXvC8J79fAtqxPT3kt0Hx2QJTXkQiHyDX/sIgyxQPQBesAYeW8WlVBO50I7TwwH8et93g2z9vKJ9P6XZsObnDWw4l42HoORBybQvB9ehceip4MzMwGqLk5RFtaHZWOIdE0dAtHY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(508600001)(66446008)(71200400001)(66476007)(66556008)(38100700002)(8676002)(5660300002)(64756008)(6512007)(186003)(66946007)(83380400001)(53546011)(76116006)(6916009)(91956017)(122000001)(2906002)(6486002)(4326008)(2616005)(33656002)(54906003)(316002)(36756003)(86362001)(7416002)(8936002)(38070700005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N3Yv91tvkISEQr+JPKrsqFv/oO8N3N63cDLyMIrFX5XgtdLZz/PnUuJZFe9I?=
 =?us-ascii?Q?XWyn7nO+5o+56pScGi/18pHKT3WyN53I9N2kMf3JA1DMoCwZ65v0UUrWhx9n?=
 =?us-ascii?Q?QrOyifWDYPmiU6LikZGVICyZVY/rzSCYUbV7HfLYhJlJKoGKadsfBRz1aPTP?=
 =?us-ascii?Q?fuDQO2rncPtFZfZ7dGTwlKlbnDmKeqjpxbX5jVIPExuzOAdK1Ee1b8fc+ITi?=
 =?us-ascii?Q?hDmOMfHyCS95dp+hT3BdDSQtOVEx+VFxDEnXwP/72mZKXAWo7s3ARTgGTvac?=
 =?us-ascii?Q?Kjt8Rz51cb8Bh21nV8ty4G7pqAZHc3yA6L2L46b3v/CAu9IeMsOShFAes29B?=
 =?us-ascii?Q?V6lDkue/tGzUXDnFIqbQaXAAXrNDddZqxVsg3H7OjcWSRTWS6gwsiy2GT68f?=
 =?us-ascii?Q?UOWgk9pqiK5b9qgt2kYyXHtWK/WAhMkwZieSkmnHXkMBS4Xo+Mg/CCG026vI?=
 =?us-ascii?Q?dJpdSmMmu1q/EfBI05phBcxZv8lt1tbUID/VOhHLCTji7Rc7NoP1q4ETZkm5?=
 =?us-ascii?Q?ttqO8dUM9KycR3CrAjq+BGwNqMnWcE2ZbcLjMat6svU1ld/OecBYSgyD9mff?=
 =?us-ascii?Q?TWqczrXXMMQ0gGw14/XeHp64SzkPmDi0SbTJEBKVAlF9F6zMcnMuixy3tJQB?=
 =?us-ascii?Q?VHV/1/JZ8C1zh2OTVL5Vt095DIv4i86nEpbApnlR92xnn0NTM6kouoh8hkMg?=
 =?us-ascii?Q?+J0pphS0f/Z5eHutF6e8PWAtRY9gu0uImJoH2uXXHGcXTaGVhcGh8AerI+3a?=
 =?us-ascii?Q?0lqVOCC75cdCYJ36PyT165iMo2CUMvSdxI4uNkOj4Ld4fOn+LnH9VQvRcKVz?=
 =?us-ascii?Q?5ZmQk+mq3ZLHj8q2KtUfC/rsZWr9TUzJtLaOn/c4tTM9a/Yw/kQU7MiiUItA?=
 =?us-ascii?Q?pR1XZ1XRUN0fUbHj4EYgH3oym02ZX7YiawZsiWYETUeSVnQDxmBQuekEcWiS?=
 =?us-ascii?Q?jB5D94D87jdWX1iA+ngF9qNjAdgrZhD+oGXEVfKTzcXETqP5bUwHLlQWybLc?=
 =?us-ascii?Q?KXQ1QAIhHu1yvR/AAooofcXCth7kqWdL8h9VoPHUTBpmYUjj2RnftL2rcx5e?=
 =?us-ascii?Q?UrYQFZZlljV2c9OzYcwHhLBbYKZoLI6sqkmUS8yQT/P3PqHmKsqq7vy2M4vF?=
 =?us-ascii?Q?Gu4KrSS9xOC43v8KV3y38UfITZhchGUPWPv1t8jjv6acoDn0jZtJGKmyAywY?=
 =?us-ascii?Q?nzRBft3ZyGdX/yS5HXVUkdzUPeY9vvDUQpVzY4yPwIBtsc/N4wZ6dvLebirX?=
 =?us-ascii?Q?b380KWAaJtd/XAsdGG+NP8bjFhoBRhKSRYOyh/lROw1AFCjkaGymEij69Fjj?=
 =?us-ascii?Q?wdubLdTDe3Lkum6O4X+EtvcvLg4+KJ2Y3s0TRLc3RudNjd2Q11f7jprUWB6r?=
 =?us-ascii?Q?VCk0tknig3cHcDhsejiRygIcTPK3NGgtPPGrv31JGMvgmTIPCzQQ0j5ecWPc?=
 =?us-ascii?Q?d3UJ3012qbUXOaCIyEjvvjM59Ycm5qGvXSOx2etG4UjtIhNdD7sJChGZdJRI?=
 =?us-ascii?Q?lghbIK4igeC/gDTaXvz15aqW0le4G367o/v58SxYuHjw2oUkm5+ABC5TmJ6V?=
 =?us-ascii?Q?AS1BV/lNmQ88MROgSV1JyuBKK0SfxZ6dH4UR6iocmsqSNUkndZMcHMdBm76+?=
 =?us-ascii?Q?80Qd73FIj6yQDp+6LN/MuQUPzSIrgIbs5IMgMXu/QP6+99mrPpsEY3/A9tEt?=
 =?us-ascii?Q?ikQ9Jg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B01226421DCC83468170CE814972EE65@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d96d98f-073a-46ff-98e7-08d9b90dbf71
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 23:11:34.6585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YpJE8TwCPy9LRAWSx3RstoH10prHZ6WKFY4yPxrG+IRpUSmy9mAibgPEbpRycnuiEkUPOaLRssP+vY/RoB4HoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5109
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: _i3P55kEeIxvB-209mJQNmfcX_kIZbqE
X-Proofpoint-ORIG-GUID: _i3P55kEeIxvB-209mJQNmfcX_kIZbqE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_08,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060140
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 5, 2021, at 2:48 PM, Namhyung Kim <namhyung@kernel.org> wrote:
> 
> While commit f79256532682 ("perf/core: fix userpage->time_enabled of
> inactive events") fixed this problem for user rdpmc usage, bperf (perf
> stat with BPF) still has the same problem that accessing inactive perf
> events from BPF using bpf_perf_event_read_value().
> 
> You can reproduce this problem easily.  As this is about a small
> window with multiplexing, we need a large number of events and short
> duration like below:
> 
>  # perf stat -a -v --bpf-counters -e instructions,branches,branch-misses \
>    -e cache-references,cache-misses,bus-cycles,ref-cycles,cycles sleep 0.1
> 
>  Control descriptor is not initialized
>  instructions: 19616489 431324015 360374366
>  branches: 3685346 417640114 344175443
>  branch-misses: 75714 404089360 336145421
>  cache-references: 438667 390474289 327444074
>  cache-misses: 49279 349333164 272835067
>  bus-cycles: 631887 283423953 165164214
>  ref-cycles: 2578771111104847872 18446744069443110306 182116355
>  cycles: 1785221016051271680 18446744071682768912 115821694
> 
>   Performance counter stats for 'system wide':
> 
>          19,616,489      instructions              #    0.00  insn per cycle           ( 83.55%)
>           3,685,346      branches                                                      ( 82.41%)
>              75,714      branch-misses             #    2.05% of all branches          ( 83.19%)
>             438,667      cache-references                                              ( 83.86%)
>              49,279      cache-misses              #   11.234 % of all cache refs      ( 78.10%)
>             631,887      bus-cycles                                                    ( 58.27%)
>  2,578,771,111,104,847,872      ref-cycles                                                     (0.00%)
>  1,785,221,016,051,271,680      cycles                                                         (0.00%)
> 
>       0.010824702 seconds time elapsed
> 
> As you can see, it shows invalid values for the last two events.
> The -v option shows that the enabled time is way bigger than the
> running time.  So it scaled the counter values using the ratio
> between the two and resulted in that.  This problem can get worse
> if users want no-aggregation or cgroup aggregation with a small
> interval.
> 
> Actually 18446744069443110306 is 0xffffffff01b345a2 so it seems to
> have a negative enabled time.  In fact, bperf keeps values returned by
> bpf_perf_event_read_value() which calls perf_event_read_local(), and
> accumulates delta between two calls.  When event->shadow_ctx_time is
> not set, it'd return invalid enabled time which is bigger than normal.
> Later, the shadow time is set and the function starts to return a
> valid time.  At the moment, the recent value is smaller than before so
> the delta in the bperf can be negative.
> 
> I think we need to set the shadow time even the events are inactive so
> that BPF programs (or other potential users) can see valid time values
> anytime.
> 
> Cc: Song Liu <songliubraving@fb.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Song Liu <song@kernel.org>

