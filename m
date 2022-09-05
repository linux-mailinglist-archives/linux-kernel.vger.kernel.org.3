Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D2A5AC9A1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 06:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbiIEEkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 00:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiIEEkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 00:40:36 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2045.outbound.protection.outlook.com [40.107.100.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377441FCCF;
        Sun,  4 Sep 2022 21:40:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6mc5ryVf6IIl9qyOehch4jgVEakBK96NTHwJKFXA8AjUTWk80NkkJOTBScw7Uw5T2ezjMZYlw8gWn75ZySJV+yMOkljY3sw+QYUd2fiz0swKcyLo1Pdpkg3dokOokr77ocB0AZeUSyBK5jdQ7abiEW1epZ5GQ1uTGHqo5gFBpOOJmPUjpcmtnZ06ezc8BkH83+rBof0elNSzoApO2jkwAhvvHtNfxnAg30s2Oaw0Mwt+EW2UvdpFags6gjp/TCSHHA6bZnjPLq+Ebv8Z1bOqWCXxTdLo0M2By/0F/WvMlSaaHD12DfdJv69kDEyNI1WObrxgs4XII4ABmBz0mBTXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEAsQYlOCHUH8sLiYEVy5JUrgbyfavvlmVJT+ic6c4Q=;
 b=F6SAJIdWV30AM2OKoMKdOY6lZbcjTNnKNCCPwPOEqqgqa1KxyWEVXCz9CMNVPd5V24Vft5HfKZBa+xgfoP2s+nvXVlxbd/MDIJxHzthBW5pCywO74xdmyGXhQogemYQi+WIKgJo3sK8Ikaotv0ywazPzIIDJpsA/UidGUL1YWer1JQHh6CKR08PwcUZioDcizxLL38oWi011wPOGApaLK3DQPDY729hdZH0g7VAUmlRIr7kClZ7CCWaeJfApBbBVeLi8Sz3wXbwWAlAzDl7TyXDNfBqmsREIOhJnsZmBVdG3I6aB/obJWiO3910wqh8QqV7uRa95VlBt78nXD0wKPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEAsQYlOCHUH8sLiYEVy5JUrgbyfavvlmVJT+ic6c4Q=;
 b=S/9nHsoBfsw6w1x9kQsLOW7T/GKp+6u2wSGO5hBtdiPiWho7SClvTURRvtyJ4wxYx8UOo3ziaSJKPHtIPBN2sLs189xoz2YYcOdm/KNtsv2SW6HX8AUh+H6o0pe3DGZIcdFnuyOlaqn22SGgYxFoSf6suex1hJfSpSzR2aG4q4o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Mon, 5 Sep
 2022 04:40:32 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d058:d925:c09b:de2]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d058:d925:c09b:de2%5]) with mapi id 15.20.5588.010; Mon, 5 Sep 2022
 04:40:31 +0000
Message-ID: <8f5b618e-e0a1-c5f2-3d4d-a41ea96fd59c@amd.com>
Date:   Mon, 5 Sep 2022 10:10:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] perf: Rewrite core context handling
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, songliubraving@fb.com,
        eranian@google.com, ak@linux.intel.com, mark.rutland@arm.com,
        frederic@kernel.org, maddy@linux.ibm.com, irogers@google.com,
        will@kernel.org, robh@kernel.org, mingo@redhat.com,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com, ravi.bangoria@amd.com
