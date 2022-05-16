Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F025282A8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240282AbiEPKxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiEPKw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:52:58 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D197424593
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:52:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efjNpLRlhTxKgKJEPMFj3UrEJgqRD/lCJ2TUl8NSVlAp+Weqn/hZMIj+ubQAGEjI5eSeqhv3hJOi61Xdb6B2j7I+ceRHtiL41c4SZwON8Tvj6pNO+iRSoS8aSvHo/5EfN27nI0wuCt6CxNr9yEd99jgeqbSoU+sjZDnexuzujL14vniAJm7xZH355vmcrK25V0k5sfikCF4V3mS4TpIaMCkmcjJXD+Jh6Rnahi4BfFbBgzlAQk1BnQNASGmuqjixjofxEF/J9+Gkc+Vv5QPgV3IWlAQ1ToA5cgmC1ySIDCnI7eEoi3Cp1wlvHmCYxgBVMSZFv7WFlHY6S58nqY6ZMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fW8bHyuMx7YqhxJ3Gsq7HxpfAohGZXmL7QOXi8lqSCw=;
 b=LzA8JH4h+/DlrJfUgnCbiTOpZcyp/V/GeCLuqjPqIMLIcXsckzVfx+KmvHzwog2hl9lvfM6lOw+zu2XxuSnakiQCDp8XlEwHBLSwg7uLX4vzIuO/+YF6JRX8FiVvjV7JHqHlu2gZURqOLRmyTZeYqh69lum56EcxedkeLtnr9Cvg3+BZFcITyjNinmHgZj/4UrMdPjY1Q8swmVruZ1XIqEwytNU0fPYjHlMEdsXGqJHD1JCAjr7DBHsnWwusg/nS4377YhtlE1iQIfsJrAMuz2q/PCohEI1Ll/QReW0ZlO5tfTihGAqGmJHHJzDJ4Pokfn8IOSWMSF9L6rcWbJK0+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fW8bHyuMx7YqhxJ3Gsq7HxpfAohGZXmL7QOXi8lqSCw=;
 b=Mk9U/p9hejd1BQ9qpJbIgYbKJJuWg9bPZTQ189XLxdLyajX9dec3cvg66vPE9X5gEjlq9lgE2PgPagw3bUEtLKftQT+ASBvGmtmHVg5sHxTR4ioZ1/T+ForyK9xG220AOHc2sFsDd/KEqyrZQ5ImJGzyouWEhA0qJ2L1yXtT9tU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by DM5PR12MB2501.namprd12.prod.outlook.com (2603:10b6:4:b4::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Mon, 16 May
 2022 10:52:51 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::d22:1b6d:6231:e435]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::d22:1b6d:6231:e435%7]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 10:52:51 +0000
Message-ID: <adfb65ab-8621-b6c0-bb77-39c9be3486b7@amd.com>
Date:   Mon, 16 May 2022 16:22:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3] sched/fair: Introduce SIS_UTIL to search idle CPU
 based on sum of util_avg
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Barry Song <21cnbao@gmail.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Len Brown <len.brown@intel.com>,
        Ben Segall <bsegall@google.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org,
        Daniel Bristot de Oliveira <bristot@redhat.com>
References: <20220428182442.659294-1-yu.c.chen@intel.com>
 <ed985eb5-abc7-34f4-7a10-e3a08800b324@amd.com>
 <20220514105544.GA20541@chenyu5-mobl1>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20220514105544.GA20541@chenyu5-mobl1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0014.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::19) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 556e3ca0-3cef-4d21-1a59-08da372a38c4
