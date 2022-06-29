Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C5555FE37
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiF2LHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbiF2LHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:07:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 006983D482
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 04:07:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98138152B;
        Wed, 29 Jun 2022 04:07:29 -0700 (PDT)
Received: from [10.1.196.218] (eglon.cambridge.arm.com [10.1.196.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21A483F66F;
        Wed, 29 Jun 2022 04:07:27 -0700 (PDT)
Subject: Re: [PATCH v5 04/21] x86/resctrl: Group struct rdt_hw_domain cleanup
To:     "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>
References: <20220622164629.20795-1-james.morse@arm.com>
 <20220622164629.20795-5-james.morse@arm.com>
 <TYAPR01MB6330E0E18CF4A229B38511648BBB9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <4ae1e6d4-89c9-ee6a-f74f-73fa84b406e5@arm.com>
Date:   Wed, 29 Jun 2022 12:07:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <TYAPR01MB6330E0E18CF4A229B38511648BBB9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=iso-2022-jp
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

Hi Shaopeng,

On 29/06/2022 09:33, tan.shaopeng@fujitsu.com wrote:
>> domain_add_cpu() and domain_remove_cpu() need to kfree() the child arrays
>> that were allocated by domain_setup_ctrlval().
>>
>> As this memory is moved around, and new arrays are created, adjusting the
>> error handling cleanup code becomes noisier.
>>
>> To simplify this, move all the kfree() calls into a domain_free() helper.
>> This depends on struct rdt_hw_domain being kzalloc()d, allowing it to
>> unconditionally kfree() all the child arrays.

>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c
>> b/arch/x86/kernel/cpu/resctrl/core.c
>> index 25f30148478b..e37889f7a1a5 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -414,6 +414,13 @@ void setup_default_ctrlval(struct rdt_resource *r, u32
>> *dc, u32 *dm)
>>  	}
>>  }
>>
>> +static void domain_free(struct rdt_hw_domain *hw_dom) {
>> +	kfree(hw_dom->ctrl_val);
>> +	kfree(hw_dom->mbps_val);
>> +	kfree(hw_dom);
>> +}
>> +
>>  static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)  {
>>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r); @@ -488,7
>> +495,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>>  	rdt_domain_reconfigure_cdp(r);
>>
>>  	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
>> -		kfree(hw_dom);
>> +		domain_free(hw_dom);

> domain_free(hw_dom) is executed when fails allocated hw_dom->ctrl_val 
> by kmalloc_array() in domain_setup_ctrlval(r, d), 
> but hw_dom->ctrl_val is freed in domain_free(hw_dom).
> 
> Also, hw_dom->mbps_val is not allocated at this time,
> but it is freed in domain_free(hw_dom).

Yes, this is deliberate. These cases end up doing:
|	kfree(NULL);
which is harmless. kfree() checks for a NULL argument and does nothing.

The alternative would be to spread the cleanup all over the place, so it only calls
kfree() on something that has been allocated - this would be more complex and easier to
miss something.


> In addition，I tested this patch series on Intel(R) Xeon(R) Gold 6254 CPU with resctrl selftest.
> It is no problem.

Thanks!

James
