Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2233A584AC8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 06:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbiG2Ero (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 00:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiG2Erl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 00:47:41 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2074.outbound.protection.outlook.com [40.107.212.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A9611177
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 21:47:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5KyxCjmgdZPowKj+AlToir7uUSumEn7FRyG+MyPEuOlD/HzAyRaG6OfEOblW8t4S71VKz3m0crZxSz1uTyvFYKVwF5ZwWQvOsD3hFD13UyEDe/y/kADe57RT2qKnFHBDbryUrcuntX4sXlqYhfw1q1qh/KsO3GZMf9W0sS32uhzO3oifX0S4WnVL4V6c6XZOsiR/jIn729jdnnWWGv2+9rmHySP4WnWIoAXLeXz4ZIbWj2V5feeu3Os+sB7ThoPE9ui0hPKRGxmZi9sZ94xy2fG5H2QaLWuV5cRaIGt8MkkvRqbq+S8L1pu2XAVc7rUOjO/QoSgZLO8k1lkuQxfDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJMeKADlGgpkP/C12jqmNrIX5ZT8Qe7ltcrdNV7N2bY=;
 b=VQl7ZChLA2dqmBGyRS6RvZoJmRHChUHt41/6iDe/IvlWIYblXbFoJX3cBDz9WXU6VY8+nKPEymWN1Q93Ai1eLAUO31RcDLR1Z9tB64/4P5wNhZK/jJ98TXRzvyQZHukeA3+YffCrLcLAQ1GZ7t+5xdo/779GTcN7ENb+tG73O7gfDytkE6BxBWj+5HWFigUEBQMx8IknxQbP9qJMjTX0fNXMqD4Er7ThVoFyA005O+pEjFmIFDXpM5VMJ22AeKCEltSULJDyObfGKXw5P3KQWPdVILxswbzxGUKsum7UrbdY9CbE192dETSfW8XK0FrmNjQE0q4crf6FFadE8tgCoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJMeKADlGgpkP/C12jqmNrIX5ZT8Qe7ltcrdNV7N2bY=;
 b=bTTyTGQgODkxIHuwE9jhkwk8oRBljehDBMGxsoqaUg/3BWc7YwbhSHRGDby8eYisN4UMlihfupgt+56XLrrBvUCGwJhUZbDYrNMcoW+NQzXnQhqTS5RcpCTcuTSBY7mMDumjBbZaM/jLo5s3RORAgjILY+WSpPCx1dGwlEPs2B4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by MN2PR12MB4208.namprd12.prod.outlook.com (2603:10b6:208:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Fri, 29 Jul
 2022 04:47:37 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::a580:39f0:8893:8ede]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::a580:39f0:8893:8ede%5]) with mapi id 15.20.5458.025; Fri, 29 Jul 2022
 04:47:37 +0000
