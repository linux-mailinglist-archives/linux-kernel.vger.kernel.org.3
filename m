Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C42A50CECA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 05:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237901AbiDXDER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 23:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiDXDEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 23:04:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB3F813FDA5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 20:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650769275;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v2xigutMK1jHrbbVOqQLpehzP+OTkeSM63dOSB5Yl6M=;
        b=RZqu2ICVkj3+5RnxOwPOSDbM6sLoDHcaOsX1G8B9lLIbnoIq/k2ewNFo1jNjJPLrNNYk04
        pl+ScY+ZIjaUeagh866E+QV+ZJTCmINluVFnCsl3lf3ct8ltH4n+9eR7rB3jp+eGI8ooR2
        9oujBJf5q9K4e7o0usz9bIHVlsc8CEE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-418-IQQt-5u5N5-Qo4ehDgZP7A-1; Sat, 23 Apr 2022 23:01:12 -0400
X-MC-Unique: IQQt-5u5N5-Qo4ehDgZP7A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BDFBC1C05ACA;
        Sun, 24 Apr 2022 03:01:11 +0000 (UTC)
Received: from [10.72.13.230] (ovpn-13-230.pek2.redhat.com [10.72.13.230])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A989A53AA;
        Sun, 24 Apr 2022 03:01:00 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v6 03/18] KVM: arm64: Add SDEI virtualization
 infrastructure
To:     Oliver Upton <oupton@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        eauger@redhat.com, Jonathan.Cameron@huawei.com,
        vkuznets@redhat.com, will@kernel.org, shannon.zhaosl@gmail.com,
        james.morse@arm.com, mark.rutland@arm.com, maz@kernel.org,
        pbonzini@redhat.com, shan.gavin@gmail.com
References: <20220403153911.12332-1-gshan@redhat.com>
 <20220403153911.12332-4-gshan@redhat.com> <YmMiyt/TDjJt0mdG@google.com>
 <36899ea9-e8bd-27b2-8dfb-75b76eab50d7@redhat.com>
 <YmRI7Bh7fWCYLUGT@google.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <0e26da1a-00bb-3d63-a8bf-6cd3271b0a38@redhat.com>
Date:   Sun, 24 Apr 2022 11:00:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <YmRI7Bh7fWCYLUGT@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

On 4/24/22 2:43 AM, Oliver Upton wrote:
> On Sat, Apr 23, 2022 at 10:18:49PM +0800, Gavin Shan wrote:
>> On 4/23/22 5:48 AM, Oliver Upton wrote:
>>> On Sun, Apr 03, 2022 at 11:38:56PM +0800, Gavin Shan wrote:
>>>> Software Delegated Exception Interface (SDEI) provides a mechanism
>>>> for registering and servicing system events, as defined by ARM DEN0054C
>>>> specification. One of these events will be used by Asynchronous Page
>>>> Fault (Async PF) to deliver notifications from host to guest.
>>>>
>>>> The events are classified into shared and private ones according to
>>>> their scopes. The shared events are system or VM scoped, but the
>>>> private events are CPU or VCPU scoped. The shared events can be
>>>> registered, enabled, unregistered and reset through hypercalls
>>>> issued from any VCPU. However, the private events are registered,
>>>> enabled, unregistered and reset on the calling VCPU through
>>>> hypercalls. Besides, the events are also classified into critical
>>>> and normal events according their priority. During event delivery
>>>> and handling, the normal event can be preempted by another critical
>>>> event, but not in reverse way. The critical event is never preempted
>>>> by another normal event.
>>>
>>> We don't have any need for critical events though, right? We should avoid
>>> building out the plumbing around the concept of critical events until
>>> there is an actual use case for it.
>>>
>>
>> The Async PF one is critical event, as guest needs to handle it immediately.
> 
> But that's the sticking point for me. IIUC, we're going to deliver an
> aync PF SDEI event to the PE that is waiting on a page so it can go do
> something else and wait for the page to come in. Normal events preempt
> ~everything, critical events preempt even normal events.
> 
> How can the guest context switch and do something better at an arbitrary
> instruction boundary (such as in an SDEI handler of normal priority)? If
> a guest takes a page fault in that context, it may as well wait
> synchronously for the page to come in.
> 
> And in the case of the page ready event, we still need to clean up shop
> before switching to the unblocked context.
> 