X-MS-TrafficTypeDiagnostic: DM5PR12MB2501:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB25018F7C8B819C13C216873298CF9@DM5PR12MB2501.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ADh2o/GsG4W3D84y9OQpjxZ6EuY/Zjn8bKwO9VSyIL7zVti/BxuiqPum71HtuzRtrCdS5xC4zFC+JPecLYLWNS47OL3HflWxbX3hTUCsSjcmne+3dP/zDZqetr+1NM0bsfoEEl6jDs+xFd6FBQ4vYeljk3u9nub8ZLsyXvwuAj3XkJ9Tdauy0HyU6IRFQnRh0pTONe4U0GwMlhzxjUe4iKzgUS9boQRjXJaMq2IgFAnLEqX3lSTku3HZT4zW3HFP5BnFiGkIio/ar4uutyxHs+mEFyVKVMqPcMGhNRee3ZXo0b0J4VpXNYVR+O90FlyVXBga8BuNpPOcoMByJDxHZ3gvsnht5RlTlB5QRlLF7WaUC2Sdqxw4Qq8lTckxzwepWh8/4/TP9Lh3HnYPvSowjV9IgS4SVKLQSeZL7aVxmQfwf5pCV6aNijR0RnnnUBPfEPjAie4pWVxRZ1paxGNXt1Cy7c7ZqjiTytFVoFqSye70a/+JrvpajYdU1F2UL+J49hH0AQIJZoGo5adaRABuK0C8uWKRKLgb6y4kYEtMa25SmXVTV+Uea/sK5JRFIMF2S2Ajc1YH2Zdk/5BxiJrEBLdx//CvsPnXGKCKqnnggnbSmCruZKehSUS8P2/1QLbUkg/jlrg78q/KPwaf8Lark8G/+SpHRKvVjL4eBR3S79dtdiJYOvqHrrKQmeKU53LYnIuB3ky6Ic2ip9DWhH7CgqWoLjA7GzgZoBjxzN7lNc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(8676002)(53546011)(66556008)(6506007)(66476007)(508600001)(8936002)(5660300002)(83380400001)(6486002)(6666004)(2906002)(38100700002)(316002)(4326008)(6512007)(36756003)(54906003)(26005)(31696002)(6916009)(31686004)(7416002)(66946007)(30864003)(2616005)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXRrS3VBWERTck5PeTFoNmpMaWQyRVR0QTlZN2VKZFRRV3MwdWFkU0JXT0lR?=
 =?utf-8?B?Wm5JUm5SWGdVVTVlS2RNUVpZY241dU1vZjNpRGpZbE5IS244Z1dWSjFDNGRB?=
 =?utf-8?B?V0Y5L2tzMXlLT1hHWUFsQ0p3SWNOWklhUnpZRGdRNHNjczFaaDVZL1pGcTR2?=
 =?utf-8?B?U0NEb1NSdXl0Vm1IeVNEb29IbCthb1Vqa0xPcmRxSFBzTFFPbDdlQlVoQzNH?=
 =?utf-8?B?NktaOUJvVEN4cDJsY3g2YXI3MkxFS0ZSV2VCR2t2RnFSN3dMTVFzMm5Palkx?=
 =?utf-8?B?dWppSm4zMzhhclJ5cFc0ZFgydER0MjZHMmpkMWlOWWVxWmlqWWMwdWNhQ1Nm?=
 =?utf-8?B?anJHQVpjclZzNCt4L1hxOG00bGZuOEdzcE0wSGRKNW95UTM4aS9YN3RWa1Ev?=
 =?utf-8?B?V2RJcTczdlhtNGZXYmNWeXBaT0FEWjJOU2NzZFRkN1U5R3FreDJ4ODRObEdR?=
 =?utf-8?B?UlR5OUVsK0t0UGlQcnJWa09PWDFNQldRZnFlS3pWQ2k5ckN2SE1IMWNTdm8v?=
 =?utf-8?B?a3NmaFlQRG01RmdQcUlXcDRVV3Ixck1lVHEyVXFnV1NOZ0ZXZnovajlQeXpl?=
 =?utf-8?B?WU5pRDVFR09YTGxEeW43ZWM0VERDN1VaYW9YOENtUU81NGtuTUR1NWZJM3Vr?=
 =?utf-8?B?MllBMTh0ZitxNDN2WnhkeUxFeXcwN2o4Wm9odGV1NCt1QVVGUWRCbHVrUy9F?=
 =?utf-8?B?Qk5RQnRUd29mSWdDZHVuanNoU0lQbW1qTENMNzdxcTdVQnRlbnB3K29aQUVa?=
 =?utf-8?B?Y3FRak4vNWNnTllidFRmNitDV0hJMWF4eWNBMFZCU1dpUmhuMmZURk45eXd0?=
 =?utf-8?B?ek83SWtxZWdmcC9HL01BTWphTUN4R2hQVlF1enFrQUt0MWlPZTNqTDdTbkMx?=
 =?utf-8?B?cEMvUG5SWHN1LzhucjA0Z2Z0SjZiOXRvUy94NXhHWmJkSTY2OW9pOWUyVThl?=
 =?utf-8?B?M3Z0WVhYK2FLeXJQYUg5aDZ3blRIazZkOVFrR1dhdzA5T0Vndno3MmxERkl1?=
 =?utf-8?B?YVVPRFcrQjI2YjVVNnBCakV5NmorM3RsWFE1RGptSmgvaXdqdjluaUkwVmZN?=
 =?utf-8?B?amhoZWxjdDJWSVdXME54VWdBaFA2RmRYdGtOc2dxYUpkWW5EWFdLVmorUnVS?=
 =?utf-8?B?SjlyTlMwQXFuOWtUYnZiemZmNEE3MVA1d3g0YUIvcmFha3BBZG5kOFhMdmdz?=
 =?utf-8?B?MmFJd3ViSVh5SWgyUGxZdk5FM1lPcmhINzY3S0NlTlpONEY2OEovd1I4dkVB?=
 =?utf-8?B?TCtoeTg0YjRqamw0N2ZUcGlPVXNrM1JkYklqKzNTT0QxT2xXUEZCN29nQk1l?=
 =?utf-8?B?Z2JucEJPZmx3NnZjQWUyTndwVEZMVjNyNVdEWW54TGlBbUNHbnZ3cE5IN0Vj?=
 =?utf-8?B?cHdkWDk3L3puSW03cHU1RVBrQ0tWZC9LZnFCZG9zUENwMjVIZUh6eWlYY1lk?=
 =?utf-8?B?aTRHY011YlJnR0dzSGFqV1k0SUFLY1lxSTh1dVlOcUYyWkQwOGxNM2luWGJU?=
 =?utf-8?B?dFpFdno0SHZmdHU0ZEJWS3pOaHEwbllaSklpL3RMenFaeEFNU3hRZ2l2Mk1N?=
 =?utf-8?B?cndXZXZubjBlU1hDeDZWVHRvMXd1d3Z1UkhOdnkxOUVoYnhTR1RNSHpja1hM?=
 =?utf-8?B?QVhTK3pVd2MyLzRPQVkxcUtLTm9kL053eDZFVHZQVSsxRGRQTE5FbW1SZlpP?=
 =?utf-8?B?OE8yUFRQSkRJd0VKN2hOTjN0TytiNkFuaDQ2ZUhVRExlVEt1OG5Kd1RGVGsw?=
 =?utf-8?B?QXFIRVJjeWpEb3lpSU9HemZUUFRFZ3FoZUlNbTJ1RHBVQWVQczQvdHVxNnQ5?=
 =?utf-8?B?cW12N3hUU0VMQTByaENJZVRDenpPRmc5ZFBmenF2bmhtbjhMdFpHWTJTU1ZP?=
 =?utf-8?B?cUtKZXRmNVlYdXFVMU5MMVhiemJma1RJZDQzWGZZV0FkSCtrMjREdisvbHhl?=
 =?utf-8?B?OExoeGlEL1k4NC9hbFlLODdzaXA3Qys4MTM4VEZLZmZmMHZYQ29nb08zcVZQ?=
 =?utf-8?B?dk02WGUySlRoSUhWTnJ1cFBSQ1poZWllSGVFbEZPM3FCZmdNS0Yrd2p6bXlp?=
 =?utf-8?B?TzMwOEdsTG1ZNmxNa3VvVXlFZmVleVBtSmVhZDNLNEcrakN1bWJnOEtVYzNC?=
 =?utf-8?B?bklFdFA1QjUxR3pHNTJaYTFWbWdoaWhFRWFJWldwTDF0WGVGanRsc0hZUjVo?=
 =?utf-8?B?c3RHTVY3SXcybEJaL1JFMXVMa3Q5N0lqQUxVeTNGd0pqQkJUNm5TWUxWMkpQ?=
 =?utf-8?B?V1N1dGRSUTY3OUtjQ205WWg4UmV0SjIydEg5RW5Fdk1STWthbUREekdqMmJa?=
 =?utf-8?B?Mm00c0JLVFUweENiZWJKNTNjLzhQTU1lWWdEZUt6WTE1aUhkQncwUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 556e3ca0-3cef-4d21-1a59-08da372a38c4
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 10:52:51.4220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V2KKgZMS2OXlecpwr7o415lhw6IWUYb6VkkxcxBn99Rbz54RJGfEg7kCvV/pdQESimxbdyjiNCpCpAPlOvAOZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2501
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chenyu,

