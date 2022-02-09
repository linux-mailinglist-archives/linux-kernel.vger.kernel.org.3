Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF024AF110
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbiBIMKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbiBIMGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:06:30 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE32C02B5CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 03:17:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BgInqg6a8cOzOf8aPaHSWd0D1ws7lua6wOBJWAJ+uVBYeovb9ZgZGI8gXSGD9dlGHA64y9cU8sfQ/xxKSSA3cnJBa4yP1otW4SScB66LbXtBY7kreyb+NoA4Y7WdHRnpQKybx7dZqtLK+tlDyyLuFKdo9+1B+wBmBGoDNnwliI2kAmTwvCH9pTM581bQwXKbW0JmBUj6PuvNPGJ9+9FxOroRds6avKPzSMM4QYgchnbLTTdMV50mAqK2wGXQqevwhvyNwR9pjsA0n8LvaWZwlNPT8pMyVxZwULUr2Mq51WKZnfAvL7emDUteLDse1xv45YnGW6c+MyiBDacKpAfFcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mz4Q5Bl+k0RHPnGxl3GYSqwFLzF0c+qOfBNEUxfs7pk=;
 b=Af6jpBLEANnq68i92kbSN8VGPxE3WeXU+sd9HfggT0WqE3Qw4oNPCNKMigQKfPatMwW3D05gMGOK1g3mrZM7Oc03wpymNuzis1Ut2p7GU/o9OjaFF+spRy9bCt5xrsfNYv/6s7exbWtzikzEb5SF542pi2I++anV2/bwQGEej0ZtbawwBDNAdqExw6R3QUz13szCa0fwk3OmXS86OeBxGHO2VLu7yYb4CamNrNyftgK2zRf5D8KnWaQsj6gtb2z6RMOg4EadevO0SsojbDYcnyu/pc7y5ytelyHyfJaEkb+Yt0l62Cv9Enwt4HaWFk1FDE17y9nzlHYcT6O+ZhjoAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mz4Q5Bl+k0RHPnGxl3GYSqwFLzF0c+qOfBNEUxfs7pk=;
 b=pgERR+venZ33M1IOuaLWBfbN/vPi4g3FvxcFtzI9qXgvbY30J1qaWHrlQNiuqZar+Sm24fPUXP6ozBj1h7KjMsOztQiZQniPvOeI1ph2OnIdP+G5XB+cSfLKILQymLfDVC+mWmNyi6vTQ+wqzuC9kuVKc08GHuPtv0QFXXxffDs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by DM6PR12MB3947.namprd12.prod.outlook.com (2603:10b6:5:148::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 11:17:44 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::c90d:9f80:a049:b432]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::c90d:9f80:a049:b432%2]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 11:17:43 +0000
Message-ID: <4b4caad8-29bb-df8a-e2dc-50b815dfbfab@amd.com>
Date:   Wed, 9 Feb 2022 16:47:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] sched/fair: Consider cpu affinity when allowing NUMA
 imbalance in find_idlest_group
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     aubrey.li@linux.intel.com, efault@gmx.de, gautham.shenoy@amd.com,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        mingo@kernel.org, song.bao.hua@hisilicon.com,
        srikar@linux.vnet.ibm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org
References: <20220207155921.21321-1-kprateek.nayak@amd.com>
 <20220209104625.GM23216@worktop.programming.kicks-ass.net>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20220209104625.GM23216@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::23) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e319250c-1c85-4fa7-4b11-08d9ebbdcaaa
