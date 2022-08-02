Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C887587701
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 08:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbiHBGMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 02:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbiHBGMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 02:12:00 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A184BE12
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 23:11:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMX573lJXMFCjLQ5XGtQb84f7wI2z2TU1Bkp0Nurt8XqCFyZVotu8TSdzGOm7TZmWly6mGVErKEVy3B7G3ZBuUi4cQssoTul7vvwXoZSY7viZ8yNhzqnLBM/DMmMiuqqtA7ibZjLndUgY0GZ9YYvGJ4ovC3YoqeNhofV1lseYWkMEH6zWP0rN8ZtP44wCfeIGPspLjSlZqAFmVtAFkEZw2/6mJbsWz8wbYomvB07EUx+8dS3HyALw+4ErKD23vaOkTY3XyruRw+qYvnTtCZfFw4NPWx0AX20s8qCe1Yk+f2Y+KHN2di1+b/G3EFTIA/T10BusfVapkUjgP9BPBC6/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5ujKjZn1IvT9b6IlhGxcYn2VdY/rOu2D3N8JXtLFRY=;
 b=W6jhRRyc8gYMParQkZFJBiS8f9tBUNWfU8K3L4sFUgyOW/mHUIKpNHc9ZW+r2yaEROapG3EjnDwKEnkAVTF6Hss6An5nG53UKRSxV0Y2Kn47aLf+zhEQtcYTKMIKxwmwW9eTCkgIWsZDTtJknqBCC4YjX4nIs2b4nGRHAZGOuWQCci4Xe75G5xPT2KCa66miiMY7vym5D6Y8Q+HqmD6mQBzXuHHhzHuG+tRWWNdBu9+c9EaCtXZXoSmv+pOxV6hdF7xqS5qtZgCPxhhdXjPkDJWRmRmlMJqq4DWHShgQRQRs4jelS8oigVzO4jOkDzSW/6OAWak0MB24fflxlHIE9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5ujKjZn1IvT9b6IlhGxcYn2VdY/rOu2D3N8JXtLFRY=;
 b=iubbt5OvOYkj8zcXrHMtpWh98V9vQhJh2ysgrDm98x13yJV1WLjCapakEYfQeAr8EYHk1ap6CQeaAASzaqseHQ1PdegHiXGvO9wWhFA+SzGW4iqhxfKLw1s9IAWO9qsHXIKD3SaahBS4eRs4QfaYYmnt4yRMjuQTqiujZ/IoHes=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MN2PR12MB3293.namprd12.prod.outlook.com (2603:10b6:208:106::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Tue, 2 Aug
 2022 06:11:57 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::1c48:55fc:da99:87c9]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::1c48:55fc:da99:87c9%3]) with mapi id 15.20.5482.011; Tue, 2 Aug 2022
 06:11:56 +0000
Message-ID: <f994d403-df7b-d88e-8324-c29d0ef2034e@amd.com>
Date:   Tue, 2 Aug 2022 11:41:42 +0530
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
 <YqdL8LsOvxNqhz/v@hirez.programming.kicks-ass.net>
Content-Language: en-US
In-Reply-To: <YqdL8LsOvxNqhz/v@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0100.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::22) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebc270a4-c9f9-45d3-f68c-08da744de6f8
X-MS-TrafficTypeDiagnostic: MN2PR12MB3293:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 59+f7WPtBJi1JODa9QbmdgxjZpoYmMzurqE1gA4S178m2sKD2UC8jYfJdi8r/DZ9iX7dClVHCg2GwP/JB3aAeTqfypTagLS2x286eBP46mEUiTtUV0MOpIT+sZiAPM0h0uulWxRbzrdHciKDSNTqq/NL17WWk85iaKDiqsbokgfAi/hCy6HnJHr1/TG/4tUcCjRTx8tzgpLHgthOSvvrPSwhcrZI7nLwQ0G7AoCp+XMQx1pzVpTcGaDdQS0AgViXzhwNBdgJCGFtG8uIzkpTVhPEhHTo8KMEUY/sIERXilt9Kbu2WgTSBHAmOJQ62Hl3nNAW12rcaScYRz9XKGmlheGgx+NqdhqgkbV607mXzC1h8OfqfGRG2eR/TpZIThj2CnEdHZG1vLtu0uvP0kXz3ILtFSNmu35vwnj3gE1ly1GkOMy2tnJiihYmmeh8GkmwRnFX4ThMcbzWbJjqdB8sALfvk8T5vbtnRfvKT3t8ibFv7q5OZG8RUZoyyPim8wqyb1HS37sinkh9MFoTSX21feEWF6+MA0qMDvyvt61N3dmasIwWhiDJ11kDD0np3q91jFvZkm/OquIBk6nQnXd/sxWQFI00FgZgUWs2YN4R9NHSz2gRmKtien9Anm20nXJFG3HLfsErSKWFfNjeajdUxkk8j7LYyZzPEbLbEgnbCoXTkjdvDXgeveli+tfx3dND+oE+6TjA9pATlKHpFPU8BdgoYjyv4mloTazqu1q66/+lknyPBXqo/doryTRW2iQhz00oDu41530QBNI2+BwljG9W/iQjDUFJ9wIQE7rOawecEsVcp3IlHLqyKRL1ilggWLsJ0HGVzlanRjszLnVgFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(6512007)(26005)(6506007)(31696002)(6666004)(41300700001)(86362001)(6916009)(316002)(6486002)(478600001)(38100700002)(2616005)(186003)(83380400001)(2906002)(66946007)(66556008)(8676002)(4326008)(66476007)(8936002)(44832011)(31686004)(5660300002)(7416002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFViNXhWN0FBK0JUZ1ZheTBWcE1FREE4REdCUlVvRWZJRituTXdCUW10NHh2?=
 =?utf-8?B?UmswYnZtbUN3NlhZRlJXV2Z4dnlndExpQ09wc2x0OHZBZC9FUHZiTkIvM1M1?=
 =?utf-8?B?a2dHeHJLZXNQNlFTMzZUclNBNGlWcG1wNkpWVU1JVnJiVVdNaGFic0Z0enpR?=
 =?utf-8?B?MS9uRGEweGdwaGtqZCtFZkxmbzYrM2Y3QW85S0dHTm04Ty9ISGM1UnVvV0FG?=
 =?utf-8?B?WGo5K0pmU0VPZzZDc0JnMTZzOXJOcE12TkFTYWw0YjdmRlhBVnpCanZLbVdv?=
 =?utf-8?B?LytwR0g0US9vZjMwTFR2U1Y4MlhxcGFuWVJNRmp6cXV3UlFWby9KUGt6OUE5?=
 =?utf-8?B?TWptZFNtUzB1OGxEMjFRNWI2a1h2c3UxQzh2ZWFXSnJpZXhKdERvUkZZTVV1?=
 =?utf-8?B?QVVuV29PK04vNEQ1ejRVOW9nOEdIL0ZqaysrNzhCVDBibVJTb3FOOWlVNVJ4?=
 =?utf-8?B?aW1Yb0UvUlJGWTZxTGhibmZNbGFIY21CMEQ1d1U1a21kdkJ4RlNsQWNwb1Jw?=
 =?utf-8?B?TkE2YjIyaWw1VE03ajNmL3BiWTEreWZTSlRsYTV4eW9PaGdWREdCQlN3Mzdj?=
 =?utf-8?B?SkJicnVDbnhVem9HZTl4MGlUL0YxRTAvaHJFM09MbDZNaS9OZXFXb21lT0sv?=
 =?utf-8?B?MHZIM0FDRHhJMExiMEVqZjdQclVDWm1weE5vaXdXSzgySEFZUWJuRzE5K1hE?=
 =?utf-8?B?RE1PcE9QbDZTWkNwaTJ0elJRVGhuMjN1cHU0eWdkUWdaVXo0S3RncERaTjk3?=
 =?utf-8?B?RGVScmhnbnR6VVZmdEp5K1VOSkRTMDdadTFuNVB1S0JGaUlhUDc2blYzQThS?=
 =?utf-8?B?Nm9iK29OZDlGaXdRdWpsRk11QTVUcWc5RlducW95aUZ6QlRNUXRaZnRRckIv?=
 =?utf-8?B?dm5mc0lYRXhCdjI4aWZhRnFMZndSaytkWFR5UzUxOXQ3dzExdTNMTHZVQmE1?=
 =?utf-8?B?bUtHVWEveUlWSll4Y3RrTzRMc0hSa2lpeUo0UXdxUTNjRDRoc3JjNjBCQjJB?=
 =?utf-8?B?MnM1VkZIWlNUMVBxT1hDVG5IY01DMHBDZmlHYnppRS9jZUhVRmhTYUtUUFc0?=
 =?utf-8?B?bHM4amZyMjB5RFJCZ1hVSTNONS9CcjN6T1dabkdJbGpMVmswdlAydXJ1M0d1?=
 =?utf-8?B?UlF5NVdveG5kQ0x6M3JuWkFWeUFEdUxqMytPNUZCL3Brb1E5QzZGSnVrZE95?=
 =?utf-8?B?elRiazY5ald2M1VoZitSb1lUZWZ6S3NMT3I3Q2N0WkpoOURLN1M1U1drTlBT?=
 =?utf-8?B?dHhObG14cmlkMFIzLzd4TkFCSTBKS2c0NWFjSFZKSHAxUEFDZFJTcUo5U1BM?=
 =?utf-8?B?THAwWE0zcmtjM284R1ZOV0FFOExpOFBGRjU2aFB1cVE5ZWZ3VG5OMG56T3Bu?=
 =?utf-8?B?dmI0MFNuSlNMMnNReStKbDRkZHBYeC9nbEtVNFZ2ZHRzMHo3SS9MazNnUVVR?=
 =?utf-8?B?UTR3VzJqcWFneCswNUh2WlpRSHhjWks0ZStXVnN6LzBwdCs1VzN0UExHcXhS?=
 =?utf-8?B?UzRRcTYwL0tWOGlQbTM0SnBaVEp1MnRlRHBBYnpwUTd2TlpvTThkK3NRaklw?=
 =?utf-8?B?WEIyTDF0azFac0wvVjFYRzJwYmgyR3J1SUpqZmhrU01GTGZxc2h5ZmpZS3cx?=
 =?utf-8?B?ZVhMQmtCQ05HRVl2YmM3M1ZqZU9IcWEwQnR1eVF5cjVpbnR5OFhkZHNlaDJm?=
 =?utf-8?B?RFA3Nlh2MTB3eC9hL2I5QTFrYXZpOTM4L3U1anRqdERHRGkrNmI5NGEvL2dw?=
 =?utf-8?B?VXllYlk3OHpKTXcvVnU4SVkreWphZGNpblp2alBkejFzdEdPd3Q1WmpFWjdP?=
 =?utf-8?B?ZnJjYS81NHp1emMxV1gvT3RDQ2h4aEtyckNaY1ZrSmtMMGw0a0czaENiL3F0?=
 =?utf-8?B?TDdNMFRUeU1WbEkvTVNYM1dpTEVidVd5WFA3ZHBtMmYyMnZ2eTBLRVVnWE5W?=
 =?utf-8?B?eS9kWTBjbXFvUVErSDkrTldlMldsTUt6RE1wMzE0dVVQbThjeG43VXFQYjl4?=
 =?utf-8?B?b2thQWpmR2dkSWx0Sll1bVJ4VlVXZWNaSWtjcjllNCtrRGJWb25qUnhNcVJy?=
 =?utf-8?B?K0liRjJPNThrMzBqUmZJSzlsSEV5ZTk5OUdpTnlmMTIrczhSY3phcTFmb1Yx?=
 =?utf-8?Q?eg5avQ2PO0bU7CMr5YXH6t3wI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc270a4-c9f9-45d3-f68c-08da744de6f8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 06:11:56.6475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jmemrSJTQ39IE3zJKIioXWwE7jr7AACk/xhf6OBx/FXm+TcetlLnZc13ifDhu4LNKD0jFSkHet29g/nSA9fE7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3293
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> pulling up the ctx->mutex makes things simpler, but also violates the
> locking order vs exec_update_lock.
> 
> Pull that lock up as well...

I'm not able to apply this patch as is but I get the idea. Few
questions below...

> 
> ---
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -12254,13 +12254,29 @@ SYSCALL_DEFINE5(perf_event_open,
>  	if (pmu->task_ctx_nr == perf_sw_context)
>  		event->event_caps |= PERF_EV_CAP_SOFTWARE;
>  
> +	if (task) {
> +		err = down_read_interruptible(&task->signal->exec_update_lock);
> +		if (err)
> +			goto err_alloc;
> +
> +		/*
> +		 * We must hold exec_update_lock across this and any potential
> +		 * perf_install_in_context() call for this new event to
> +		 * serialize against exec() altering our credentials (and the
> +		 * perf_event_exit_task() that could imply).
> +		 */
> +		err = -EACCES;
> +		if (!perf_check_permission(&attr, task))
> +			goto err_cred;
> +	}
> +
>  	/*
>  	 * Get the target context (task or percpu):
>  	 */
>  	ctx = find_get_context(task, event);
>  	if (IS_ERR(ctx)) {
>  		err = PTR_ERR(ctx);
> -		goto err_alloc;
> +		goto err_cred;
>  	}
>  
>  	mutex_lock(&ctx->mutex);
> @@ -12358,58 +12374,14 @@ SYSCALL_DEFINE5(perf_event_open,
>  			goto err_context;
>  	}
>  
> -	event_file = anon_inode_getfile("[perf_event]", &perf_fops, event, f_flags);
> -	if (IS_ERR(event_file)) {
> -		err = PTR_ERR(event_file);
> -		event_file = NULL;
> -		goto err_context;
> -	}
> -
> -	if (task) {
> -		err = down_read_interruptible(&task->signal->exec_update_lock);
> -		if (err)
> -			goto err_file;
> -
> -		/*
> -		 * We must hold exec_update_lock across this and any potential
> -		 * perf_install_in_context() call for this new event to
> -		 * serialize against exec() altering our credentials (and the
> -		 * perf_event_exit_task() that could imply).
> -		 */
> -		err = -EACCES;
> -		if (!perf_check_permission(&attr, task))
> -			goto err_cred;
> -	}
> -
> -	if (ctx->task == TASK_TOMBSTONE) {
> -		err = -ESRCH;
> -		goto err_locked;
> -	}

I think we need to keep (ctx->task == TASK_TOMBSTONE) check?

> -
>  	if (!perf_event_validate_size(event)) {
>  		err = -E2BIG;
> -		goto err_locked;
> -	}
> -
> -	if (!task) {
> -		/*
> -		 * Check if the @cpu we're creating an event for is online.
> -		 *
> -		 * We use the perf_cpu_context::ctx::mutex to serialize against
> -		 * the hotplug notifiers. See perf_event_{init,exit}_cpu().
> -		 */
> -		struct perf_cpu_context *cpuctx =
> -			container_of(ctx, struct perf_cpu_context, ctx);
> -
> -		if (!cpuctx->online) {
> -			err = -ENODEV;
> -			goto err_locked;
> -		}
> +		goto err_context;

Why did you remove this hunk? We should confirm whether cpu is online or not
before creating event. No?

Thanks,
Ravi