References: <20220829113347.295-1-ravi.bangoria@amd.com>
 <YwyrUYS30gVbxc2D@hirez.programming.kicks-ass.net>
 <YwzP+AFWCx4Ni/kx@hirez.programming.kicks-ass.net>
 <c5a6aea9-4f3a-495e-78fa-e426de9b0496@amd.com>
 <YxCXqjfiJca3izQd@hirez.programming.kicks-ass.net>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <YxCXqjfiJca3izQd@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0051.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::26) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8145d740-5ce8-47bd-d191-08da8ef8c3c8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4483:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xXTKv56WeBHIOoSur8CeDhQN7IIFDtz5EJOsk3UvKgtEsj9TJG9411U5ZRm7A8Zr45GpoiOf0hPK3eS2dp0p+TtI5hcP66OEW+8iFAtwpLGCE3ZkS3xjzv5Fx6vQzHij6cAxsRnWF6q49hitpbYBnsTz7FX4/UJKHFhd2KzCRXtcg0TFmNt1IggKM+ZV2vzYvN7MtwzvDmKJ8o1jfSBNWqgSJYgegJHUkvxKeIc3BjgFUP4hYt5tQ5/Gml8P8XgXuuohv9/IS47TC6FJ+PCe4SIwphxY+cStZg1X/WNFXyCSOaPMWkI5lMlssJeS9Rig9rylfEbtBP7SiQ9gWFcs3xM8DbGJkZkvYIMjfXF8iUG8XiFmlUaK6p00V17m0flGYaJ0y6MNWyvtZ1yfCViHiIV7LNYKt9M0ixm3ZhGsdbnNJV36DQF9q3qroiNqKswSmRqcStVzRX2zQQvYRYRDGuUaIZeaVEV4lK5CPCrX8iu4OVt3aGPfZ5Q97GOqZLLO3WVYhvq3rz++7EQjUkp4mnuyRiSlWkrqI2BJ1DgrjZt2NYKDKCbRs+levR1he8qJQaxL2O+RK2JTPWQ9MxLYSqHptJhho4Upeg16BLILiXyDE37Ka8TgesAGdBmvgk8X3bkyfuRvHzDaML//PxO5f1dB0Tn7GAMjwkGlEQ6JVABpFxifTZv9tT/QF0BgRX2JRyIyXE6gYffMi2XWCBQ+NbZwa3z0T/xcUYE5szN2VJji+8zdA5duuR8ssBApfZDXIF3MI6zBFwjRECdU4VyRcZY2ei3qS8d9UZckycrJSyZmwHQpZleqER5q1VViBIcl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(66556008)(8676002)(4326008)(66946007)(8936002)(66476007)(5660300002)(7416002)(6506007)(26005)(478600001)(83380400001)(6486002)(41300700001)(186003)(6666004)(2616005)(86362001)(316002)(6916009)(31696002)(36756003)(31686004)(2906002)(38100700002)(6512007)(44832011)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkN5OTRJUmcvTkxlYVV0YTJXRUg1Qmd4dnBmUWVmaDdLelBxYXhqOU5xRlBQ?=
 =?utf-8?B?M0NYNnpnNURwbGhjODdzaFplbmR4TEVaeUpXREFtZWViVDFqVWFHazd3MGJL?=
 =?utf-8?B?MXczd2VPMSt2bXNiM012b1hRQlo3TEF6Q3liU2kyeEFyZE5PSi8rbHU3eit0?=
 =?utf-8?B?RmZiaGFsWDB3ZEFnczdkbUtEd2ltZDV3c2VJcjF0bjVZM2hYa0l0MTlaSGpV?=
 =?utf-8?B?c2ovMWN2L3UxNUZnU05RMzluTHpORmhpNzM0ZUVWVldsZWVhd3ZrcDdCME1O?=
 =?utf-8?B?a3RYUTFKMzl2ZDJBUTBVNWRNRSthcWdCRmVOdE1maWNiVjBiUFFIU2g5ckts?=
 =?utf-8?B?UTJjRXk0MENqaVR6ZmJwUGE2eXE1bC91NUUyTllPL25FaUFERkFMSFdMUVpw?=
 =?utf-8?B?UENURUdJem9rOU1QdGtmd2V3M1BLRGdBb1kvdk9RSHdHUDZtWWVoazJtZmxp?=
 =?utf-8?B?cWJ5Z0FJbkkwNVZuaVBMYnZJWUJuSUdNS1k3TlBSOHNBeUdWSkI4TmpjV1Y5?=
 =?utf-8?B?d21VQ1c5ZHJ6cFFJVVRtWU9nbzFkR1prSDA4eU1HazBjRFBmMVVpN3RHV21u?=
 =?utf-8?B?K0JDWDBRb0F0UVd3MnRCUjRDaTF2eUlFZkpzeEZkbHFmbURWNkpMQUtrSU8r?=
 =?utf-8?B?NHVocVRlc3Ura0twd2trMkpnN3h3T21QbzNVdmJPOTNhSmVoQmlRTTJLV1Fv?=
 =?utf-8?B?TC9XT0FEV2FCYzFiVzk4cFpaU0pENFhueEcyUWdZbVpCYUhIcjlNM0FLQUNX?=
 =?utf-8?B?Yko3SDRPMHNRTTFEU2pqYUY0OTAxMEpnSUNTL2RYd3EzdzF0cjVpK2IybVlG?=
 =?utf-8?B?NURmYjg1ZENtOURqUkY1K2d4UkhBOEZFcnJBOW83UVVnbFVKdTNPNjFvYWZF?=
 =?utf-8?B?ZmFEaUZJOFhFSWxrbG5XQlo5Tm0yNGczVGkxT0RsK08yWXRsQy9TMElqZkN1?=
 =?utf-8?B?OXNrWExWYW9xOHI3WnZNYVhUMDhvWEdiR3RnbjJLUzhWdGpKdm13QnM1ekZk?=
 =?utf-8?B?N2RURVU3NTlzbUN2OWJFdy9yQUxrVVFDTkowcnZTZGJGejFscFl6Q2dIQnc5?=
 =?utf-8?B?NEM0bXFQOTF4SG5HUVY3S1BxUUpneXJtYjc1aDJLMms0Y2lLWnlZWXpjS09x?=
 =?utf-8?B?Q0N6NXRsSlB5Vlg2RU1xR01kYjVXb0ZOdEJKR21pK2VEWWsyeHJqNUp5ZmIw?=
 =?utf-8?B?eS83VlpiV28xVVZnZ2hmM1dIcDQwZVZvcDBCcjZoSW1xMzJ1d3gyano1ZjJR?=
 =?utf-8?B?NHdheFNLRjRDY2I2SE1EUWpabEI0b1Y5c1BUZXZkN1RVY2ZXeFdMdHJRNit5?=
 =?utf-8?B?REV3V2U2VDd2K05MdnA2THBHSzFrMWY1d2I2U0JuL2dTVUFML3ozb3BvOUdY?=
 =?utf-8?B?eVVGaUF0elB4Z29hdFowSXFzcmp0cldGRVZEdHBoS2NtTW16RmlUd2U0eDJH?=
 =?utf-8?B?Z2R2SUdPNHNSVS9jZUh6dWJBSjVGc1dLbGMyOXFXMkxYV1hMK1ZBZ0c1T1R6?=
 =?utf-8?B?OFRFTkJUUVNwZjlZQUtwSHE5VTFWVWFSa0tjQlBVMkVJNlhXeEQzTlFVNDdR?=
 =?utf-8?B?bVNkVTBpTFlmRUpyenJWYSsvMk1RNlM4VW13cyt2NWVrc0hsNUxFL0NVZDMx?=
 =?utf-8?B?Qm8xVlBlZDRGR2Q4aWhkTURwbE9vc0hZTytXT3Y2Uk52eWVmaFJPZkI5OU5M?=
 =?utf-8?B?M1pjSkZDbGl1M0NIb2Jqci9MWWpaZkFuNEx2Tjd4YkxzeFBjZWNrVnBLSmNV?=
 =?utf-8?B?SFliZlkzejlTRWJWaTJkM3JtejlURjVRS3ZEUmpBaWVyeiswcGFUR0tuNGtF?=
 =?utf-8?B?RGVxV0h0Q1JmcVJqbHFjYVRWN0tvK01FaWNLa3NGbjQzZHVPYXJtekRINFVx?=
 =?utf-8?B?UlZVSXRZbzZhMXh1ZjJ1VnN6LzJlOEYyRE43QVVvODBxS1kzRjljMit1WmFS?=
 =?utf-8?B?TEkvaHhZSldLWlAzYS9KNGMvdkxvUnJQS3FsUjZWSmpXSUZ1ckEwanFDT2lr?=
 =?utf-8?B?Z2NWUmRkVHNWejljUVcrWFVCQkVtbEFqSUdOKzRqcmJXZXhmeVppbG5DT2NC?=
 =?utf-8?B?eWdVK3hhVUZpUGMrZ0NBM2U1ZlQvVG5WdncxcGVRd1BYaklpL2s4VDI2cDRC?=
 =?utf-8?Q?2ELZpZ5B50WWFL1uko2T0YxrB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8145d740-5ce8-47bd-d191-08da8ef8c3c8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 04:40:31.7847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RKo42N3U0v8Z4PhdlgAC2EKOm1hJFIGNUXOVKs1BimXw8vlw0eVN0WfBGre1F27dXvMwuxmYTAK2vwSG5AySSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So the basic issue I mentioned is that:
