Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B610949BB3A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 19:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbiAYSYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 13:24:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:46361 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231276AbiAYSXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 13:23:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643135026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wQiWPJdaqri76JgRGXeOGlGXeaAGk3DNqSI3A9eZhrQ=;
        b=Pdn/AZtea6QLh0biD6MwjDY7JPaZAP/4ARLS9i/l1WLo7ArTK18idb25E+Vtikff1HFncv
        MTuDAgCCagUYpKSzT4EOUo1oJ+nkZt27BUn4RNrMiaBDG3Y947+i5wZqrpxEcLUlTaGWIy
        uG/d3T8VfQ7FbiV/OqeCoSvVPvBA7Ws=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-141-WC3j1EzSM62uYdjHeTmUyQ-1; Tue, 25 Jan 2022 13:23:44 -0500
X-MC-Unique: WC3j1EzSM62uYdjHeTmUyQ-1
Received: by mail-wr1-f70.google.com with SMTP id h12-20020adfa4cc000000b001d474912698so3418989wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 10:23:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wQiWPJdaqri76JgRGXeOGlGXeaAGk3DNqSI3A9eZhrQ=;
        b=tvIpwJaPIQ/EFAiVQ7v7Yfw2ZlIRNM8QzpC91SabpbPwzDSIW+kL4rJyuvTdXrF4vq
         whFepYlODZDCHKoBAmLZs+LOBM8IWCYTqV7n9u+w5zkFNSbg8wn8vFunHECFwlUYKQve
         D/pbblwL95/3nCRkW81ZZlFIj/DsB+KFuv8+GyBhdRONozq6U6PJr/Lmyn4AcqPJjfgK
         /4OP0qbCNJj9h8WjiARjQXdvJbZuNp9xSV0BjaDBvyx7b022Jw50yfc8mjNCSdb0+ZGF
         sMX0stoMESol4CF8fYl7pTKwhtVlGksV4HICImg0UE8sd6+Qm/QSyP17dbN+s2MElFuF
         3qcw==
X-Gm-Message-State: AOAM531Wx4lJdLnt9ftbRq24HuG5qG0wU2ulbB2tZSnj8h5j3CX92OcB
        ry0ph4F122HTIlIo42hAUghEu4NJ9kj5SOawGuMKrQSlKjBUjHniu9jwttnbl0yRxc4cyD/I9YW
        rXypkeVxzdlu3DtmZWo1hospb
X-Received: by 2002:a5d:69c1:: with SMTP id s1mr15463228wrw.114.1643135022681;
        Tue, 25 Jan 2022 10:23:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJygGx6tbpCyoXfBOstJyIPCE+fQLPVTlTN361eLiHBotZVy/dgkejxLJ7815NvcqdCls1TNvA==
X-Received: by 2002:a5d:69c1:: with SMTP id s1mr15463214wrw.114.1643135022434;
        Tue, 25 Jan 2022 10:23:42 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id bg26sm1032430wmb.48.2022.01.25.10.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 10:23:41 -0800 (PST)
Subject: Re: [PATCH v4 05/21] KVM: arm64: Support SDEI_EVENT_{ENABLE, DISABLE}
 hypercall
To:     Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-6-gshan@redhat.com>
 <4ce1aed4-d955-145c-777b-350efec2e7bc@redhat.com>
 <d7fdb8f8-d0f7-32c4-9644-0ab7cb46dfdf@redhat.com>
From:   Eric Auger <eauger@redhat.com>
Message-ID: <69cdc2b8-ccbe-dbe2-4805-04f1a53d9a53@redhat.com>
Date:   Tue, 25 Jan 2022 19:23:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <d7fdb8f8-d0f7-32c4-9644-0ab7cb46dfdf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gavin,

