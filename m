Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5EAD48BD0A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 03:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348366AbiALCTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 21:19:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49132 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236083AbiALCT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 21:19:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641953967;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AQIy1tnY0f6qoWZEP3tFJkR6OJmbwGoKaen0O/T2Psg=;
        b=SLKV23lvEg/tiwIjf3y7Fq//7OY2/25CguxhuNLdCE3ZpGFKwsv9kjX5tnZj8vOh7+iYLJ
        /W2e33HtJL4RcF0MsXip5EEokSRrlMmkVLGCj6UjR2jjdpTioHfPrc7zB6XNNkwzFdAaO9
        H600QJ5bG7Y54nrLrSWp62hf0bEElSM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-160-3yQ1v3uGO5iW3j-ckWxUMQ-1; Tue, 11 Jan 2022 21:19:23 -0500
X-MC-Unique: 3yQ1v3uGO5iW3j-ckWxUMQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAA52101AFA8;
        Wed, 12 Jan 2022 02:19:19 +0000 (UTC)
Received: from [10.72.12.29] (ovpn-12-29.pek2.redhat.com [10.72.12.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 770484E2C5;
        Wed, 12 Jan 2022 02:19:11 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v4 04/21] KVM: arm64: Support SDEI_EVENT_REGISTER
 hypercall
To:     Eric Auger <eauger@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-5-gshan@redhat.com>
 <434349d3-4dcb-9157-35a5-9f05aaed4982@redhat.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <9eca731c-e53e-127d-c61e-b346ffcc09c2@redhat.com>
Date:   Wed, 12 Jan 2022 10:19:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <434349d3-4dcb-9157-35a5-9f05aaed4982@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 11/9/21 11:50 PM, Eric Auger wrote:
> On 8/15/21 2:13 AM, Gavin Shan wrote:
>> This supports SDEI_EVENT_REGISTER hypercall, which is used by guest
>> to register SDEI events. The SDEI event won't be raised to the guest
>> or specific vCPU until it's registered and enabled explicitly.
>>
>> Only those events that have been exported by KVM can be registered.
>> After the event is registered successfully, the KVM SDEI event (object)
>> is created or updated because the same KVM SDEI event is shared by
> revisit the terminology (KVM SDEI event). The same SDEI registered event
> object is shared by multiple vCPUs if it is a private event.

Yep, I will correct the commit log in next respin.

>> multiple vCPUs if it's a private event.>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/kvm/sdei.c | 122 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 122 insertions(+)
>>
>> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
>> index aa9485f076a9..d3ea3eee154b 100644
>> --- a/arch/arm64/kvm/sdei.c
>> +++ b/arch/arm64/kvm/sdei.c
>> @@ -21,6 +21,20 @@ static struct kvm_sdei_event_state defined_kse[] = {
>>   	},
>>   };
>>   
>> +static struct kvm_sdei_event *kvm_sdei_find_event(struct kvm *kvm,
>> +						  unsigned long num)
>> +{
>> +	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
>> +	struct kvm_sdei_event *kse;
> the 'k' prefix everywhere for your local variable is unneeded.

ok.

>> +
>> +	list_for_each_entry(kse, &ksdei->events, link) {
>> +		if (kse->state.num == num)
>> +			return kse;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>>   static void kvm_sdei_remove_events(struct kvm *kvm)
>>   {
>>   	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
>> @@ -32,6 +46,20 @@ static void kvm_sdei_remove_events(struct kvm *kvm)
>>   	}
>>   }
>>   
>> +static struct kvm_sdei_kvm_event *kvm_sdei_find_kvm_event(struct kvm *kvm,
>> +							  unsigned long num)
>> +{
>> +	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
>> +	struct kvm_sdei_kvm_event *kske;
>> +
>> +	list_for_each_entry(kske, &ksdei->kvm_events, link) {> +		if (kske->state.num == num)
> I still don't get the diff between the num of an SDEI event vs the num
> of a so-called SDEI kvm event. Event numbers are either static or
> dynamically created using bind ops which you do not support. But to me
> this is a property of the root exposed SDEI event and not a property of
> the registered event. Please could you clarify?

Your understanding is correct. The SDEI events are defined staticly apart
from the binding one, which we don't support for now. As the information
(properties) of one specific SDEI event is scattered and associated with
different objects, like KVM/vCPU/context. The SDEI event (@num) is the key
to associate these scattered information (properties).

>> +			return kske;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>>   static void kvm_sdei_remove_kvm_events(struct kvm *kvm,
>>   				       unsigned int mask,
>>   				       bool force)
>> @@ -86,6 +114,98 @@ static unsigned long kvm_sdei_hypercall_version(struct kvm_vcpu *vcpu)
>>   	return ret;
>>   }
>>   
>> +static unsigned long kvm_sdei_hypercall_register(struct kvm_vcpu *vcpu)
>> +{
>> +	struct kvm *kvm = vcpu->kvm;
>> +	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
>> +	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
>> +	struct kvm_sdei_event *kse = NULL;
>> +	struct kvm_sdei_kvm_event *kske = NULL;
>> +	unsigned long event_num = smccc_get_arg1(vcpu);
>> +	unsigned long event_entry = smccc_get_arg2(vcpu);
>> +	unsigned long event_param = smccc_get_arg3(vcpu);
>> +	unsigned long route_mode = smccc_get_arg4(vcpu);
>> +	unsigned long route_affinity = smccc_get_arg5(vcpu);
>> +	int index = vcpu->vcpu_idx;
>> +	unsigned long ret = SDEI_SUCCESS;
>> +
>> +	/* Sanity check */
>> +	if (!(ksdei && vsdei)) {
>> +		ret = SDEI_NOT_SUPPORTED;
>> +		goto out;
>> +	}
>> +
>> +	if (!kvm_sdei_is_valid_event_num(event_num)) {
>> +		ret = SDEI_INVALID_PARAMETERS;
>> +		goto out;
>> +	}
>> +
>> +	if (!(route_mode == SDEI_EVENT_REGISTER_RM_ANY ||
>> +	      route_mode == SDEI_EVENT_REGISTER_RM_PE)) {
>> +		ret = SDEI_INVALID_PARAMETERS;
>> +		goto out;
>> +	}
>> +
>> +	/*
>> +	 * The KVM event could have been created if it's a private event.
>> +	 * We needn't create a KVM event in this case.
> s/create a KVM event/to create another KVM event instance

Ok.

>> +	 */
>> +	spin_lock(&ksdei->lock);
>> +	kske = kvm_sdei_find_kvm_event(kvm, event_num);
>> +	if (kske) {
>> +		kse = kske->kse;
>> +		index = (kse->state.type == SDEI_EVENT_TYPE_PRIVATE) ?
>> +			vcpu->vcpu_idx : 0;
>> +
>> +		if (kvm_sdei_is_registered(kske, index)) {
>> +			ret = SDEI_DENIED;
>> +			goto unlock;
>> +		}
>> +
>> +		kske->state.route_mode     = route_mode;
>> +		kske->state.route_affinity = route_affinity;
>> +		kske->state.entries[index] = event_entry;
>> +		kske->state.params[index]  = event_param;
>> +		kvm_sdei_set_registered(kske, index);
>> +		goto unlock;
>> +	}
>> +
>> +	/* Check if the event number has been registered */
>> +	kse = kvm_sdei_find_event(kvm, event_num);
> I don't get the comment. find_event looks up for exposed events and not
> registered events, right? So maybe this is the first thing to check, ie.
> the num matches one exposed event.

This should be corrected to:

	/* Check if the event has been defined or exposed */

>> +	if (!kse) {
>> +		ret = SDEI_INVALID_PARAMETERS;
>> +		goto unlock;
>> +	}
>> +
>> +	/* Create KVM event */
>> +	kske = kzalloc(sizeof(*kske), GFP_KERNEL);
>> +	if (!kske) {
>> +		ret = SDEI_OUT_OF_RESOURCE;
>> +		goto unlock;
>> +	}
>> +
>> +	/* Initialize KVM event state */
>> +	index = (kse->state.type == SDEI_EVENT_TYPE_PRIVATE) ?
>> +		vcpu->vcpu_idx : 0;
>> +	kske->state.num            = event_num;
>> +	kske->state.refcount       = 0;
>> +	kske->state.route_mode     = route_affinity;
>> +	kske->state.route_affinity = route_affinity;
>> +	kske->state.entries[index] = event_entry;
>> +	kske->state.params[index] = event_param;
>> +	kvm_sdei_set_registered(kske, index);
>> +
>> +	/* Initialize KVM event */
>> +	kske->kse = kse;
>> +	kske->kvm = kvm;
>> +	list_add_tail(&kske->link, &ksdei->kvm_events);
>> +
>> +unlock:
>> +	spin_unlock(&ksdei->lock);
>> +out:
>> +	return ret;
>> +}
>> +
>>   int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>>   {
>>   	u32 func = smccc_get_function(vcpu);
>> @@ -97,6 +217,8 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>>   		ret = kvm_sdei_hypercall_version(vcpu);
>>   		break;
>>   	case SDEI_1_0_FN_SDEI_EVENT_REGISTER:
>> +		ret = kvm_sdei_hypercall_register(vcpu);
>> +		break;
>>   	case SDEI_1_0_FN_SDEI_EVENT_ENABLE:
>>   	case SDEI_1_0_FN_SDEI_EVENT_DISABLE:
>>   	case SDEI_1_0_FN_SDEI_EVENT_CONTEXT:
>>

Thanks,
Gavin