Message-ID: <c50bdbfe-02ce-c1bc-c761-c95f8e216ca0@amd.com>
Date:   Fri, 29 Jul 2022 10:17:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] sched/fair: no sync wakeup from interrupt context
Content-Language: en-US
To:     Libo Chen <libo.chen@oracle.com>, peterz@infradead.org,
        vincent.guittot@linaro.org, mgorman@suse.de,
        tim.c.chen@linux.intel.com, 21cnbao@gmail.com,
        dietmar.eggemann@arm.com
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de
References: <20220711224704.1672831-1-libo.chen@oracle.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20220711224704.1672831-1-libo.chen@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0227.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::14) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be00541d-3409-47dc-dd72-08da711d757f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4208:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y9nbsBy5ZgCepxLBllXJx+tUgus5ST2eAseBirzaO9NSb2DZSrY7KoP49TczS8nUeMwp94V+IE9kFqP3Awdi05mLaChq/VV2Tdp5r7YdsIE33rTUcMBaQkTrnkBlX9lZre3svLli1TeWRtWm6A9Td4HUrLX1yHKPkaHd17fEahDbLKdBSccd0tkc65rP/VgpNjJIec/FB/wixT0pmGB5g6XROsC9yiRvlo+6wgOWHvz4yzr8QLf0htLn4d6GtQ0ivHnfbj6j1EOY96hnEy78iV13e+AXxOSxHOuUynCglYV8BxPag8U81pnujJOcCpOIlpUhKKsd6d5DU4IQxWnk/9xjsuX6U8/+D5jYNllgAmOjJRN+Cq8Ir2djlzu2pyZc21c0RWMS9UOXT2zkADgL0Q/wg6pN+2YhbsviGcD75u6Ko2UBleaW4GJ3IVyP+vvc7uM2huR9pVbQ9HFL564waGHpKVxLmOFQEmoTx63Z2z/BqxR/sZdQ1o/awpdkMqUzvkDGm+SWpQgg7fxB8sBF0FAO2AD+P4MxEwSMU1/gswscnAoVEbF2mERuKtSLwPFivkcCKrA26aXg0CoGEkrQg0m3ec2tT8Vu6sH9IoQm2R3dsK7UHttinadYtXUwIhkDN9r5mOTla3ts8jxKlhwrO67oXhprsni5Sm4gcD8jzZASmRC241uVkGV6MKAFlX3ee7Sc0ibUPOWMFlRLDtpl9392uf+eIE3Dp0zDCu5m6Unzc+86WYv5iDso7admMtawRHZBQ4BkHGoWJlt2hx27IhZ7q2JXZnmOLv+OXjzrDEm8cCpeeUzJeKze8PITUfpB0voHg2FbjabAUyRRxIzq0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(66476007)(5660300002)(8936002)(30864003)(4326008)(66946007)(8676002)(186003)(66556008)(2906002)(83380400001)(86362001)(40140700001)(36756003)(31696002)(38100700002)(316002)(31686004)(2616005)(6512007)(26005)(478600001)(6506007)(6486002)(53546011)(41300700001)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXdIaXA1akRYSlFxUzNObFg3QU8yYkQyRVBxWGxzdTVuVlJCSFhUalFFejhK?=
 =?utf-8?B?cnVRQW1xdlhzRHJUeDBTbWJYcVk3MWhvOWZNV05GTmZXbW1yZVBUaWF5QUs1?=
 =?utf-8?B?MzY4VEZZb2xxdXo1TzBTN0NrOFFLR0NkalhIVno1K0ppdUUvSU42L0lxbzQy?=
 =?utf-8?B?YzVMc0dLbmVDYjZ5TWUrMEV0SHR2R216VThsV09ERk1tcnNzVlVWZWdLbDJr?=
 =?utf-8?B?TUE1Z0h2L0V0bFVEMlhJdkVrQU5HLy8wUSt6ajlKNFlEUEhXYmhBV0ZMQzlS?=
 =?utf-8?B?Q244L0xQZXZaakJ2cW5kQjJCRDNGZTMvdnp1MkJBM1hHb1prc3lpeEZxQktY?=
 =?utf-8?B?Y3RYYTVzcVg0NENUK1gvZzZQZjVJZ1JVQXJyQjliWFMrSk9Fdkh4bUFqQWha?=
 =?utf-8?B?U2h5b3gwdEdCOTBVajlxMVhPZWNvV2ZkUmZPRzdLQzJnYlVDUEFsT2JTLy94?=
 =?utf-8?B?WkRPdFI2N0tHWG40bmg5MU9kSkJTMkt0dkZoOWgvdm10QWZRZ0o4aDJ5M1lt?=
 =?utf-8?B?a1NRdnZUMDZoWUM2QXhod1ZXbU12a0NFNDRheFh3ck0xOTlOYVpYUUhpOXRR?=
 =?utf-8?B?UzhtY0lscGhHY0NCUzRHZTBaUmNlSUxWNmxOdTJJSnlLVmR5TUNxUjRYdzRp?=
 =?utf-8?B?ejVudFZ6d2dFbTc1elhYVTViOHRVK2Z1Vlphc3BRNWFkTWRiZ1dKZmphSU1L?=
 =?utf-8?B?aEZweDgwNjJsbHlXWTZxTW53TlIzM2ZHQjRMZzNNS2xlVkpRc0d3REVEU0I5?=
 =?utf-8?B?MFdXQVJMV0UyMHY3MVpUMnRORUF1NVlCeUpqQjZncUtubVVpQUd3VFUzTXRa?=
 =?utf-8?B?NVNlYWxUSGFlbUFoWFNESmxNbjFuWkR4NHF3QlBxUWw0RWRld3FQMEh2ekNi?=
 =?utf-8?B?cGJrR3MwanFUSG5kTnZGVlZMR1VveHlGbmc0cXNnbm53QWpXejdIcWZDUVlF?=
 =?utf-8?B?d3NUbDIxVk5SZ3pLYzBDbzBwNU9Ob3RZOTYxQmhXc1I4cDJJZWZIYXRiTk9o?=
 =?utf-8?B?d0hnTjcxM2tpMitISitnMmlWMHFkWHQyVFdQSis1ZXB1NGJRZGZqWXVmZEFS?=
 =?utf-8?B?dFY0VDJnOWZyV2pVSTdPLzI1OHhPTS92RXRXZWpoazdPRExxaHM4ZWZhNDVM?=
 =?utf-8?B?b0FSNmV5TzcyODhRNDU2SmUrMzBVZXhDcW9SbEpaOEVXd3J6QUIxNjNKWmQ5?=
 =?utf-8?B?UjNGOXo0bXFPRCtISmY1VGFCY0FqNU93N0R1Wk8vSjFlOWovR0JJY3U0LzRa?=
 =?utf-8?B?cm0zV2owUDBLczR0UDEyS1BQc2tnY3VMcDVsVkswNWQyQUY0ZHpoOGNQaURn?=
 =?utf-8?B?ai9KMTY4TjU2WTdoVjduUmZNZWpIMFhtOU9RODN4Ky9pNk9NSmJMRjJPYTd2?=
 =?utf-8?B?MjNodEJBOGJlT1A3ODBFZWVyVStZSnRKcXUvbndHMm84czUzWDNkb2JVUjJn?=
 =?utf-8?B?dEtLRC9MV09UNSswbmVoMCtpOXEzWitUU3lETkJOVWVkUkYwakVIQUJHTTlp?=
 =?utf-8?B?cWp0NDA0ZWpYSGhyeHJiRmdSSlBJZ0NsUEFaemtPSktsbWRaUGxwSVpyN3N3?=
 =?utf-8?B?ekpDejlJSnVjTVpGcUdLMENZNkZ6aWZJK1JkbXU1cVlMRnNOUTJreWFSN0Ir?=
 =?utf-8?B?NEQySWJ2ZEp2a2ptU243eWNGRFA0OUM4bVBjSGplWmttTmhnSFVpUlhQTXNH?=
 =?utf-8?B?VCtianR0R2hDMGEyTGNIcGJRTFprV2ZsMVlseFlEaXduRWdOT21GdTJTODhz?=
 =?utf-8?B?eEZMc0RLOHh4K1N0c2xWd0I5QVg2VUhVa0FUdTZqdEN3YklQVHBCZ1BSZ0x6?=
 =?utf-8?B?M3ZUb1JtQzNtWlhJYWgwdEVYa09McU5ZeVRxMFAyaGI5Nzd6WmZoTnlmNi9q?=
 =?utf-8?B?N3NXZUsxL3JXNkkwL0ZJSkxYUUh3QUhmSUFyWmQ4RDFEUkJENXRsODRxb0k4?=
 =?utf-8?B?ZklOekNjL3dQSlE4Vm00aFdoZkYvZlVyemc4YTdtdExCckY4bFZ3ZDFmb2lx?=
 =?utf-8?B?c0MrWGVBK2l4NGxnNm1TRGd3QUdqNHkwTEJZbW04VlBTMUsyM2FBbUZHazhX?=
 =?utf-8?B?akk3N1RzS1hKWXBSMGUweEQwMFhTU0VwVjNIV1c3MVdYOVV3czFRQVFyaHFJ?=
 =?utf-8?Q?rm/l59MvAvIiwKLq89Kz3GNaH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be00541d-3409-47dc-dd72-08da711d757f
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 04:47:36.8150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +vvtbfWtAN2aT3cnDZE73+HIl6n6pEKAOeT7H2oBy078Rh0Hj0iCGaXD5K+Yl3Gj/MCApdukh13732Dfn8wU3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4208
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Libo and Peter,

