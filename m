Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A10525BAD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 08:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377394AbiEMGhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377387AbiEMGhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:37:20 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E63606FD
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 23:37:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7jA4yJdvfjFTr4sEoyBSNJFJwIlE2bOMo9cJRyAdFAyTz7r0z0l3hUVQGaINlk3GtWdOhz2bO3hBclfrfPTLZy123ju7SEFp1M7jHJD9RTfL9xcop+dGlxsx2Qf4ySn2ncl0vxO8JlRqXFFJYzcgQOFy7tDqT77GxurUBFpa5wE9GujZsdvVXdEWOnYSPx6OacxFY1BjwFFrppp8ooMKWpGgV+hlGTN7LqH56aJW0haao1v9BPMsDygVk7p2yKqN3nyKRT89XpnKRUxxKW2ouUdx+swXnEFsB/6+jGu5zLX+ZAiJKI9jXstl4fF9FCx9qQurB4Z/xAe8yQY4JK+Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxSZLdsiKs3J/9TFC+l7DDbtx+lnGV8F8wzJ8KjG7Xs=;
 b=ggFBHndyhbWIpSUPyPd1brJ3TCZfm6a77X8zsD0BBI/0ZFYuoP5VHccJ8lyfvaT1ea4MgSFd/ZDGBaQeiPdKdLdAKifRPwEwVPDrKYwhvEJDbjM0T9zuBdfh51fa+06BNWyATsoVGMEWxc4jq014WyxoA9diansmONxInogcv2ohpYYzc87PhJKMEFO3f/zo2yT2zq/WqLVym9KHpZJAssyXr6P1KI+623ThZO/AFdLQTP2VGckDtZDOKewK8ZcAExvgarXRaXf1fabCGXBr8LVT0z8nVkMjhAkVr3h/ltS/zhxgiVs4LnOwvk0SolLin05D1GeK6Amz8NFliybXpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxSZLdsiKs3J/9TFC+l7DDbtx+lnGV8F8wzJ8KjG7Xs=;
 b=Qp5Q9SWK3ERr3UupuzhfA4gsDzoT//ODmOGXzHVBbhMwlGQBxf99puJte0PzuBdFE1oXjjiQ5004j/3iGN8AjHWdVTHO+EHVV2fBcwSksIWVbat3/auu/8yDEDQ+/if1fjYhGXUwGX49agBV/KjlJQiw6/srKcG1p1QtexOr2YY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by MW2PR12MB2522.namprd12.prod.outlook.com (2603:10b6:907:f::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Fri, 13 May
 2022 06:37:14 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::ad62:2a53:3afa:3567]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::ad62:2a53:3afa:3567%6]) with mapi id 15.20.5227.023; Fri, 13 May 2022
 06:37:14 +0000
