Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3240248BEDF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 08:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351152AbiALHM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 02:12:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54225 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237258AbiALHMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 02:12:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641971575;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i4DwJd3VBrIuZBhZeLiKOVZ3AibbAwHxY0tLpu2xHGE=;
        b=T5E+br/vi2b50XA2Lu9LTz7xamOVkvticJb7I6VcRF2NK7KIL7Y1EG1NvFkeU8F4JlD28b
        0xhF2WW74tA7kjQVc4S7W5iVgKRyxEgMGVevFbOuGIhH78LmUU4uxBM3XoJsy73ua6WR18
        PxrMX5hMdxelATLxy19KBp/NVP8vNSU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-339-qqlBMFP2PW6Rd7wtpOESOA-1; Wed, 12 Jan 2022 02:12:53 -0500
X-MC-Unique: qqlBMFP2PW6Rd7wtpOESOA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9446381CCB4;
        Wed, 12 Jan 2022 07:12:52 +0000 (UTC)
Received: from [10.72.12.204] (ovpn-12-204.pek2.redhat.com [10.72.12.204])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EAC9C163C7;
        Wed, 12 Jan 2022 07:12:42 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v4 18/21] KVM: arm64: Support SDEI event injection
To:     Eric Auger <eauger@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-19-gshan@redhat.com>
 <6c11ed83-796e-765e-bb6a-116947d33eab@redhat.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <b0603dc2-a7d1-04d2-3efc-8890e6e3aadf@redhat.com>
