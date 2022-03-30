Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5AA4EC9D5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 18:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348908AbiC3Qpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 12:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348899AbiC3Qpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:45:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24C211C8A86
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:43:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2BE51477;
        Wed, 30 Mar 2022 09:43:55 -0700 (PDT)
Received: from [10.1.196.218] (eglon.cambridge.arm.com [10.1.196.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C93BA3F73B;
        Wed, 30 Mar 2022 09:43:52 -0700 (PDT)
Subject: Re: [PATCH v3 07/21] x86/resctrl: Create mba_sc configuration in the
 rdt_domain
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
 <20220217182110.7176-8-james.morse@arm.com>
 <01651414-9d4a-409d-9db7-b4b6dde72829@intel.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <d49bdfad-df5e-77e1-4834-266dcd1b9055@arm.com>
Date:   Wed, 30 Mar 2022 17:43:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <01651414-9d4a-409d-9db7-b4b6dde72829@intel.com>
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

On 16/03/2022 21:50, Reinette Chatre wrote:
> I tried out this work and encountered a null pointer de-reference that
> seems related to this patch. After digging into that it is not
> clear to me how this is expected to work.
> 
> I encounter the issue just by attempting to mount with "-o mba_MBps" which is
> the way to enable the mba_sc and exactly what this patch aims to address.
> 
> More below ...
> 
> On 2/17/2022 10:20 AM, James Morse wrote:
>> To support resctrl's MBA software controller, the architecture must provide
>> a second configuration array to hold the mbps_val[] from user-space.
>>
>> This complicates the interface between the architecture specific code and
>> the filesystem portions of resctrl that will move to /fs/, to allow
>> multiple architectures to support resctrl.
>>
>> Make the filesystem parts of resctrl create an array for the mba_sc
>> values when is_mba_sc() is set to true. The software controller
>> can be changed to use this, allowing the architecture code to only
>> consider the values configured in hardware.

...

>> @@ -3309,6 +3344,12 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
>>  	if (err)
>>  		return err;
>>  
>> +	err = mba_sc_domain_allocate(r, d);
>> +	if (err) {
>> +		domain_destroy_mon_state(d);
>> +		return err;
>> +	}
>> +
> 
> Before the above snippet there is a check if the resource is capable of monitoring:
> 
> resctrl_online_domain()
> {
> 	...
> 	if (!r->mon_capable)
> 		return 0;
> 
> 	...
> 	err = mba_sc_domain_allocate(r, d);
> 	...
> }
> 
> Thus, the rdt_domain->mbps_val array will only exist in those resources that
> support monitoring.
> 	
> Taking a look at where mon_capable is set we see it is done in 
> get_rdt_mon_resources() and as you can see it is only done for RDT_RESOURCE_L3.
> 
> get_rdt_mon_resources()
> {
> 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> 
> 	...
> 
> 	return !rdt_get_mon_l3_config(r); /* mon_capable is set within */
> }
> 
> Based on the above the rdt_domain->mbps_val array can only exist for those
> domains that belong to resource RDT_RESOURCE_L3 (if it is capable of monitoring).
> 
> Now, looking at set_mba_sc() changed here, it only interacts with RDT_RESOURCE_MBA:
> 
> set_mba_sc() 
> {
> 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
> 
> 	...
> 
> 	list_for_each_entry(d, &r->domains, list) {
> 		for (i = 0; i < num_closid; i++)
> 			d->mbps_val[i] = MBA_MAX_MBPS;
> 	}
> }
> 	
> Considering that no domain belonging to RDT_RESOURCE_MBA will have this array this
> always ends up being a null pointer de-reference.

Ugh. I'm not sure how I managed to miss that. Thanks for debugging it!

That loop was added to reset the array when the filesystem is mounted, as it may hold
stale values from a previous mount of the filesystem. Its currently done by
reset_all_ctrls(), but that function should really belong to the architecture code.

Because mbm_handle_overflow() always passes a domain from the L3 to update_mba_bw(), I
think the cleanest thing to do is move the reset to a helper that always operates on the
L3 array. (and leave some breadcrumbs in the comments).


Thanks!

James

-----------------%<-----------------
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 36edae7dbc6a..3b52f079a5b3 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1913,6 +1913,23 @@ static void mba_sc_domain_destroy(struct rdt_resource *r,
        d->mbps_val = NULL;
 }

+static void mba_sc_reset(void)
+{
+       /*
+        * mbm_handle_overflow() only passes domains of the L3 resource to
+        * update_mba_bw(), so mba_sc only supports monitoring on the L3.
+        */
+       struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+       u32 num_closid = resctrl_arch_get_num_closid(r);
+       struct rdt_domain *d;
+       int i;
+
+       list_for_each_entry(d, &r->domains, list) {
+               for (i = 0; i < num_closid; i++)
+                       d->mbps_val[i] = MBA_MAX_MBPS;
+       }
+}
+
 /*
  * Enable or disable the MBA software controller
  * which helps user specify bandwidth in MBps.
@@ -1922,20 +1939,13 @@ static void mba_sc_domain_destroy(struct rdt_resource *r,
 static int set_mba_sc(bool mba_sc)
 {
        struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
-       u32 num_closid = resctrl_arch_get_num_closid(r);
-       struct rdt_domain *d;
-       int i;

        if (!is_mbm_enabled() || !is_mba_linear() ||
            mba_sc == is_mba_sc(r))
                return -EINVAL;

        r->membw.mba_sc = mba_sc;
-
-       list_for_each_entry(d, &r->domains, list) {
-               for (i = 0; i < num_closid; i++)
-                       d->mbps_val[i] = MBA_MAX_MBPS;
-       }
+       mba_sc_reset();

        return 0;
 }
-----------------%<-----------------
