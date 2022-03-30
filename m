Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55EE4EC9EE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 18:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiC3QrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 12:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348916AbiC3Qq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:46:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE06F2013F4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:45:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D4EA1576;
        Wed, 30 Mar 2022 09:45:10 -0700 (PDT)
Received: from [10.1.196.218] (eglon.cambridge.arm.com [10.1.196.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B34053F73B;
        Wed, 30 Mar 2022 09:45:08 -0700 (PDT)
Subject: Re: [PATCH v3 16/21] x86/resctrl: Pass the required parameters into
 resctrl_arch_rmid_read()
To:     Rob Herring <robh@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
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
 <20220217182110.7176-17-james.morse@arm.com>
 <YjuKEB9RbDa/68ll@robh.at.kernel.org>
From:   James Morse <james.morse@arm.com>
Message-ID: <4b1cc5a9-a081-bbc9-40af-e8e33061e64e@arm.com>
Date:   Wed, 30 Mar 2022 17:45:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YjuKEB9RbDa/68ll@robh.at.kernel.org>
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

Hi Rob,

On 23/03/2022 20:58, Rob Herring wrote:
> On Thu, Feb 17, 2022 at 06:21:05PM +0000, James Morse wrote:
>> resctrl_arch_rmid_read() is intended as the function that an
>> architecture agnostic resctrl filesystem driver can use to
>> read a value in bytes from a hardware register. Currently the function
>> returns the MBM values in chunks directly from hardware.
>>
>> To convert this to bytes, some correction and overflow calculations
>> are needed. These depend on the resource and domain structures.
>> Overflow detection requires the old chunks value. None of this
>> is available to resctrl_arch_rmid_read(). MPAM requires the
>> resource and domain structures to find the MMIO device that holds
>> the registers.

>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index b6ad290fda8d..277c22f8c976 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -167,10 +167,14 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
>>  		memset(am, 0, sizeof(*am));
>>  }
>>  
>> -int resctrl_arch_rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
>> +int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>> +			   u32 rmid, enum resctrl_event_id eventid, u64 *val)
>>  {
>>  	u64 msr_val;
>>  
>> +	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))

> We already tested this and disabled preemption. (At least from some 
> caller AFAICT from this patch.) I'd assume we'd want the fs code to 
> handle preemption disable and checking cpumask. In any case, it should 
> be clear what guarantees resctrl_arch_rmid_read() has.

This started as a lockdep warning for things that don't matter on x86, but would break
arm64. Combined with some half baked thinking about RT.

I'll add a comment, (in the header file).

It needs to be called on the correct CPU, but from process context as MPAM needs to send
IPI from here. I didn't want to add a preempt_disable() lockdep annotation here as its not
pre-emption that's the problem, but migration. cqm_handle_limbo() and
mbm_handle_overflow() are the two main routes in here, and they both use
schedule_delayed_work_on() to target the 'correct' CPU.


Thanks,

James