tl;dr

- We observed a major regression with tbench when testing the latest tip
  sched/core at:
  commit 14b3f2d9ee8d "sched/fair: Disallow sync wakeup from interrupt context"
  Reason for the regression are the fewer affine wakeups that leaves the
  client farther away from the data it needs to consume next primed in the
  waker's LLC.
  Such regressions can be expected from tasks that use sockets to communicate
  significant amount of data especially on system with multiple LLCs.

- Other benchmarks have a comparable behavior to the tip at previous commit
  commit : 91caa5ae2424 "sched/core: Fix the bug that task won't enqueue
  into core tree when update cookie"

I'll leave more details below.

On 7/12/2022 4:17 AM, Libo Chen wrote:
> Barry Song first pointed out that replacing sync wakeup with regular wakeup
> seems to reduce overeager wakeup pulling and shows noticeable performance
> improvement.[1]
> 
> This patch argues that allowing sync for wakeups from interrupt context
> is a bug and fixing it can improve performance even when irq/softirq is
> evenly spread out.
> 
> For wakeups from ISR, the waking CPU is just the CPU of ISR and the so-called
> waker can be any random task that happens to be running on that CPU when the
> interrupt comes in. This is completely different from other wakups where the
> task running on the waking CPU is the actual waker. For example, two tasks
> communicate through a pipe or mutiple tasks access the same critical section,
> etc. This difference is important because with sync we assume the waker will
> get off the runqueue and go to sleep immedately after the wakeup. The
> assumption is built into wake_affine() where it discounts the waker's presence
> from the runqueue when sync is true. The random waker from interrupts bears no
> relation to the wakee and don't usually go to sleep immediately afterwards
> unless wakeup granularity is reached. Plus the scheduler no longer enforces the
> preepmtion of waker for sync wakeup as it used to before
> patch f2e74eeac03ffb7 ("sched: Remove WAKEUP_SYNC feature"). Enforcing sync
> wakeup preemption for wakeups from interrupt contexts doesn't seem to be
> appropriate too but at least sync wakeup will do what it's supposed to do.
> 
> Add a check to make sure that sync can only be set when in_task() is true. If
> a wakeup is from interrupt context, sync flag will be 0 because in_task()
> returns 0.
> 
> Tested in two scenarios: wakeups from 1) task contexts, expected to see no
> performance changes; 2) interrupt contexts, expected to see better performance
> under low/medium load and no regression under heavy load.
> 
> Use hackbench for scenario 1 and pgbench for scenarios 2 both from mmtests on
> a 2-socket Xeon E5-2699v3 box with 256G memory in total. Running 5.18 kernel
> with SELinux disabled. Scheduler/MM tunables are all default. Irqbalance
> daemon is active.
> 
> Hackbench (config-scheduler-unbound)
> =========
> process-pipes:
>                 Baseline                Patched
> Amean   1       0.4300  ( 0.00%)        0.4420  ( -2.79%)
> Amean   4       0.8757  ( 0.00%)        0.8774  ( -0.20%)
> Amean   7       1.3712  ( 0.00%)        1.3789  ( -0.56%)
> Amean   12      2.3541  ( 0.00%)        2.3714  ( -0.73%)
> Amean   21      4.2229  ( 0.00%)        4.2439  ( -0.50%)
> Amean   30      5.9113  ( 0.00%)        5.9451  ( -0.57%)
> Amean   48      9.3873  ( 0.00%)        9.4898  ( -1.09%)
> Amean   79      15.9281 ( 0.00%)        16.1385 ( -1.32%)
> Amean   110     22.0961 ( 0.00%)        22.3433 ( -1.12%)
> Amean   141     28.2973 ( 0.00%)        28.6209 ( -1.14%)
> Amean   172     34.4709 ( 0.00%)        34.9347 ( -1.35%)
> Amean   203     40.7621 ( 0.00%)        41.2497 ( -1.20%)
> Amean   234     47.0416 ( 0.00%)        47.6470 ( -1.29%)
> Amean   265     53.3048 ( 0.00%)        54.1625 ( -1.61%)
> Amean   288     58.0595 ( 0.00%)        58.8096 ( -1.29%)
> 
> process-sockets:
>                 Baseline                Patched
> Amean   1       0.6776   ( 0.00%)       0.6611   ( 2.43%)
> Amean   4       2.6183   ( 0.00%)       2.5769   ( 1.58%)
> Amean   7       4.5662   ( 0.00%)       4.4801   ( 1.89%)
> Amean   12      7.7638   ( 0.00%)       7.6201   ( 1.85%)
> Amean   21      13.5335  ( 0.00%)       13.2915  ( 1.79%)
> Amean   30      19.3369  ( 0.00%)       18.9811  ( 1.84%)
> Amean   48      31.0724  ( 0.00%)       30.6015  ( 1.52%)
> Amean   79      51.1881  ( 0.00%)       50.4251  ( 1.49%)
> Amean   110     71.3399  ( 0.00%)       70.4578  ( 1.24%)
> Amean   141     91.4675  ( 0.00%)       90.3769  ( 1.19%)
> Amean   172     111.7463 ( 0.00%)       110.3947 ( 1.21%)
> Amean   203     131.6927 ( 0.00%)       130.3270 ( 1.04%)
> Amean   234     151.7459 ( 0.00%)       150.1320 ( 1.06%)
> Amean   265     171.9101 ( 0.00%)       169.9751 ( 1.13%)
> Amean   288     186.9231 ( 0.00%)       184.7706 ( 1.15%)
> 
> thread-pipes:
>                 Baseline                Patched
> Amean   1       0.4523  ( 0.00%)        0.4535  ( -0.28%)
> Amean   4       0.9041  ( 0.00%)        0.9085  ( -0.48%)
> Amean   7       1.4111  ( 0.00%)        1.4146  ( -0.25%)
> Amean   12      2.3532  ( 0.00%)        2.3688  ( -0.66%)
> Amean   21      4.1550  ( 0.00%)        4.1701  ( -0.36%)
> Amean   30      6.1043  ( 0.00%)        6.2391  ( -2.21%)
> Amean   48      10.2077 ( 0.00%)        10.3511 ( -1.40%)
> Amean   79      16.7922 ( 0.00%)        17.0427 ( -1.49%)
> Amean   110     23.3350 ( 0.00%)        23.6522 ( -1.36%)
> Amean   141     29.6458 ( 0.00%)        30.2617 ( -2.08%)
> Amean   172     35.8649 ( 0.00%)        36.4225 ( -1.55%)
> Amean   203     42.4477 ( 0.00%)        42.8332 ( -0.91%)
> Amean   234     48.7117 ( 0.00%)        49.4042 ( -1.42%)
> Amean   265     54.9171 ( 0.00%)        55.6551 ( -1.34%)
> Amean   288     59.5282 ( 0.00%)        60.2903 ( -1.28%)
> 
> thread-sockets:
>                 Baseline                Patched
> Amean   1       0.6917   ( 0.00%)       0.6892   ( 0.37%)
> Amean   4       2.6651   ( 0.00%)       2.6017   ( 2.38%)
> Amean   7       4.6734   ( 0.00%)       4.5637   ( 2.35%)
> Amean   12      8.0156   ( 0.00%)       7.8079   ( 2.59%)
> Amean   21      14.0451  ( 0.00%)       13.6679  ( 2.69%)
> Amean   30      20.0963  ( 0.00%)       19.5657  ( 2.64%)
> Amean   48      32.4115  ( 0.00%)       31.6001  ( 2.50%)
> Amean   79      53.1104  ( 0.00%)       51.8395  ( 2.39%)
> Amean   110     74.0929  ( 0.00%)       72.4391  ( 2.23%)
> Amean   141     95.1506  ( 0.00%)       93.0992  ( 2.16%)
> Amean   172     116.1969 ( 0.00%)       113.8307 ( 2.04%)
> Amean   203     137.4413 ( 0.00%)       134.5247 ( 2.12%)
> Amean   234     158.5395 ( 0.00%)       155.2793 ( 2.06%)
> Amean   265     179.7729 ( 0.00%)       176.1099 ( 2.04%)
> Amean   288     195.5573 ( 0.00%)       191.3977 ( 2.13%)
> 
> Pgbench (config-db-pgbench-timed-ro-small)
> =======
>                 Baseline            Patched
> Hmean   1       68.54    ( 0.00%)   69.72    ( 1.71%)
> Hmean   6       27725.78 ( 0.00%)   34119.11 ( 23.06%)
> Hmean   12      55724.26 ( 0.00%)   63158.22 ( 13.34%)
> Hmean   22      72806.26 ( 0.00%)   73389.98 ( 0.80%)
> Hmean   30      79000.45 ( 0.00%)   75197.02 ( -4.81%)
> Hmean   48      78180.16 ( 0.00%)   75074.09 ( -3.97%)
> Hmean   80      75001.93 ( 0.00%)   70590.72 ( -5.88%)
> Hmean   110     74812.25 ( 0.00%)   74128.57 ( -0.91%)
> Hmean   142     74261.05 ( 0.00%)   72910.48 ( -1.82%)
> Hmean   144     75375.35 ( 0.00%)   71295.72 ( -5.41%)

