Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B28D48BD60
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 03:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348880AbiALClR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 21:41:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30399 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236970AbiALClR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 21:41:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641955276;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uEux6PgvXo4td8VAgOHXM3FPN3p4OGxpPUEBxPT+bpE=;
        b=dSLCoKDltnu6Yvyc4HmOCj21K/8x5vl0dz4KSb1jTTff7NWZ+RNTVGWS7iDUZsVOFVqzzy
        64G8CRCbI+Vh2jL40Nay2Mhj6kRIIEBQP4jOnWT3DH6hmKIJVfvnqKjrufUTz6PlDRVc10
        h9FKrNMDGNvKqjRHi2qGOBHVXLTYKmQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-KfpExFTfMpKXr5U0oyp9HQ-1; Tue, 11 Jan 2022 21:41:15 -0500
X-MC-Unique: KfpExFTfMpKXr5U0oyp9HQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AE7B363A6;
        Wed, 12 Jan 2022 02:41:14 +0000 (UTC)
Received: from [10.72.12.29] (ovpn-12-29.pek2.redhat.com [10.72.12.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9DDAA519BF;
        Wed, 12 Jan 2022 02:41:03 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v4 08/21] KVM: arm64: Support SDEI_EVENT_STATUS hypercall
To:     Eric Auger <eauger@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-9-gshan@redhat.com>
 <36f2f2cf-3e6e-30ce-53d2-6c44be93272d@redhat.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <c60845e3-0d98-2007-3461-2a707abe03cb@redhat.com>
Date:   Wed, 12 Jan 2022 10:40:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <36f2f2cf-3e6e-30ce-53d2-6c44be93272d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 11/10/21 1:12 AM, Eric Auger wrote:
> On 8/15/21 2:13 AM, Gavin Shan wrote:
>> This supports SDEI_EVENT_STATUS hypercall. It's used by the guest
>> to retrieve a bitmap to indicate the SDEI event states, including
>> registration, enablement and delivery state.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/kvm/sdei.c | 50 +++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 50 insertions(+)
>>
>> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
>> index a3ba69dc91cb..b95b8c4455e1 100644
>> --- a/arch/arm64/kvm/sdei.c
>> +++ b/arch/arm64/kvm/sdei.c
>> @@ -367,6 +367,54 @@ static unsigned long kvm_sdei_hypercall_unregister(struct kvm_vcpu *vcpu)
>>   	return ret;
>>   }
>>   
>> +static unsigned long kvm_sdei_hypercall_status(struct kvm_vcpu *vcpu)
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
>> +		ret = SDEI_INVALID_PARAMETERS;
>> +		goto out;
>> +	}
> if we were to support bound events, I do not know if a given even num
> can disapper inbetween that check and the rest of the code, in which
> case a lock would be needed?

For the bound events, it's possbile. However, @ksdei->lock can be reused
in that cause. Anyway, it's something for future :)

>> +
>> +	/*
>> +	 * Check if the KVM event exists. None of the flags
>> +	 * will be set if it doesn't exist.
>> +	 */
>> +	spin_lock(&ksdei->lock);
>> +	kske = kvm_sdei_find_kvm_event(kvm, event_num);
>> +	if (!kske) {
>> +		ret = 0;
>> +		goto unlock;
>> +	}
>> +
>> +	index = (kse->state.type == SDEI_EVENT_TYPE_PRIVATE) ?
>> +		vcpu->vcpu_idx : 0;
>> +	if (kvm_sdei_is_registered(kske, index))
>> +		ret |= (1UL << SDEI_EVENT_STATUS_REGISTERED);
>> +	if (kvm_sdei_is_enabled(kske, index))
>> +		ret |= (1UL << SDEI_EVENT_STATUS_ENABLED);
>> +	if (kske->state.refcount)
>> +		ret |= (1UL << SDEI_EVENT_STATUS_RUNNING);
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
>> @@ -395,6 +443,8 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>>   		ret = kvm_sdei_hypercall_unregister(vcpu);
>>   		break;
>>   	case SDEI_1_0_FN_SDEI_EVENT_STATUS:
>> +		ret = kvm_sdei_hypercall_status(vcpu);
>> +		break;
>>   	case SDEI_1_0_FN_SDEI_EVENT_GET_INFO:
>>   	case SDEI_1_0_FN_SDEI_EVENT_ROUTING_SET:
>>   	case SDEI_1_0_FN_SDEI_PE_MASK:
>>

Thanks,
Gavin

