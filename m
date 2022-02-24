Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424304C2EF5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbiBXPF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiBXPFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:05:54 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47E818DA97
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:05:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEW++C085/mOGCotK62cifhJkJjx+RdbfEq08Y/DdEOlHQK3m/mKDy4p6kr7fY9LXhRWzG0/SKrgTRrfeSrRqtgIZRjLP/073oU8UrlypTvVofjU9NQbaFHVnE7xlPsffo9cFt66e4TRDBFZA0DIzZhkxR+X0jHN8C1xxKqx5cLiSF0+1NiMPypAeh6QsWk/RVEhrb7SHbT8GdoqpoIZpaqs+JpoA2Dk3ISuoQ0ueiGhZHkfcygo13HxKLAilIDSxmZ2/+9ZQ1AYP5F7o+PpNkNhXBvbNwh4R0jZ7uh8Ve4nuDOooaSERAIP9/wQVicwD/IA+8nsWm+EuDM8T5IyRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYis6gzglkzZrK5gceFhoN3RWFonpWTJ7udpinbUCoo=;
 b=NfS389qyfGwPgDH8yS/lc0P3JBLZbuf5vXE82w85dWuR0mmorsYrB8z9ntMECoNqHXvoY6SyCOVAtsXpwpv2AKn1JOGUCRMPXhiKFI5sAVj+gY/+8oPMtK7Bf55doeK1Y+B/4MNtfFcQyoW3PL1V/UL5VsL4Kttu5arOytpT1dpEMpfTkLHorpFgKtER/qLUSJLzIht8oKObcd+gFxcYZQ21HOxFXJs2BHGt6F8i54epTNVVQxzLLivlmWPHHGJ+mK7Zby9Bs8pjzjjBlAoDjGaxN5Q1fn6ndtpskHfxelaydnL/8qNB/diQc/CnSH0beA5n7KlRqPOktqHOLYv2aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYis6gzglkzZrK5gceFhoN3RWFonpWTJ7udpinbUCoo=;
 b=Ud2sow3JETx3dVkpAiiM5NvacEVHXsFX16lNZt42EKriEkiIJdUGuwVvVnNHZ7Yu+CNaJjLH7H5l7KXyE8bnOAKRGAVluNBoG+SVCRayeh+XR+AJs82nSQBq5DPn619uJBsjE375b9EEZnwpuc8cxn+iO1blHeARpJZ0kfpMoaU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by CY4PR12MB1846.namprd12.prod.outlook.com (2603:10b6:903:11b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Thu, 24 Feb
 2022 15:05:16 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8d44:d69b:b031:1d50]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8d44:d69b:b031:1d50%4]) with mapi id 15.20.5017.023; Thu, 24 Feb 2022
 15:05:16 +0000
Message-ID: <f78a0d14-b0d4-b6ef-4d6b-561df5bd8a16@amd.com>
Date:   Thu, 24 Feb 2022 09:05:14 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] kernel/sched: Update schedstats when migrating threads
Content-Language: en-US
To:     Phil Auld <pauld@redhat.com>, mingo@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org
References: <20220126152222.5429-1-carlos.bilbao@amd.com>
 <YhYKL4hxx4TNKHGD@hirez.programming.kicks-ass.net>
 <aac8f860-c01f-bda0-9f1b-029b234213c2@amd.com>
 <YhZSqd+d03oWUPP6@lorien.usersys.redhat.com>
 <0e42c46a-ccc4-e793-00b8-ae407e06846f@amd.com>
 <YhZXGv34YTV5omKq@lorien.usersys.redhat.com>
 <b7a28537-8bfb-7f0d-5ed3-f301983e4e30@amd.com>
 <3c6224ca-c0da-7ba9-1396-a2e74c4a40e8@amd.com>
 <YheQIU7oFDcaPoD7@lorien.usersys.redhat.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <YheQIU7oFDcaPoD7@lorien.usersys.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0223.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::18) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec508239-1768-4c77-f9ab-08d9f7a7108c
