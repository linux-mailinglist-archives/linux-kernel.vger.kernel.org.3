Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C534E584C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 19:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240064AbiCWSXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 14:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236368AbiCWSWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 14:22:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DA3890AB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 11:21:21 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22NHxhCX014956;
        Wed, 23 Mar 2022 18:20:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=sYlDAAM/X7pGH4kADpVZFR+C/ytBn+hVtYmL0/I9+qo=;
 b=xrF0O6oiJgSLHKkmgb4KsA2RrfIyFdVziWfqpFHaQfJVfaI9KDF4rCRA+CbvqsRRIfim
 0dX9sgAGlll4SvreuzCfEeUq1VIIjyNCSA5cGyScUizYpWDlTtiwfESQCNmHdav1hKuI
 gk9AHiWpAjOZyovYBqTson8CxsP6ABF4czqVMZCB6cVkpEEqhbQgJAq1ORovB/ylJXTf
 Y8JKKonUyUaWRGPunNs7xzn85nEqYpgn8fvnXUq3XikDdWp89VSx/lU19RMp//Cjpksk
 BKxyFPZV34foKXZbDilBI0yfgphKMT/vgkV8eSvTzioYXDH1vNOHOS6kB+99EeAVsxf2 PQ== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5s0tdj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Mar 2022 18:20:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22NIHIvF095882;
        Wed, 23 Mar 2022 18:20:29 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by aserp3030.oracle.com with ESMTP id 3ew578xp7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Mar 2022 18:20:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CyNnAOSQZlFE4g5pV4e1o/dloTSB/WdweEaQiwZQgetoT0+5k+uREp7n8vmpQLf7KH0eS+QY84232zo5ULXNPvmg2w5JVXwpCBAAOw2t4F4ZjrCtGZkbTGFdvyZ5Sa+8pGlwQneumNBzHtDX/WzZ0nl6VMw/2TmIdrAzGFlO1mA6Qyhz/iMrcy5xaBnap7TdVpvxW3cL1yYK6+1HQLd7vQZyoYis+hu7MnhYwGZrSzbrG1R5RkWdeE2oZXpIZ3x9I1/RHISmWhapLMQxtGZHdiEg7wmEA3/KX3pYnudb9XqPYhffX35P10XY8pg6v+SUUxpUR6xzY64KfVjx6NlA3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYlDAAM/X7pGH4kADpVZFR+C/ytBn+hVtYmL0/I9+qo=;
 b=cPKzotAz16xpMzXV1kWD+JEFjIA+mgOtO34yylsneX6rCRtoIdKUDfb8tuVyVpEWEN3bq74Qx8TmXuhu+3UHpTdTvmz4vghDMujo4pLlFrF2VHpH6iZmRJTN9zTDzFDDcpQX2JUSKlx9B4B+8ImSkQ9repw5bJQO0ldL1LmwZh11IhThk8NZt7pwDKU07MLyjNP4CxURl16VVnW7LfFu0yYVN6kbs1D8xRwQwaJDJwQQFFWDSSQD329EZ5uL4l5FkVXa/ZrmjTwpqhjQfNIqtaHqVUj1k6+y7smCXv8L0Opcm2zMzmpQqLhc2rgBHM2pcQ0VtdwOMJYfkffwO7LLrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYlDAAM/X7pGH4kADpVZFR+C/ytBn+hVtYmL0/I9+qo=;
 b=vMeg0foRoItj3d26UNv67Pq9MU0mMSEbd5ywOh3qqQ2WE4g7ScsCcWxjwxlOnIOvlQpLWzoWrobxzDVqfKAEczJtb/givXkDlI5tH7ZkfXvEJstGjnBGAsAXTRxhrppoWUpy8t9KaOSKVlV6+sLYGP5fJqGzCsZGjEDZVtLlejw=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by MWHPR10MB1472.namprd10.prod.outlook.com (2603:10b6:300:22::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 23 Mar
 2022 18:20:26 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::c990:5996:845a:43b5]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::c990:5996:845a:43b5%8]) with mapi id 15.20.5102.017; Wed, 23 Mar 2022
 18:20:26 +0000
Subject: Re: [RFC 6/6] sched/fair: Add sched group latency support
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Tejun Heo <tj@kernel.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, pkondeti@codeaurora.org,
        Valentin.Schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        dhaval.giani@oracle.com, qperret@google.com,
        tim.c.chen@linux.intel.com
References: <20220311161406.23497-1-vincent.guittot@linaro.org>
 <20220311161406.23497-7-vincent.guittot@linaro.org>
 <Yji0twS4N+0b/Rs9@slm.duckdns.org>
 <CAKfTPtA8g-MJMPRM2R_Bfo9rGSyR3cYAUy_j5UrRM+SAB=Mm7w@mail.gmail.com>
 <Yjn8DohJ8CZ6pEvf@slm.duckdns.org>
 <CAKfTPtB4iV0Z40grV3w=WwpOUAZAgx_ZoBfvjA63H8Am-RYdNw@mail.gmail.com>
From:   Chris Hyser <chris.hyser@oracle.com>
Message-ID: <7139641b-5ca6-3799-9e41-72af894d02ad@oracle.com>
Date:   Wed, 23 Mar 2022 14:20:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <CAKfTPtB4iV0Z40grV3w=WwpOUAZAgx_ZoBfvjA63H8Am-RYdNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR15CA0001.namprd15.prod.outlook.com
 (2603:10b6:610:51::11) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af257ed5-2390-45ff-a048-08da0cf9cd4b
