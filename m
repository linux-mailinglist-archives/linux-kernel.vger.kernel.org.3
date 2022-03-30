Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CECF4EC9EF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 18:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349006AbiC3QsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 12:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiC3Qrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:47:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E79326ECBA
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:46:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 669011576;
        Wed, 30 Mar 2022 09:46:03 -0700 (PDT)
Received: from [10.1.196.218] (eglon.cambridge.arm.com [10.1.196.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92D4C3F73B;
        Wed, 30 Mar 2022 09:46:01 -0700 (PDT)
Subject: Re: [PATCH v3 19/21] x86/resctrl: Rename and change the units of
 resctrl_cqm_threshold
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
 <20220217182110.7176-20-james.morse@arm.com>
 <87c00fe2-e4fc-b006-f608-3dc2a209ed77@intel.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <1d4220ef-277d-fbb0-edb7-14f09bae0c23@arm.com>
Date:   Wed, 30 Mar 2022 17:45:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <87c00fe2-e4fc-b006-f608-3dc2a209ed77@intel.com>
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

On 17/03/2022 17:00, Reinette Chatre wrote:
> On 2/17/2022 10:21 AM, James Morse wrote:
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
>> As all the callers have been touched, rename the variable to
>> resctrl_rmid_realloc_threshold, which describes what the value is for.

>> @@ -762,10 +763,7 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
>>  	 *
>>  	 * For a 35MB LLC and 56 RMIDs, this is ~1.8% of the LLC.
>>  	 */
>> -	resctrl_cqm_threshold = cl_size * 1024 / r->num_rmid;
>> -
>> -	/* h/w works in units of "boot_cpu_data.x86_cache_occ_scale" */
>> -	resctrl_cqm_threshold /= hw_res->mon_scale;
>> +	resctrl_rmid_realloc_threshold = cl_size * 1024 / r->num_rmid;
>>  
>>  	ret = dom_data_init(r);
>>  	if (ret)
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 7ec089d72ab7..93b3697027df 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1030,10 +1030,7 @@ static int rdt_delay_linear_show(struct kernfs_open_file *of,
>>  static int max_threshold_occ_show(struct kernfs_open_file *of,
>>  				  struct seq_file *seq, void *v)
>>  {
>> -	struct rdt_resource *r = of->kn->parent->priv;
>> -	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>> -
>> -	seq_printf(seq, "%u\n", resctrl_cqm_threshold * hw_res->mon_scale);
>> +	seq_printf(seq, "%u\n", resctrl_rmid_realloc_threshold);
>>  
>>  	return 0;
>>  }
> 
> 
> This change has some user visible impact that I am still digesting but thought
> that I would share for your consideration.
> 
> As seen in the above two snippets, the original code did:
> 
> resctrl_cqm_threshold /= hw_res->mon_scale; /* resctrl_cqm_threshold used internally */
> 
> resctrl_cqm_threshold * hw_res->mon_scale; /* this is displayed to user */
> 
> The original loss due to truncation during the division is not recovered
> when the value is displayed to the user the user may see significant differences
> before and after this patch.
> 
> I tried this out on a system with a large cache and the before and after 
> information is significant:
> Before this patch:
> info/L3_MON/max_threshold_occupancy:147456
> 
> After this patch:
> info/L3_MON/max_threshold_occupancy:196608

Hmm. I hadn't considered that information would be lost by the current way of doing this.
It looks like this happens because num_rmid isn't necessarily a power of 2.


> As I understand this change indeed represents the information more accurately but
> I found it noteworthy that this is not just a simple "change the units" and
> may thus have broader impact and may indeed result in different behavior that
> should be considered.

I agree it more accurately reflects resctrl's calculation of "the number
of lines tagged per RMID if all RMIDs have the same number of lines", but if that
produces a number the hardware will never actually measure, then the rounding is still
happening, but somewhere else.

I think the right thing to do is round resctrl_rmid_realloc_threshold down to the nearest
multiple of hw_res->mon_scale in rdt_get_mon_l3_config(). This way the filesystem parts
still handle things in bytes, and the architecture code provides the quantised value that
will actually get measured. Its this value that should be reported to user-space.

It doesn't look like the 'Upscaling Factor' is guaranteed to be a power of 2, so I can't
use the round_down() helpers.

I've added this to the commit message:
| Neither r->num_rmid nor hw_res->mon_scale are guaranteed to be a power
| of 2, so the existing code introduces a rounding error from resctrl's
| theoretical fraction of the cache usage. This behaviour is kept as it
| ensures the user visible value matches the value read from hardware
| when the rmid will be reallocated.

and the hunk below, which fixes it for me.



Thanks,

James

---------------%<---------------
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index b18e227d585c..fb81d650c457 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -753,6 +753,7 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
        unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
        struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
        unsigned int cl_size = boot_cpu_data.x86_cache_size;
+       u64 threshold;
        int ret;

        hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale;
@@ -771,7 +772,15 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
         *
         * For a 35MB LLC and 56 RMIDs, this is ~1.8% of the LLC.
         */
-       resctrl_rmid_realloc_threshold = cl_size * 1024 / r->num_rmid;
+       threshold = cl_size * 1024 / r->num_rmid;
+
+       /*
+        * Because num_rmid may not be a power of two, round the value
+        * to the nearest multiple of hw_res->mon_scale so it matches a
+        * value the hardware will measure. mon_scale may not be a power of 2.
+        */
+       threshold /= hw_res->mon_scale;
+       resctrl_rmid_realloc_threshold = threshold * hw_res->mon_scale;

        ret = dom_data_init(r);
        if (ret)
---------------%<---------------
