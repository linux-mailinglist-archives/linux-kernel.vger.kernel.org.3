Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310BF57805C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 13:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbiGRLAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 07:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbiGRLAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 07:00:35 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F26D1EEFF
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 04:00:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrHnVREvLgcGij7aZSYHBSbLBFTHflOaY6EEbHlu1VedmVi+8llGBOIfD0Hp7eZYGmpvBGvcMEiCUyoDBm061bpm8uDeUoxtakAlM97geN0ughS7DvF3uvdVR08VKq8vQevdV39HLhity1CBjh2Em2SzyLk7wcEMVAtjwIUgbj7T7RTGc/TSzLWzCxL+x0CsaV2EX/xKVDxCKTCbKkaCLmHmRPZ4kExmMi6Y/tseQcJnF1gZxpV9gK1Y3c3mlOFeV7W+nezBJ4ddgBskbJhcrbJcE4O7YuNwgUrjIjJJwcWxsaAmIswn6Y1iq7JbrMKge2DDEWnPl852Qu3KzM1LDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3vKbn+YcRX6x/Z1XtvaIILDEDzvhlYBA2OmF05xck4=;
 b=KvhX1aOCUdbuG+5koYbH+zvfcgrqxIHknKg28O/MCtePfO4snPt7T2MwogE2QH3h7URTv1b+UMzwcB6YLJpTrH5ooyvxt2ydPQnVW5JLxewDNwjvoVJr19HkgrsV27cCGAmJ5GJ5U9WhCBXdypE0ePZGEafHxBVBsuOux/usfzJ7Sq+w4bl2UVRslnehZvdGYvRsE7BbG1UFBmZbZq3QHdL/BsKQmrLl9MQRP/nNyDD9BD/pz8jjbHOFcaoQeUaKlBrqS6ZjxWiI0e9ejWkoU0wvYtChiGD54BFQg60sjcwfho6PlBcpY3t4QzKEXcFYT7KA98/Vmud6DTny0BBoOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3vKbn+YcRX6x/Z1XtvaIILDEDzvhlYBA2OmF05xck4=;
 b=0be3gfNpqvB4ZWfb0jHrgI/0Z2zm/LqLHGbK5JgMRszE/iCvpcUHVfIMJUrqpTpD8JzzMSGmEON7BHlpLGukS3PsMGEPuRdoqlwaAiPHEBot1665vl17o8gffqUgHzg9RxypM3xBhvF1h1dIzJ86q2kS8Mf0JZInI38tEfaWzoc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by BYAPR12MB3509.namprd12.prod.outlook.com (2603:10b6:a03:13b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Mon, 18 Jul
 2022 11:00:29 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::a580:39f0:8893:8ede]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::a580:39f0:8893:8ede%5]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 11:00:25 +0000
Message-ID: <dfcfae9c-caae-1d94-3f7d-de3d644de9e0@amd.com>
Date:   Mon, 18 Jul 2022 16:30:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 0/7] sched/fair: improve scan efficiency of SIS
Content-Language: en-US
To:     Abel Wu <wuyun.abel@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org
References: <20220619120451.95251-1-wuyun.abel@bytedance.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20220619120451.95251-1-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::26)
 To MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24b40ff3-bdf8-41de-363f-08da68acb79a
