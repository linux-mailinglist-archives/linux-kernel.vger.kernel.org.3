Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83B1516B37
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 09:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358683AbiEBH33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 03:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239437AbiEBH30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 03:29:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A86E9183AD
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 00:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651476356;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WQiIsUIyn8Y6BpyeDFKijqoXHSq8EzeA4ooMIOtNlRk=;
        b=Srf1sOSUA6Z4HDoOGapaCWDombtml+iIUSw8+eqgXUr6rnpstrK5WmRjJYCQLxY1fOJsE1
        +h7FQBp7JFgjGpYEH3ltw3kh2pBR3xpbNLf81psdMk0HB5z1kxF+Ao1Uz6cJTPGOdm46hM
        K+YesMhCzCxsuaW3YKaqIJHM3zU3Juo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-261-CKbFpMLbPBab97z5D1flNw-1; Mon, 02 May 2022 03:25:50 -0400
X-MC-Unique: CKbFpMLbPBab97z5D1flNw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FFD229AB3FF;
        Mon,  2 May 2022 07:25:50 +0000 (UTC)
Received: from [10.72.12.86] (ovpn-12-86.pek2.redhat.com [10.72.12.86])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 03E291460E5A;
        Mon,  2 May 2022 07:25:43 +0000 (UTC)
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
 <0e26da1a-00bb-3d63-a8bf-6cd3271b0a38@redhat.com>
 <Ymr45B+8xTlhi7vk@google.com>
 <96711526-c4f3-3b50-c015-beba8cc9fcc9@redhat.com>
 <Ym1EztjkJIHrg4Qz@google.com>
 <62f06a03-d6fc-3803-a2d2-7a85cf733459@redhat.com>
 <Ym9So9YariC0M7Zu@google.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <2d631426-17fd-e7e3-5c62-eda547732bb7@redhat.com>
Date:   Mon, 2 May 2022 15:25:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <Ym9So9YariC0M7Zu@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

On 5/2/22 11:40 AM, Oliver Upton wrote:
> On Mon, May 02, 2022 at 10:35:08AM +0800, Gavin Shan wrote:
>> On 4/30/22 10:16 PM, Oliver Upton wrote:
>>> On Sat, Apr 30, 2022 at 07:38:29PM +0800, Gavin Shan wrote:
>>>> Thank you for the comments and details. It should work by using bitmaps
>>>> to represent event's states. I will adopt your proposed structs in next
>>>> respin. However, there are more states needed. So I would adjust
>>>> "struct kvm_sdei_vcpu" like below in next respin.
>>>>
>>>>       struct kvm_sdei_vcpu {
>>>>           unsigned long registered;    /* the event is registered or not                 */
>>>>           unsigned long enabled;       /* the event is enabled or not                    */
>>>>           unsigned long unregistering; /* the event is pending for unregistration        */
>>>
>>> I'm not following why we need to keep track of the 'pending unregister'
>>> state directly. Is it not possible to infer from (active && !registered)?
>>>
>>
>> The event can be unregistered and reseted through hypercalls when it's
>> being handled. In this case, the unregistration for the event can't
>> be done immediately and has to be delayed until the handling is finished.
>> The unregistration pending state is used in this case. Yes, it's
>> correct we also can use (active & !registered) to represent the state.
> 
> I don't believe there is any delay in the unregistration of an event.
> The state is only meant to imply that the handler must complete before
> software can re-register for the event.
> 
> The event state machine from 6.1 can be encoded using 3 bits, which is
> exactly what we see in Table 13 of DEN0054C.
> 
> I'm sorry for being pedantic, but avoiding duplication of state reduces
> the chance of bugs + makes things a bit easier to reason about.
> 

 From section 6.1 and table 13 in DEN0054C, it's true there are just 3-bits
for the event states: reigstered/unregistered, enabled/disabled, running/not_running.
The unregistration-pending state is somewhat related to implementation, similar
to the pending state we have. The unregistration-pending state isn't explicitly
defined by the specification. However, the state is implicitly stated by the
specification. For example, there are statements about it in section 5.1.18
and 5.1.18.2:

    It is expected that no private event handlers would have the event
    handler property handler-running set to TRUE. If an event handler
    is running, unregister will be pending until the event is completed.

Oliver, how about to adjust struct kvm_sdei_vcpu like below. With the
changes, struct kvm_sdei_vcpu::unregistering is dropped, to match with
the specification strictly.

    struct kvm_sdei_vcpu {
        unsigned long registered;
        unsigned long enabled;
        unsigned long running;        // renamed from 'active' to match the specification strictly
        unsigned long pending;        // event pending for delivery
           :
    };

    state                          @registered  @enabled  @running  @pending
    --------------------------------------------------------------------------------
    unregistered                   0            0         0/1       0
    registered-disabled            1            0         0         0/1
    registered-enabled             1            1         0/1       0/1
    handler-running                0/1          0/1       1         0/1

We can use the specific encoding to represent the unregistration-pending.

    state                          @registered  @enabled  @running  @pending
    -------------------------------------------------------------------------
    handler-running                0            0          1        0

Thanks for your valuable comments, Oliver. I'm not starting to work on
v7 yet. I also would like to make everything clear before that. In that
case, it will be easier for you to review next revision :)

