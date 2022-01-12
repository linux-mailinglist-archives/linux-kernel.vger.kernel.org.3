Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD81A48BD74
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 03:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348957AbiALCyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 21:54:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33921 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345571AbiALCyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 21:54:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641956071;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IJtNZPmgnultkELIdPp+Rndgw+ubXlvcPANdrwhJ964=;
        b=glaZuZplLFKB16OwPbxpULBR4ILxfiKtUu5hO9SzdfOtgagGRO4n/OVWBv/RyHBU8Rdiff
        zXyhEOTW3E9HKKZlz4Wifh19o8cxROk17cCEUTrGvBieCrYI3Wp+imNs/B1g2uP0zl6twu
        fAwINapvuLc7u6yixYMKhznY4+ikEdU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-314-oqlNpao6MYGCrqom9x1JoA-1; Tue, 11 Jan 2022 21:54:28 -0500
X-MC-Unique: oqlNpao6MYGCrqom9x1JoA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EB551083F61;
        Wed, 12 Jan 2022 02:54:26 +0000 (UTC)
Received: from [10.72.12.29] (ovpn-12-29.pek2.redhat.com [10.72.12.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A4DEB5E485;
        Wed, 12 Jan 2022 02:54:21 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v4 10/21] KVM: arm64: Support SDEI_EVENT_ROUTING_SET
 hypercall
To:     Eric Auger <eauger@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-11-gshan@redhat.com>
 <0d46c17b-1a37-cbf6-4d34-aa03d30e39ef@redhat.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <f2ecad36-ba52-5420-1f7b-d7c099318680@redhat.com>
Date:   Wed, 12 Jan 2022 10:54:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <0d46c17b-1a37-cbf6-4d34-aa03d30e39ef@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 11/10/21 2:47 AM, Eric Auger wrote:
> On 8/15/21 2:13 AM, Gavin Shan wrote:
>> This supports SDEI_EVENT_ROUTING_SET hypercall. It's used by the
>> guest to set route mode and affinity for the registered KVM event.
>> It's only valid for the shared events. It's not allowed to do so
>> when the corresponding event has been raised to the guest.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/kvm/sdei.c | 64 +++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 64 insertions(+)
>>
>> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
>> index 5dfa74b093f1..458695c2394f 100644
>> --- a/arch/arm64/kvm/sdei.c
>> +++ b/arch/arm64/kvm/sdei.c
>> @@ -489,6 +489,68 @@ static unsigned long kvm_sdei_hypercall_info(struct kvm_vcpu *vcpu)
>>   	return ret;
>>   }
>>   
>> +static unsigned long kvm_sdei_hypercall_route(struct kvm_vcpu *vcpu)
>> +{
>> +	struct kvm *kvm = vcpu->kvm;
>> +	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
>> +	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
>> +	struct kvm_sdei_event *kse = NULL;
>> +	struct kvm_sdei_kvm_event *kske = NULL;
>> +	unsigned long event_num = smccc_get_arg1(vcpu);
>> +	unsigned long route_mode = smccc_get_arg2(vcpu);
>> +	unsigned long route_affinity = smccc_get_arg3(vcpu);
>> +	int index = 0;
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
> Some sanity checking on the affinity arg could be made as well according
> to 5.1.2  affinity desc. The fn shall return INVALID_PARAMETER in case
> of invalid affinity.

Yep, you're right. I didn't figure out it. I may put a comment here.
For now, the SDEI client driver in the guest kernel doesn't attempt
to change the routing mode.

	/* FIXME: The affinity should be verified */

>> +
>> +	/* Check if the KVM event has been registered */
>> +	spin_lock(&ksdei->lock);
>> +	kske = kvm_sdei_find_kvm_event(kvm, event_num);
>> +	if (!kske) {
>> +		ret = SDEI_INVALID_PARAMETERS;
>> +		goto unlock;
>> +	}
>> +
>> +	/* Validate KVM event state */
>> +	kse = kske->kse;
>> +	if (kse->state.type != SDEI_EVENT_TYPE_SHARED) {
>> +		ret = SDEI_INVALID_PARAMETERS;
>> +		goto unlock;
>> +	}
>> +
> Event handler is in a state other than: handler-registered.

They're equivalent as the handler is provided as a parameter when
the event is registered.

>> +	if (!kvm_sdei_is_registered(kske, index) ||
>> +	    kvm_sdei_is_enabled(kske, index)     ||
>> +	    kske->state.refcount) {
> I am not sure about the refcount role here. Does it make sure the state
> is != handler-enabled and running or handler-unregister-pending?
> 
> I think we would gain in readibility if we had a helper to check whether
> we are in those states?

@refcount here indicates pending SDEI event for delivery. In this case,
chaning its routing mode is disallowed.

>> +		ret = SDEI_DENIED;
>> +		goto unlock;
>> +	}
>> +
>> +	/* Update state */
>> +	kske->state.route_mode     = route_mode;
>> +	kske->state.route_affinity = route_affinity;
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
>> @@ -523,6 +585,8 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>>   		ret = kvm_sdei_hypercall_info(vcpu);
>>   		break;
>>   	case SDEI_1_0_FN_SDEI_EVENT_ROUTING_SET:
>> +		ret = kvm_sdei_hypercall_route(vcpu);
>> +		break;
>>   	case SDEI_1_0_FN_SDEI_PE_MASK:
>>   	case SDEI_1_0_FN_SDEI_PE_UNMASK:
>>   	case SDEI_1_0_FN_SDEI_INTERRUPT_BIND:
>>

Thanks,
Gavin