X-MS-TrafficTypeDiagnostic: BYAPR12MB3509:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6fGwvMHwWon4Ipp8xSq720VcbykqwyxotFAlRhcj33KZzCg3BJuoP9JqRB98PSiIQ8rU9p9RpsfQfROU8xrJlMI0inm5fvdDxvq5z2HskuEXZn97BeMdPMHkNK3ygob+2xaG3KlprFEoZWnRYicpJf4zH15cOLnTLzBwQwTPQqp+t7tYRRhjwbI2Ta9C4p4BAMxdJR//nStGx8xo71uu66tOTeqg14jCpK/OdHQFxxr1zhEp0WCmHu6INLFk7PaI7v46vTwoAPCDyuhA5R7lXjNm7BEoIXAlZtsqPDInhZhAGkWIM2XDzUIa6v351dt0CLSESbE/5wF9MOwHRxMghF8iYhnimDR9/W7LGOv63frnpgK2wbe9RjkjJTEPApFAfd4Sghxws9cgYcovlb8vWXkehSGf3EMaJnb4/nvparYpkzFTd/yQ4dJo5vT7RJSF/PMbJnf7u8YXglMN9Xp1F95UJRYxCxzeYN11PHSJx6Af+MHepMFylBwtV6JvEVs1axKAe+81PJUk3TPJCjI8WgSMmT/SF8aDy/Yew6AG2z8oHRD4WqsYgmY/iXyLuYuIDxmXfjBie2CE2465JZm5fALFoOlCczpSBjnTeTDJdwqwH03AUV9Z4cC3afvBovIPkoUc7MrjDvA/jvIn9bt0Ehcg6MWTstzqItSQnZP+YwytvvD3eDIv6l82SjwHJ8XzsbW2hDcQ3dEQoTIUOTwLFySP0xnsWXlsFpeudjKp82twUqplToIQqBcHAJd7VBxNfMtf6ytv3L5oUAR7vcxhdZ/A3qco8C/5N1c76mqRq4SHJxWohmWqA5Qr11GyWHPQYCFjt1EgedpUEZCUfyYx/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(66556008)(8676002)(4326008)(66476007)(66946007)(8936002)(316002)(40140700001)(54906003)(110136005)(2906002)(86362001)(38100700002)(31686004)(36756003)(83380400001)(186003)(31696002)(26005)(6666004)(53546011)(6506007)(6486002)(41300700001)(478600001)(30864003)(2616005)(6512007)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?em8zU1grOE4xc2s1NU5pVnNvNStuOVM0dThGTlhFMnFxaFVpOXpVRmpOZlRo?=
 =?utf-8?B?NFNGUFNxbGw0RGdWRmRvNW5yMHFJdU5NOENyeFNoMzlQUU1xS3FCT01FUlBD?=
 =?utf-8?B?bDB4dkRvVThmT3B1dTQ2dk1OWkpKWmJFVmE1RE1xZXNHaWpTaVF1ZXAxSnUx?=
 =?utf-8?B?NEVvNE0ySFR2aVRCZkhabTIxMFo5OUZ5bnBvMnVWNWxtRnkrbk4xb3QvYkNV?=
 =?utf-8?B?aXk2clJmcmMrRW9Cb3owTEZnamsvZXVPaTdGUENPVDFXcXFYeGNnVSswODZT?=
 =?utf-8?B?TTlUdk0yRzhyL0h6K2lKREhycTdxcnpObnhWUmdCSHJXeGVPUGE4ZEhyVjBH?=
 =?utf-8?B?THc3aElEVXZBTGJNZlhVOWtqWnRGV0FFbjNUNTJTbGpoamNZcDk1d0tmVk4v?=
 =?utf-8?B?NTI5OXhEZTFlSXZWQ25MZDFXMkJBSEl0dXBncWJ1a0NWRXlXWkJueGdRb05I?=
 =?utf-8?B?VjRNbFF3OWI1OVFTdjlWYXp5enNLM2pHUUdzU003TGM1Vi93R2dHZ0NBemVk?=
 =?utf-8?B?dGlRQXVHVmJSUzFlbWhFeXF1d0R0OENSTFJLUnMvd2FXNVRQdDQ3OEx1UTJ4?=
 =?utf-8?B?QjBTUVQ1QVdyZUs0WEkvUW9MUi95NzBEOG5WN3hQNnJCdzZaWUxEcHg5RmFB?=
 =?utf-8?B?Q0tjU1B1S3h3RU5hekNoSFF5dDgyRjJCaVMwNUkraUMvZ2tIODZhd0cwK0xR?=
 =?utf-8?B?SU9oTFNaUEkzMlliQkl4RkxxanJMWUoxdXk1OG9ES1JIM253a1lNbVFLZVJz?=
 =?utf-8?B?UFNnTHNGVzJoY0VLVW1HVk9OeTlHRFkvTG5nd09lTzBuaVoyN3g1azJZcXBC?=
 =?utf-8?B?VXo4M1hNNEdEc2RuNm44L1VlUXo0cDB0OUNRak1UeFBJSUdhMEJ0Skpub1h5?=
 =?utf-8?B?RDhxemJydDAyQUlkM3hGenZMYmxDL0xQcEhSSllIdE9sV01oczhPQ1lvVGJL?=
 =?utf-8?B?VElobUdDMktuR1FrVEUvTjlLdjZLQjJzUVVhWlAyb1JtcjROUnpBYTF0dzlx?=
 =?utf-8?B?aFhUSUh3Lzl2RlkvOFVIR09yYkxTbVdTaE9CK1ZIdFhXa2xiV1RHSU1SNjA5?=
 =?utf-8?B?TnR1amVFVjI5OWN3dllGQ2t1dGZIekQ1MUlUcjNybUNQcHM0c1NBOVdTTWtO?=
 =?utf-8?B?VHNYNXlHTmxMblIzVEtpakZlR1czTERBRWR2RHFBdUY0Q25rVzBWeXlWaFdY?=
 =?utf-8?B?M29YU1ZQdlRoN3pKQll3a05LSGpvSkZOdHhtSUxSOSt4a2h1TFhob1k1TVlN?=
 =?utf-8?B?WWkyYXBuZngvMEYweVRqNGdBWGg1dHlxNytvZ3VZTDVhUm0xd2hUTkJWREpO?=
 =?utf-8?B?ekgvNlNkbFY3V3lncnE1TTVJelRSWmxsMHY4OWVsR2Zob0tIb2xJSU5ONzIw?=
 =?utf-8?B?R0V3TmhFOEZrZlZMSE15NGdYbGFMS29CR0ErY1lzRUhBVFYyZmZTU2tjRFpY?=
 =?utf-8?B?U09qLzhJL2lCakUvdkhNK3k3Q0RJRjNURm1FQU83VmlLNkNQUVdiUDR5Z01Y?=
 =?utf-8?B?alFLSXB1NEsyTzgxQ0VzNEEydkZQSUxqMmxNcmpMTEVseTFuL2NvU3pqSjAv?=
 =?utf-8?B?dnhaM0RyaTh2cEc5Sk9jUld2OERad29ldDg1bi9Rd0k2UXlEdE5lOFdOSnNw?=
 =?utf-8?B?RDBSMXZadzB0N1Jod0Y3TW8wNkZhVW8xQlgwR25LeXFUMjZJQmNzVjc3Tk1H?=
 =?utf-8?B?WDEybzF0NGVybzZaSnpVNUFYb0JRaGIveUFaeTYzSnoxUmtMazJ6cVNzMzVh?=
 =?utf-8?B?YVlYUUczN01RL2o4LzBKbjJwa01NUUgvbzBxM2pGYzJSRktadk42Yjg2NmhC?=
 =?utf-8?B?cWlkOTM2aWxsZ2lJdC9sbFg1VkpsZ1Q0RGtxWmgxU2prUURRVmlYK3hPQzlX?=
 =?utf-8?B?YkxGYkNVa2NpbDY3MCtxZ0oyMnF5cUMrT2M2aGZhN2NGSzZtN21nSzJRbnd2?=
 =?utf-8?B?UFVzemdCQS84NEg3aVdCRDJXT01DczBHYkhBdDlNNVh3WDZLQTFtcytIeUYy?=
 =?utf-8?B?NXBpRVBuQ2UxM3JjS1dLSTY0MzBuZUFaU0pad2tmVFdMNC9ub3hBMmo2blZ2?=
 =?utf-8?B?VEY3em9sRUpKcFZ3OU5qUDBqYU52RVduRHZDNFU4eTNnb1U3U1Y1RU5kd05x?=
 =?utf-8?Q?r3bNcGQ3+P8x6GOJZUb1uIIn8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b40ff3-bdf8-41de-363f-08da68acb79a
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 11:00:25.4096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJ0kz6b8cMbgePfMhrfzhJ+X0O1x1SbLXjq/NcNpplBJxQskXofzfnLv48uVuAvSx3TuMoy5LwRy7JkT6V3LmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3509
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Abel,

