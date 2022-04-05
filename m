Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080044F46E6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377030AbiDEUwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389673AbiDENeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 09:34:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13943137F43
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 05:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649162398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ye4ZaW/ItY5DViRmitahbrOWzYkgcy+w01IKjssfwqM=;
        b=MMOC/a+A71jmqUg4ovauivV8zzYtfuWzePvYS7vsFtuu9n68D2UYsFdsB/wndd4CU2Y1pf
        b+Qp1hI0JJ0d9/fUo0eD43KK4YR/pGlbbNIOw/lhmqQSGZWzBBKPx0Q60iAKjOE9OxLRx3
        CUfzSDU4wN3qrTjrdfiLvNrFgHMjA24=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-oTFMImcwO5qB74yxuvRuxg-1; Tue, 05 Apr 2022 08:39:55 -0400
X-MC-Unique: oTFMImcwO5qB74yxuvRuxg-1
Received: by mail-wm1-f71.google.com with SMTP id f19-20020a7bcd13000000b0038c01defd5aso1191616wmj.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 05:39:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ye4ZaW/ItY5DViRmitahbrOWzYkgcy+w01IKjssfwqM=;
        b=pFGGnZ3ixdVYD7zf+FQjcEUeHXzSuzr03uAa3/HtdJEbPGnwctGId2dUSiyfjmKYal
         FBLIKjkToY+IWQzCzv7iPr/tYdQ4gEoJXEZF5/YZ62c684hzQZobef07DphUmdDczv/U
         dKIk/agylbOXD00sykz/puJ88j0tI7OXlM50ZaazBiEyOQ5Cqq9AgAFdT8DJJIHvZXpa
         2gc125AISGKaPyeLXhZQGC4AoqXFZVOZhjgvYRTtOA5FWtoMyyTwO6u868jhkLw+IhCs
         pv1mpXqLNV133w3woPQrsWJSWFBvcmAyUMEY/+EdMiMSLtvPKdlm9KMlNbtIBtvQKpWo
         J37Q==
X-Gm-Message-State: AOAM533AzXS9VeK8mSnAkJPhIvULCKhAWpZqqDk9uQGbFS9AebAVwKOA
        OmhDJQZxfUzEVAC/0ijjVAXucbYwZCU61nFtk6hZUA0MqzWIDEgmIVc6+dGsR1ykM7ATxbdPzlD
        SxnsjCGPAw3r9UiKdjJV5tmYT
X-Received: by 2002:adf:e582:0:b0:206:fcf:8eb3 with SMTP id l2-20020adfe582000000b002060fcf8eb3mr2720024wrm.517.1649162393891;
        Tue, 05 Apr 2022 05:39:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlo0bj2jutu52YWf8gdKhedE/z/VWmesp/G1YrMVbP8ucNmMKxfYc9MxKHXr/mNZGwYksxog==
X-Received: by 2002:adf:e582:0:b0:206:fcf:8eb3 with SMTP id l2-20020adfe582000000b002060fcf8eb3mr2720009wrm.517.1649162393651;
        Tue, 05 Apr 2022 05:39:53 -0700 (PDT)
Received: from [10.32.181.87] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.googlemail.com with ESMTPSA id y7-20020adfdf07000000b0020609f6b386sm8537167wrl.37.2022.04.05.05.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 05:39:52 -0700 (PDT)
Message-ID: <25257849-8e1a-17ff-5008-bb2d1efecf80@redhat.com>
Date:   Tue, 5 Apr 2022 14:39:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v5 020/104] KVM: TDX: allocate per-package mutex
Content-Language: en-US
To:     isaku.yamahata@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@gmail.com, Jim Mattson <jmattson@google.com>,
        erdemaktas@google.com, Connor Kuehl <ckuehl@redhat.com>,
        Sean Christopherson <seanjc@google.com>
References: <cover.1646422845.git.isaku.yamahata@intel.com>
 <f7b44d1d5a61f788294c399b63b505b3ff4d301b.1646422845.git.isaku.yamahata@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <f7b44d1d5a61f788294c399b63b505b3ff4d301b.1646422845.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/22 20:48, isaku.yamahata@intel.com wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> Several TDX SEAMCALLs are per-package scope (concretely per memory
> controller) and they need to be serialized per-package.  Allocate mutex for
> it.
> 
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---
>   arch/x86/kvm/vmx/main.c    |  8 +++++++-
>   arch/x86/kvm/vmx/tdx.c     | 18 ++++++++++++++++++
>   arch/x86/kvm/vmx/x86_ops.h |  2 ++
>   3 files changed, 27 insertions(+), 1 deletion(-)

Please define here the lock/unlock functions as well:

static inline int tdx_mng_key_lock(void)
{
	int cpu = get_cpu();
	cur_pkg = topology_physical_package_id(cpu);

	mutex_lock(&tdx_mng_key_config_lock[cur_pkg]);
	return cur_pkg;
}

static inline void tdx_mng_key_unlock(int cur_pkg)
{
	mutex_unlock(&tdx_mng_key_config_lock[cur_pkg]);
	put_cpu();
}

Thanks,

Paolo


> 
> diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
> index 8103d1c32cc9..6111c6485d8e 100644
> --- a/arch/x86/kvm/vmx/main.c
> +++ b/arch/x86/kvm/vmx/main.c
> @@ -25,6 +25,12 @@ static __init int vt_hardware_setup(void)
>   	return 0;
>   }
>   
> +static void vt_hardware_unsetup(void)
> +{
> +	tdx_hardware_unsetup();
> +	vmx_hardware_unsetup();
> +}
> +
>   static int vt_vm_init(struct kvm *kvm)
>   {
>   	int ret;
> @@ -42,7 +48,7 @@ static int vt_vm_init(struct kvm *kvm)
>   struct kvm_x86_ops vt_x86_ops __initdata = {
>   	.name = "kvm_intel",
>   
> -	.hardware_unsetup = vmx_hardware_unsetup,
> +	.hardware_unsetup = vt_hardware_unsetup,
>   
>   	.hardware_enable = vmx_hardware_enable,
>   	.hardware_disable = vmx_hardware_disable,
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index e8d293a3c11c..1c8222f54764 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -34,6 +34,8 @@ struct tdx_capabilities {
>   /* Capabilities of KVM + the TDX module. */
>   struct tdx_capabilities tdx_caps;
>   
> +static struct mutex *tdx_mng_key_config_lock;
> +
>   static u64 hkid_mask __ro_after_init;
>   static u8 hkid_start_pos __ro_after_init;
>   
> @@ -112,7 +114,9 @@ bool tdx_is_vm_type_supported(unsigned long type)
>   
>   static int __init __tdx_hardware_setup(struct kvm_x86_ops *x86_ops)
>   {
> +	int max_pkgs;
>   	u32 max_pa;
> +	int i;
>   
>   	if (!enable_ept) {
>   		pr_warn("Cannot enable TDX with EPT disabled\n");
> @@ -127,6 +131,14 @@ static int __init __tdx_hardware_setup(struct kvm_x86_ops *x86_ops)
>   	if (WARN_ON_ONCE(x86_ops->tlb_remote_flush))
>   		return -EIO;
>   
> +	max_pkgs = topology_max_packages();
> +	tdx_mng_key_config_lock = kcalloc(max_pkgs, sizeof(*tdx_mng_key_config_lock),
> +				   GFP_KERNEL);
> +	if (!tdx_mng_key_config_lock)
> +		return -ENOMEM;
> +	for (i = 0; i < max_pkgs; i++)
> +		mutex_init(&tdx_mng_key_config_lock[i]);
> +
>   	max_pa = cpuid_eax(0x80000008) & 0xff;
>   	hkid_start_pos = boot_cpu_data.x86_phys_bits;
>   	hkid_mask = GENMASK_ULL(max_pa - 1, hkid_start_pos);
> @@ -147,6 +159,12 @@ void __init tdx_hardware_setup(struct kvm_x86_ops *x86_ops)
>   		enable_tdx = false;
>   }
>   
> +void tdx_hardware_unsetup(void)
> +{
> +	/* kfree accepts NULL. */
> +	kfree(tdx_mng_key_config_lock);
> +}
> +
>   void __init tdx_pre_kvm_init(unsigned int *vcpu_size,
>   			unsigned int *vcpu_align, unsigned int *vm_size)
>   {
> diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
> index 78331dbc29f7..da32b4b86b19 100644
> --- a/arch/x86/kvm/vmx/x86_ops.h
> +++ b/arch/x86/kvm/vmx/x86_ops.h
> @@ -131,11 +131,13 @@ void __init tdx_pre_kvm_init(unsigned int *vcpu_size,
>   			unsigned int *vcpu_align, unsigned int *vm_size);
>   bool tdx_is_vm_type_supported(unsigned long type);
>   void __init tdx_hardware_setup(struct kvm_x86_ops *x86_ops);
> +void tdx_hardware_unsetup(void);
>   #else
>   static inline void tdx_pre_kvm_init(
>   	unsigned int *vcpu_size, unsigned int *vcpu_align, unsigned int *vm_size) {}
>   static inline bool tdx_is_vm_type_supported(unsigned long type) { return false; }
>   static inline void tdx_hardware_setup(struct kvm_x86_ops *x86_ops) {}
> +static inline void tdx_hardware_unsetup(void) {}
>   #endif
>   
>   #endif /* __KVM_X86_VMX_X86_OPS_H */

