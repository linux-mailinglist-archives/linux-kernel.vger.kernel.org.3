Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856DA4BB06E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 04:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiBRD40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 22:56:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiBRD4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 22:56:24 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AC817A89
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 19:56:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTyctMUVsUo9YZsFfxC2Gkp/QATpvd0iRmIEZM9GCPkN5j5gHkt4BcRIywBZ0uu0bfI7jIGiICmZcsK3ichFFxte4QDzV7ARk0yW4CHXxH6CrMht8atHWzRJH8khDfKMTjQDzK7zQ1fUhlcBaJdvEZAuy7PMPSsFwPEomrpLvpT6F65xXwMx6ay6gBH6KLulIpfKV2DSX3EM4o2mWORz6behEAe7FZxBhfY9WDIEqs5tOmwGa420IgYxTiVLwVf1cHiXl94aNtRVAiGSXM0D1ydcbKnMTIRQOnnLSqVxEwfJTCMSAku166ksE0AnFQkM2LZcDlwYelAPijcSy7wFUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avO5cTZMKUum3L8AY21azZ3gKOkzRrw8M5GvDvZ4gI8=;
 b=JpVzcRVo6lSGkG+8TjfVDZ+sNnVrUjl9+n8OVkA5sasAw2Ze054ju6zKJjPhKoBeVSH4mLwo9ZOCdFVxTD1um3eVoxX0eyP9ihtGVfTSAv7FPxpk6QxIfqIsJ+sx5YtffLRiYtmgv71b5GEWep2k0T29ns0sI6sWG/3tboTDlkxd3x9VnoXHl5/Ry0wlBZteLlXwpkcYfSXR/ZEXbAdBQCow+KlgqfzoZu31wVFm5NLa5l+fvjzYT7DUn82kxZRAxbh4QEwuVmvcv1xOAMYvKSV9nwrzZawgak8GcxsxhdVVHPR3L//d/mOkiOi2adQT9r/4QEysOVd7OLgvObBOBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avO5cTZMKUum3L8AY21azZ3gKOkzRrw8M5GvDvZ4gI8=;
 b=kh07/jsxuFcTwaziYNdFJY+6K3veRhZSw9QNH8S/RvPDfMshHXA5rDgjx4q4oRDPBprR/p4bZfpzw06CiOwdtWhjziwdMkFFw65eQXA1YAwW2ZFudeVjirnap32HZsJ5P/KSgqgEJ/GSAO3KKq4YFiSHTkljCnjLNjL/qCa4oyY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by MN2PR12MB3408.namprd12.prod.outlook.com (2603:10b6:208:cd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Fri, 18 Feb
 2022 03:56:01 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::c90d:9f80:a049:b432]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::c90d:9f80:a049:b432%2]) with mapi id 15.20.4975.017; Fri, 18 Feb 2022
 03:56:01 +0000
Message-ID: <9de59bef-0dbb-d94a-077e-28e06daa521a@amd.com>
Date:   Fri, 18 Feb 2022 09:25:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v4] sched/fair: Consider cpu affinity when allowing NUMA
 imbalance in find_idlest_group
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     peterz@infradead.org, aubrey.li@linux.intel.com, efault@gmx.de,
        gautham.shenoy@amd.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, song.bao.hua@hisilicon.com,
        srikar@linux.vnet.ibm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org
