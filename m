Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DF14F1BAF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380901AbiDDVWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379166AbiDDQiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:38:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 626472C11C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:36:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 293D41480;
        Mon,  4 Apr 2022 09:36:07 -0700 (PDT)
Received: from [10.57.24.6] (unknown [10.57.24.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F6D93F73B;
        Mon,  4 Apr 2022 09:36:04 -0700 (PDT)
Message-ID: <30d85009-f4be-25b1-7eb8-eea4b3058e27@arm.com>
Date:   Mon, 4 Apr 2022 17:36:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 21/21] x86/resctrl: Make resctrl_arch_rmid_read()
 return values in bytes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com, bobo.shaobowang@huawei.com,
        tan.shaopeng@fujitsu.com
References: <20220217182110.7176-1-james.morse@arm.com>
 <20220217182110.7176-22-james.morse@arm.com>
 <YjuOWpqLfiP4u2AT@robh.at.kernel.org>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <YjuOWpqLfiP4u2AT@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 3/23/22 21:17, Rob Herring wrote:
> On Thu, Feb 17, 2022 at 06:21:10PM +0000, James Morse wrote:
>> resctrl_arch_rmid_read() returns a value in chunks, as read from the
>> hardware. This needs scaling to bytes by mon_scale, as provided by
>> the architecture code.
>>
>> Now that resctrl_arch_rmid_read() performs the overflow and corrections
>> itself, it may as well return a value in bytes directly. This allows
>> the accesses to the architecture specific 'hw' structure to be removed.
>>
>> Move the mon_scale conversion into resctrl_arch_rmid_read().
>> mbm_bw_count() is updated to calculate bandwidth from bytes.

>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 3a6555f49720..437e7db77f93 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -211,10 +211,11 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>>   	if (am) {
>>   		am->chunks += mbm_overflow_count(am->prev_msr, msr_val,
>>   						 hw_res->mbm_width);
>> -		*val = get_corrected_mbm_count(rmid, am->chunks);
>> +		chunks = get_corrected_mbm_count(rmid, am->chunks);
>> +		*val = chunks * hw_res->mon_scale;
> 
> This can be moved out of the if/else if you make the following change:
> 
>>   		am->prev_msr = msr_val;
>>   	} else {
>> -		*val = msr_val;
>> +		*val = msr_val * hw_res->mon_scale;
> 
> chunks = msr_val;
> 
>>   	}

Sure, I guess it makes sense to only set *val in one place.

>>   
>>   	return 0;
>> @@ -400,15 +397,14 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
>>    */
>>   static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
>>   {
>> -	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(rr->r);
>>   	struct mbm_state *m = &rr->d->mbm_local[rmid];
>> -	u64 cur_bw, chunks, cur_chunks;
>> +	u64 cur_bw, bytes, cur_bytes;
>>   
>> -	cur_chunks = rr->val;
>> -	chunks = cur_chunks - m->prev_bw_chunks;
>> -	m->prev_bw_chunks = cur_chunks;
>> +	cur_bytes = rr->val;
>> +	bytes = cur_bytes - m->prev_bw_bytes;
>> +	m->prev_bw_bytes = cur_bytes;
>>   
>> -	cur_bw = (chunks * hw_res->mon_scale) >> 20;
>> +	cur_bw = bytes >> 20;
> 
> 'bytes / SZ_1M' would be more readable and any decent compiler should
> optimize a power of 2 divide. But maybe that's a separate change as
> there are other cases of bytes to MB.

I agree its more readable. As I've touched this one, I'll change it.


Thanks,

James
