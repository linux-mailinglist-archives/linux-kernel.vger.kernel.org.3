Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D964648BEA7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 07:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351033AbiALGnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 01:43:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47273 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237188AbiALGns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 01:43:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641969828;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H2/scgVj9r7wMSNo1nFE4yD66dJitUm+1roYfYsXnC8=;
        b=H4C06vDar+x7koY62Esn581f76gslcVhw6n6JJtZ+5VzLl/6Ge/KwNJPUBql1a4cwpPkwJ
        93DGAy7wBl55zzw4Iu40Z32QPOuDv4ab/CprMG88ECdCpZ6DBR8UgJa8nord3dN82jeXhq
        4bwPk22Bp/H7J7i/8Q7/3zoJJm460XA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-241-gWt-zo3MMv6vg9VTi7Q3eQ-1; Wed, 12 Jan 2022 01:43:45 -0500
X-MC-Unique: gWt-zo3MMv6vg9VTi7Q3eQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7F8084B9A7;
        Wed, 12 Jan 2022 06:43:43 +0000 (UTC)
Received: from [10.72.12.204] (ovpn-12-204.pek2.redhat.com [10.72.12.204])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C148173140;
        Wed, 12 Jan 2022 06:43:39 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v4 14/21] KVM: arm64: Support SDEI_EVENT_{COMPLETE,
 COMPLETE_AND_RESUME} hypercall
To:     Eric Auger <eauger@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-15-gshan@redhat.com>
 <62c67e31-fa33-24e9-6508-59976673c0db@redhat.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <fdb013e7-10a1-58de-92aa-3ab9d25346fa@redhat.com>