Thank you taking a look at the results.

On 5/14/2022 4:25 PM, Chen Yu wrote:
> [..snip..]
> May I know if in all NPS mode, all LLC domains have 16 CPUs?
Yes. The number of CPUs in LLC domain is always 16 irrespective of the NPS mode.
>> Following is the NUMA configuration for each NPS mode on the system:
>>
>> NPS1: Each socket is a NUMA node.
>>     Total 2 NUMA nodes in the dual socket machine.
>>
>>     Node 0: 0-63,   128-191
>>     Node 1: 64-127, 192-255
>>
>> NPS2: Each socket is further logically divided into 2 NUMA regions.
>>     Total 4 NUMA nodes exist over 2 socket.
>>    
>>     Node 0: 0-31,   128-159
>>     Node 1: 32-63,  160-191
>>     Node 2: 64-95,  192-223
>>     Node 3: 96-127, 223-255
>>
>> NPS4: Each socket is logically divided into 4 NUMA regions.
>>     Total 8 NUMA nodes exist over 2 socket.
>>    
>>     Node 0: 0-15,    128-143
>>     Node 1: 16-31,   144-159
>>     Node 2: 32-47,   160-175
>>     Node 3: 48-63,   176-191
>>     Node 4: 64-79,   192-207
>>     Node 5: 80-95,   208-223
>>     Node 6: 96-111,  223-231
>>     Node 7: 112-127, 232-255
>>
>> Kernel versions:
>> - tip:      5.18-rc1 tip sched/core
>> - SIS_UTIL:    5.18-rc1 tip sched/core + this patch
>>
>> When we began testing, tip was at:
>>
>> commit: a658353167bf "sched/fair: Revise comment about lb decision matrix"
>>
>> Following are the results from the benchmark:
>>
>> * - Data points of concern
>>
>> ~~~~~~~~~
>> hackbench
>> ~~~~~~~~~
>>
>> NPS1
>>
>> Test:                   tip                     SIS_UTIL
>>  1-groups:         4.64 (0.00 pct)         4.70 (-1.29 pct)
>>  2-groups:         5.38 (0.00 pct)         5.45 (-1.30 pct)
>>  4-groups:         6.15 (0.00 pct)         6.10 (0.81 pct)
>>  8-groups:         7.42 (0.00 pct)         7.42 (0.00 pct)
>> 16-groups:        10.70 (0.00 pct)        11.69 (-9.25 pct)  *
>>
>> NPS2
>>
>> Test:                   tip                     SIS_UTIL
>>  1-groups:         4.70 (0.00 pct)         4.70 (0.00 pct)
>>  2-groups:         5.45 (0.00 pct)         5.46 (-0.18 pct)
>>  4-groups:         6.13 (0.00 pct)         6.05 (1.30 pct)
>>  8-groups:         7.30 (0.00 pct)         7.05 (3.42 pct)
>> 16-groups:        10.30 (0.00 pct)        10.12 (1.74 pct)
>>
>> NPS4
>>
>> Test:                   tip                     SIS_UTIL
>>  1-groups:         4.60 (0.00 pct)         4.75 (-3.26 pct)  *
>>  2-groups:         5.41 (0.00 pct)         5.42 (-0.18 pct)
>>  4-groups:         6.12 (0.00 pct)         6.00 (1.96 pct)
>>  8-groups:         7.22 (0.00 pct)         7.10 (1.66 pct)
>> 16-groups:        10.24 (0.00 pct)        10.11 (1.26 pct)
>>
>> ~~~~~~~~
>> schbench
>> ~~~~~~~~
>>
>> NPS 1
>>
>> #workers:   tip                     SIS_UTIL
>>   1:      29.00 (0.00 pct)        21.00 (27.58 pct)
>>   2:      28.00 (0.00 pct)        28.00 (0.00 pct)
>>   4:      31.50 (0.00 pct)        31.00 (1.58 pct)
>>   8:      42.00 (0.00 pct)        39.00 (7.14 pct)
>>  16:      56.50 (0.00 pct)        54.50 (3.53 pct)
>>  32:      94.50 (0.00 pct)        94.00 (0.52 pct)
>>  64:     176.00 (0.00 pct)       175.00 (0.56 pct)
>> 128:     404.00 (0.00 pct)       394.00 (2.47 pct)
>> 256:     869.00 (0.00 pct)       863.00 (0.69 pct)
>> 512:     58432.00 (0.00 pct)     55424.00 (5.14 pct)
>>
>> NPS2
>>
>> #workers:      tip                     SIS_UTIL
>>   1:      26.50 (0.00 pct)        25.00 (5.66 pct)
>>   2:      26.50 (0.00 pct)        25.50 (3.77 pct)
>>   4:      34.50 (0.00 pct)        34.00 (1.44 pct)
>>   8:      45.00 (0.00 pct)        46.00 (-2.22 pct)
>>  16:      56.50 (0.00 pct)        60.50 (-7.07 pct)        *
>>  32:      95.50 (0.00 pct)        93.00 (2.61 pct)
>>  64:     179.00 (0.00 pct)       179.00 (0.00 pct)
>> 128:     369.00 (0.00 pct)       376.00 (-1.89 pct)
>> 256:     898.00 (0.00 pct)       903.00 (-0.55 pct)
>> 512:     56256.00 (0.00 pct)     57088.00 (-1.47 pct)
>>
>> NPS4
>>
>> #workers:    tip                     SIS_UTIL
>>   1:      25.00 (0.00 pct)        21.00 (16.00 pct)
>>   2:      28.00 (0.00 pct)        24.00 (14.28 pct)
>>   4:      29.50 (0.00 pct)        29.50 (0.00 pct)
>>   8:      41.00 (0.00 pct)        37.50 (8.53 pct)
>>  16:      65.50 (0.00 pct)        64.00 (2.29 pct)
>>  32:      93.00 (0.00 pct)        94.50 (-1.61 pct)
>>  64:     170.50 (0.00 pct)       175.50 (-2.93 pct)
>> 128:     377.00 (0.00 pct)       368.50 (2.25 pct)
>> 256:     867.00 (0.00 pct)       902.00 (-4.03 pct)
>> 512:     58048.00 (0.00 pct)     55488.00 (4.41 pct)
>>
>> ~~~~~~
>> tbench
>> ~~~~~~
>>
>> NPS 1
>>
>> Clients:     tip                     SIS_UTIL
>>     1    443.31 (0.00 pct)       456.19 (2.90 pct)
>>     2    877.32 (0.00 pct)       875.24 (-0.23 pct)
>>     4    1665.11 (0.00 pct)      1647.31 (-1.06 pct)
>>     8    3016.68 (0.00 pct)      2993.23 (-0.77 pct)
>>    16    5374.30 (0.00 pct)      5246.93 (-2.36 pct)
>>    32    8763.86 (0.00 pct)      7878.18 (-10.10 pct)     *
>>    64    15786.93 (0.00 pct)     12958.47 (-17.91 pct)    *
>>   128    26826.08 (0.00 pct)     26741.14 (-0.31 pct)
>>   256    24207.35 (0.00 pct)     52041.89 (114.98 pct)
>>   512    51740.58 (0.00 pct)     52084.44 (0.66 pct)
>>  1024    51177.82 (0.00 pct)     53126.29 (3.80 pct)
>>
>> NPS 2
>>
>> Clients:     tip                     SIS_UTIL
>>     1    449.49 (0.00 pct)       447.96 (-0.34 pct)
>>     2    867.28 (0.00 pct)       869.52 (0.25 pct)
>>     4    1643.60 (0.00 pct)      1625.91 (-1.07 pct)
>>     8    3047.35 (0.00 pct)      2952.82 (-3.10 pct)
>>    16    5340.77 (0.00 pct)      5251.41 (-1.67 pct)
>>    32    10536.85 (0.00 pct)     8843.49 (-16.07 pct)     *
>>    64    16543.23 (0.00 pct)     14265.35 (-13.76 pct)    *
>>   128    26400.40 (0.00 pct)     25595.42 (-3.04 pct)
>>   256    23436.75 (0.00 pct)     47090.03 (100.92 pct)
>>   512    50902.60 (0.00 pct)     50036.58 (-1.70 pct)
>>  1024    50216.10 (0.00 pct)     50639.74 (0.84 pct)
>>
>> NPS 4
>>
>> Clients:     tip                     SIS_UTIL
>>     1    443.82 (0.00 pct)       459.93 (3.62 pct)
>>     2    849.14 (0.00 pct)       882.17 (3.88 pct)
>>     4    1603.26 (0.00 pct)      1629.64 (1.64 pct)
>>     8    2972.37 (0.00 pct)      3003.09 (1.03 pct)
>>    16    5277.13 (0.00 pct)      5234.07 (-0.81 pct)
>>    32    9744.73 (0.00 pct)      9347.90 (-4.07 pct)      *
>>    64    15854.80 (0.00 pct)     14180.27 (-10.56 pct)    *
>>   128    26116.97 (0.00 pct)     24597.45 (-5.81 pct)     *
>>   256    22403.25 (0.00 pct)     47385.09 (111.50 pct)
>>   512    48317.20 (0.00 pct)     49781.02 (3.02 pct)
>>  1024    50445.41 (0.00 pct)     51607.53 (2.30 pct)
>>
>> ~~~~~~
>> Stream
>> ~~~~~~
>>
>> - 10 runs
>>
>> NPS1
>>
>>               tip                     SIS_UTIL
>>  Copy:   189113.11 (0.00 pct)    188490.27 (-0.32 pct)
>> Scale:   201190.61 (0.00 pct)    204526.15 (1.65 pct)
>>   Add:   232654.21 (0.00 pct)    234948.01 (0.98 pct)
>> Triad:   226583.57 (0.00 pct)    228844.43 (0.99 pct)
>>
>> NPS2
>>
>> Test:         tip                     SIS_UTIL
>>  Copy:   155347.14 (0.00 pct)    169386.29 (9.03 pct)
>> Scale:   191701.53 (0.00 pct)    196110.51 (2.29 pct)
>>   Add:   210013.97 (0.00 pct)    221088.45 (5.27 pct)
>> Triad:   207602.00 (0.00 pct)    218072.52 (5.04 pct)
>>
>> NPS4
>>
>> Test:         tip                     SIS_UTIL
>>  Copy:   136421.15 (0.00 pct)    140894.11 (3.27 pct)
>> Scale:   191217.59 (0.00 pct)    190554.17 (-0.34 pct)
>>   Add:   189229.52 (0.00 pct)    190871.88 (0.86 pct)
>> Triad:   188052.99 (0.00 pct)    188417.63 (0.19 pct)
>>
>> - 100 runs
>>
>> NPS1
>>
>> Test:       tip                     SIS_UTIL
>>  Copy:   244693.32 (0.00 pct)    232328.05 (-5.05 pct)
>> Scale:   221874.99 (0.00 pct)    216858.39 (-2.26 pct)
>>   Add:   268363.89 (0.00 pct)    265449.16 (-1.08 pct)
>> Triad:   260945.24 (0.00 pct)    252240.56 (-3.33 pct)
>>
>> NPS2
>>
>> Test:       tip                     SIS_UTIL
>>  Copy:   211262.00 (0.00 pct)    225240.03 (6.61 pct)
>> Scale:   222493.34 (0.00 pct)    219094.65 (-1.52 pct)
>>   Add:   280277.17 (0.00 pct)    275677.73 (-1.64 pct)
>> Triad:   265860.49 (0.00 pct)    262584.22 (-1.23 pct)
>>
>> NPS4
>>
>> Test:       tip                     SIS_UTIL
>>  Copy:   250171.40 (0.00 pct)    230983.60 (-7.66 pct)
>> Scale:   222293.56 (0.00 pct)    215984.34 (-2.83 pct)
>>   Add:   279222.16 (0.00 pct)    270402.64 (-3.15 pct)
>> Triad:   262013.92 (0.00 pct)    254820.60 (-2.74 pct)
>>
>> ~~~~~~~~~~~~
>> ycsb-mongodb
>> ~~~~~~~~~~~~
>>
>> NPS1
>>
>> sched-tip:      303718.33 (var: 1.31)
>> SIS_UTIL:       303529.33 (var: 0.67)    (-0.06%)
>>
>> NPS2
>>
>> sched-tip:      304536.33 (var: 2.46)
>> SIS_UTIL:       303730.33 (var: 1.57)    (-0.26%)
>>
>> NPS4
>>
>> sched-tip:      301192.33 (var: 1.81)
>> SIS_UTIL:       300101.33 (var: 0.35)   (-0.36%)
>>
>> ~~~~~~~~~~~~~~~~~~
>>
>> Notes:
>>
>> - There seems to be some noticeable regression for hackbench
>>   with 16 groups in NPS1 mode.
> Did the hackbench use the default fd number(20) in every group? If
> this is the case, then there are 16 * 20 * 2 = 640 threads in the
> system. I thought this should be overloaded, either in SIS_PROP or
> SIS_UTIL, the search depth might be 4 and 0 respectively. And it
> is also very likely the SIS_PROP will not find an idle CPU after
> searching for 4 CPUs. So in theory there should be not much performance
> difference with vs without the patch applied. But if the fd number is set
> to a smaller one, the regression could be explained as you mentioned,
> SIS_PROP search more aggressively.
Yes, I'm using fd number(20). The logs from hackbench run show that it is
indeed running 640 threads with 16 groups:

# Running 'sched/messaging' benchmark:
# 20 sender and receiver threads per group
# 16 groups == 640 threads run

This is indeed counterintuitive and I don't have
a good explanation for this other than that SIS_PROP
probably finding slightly greater success at finding
an idle CPU even in this overloaded environment.

I've ran the benchmark in two sets of 3 runs rebooting
in between on each kernel version:

- tip

Test:                   tip-r0                  tip-r1                  tip-r2
 1-groups:         4.64 (0.00 pct)         4.90 (-5.60 pct)        4.99 (-7.54 pct)
 2-groups:         5.54 (0.00 pct)         5.56 (-0.36 pct)        5.58 (-0.72 pct)
 4-groups:         6.24 (0.00 pct)         6.18 (0.96 pct)         6.20 (0.64 pct)
 8-groups:         7.54 (0.00 pct)         7.50 (0.53 pct)         7.54 (0.00 pct)
16-groups:        10.85 (0.00 pct)        11.17 (-2.94 pct)       10.91 (-0.55 pct)

Test:                   tip-r3                  tip-r4                  tip-r5
 1-groups:         4.68 (0.00 pct)         4.97 (-6.19 pct)        4.98 (-6.41 pct)
 2-groups:         5.60 (0.00 pct)         5.62 (-0.35 pct)        5.66 (-1.07 pct)
 4-groups:         6.24 (0.00 pct)         6.23 (0.16 pct)         6.24 (0.00 pct)
 8-groups:         7.54 (0.00 pct)         7.50 (0.53 pct)         7.46 (1.06 pct)
16-groups:        10.81 (0.00 pct)        10.84 (-0.27 pct)       10.81 (0.00 pct)

- SIS_UTIL


Test:                SIS_UTIL-r0              SIS_UTIL-r1             SIS_UTIL-r2
 1-groups:         4.68 (0.00 pct)         5.03 (-7.47 pct)        4.96 (-5.98 pct)
 2-groups:         5.45 (0.00 pct)         5.48 (-0.55 pct)        5.50 (-0.91 pct)
 4-groups:         6.10 (0.00 pct)         6.07 (0.49 pct)         6.14 (-0.65 pct)
 8-groups:         7.52 (0.00 pct)         7.51 (0.13 pct)         7.52 (0.00 pct)
16-groups:        11.63 (0.00 pct)        11.48 (1.28 pct)        11.51 (1.03 pct)

Test:                SIS_UTIL-r3              SIS_UTIL-r4             SIS_UTIL-r5
 1-groups:         4.80 (0.00 pct)         5.00 (-4.16 pct)        5.06 (-5.41 pct)
 2-groups:         5.51 (0.00 pct)         5.58 (-1.27 pct)        5.58 (-1.27 pct)
 4-groups:         6.14 (0.00 pct)         6.11 (0.48 pct)         6.06 (1.30 pct)
 8-groups:         7.35 (0.00 pct)         7.38 (-0.40 pct)        7.40 (-0.68 pct)