References: <20220217055408.28151-1-kprateek.nayak@amd.com>
 <20220217100523.GV3366@techsingularity.net>
 <a57dbac2-1b8e-ea5c-8b6c-3a97ac186ad9@amd.com>
 <20220217131512.GW3366@techsingularity.net>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20220217131512.GW3366@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::24) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61b4b500-140d-4f4a-72af-08d9f292938f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3408:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3408ED926146E9334268BC3D98379@MN2PR12MB3408.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aZ4R3OAyFja/Qy1+CLkgwQGyJv14FqTP3ifajygCS62It8GHvg2wqnzwMhXb2Z5DTzpAbTWJelk/HGctlYHh1BFGbxw3AB2vABGxH8V/yaxdhmnc1bMPe+Y/rXZKVy6jhaCcVbZ5p82CxWaCqbtE6oXtxeDHVDDxUNscFczLdD29sj5IKwCLg5O0YHlWaCfoRhwgMN5EEEOuUDRlJiJ+L+fmrS/WuI/ptMl4bB2OEMqeiEwv2YIPNuCkuWNL4obmyqr5Z/hFXrFzhNVtAfzyqgImkRAQ7SAxMEICfdrSZC9/Cjw5V0BCC7nJLA6o0TmzU6Mmj+izFSg8OygUP2WTElU1DQ4vpd2aFaSNRiscyoQvibavU35cPqtDFkpUhvtANkK80TSsYVlRiGAZDaLftXQnCzPoN69+P26rTXycvpa3h1Y/G/TZ9To/1is53sw30LsZrCedekcRqkj7IZ+QXxhPJMUxn9gT4r/JGQRN4HgsQglEXmnFxq5/vZBqbV4mJ8Qh4w6/8LyH66E8wXaIjihWf3Cu/aYvRB8bnACvYUAC21IU5BsIRvjMI7g7VBQs44eNWbhDg77LPV27TGMd9hR83k1LyQUJqW/wAeYGWkNT+UWzP8xevx1UEJ4Zb+ETWu5r8vJR7AZ3nNF8GEXKdBDvyzwNYQj3d5KSbQmzFcvZW+voq914cbYFCwt/KDf6JaR/eUKFpc79tg6pYi9NakKE22/39ZIGZQpdcBkGT5f8nAwRjuq55mgl8C62ttINUMqODIx1uy9qV0slV1GV/Ftt6Sm1aGskU/mF3JUo8BMROxsVDPghWMm9NzXam6Nd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31686004)(38100700002)(86362001)(5660300002)(83380400001)(26005)(186003)(2616005)(7416002)(6506007)(6666004)(508600001)(6486002)(966005)(316002)(55236004)(53546011)(6916009)(6512007)(8676002)(66476007)(36756003)(8936002)(4326008)(66556008)(31696002)(66946007)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEprNWs0dVdYUG5nNkc2WWZXNDROcFZaLzlDbU5SVDVTU3FnSkpVMkYza2pw?=
 =?utf-8?B?Y3RzM0krU1o4ajJRV2wvbHhNYW5zazBZSDB4dmVjVmRXeWY0RXZmMzFVWTBa?=
 =?utf-8?B?T1pLZGM4TEFscEpPdkRkMEs3K3krdzRTOUVaVFNzRHBsbXJRM3hTTGRyOTQy?=
 =?utf-8?B?VHlGUXoyeWpUZWVydzByWi81V2ZSZDdnTEUvOGNEYjZFVDlpaW5nankzejlH?=
 =?utf-8?B?WUFvWFBhbmRiN21ReGFzbWtoOWNhWE1JQUpLb1Z2S3JTSUcxNzAwNDBjMkcx?=
 =?utf-8?B?aHIwSFlNYUdjRjZCZTczNzB3ODZXMHNiYlc4ckcwMDlZeFJ1Q3pkUEtPd3JD?=
 =?utf-8?B?ckplL0NlUGFidW1IT1RrdytXRm1ESDhpQ3NPS1d1QXVXdndBZkE0T0Y2L2Vz?=
 =?utf-8?B?aDYyOWRSOHFnOXc0b0NnTWRyZldmcjhOWDZCbkVFbUhvclE0RzBObjFTMTFB?=
 =?utf-8?B?NkF5emQ3dnFyOEhDbjVrRHppaFdqeHlCTzh1ZlQvU0tFRDR6UjFSemR1bjM3?=
 =?utf-8?B?aGtOM2NrS0hCSGk1bldsVU9EUk5lSkk5Um5wZWYrSlVNMG1ySW9EQ09acGtq?=
 =?utf-8?B?UjJKazdBa1dTSDI0ejIrV3VVSzdrZ1ZIaVZ6TThOa3pHTFlhbk9LTXo4clFY?=
 =?utf-8?B?VG40WHR1cnZzYXY1bS94TDdodmdlTnVFV1liM3cwRzV3Z3QvTnpmUFdQTzkw?=
 =?utf-8?B?bFRxaTQrL0l3U3BCWklsNm5CNkI3bXJPaDRhbzNLZjc3MWEyTktYaWUyTlc2?=
 =?utf-8?B?ZUIwd3g4bVh2UWo0SG5nY0Jrb2pTbWVDMmttZ01mVHhscExiZVJJY0JncWFs?=
 =?utf-8?B?T0xYN1dTeFlxZW10TGEvNWFZSWtQMUQ1cVZYbkhqeXhna1VQdzV1WUtxcVd2?=
 =?utf-8?B?U29PVEphdmVOL0tpMDlIbWhlUm1KK284RGJDQjVXV0MvSjNDc3lWNGpHZG8w?=
 =?utf-8?B?eDE5ZXJqbGE1R3RRdDRwVC8yVUZnOUZVdlNSU01pcHgwVXB3TkNtQW9WTDJo?=
 =?utf-8?B?SUpHL1hwZFA0MWFuSFdkNnU1VTFMOEZXN1d4U0Vtd04xbXhRZDZmQTBCS2Z4?=
 =?utf-8?B?TlEvWElIdHJ3WFp6RnRrcW10OGJxUkR1ZThzbnI1bGw3c0NhaFhELzMreDlW?=
 =?utf-8?B?TGlFa1B3OGR3SE5aczQ3dTEyK3E4eUJKZWovOUNEdGZYdGkydlp2OUJlNVZk?=
 =?utf-8?B?ZTd1UEpoTGNCQlRTbDM1bTJ0UUN4RE9qdEFZalU5NzdSK0lhNDFzTTNNM1Jr?=
 =?utf-8?B?YXlWRFlqK24rZjVTY0xuekRpdXM5OWhUbG5yeDBmK3ZEb21hR0l4a2ZzWFhz?=
 =?utf-8?B?MHlKM3FIVFRLa2h0eDVpaU5ibmtnY2Roak9sUjU0Z1JhREdkVUYvT24wWnlR?=
 =?utf-8?B?Z0duUkVYUkJxUG04alQwRlJJc1BNejk1MjExTjNuWWl4THJLMUNqU2RpZXc3?=
 =?utf-8?B?bGprbXpsTG9SN0tkdHNXamxIRlRvaWMreW1EdzhGQnRsSVRJRk91Y3gyUldC?=
 =?utf-8?B?NWlDazZ0YTU5T1BRYmlPUmd6Tmd1RExLQnFTNXVOOGZFc29SMW1oTVUxaHdm?=
 =?utf-8?B?RjlVTjhHSU1vR09RMWl0YThUR1VWTlhUdCtGU2lCRCtldXdnN3NxTDBoWkgr?=
 =?utf-8?B?cnpDQkJlTjU3SmtYSVdaYUluYWl1OENTelpXVjhrMmxkR2JrdHcvcDBYZG11?=
 =?utf-8?B?WEJzNGY4c1FNbUlYb2ZFQlNqdjlnVjJqN3d5bnJ4YVo0Z2xDS0NKa05SRG5G?=
 =?utf-8?B?VWQvTlEzWnd6Z0NZczZ1YTBwRGlVbGJoU3JKRnJIazMxMi9NcTE1K3NGeldV?=
 =?utf-8?B?am9EU2lVUTRXYXAxdkpiYjNQTXVubEUyTFFOVEJreXdvdjJGOTRKSVNUWHBV?=
 =?utf-8?B?TmQrWDNEcFZRTVAyLzNoQmp4QStOeGZ6UkdPSHlPTVZJMGhKdFFYQTJBbHBR?=
 =?utf-8?B?WGpZR3NLdzQxNVNTbVc0TndCNnVCYTE3L2NCblE2bktoMjFlalNkUS9ickh6?=
 =?utf-8?B?S1QxL1AvLzlaT3BaTGZhejBVUnpxMnNoayszbjRrOWYxOHZFaUVYY1N5VTRR?=
 =?utf-8?B?N3BWSTBNZENpdFhRRnh4NklpRUNkQ1VNYXZKVjhRQ0MwenhZaFRLclVTL2tD?=
 =?utf-8?B?UnJMOW5xcWRMT0lPd2JtZFdtU0xyKzdEak1veTVUNmhxSERIZ1V5OGhHaC9a?=
 =?utf-8?Q?aRth2VVJUYp68tJxtvqdSI8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b4b500-140d-4f4a-72af-08d9f292938f
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 03:56:01.0371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: runB4E3NH2wKXp4kq1narf3Z86fkhrH3SLs016bxM0BN+wzvmP4gyhmqa1tHm2IWSz+Jp6ObU43l+SIOhINtDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3408
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mel,

