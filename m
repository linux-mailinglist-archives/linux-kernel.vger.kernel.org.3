Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBD2498194
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237864AbiAXOAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:00:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21299 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237854AbiAXOAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:00:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643032810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SPUOW8uGzOaBnPqkdCVGj414reOKu6Qs0f5WCNo4Sjg=;
        b=VeX2BIHrsSdtIb07/HHm+MJaPWm7mDegYcke6xTnQQZLhiT3U8Eqi+0ag1KKFd/OQrNxvM
        Q72tCbwlG3uFkCfo5mceomtpbWo1HdxNCMUgbu62+78wTG8oniCVOPhrLEgdLSe7I0hWWP
        jC8+tYWLS+v2dwyzkxkhd2Exc8tIeHM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-4P1rSw53OUWDZaZwHiWBVw-1; Mon, 24 Jan 2022 09:00:08 -0500
X-MC-Unique: 4P1rSw53OUWDZaZwHiWBVw-1
Received: by mail-ed1-f71.google.com with SMTP id h21-20020aa7c955000000b0040390b2bfc5so13138443edt.15
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 06:00:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SPUOW8uGzOaBnPqkdCVGj414reOKu6Qs0f5WCNo4Sjg=;
        b=zQrJMPUPHyHCJcdULM6PRfrpseoi09TEN0/on273HHNfaRC5u2s9YCuWEMegoMhKhZ
         IdxaLsLVhQrG69gaBBOvg0s0JiFEnHM5eWDgZyQMXTeF/AP8EPilhbD18gqKhSn8FlRu
         gnTvybU63pIBma1zwUl7jVvqJcxVY7/LmHXTNwv+xBhs2XsUzOr1GCKdhwitkaJux8DG
         nCYc68AITDhvJpBxIuOtapQTc0SpGloDj+uNODdm3r7qUY4+xRijXTfbw08ENm/Q4wg4
         p9+Q17C3L/kGLlCXs0pBZmgmNEl1HVpnov3hIYmEAXxVN0SrAY5emOKuuFh1SRNNDuCt
         jm+Q==
X-Gm-Message-State: AOAM531uLB50n4TwjBGKSFcGmn2CA92mpdXYrGmgEBIrPnkbLFjgRJs1
        zv/pxjDKInJF4szfRdcQIJ1FAK/5lPqxiBw5umxvPQ52RHup+4KYbza1tGc5YiHNqg8l5E0APCG
        T4ddCWwknENNYbIb4nUMqaAER
X-Received: by 2002:aa7:c941:: with SMTP id h1mr16027027edt.319.1643032806982;
        Mon, 24 Jan 2022 06:00:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJza2S2Z2pNL/ZTCfC3bDTrVnvqz7iFrBysOjazndMzlCP6B/quM7sFTr3eiAnJp2HFdpgNA6Q==
X-Received: by 2002:aa7:c941:: with SMTP id h1mr16027001edt.319.1643032806779;
        Mon, 24 Jan 2022 06:00:06 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id dc24sm4894716ejb.201.2022.01.24.06.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 06:00:06 -0800 (PST)
Message-ID: <f4ddcedc-4a81-4f4e-f3f4-8388120a0776@redhat.com>
Date:   Mon, 24 Jan 2022 15:00:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] KVM: x86/cpuid: Exclude unpermitted xfeatures sizes at
 KVM_GET_SUPPORTED_CPUID
Content-Language: en-US
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Tian Kevin <kevin.tian@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220124080251.60558-1-likexu@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220124080251.60558-1-likexu@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/22 09:02, Like Xu wrote:
>   	case 0xd: {
> -		u64 guest_perm = xstate_get_guest_group_perm();
> +		u64 supported_xcr0 = supported_xcr0 & xstate_get_guest_group_perm();
>   
> -		entry->eax &= supported_xcr0 & guest_perm;
> +		entry->eax &= supported_xcr0;
>   		entry->ebx = xstate_required_size(supported_xcr0, false);
>   		entry->ecx = entry->ebx;
> -		entry->edx &= (supported_xcr0 & guest_perm) >> 32;
> +		entry->edx &= supported_xcr0 >> 32;
>   		if (!supported_xcr0)
>   			break;
>   

No, please don't use this kind of shadowing.  I'm not even sure it
works, and one would have to read the C standard or look at the
disassembly to be sure.  Perhaps this instead could be an idea:

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 3dcd58a138a9..03deb51d8d18 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -887,13 +887,14 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
  		}
  		break;
  	case 0xd: {
-		u64 supported_xcr0 = supported_xcr0 & xstate_get_guest_group_perm();
+		u64 permitted_xcr0 = supported_xcr0 & xstate_get_guest_group_perm();
  
-		entry->eax &= supported_xcr0;
-		entry->ebx = xstate_required_size(supported_xcr0, false);
+#define supported_xcr0 DO_NOT_USE_ME
+		entry->eax &= permitted_xcr0;
+		entry->ebx = xstate_required_size(permitted_xcr0, false);
  		entry->ecx = entry->ebx;
-		entry->edx &= supported_xcr0 >> 32;
-		if (!supported_xcr0)
+		entry->edx &= permitted_xcr0 >> 32;
+		if (!permitted_xcr0)
  			break;
  
  		entry = do_host_cpuid(array, function, 1);
@@ -902,7 +903,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
  
  		cpuid_entry_override(entry, CPUID_D_1_EAX);
  		if (entry->eax & (F(XSAVES)|F(XSAVEC)))
-			entry->ebx = xstate_required_size(supported_xcr0 | supported_xss,
+			entry->ebx = xstate_required_size(permitted_xcr0 | supported_xss,
  							  true);
  		else {
  			WARN_ON_ONCE(supported_xss != 0);
@@ -913,7 +914,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
  
  		for (i = 2; i < 64; ++i) {
  			bool s_state;
-			if (supported_xcr0 & BIT_ULL(i))
+			if (permitted_xcr0 & BIT_ULL(i))
  				s_state = false;
  			else if (supported_xss & BIT_ULL(i))
  				s_state = true;
@@ -942,6 +943,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
  			entry->edx = 0;
  		}
  		break;
+#undef supported_xcr0
  	}
  	case 0x12:
  		/* Intel SGX */

or alternatively add

	u64 permitted_xss = supported_xss;

so that you use "permitted" consistently.  Anybody can vote on what they
prefer (including "permitted_xcr0" and no #define/#undef).

Paolo