16-groups:        11.03 (0.00 pct)        11.29 (-2.35 pct)       11.14 (-0.99 pct)

- Comparing the best and bad data points for 16-groups with each
kernel version:

Test:                   tip-good             SIS_UTIL-good
 1-groups:         4.68 (0.00 pct)         4.80 (-2.56 pct)
 2-groups:         5.60 (0.00 pct)         5.51 (1.60 pct)
 4-groups:         6.24 (0.00 pct)         6.14 (1.60 pct)
 8-groups:         7.54 (0.00 pct)         7.35 (2.51 pct)
16-groups:        10.81 (0.00 pct)        11.03 (-2.03 pct)

Test:                   tip-good             SIS_UTIL-bad
 1-groups:         4.68 (0.00 pct)         4.68 (0.00 pct)
 2-groups:         5.60 (0.00 pct)         5.45 (2.67 pct)
 4-groups:         6.24 (0.00 pct)         6.10 (2.24 pct)
 8-groups:         7.54 (0.00 pct)         7.52 (0.26 pct)
16-groups:        10.81 (0.00 pct)        11.63 (-7.58 pct)

Test:                   tip-bad             SIS_UTIL-good
 1-groups:         4.90 (0.00 pct)         4.80 (2.04 pct)
 2-groups:         5.56 (0.00 pct)         5.51 (0.89 pct)
 4-groups:         6.18 (0.00 pct)         6.14 (0.64 pct)
 8-groups:         7.50 (0.00 pct)         7.35 (2.00 pct)
