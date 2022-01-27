Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACDAF49E5E2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 16:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbiA0PVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 10:21:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38637 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232640AbiA0PVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:21:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643296865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m09KuPll96lK3eZtExH0uBzkSWTiuK60NkhVi9XKS9w=;
        b=X2AjRSS471s/D1pMuANMsC3rKc/qivyCUBHwoYnoHz9LuGrBpo6jF1VsbBf+g/eRqWla9K
        zkf+otHbNSTJURMXgW+PP1Xc0Emoc/ZIgRIFLK0iZuGqqf/+ivawM/TMj0RU0KK1Y8vrbi
        7s4LJY/3SBS0t59aqy720ASpv5oznY4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-fvSx-oBeNfuCpwAvwjNyBA-1; Thu, 27 Jan 2022 10:21:03 -0500
X-MC-Unique: fvSx-oBeNfuCpwAvwjNyBA-1
Received: by mail-wr1-f70.google.com with SMTP id c9-20020adfa709000000b001dde29c3202so1177168wrd.22
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 07:21:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m09KuPll96lK3eZtExH0uBzkSWTiuK60NkhVi9XKS9w=;
        b=Dq76JFheGDvNqNpmXLfMdAjuE7mts9P4HIYf/XAueeAEiImLr7v4rCzhvH2+ps7VC/
         C5kkQO56XhY6Fjm9bsLU18Db2Q7jWa36B4aG4kEKxQqCttAibJGwxzS5b4Hh3Datrq3c
         MPpaTjJadI3Iuhrusr9Ej/mj7aSnJKlhUQWc0JPcnpAJ5C3Fc7dyvzc8b49X3nWK3JDm
         cWrCtZR635y3So6Ee4wZ6Px+NQdjiGI57sdiKYXMWJMofE8SkG1NDeEEV/l/yC9cZ6LC
         qGX/emR3yNhpHQsnV2/eBfyz2RuTpPhlZ5L+9dVd1YTL1nub2MEr3CDDt4PtFAa4ZIw4
         JM0Q==
X-Gm-Message-State: AOAM532np4nfEyKH4C4UbIqPiTgw9GlsR+W+GtJOfrT3EPJnelGkDpKY
        lYTuVGTlwIDk46Wu8/xU3c97PNAB1KEDKsofcUJkprRqAZcRmveN7jMeTrFGS2Y7hXZ4LP2m5/A
        mIpRCP9Nx0uHEUsntMaqqamV/
X-Received: by 2002:a5d:6f05:: with SMTP id ay5mr3504077wrb.192.1643296861515;
        Thu, 27 Jan 2022 07:21:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJww4O0BprX6fKhLSsVD/osqEVNe1lwuCjQRTufLDZYYsYrxTU7w78G0DgKzXhx6JHyWHmfItQ==
X-Received: by 2002:a5d:6f05:: with SMTP id ay5mr3504062wrb.192.1643296861235;
        Thu, 27 Jan 2022 07:21:01 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id p190sm2235489wmp.16.2022.01.27.07.21.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 07:21:00 -0800 (PST)
Subject: Re: [PATCH v4 14/21] KVM: arm64: Support SDEI_EVENT_{COMPLETE,
 COMPLETE_AND_RESUME} hypercall
To:     Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-15-gshan@redhat.com>
 <62c67e31-fa33-24e9-6508-59976673c0db@redhat.com>
 <fdb013e7-10a1-58de-92aa-3ab9d25346fa@redhat.com>
