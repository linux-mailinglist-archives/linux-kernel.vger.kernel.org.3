Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7663D4984D1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243756AbiAXQ3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:29:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33271 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243749AbiAXQ3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:29:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643041776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I5kTFm0DSLDhibevYhrcD9Q7bduJaISj2Els8l1FPxY=;
        b=P5AWIDWQ/m/oR0OmfeOH9ck6q1sgbaaGvVw0SJB43XxV/p1Gv8yY3m8k3c9ZaNTeN4VDth
        9HHhtuluqPGtM6Yp0GGjOkiLvKLFIAU0rgEylxmScwOdx1EEEa5me5oJdviHfm4KUCBmH0
        eWXjENRLchxyEL24xX8BSHVz/KO9zkY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-7n8tAzrJN6-cAC3UpEUfqg-1; Mon, 24 Jan 2022 11:29:34 -0500
X-MC-Unique: 7n8tAzrJN6-cAC3UpEUfqg-1
Received: by mail-ej1-f70.google.com with SMTP id p8-20020a1709060e8800b006b39ade8c12so2301626ejf.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 08:29:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=I5kTFm0DSLDhibevYhrcD9Q7bduJaISj2Els8l1FPxY=;
        b=002neBqdLWN3wnkVdkeCe1DV7LRwwkn7qXFrBXuspekEDaytlPA57m33WpdvHbpp0A
         Vr5R92HTyg59Zk3F0pChuYfruyi/JyljcOwS+7mkgrxQ1k04MhZrsXhyxM6sWr4g+lTH
         fVAq2KgljKwlScHV4RBn1e/XCih4P5IDLAsyP+2r/GdyuWsg2yRmvoUy472PPIqXvxlS
         3fpAxOUO0wKusUwppZfZmA+so1xne9/fVwHjBX17LgbUkJpf42StqhOIn9xudh/3ivHo
         32BJjClAzk33Goy91se8wQno2LfxXx6z3Cg4+WTUabjWxl9MJ0/y44Sv+j4wo3qp7daf
         uCEg==
X-Gm-Message-State: AOAM530GcJGP352LzLnVdwu4cecaq0sYgfh2QQiUdojXW2II9ZGN5eA5
        oF5ZbZranNskWkx982ZNGoMec+izm6I5Y7QgazhFfQ6it+x/cAJCqJ4KQYCLXiuelWS/vEUGv0X
        d9JAvqGS/2HuvreE7x4cctfW4
X-Received: by 2002:a17:906:5d1:: with SMTP id t17mr3830527ejt.516.1643041773717;
        Mon, 24 Jan 2022 08:29:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx+R1P61BLNvW5+jUNlHT2Rv/97l1hdi1FjyqW97FSaLqQVMnQO4NT8VUCx8D7Pl6nWRWWIGg==
X-Received: by 2002:a17:906:5d1:: with SMTP id t17mr3830516ejt.516.1643041773506;
        Mon, 24 Jan 2022 08:29:33 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id gv34sm5040817ejc.125.2022.01.24.08.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 08:29:32 -0800 (PST)
Message-ID: <e5744e0b-00fc-8563-edb7-b6bf52c63b0e@redhat.com>
Date:   Mon, 24 Jan 2022 17:29:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] KVM: x86/cpuid: Exclude unpermitted xfeatures for
 vcpu->arch.guest_supported_xcr0
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Like Xu <like.xu.linux@gmail.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhong, Yang" <yang.zhong@intel.com>
References: <20220123055025.81342-1-likexu@tencent.com>
 <BN9PR11MB52762E2DEF810DF9AFAE1DDC8C5E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <38c1fbc3-d770-48f3-5432-8fa1fde033f5@gmail.com>
 <Ye7SbfPL/QAjOI6s@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Ye7SbfPL/QAjOI6s@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/22 17:23, Sean Christopherson wrote:
> On Mon, Jan 24, 2022, Like Xu wrote:
>> On 24/1/2022 3:06 pm, Tian, Kevin wrote:
>>>> From: Like Xu <like.xu.linux@gmail.com>
>>>> Sent: Sunday, January 23, 2022 1:50 PM
>>>>
>>>> From: Like Xu <likexu@tencent.com>
>>>>
>>>> A malicious user space can bypass xstate_get_guest_group_perm() in the
>>>> KVM_GET_SUPPORTED_CPUID mechanism and obtain unpermitted xfeatures,
>>>> since the validity check of xcr0 depends only on guest_supported_xcr0.
>>>
>>> Unpermitted xfeatures cannot pass kvm_check_cpuid()...
>>
>> Indeed, 5ab2f45bba4894a0db4af8567da3efd6228dd010.
>>
>> This part of logic is pretty fragile and fragmented due to semantic
>> inconsistencies between supported_xcr0 and guest_supported_xcr0
>> in other three places:
> 
> There are no inconsistencies, at least not in the examples below, as the examples
> are intended to work in host context.  guest_supported_xcr0 is about what the guest
> is/isn't allowed to access, it has no bearing on what host userspace can/can't do.
> Or are you talking about a different type of inconsistency?

The extra complication is that arch_prctl(ARCH_REQ_XCOMP_GUEST_PERM) 
changes what host userspace can/can't do.  It would be easier if we 
could just say that KVM_GET_SUPPORTED_CPUID returns "the most" that 
userspace can do, but we already have the contract that userspace can
take KVM_GET_SUPPORTED_CPUID and pass it straight to KVM_SET_CPUID2.

Therefore,  KVM_GET_SUPPORTED_CPUID must limit its returned values to 
what has already been enabled.

While reviewing the QEMU part of AMX support (this morning), I also 
noticed that there is no equivalent for guest permissions of 
ARCH_GET_XCOMP_SUPP.  This needs to know KVM's supported_xcr0, so it's 
probably best realized as a new KVM_CHECK_EXTENSION rather than as an 
arch_prctl.

Paolo

>> - __do_cpuid_func
> 
> Reporting what KVM supports to host userspace.
> 
>> - kvm_mpx_supported
> 
> This is a check on host support.
> 
>> - kvm_vcpu_ioctl_x86_set_xsave
> 
> "write" from host userspace.
> 
>> Have you identified all their areas of use ?
> 

