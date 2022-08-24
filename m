Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4765A03B7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 00:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240892AbiHXWGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 18:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbiHXWGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 18:06:08 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323297CB53
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 15:06:06 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id p185so3347810pfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 15:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=nJk22XJ7wOcvuCzoRyIGvhgc9X2oEpNpAmvbdRYC9rU=;
        b=tUTOy/np2IJItYhuVGMMnsrVV+ydgrkxKJ+hYrUWTxm8CN+LahtWN5HL5rBpOxN1Ll
         HaSnQBQJoGwN/gJUgT53N+Sb7uHbUmEO/A1JtN7AdFlLyLSBsAGc/pQb/p4j0mLzC6wM
         8XTxdBUnMNqZvR46FJNZQb4s4rhCuTBLox4PkBdTgDZayH7cCle+3f5Xs9UdZwLzRy8U
         qIOIjtPp24yLO6PZWUCpafE8jlzslVX/sYBHu1NBOtHHeu6v/qp9sdmVQTw5JK4/HavL
         fTwLARDDsxC9bUo6LKINSnvapDHbN+ubIqs/NI4dqQ3opt4imjH19+mKz6dJLVL1xx/G
         wkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=nJk22XJ7wOcvuCzoRyIGvhgc9X2oEpNpAmvbdRYC9rU=;
        b=vCPzT5+YqB5nxVSZPZoAvVSK8NuN/Ap54gzMNZQvV69x7+DFsrVQRTbbEzNu4LILFr
         T7BdLPNpGGswh0991VHvnuUEBXvDzj7ocKxh6mKm17SKGf0kroU+0mICQun+//DtxTBF
         0P20ZDk1U3iyW3cw2lNGePcKkTSJQ9COSOhVHXiMxLpMfFie3Sq5a5bT7S7K/mMDjcDg
         ArCUr+0qf0ZuRFY5Av/X8Zbyi4BW6nXdQxEYn/eAeny9C9XDb5wh80drx2wbdgbXBT3M
         Bvz8+2pAWf7zlY1XeBwn4vTIfyE8zRBduBVdRFr+OVuhk7SD+pAL/7uwXvlc58K0vt6y
         ovPw==
X-Gm-Message-State: ACgBeo3HTOm+ehG+whs1eufVhcQZE4RPd8o8tfEo9DJqh1uT/Hs97wzM
        J33zBWlh8ba5Mc5FiGys8ROFpQ==
X-Google-Smtp-Source: AA6agR4nCg320FC5ogznqsjn0vPK5nuwzVFzRHaOV7SdrQv7eMc2KV4zVEPpadFc/buFs9qVKWflIA==
X-Received: by 2002:a65:4cc7:0:b0:41a:4df2:4839 with SMTP id n7-20020a654cc7000000b0041a4df24839mr768027pgt.37.1661378765493;
        Wed, 24 Aug 2022 15:06:05 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902e5c900b00172fad607b3sm5234217plf.207.2022.08.24.15.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 15:06:05 -0700 (PDT)
Date:   Wed, 24 Aug 2022 22:06:01 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Jim Mattson <jmattson@google.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 07/13] KVM: x86: emulator/smm: add structs for KVM's
 smram layout
Message-ID: <YwagyQu5X8N/w8UV@google.com>
References: <20220803155011.43721-1-mlevitsk@redhat.com>
 <20220803155011.43721-8-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803155011.43721-8-mlevitsk@redhat.com>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022, Maxim Levitsky wrote:
> Those structs will be used to read/write the smram state image.
> 
> Also document the differences between KVM's SMRAM layout and SMRAM
> layout that is used by real Intel/AMD cpus.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  arch/x86/kvm/emulate.c     |   6 +
>  arch/x86/kvm/kvm_emulate.h | 218 +++++++++++++++++++++++++++++++++++++
>  arch/x86/kvm/x86.c         |   1 +
>  3 files changed, 225 insertions(+)
> 
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index 18551611cb13af..55d9328e6074a2 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -5864,3 +5864,9 @@ bool emulator_can_use_gpa(struct x86_emulate_ctxt *ctxt)
>  
>  	return true;
>  }
> +
> +void  __init kvm_emulator_init(void)
> +{
> +	__check_smram32_offsets();
> +	__check_smram64_offsets();
> +}

...

> +static inline void __check_smram64_offsets(void)

Why double underscores?  Same question for the macros.