We've tested the patch on a dual socket Zen3 System (2 x 64C/128T).

tl;dr

- There is a noticeable regression for Hackbench with the system
  configured in NPS4 mode. This regression is more noticeable
  with SIS_UTIL enabled and not as severe with SIS_PROP.
  This regression is surprising given the patch should have
  improved SIS Efficiency in case of fully loaded system and is
  consistently reproducible across multiple runs and reboots.

- Apart from the above anomaly, the results look positive overall
  with the patched kernel behaving as well as, or better than the tip.

I'll leave the full test results below.

On 6/19/2022 5:34 PM, Abel Wu wrote:
>
> [..snip..]
> 
> Benchmark
> =========
> 
> Tests are done in an Intel Xeon(R) Platinum 8260 CPU@2.40GHz machine
> with 2 NUMA nodes each of which has 24 cores with SMT2 enabled, so 96
> CPUs in total.
> 
> All of the benchmarks are done inside a normal cpu cgroup in a clean
> environment with cpu turbo disabled.
> 
> Based on tip sched/core f3dd3f674555 (v5.19-rc2).
> 
> Results
> =======
> 
> hackbench-process-pipes
>                              vanilla		     filter
> Amean     1        0.2357 (   0.00%)      0.2540 (  -7.78%)
> Amean     4        0.6403 (   0.00%)      0.6363 (   0.62%)
> Amean     7        0.7583 (   0.00%)      0.7367 (   2.86%)
> Amean     12       1.0703 (   0.00%)      1.0520 (   1.71%)
> Amean     21       2.0363 (   0.00%)      1.9610 *   3.70%*
> Amean     30       3.2487 (   0.00%)      2.9083 *  10.48%*
> Amean     48       6.3620 (   0.00%)      4.8543 *  23.70%*
> Amean     79       8.3653 (   0.00%)      7.1077 *  15.03%*
> Amean     110      9.8370 (   0.00%)      8.5740 *  12.84%*
> Amean     141     11.4667 (   0.00%)     10.8750 *   5.16%*
> Amean     172     13.4433 (   0.00%)     12.6443 *   5.94%*
> Amean     203     15.8970 (   0.00%)     14.9143 *   6.18%*
> Amean     234     17.9643 (   0.00%)     16.9123 *   5.86%*
> Amean     265     20.3910 (   0.00%)     19.2040 *   5.82%*
> Amean     296     22.5253 (   0.00%)     21.2547 *   5.64%*
> 
> hackbench-process-sockets
>                              vanilla		     filter
> Amean     1        0.4177 (   0.00%)      0.4133 (   1.04%)
> Amean     4        1.4397 (   0.00%)      1.4240 *   1.09%*
> Amean     7        2.4720 (   0.00%)      2.4310 *   1.66%*
> Amean     12       4.1407 (   0.00%)      4.0683 *   1.75%*
> Amean     21       7.0550 (   0.00%)      6.8830 *   2.44%*
> Amean     30       9.9633 (   0.00%)      9.7750 *   1.89%*
> Amean     48      15.9837 (   0.00%)     15.5313 *   2.83%*
> Amean     79      26.7740 (   0.00%)     26.2703 *   1.88%*
> Amean     110     37.2913 (   0.00%)     36.5433 *   2.01%*
> Amean     141     47.8937 (   0.00%)     46.5300 *   2.85%*
> Amean     172     58.0273 (   0.00%)     56.4530 *   2.71%*
> Amean     203     68.2530 (   0.00%)     66.3320 *   2.81%*
> Amean     234     78.8987 (   0.00%)     76.8497 *   2.60%*
> Amean     265     89.1520 (   0.00%)     86.8213 *   2.61%*
> Amean     296     99.6920 (   0.00%)     96.9707 *   2.73%*
> 
> hackbench-thread-pipes
>                              vanilla		     filter
> Amean     1        0.2647 (   0.00%)      0.2633 (   0.50%)
> Amean     4        0.6290 (   0.00%)      0.6607 (  -5.03%)
> Amean     7        0.7850 (   0.00%)      0.7870 (  -0.25%)
> Amean     12       1.3347 (   0.00%)      1.2577 (   5.77%)
> Amean     21       3.1233 (   0.00%)      2.4613 *  21.20%*
> Amean     30       5.7120 (   0.00%)      3.6847 *  35.49%*
> Amean     48       8.1947 (   0.00%)      6.2670 *  23.52%*
> Amean     79       9.1750 (   0.00%)      8.0640 *  12.11%*
> Amean     110     10.6300 (   0.00%)      9.5583 *  10.08%*
> Amean     141     12.7490 (   0.00%)     12.0167 *   5.74%*
> Amean     172     15.1567 (   0.00%)     14.1570 *   6.60%*
> Amean     203     17.5160 (   0.00%)     16.7883 (   4.15%)
> Amean     234     19.8710 (   0.00%)     19.5370 (   1.68%)
> Amean     265     23.2700 (   0.00%)     21.4017 *   8.03%*
> Amean     296     25.4093 (   0.00%)     23.9943 *   5.57%*
> 
> hackbench-thread-sockets
>                              vanilla		     filter
> Amean     1        0.4467 (   0.00%)      0.4347 (   2.69%)
> Amean     4        1.4757 (   0.00%)      1.4533 *   1.51%*
> Amean     7        2.5320 (   0.00%)      2.4993 *   1.29%*
> Amean     12       4.2617 (   0.00%)      4.1780 *   1.96%*
> Amean     21       7.2397 (   0.00%)      7.0660 *   2.40%*
> Amean     30      10.2200 (   0.00%)      9.9810 *   2.34%*
> Amean     48      16.2623 (   0.00%)     16.0483 *   1.32%*
> Amean     79      27.4307 (   0.00%)     26.8410 *   2.15%*
> Amean     110     37.8993 (   0.00%)     37.3223 *   1.52%*
> Amean     141     48.3890 (   0.00%)     47.4823 *   1.87%*
> Amean     172     58.9887 (   0.00%)     57.7753 *   2.06%*
> Amean     203     69.5853 (   0.00%)     68.0563 *   2.20%*
> Amean     234     80.0743 (   0.00%)     78.4857 *   1.98%*
> Amean     265     90.5473 (   0.00%)     89.3363 *   1.34%*
> Amean     296    101.3857 (   0.00%)     99.7717 *   1.59%*
> 
> schbench
> 				   vanilla		   filter
> Lat 50.0th-qrtle-1         6.00 (   0.00%)        6.00 (   0.00%)
> Lat 75.0th-qrtle-1         8.00 (   0.00%)        8.00 (   0.00%)
> Lat 90.0th-qrtle-1         9.00 (   0.00%)        8.00 (  11.11%)
> Lat 95.0th-qrtle-1         9.00 (   0.00%)        8.00 (  11.11%)
> Lat 99.0th-qrtle-1        10.00 (   0.00%)        9.00 (  10.00%)
> Lat 99.5th-qrtle-1        11.00 (   0.00%)        9.00 (  18.18%)
> Lat 99.9th-qrtle-1        11.00 (   0.00%)        9.00 (  18.18%)
> Lat 50.0th-qrtle-2         6.00 (   0.00%)        7.00 ( -16.67%)
> Lat 75.0th-qrtle-2         7.00 (   0.00%)        8.00 ( -14.29%)
> Lat 90.0th-qrtle-2         8.00 (   0.00%)        9.00 ( -12.50%)
> Lat 95.0th-qrtle-2         8.00 (   0.00%)       10.00 ( -25.00%)
> Lat 99.0th-qrtle-2         9.00 (   0.00%)       11.00 ( -22.22%)
> Lat 99.5th-qrtle-2         9.00 (   0.00%)       11.00 ( -22.22%)
> Lat 99.9th-qrtle-2         9.00 (   0.00%)       11.00 ( -22.22%)
> Lat 50.0th-qrtle-4         9.00 (   0.00%)        8.00 (  11.11%)
> Lat 75.0th-qrtle-4        10.00 (   0.00%)       10.00 (   0.00%)
> Lat 90.0th-qrtle-4        11.00 (   0.00%)       11.00 (   0.00%)
> Lat 95.0th-qrtle-4        12.00 (   0.00%)       11.00 (   8.33%)
> Lat 99.0th-qrtle-4        13.00 (   0.00%)       13.00 (   0.00%)
> Lat 99.5th-qrtle-4        13.00 (   0.00%)       16.00 ( -23.08%)
> Lat 99.9th-qrtle-4        13.00 (   0.00%)       19.00 ( -46.15%)
> Lat 50.0th-qrtle-8        11.00 (   0.00%)       11.00 (   0.00%)
> Lat 75.0th-qrtle-8        14.00 (   0.00%)       14.00 (   0.00%)
> Lat 90.0th-qrtle-8        16.00 (   0.00%)       16.00 (   0.00%)
> Lat 95.0th-qrtle-8        17.00 (   0.00%)       17.00 (   0.00%)
> Lat 99.0th-qrtle-8        22.00 (   0.00%)       19.00 (  13.64%)
> Lat 99.5th-qrtle-8        28.00 (   0.00%)       23.00 (  17.86%)
> Lat 99.9th-qrtle-8        31.00 (   0.00%)       42.00 ( -35.48%)
> Lat 50.0th-qrtle-16       17.00 (   0.00%)       17.00 (   0.00%)
> Lat 75.0th-qrtle-16       23.00 (   0.00%)       23.00 (   0.00%)
> Lat 90.0th-qrtle-16       26.00 (   0.00%)       27.00 (  -3.85%)
> Lat 95.0th-qrtle-16       28.00 (   0.00%)       29.00 (  -3.57%)
> Lat 99.0th-qrtle-16       32.00 (   0.00%)       33.00 (  -3.12%)
> Lat 99.5th-qrtle-16       37.00 (   0.00%)       35.00 (   5.41%)
> Lat 99.9th-qrtle-16       54.00 (   0.00%)       46.00 (  14.81%)
> Lat 50.0th-qrtle-32       30.00 (   0.00%)       29.00 (   3.33%)
> Lat 75.0th-qrtle-32       43.00 (   0.00%)       42.00 (   2.33%)
> Lat 90.0th-qrtle-32       51.00 (   0.00%)       49.00 (   3.92%)
> Lat 95.0th-qrtle-32       54.00 (   0.00%)       51.00 (   5.56%)
> Lat 99.0th-qrtle-32       61.00 (   0.00%)       57.00 (   6.56%)
> Lat 99.5th-qrtle-32       64.00 (   0.00%)       60.00 (   6.25%)
> Lat 99.9th-qrtle-32       72.00 (   0.00%)       82.00 ( -13.89%)
> Lat 50.0th-qrtle-47       44.00 (   0.00%)       45.00 (  -2.27%)
> Lat 75.0th-qrtle-47       64.00 (   0.00%)       65.00 (  -1.56%)
> Lat 90.0th-qrtle-47       75.00 (   0.00%)       77.00 (  -2.67%)
> Lat 95.0th-qrtle-47       81.00 (   0.00%)       82.00 (  -1.23%)
> Lat 99.0th-qrtle-47       92.00 (   0.00%)       98.00 (  -6.52%)
> Lat 99.5th-qrtle-47      101.00 (   0.00%)      114.00 ( -12.87%)
> Lat 99.9th-qrtle-47      271.00 (   0.00%)      167.00 (  38.38%)
> 
> netperf-udp
> 				    vanilla		    filter
> Hmean     send-64         199.12 (   0.00%)      201.32 (   1.11%)
> Hmean     send-128        396.22 (   0.00%)      397.01 (   0.20%)
> Hmean     send-256        777.80 (   0.00%)      783.96 (   0.79%)
> Hmean     send-1024      2972.62 (   0.00%)     3011.87 *   1.32%*
> Hmean     send-2048      5600.64 (   0.00%)     5730.50 *   2.32%*
> Hmean     send-3312      8757.45 (   0.00%)     8703.62 (  -0.61%)
> Hmean     send-4096     10578.90 (   0.00%)    10590.93 (   0.11%)
> Hmean     send-8192     17051.22 (   0.00%)    17189.62 *   0.81%*
> Hmean     send-16384    27915.16 (   0.00%)    27816.01 (  -0.36%)
> Hmean     recv-64         199.12 (   0.00%)      201.32 (   1.11%)
> Hmean     recv-128        396.22 (   0.00%)      397.01 (   0.20%)
> Hmean     recv-256        777.80 (   0.00%)      783.96 (   0.79%)
> Hmean     recv-1024      2972.62 (   0.00%)     3011.87 *   1.32%*
> Hmean     recv-2048      5600.64 (   0.00%)     5730.49 *   2.32%*
> Hmean     recv-3312      8757.45 (   0.00%)     8703.61 (  -0.61%)
> Hmean     recv-4096     10578.90 (   0.00%)    10590.93 (   0.11%)
> Hmean     recv-8192     17051.21 (   0.00%)    17189.57 *   0.81%*
> Hmean     recv-16384    27915.08 (   0.00%)    27815.86 (  -0.36%)
> 
> netperf-tcp
> 			       vanilla		       filter
> Hmean     64         811.07 (   0.00%)      835.46 *   3.01%*
> Hmean     128       1614.86 (   0.00%)     1652.27 *   2.32%*
> Hmean     256       3131.16 (   0.00%)     3119.01 (  -0.39%)
> Hmean     1024     10286.12 (   0.00%)    10333.64 (   0.46%)
> Hmean     2048     16231.88 (   0.00%)    17141.88 *   5.61%*
> Hmean     3312     20705.91 (   0.00%)    21703.49 *   4.82%*
> Hmean     4096     22650.75 (   0.00%)    23904.09 *   5.53%*
> Hmean     8192     27984.06 (   0.00%)    29170.57 *   4.24%*
> Hmean     16384    32816.85 (   0.00%)    33351.41 *   1.63%*
> 
> tbench4 Throughput
> 			     vanilla		     filter
> Hmean     1        300.07 (   0.00%)      302.52 *   0.82%*
> Hmean     2        617.72 (   0.00%)      598.45 *  -3.12%*
> Hmean     4       1213.99 (   0.00%)     1206.36 *  -0.63%*
> Hmean     8       2373.78 (   0.00%)     2372.28 *  -0.06%*
> Hmean     16      4777.82 (   0.00%)     4711.44 *  -1.39%*
> Hmean     32      7182.50 (   0.00%)     7718.15 *   7.46%*
> Hmean     64      8611.44 (   0.00%)     9409.29 *   9.27%*
> Hmean     128    18102.63 (   0.00%)    20650.23 *  14.07%*
> Hmean     256    18029.28 (   0.00%)    20611.03 *  14.32%*
> Hmean     384    17986.44 (   0.00%)    19361.29 *   7.64%
Following are the results from dual socket Zen3 platform (2 x 64C/128T) running with
various NPS configuration:

Following is the NUMA configuration for each NPS mode on the system:

NPS1: Each socket is a NUMA node.
    Total 2 NUMA nodes in the dual socket machine.

    Node 0: 0-63,   128-191
    Node 1: 64-127, 192-255

NPS2: Each socket is further logically divided into 2 NUMA regions.
    Total 4 NUMA nodes exist over 2 socket.
   
    Node 0: 0-31,   128-159
    Node 1: 32-63,  160-191
    Node 2: 64-95,  192-223
    Node 3: 96-127, 223-255

NPS4: Each socket is logically divided into 4 NUMA regions.
    Total 8 NUMA nodes exist over 2 socket.
   
    Node 0: 0-15,    128-143
    Node 1: 16-31,   144-159
    Node 2: 32-47,   160-175
    Node 3: 48-63,   176-191
    Node 4: 64-79,   192-207
    Node 5: 80-95,   208-223
    Node 6: 96-111,  223-231
    Node 7: 112-127, 232-255

Kernel versions:
- tip:         5.19-rc2 tip sched/core
- SIS_Eff:     5.19-rc2 tip sched/core + this patch series

When we started testing, the tip was at:
commit: c02d5546ea34 "sched/core: Use try_cmpxchg in set_nr_{and_not,if}_polling"

Note: All the testing was done with SIS_UTIL as the default SIS logic.