Message-ID: <ed985eb5-abc7-34f4-7a10-e3a08800b324@amd.com>
Date:   Fri, 13 May 2022 12:07:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3] sched/fair: Introduce SIS_UTIL to search idle CPU
 based on sum of util_avg
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Tim Chen <tim.c.chen@intel.com>
Cc:     Chen Yu <yu.chen.surf@gmail.com>, Ingo Molnar <mingo@redhat.com>,
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
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20220428182442.659294-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0029.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::14) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3de9ec90-773a-4d25-b044-08da34ab0421
X-MS-TrafficTypeDiagnostic: MW2PR12MB2522:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB25227A5CF16F684E3536386B98CA9@MW2PR12MB2522.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LKxvydy81uO1GBmnDX9S5za6f7l7DZ+E8eWs6n7/D1RO3/MWyAAPR3zO8CzJe3g4hvfc3TEW2mGZePl5mSB7antge6WH8Pm5umGQh9HYY8lZRLoeQ2J13kRTFdxHqUJWlHV1BxxdL7lmxieJCRKe0VF0RRG/cubVRdiTZyWAT/GTDdcSPMODfsTt7xg/6t+iqOJV5fzTJ+PgWfJjO1Nt1JAVgdE5tsbYA0KUUfaQHewRUBcoRhGfauDLR0P+T0if54cqAkAkO7cbC9CAXYv06DB36HIshRT1SC/RhqJ3IpVaPmAJsFTw+trNJRsGjA+JH/Rh62wvpFMNyosQoz4QOzCjnbW15YfiViS31rBVIUH0d94TrF52ZCo1/hKTLeFdJf88M7ftqKaPtbR5zEkQk7YujbBKz4rTZlRvUFU7HhSlLAtSI/d23tQljupN92yMMdW1zdvutL+670YUUzF3XUzWK/WLICTvRD9HdcRS7sZiVGCuun4zWGDcKUZ0H+YUf0UVORBnqeyn36G65V58UKzD5u1QHkjRDwOVMTSGx6/1X/vd0nsg0MTqezb2Xl3DnPeVlzlEr/wLU49LGgU3aHb2zkjgvhB2tL9m91doZ7OC/zq/gng11DLOiaGFSkoy2VOTKzsn+Jimn21WiUaAK/gJ/akdagRq5I553erDzzLQxbYDKC8sfTKDrt1eulwWg7S7EhhAmuO0l9pKaHCV69z4FeDI/irLwP8AO78IhDvu3Djcy//JFQ/m+6eKJOIv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(31696002)(86362001)(53546011)(30864003)(6506007)(6666004)(8936002)(508600001)(5660300002)(7416002)(83380400001)(38100700002)(26005)(2616005)(6512007)(186003)(316002)(36756003)(110136005)(31686004)(66476007)(66946007)(66556008)(4326008)(54906003)(8676002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlNmYW5tcWFwZVBzNnd5dGJOM1pBVlpEc0p0OUhaenFsS0FCbDk0bERnWk40?=
 =?utf-8?B?bExwSHNBTmdicWh6OGF3N0hMZHZ5bXdWaDdvSGh3RlhRVzN5cGIzdE1NNCtj?=
 =?utf-8?B?TkZPNWwycUowN2ZFMzA4T24reGs3YTQwVmJORytQWFhsUGtzNWJpZWpEaHk0?=
 =?utf-8?B?VW94T2x6YTJFTTR3QkhjSWVsTVpuMmMxRXBmWE16QS9BUnFyYzZGVGl4L21j?=
 =?utf-8?B?RVZNOVhUUWxhNXZtNWo1TXAwUXNkdzFhTHZKazBMdk5JYkZCdWgwbWNGR1Jr?=
 =?utf-8?B?N3NRZXpmM2g0UjJtK1p4NEh4VzFJV0c4WkZTYXc3SmFJUk1aek0vSVdGeHN3?=
 =?utf-8?B?Zks2b0lzWjcyQU5XT3lPSkt6UlM2SDVmOUNLcjJCcGlKNTJzTmd1NHBrV2FZ?=
 =?utf-8?B?N2ozbE9TdVI4NDZpd1JHVmRJOVNHaU42bU9mRGY5c292QVFGbnc5WHVWWWVy?=
 =?utf-8?B?ZXVySHpwdE1adlE3bUxBRUtvcWZNS1NsV2VTZmJiemdvSWJzUnVaY1NGMnZj?=
 =?utf-8?B?R1FSbmtud0xXcnQwN2pYWFRuRHFQdWlieExMNjJEd3VWM3VIWjl6UHNqQnRj?=
 =?utf-8?B?emFkMkpIMEJhZTFmZmJQK3lhSXA2RWNQOE1NbVFMSGw3c2o0OExXLy85M0p2?=
 =?utf-8?B?N3Ewb2l1RHdKZFBETmYwVXVmYVBKaG5LTm1QMzZTdU5zdnlvN3Q4aVdHTWpo?=
 =?utf-8?B?VlpmWVpXdUVaTnU1ZWRybU1jeFRkdWpvTEp6U29CQVVzSnR0czVkYmd5TGdP?=
 =?utf-8?B?Z1hHV2R6eGMwNDFSNmpzTXowMWFCbzFySFVLUmRJSFExRUFsTkE0RHVpZDBW?=
 =?utf-8?B?MFZiTGRtRDZuazFQb0gzZ1JTVmdzdlFSbEJkeE9aM05HWlRYMXFadlk4TytQ?=
 =?utf-8?B?U012cnlIUWlNRHVGUVlsdEIxbGhXL3RIYTFIY0Q2SzNvSmtxRnVzS0hiaWdw?=
 =?utf-8?B?SnA2ZjE4WWRQOHh6b3Z1Ym1jdzh6N1ZYQ3hod3FrNUhlRldja0tMenQ4bFZz?=
 =?utf-8?B?WC81OG54RG5jaFVNK1BIRm1xVm5sUkhvTVJpRUJIMUs0T3ZySmRSZUp5YU4w?=
 =?utf-8?B?d1pUWjlvdjhiUDlneXp0SDdHVDBDRk5adnZBdEJ3QWYwYk5sOE9OeGxMVU1M?=
 =?utf-8?B?cm13V05nSFV5SFZnVGpaMWp4aGQzeGRDNHg5WWp1bmpPV2p4MXExL3M5TU9l?=
 =?utf-8?B?UWtNSVhmM1QzQmFncnN2Wnhya25JbjBIZG5sR2swSXRNTU93cmRaQjVkNkdy?=
 =?utf-8?B?cW9oTkRwYWlaR3U4K2wzRDlYL1pBMXNRS3QxeTRDOFJKK0lXaFVMdkRqWjlv?=
 =?utf-8?B?SktUam42b1ZGUVdzSndFbHNLbzF4aDFZbnVNamlDcC9Ub0Jidm1XcFVJdzVH?=
 =?utf-8?B?bzQwamlqT0NNS0xZZjlqVFVlVzUxTXVwM2gzSzJScEFYbHY2VHlYVFIzSnhn?=
 =?utf-8?B?N25YcVlFTGYzbW9XejdNazM2TDhoblFSaXQ5cy9odDBRLzdtWUNaRi92cHNX?=
 =?utf-8?B?cm9veFpDd1FTV0pGSVRyVENJVG9QNWc3SDBONDBnYUJTS05ockFKbllPWTVY?=
 =?utf-8?B?dG9VMngzTVRwdlF4TGkzRWE0eUpoY0JZQktGb09JbXBWZzA1QWNmQ0FON2tx?=
 =?utf-8?B?b0hLenh5WDg0YTFuQ3g1QitXSDZqMnVQd2ZrRUVPaXhYWUZya0pZOFFmb2FZ?=
 =?utf-8?B?UmNocWlWckVIbkIyakVBTGlIU2ZPWm1UaGg4S1ZoMzhJQit3Z3VFSUw2dTR1?=
 =?utf-8?B?RGxFMzIzSThQbjBoRUJnYWR5bE01aVRSQ3lrNWlkcDhjNUJWRitDWkcyMDhV?=
 =?utf-8?B?eE4yS1VRdGZHRFdMNWp0bVBwNWVTVDBCV0p0d2tmTjA1UUU2M3ozd3ZlSE1o?=
 =?utf-8?B?Nm03elB6dU1PWDJVK1JCajB6QUZjWThQckp3aDRaenRDMVdmNzl6SlN3MDEw?=
 =?utf-8?B?Si9uNWUyNUhYWVA0Z0xGeWFJWUJ6dUFNak05d3JSZEZrMTNrMitVSElDQjIv?=
 =?utf-8?B?aUlFZ3Zka3hVWXorNzladFB6QkZkYXR1L1RyS2dlbitTazUrSU15WWE4bllC?=
 =?utf-8?B?dkI5NHp6UkpsVHBpbE1EeXZGRWFXYUJzKzBTdVptRjVuRWpNMENzZFIzcUpi?=
 =?utf-8?B?aGx0dFlBRmphcUdZZVgvd0plS0VkUHJxR1BCQWtMMjRHdGV6cWdRYS9GaDgw?=
 =?utf-8?B?M1hrZGh3b01oTWEzNEx1MklyeXVsT21QU01xMllLMnR0cEFRYVlPNDdydGpG?=
 =?utf-8?B?d3pXZzd6WmYxbFgzRkgxMjkxbVYxK2g5Y01EVTBscXdvTXU2WjJ3L2lWVm1h?=
 =?utf-8?B?bFFLSEVYS0t4Tko2WEQxZUphTWl3YlFFSXcvaFJqTDd2c21CZlc5Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de9ec90-773a-4d25-b044-08da34ab0421
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 06:37:14.4871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MlgGYSh4utet5/dGO/lRO/Zr+VXUX4xlmtTdIA+0bqxbOFVvloL4oQLfsmok/FrR5zzLtsvlpIT299PIHRp2Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2522
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chenyu,

