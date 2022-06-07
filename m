Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD24C53FE52
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243451AbiFGMH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243421AbiFGMHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:07:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1CFE037A31
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:07:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D054B143D;
        Tue,  7 Jun 2022 05:07:38 -0700 (PDT)
Received: from [10.1.196.218] (eglon.cambridge.arm.com [10.1.196.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AD773F85F;
        Tue,  7 Jun 2022 05:07:34 -0700 (PDT)
Subject: Re: [PATCH v4 07/21] x86/resctrl: Create mba_sc configuration in the
 rdt_domain
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
 <20220412124419.30689-8-james.morse@arm.com>
 <7f1c23cd-486d-9bbd-2bcc-c2db0fa1e5c2@intel.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <ce78e593-545f-0c27-cc3d-c6ec3193da36@arm.com>
Date:   Tue, 7 Jun 2022 13:07:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <7f1c23cd-486d-9bbd-2bcc-c2db0fa1e5c2@intel.com>
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

On 17/05/2022 17:18, Reinette Chatre wrote:
> On 4/12/2022 5:44 AM, James Morse wrote:
>> @@ -3263,6 +3295,7 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
>>  		cancel_delayed_work(&d->cqm_limbo);
>>  	}
>>  
>> +	mba_sc_domain_destroy(r, d);
>>  	domain_destroy_mon_state(d);
>>  }
> 
> It is not clear to me how rdt_domain->mbps_val will be released via the above call.
> 
> After patch 3/21 and the hunk below resctrl_online_domain() would look like:

[..]

> If I understand the above correctly, if MBM is enabled then all domains
> of resource RDT_RESOURCE_MBA will have rdt_domain->mbps_val allocated via
> resctrl_online_domain().
> 
> RDT_RESOURCE_MBA is not mon_capable,

Bother - this is part of the mistake I made with v3.
(in MPAM, all resources can be alloc_capable or mon_capable - this trips me up every time)


> so at the time its domains go
> offline, the freeing of rdt_domain->mbps_val will be skipped because	
> after patch 5/21 resctrl_offline_domain() would look like below so
> I do not see how the hunk added above will ever end up cleaning up
> allocated memory:

Yup, I missed this when fixing the mistake you pointed out in v3.

I've changes this to have:
|	if (supports_mba_mbps() && r->rid == RDT_RESOURCE_MBA)
|		mba_sc_domain_destroy(r, d);

in resctrl_offline_domain().



>> @@ -3302,12 +3335,20 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
>>  
>>  	lockdep_assert_held(&rdtgroup_mutex);
>>  
>> +	if (is_mbm_enabled() && r->rid == RDT_RESOURCE_MBA) {
> 
> This introduces only half of the checks that are later replaced in
> patch 10 "x86/resctrl: Abstract and use supports_mba_mbps()". Could the
> full check be used here for that patch to be cleaner or perhaps patch 10
> could be moved to be before this patch?

Great idea.


>> +		err = mba_sc_domain_allocate(r, d);
>> +		if (err)
>> +			return err;
>> +	}
>> +
>>  	if (!r->mon_capable)
>>  		return 0;
>>  
>>  	err = domain_setup_mon_state(r, d);
>> -	if (err)
>> +	if (err) {
>> +		mba_sc_domain_destroy(r, d);
>>  		return err;
>> +	}
> 
> Cleaning up after the error is reasonable but this allocation would only
> ever happen if the resource is RDT_RESOURCE_MBA and it is not mon_capable.
> Something would thus have gone really wrong if this cleanup is necessary.
> Considering that only mon_capable resources are initialized at this point,
> why not just exit right after calling mba_sc_domain_allocate()?

I'm a little uncomfortable adding more places that hardcode "this resources is never
mon_capable", its something that has to be bodged around by MPAM where any resource can
have monitors.

But sure, this just needs looking at in more detail in the future.


Thanks,

James