On 1/12/22 3:29 AM, Gavin Shan wrote:
> Hi Eric,
> 
> On 11/10/21 12:02 AM, Eric Auger wrote:
>> On 8/15/21 2:13 AM, Gavin Shan wrote:
>>> This supports SDEI_EVENT_{ENABLE, DISABLE} hypercall. After SDEI
>>> event is registered by guest, it won't be delivered to the guest
>>> until it's enabled. On the other hand, the SDEI event won't be
>>> raised to the guest or specific vCPU if it's has been disabled
>>> on the guest or specific vCPU.
>>>
>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>> ---
>>>   arch/arm64/kvm/sdei.c | 68 +++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 68 insertions(+)
>>>
>>> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
>>> index d3ea3eee154b..b022ce0a202b 100644
>>> --- a/arch/arm64/kvm/sdei.c
>>> +++ b/arch/arm64/kvm/sdei.c
>>> @@ -206,6 +206,70 @@ static unsigned long
>>> kvm_sdei_hypercall_register(struct kvm_vcpu *vcpu)
>>>       return ret;
>>>   }
>>>   +static unsigned long kvm_sdei_hypercall_enable(struct kvm_vcpu *vcpu,
>>> +                           bool enable)
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
>> I would rename into is_exposed_event_num()
> 
> kvm_sdei_is_virtual() has been recommended by you when you reviewed the
> following
> patch. I think kvm_sdei_is_virtual() is good enough :)

argh, is_virtual() then :)

Eric
> 
>    [PATCH v4 02/21] KVM: arm64: Add SDEI virtualization infrastructure
> 
>>> +        ret = SDEI_INVALID_PARAMETERS;
>>> +        goto out;
>>> +    }
>>> +
>>> +    /* Check if the KVM event exists */
>>> +    spin_lock(&ksdei->lock);
>>> +    kske = kvm_sdei_find_kvm_event(kvm, event_num);
>>> +    if (!kske) {
>>> +        ret = SDEI_INVALID_PARAMETERS;
>> should be DENIED according to the spec, ie. nobody registered that event?
> 
> Ok.
> 
>>> +        goto unlock;
>>> +    }
>>> +
>>> +    /* Check if there is pending events */
>> does that match the "handler-unregister-pending state" case mentionned
>> in the spec?
>>> +    if (kske->state.refcount) {
>>> +        ret = SDEI_PENDING;
>> ? not documented in my A spec? DENIED?
> 
> Yep, It should be DENIED.
> 
>>> +        goto unlock;
>>> +    }
>>> +
>>> +    /* Check if it has been registered */
>> isn't duplicate of /* Check if the KVM event exists */ ?
> 
> It's not duplicate check, but the comment here seems misleading. I will
> correct this to:
> 
>     /* Check if it has been defined or exposed */
> 
>>> +    kse = kske->kse;
>>> +    index = (kse->state.type == SDEI_EVENT_TYPE_PRIVATE) ?
>>> +        vcpu->vcpu_idx : 0;
>>> +    if (!kvm_sdei_is_registered(kske, index)) {
>>> +        ret = SDEI_DENIED;
>>> +        goto unlock;
>>> +    }
>>> +
>>> +    /* Verify its enablement state */
>>> +    if (enable == kvm_sdei_is_enabled(kske, index)) {
>> spec says:
>> Enabling/disabled an event, which is already enabled/disabled, is
>> permitted and has no effect. I guess ret should be OK.
> 
> yep, it should be ok.
> 
>>> +        ret = SDEI_DENIED;
>>> +        goto unlock;
>>> +    }
>>> +
>>> +    /* Update enablement state */
>>> +    if (enable)
>>> +        kvm_sdei_set_enabled(kske, index);
>>> +    else
>>> +        kvm_sdei_clear_enabled(kske, index);
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
>>> @@ -220,7 +284,11 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>>>           ret = kvm_sdei_hypercall_register(vcpu);
>>>           break;
>>>       case SDEI_1_0_FN_SDEI_EVENT_ENABLE:
>>> +        ret = kvm_sdei_hypercall_enable(vcpu, true);
>>> +        break;
>>>       case SDEI_1_0_FN_SDEI_EVENT_DISABLE:
>>> +        ret = kvm_sdei_hypercall_enable(vcpu, false);
>>> +        break;
>>>       case SDEI_1_0_FN_SDEI_EVENT_CONTEXT:
>>>       case SDEI_1_0_FN_SDEI_EVENT_COMPLETE:
>>>       case SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME:
>>>
> 
> Thanks,
> Gavin
> 