X-MS-TrafficTypeDiagnostic: MWHPR10MB1472:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB14728632554686E4E3D174649B189@MWHPR10MB1472.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FUlWOhT6wtOzSRZGFobrEwJzEmCm8IRxiGqO7LSMUh7r2mzxDlktE7jzWhSlK6DvrdGJgUGdr8OVASr/1xzWYfWfwXtQ6pNJ2NXNxIDWaV5wmN4sBGw3vRpSJoLkh87JjUNDWV6UCLLUDEMJwMJmKWl3BK4BTRVkfvz3fWv7TeGiGKfcc4zWaDyeMANUSZgyGmhoYGTESMG3KGpa28Fyh9dvt56+paONS9PAXMsvFGmqPPRHBhSEqWsN6hTuRrmahu4f7zLRXnQFx4YwEXqhwtsXDXC0+9yq0/PCjb2/lErpf+p4d04XAvfLZi86dDg9hZAe+MKX5gnI/reVYXm8h2L89VLiRnga55VLlfCOOsC+6ezvhqRx/rHvezjIpgRDU1q5pqmPP732TCQKWm24gHegUd+lJz125s5pp1Nz0rJ6AQ2omkfTD0MCyefyL39uU0uxsshK7NUXRvukBC3YLreC8cn4nEmKDvUZPMXBAe5tq3AwDRtvR9JNjstxdX/7EymwrB+3Awns5yewFYn3BgZRKFODyuXJh8gVxT5zMJ7Tn9x9bAynWvtwDUGgv2Z/f5Oxl3j9TGLtl9O4/KSTI+rBXY9cYFF82Z/O84ZVfnzeFUdohCz+A/x5qSfPiQhWriN/OXWOUrVxOvz2DWR+ME15cuuWUvCZV7MMLQmAmkid7DMwEcM/RXuiz92jSq+gHrzeGe2YHCkzI5pU904JhF6e60lhMbNjeeDeePnG+eqvZTQEvLOvkh/De63H7OKOBnTEeOWlyiclqB6K4Rh5hQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(316002)(110136005)(186003)(31696002)(4326008)(86362001)(8676002)(66946007)(66556008)(66476007)(83380400001)(26005)(508600001)(6486002)(38350700002)(38100700002)(52116002)(53546011)(2616005)(7416002)(44832011)(6666004)(6506007)(31686004)(8936002)(5660300002)(2906002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXRVUExpVzRrdnhNT2xXM2pBZGdjdzVwVGM0eWlGbkxQd3E5QkIvd3dIZmZl?=
 =?utf-8?B?NHJXM0JyWXY3c0l4NU4xSUVjcDFSZHF3cnRyRjU4NHZnQ0xreXlrazcyYVlL?=
 =?utf-8?B?QlZ2dTlzVVBwMjg5VnlOeVR3WkROSERqZjlSemg2SDdpaEJPc3BGYzBuTGxs?=
 =?utf-8?B?M2t1ZDhHejllUVdGV2Jaa3o4Kzl1dkMyR1o2aGZPUmpOS1FqSFl6QVFjL1E3?=
 =?utf-8?B?T1ZTYXFEYTZsRGRXbldIVkREY0pwWUptVlRnVXFWb0IvelU0K3hCUFJjNkZE?=
 =?utf-8?B?MkpzeS9MVjZLMnV4S1hJaFRodEtmNWtmZkkwd1l3RFlkalZucDIvaDdGVUFu?=
 =?utf-8?B?ckJRQk1wSTNMWUk5OXc5dG1TVENIbGNsSGlmRFpabkIxYnlXL2dXdnJsWWR6?=
 =?utf-8?B?aEljSHo3dTM1azY0WEkrei9tSmcyMGtuTE14RzVVczAvSVA4U0Yrelc5M241?=
 =?utf-8?B?ZDk3SWZMV2RCTW50enNFMXBEbHduaXJzc2IwdCtRcExTSlZnZkhWVHFoalY5?=
 =?utf-8?B?eW9PWEVHSDMrQTFqVCs5YkpMbHdKQ3lqQ2p0OHUzZXhhWVV3ZzNHT0o4bXpZ?=
 =?utf-8?B?V1BaMHQvWE0zZEFNcUpDcG1BYlVkWWFsVlRaVk1TTzVwa2pQNkFiSEdYOU1v?=
 =?utf-8?B?bC9Hd0JKUTZUeFgzL1VPbTl2WHZLRyt6eHpJVE83UzU2N29EWGpJSnhaa2s1?=
 =?utf-8?B?b2IzVzRvQ1VNeG5NNngzL3QzTDQreG1OdkkvNFoyejVVdGVrbi8xeFNyQjhW?=
 =?utf-8?B?anBsTThEQmtBbU5acEtLQWl0T3dMN2JFWjE1NXg0Skw3R2luekN6emExWlhV?=
 =?utf-8?B?Rkh2b3ZJaU1lRXpHU01hQlBMQmpFSmNFYTMvaW5taFFNdnhvdUduT0hYcGc2?=
 =?utf-8?B?TU4ybWg3S0ZYaW56cWprTjYySndxVzRoWGRXRkdNbThEb08vRit0aSs0Mi8v?=
 =?utf-8?B?K0hsYzFGYUU3R3FEMndDREFoeTNWcVBSRlZpR1RIZHVkSXJGQVRkWm8yUEs1?=
 =?utf-8?B?VGcwakJDSHpnUXpMZCs3TlZOTGw2ckxZYm9oK2tKeXYxTEN0VG9hTFlIenB4?=
 =?utf-8?B?SDlNOUJsbmFRLzNGZzBQZnlObjJZcjgrQnVvZkpDQkQxZGtoQ3Y0cHg0SDc0?=
 =?utf-8?B?UjdXeG5EcTZCQVloV093S2V2dE4vc0tzWkllSWhkVzFDRWxpY3F3UlQ1UG5B?=
 =?utf-8?B?WjR5U0VMUWdqaG5ERjZ2bEdtcW0wR3U4MmJSMTdmZjcwSXduMEwxK1RjSld1?=
 =?utf-8?B?dDF5NjBTOEg2aEIxQVBKSnpna1AyeXpiSS95ZE5xN3JlOVc3M2pId1B1T2Rk?=
 =?utf-8?B?azUxRTdlM1VlMVBEeFFxak80cGpmS0J4MUhmMkRzMEtRQkVwTE42eGNkWUVD?=
 =?utf-8?B?aVFQOVJzRVFBVUpLeWNHT29BQTlrZ3djNEl5bE0zYTZ4SVdYa0FzdFpFUXBs?=
 =?utf-8?B?dGx1UTJ2clVZVTVhb2JUTmUyaWhPRUVDQW9tdWxzMDlpMGhKYitkU3c5dm5R?=
 =?utf-8?B?R25IbUpuVDEyTDc3TjJldVpKc2JUZyt6VkQ4U3NnN2VBbXNhSEd1ODM0S0k0?=
 =?utf-8?B?M1VDZWk5d0dnZ0ZGZFo2MWNNOXp0N08xc3lmMEVnWWJXODRSZ0tTU3poZ0xE?=
 =?utf-8?B?cjZhUVBXb0dWaEo3OGFTVnlxRVFPY2JwWDRMRUw0ZCswaU0venFRandaYlRT?=
 =?utf-8?B?UWt6YnczWjhCUmZFdSs0ZGZPcVlubkVyaXdyL1dWWXludWR6Q1R1WmpDVlgx?=
 =?utf-8?B?aXJBdFcvM2N4MVF3WnZPbXdkdUJnRWNWMHJyYWVtaW4vMWpmL2t2SWw3ZHR4?=
 =?utf-8?B?QjR3d1FBcGg0NXVrMkJqb2ZhNTNmUE91K2xUWHR5eS9jaUMvWmVHOVVLNUkx?=
 =?utf-8?B?TDVZaDVKcDNxZzFibStUQ3J0bDkrV0NYU3BTaEdBUk4zeDJPR3lSTS9PcUJm?=
 =?utf-8?B?c25XWkdJN3V2eFdtK09pQU84UU9lOVdOYUJmSTBZRWZyRnB5TjNxUXpacVY5?=
 =?utf-8?B?YmdudTJDbHZnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af257ed5-2390-45ff-a048-08da0cf9cd4b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 18:20:26.2699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EzB3821zckmZH84RrOvqTb31JzOq0LZIa8QxukJJCYynZjZYLHhVINB5U6Ep6e3inbwzPLy721oKcKS7sMS0xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1472
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10295 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203230096
X-Proofpoint-GUID: cHNfDhnhVyfDf2aXqV-f6cAop3RQYmFr
X-Proofpoint-ORIG-GUID: cHNfDhnhVyfDf2aXqV-f6cAop3RQYmFr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/22 11:04 AM, Vincent Guittot wrote:
> On Tue, 22 Mar 2022 at 17:40, Tejun Heo <tj@kernel.org> wrote:
>>
>> Hello,
>>
>> On Tue, Mar 22, 2022 at 05:10:36PM +0100, Vincent Guittot wrote:
>>> latency_nice is quite similar to nice. The nice latency is used as an
>>> index to get a latency weight in the range [-1024:1024].  latency_nice
>>> is in the range [-20:19] and latency_prio shifts it in the range
>>> [0:40] . This index is then used to get the latency weight similar to
>>> how the nice prio is used to get a weight. That being said, the
>>> latency should probably reflect the latency_weight instead of the
>>> latency_prio in order to be aligned with the weight and weight.nice
>>> fields of cgroups.
>>>
>>> As described in patch 5 commit message, the weight is then used to
>>> compute a relative offset to check whether the waking task can preempt
>>> the current running task.
>>
>> So, what I'm trying to say is if it is actually a weight, just use weight
>> values instead of arbitrary mapped nice values. Nobody can tell how the
>> latency nice value of -2 compares against, say, 3. If you can define it
>> clearly in terms of weights (or something else clearly describable), it'd be
>> a lot better.
> 
> The current use is mapped to weight because weight makes sense when
> comparing vruntime but others might want to map the latency nice to
> something else in other places of the scheduler. Time but also others
> have mentioned the depth of the loop for looking an idle CPU

Reinforcing what Vincent said, about a year and half ago there were four different projects/ideas looking to do 
different but relatively compatible things based on the latency sensitivity of a task. We were looking for a number to 
describe this sensitivity, say like an integer. One of those projects wanted to do "bad for latency" power saving things 
so we then needed "good for latency", "neutral" and "potentially bad for latency". Call neutral 0, negative good and 
positive bad and there was a fair similarity to nice. Given that was an abstraction, we did recognize that beyond 
smaller numbers being more sensitive there really isn't much more you can say about the relationship between numbers. 
Certainly no guarantees of linearity.

-chrish