Sorry for the delay with analysis.

On 4/28/2022 11:54 PM, Chen Yu wrote:
> [Problem Statement]
> select_idle_cpu() might spend too much time searching for an idle CPU,
> when the system is overloaded.
>
> [..snip..]
>
> [Test result]
>
> The following is the benchmark result comparison between
> baseline:vanilla and compare:patched kernel. Positive compare%
> indicates better performance.
>
> netperf.throughput
> each thread: netperf -4 -H 127.0.0.1 -t TCP/UDP_RR -c -C -l 100
> =======
> case            	load    	baseline(std%)	compare%( std%)
> TCP_RR          	28 threads	 1.00 (  0.40)	 +1.14 (  0.37)
> TCP_RR          	56 threads	 1.00 (  0.49)	 +0.62 (  0.31)
> TCP_RR          	84 threads	 1.00 (  0.50)	 +0.26 (  0.55)
> TCP_RR          	112 threads	 1.00 (  0.27)	 +0.29 (  0.28)
> TCP_RR          	140 threads	 1.00 (  0.22)	 +0.14 (  0.23)
> TCP_RR          	168 threads	 1.00 (  0.21)	 +0.40 (  0.19)
> TCP_RR          	196 threads	 1.00 (  0.18)	+183.40 ( 16.43)
> TCP_RR          	224 threads	 1.00 (  0.16)	+188.44 (  9.29)
> UDP_RR          	28 threads	 1.00 (  0.47)	 +1.45 (  0.47)
> UDP_RR          	56 threads	 1.00 (  0.28)	 -0.22 (  0.30)
> UDP_RR          	84 threads	 1.00 (  0.38)	 +1.72 ( 27.10)
> UDP_RR          	112 threads	 1.00 (  0.16)	 +0.01 (  0.18)
> UDP_RR          	140 threads	 1.00 ( 14.10)	 +0.32 ( 11.15)
> UDP_RR          	168 threads	 1.00 ( 12.75)	 +0.91 ( 11.62)
> UDP_RR          	196 threads	 1.00 ( 14.41)	+191.97 ( 19.34)
> UDP_RR          	224 threads	 1.00 ( 15.34)	+194.88 ( 17.06)
>
> Take the 224 threads as an example, the SIS search metrics changes are
> illustrated below:
>
>     vanilla                    patched
>    4544492          +237.5%   15338634        sched_debug.cpu.sis_domain_search.avg
>      38539        +39686.8%   15333634        sched_debug.cpu.sis_failed.avg
>   128300000          -87.9%   15551326        sched_debug.cpu.sis_scanned.avg
>    5842896          +162.7%   15347978        sched_debug.cpu.sis_search.avg
>
> There is -87.9% less CPU scans after patched, which indicates lower overhead.
> Besides, with this patch applied, there is -13% less rq lock contention
> in perf-profile.calltrace.cycles-pp._raw_spin_lock.raw_spin_rq_lock_nested
> .try_to_wake_up.default_wake_function.woken_wake_function.
> This could help explain the performance improvement - Because this patch allows
> the waking task to remain on the previous CPU, rather than grabbing other CPU's
> lock.
>
> Other benchmarks:
>
> hackbench.throughput
> =========
> case            	load    	baseline(std%)	compare%( std%)
> process-pipe    	1 group 	 1.00 (  0.09)	 -0.54 (  0.82)
> process-pipe    	2 groups 	 1.00 (  0.47)	 +0.89 (  0.61)
> process-pipe    	4 groups 	 1.00 (  0.83)	 +0.90 (  0.15)
> process-pipe    	8 groups 	 1.00 (  0.09)	 +0.31 (  0.07)
> process-sockets 	1 group 	 1.00 (  0.13)	 -0.58 (  0.49)
> process-sockets 	2 groups 	 1.00 (  0.41)	 -0.58 (  0.52)
> process-sockets 	4 groups 	 1.00 (  0.61)	 -0.37 (  0.50)
> process-sockets 	8 groups 	 1.00 (  0.22)	 +1.15 (  0.10)
> threads-pipe    	1 group 	 1.00 (  0.35)	 -0.28 (  0.78)
> threads-pipe    	2 groups 	 1.00 (  0.65)	 +0.03 (  0.96)
> threads-pipe    	4 groups 	 1.00 (  0.43)	 +0.81 (  0.38)
> threads-pipe    	8 groups 	 1.00 (  0.11)	 -1.56 (  0.07)
> threads-sockets 	1 group 	 1.00 (  0.30)	 -0.39 (  0.41)
> threads-sockets 	2 groups 	 1.00 (  0.21)	 -0.23 (  0.27)
> threads-sockets 	4 groups 	 1.00 (  0.23)	 +0.36 (  0.19)
> threads-sockets 	8 groups 	 1.00 (  0.13)	 +1.57 (  0.06)
>
> tbench.throughput
> ======
> case            	load    	baseline(std%)	compare%( std%)
> loopback        	28 threads	 1.00 (  0.15)	 +1.05 (  0.08)
> loopback        	56 threads	 1.00 (  0.09)	 +0.36 (  0.04)
> loopback        	84 threads	 1.00 (  0.12)	 +0.26 (  0.06)
> loopback        	112 threads	 1.00 (  0.12)	 +0.04 (  0.09)
> loopback        	140 threads	 1.00 (  0.04)	 +2.98 (  0.18)
> loopback        	168 threads	 1.00 (  0.10)	 +2.88 (  0.30)
> loopback        	196 threads	 1.00 (  0.06)	 +2.63 (  0.03)
> loopback        	224 threads	 1.00 (  0.08)	 +2.60 (  0.06)
>
> schbench.latency_90%_us
> ========
> case            	load    	baseline	compare%
> normal          	1 mthread	 1.00 	        -1.7%
> normal          	2 mthreads	 1.00           +1.6%
> normal          	4 mthreads	 1.00           +1.4%
> normal          	8 mthreads	 1.00    	+21.0%
>
> Limitations:
> [1]
> This patch is based on the util_avg, which is very sensitive to the CPU
> frequency invariance. The util_avg would decay quite fast when the
> CPU is idle, if the max frequency has been limited by the user.
> Patch [3] should be applied if turbo is disabled manually on Intel
> platforms.
>
> [2]
> There may be unbalanced tasks among CPUs due to CPU affinity. For example,
> suppose the LLC domain is composed of 8 CPUs, and 7 tasks are bound to
> CPU0~CPU6, while CPU7 is idle:
>
>           CPU0    CPU1    CPU2    CPU3    CPU4    CPU5    CPU6    CPU7
> util_avg  1024    1024    1024    1024    1024    1024    1024    0
>
> Since the util_avg ratio is 87.5%( = 7/8 ), which is higher than 85%,
> select_idle_cpu() will not scan, thus CPU7 is undetected.

