Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9CD5B2424
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 19:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiIHRB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 13:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbiIHRBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:01:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46B8DEA437
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 10:01:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50346153B;
        Thu,  8 Sep 2022 10:01:50 -0700 (PDT)
Received: from [10.1.197.78] (eglon.cambridge.arm.com [10.1.197.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6072E3F71A;
        Thu,  8 Sep 2022 10:01:41 -0700 (PDT)
Message-ID: <751efaec-e997-370a-4ac0-85626c05cf5a@arm.com>
Date:   Thu, 8 Sep 2022 18:01:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 20/21] x86/resctrl: Add resctrl_rmid_realloc_limit to
 abstract x86's boot_cpu_data
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
 <20220902154829.30399-21-james.morse@arm.com>
 <539cd9b3-9a2b-47c2-7436-89aedef33d1c@linux.alibaba.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <539cd9b3-9a2b-47c2-7436-89aedef33d1c@linux.alibaba.com>
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

On 07/09/2022 07:26, haoxin wrote:
> 在 2022/9/2 下午11:48, James Morse 写道:
>> resctrl_rmid_realloc_threshold can be set by user-space. The maximum
>> value is specified by the architecture.
>>
>> Currently max_threshold_occ_write() reads the maximum value from
>> boot_cpu_data.x86_cache_size, which is not portable to another
>> architecture.
>>
>> Add resctrl_rmid_realloc_limit to describe the maximum size in bytes
>> that user-space can set the threshold to.

>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index e91afe99b763..8d15568d7121 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -747,10 +752,10 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
>>   {
>>       unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
>>       struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>> -    unsigned int cl_size = boot_cpu_data.x86_cache_size;
>>       unsigned int threshold;
>>       int ret;
>>   +    resctrl_rmid_realloc_limit = boot_cpu_data.x86_cache_size * 1024;

> Use SZ_1K instead ?

Sure, that's usually more readable. I didn't because the existing code doesn't, and I
wanted it to be obvious where this had come from.

If I re-post the series I'll change this.


Thanks for taking a look!

James

>>       hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale;
>>       r->num_rmid = boot_cpu_data.x86_cache_max_rmid + 1;
>>       hw_res->mbm_width = MBM_CNTR_WIDTH_BASE;
>> @@ -767,7 +772,7 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
>>        *
>>        * For a 35MB LLC and 56 RMIDs, this is ~1.8% of the LLC.
>>        */
>> -    threshold = cl_size * 1024 / r->num_rmid;
>> +    threshold = resctrl_rmid_realloc_limit / r->num_rmid;
>>         /*
>>        * Because num_rmid may not be a power of two, round the value
