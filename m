Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05E75B2421
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 19:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiIHRBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 13:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiIHRBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:01:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61C2BE5581
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 10:01:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 523BF153B;
        Thu,  8 Sep 2022 10:01:20 -0700 (PDT)
Received: from [10.1.197.78] (eglon.cambridge.arm.com [10.1.197.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 399BA3F71A;
        Thu,  8 Sep 2022 10:01:11 -0700 (PDT)
Message-ID: <846894f1-9d13-26f3-2f26-80768942eecb@arm.com>
Date:   Thu, 8 Sep 2022 18:01:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 04/21] x86/resctrl: Group struct rdt_hw_domain cleanup
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
 <20220902154829.30399-5-james.morse@arm.com>
 <33bedd74-a19e-8919-64c3-432c2eaba11d@linux.alibaba.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <33bedd74-a19e-8919-64c3-432c2eaba11d@linux.alibaba.com>
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

On 07/09/2022 07:28, haoxin wrote:
> 
> 在 2022/9/2 下午11:48, James Morse 写道:
>> domain_add_cpu() and domain_remove_cpu() need to kfree() the child
>> arrays that were allocated by domain_setup_ctrlval().
>>
>> As this memory is moved around, and new arrays are created, adjusting
>> the error handling cleanup code becomes noisier.
>>
>> To simplify this, move all the kfree() calls into a domain_free() helper.
>> This depends on struct rdt_hw_domain being kzalloc()d, allowing it to
>> unconditionally kfree() all the child arrays.

>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>> index 25f30148478b..e37889f7a1a5 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -414,6 +414,13 @@ void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm)
>>       }
>>   }
>>   +static void domain_free(struct rdt_hw_domain *hw_dom)

> add inline ?

It's best to let the compiler decide this. As this is in a C file, and is declared static,
the compiler is free to duplicate and inline this function as it sees fit. The inline
keyword would only be needed if this were in a header file.

Looking at the built object file - the compiler chose not to duplicate this into the two
callers, presumably because of the size of the function.

Unless its relied on for correctness, or is a performance sensitive path, its best to let
the compiler make its own decision here.


Thanks,

James


>> +{
>> +    kfree(hw_dom->ctrl_val);
>> +    kfree(hw_dom->mbps_val);
>> +    kfree(hw_dom);
>> +}
>> +
>>   static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
>>   {
>>       struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
