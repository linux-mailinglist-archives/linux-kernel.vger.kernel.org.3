Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798474903E5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238198AbiAQIby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:31:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44199 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232331AbiAQIbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:31:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642408312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kZiUn9HGYMpstUGdIlC1VGh2Ev+eOpvhg6ZsJcnRfGw=;
        b=Vx7KHHb0s+9iWn4D0TL6x2yzhaw119w/EbvOcRg7foyNB8x9yU5bvyYk1RfevSr7vnqCTK
        02owAyX5f8bPnl0M+0MgJt5ncvHf0AKp0vO5TU2MBPk0bbnRkOY3qQBG5V2XBRVDpV1vZq
        2zFO7TkYwwWfCLn1GSbm6f2zjo0E7O4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-576-_lsP_DTVMsKI82DTALvotg-1; Mon, 17 Jan 2022 03:31:49 -0500
X-MC-Unique: _lsP_DTVMsKI82DTALvotg-1
Received: by mail-wm1-f72.google.com with SMTP id s17-20020a7bc0d1000000b00348737ba2a2so10525006wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 00:31:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kZiUn9HGYMpstUGdIlC1VGh2Ev+eOpvhg6ZsJcnRfGw=;
        b=nh0TL4cisPXPjFO9Yc7i5+M7pttQATA+l7hTFfw24GQeZzOxZK6qXR3b+pt4aZ6zzu
         J8HY/7N4JiGtXNk6d4WvP5wSWqzq/Y5KYMJzrC6Ly7PvGedv2aMhNUSVMVlfLWcKqCOL
         8mLxOpjDEV++/bdYr3Mb2LQEhUCDXBeXKzXjcT68+Of36yEZCTSpB7bG/qx0dixoYyUl
         r7rKtq3zcppqiGEF0DylQ+C4jCw136VQBBXH5yU/1uJg50UPcEI8TGiZteBA2KfJnhcC
         FN7+xTxndlojyWZUt8DU2rWaWy6SNxw0KQ1unNOm7xSh7h3M51HGqURkCbTcUD9URQO2
         ozFQ==
X-Gm-Message-State: AOAM530GYj12sdoOYrQsn9o8c9Ayrimly9FRmSqDgzUeuxiIny5ZBXU4
        IfFvG0up4u+wZGgml2U1+9S9aBij4RLxpKyderfAUpsR3jXQ0+ZiXTUNtLwBgLSjKk7enZTgrHf
        b4VJJqghrF+xkjoDityFUwZH/
X-Received: by 2002:a05:6000:1543:: with SMTP id 3mr14327427wry.683.1642408307947;
        Mon, 17 Jan 2022 00:31:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxr9+owYNFGFXo0eIoRWnDYuAoyIH41ad1EUV1B4t5z/hV+sGBIXjK2Tjm/DHQARATtQoXOhQ==
X-Received: by 2002:a05:6000:1543:: with SMTP id 3mr14327410wry.683.1642408307777;
        Mon, 17 Jan 2022 00:31:47 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id 9sm10836521wrb.77.2022.01.17.00.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 00:31:46 -0800 (PST)
Message-ID: <a133d6e2-34de-8a41-475e-3858fc2902bf@redhat.com>
Date:   Mon, 17 Jan 2022 09:31:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] KVM: x86: Fix the #GP(0) and #UD conditions for XSETBV
 emulation
Content-Language: en-US
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220117072456.71155-1-likexu@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220117072456.71155-1-likexu@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/22 08:24, Like Xu wrote:
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 76b4803dd3bd..7d8622e592bb 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1024,7 +1024,11 @@ static int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr)
>   
>   int kvm_emulate_xsetbv(struct kvm_vcpu *vcpu)
>   {
> -	if (static_call(kvm_x86_get_cpl)(vcpu) != 0 ||
> +	if (!guest_cpuid_has(vcpu, X86_FEATURE_XSAVE) ||
> +	    !kvm_read_cr4_bits(vcpu, X86_CR4_OSXSAVE))
> +		return kvm_handle_invalid_op(vcpu);

There's no need to check XSAVE, because it XSAVE=0 will prevent setting 
CR4.OSXSAVE.

Likewise, CPL and SS.DPL are also defined in real mode so there's no 
need to check is_protmode.  The Intel manuals sometimes still act as the 
descriptor caches don't exist, even though VMX effectively made them 
part of the architecture.

Also, the "Fixes" tag is not really correct as the behavior was the same 
before.  Rather, it fixes commit 02d4160fbd76 ("x86: KVM: add xsetbv to 
the emulator", 2019-08-22).  Checking OSXSAVE is a bug in the emulator 
path, even though it's not needed in the XSETBV vmexit case.

Thanks,

Paolo

> +	if ((is_protmode(vcpu) && static_call(kvm_x86_get_cpl)(vcpu) != 0) ||
>   	    __kvm_set_xcr(vcpu, kvm_rcx_read(vcpu), kvm_read_edx_eax(vcpu))) {
>   		kvm_inject_gp(vcpu, 0);
>   		return 1;