~~~~~~~~~
Hackbench
~~~~~~~~~

NPS1

Test:                   tip                     SIS_Eff
 1-groups:         4.85 (0.00 pct)         4.83 (0.41 pct)
 2-groups:         5.06 (0.00 pct)         5.24 (-3.55 pct)
 4-groups:         5.25 (0.00 pct)         5.29 (-0.76 pct)
 8-groups:         5.64 (0.00 pct)         5.57 (1.24 pct)
16-groups:         7.46 (0.00 pct)         7.40 (0.80 pct)

NPS2

Test:                   tip                     SIS_Eff
 1-groups:         4.73 (0.00 pct)         4.70 (0.63 pct)
 2-groups:         4.94 (0.00 pct)         4.95 (-0.20 pct)
 4-groups:         5.14 (0.00 pct)         5.10 (0.77 pct)
 8-groups:         5.59 (0.00 pct)         5.48 (1.96 pct)
16-groups:         7.42 (0.00 pct)         7.52 (-1.34 pct)

NPS4

Test:                   tip                     SIS_Eff
 1-groups:         4.75 (0.00 pct)         4.76 (-0.21 pct)
 2-groups:         5.10 (0.00 pct)         5.01 (1.76 pct)
 4-groups:         5.87 (0.00 pct)         5.54 (5.62 pct)
 8-groups:         5.97 (0.00 pct)         6.30 (-5.52 pct)     *
 8-groups:         5.80 (0.00 pct)         5.95 (-2.58 pct)     [Verification Run]
