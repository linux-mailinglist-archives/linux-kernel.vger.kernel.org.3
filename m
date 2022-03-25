Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9699E4E6E19
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 07:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354742AbiCYGJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 02:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346002AbiCYGJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 02:09:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D0FA5F40
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 23:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648188465;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0WaUuK138cvvma9ZSJzh7EsRKt97wB8z96xiUtTAMl8=;
        b=gjmkw4XDTqPnzNyOVhHKRGhQNkcU0QR2jk0F1UHR5BhsK6kjaCHpx4xuZ+LCJ4Hk5tvXji
        yndOapvX+AskFGh8G212QyRAsNzVx3cufQ7p3+W1ykk5g4r+5dSZRwXmDaAckq2GusPUKL
        JDKRy6YvTUyBwDw5NBwNIbHj3kwENsk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-6cPHBQwvP0Cv6SKhS33ykQ-1; Fri, 25 Mar 2022 02:07:41 -0400
X-MC-Unique: 6cPHBQwvP0Cv6SKhS33ykQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 40309100E659;
        Fri, 25 Mar 2022 06:07:41 +0000 (UTC)
Received: from [10.72.12.33] (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DFA7B9E60;
        Fri, 25 Mar 2022 06:07:27 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v5 02/22] KVM: arm64: Add SDEI virtualization
 infrastructure
To:     Oliver Upton <oupton@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, maz@kernel.org,
        linux-kernel@vger.kernel.org, eauger@redhat.com,
        shan.gavin@gmail.com, Jonathan.Cameron@huawei.com,
        pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org
References: <20220322080710.51727-1-gshan@redhat.com>
 <20220322080710.51727-3-gshan@redhat.com> <YjtUufdsWYxqdGa+@google.com>
 <4d4e5645-4443-c233-6d25-97e68d804512@redhat.com>
 <Yjw0KFZ+DG0A1KxK@google.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <6596a735-d294-f727-1abe-e8d8db339225@redhat.com>
Date:   Fri, 25 Mar 2022 14:07:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <Yjw0KFZ+DG0A1KxK@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

On 3/24/22 5:04 PM, Oliver Upton wrote:
> On Thu, Mar 24, 2022 at 02:54:00PM +0800, Gavin Shan wrote:
>>>> +#define KVM_SDEI_DEFAULT_EVENT	0
>>>> +
>>>> +#define KVM_SDEI_MAX_VCPUS	512	/* Aligned to 64 */
>>>> +#define KVM_SDEI_MAX_EVENTS	128
>>>
>>> I would *strongly* recommend against having these limits. I find the
>>> vCPU limit especially concerning, because we're making KVM_MAX_VCPUS
>>> ABI, which it definitely is not. Anything that deals with a vCPU should
>>> be accessed through a vCPU FD (and thus agnostic to the maximum number
>>> of vCPUs) to avoid such a complication.
>>>
>>
>> For KVM_SDEI_DEFAULT_EVENT, which corresponds to the software signaled
>> event. As you suggested on PATCH[15/22], we can't assume its usage.
>> I will define it with SDEI_SW_SIGNALED_EVENT in uapi/linux/arm_sdei.h
>>
>> For KVM_SDEI_MAX_EVENTS, it will be moved from this header file to
>> kvm_sdei.h after static arrays to hold the data structures or their
>> pointers are used, as you suggested early for this patch (PATCH[02/22]).
>>
>> There are two types of (SDEI) events: shared and private. For the private
>> event, it can be registered independently from the vcpus. It also means
>> the address and argument for the entry points, corresponding to @ep_address
>> and @ep_arg in struct kvm_sdei_registered_event, can be different on
>> the individual vcpus. However, all the registered/enabled states and
>> the entry point address and argument are same on all vcpus for the shared
>> event. KVM_SDEI_MAX_VCPUS was introduced to use same data structure to
>> represent both shared and private event.
> 
> You're providing a great deal of abstraction around the SDEI
> specification, but I really am unconvinced that KVM needs that. This
> series needs to add support for a single SDEI event (event 0) and async
> PF to follow. Since we are going to support a static set of events under
> KVM I believe a lot of the complexity in this design should fade away.
> 

Yeah, I think we can drop the functionality to support the shared
event since both events are exposed by KVM as private events. Please
refer below reply for more details.