The two tests kernels used are:

- tip at commit: 14b3f2d9ee8d "sched/fair: Disallow sync wakeup from interrupt context"
- tip at commit: 91caa5ae2424 "sched/core: Fix the bug that task won't enqueue into core tree when update cookie"

Below are the tbench result on a dual socket Zen3 machine
running in NPS1 mode. Following is the NUMA configuration
NPS1 mode:

- NPS1: Each socket is a NUMA node.
  Total 2 NUMA nodes in the dual socket machine.

  Node 0: 0-63,   128-191
  Node 1: 64-127, 192-255

Clients: tip (91caa5ae2424)      tip (14b3f2d9ee8d)
    1    569.24 (0.00 pct)       283.63 (-50.17 pct)    *
    2    1104.76 (0.00 pct)      590.45 (-46.55 pct)    *
    4    2058.78 (0.00 pct)      1080.63 (-47.51 pct)   *
    8    3590.20 (0.00 pct)      2098.05 (-41.56 pct)   *
   16    6119.21 (0.00 pct)      4348.40 (-28.93 pct)   *
   32    11383.91 (0.00 pct)     8417.55 (-26.05 pct)   *
   64    21910.01 (0.00 pct)     19405.11 (-11.43 pct)  *
  128    33105.27 (0.00 pct)     29791.80 (-10.00 pct)  *
  256    45550.99 (0.00 pct)     45847.10 (0.65 pct)
  512    57753.81 (0.00 pct)     49481.17 (-14.32 pct)  *
 1024    55684.33 (0.00 pct)     48748.38 (-12.45 pct)  *