Date:   Wed, 12 Jan 2022 15:12:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <6c11ed83-796e-765e-bb6a-116947d33eab@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 11/10/21 10:05 PM, Eric Auger wrote:
> On 8/15/21 2:13 AM, Gavin Shan wrote:
>> This supports SDEI event injection by implementing kvm_sdei_inject().
>> It's called by kernel directly or VMM through ioctl command to inject
>> SDEI event to the specific vCPU.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/include/asm/kvm_sdei.h      |   2 +
>>   arch/arm64/include/uapi/asm/kvm_sdei.h |   1 +
>>   arch/arm64/kvm/sdei.c                  | 108 +++++++++++++++++++++++++
>>   3 files changed, 111 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/kvm_sdei.h b/arch/arm64/include/asm/kvm_sdei.h
>> index a997989bab77..51087fe971ba 100644
>> --- a/arch/arm64/include/asm/kvm_sdei.h
>> +++ b/arch/arm64/include/asm/kvm_sdei.h
>> @@ -124,6 +124,8 @@ void kvm_sdei_create_vcpu(struct kvm_vcpu *vcpu);
>>   int kvm_sdei_hypercall(struct kvm_vcpu *vcpu);
>>   int kvm_sdei_register_notifier(struct kvm *kvm, unsigned long num,
>>   			       kvm_sdei_notifier notifier);
>> +int kvm_sdei_inject(struct kvm_vcpu *vcpu,
>> +		    unsigned long num, bool immediate);
>>   void kvm_sdei_deliver(struct kvm_vcpu *vcpu);
>>   long kvm_sdei_vm_ioctl(struct kvm *kvm, unsigned long arg);
>>   long kvm_sdei_vcpu_ioctl(struct kvm_vcpu *vcpu, unsigned long arg);
>> diff --git a/arch/arm64/include/uapi/asm/kvm_sdei.h b/arch/arm64/include/uapi/asm/kvm_sdei.h
>> index b916c3435646..f7a6b2b22b50 100644
>> --- a/arch/arm64/include/uapi/asm/kvm_sdei.h
>> +++ b/arch/arm64/include/uapi/asm/kvm_sdei.h
>> @@ -67,6 +67,7 @@ struct kvm_sdei_vcpu_state {
>>   #define KVM_SDEI_CMD_SET_VEVENT			7
>>   #define KVM_SDEI_CMD_GET_VCPU_STATE		8
>>   #define KVM_SDEI_CMD_SET_VCPU_STATE		9
>> +#define KVM_SDEI_CMD_INJECT_EVENT		10
>>   
>>   struct kvm_sdei_cmd {
>>   	__u32						cmd;
>> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
>> index 79315b77f24b..7c2789cd1421 100644
>> --- a/arch/arm64/kvm/sdei.c
>> +++ b/arch/arm64/kvm/sdei.c
>> @@ -802,6 +802,111 @@ int kvm_sdei_register_notifier(struct kvm *kvm,
>>   	return ret;
>>   }
>>   
>> +int kvm_sdei_inject(struct kvm_vcpu *vcpu,
>> +		    unsigned long num,
>> +		    bool immediate)
> don't get the immediate param.

I definitely need comments to explain @immediate here. It means the
injected SDEI event should be handled and delivered immediately.
For example, if one of the following conditions is met, the injected
event can't be delivered immediately. This mechanism is needed by
Async PF to inject event for page-not-present notification and it's
expected to be delivered immediately.

    (a) Current event is critical, another critical event is being delivered.
    (b) Current event is normal, another critical or normal event is being delivered.

>> +{
>> +	struct kvm *kvm = vcpu->kvm;
>> +	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
>> +	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
>> +	struct kvm_sdei_event *kse = NULL;
>> +	struct kvm_sdei_kvm_event *kske = NULL;
>> +	struct kvm_sdei_vcpu_event *ksve = NULL;
>> +	int index, ret = 0;
>> +
>> +	/* Sanity check */
>> +	if (!(ksdei && vsdei)) {
>> +		ret = -EPERM;
>> +		goto out;
>> +	}
>> +
>> +	if (!kvm_sdei_is_valid_event_num(num)) {
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	/* Check the kvm event */
>> +	spin_lock(&ksdei->lock);
>> +	kske = kvm_sdei_find_kvm_event(kvm, num);
>> +	if (!kske) {
>> +		ret = -ENOENT;
>> +		goto unlock_kvm;
>> +	}
>> +
>> +	kse = kske->kse;
>> +	index = (kse->state.type == SDEI_EVENT_TYPE_PRIVATE) ?
>> +		vcpu->vcpu_idx : 0;
>> +	if (!(kvm_sdei_is_registered(kske, index) &&
>> +	      kvm_sdei_is_enabled(kske, index))) {
>> +		ret = -EPERM;
>> +		goto unlock_kvm;
>> +	}
>> +
>> +	/* Check the vcpu state */
>> +	spin_lock(&vsdei->lock);
>> +	if (vsdei->state.masked) {
>> +		ret = -EPERM;
>> +		goto unlock_vcpu;
>> +	}
>> +
>> +	/* Check if the event can be delivered immediately */
>> +	if (immediate) {
> According to the dispatcher pseudo code this should be always checked?

Nope, The spec doesn't require that the event is delivered immediately.
It means the event can be delayed.

>> +		if (kse->state.priority == SDEI_EVENT_PRIORITY_CRITICAL &&
>> +		    !list_empty(&vsdei->critical_events)) {
>> +			ret = -ENOSPC;
>> +			goto unlock_vcpu;
>> +		}
>> +
>> +		if (kse->state.priority == SDEI_EVENT_PRIORITY_NORMAL &&
>> +		    (!list_empty(&vsdei->critical_events) ||
>> +		     !list_empty(&vsdei->normal_events))) {
>> +			ret = -ENOSPC;
>> +			goto unlock_vcpu;
>> +		}
>> +	}
> What about shared event dispatching. I don't see the afficinity checked
> anywhere?

You're correct. I ignore affinity stuff for now for two reasons: (1) I didn't
figure out the mechanism to verify the affinity, as I mentioned before.
(2) Currently, the affinity isn't used by SDEI client driver in the guest kernel.

>> +
>> +	/* Check if the vcpu event exists */
>> +	ksve = kvm_sdei_find_vcpu_event(vcpu, num);
>> +	if (ksve) {
>> +		kske->state.refcount++;
>> +		ksve->state.refcount++;
> why this double refcount increment??

Yep, As I explained before, "ksve->state.refcount" should be increased only
when the corresponding vCPU event is created.

>> +		kvm_make_request(KVM_REQ_SDEI, vcpu);
>> +		goto unlock_vcpu;
>> +	}
>> +
>> +	/* Allocate vcpu event */
>> +	ksve = kzalloc(sizeof(*ksve), GFP_KERNEL);
>> +	if (!ksve) {
>> +		ret = -ENOMEM;
>> +		goto unlock_vcpu;
>> +	}
>> +
>> +	/*
>> +	 * We should take lock to update KVM event state because its
>> +	 * reference count might be zero. In that case, the KVM event
>> +	 * could be destroyed.
>> +	 */
>> +	kske->state.refcount++;
>> +	ksve->state.num      = num;
>> +	ksve->state.refcount = 1;
>> +	ksve->kske           = kske;
>> +	ksve->vcpu           = vcpu;
>> +
>> +	if (kse->state.priority == SDEI_EVENT_PRIORITY_CRITICAL)
>> +		list_add_tail(&ksve->link, &vsdei->critical_events);
>> +	else
>> +		list_add_tail(&ksve->link, &vsdei->normal_events);
>> +
>> +	kvm_make_request(KVM_REQ_SDEI, vcpu);
>> +
>> +unlock_vcpu:
>> +	spin_unlock(&vsdei->lock);
>> +unlock_kvm:
>> +	spin_unlock(&ksdei->lock);
>> +out:
>> +	return ret;
>> +}
>> +
>>   void kvm_sdei_deliver(struct kvm_vcpu *vcpu)
>>   {
>>   	struct kvm *kvm = vcpu->kvm;
>> @@ -1317,6 +1422,9 @@ long kvm_sdei_vcpu_ioctl(struct kvm_vcpu *vcpu, unsigned long arg)
>>   	case KVM_SDEI_CMD_SET_VCPU_STATE:
>>   		ret = kvm_sdei_set_vcpu_state(vcpu, &cmd->ksv_state);
>>   		break;
>> +	case KVM_SDEI_CMD_INJECT_EVENT:
>> +		ret = kvm_sdei_inject(vcpu, cmd->num, false);
>> +		break;
>>   	default:
>>   		ret = -EINVAL;
>>   	}
>>

Thanks,
Gavin