16-groups:        11.17 (0.00 pct)        11.03 (1.25 pct)

Test:                   tip-bad             SIS_UTIL-bad
 1-groups:         4.90 (0.00 pct)         4.68 (4.48 pct)
 2-groups:         5.56 (0.00 pct)         5.45 (1.97 pct)
 4-groups:         6.18 (0.00 pct)         6.10 (1.29 pct)
 8-groups:         7.50 (0.00 pct)         7.52 (-0.26 pct)
16-groups:        11.17 (0.00 pct)        11.63 (-4.11 pct)

Hackbench consistently reports > 11 for 16-group
case with SIS_UTIL however only once with SIS_PROP

>> - There seems to be regression in tbench for case with number
>>   of workers in range 32-128 (12.5% loaded to 50% loaded)
>> - tbench reaches saturation early when system is fully loaded
>>
>> This probably show that the strategy in the initial v1 RFC
>> seems to work better with our LLC where number of CPUs per LLC
>> is low compared to systems with unified LLC. Given this is
>> showing great results for unified LLC, maybe SIS_PROP and SIS_UTIL
>> can be enabled based on the the size of LLC.
>>
> Yes, SIS_PROP searches more aggressively, but we attempts to replace
> SIS_PROP with a more accurate policy.
>>> [..snip..]
>>>
>>> [3]
>>> Prateek mentioned that we should scan aggressively in an LLC domain
>>> with 16 CPUs. Because the cost to search for an idle one among 16 CPUs is
>>> negligible. The current patch aims to propose a generic solution and only
>>> considers the util_avg. A follow-up change could enhance the scan policy
>>> to adjust the scan_percent according to the CPU number in LLC.
>> Following are some additional numbers I would like to share comparing SIS_PROP and
>> SIS_UTIL:
>>
> Nice analysis.
>> o Hackbench with 1 group
>>
>> With 1 group, following are the chances of SIS_PROP
>> and SIS_UTIL finding an idle CPU when an idle CPU
>> exists in LLC:
>>
>> +-----------------+---------------------------+---------------------------+--------+
>> | Idle CPU in LLC | SIS_PROP able to find CPU | SIS_UTIL able to find CPU | Count  |
>> +-----------------+---------------------------+---------------------------+--------+
>> |        1        |             0             |             0             | 66444  |
>> |        1        |             0             |             1             | 34153  |
>> |        1        |             1             |             0             | 57204  |
>> |        1        |             1             |             1             | 119263 |
>> +-----------------+---------------------------+---------------------------+--------+
>>
> So SIS_PROP searches more, and get higher chance to find an idle CPU in a LLC with
> 16 CPUs.
Yes!
>> SIS_PROP vs no SIS_PROP CPU search stats:
>>
>> Total time without SIS_PROP: 90653653
>> Total time with SIS_PROP: 53558942 (-40.92 pct)
>> Total time saved: 37094711
>>
> What does no SIS_PROP mean? Is it with SIS_PROP disabled and
> SIS_UTIL enabled? Or with both SIS_PROP and SIS_UTIL disabled?
> If it is the latter, is there any performance difference between
> the two?

Sorry for not being clear here. No SIS_PROP mean we are searching the
entire LLC all the time for an idle CPU.This data aims to find how much time SIS_PROP is saving compared tocase where it is disabled.