This regression is consistently reproducible.

Below are the statistics gathered from schedstat data:

Kernel                                                     :        tip + remove 14b3f2d9ee8d                    tip
HEAD commit                                                :             91caa5ae2424                       14b3f2d9ee8d                                                                
sched_yield cnt                                            :                   11                                 17
Legacy counter can be ignored                              :                    0                                  0
schedule called                                            :             12621212                           15104022
schedule left the processor idle                           :              6306653 ( 49.96% of times )        7547375       ( 49.96% of times )
try_to_wake_up was called                                  :              6310778                            7552147
try_to_wake_up was called to wake up the local cpu         :                12305 ( 0.19% of times )           12816       ( 0.16% of times ) 
total time by tasks on this processor (in jiffies)         :          78497712520                        72461915902  
total time waiting tasks on this processor (in jiffies)    :             56398803 ( 0.07% of times )        34631178       ( 0.04% of times ) 
total timeslices run on this cpu                           :              6314548                            7556630   

Wakeups on same                                    SMT     :                   39 ( 0.00062 )                    263 ( 0.00348 )
Wakeups on same                                    MC      :              6297015 ( 99.78% of time ) <---       1079 ( 0.01429 )
Wakeups on same                                    DIE     :                  559 ( 0.00886 )                7537909 ( 99.81147 ) <--- With the patch, the task will prefer
Wakeups on same                                    NUMA    :                  860 ( 0.01363 )                     80 ( 0.00106 )       to wake on the same LLC where it previously
Affine wakeups on same                             SMT     :                   25 ( 0.00040 )                    255 ( 0.00338 )       ran as compared to the LLC of waker.
Affine wakeups on same                             MC      :              6282684 ( 99.55% of time ) <---        961 ( 0.01272 )       This results in performance degradation as
Affine wakeups on same                             DIE     :                  523 ( 0.00829 )                7537220 ( 99.80235 ) <--- the task is farther away from data it will
Affine wakeups on same                             NUMA    :                  839 ( 0.01329 )                     46 ( 0.00061 )       consume next.

