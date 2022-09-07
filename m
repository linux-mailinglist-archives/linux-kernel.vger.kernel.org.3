Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6358C5AFBE8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 07:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiIGFq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 01:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIGFq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 01:46:26 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50156371BB
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 22:46:25 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0VOwWds8_1662529577;
Received: from 30.240.98.182(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VOwWds8_1662529577)
          by smtp.aliyun-inc.com;
          Wed, 07 Sep 2022 13:46:19 +0800
Message-ID: <a05e0397-50be-2f99-e461-60852c8efb3c@linux.alibaba.com>
Date:   Wed, 7 Sep 2022 13:46:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCH v5 00/21] x86/resctrl: Make resctrl_arch_rmid_read()
 return values in bytes
To:     Reinette Chatre <reinette.chatre@intel.com>,
        James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com, bobo.shaobowang@huawei.com,
        tan.shaopeng@fujitsu.com, Jamie Iles <quic_jiles@quicinc.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com
References: <20220622164629.20795-1-james.morse@arm.com>
 <f5ab048c-4a3a-8292-8a08-5fdaff739381@linux.alibaba.com>
 <5adf4968-b079-2fd3-dd61-09ed16f74080@intel.com>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <5adf4968-b079-2fd3-dd61-09ed16f74080@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/8/24 上午1:09, Reinette Chatre 写道:
> Hi,
>
> On 7/3/2022 8:54 AM, Xin Hao wrote:
>> Hi  james,
>>
>> I have a review all of the patches, it looks goot to me, but i also test them once again, i have a little confusion with my test.
>>
>> # mkdir p1
>>
>> # echo "L3:0=001;1=001" > p1/schemata
>>
>> # [root@iZbp1bu26qv0j3ddyusot3Z p1]# cat schemata
>>      MB:0=100;1=100
>>      L3:0=001;1=001
>>
>> # memhog -r1000000 1000m > /mnt/log &
>>
>> [1] 53023
>> [root@iZbp1bu26qv0j3ddyusot3Z p1]# echo 53023 > tasks
>> [
>> [root@iZbp1bu26qv0j3ddyusot3Z p1]# cat mon_data/mon_L3_00/llc_occupancy
>> 3833856
>> [root@iZbp1bu26qv0j3ddyusot3Z p1]# cat mon_data/mon_L3_00/llc_occupancy
>> 3620864
>> [root@iZbp1bu26qv0j3ddyusot3Z p1]# cat mon_data/mon_L3_00/llc_occupancy
>> 3727360
>> [root@iZbp1bu26qv0j3ddyusot3Z p1]# cat size
>>      MB:0=100;1=100
>>      L3:0=3407872;1=3407872
>>
>> Obviously, the value has been overflowed,  Can you explain why？
> Are you seeing different behavior before and after you apply this
> series?
No,they have the same test result。
>
> I do not think the conclusion should immediately be that there is an
> overflow issue. Have you perhaps run into the scenario "Notes on
> cache occupancy monitoring and control" described in
> Documentation/x86/resctrl.rst?
>
> When "memhog" starts it can allocate to the entire L3 for a while
> before it is moved to the constrained resource group. It's cache
> lines are not evicted as part of this move so it is not unusual for
> it to have more lines in L3 than it is allowed to allocate into.

Yes as you said, the mon_data/mon_L3_00/llc_occupancy does not 
immediately become the value small than the set by schemata,  it may 
takes a few minutes to reduce to the set value.

I don't quite understand why it takes so long to see the llc_occupancy 
degrage.

>
> Understanding the occupancy values require understanding of the workload
> as well as the system environment.
>
> Depending on the workload's data usage (for example if it keeps loading
> new data - note that if the workload keeps loading the same data and the
> data is already present in an area of cache that the workload cannot
> allocate into then the data read would still result in a cache hit for the
> workload, the data would not be moved to the area the
> workload can allocate into) and other workloads on the system (there is
> other load present also that evicts the lines owned by the workload) the
> L3 occupancy rate should go down after a while to match the space it
> can allocate into.
>
> Reinette
