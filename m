Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C0349E455
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237144AbiA0ONt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:13:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41156 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231342AbiA0ONs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643292827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RA+FqaQrHjc+Ri5R2W1XnPNRe48WbE+y+UNj2cKryyI=;
        b=Uj32+eDiEZI4jB7Z5C34oY2Th5AA/R9PegqF/b5bdEK+SP0+ig6iWXCPLo298zJ7Acy7Q/
        gUhcM0Ny/wFw4/hlW6m5iRw4YcqaBgWfH2mGpXpiDJha8pccTaZ5ZdFEZk7H6fb76b6KLA
        XibQOHR7+TDzykA4LtekcdNCh4FYD3U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-PXjhnpeNPum1EZnRw-iI9g-1; Thu, 27 Jan 2022 09:13:46 -0500
X-MC-Unique: PXjhnpeNPum1EZnRw-iI9g-1
Received: by mail-wm1-f72.google.com with SMTP id q71-20020a1ca74a000000b003507f38e330so4182313wme.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 06:13:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RA+FqaQrHjc+Ri5R2W1XnPNRe48WbE+y+UNj2cKryyI=;
        b=eFqSP6SqPgLXUg237786jzrvJOGuKpzIm+w1yS2QmI0GjEgvaWohHQI+5hM/C6YZ1P
         VUS+esOGNzUW8wGO49GjDdBygdJxwUbcgybGYKygATd2gSERyAygW3gxUGg9zjUkEvse
         vd9DcdNTNuGfxH8AMFjLrW55ytgNUvrZtxqzsNtCZ4AHo6BFaT4Lw4zZXob1wgbSk6/8
         L2kkIc/BBgReSiOuzm/LaINn9PdI+OSQtIqu9FK83ioEx/kQF0igwHYUb4YuHsaEYy4J
         3bnKXJf5UBu9eQAudq/3Kf8xlDGPYmhFWGBjiALZLl0K8MsaJmVn1vAmZcW4KfVxpD1B
         UDtA==
X-Gm-Message-State: AOAM533vG0uhJpLbjohslTVtdnWbq74NvHou1g0pTZjSMEPrVncfPhlX
        770lOOhFMipkmVnL89mObocfQwihAsrrfxcOfckfRNeTCeLIlU25emtTYw8JBYL7hh4L+ew38/5
        wKbc7Ibcd105iC5P9hkacNWkH
X-Received: by 2002:a05:600c:4ed3:: with SMTP id g19mr2234010wmq.63.1643292825014;
        Thu, 27 Jan 2022 06:13:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy7EusHvqjNVRmjOE+yGYJZY0KAXbfBzEZZTX4VRBf+Guk7/SFdfRO10BfRMtkhycvcqOIvrA==
X-Received: by 2002:a05:600c:4ed3:: with SMTP id g19mr2233994wmq.63.1643292824761;
        Thu, 27 Jan 2022 06:13:44 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id a18sm2308276wrw.5.2022.01.27.06.13.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 06:13:44 -0800 (PST)
Subject: Re: [PATCH v4 10/21] KVM: arm64: Support SDEI_EVENT_ROUTING_SET
 hypercall
To:     Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-11-gshan@redhat.com>
 <0d46c17b-1a37-cbf6-4d34-aa03d30e39ef@redhat.com>
 <f2ecad36-ba52-5420-1f7b-d7c099318680@redhat.com>
From:   Eric Auger <eauger@redhat.com>
Message-ID: <9186a727-afa7-a32c-e46e-580b2bc07ef7@redhat.com>
Date:   Thu, 27 Jan 2022 15:13:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <f2ecad36-ba52-5420-1f7b-d7c099318680@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gavin,