Following are the results from dual socket Zen3 platform (2 x 64C/128T) running with
various NPS configuration:

Following is the NUMA configuration for each NPS mode on the system:

NPS1: Each socket is a NUMA node.
    Total 2 NUMA nodes in the dual socket machine.

    Node 0: 0-63,   128-191
    Node 1: 64-127, 192-255

NPS2: Each socket is further logically divided into 2 NUMA regions.
    Total 4 NUMA nodes exist over 2 socket.
   
    Node 0: 0-31,   128-159
    Node 1: 32-63,  160-191
    Node 2: 64-95,  192-223
    Node 3: 96-127, 223-255

NPS4: Each socket is logically divided into 4 NUMA regions.
    Total 8 NUMA nodes exist over 2 socket.
   
    Node 0: 0-15,    128-143
    Node 1: 16-31,   144-159
    Node 2: 32-47,   160-175
    Node 3: 48-63,   176-191
    Node 4: 64-79,   192-207
    Node 5: 80-95,   208-223
    Node 6: 96-111,  223-231
    Node 7: 112-127, 232-255

Kernel versions:
- tip:      5.18-rc1 tip sched/core
- SIS_UTIL:    5.18-rc1 tip sched/core + this patch

When we began testing, tip was at:

commit: a658353167bf "sched/fair: Revise comment about lb decision matrix"