16-groups:         8.33 (0.00 pct)        13.45 (-61.46 pct)    * (System Overloaded ~ 2.5 task per CPU)
16-groups:         8.25 (0.00 pct)        14.26 (-72.84 pct)    [Verification Run]
16-groups:         8.25 (0.00 pct)        13.44 (-62.90 pct)    [Verification Run]

~~~~~~~~
schbench
~~~~~~~~

NPS1

#workers:     tip                     SIS_Eff
  1:      24.50 (0.00 pct)        19.00 (22.44 pct)
  2:      28.00 (0.00 pct)        37.50 (-33.92 pct)    *
  2:      21.50 (0.00 pct)        23.00 (-6.97 pct)     [Verification Run]
  4:      35.50 (0.00 pct)        31.00 (12.67 pct)
  8:      44.50 (0.00 pct)        43.50 (2.24 pct)
 16:      69.50 (0.00 pct)        67.00 (3.59 pct)
 32:     103.00 (0.00 pct)       102.50 (0.48 pct)
 64:     183.50 (0.00 pct)       183.00 (0.27 pct)
128:     388.50 (0.00 pct)       380.50 (2.05 pct)
256:     868.00 (0.00 pct)       868.00 (0.00 pct)
512:     57856.00 (0.00 pct)     60224.00 (-4.09 pct)