X-MS-TrafficTypeDiagnostic: DM6PR12MB3947:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB394794883850A2E9D0E93F69982E9@DM6PR12MB3947.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NftufsNAzg0qHWSqPdZtH+4neyIpBiYL0Yi04MtGAGPp2kmRNRF5BofUdoFtqc6OtSV4ZY9RaC0GSyqLgJywHaV1xhyONm+CLuWK7kgotwNz1ESW//9tAdaOLdJyUZcoy2+yR6bfiz9hBGviyWN+3REf/Wz7+5JLoPptbk1J3w5Ei08UXrdI0M1luKWEFJGtBBsv+3Mam9aGGYyceYnd4V94fBWgz5MhveYgWWZn+L+QqVDBywHrZ56TLgIhzFVwU+RwQB9mAU7bJjNsFhhooiG/vhHCfYbsRUgrTYilpaWPvnkERuiC4Dy2rD3EVjjgcMmwoGbWY16+j1M8MF4Nc+7nsrcsvPsheF+wsjHE54z1Vi7s+mRa8peYqllGpOyGDzp63XVSLMOO2/TEfO2/CJYkD7cft4QBnJ93S187CKKDEl5e7OAyCJs6aKB7nw5WmEADhDDBAxyLQVb8VedvvudG9oYpjfKhbBD4ODvPqKx7YDVGDrLr3PaqzrIZ3RWahP0u3+0OCcSai12P26aYUEwPgg0mhBbaqJMR0H9xfY4uDRhqYMoFuAoyaa73Uy1FPv3TYKp1u8BOFFHdQpYbWqqJW99f/E80ZwxWEmr03Zp17ZOIlHCXvlvQoNUFfA1SH0sftywPRbeo3LcsnnN32QVOWWoHs7bFFRMB1gIt6AuHoYLBgSvXR0nTt7+RrN00hyTNT5oamxdX7emeXZjbeqRTeHD4EgwKLbmFbXiyLL4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(83380400001)(6486002)(4326008)(26005)(31686004)(2906002)(5660300002)(38100700002)(186003)(36756003)(2616005)(6916009)(4744005)(6666004)(53546011)(6506007)(66946007)(8936002)(508600001)(66476007)(66556008)(6512007)(316002)(86362001)(31696002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2huWTJtazFoQWQxcFI0eDhkYjJvRmQ3WFdRd2psMG1lS1BEWFFyRVFFcHpm?=
 =?utf-8?B?cCt6OW16Sm8wb0NHeWx0ZExRUjd1Mkgxelg5RVlON1JBdEZBUjdIVnM0MlpY?=
 =?utf-8?B?UDM0aXFycFpNTTIvMGppVUNrOG0wbmszenpKSjVBRzlMVDRMS3p0aHlxNUMy?=
 =?utf-8?B?Q3dvcHg4ZjBra0U0Rmc4SkN3ZXg2UVdIZlo4YVBQUlRYZXdHV1lkNFhZNmh2?=
 =?utf-8?B?TkpZcHpMekRRUWgrbG9xcFZRa0Q1UXBmWU5mTmNmMDhGeXVrTms4eU03Rm5s?=
 =?utf-8?B?SlRWaXl1ZS9UdTRrdzYvbjZRWEJISkdncG5Td0NrRUdTcGNMMzRuNHJTNWVR?=
 =?utf-8?B?V1dyZ25pQjFYMTNrKytMTjdaT2ZiS253Yis3ZkRVUVY4ZW5QaERxRnNaRE1u?=
 =?utf-8?B?d04yeGxMUW1HTnA1amw3UDEycStwajQyOXl0WnlwQWhVc25yWFNzWDhtaUp6?=
 =?utf-8?B?TUozS1VKeUJYVDRXNWZxYlkvWXRNL1FRcVJSK3c1VytYS2Z6Qm5mRnRZVG9j?=
 =?utf-8?B?UnBFTUtlV255VmdqWDZqSDBZR1ZBVnJFZVRSL3FZU2o5aWtTVTY2ODgzeEhz?=
 =?utf-8?B?UllXSFhoVCtMQWRlckdxYUk2NG1QaFVVelVmM3JxVzZNaU5kSXFjVXB2aUZG?=
 =?utf-8?B?Y0tvV3Z2MU9nNWp6aGh4cDlQN1VoSVExUWM1YmZ0MFQxVHgwQXEzeCtBUjYx?=
 =?utf-8?B?YXREMlRmVWxaRFI3VE9kRjY3QzRlaTBQRDlCZ3p5TkZKNFJBWlp5VDJkUUFn?=
 =?utf-8?B?ek9RM1liZzh6ZG1KVWFRNnlsRXVNWTNUZFo2ZW13ODBCOGY1UGJIK05HUjAz?=
 =?utf-8?B?RTJVOFFac0ZPNkpTOEJkZkhvN0QzeEVwUjg4QXROR2tTNVJNdzRoSGRxcVN2?=
 =?utf-8?B?R2d3TVVybEE3VmJiK21EVCtuTWluT001c1FYN0QwQ2pRZnJjOTB3MnBUN2cw?=
 =?utf-8?B?SDJXUGoxVFdveXNrTERwQXovalJxYU9WN3EyNmk4LzJBVEdCaCs5K3Vwc3ov?=
 =?utf-8?B?N3RVWGovYjNxdGJnTUJiZUlESllma1NIajhwR1o5Zk82dUxIWnJZZlE4WWdv?=
 =?utf-8?B?WFRRbWFRdGRMdjhLTXZXMlVPQlcxVVhQdFpHb3JYamRsQkg2cXlxNGt5TE1J?=
 =?utf-8?B?M0pxZ2RhdmFQaGhTNkt5QnFWMjZRZUo2OWdoSFdNQkdaczNrTklpTDZvZ0VR?=
 =?utf-8?B?MW1OL2J1L3hxd1lKMDUvNGNMQlhPOG96eFMwejBJMnFEVjFGZ3JEMWN2dXpL?=
 =?utf-8?B?N2xJRHU0d2M4a1pxN2lpQ0lSUEJvUFJ1b0c2QjFwdHU0TnRhYkdUU1JhRjE2?=
 =?utf-8?B?RUtZbzBsbDdmOEVUdXhMSTVpY3JPWG45MHZ1Y3FQVTduRUFvTk04cDV6S2Jy?=
 =?utf-8?B?aDNJQkJzTzBDUFFLbk5ZeEh0U0dXZ1k1V3g0cGZEbm1TMXJibkpVVzQ3V1g2?=
 =?utf-8?B?VE5JcFZmZFJZRGpxaEs2MGVPWmNJNTFGdFVnRHFzalRsQTVNcTdTY1dMTlBr?=
 =?utf-8?B?RlB3Z2lKKzNFTmhOemN4YWZLT1hNU1plaEFndHk4RCt0KzlQalJKSW5NdXNn?=
 =?utf-8?B?TWZjaWZTTTM1N0pTczVTVm1mY1R1TzdPaU1SOXp0YThhQUsyaml6aFVYeVl5?=
 =?utf-8?B?eGkrZVJNUmM5OCtiWWVtV25vdzdlSWJtSTcyS3ZzMUtrdWNKeDVrYkJnWDBM?=
 =?utf-8?B?R3NxZ3VkTGo2YjJlMWZkaVFRWC9Banl1N080UW5RTnZNYjIwMElHenlBV0RP?=
 =?utf-8?B?ZlhjQ3VmM3ZzOERSb0l0UkMrSGdBTXlDRVRETlpwRDBOdmxUUmRrZ2tHMThl?=
 =?utf-8?B?cjFuMzRyZC9JbFhESjVnSWxyOS9nTTAyaEMzQyt0b2VCWVVoMEFpSk9zaTZH?=
 =?utf-8?B?WHdOY01SMGlvbVE0dDAxTWJCL2RENDBBQWdpbzN5dGdCb1RLRndna3lLNE1B?=
 =?utf-8?B?aXpyd0lzeUk4aXlXRnFLZmRPSy9aSXJCUk5Xb2xuTCtSRVhhdEdqN2xHM1M2?=
 =?utf-8?B?ZHQxUkpZMlhOL1UrZ0p3V01OUk5JSCt4em1iMkNoTEJxQXVSV1p5eC9JSjJK?=
 =?utf-8?B?UWlkL3Y0SDZkYUphY3NudHQ3VFlLRW85aUFTSkd4ZXVJSFdwSXVGalFReHdx?=
 =?utf-8?B?WFlnS0FNemhlTkFFd0pqbmJkeFZvaEMvdjhoUWhCaU1FV3ZwWDY3RFZwSWxN?=
 =?utf-8?Q?dq7k/dbITtaSOrVFVRJJJyU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e319250c-1c85-4fa7-4b11-08d9ebbdcaaa
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 11:17:43.5046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33Y9Si4HNcNRiiw4PUggpG08Vf0Z0SylrFdtDHUpEX9b5UNCRmiHOcdxe18py08zgP0RqLn8IyYJBVfdVdWjNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3947
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter,

On 2/9/2022 4:16 PM, Peter Zijlstra wrote:
> On Mon, Feb 07, 2022 at 09:29:21PM +0530, K Prateek Nayak wrote:
>> Neither the sched/tip nor Mel's v5 patchset [1] provides an optimal
>> new-task wakeup strategy when the tasks are affined to a subset of cpus
>> which can result in piling of tasks on the same set of CPU in a NUMA
>> group despite there being other cpus in a different NUMA group where the
>> task could have run in. 
> Where does this affinity come from?

The affinity comes from limiting the process to run on certain subset
of available cpus by modifying the cpus_ptr member of task_struck
of process via taskset or numactl.

---
Thanks and Regards
Prateek