Following are the results from the benchmark:

* - Data points of concern

~~~~~~~~~
hackbench
~~~~~~~~~

NPS1

Test:                   tip                     SIS_UTIL
 1-groups:         4.64 (0.00 pct)         4.70 (-1.29 pct)
 2-groups:         5.38 (0.00 pct)         5.45 (-1.30 pct)
 4-groups:         6.15 (0.00 pct)         6.10 (0.81 pct)
 8-groups:         7.42 (0.00 pct)         7.42 (0.00 pct)
16-groups:        10.70 (0.00 pct)        11.69 (-9.25 pct)  *

NPS2

Test:                   tip                     SIS_UTIL
 1-groups:         4.70 (0.00 pct)         4.70 (0.00 pct)
 2-groups:         5.45 (0.00 pct)         5.46 (-0.18 pct)
 4-groups:         6.13 (0.00 pct)         6.05 (1.30 pct)
 8-groups:         7.30 (0.00 pct)         7.05 (3.42 pct)
16-groups:        10.30 (0.00 pct)        10.12 (1.74 pct)

NPS4

Test:                   tip                     SIS_UTIL
 1-groups:         4.60 (0.00 pct)         4.75 (-3.26 pct)  *
 2-groups:         5.41 (0.00 pct)         5.42 (-0.18 pct)
 4-groups:         6.12 (0.00 pct)         6.00 (1.96 pct)
 8-groups:         7.22 (0.00 pct)         7.10 (1.66 pct)
16-groups:        10.24 (0.00 pct)        10.11 (1.26 pct)

~~~~~~~~
schbench
~~~~~~~~

NPS 1

#workers:   tip                     SIS_UTIL
  1:      29.00 (0.00 pct)        21.00 (27.58 pct)
  2:      28.00 (0.00 pct)        28.00 (0.00 pct)
  4:      31.50 (0.00 pct)        31.00 (1.58 pct)
  8:      42.00 (0.00 pct)        39.00 (7.14 pct)
 16:      56.50 (0.00 pct)        54.50 (3.53 pct)
 32:      94.50 (0.00 pct)        94.00 (0.52 pct)
 64:     176.00 (0.00 pct)       175.00 (0.56 pct)