NPS2

#workers:     tip                     SIS_Eff
  1:      18.50 (0.00 pct)        18.50 (0.00 pct)
  2:      33.00 (0.00 pct)        27.50 (16.66 pct)
  4:      37.00 (0.00 pct)        35.50 (4.05 pct)
  8:      54.00 (0.00 pct)        52.50 (2.77 pct)
 16:      70.50 (0.00 pct)        74.00 (-4.96 pct) *
 16:      79.00 (0.00 pct)        71.00 (10.12 pct) [Verification Run]
 32:     103.50 (0.00 pct)       105.00 (-1.44 pct)
 64:     183.50 (0.00 pct)       192.00 (-4.63 pct) *
 64:     179.50 (0.00 pct)       179.50 (0.00 pct)  [Verification Run]
128:     378.50 (0.00 pct)       380.00 (-0.39 pct)
256:     902.00 (0.00 pct)       907.00 (-0.55 pct)
512:     58304.00 (0.00 pct)     60160.00 (-3.18 pct)

NPS4

#workers:     tip                     SIS_Eff
  1:      20.50 (0.00 pct)        18.50 (9.75 pct)
  2:      35.00 (0.00 pct)        35.50 (-1.42 pct)
  4:      36.00 (0.00 pct)        36.00 (0.00 pct)
  8:      47.00 (0.00 pct)        52.00 (-10.63 pct)  *
  8:      54.00 (0.00 pct)        51.00 (5.55 pct)    [Verification Run]
 16:      83.50 (0.00 pct)        85.00 (-1.79 pct)
 32:     102.50 (0.00 pct)       102.50 (0.00 pct)
 64:     178.50 (0.00 pct)       181.00 (-1.40 pct)
128:     366.50 (0.00 pct)       380.00 (-3.68 pct)
256:     921.00 (0.00 pct)       920.00 (0.10 pct)
512:     60032.00 (0.00 pct)     60096.00 (-0.10 pct)

Note: schbench shows run to run variance which is linked to
new idle balance.

~~~~~~
tbench
~~~~~~

NPS1

Clients:      tip                     SIS_Eff
    1    446.42 (0.00 pct)       446.15 (-0.06 pct)
    2    869.92 (0.00 pct)       876.12 (0.71 pct)
    4    1637.44 (0.00 pct)      1641.65 (0.25 pct)
    8    3210.27 (0.00 pct)      3213.43 (0.09 pct)
   16    6196.44 (0.00 pct)      5972.09 (-3.62 pct)
   32    11844.65 (0.00 pct)     10903.18 (-7.94 pct)   *
   32    11761.81 (0.00 pct)     12072.37 (2.64 pct)    [Verification Run]
   64    21678.40 (0.00 pct)     21747.25 (0.31 pct)
  128    31311.82 (0.00 pct)     31499.24 (0.59 pct)
  256    50250.62 (0.00 pct)     50930.33 (1.35 pct)
  512    51377.40 (0.00 pct)     51377.19 (0.00 pct)
 1024    53628.03 (0.00 pct)     53876.23 (0.46 pct)

NPS2

Clients:      tip                     SIS_Eff
    1    445.03 (0.00 pct)       447.66 (0.59 pct)
    2    865.65 (0.00 pct)       872.88 (0.83 pct)
    4    1619.09 (0.00 pct)      1645.17 (1.61 pct)
    8    3117.29 (0.00 pct)      3168.90 (1.65 pct)
   16    5950.42 (0.00 pct)      5657.02 (-4.93 pct)    *
   16    5663.73 (0.00 pct)      5915.61 (4.44 pct)     [Verification Run]
   32    11708.61 (0.00 pct)     11342.37 (-3.12 pct)
   64    20415.11 (0.00 pct)     20876.49 (2.25 pct)
  128    30134.02 (0.00 pct)     29912.02 (-0.73 pct)
  256    41660.75 (0.00 pct)     49418.80 (18.62 pct)
  512    49560.67 (0.00 pct)     52372.63 (5.67 pct)
 1024    52340.77 (0.00 pct)     53714.13 (2.62 pct)

NPS4

