Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD64F573A67
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236943AbiGMPpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiGMPp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:45:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C1864D4D1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657727127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZVY0K5yxBZ9KDDh5Uo4Ad2ghdbNkYwOVyUboikxAno4=;
        b=Gvgcq+J9m/4wb9NF53+gh+GCkfooLFdXWUGtjGaSnL4HWxSvoHbgd/EjYQw9Xa1CBovi+Z
        k4vEStkTEstKEOG2cu1iYs23kCEsu+FzZ4hywVii/jY+kbfCyh2atbIUYEpBbyC/Gv/vOx
        B3IQ4osTNZQ+d9iOsInVC6/ykldGUik=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-98-UO80WnJrNv6WRbm3kyh4sQ-1; Wed, 13 Jul 2022 11:45:26 -0400
X-MC-Unique: UO80WnJrNv6WRbm3kyh4sQ-1
Received: by mail-ed1-f70.google.com with SMTP id t5-20020a056402524500b0043a923324b2so8739295edd.22
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ZVY0K5yxBZ9KDDh5Uo4Ad2ghdbNkYwOVyUboikxAno4=;
        b=6cEjQ08kbWDu02qhQS925sVfOqAzdMvu4aM8Q51gyqVKK7y9KbHGU1ou0orput5bs0
         9BMIFUMPvxd+zNCnx6YEoKLUej4GJ+ImEZdCnCGbuIndNdZE3nQ1wdnKTQ4M/cRNKKc4
         YZnKAh1Faixkbh7kDGFBfxX+g65r11Jc684L06QXJuLV1CdL9Sf7BLUr0dbBHZ9KNKdz
         vC4XHKqiCFzTnVzVebJgFwwOHsaZcSQ7wnKUjKFlOeKlAwqTYlVXuz1gd48DJePc/4N3
         /EIWs04AdJTy2SEQuBsmVJPcRLwhyGE4oZPia9hnRA3UM9gZYNjVm7glV3Q/sYxZ2Y/D
         7oyQ==
X-Gm-Message-State: AJIora8zMXUgq40FVIZ+baSpsU4TZuNj1pxiLYMJIpklDBuAo9mvzG8J
        rdxIjjmyqWFqgYaciw8UgiACfZS1UYAW+TGqcEt5lt1VEiUrDW1MYVNtsbkWCx6cPQp8hb7AbDf
        muzVfIgyH4HNTW3dWRlPTjzCk
X-Received: by 2002:aa7:df12:0:b0:43a:4991:1725 with SMTP id c18-20020aa7df12000000b0043a49911725mr5915127edy.55.1657727125227;
        Wed, 13 Jul 2022 08:45:25 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vqywBIarKeBDvJ/Os4B4nmMtiJdv7n72OU8I7PEmJFEsDhEcFdrgUnpf9fyhglCvafO0VOnw==
X-Received: by 2002:aa7:df12:0:b0:43a:4991:1725 with SMTP id c18-20020aa7df12000000b0043a49911725mr5915114edy.55.1657727125070;
        Wed, 13 Jul 2022 08:45:25 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id o2-20020aa7dd42000000b0043ad162b5e3sm5991517edw.18.2022.07.13.08.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 08:45:24 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v3 06/25] KVM: x86: hyper-v: Cache
 HYPERV_CPUID_NESTED_FEATURES CPUID leaf
In-Reply-To: <26e7784ff4ee91a8d41d217dcb5f3e0e0ce6e470.camel@redhat.com>
References: <20220708144223.610080-1-vkuznets@redhat.com>
 <20220708144223.610080-7-vkuznets@redhat.com>
 <26e7784ff4ee91a8d41d217dcb5f3e0e0ce6e470.camel@redhat.com>
Date:   Wed, 13 Jul 2022 17:45:23 +0200
Message-ID: <87k08hnhik.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxim Levitsky <mlevitsk@redhat.com> writes:

> On Fri, 2022-07-08 at 16:42 +0200, Vitaly Kuznetsov wrote:
>> KVM has to check guest visible HYPERV_CPUID_NESTED_FEATURES.EBX CPUID
>> leaf to know with Enlightened VMCS definition to use (original or 2022
>> update). Cache the leaf along with other Hyper-V CPUID feature leaves
>> to make the check quick.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/include/asm/kvm_host.h | 2 ++
>>  arch/x86/kvm/hyperv.c           | 9 +++++++++
>>  2 files changed, 11 insertions(+)
>> 
>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>> index de5a149d0971..077ec9cf3169 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -616,6 +616,8 @@ struct kvm_vcpu_hv {
>>  		u32 enlightenments_eax; /* HYPERV_CPUID_ENLIGHTMENT_INFO.EAX */
>>  		u32 enlightenments_ebx; /* HYPERV_CPUID_ENLIGHTMENT_INFO.EBX */
>>  		u32 syndbg_cap_eax; /* HYPERV_CPUID_SYNDBG_PLATFORM_CAPABILITIES.EAX */
>> +		u32 nested_eax; /* HYPERV_CPUID_NESTED_FEATURES.EAX */
>> +		u32 nested_ebx; /* HYPERV_CPUID_NESTED_FEATURES.EBX */
>>  	} cpuid_cache;
>>  };
>>  
>> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
>> index e08189211d9a..b666902da4d9 100644
>> --- a/arch/x86/kvm/hyperv.c
>> +++ b/arch/x86/kvm/hyperv.c
>> @@ -2030,6 +2030,15 @@ void kvm_hv_set_cpuid(struct kvm_vcpu *vcpu)
>>  		hv_vcpu->cpuid_cache.syndbg_cap_eax = entry->eax;
>>  	else
>>  		hv_vcpu->cpuid_cache.syndbg_cap_eax = 0;
>> +
>> +	entry = kvm_find_cpuid_entry(vcpu, HYPERV_CPUID_NESTED_FEATURES, 0);
>> +	if (entry) {
>> +		hv_vcpu->cpuid_cache.nested_eax = entry->eax;
>> +		hv_vcpu->cpuid_cache.nested_ebx = entry->ebx;
>> +	} else {
>> +		hv_vcpu->cpuid_cache.nested_eax = 0;
>> +		hv_vcpu->cpuid_cache.nested_ebx = 0;
>> +	}
>>  }
>>  
>>  int kvm_hv_set_enforce_cpuid(struct kvm_vcpu *vcpu, bool enforce)
>
>
> Small Nitpick:
>
> If I understand correctly, the kvm_find_cpuid_entry can fail if the userspace didn't provide the
> cpuid entry.
>
> Since the code that deals with failback is now repeated 3 times, how about some wrapper function that
> will return all zeros for a non present cpuid entry?

I've opted for wiping the whole hv_vcpu->cpuid_cache with memset(), this
way we don't even need a new helper.

-- 
Vitaly