All the statistics are comparable except for the reduced number of affine
wakeup on the waker's LLC that resulting in task being placed on the previous
LLC farther away from the data that resides in the waker's LLC that the wakee
will consume next.

All wakeups in the tbench, happens in_serving_softirq() making in_taks() false
for all the cases where sync would have been true otherwise.

We wanted to highlight there are workloads which would still benefit from
affine wakeups even when it happens in an interrupt context. It would be
great if we could spot such cases and bias wakeups towards waker's LLC.

Other benchmarks results are comparable to the tip in most cases.
All benchmarks were run on machine configured in NPS1 mode.
Following are the results:

~~~~~~~~~
hackbench
~~~~~~~~~

Test:             tip (91caa5ae2424)      tip (14b3f2d9ee8d)
 1-groups:         4.22 (0.00 pct)         4.48 (-6.16 pct)     *
 1-groups:         4.22 (0.00 pct)         4.30 (-1.89 pct)     [Verification run]
 2-groups:         5.01 (0.00 pct)         4.87 (2.79 pct)
 4-groups:         5.49 (0.00 pct)         5.34 (2.73 pct)
 8-groups:         5.64 (0.00 pct)         5.50 (2.48 pct)
16-groups:         7.54 (0.00 pct)         7.34 (2.65 pct)

