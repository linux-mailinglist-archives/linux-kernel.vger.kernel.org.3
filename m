Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7757047862F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 09:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbhLQI2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 03:28:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58923 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233805AbhLQI2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 03:28:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639729690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=26LIJ1YdIsB73eNvPXzazi/kBaf5btKN6tb7Yo1wgdw=;
        b=DX6oml4OvvSEAGq0CZt+6lqvsxVuN7EB7yGU9OXtRwjRLEQ3WTPhZ13wRgFMYKozC/l5Zz
        8Nc7x60obBl85UdDEFpj7Z5YIqjSt9YQ5TwZwxp4T/PmTNEaYeEv9LF4mby6iswUdJmaKs
        Gwc2M8ai5bZUcIIbUpaNoYXo/KChXgY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-209-r-hRNGmiOv65y3OoL-Dudw-1; Fri, 17 Dec 2021 03:28:08 -0500
X-MC-Unique: r-hRNGmiOv65y3OoL-Dudw-1
Received: by mail-wm1-f71.google.com with SMTP id j20-20020a05600c1c1400b00343ad0c4c40so2631920wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 00:28:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=26LIJ1YdIsB73eNvPXzazi/kBaf5btKN6tb7Yo1wgdw=;
        b=v8JSS3u1af0GnbqT78xDaRfa85NVkoJoUcfS/KEcXCa8Ab1BhNttCuOqPVSRyx0nPh
         GlTM9r8K9N+gjh6fcEW4a4deAHwuoe5fv2ABntrYkS7MfS1yV/zjqUErQckmlDSJoaCs
         sFRbtGNHkeWEHjJsxWRiyQkIeIuiYLd96Kt/dei4WhnjIG5kFs6pNee/TyL4o4ZtHMxJ
         K/UzUTiDsYGmXg8t9vtT4zuHgyu74vfCASHff0nORepDhzOgAP9+4G4CFq+TAJMjVz+Y
         L0CIc0OKwsvzuP4+b240uJmnpgVHRUOs2nq7RGFEGGfccKazaf0trUvfbjkpmke+V0ci
         Lbsw==
X-Gm-Message-State: AOAM530poyE2cdVbpZZgoWipt+UfedPbQQdLevFOBL1Dr1r5xh2x94sg
        m7EhyAA4ael0vbdwwNyszXcWLhVqVZ7EEnoLkQSMpw3adHGUWgwfmqiVkSjn29QETrqFrj76TAP
        00vxzlC3dkVx1EKa3j/J8Pp4A
X-Received: by 2002:adf:f10f:: with SMTP id r15mr1465016wro.553.1639729687526;
        Fri, 17 Dec 2021 00:28:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyqmD+ti2U+gXLkJIXbA6dH/cRko3HnTprM5FpnCFB+dff8kIv2MHRCc7cqlV3ofyjCfG18KQ==
X-Received: by 2002:adf:f10f:: with SMTP id r15mr1464998wro.553.1639729687242;
        Fri, 17 Dec 2021 00:28:07 -0800 (PST)
Received: from ?IPV6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.googlemail.com with ESMTPSA id m6sm8866287wrp.34.2021.12.17.00.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 00:28:06 -0800 (PST)
Message-ID: <3c5472f4-44ce-9ba8-4dbc-967ea377ae10@redhat.com>
Date:   Fri, 17 Dec 2021 09:28:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 2/4] RISC-V: KVM: Add VM capability to allow userspace
 get GPA bits
Content-Language: en-US
To:     Anup Patel <anup.patel@wdc.com>, Shuah Khan <shuah@kernel.org>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20211129075451.418122-1-anup.patel@wdc.com>
 <20211129075451.418122-3-anup.patel@wdc.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211129075451.418122-3-anup.patel@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/21 08:54, Anup Patel wrote:
> The number of GPA bits supported for a RISC-V Guest/VM is based on the
> MMU mode used by the G-stage translation. The KVM RISC-V will detect and
> use the best possible MMU mode for the G-stage in kvm_arch_init().
> 
> We add a generic VM capability KVM_CAP_VM_GPA_BITS which can be used by
> the KVM userspace to get the number of GPA (guest physical address) bits
> supported for a Guest/VM.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>   arch/riscv/include/asm/kvm_host.h | 1 +
>   arch/riscv/kvm/mmu.c              | 5 +++++
>   arch/riscv/kvm/vm.c               | 3 +++
>   include/uapi/linux/kvm.h          | 1 +
>   4 files changed, 10 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
> index 37589b953bcb..ae5d238607fe 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -221,6 +221,7 @@ void kvm_riscv_stage2_free_pgd(struct kvm *kvm);
>   void kvm_riscv_stage2_update_hgatp(struct kvm_vcpu *vcpu);
>   void kvm_riscv_stage2_mode_detect(void);
>   unsigned long kvm_riscv_stage2_mode(void);
> +int kvm_riscv_stage2_gpa_size(void);
>   
>   void kvm_riscv_stage2_vmid_detect(void);
>   unsigned long kvm_riscv_stage2_vmid_bits(void);
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 9ffd0255af43..9b6d6465094f 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -760,3 +760,8 @@ unsigned long kvm_riscv_stage2_mode(void)
>   {
>   	return stage2_mode >> HGATP_MODE_SHIFT;
>   }
> +
> +int kvm_riscv_stage2_gpa_size(void)
> +{
> +	return stage2_gpa_bits;
> +}
> diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
> index fb18af34a4b5..6f959639ec45 100644
> --- a/arch/riscv/kvm/vm.c
> +++ b/arch/riscv/kvm/vm.c
> @@ -82,6 +82,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>   	case KVM_CAP_NR_MEMSLOTS:
>   		r = KVM_USER_MEM_SLOTS;
>   		break;
> +	case KVM_CAP_VM_GPA_BITS:
> +		r = kvm_riscv_stage2_gpa_size();
> +		break;
>   	default:
>   		r = 0;
>   		break;
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 1daa45268de2..469f05d69c8d 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1131,6 +1131,7 @@ struct kvm_ppc_resize_hpt {
>   #define KVM_CAP_EXIT_ON_EMULATION_FAILURE 204
>   #define KVM_CAP_ARM_MTE 205
>   #define KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM 206
> +#define KVM_CAP_VM_GPA_BITS 207
>   
>   #ifdef KVM_CAP_IRQ_ROUTING
>   
> 

This is nice and other architectures could support it.

Paolo

