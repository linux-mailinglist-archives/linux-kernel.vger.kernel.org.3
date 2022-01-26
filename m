Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23BB49D068
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243573AbiAZRIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:08:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:46734 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243408AbiAZRIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:08:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643216924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rM1hDBr+ava8RdEGSBdGsJeEePGz4uqrMVillmYDZl0=;
        b=WXdm6CErF+2/rJ/fhz/TqX9S8XbAWl8v4jIEgQswcmk9hYXUIk5vGS6xu96/ryEC0pgnX7
        zsGt+NC+V+ovSJJqDnWAEGtGfD5aKE9WtD7ZLTRBE6jShFlD6M6lUtsuu+uwW+ZtjXRsn3
        KJaE7wmcECBcSkLlJZ1hjQw6xnfuaz4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-9171GsW3MPevHg4g5ioLcA-1; Wed, 26 Jan 2022 12:08:43 -0500
X-MC-Unique: 9171GsW3MPevHg4g5ioLcA-1
Received: by mail-ej1-f72.google.com with SMTP id v2-20020a1709062f0200b006a5f725efc1so5191285eji.23
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:08:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rM1hDBr+ava8RdEGSBdGsJeEePGz4uqrMVillmYDZl0=;
        b=Vw5qYi4ET/wqM6RRB3/35JNVLmXfYK89r26Mvbywo5jOrtDVSclMNuM2KixW8ngKqG
         3HNUYqRpT2bK7FePDv73nE6YubBRCHDCSMK++4qjFzE+KP78qKOnzmXAQCLVnt7y/6uw
         5cTLWcegD6r8zjYO6sn1v6lJw7CWsiF38KR4mIxJwIEd6Vnpc2gJDsQ2ooMdkQBX9rCI
         Em5ByHv+tSSoVtc+VTVTrHsHThqfAHa+lVErWwXo5Y1fXmm+x90OgqD/Ee/XqyvpoPgo
         SPoxhSgNAaUD4K3QXQV1Lx/dcbTno3JQjCNBSIn7ky4hFQaQtSZ/hMIM8VP4rOJ6frUn
         vCzw==
X-Gm-Message-State: AOAM531PEiFEyKWOJHlG5Ag03ZTlM2fBroF5MyU+0KHRaR5+F2GDJKl/
        3EUqWqxvVekEUQwBqCXpLLrUk2KBOu9cwrLk5n6fHdrUIiuejMsnhFb21lec9+q+r/CpKzS7I4N
        r09OJUGVd1qIcGDGDyqoNhGKY
X-Received: by 2002:a17:907:2cc7:: with SMTP id hg7mr19199261ejc.265.1643216921866;
        Wed, 26 Jan 2022 09:08:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxOxI9156B7TPqslv0PvdSz+7QcMW8S9ozWndpOGSmblc+qLSTa6/X2WUm92iqtfok055zUSw==
X-Received: by 2002:a17:907:2cc7:: with SMTP id hg7mr19199233ejc.265.1643216921590;
        Wed, 26 Jan 2022 09:08:41 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id s7sm7629628ejo.53.2022.01.26.09.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 09:08:40 -0800 (PST)
Message-ID: <e1525696-08b3-dca7-5838-c3d5ef8d1ae8@redhat.com>
Date:   Wed, 26 Jan 2022 18:08:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3] KVM: x86: Sync the states size with the XCR0/IA32_XSS
 at, any time
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Like Xu <like.xu.linux@gmail.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220117082631.86143-1-likexu@tencent.com>
 <f9edf9b5-0f84-a424-f8e9-73cad901d993@redhat.com>
 <eacf3f83-96f5-301e-de54-8a0f6c8f9fe5@gmail.com>
 <YerUQa+SN/xWMhvB@google.com>
 <dc8c75a6-a39f-be1d-6cf3-024b88bdf5fe@gmail.com>
 <YfF4z5ye8YCfoqzJ@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YfF4z5ye8YCfoqzJ@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/22 17:37, Sean Christopherson wrote:
> On Sun, Jan 23, 2022, Like Xu wrote:
>> From: Like Xu <likexu@tencent.com>
>>
>> XCR0 is reset to 1 by RESET but not INIT and IA32_XSS is zeroed by
>> both RESET and INIT. The kvm_set_msr_common()'s handling of MSR_IA32_XSS
>> also needs to update kvm_update_cpuid_runtime(). In the above cases, the
>> size in bytes of the XSAVE area containing all states enabled by XCR0 or
>> (XCRO | IA32_XSS) needs to be updated.
>>
>> For simplicity and consistency, existing helpers are used to write values
>> and call kvm_update_cpuid_runtime(), and it's not exactly a fast path.
>>
>> Fixes: a554d207dc46 ("KVM: X86: Processor States following Reset or INIT")
>> Signed-off-by: Like Xu <likexu@tencent.com>
>> ---
>> v2 -> v3 Changelog:
>> - Apply s/legacy/existing in the commit message; (Sean)
>> - Invoke kvm_update_cpuid_runtime() for MSR_IA32_XSS; (Sean)
>>
>>   arch/x86/kvm/x86.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index 55518b7d3b96..4b509b26d9ab 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -3535,6 +3535,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct
>> msr_data *msr_info)
>>   		if (data & ~supported_xss)
>>   			return 1;
>>   		vcpu->arch.ia32_xss = data;
>> +		kvm_update_cpuid_runtime(vcpu);
>>   		break;
>>   	case MSR_SMI_COUNT:
>>   		if (!msr_info->host_initiated)
>> @@ -11256,7 +11257,7 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>>
>>   		vcpu->arch.msr_misc_features_enables = 0;
>>
>> -		vcpu->arch.xcr0 = XFEATURE_MASK_FP;
>> +		__kvm_set_xcr(vcpu, 0, XFEATURE_MASK_FP);
>>   	}
>>
>>   	/* All GPRs except RDX (handled below) are zeroed on RESET/INIT. */
>> @@ -11273,7 +11274,7 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>>   	cpuid_0x1 = kvm_find_cpuid_entry(vcpu, 1, 0);
>>   	kvm_rdx_write(vcpu, cpuid_0x1 ? cpuid_0x1->eax : 0x600);
>>
>> -	vcpu->arch.ia32_xss = 0;
>> +	__kvm_set_msr(vcpu, MSR_IA32_XSS, 0, true);
> 
> Heh, this now conflicts with a patch Xiaoyao just posted, turns out the SDM was
> wrong.  I think there's also some whitespace change or something that prevents
> this from applying cleanly.  For convenience, I'll post a miniseries with this
> and Xiaoyao's patch.
> 
> [*] https://lore.kernel.org/all/20220126034750.2495371-1-xiaoyao.li@intel.com

It's okay, fixing the conflict in Xiaoyao's patch is trivial 
and---anyway---KVM does not support XSS != 0 for now so his patch 
doesn't really have any practical effect.

Like's patch queued, thanks.

Paolo

