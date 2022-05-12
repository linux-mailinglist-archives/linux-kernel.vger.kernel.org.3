Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCE4524DEB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354380AbiELNLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354224AbiELNKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:10:53 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C4BE01B
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:10:46 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KzXBf5GJNzGpfQ;
        Thu, 12 May 2022 21:07:54 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 21:10:43 +0800
CC:     <yangyicong@hisilicon.com>, Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
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
        Zhang Rui <rui.zhang@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v3] sched/fair: Introduce SIS_UTIL to search idle CPU
 based on sum of util_avg
To:     Chen Yu <yu.c.chen@intel.com>
References: <20220428182442.659294-1-yu.c.chen@intel.com>
 <962e16d1-dd73-418c-9635-009db110823d@huawei.com>
 <20220512081414.GA31450@chenyu5-mobl1>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <37596ea2-b97a-71a7-74ff-ec0281dd3de1@huawei.com>
Date:   Thu, 12 May 2022 21:10:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20220512081414.GA31450@chenyu5-mobl1>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/12 16:14, Chen Yu wrote:
> On Tue, May 10, 2022 at 08:41:57PM +0800, Yicong Yang wrote:
>> On 2022/4/29 2:24, Chen Yu wrote:
>>> @@ -61,6 +61,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
>>>   * When doing wakeups, attempt to limit superfluous scans of the LLC domain.
>>>   */
>>>  SCHED_FEAT(SIS_PROP, true)
>>> +SCHED_FEAT(SIS_UTIL, false)
>>>  
>>
>> I see you mentioned they're mutually exclusive in the commit, worth a comment here?
>>
> Yes, previously I thought it could be made mutually exclusive, and Peter has
> suggested that we should make SIS_UTIL enabled by default, so later we could
> remove SIS_PROP if SIS_UTIL behaves stable. So I assume there is no need to
> add comment in the next version now. 
>> One minor question: nr is updated in load balance so there maybe a delay because of
>> interval of load balancing.
> Yes, this is a good question. The default interval between two load balance is sd_weight ms,
> which is 112ms in my case. This interval was a trade off to reduce cache contention. Besides,
> every 1st idle CPU or the balanced CPU in one sched group within the LLC domain has the chance
> to launch a periodic load balance, for example, although CPU0 and CPU1's periodic load balance
> are both triggered every 112ms, CPU1 could help launch the load balance when CPU0 is not in
> load balance work. Consider there are many CPUs in a LLC domain, the 'internal' to launch
> the periodic load balance becomes smaller.
>> Furthermore, the LLC domain may not be balanced everytime
>> if the lowest domain is not LLC, like CLS->LLC. So maybe a bit more delay included.
>>
> I thought every domain has its chance to launch a load balance, the difference is different
> domains have different interval. No?
I might miss something. I think it's right here.
>> The test results is fine and as expected. The improvement of netperf at a heavy load
>> condition, compared to your v2 version.
>>
> Thanks for the test, would you mind if I add Tested-by tag?
> 

On Kunpeng920 for this patch,

Tested-by: Yicong Yang <yangyicong@hisilicon.com>

> thanks,
> Chenyu 
>> Thanks,
>> Yicong
>>
>> TCP_RR node 0-1
>> threads
>> 16	57559.56667	57930.03333 (+0.64%)
>> 32	56373		57754.53333 (+2.45%)
>> 64	18831.4		46234.76667 (+145.52%)
>> 128	15658.9		19620.26667 (+25.30%)
>> 256	7959.896667	8869.013333 (+11.42%)
>>
>> TCP_RR node 0
>> threads
>> 16	58389.43333	59026.03333 (+1.09%)
>> 32	23779.6		51563.33333 (+116.84%)
>> 64	20514.56667	23485.63333 (+14.48%)
>> 128	8202.49		9205.483333 (+12.23%)
>> 256	3843.163333	4304.8      (+12.01%)
>>
>> tbench4 node 0-1
>>                            5.18-rc1                patched
>> Hmean     1        299.02 (   0.00%)      307.73 *   2.91%*
>> Hmean     2        597.88 (   0.00%)      619.10 *   3.55%*
>> Hmean     4       1207.11 (   0.00%)     1239.57 *   2.69%*
>> Hmean     8       2406.67 (   0.00%)     2463.63 *   2.37%*
>> Hmean     16      4755.52 (   0.00%)     4979.46 *   4.71%*
>> Hmean     32      9449.01 (   0.00%)     9709.59 *   2.76%*
>> Hmean     64     10538.89 (   0.00%)    10727.86 *   1.79%*
>> Hmean     128    13333.84 (   0.00%)    14580.63 *   9.35%*
>> Hmean     256    11735.24 (   0.00%)    11737.16 (   0.02%)
>>
>> tbench4 node 0
>>                            5.18-rc1                patched
>> Hmean     1        302.26 (   0.00%)      313.43 *   3.70%*
>> Hmean     2        603.87 (   0.00%)      618.56 *   2.43%*
>> Hmean     4       1213.91 (   0.00%)     1249.63 *   2.94%*
>> Hmean     8       2469.72 (   0.00%)     2527.48 *   2.34%*
>> Hmean     16      4980.70 (   0.00%)     5099.62 *   2.39%*
>> Hmean     32      9001.88 (   0.00%)     9730.27 *   8.09%*
>> Hmean     64      7032.07 (   0.00%)     7691.56 *   9.38%*
>> Hmean     128     6037.76 (   0.00%)     6712.86 *  11.18%*
>> Hmean     256     8513.83 (   0.00%)     9117.79 *   7.09%*
>>
> .
> 