From:   Eric Auger <eauger@redhat.com>
Message-ID: <e862132c-7151-e018-2a15-0bd06932f702@redhat.com>
Date:   Thu, 27 Jan 2022 16:20:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <fdb013e7-10a1-58de-92aa-3ab9d25346fa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gavin,
On 1/12/22 7:43 AM, Gavin Shan wrote:
> Hi Eric,
> 
> On 11/10/21 6:58 PM, Eric Auger wrote:
>> On 8/15/21 2:13 AM, Gavin Shan wrote:
>>> This supports SDEI_EVENT_{COMPLETE, COMPLETE_AND_RESUME} hypercall.
>>> They are used by the guest to notify the completion of the SDEI
>>> event in the handler. The registers are changed according to the
>>> SDEI specification as below:
>>>
>>>     * x0 - x17, PC and PState are restored to what values we had in
>>>       the interrupted context.
>>>
>>>     * If it's SDEI_EVENT_COMPLETE_AND_RESUME hypercall, IRQ exception
>>>       is injected.
>>>
>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>> ---
>>>   arch/arm64/include/asm/kvm_emulate.h |  1 +
>>>   arch/arm64/include/asm/kvm_host.h    |  1 +
>>>   arch/arm64/kvm/hyp/exception.c       |  7 +++
>>>   arch/arm64/kvm/inject_fault.c        | 27 ++++++++++
>>>   arch/arm64/kvm/sdei.c                | 75 ++++++++++++++++++++++++++++
>>>   5 files changed, 111 insertions(+)
>>>
>>> diff --git a/arch/arm64/include/asm/kvm_emulate.h
>>> b/arch/arm64/include/asm/kvm_emulate.h
>>> index fd418955e31e..923b4d08ea9a 100644
>>> --- a/arch/arm64/include/asm/kvm_emulate.h
>>> +++ b/arch/arm64/include/asm/kvm_emulate.h
>>> @@ -37,6 +37,7 @@ bool kvm_condition_valid32(const struct kvm_vcpu
>>> *vcpu);
>>>   void kvm_skip_instr32(struct kvm_vcpu *vcpu);
>>>     void kvm_inject_undefined(struct kvm_vcpu *vcpu);
>>> +void kvm_inject_irq(struct kvm_vcpu *vcpu);
>>>   void kvm_inject_vabt(struct kvm_vcpu *vcpu);
>>>   void kvm_inject_dabt(struct kvm_vcpu *vcpu, unsigned long addr);
>>>   void kvm_inject_pabt(struct kvm_vcpu *vcpu, unsigned long addr);
>>> diff --git a/arch/arm64/include/asm/kvm_host.h
>>> b/arch/arm64/include/asm/kvm_host.h
>>> index 46f363aa6524..1824f7e1f9ab 100644
>>> --- a/arch/arm64/include/asm/kvm_host.h
>>> +++ b/arch/arm64/include/asm/kvm_host.h
>>> @@ -437,6 +437,7 @@ struct kvm_vcpu_arch {
>>>   #define KVM_ARM64_EXCEPT_AA32_UND    (0 << 9)
>>>   #define KVM_ARM64_EXCEPT_AA32_IABT    (1 << 9)
>>>   #define KVM_ARM64_EXCEPT_AA32_DABT    (2 << 9)
>>> +#define KVM_ARM64_EXCEPT_AA32_IRQ    (3 << 9)
>>>   /* For AArch64: */
>>>   #define KVM_ARM64_EXCEPT_AA64_ELx_SYNC    (0 << 9)
>>>   #define KVM_ARM64_EXCEPT_AA64_ELx_IRQ    (1 << 9)
>>> diff --git a/arch/arm64/kvm/hyp/exception.c
>>> b/arch/arm64/kvm/hyp/exception.c
>>> index 0418399e0a20..ef458207d152 100644
>>> --- a/arch/arm64/kvm/hyp/exception.c
>>> +++ b/arch/arm64/kvm/hyp/exception.c
>>> @@ -310,6 +310,9 @@ static void kvm_inject_exception(struct kvm_vcpu
>>> *vcpu)
>>>           case KVM_ARM64_EXCEPT_AA32_DABT:
>>>               enter_exception32(vcpu, PSR_AA32_MODE_ABT, 16);
>>>               break;
>>> +        case KVM_ARM64_EXCEPT_AA32_IRQ:
>>> +            enter_exception32(vcpu, PSR_AA32_MODE_IRQ, 4);
>>> +            break;
>>>           default:
>>>               /* Err... */
>>>               break;
>>> @@ -320,6 +323,10 @@ static void kvm_inject_exception(struct kvm_vcpu
>>> *vcpu)
>>>                 KVM_ARM64_EXCEPT_AA64_EL1):
>>>               enter_exception64(vcpu, PSR_MODE_EL1h, except_type_sync);
>>>               break;
>>> +        case (KVM_ARM64_EXCEPT_AA64_ELx_IRQ |
>>> +              KVM_ARM64_EXCEPT_AA64_EL1):
>>> +            enter_exception64(vcpu, PSR_MODE_EL1h, except_type_irq);
>>> +            break;
>>>           default:
>>>               /*
>>>                * Only EL1_SYNC makes sense so far, EL2_{SYNC,IRQ}
>>> diff --git a/arch/arm64/kvm/inject_fault.c
>>> b/arch/arm64/kvm/inject_fault.c
>>> index b47df73e98d7..3a8c55867d2f 100644
>>> --- a/arch/arm64/kvm/inject_fault.c
>>> +++ b/arch/arm64/kvm/inject_fault.c
>>> @@ -66,6 +66,13 @@ static void inject_undef64(struct kvm_vcpu *vcpu)
>>>       vcpu_write_sys_reg(vcpu, esr, ESR_EL1);
>>>   }
>>>   +static void inject_irq64(struct kvm_vcpu *vcpu)
>>> +{
>>> +    vcpu->arch.flags |= (KVM_ARM64_EXCEPT_AA64_EL1     |
>>> +                 KVM_ARM64_EXCEPT_AA64_ELx_IRQ |
>>> +                 KVM_ARM64_PENDING_EXCEPTION);
>>> +}
>>> +
>>>   #define DFSR_FSC_EXTABT_LPAE    0x10
>>>   #define DFSR_FSC_EXTABT_nLPAE    0x08
>>>   #define DFSR_LPAE        BIT(9)
>>> @@ -77,6 +84,12 @@ static void inject_undef32(struct kvm_vcpu *vcpu)
>>>                    KVM_ARM64_PENDING_EXCEPTION);
>>>   }
>>>   +static void inject_irq32(struct kvm_vcpu *vcpu)
>>> +{
>>> +    vcpu->arch.flags |= (KVM_ARM64_EXCEPT_AA32_IRQ |
>>> +                 KVM_ARM64_PENDING_EXCEPTION);
>>> +}
>>> +
>>>   /*
>>>    * Modelled after TakeDataAbortException() and
>>> TakePrefetchAbortException
>>>    * pseudocode.
>>> @@ -160,6 +173,20 @@ void kvm_inject_undefined(struct kvm_vcpu *vcpu)
>>>           inject_undef64(vcpu);
>>>   }
>>>   +/**
>>> + * kvm_inject_irq - inject an IRQ into the guest
>>> + *
>>> + * It is assumed that this code is called from the VCPU thread and
>>> that the
>>> + * VCPU therefore is not currently executing guest code.
>>> + */
>>> +void kvm_inject_irq(struct kvm_vcpu *vcpu)
>>> +{
>>> +    if (vcpu_el1_is_32bit(vcpu))
>>> +        inject_irq32(vcpu);
>>> +    else
>>> +        inject_irq64(vcpu);
>>> +}
>>> +
>>>   void kvm_set_sei_esr(struct kvm_vcpu *vcpu, u64 esr)
>>>   {
>>>       vcpu_set_vsesr(vcpu, esr & ESR_ELx_ISS_MASK);
>>> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
>>> index b5d6d1ed3858..1e8e213c9d70 100644
>>> --- a/arch/arm64/kvm/sdei.c
>>> +++ b/arch/arm64/kvm/sdei.c
>>> @@ -308,6 +308,75 @@ static unsigned long
>>> kvm_sdei_hypercall_context(struct kvm_vcpu *vcpu)
>>>       return ret;
>>>   }
>>>   +static unsigned long kvm_sdei_hypercall_complete(struct kvm_vcpu
>>> *vcpu,
>>> +                         bool resume)
>>> +{
>>> +    struct kvm *kvm = vcpu->kvm;
>>> +    struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
>>> +    struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
>>> +    struct kvm_sdei_kvm_event *kske = NULL;
>>> +    struct kvm_sdei_vcpu_event *ksve = NULL;
>>> +    struct kvm_sdei_vcpu_regs *regs;
>>> +    unsigned long ret = SDEI_SUCCESS;
>> for the RESUME you never seem to read resume_addr arg? How does it work?
>> I don't get the irq injection path. Please could you explain?
> 
> The guest kernel uses COMPLETE and COMPLETE_AND_RESUME hypercalls to
> notify the
> SDEI event has been acknoledged by it. The difference between them is
> COMPLETE_AND_RESUME
> fires the pending interrupts, but COMPLETE doesn't.
> 
>>> +    int index;
>>> +
>>> +    /* Sanity check */
>>> +    if (!(ksdei && vsdei)) {
>>> +        ret = SDEI_NOT_SUPPORTED;
>>> +        goto out;
>>> +    }
>>> +
>>> +    spin_lock(&vsdei->lock);
>>> +    if (vsdei->critical_event) {
>>> +        ksve = vsdei->critical_event;
>>> +        regs = &vsdei->state.critical_regs;
>>> +        vsdei->critical_event = NULL;
>>> +        vsdei->state.critical_num = KVM_SDEI_INVALID_NUM;
>>> +    } else if (vsdei->normal_event) {
>>> +        ksve = vsdei->normal_event;
>>> +        regs = &vsdei->state.normal_regs;
>>> +        vsdei->normal_event = NULL;
>>> +        vsdei->state.normal_num = KVM_SDEI_INVALID_NUM;
>>> +    } else {
>>> +        ret = SDEI_DENIED;
>>> +        goto unlock;
>>> +    }
>>> +
>>> +    /* Restore registers: x0 -> x17, PC, PState */
>>> +    for (index = 0; index < ARRAY_SIZE(regs->regs); index++)
>>> +        vcpu_set_reg(vcpu, index, regs->regs[index]);
>>> +
>>> +    *vcpu_cpsr(vcpu) = regs->pstate;
>>> +    *vcpu_pc(vcpu) = regs->pc;
>>> +
>>> +    /* Inject interrupt if needed */
>>> +    if (resume)
>>> +        kvm_inject_irq(vcpu);
>>> +
>>> +    /*
>>> +     * Update state. We needn't take lock in order to update the KVM
>>> +     * event state as it's not destroyed because of the reference
>>> +     * count.
>>> +     */
>>> +    kske = ksve->kske;
>>> +    ksve->state.refcount--;
>>> +    kske->state.refcount--;
>> why double --?

> 
> On each SDEI event is queued for delivery, both reference count are
> increased. I guess
> it's a bit confusing. I will change in next revision:
> 
> ksve->state.refcount: Increased on each SDEI event is queued for delivered
> kske->state.refcount: Increased on each @ksve is created
Well generally this kind of stuff is frown upon.
> 
> 
>>> +    if (!ksve->state.refcount) {
>> why not using a struct kref directly?
> 
> The reason is kref isn't friendly to userspace. This field (@refcount)
> needs to be
> migrated :)
waiting for the mig documentation to further comment.

Thanks

Eric
> 
>>> +        list_del(&ksve->link);
>>> +        kfree(ksve);
>>> +    }
>>> +
>>> +    /* Make another request if there is pending event */
>>> +    if (!(list_empty(&vsdei->critical_events) &&
>>> +          list_empty(&vsdei->normal_events)))
>>> +        kvm_make_request(KVM_REQ_SDEI, vcpu);
>>> +
>>> +unlock:
>>> +    spin_unlock(&vsdei->lock);
>>> +out:
>>> +    return ret;
>>> +}
>>> +
>>>   static unsigned long kvm_sdei_hypercall_unregister(struct kvm_vcpu
>>> *vcpu)
>>>   {
>>>       struct kvm *kvm = vcpu->kvm;
>>> @@ -628,7 +697,13 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>>>           ret = kvm_sdei_hypercall_context(vcpu);
>>>           break;
>>>       case SDEI_1_0_FN_SDEI_EVENT_COMPLETE:
>>> +        has_result = false;
>>> +        ret = kvm_sdei_hypercall_complete(vcpu, false);
>>> +        break;
>>>       case SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME:
>>> +        has_result = false;
>>> +        ret = kvm_sdei_hypercall_complete(vcpu, true);
>>> +        break;
>>>       case SDEI_1_0_FN_SDEI_EVENT_UNREGISTER:
>>>           ret = kvm_sdei_hypercall_unregister(vcpu);
>>>           break;
>>>
> 
> Thanks,
> Gavin
> 

