Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2A74E5256
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 13:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242778AbiCWMmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 08:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbiCWMmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 08:42:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2FE407B553
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 05:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648039246;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EFFzrMoeCc+vtGGQUpI0c3WJGOuV+lzt7PoTPoO5vXg=;
        b=N4WEOa5MQuD8qGEnFeDHLDcJFyynMMX8bC5FMhqmNM9BZLpIXOXPKHeQYaXnoRE/tthZxy
        VWwzZu9cD1qQr7Pn6X22pODfm6xLWTcFHi4ABe3yYRRTKi0k+Dp1mc63UsOFlNnH20qOln
        NgutCS5q3tQYZ0a1Rkni5ji036c5MRQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-250-yjcbSrvrOCe8umxWptf5wQ-1; Wed, 23 Mar 2022 08:40:43 -0400
X-MC-Unique: yjcbSrvrOCe8umxWptf5wQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 87CB63C01B95;
        Wed, 23 Mar 2022 12:40:42 +0000 (UTC)
Received: from [10.72.12.33] (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E037C140262B;
        Wed, 23 Mar 2022 12:40:36 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v5 02/22] KVM: arm64: Add SDEI virtualization
 infrastructure
To:     Oliver Upton <oupton@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, maz@kernel.org,
        linux-kernel@vger.kernel.org, eauger@redhat.com,
        shan.gavin@gmail.com, Jonathan.Cameron@huawei.com,
        pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org
References: <20220322080710.51727-1-gshan@redhat.com>
 <20220322080710.51727-3-gshan@redhat.com> <YjpRArSezR3gVv2K@google.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <c178489c-9e52-f5b2-4ff8-4f1328c08208@redhat.com>
Date:   Wed, 23 Mar 2022 20:40:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <YjpRArSezR3gVv2K@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
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

On 3/23/22 6:43 AM, Oliver Upton wrote:
> On Tue, Mar 22, 2022 at 04:06:50PM +0800, Gavin Shan wrote:
>> Software Delegated Exception Interface (SDEI) provides a mechanism for
>> registering and servicing system events. Those system events are high
>> priority events, which must be serviced immediately. It's going to be
>> used by Asynchronous Page Fault (APF) to deliver notification from KVM
>> to guest. It's noted that SDEI is defined by ARM DEN0054C specification.
> 
> I'm guessing that you're using linked lists for stitching all of this
> together because the specification provides for 24 bits of event
> encoding. However, it seems that there will be a finite number of events
> in KVM. So the APF stuff and a software signaled event.
> 
> Given that the number of events in KVM is rather small, would it make
> more sense to do away with the overhead of linked lists and having the
> state just represented in a static or allocated array? I think you can
> cram all of the VM scoped event state into a single structure and hang
> the implementation off of that.
> 

Yes, the number of events in KVM is small. Including the events for Async
PF and the software signaled event, 8 events would be enough currently. In
the meanwhile, there are several types of objects for various events. Some
of them can be put into static array, while the left might need static array
of pointers to avoid the linked list:

    struct kvm_sdei_exposed_event/state         on struct kvm_arch
           size: 24 bytes
           static array, 8 entries
    struct kvm_sdei_registered_event/state      on struct kvm_arch
           size: 9KB
           static array of pointers, still need allocate them dynamically, 8 entries
    struct kvm_sdei_vcpu_event/state            on struct kvm_vcpu_arch
           size: 16 bytes
           static array, 8 entries


>> This introduces SDEI virtualization infrastructure where the SDEI events
>> are registered and manipulated by the guest through hypercall. The SDEI
>> event is delivered to one specific vCPU by KVM once it's raised. This
>> introduces data structures to represent the needed objects to support
>> the feature, which is highlighted as below. As those objects could be
>> migrated between VMs, these data structures are partially exposed to
>> user space.
>>
>>     * kvm_sdei_exposed_event
>>       The exposed events are determined and added by VMM through ioctl
>>       interface. Only the exposed events can be registered from the
>>       guest.
>>
>>     * kvm_sdei_registered_event
>>       The events that have been registered from the guest through the
>>       SDEI_1_0_FN_SDEI_EVENT_REGISTER hypercall.
>>
>>     * kvm_sdei_vcpu_event
>>       The events that have been delivered to the target vCPU.
>>
>>     * kvm_sdei_vcpu
>>       Used to save the preempted context when the SDEI event is serviced
>>       and delivered. After the SDEI event handling is completed, the
>>       execution is resumed from the preempted context.
>>
>>     * kvm_sdei_kvm
>>       Place holder for the exposed and registered events.
> 
> It might be a good idea to expand these a bit and move them into
> comments on each of the structures.
> 

Sure, I will do in next respin.