The Async PF is working exactly like what you said. The normal event handler
should be executed in EL1. When the vcpu runs in EL1, no Async PF event will
be triggered. So the page fault in the normal event context is always resolved
synchronously. The page ready notification is delivered by PPI instead of
SDEI event, but yes, we need cleanup before switching to the previously
suspended context.

>> Otherwise, it's possible that guest can't continue its execution. Besides,
>> the software signaled event (0x0) is normal event. They're the only two
>> events to be supported, I assume the software signaled event (0x0) is only
>> used selftest/kvm. So Async PF one becomes the only event and it can be
>> in normal priority until other SDEI event needs to be added and supported.
> 
> I believe there are multiple use cases for guest-initiated SDEI events
> beyond just testing. Poking a hung PE but one example.
> 

Right. I think we can drop support to the critical event. Lets do this
in next respin. Prior to working on next revision, I still want to
confirm with you on the data structures. Please refer the below reply
about the adjusted data structures.

>> However, the logic to support critical/normal events has been here. So
>> I think it's probably nice to keep it. At least, it make it easier to
>> add a new SDEI event in future. We dropped the support for the shared
>> event from v5 to v6, I think we probably never need a shared event for
>> ever :)
> 
> But then we're sprinkling a lot of dead code throughout KVM, right? It
> makes KVM's job even easier if it doesn't have to worry about nesting
> SDEI events.
>>>> +struct kvm_sdei_exposed_event {
>>>> +	unsigned int	num;
>>>> +	unsigned char	type;
>>>> +	unsigned char	signaled;
>>>
>>> what is this used for?
>>>
>>
>> It indicates the event can be raised by software or not. For those
>> events exposed by KVM should be raised by software, so this should
>> always be true.
> 
> Isn't there always going to be some piece of software that raises an
> event?
> 
> For KVM, we have guest-initiated 'software-signaled' events and KVM-initiated
> async PF (whatever else may follow as well).
> 

Yes, The assumption that all events are always singled by software should
be true. So this field (@signaled) can be dropped either. So I plan to
change the data structures like below, according to the suggestions given
by you. Please double check if there are anything missed.

(1) Those fields of struct kvm_sdei_exposed_event are dropped or merged
     to struct kvm_sdei_event.

     struct kvm_sdei_event {
            unsigned int          num;
            unsigned long         ep_addr;
            unsigned long         ep_arg;
#define KVM_SDEI_EVENT_STATE_REGISTERED         0
#define KVM_SDEI_EVENT_STATE_ENABLED            1
#define KVM_SDEI_EVENT_STATE_UNREGISTER_PENDING 2
            unsigned long         state;                 /* accessed by {test,set,clear}_bit() */
            unsigned long         event_count;
     };

(2) In arch/arm64/kvm/sdei.c

     static kvm_sdei_event exposed_events[] = {
            { .num = SDEI_SW_SIGNALED_EVENT },
     };

(3) In arch/arm64/kvm/sdei.c::kvm_sdei_create_vcpu(), the SDEI events
     are instantiated based on @exposed_events[]. It's just what we're
     doing and nothing is changed.

>>> Do we need this if we disallow nesting events?
>>>
>>
>> Yes, we need this. "event == NULL" is used as indication of invalid
>> context. @event is the associated SDEI event when the context is
>> valid.
> 
> What if we use some other plumbing to indicate the state of the vCPU? MP
> state comes to mind, for example.
> 

Even the indication is done by another state, kvm_sdei_vcpu_context still
need to be linked (associated) with the event. After the vCPU context becomes
valid after the event is delivered, we still need to know the associated
event when some of hypercalls are triggered. SDEI_1_0_FN_SDEI_EVENT_COMPLETE
is one of the examples, we need to decrease struct kvm_sdei_event::event_count
for the hypercall.

There are several options I can figure out for now. Please let me know your
preference.

(1) Rename 'struct kvm_sdei_event *event' to 'unsigned int num'. We use
     the check of '@num == KVM_SDEI_INVALID_NUM' as the indication.
     KVM_SDEI_INVALID_NUM is defined as -1U. With the change, no pointer
     is left in kvm_sdei_vcpu_context.

(2) Add field of 'struct kvm_sdei_event *current_event' to kvm_sdei_vcpu,
     to associate the event with the vCPU context. We still use the
     check of '@current_event == NULL' as the indication.

(3) Have changes in (1) and (2) in the mean while.

Besides, the data structures needs somewhat adjustment as you suggested
previously. The major changes are to drop @lock and critical event support.

    struct kvm_sdei_vcpu_context {
         struct kvm_sdei_event   *event;                      /* need your confirm */
         unsigned long           regs[18];
         unsigned long           pc;
         unsigned long           pstate;
    };

    struct kvm_sdei_vcpu {
         struct kvm_sdei_event           *events;            /* instantiated from @exposed_events[] */
         unsigned char                   masked;             /* vCPU is masked off or not           */
         unsigned long                   event_count;        /* Total count of pending events       */
         struct kvm_sdei_vcpu_context    context;            /* vCPU context for SDEI event         */
    };

>>>> +/*
>>>> + * According to SDEI specification (v1.1), the event number spans 32-bits
>>>> + * and the lower 24-bits are used as the (real) event number. I don't
>>>> + * think we can use that much event numbers in one system. So we reserve
>>>> + * two bits from the 24-bits real event number, to indicate its types:
>>>> + * physical or virtual event. One reserved bit is enough for now, but
>>>> + * two bits are reserved for possible extension in future.
>>>> + *
>>>> + * The physical events are owned by firmware while the virtual events
>>>> + * are used by VMM and KVM.
>>>
>>> Doesn't KVM own everything? I don't see how the guest could interact
>>> with another SDEI implementation.
>>>
>>
>> I might be overthinking on the scheme. The host's firmware might have
>> SDEI supported and we want to propogate these events originated from
>> host's firmware to guest. In this case, we need to distinguish the events
>> originated from host's firmware and kvm (guest's firmware). Even this
>> case isn't possible to happen, I think it's still nice to distinguish
>> the events originated from a real firmware or KVM emulated firmware.
> 
> The guest ABI w.r.t. SDEI is under full ownership of KVM. Any other
> implementations events will never get exposed to the guest.
> 
> Couldn't the guest own the host if it was talking to our firmware
> anyway?
> 

Right. Lets drop these macros and kvm_sdei_is_virtual() in next respin.
As you suggested, we need to iterate struct kvm_sdei_vcpu::events to
see if the event (number) is valid or not.

>>>> + */
>>>> +#define KVM_SDEI_EVENT_NUM_TYPE_SHIFT	22
>>>> +#define KVM_SDEI_EVENT_NUM_TYPE_MASK	(3 << KVM_SDEI_EVENT_NUM_TYPE_SHIFT)
>>>> +#define KVM_SDEI_EVENT_NUM_TYPE_PHYS	0
>>>> +#define KVM_SDEI_EVENT_NUM_TYPE_VIRT	1
>>>> +
>>>> +static inline bool kvm_sdei_is_virtual(unsigned int num)
>>>> +{
>>>> +	unsigned int type;
>>>> +
>>>> +	type = (num & KVM_SDEI_EVENT_NUM_TYPE_MASK) >>
>>>> +	       KVM_SDEI_EVENT_NUM_TYPE_SHIFT;
>>>> +	if (type == KVM_SDEI_EVENT_NUM_TYPE_VIRT)
>>>> +		return true;
>>>> +
>>>> +	return false;
>>>> +}
>>>> +
>>>> +static inline bool kvm_sdei_is_virtual(unsigned int num)
>>>> +{
>>>> +	return num == SDEI_SW_SIGNALED_EVENT;
>>>> +}
>>>
>>> Couldn't the caller just check the event number on their own?
>>>
>>
>> It would be hard because the caller can be guest. Generally, the
>> event and its associated information/state are accessed by hypercalls,
>> event injection and delivery, migration to be supported in future.
>> So I think it's good to check the event number by ourselves.
> 
> What I'm saying is, can't the caller of kvm_sdei_is_sw_signaled() just
> do the comparison?
> 

The only caller of kvm_sdei_is_sw_signaled() is hypercall_signal(). So
lets drop kvm_sdei_is_sw_signaled() and do the comparison in hypercall_signal()
in next respin.


Thanks,
Gavin

