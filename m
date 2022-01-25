Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD9649BB5A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 19:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbiAYSdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 13:33:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25745 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232525AbiAYSct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 13:32:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643135566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2YHSY/Nkzf4Yub0Wgdnv3A9D/iLT4fHqA5QN1U3nZRw=;
        b=KiVlnHkesPlt84D17QAadDyb8TH2JHomKMVun2OGDQ4V8MJyn3UU0gC/JXkr6QOsELLACG
        ILAlGdVfqlS50KPNt7x/U8zYoLZezgFKDxgwZKoddX90KKccgWI/iGbbLUEWukF+Wi6miJ
        UT5orfOg6iajyKkvjnQu4IZISq2JVeg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-202-ReGbgdcjNJ25uDKsy4nxZw-1; Tue, 25 Jan 2022 13:32:45 -0500
X-MC-Unique: ReGbgdcjNJ25uDKsy4nxZw-1
Received: by mail-wm1-f70.google.com with SMTP id f7-20020a1cc907000000b0034b63f314ccso1890965wmb.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 10:32:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2YHSY/Nkzf4Yub0Wgdnv3A9D/iLT4fHqA5QN1U3nZRw=;
        b=79wY9zNabWIYS2HyVl2lArDQk0Pe9VwsZ/uPJLE2sDFiBrF1qN+O/XTDEErBwnyCBG
         +MC7T9VbZiXIn8XdWjapNY96JZ5RHyidH7A1WGWl22+AK/78q9OwlBgbt41c0Ya+OzkK
         0mQ3/M3YndAxs76y8pexiO8GBx29l7ra4lAzyjFHD/A95sdW64WvJCuEosqli5smyaP4
         VE/spIKOwUMWUIfVvUxTApoug6U9zYRX+gV4H+zpU3LejtwsSHSzqHPitXSt9wrML91o
         RL5cgekcvNtV2vNdV1RxnGNEEEUvTq70i92ZKKJXeZ5ZiKD385+nqgpw2qDcWdL0Fs9/
         Uetw==
X-Gm-Message-State: AOAM5307urCnWnVVJN14QMnphm9dBd4cL3fiJvtwdTQ2zEk8Gg0NOx89
        ZA9B5DPNjpOXFFP10ts+isfsRoOKcDbkPCSxtfWD0sk2P2IpvbI4jf1rtvn0wI7gRkP/ZPWGPpy
        wGWSvJwLh5ITQVqV7r7ZhZoWh
X-Received: by 2002:a05:600c:2505:: with SMTP id d5mr4102640wma.36.1643135564373;
        Tue, 25 Jan 2022 10:32:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyWAzVQFt8v++ktzP0X4IvFxbJMwGQJKw9tLIEla5bx4IKLla8MyJnZjdvqnp5cKa4sM0QpDw==
X-Received: by 2002:a05:600c:2505:: with SMTP id d5mr4102628wma.36.1643135564155;
        Tue, 25 Jan 2022 10:32:44 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id l5sm1125913wmq.7.2022.01.25.10.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 10:32:43 -0800 (PST)
Subject: Re: [PATCH v4 06/21] KVM: arm64: Support SDEI_EVENT_CONTEXT hypercall
To:     Gavin Shan <gshan@redhat.com>,
        Shannon Zhao <shannon.zhaosl@gmail.com>,
        kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, pbonzini@redhat.com, will@kernel.org,
        linux-kernel@vger.kernel.org, Jonathan.Cameron@huawei.com
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-7-gshan@redhat.com>
 <40d818a2-0c91-e06e-6ce8-ac8123b8d1d4@gmail.com>
 <798ecbb0-f369-f3e7-ad50-78acfd902d1d@redhat.com>
 <71b87778-ea60-b01d-9010-789feb1e16fa@redhat.com>
From:   Eric Auger <eauger@redhat.com>
Message-ID: <11bbc0c9-b4b2-473f-1979-a7ea8994d15e@redhat.com>
Date:   Tue, 25 Jan 2022 19:32:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <71b87778-ea60-b01d-9010-789feb1e16fa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gavin,

On 1/13/22 8:13 AM, Gavin Shan wrote:
> Hi Shannon,
> 
> On 1/13/22 3:02 PM, Gavin Shan wrote:
>> On 1/11/22 5:43 PM, Shannon Zhao wrote:
>>> On 2021/8/15 8:13, Gavin Shan wrote:
>>>> +static unsigned long kvm_sdei_hypercall_context(struct kvm_vcpu *vcpu)
>>>> +{
>>>> +    struct kvm *kvm = vcpu->kvm;
>>>> +    struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
>>>> +    struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
>>>> +    struct kvm_sdei_vcpu_regs *regs;
>>>> +    unsigned long index = smccc_get_arg1(vcpu);
>>>> +    unsigned long ret = SDEI_SUCCESS;
>>>> +
>>>> +    /* Sanity check */
>>>> +    if (!(ksdei && vsdei)) {
>>>> +        ret = SDEI_NOT_SUPPORTED;
>>>> +        goto out;
>>>> +    }
>>> Maybe we could move these common sanity check codes to
>>> kvm_sdei_hypercall to save some lines.
>>>
>>
>> Not all hypercalls need this check. For example,
>> COMPLETE/COMPLETE_RESUME/CONTEXT don't
>> have SDEI event number as the argument. If we really want move this
>> check into function
>> kvm_sdei_hypercall(), we would have code like below. Too much
>> duplicated snippets will
>> be seen. I don't think it's better than what we have if I fully
>> understand your comments.
>>
> 
> oops... sorry. Please ignore my previous reply. I thought you talk about
> the check on the SDEI event number wrongly. Yes, you're correct that the
> check should be moved to kvm_sdei_hypercall().

even better than my previous proposal then

Eric
> 
> Thanks,
> Gavin
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm

