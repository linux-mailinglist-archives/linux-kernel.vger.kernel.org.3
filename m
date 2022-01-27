Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36AAF49E32D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241623AbiA0NRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:17:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24311 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236333AbiA0NRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:17:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643289468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=quNV7QiDJuWYENkY3uXPAoFpSOJDshvxFzH3jG4pZsA=;
        b=eQfaMdqDzbrZDmCLSUopRcDF5QCdTezUpBruyXLNqRRw/tLpUspju7DaduvLXRvk2fzdNq
        vbNCBz1y+lao6Ajrm8kXQ54b8QDFkmH6RAhsDlB/tyhQ3C/JqkD40ZWnlipfNkRQytrl5R
        YPtG1a8W0gV6q0pZC3cHKInbuaN79rs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-0Cc5CIo_OeuBNc3DR2bqEg-1; Thu, 27 Jan 2022 08:17:47 -0500
X-MC-Unique: 0Cc5CIo_OeuBNc3DR2bqEg-1
Received: by mail-wr1-f70.google.com with SMTP id w7-20020adfbac7000000b001d6f75e4faeso1082124wrg.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:17:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=quNV7QiDJuWYENkY3uXPAoFpSOJDshvxFzH3jG4pZsA=;
        b=1dsINc3AU5OBKgJ8f8CrzvPMMz4qB6gkTBFVUhVZx/c0Tgw/QhE1La7hLi644eRBND
         1MmwVma6QcgMzHOR9w7J8mc4SiC06y9RLjlwQscWYFU6Ukb+n4RoLdlifYA6UBQpjJJS
         IWfPHuerM47FdwxNukNICT//jug4L/BieMWMMvn0k6cy5Ry6ip4C3qhYhmULqlGyx44W
         p77nBRKJBjQfM54LLQwTXiyJGpvCRrLapFnL0RuMvpsafwwxO2IwspM3HDOevIVL2bSW
         ZIMbXIEsgcLBTZQEoWHXRtS6aMGY4bQ6AM9FQMW3I5ADfiF1W+TB0ARF+CE8ozVkC3Yd
         mR3A==
X-Gm-Message-State: AOAM533cLGPJqkE+1eN8fFho5waJf1Bhdda7iSK/rXvpp7n6f9hEQuV1
        yzcIN1LLbyiK03Hhx+8jNRVjBHIPUWvfPJo9SmnRqBt90vekBslpGGJVZU6aflPv54crOk0Xybn
        Bry80HxdnYudbdqQQyZhyD2ZY
X-Received: by 2002:adf:db0a:: with SMTP id s10mr3073146wri.267.1643289464824;
        Thu, 27 Jan 2022 05:17:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxlUJXRMO7owUEpQK9JMFUrslMP5gbTww4o6W4bhgGMe4i+pU39D/5BzhF+2L5LDzXSDLIMig==
X-Received: by 2002:adf:db0a:: with SMTP id s10mr3073101wri.267.1643289464168;
        Thu, 27 Jan 2022 05:17:44 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id u19sm1887305wmm.39.2022.01.27.05.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 05:17:43 -0800 (PST)
Subject: Re: [PATCH v4 02/21] KVM: arm64: Add SDEI virtualization
 infrastructure
To:     Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-3-gshan@redhat.com>
 <8108db38-e0fa-774b-c884-70b8606a3ab9@redhat.com>
 <dcb8e2db-7189-b241-3e74-39257d282363@redhat.com>
From:   Eric Auger <eauger@redhat.com>
Message-ID: <78c08701-324d-e519-2817-a923d282554a@redhat.com>
Date:   Thu, 27 Jan 2022 14:17:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <dcb8e2db-7189-b241-3e74-39257d282363@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gavin,

On 1/11/22 10:20 AM, Gavin Shan wrote:
> Hi Eric,
> 
> On 11/9/21 11:45 PM, Eric Auger wrote:
>> On 8/15/21 2:13 AM, Gavin Shan wrote:
>>> Software Delegated Exception Interface (SDEI) provides a mechanism for
>>> registering and servicing system events. Those system events are high
>>> priority events, which must be serviced immediately. It's going to be
>>> used by Asynchronous Page Fault (APF) to deliver notification from KVM
>>> to guest. It's noted that SDEI is defined by ARM DEN0054A specification.
>>>
>>> This introduces SDEI virtualization infrastructure where the SDEI events
>>> are registered and manuplated by the guest through hypercall. The SDEI
>> manipulated
> 
> Thanks, It will be corrected in next respin.
> 
>>> event is delivered to one specific vCPU by KVM once it's raised. This
>>> introduces data structures to represent the needed objects to implement
>>> the feature, which is highlighted as below. As those objects could be
>>> migrated between VMs, these data structures are partially exported to
>>> user space.
>>>
>>>     * kvm_sdei_event
>>>       SDEI events are exported from KVM so that guest is able to
>>> register
>>>       and manuplate.
>> manipulate
> 
> Thanks, It will be fixed in next respin. I'm uncertain how the wrong
> spelling are still existing even though I had spelling check with
> "scripts/checkpatch.pl --codespell".
I don't know. I am not used to it :(
> 
>>>     * kvm_sdei_kvm_event
>>>       SDEI event that has been registered by guest.
>> I would recomment to revisit the names. Why kvm event? Why not
>> registered_event instead that actually would tell what it its. also you
>> have kvm twice in the struct name.
> 
> Yep, I think I need reconsider the struct names. The primary reason
> why I had the names are keeping the struct names short enough while
> being easy to be identified: "kvm_sdei" is the prefix. How about to
> have the following struct names?
also kvm_sdei_kvm looks awkward to me. since it is arch specific,
couldn't you name kvm_sdei_arch?
> 
>     kvm_sdei_event             events exported from KVM to userspace
>     kvm_sdei_kevent            events registered (associated) to KVM
I still don't find kevent self explanatory. and even confusing because
it makes me think of events exposed by kvm.

