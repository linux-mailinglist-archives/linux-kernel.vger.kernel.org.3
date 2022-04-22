Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7227E50B728
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 14:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447386AbiDVMYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 08:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447278AbiDVMYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:24:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A02645676B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650630069;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kWQPCphupztcwaJFTiIR3K+dJ6EeOjA7elJSGuW4nMY=;
        b=Orwu6VX2FZHD6WYQiTBERTImzJOCJDCHmtR88oevIm4phzTU7Zks8aa0FssQFunbT32/7Q
        H+sl8290z1EaqzJdJM2mD9Ic+yc9Uk7+yI0hM1l1jjbIYEu41E7HtVJMR4epAggfUekxyz
        yKSawhyPcDM7yxl+V3Cikd39UtpQfJw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-PVSvDhH3OKKRVNHUePTtWQ-1; Fri, 22 Apr 2022 08:21:04 -0400
X-MC-Unique: PVSvDhH3OKKRVNHUePTtWQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C53EC811E76;
        Fri, 22 Apr 2022 12:21:03 +0000 (UTC)
Received: from [10.72.13.230] (ovpn-13-230.pek2.redhat.com [10.72.13.230])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 118E220296C2;
        Fri, 22 Apr 2022 12:20:54 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v6 02/18] KVM: arm64: Route hypercalls based on their
 owner
To:     Oliver Upton <oupton@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        eauger@redhat.com, Jonathan.Cameron@huawei.com,
        vkuznets@redhat.com, will@kernel.org, shannon.zhaosl@gmail.com,
        james.morse@arm.com, mark.rutland@arm.com, maz@kernel.org,
        pbonzini@redhat.com, shan.gavin@gmail.com
References: <20220403153911.12332-1-gshan@redhat.com>
 <20220403153911.12332-3-gshan@redhat.com> <YmETmWvPPQvHpQwP@google.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <2519e2fa-4d6a-a5f8-1057-6b1820853036@redhat.com>
Date:   Fri, 22 Apr 2022 20:20:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <YmETmWvPPQvHpQwP@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

On 4/21/22 4:19 PM, Oliver Upton wrote:
> On Sun, Apr 03, 2022 at 11:38:55PM +0800, Gavin Shan wrote:
>> kvm_hvc_call_handler() directly handles the incoming hypercall, or
>> and routes it based on its (function) ID. kvm_psci_call() becomes
>> the gate keeper to handle the hypercall that can't be handled by
>> any one else. It makes kvm_hvc_call_handler() a bit messy.
>>
>> This reorgnizes the code to route the hypercall to the corresponding
>> handler based on its owner.
> 
> nit: write changelogs in the imperative:
> 
> Reorganize the code to ...
> 

Thanks again for your review. It will be corrected in next respin.
By the way, could you help to review the rest when you have free
cycles? :)

