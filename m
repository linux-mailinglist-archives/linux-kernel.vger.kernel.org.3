Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A654DDEF9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239206AbiCRQbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239181AbiCRQa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:30:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA766194AAD
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 09:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647620964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zf+D2msIjA8cu3KF+9rp/T6nW3cAB4bRjyxbO7BeSLs=;
        b=Ai9dVlVWXCTX9V9/xOdFxOJm4XV1F6rzL1pY+fwf8rp93aoU7NJUuAQqPrTKejNruC7If5
        FHo66m7SBUelEtt5tH4Nh7cFIXhv6wSXrzbFzURz8CR7Tb4K+e/B5t/9VEWekFD2ZgLR60
        W7NFKduwciA3TTHUD6edeJ0+1dh14NU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-AReaBzJAPbKoTGSzq9txqA-1; Fri, 18 Mar 2022 12:29:23 -0400
X-MC-Unique: AReaBzJAPbKoTGSzq9txqA-1
Received: by mail-ej1-f70.google.com with SMTP id 13-20020a170906328d00b006982d0888a4so4747749ejw.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 09:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zf+D2msIjA8cu3KF+9rp/T6nW3cAB4bRjyxbO7BeSLs=;
        b=XllrtuPL91Og5Ntdt0JkuT3IB57LCJGJRNyjCiYPNIR6DUbdwHRHG9lFANyiua7JaW
         CwNLQ8W9Tt3UoxQ8QHxGn1wZouR/J4E1jmH5wp1STempFebJpUfVpuhORQo3Dg0d+hA4
         0SuzHcJldkITEYhYltgs8SPstJVNQ6GaUq5wCBXzLQPC3e7PkCR3mjvq3ThIS2k+3biy
         IS+WfD4z/ZySZuuz+joIu4AyZATRC7NhynIFTKBZMM6x2hvwL1Rl3XZJSDB3CS+9TYAc
         XCex+R0/aaCKl9v5urQUOZSL1WL0vDWhkHB4bu/E9ODOh8r5M1jOdxqE0nwQ5UumSOvm
         HX+A==
X-Gm-Message-State: AOAM533wPqU9sjz1f6p55TvA6mV1Ylr0LQX9j/UMSN+RIC0gLdbMkb73
        5sMI3dr/aYCcdfFjF6xCOpjmdfeYuWMGGlrX0Du1tpwux8kEgXNqZtEUVaBGLfrWQwGu/Pggab+
        YdJBcukdMIcOfEtCu4UWO7NhQ
X-Received: by 2002:a05:6402:1d50:b0:418:5a20:8dd8 with SMTP id dz16-20020a0564021d5000b004185a208dd8mr10196786edb.324.1647620962113;
        Fri, 18 Mar 2022 09:29:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0QVrcybe8P7ed99Ps8zPs7o/wv3XcFLeW9KRDleYQFKnzIpYSjREjPoKgWHPqRQ7bBS4f+g==
X-Received: by 2002:a05:6402:1d50:b0:418:5a20:8dd8 with SMTP id dz16-20020a0564021d5000b004185a208dd8mr10196767edb.324.1647620961886;
        Fri, 18 Mar 2022 09:29:21 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id go40-20020a1709070da800b006dfc3945312sm614245ejc.202.2022.03.18.09.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 09:29:21 -0700 (PDT)
Message-ID: <1dc56110-5f1b-6140-937c-bf4a28ddbe87@redhat.com>
Date:   Fri, 18 Mar 2022 17:29:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 6/6] KVM: x86: allow defining return-0 static calls
Content-Language: en-US
To:     Maxim Levitsky <mlevitsk@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     seanjc@google.com
References: <20220217180831.288210-1-pbonzini@redhat.com>
 <20220217180831.288210-7-pbonzini@redhat.com>
 <3bbe3f8717cdf122f909a48e117dab6c09d8e0c8.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <3bbe3f8717cdf122f909a48e117dab6c09d8e0c8.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/22 18:43, Maxim Levitsky wrote:
> diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
> index 20f64e07e359..3388072b2e3b 100644
> --- a/arch/x86/include/asm/kvm-x86-ops.h
> +++ b/arch/x86/include/asm/kvm-x86-ops.h
> @@ -88,7 +88,7 @@ KVM_X86_OP(deliver_interrupt)
>   KVM_X86_OP_OPTIONAL(sync_pir_to_irr)
>   KVM_X86_OP_OPTIONAL_RET0(set_tss_addr)
>   KVM_X86_OP_OPTIONAL_RET0(set_identity_map_addr)
> -KVM_X86_OP_OPTIONAL_RET0(get_mt_mask)
> +KVM_X86_OP(get_mt_mask)
>   KVM_X86_OP(load_mmu_pgd)
>   KVM_X86_OP(has_wbinvd_exit)
>   KVM_X86_OP(get_l2_tsc_offset)
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index a09b4f1a18f6..0c09292b0611 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -4057,6 +4057,11 @@ static bool svm_has_emulated_msr(struct kvm *kvm, u32 index)
>          return true;
>   }
>   
> +static u64 svm_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
> +{
> +       return 0;
> +}
> +
>   static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>   {
>          struct vcpu_svm *svm = to_svm(vcpu);
> @@ -4718,6 +4723,7 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
>          .check_apicv_inhibit_reasons = avic_check_apicv_inhibit_reasons,
>          .apicv_post_state_restore = avic_apicv_post_state_restore,
>   
> +       .get_mt_mask = svm_get_mt_mask,
>          .get_exit_info = svm_get_exit_info,
>   
>          .vcpu_after_set_cpuid = svm_vcpu_after_set_cpuid,

Thanks, I'll send it as a complete patch.  Please reply there with your 
Signed-off-by.

Related to this, I don't see anything in arch/x86/kernel/static_call.c 
that limits this code to x86-64:

                 if (func == &__static_call_return0) {
                         emulate = code;
                         code = &xor5rax;
                 }


On 32-bit, it will be patched as "dec ax; xor eax, eax" or something 
like that.  Fortunately it doesn't corrupt any callee-save register but 
it is not just a bit funky, it's also not a single instruction.

Paolo

