Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA46848BD65
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 03:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348920AbiALCqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 21:46:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:44034 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345477AbiALCqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 21:46:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641955595;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lrg/rvcseomradiaHHuYHA2x3dDDuMaVcEYJB9dgKGE=;
        b=HFbEvTNrTK17JvVDwN+l6k0o6XH0ej/rzt5wZNCqffcjKdmFxV8fO2JLHRkhUHrq2IMlNh
        SpfUj3SqVzeTis0Ao+7KuvTPU37o8eCV/J/SytXRk77p7qdPNfwevIIqLynd/qW2hEyohj
        8b5ixfpvoHEa4CIq4s0WplpvcY8y3iI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-QaXQ-xsCMZixjJs-4ANMPQ-1; Tue, 11 Jan 2022 21:46:32 -0500
X-MC-Unique: QaXQ-xsCMZixjJs-4ANMPQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CEB801898292;
        Wed, 12 Jan 2022 02:46:30 +0000 (UTC)
Received: from [10.72.12.29] (ovpn-12-29.pek2.redhat.com [10.72.12.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3ACED5BE29;
        Wed, 12 Jan 2022 02:46:26 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v4 09/21] KVM: arm64: Support SDEI_EVENT_GET_INFO
 hypercall
To:     Eric Auger <eauger@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-10-gshan@redhat.com>
 <03e9b1fb-af79-69bf-f242-00fef3b11a81@redhat.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <44039a09-344f-3ac9-0d58-c0c8c4562b60@redhat.com>
Date:   Wed, 12 Jan 2022 10:46:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <03e9b1fb-af79-69bf-f242-00fef3b11a81@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 11/10/21 1:19 AM, Eric Auger wrote:
> On 8/15/21 2:13 AM, Gavin Shan wrote:
>> This supports SDEI_EVENT_GET_INFO hypercall. It's used by the guest
>> to retrieve various information about the supported (exported) events,
>> including type, signaled, route mode and affinity for the shared
>> events.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/kvm/sdei.c | 76 +++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 76 insertions(+)
>>
>> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
>> index b95b8c4455e1..5dfa74b093f1 100644
>> --- a/arch/arm64/kvm/sdei.c
>> +++ b/arch/arm64/kvm/sdei.c
>> @@ -415,6 +415,80 @@ static unsigned long kvm_sdei_hypercall_status(struct kvm_vcpu *vcpu)
>>   	return ret;
>>   }
>>   
>> +static unsigned long kvm_sdei_hypercall_info(struct kvm_vcpu *vcpu)
>> +{
>> +	struct kvm *kvm = vcpu->kvm;
>> +	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
>> +	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
>> +	struct kvm_sdei_event *kse = NULL;
>> +	struct kvm_sdei_kvm_event *kske = NULL;
>> +	unsigned long event_num = smccc_get_arg1(vcpu);
>> +	unsigned long event_info = smccc_get_arg2(vcpu);
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
>> +	/*
>> +	 * Check if the KVM event exists. The event might have been
>> +	 * registered, we need fetch the information from the registered
> s/fetch/to fetch

Ack.

>> +	 * event in that case.
>> +	 */
>> +	spin_lock(&ksdei->lock);
>> +	kske = kvm_sdei_find_kvm_event(kvm, event_num);
>> +	kse = kske ? kske->kse : NULL;
>> +	if (!kse) {
>> +		kse = kvm_sdei_find_event(kvm, event_num);
>> +		if (!kse) {
>> +			ret = SDEI_INVALID_PARAMETERS;
> this should have already be covered by !kvm_sdei_is_valid_event_num I
> think (although this latter only checks the since static event num with
> KVM owner mask)

Nope. Strictly speaking, kvm_sdei_find_event() covers the check carried
by !kvm_sdei_is_valid_event_num(). All the defined (exposed) events should
have virtual event number :)

>> +			goto unlock;
>> +		}
>> +	}
>> +
>> +	/* Retrieve the requested information */
>> +	switch (event_info) {
>> +	case SDEI_EVENT_INFO_EV_TYPE:
>> +		ret = kse->state.type;
>> +		break;
>> +	case SDEI_EVENT_INFO_EV_SIGNALED:
>> +		ret = kse->state.signaled;
>> +		break;
>> +	case SDEI_EVENT_INFO_EV_PRIORITY:
>> +		ret = kse->state.priority;
>> +		break;
>> +	case SDEI_EVENT_INFO_EV_ROUTING_MODE:
>> +	case SDEI_EVENT_INFO_EV_ROUTING_AFF:
>> +		if (kse->state.type != SDEI_EVENT_TYPE_SHARED) {
>> +			ret = SDEI_INVALID_PARAMETERS;
>> +			break;
>> +		}
>> +
>> +		if (event_info == SDEI_EVENT_INFO_EV_ROUTING_MODE) {
>> +			ret = kske ? kske->state.route_mode :
>> +				     SDEI_EVENT_REGISTER_RM_ANY;
> no, if event is not registered (!kske) DENIED should be returned

I don't think so. According to the specification, there is no DENIED
return value for STATUS hypercall. Either INVALID_PARAMETERS or NOT_SUPPORTED
should be returned from this hypercall :)

>> +		} else {
> same here
>> +			ret = kske ? kske->state.route_affinity : 0;
>> +		}
>> +
>> +		break;
>> +	default:
>> +		ret = SDEI_INVALID_PARAMETERS;
>> +	}
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
>> @@ -446,6 +520,8 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>>   		ret = kvm_sdei_hypercall_status(vcpu);
>>   		break;
>>   	case SDEI_1_0_FN_SDEI_EVENT_GET_INFO:
>> +		ret = kvm_sdei_hypercall_info(vcpu);
>> +		break;
>>   	case SDEI_1_0_FN_SDEI_EVENT_ROUTING_SET:
>>   	case SDEI_1_0_FN_SDEI_PE_MASK:
>>   	case SDEI_1_0_FN_SDEI_PE_UNMASK:
>>

Thanks,
Gavin