On 1/12/22 3:54 AM, Gavin Shan wrote:
> Hi Eric,
> 
> On 11/10/21 2:47 AM, Eric Auger wrote:
>> On 8/15/21 2:13 AM, Gavin Shan wrote:
>>> This supports SDEI_EVENT_ROUTING_SET hypercall. It's used by the
>>> guest to set route mode and affinity for the registered KVM event.
>>> It's only valid for the shared events. It's not allowed to do so
>>> when the corresponding event has been raised to the guest.
>>>
>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>> ---
>>>   arch/arm64/kvm/sdei.c | 64 +++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 64 insertions(+)
>>>
>>> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
>>> index 5dfa74b093f1..458695c2394f 100644
>>> --- a/arch/arm64/kvm/sdei.c
>>> +++ b/arch/arm64/kvm/sdei.c
>>> @@ -489,6 +489,68 @@ static unsigned long
>>> kvm_sdei_hypercall_info(struct kvm_vcpu *vcpu)
>>>       return ret;
>>>   }
>>>   +static unsigned long kvm_sdei_hypercall_route(struct kvm_vcpu *vcpu)
>>> +{
>>> +    struct kvm *kvm = vcpu->kvm;
>>> +    struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
>>> +    struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
>>> +    struct kvm_sdei_event *kse = NULL;
>>> +    struct kvm_sdei_kvm_event *kske = NULL;
>>> +    unsigned long event_num = smccc_get_arg1(vcpu);
>>> +    unsigned long route_mode = smccc_get_arg2(vcpu);
>>> +    unsigned long route_affinity = smccc_get_arg3(vcpu);
>>> +    int index = 0;
>>> +    unsigned long ret = SDEI_SUCCESS;
>>> +
>>> +    /* Sanity check */
>>> +    if (!(ksdei && vsdei)) {
>>> +        ret = SDEI_NOT_SUPPORTED;
>>> +        goto out;
>>> +    }
>>> +
>>> +    if (!kvm_sdei_is_valid_event_num(event_num)) {
>>> +        ret = SDEI_INVALID_PARAMETERS;
>>> +        goto out;
>>> +    }
>>> +
>>> +    if (!(route_mode == SDEI_EVENT_REGISTER_RM_ANY ||
>>> +          route_mode == SDEI_EVENT_REGISTER_RM_PE)) {
>>> +        ret = SDEI_INVALID_PARAMETERS;
>>> +        goto out;
>>> +    }
>> Some sanity checking on the affinity arg could be made as well according
>> to 5.1.2  affinity desc. The fn shall return INVALID_PARAMETER in case
>> of invalid affinity.
> 
> Yep, you're right. I didn't figure out it. I may put a comment here.
> For now, the SDEI client driver in the guest kernel doesn't attempt
> to change the routing mode.
> 
>     /* FIXME: The affinity should be verified */
> 
>>> +
>>> +    /* Check if the KVM event has been registered */
>>> +    spin_lock(&ksdei->lock);
>>> +    kske = kvm_sdei_find_kvm_event(kvm, event_num);
>>> +    if (!kske) {
>>> +        ret = SDEI_INVALID_PARAMETERS;
>>> +        goto unlock;
>>> +    }
>>> +
>>> +    /* Validate KVM event state */
>>> +    kse = kske->kse;
>>> +    if (kse->state.type != SDEI_EVENT_TYPE_SHARED) {
>>> +        ret = SDEI_INVALID_PARAMETERS;
>>> +        goto unlock;
>>> +    }
>>> +
>> Event handler is in a state other than: handler-registered.
> 
> They're equivalent as the handler is provided as a parameter when
> the event is registered.
> 
>>> +    if (!kvm_sdei_is_registered(kske, index) ||
>>> +        kvm_sdei_is_enabled(kske, index)     ||
>>> +        kske->state.refcount) {
>> I am not sure about the refcount role here. Does it make sure the state
>> is != handler-enabled and running or handler-unregister-pending?
>>
>> I think we would gain in readibility if we had a helper to check whether
>> we are in those states?
> 
> @refcount here indicates pending SDEI event for delivery. In this case,
> chaning its routing mode is disallowed.
OK. I guess you will document the refcount role somewhere.

Thanks

Eric
> 
>>> +        ret = SDEI_DENIED;
>>> +        goto unlock;
>>> +    }
>>> +
>>> +    /* Update state */
>>> +    kske->state.route_mode     = route_mode;
>>> +    kske->state.route_affinity = route_affinity;
>>> +
>>> +unlock:
>>> +    spin_unlock(&ksdei->lock);
>>> +out:
>>> +    return ret;
>>> +}
>>> +
>>>   int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>>>   {
>>>       u32 func = smccc_get_function(vcpu);
>>> @@ -523,6 +585,8 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>>>           ret = kvm_sdei_hypercall_info(vcpu);
>>>           break;
>>>       case SDEI_1_0_FN_SDEI_EVENT_ROUTING_SET:
>>> +        ret = kvm_sdei_hypercall_route(vcpu);
>>> +        break;
>>>       case SDEI_1_0_FN_SDEI_PE_MASK:
>>>       case SDEI_1_0_FN_SDEI_PE_UNMASK:
>>>       case SDEI_1_0_FN_SDEI_INTERRUPT_BIND:
>>>
> 
> Thanks,
> Gavin
> 