128:     404.00 (0.00 pct)       394.00 (2.47 pct)
256:     869.00 (0.00 pct)       863.00 (0.69 pct)
512:     58432.00 (0.00 pct)     55424.00 (5.14 pct)

NPS2

#workers:      tip                     SIS_UTIL
  1:      26.50 (0.00 pct)        25.00 (5.66 pct)
  2:      26.50 (0.00 pct)        25.50 (3.77 pct)
  4:      34.50 (0.00 pct)        34.00 (1.44 pct)
  8:      45.00 (0.00 pct)        46.00 (-2.22 pct)
 16:      56.50 (0.00 pct)        60.50 (-7.07 pct)        *
 32:      95.50 (0.00 pct)        93.00 (2.61 pct)
 64:     179.00 (0.00 pct)       179.00 (0.00 pct)
128:     369.00 (0.00 pct)       376.00 (-1.89 pct)
256:     898.00 (0.00 pct)       903.00 (-0.55 pct)
512:     56256.00 (0.00 pct)     57088.00 (-1.47 pct)

NPS4

#workers:    tip                     SIS_UTIL
  1:      25.00 (0.00 pct)        21.00 (16.00 pct)
  2:      28.00 (0.00 pct)        24.00 (14.28 pct)
  4:      29.50 (0.00 pct)        29.50 (0.00 pct)
  8:      41.00 (0.00 pct)        37.50 (8.53 pct)
 16:      65.50 (0.00 pct)        64.00 (2.29 pct)
 32:      93.00 (0.00 pct)        94.50 (-1.61 pct)
 64:     170.50 (0.00 pct)       175.50 (-2.93 pct)
128:     377.00 (0.00 pct)       368.50 (2.25 pct)
256:     867.00 (0.00 pct)       902.00 (-4.03 pct)
512:     58048.00 (0.00 pct)     55488.00 (4.41 pct)

~~~~~~
tbench
~~~~~~

NPS 1

Clients:     tip                     SIS_UTIL
    1    443.31 (0.00 pct)       456.19 (2.90 pct)
    2    877.32 (0.00 pct)       875.24 (-0.23 pct)
    4    1665.11 (0.00 pct)      1647.31 (-1.06 pct)
    8    3016.68 (0.00 pct)      2993.23 (-0.77 pct)
   16    5374.30 (0.00 pct)      5246.93 (-2.36 pct)
   32    8763.86 (0.00 pct)      7878.18 (-10.10 pct)     *
   64    15786.93 (0.00 pct)     12958.47 (-17.91 pct)    *
  128    26826.08 (0.00 pct)     26741.14 (-0.31 pct)
  256    24207.35 (0.00 pct)     52041.89 (114.98 pct)
  512    51740.58 (0.00 pct)     52084.44 (0.66 pct)
 1024    51177.82 (0.00 pct)     53126.29 (3.80 pct)

NPS 2

Clients:     tip                     SIS_UTIL
    1    449.49 (0.00 pct)       447.96 (-0.34 pct)
    2    867.28 (0.00 pct)       869.52 (0.25 pct)
    4    1643.60 (0.00 pct)      1625.91 (-1.07 pct)
    8    3047.35 (0.00 pct)      2952.82 (-3.10 pct)
   16    5340.77 (0.00 pct)      5251.41 (-1.67 pct)
   32    10536.85 (0.00 pct)     8843.49 (-16.07 pct)     *
   64    16543.23 (0.00 pct)     14265.35 (-13.76 pct)    *
  128    26400.40 (0.00 pct)     25595.42 (-3.04 pct)
  256    23436.75 (0.00 pct)     47090.03 (100.92 pct)
  512    50902.60 (0.00 pct)     50036.58 (-1.70 pct)
 1024    50216.10 (0.00 pct)     50639.74 (0.84 pct)

NPS 4

Clients:     tip                     SIS_UTIL
    1    443.82 (0.00 pct)       459.93 (3.62 pct)
    2    849.14 (0.00 pct)       882.17 (3.88 pct)
    4    1603.26 (0.00 pct)      1629.64 (1.64 pct)
    8    2972.37 (0.00 pct)      3003.09 (1.03 pct)
   16    5277.13 (0.00 pct)      5234.07 (-0.81 pct)
   32    9744.73 (0.00 pct)      9347.90 (-4.07 pct)      *
   64    15854.80 (0.00 pct)     14180.27 (-10.56 pct)    *
  128    26116.97 (0.00 pct)     24597.45 (-5.81 pct)     *
  256    22403.25 (0.00 pct)     47385.09 (111.50 pct)
  512    48317.20 (0.00 pct)     49781.02 (3.02 pct)
 1024    50445.41 (0.00 pct)     51607.53 (2.30 pct)

