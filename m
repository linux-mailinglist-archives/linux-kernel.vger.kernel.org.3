Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC0B49E477
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242290AbiA0OTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:19:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:42952 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230206AbiA0OTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:19:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643293179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zdw6B1+/yghhyiOfWsSzGzXgg3VtutpZI7oStoOL0GI=;
        b=CKLMwq0QNthovPAG+LoIiD2kP1O5Z4Tcxfksa57/Uia7MpbLv60nKdr6+j3iwDKCzN8Q9j
        jrd1LCTdqHMR1l+SxZxFiII1CAxmL/vZfpUfztg5Za+tps6I23RZtwtfiT6OFDabqHLz5w
        8vT6g2z86ALp5nHOuFlpoA9nracf/4s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-_DESx5qjPQilUtCgrUt84Q-1; Thu, 27 Jan 2022 09:19:37 -0500
X-MC-Unique: _DESx5qjPQilUtCgrUt84Q-1
Received: by mail-wm1-f71.google.com with SMTP id j18-20020a05600c1c1200b0034aeea95dacso4243497wms.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 06:19:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zdw6B1+/yghhyiOfWsSzGzXgg3VtutpZI7oStoOL0GI=;
        b=wJNLuMnSAK1FQUZ+8znbcQXrYs68+UhGM08/WzWYHLuKy03NE2HcuFZJzoRB89yBYD
         TyMdIfK/MVSDzz4cqTqCHHxEFOQnwIxRi6ZuV3Le/NSOjfLMo4i+zq1bz5QIJ5fz874c
         KA3VQ/zpa+qEaO/H6VLBN7NtUWJ8y78tsYVXNb3NCZ8hJmvjJnkJxNQ76RmCKGKikLDE
         4SD6Y8KfXLVEvGouCYnNof1YpaLzg3MhcoTK1FWwFiDnx2rtWhhwS01i+nx+Q2Q4dhnW
         BQ8JXDj/gtoq+SbZiS1gr9UCl9pCBs6kJG2A3xU6wBPKdb9aMUXKh/M15b3xPooDeF3Z
         S/jg==
X-Gm-Message-State: AOAM533QB4Lr+i+bA4r4N+F9eSKDiombM2cFHvsDFn2o1OKJrugE8FvA
        5oAvhSIXLWyUvFz0ochUJXab8zlRVRJ1aRNkhFuYVJGVylqeoSp2YCaRz1pq98SB8Z1Hf/nWUqa
        xZKJJZPcU0RC8QFc2d3/mnWy/
X-Received: by 2002:a05:6000:c2:: with SMTP id q2mr3222160wrx.85.1643293176589;
        Thu, 27 Jan 2022 06:19:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx/UemIofHSAjIkOM40Icl8MDcnSL8ap54lx+rFPtBHcYLstOFs35S+CqvKI+yehQuSceZJCQ==
X-Received: by 2002:a05:6000:c2:: with SMTP id q2mr3222145wrx.85.1643293176325;
        Thu, 27 Jan 2022 06:19:36 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id j2sm2419005wms.2.2022.01.27.06.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 06:19:35 -0800 (PST)
Subject: Re: [PATCH v4 09/21] KVM: arm64: Support SDEI_EVENT_GET_INFO
 hypercall
To:     Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-10-gshan@redhat.com>
 <03e9b1fb-af79-69bf-f242-00fef3b11a81@redhat.com>
 <44039a09-344f-3ac9-0d58-c0c8c4562b60@redhat.com>
From:   Eric Auger <eauger@redhat.com>
Message-ID: <9764c112-733a-fae5-b198-c0b0b2370f2a@redhat.com>
Date:   Thu, 27 Jan 2022 15:19:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <44039a09-344f-3ac9-0d58-c0c8c4562b60@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gavin,