>>>>           unsigned long pending;       /* the event is pending for delivery and handling */
>>>>           unsigned long active;        /* the event is currently being handled           */
>>>>
>>>>           :
>>>>           <this part is just like what you suggested>
>>>>       };
>>>>
>>>> I rename @pending to @unregister. Besides, there are two states added:
>>>>
>>>>      @pending: Indicate there has one event has been injected. The next step
>>>>                for the event is to deliver it for handling. For one particular
>>>>                event, we allow one pending event in the maximum.
>>>
>>> Right, if an event retriggers when it is pending we still dispatch a
>>> single event to the guest. And since we're only doing normal priority
>>> events, it is entirely implementation defined which gets dispatched
>>> first.
>>>
>>
>> Yep, we will simply rely on find_first_bit() for the priority. It means
>> the software signaled event, whose number is zero, will have the highest
>> priority.
>>
>>>>      @active:  Indicate the event is currently being handled. The information
>>>>                stored in 'struct kvm_sdei_event_context' instance can be
>>>>                correlated with the event.
>>>
>>> Does this need to be a bitmap though? We can't ever have more than one
>>> SDEI event active at a time since this is private to a vCPU.
>>>
>>
>> Yes, one event is active at most on one particular vCPU. So tt don't
>> have to be a bitmap necessarily. The reason I proposed to use bitmap
>> for this state is to having all (event) states represented by bitmaps.
>> In this way, all states are managed in a unified fashion. The alternative
>> way is to have "unsigned long active_event", which traces the active
>> event number. It also consumes 8-bytes when live migration is concerned.
>> So I prefer a bitmap :)
>>
> 
> The small benefit of using the event number is that we can address all
> events in 8 bytes, whereas we'd need to extend the bitmap for >64
> events. I suppose we'll run into that issue either way, since the
> pending, registered, and enabled portions are also bitmaps.
> 
> When live migration is in scope we should probably bark at userspace if
> it attempts to set more than a single bit in the register.
> 

Even it's unlikely to support the shared event, bitmap will help in that
case. I'm not sure about other VMM, the pseudo firmware registers are
almost transparent to user space in QEMU. They're accessed and no one
cares the values reading from and writing to these registers in QEMU ;-)

Please refer to the above reply for more details :)

