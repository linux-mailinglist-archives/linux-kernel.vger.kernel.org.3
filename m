Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7F749BB73
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 19:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbiAYSnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 13:43:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60275 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233192AbiAYSnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 13:43:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643136182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k/E8W/vFo172c5tLpHmdy+vUoVoEPG0qfVKMS8tIOlk=;
        b=bOzVR+JulCFXAfDzR8tu83XPUPrmMdYHhGZbNdC8arC7PSaey8i18eNN+/2hrGB3NtBv8/
        xiEKwLFNcZMfIFL+GbtYKvZaJJLOudWUD6bL/FZLRT0si2e3v9iTvuyvuMQs7zu4D40lSs
        dZLFLfYgI+BMEc97tQuPOj1ZZ8dcrrk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-151-ornU1qHxPNGB7eTgcXj_mA-1; Tue, 25 Jan 2022 13:43:00 -0500
X-MC-Unique: ornU1qHxPNGB7eTgcXj_mA-1
Received: by mail-wr1-f71.google.com with SMTP id q4-20020adfbb84000000b001dd3cfddb2dso992157wrg.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 10:43:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k/E8W/vFo172c5tLpHmdy+vUoVoEPG0qfVKMS8tIOlk=;
        b=0wEqJFoJPza5PeWfBLsY6MbPPewb7l5tRgxhlxtTm6o96OWGCJxKgZccSOv966TnJ8
         sMBJpd2J0+HjQP07Sw9XH1Ip6luKjgaR6Ya5M450h3r/gzFSEcX0pljPg0IWwd8sN/G8
         MdL++wOr8HXHGiee/Kth8h69wVe67D/XyVBNe5YGg0znKqbeFTlSc1OMMwMV52qV5rci
         whGAbZVpoGjdSUCLNKX5GkzFzR6jQj4wwtn8jTGd0x7eED7YrtxagbagWodAOT3YbAXU
         jCZvShSBjZyrp+BYjwLEQx5x/YK+LZyn6QODA95wsnBAG1w9SaNFspoboVaw+M3tjrkC
         7CJA==
X-Gm-Message-State: AOAM532mI3KoPMUo6QglLslhKEUAij7IcqQyx7/Yab/EbJTYMUngnQQR
        wBsE5sH/6Q6IfLviT5uIKUpGEN7peHRAcBQP1GGIWK9uIEOrtceB01ua649tKkYUgDDxjsgIfG7
        xhKLqwPUP3ZF+9L8zhBhXb8Bo
X-Received: by 2002:a5d:6d04:: with SMTP id e4mr9512122wrq.398.1643136179219;
        Tue, 25 Jan 2022 10:42:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyy/7ISkdIjSYoDZ1gzcYOgd0KtipUYjYIsylN82M3L6gXjY9mDWnzDzpKnA0PmGmlx+o5rrA==
X-Received: by 2002:a5d:6d04:: with SMTP id e4mr9512106wrq.398.1643136178982;
        Tue, 25 Jan 2022 10:42:58 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 11sm1096881wmx.5.2022.01.25.10.42.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 10:42:58 -0800 (PST)
Subject: Re: [PATCH v4 07/21] KVM: arm64: Support SDEI_EVENT_UNREGISTER
 hypercall
To:     Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-8-gshan@redhat.com>
 <100a4aa0-6c2d-2fec-6f11-c7e64946ef0b@redhat.com>
 <11022feb-16d7-8732-0d3a-12a65a4e39de@redhat.com>
