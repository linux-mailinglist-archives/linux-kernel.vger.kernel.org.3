Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71196524563
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 08:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350160AbiELGLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 02:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347360AbiELGLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:11:19 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36F66D952
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 23:11:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmGGEz9ak88uhMPGZs3eqc2XdwMCPsi6tVDTav7RRXlbAGJRbRBRErNj23a44S4KHpXYW2iF4I8uS6qRRCOV8E3+1x77ZOq1nGgigJ6Ud2C4kIF97TUErG1hmwQvVj38t9WdkblvG4q8h7MeiUXvy6582snwJr3OZh0y1RrMFXT30g+/9OFI+2uUhPfAHKV5zLr5+PdhVWAbYRIeuq7MuGc/yaWVr7H8RPO16tnAsn2S62n7c6eO64APp5q/h1jYluURU/7H6FvVafbd2yfHXccF6DN2BFeKByr+7EpAG71ZvZFrLBWVVr1Ug9lzrk40Tqwb8IIwnDX3+xd9CgfLvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7VvLz7VDJIKaVXyTVSL5esDwKStvlI/kKNQugiA2vk=;
 b=grjzjru0xnD+eObUIHl5lHj1vjXCrm2eqZJQCGYyKOuPpnMbsWsto4LH9JSOKJaY2zVupxHAAO18eouZBPWZ7elchQn2MMuE7r7RDcRxLQcPjXpoyJmkQ/XfLOBu6GvdRQ/08aGNTDBHGhvDZNSZbh6GEGvQHPZ0SVRGVLH5NDSw0P9jqo7QssYp4+cdJ9Fm6yKGGf+14PWWIp0gxqHrboi2nZz+a6vQdBGvos5brJD5HYhf36hsBc7QLFgBzy5LGqeOg3Gkr1PSqPeq1NiVXQtOKqJ/enq/Emr5089Y72eFjATl0O/cyFTAl/g1lh+oD6zeUIUZnfZVqEgFmtj/mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7VvLz7VDJIKaVXyTVSL5esDwKStvlI/kKNQugiA2vk=;
 b=1bccimF2xHb1IfzF2Ttw4e7d//bYad2USwplxL7ALSHkZCiICANl4EPfcPvL9/Gryn7XGMpwNUeYiJ8mG1PPBv33pICPzaUGaWOwao8Vf3oLaSDq35rvEGq1QoJo7nRs3PrUR/XVVJnCexalUHUnMxcNYfpOElO1SZ6uuSe54/E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2381.namprd12.prod.outlook.com (2603:10b6:802:2f::13)
 by SN6PR12MB4768.namprd12.prod.outlook.com (2603:10b6:805:e8::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Thu, 12 May
 2022 06:11:14 +0000
Received: from SN1PR12MB2381.namprd12.prod.outlook.com
 ([fe80::5d6e:c1ab:b325:73c9]) by SN1PR12MB2381.namprd12.prod.outlook.com
 ([fe80::5d6e:c1ab:b325:73c9%7]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 06:11:14 +0000
Message-ID: <6e480001-ecd6-1ce5-f95f-8eff42587c78@amd.com>
Date:   Thu, 12 May 2022 11:41:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v7] sched/fair: Consider cpu affinity when allowing NUMA
 imbalance in find_idlest_group
Content-Language: en-US
To:     peterz@infradead.org
Cc:     aubrey.li@linux.intel.com, efault@gmx.de, gautham.shenoy@amd.com,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        mingo@kernel.org, song.bao.hua@hisilicon.com,
        srikar@linux.vnet.ibm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org
References: <20220407111222.22649-1-kprateek.nayak@amd.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20220407111222.22649-1-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0001.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::6) To SN1PR12MB2381.namprd12.prod.outlook.com
 (2603:10b6:802:2f::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e490b163-a536-4d86-111a-08da33de37b7
X-MS-TrafficTypeDiagnostic: SN6PR12MB4768:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB476821015E6AE18772569DCD98CB9@SN6PR12MB4768.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ipVF3ICztjNr/VNXglc2yiK5Wo+tmCLs88y4a7sgjBkNdaApYbIOoYW9IjdtxF2GIDxgGFCp3TpFTEtqmkTEAOWE8GP5/eqBj5OIxjPinr1u23j3s7PXDcSuLxJiXi5fnqu3e0+EFzHQpKqxduarHXuawuBzhWgtOK8ePp543ghY5uukQDuqqYG1jjKkluwpJXBAavW+DfRjlRY9+DLALPuB6MuNbEEFoMhr6EbaePABOM945eDFPRaArUGwFVxwNWAJKZQwmZMrxuWEOX5bQkpaWisTejOzHfQN+wFbgm0T+68XmBjGoYQvGE+TLc354FqkAcFlC2Jqf04FhaQdI4CYneBqGrp+Jia+/1+yvrltXp5ItbNz0GfccriDbzFR7jHmOKIZw9qPrUGWs//KZryItmxYCLso2HTB10z7bqr3xem73ve7C6S4eQq7n6yLgeeW2286ZMSxyQmkitjEBTajKMWI0txL7ATKUJaPYW7fKEYgFuS0NqmgVzzTUMQ7OVSh4SeJu/hGZHI+rMgtA/ycTOeb4/ANGSbwICPKgcyMwrwwqJG1TspYZVb6q22c11UNtLg5DT1c4Q6CWCPwOm9WoS4zFb8UBECHR/bshz+p5Wqeepeib191jV7qyY+WOcGrTmwkJwH3IenvhyRlgxzGgNgdf5uh5kpANChynqtMTQAM5FULaOVQael+vZ3r8Zg9fJHoMLaCRzJ/3lhylENCEYpZWnFjBr+0WMMFJVkyiKptptzS/81v0XwzV0Iv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2381.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(186003)(31686004)(6666004)(6512007)(2616005)(26005)(2906002)(36756003)(5660300002)(508600001)(8936002)(6486002)(7416002)(38100700002)(86362001)(31696002)(66946007)(66476007)(66556008)(6916009)(8676002)(4326008)(6506007)(53546011)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dytwMXM0V0o1MDdPWFZXVHY0Vk5sTG9Yc05COGhvbDV3dFBRRXBGcHFYNjEv?=
 =?utf-8?B?bXpNUjFuWk9tZzVVV09xaHlHK3U3cFVkcGdORE5pd295b0VHaEE5a2RsSFB2?=
 =?utf-8?B?bHAzZVFqU0NvM2gxZHQ4U2FjZzFuWml0d2ZQa1lYK25IbjZqRW5XSU5zc081?=
 =?utf-8?B?L2JSOTNYNEgvaVU1L3lCQjUzSWEwcTU2L3V3QndteDZnd3FGeG5xcWVVLzhv?=
 =?utf-8?B?Z1lhUDJKNjZJZlNRMURQSWo0ZUpKeUlMbHdIYUd1cFJLc0JlRk1FNXpJL0F2?=
 =?utf-8?B?NjA4Rk5vYm5sMlJDZHVYanlVRlpkdGxOQVF2U2s4disyU3VDaHpWV1RkNkJh?=
 =?utf-8?B?WWcxY01ieTIrREdlNitWNVcwN2Y4ZmdQVlhPMWZ6TjgrNHNUOWJsTUprdVRU?=
 =?utf-8?B?SlZ6WndOajRSY2FzQjZodVBWQW0rSXBWcDZWMGQrMWJrdkNHZ2pxZExBQVRH?=
 =?utf-8?B?ZldvTlExcXprQldzMGNmVngyMldMTlAwUnNuS2R0cTNhQ0NCQWx4MGpPN3Vo?=
 =?utf-8?B?NHl6S093dlk3L21waUFaRE5qMENnYlFXeWVsMWpYbEZ4d3VUamdWRE5CUDJ5?=
 =?utf-8?B?bVZkSHdNU2pOZjJwaUZCeXFvVXJCL0FQNGpIcjlLb2MxamJlRyt4UjBvTWx3?=
 =?utf-8?B?L2lrSlZIM210Z0hUUUJNRHdISUFwY1Y3S0tQb2xmeng4RDBrb2lwTjMvbURQ?=
 =?utf-8?B?VlF5QzVIWWZQS1RVVFUwL1pDSE8yeDRzQVdGMng1MGljRk1iVDVWeFpkTXIv?=
 =?utf-8?B?MWQ2a1NpUUY1R3Q0cW5pR1E1MnF5VEtqb1QxWFJuNjZneGFkdjI3UVFKMjI1?=
 =?utf-8?B?V2FRYS83Uit5UFlhSVcrQStKd1IzZjlXdFgvRzFNUjY4cHpFaURKNGhCR3Y3?=
 =?utf-8?B?UlQySE56SitNTjdCTzVMRG5na0pveG9uV1dPNUI1SG5NMmdsZDdvWi9HeW45?=
 =?utf-8?B?c284M2FTRkZ1elgxem1NYnhTYko4eCtyRGpHUmR3aEJqeFFYcVRJUTE2UXZx?=
 =?utf-8?B?UllLYUx2ekVQUGlOV3Y0SmhxQURXQ0RiblFpSGR2Skt3WEJUdjk4OVAwMjc3?=
 =?utf-8?B?dGtYaDVXOURheENaYmY0aXQrTkZuZG5jdWRsVmlmNnFMYnVMN2VRamYwQytu?=
 =?utf-8?B?UGZLZnByMmNtVWJybFhrc1k1SlJSNWExWnFnQXVrTFE1TUJ0WTZibGY1djA4?=
 =?utf-8?B?R0xmZ0NZaHdQY1JTNmRUU1lLTm9yTkhHZE1kb24rME5KU1pLUzR0Rmp1eXZv?=
 =?utf-8?B?Y2VIVTRZUzA4OUhpemNjeHZYcVVPQnorS1N6QUZ0NkZBZXZScmJDUmdZUHQw?=
 =?utf-8?B?UzVjT1J3b1ZUcnlDcWRHRGFEWTlDWEFZaHNqTkIzSW1DbkJYM1dnVUlUNS80?=
 =?utf-8?B?Q2IzTUtpYVNMYUlmb09ubDVGMmE4MjVpc21rek1aYUhGQTB4OERLVzlsMThU?=
 =?utf-8?B?WWx5b3BaQmtuRXNnbFJVeTVTU2U2Q3dLakFoMytDNFJ5Uk1TYjRLc2dXRVpT?=
 =?utf-8?B?ZDIrNDVReXVmRytubDc2Z1ArS1d3N3dralNHVnE4eFBRMW5FOWo5QTZudDE5?=
 =?utf-8?B?cGFMN0J6Qit6UVFJc1BBa1o4WGMxRjNleFUwRWNrWXdKbk5OckNxaHpVUHFv?=
 =?utf-8?B?WFc0bHE3MXhEVnYvSEtNeFl2TUxZUzRRUUxLTk1MWXpSY3B3SDU3eGE5T1RV?=
 =?utf-8?B?ZngxaUFiMUtBd1pOMkNNWERJSnZDbElpOUJ4UGZMM3Y1Q3J4OEp0ck1vUkg1?=
 =?utf-8?B?WU5ydEZCMlluYy9RaHlEWENRUWl3VmI2SS9lWk40T3MzaytvcU03bVg3czVl?=
 =?utf-8?B?dGdBSHdBNk1xaFdIWks4UE1JL3A1S3g5QitWRDUyUEFPNkZDb3BoYzBqcjFT?=
 =?utf-8?B?b3lJMnh6ejVUS1RPK2V0OEUwY2xCanBmaGdsdlRkM1hFdVhTSFc5V0h2cHFQ?=
 =?utf-8?B?VnlVWWNXSWNUNGRGODl4WjFtVSs3RDN1MGhIWmY0R3E3VDV4NnVuVUlHdUhN?=
 =?utf-8?B?RVRPRWRaWkY2cnZUSXRzZjZ6OFBQU25CWXl5N0IvNlJpOTczQzcrQmFVWGxz?=
 =?utf-8?B?QjdzSEc5VTdIVXZma3NXZVZudXFaTkovR1dJZDdiWU5hanlNYVZXb3ZrY3V3?=
 =?utf-8?B?U3VNYW13QW1VVkhmUWVLZEhTUHkyNUttUkp1U283eHUzOGgrdGpWTUxFT3Bs?=
 =?utf-8?B?eEtHeHdDR2Y3SzY1WDBTNTJPTmROQVRVR2s2WEkyYWM1K29janRoL01Ba1M4?=
 =?utf-8?B?TFNwRHlKRmxwVG5nak5uSEVBUC93aWJJQ2tubElsYWVNME9HdGQxZUpoUkw2?=
 =?utf-8?B?Tk1uTmxSb0EzcG1IZC9ERXdGT0tBRnU1N281MnNBODhiTHBTeDBCdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e490b163-a536-4d86-111a-08da33de37b7
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2381.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 06:11:14.2003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+FJAl421mmK2VS5bSYzk2AsSF9SlG9nq24+70AcdfKx48DMxQ//o5B9o7Gyk8MnEmuG406E4Tn29kKuKvtCDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4768
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping :)

