Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A174F4CD0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580053AbiDEXdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389909AbiDENe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 09:34:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C004104A62
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 05:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649162462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iAgWhjRrYpIhx8E90XItBzeThRQ5JiMqIe491O7AfVA=;
        b=RTeLStRBMRUHBXaEEe097sk40fKR4/XvMpIEEkQ+QtAK8kgxIpMpqIbidq0wUfxiavOOO0
        fcqLNwzDngWtu6c/BXvrsM2wEUe7pcyzmwLwdS+d87lGCxPxYVd0D1Yy56qXfr9j7b0/xE
        +9lVVGycUiwHQ7JMN05Kyvs8a+bnp5k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-310-nS_WsDmoMyK4lTSKq77RYQ-1; Tue, 05 Apr 2022 08:41:01 -0400
X-MC-Unique: nS_WsDmoMyK4lTSKq77RYQ-1
Received: by mail-wm1-f72.google.com with SMTP id 189-20020a1c02c6000000b0038e6c4c6472so1291426wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 05:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iAgWhjRrYpIhx8E90XItBzeThRQ5JiMqIe491O7AfVA=;
        b=GDS7yCw5RWTFvOy5d8HN9xBH44/XaJ3xTbB0OPM/kFqs7LmdKlpoVWFQ96qLpbDCrL
         I1P6TMJGCVOD5D/LGhGR46KfY37X22FaW6MO8z3Tux5QY/Pb/5QbXuqjaaLWtgDQdPbU
         NkLPGWnxChWLz7C042oP6hbdSMWBVT71jqeH3uNsqQvETT/lQ86/NMpAr/hAKpDqlYSZ
         lJp21xvmzGkXzo4wSy8HqW7whlhcJiJktTqFputb2iFaHTyZ/PeEVXUS+zFRTKfGKRuv
         tJsFe+pKGrPueUY1/T4e0LMBGKDlMIbCNs/7VZIcOjY1n0adj2mVRWAKiNTYLw9O3Kda
         RU6A==
X-Gm-Message-State: AOAM532P3HL+r9DTE3KSMPThMHJVv3/GDpjoqLIgfZD+XW83QYaWjtIx
        PdQISAFaynN0iHoYKS8l/wWlpldOZH7Th4QJfGUQ//6PbBUEQ85dqskCAUsHJv4TICe5HbBUDon
        vdC0oYl3+QbCkxSu/Y/5hzRZ1
X-Received: by 2002:a05:600c:3ca7:b0:38e:50d2:27fe with SMTP id bg39-20020a05600c3ca700b0038e50d227femr2975268wmb.159.1649162460264;
        Tue, 05 Apr 2022 05:41:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7XSgpiU5Q0NcEbeo/UDtUNiygqgEZ3cIbl0PjhHRkwLB8zLMXnA0rseu9YHs+ssjUiCngZQ==
X-Received: by 2002:a05:600c:3ca7:b0:38e:50d2:27fe with SMTP id bg39-20020a05600c3ca700b0038e50d227femr2975243wmb.159.1649162460003;
        Tue, 05 Apr 2022 05:41:00 -0700 (PDT)
Received: from [10.32.181.87] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.googlemail.com with ESMTPSA id p18-20020a1c5452000000b0038e70261309sm2147830wmi.1.2022.04.05.05.40.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 05:40:59 -0700 (PDT)
Message-ID: <9a319273-b2ed-2eb7-a00d-3c46588e45d8@redhat.com>
Date:   Tue, 5 Apr 2022 14:40:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v5 021/104] KVM: x86: Introduce hooks to free VM
 callback prezap and vm_free
Content-Language: en-US
To:     isaku.yamahata@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@gmail.com, Jim Mattson <jmattson@google.com>,
        erdemaktas@google.com, Connor Kuehl <ckuehl@redhat.com>,
        Sean Christopherson <seanjc@google.com>
References: <cover.1646422845.git.isaku.yamahata@intel.com>
 <af18a5c763a78af2b7de6e6e0841d9e61a571dc4.1646422845.git.isaku.yamahata@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <af18a5c763a78af2b7de6e6e0841d9e61a571dc4.1646422845.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/22 20:48, isaku.yamahata@intel.com wrote:
> From: Kai Huang <kai.huang@intel.com>
> 
> Before tearing down private page tables, TDX requires some resources of the
> guest TD to be destroyed (i.e. keyID must have been reclaimed, etc).  Add
> prezap callback before tearing down private page tables for it.
> 
> TDX needs to free some resources after other resources (i.e. vcpu related
> resources).  Add vm_free callback at the end of kvm_arch_destroy_vm().
> 
> Signed-off-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---
>   arch/x86/include/asm/kvm-x86-ops.h | 2 ++
>   arch/x86/include/asm/kvm_host.h    | 2 ++
>   arch/x86/kvm/x86.c                 | 8 ++++++++
>   3 files changed, 12 insertions(+)
> 
> diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
> index 8125d43d3566..ef48dcc98cfc 100644
> --- a/arch/x86/include/asm/kvm-x86-ops.h
> +++ b/arch/x86/include/asm/kvm-x86-ops.h
> @@ -20,7 +20,9 @@ KVM_X86_OP(has_emulated_msr)
>   KVM_X86_OP(vcpu_after_set_cpuid)
>   KVM_X86_OP(is_vm_type_supported)
>   KVM_X86_OP(vm_init)
> +KVM_X86_OP_NULL(mmu_prezap)
>   KVM_X86_OP_NULL(vm_destroy)
> +KVM_X86_OP_NULL(vm_free)
>   KVM_X86_OP(vcpu_create)
>   KVM_X86_OP(vcpu_free)
>   KVM_X86_OP(vcpu_reset)
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 8de357a9ad30..5ff7a0fba311 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1326,7 +1326,9 @@ struct kvm_x86_ops {
>   	bool (*is_vm_type_supported)(unsigned long vm_type);
>   	unsigned int vm_size;
>   	int (*vm_init)(struct kvm *kvm);
> +	void (*mmu_prezap)(struct kvm *kvm);
>   	void (*vm_destroy)(struct kvm *kvm);
> +	void (*vm_free)(struct kvm *kvm);
>   
>   	/* Create, but do not attach this VCPU */
>   	int (*vcpu_create)(struct kvm_vcpu *vcpu);
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index f6438750d190..a48f5c69fadb 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -11779,6 +11779,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
>   	kvm_page_track_cleanup(kvm);
>   	kvm_xen_destroy_vm(kvm);
>   	kvm_hv_destroy_vm(kvm);
> +	static_call_cond(kvm_x86_vm_free)(kvm);
>   }
>   
>   static void memslot_rmap_free(struct kvm_memory_slot *slot)
> @@ -12036,6 +12037,13 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>   
>   void kvm_arch_flush_shadow_all(struct kvm *kvm)
>   {
> +	/*
> +	 * kvm_mmu_zap_all() zaps both private and shared page tables.  Before
> +	 * tearing down private page tables, TDX requires some TD resources to
> +	 * be destroyed (i.e. keyID must have been reclaimed, etc).  Invoke
> +	 * kvm_x86_mmu_prezap() for this.
> +	 */
> +	static_call_cond(kvm_x86_mmu_prezap)(kvm);
>   	kvm_mmu_zap_all(kvm);

Please rename the hook to (*flush_shadow_all_private).

Otherwise ok,

Paolo

>   }
>   

