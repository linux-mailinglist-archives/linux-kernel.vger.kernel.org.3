Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239804964D9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 19:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382069AbiAUSNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 13:13:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24925 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343720AbiAUSNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 13:13:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642788819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IIkvCHpo+x1x5RT7CF3Wr420DAwPu6iEw50LWWzJscw=;
        b=NXWa1LsSdygGQUEwD7r+cREyJwdX6xiRyl8ywJadfTVCYTxoLVUPNx8d9BhZF7ULGzfPB4
        lSgXSV8GI8Od7T3z/isal1BUfDDPEKDZsuULSbtrkchLCIAnQLzAGGDOBQkLmNfjAu50S/
        opkTr8DLWtTCmyWVoOZvPrJoL7sPR8o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-kkOLBw-XMXutwb6A7U6ZEA-1; Fri, 21 Jan 2022 13:13:37 -0500
X-MC-Unique: kkOLBw-XMXutwb6A7U6ZEA-1
Received: by mail-wm1-f69.google.com with SMTP id o193-20020a1ca5ca000000b0034d78423625so8697609wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 10:13:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IIkvCHpo+x1x5RT7CF3Wr420DAwPu6iEw50LWWzJscw=;
        b=fobiZf4oZT7U1y3LkkYEpcSAuccxvsgrnv/8IeclMjRnOyNSJqVVLZKm/MM5E1cLet
         0kcvWA+tqBZdhGD5PwCFBeCbpyzXglYfIwz4kx56m0oyyvNtBMB0cjiSqN7Xp3Fpzrsh
         LdrSx5GDRkmHc6lnhzEeYfOTs/qoo8pzIXJVqqR8TYBaj07tKV6ptIiTAyOcVreyt91x
         88u+vOB8hSqfFPPpz+4O0c/xCUeeA7QaQzceTZFhJyWIK526ExskyKbO6r0uKrReG8op
         KeIrWOtd/boFmtMynVcYS5ujTJ+WqGD9vXuPxy9I92sGyZMTm9YZx58zgb6JQkzoPMm/
         c+zw==
X-Gm-Message-State: AOAM530Od30OePlmJSKUqYKXcLZquXZCNXSW1xzbkUoj9eoocHZMUQbR
        Gzzgwk4Qp3+E5i6v+XXZAhZIV4g86U8k6POtEvoQ4EoXAfXi9aXREdR6RdhjxUGWaCJcGBrsIvK
        EoE/SzaIfplANDAWlctesvG9A
X-Received: by 2002:a5d:6251:: with SMTP id m17mr4776583wrv.49.1642788816494;
        Fri, 21 Jan 2022 10:13:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzS8LAJ4MNjMqj+zj+f5/T5STTM3OfpC7F6RtJbxyEQUwOCnAk62xMFsytEcDd6N2aRoXUbhw==
X-Received: by 2002:a5d:6251:: with SMTP id m17mr4776564wrv.49.1642788816281;
        Fri, 21 Jan 2022 10:13:36 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id k16sm6176440wrc.35.2022.01.21.10.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 10:13:35 -0800 (PST)
Message-ID: <2ba86d3f-5ab2-af2f-1f7d-ba2d6b7e78d2@redhat.com>
Date:   Fri, 21 Jan 2022 19:13:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 2/5] KVM: x86: Move CPUID.(EAX=0x12,ECX=1) mangling to
 __kvm_update_cpuid_runtime()
Content-Language: en-US
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20220121132852.2482355-1-vkuznets@redhat.com>
 <20220121132852.2482355-3-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220121132852.2482355-3-vkuznets@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/22 14:28, Vitaly Kuznetsov wrote:
> To support comparing CPUID data update with what's already set for a vCPU
> all mangling needs to happen in __kvm_update_cpuid_runtime(), before
> 'vcpu->arch.cpuid_entries' is updated. CPUID.(EAX=0x12,ECX=1) is currently
> being mangled in kvm_vcpu_after_set_cpuid(), move it to
> __kvm_update_cpuid_runtime(). Split off cpuid_get_supported_xcr0() helper
> as 'vcpu->arch.guest_supported_xcr0' update needs (logically) to stay in
> kvm_vcpu_after_set_cpuid().
> 
> No functional change intended.

Since v3 is already on its way to Linus, I'll merge this patch next week.

Paolo

