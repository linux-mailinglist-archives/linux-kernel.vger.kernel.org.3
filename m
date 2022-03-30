Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F434EC9ED
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 18:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344370AbiC3Qqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 12:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348941AbiC3QqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:46:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4F151E3E14
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:44:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88ABB1576;
        Wed, 30 Mar 2022 09:44:38 -0700 (PDT)
Received: from [10.1.196.218] (eglon.cambridge.arm.com [10.1.196.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACA3E3F73B;
        Wed, 30 Mar 2022 09:44:36 -0700 (PDT)
Subject: Re: [PATCH v3 15/21] x86/resctrl: Abstract __rmid_read()
To:     Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
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
 <20220217182110.7176-16-james.morse@arm.com>
 <853b9cfd-504d-0dcb-2a2c-8b8df75a9b60@intel.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <c2358bf0-1369-f8c3-6b44-e86a44c5016e@arm.com>
Date:   Wed, 30 Mar 2022 17:44:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <853b9cfd-504d-0dcb-2a2c-8b8df75a9b60@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 16/03/2022 21:52, Reinette Chatre wrote:
> On 2/17/2022 10:21 AM, James Morse wrote:
>> __rmid_read() selects the specified eventid and returns the counter
>> value from the MSR. The error handling is architecture specific, and
>> handled by the callers, rdtgroup_mondata_show() and __mon_event_count().
>>
>> Error handling should be handled by architecture specific code, as
>> a different architecture may have different requirements. MPAM's
>> counters can report that they are 'not ready', requiring a second
>> read after a short delay. This should be hidden from resctrl.
>>
>> Make __rmid_read() the architecture specific function for reading
>> a counter. Rename it resctrl_arch_rmid_read() and move the error
>> handling into it.

>> @@ -180,14 +180,24 @@ static u64 __rmid_read(u32 rmid, enum resctrl_event_id eventid)
>>  	 * are error bits.
>>  	 */
>>  	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
>> -	rdmsrl(MSR_IA32_QM_CTR, val);
>> +	rdmsrl(MSR_IA32_QM_CTR, msr_val);
>>  
>> -	return val;
>> +	if (msr_val & RMID_VAL_ERROR)
>> +		return -EIO;
>> +	if (msr_val & RMID_VAL_UNAVAIL)
>> +		return -EINVAL;
>> +
>> +	*val = msr_val;
>> +
>> +	return 0;
>>  }
> 
> From above we see that resctrl_arch_rmid_read() returns an int that could be
> -EIO or -EINVAL ...
> 
> ...
> 
>> @@ -319,15 +331,15 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
>>  {
>>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(rr->r);
>>  	struct mbm_state *m;
>> -	u64 chunks, tval;
>> +	u64 chunks, tval = 0;
>>  
>>  	if (rr->first)
>>  		resctrl_arch_reset_rmid(rr->r, rr->d, rmid, rr->evtid);
>>  
>> -	tval = __rmid_read(rmid, rr->evtid);
>> -	if (tval & (RMID_VAL_ERROR | RMID_VAL_UNAVAIL)) {
>> -		return tval;
>> -	}
>> +	rr->err = resctrl_arch_rmid_read(rmid, rr->evtid, &tval);
>> +	if (rr->err)
>> +		return rr->err;
>> +
> 
> Setting rr->err, an int, to the return of resctrl_arch_rmid_read() is ok and
> can handle the negative error codes, but returning it here means that
> __mon_event_count()'s return type should be changed,
> it is currently u64.

Good point. Fixed.


>> @@ -419,9 +431,14 @@ void mon_event_count(void *info)
>>  		}
>>  	}
>>  
> 
> Also take care here ... ret_val in mon_event_count() is still u64 while
> __mon_event_count() attempts to return negative errors.

(yup, fixed)


>> -	/* Report error if none of rmid_reads are successful */
>> -	if (ret_val)
>> -		rr->val = ret_val;
>> +	/*
>> +	 * __mon_event_count() calls for newly created monitor groups may
>> +	 * report -EINVAL/Unavailable if the monitor hasn't seen any traffic.
>> +	 * If the first call for the control group succeed, discard any error
>> +	 * set by reads of monitor groups.
>> +	 */
> 
> Additionally, if the first call fails, but a following read of monitor group
> succeeds then the first call's error is discarded.
> 
> How about if the last sentence is replaced with:
> "Discard error if any of the monitor event reads succeeded."

Sure,


Thanks,

James