Date:   Wed, 12 Jan 2022 14:43:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <62c67e31-fa33-24e9-6508-59976673c0db@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 11/10/21 6:58 PM, Eric Auger wrote:
> On 8/15/21 2:13 AM, Gavin Shan wrote:
>> This supports SDEI_EVENT_{COMPLETE, COMPLETE_AND_RESUME} hypercall.
>> They are used by the guest to notify the completion of the SDEI
>> event in the handler. The registers are changed according to the
>> SDEI specification as below:
>>
>>     * x0 - x17, PC and PState are restored to what values we had in
>>       the interrupted context.
>>
>>     * If it's SDEI_EVENT_COMPLETE_AND_RESUME hypercall, IRQ exception
>>       is injected.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/include/asm/kvm_emulate.h |  1 +
>>   arch/arm64/include/asm/kvm_host.h    |  1 +
>>   arch/arm64/kvm/hyp/exception.c       |  7 +++
>>   arch/arm64/kvm/inject_fault.c        | 27 ++++++++++
>>   arch/arm64/kvm/sdei.c                | 75 ++++++++++++++++++++++++++++
>>   5 files changed, 111 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
>> index fd418955e31e..923b4d08ea9a 100644
>> --- a/arch/arm64/include/asm/kvm_emulate.h
>> +++ b/arch/arm64/include/asm/kvm_emulate.h
>> @@ -37,6 +37,7 @@ bool kvm_condition_valid32(const struct kvm_vcpu *vcpu);
>>   void kvm_skip_instr32(struct kvm_vcpu *vcpu);
>>   
>>   void kvm_inject_undefined(struct kvm_vcpu *vcpu);
>> +void kvm_inject_irq(struct kvm_vcpu *vcpu);
>>   void kvm_inject_vabt(struct kvm_vcpu *vcpu);
>>   void kvm_inject_dabt(struct kvm_vcpu *vcpu, unsigned long addr);
>>   void kvm_inject_pabt(struct kvm_vcpu *vcpu, unsigned long addr);
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>> index 46f363aa6524..1824f7e1f9ab 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -437,6 +437,7 @@ struct kvm_vcpu_arch {
>>   #define KVM_ARM64_EXCEPT_AA32_UND	(0 << 9)
>>   #define KVM_ARM64_EXCEPT_AA32_IABT	(1 << 9)
>>   #define KVM_ARM64_EXCEPT_AA32_DABT	(2 << 9)
>> +#define KVM_ARM64_EXCEPT_AA32_IRQ	(3 << 9)
>>   /* For AArch64: */
>>   #define KVM_ARM64_EXCEPT_AA64_ELx_SYNC	(0 << 9)
>>   #define KVM_ARM64_EXCEPT_AA64_ELx_IRQ	(1 << 9)
>> diff --git a/arch/arm64/kvm/hyp/exception.c b/arch/arm64/kvm/hyp/exception.c
>> index 0418399e0a20..ef458207d152 100644
>> --- a/arch/arm64/kvm/hyp/exception.c
>> +++ b/arch/arm64/kvm/hyp/exception.c
>> @@ -310,6 +310,9 @@ static void kvm_inject_exception(struct kvm_vcpu *vcpu)
>>   		case KVM_ARM64_EXCEPT_AA32_DABT:
>>   			enter_exception32(vcpu, PSR_AA32_MODE_ABT, 16);
>>   			break;
>> +		case KVM_ARM64_EXCEPT_AA32_IRQ:
>> +			enter_exception32(vcpu, PSR_AA32_MODE_IRQ, 4);
>> +			break;
>>   		default:
>>   			/* Err... */
>>   			break;
>> @@ -320,6 +323,10 @@ static void kvm_inject_exception(struct kvm_vcpu *vcpu)
>>   		      KVM_ARM64_EXCEPT_AA64_EL1):
>>   			enter_exception64(vcpu, PSR_MODE_EL1h, except_type_sync);
>>   			break;
>> +		case (KVM_ARM64_EXCEPT_AA64_ELx_IRQ |
>> +		      KVM_ARM64_EXCEPT_AA64_EL1):
>> +			enter_exception64(vcpu, PSR_MODE_EL1h, except_type_irq);
>> +			break;
>>   		default:
>>   			/*
>>   			 * Only EL1_SYNC makes sense so far, EL2_{SYNC,IRQ}
>> diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
>> index b47df73e98d7..3a8c55867d2f 100644
>> --- a/arch/arm64/kvm/inject_fault.c
>> +++ b/arch/arm64/kvm/inject_fault.c
>> @@ -66,6 +66,13 @@ static void inject_undef64(struct kvm_vcpu *vcpu)
>>   	vcpu_write_sys_reg(vcpu, esr, ESR_EL1);
>>   }
>>   
>> +static void inject_irq64(struct kvm_vcpu *vcpu)
>> +{
>> +	vcpu->arch.flags |= (KVM_ARM64_EXCEPT_AA64_EL1     |
>> +			     KVM_ARM64_EXCEPT_AA64_ELx_IRQ |
>> +			     KVM_ARM64_PENDING_EXCEPTION);
>> +}
>> +
>>   #define DFSR_FSC_EXTABT_LPAE	0x10
>>   #define DFSR_FSC_EXTABT_nLPAE	0x08
>>   #define DFSR_LPAE		BIT(9)
>> @@ -77,6 +84,12 @@ static void inject_undef32(struct kvm_vcpu *vcpu)
>>   			     KVM_ARM64_PENDING_EXCEPTION);
>>   }
>>   
>> +static void inject_irq32(struct kvm_vcpu *vcpu)
>> +{
>> +	vcpu->arch.flags |= (KVM_ARM64_EXCEPT_AA32_IRQ |
>> +			     KVM_ARM64_PENDING_EXCEPTION);
>> +}
>> +
>>   /*
>>    * Modelled after TakeDataAbortException() and TakePrefetchAbortException
>>    * pseudocode.
>> @@ -160,6 +173,20 @@ void kvm_inject_undefined(struct kvm_vcpu *vcpu)
>>   		inject_undef64(vcpu);
>>   }
>>   
>> +/**
>> + * kvm_inject_irq - inject an IRQ into the guest
>> + *
>> + * It is assumed that this code is called from the VCPU thread and that the
>> + * VCPU therefore is not currently executing guest code.
>> + */
>> +void kvm_inject_irq(struct kvm_vcpu *vcpu)
>> +{
>> +	if (vcpu_el1_is_32bit(vcpu))
>> +		inject_irq32(vcpu);
>> +	else
>> +		inject_irq64(vcpu);
>> +}
>> +
>>   void kvm_set_sei_esr(struct kvm_vcpu *vcpu, u64 esr)
>>   {
>>   	vcpu_set_vsesr(vcpu, esr & ESR_ELx_ISS_MASK);
>> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
>> index b5d6d1ed3858..1e8e213c9d70 100644
>> --- a/arch/arm64/kvm/sdei.c
>> +++ b/arch/arm64/kvm/sdei.c
>> @@ -308,6 +308,75 @@ static unsigned long kvm_sdei_hypercall_context(struct kvm_vcpu *vcpu)
>>   	return ret;
>>   }
>>   
>> +static unsigned long kvm_sdei_hypercall_complete(struct kvm_vcpu *vcpu,
>> +						 bool resume)
>> +{
>> +	struct kvm *kvm = vcpu->kvm;
>> +	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
>> +	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
>> +	struct kvm_sdei_kvm_event *kske = NULL;
>> +	struct kvm_sdei_vcpu_event *ksve = NULL;
>> +	struct kvm_sdei_vcpu_regs *regs;
>> +	unsigned long ret = SDEI_SUCCESS;
> for the RESUME you never seem to read resume_addr arg? How does it work?
> I don't get the irq injection path. Please could you explain?

The guest kernel uses COMPLETE and COMPLETE_AND_RESUME hypercalls to notify the
SDEI event has been acknoledged by it. The difference between them is COMPLETE_AND_RESUME
fires the pending interrupts, but COMPLETE doesn't.

>> +	int index;
>> +
>> +	/* Sanity check */
>> +	if (!(ksdei && vsdei)) {
>> +		ret = SDEI_NOT_SUPPORTED;
>> +		goto out;
>> +	}
>> +
>> +	spin_lock(&vsdei->lock);
>> +	if (vsdei->critical_event) {
>> +		ksve = vsdei->critical_event;
>> +		regs = &vsdei->state.critical_regs;
>> +		vsdei->critical_event = NULL;
>> +		vsdei->state.critical_num = KVM_SDEI_INVALID_NUM;
>> +	} else if (vsdei->normal_event) {
>> +		ksve = vsdei->normal_event;
>> +		regs = &vsdei->state.normal_regs;
>> +		vsdei->normal_event = NULL;
>> +		vsdei->state.normal_num = KVM_SDEI_INVALID_NUM;
>> +	} else {
>> +		ret = SDEI_DENIED;
>> +		goto unlock;
>> +	}
>> +
>> +	/* Restore registers: x0 -> x17, PC, PState */
>> +	for (index = 0; index < ARRAY_SIZE(regs->regs); index++)
>> +		vcpu_set_reg(vcpu, index, regs->regs[index]);
>> +
>> +	*vcpu_cpsr(vcpu) = regs->pstate;
>> +	*vcpu_pc(vcpu) = regs->pc;
>> +
>> +	/* Inject interrupt if needed */
>> +	if (resume)
>> +		kvm_inject_irq(vcpu);
>> +
>> +	/*
>> +	 * Update state. We needn't take lock in order to update the KVM
>> +	 * event state as it's not destroyed because of the reference
>> +	 * count.
>> +	 */
>> +	kske = ksve->kske;
>> +	ksve->state.refcount--;
>> +	kske->state.refcount--;
> why double --?

On each SDEI event is queued for delivery, both reference count are increased. I guess
it's a bit confusing. I will change in next revision:

ksve->state.refcount: Increased on each SDEI event is queued for delivered
kske->state.refcount: Increased on each @ksve is created


>> +	if (!ksve->state.refcount) {
> why not using a struct kref directly?

The reason is kref isn't friendly to userspace. This field (@refcount) needs to be
migrated :)

>> +		list_del(&ksve->link);
>> +		kfree(ksve);
>> +	}
>> +
>> +	/* Make another request if there is pending event */
>> +	if (!(list_empty(&vsdei->critical_events) &&
>> +	      list_empty(&vsdei->normal_events)))
>> +		kvm_make_request(KVM_REQ_SDEI, vcpu);
>> +
>> +unlock:
>> +	spin_unlock(&vsdei->lock);
>> +out:
>> +	return ret;
>> +}
>> +
>>   static unsigned long kvm_sdei_hypercall_unregister(struct kvm_vcpu *vcpu)
>>   {
>>   	struct kvm *kvm = vcpu->kvm;
>> @@ -628,7 +697,13 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>>   		ret = kvm_sdei_hypercall_context(vcpu);
>>   		break;
>>   	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE:
>> +		has_result = false;
>> +		ret = kvm_sdei_hypercall_complete(vcpu, false);
>> +		break;
>>   	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME:
>> +		has_result = false;
>> +		ret = kvm_sdei_hypercall_complete(vcpu, true);
>> +		break;
>>   	case SDEI_1_0_FN_SDEI_EVENT_UNREGISTER:
>>   		ret = kvm_sdei_hypercall_unregister(vcpu);
>>   		break;
>>

Thanks,
Gavin