~~~~~~
Stream
~~~~~~

- 10 runs

NPS1

              tip                     SIS_UTIL
 Copy:   189113.11 (0.00 pct)    188490.27 (-0.32 pct)
Scale:   201190.61 (0.00 pct)    204526.15 (1.65 pct)
  Add:   232654.21 (0.00 pct)    234948.01 (0.98 pct)
Triad:   226583.57 (0.00 pct)    228844.43 (0.99 pct)

NPS2

Test:         tip                     SIS_UTIL
 Copy:   155347.14 (0.00 pct)    169386.29 (9.03 pct)
Scale:   191701.53 (0.00 pct)    196110.51 (2.29 pct)
  Add:   210013.97 (0.00 pct)    221088.45 (5.27 pct)
Triad:   207602.00 (0.00 pct)    218072.52 (5.04 pct)

NPS4

Test:         tip                     SIS_UTIL
 Copy:   136421.15 (0.00 pct)    140894.11 (3.27 pct)
Scale:   191217.59 (0.00 pct)    190554.17 (-0.34 pct)
  Add:   189229.52 (0.00 pct)    190871.88 (0.86 pct)
Triad:   188052.99 (0.00 pct)    188417.63 (0.19 pct)

- 100 runs

NPS1

Test:       tip                     SIS_UTIL
 Copy:   244693.32 (0.00 pct)    232328.05 (-5.05 pct)
Scale:   221874.99 (0.00 pct)    216858.39 (-2.26 pct)
  Add:   268363.89 (0.00 pct)    265449.16 (-1.08 pct)
Triad:   260945.24 (0.00 pct)    252240.56 (-3.33 pct)

NPS2

Test:       tip                     SIS_UTIL
 Copy:   211262.00 (0.00 pct)    225240.03 (6.61 pct)
Scale:   222493.34 (0.00 pct)    219094.65 (-1.52 pct)
  Add:   280277.17 (0.00 pct)    275677.73 (-1.64 pct)
Triad:   265860.49 (0.00 pct)    262584.22 (-1.23 pct)

NPS4

Test:       tip                     SIS_UTIL
 Copy:   250171.40 (0.00 pct)    230983.60 (-7.66 pct)
Scale:   222293.56 (0.00 pct)    215984.34 (-2.83 pct)
  Add:   279222.16 (0.00 pct)    270402.64 (-3.15 pct)
Triad:   262013.92 (0.00 pct)    254820.60 (-2.74 pct)

~~~~~~~~~~~~
ycsb-mongodb
~~~~~~~~~~~~

NPS1

sched-tip:      303718.33 (var: 1.31)
SIS_UTIL:       303529.33 (var: 0.67)    (-0.06%)

NPS2

sched-tip:      304536.33 (var: 2.46)
SIS_UTIL:       303730.33 (var: 1.57)    (-0.26%)

NPS4

sched-tip:      301192.33 (var: 1.81)
SIS_UTIL:       300101.33 (var: 0.35)   (-0.36%)

~~~~~~~~~~~~~~~~~~

Notes:

- There seems to be some noticeable regression for hackbench
  with 16 groups in NPS1 mode.
- There seems to be regression in tbench for case with number
  of workers in range 32-128 (12.5% loaded to 50% loaded)
- tbench reaches saturation early when system is fully loaded

This probably show that the strategy in the initial v1 RFC
seems to work better with our LLC where number of CPUs per LLC
is low compared to systems with unified LLC. Given this is
showing great results for unified LLC, maybe SIS_PROP and SIS_UTIL
can be enabled based on the the size of LLC.

> [..snip..]
>
> [3]
> Prateek mentioned that we should scan aggressively in an LLC domain
> with 16 CPUs. Because the cost to search for an idle one among 16 CPUs is
> negligible. The current patch aims to propose a generic solution and only
> considers the util_avg. A follow-up change could enhance the scan policy
> to adjust the scan_percent according to the CPU number in LLC.

Following are some additional numbers I would like to share comparing SIS_PROP and
SIS_UTIL:

o Hackbench with 1 group

With 1 group, following are the chances of SIS_PROP
and SIS_UTIL finding an idle CPU when an idle CPU
exists in LLC:

+-----------------+---------------------------+---------------------------+--------+
| Idle CPU in LLC | SIS_PROP able to find CPU | SIS_UTIL able to find CPU | Count  |
+-----------------+---------------------------+---------------------------+--------+
|        1        |             0             |             0             | 66444  |
|        1        |             0             |             1             | 34153  |
|        1        |             1             |             0             | 57204  |
|        1        |             1             |             1             | 119263 |
+-----------------+---------------------------+---------------------------+--------+