>>>> Furthermore, it's fair enough to put the (vcpu) mask state into 'flags'
>>>> field of struct kvm_vcpu_arch :)
>>>
>>> I think you can get away with putting active in there too, I don't see
>>> why we need more than a single bit for this info.
>>>
>>
>> Not really. We just need one single bit for vCPU's mask state. We need
>> multiple bits for event's active state, depending on how many events are
>> supported. We need to know which event is currently active at least.
>> For now, there are only two supported events (0/1), but one single bit
>> is still not enough because there are 3 states: (1) software signaled
>> event is active. (2) async pf event is active. (3) none of them is
>> active.
>>
>> Lets use a bitmap for the event active state as I said above, if you
>> don't strongly object :)
>>
>>>>>>>>> Do we need this if we disallow nesting events?
>>>>>>>>>
>>>>>>>>
>>>>>>>> Yes, we need this. "event == NULL" is used as indication of invalid
>>>>>>>> context. @event is the associated SDEI event when the context is
>>>>>>>> valid.
>>>>>>>
>>>>>>> What if we use some other plumbing to indicate the state of the vCPU? MP
>>>>>>> state comes to mind, for example.
>>>>>>>
>>>>>>
>>>>>> Even the indication is done by another state, kvm_sdei_vcpu_context still
>>>>>> need to be linked (associated) with the event. After the vCPU context becomes
>>>>>> valid after the event is delivered, we still need to know the associated
>>>>>> event when some of hypercalls are triggered. SDEI_1_0_FN_SDEI_EVENT_COMPLETE
>>>>>> is one of the examples, we need to decrease struct kvm_sdei_event::event_count
>>>>>> for the hypercall.
>>>>>
>>>>> Why do we need to keep track of how many times an event has been
>>>>> signaled? Nothing in SDEI seems to suggest that the number of event
>>>>> signals corresponds to the number of times the handler is invoked. In
>>>>> fact, the documentation on SDEI_EVENT_SIGNAL corroborates this:
>>>>>
>>>>> """
>>>>> The event has edgetriggered semantics and the number of event signals
>>>>> may not correspond to the number of times the handler is invoked in the
>>>>> target PE.
>>>>> """
>>>>>
>>>>> DEN0054C 5.1.16.1
>>>>>
>>>>> So perhaps we queue at most 1 pending event for the guest.
>>>>>
>>>>> I'd also like to see if anyone else has thoughts on the topic, as I'd
>>>>> hate for you to go back to the whiteboard again in the next spin.
>>>>>
>>>>
>>>> Agreed. In next respin, we will have one pending event at most. Error
>>>> can be returned if user attempts to inject event whose pending state
>>>> (struct kvm_sdei_vcpu::pending) has been set.
>>>
>>> I don't believe we can do that. The SDEI_EVENT_SIGNAL call should succeed,
>>> even if the event was already pending.
>>>
>>
>> I rethinking it a bit. Yes, you're correct. In this specific case, the
>> event handler is running for multiple events.
>>
>>>> Indeed, the hardest part is to determine the data structures and
>>>> functions we need. Oliver, your valuable comments are helping to
>>>> bring this series to the right track. However, I do think it's
>>>> helpful if somebody else can confirm the outcomes from the previous
>>>> discussions. I'm not sure if Marc has time for a quick scan and provide
>>>> comments.
>>>>
>>>> I would summarize the outcomes from our discussions, to help Marc
>>>> or others to confirm:
>>>
>>> Going to take a look at some of your later patches as well, just a heads
>>> up.
>>>
>>
>> Yep, thanks again for your valuable comments :)
>>
>>>> - Drop support for the shared event.
>>>> - Dropsupport for the critical event.
>>>> - The events in the implementations are all private and can be signaled
>>>>     (raised) by software.
>>>> - Drop migration support for now, and we will consider it using
>>>>     pseudo firmware registers. So add-on patches are expected to support
>>>>     the migration in future.
>>>
>>> Migration will be supported in a future spin of this series, not a
>>> subsequent one right? :) I had just made the suggestion because there was
>>> a lot of renovations that we were discussing.
>>>
>>
>> I prefer a separate series to support migration after this series gets
>> merged. There are couple of reasons to do so: (1) The migration depends
>> on Raghavendra's series to support for hypercall services selection.
>> The series is close to be merged, but not happen yet. The SDEI is one
>> of the hypercall services at least. SDEI's pseudo firmware registers
>> for migration will be managed by the infrastructure. (2) I would focus
>> on the core functinality for now. In this way, we give migration space.
>> For example, the data structures needs sorts of adjustments for migration,
>> just in case.
> 
> Although merging this series w/o support for LM would mean that a guest
> using SDEI could potentially explode when migrated, right? We can't
> break it to implement something else.
> 

Yes. I even had the code for migration for v6, which is really coarse and
needs to be polished. If two VMs are mismatched in terms of SDEI support,
the migration fails. With Raghavendra's series to support for hypercall
services selection, we can make SDEI migration opt-in to some extent at
least. For example, the migration from where SDEI isn't supported to
the destination VM where SDEI is supported. It's helping people to finish
forwards upgrade.

    git@github.com:gwshan/linux.git  (branch: kvm/arm64_sdei)

Thanks,
Gavin

