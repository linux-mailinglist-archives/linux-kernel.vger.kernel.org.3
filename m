Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A700498329
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240523AbiAXPKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:10:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21280 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240565AbiAXPKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:10:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643037029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oC+kZYxunT62Tn6ecl24Q4N+v2y0DrmKFuUG0aDL2m4=;
        b=LG8umBlCXVYyOOcAUDpEToxDPLcqmuw0DbpEJ36gF9uMBeCPrrvqzfHXYITp/99kwvvFhA
        Eqf8W6KJrtjgbcg6wDzhyv5PugjQugHjJ6aMV/Jn1S/5kNpMrRH0DsLi3qIldgUtxRS1Ng
        Wf79AMwZgrkilgft9bbx6AtSeDq7pv4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-56-ss1xyaWAMqyUVYp-DSiZKQ-1; Mon, 24 Jan 2022 10:10:25 -0500
X-MC-Unique: ss1xyaWAMqyUVYp-DSiZKQ-1
Received: by mail-wr1-f72.google.com with SMTP id d24-20020adf9b98000000b001d81899a728so2001760wrc.19
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 07:10:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=oC+kZYxunT62Tn6ecl24Q4N+v2y0DrmKFuUG0aDL2m4=;
        b=YGS4dVdpSK7l0Is0fFCFgg0mwnhM5jq7CMAK/Y7kyersaU9vNT+vsB8qTUxumUwtQa
         qAVRT3ViukIjfF5xXXDg+2LhtZfW7uq5T2emnRyobhdM82GuzT7493nKl0Q5D3ipByY6
         nsOUb/bNFZTRNzyAancsytB8J1bboBzvx75jf2L9EGUwk0JwlAsR9LO0jy/4KCV190Dh
         uK1fyyOQgTtvdFD6s4wr5k9QKyoL49kwmz5fD+z1gchEzz/1+lGECLIcNSjSamfeJgRB
         6PoiwdgSU8AMUPPAN/I9WEdtYBxxP/BNqPiCzJqF9cmvTzpgD2s3P8UXShdiWm0M1TFG
         4QNQ==
X-Gm-Message-State: AOAM532JA0qO6wi1WL5Q4vraHyQlfLhNYZR3bmUC68ZaxIQZHxrxLBKm
        Whspy052EDa7gR4HFj7zSiJ8aBA7kQcSUCdTwmzJG5vDAq6gvZEo3t6LZCpXK3YGInwy/gy4jvn
        p+qnvi8XKBgmHRRgxZ0CfSp1p/4C1Y9K1nPLnzd62Q2SrC/Ohnmgh7TmWI6rmDqP3dLArvJYGLj
        qu
X-Received: by 2002:a1c:9a14:: with SMTP id c20mr2210888wme.146.1643037024045;
        Mon, 24 Jan 2022 07:10:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxU2vLVGgQ3gVv+oBMMqqPhsunml8TDWg+adWMY6Ne+76AVF+o5GKjix3JCNDuzORVGJb19Aw==
X-Received: by 2002:a1c:9a14:: with SMTP id c20mr2210870wme.146.1643037023769;
        Mon, 24 Jan 2022 07:10:23 -0800 (PST)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id b62sm12934670wmb.16.2022.01.24.07.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 07:10:23 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: x86: Use memcmp in kvm_cpuid_check_equal()
In-Reply-To: <95f63ed6-743b-3547-dda1-4fe83bc39070@redhat.com>
References: <20220124103606.2630588-1-vkuznets@redhat.com>
 <20220124103606.2630588-3-vkuznets@redhat.com>
 <95f63ed6-743b-3547-dda1-4fe83bc39070@redhat.com>
Date:   Mon, 24 Jan 2022 16:10:22 +0100
Message-ID: <87bl01i2zl.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 1/24/22 11:36, Vitaly Kuznetsov wrote:
>> kvm_cpuid_check_equal() should also check .flags equality but instead
>> of adding it to the existing check, just switch to using memcmp() for
>> the whole 'struct kvm_cpuid_entry2'.
>> 
>> When .flags are not checked, kvm_cpuid_check_equal() may allow an update
>> which it shouldn't but kvm_set_cpuid() does not actually update anything
>> and just returns success.
>> 
>> Suggested-by: Sean Christopherson <seanjc@google.com>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>   arch/x86/kvm/cpuid.c | 13 ++-----------
>>   1 file changed, 2 insertions(+), 11 deletions(-)
>> 
>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>> index 89d7822a8f5b..7dd9c8f4f46e 100644
>> --- a/arch/x86/kvm/cpuid.c
>> +++ b/arch/x86/kvm/cpuid.c
>> @@ -123,20 +123,11 @@ static int kvm_check_cpuid(struct kvm_vcpu *vcpu,
>>   static int kvm_cpuid_check_equal(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
>>   				 int nent)
>>   {
>> -	struct kvm_cpuid_entry2 *orig;
>> -	int i;
>> -
>>   	if (nent != vcpu->arch.cpuid_nent)
>>   		return -EINVAL;
>>   
>> -	for (i = 0; i < nent; i++) {
>> -		orig = &vcpu->arch.cpuid_entries[i];
>> -		if (e2[i].function != orig->function ||
>> -		    e2[i].index != orig->index ||
>> -		    e2[i].eax != orig->eax || e2[i].ebx != orig->ebx ||
>> -		    e2[i].ecx != orig->ecx || e2[i].edx != orig->edx)
>> -			return -EINVAL;
>> -	}
>> +	if (memcmp(e2, vcpu->arch.cpuid_entries, nent * sizeof(*e2)))
>> +		return -EINVAL;
>
> Hmm, not sure about that due to the padding in struct kvm_cpuid_entry2. 
>   It might break userspace that isn't too careful about zeroing it.

FWIW, QEMU zeroes the whole thing before setting individual CPUID
entries. Legacy KVM_SET_CPUID call is also not afffected as it copies
entries to a newly allocated "struct kvm_cpuid_entry2[]" and explicitly
zeroes padding.

Do we need to at least add a check for ".flags"?

>
> Queued patch 1 though.
>
> Paolo
>

-- 
Vitaly