To me there are exposed events and registered events and I think it
would be simpler to stick to this terminology. I would rather rename
kevent into registered_event.
>     kvm_sdei_vevent            events associated with vCPU
s/vevent/vcpu_event otherwise sounds like virtual event
>     kvm_sdei_vcpu              vCPU context for event delivery
> 
>>>     * kvm_sdei_kvm_vcpu
>> Didn't you mean kvm_sdei_vcpu_event instead?
> 
> Yeah, you're correct. I was supposed to explain kvm_sdei_vcpu_event here.
> 
>>>       SDEI event that has been delivered to the target vCPU.
>>>     * kvm_sdei_kvm
>>>       Place holder of exported and registered SDEI events.
>>>     * kvm_sdei_vcpu
>>>       Auxiliary object to save the preempted context during SDEI event
>>>       delivery.
>>>
>>> The error is returned for all SDEI hypercalls for now. They will be
>>> implemented by the subsequent patches.
>>>
>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>> ---
>>>   arch/arm64/include/asm/kvm_host.h      |   6 +
>>>   arch/arm64/include/asm/kvm_sdei.h      | 118 +++++++++++++++
>>>   arch/arm64/include/uapi/asm/kvm.h      |   1 +
>>>   arch/arm64/include/uapi/asm/kvm_sdei.h |  60 ++++++++
>>>   arch/arm64/kvm/Makefile                |   2 +-
>>>   arch/arm64/kvm/arm.c                   |   7 +
>>>   arch/arm64/kvm/hypercalls.c            |  18 +++
>>>   arch/arm64/kvm/sdei.c                  | 198 +++++++++++++++++++++++++
>>>   8 files changed, 409 insertions(+), 1 deletion(-)
>>>   create mode 100644 arch/arm64/include/asm/kvm_sdei.h
>>>   create mode 100644 arch/arm64/include/uapi/asm/kvm_sdei.h
>>>   create mode 100644 arch/arm64/kvm/sdei.c
>>>
>>> diff --git a/arch/arm64/include/asm/kvm_host.h
>>> b/arch/arm64/include/asm/kvm_host.h
>>> index 41911585ae0c..aedf901e1ec7 100644
>>> --- a/arch/arm64/include/asm/kvm_host.h
>>> +++ b/arch/arm64/include/asm/kvm_host.h
>>> @@ -113,6 +113,9 @@ struct kvm_arch {
>>>       /* Interrupt controller */
>>>       struct vgic_dist    vgic;
>>>   +    /* SDEI support */
>> does not bring much. Why not reusing the commit msg explanation? Here
>> and below.
> 
> I would drop the comment in next respin because I want to avoid too much
> comments to be embedded into "struct kvm_arch". The struct is already
> huge in terms of number of fields.
Yep I would drop it too.
> 
>>> +    struct kvm_sdei_kvm *sdei;
>>> +
>>>       /* Mandated version of PSCI */
>>>       u32 psci_version;
>>>   @@ -339,6 +342,9 @@ struct kvm_vcpu_arch {
>>>        * here.
>>>        */
>>>   +    /* SDEI support */
>>> +    struct kvm_sdei_vcpu *sdei;> +
>>>       /*
>>>        * Guest registers we preserve during guest debugging.
>>>        *
>>> diff --git a/arch/arm64/include/asm/kvm_sdei.h
>>> b/arch/arm64/include/asm/kvm_sdei.h
>>> new file mode 100644
>>> index 000000000000..b0abc13a0256
>>> --- /dev/null
>>> +++ b/arch/arm64/include/asm/kvm_sdei.h
>>> @@ -0,0 +1,118 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>> +/*
>>> + * Definitions of various KVM SDEI events.
>>> + *
>>> + * Copyright (C) 2021 Red Hat, Inc.
>>> + *
>>> + * Author(s): Gavin Shan <gshan@redhat.com>
>>> + */
>>> +
>>> +#ifndef __ARM64_KVM_SDEI_H__
>>> +#define __ARM64_KVM_SDEI_H__
>>> +
>>> +#include <uapi/linux/arm_sdei.h>> +#include <uapi/asm/kvm_sdei.h>
>>> +#include <linux/bitmap.h>
>>> +#include <linux/list.h>
>>> +#include <linux/spinlock.h>
>>> +
>>> +struct kvm_sdei_event {
>>> +    struct kvm_sdei_event_state        state;
>>> +    struct kvm                *kvm;
>>> +    struct list_head            link;>>> +};
>>> +
>>> +struct kvm_sdei_kvm_event {
>>> +    struct kvm_sdei_kvm_event_state        state;
>>> +    struct kvm_sdei_event            *kse;
>>> +    struct kvm                *kvm;
>> can't you reuse the kvm handle in state?
> 
> Nope, there is no kvm handle in @state.
right mixed names sorry
> 
>>> +    struct list_head            link;
>>> +};
>>> +
>>> +struct kvm_sdei_vcpu_event {
>>> +    struct kvm_sdei_vcpu_event_state    state;
>>> +    struct kvm_sdei_kvm_event        *kske;
>>> +    struct kvm_vcpu                *vcpu;
>>> +    struct list_head            link;
>>> +};
>>> +
>>> +struct kvm_sdei_kvm {
>>> +    spinlock_t        lock;
>>> +    struct list_head    events;        /* kvm_sdei_event */
>>> +    struct list_head    kvm_events;    /* kvm_sdei_kvm_event */
>>> +};
>>> +
>>> +struct kvm_sdei_vcpu {
>>> +    spinlock_t                      lock;
>>> +    struct kvm_sdei_vcpu_state      state;
>> could you explain the fields below?
> 
> As defined by the specification, each SDEI event is given priority:
> critical
> or normal priority. The priority affects how the SDEI event is delivered.
> The critical event can preempt the normal one, but the reverse thing can't
> be done.
> 
>>> +    struct kvm_sdei_vcpu_event      *critical_event;
>>> +    struct kvm_sdei_vcpu_event      *normal_event;
>>> +    struct list_head                critical_events;
>>> +    struct list_head                normal_events;
>>> +};
>>> +
>>> +/*
>>> + * According to SDEI specification (v1.0), the event number spans
>>> 32-bits
>>> + * and the lower 24-bits are used as the (real) event number. I don't
>>> + * think we can use that much SDEI numbers in one system. So we reserve
>>> + * two bits from the 24-bits real event number, to indicate its types:
>>> + * physical event and virtual event. One reserved bit is enough for
>>> now,
>>> + * but two bits are reserved for possible extension in future.
>> I think this assumption is worth to be mentionned in the commit msg.
> 
> Sure, I will explain it in the commit log in next respin.
> 
>>> + *
>>> + * The physical events are owned by underly firmware while the virtual
>> underly?
> 
> s/underly firmware/firmware in next respin.
> 
>>> + * events are used by VMM and KVM.
>>> + */
>>> +#define KVM_SDEI_EV_NUM_TYPE_SHIFT    22
>>> +#define KVM_SDEI_EV_NUM_TYPE_MASK    3
>>> +#define KVM_SDEI_EV_NUM_TYPE_PHYS    0
>>> +#define KVM_SDEI_EV_NUM_TYPE_VIRT    1
>>> +
>>> +static inline bool kvm_sdei_is_valid_event_num(unsigned long num)
>> the name of the function does does not really describe what it does. It
>> actually checks the sdei is a virtual one. suggest kvm_sdei_is_virtual?
> 
> The header file is only used by KVM where the virtual SDEI event is the
> only concern. However, kvm_sdei_is_virtual() is a better name.
> 
>>> +{
>>> +    unsigned long type;
>>> +
>>> +    if (num >> 32)
>>> +        return false;
>>> +
>>> +    type = (num >> KVM_SDEI_EV_NUM_TYPE_SHIFT) &
>>> KVM_SDEI_EV_NUM_TYPE_MASK;
>> I think the the mask generally is applied before shifting. See
>> include/linux/irqchip/arm-gic-v3.h
> 
> Ok, I will adopt the style in next respin.
> 
>>> +    if (type != KVM_SDEI_EV_NUM_TYPE_VIRT)
>>> +        return false;
>>> +
>>> +    return true;
>>> +}
>>> +
>>> +/* Accessors for the registration or enablement states of KVM event */
>>> +#define KVM_SDEI_FLAG_FUNC(field)                       \
>>> +static inline bool kvm_sdei_is_##field(struct kvm_sdei_kvm_event
>>> *kske,       \
>>> +                       unsigned int index)           \
>>> +{                                       \
>>> +    return !!test_bit(index, (void *)(kske->state.field));           \
>>> +}                                       \
>>> +                                       \
>>> +static inline bool kvm_sdei_empty_##field(struct kvm_sdei_kvm_event
>>> *kske) \
>> nit: s/empty/none ?
> 
> "empty" is sticky to bitmap_empty(), but "none" here looks better :)
> 
>>> +{                                       \
>>> +    return bitmap_empty((void *)(kske->state.field),           \
>>> +                KVM_SDEI_MAX_VCPUS);               \
>>> +}                                       \
>>> +static inline void kvm_sdei_set_##field(struct kvm_sdei_kvm_event
>>> *kske,   \
>>> +                    unsigned int index)           \
>>> +{                                       \
>>> +    set_bit(index, (void *)(kske->state.field));               \
>>> +}                                       \
>>> +static inline void kvm_sdei_clear_##field(struct kvm_sdei_kvm_event
>>> *kske, \
>>> +                      unsigned int index)           \
>>> +{                                       \
>>> +    clear_bit(index, (void *)(kske->state.field));               \
>>> +}
>>> +
>>> +KVM_SDEI_FLAG_FUNC(registered)
>>> +KVM_SDEI_FLAG_FUNC(enabled)
>>> +
>>> +/* APIs */
>>> +void kvm_sdei_init_vm(struct kvm *kvm);
>>> +void kvm_sdei_create_vcpu(struct kvm_vcpu *vcpu);
>>> +int kvm_sdei_hypercall(struct kvm_vcpu *vcpu);
>>> +void kvm_sdei_destroy_vcpu(struct kvm_vcpu *vcpu);
>>> +void kvm_sdei_destroy_vm(struct kvm *kvm);
>>> +
>>> +#endif /* __ARM64_KVM_SDEI_H__ */
>>> diff --git a/arch/arm64/include/uapi/asm/kvm.h
>>> b/arch/arm64/include/uapi/asm/kvm.h
>>> index b3edde68bc3e..e1b200bb6482 100644
>>> --- a/arch/arm64/include/uapi/asm/kvm.h
>>> +++ b/arch/arm64/include/uapi/asm/kvm.h
>>> @@ -36,6 +36,7 @@
>>>   #include <linux/types.h>
>>>   #include <asm/ptrace.h>
>>>   #include <asm/sve_context.h>
>>> +#include <asm/kvm_sdei.h>
>>>     #define __KVM_HAVE_GUEST_DEBUG
>>>   #define __KVM_HAVE_IRQ_LINE
>>> diff --git a/arch/arm64/include/uapi/asm/kvm_sdei.h
>>> b/arch/arm64/include/uapi/asm/kvm_sdei.h
>>> new file mode 100644
>>> index 000000000000..8928027023f6
>>> --- /dev/null
>>> +++ b/arch/arm64/include/uapi/asm/kvm_sdei.h
>>> @@ -0,0 +1,60 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>>> +/*
>>> + * Definitions of various KVM SDEI event states.
>>> + *
>>> + * Copyright (C) 2021 Red Hat, Inc.
>>> + *
>>> + * Author(s): Gavin Shan <gshan@redhat.com>
>>> + */
>>> +
>>> +#ifndef _UAPI__ASM_KVM_SDEI_H
>>> +#define _UAPI__ASM_KVM_SDEI_H
>>> +
>>> +#ifndef __ASSEMBLY__
>>> +#include <linux/types.h>
>>> +
>>> +#define KVM_SDEI_MAX_VCPUS    512
>>> +#define KVM_SDEI_INVALID_NUM    0
>>> +#define KVM_SDEI_DEFAULT_NUM    0x40400000
>>
>> The motivation behind introducing such uapi should be clearer (besides
>> just telling this aims at migrating). To me atm, this justification does
>> not make possible to understand if those structs are well suited. You
>> should document the migration process I think.
>>
>> I would remove _state suffix in all of them.
> 
> I think so. I will add document "Documentation/virt/kvm/arm/sdei.rst" to
> explain the design and the corresponding data structs for migration.
> However,
> I would keep "state" suffix because I used this field as indicator for
> data structs to be migrated. However, the structs should be named
> accordingly
> since they're embedded to their parent structs:
> 
>    kvm_sdei_event_state
>    kvm_sdei_kevent_state
>    kvm_sdei_vevent_state
>    kvm_sdei_vcpu_state