On 4/7/2022 4:42 PM, K Prateek Nayak wrote:
> In the case of systems containing multiple LLCs per socket, like
> AMD Zen systems, users want to spread bandwidth hungry applications
> across multiple LLCs. Stream is one such representative workload where
> the best performance is obtained by limiting one stream thread per LLC.
> To ensure this, users are known to pin the tasks to a specify a subset
> of the CPUs consisting of one CPU per LLC while running such bandwidth
> hungry tasks.
>
> Suppose we kickstart a multi-threaded task like stream with 8 threads
> using taskset or numactl to run on a subset of CPUs on a 2 socket Zen3
> server where each socket contains 128 CPUs
> (0-63,128-191 in one socket, 64-127,192-255 in another socket)
>
> Eg: numactl -C 0,16,32,48,64,80,96,112 ./stream8
>
> Here each CPU in the list is from a different LLC and 4 of those LLCs
> are on one socket, while the other 4 are on another socket.
>
> Ideally we would prefer that each stream thread runs on a different
> CPU from the allowed list of CPUs. However, the current heuristics in
> find_idlest_group() do not allow this during the initial placement.
>
> Suppose the first socket (0-63,128-191) is our local group from which
> we are kickstarting the stream tasks. The first four stream threads
> will be placed in this socket. When it comes to placing the 5th
> thread, all the allowed CPUs are from the local group (0,16,32,48)
> would have been taken.
>
> However, the current scheduler code simply checks if the number of
> tasks in the local group is fewer than the allowed numa-imbalance
> threshold. This threshold was previously 25% of the NUMA domain span
> (in this case threshold = 32) but after the v6 of Mel's patchset
> "Adjust NUMA imbalance for multiple LLCs", got merged in sched-tip,
> Commit: e496132ebedd ("sched/fair: Adjust the allowed NUMA imbalance
> when SD_NUMA spans multiple LLCs") it is now equal to number of LLCs
> in the NUMA domain, for processors with multiple LLCs.
> (in this case threshold = 8).
>
> For this example, the number of tasks will always be within threshold
> and thus all the 8 stream threads will be woken up on the first socket
> thereby resulting in sub-optimal performance.
>
> The following sched_wakeup_new tracepoint output shows the initial
> placement of tasks in the current tip/sched/core on the Zen3 machine:
>
> stream-5313    [016] d..2.   627.005036: sched_wakeup_new: comm=stream pid=5315 prio=120 target_cpu=032
> stream-5313    [016] d..2.   627.005086: sched_wakeup_new: comm=stream pid=5316 prio=120 target_cpu=048
> stream-5313    [016] d..2.   627.005141: sched_wakeup_new: comm=stream pid=5317 prio=120 target_cpu=000
> stream-5313    [016] d..2.   627.005183: sched_wakeup_new: comm=stream pid=5318 prio=120 target_cpu=016
> stream-5313    [016] d..2.   627.005218: sched_wakeup_new: comm=stream pid=5319 prio=120 target_cpu=016
> stream-5313    [016] d..2.   627.005256: sched_wakeup_new: comm=stream pid=5320 prio=120 target_cpu=016
> stream-5313    [016] d..2.   627.005295: sched_wakeup_new: comm=stream pid=5321 prio=120 target_cpu=016
>
> Once the first four threads are distributed among the allowed CPUs of
> socket one, the rest of the treads start piling on these same CPUs
> when clearly there are CPUs on the second socket that can be used.
>
> Following the initial pile up on a small number of CPUs, though the
> load-balancer eventually kicks in, it takes a while to get to {4}{4}
> and even {4}{4} isn't stable as we observe a bunch of ping ponging
> between {4}{4} to {5}{3} and back before a stable state is reached
> much later (1 Stream thread per allowed CPU) and no more migration is
> required.
>
> We can detect this piling and avoid it by checking if the number of
> allowed CPUs in the local group are fewer than the number of tasks
> running in the local group and use this information to spread the
> 5th task out into the next socket (after all, the goal in this
> slowpath is to find the idlest group and the idlest CPU during the
> initial placement!).
>
> The following sched_wakeup_new tracepoint output shows the initial
> placement of tasks after adding this fix on the Zen3 machine:
>
> stream-4485    [016] d..2.   230.784046: sched_wakeup_new: comm=stream pid=4487 prio=120 target_cpu=032
> stream-4485    [016] d..2.   230.784123: sched_wakeup_new: comm=stream pid=4488 prio=120 target_cpu=048
> stream-4485    [016] d..2.   230.784167: sched_wakeup_new: comm=stream pid=4489 prio=120 target_cpu=000
> stream-4485    [016] d..2.   230.784222: sched_wakeup_new: comm=stream pid=4490 prio=120 target_cpu=112
> stream-4485    [016] d..2.   230.784271: sched_wakeup_new: comm=stream pid=4491 prio=120 target_cpu=096
> stream-4485    [016] d..2.   230.784322: sched_wakeup_new: comm=stream pid=4492 prio=120 target_cpu=080
> stream-4485    [016] d..2.   230.784368: sched_wakeup_new: comm=stream pid=4493 prio=120 target_cpu=064
>
> We see that threads are using all of the allowed CPUs and there is
> no pileup.
>
> No output is generated for tracepoint sched_migrate_task with this
> patch due to a perfect initial placement which removes the need
> for balancing later on - both across NUMA boundaries and within
> NUMA boundaries for stream.
>
> Following are the results from running 8 Stream threads with and
> without pinning on a dual socket Zen3 Machine (2 x 64C/128T):
>
> During the testing of this patch, the tip sched/core was at
> commit: 089c02ae2771 "ftrace: Use preemption model accessors for trace
> header printout"
>
> Pinning is done using: numactl -C 0,16,32,48,64,80,96,112 ./stream8
>
> 	           5.18.0-rc1               5.18.0-rc1                5.18.0-rc1
>                tip sched/core           tip sched/core            tip sched/core
>                  (no pinning)                + pinning              + this-patch
> 								       + pinning
>
>  Copy:   109364.74 (0.00 pct)     94220.50 (-13.84 pct)    158301.28 (44.74 pct)
> Scale:   109670.26 (0.00 pct)     90210.59 (-17.74 pct)    149525.64 (36.34 pct)
>   Add:   129029.01 (0.00 pct)    101906.00 (-21.02 pct)    186658.17 (44.66 pct)
> Triad:   127260.05 (0.00 pct)    106051.36 (-16.66 pct)    184327.30 (44.84 pct)
>
> Pinning currently hurts the performance compared to unbound case on
> tip/sched/core. With the addition of this patch, we are able to
> outperform tip/sched/core by a good margin with pinning.
>
> Following are the results from running 16 Stream threads with and
> without pinning on a dual socket IceLake Machine (2 x 32C/64T):
>
> NUMA Topology of Intel Skylake machine:
> Node 1: 0,2,4,6 ... 126 (Even numbers)
> Node 2: 1,3,5,7 ... 127 (Odd numbers)
>
> Pinning is done using: numactl -C 0-15 ./stream16
>
> 	           5.18.0-rc1               5.18.0-rc1                5.18.0-rc1
>                tip sched/core           tip sched/core            tip sched/core
>                  (no pinning)                 +pinning              + this-patch
> 								       + pinning
>
>  Copy:    85815.31 (0.00 pct)     149819.21 (74.58 pct)    156807.48 (82.72 pct)
> Scale:    64795.60 (0.00 pct)      97595.07 (50.61 pct)     99871.96 (54.13 pct)
>   Add:    71340.68 (0.00 pct)     111549.10 (56.36 pct)    114598.33 (60.63 pct)
> Triad:    68890.97 (0.00 pct)     111635.16 (62.04 pct)    114589.24 (66.33 pct)
>
> In case of Icelake machine, with single LLC per socket, pinning across
> the two sockets reduces cache contention, thus showing great
> improvement in pinned case which is further benefited by this patch.
>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Acked-by: Mel Gorman <mgorman@techsingularity.net>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> ---
> Changelog v6-->v7:
>  -  Rebased the changes on the latest sched-tip.
>  -  Updated commit log with numbers comparing patch with the latest
>     sched-tip on AMD Zen3 and Intel Icelake based server offerings.
>  -  Collected tags from v6.
> Changelog v5-->v6:
>  -  Move the cpumask variable declaration to the block it is used in.
>  -  Collect tags from v5.
> ---
>  kernel/sched/fair.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d4bd299d67ab..520593bf0de6 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9215,6 +9215,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>  
>  	case group_has_spare:
>  		if (sd->flags & SD_NUMA) {
> +			int imb;
>  #ifdef CONFIG_NUMA_BALANCING
>  			int idlest_cpu;
>  			/*
> @@ -9232,10 +9233,19 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>  			 * Otherwise, keep the task close to the wakeup source
>  			 * and improve locality if the number of running tasks
>  			 * would remain below threshold where an imbalance is
> -			 * allowed. If there is a real need of migration,
> -			 * periodic load balance will take care of it.
> +			 * allowed while accounting for the possibility the
> +			 * task is pinned to a subset of CPUs. If there is a
> +			 * real need of migration, periodic load balance will
> +			 * take care of it.
>  			 */
> -			if (allow_numa_imbalance(local_sgs.sum_nr_running + 1, sd->imb_numa_nr))
> +			imb = sd->imb_numa_nr;
> +			if (p->nr_cpus_allowed != num_online_cpus()) {
> +				struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> +
> +				cpumask_and(cpus, sched_group_span(local), p->cpus_ptr);
> +				imb = min(cpumask_weight(cpus), sd->imb_numa_nr);
> +			}
> +			if (allow_numa_imbalance(local_sgs.sum_nr_running + 1, imb))
>  				return NULL;
>  		}
>  

--
Thanks and Regards,
Prateek

