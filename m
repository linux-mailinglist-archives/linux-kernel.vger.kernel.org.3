Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1EEA59C1BE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 16:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbiHVOiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 10:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbiHVOir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:38:47 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B21E1EAD5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 07:38:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eocmT5DDCnBfVzCgpROy8D/5QX9kRzQsLszmVS84sdRzxWaPGLLJCk7MZCQyy06PtyExuZ+9tnWkCXXkJfT0KgXEsBUxRPOkMWqveZ+5UjEX0tgyy5GMWRhjsA50HDkpzN5vag5eCWCYmvPuskpZWHHvEstCVU+s/cD71CjEOI6+KfIJ1OrsNF/67ZbWZBe9dbDPw6njMl0/fHiRhA56MicfF8c1fF+XuTR0/x5xciVfesdLBkqymOyxyGJ7mfYZ2Pi3xe4aw2Vf2Vug2WPxGWorwpcmxibIHIA+1ld69mn/n0tharf6Sch6PLLOSSHWdNYGu4VrdDpUCyEbNxaEGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOXkuhc74Mr9tG/QuIJJd2BI8rnG8efD6mZaq59yZ9c=;
 b=eXW7n5S4tv4XD7A+bAVwYnDW8ZPA4YCMSs39UdHEpFi4G+Y2OqpRblhLQsfUzbz15G52DLXihm9Y6aczzf4+NNNKXAWqAmsLbHj46yrvz9piLypvnRNVFg/+jCzmqBBeaVaxb16plmhodLY8lubQ2ZKAKGiyJPbwwhGgOpRHqqtbiLhnEds0Yc3LjgN6BtFmi68DebHsEjeKcO5n1L0W7zYCLnEb62oik6bcbwet2WjZg2vi85fk24uXO7Nw0nZ42QqL3M9b5eRG1WIteES/HswdmFDc+R89U/I5fm6EqGbY9WBTPRbkZ093zOzLaiFvNjA7szI1FGhSsEFWMUyp6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOXkuhc74Mr9tG/QuIJJd2BI8rnG8efD6mZaq59yZ9c=;
 b=1OzJmeZjh4TfpPuL3tRnkGr0NvkPiTq6W3mnGcK7aHINZZ3bxtmVuHQzzJmtGCyu95zgcOzD7xBC/UyCdNKUH22nEXqgC8xdFQ1OBxpCLXxFB1jB5tB5z8dcRqZGFAa1P6J+cGTXQuXx/wPjX4PWIPi6Z4JKRwmcnRkObpekeWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by BN6PR12MB1873.namprd12.prod.outlook.com (2603:10b6:404:102::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Mon, 22 Aug
 2022 14:38:40 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::7d11:1ba2:dab0:bae3]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::7d11:1ba2:dab0:bae3%4]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 14:38:39 +0000
Message-ID: <5f2efe0f-fb81-3bed-3aa4-a3b15d823946@amd.com>
Date:   Mon, 22 Aug 2022 20:08:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [RFC v2] perf: Rewrite core context handling
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, songliubraving@fb.com,
        eranian@google.com, alexey.budankov@linux.intel.com,
        ak@linux.intel.com, mark.rutland@arm.com, megha.dey@intel.com,
        frederic@kernel.org, maddy@linux.ibm.com, irogers@google.com,
        kim.phillips@amd.com, linux-kernel@vger.kernel.org,
        santosh.shukla@amd.com, ravi.bangoria@amd.com
References: <20220113134743.1292-1-ravi.bangoria@amd.com>
 <YqdLH+ZU/sf4n0pa@hirez.programming.kicks-ass.net>
 <YqdMmLqFS9cX4jRb@hirez.programming.kicks-ass.net>
