Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81EE448BD4A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 03:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348737AbiALC33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 21:29:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50534 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236896AbiALC30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 21:29:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641954565;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VsbqtGg+ePpOhhtcOeVTbJ5DJvk86Q9d7Vdl1Q2cFD8=;
        b=aU4cVC7obJ3xAlKZU1kE5nCpZHcSOCBm+mgKVm07TXzVKIpL742n22BIvhU+41fcrBMH7T
        qeDNLG4UCR5nAH3vqCwvEGtc3JVaO6bMjHkp1NFdKGEiPXxvfXkyibFeIS8dHHr6NmPMv3
        gsamVSoQWdS76EjbIIE9vpO83SkYubo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-bKcD2JEsNH6AUYuLu_pM3g-1; Tue, 11 Jan 2022 21:29:19 -0500
X-MC-Unique: bKcD2JEsNH6AUYuLu_pM3g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8C2A14759;
        Wed, 12 Jan 2022 02:29:17 +0000 (UTC)
Received: from [10.72.12.29] (ovpn-12-29.pek2.redhat.com [10.72.12.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EC1955DF2E;
        Wed, 12 Jan 2022 02:29:11 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v4 05/21] KVM: arm64: Support SDEI_EVENT_{ENABLE, DISABLE}
 hypercall
To:     Eric Auger <eauger@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-6-gshan@redhat.com>
 <4ce1aed4-d955-145c-777b-350efec2e7bc@redhat.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <d7fdb8f8-d0f7-32c4-9644-0ab7cb46dfdf@redhat.com>
Date:   Wed, 12 Jan 2022 10:29:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <4ce1aed4-d955-145c-777b-350efec2e7bc@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 11/10/21 12:02 AM, Eric Auger wrote:
> On 8/15/21 2:13 AM, Gavin Shan wrote:
>> This supports SDEI_EVENT_{ENABLE, DISABLE} hypercall. After SDEI
>> event is registered by guest, it won't be delivered to the guest
>> until it's enabled. On the other hand, the SDEI event won't be
>> raised to the guest or specific vCPU if it's has been disabled
>> on the guest or specific vCPU.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/kvm/sdei.c | 68 +++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 68 insertions(+)
>>
>> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
>> index d3ea3eee154b..b022ce0a202b 100644
>> --- a/arch/arm64/kvm/sdei.c
>> +++ b/arch/arm64/kvm/sdei.c
>> @@ -206,6 +206,70 @@ static unsigned long kvm_sdei_hypercall_register(struct kvm_vcpu *vcpu)
>>   	return ret;
>>   }
>>   
>> +static unsigned long kvm_sdei_hypercall_enable(struct kvm_vcpu *vcpu,
>> +					       bool enable)
>> +{
>> +	struct kvm *kvm = vcpu->kvm;
>> +	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
>> +	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
>> +	struct kvm_sdei_event *kse = NULL;
>> +	struct kvm_sdei_kvm_event *kske = NULL;
>> +	unsigned long event_num = smccc_get_arg1(vcpu);
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
> I would rename into is_exposed_event_num()

kvm_sdei_is_virtual() has been recommended by you when you reviewed the following
patch. I think kvm_sdei_is_virtual() is good enough :)

    [PATCH v4 02/21] KVM: arm64: Add SDEI virtualization infrastructure

>> +		ret = SDEI_INVALID_PARAMETERS;
>> +		goto out;
>> +	}
>> +
>> +	/* Check if the KVM event exists */
>> +	spin_lock(&ksdei->lock);
>> +	kske = kvm_sdei_find_kvm_event(kvm, event_num);
>> +	if (!kske) {
>> +		ret = SDEI_INVALID_PARAMETERS;
> should be DENIED according to the spec, ie. nobody registered that event?

Ok.

>> +		goto unlock;
>> +	}
>> +
>> +	/* Check if there is pending events */
> does that match the "handler-unregister-pending state" case mentionned
> in the spec?
>> +	if (kske->state.refcount) {
>> +		ret = SDEI_PENDING;
> ? not documented in my A spec? DENIED?

Yep, It should be DENIED.

>> +		goto unlock;
>> +	}
>> +
>> +	/* Check if it has been registered */
> isn't duplicate of /* Check if the KVM event exists */ ?

It's not duplicate check, but the comment here seems misleading. I will
correct this to:

	/* Check if it has been defined or exposed */

>> +	kse = kske->kse;
>> +	index = (kse->state.type == SDEI_EVENT_TYPE_PRIVATE) ?
>> +		vcpu->vcpu_idx : 0;
>> +	if (!kvm_sdei_is_registered(kske, index)) {
>> +		ret = SDEI_DENIED;
>> +		goto unlock;
>> +	}
>> +
>> +	/* Verify its enablement state */
>> +	if (enable == kvm_sdei_is_enabled(kske, index)) {
> spec says:
> Enabling/disabled an event, which is already enabled/disabled, is
> permitted and has no effect. I guess ret should be OK.

yep, it should be ok.

>> +		ret = SDEI_DENIED;
>> +		goto unlock;
>> +	}
>> +
>> +	/* Update enablement state */
>> +	if (enable)
>> +		kvm_sdei_set_enabled(kske, index);
>> +	else
>> +		kvm_sdei_clear_enabled(kske, index);
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
>> @@ -220,7 +284,11 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>>   		ret = kvm_sdei_hypercall_register(vcpu);
>>   		break;
>>   	case SDEI_1_0_FN_SDEI_EVENT_ENABLE:
>> +		ret = kvm_sdei_hypercall_enable(vcpu, true);
>> +		break;
>>   	case SDEI_1_0_FN_SDEI_EVENT_DISABLE:
>> +		ret = kvm_sdei_hypercall_enable(vcpu, false);
>> +		break;
>>   	case SDEI_1_0_FN_SDEI_EVENT_CONTEXT:
>>   	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE:
>>   	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME:
>>

Thanks,
Gavin