Clients:      tip                     SIS_Eff
    1    441.41 (0.00 pct)       446.12 (1.06 pct)
    2    863.53 (0.00 pct)       871.30 (0.89 pct)
    4    1646.06 (0.00 pct)      1646.85 (0.04 pct)
    8    3160.26 (0.00 pct)      3103.85 (-1.78 pct)
   16    5605.21 (0.00 pct)      5853.23 (4.42 pct)
   32    10657.29 (0.00 pct)     11397.58 (6.94 pct)
   64    21054.34 (0.00 pct)     20234.69 (-3.89 pct)
  128    31285.51 (0.00 pct)     30188.03 (-3.50 pct)
  256    49287.47 (0.00 pct)     51330.34 (4.14 pct)
  512    50042.95 (0.00 pct)     52658.13 (5.22 pct)
 1024    52589.40 (0.00 pct)     53067.80 (0.90 pct)

~~~~~~
Stream
~~~~~~

- 10 runs

NPS1

Test:         tip                     SIS_Eff
 Copy:   211443.49 (0.00 pct)    224768.55 (6.30 pct)
Scale:   209797.67 (0.00 pct)    208050.69 (-0.83 pct)
  Add:   250586.89 (0.00 pct)    250268.08 (-0.12 pct)
Triad:   243034.31 (0.00 pct)    244552.37 (0.62 pct)

NPS2

Test:         tip                     SIS_Eff
 Copy:   146432.23 (0.00 pct)    140412.56 (-4.11 pct)
Scale:   179508.95 (0.00 pct)    178038.96 (-0.81 pct)
  Add:   188328.69 (0.00 pct)    189046.25 (0.38 pct)
Triad:   186353.95 (0.00 pct)    187660.23 (0.70 pct)

NPS4

Test:         tip                     SIS_Eff
 Copy:   133934.59 (0.00 pct)    132595.29 (-0.99 pct)
Scale:   179877.71 (0.00 pct)    185094.80 (2.90 pct)
  Add:   178079.94 (0.00 pct)    186399.22 (4.67 pct)
Triad:   177277.29 (0.00 pct)    184725.00 (4.20 pct)

- 100 runs

NPS1

Test:          tip                     SIS_Eff
 Copy:   220780.64 (0.00 pct)    226194.97 (2.45 pct)
Scale:   204372.85 (0.00 pct)    209461.05 (2.48 pct)
  Add:   245548.31 (0.00 pct)    253363.99 (3.18 pct)
Triad:   233611.73 (0.00 pct)    242670.41 (3.87 pct)

NPS2

Test:          tip                     SIS_Eff
 Copy:   229624.58 (0.00 pct)    233458.30 (1.66 pct)
Scale:   210163.13 (0.00 pct)    211198.12 (0.49 pct)
  Add:   261992.62 (0.00 pct)    260243.74 (-0.66 pct)
Triad:   248713.02 (0.00 pct)    247594.21 (-0.44 pct)

NPS4

Test:          tip                     SIS_Eff
 Copy:   249308.79 (0.00 pct)    245362.22 (-1.58 pct)
Scale:   218948.88 (0.00 pct)    217819.07 (-0.51 pct)
  Add:   268469.03 (0.00 pct)    270935.96 (0.91 pct)
Triad:   251920.99 (0.00 pct)    255730.95 (1.51 pct)

~~~~~~~~~~~~
ycsb-mongodb
~~~~~~~~~~~~

NPS1

tip:            289306.33 (var: 0.91)
SIS_Eff:        293789.33 (var: 1.38)   (1.54 pct)

NPS2

NPS2

tip:            290226.00 (var: 1.62)
SIS_Eff         290796.00 (var: 1.76)   (0.19 pct)

NPS4

tip:            290427.33 (var: 1.57)
SIS_Eff:        288134.33 (var: 0.88)   (-0.78pct) 

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Hackbench - 15 runs statistics
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

o NPS 4 - 16 groups (SIS_UTIL)

- tip

Min           : 7.35
Max           : 12.66
Median        : 10.60
AMean         : 10.00
GMean         : 9.82
HMean         : 9.64
AMean Stddev  : 1.88
AMean CoefVar : 18.85 pct

- SIS_Eff

Min           : 12.32
Max           : 18.92
Median        : 13.82
AMean         : 14.96	(-49.60 pct)
GMean         : 14.80
HMean         : 14.66
AMean Stddev  : 2.25
AMean CoefVar : 15.01 pct

o NPS 4 - 16 groups (SIS_PROP)

- tip

Min           : 7.04
Max           : 8.22
Median        : 7.49
AMean         : 7.52
GMean         : 7.52
HMean         : 7.51
AMean Stddev  : 0.29
AMean CoefVar : 3.88 pct

- SIS_Eff

Min           : 7.04
Max           : 9.78
Median        : 8.16
AMean         : 8.42	(-11.06 pct)
GMean         : 8.39
HMean         : 8.36
AMean Stddev  : 0.78
AMean CoefVar : 9.23 pct

The Hackbench regression is much more noticeable with SIS_UTIL
enabled but only when the test machine is running in NPS4 mode.
It is not obvious why this is happening given the patch series
aims at improving SIS Efficiency.

It would be great if you can test the series with SIS_UTIL
enabled and SIS_PROP disabled to see if it effects any benchmark
behavior given SIS_UTIL is the default SIS logic currently on
the tip.

> 
> [..snip..]
> 
Please let me know if you need any more data from the
test system.
--
Thanks and Regards,
Prateek
