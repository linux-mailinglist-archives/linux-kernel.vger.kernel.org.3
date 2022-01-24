Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619A34981A6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238198AbiAXODC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:03:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51437 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238170AbiAXODB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:03:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643032980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=71OMRwnzQ9vcWo2Yl4uI77rVjb7JJPzSN8H73qAHNAM=;
        b=IGVVojc6B3OOfbbJBT8nemgzAeUdufOlt5N0fQ1MV4Z/zsmME+wbj7Gy2mL5shJ9Jv9RNm
        GncpCeTOjSROBOuIgjUgU/m0AG6AKNPWn+hQjMrbWeNKr3ZwTlFbEGd8hXgHfpl+2EYAKg
        Js9A+ZciJJe6lXXGdymNzOT8bufrYqs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-457-wk85KERQO5OtLdVqm8H1iA-1; Mon, 24 Jan 2022 09:02:59 -0500
X-MC-Unique: wk85KERQO5OtLdVqm8H1iA-1
Received: by mail-ed1-f69.google.com with SMTP id el8-20020a056402360800b00403bbdcef64so13144241edb.14
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 06:02:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=71OMRwnzQ9vcWo2Yl4uI77rVjb7JJPzSN8H73qAHNAM=;
        b=e5RPBsfDIiggbdB1gn8xN165B3iQRWFCpvazDlJ5VnUaZRJycdhiTo27qmaCCpTRbY
         Ibe4CqmtZsT02P3R4kvV7wj+xoXEKrZE5UnweNFsvIlqb+8/XAM5ll5aHahcY8QT1gQ0
         t1EoU2mzmYRP22/BX3AjNV+R+qpqcILIENE/HLn/+/y1j/Hl3Q5vi65+tviSJCSLy2uC
         xfaCF4SogA84i3NNyvTiGMK8d0Tck5g5oTFB77NcHNCQ+QTnHMNMCt39T5ew8f2p2HAF
         noWPNdRNS/rJjQkOHNvqN9ROj5p/stmg2fa+N244XJp0YCzkS/jhF0OenhNWPADR5pNd
         KZhQ==
X-Gm-Message-State: AOAM530I0OmIUBvZ0Hbdkjpj3BcA24JzxuN0pyEfvhp5iOI3WG5T2po2
        3Kt3P0/ZpaHev6V9ZyQMC8UYo8gGabH41Ci9rmK5pOFB6u6aZyL26H9n386XPYEXCHz2phNvXwj
        wdCNDjQjQ8/gUrfR95SlnEAm4
X-Received: by 2002:a17:907:1dca:: with SMTP id og10mr12455505ejc.597.1643032977606;
        Mon, 24 Jan 2022 06:02:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy11cY4vuoXAFcdU3X4chXiK6B8Sc/D3PyYzvkaZgkot9ZWTWlk6b1fVKjCWPAXjduQeca55Q==
X-Received: by 2002:a17:907:1dca:: with SMTP id og10mr12455484ejc.597.1643032977329;
        Mon, 24 Jan 2022 06:02:57 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id f19sm4932863ejb.0.2022.01.24.06.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 06:02:56 -0800 (PST)
Message-ID: <95f63ed6-743b-3547-dda1-4fe83bc39070@redhat.com>
Date:   Mon, 24 Jan 2022 15:02:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/2] KVM: x86: Use memcmp in kvm_cpuid_check_equal()
Content-Language: en-US
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20220124103606.2630588-1-vkuznets@redhat.com>
 <20220124103606.2630588-3-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220124103606.2630588-3-vkuznets@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/22 11:36, Vitaly Kuznetsov wrote:
> kvm_cpuid_check_equal() should also check .flags equality but instead
> of adding it to the existing check, just switch to using memcmp() for
> the whole 'struct kvm_cpuid_entry2'.
> 
> When .flags are not checked, kvm_cpuid_check_equal() may allow an update
> which it shouldn't but kvm_set_cpuid() does not actually update anything
> and just returns success.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>   arch/x86/kvm/cpuid.c | 13 ++-----------
>   1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 89d7822a8f5b..7dd9c8f4f46e 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -123,20 +123,11 @@ static int kvm_check_cpuid(struct kvm_vcpu *vcpu,
>   static int kvm_cpuid_check_equal(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
>   				 int nent)
>   {
> -	struct kvm_cpuid_entry2 *orig;
> -	int i;
> -
>   	if (nent != vcpu->arch.cpuid_nent)
>   		return -EINVAL;
>   
> -	for (i = 0; i < nent; i++) {
> -		orig = &vcpu->arch.cpuid_entries[i];
> -		if (e2[i].function != orig->function ||
> -		    e2[i].index != orig->index ||
> -		    e2[i].eax != orig->eax || e2[i].ebx != orig->ebx ||
> -		    e2[i].ecx != orig->ecx || e2[i].edx != orig->edx)
> -			return -EINVAL;
> -	}
> +	if (memcmp(e2, vcpu->arch.cpuid_entries, nent * sizeof(*e2)))
> +		return -EINVAL;

Hmm, not sure about that due to the padding in struct kvm_cpuid_entry2. 
  It might break userspace that isn't too careful about zeroing it.

Queued patch 1 though.

Paolo

