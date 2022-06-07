Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1CE53FE66
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243431AbiFGMHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243419AbiFGMHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:07:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4824830541
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:07:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DACB11FB;
        Tue,  7 Jun 2022 05:07:37 -0700 (PDT)
Received: from [10.1.196.218] (eglon.cambridge.arm.com [10.1.196.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36CF43F73B;
        Tue,  7 Jun 2022 05:07:31 -0700 (PDT)
Subject: Re: [PATCH v4 08/21] x86/resctrl: Switch over to the resctrl mbps_val
 list
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
 <20220412124419.30689-9-james.morse@arm.com>
 <93459560-0740-57f3-ed15-caae370aa80a@intel.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <ad3b0290-9419-5763-6f20-306af0d8521d@arm.com>
Date:   Tue, 7 Jun 2022 13:07:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <93459560-0740-57f3-ed15-caae370aa80a@intel.com>
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

On 17/05/2022 17:19, Reinette Chatre wrote:
> On 4/12/2022 5:44 AM, James Morse wrote:
>> Updates to resctrl's software controller follow the same path as
>> other configuration updates, but they don't modify the hardware state.
>> rdtgroup_schemata_write() uses parse_line() and the resource's
>> parse_ctrlval() function to stage the configuration.
>> resctrl_arch_update_domains() then updates the mbps_val[] array
>> instead, and resctrl_arch_update_domains() skips the rdt_ctrl_update()
>> call that would update hardware.
>>
>> This complicates the interface between resctrl's filesystem parts
>> and architecture specific code. It should be possible for mba_sc
>> to be completely implemented by the filesystem parts of resctrl. This
>> would allow it to work on a second architecture with no additional code.
>> resctrl_arch_update_domains() using the mbps_val[] array prevents this.
>>
>> Change parse_bw() to write the configuration value directly to the
>> mbps_val[] array in the domain structure. Change rdtgroup_schemata_write()
>> to skip the call to resctrl_arch_update_domains(), meaning all the
>> mba_sc specific code in resctrl_arch_update_domains() can be removed.
>> On the read-side, show_doms() and update_mba_bw() are changed to read
>> the mbps_val[] array from the domain structure. With this,
>> resctrl_arch_get_config() no longer needs to consider mba_sc resources.

> This sounds like a good cleanup and I understand it to not intend 
> functional change, so a bit more information is needed on the change
> in rdtgroup_init_alloc(). More below.

>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 9d5be6a73644..07904308245c 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1932,11 +1937,6 @@ static int set_mba_sc(bool mba_sc)
>>  
>>  	r->membw.mba_sc = mba_sc;
>>  
>> -	list_for_each_entry(d, &r->domains, list) {
>> -		for (i = 0; i < num_closid; i++)
>> -			d->mbps_val[i] = MBA_MAX_MBPS;
>> -	}
>> -
>>  	return 0;
>>  }

> With this removed, where is rdt_domain->mbps_val reset on remount of resctrl?

Oops, this is a bug. Its a left over from when the rdt_domain->mbps_val[] array was only
allocated when mba_sc was enabled.


>> @@ -2809,15 +2809,18 @@ static int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid)
>>  }
>>  
>>  /* Initialize MBA resource with default values. */
>> -static void rdtgroup_init_mba(struct rdt_resource *r)
>> +static void rdtgroup_init_mba(struct rdt_resource *r, u32 closid)
>>  {
>>  	struct resctrl_staged_config *cfg;
>>  	struct rdt_domain *d;
>>  
>>  	list_for_each_entry(d, &r->domains, list) {
>>  		cfg = &d->staged_config[CDP_NONE];
>> -		cfg->new_ctrl = is_mba_sc(r) ? MBA_MAX_MBPS : r->default_ctrl;
>> +		cfg->new_ctrl = r->default_ctrl;
>>  		cfg->have_new_ctrl = true;
>> +
>> +		if (is_mba_sc(r))
>> +			d->mbps_val[closid] = MBA_MAX_MBPS;
>>  	}
>>  }
>>  
>> @@ -2831,7 +2834,7 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
>>  	list_for_each_entry(s, &resctrl_schema_all, list) {
>>  		r = s->res;
>>  		if (r->rid == RDT_RESOURCE_MBA) {
>> -			rdtgroup_init_mba(r);
>> +			rdtgroup_init_mba(r, rdtgrp->closid);
>>  		} else {
>>  			ret = rdtgroup_init_cat(s, rdtgrp->closid);
>>  			if (ret < 0)
> 
> What follows this hunk and continues to be called is:
> 
> 	ret = resctrl_arch_update_domains(r, rdtgrp->closid);
> 
> before this patch resctrl_arch_update_domains() would just have updated
> the mbps_val but not made any configuration changed if is_mba_sc() is true.
> Before this patch configuration changes done in
> resctrl_arch_update_domains() is omitted when is_mba_sc() is true
> but after earlier change in this patch it proceeds and will result in
> configuration change.

Yes, this will write the default ctrl_val into hardware. Previously it may have an unknown
value from a previous allocation of the closid, update_mba_bw() will eventually adjust
that to something sensible.

I think I ignored this as harmless, but I agree its better to keep the existing behaviour.
I'll add:
|		if (is_mba_sc(r))
|			continue;

to both rdtgroup_init_mba() and rdtgroup_init_alloc().


Thanks,

James
