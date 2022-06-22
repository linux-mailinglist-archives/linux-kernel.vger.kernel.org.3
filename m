Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA29B554EE4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359190AbiFVPQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359187AbiFVPQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:16:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBD5637A18
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 08:16:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EB2513D5;
        Wed, 22 Jun 2022 08:16:24 -0700 (PDT)
Received: from [10.1.196.218] (eglon.cambridge.arm.com [10.1.196.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F1273F792;
        Wed, 22 Jun 2022 08:16:19 -0700 (PDT)
Subject: Re: [PATCH v4 16/21] x86/resctrl: Pass the required parameters into
 resctrl_arch_rmid_read()
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
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
        Xin Hao <xhao@linux.alibaba.com>, xingxin.hx@openanolis.org,
        baolin.wang@linux.alibaba.com
References: <20220412124419.30689-1-james.morse@arm.com>
 <20220412124419.30689-17-james.morse@arm.com>
 <Yp++A0tuEqAN7eHo@fyu1.sc.intel.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <36032ca3-b0dc-4bf3-7e6c-e45deda41511@arm.com>
Date:   Wed, 22 Jun 2022 16:16:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <Yp++A0tuEqAN7eHo@fyu1.sc.intel.com>
Content-Type: text/plain; charset=utf-8
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

Hi Fenghua,

On 07/06/2022 22:07, Fenghua Yu wrote:
> On Tue, Apr 12, 2022 at 12:44:14PM +0000, James Morse wrote:
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
>>
>> Pass the resource and domain to resctrl_arch_rmid_read(). This makes
>> rmid_dirty() too big.

> rmid_dirty() is not called by resctrl_arch_rmid_read(). Why does parring r and d
> make rmid_dirty() too big?

But rmid_dirty() does call resctrl_arch_rmid_read(). To add the resource and the domain,
which the arch-specific side of this needs to get its work done, changes the prototype from:
| static bool rmid_dirty(struct rmid_entry *entry)
to:
| static bool rmid_dirty(struct rdt_resource *r, struct rdt_domain *d,
| 			 enum resctrl_event_id eventid, struct rmid_entry *entry)

Not to mention the closid, which MPAM will need in here too.

rmid_dirty() only has one caller, and other than this function call - its only doing a
single comparison.

Instead of bloating it - I merged it with its sole caller.


>> Instead merge it with its only caller, and the
>> name is kept as a local variable.

>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 20c54cbadc0c..81cc7587b598 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -167,10 +167,14 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
>>  		memset(am, 0, sizeof(*am));
>>  }
>>  
>> -int resctrl_arch_rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
>> +int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>> +			   u32 rmid, enum resctrl_event_id eventid, u64 *val)
> 
> Can this be a concise interface by just adding one more parameter "rr"?
> 
> int resctrl_arch_rmid_read(struct rmid_read *rr, u32 rmid, u64 *val);
>>  {
>>  	u64 msr_val;
> 
> Then inside the API, add:
> 	struct rdt_resource *r = rr->r;
> 	struct rdt_domain *d = rr->d;
> 	struct rdt_resource r = rr->r;
> 	enum resctrl_event_id evtid = rr->evtid;

Isn't this less concise for all the callers? A subsequent patch has to add the CLOSID too
as MPAM needs CLOSID/RMID as a pair.

I really don't like APIs that do this, it allows an uninitialised value to be passed by
accident. Putting this in the prototype lets the compiler check all the arguments are
supplied.

(It does make sense if there are unions, or not all the arguments are required. That
doesn't apply here)

I don't think 5 or 6 arguments to a function are a problem.


Thanks,

James