From:   Eric Auger <eauger@redhat.com>
Message-ID: <60e5b475-2ebb-f697-9024-3afba7a7ab3e@redhat.com>
Date:   Tue, 25 Jan 2022 19:42:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <11022feb-16d7-8732-0d3a-12a65a4e39de@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gavin,
On 1/12/22 3:38 AM, Gavin Shan wrote:
> Hi Eric,
> 
> On 11/10/21 1:05 AM, Eric Auger wrote:
>> On 8/15/21 2:13 AM, Gavin Shan wrote:
>>> This supports SDEI_EVENT_UNREGISTER hypercall. It's used by the
>>> guest to unregister SDEI event. The SDEI event won't be raised to
>>> the guest or specific vCPU after it's unregistered successfully.
>>> It's notable the SDEI event is disabled automatically on the guest
>>> or specific vCPU once it's unregistered successfully.
>>>
>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>> ---
>>>   arch/arm64/kvm/sdei.c | 61 +++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 61 insertions(+)
>>>
>>> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
>>> index b4162efda470..a3ba69dc91cb 100644
>>> --- a/arch/arm64/kvm/sdei.c
>>> +++ b/arch/arm64/kvm/sdei.c
>>> @@ -308,6 +308,65 @@ static unsigned long
>>> kvm_sdei_hypercall_context(struct kvm_vcpu *vcpu)
>>>       return ret;
>>>   }
>>>   +static unsigned long kvm_sdei_hypercall_unregister(struct kvm_vcpu
>>> *vcpu)
>>> +{
>>> +    struct kvm *kvm = vcpu->kvm;
>>> +    struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
>>> +    struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
>>> +    struct kvm_sdei_event *kse = NULL;
>>> +    struct kvm_sdei_kvm_event *kske = NULL;
>>> +    unsigned long event_num = smccc_get_arg1(vcpu);
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
>>> +    /* Check if the KVM event exists */
>>> +    spin_lock(&ksdei->lock);
>>> +    kske = kvm_sdei_find_kvm_event(kvm, event_num);
>>> +    if (!kske) {
>>> +        ret = SDEI_INVALID_PARAMETERS;
>>> +        goto unlock;
>>> +    }
>>> +
>>> +    /* Check if there is pending events */
>>> +    if (kske->state.refcount) {
>>> +        ret = SDEI_PENDING;
>> don't you want to record the fact the unregistration is outstanding to
>> perform subsequent actions? Otherwise nothing will hapen when the
>> current executing handlers complete?>
> It's not necessary. The guest should retry in this case.

I do not understand that from the spec:
6.7 Unregistering an event says

With the PENDING status, the unregister request will be queued until the
event is completed using SDEI_EVENT_COMPLETE .

Also there is state called "Handler-unregister-pending"

But well I would need to dig further into the spec again :)


> 
>>> +        goto unlock;
>>> +    }
>>> +
>>> +    /* Check if it has been registered */
>>> +    kse = kske->kse;
>>> +    index = (kse->state.type == SDEI_EVENT_TYPE_PRIVATE) ?
>>> +        vcpu->vcpu_idx : 0;
>> you could have an inline for the above as this is executed in many
>> functions. even including the code below.
> 
> Ok, it's a good idea.
> 
>>> +    if (!kvm_sdei_is_registered(kske, index)) {
>>> +        ret = SDEI_DENIED;
>>> +        goto unlock;
>>> +    }
>>> +
>>> +    /* The event is disabled when it's unregistered */
>>> +    kvm_sdei_clear_enabled(kske, index);
>>> +    kvm_sdei_clear_registered(kske, index);
>>> +    if (kvm_sdei_empty_registered(kske)) {
>> a refcount mechanism would be cleaner I think.
> 
> A refcount isn't working well. We need a mapping here because the private
> SDEI event can be enabled/registered on multiple vCPUs. We need to know
> the exact vCPUs where the private SDEI event is enabled/registered.

I don't get why you can't increment/decrement the ref count each time
the event is registered/unregistered by a given vcpu to manage its life
cycle? Does not mean you don't need the bitmap to know the actual mapping.

Thanks

Eric
> 
>>> +        list_del(&kske->link);
>>> +        kfree(kske);
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
>>> @@ -333,6 +392,8 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>>>       case SDEI_1_0_FN_SDEI_EVENT_COMPLETE:
>>>       case SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME:
>>>       case SDEI_1_0_FN_SDEI_EVENT_UNREGISTER:
>>> +        ret = kvm_sdei_hypercall_unregister(vcpu);
>>> +        break;
>>>       case SDEI_1_0_FN_SDEI_EVENT_STATUS:
>>>       case SDEI_1_0_FN_SDEI_EVENT_GET_INFO:
>>>       case SDEI_1_0_FN_SDEI_EVENT_ROUTING_SET:
>>>
> 
> Thanks,
> Gavin
> 