X-MS-TrafficTypeDiagnostic: CY4PR12MB1846:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1846344E3E2FF5051C12814DF83D9@CY4PR12MB1846.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uq80qdcgh1ZsgrBqDFK6xJ627I5XSxNPI64Lt4cnsmlT0NPIz0HWCkRzSSAXgUXZ5n+yC/Jpsb1by4fm/G8Noy6wCyAUidMUdsfLRKGjZlbm396WQh/gOxeXYcAUt+cUzSLBHZwYoau1UWWYFxJVnwHj7bAejg1M80airchsbDSSBMoqlF4lOrSAElSO6k9vDQcdZuG9Qcco38I/wx+p0KshOmqkEVm0q1DwmCn+MGqcoB5XQQOnfG1NN0ODpMqvOJJUAm8JLm87cZK9IBntkb2pYtA8e8RlDvBbn7Oxi7ADRba7oUSOHGopyEgxD1D2Q7GWT/pDZ7ZDX+Spg07jgl0fgGTt1mQK/C/OyBJy3MyOoMpDMwN8USwVeNE9DKvchWLuZsf14p/mRsOF4/CNu1pUhpQlTnmnYZIzoqWQGVtiXg0oCL3vNscLWxjqn0Rcml8GiwA4oBu0SGLd4u+pL/GMGvkkFBr5zuDOvr+roVdJVW9F1PbRyRaYtMhjuE+estKOVDxRue3yhosjtZw+KRgDFlpsYDNTATyNnHRzjWmyolNBm4LBEW5+VjUP4RV5AcQDbUircmbPWdg4U/h7ocy9NySRksaWasgkUkGuc5aMohml0+CuE2jTFeYu5Wq9efLvOl5qlwSggxAS943j0eOekPf120pFT7z0G9khpPSD2F36RAQ1VNXvZ1wfi+wMsjiAgQxBL+CcaVnmTK/dSLMSu+QZ7btbq75sLU7gD+jpC72lqv6n4nZdV0pIBPGd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(38100700002)(86362001)(53546011)(31696002)(6512007)(6486002)(36756003)(66476007)(508600001)(316002)(4326008)(66946007)(8676002)(15650500001)(5660300002)(44832011)(8936002)(7416002)(186003)(26005)(83380400001)(2616005)(66556008)(31686004)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1d2ZWZMZzYrM2IzM1VyMDJZYWVkYW1xU2FxNzZ6OXlJV2VxaExHRm85aGFo?=
 =?utf-8?B?bUFpQVBpbWRCMEI1QlRTaG8zUjg0RWJnWmpLSkR2RDZCUnNBTGRvU1Zuc2R4?=
 =?utf-8?B?aDdXRk5Zb0l4YTdvZkREcUl3QWp3UlJaNG1OaWFyQSt1VlNwYlhNb2NhMHBv?=
 =?utf-8?B?dFc5Q3VEcXZPeHdNclNmdE9GeFVlSS9GMG5PZUNrdlpvaHByb2tsVXAzamZC?=
 =?utf-8?B?WU9GS21IRGJaNVFFWE4rdkhlakNLSTlWT05sUk5Bb21LekRqS0xNODVGL3ph?=
 =?utf-8?B?THJPSmtlRHArUUNiOHVlRHA3WWwxNS9jTERFM1d2akpXQW42bUNTdTFieFFI?=
 =?utf-8?B?M1RUazBSS1YvVTU0d21CazN3REc2VGdkaDFYdmhlaVk1M1l6dGd5dkYxaDVn?=
 =?utf-8?B?a1pzc1c5STl0RUN1bEc1MDJhcXF1dXg2Wm1TbUNqcXBJZ05qbHpHT1I1eVZO?=
 =?utf-8?B?QSs3QzdiRTQvTituT2Nmbm0vYmxqbm5jT0lvWnpZNlo0Y1F5bnh3NUs0LzVr?=
 =?utf-8?B?RG9mZnNlcG5XelBvVVlRNk1hWWc0c0M3WGhJSGh3bDRJM2ZSQzZobzErVzZw?=
 =?utf-8?B?SUVLeTVLSDNDYTBaaEY2YTJZa2pVUkZwRWg1RHVvR08xOUVEc24reUEyZXVz?=
 =?utf-8?B?STd6eWU5QnhJRGIzNTM4WTFQdDBnSnNCNFRNRVBKUitaaXVJYWtuMGFmanhm?=
 =?utf-8?B?dHp5ei81TkIxUmIyYW1EQVVHY25BdGZKbTZ5YndaOUtyV2RWdGZhWmY0UTdv?=
 =?utf-8?B?QlQ1SGM4cHcyTGVWRzFKcHlkWC9PdjExM25QYi9KSXl5dUlmYnp0OU5LV21X?=
 =?utf-8?B?SjJwNFZiZTRUTUphNG1XZHd4UkQxWThHNDNCUmVQcTFMb29NRmJ3NjVmRkJC?=
 =?utf-8?B?cEVGeldaOXpvL2pGSG43OVNyUGF4YzJ4TzlUWjNiRjVVTktEMFdPTlFMMVlh?=
 =?utf-8?B?ejFlU3VZODNzRDJMTUxqbzF1QzQ1Q0d1ZHppam5BQ3RZMjhiQjhPMFFnSlVT?=
 =?utf-8?B?bFpyMDNlRWs4MFJEcG05dFhtQ3VZWXlTQnMzQ1J0bFRLM01PdHJHRU0rMW8v?=
 =?utf-8?B?a0lnWmZNUmVhM2ptMjJOdHlubnhoYVk2TnNDWU5ldHRaRHlPUUtzU0hKdW1p?=
 =?utf-8?B?cnkzK3RIQTRHVjBxd1JSOGE1Z21DU20xWGNqVUxQODVEWEZ1ZEJSdkZWb2Qy?=
 =?utf-8?B?RzJKVEx1UWo2ZDVIMlBjK0dGZFZRaW4zZXlkL0U1M0t0TGFBZ0xNSzZtbUtL?=
 =?utf-8?B?VTRpdEtVaUxjUTI0U1VJOXl6SHdud0o2ZGpIK3JzeWw4QXpHcHFraVNzU1pW?=
 =?utf-8?B?S3FiK211SVFnOG5LQ1JkaG5mZXROTG1QbEN2KzI2UXdjTkRKbGlNcStaQ2Jk?=
 =?utf-8?B?cVEwVTNUTjhsWWR1WUt3ZGpvSjkzdVYrVUpWdlNaVlhwQnBEYjdPR1BIazVZ?=
 =?utf-8?B?T1RLVGNwWllkUnNWTFppWGUwYVROa2VNYzNYeEVqZHdwN0R1WWZCVHlzell2?=
 =?utf-8?B?MkN0Y0k3cnZZMnVwcjVCKzE2L1NCRWJuRnord010S040YlpSamZzemUzOWtG?=
 =?utf-8?B?d0hQNFVXdTdjMFlBV3RyK1BFdE1sYkZNNmJqRUQ2b0lQYVpVOXhUVHdLK0lp?=
 =?utf-8?B?REtvTXdvN2ZteGFiaElCVEVvQVFkb0g0ejN5L0Jtd3hZL041OEJUZXBFdUdY?=
 =?utf-8?B?d0FZNnU5dzJJdStFa2xlVk1xRkpoR0s5UXFDMFM0UjRoY0FZNTFTK3crMnk1?=
 =?utf-8?B?ZVAwbDFJSzZpLzFzcE9ENUFXTEtBQ3NISFZKWklnejRhWTdwWUxxUWNUeU1n?=
 =?utf-8?B?NlluenQvOGs2cnJ6M05jK3Z1RXVmWmRUK1NyWHhXckdVczNhNmxmZ0Q5TEpC?=
 =?utf-8?B?OUhNVTN5MHNMaDNjY0s4bWVTSUljZ1JIbXhsTVJxQUQ2MnNyQysyL3NvODJo?=
 =?utf-8?B?QlM0Yi93WUdBSjlkdDNDYVVXMzRvTmhwRHNpZi8zaklFVVE2M3IwVnJkTjFL?=
 =?utf-8?B?R2NlSmZ5ciswdkp2QnJrVXRwTVM0VXNnVEFTOEwxN2Vqd0gweHc5SWFENHJY?=
 =?utf-8?B?cTAyMm1Jb1p4bStadThINUpGQ3NQWkloaXRuQW1Rb0NwMU16bHZhYnMzK1JJ?=
 =?utf-8?B?K0FqWjgyVldtOTdIbEFQL3ZFWkFrNVlheWFBUVVySTdTNTFZRzRjd1Rka3h5?=
 =?utf-8?Q?ZssX7HQkt60h60WKcqIS6v8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec508239-1768-4c77-f9ab-08d9f7a7108c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 15:05:16.0784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0prkkf63ikr7RfDvlPEnSfLd4aVYn327qXZ90reGxBkVl/QuyR51E46nKQuiL8SWz1YZ/5rZjAsJVSkTHimFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1846
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/2022 8:03 AM, Phil Auld wrote:
> On Wed, Feb 23, 2022 at 10:13:50AM -0600 Carlos Bilbao wrote:
>> The kernel manages per-task scheduler statistics or schedstats. Update
>> function migrate_task_to() to increase the counter for migrations.
>>
>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>> ---
>> Changelog:
>> 	v2: Update commit message, don't reinitialize sched fields.
>> ---
>>  kernel/sched/core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index fcf0c180617c..1360e501c737 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -8751,7 +8751,7 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
>>  	if (!cpumask_test_cpu(target_cpu, p->cpus_ptr))
>>  		return -EINVAL;
>>  
>> -	/* TODO: This is not properly updating schedstats */
>> +	schedstat_inc(p->stats.nr_migrations_cold);
>>
> 
> I was going to give a reviewed by since I was looking at this,
> but I can't convince myself that nr_migrations_cold is right.
> This looks more like a "hot" migration (using stop_cpu to force
> it). But nr_migrations_cold is not incremented anywhere else so
> maybe it's a terminology thing.
> 
> Can you tell me why this is the right counter?
> 
>
The alternative to nr_migrations_cold is nr_forced_migrations, and since
we call this function in the context of NUMA balancing it didn't seem like
an appropriate fit at first glance. But documentation in this is scarce and 
I'm not very confident with the terminology either. Maybe Ingo Molar -the
original author of the structure- can clarify the specifics of these two 
counters so we can be sure about this? Maybe we need a new counter?

> Thanks,
> Phil
> 
> 
>>  	trace_sched_move_numa(p, curr_cpu, target_cpu);
>>  	return stop_one_cpu(curr_cpu, migration_cpu_stop, &arg);
>> -- 
>> 2.27.0
>>
> 

Thanks,
Carlos