> +{
> +#define __CHECK_SMRAM64_OFFSET(field, offset) \
> +	ASSERT_STRUCT_OFFSET(struct kvm_smram_state_64, field, offset - 0xFE00)
> +
> +	__CHECK_SMRAM64_OFFSET(es,			0xFE00);
> +	__CHECK_SMRAM64_OFFSET(cs,			0xFE10);
> +	__CHECK_SMRAM64_OFFSET(ss,			0xFE20);
> +	__CHECK_SMRAM64_OFFSET(ds,			0xFE30);
> +	__CHECK_SMRAM64_OFFSET(fs,			0xFE40);
> +	__CHECK_SMRAM64_OFFSET(gs,			0xFE50);
> +	__CHECK_SMRAM64_OFFSET(gdtr,			0xFE60);
> +	__CHECK_SMRAM64_OFFSET(ldtr,			0xFE70);
> +	__CHECK_SMRAM64_OFFSET(idtr,			0xFE80);
> +	__CHECK_SMRAM64_OFFSET(tr,			0xFE90);
> +	__CHECK_SMRAM64_OFFSET(io_restart_rip,		0xFEA0);
> +	__CHECK_SMRAM64_OFFSET(io_restart_rcx,		0xFEA8);
> +	__CHECK_SMRAM64_OFFSET(io_restart_rsi,		0xFEB0);
> +	__CHECK_SMRAM64_OFFSET(io_restart_rdi,		0xFEB8);
> +	__CHECK_SMRAM64_OFFSET(io_restart_dword,	0xFEC0);
> +	__CHECK_SMRAM64_OFFSET(reserved1,		0xFEC4);
> +	__CHECK_SMRAM64_OFFSET(io_inst_restart,		0xFEC8);
> +	__CHECK_SMRAM64_OFFSET(auto_hlt_restart,	0xFEC9);
> +	__CHECK_SMRAM64_OFFSET(reserved2,		0xFECA);
> +	__CHECK_SMRAM64_OFFSET(efer,			0xFED0);
> +	__CHECK_SMRAM64_OFFSET(svm_guest_flag,		0xFED8);
> +	__CHECK_SMRAM64_OFFSET(svm_guest_vmcb_gpa,	0xFEE0);
> +	__CHECK_SMRAM64_OFFSET(svm_guest_virtual_int,	0xFEE8);
> +	__CHECK_SMRAM64_OFFSET(reserved3,		0xFEF0);
> +	__CHECK_SMRAM64_OFFSET(smm_revison,		0xFEFC);
> +	__CHECK_SMRAM64_OFFSET(smbase,			0xFF00);
> +	__CHECK_SMRAM64_OFFSET(reserved4,		0xFF04);
> +	__CHECK_SMRAM64_OFFSET(ssp,			0xFF18);
> +	__CHECK_SMRAM64_OFFSET(svm_guest_pat,		0xFF20);
> +	__CHECK_SMRAM64_OFFSET(svm_host_efer,		0xFF28);
> +	__CHECK_SMRAM64_OFFSET(svm_host_cr4,		0xFF30);
> +	__CHECK_SMRAM64_OFFSET(svm_host_cr3,		0xFF38);
> +	__CHECK_SMRAM64_OFFSET(svm_host_cr0,		0xFF40);
> +	__CHECK_SMRAM64_OFFSET(cr4,			0xFF48);
> +	__CHECK_SMRAM64_OFFSET(cr3,			0xFF50);
> +	__CHECK_SMRAM64_OFFSET(cr0,			0xFF58);
> +	__CHECK_SMRAM64_OFFSET(dr7,			0xFF60);
> +	__CHECK_SMRAM64_OFFSET(dr6,			0xFF68);
> +	__CHECK_SMRAM64_OFFSET(rflags,			0xFF70);
> +	__CHECK_SMRAM64_OFFSET(rip,			0xFF78);
> +	__CHECK_SMRAM64_OFFSET(gprs,			0xFF80);
> +#undef __CHECK_SMRAM64_OFFSET
> +}
> +
> +union kvm_smram {
> +	struct kvm_smram_state_64 smram64;
> +	struct kvm_smram_state_32 smram32;
> +	u8 bytes[512];
> +};
> +
> +void  __init kvm_emulator_init(void);
> +
> +

Unnecessary newline.

>  /* Host execution mode. */
>  #if defined(CONFIG_X86_32)
>  #define X86EMUL_MODE_HOST X86EMUL_MODE_PROT32
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 33560bfa0cac6e..bea7e5015d592e 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -13355,6 +13355,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_vmgexit_msr_protocol_exit);
>  static int __init kvm_x86_init(void)
>  {
>  	kvm_mmu_x86_module_init();
> +	kvm_emulator_init();

Please don't add an init call that is nop at runtime, e.g. I was _really_ curious
what initialization needed to be done in the emulator.  And it makes it look like
kvm_x86_exit() forgot to call kvm_emulator_exit().

em_rsm() already ends up with

	BUILD_BUG_ON(sizeof(smram) != 512);

just put all the assertions there.

>  	return 0;
>  }
>  module_init(kvm_x86_init);
> -- 
> 2.26.3
> 
