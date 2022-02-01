Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9B64A5CCF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 14:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238351AbiBANHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 08:07:38 -0500
Received: from mail-bn1nam07on2047.outbound.protection.outlook.com ([40.107.212.47]:27406
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231978AbiBANHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 08:07:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ER/puhwtvfAgGBDx69B49ckiXArLvVPh12RCMCst3q0V6Wicq9CHQozPCin39aJ99tUfihhhQSMGPStJP5h2kPImsVQW1h2YL24jMu8QzKXIlKlaV07Vo4WLnyV0AKVVO3ovKXnr28wqO+NCu4V2tJyh5PgPxNHb0+Av9t0LSB+NzcB9s8e4EBu/0NYHABC+DRlvkyd1YhMciUTb1RBvxIg08XBcR8M/kVMm3w10EzGKfvILkAfs4udbRf9sy2i3BQcMrkquybY3PNrBEE7xMkPBXxKHOdBhY+GVBGBv6tDe7piI0edOujiZ0MDZydAxbjJjKXZcDAMxnhrXO9MP0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Li3KsDHIjfbppUAkkik0w+1aCX3pVWezpvZvrYMGGVM=;
 b=TllCDMa314JyVsi8ftaVmIZrz+49e6LaHYUWsBcXi87AywqSgM7+xHpyBjd4vjX9d4yCZt2vogvPhdIijLKACri+vkLVrjuO2y+4onvhC4q4OxGYXb2jw9wTOSZyZl/AREyoeKSluYyiS2ktnatJ/gXiys+k1pwAmKz6yJs1l8JBRCd0vjmxuGHgt/Tsfemve3JOh1NiD7C4epCGcd6ccy9Rodn4yX2VkuD62k2MGL3WwISEpwqE3p9lLy8X0ptDQi5DjhYTYJNepF/92ZV9YUX8h0niCFxIKZQRjTDQn07BrZKflEI0phqM7mY8khTLCUuSY2IrgWGm15xRNV6s4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Li3KsDHIjfbppUAkkik0w+1aCX3pVWezpvZvrYMGGVM=;
 b=J+IMq3Dm2RLYMOg9jC+xyKbLZ/6KIy/dbmv+4Zap1ifZQmN7ecxnqVHlWLGd3Jo4ds7WYw75NbZPw/ZdP7jRZ6ztalF8vAIViPGyYKBY8G2sunhDcGpmjtL+cL70iE7TGvS9vx9Cv6C5gQBqt2lGsjvBpLKldGenWOTaIDqnV+4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14)
 by BN8PR12MB3233.namprd12.prod.outlook.com (2603:10b6:408:9f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Tue, 1 Feb
 2022 13:07:35 +0000
Received: from BY5PR12MB4289.namprd12.prod.outlook.com
 ([fe80::b1bf:8e72:56ca:4256]) by BY5PR12MB4289.namprd12.prod.outlook.com
 ([fe80::b1bf:8e72:56ca:4256%8]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 13:07:35 +0000
Message-ID: <ff74bacd-9092-4ebb-a5bb-98e49cf314a9@amd.com>
Date:   Tue, 1 Feb 2022 18:37:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v0 0/3] sched/numa: Process Adaptive autoNUMA
Content-Language: en-US
To:     Mel Gorman <mgorman@suse.de>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        dishaa.talreja@amd.com, "Huang2, Wei" <Wei.Huang2@amd.com>
References: <20220128052851.17162-1-bharata@amd.com>
 <20220131121707.GW3301@suse.de>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <20220131121707.GW3301@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR0101CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::21) To BY5PR12MB4289.namprd12.prod.outlook.com
 (2603:10b6:a03:204::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a912fae-cc0c-418e-81eb-08d9e583d03c
X-MS-TrafficTypeDiagnostic: BN8PR12MB3233:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB32336E86397006933525F64FB0269@BN8PR12MB3233.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5x4heLThh6XwoHuBM3oQZjiFHVRQPDUa1W238xE0BiOIBBx1urKcJP4EUpLzhU5cm7l/n6VCyboQyyAkQO0gj8tgQCOnAYDIwRVI74USf+uWvzvgT2vY0uMgwFjrAincEu+OsQumy43lh/GxYYx+Oa0pJWy28uDZ15S1uKQPM6LBueMGjQnSiL49guq7L3RBnoc2CJdRCuLhtisXN0ChzN3/dJedBgeOWpRqT4/6n5zcHliDAbEixeJaiJj1Wn1g8YVvnCWiSS4SXKheWYC5aIIDo9ECGLuttDn41KWlDVyRY10wIxS70ON1RpoAh1oS4upTq/r1NxV02aNP2iqOj+Pjid0vXSfpkbbx8Xpv6WbEE1iyjn8UkyqnWZ3eo0ZUIXRVUBAPvzReWdVOyB1w6q4eBi6D6WYRQ4CvHm54eUfQDBaF3eIZ8VXOBKSH6cjWtDgx65q1B3LxzhhSZLr13b5lo3hKcaJ+BgTes2YcGcARs0fpF9T8I/bAjovDPqFWM96MfyJqXOqh4ztoj4/jwuhx3S6EgGz8W7Es8r5BB+vs/vKQKPP1TkcbBNs695/wUDZsGKq7SAAyg8JuAfzdQhI38dS9UZ1wy51WwCW9Dk8Ei9QJJEblB3UskGFYXHklY1aZh5rGLoMPFmghbwvPryDvuKVOz/HDr6tdMoB3n3/W32ypkLdK9i21veP4Lo6csbwNhnq+5Dc7Bn5uh/7NslFljoYKwiUIqgAL7MmcdXM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4289.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(2906002)(66476007)(8936002)(8676002)(66556008)(66946007)(5660300002)(2616005)(4326008)(7416002)(6512007)(6506007)(53546011)(86362001)(6666004)(508600001)(6486002)(31686004)(83380400001)(38100700002)(316002)(186003)(6916009)(26005)(36756003)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0JZYzFET2t1a2wzaHNBZUh1N3Vjang0cnZGT0JTSVFvcm1zYjdySldSc3B6?=
 =?utf-8?B?Wmc5Rm5lZFRJalZNbHQ2UzRDTmczdXU2bmtYdVB5Zml5UUxhNkl1cytEMnE5?=
 =?utf-8?B?UHRaVWhpS29CNFFrVmZGSWNYSUVBdjUrTHRIWVlQaUpha3VuMXRiZWEreFJi?=
 =?utf-8?B?QVFuSHRGd1FLbE9XNG12WmgrajFaVXp0aXJURnN1MWh0V2NFVlYzcmJoanla?=
 =?utf-8?B?NkRldHhDVTZRZCt5V1diRk54NDlFOXNqbjhicnNrNGczL1BGYnhDdGRGcE9j?=
 =?utf-8?B?MTVzZW40b203QlkzRHhneXJPSDV3VEV5Z0ZhcWlJY3lPYnE2UklIZTdqRXVF?=
 =?utf-8?B?NmloeG9td2ZyNEkxb0IrbTJXNXhKTGJpcGtNN1FrdXdZVUpmTFBleDJZVWI2?=
 =?utf-8?B?MEJzT2FRQ2VxYU1rN09kVHBKSVRWeGtxTFNhdzA5YXpLRXMzQmoyRUxwR3Qr?=
 =?utf-8?B?emk5R3c3blNUdzhQTHgva1Y0T2ZEbFRaSWgzL0RzK2tKWHVRZUtBMWdXbnYv?=
 =?utf-8?B?WTE2L1pCTk94a3M2cTJuank4QlVQTUZTNEpHbUVEL3JEclA5SUVaelVVMExv?=
 =?utf-8?B?TTlFQlRxdmhJNGFMajRSbXR3VTZEVmZlL05lcGxqNUZBNmw1QXlscVpvK2Zv?=
 =?utf-8?B?UVh1TlVLVHVlUUFlY0RxQU1ObUMyb01ldUJETS94WGYrb2RtYkFiWlVyQXVM?=
 =?utf-8?B?dkxOcWNtdjQ1S1o2UFoxeXk2aEdCM2RaNkpkMk1vQ2N2QnI4VitDQXVJMU5L?=
 =?utf-8?B?MTdpU0t0UmJYQ0ZwdGlyZCtzK2k0RG1lNklUUkJXZFdqaThmZktGUi9qSzlI?=
 =?utf-8?B?dFRETTFCYzVOaWM3ZktPREo0aEVPMWtiNWJzaFlVVVYwNVA2eXR2V1NybXpF?=
 =?utf-8?B?NVQ4NVZWZnRDYWd4Vkw0WXcvbTFydmxEY2l2aHFEUEpvUXJoZXdxYkRaeExR?=
 =?utf-8?B?QlhlaENKY29JcW13MHl6RmJ0MmxCcnBWdldjNS9XMXBtdUlZS1N3ZmN2eHU4?=
 =?utf-8?B?RVlRNStaUGhEY3dXNzg1bmo4YWNsamdrR1E0cE5YbittSmlVRnk0NWpPVmw3?=
 =?utf-8?B?OWJ0aXljdjFOSm9RTlV2NkkyZFIyWC82ekxiOCtuRUN6NmVrSW5rYklQZWJv?=
 =?utf-8?B?U0tXQ3lnTDcyc1VSVEFsZlJ0bnpCVjhJanYxNmdSam56QTFDMVFTM09DZ3d5?=
 =?utf-8?B?ZGp3T1FZc0tlSjhGajNIcTFkZWFCMXZUVVdQODkyZkJjbzU2YVEwSGMvMzN6?=
 =?utf-8?B?K3Z6ZGx5Zk1Tb09nZUxETFNxcDFsTzdwbVZpdGpWWE9nNnAvREFUN1RyYnh5?=
 =?utf-8?B?ZXJmWmhXMGNVTk1BeXJXdlB1V2pmU3pXY0xrNjVQUjdTZTU5aEhYQ0hXRjU0?=
 =?utf-8?B?MEliUTVwVE53TGNncVRJYUZZbCs1Um9rcEY0cHFFbjFGNUwybGJpYXpKdmhy?=
 =?utf-8?B?NFdqZGxuQXBDTVBDWUpNWGM3a2ZDcHA3NlViQ0pMaXN1cmhVK0EzTjBFbXFR?=
 =?utf-8?B?dWl3QnBTQ3VsT1hQQk1WcTBVOG55c3pEQUJIZGRjQ1pHY1dLdnh5dW8vWldx?=
 =?utf-8?B?KytLbWdMcU5OZmttKzJzbjdPT0tBbkIvMzREaVRZcUo3UnZmdjJ6cTlOV284?=
 =?utf-8?B?bnVCVnNCZ2JYUGF2V0ZYczlldlFRM00vZ2dLdXJjSVB3NStMcXI1U1l6RFZi?=
 =?utf-8?B?cU9kaFpkOWYzNy9UQ08xZHdqQnhzeEJ5R0RUY08rQkU2WWdhUEVkd1ZlcU8z?=
 =?utf-8?B?cHFGSko0eVV3Z3VQeUFiQnliLzFwN2YzWEFTakF2U25CU0FhWnpubENzeHBO?=
 =?utf-8?B?aEVqRHkxakltdUM0anZpWmNXcjZsZDNpWEpTcEJISmF1ampGVzE1L012MEl6?=
 =?utf-8?B?bzJHYms5eGJTWDg4UHN2UUl3WjBsWmZ0amNMdDdJa2g5VEpKT0N4YU1KNXha?=
 =?utf-8?B?NE9qVDBHZ3pMOC8wSHNza2lpUjcxSEo1dVYxNlRmQURDRlRjcEVISS9KWmNl?=
 =?utf-8?B?UGFJdU5jcTBHaGRidjZkbzdudjY4UnJTcWlSM29SQWc1OUFxV1kzc0RrbXpk?=
 =?utf-8?B?c2pLRFg3UFJGaWhmWjB5VVVtK0w3UXRZdis3aDBFbUtDN1NQaXNVdElqVWo4?=
 =?utf-8?B?Y0dkUDBoVkptbHlreEQvUGZTZm1OZjhqYlV4Z285WEFtMHBrVFd2UGE2Yy8v?=
 =?utf-8?Q?+D7V0eANCmwh0hXzcp51P5A=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a912fae-cc0c-418e-81eb-08d9e583d03c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4289.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 13:07:34.9863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IIdOzsLSmcfrM0HnZ2GONW9f/yzVg55R+nqJpbOOVaW8yZFsiBSypnJZ+Uk24i88F72SB4SYuD3R79E/jBzThg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3233
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/2022 5:47 PM, Mel Gorman wrote:
> On Fri, Jan 28, 2022 at 10:58:48AM +0530, Bharata B Rao wrote:
>> Hi,
>>
>> This patchset implements an adaptive algorithm for calculating the autonuma
>> scan period.
> 
> autonuma refers to the khugepaged-like approach to NUMA balancing that
> was later superceded by NUMA Balancing (NUMAB) and is generally reflected
> by the naming e.g. git grep -i autonuma and note how few references there
> are to autonuma versus numab or "NUMA balancing". I know MMTests still
> refers to AutoNUMA but mostly because at the time it was written,
> autoNUMA was what was being evaluated and I never updated the naming.

Thanks. Noted and will use appropriate terminologies next time onward.

> 
>> In the existing mechanism of scan period calculation,
>>
>> - scan period is derived from the per-thread stats.
>> - static threshold (NUMA_PERIOD_THRESHOLD) is used for changing the
>>   scan rate.
>>
>> In this new approach (Process Adaptive autoNUMA or PAN), we gather NUMA
>> fault stats at per-process level which allows for capturing the application
>> behaviour better. In addition, the algorithm learns and adjusts the scan
>> rate based on remote fault rate. By not sticking to a static threshold, the
>> algorithm can respond better to different workload behaviours.
>>
> 
> NUMA Balancing is concerned with threads (task) and an address space (mm)
> so basing the naming on Address Space rather than process may be more
> appropriate although I admit the acronym is not as snappy.

Sure, will think about more appropriate naming.

> 
>> Since the threads of a processes are already considered as a group,
>> we add a bunch of metrics to the task's mm to track the various
>> types of faults and derive the scan rate from them.
>>
> 
> Enumerate the types of faults and note how the per-thread and
> per-address-space metrics are related.

Sure will list the type of faults and describe the.

Per-address-space metrics are essentially aggregate of the existing per-thread
metrics. Unlike the existing task_numa_group mechanism, the threads are
implicitly/already considered part of the address space group (p->mm).

> 
>> The new per-process fault stats contribute only to the per-process
>> scan period calculation, while the existing per-thread stats continue
>> to contribute towards the numa_group stats which eventually
>> determine the thresholds for migrating memory and threads
>> across nodes.
>>
>> This patchset has been tested with a bunch of benchmarks on the
>> following system:
>>
> 
> Please include the comparisons of both the headline metrics and notes on
> the change in scan rates in the changelog of the patch. Not all people
> are access to Google drive and it is not guaranteed to remain forever.
> Similarly, the leader is not guaranteed to appear in the git history

Sure, noted.

> 
>> ------------------------------------------------------
>> % gain of PAN vs default (Avg of 3 runs)
>> ------------------------------------------------------
>> NAS-BT		-0.17
>> NAS-CG		+9.39
>> NAS-MG		+8.19
>> NAS-FT		+2.23
>> Hashjoin	+0.58
>> Graph500	+14.93
>> Pagerank	+0.37
> 
> 
> 
>> ------------------------------------------------------
>> 		Default		PAN		%diff
>> ------------------------------------------------------
>> 		NUMA hint faults(Total of 3 runs)
>> ------------------------------------------------------
>> NAS-BT		758282358	539850429	+29
>> NAS-CG		2179458823	1180301361	+46
>> NAS-MG		517641172	346066391	+33
>> NAS-FT		297044964	230033861	+23
>> Hashjoin	201684863	268436275	-33
>> Graph500	261808733	154338827	+41
>> Pagerank	217917818	211260310	+03
>> ------------------------------------------------------
>> 		Migrations(Total of 3 runs)
>> ------------------------------------------------------
>> NAS-BT		106888517	86482076	+19
>> NAS-CG		81191368	12859924	+84
>> NAS-MG		83927451	39651254	+53
>> NAS-FT		61807715	38934618	+37
>> Hashjoin	45406983	59828843	-32
>> Graph500	22798837	21560714	+05
>> Pagerank	59072135	44968673	+24
>> ------------------------------------------------------
>>
>> And here are some tests from a few microbenchmarks of mmtests suite.
>> (The results are trimmed a bit here, the complete results can
>> be viewed in the above mentioned link)
>>
>> Hackbench
>> ---------
>> hackbench-process-pipes
>>                            hackbench              hackbench
>>                              default                    pan
>> Min       256     23.5510 (   0.00%)     23.1900 (   1.53%)
>> Amean     256     24.4604 (   0.00%)     24.0353 *   1.74%*
>> Stddev    256      0.4420 (   0.00%)      0.7611 ( -72.18%)
>> CoeffVar  256      1.8072 (   0.00%)      3.1666 ( -75.22%)
>> Max       256     25.4930 (   0.00%)     30.5450 ( -19.82%)
>> BAmean-50 256     24.1074 (   0.00%)     23.6616 (   1.85%)
>> BAmean-95 256     24.4111 (   0.00%)     23.9308 (   1.97%)
>> BAmean-99 256     24.4499 (   0.00%)     23.9696 (   1.96%)
>>
>>                    hackbench   hackbench
>>                      default         pan
>> Duration User       25810.02    25158.93
>> Duration System    276322.70   271729.32
>> Duration Elapsed     2707.75     2671.33
>>
> 
>>                                       hackbench      hackbench
>>                                         default            pan
>> Ops NUMA alloc hit                1082415453.00  1088025994.00
>> Ops NUMA alloc miss                        0.00           0.00
>> Ops NUMA interleave hit                    0.00           0.00
>> Ops NUMA alloc local              1082415441.00  1088025974.00
>> Ops NUMA base-page range updates       33475.00      228900.00
>> Ops NUMA PTE updates                   33475.00      228900.00
>> Ops NUMA PMD updates                       0.00           0.00
>> Ops NUMA hint faults                   15758.00      222100.00
>> Ops NUMA hint local faults %           15371.00      214570.00
>> Ops NUMA hint local percent               97.54          96.61
>> Ops NUMA pages migrated                  235.00        4029.00
>> Ops AutoNUMA cost                         79.03        1112.18
>>
> 
> Hackbench processes are generally short-lived enough that NUMA balancing
> has a marginal impact. Interesting though that updates and hints were
> increased by a lot relatively speaking.

Yes, this increased AutoNUMA cost seen mostly with these micro benchmarks
are not seen typically with the other benchmarks that we have listed at
the beginning which we believe contributes to the gain that those
benchmarks see.

The algorithm tries aggressively to learn the application behaviour
at the beginning and short-lived tasks will see more scanning than
default.

Having said that, we need to investigate and check why some of these
micro benchmarks incur higher autonuma cost.

> 
>> Netperf-RR
>> ----------
>> netperf-udp-rr
>>                            netperf                netperf
>>                         rr-default                 rr-pan
>> Min       1   104915.69 (   0.00%)   104505.71 (  -0.39%)
>> Hmean     1   105865.46 (   0.00%)   105899.22 *   0.03%*
>> Stddev    1      528.45 (   0.00%)      881.92 ( -66.89%)
>> CoeffVar  1        0.50 (   0.00%)        0.83 ( -66.83%)
>> Max       1   106410.28 (   0.00%)   107196.52 (   0.74%)
>> BHmean-50 1   106232.53 (   0.00%)   106568.26 (   0.32%)
>> BHmean-95 1   105972.05 (   0.00%)   106056.35 (   0.08%)
>> BHmean-99 1   105972.05 (   0.00%)   106056.35 (   0.08%)
>>
>>                      netperf     netperf
>>                   rr-default      rr-pan
>> Duration User          11.20       10.74
>> Duration System       202.40      201.32
>> Duration Elapsed      303.09      303.08
>>
>>                                         netperf        netperf
>>                                      rr-default         rr-pan
>> Ops NUMA alloc hit                    183999.00      183853.00
>> Ops NUMA alloc miss                        0.00           0.00
>> Ops NUMA interleave hit                    0.00           0.00
>> Ops NUMA alloc local                  183999.00      183853.00
>> Ops NUMA base-page range updates           0.00       24370.00
>> Ops NUMA PTE updates                       0.00       24370.00
>> Ops NUMA PMD updates                       0.00           0.00
>> Ops NUMA hint faults                     539.00       24470.00
>> Ops NUMA hint local faults %             539.00       24447.00
>> Ops NUMA hint local percent              100.00          99.91
>> Ops NUMA pages migrated                    0.00          23.00
>> Ops AutoNUMA cost                          2.69         122.52
>>
> 
> Netperf these days usually runs on the same node so NUMA balancing
> triggers very rarely.

But we still see increase in the hint faults, need to investigate this.


>>                 autonumabenchautonumabench
>>                      default         pan
>> Duration User       94363.43    94436.71
>> Duration System     81671.72    81408.53
>> Duration Elapsed     1676.81     1647.99
>>
>>                                   autonumabench  autonumabench
>>                                         default            pan
>> Ops NUMA alloc hit                 539544115.00   539522029.00
>> Ops NUMA alloc miss                        0.00           0.00
>> Ops NUMA interleave hit                    0.00           0.00
>> Ops NUMA alloc local               279025768.00   281735736.00
>> Ops NUMA base-page range updates    69695169.00    84767502.00
>> Ops NUMA PTE updates                69695169.00    84767502.00
>> Ops NUMA PMD updates                       0.00           0.00
>> Ops NUMA hint faults                69691818.00    87895044.00
>> Ops NUMA hint local faults %        56565519.00    65819747.00
>> Ops NUMA hint local percent               81.17          74.88
>> Ops NUMA pages migrated              5950362.00     8310169.00
>> Ops AutoNUMA cost                     349060.01      440226.49
>>
> 
> More hinting faults and migrations. Not clear which sub-test exactly but
> most likely NUMA02.

I will have to run them separately and check.

Regards,
Bharata.