> 
> 
> /*
>  *           ,------------------------[1:n]---------------------.
>  *           V                                                  V
>  * perf_event_context <-[1:n]-> perf_event_pmu_context <--- perf_event
>  *           ^                      ^     |                     |
>  *           `--------[1:n]---------'     `-[n:1]-> pmu <-[1:n]-'
>  *
>  *
>  * XXX destroy epc when empty
>  *   refcount, !rcu
>  *
>  * XXX epc locking
>  *
>  *   event->pmu_ctx            ctx->mutex && inactive
>  *   ctx->pmu_ctx_list         ctx->mutex && ctx->lock
>  *
>  */
> struct perf_event_pmu_context {
> 	...
>         atomic_t                        refcount; /* event <-> epc */
> 	...
> }
> 
> But that then also suggests that:
> 
> struct perf_event_context {
> 	...
>         refcount_t                      refcount;
> 	...
> }
> 
> should be: ctx <-> epc, and that is not so, the ctx::refcount still
> counts the number of events.
> 
> Now this might not be bad, but it is confusing.

I don't have strong opinion, but we store events in ctx, not in pmu_ctx.
So, I think it makes sense to keep refcount as ctx <-> event?

[...]

> +void perf_pmu_migrate_context(struct pmu *pmu, int src_cpu, int dst_cpu)
> +{
> +	struct perf_event_context *src_ctx, *dst_ctx;
> +	LIST_HEAD(events);
> +
> +	src_ctx = &per_cpu_ptr(&cpu_context, src_cpu)->ctx;
> +	dst_ctx = &per_cpu_ptr(&cpu_context, dst_cpu)->ctx;
> +
> +	/*
> +	 * See perf_event_ctx_lock() for comments on the details
> +	 * of swizzling perf_event::ctx.
> +	 */
> +	mutex_lock_double(&src_ctx->mutex, &dst_ctx->mutex);
> +
> +	__perf_pmu_remove(src_ctx, src_cpu, pmu, &src_src->pinned_groups, &events);
> +	__perf_pmu_remove(src_ctx, src_cpu, pmu, &src_src->flexible_groups, &events);

Rbtrees does not contain sibling events. Shouldn't we continue using
event_list here?

Thanks,
Ravi