>> Following are number of CPUs SIS_UTIL will search when SIS_PROP limit >= 16 (LLC size):
>>
>> +--------------+-------+
>> | CPU Searched | Count |
>> +--------------+-------+
>> |      0       | 10520 |
>> |      1       |  7770 |
>> |      2       | 11976 |
>> |      3       | 17554 |
>> |      4       | 13932 |
>> |      5       | 15051 |
>> |      6       |  8398 |
>> |      7       |  4544 |
>> |      8       |  3712 |
>> |      9       |  2337 |
>> |      10      |  4541 |
>> |      11      |  1947 |
>> |      12      |  3846 |
>> |      13      |  3645 |
>> |      14      |  2686 |
>> |      15      |  8390 |
>> |      16      | 26157 |
>> +--------------+-------+
>>
>> - SIS_UTIL might be bailing out too early in some of these cases.
>>
> Right. 
>> o Hackbench with 16 group
>>
>> the success rate looks as follows:
>>
>> +-----------------+---------------------------+---------------------------+---------+
>> | Idle CPU in LLC | SIS_PROP able to find CPU | SIS_UTIL able to find CPU |  Count  |
>> +-----------------+---------------------------+---------------------------+---------+
>> |        1        |             0             |             0             | 1313745 |
>> |        1        |             0             |             1             |  694132 |
>> |        1        |             1             |             0             | 2888450 |
>> |        1        |             1             |             1             | 5343065 |
>> +-----------------+---------------------------+---------------------------+---------+
>>
>> SIS_PROP vs no SIS_PROP CPU search stats:
>>
>> Total time without SIS_PROP: 5227299388
>> Total time with SIS_PROP: 3866575188 (-26.03 pct)
>> Total time saved: 1360724200
>>
>> Following are number of CPUs SIS_UTIL will search when SIS_PROP limit >= 16 (LLC size):
>>
>> +--------------+---------+
>> | CPU Searched |  Count  |
>> +--------------+---------+
>> |      0       |  150351 |
>> |      1       |  105116 |
>> |      2       |  214291 |
>> |      3       |  440053 |
>> |      4       |  914116 |
>> |      5       | 1757984 |
>> |      6       | 2410484 |
>> |      7       | 1867668 |
>> |      8       |  379888 |
>> |      9       |  84055  |
>> |      10      |  55389  |
>> |      11      |  26795  |
>> |      12      |  43113  |
>> |      13      |  24579  |
>> |      14      |  32896  |
>> |      15      |  70059  |
>> |      16      |  150858 |
>> +--------------+---------+
>>
>> - SIS_UTIL might be bailing out too early in most of these cases
>>
> It might be interesting to see what the current sum of util_avg is, and this suggested that,
> even if util_avg is a little high, it might be still be worthwhile to search more CPUs.
I agree. Let me know if there is any data you would like me to collect wrt this.
>> o tbench with 256 workers
>>
>> For tbench with 256 threads, SIS_UTIL works great as we have drastically cut down the number
>> of CPUs to search.
>>
>> SIS_PROP vs no SIS_PROP CPU search stats:
>>
>> Total time without SIS_PROP: 64004752959
>> Total time with SIS_PROP: 34695004390 (-45.79 pct)
>> Total time saved: 29309748569
>>
>> Following are number of CPUs SIS_UTIL will search when SIS_PROP limit >= 16 (LLC size):
>>
>> +--------------+----------+
>> | CPU Searched |  Count   |
>> +--------------+----------+
>> |      0       |  500077  |
>> |      1       |  543865  |
>> |      2       | 4257684  |
>> |      3       | 27457498 |
>> |      4       | 40208673 |
>> |      5       | 3264358  |
>> |      6       |  191631  |
>> |      7       |  24658   |
>> |      8       |   2469   |
>> |      9       |   1374   |
>> |      10      |   2008   |
>> |      11      |   1300   |
>> |      12      |   1226   |
>> |      13      |   1179   |
>> |      14      |   1631   |
>> |      15      |  11678   |
>> |      16      |   7793   |
>> +--------------+----------+
>>
>> - This is where SIS_UTIL shines for tbench case with 256 workers as it is effective
>>   at restricting search space well.
>>
>> o Observations
>>
>> SIS_PROP seems to have a higher chance of finding an idle CPU compared to SIS_UTIL
>> in case of hackbench with 16-group. The gap between SIS_PROP and SIS_UTIL is wider
>> with 16 groups compared to than with 1 group.
>> Also SIS_PROP is more aggressive at saving time for 1-group compared to the
>> case with 16-groups.
>>
>> The bailout from SIS_UTIL is fruitful for tbench with 256 workers leading to massive
>> performance gain in a fully loaded system.
>>
>> Note: There might be some inaccuracies for the numbers presented for metrics that
>> directly compare SIS_PROP and SIS_UTIL as both SIS_PROP and SIS_UTIL were enabled
>> when gathering these data points and the results from SIS_PROP were returned from
>> search_idle_cpu().
> Do you mean the 'CPU Searched' calculated by SIS_PROP was collected with both SIS_UTIL
> and SIS_PROP enabled?
Yes, the table
"Number of CPUs SIS_UTIL will search when SIS_PROP limit >= 16 (LLC size)"
was obtained by enabling both the features - SIS_PROP and SIS_UTIL, and
comparing the nr values suggested by SIS_UTIL when SIS_PROP allowed
searching for the entire LLC.
>> All the numbers for the above analysis were gathered in NPS1 mode.
>>
> I'm thinking of taking nr_llc number into consideration to adjust the search depth,
> something like:
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index dd52fc5a034b..39b914599dce 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9302,6 +9302,9 @@ static inline void update_idle_cpu_scan(struct lb_env *env,
>         llc_util_pct = (sum_util * 100) / (nr_llc * SCHED_CAPACITY_SCALE);
>         nr_scan = (100 - (llc_util_pct * llc_util_pct / 72)) * nr_llc / 100;
>         nr_scan = max(nr_scan, 0);
> +       if (nr_llc <= 16 && nr_scan)
> +               nr_scan = nr_llc;
> +
This will behave closer to the initial RFC on systems with smaller LLC.
I can do some preliminary testing with this and get back to you.
>         WRITE_ONCE(sd_share->nr_idle_scan, nr_scan);
>  }
>
> I'll offline the CPUs to make it 16 CPUs per LLC, and check what hackbench behaves.
Thank you for looking into this.

--
Thanks and Regards,
Prateek