>> The hypercall may be handled directly
>> in the handler or routed further to the corresponding functionality.
>> The (function) ID is always verified before it's routed to the
>> corresponding functionality. By the way, @func_id is repalced by
>> @func, to be consistent with by smccc_get_function().
>>
>> PSCI is the only exception, those hypercalls defined by 0.2 or
>> beyond are routed to the handler for Standard Secure Service, but
>> those defined in 0.1 are routed to the handler for Standard
>> Hypervisor Service.
>>
>> Suggested-by: Oliver Upton <oupton@google.com>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/kvm/hypercalls.c | 199 +++++++++++++++++++++++-------------
>>   1 file changed, 127 insertions(+), 72 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
>> index 8438fd79e3f0..b659387d8919 100644
>> --- a/arch/arm64/kvm/hypercalls.c
>> +++ b/arch/arm64/kvm/hypercalls.c
> 
> [...]
> 
>> +static int kvm_hvc_standard(struct kvm_vcpu *vcpu, u32 func)
>> +{
>> +	u64 val = SMCCC_RET_NOT_SUPPORTED;
>> +
>> +	switch (func) {
>> +	case ARM_SMCCC_TRNG_VERSION ... ARM_SMCCC_TRNG_RND32:
>> +	case ARM_SMCCC_TRNG_RND64:
>> +		return kvm_trng_call(vcpu);
>> +	case PSCI_0_2_FN_PSCI_VERSION ... PSCI_0_2_FN_SYSTEM_RESET:
>> +	case PSCI_0_2_FN64_CPU_SUSPEND ... PSCI_0_2_FN64_MIGRATE_INFO_UP_CPU:
>> +	case PSCI_1_0_FN_PSCI_FEATURES ... PSCI_1_0_FN_SET_SUSPEND_MODE:
>> +	case PSCI_1_0_FN64_SYSTEM_SUSPEND:
>> +	case PSCI_1_1_FN_SYSTEM_RESET2:
>> +	case PSCI_1_1_FN64_SYSTEM_RESET2:
> 
> Isn't it known from the SMCCC what range of hypercall numbers PSCI and
> TRNG fall under, respectively?
> 
> https://developer.arm.com/documentation/den0028/e/
> 
> See sections 6.3 and 6.4.
> 

Bit#30 of the function ID is the call convention indication, which is
either 32 or 64-bits. For TRNG's function IDs, its 32-bits and 64-bits
variants are discrete. Besides, the spec reserves more functions IDs
than what range we're using. It means we don't have symbols to match
the reserved ranges. So it looks good to me for TRNG cases.

For PSCI, it can be simplified as below, according to the defination
in include/uapi/linux/psci.h:

     case PSCI_0_2_FN_PSCI_VERSION ...
          PSCI_1_1_FN_SYSTEM_RESET2:     /* 32-bits */
     case PSCI_0_2_FN64_CPU_SUSPEND ...
          PSCI_1_1_FN64_SYSTEM_RESET2:   /* 64-bits */

>> +		return kvm_psci_call(vcpu);
>> +	}
>> +
>> +	smccc_set_retval(vcpu, val, 0, 0, 0);
>> +	return 1;
> 
> I don't think any cases of the switch statement change val, could you
> just use SMCCC_RET_NOT_SUPPORTED here?
> 

Yes, Will do in next respin.

>> +}
>> +
>> +static int kvm_hvc_standard_hyp(struct kvm_vcpu *vcpu, u32 func)
>> +{
>> +	u64 val = SMCCC_RET_NOT_SUPPORTED;
>> +	gpa_t gpa;
>> +
>> +	switch (func) {
>>   	case ARM_SMCCC_HV_PV_TIME_FEATURES:
>> -		val[0] = kvm_hypercall_pv_features(vcpu);
>> +		val = kvm_hypercall_pv_features(vcpu);
>>   		break;
>>   	case ARM_SMCCC_HV_PV_TIME_ST:
>>   		gpa = kvm_init_stolen_time(vcpu);
>>   		if (gpa != GPA_INVALID)
>> -			val[0] = gpa;
>> +			val = gpa;
>>   		break;
>> +	case KVM_PSCI_FN_CPU_SUSPEND ... KVM_PSCI_FN_MIGRATE:
>> +		return kvm_psci_call(vcpu);
> 
> You might want to handle these from the main call handler with a giant
> disclaimer that these values predate SMCCC and therefore collide with
> the standard hypervisor service range.
> 
> [...]
> 

I probably just keep it as it is to follow the rule: to route
based on the owner strictly. Besides, there are 3 levels to
handle SMCCCs after this patch is applied, which corresponds
to 3 handlers as main/owner/function. It sounds more natural
for reader to follow the implementation in this way.

>> +
>> +int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
>> +{
>> +	u32 func = smccc_get_function(vcpu);
>> +	u64 val = SMCCC_RET_NOT_SUPPORTED;
>> +
>> +	switch (ARM_SMCCC_OWNER_NUM(func)) {
>> +	case ARM_SMCCC_OWNER_ARCH:
>> +		return kvm_hvc_arch(vcpu, func);
>> +	case ARM_SMCCC_OWNER_STANDARD:
>> +		return kvm_hvc_standard(vcpu, func);
>> +	case ARM_SMCCC_OWNER_STANDARD_HYP:
>> +		return kvm_hvc_standard_hyp(vcpu, func);
>> +	case ARM_SMCCC_OWNER_VENDOR_HYP:
>> +		return kvm_hvc_vendor_hyp(vcpu, func);
>> +	}
>> +
>> +	smccc_set_retval(vcpu, val, 0, 0, 0);
> 
> Same here, avoid indirecting the return value through a local variable.
> 

Sure, will do in next respin.

Thanks,
Gavin