~~~~~~~~
schbench
~~~~~~~~

#workers: tip (91caa5ae2424)     tip (14b3f2d9ee8d)
  1:      22.00 (0.00 pct)        22.00 (0.00 pct)
  2:      22.00 (0.00 pct)        27.00 (-22.72 pct)    * Known to have run to run
  4:      33.00 (0.00 pct)        38.00 (-15.15 pct)    * variations.
  8:      48.00 (0.00 pct)        51.00 (-6.25 pct)     *
 16:      70.00 (0.00 pct)        70.00 (0.00 pct)
 32:     118.00 (0.00 pct)       120.00 (-1.69 pct)
 64:     217.00 (0.00 pct)       223.00 (-2.76 pct)
128:     485.00 (0.00 pct)       488.00 (-0.61 pct)
256:     1066.00 (0.00 pct)      1054.00 (1.12 pct)
512:     47296.00 (0.00 pct)     47168.00 (0.27 pct)

Note: schbench results at lower worker count have a large
run-to-run variance and depends on certain characteristics
of new-idle balance.

~~~~~~
stream
~~~~~~

- 10 runs

Test:     tip (91caa5ae2424)      tip (14b3f2d9ee8d)
 Copy:   336140.45 (0.00 pct)    334362.29 (-0.52 pct)
Scale:   214679.13 (0.00 pct)    218016.44 (1.55 pct)
  Add:   251691.67 (0.00 pct)    249734.04 (-0.77 pct)
Triad:   262174.93 (0.00 pct)    260063.57 (-0.80 pct)

- 100 runs

Test:     tip (91caa5ae2424)      tip (14b3f2d9ee8d)
 Copy:   336576.38 (0.00 pct)    334646.27 (-0.57 pct)
