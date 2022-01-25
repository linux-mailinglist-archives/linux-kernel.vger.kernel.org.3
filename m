Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6DD549BB4B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 19:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbiAYS3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 13:29:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53459 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232011AbiAYS3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 13:29:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643135357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OguiwXEbcW8UNqgrCV2TtbVUcGVCkasrwnWQMbIucmw=;
        b=No4YgpPRSKsVkH9izR0gP5hXe596UNPOQiHCroYMUoHClHIbiw4UqjjC53dg7z08VxNlGu
        +GFVxDpsJYEYKeEsd4cs5T+Ov4VEbpIUtcJQCajz7fJAQTd3D+MnnxD7KiOSdJDWKzX9yx
        5+6dKITjz/p6qkJKrzgFYDbXbEY81mE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-335-PDGT-xIKMcSOPdT_c-6EtQ-1; Tue, 25 Jan 2022 13:29:15 -0500
X-MC-Unique: PDGT-xIKMcSOPdT_c-6EtQ-1
Received: by mail-wr1-f71.google.com with SMTP id k12-20020adfe3cc000000b001d6806dfde1so3438086wrm.16
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 10:29:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OguiwXEbcW8UNqgrCV2TtbVUcGVCkasrwnWQMbIucmw=;
        b=wwdVLnoKUVdvYeuUZRh2lEPtGBcdwZTGxqmEU8GW3ihxFNQljhRDeGAaZnPlf4hYsc
         YQ9J0jfBrY9ObbCbITFsapsNQ1XPEZYubj0s02sUbtaQc2g/PDchtvN3kAWb9IhhCJ/s
         b59he0l0pgdJFP8sfNxHRs32b22r8HvaJDoUpSCL6YDjP0MOG4uBqJwV0/3R5JGhimQB
         ZJRZuE09d9K48ODNfDWUXt9ijRnFDTTomGAW8mtEhCmFm8lrk1iRSzAD4SsbQy5TWdG0
         ItBYZ8XO5e0bqrzkVIdbMk6X7LMtPQK4s+ZloD2MUJJt5qX6iOyC/+IEieDqdU+8Ynmt
         Gc8Q==
X-Gm-Message-State: AOAM533Pb+NqFWt9RYbPz5O0daHqjuSIi84VmppVkAp8ntpQB5bI+7Bx
        Dhgamf7LlsRVCOR3f90fx6AfM0M3f/G82eyDWHjTNCyAYzKmRSfroY0bB9NifWCf6OgeMxkL2p/
        tBOGANHgf6nFG95rrEXwPlUKk
X-Received: by 2002:a1c:a98f:: with SMTP id s137mr4093512wme.51.1643135354795;
        Tue, 25 Jan 2022 10:29:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzUlVxRuqvD0OsvPGHGKQUo7uU7drlEMBvdZthikmOuCgmqnzJuuqfomDCZp9tl7pdc4yBi/w==
X-Received: by 2002:a1c:a98f:: with SMTP id s137mr4093493wme.51.1643135354598;
        Tue, 25 Jan 2022 10:29:14 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 21sm1093214wmk.45.2022.01.25.10.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 10:29:14 -0800 (PST)
Subject: Re: [PATCH v4 06/21] KVM: arm64: Support SDEI_EVENT_CONTEXT hypercall
To:     Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-7-gshan@redhat.com>
 <d9471e38-1840-1f79-c028-8f78afc0d2c7@redhat.com>
 <28219c6a-5200-b8f3-09e1-6aa08565030a@redhat.com>
From:   Eric Auger <eauger@redhat.com>
Message-ID: <33a1ba7a-ad97-00db-a381-3dbc88835e15@redhat.com>
Date:   Tue, 25 Jan 2022 19:29:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <28219c6a-5200-b8f3-09e1-6aa08565030a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gavin,

On 1/12/22 3:33 AM, Gavin Shan wrote:
> Hi Eric,
> 
> On 11/10/21 7:16 PM, Eric Auger wrote:
>> On 8/15/21 2:13 AM, Gavin Shan wrote:
>>> This supports SDEI_EVENT_CONTEXT hypercall. It's used by the guest
>>> to retrieved the original registers (R0 - R17) in its SDEI event
>>> handler. Those registers can be corrupted during the SDEI event
>>> delivery.
>>>
>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>> ---
>>>   arch/arm64/kvm/sdei.c | 40 ++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 40 insertions(+)
>>>
>>> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
>>> index b022ce0a202b..b4162efda470 100644
>>> --- a/arch/arm64/kvm/sdei.c
>>> +++ b/arch/arm64/kvm/sdei.c
>>> @@ -270,6 +270,44 @@ static unsigned long
>>> kvm_sdei_hypercall_enable(struct kvm_vcpu *vcpu,
>>>       return ret;
>>>   }
>>>   +static unsigned long kvm_sdei_hypercall_context(struct kvm_vcpu
>>> *vcpu)
>>> +{
>>> +    struct kvm *kvm = vcpu->kvm;
>>> +    struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
>>> +    struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
>>> +    struct kvm_sdei_vcpu_regs *regs;
>>> +    unsigned long index = smccc_get_arg1(vcpu);
>> s/index/param_id to match the spec?
> 
> Sure, but "reg_id" seems better here. As the parameter indicates the GPR
> index
> to be fetched on request of the guest kernel.
fine with me.
> 
>>> +    unsigned long ret = SDEI_SUCCESS;
>>> +
>>> +    /* Sanity check */
>>> +    if (!(ksdei && vsdei)) {
>>> +        ret = SDEI_NOT_SUPPORTED;
>>> +        goto out;
>>> +    }
>>> +
>>> +    if (index > ARRAY_SIZE(vsdei->state.critical_regs.regs)) {
>>> +        ret = SDEI_INVALID_PARAMETERS;
>>> +        goto out;
>>> +    }
>> I would move the above after regs = and use regs there (although the
>> regs ARRAY_SIZE of both is identifical)
> 
> Ok.
> 
>>> +
>>> +    /* Check if the pending event exists */
>>> +    spin_lock(&vsdei->lock);
>>> +    if (!(vsdei->critical_event || vsdei->normal_event)) {
>>> +        ret = SDEI_DENIED;
>>> +        goto unlock;
>>> +    }
>>> +
>>> +    /* Fetch the requested register */
>>> +    regs = vsdei->critical_event ? &vsdei->state.critical_regs :
>>> +                       &vsdei->state.normal_regs;
>>> +    ret = regs->regs[index];
>>> +
>>> +unlock:
>>> +    spin_unlock(&vsdei->lock);
>>> +out:
>>> +    return ret;
>>> +}
>>> +
>>>   int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>>>   {
>>>       u32 func = smccc_get_function(vcpu);
>>> @@ -290,6 +328,8 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>>>           ret = kvm_sdei_hypercall_enable(vcpu, false);
>>>           break;
>>>       case SDEI_1_0_FN_SDEI_EVENT_CONTEXT:
>>> +        ret = kvm_sdei_hypercall_context(vcpu);
>>> +        break;
>>>       case SDEI_1_0_FN_SDEI_EVENT_COMPLETE:
>>>       case SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME:
>>>       case SDEI_1_0_FN_SDEI_EVENT_UNREGISTER:
>>>
> 
> Thanks,
> Gavin
> 
Eric