>>>> +struct kvm_sdei_exposed_event_state {
>>>> +	__u64	num;
>>>> +
>>>> +	__u8	type;
>>>> +	__u8	signaled;
>>>> +	__u8	priority;
>>>> +	__u8	padding[5];
>>>> +	__u64	notifier;
>>>
>>> Wait, isn't this a kernel function pointer!?
>>>
>>
>> Yeah, it is a kernel function pointer, used by Async PF to know if
>> the corresponding event has been handled or not. Async PF can cancel
>> the previously injected event for performance concerns. Either Async PF
>> or SDEI needs to migrate it. To keep SDEI transparent enough to Async PF,
>> SDEI is responsible for its migration.
> 
> But this is a UAPI header, why would we even consider giving userspace a
> window into the kernel like this? Couldn't userspace crash the kernel by
> writing whatever it wants to this field, knowing that it will call it as
> a function pointer?
> 
> Security aside, there's no guarantee that a function winds up at the
> same address between compiler versions or kernel versions.
> 
> Overall, I don't think that userspace should have the ability to add
> arbitrary SDEI events. KVM takes ownership of its own vendor-specific
> ABI in patch 3/22 by declaring its vendor identifier, so any new events
> we support must remain within KVM. There is going to be some state that
> will need to be migrated for KVM's SDEI events, that ought to be
> surfaced to userspace through the KVM_{GET,SET}_ONE_REG ioctls.
> 
> Given that there isn't much userspace involvement to make SDEI
> work, do you think it would be possible to drop the proposed UAPI from
> your series and work on enabling software-signaled SDEI events within
> KVM first? By this I mean a VM running under KVM shouldn't require any
> ioctls to make it work.
> 
> In so doing, we can discover exactly what the mechanics look like in KVM
> and only then talk about the necessary UAPI to migrate state. One piece
> of the mechanics that is top of mind which I'd like to see addressed is
> the use of linked lists and the preallocations that have been made in
> structures. KVM will know how many events exist at compile time, so we
> can represent these statically.
> 

For @notifier, it is set on the kernel of source VM and migrated to the
kernel of destination VM. It's really concerned with security, I will
drop this in next respin.

I plan to make the following changes for next revision (v6) as below.
Please let me know if there are more things to be covered:

(1) Drop the code to support the shared (SDEI) events since the needed
     events, either software signaled or Async PF event, are all private.
     After that, the private event is the only type to be supported. When
     the shared event becomes unsupported, we can simply return SDEI_NOT_SUPPORTED
     for hypercall SDEI_EVENT_ROUTING_SET and SDEI_SHARED_RESET.

(2) Drop the code to support migration for now. It means the data
     structures defined in arch/arm64/include/uapi/asm/kvm_sdei_state.h
     will be combined to arch/arm64/include/asm/kvm_sdei.h. Besides,
     all the ioctl commands, including KVM_CAP_ARM_SDEI will be dropped
     either.

(3) As we discussed before, the linked lists will be replaced by the
     static arrays or preallocation. The data structures will be amended
     like below.

     (3.1) In arch/arm64/include/asm/kvm_sdei.h
  
     struct kvm_sdei_exposed_event {
         unsigned int                     num;
         unsigned char                    type;           /* reserved, should be 'private' */
         unsigned char                    signaled;
         unsigned char                    priority;
     };

     struct kvm_sdei_registered_event {
         struct kvm_sdei_exposed_event    *exposed_event;
         unsigned long                    ep_address;
         unsigned long                    ep_arg;
#define KVM_SDEI_EVENT_STATE_REGISTERED         (1UL << 0)
#define KVM_SDEI_EVENT_STATE_ENABLED            (1UL << 1)
#define KVM_SDEI_EVENT_STATE_UNREGISTER_PENDING (1UL << 2)
         unsigned long                    state;

         unsigned long                    event_count;  /* number of events pending for hanlding */
     };
        
     struct kvm_sdei_context {
         struct kvm_sdei_registered_event *registered_event;
         unsigned long                    regs[18];
         unsigned long                    pc;
         unsigned long                    pstate;
     };

     /* We even needn't a lock */
     struct kvm_sdei_vcpu {
         unsigned char                    masked;
         struct kvm_sdei_registered_event *registered_event;
         struct kvm_sdei_context          context[SDEI_EVENT_PRIORITY_CRITICAL + 1];
     };

     /* struct kvm_sdei won't be existing any more */

     (3.2) In arch/arm64/kvm/sdei.c

     static struct kvm_sdei_exposed_event exposed_events[] = {
         { .num      = SDEI_EVENT_SW_SIGNALED,    /* defined in include/uapi/linux/arm_sdei.h */
           .type     = SDEI_EVENT_TYPE_PRIVATE,
           .signaled = 1,
           .priority = SDEI_EVENT_PRIORITY_NORMAL,
         },
         {
           .num      = SDEI_EVENT_ASYNC_PF,       /* defined in include/asm/kvm_sdei.h */
           .type     = SDEI_EVENT_TYPE_PRIVATE,
           .signaled = 1,
           .priority = SDEI_EVENT_PRIORITY_CRITICAL,
         },
     };

     In kvm_sdei_create_vcpu(), the events are pre-allocated. They will be destroy
     in kvm_sdei_destroy_vcpu().
  
     struct kvm_vcpu_arch::sdei =
            kzalloc(sizeof(struct kvm_sdei_vcpu), GFP_KERNEL_ACCOUNT);
     struct kvm_sdei_vcpu::registered_event =
            kcalloc(sizeof(struct kvm_sdei_exposed_event), ARRAY_SIZE(exposed_events), GFP_KERNEL_ACCOUNT);

     In kvm_sdei_hypercall(), SDEI_NOT_SUPPORTED will be returned on hypercall
     SDEI_EVENT_ROUTING_SET and SDEI_SHARED_RESET.

(4) Stuff to be considered or discussed in future: migration and mechanism.
     We probably don't want to support the shared event. The function of a
     event is to notify from host to guest kernel. In this regard, the shared
     event can be replaced by the private one. With above changes in (1)/(2)/(3),
     we don't have any VM-scoped properties or states. It means all the properties
     and states are associated with VCPU. It will help to adopt 'firmware-pseudo'
     registers and KVM_{GET,SET}_ONE_REG during the migration in the future.

>>>> +};
>>>> +
>>>> +struct kvm_sdei_registered_event_state {
>>>
>>> You should fold these fields together with kvm_sdei_exposed_event_state
>>> into a single 'kvm_sdei_event' structure:
>>>
>>
>> @route_mode and @route_affinity can't be configured or modified until
>> the event is registered. Besides, they're only valid to the shared
>> events. For private events, they don't have the routing needs. It means
>> those two fields would be part of struct kvm_sdei_registered_event instead
>> of kvm_sdei_exposed_event.
>>
>>
>>>> +	__u64	num;
>>>> +
>>>> +	__u8	route_mode;
>>>> +	__u8	padding[3];
>>>> +	__u64	route_affinity;
>>>
>>> And these shouldn't be UAPI at the VM scope. Each of these properties
>>> could be accessed via a synthetic/'pseudo-firmware' register on a vCPU FD:
>>>
>>
>> They're accessed through vcpu or kvm fd depending on what type the event
>> is. For the VM-owned shared event, they're accessed through KVM fd. For the
>> vcpu-owned private event, they're accessed through vcpu fd.
> 
> Some of the state that you represent in struct kvm_sdei_registered_event_state
> is really per-vCPU state. Any time that there's data available at a vCPU
> granularity userspace should access it with a vCPU FD.
> 

Yeah, I used "struct kvm_sdei_registered_event" to represent the shared and
private event. For the shared event, they are VM scoped. However, they're
VCPU scoped for the private event. As I suggested above, all the states are
VCPU scoped when the private event becomes the only supported one.

>> I'm not sure if I catch the idea to have a synthetic register and I'm to
>> confirm. If I'm correct, you're talking about the "IMPLEMENTATION DEFINED"
>> system register, whose OP0 and CRn are 0B11 and 0B1x11. If two implementation
>> defined registers can be adopted, I don't think we need to expose anything
>> through ABI. All the operations and the needed data can be passed through
>> the system registers.
> 
> No, I'm not talking about the guest-facing interface. I'm talking about
> what gets exposed to userspace to migrate the VM's state. For parts of
> the guest that do not map to an architectural construct, we've defined
> the concept of a firmware pseudo-register. What that really means is we
> expose a register to userspace that is inaccessible from the guest which
> migrates KVM's nonarchitected state. We are abusing the fact that VMMs
> will save/restore whatever registers are reported on KVM_GET_REG_LIST to
> trick it into migrating KVM state, and it has worked quite nicely to
> avoid adding new ioctls for new features. It also means that older VMMs
> are capable of utilizing new KVM features, so long as they obey the
> prescribed rules.
> 

Thanks for the details about the 'firmware pseudo register'. Oliver, is
there exiting one in current KVM implementation? I would like to see how
it's being used. It's definitely a good idea. Those non-architectural
CPU properties can be mapped and migrated in a natural way. I'm not
sure if we had similar mechanism or 'firmware pseudo registers' for
the VM scoped properties?

Thanks,
Gavin