Content-Language: en-US
In-Reply-To: <YqdMmLqFS9cX4jRb@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0178.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::12) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4489b810-49f2-422d-9105-08da844c00a9
X-MS-TrafficTypeDiagnostic: BN6PR12MB1873:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /0R0mhXPEEwp6YTYz3Ufky3pec5sS5a2v2I4Tq5M/GEx9gxLcPW/oJYOGkfSlMIQfrU+bH9xRtaU4hIfo1yd6uUlek+upbjvyW+0aNxgGtzrhrll8X2Dy0go2FpUFP9PneP1iCYV31PRUpQYcSWe2JMaXvX0qpZO4kR2j5iIOZIQkGvO9GVOLuAf9J+Fxz3N0haHg3B8joJpbV3JWrdj39vNARqPM7cxdhmJfHBlvFyJZHo7hcu369E0u3EBv2oiEY3UesG6amb1Y/WUzk5XofvCgiI8Bt8zm30PfjbNhS6WklHLEZgOeN4v1Coc9M6Ei3Rx6FRXPmO1gkv04yPkr7FTMOo0lvaeDZL2rzkLLLEokxoWuZBLjYmvQJO0/2ObRP/Isy2PddZ/4O7qFQgeMWKfT470ynWvZ1G4BJEg2pj2VjyD/U8u1vuwAKSh0SgtVQUICRPGSxqz6PfYfIFDnLuDGKVrsUlweXGnyJpfSpJEMFV5zezVs5O7PBKZD79M8rGw0MoE4WQOIMqcXhSuvxOIFvccE8dApWFdQTZmIYlEzpLCHqwPoPsVeFj/tn+PUmvfjF0r7lI07fQIqT6Wk88hfWnEwdp5Oqno7crtjoOjkreQP1MZNUgYHN2iw1P2mnUgOUfbS5j07huSWnuJ6txvC1mA7OLe5fF6YXU9VcakCKi6Y8XCCLJy7EdGP1xNLERm5X/zkBjGHWRZ7Ish9N8wxG1UpAUB0mZn2UXdqNyQdaxgCRJ3mIs6u1To6Dn7QHVOwzbokTlxlicUWmHL32vk47u8r5HKvtMYsppilCo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(186003)(86362001)(31696002)(38100700002)(2616005)(66946007)(66556008)(66476007)(8676002)(4326008)(6506007)(8936002)(31686004)(316002)(6916009)(36756003)(7416002)(2906002)(44832011)(5660300002)(478600001)(6512007)(6666004)(41300700001)(6486002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVdCQ3NrTnBMYWk2TVRNSlVjcUppUDhuUmkvNUJEL0d1Y2FXeTdOeU9tVWZs?=
 =?utf-8?B?OXFsbmUxV1A0N3pDbEEzVHJjY0Npd3JIZlM1eUdzMi91WG9MYXFtbUNEMWZn?=
 =?utf-8?B?R29CaDMwZDNMWDJlL3BYYm9sRFVDN0xxczdnOVQ5bHNhZkthbzFSYlRmWnRn?=
 =?utf-8?B?MHZoWjRBYVdhSG1PaGJNb0F4MWhzYnAxVnRKb2pqbGlJQmhzd2MxZTlSL2ZB?=
 =?utf-8?B?R3lvOUJxVVBmVFgybmxrRFF2Q2VBQkd1UDdHTlhtcC9kSVc2ZEdwbHh0UUEz?=
 =?utf-8?B?RmlhcVFwUFhiN2ErS0I4bEgzZk15Q0Nuck9SWGJkLzlCK2NRVW0yRFYvcm9U?=
 =?utf-8?B?NkxWclh3Zk5iR1A4Z0JTYWhmbitEa01jU2xkUkRWNHJZeXNIYUQrRVR1bmRq?=
 =?utf-8?B?WFZZMU9tUDJOdzJPK3FscmpsY3hwakhoNCsxdGRSNU9YYnltSG1HZC8xaTBL?=
 =?utf-8?B?dk00d3UrdVRjZ3A1S2crTHIvdWZkUlZySTd4eFNVQ2dQdVFqUDdyMFh4dUNa?=
 =?utf-8?B?d0JwV0F1MG1qZDdsQU9ZUUpjQTBQMThhMzNZMVBNaG1TTkM5ZXhUa3RRRWh0?=
 =?utf-8?B?bGRRTW9NTE9SQ1ZObW0vU2NvbHFxbE8zWDRFWmxSNEZNd3RlSjlBdG4wbzVS?=
 =?utf-8?B?YS8zR1MzT21GYzdFTytZR2NuQ215U21FQWJRSmVkRVFjeTlsREl3dS95Ukt0?=
 =?utf-8?B?eXlSZjQxUGQyQUM2K1NLc04zWVNuWmpUY3d0bG16aFMyNnhFdFQ2REwxc3Qr?=
 =?utf-8?B?aUdWN2EvS21hcDFCdzRqUlBCVDk0ZVJKUExNYVNzV0hRTWdNVXgrbjZzSnBx?=
 =?utf-8?B?bVhsYnJ6YVAyb01JR2Zjclg2YmFCWkRiSjhFeFlYWlVaSU95UmpWdHlJZkhk?=
 =?utf-8?B?OXY5bk5sQmwxZEQxek96OHBvVnhLVkQrSTQ3QXY3a0pNM0JsMEJQSExrVG1S?=
 =?utf-8?B?ejlxMEFMT01ZM21FUU45WWFsSHp5MXBwSm9BNnlGbHNLUUE3dWh4MG1LNUZH?=
 =?utf-8?B?bmFKa1diZStZQmdncVFsL3lIY2F5cGJ3RVFvOVE2eEgyMjFhalkxOXByQzRK?=
 =?utf-8?B?cXg3QU1hanh2TTYvUE9yNWREZFFGbDM5a1hmNnd3ZS94T1JiVkppTS81dGtx?=
 =?utf-8?B?MjV1ckx2eEJnMVh4NTR4V0YzZ3VZTWxtTDhZQlcvdGF3NFBPdVZ2ZzJMOEg0?=
 =?utf-8?B?QUZGK0tPbmlrMjh1MVRHalZzWDdmb0ZpTXI0QnJMYTBqcXovMTVRQmlsb1NG?=
 =?utf-8?B?TkpxM2lLV0tZZXY3ZUdxSWtnRG4vbXFUV1o0dVI4bUpBTUE1VzhmbnNxYytE?=
 =?utf-8?B?V2tSWXFMcUFLZ3hiMDN4OGozbzhFdStxUHRnZmlmVUhDSm42ME1TbEQvZ0Jl?=
 =?utf-8?B?S0QwU3l5M3Z5dnR2SStiSjA3RkVMZ01TbE9JbTlob3dzYytJSFZ5MDZoTS9K?=
 =?utf-8?B?RUt6SHBYUzV0dUh4aXYzeFBsT3FMbGdsRVZ1SU4xdEp5blZ3eDlZa3RiNDdT?=
 =?utf-8?B?eG9SbWc3ZTZkRDFHaGpGME5zTHY1Wkd5UTRJUmdPWXBGcTlaRzEyNEdRdzRs?=
 =?utf-8?B?Nlg2b2ZpQ05vV05ZNWxjVHltUW5qU2h0K2NoZ1ZiQ2QyUFBLNENOUnRSVUda?=
 =?utf-8?B?c1ZWVzVLeXFlS1lmcmxNZzdqNXhlR3hYWHhtZWQ0cWhKS1R6Z1ZyZlhMUmRj?=
 =?utf-8?B?YVVSZk1GVkJ4dEhYSzFBRDdoZitQUWlOR05zdEJOU0ZRd1dPbEo4SUdqNU8z?=
 =?utf-8?B?ekdLc3lDdnhMTnRNeS9yejZ1aUNxYjJwTlN3c1NycWtCV29XMTR4NUlzdDZQ?=
 =?utf-8?B?Z0hQdkF0bkx3MzN2QkhZZElscUhqZjE1bmtFMnZZWkVkM1Q1bjdRQkNTSURR?=
 =?utf-8?B?c29NTGtxL1JGVGRZVit4WjZ2OEJnclFndS9MQzFaQlJlS0daMG8zbnMrdjUw?=
 =?utf-8?B?Yjc0R3NTNGJuRld4VE00ckcwNFNjbldqOFhJcHYxTTlOakxkN01SZm41azRz?=
 =?utf-8?B?VVQwUHhqaDVvOWdjNTBIY0VMWm9UNDl6M2I4b2gvWjB6dVo3Umg4SFVUMDFC?=
 =?utf-8?B?NU1SVjlyN3ZyVGkyc1Q4UDJLSE5UQllvN09QTisxYy9hdWt2eDIzRk9kNGRa?=
 =?utf-8?Q?1knZX3oTaVwA5ryWdKl3iTEwC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4489b810-49f2-422d-9105-08da844c00a9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 14:38:39.6557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/gN7o+mBlz4/r2qwaMxDa3t80BcbNIPUmcWvnPOSclveOuZkS56d3JndRq+4/mYchxdL8ATb2apiUBNm3+O3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1873
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> You mentioned trouble with cpc->task_epc, there's one rebase mistake
> from you and an original bug from me.
> 
> You lost the last hunk, I forgot to clear cpc on
> perf_remove_from_context().
> 
> With these fixes I can run: 'perf test' without things going
> insta-splat.
> 
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2311,6 +2311,7 @@ __perf_remove_from_context(struct perf_e
>  			   struct perf_event_context *ctx,
>  			   void *info)
>  {
> +	struct perf_event_pmu_context *pmu_ctx = event->pmu_ctx;
>  	unsigned long flags = (unsigned long)info;
>  
>  	if (ctx->is_active & EVENT_TIME) {
> @@ -2325,8 +2326,17 @@ __perf_remove_from_context(struct perf_e
>  		perf_child_detach(event);
>  	list_del_event(event, ctx);
>  
> -	if (!event->pmu_ctx->nr_events)
> -		event->pmu_ctx->rotate_necessary = 0;
> +	if (!pmu_ctx->nr_events) {
> +		pmu_ctx->rotate_necessary = 0;
> +
> +		if (ctx->task) {

IIUC, this should also check for ctx->is_active? i.e.

		if (ctx->task && ctx->is_active) {
			...

> +			struct perf_cpu_pmu_context *cpc;
> +
> +			cpc = this_cpu_ptr(pmu_ctx->pmu->cpu_pmu_context);
> +			WARN_ON_ONCE(cpc->task_epc && cpc->task_epc != pmu_ctx);
> +			cpc->task_epc = NULL;
> +		}
> +	}

Thanks,
Ravi