Thank you for the feedback.

On 2/17/2022 6:45 PM, Mel Gorman wrote:
> On Thu, Feb 17, 2022 at 04:53:51PM +0530, K Prateek Nayak wrote:
>> [..snip..]
>> Can we optimize this further as:
>>
>> 	imb = sd->imb_numa_nr;
>> 	if (unlikely(p->nr_cpus_allowed != num_online_cpus()))
>> 		struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
>>
>> 		cpumask_and(cpus, sched_group_span(local), p->cpus_ptr);
>> 		imb = min(cpumask_weight(cpus), imb);
>> 	}
>>
>> As for most part, p->nr_cpus_allowed will be equal to num_online_cpus()
>> unless user has specifically pinned the task.
>>
> I'm a little wary due to https://lwn.net/Articles/420019/ raising concerns
> from people that feel more strongly about likely/unlikely use.
I wasn't aware of this. Thank you for pointing this out to me.
> Whether that
> branch is likely true or not is specific to the deployment. On my desktop
> and most tests I run, the branch is very unlikely because most workloads
> I run are usually not CPU-constrained and not fork-intensive. Even those
> that are CPU contrained are generally not fork intensive. For a setup with
> lots of containers, virtual machines, locality-aware applications etc,
> the path is potentially very likely and harder to detect in the future.
Yes, you make a good point.
> I don't object to the change but I would wonder if it's measurable for
> anything other than a fork-intensive microbenchmark given it's one branch
> in a relatively heavy operation.
>
> I think a relatively harmless micro-optimisation would be
>
> -		imb = min(cpumask_weight(cpus), imb);
> +		imb = cpumask_weight(cpus);
>
> It assumes that the constrained cpus_allowed would have a lower imb
> than one calculated based on all cpus allowed which sounds like a safe
> assumption other than racing with hot-onlining a bunch of CPUs.
This is a good micro-optimization as long as the assumption holds
true.
> I think both micro-optimisations are negligible in comparison to avoiding
> an unecessary cpumask_and cpumask_weight call.
I agree. Checking for p->nr_cpus_allowed != num_online_cpus() will
avoid the relatively expensive cpumask operations.
> FWIW, I looked at my own
> use of likely/unlikely recently and it's
>
> c49c2c47dab6b8d45022b3fabf0642a0e62e3109 unlikely that memory hotplug operation is in progress
> 3b12e7e97938424de2bb1b95ba0bd6a49bad39f9 hotplug active or machine booting
> df1acc856923c0a65c28b588585449106c316b71 memory isolated for hotplug or CMA attempt in progress
> 56f0e661ea8c0178e80048df7166653a51ef2c3d memory isolated for hotplug or CMA attempt in progress
> b3b64ebd38225d8032b5db42938d969b602040c2 bulk allocation request with an array that already has pages
>
> Of those, the last one is the most marginal because it really depends
> on whether network core or NFS is the heavy user of the interface and
> I made a guess that high-speed networks are more common critical paths
> than NFS servers.
Thank you for giving these examples. I considered the case of branch
being taken to be very unlikely based on my workloads, but as you
pointed out, there may be other cases where it's outcome might not be
so predictable all the time.

--
Thanks and Regards,
Prateek