SIS_PROP vs no SIS_PROP CPU search stats:

Total time without SIS_PROP: 90653653
Total time with SIS_PROP: 53558942 (-40.92 pct)
Total time saved: 37094711

Following are number of CPUs SIS_UTIL will search when SIS_PROP limit >= 16 (LLC size):

+--------------+-------+
| CPU Searched | Count |
+--------------+-------+
|      0       | 10520 |
|      1       |  7770 |
|      2       | 11976 |
|      3       | 17554 |
|      4       | 13932 |
|      5       | 15051 |
|      6       |  8398 |
|      7       |  4544 |
|      8       |  3712 |
|      9       |  2337 |
|      10      |  4541 |
|      11      |  1947 |
|      12      |  3846 |
|      13      |  3645 |
|      14      |  2686 |
|      15      |  8390 |
|      16      | 26157 |
+--------------+-------+

- SIS_UTIL might be bailing out too early in some of these cases.

o Hackbench with 16 group

the success rate looks as follows:

+-----------------+---------------------------+---------------------------+---------+
| Idle CPU in LLC | SIS_PROP able to find CPU | SIS_UTIL able to find CPU |  Count  |
+-----------------+---------------------------+---------------------------+---------+
|        1        |             0             |             0             | 1313745 |
|        1        |             0             |             1             |  694132 |
|        1        |             1             |             0             | 2888450 |
|        1        |             1             |             1             | 5343065 |
+-----------------+---------------------------+---------------------------+---------+

SIS_PROP vs no SIS_PROP CPU search stats:

Total time without SIS_PROP: 5227299388
Total time with SIS_PROP: 3866575188 (-26.03 pct)
Total time saved: 1360724200

Following are number of CPUs SIS_UTIL will search when SIS_PROP limit >= 16 (LLC size):

+--------------+---------+
| CPU Searched |  Count  |
+--------------+---------+
|      0       |  150351 |
|      1       |  105116 |
|      2       |  214291 |
|      3       |  440053 |
|      4       |  914116 |
|      5       | 1757984 |
|      6       | 2410484 |
|      7       | 1867668 |
|      8       |  379888 |
|      9       |  84055  |
|      10      |  55389  |
|      11      |  26795  |
|      12      |  43113  |
|      13      |  24579  |
|      14      |  32896  |
|      15      |  70059  |
|      16      |  150858 |
+--------------+---------+

- SIS_UTIL might be bailing out too early in most of these cases

o tbench with 256 workers

For tbench with 256 threads, SIS_UTIL works great as we have drastically cut down the number
of CPUs to search.

SIS_PROP vs no SIS_PROP CPU search stats:

Total time without SIS_PROP: 64004752959
Total time with SIS_PROP: 34695004390 (-45.79 pct)
Total time saved: 29309748569

Following are number of CPUs SIS_UTIL will search when SIS_PROP limit >= 16 (LLC size):

+--------------+----------+
| CPU Searched |  Count   |
+--------------+----------+
|      0       |  500077  |
|      1       |  543865  |
|      2       | 4257684  |
|      3       | 27457498 |
|      4       | 40208673 |
|      5       | 3264358  |
|      6       |  191631  |
|      7       |  24658   |
|      8       |   2469   |
|      9       |   1374   |
|      10      |   2008   |
|      11      |   1300   |
|      12      |   1226   |
|      13      |   1179   |
|      14      |   1631   |
|      15      |  11678   |
|      16      |   7793   |
+--------------+----------+

- This is where SIS_UTIL shines for tbench case with 256 workers as it is effective
  at restricting search space well.

o Observations

SIS_PROP seems to have a higher chance of finding an idle CPU compared to SIS_UTIL
in case of hackbench with 16-group. The gap between SIS_PROP and SIS_UTIL is wider
with 16 groups compared to than with 1 group.
Also SIS_PROP is more aggressive at saving time for 1-group compared to the
case with 16-groups.

The bailout from SIS_UTIL is fruitful for tbench with 256 workers leading to massive
performance gain in a fully loaded system.

Note: There might be some inaccuracies for the numbers presented for metrics that
directly compare SIS_PROP and SIS_UTIL as both SIS_PROP and SIS_UTIL were enabled
when gathering these data points and the results from SIS_PROP were returned from
search_idle_cpu(). All the numbers for the above analysis were gathered in NPS1 mode.

> [..snip..]

--
Thanks and Regards,
Prateek

