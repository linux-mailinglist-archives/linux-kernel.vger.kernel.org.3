Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC124E5EF9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 07:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347996AbiCXGzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 02:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiCXGzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 02:55:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DFCD34B8E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 23:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648104853;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uqxLCdovFgJL3F6d8oL7OZj3s1uofXe6x4kAqL3R+ZE=;
        b=WNynCwWhLybu5kQOgXqZdV0JzGoSUrrXrvXKXSE1MGnu52qNBHsFCwp93o+l2bwpS48/Oj
        Udav5B5tx9gj0DMgNKmLYFQc1zxdJ/PFboNpRmEkMvPmtsp4MLbGb6A2NU/WbFxr+5Q6j4
        0eoBQwOaYtYv6/Gfgp3jgCaESmT848g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-275-EWgYXsDqMoebXbULwH5HzA-1; Thu, 24 Mar 2022 02:54:10 -0400
X-MC-Unique: EWgYXsDqMoebXbULwH5HzA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B19A61C05AC4;
        Thu, 24 Mar 2022 06:54:09 +0000 (UTC)
Received: from [10.72.12.33] (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7AC0140CF8ED;
        Thu, 24 Mar 2022 06:54:04 +0000 (UTC)
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
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <4d4e5645-4443-c233-6d25-97e68d804512@redhat.com>
Date:   Thu, 24 Mar 2022 14:54:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <YjtUufdsWYxqdGa+@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

On 3/24/22 1:11 AM, Oliver Upton wrote:
> More comments, didn't see exactly how all of these structures are
> getting used.
> 

Ok, thanks for your review and comments.

> On Tue, Mar 22, 2022 at 04:06:50PM +0800, Gavin Shan wrote:
> 
> [...]
> 
>> diff --git a/arch/arm64/include/uapi/asm/kvm_sdei_state.h b/arch/arm64/include/uapi/asm/kvm_sdei_state.h
>> new file mode 100644
>> index 000000000000..b14844230117
>> --- /dev/null
>> +++ b/arch/arm64/include/uapi/asm/kvm_sdei_state.h
>> @@ -0,0 +1,72 @@
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>> +/*
>> + * Definitions of various KVM SDEI event states.
>> + *
>> + * Copyright (C) 2022 Red Hat, Inc.
>> + *
>> + * Author(s): Gavin Shan <gshan@redhat.com>
>> + */
>> +
>> +#ifndef _UAPI__ASM_KVM_SDEI_STATE_H
>> +#define _UAPI__ASM_KVM_SDEI_STATE_H
>> +
>> +#ifndef __ASSEMBLY__
>> +#include <linux/types.h>
>> +
>> +/*
>> + * The software signaled event is the default one, which is
>> + * defined in v1.1 specification.
>> + */
>> +#define KVM_SDEI_INVALID_EVENT	0xFFFFFFFF
> 
> Isn't the constraint that bit 31 must be zero? (DEN 0054C 4.4 "Event
> number allocation")
> 

Yes, bit 31 of the event number should be zero. So this is invalid
event number, used by struct kvm_sdei_vcpu_state::critical_num
and normal_num to indicate if there is event being handled on the
corresponding vcpu. When those fields are set to KVM_SDEI_INVALID_EVENT,
no event is being handled on the vcpu.

>> +#define KVM_SDEI_DEFAULT_EVENT	0
>> +
>> +#define KVM_SDEI_MAX_VCPUS	512	/* Aligned to 64 */
>> +#define KVM_SDEI_MAX_EVENTS	128
> 
> I would *strongly* recommend against having these limits. I find the
> vCPU limit especially concerning, because we're making KVM_MAX_VCPUS
> ABI, which it definitely is not. Anything that deals with a vCPU should
> be accessed through a vCPU FD (and thus agnostic to the maximum number
> of vCPUs) to avoid such a complication.
> 

For KVM_SDEI_DEFAULT_EVENT, which corresponds to the software signaled
event. As you suggested on PATCH[15/22], we can't assume its usage.
I will define it with SDEI_SW_SIGNALED_EVENT in uapi/linux/arm_sdei.h

For KVM_SDEI_MAX_EVENTS, it will be moved from this header file to
kvm_sdei.h after static arrays to hold the data structures or their
pointers are used, as you suggested early for this patch (PATCH[02/22]).

There are two types of (SDEI) events: shared and private. For the private
event, it can be registered independently from the vcpus. It also means
the address and argument for the entry points, corresponding to @ep_address
and @ep_arg in struct kvm_sdei_registered_event, can be different on
the individual vcpus. However, all the registered/enabled states and
the entry point address and argument are same on all vcpus for the shared
event. KVM_SDEI_MAX_VCPUS was introduced to use same data structure to
represent both shared and private event.

If the data belongs to particular vcpu should be accessed through the
vcpu fd, then we need to split or reorganize the data struct as below.

     /*
      * The events are exposed through ioctl interface or similar
      * mechanism (synthetic system registers?) before they can be
      * registered. struct kvm_sdei_exposed_event instance is reserved
      * from the kvm's static array on receiving the ioctl command
      * from VMM.
      */
     struct kvm_sdei_exposed_event {
         __u32   num;

         __u8    type;
         __u8    signaled;
         __u8    priority;
         __u8    padding;
     };

     /*
      * The struct kvm_sdei_registered_event instance is allocated or
      * reserved from the static array. For the shared event, the instance
      * is linked to kvm, but it will be allocated or reserved from vcpu's
      * static array and linked to the vcpu if it's a private event.
      *
      * The instance is only allocated and reserved upon SDEI_EVENT_REGISTER
      * hypercall.
      */
     struct kvm_sdei_registered_event {
         __u32   num

#define KVM_SDEI_EVENT_STATE_REGISTERED         (1 << 0)
#define KVM_SDEI_EVENT_STATE_ENABLE             (1 << 1)
#define KVM_SDEI_EVENT_STATE_UNREGISTER_PENDING (1 << 2)
         __u8    state;
         __u8	route_mode;
         __u8    padding[2];
         __u64   route_affinity;
         __u64	ep_address;
         __u64	ep_arg;
         __u64   notifier;
     }

>> +struct kvm_sdei_exposed_event_state {
>> +	__u64	num;
>> +
>> +	__u8	type;
>> +	__u8	signaled;
>> +	__u8	priority;
>> +	__u8	padding[5];
>> +	__u64	notifier;
> 
> Wait, isn't this a kernel function pointer!?
> 

Yeah, it is a kernel function pointer, used by Async PF to know if
the corresponding event has been handled or not. Async PF can cancel
the previously injected event for performance concerns. Either Async PF
or SDEI needs to migrate it. To keep SDEI transparent enough to Async PF,
SDEI is responsible for its migration.

>> +};
>> +
>> +struct kvm_sdei_registered_event_state {
> 
> You should fold these fields together with kvm_sdei_exposed_event_state
> into a single 'kvm_sdei_event' structure:
> 

@route_mode and @route_affinity can't be configured or modified until
the event is registered. Besides, they're only valid to the shared
events. For private events, they don't have the routing needs. It means
those two fields would be part of struct kvm_sdei_registered_event instead
of kvm_sdei_exposed_event.


>> +	__u64	num;
>> +
>> +	__u8	route_mode;
>> +	__u8	padding[3];
>> +	__u64	route_affinity;
> 
> And these shouldn't be UAPI at the VM scope. Each of these properties
> could be accessed via a synthetic/'pseudo-firmware' register on a vCPU FD:
> 

They're accessed through vcpu or kvm fd depending on what type the event
is. For the VM-owned shared event, they're accessed through KVM fd. For the
vcpu-owned private event, they're accessed through vcpu fd.

I'm not sure if I catch the idea to have a synthetic register and I'm to
confirm. If I'm correct, you're talking about the "IMPLEMENTATION DEFINED"
system register, whose OP0 and CRn are 0B11 and 0B1x11. If two implementation
defined registers can be adopted, I don't think we need to expose anything
through ABI. All the operations and the needed data can be passed through
the system registers.

     SYS_REG_SDEI_COMMAND
         Receives commands like to expose event, register event and change
         vcpu state etc.
     SYS_REG_SDEI_DATA
         The needed data corresponding to the received command.

However, I'm not positive that synthetic register can be used here. When
Mark Rutland review "PATCH[RFC v1] Async PF support", the implementation
defined registers can't be used in a very limited way. That time, a set
of implementation defined registers are defined to identify the asynchronous
page faults and access to the control data block. However, the idea was
rejected. Later on, Marc recommended SDEI for Async PF.

https://www.spinics.net/lists/kvm-arm/msg40315.html


>> +	__u64	ep_address[KVM_SDEI_MAX_VCPUS];
>> +	__u64	ep_arg[KVM_SDEI_MAX_VCPUS];
>> +	__u64	registered[KVM_SDEI_MAX_VCPUS/64];
>> +	__u64	enabled[KVM_SDEI_MAX_VCPUS/64];
>> +	__u64	unregister_pending[KVM_SDEI_MAX_VCPUS/64];
>> +};
>> +
>> +struct kvm_sdei_vcpu_event_state {
>> +	__u64	num;
>> +
>> +	__u32	event_count;
>> +	__u32	padding;
>> +};
>> +
>> +struct kvm_sdei_vcpu_regs_state {
>> +	__u64	regs[18];
>> +	__u64	pc;
>> +	__u64	pstate;
>> +};
>> +
>> +struct kvm_sdei_vcpu_state {
> 
> Same goes here, I strongly recommend you try to expose this through the
> KVM_{GET,SET}_ONE_REG interface if at all possible since it
> significantly reduces the UAPI burden, both on KVM to maintain it and
> VMMs to actually use it.
> 

Yeah, it's much convenient to use the implementation defined register here.
However, I'm not positive if we can do this. Please see the details I
provided above :)

Thanks,
Gavin


