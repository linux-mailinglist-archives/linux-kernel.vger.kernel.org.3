Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B925B2422
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 19:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiIHRBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 13:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiIHRB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:01:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79BB6EA423
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 10:01:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89FE0153B;
        Thu,  8 Sep 2022 10:01:34 -0700 (PDT)
Received: from [10.1.197.78] (eglon.cambridge.arm.com [10.1.197.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3A593F71A;
        Thu,  8 Sep 2022 10:01:25 -0700 (PDT)
Message-ID: <0586ab4b-e201-fbeb-927d-8ba709573b07@arm.com>
Date:   Thu, 8 Sep 2022 18:01:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 00/21] x86/resctrl: Make resctrl_arch_rmid_read()
 return values in bytes
Content-Language: en-GB
To:     haoxin <xhao@linux.alibaba.com>,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
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
 <a05e0397-50be-2f99-e461-60852c8efb3c@linux.alibaba.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <a05e0397-50be-2f99-e461-60852c8efb3c@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hao Xin,

On 07/09/2022 06:46, haoxin wrote:
> 在 2022/8/24 上午1:09, Reinette Chatre 写道:
>> On 7/3/2022 8:54 AM, Xin Hao wrote:
>>> [root@iZbp1bu26qv0j3ddyusot3Z p1]# cat mon_data/mon_L3_00/llc_occupancy
>>> 3833856
>>> [root@iZbp1bu26qv0j3ddyusot3Z p1]# cat mon_data/mon_L3_00/llc_occupancy
>>> 3620864
>>> [root@iZbp1bu26qv0j3ddyusot3Z p1]# cat mon_data/mon_L3_00/llc_occupancy
>>> 3727360
>>> [root@iZbp1bu26qv0j3ddyusot3Z p1]# cat size
>>>      MB:0=100;1=100
>>>      L3:0=3407872;1=3407872
>>>
>>> Obviously, the value has been overflowed,  Can you explain why？

>> I do not think the conclusion should immediately be that there is an
>> overflow issue. Have you perhaps run into the scenario "Notes on
>> cache occupancy monitoring and control" described in
>> Documentation/x86/resctrl.rst?
>>
>> When "memhog" starts it can allocate to the entire L3 for a while
>> before it is moved to the constrained resource group. It's cache
>> lines are not evicted as part of this move so it is not unusual for
>> it to have more lines in L3 than it is allowed to allocate into.
> 
> Yes as you said, the mon_data/mon_L3_00/llc_occupancy does not immediately become the
> value small than the set by schemata,  it may takes a few minutes to reduce to the set value.
> 
> I don't quite understand why it takes so long to see the llc_occupancy degrage.

Do you have workloads in other control groups causing cache allocations?

One of the ways this stuff can be built is for the cache to use the policy to choose which
lines to evict. The cache may already have some LRU or line-state preferences when it
comes to eviction, so it may not apply the RDT policy as the first choice.

If there is no cache pressure from outside the control group - does it matter how quickly
it takes to apply?


Thanks,

James