>> The error of SDEI_NOT_SUPPORTED is returned for all SDEI hypercalls for
>> now. They will be supported in the subsequent patches.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/include/asm/kvm_host.h            |   3 +
>>   arch/arm64/include/asm/kvm_sdei.h            | 171 +++++++++++++
>>   arch/arm64/include/uapi/asm/kvm.h            |   1 +
>>   arch/arm64/include/uapi/asm/kvm_sdei_state.h |  72 ++++++
>>   arch/arm64/kvm/Makefile                      |   2 +-
>>   arch/arm64/kvm/arm.c                         |   8 +
>>   arch/arm64/kvm/hypercalls.c                  |  21 ++
>>   arch/arm64/kvm/sdei.c                        | 244 +++++++++++++++++++
>>   include/uapi/linux/arm_sdei.h                |   2 +
>>   9 files changed, 523 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/arm64/include/asm/kvm_sdei.h
>>   create mode 100644 arch/arm64/include/uapi/asm/kvm_sdei_state.h
>>   create mode 100644 arch/arm64/kvm/sdei.c
>>
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>> index 031e3a2537fc..5d37e046a458 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -113,6 +113,8 @@ struct kvm_arch {
>>   	/* Interrupt controller */
>>   	struct vgic_dist	vgic;
>>   
>> +	struct kvm_sdei_kvm *sdei;
>> +
> 
> nit: avoid repeating 'kvm'. struct kvm_sdei should be descriptive enough
> :)
> 

Indeed, "struct kvm_sdei" is better :)

>>   	/* Mandated version of PSCI */
>>   	u32 psci_version;
>>   
>> @@ -338,6 +340,7 @@ struct kvm_vcpu_arch {
>>   	 * Anything that is not used directly from assembly code goes
>>   	 * here.
>>   	 */
>> +	struct kvm_sdei_vcpu *sdei;
>>
> 
> nit: put your scoping tokens at the beginning of a symbol name, so
> 'struct kvm_vcpu_sdei'.
> 
> [...]
> 

Yep, "struct kvm_vcpu_sdei" is the one I will have in next respin :)

>> diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
>> index 202b8c455724..3c20fee72bb4 100644
>> --- a/arch/arm64/kvm/hypercalls.c
>> +++ b/arch/arm64/kvm/hypercalls.c
>> @@ -5,6 +5,7 @@
>>   #include <linux/kvm_host.h>
>>   
>>   #include <asm/kvm_emulate.h>
>> +#include <asm/kvm_sdei.h>
>>   
>>   #include <kvm/arm_hypercalls.h>
>>   #include <kvm/arm_psci.h>
>> @@ -151,6 +152,26 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
>>   	case ARM_SMCCC_TRNG_RND32:
>>   	case ARM_SMCCC_TRNG_RND64:
>>   		return kvm_trng_call(vcpu);
>> +	case SDEI_1_0_FN_SDEI_VERSION:
>> +	case SDEI_1_0_FN_SDEI_EVENT_REGISTER:
>> +	case SDEI_1_0_FN_SDEI_EVENT_ENABLE:
>> +	case SDEI_1_0_FN_SDEI_EVENT_DISABLE:
>> +	case SDEI_1_0_FN_SDEI_EVENT_CONTEXT:
>> +	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE:
>> +	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME:
>> +	case SDEI_1_0_FN_SDEI_EVENT_UNREGISTER:
>> +	case SDEI_1_0_FN_SDEI_EVENT_STATUS:
>> +	case SDEI_1_0_FN_SDEI_EVENT_GET_INFO:
>> +	case SDEI_1_0_FN_SDEI_EVENT_ROUTING_SET:
>> +	case SDEI_1_0_FN_SDEI_PE_MASK:
>> +	case SDEI_1_0_FN_SDEI_PE_UNMASK:
>> +	case SDEI_1_0_FN_SDEI_INTERRUPT_BIND:
>> +	case SDEI_1_0_FN_SDEI_INTERRUPT_RELEASE:
>> +	case SDEI_1_1_FN_SDEI_EVENT_SIGNAL:
>> +	case SDEI_1_0_FN_SDEI_PRIVATE_RESET:
>> +	case SDEI_1_0_FN_SDEI_SHARED_RESET:
>> +	case SDEI_1_1_FN_SDEI_FEATURES:
> 
> Consider only adding switch statements for hypercalls when they're
> actually implemented.
> 
> Additionally, while this isn't directly related to your patch, I do have
> a gripe about kvm_hvc_call_handler(). It is really ugly that we
> enumerate the specific hypercalls we support, and otherwise fall through
> to PSCI.
> 
> IMO, a cleaner approach would be to have kvm_hvc_call_handler() simply
> route a particular service range/service owner to the appropriate
> handler. We can then terminate individual hypercalls in those handlers,
> avoiding a catch-all switch such as this one is currently.
> 

Yes, I agree. I can have a separate patch as preparatory work to
route the range of hypercalls to their owner for further handling.
In this way, we can route the range of SDEI hypercalls to its own
handler. I will figure it out in next respin.

Thanks,
Gavin