Scale:   219124.86 (0.00 pct)    223480.29 (1.98 pct)
  Add:   251796.93 (0.00 pct)    250845.95 (-0.37 pct)
Triad:   262286.47 (0.00 pct)    258020.57 (-1.62 pct)

~~~~~~~~~~~~
ycsb-mongodb
~~~~~~~~~~~~

tip (91caa5ae2424):   290479.00 (var: 1.53)
tip (14b3f2d9ee8d):   287361.67 (var: 0.80) (-1.07 pct)

>
> [..snip..]
> 

We also ran tbench on a dual socket Icelake Xeon system (2 x 32C/64T)
(Intel Xeon Platinum 8362) and following are the results:

 Clients:       tip (91caa5ae2424)       tip (14b3f2d9ee8d)
    1           131.56 (0.00 pct)        145.05 (10.25 pct)
    2           279.46 (0.00 pct)        245.94 (-11.99 pct)	*
    4           552.19 (0.00 pct)        577.94 (4.66 pct)
    8           1176.12 (0.00 pct)       1309.40 (11.33 pct)
   16           2685.86 (0.00 pct)       2724.96 (1.45 pct)
   32           11582.50 (0.00 pct)      10817.42 (-6.60 pct)	*
   64           18309.47 (0.00 pct)      18287.92 (-0.11 pct)
  128           15689.97 (0.00 pct)      15322.08 (-2.34 pct)
  256           37130.34 (0.00 pct)      37332.91 (0.54 pct)
  512           36448.68 (0.00 pct)      36162.17 (-0.78 pct)

Both kernel versions show lot of run to run variance but the two highlighted
cases are relatively more stable and the case with 32 clients is outside of
the NUMA imbalance threshold.

Below are detailed stats of each individual runs on Icelacke machine:

Kernel:          tip            tip
           (91caa5ae2424)  (14b3f2d9ee8d)

o 1 Clients

Min           : 126.23        128.01
Max           : 137.75        168.99
Median        : 131.20        143.83
AMean         : 131.73        146.94
GMean         : 131.64        145.99
HMean         : 131.56        145.05
AMean Stddev  : 5.78          20.66
AMean CoefVar : 4.39 pct      14.06 pct

o 2 clients *

Min           : 261.71        234.26
Max           : 293.38        253.03
Median        : 285.27        251.43
AMean         : 280.12        246.24
GMean         : 279.79        246.09
HMean         : 279.46        245.94
AMean Stddev  : 16.45         10.40 
AMean CoefVar : 5.87 pct      4.22 pct

o 4 clients

Min           : 515.98        497.81
Max           : 611.56        744.49
Median        : 537.71        543.82
AMean         : 555.08        595.37
GMean         : 553.61        586.31
HMean         : 552.19        577.94
AMean Stddev  : 50.10         131.17
AMean CoefVar : 9.03 pct      22.03 pct

o 8 clients

Min           : 1101.30       1178.59
Max           : 1293.18       1442.30
Median        : 1150.15       1334.56
AMean         : 1181.54       1318.48
GMean         : 1178.80       1313.97
HMean         : 1176.12       1309.40
AMean Stddev  : 99.72         132.59
AMean CoefVar : 8.44 pct      10.06 pct

o 16 clients

Min           : 2478.03       2522.28
Max           : 2829.35       3043.49
Median        : 2777.96       2660.31
AMean         : 2695.11       2742.03
GMean         : 2690.54       2733.37
HMean         : 2685.86       2724.96
AMean Stddev  : 189.75        270.04
AMean CoefVar : 7.04 pct      9.85 pct

o 32 clients *

Min           : 11479.70      10569.00
Max           : 11670.50      11154.90
Median        : 11598.90      10744.90
AMean         : 11583.03      10822.93
GMean         : 11582.77      10820.17
HMean         : 11582.50      10817.42
AMean Stddev  : 96.38         300.64
AMean CoefVar : 0.83 pct      2.78 pct

Please let me know if you would like me to gather any more data
on the test system.
--
Thanks and Regards,
Prateek
