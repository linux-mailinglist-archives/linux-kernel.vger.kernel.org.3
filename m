Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDA653FE65
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243491AbiFGMIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243460AbiFGMIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:08:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C1BC8B0AD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:08:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 291411480;
        Tue,  7 Jun 2022 05:08:00 -0700 (PDT)
Received: from [10.1.196.218] (eglon.cambridge.arm.com [10.1.196.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B48F3F73B;
        Tue,  7 Jun 2022 05:07:54 -0700 (PDT)
Subject: Re: [PATCH v4 15/21] x86/resctrl: Abstract __rmid_read()
To:     Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
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
        Xin Hao <xhao@linux.alibaba.com>, xingxin.hx@openanolis.org,
        baolin.wang@linux.alibaba.com
References: <20220412124419.30689-1-james.morse@arm.com>
 <20220412124419.30689-16-james.morse@arm.com>
 <39264d40-265e-b41f-913f-c21325678735@intel.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <63845ed3-f09e-43b2-5ded-394bbbd874c4@arm.com>
Date:   Tue, 7 Jun 2022 13:07:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <39264d40-265e-b41f-913f-c21325678735@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 17/05/2022 22:23, Reinette Chatre wrote:
> On 4/12/2022 5:44 AM, James Morse wrote:
> 
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
>>  
> 
> In above EIO is used to represent RMID_VAL_ERROR ...
> 
>> @@ -343,7 +355,7 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
>>  		 * Code would never reach here because an invalid
>>  		 * event id would fail the __rmid_read.

(I'll fix this comment)

>>  		 */
>> -		return RMID_VAL_ERROR;
>> +		return -EINVAL;
>>  	}
>>  
>>  	if (rr->first) {
> 
> I understand it can be seen as a symbolic change but could
> RMID_VAL_ERROR consistently be associated with the same error?

This one isn't really RMID_VAL_ERROR - it was never read from the hardware, this was an
invalid argument supplied by the caller.

You can only hit this if resctrl_arch_rmid_read() doesn't read RMID_VAL_ERROR from the
hardware, because the hardware supports the event, but its an invalid argument as far as
this code is concerned.

I'd prefer to avoid EIO as the error was not reported from hardware - its only reachable
if the hardware does support the event!


Thanks,

James
