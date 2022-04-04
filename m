Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05CD4F1F10
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382606AbiDDWJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379161AbiDDQhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:37:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D3BB71B7B5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:35:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B755D6E;
        Mon,  4 Apr 2022 09:35:55 -0700 (PDT)
Received: from [10.57.24.6] (unknown [10.57.24.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 636063F73B;
        Mon,  4 Apr 2022 09:35:53 -0700 (PDT)
Message-ID: <f5f8166e-1831-1fa0-123c-53d3632451a8@arm.com>
Date:   Mon, 4 Apr 2022 17:35:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 07/21] x86/resctrl: Create mba_sc configuration in the
 rdt_domain
Content-Language: en-US
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
 <d49bdfad-df5e-77e1-4834-266dcd1b9055@arm.com>
 <91a43681-524e-c12d-612d-259e51bde12c@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <91a43681-524e-c12d-612d-259e51bde12c@intel.com>
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

Hi Reinette,

On 4/1/22 23:54, Reinette Chatre wrote:
> On 3/30/2022 9:43 AM, James Morse wrote:
>> On 16/03/2022 21:50, Reinette Chatre wrote:
>>> On 2/17/2022 10:20 AM, James Morse wrote:
>>>> To support resctrl's MBA software controller, the architecture must provide
>>>> a second configuration array to hold the mbps_val[] from user-space.
>>>>
>>>> This complicates the interface between the architecture specific code and
>>>> the filesystem portions of resctrl that will move to /fs/, to allow
>>>> multiple architectures to support resctrl.
>>>>
>>>> Make the filesystem parts of resctrl create an array for the mba_sc
>>>> values when is_mba_sc() is set to true. The software controller
>>>> can be changed to use this, allowing the architecture code to only
>>>> consider the values configured in hardware.

[...]

>>> Considering that no domain belonging to RDT_RESOURCE_MBA will have this array this
>>> always ends up being a null pointer de-reference.
>>
>> Ugh. I'm not sure how I managed to miss that. Thanks for debugging it!
>>
>> That loop was added to reset the array when the filesystem is mounted, as it may hold
>> stale values from a previous mount of the filesystem. Its currently done by
>> reset_all_ctrls(), but that function should really belong to the architecture code.
>>
>> Because mbm_handle_overflow() always passes a domain from the L3 to update_mba_bw(), I
>> think the cleanest thing to do is move the reset to a helper that always operates on the
>> L3 array. (and leave some breadcrumbs in the comments).

> I think this points to more than a need to reset the correct array on mount/unmount ... or
> perhaps I am not understanding this correctly?
> 
> As the analysis above shows the mbps_val array only exists for rdt_domains associated
> with RDT_RESOURCE_L3 but yet mbps_val will contain the MB value provided by user space
> associated with RDT_RESOURCE_MBA.

I've finally got my head round what is going on here: I've muddled up whether mon_capable
is a resource or system property. mba_sc depends on the L3 being mon_capable, but the
configuration should be associated with MBA (wherever that is).
(basically ignore my previous reply!)

The creation of the mbps_val[] should depend on supports_mba_mbps(), which uses
is_mbm_enabled() to check whether the L3 is mon_capable. I'll check the rid too
to make it clear its only MBA that has this.
The call to allocate the domain in resctrl_online_domain() should be above the mon_capable
check. (which is still needed to avoid the work guarded by is_mbm_enabled() and friends
running for each domain).


Thanks,

James

-----------------------%<-----------------------
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index e3c90f33baf2..ad0411eb2147 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3345,6 +3345,14 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
  
         lockdep_assert_held(&rdtgroup_mutex);
  
+       if (is_mbm_enabled() && r->rid == RDT_RESOURCE_MBA) {
+               err = mba_sc_domain_allocate(r, d);
+               if (err) {
+                       domain_destroy_mon_state(d);
+                       return err;
+               }
+       }
+
         if (!r->mon_capable)
                 return 0;
  
@@ -3352,12 +3360,6 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
         if (err)
                 return err;
  
-       err = mba_sc_domain_allocate(r, d);
-       if (err) {
-               domain_destroy_mon_state(d);
-               return err;
-       }
-
         if (is_mbm_enabled()) {
                 INIT_DELAYED_WORK(&d->mbm_over, mbm_handle_overflow);
                 mbm_setup_overflow_handler(d, MBM_OVERFLOW_INTERVAL);
-----------------------%<-----------------------