On 1/12/22 3:46 AM, Gavin Shan wrote:
> Hi Eric,
> 
> On 11/10/21 1:19 AM, Eric Auger wrote:
>> On 8/15/21 2:13 AM, Gavin Shan wrote:
>>> This supports SDEI_EVENT_GET_INFO hypercall. It's used by the guest
>>> to retrieve various information about the supported (exported) events,
>>> including type, signaled, route mode and affinity for the shared
>>> events.
>>>
>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>> ---
>>>   arch/arm64/kvm/sdei.c | 76 +++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 76 insertions(+)
>>>
>>> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
>>> index b95b8c4455e1..5dfa74b093f1 100644
>>> --- a/arch/arm64/kvm/sdei.c
>>> +++ b/arch/arm64/kvm/sdei.c
>>> @@ -415,6 +415,80 @@ static unsigned long
>>> kvm_sdei_hypercall_status(struct kvm_vcpu *vcpu)
>>>       return ret;
>>>   }
>>>   +static unsigned long kvm_sdei_hypercall_info(struct kvm_vcpu *vcpu)
>>> +{
>>> +    struct kvm *kvm = vcpu->kvm;
>>> +    struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
>>> +    struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
>>> +    struct kvm_sdei_event *kse = NULL;
>>> +    struct kvm_sdei_kvm_event *kske = NULL;
>>> +    unsigned long event_num = smccc_get_arg1(vcpu);
>>> +    unsigned long event_info = smccc_get_arg2(vcpu);
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
>>> +    /*
>>> +     * Check if the KVM event exists. The event might have been
>>> +     * registered, we need fetch the information from the registered
>> s/fetch/to fetch
> 
> Ack.
> 
>>> +     * event in that case.
>>> +     */
>>> +    spin_lock(&ksdei->lock);
>>> +    kske = kvm_sdei_find_kvm_event(kvm, event_num);
>>> +    kse = kske ? kske->kse : NULL;
>>> +    if (!kse) {
>>> +        kse = kvm_sdei_find_event(kvm, event_num);
>>> +        if (!kse) {
>>> +            ret = SDEI_INVALID_PARAMETERS;
>> this should have already be covered by !kvm_sdei_is_valid_event_num I
>> think (although this latter only checks the since static event num with
>> KVM owner mask)
> 
> Nope. Strictly speaking, kvm_sdei_find_event() covers the check carried
> by !kvm_sdei_is_valid_event_num(). All the defined (exposed) events should
> have virtual event number :)
you're right
> 
>>> +            goto unlock;
>>> +        }
>>> +    }
>>> +
>>> +    /* Retrieve the requested information */
>>> +    switch (event_info) {
>>> +    case SDEI_EVENT_INFO_EV_TYPE:
>>> +        ret = kse->state.type;
>>> +        break;
>>> +    case SDEI_EVENT_INFO_EV_SIGNALED:
>>> +        ret = kse->state.signaled;
>>> +        break;
>>> +    case SDEI_EVENT_INFO_EV_PRIORITY:
>>> +        ret = kse->state.priority;
>>> +        break;
>>> +    case SDEI_EVENT_INFO_EV_ROUTING_MODE:
>>> +    case SDEI_EVENT_INFO_EV_ROUTING_AFF:
>>> +        if (kse->state.type != SDEI_EVENT_TYPE_SHARED) {
>>> +            ret = SDEI_INVALID_PARAMETERS;
>>> +            break;
>>> +        }
>>> +
>>> +        if (event_info == SDEI_EVENT_INFO_EV_ROUTING_MODE) {
>>> +            ret = kske ? kske->state.route_mode :
>>> +                     SDEI_EVENT_REGISTER_RM_ANY;
>> no, if event is not registered (!kske) DENIED should be returned
> 
> I don't think so. According to the specification, there is no DENIED
> return value for STATUS hypercall. Either INVALID_PARAMETERS or
> NOT_SUPPORTED
> should be returned from this hypercall :)

Look at table 5.1.10.2 Parameter a,d Return Values. DENIED is returned
in some cases

Eric
> 
>>> +        } else {
>> same here
>>> +            ret = kske ? kske->state.route_affinity : 0;
>>> +        }
>>> +
>>> +        break;
>>> +    default:
>>> +        ret = SDEI_INVALID_PARAMETERS;
>>> +    }
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
>>> @@ -446,6 +520,8 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>>>           ret = kvm_sdei_hypercall_status(vcpu);
>>>           break;
>>>       case SDEI_1_0_FN_SDEI_EVENT_GET_INFO:
>>> +        ret = kvm_sdei_hypercall_info(vcpu);
>>> +        break;
>>>       case SDEI_1_0_FN_SDEI_EVENT_ROUTING_SET:
>>>       case SDEI_1_0_FN_SDEI_PE_MASK:
>>>       case SDEI_1_0_FN_SDEI_PE_UNMASK:
>>>
> 
> Thanks,
> Gavin
> 

