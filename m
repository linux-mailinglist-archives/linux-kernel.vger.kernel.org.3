Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37607554EE3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359174AbiFVPQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359127AbiFVPQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:16:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79A7C2CDFF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 08:16:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5936C12FC;
        Wed, 22 Jun 2022 08:16:15 -0700 (PDT)
Received: from [10.1.196.218] (eglon.cambridge.arm.com [10.1.196.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B701F3F792;
        Wed, 22 Jun 2022 08:16:12 -0700 (PDT)
Subject: Re: [PATCH v4 19/21] x86/resctrl: Rename and change the units of
 resctrl_cqm_threshold
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
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
        Xin Hao <xhao@linux.alibaba.com>, xingxin.hx@openanolis.org,
        baolin.wang@linux.alibaba.com
References: <20220412124419.30689-1-james.morse@arm.com>
 <20220412124419.30689-20-james.morse@arm.com>
 <Yp/MUBOKvu+EqBmz@fyu1.sc.intel.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <f876523c-762d-3877-652f-4c62800d7236@arm.com>
Date:   Wed, 22 Jun 2022 16:16:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <Yp/MUBOKvu+EqBmz@fyu1.sc.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenghua,

On 07/06/2022 23:08, Fenghua Yu wrote:
> On Tue, Apr 12, 2022 at 12:44:17PM +0000, James Morse wrote:
>> resctrl_cqm_threshold is stored in a hardware specific chunk size,
>> but exposed to user-space as bytes.
>>
>> This means the filesystem parts of resctrl need to know how the hardware
>> counts, to convert the user provided byte value to chunks. The interface
>> between the architecture's resctrl code and the filesystem ought to
>> treat everything as bytes.
>>
>> Change the unit of resctrl_cqm_threshold to bytes. resctrl_arch_rmid_read()
>> still returns its value in chunks, so this needs converting to bytes.
>> As all the users have been touched, rename the variable to
>> resctrl_rmid_realloc_threshold, which describes what the value is for.
>>
>> Neither r->num_rmid nor hw_res->mon_scale are guaranteed to be a power
>> of 2, so the existing code introduces a rounding error from resctrl's
>> theoretical fraction of the cache usage. This behaviour is kept as it
>> ensures the user visible value matches the value read from hardware
>> when the rmid will be reallocated.

>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 88988de0c96c..00f6e27e4e0d 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -762,10 +764,15 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
>>  	 *
>>  	 * For a 35MB LLC and 56 RMIDs, this is ~1.8% of the LLC.
>>  	 */
>> -	resctrl_cqm_threshold = cl_size * 1024 / r->num_rmid;
>> +	threshold = cl_size * 1024 / r->num_rmid;
>>  
>> -	/* h/w works in units of "boot_cpu_data.x86_cache_occ_scale" */


> Could you please keep this comment? This comment is still helpful and
> meaningful in the context.

Not in this context anymore:

>> -	resctrl_cqm_threshold /= hw_res->mon_scale;

But if you think its important I'll move it to resctrl_arch_round_mon_val(), which got
added after Reinette's comment about the change in behaviour visible via the
max_threshold_occupancy file.


>> +	/*
>> +	 * Because num_rmid may not be a power of two, round the value
>> +	 * to the nearest multiple of hw_res->mon_scale so it matches a
>> +	 * value the hardware will measure. mon_scale may not be a power of 2.
>> +	 */
>> +	threshold /= hw_res->mon_scale;
>> +	resctrl_rmid_realloc_threshold = threshold * hw_res->mon_scale;
>>  
>>  	ret = dom_data_init(r);
>>  	if (ret)

>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index f494ca6b8bdd..7c35561e5216 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c

>> @@ -1066,8 +1062,7 @@ static ssize_t max_threshold_occ_write(struct kernfs_open_file *of,
>>  	if (bytes > (boot_cpu_data.x86_cache_size * 1024))
>>  		return -EINVAL;
>>  
>> -	hw_res = resctrl_to_arch_res(of->kn->parent->priv);
>> -	resctrl_cqm_threshold = bytes / hw_res->mon_scale;
>> +	resctrl_rmid_realloc_threshold = bytes;
> 
> Shouldn't bytes be multiples of hw_res->mon_scale? If user inputs non-multiples
> value, resctrl_rmid_realloc_threshold will keep the value in the kernel. Is that
> right?

I'd argue its the value user-space supplied, and its weird if you don't read back the
value you wrote.

But Reinette argued this was a change in behaviour, so v5 has a helper that does this:
| static inline unsigned int resctrl_arch_round_mon_val(unsigned int val)
| {
|	unsigned int scale = boot_cpu_data.x86_cache_occ_scale;
|
|	/* h/w works in units of "boot_cpu_data.x86_cache_occ_scale" */
|	val /= scale;
|	return val * scale;
| }


> But if you convert the input into multiples, user may see a different value when
> read it.

Weird huh! But that is what the max_threshold_occupancy file does today.


> Does this argument override the reason why this patch is needed?

No, this is about making more of resctrl handle the values in a platform agnostic unit,
like bytes, so it can be moved to live in /fs/ instead of arch/x86.


Thanks,

James