> 
>>> +
>>> +struct kvm_sdei_event_state {
>> This is not really a state because it cannot be changed by the guest,
>> right? I would remove _state and just call it kvm_sdei_event
> 
> The name kvm_sdei_event will be conflicting with same struct, defined
> in include/asm/kvm_sdei.h. Lets keep "_state" as I explained. I use
> the suffix as indicator to structs which need migration even though
> they're not changeable.
ok
> 
>>> +    __u64    num;
>>> +
>>> +    __u8    type;
>>> +    __u8    signaled;
>>> +    __u8    priority;
>> you need some padding to be 64-bit aligned. See in generic or aarch64
>> kvm.h for instance.
> 
> Sure.
> 
>>> +};
>>> +
>>> +struct kvm_sdei_kvm_event_state {
>> I would rename into kvm_sdei_registered_event or smth alike
anyway the doc explaining the migration process will help here.
> 
> As above, it will be conflicting with its parent struct, defined
> in include/asm/kvm_sdei.h
> 
>>> +    __u64    num;
>> how does this num differ from the event state one?
> 
> @num is same thing to that in kvm_sdei_event_state. It's used as
> index to retrieve corresponding kvm_sdei_event_state. One
> kvm_sdei_event_state
> instance can be dereferenced by kvm_sdei_kvm_event_state and
> kvm_sdei_kvm_vcpu_event_state.
> It's why we don't embed kvm_sdei_event_state in them, to avoid duplicated
> traffic in migration.
> 
>>> +    __u32    refcount;
>>> +
>>> +    __u8    route_mode;
>> padding also here. See for instance
>> https://lore.kernel.org/kvm/20200911145446.2f9f5eb8@w520.home/T/#m7bac2ff2b28a68f8d2196ec452afd3e46682760d
>>
>>
>> Maybe put the the route_mode field and refcount at the end and add one
>> byte of padding?
>>
>> Why can't we have a single sdei_event uapi representation where route
>> mode defaults to unset and refcount defaults to 0 when not registered?
>>
> 
> Ok. I will fix the padding and alignment in next respin. The
> @route_affinity
> can be changed on request from the guest. The @refcount helps to prevent
> the
> event from being unregistered if it's still dereferenced by
> kvm_sdei_vcpu_event_state.
> 
>>> +    __u64    route_affinity;
>>> +    __u64    entries[KVM_SDEI_MAX_VCPUS];
>>> +    __u64    params[KVM_SDEI_MAX_VCPUS];
>> I would rename entries into ep_address and params into ep_arg.
> 
> Ok, but what does "ep" means? I barely guess it's "entry point".
> I'm not sure if you're talking about "PE" here.
ep = entry point
> 
>>> +    __u64    registered[KVM_SDEI_MAX_VCPUS/64];
>> maybe add a comment along with KVM_SDEI_MAX_VCPUS that it must be a
>> multiple of 64 (or a build check)
>>
> 
> Sure.
>  
>>> +    __u64    enabled[KVM_SDEI_MAX_VCPUS/64];
>> Also you may clarify what this gets used for a shared event. I guess
>> this only makes sense for a private event which can be registered by
>> several EPs?
> 
> Nope, they're used by both shared and private events. For shared event,
> the bit#0 is used to indicate the state, while the individual bit is
> used for the private eventYes, the private event can be registered
> and enabled separately on multiple PEs.
> 
>>> +};
>>> +
>>> +struct kvm_sdei_vcpu_event_state {
>>> +    __u64    num;
>>> +    __u32    refcount;
>> how does it differ from num and refcount of the registered event?
>> padding++
> 
> About @num and @refcount, please refer to the above explanation. Yes,
> I will fix padding in next respin.
> 
>>> +};
>>> +
>>> +struct kvm_sdei_vcpu_regs {
>>> +    __u64    regs[18];
>>> +    __u64    pc;
>>> +    __u64    pstate;
>>> +};
>>> +
>>> +struct kvm_sdei_vcpu_state {
>>> +    __u8                masked;
>> padding++
> 
> Ok.
> 
>>> +    __u64                critical_num;
>>> +    __u64                normal_num;
>>> +    struct kvm_sdei_vcpu_regs    critical_regs;
>>> +    struct kvm_sdei_vcpu_regs    normal_regs;
>>> +};> +
>>> +#endif /* !__ASSEMBLY__ */
>>> +#endif /* _UAPI__ASM_KVM_SDEI_H */
>>> diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
>>> index 989bb5dad2c8..eefca8ca394d 100644
>>> --- a/arch/arm64/kvm/Makefile
>>> +++ b/arch/arm64/kvm/Makefile
>>> @@ -16,7 +16,7 @@ kvm-y := $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o
>>> $(KVM)/eventfd.o \
>>>        inject_fault.o va_layout.o handle_exit.o \
>>>        guest.o debug.o reset.o sys_regs.o \
>>>        vgic-sys-reg-v3.o fpsimd.o pmu.o \
>>> -     arch_timer.o trng.o\
>>> +     arch_timer.o trng.o sdei.o \
>>>        vgic/vgic.o vgic/vgic-init.o \
>>>        vgic/vgic-irqfd.o vgic/vgic-v2.o \
>>>        vgic/vgic-v3.o vgic/vgic-v4.o \
>>> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
>>> index e9a2b8f27792..2f021aa41632 100644
>>> --- a/arch/arm64/kvm/arm.c
>>> +++ b/arch/arm64/kvm/arm.c
>>> @@ -150,6 +150,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned
>>> long type)
>>>         kvm_vgic_early_init(kvm);
>>>   +    kvm_sdei_init_vm(kvm);
>>> +
>>>       /* The maximum number of VCPUs is limited by the host's GIC
>>> model */
>>>       kvm->arch.max_vcpus = kvm_arm_default_max_vcpus();
>>>   @@ -179,6 +181,8 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
>>>         kvm_vgic_destroy(kvm);
>>>   +    kvm_sdei_destroy_vm(kvm);
>>> +
>>>       for (i = 0; i < KVM_MAX_VCPUS; ++i) {
>>>           if (kvm->vcpus[i]) {
>>>               kvm_vcpu_destroy(kvm->vcpus[i]);
>>> @@ -333,6 +337,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>>>         kvm_arm_pvtime_vcpu_init(&vcpu->arch);
>>>   +    kvm_sdei_create_vcpu(vcpu);
>>> +
>>>       vcpu->arch.hw_mmu = &vcpu->kvm->arch.mmu;
>>>         err = kvm_vgic_vcpu_init(vcpu);
>>> @@ -354,6 +360,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
>>>       kvm_mmu_free_memory_cache(&vcpu->arch.mmu_page_cache);
>>>       kvm_timer_vcpu_terminate(vcpu);
>>>       kvm_pmu_vcpu_destroy(vcpu);
>>> +    kvm_sdei_destroy_vcpu(vcpu);
>>>         kvm_arm_vcpu_destroy(vcpu);
>>>   }
>>> diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
>>> index 30da78f72b3b..d3fc893a4f58 100644
>>> --- a/arch/arm64/kvm/hypercalls.c
>>> +++ b/arch/arm64/kvm/hypercalls.c
>>> @@ -139,6 +139,24 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
>>>       case ARM_SMCCC_TRNG_RND32:
>>>       case ARM_SMCCC_TRNG_RND64:
>>>           return kvm_trng_call(vcpu);
>>> +    case SDEI_1_0_FN_SDEI_VERSION:
>>> +    case SDEI_1_0_FN_SDEI_EVENT_REGISTER:
>>> +    case SDEI_1_0_FN_SDEI_EVENT_ENABLE:
>>> +    case SDEI_1_0_FN_SDEI_EVENT_DISABLE:
>>> +    case SDEI_1_0_FN_SDEI_EVENT_CONTEXT:
>>> +    case SDEI_1_0_FN_SDEI_EVENT_COMPLETE:
>>> +    case SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME:
>>> +    case SDEI_1_0_FN_SDEI_EVENT_UNREGISTER:
>>> +    case SDEI_1_0_FN_SDEI_EVENT_STATUS:
>>> +    case SDEI_1_0_FN_SDEI_EVENT_GET_INFO:
>>> +    case SDEI_1_0_FN_SDEI_EVENT_ROUTING_SET:
>>> +    case SDEI_1_0_FN_SDEI_PE_MASK:
>>> +    case SDEI_1_0_FN_SDEI_PE_UNMASK:
>>> +    case SDEI_1_0_FN_SDEI_INTERRUPT_BIND:
>>> +    case SDEI_1_0_FN_SDEI_INTERRUPT_RELEASE:
>>> +    case SDEI_1_0_FN_SDEI_PRIVATE_RESET:
>>> +    case SDEI_1_0_FN_SDEI_SHARED_RESET:
>>> +        return kvm_sdei_hypercall(vcpu);
>>>       default:
>>>           return kvm_psci_call(vcpu);
>>>       }
>>> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
>>> new file mode 100644
>>> index 000000000000..ab330b74a965
>>> --- /dev/null
>>> +++ b/arch/arm64/kvm/sdei.c
>>> @@ -0,0 +1,198 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/*
>>> + * SDEI virtualization support.
>>> + *
>>> + * Copyright (C) 2021 Red Hat, Inc.
>>> + *
>>> + * Author(s): Gavin Shan <gshan@redhat.com>
>>> + */
>>> +
>>> +#include <linux/kernel.h>
>>> +#include <linux/kvm_host.h>
>>> +#include <linux/spinlock.h>
>>> +#include <linux/slab.h>
>>> +#include <kvm/arm_hypercalls.h>
>>> +
>>> +static struct kvm_sdei_event_state defined_kse[] = {
>>> +    { KVM_SDEI_DEFAULT_NUM,
>>> +      SDEI_EVENT_TYPE_PRIVATE,
>>> +      1,
>>> +      SDEI_EVENT_PRIORITY_CRITICAL
>>> +    },
>>> +};
>> I understand from the above we currently only support a single static (~
>> platform) SDEI event with num = KVM_SDEI_DEFAULT_NUM. We do not support
>> bound events. You may add a comment here and maybe in the commit msg.
>> I would rename the variable into exported_events.
> 
> Yeah, we may enhance it to allow userspace to add more in future, but
> not now. Ok, I will rename it to @exported_events.
> 
>>> +
>>> +static void kvm_sdei_remove_events(struct kvm *kvm)
>>> +{
>>> +    struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
>>> +    struct kvm_sdei_event *kse, *tmp;
>>> +
>>> +    list_for_each_entry_safe(kse, tmp, &ksdei->events, link) {
>>> +        list_del(&kse->link);
>>> +        kfree(kse);
>>> +    }
>>> +}
>>> +
>>> +static void kvm_sdei_remove_kvm_events(struct kvm *kvm,
>>> +                       unsigned int mask,
>>> +                       bool force)
>>> +{
>>> +    struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
>>> +    struct kvm_sdei_event *kse;
>>> +    struct kvm_sdei_kvm_event *kske, *tmp;
>>> +
>>> +    list_for_each_entry_safe(kske, tmp, &ksdei->kvm_events, link) {
>>> +        kse = kske->kse;
>>> +
>>> +        if (!((1 << kse->state.type) & mask))
>>> +            continue;
>> don't you need to hold a lock before looping? What if sbdy concurrently
>> changes the state fields, especially the refcount below?
> 
> Yes, the caller holds @kvm->sdei_lock.
> 
>>> +
>>> +        if (!force && kske->state.refcount)
>>> +            continue;
>> Usually the refcount is used to control the lifetime of the object. The
>> 'force' flag looks wrong in that context. Shouldn't you make sure all
>> users have released their refcounts and on the last decrement, delete
>> the object?
> 
> @force is used for exceptional case. For example, the KVM process is
> killed before the event reference count gets chance to be dropped.
hum not totally convinced here but let's see your next version ;-)
> 
>>> +
>>> +        list_del(&kske->link);
>>> +        kfree(kske);
>>> +    }
>>> +}
>>> +
>>> +static void kvm_sdei_remove_vcpu_events(struct kvm_vcpu *vcpu)
>>> +{
>>> +    struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
>>> +    struct kvm_sdei_vcpu_event *ksve, *tmp;
>>> +
>>> +    list_for_each_entry_safe(ksve, tmp, &vsdei->critical_events,
>>> link) {
>>> +        list_del(&ksve->link);
>>> +        kfree(ksve);
>>> +    }
>>> +
>>> +    list_for_each_entry_safe(ksve, tmp, &vsdei->normal_events, link) {
>>> +        list_del(&ksve->link);
>>> +        kfree(ksve);
>>> +    }
>>> +}
>>> +
>>> +int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>>> +{
>>> +    u32 func = smccc_get_function(vcpu);
>>> +    bool has_result = true;
>>> +    unsigned long ret;
>>> +
>>> +    switch (func) {
>>> +    case SDEI_1_0_FN_SDEI_VERSION:
>>> +    case SDEI_1_0_FN_SDEI_EVENT_REGISTER:
>>> +    case SDEI_1_0_FN_SDEI_EVENT_ENABLE:
>>> +    case SDEI_1_0_FN_SDEI_EVENT_DISABLE:
>>> +    case SDEI_1_0_FN_SDEI_EVENT_CONTEXT:
>>> +    case SDEI_1_0_FN_SDEI_EVENT_COMPLETE:
>>> +    case SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME:
>>> +    case SDEI_1_0_FN_SDEI_EVENT_UNREGISTER:
>>> +    case SDEI_1_0_FN_SDEI_EVENT_STATUS:
>>> +    case SDEI_1_0_FN_SDEI_EVENT_GET_INFO:
>>> +    case SDEI_1_0_FN_SDEI_EVENT_ROUTING_SET:
>>> +    case SDEI_1_0_FN_SDEI_PE_MASK:
>>> +    case SDEI_1_0_FN_SDEI_PE_UNMASK:
>>> +    case SDEI_1_0_FN_SDEI_INTERRUPT_BIND:
>>> +    case SDEI_1_0_FN_SDEI_INTERRUPT_RELEASE:
>>> +    case SDEI_1_0_FN_SDEI_PRIVATE_RESET:
>>> +    case SDEI_1_0_FN_SDEI_SHARED_RESET:
>>> +    default:
>>> +        ret = SDEI_NOT_SUPPORTED;
>>> +    }
>>> +
>>> +    /*
>>> +     * We don't have return value for COMPLETE or COMPLETE_AND_RESUME
>>> +     * hypercalls. Otherwise, the restored context will be corrupted.
>>> +     */
>>> +    if (has_result)
>>> +        smccc_set_retval(vcpu, ret, 0, 0, 0);
>> If I understand the above comment, COMPLETE and COMPLETE_AND_RESUME
>> should have has_result set to false whereas in that case they will
>> return NOT_SUPPORTED. Is that OK for the context restore?
> 
> Nice catch! @has_result needs to be false for COMPLETE and
> COMPLETE_AND_RESUME.
> 
>>> +
>>> +    return 1;
>>> +}
>>> +
>>> +void kvm_sdei_init_vm(struct kvm *kvm)
>>> +{
>>> +    struct kvm_sdei_kvm *ksdei;
>>> +    struct kvm_sdei_event *kse;
>>> +    int i;
>>> +
>>> +    ksdei = kzalloc(sizeof(*ksdei), GFP_KERNEL);
>>> +    if (!ksdei)
>>> +        return;
>>> +
>>> +    spin_lock_init(&ksdei->lock);
>>> +    INIT_LIST_HEAD(&ksdei->events);
>>> +    INIT_LIST_HEAD(&ksdei->kvm_events);
>>> +
>>> +    /*
>>> +     * Populate the defined KVM SDEI events. The whole functionality
>>> +     * will be disabled on any errors.
>> You should definitively revise your naming conventions. this brings
>> confusion inbetween exported events and registered events. Why not
>> simply adopt the spec terminology?
> 
> Yeah, I think so, but I think "defined KVM SDEI events" is following
> the specification because the SDEI event is defined by the firmware
> as the specification says. We're emulating firmware in KVM here.
> 
>>> +     */
>>> +    for (i = 0; i < ARRAY_SIZE(defined_kse); i++) {
>>> +        kse = kzalloc(sizeof(*kse), GFP_KERNEL);
>>> +        if (!kse) {
>>> +            kvm_sdei_remove_events(kvm);
>>> +            kfree(ksdei);
>>> +            return;
>>> +        }
>> Add a comment saying that despite we currently support a single static
>> event we prepare for binding support by building a list of exposed
>> events?
>>
>> Or maybe simplify the implementation at this stage of the development
>> assuming a single platform event is supported?
> 
> I will add comment as you suggested in next respin. Note that another entry
> will be added to the defined event array when Async PF is involved.
> 
>>> +
>>> +        kse->kvm   = kvm;
>>> +        kse->state = defined_kse[i];
>>> +        list_add_tail(&kse->link, &ksdei->events);
>>> +    }
>>> +
>>> +    kvm->arch.sdei = ksdei;
>>> +}
>>> +
>>> +void kvm_sdei_create_vcpu(struct kvm_vcpu *vcpu)
>>> +{
>>> +    struct kvm *kvm = vcpu->kvm;
>>> +    struct kvm_sdei_vcpu *vsdei;
>>> +
>>> +    if (!kvm->arch.sdei)
>>> +        return;
>>> +
>>> +    vsdei = kzalloc(sizeof(*vsdei), GFP_KERNEL);
>>> +    if (!vsdei)
>>> +        return;
>>> +
>>> +    spin_lock_init(&vsdei->lock);
>>> +    vsdei->state.masked       = 1;
>>> +    vsdei->state.critical_num = KVM_SDEI_INVALID_NUM;
>>> +    vsdei->state.normal_num   = KVM_SDEI_INVALID_NUM;
>>> +    vsdei->critical_event     = NULL;
>>> +    vsdei->normal_event       = NULL;
>>> +    INIT_LIST_HEAD(&vsdei->critical_events);
>>> +    INIT_LIST_HEAD(&vsdei->normal_events);
>>> +
>>> +    vcpu->arch.sdei = vsdei;
>>> +}
>>> +
>>> +void kvm_sdei_destroy_vcpu(struct kvm_vcpu *vcpu)
>>> +{
>>> +    struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
>>> +
>>> +    if (vsdei) {
>>> +        spin_lock(&vsdei->lock);
>>> +        kvm_sdei_remove_vcpu_events(vcpu);
>>> +        spin_unlock(&vsdei->lock);
>>> +
>>> +        kfree(vsdei);
>>> +        vcpu->arch.sdei = NULL;
>>> +    }
>>> +}
>>> +
>>> +void kvm_sdei_destroy_vm(struct kvm *kvm)
>>> +{
>>> +    struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
>>> +    unsigned int mask = (1 << SDEI_EVENT_TYPE_PRIVATE) |
>>> +                (1 << SDEI_EVENT_TYPE_SHARED);
>>> +
>>> +    if (ksdei) {
>>> +        spin_lock(&ksdei->lock);
>>> +        kvm_sdei_remove_kvm_events(kvm, mask, true);> +       
>>> kvm_sdei_remove_events(kvm);
>>> +        spin_unlock(&ksdei->lock);
>>> +
>>> +        kfree(ksdei);
>>> +        kvm->arch.sdei = NULL;
>>> +    }
>>> +}
>>>
> 
> Thanks,
> Gavin
> 
Thanks

Eric

