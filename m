Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A1F5B241D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 19:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiIHRAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 13:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiIHRAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:00:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2BDBC4831
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 10:00:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58B85106F;
        Thu,  8 Sep 2022 10:00:48 -0700 (PDT)
Received: from [10.1.197.78] (eglon.cambridge.arm.com [10.1.197.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE0B33F71A;
        Thu,  8 Sep 2022 10:00:39 -0700 (PDT)
Message-ID: <5b4da95f-28ac-a571-6c01-cf1a94d0753d@arm.com>
Date:   Thu, 8 Sep 2022 18:00:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 12/21] x86/resctrl: Calculate bandwidth from the
 previous __mon_event_count() chunks
Content-Language: en-GB
To:     haoxin <xhao@linux.alibaba.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
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
References: <20220902154829.30399-1-james.morse@arm.com>
 <20220902154829.30399-13-james.morse@arm.com>
 <87aa9fd2-cae8-972d-81d4-8855cbd81569@linux.alibaba.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <87aa9fd2-cae8-972d-81d4-8855cbd81569@linux.alibaba.com>
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

On 07/09/2022 07:47, haoxin wrote:
> 在 2022/9/2 下午11:48, James Morse 写道:
>> mbm_bw_count() is only called by the mbm_handle_overflow() worker once a
>> second. It reads the hardware register, calculates the bandwidth and
>> updates m->prev_bw_msr which is used to hold the previous hardware register
>> value.
>>
>> Operating directly on hardware register values makes it difficult to make
>> this code architecture independent, so that it can be moved to /fs/,
>> making the mba_sc feature something resctrl supports with no additional
>> support from the architecture.
>> Prior to calling mbm_bw_count(), mbm_update() reads from the same hardware
>> register using __mon_event_count().
>>
>> Change mbm_bw_count() to use the current chunks value most recently saved
>> by __mon_event_count(). This removes an extra call to __rmid_read().
>> Instead of using m->prev_msr to calculate the number of chunks seen,
>> use the rr->val that was updated by __mon_event_count(). This removes an
>> extra call to mbm_overflow_count() and get_corrected_mbm_count().
>> Calculating bandwidth like this means mbm_bw_count() no longer operates
>> on hardware register values directly.

>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 3e69386cfe00..2d81b6cd9632 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c

>> @@ -516,10 +521,12 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain
>> *d, int rmid)
>>        */
>>       if (is_mbm_total_enabled()) {
>>           rr.evtid = QOS_L3_MBM_TOTAL_EVENT_ID;>> +        rr.val = 0;

> In mbm_update,  there no use the rr.val, so there no need to initialize ？

>>           __mon_event_count(rmid, &rr);
>>       }
>>       if (is_mbm_local_enabled()) {
>>           rr.evtid = QOS_L3_MBM_LOCAL_EVENT_ID;
>> +        rr.val = 0;

> ditto.

>>           __mon_event_count(rmid, &rr);
>>             /*

No, but this just leaves that problem for someone else to discover the hard way! I think
its fair for the compiler to complain that addition on an uninitialised field is a bug.

I'd prefer to keep this as it is on the principle of 'least surprise'.


Thanks,

James
