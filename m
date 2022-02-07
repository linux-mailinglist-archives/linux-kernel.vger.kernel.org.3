Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E70B4AC026
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389025AbiBGNvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387009AbiBGNab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 08:30:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC76BC043188
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 05:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644240630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d/RwIpkh1gprTvNPsmejeNnvxhM/jcf++w/m9CVaFcI=;
        b=Ty6cCWAO4PUPhr+H1W5IqKWS5NU7R7djj0scEiaH5eh2NoWcKUn2n74C7OAyAiJ8QYku3N
        EAPNxkdCdM9nMSxqWf7v/v7kKj47+HICU4MmTCZVrDNcIaYZ7Yk+xWyI83FPr1WdjvZ+1h
        ZbvTLayw5adm/rlxpt2YdcktPyzVXQQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-6lmq81nMNOCCfT2372ptFA-1; Mon, 07 Feb 2022 08:30:28 -0500
X-MC-Unique: 6lmq81nMNOCCfT2372ptFA-1
Received: by mail-ed1-f72.google.com with SMTP id s7-20020a508dc7000000b0040f29ccd65aso4084465edh.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 05:30:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=d/RwIpkh1gprTvNPsmejeNnvxhM/jcf++w/m9CVaFcI=;
        b=nyS3gGp7IpkBTnRzdAJxlfBruMBgTap0dZKy16G91oFDcHjrp6DgjVXkR4yUkwcI4b
         bo5I6CGgIci6rHqE6GBPBZ7eKe1ZTf9dicCoC8UICo/vdNwgYq6pP2EfqRIkhfkr5tZg
         O8vmOVAwlJEltxqCYrYLUmVS+W6D4+NuipInAEP1JjIgPiyDrvkH7dgGygud7GWZTDeS
         5X2YDGkt4g84DwN0pXO4WmmLGpnWlbSCp8YtDt6HGujpklnvPDHaIZJawx858GlULNM2
         s0Pww4qIAQerXGQpugLzdBolLfhSfJ1JE9rCZqq40+1O2+cvihaWeb+8quRuvTFRT6VL
         ekXg==
X-Gm-Message-State: AOAM532E1zzFVIxGCe1IDbaIMPuFe0PdQcu3D9TMSy5HDcDygNQIq+N9
        ib0Khh/c46MAimSxE4g9wd59jymlcFHcLkViZmQGYQ1bmN2qXuB3rKgYPzfW3cNszJ8eZVL2W58
        Y6rODCSKBR6ilFUPA2N2tfhpS
X-Received: by 2002:aa7:c685:: with SMTP id n5mr9093114edq.259.1644240627730;
        Mon, 07 Feb 2022 05:30:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwqkWzxxGviHYUkeA6MDfeaDIq/YZmhUBCfLKbW46BnBEHUYafJM43kTtIMCFfYXULfWBsEng==
X-Received: by 2002:aa7:c685:: with SMTP id n5mr9093082edq.259.1644240627465;
        Mon, 07 Feb 2022 05:30:27 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id h21sm1569028edt.26.2022.02.07.05.30.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 05:30:26 -0800 (PST)
Message-ID: <f2b0cac2-2f8a-60e8-616c-73825b3f62a6@redhat.com>
Date:   Mon, 7 Feb 2022 14:30:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 1/2] x86/kvm/fpu: Mask guest fpstate->xfeatures with
 guest_supported_xcr0
Content-Language: en-US
To:     Leonardo Bras <leobras@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220205081658.562208-1-leobras@redhat.com>
 <20220205081658.562208-2-leobras@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220205081658.562208-2-leobras@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/22 09:16, Leonardo Bras wrote:
> During host/guest switch (like in kvm_arch_vcpu_ioctl_run()), the kernel
> swaps the fpu between host/guest contexts, by using fpu_swap_kvm_fpstate().
> 
> When xsave feature is available, the fpu swap is done by:
> - xsave(s) instruction, with guest's fpstate->xfeatures as mask, is used
>    to store the current state of the fpu registers to a buffer.
> - xrstor(s) instruction, with (fpu_kernel_cfg.max_features &
>    XFEATURE_MASK_FPSTATE) as mask, is used to put the buffer into fpu regs.
> 
> For xsave(s) the mask is used to limit what parts of the fpu regs will
> be copied to the buffer. Likewise on xrstor(s), the mask is used to
> limit what parts of the fpu regs will be changed.
> 
> The mask for xsave(s), the guest's fpstate->xfeatures, is defined on
> kvm_arch_vcpu_create(), which (in summary) sets it to all features
> supported by the cpu which are enabled on kernel config.
> 
> This means that xsave(s) will save to guest buffer all the fpu regs
> contents the cpu has enabled when the guest is paused, even if they
> are not used.
> 
> This would not be an issue, if xrstor(s) would also do that.
> 
> xrstor(s)'s mask for host/guest swap is basically every valid feature
> contained in kernel config, except XFEATURE_MASK_PKRU.
> Accordingto kernel src, it is instead switched in switch_to() and
> flush_thread().

Hi Leonardo, is this an issue when patch 2 is applied?  With this patch, 
we have to reason about the effect of calling KVM_SET_CPUID2 twice calls 
back to back.  I think an "&=" would be wrong in that case.

On the other hand, with patch 2 the change is only in the KVM_SET_XSAVE 
output, which is much more self-contained.

Thanks,

Paolo

> Then, the following happens with a host supporting PKRU starts a
> guest that does not support it:
> 1 - Host has XFEATURE_MASK_PKRU set. 1st switch to guest,
> 2 - xsave(s) fpu regs to host fpustate (buffer has XFEATURE_MASK_PKRU)
> 3 - xrstor(s) guest fpustate to fpu regs (fpu regs have XFEATURE_MASK_PKRU)
> 4 - guest runs, then switch back to host,
> 5 - xsave(s) fpu regs to guest fpstate (buffer now have XFEATURE_MASK_PKRU)
> 6 - xrstor(s) host fpstate to fpu regs.
> 
> On 5, even though the guest does not support PKRU, it does have the flag
> set on guest fpstate, which is transferred to userspace via vcpu ioctl
> KVM_GET_XSAVE.
> 
> This becomes a problem when the user decides on migrating the above guest
> to another machine that does not support PKRU:
> The new host restores guest's fpu regs to as they were before (xrstor(s)),
> but since the new host don't support PKRU, a general-protection exception
> ocurs in xrstor(s) and that crashes the guest.
> 
> This can be solved by making the guest's fpstate->xfeatures only hold
> values compatible to guest_supported_xcr0. This way, on 5 the only flags
> saved by xsave(s) will be the ones compatible to guest requirements,
> and thus there will be no issue during migration.
> 
> Signed-off-by: Leonardo Bras <leobras@redhat.com>
> ---
>   arch/x86/kvm/cpuid.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 28be02adc669..8ce481cc0f9b 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -296,6 +296,9 @@ static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>   	vcpu->arch.guest_supported_xcr0 =
>   		cpuid_get_supported_xcr0(vcpu->arch.cpuid_entries, vcpu->arch.cpuid_nent);
>   
> +	/* Mask out features unsupported by guest */
> +	vcpu->arch.guest_fpu.fpstate->xfeatures &= vcpu->arch.guest_supported_xcr0;
> +
>   	kvm_update_pv_runtime(vcpu);
>   
>   	vcpu->arch.maxphyaddr = cpuid_query_maxphyaddr(vcpu);

