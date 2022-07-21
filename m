Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA7857C1AD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 02:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbiGUAib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 20:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiGUAia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 20:38:30 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0775753B5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 17:38:28 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id g17so350312plh.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 17:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qIXB7whg+5LKxcRErmf7YwO5OWBbWQDJ0V2XnbTZNg4=;
        b=BACRZqGDzXNofGzcoYRAS2JjGiCOrkPjVYzQ3lKxaNcbSVSMwv4PaCdFhQz33SC/56
         bU7oo7Wzi39irAkMrCZ2rXJp08uAcaW1ogwtKBcXg2TrY72p1CRXLsr9vQBUfEeZqFAM
         kgsXD99MjdByuEqDgbrnnkJqdPZpIOT1AAICubSLwc1ziYsOeZeFO7ZZNVXxjRLoZTej
         sIhHSez5sJskV1l5EMmUbELRdx+Q033WY546bBSLpGZvVVKh9s+eZxefAFhoDxZbgA11
         Ipo3YEUQNY8+a2dzp4UOGZic4/UjROC3ROGikEZfpyO9YJ0iQjCU/3uieJmU4c9le9gi
         XCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qIXB7whg+5LKxcRErmf7YwO5OWBbWQDJ0V2XnbTZNg4=;
        b=w0uCi87rnIhjSe2azOkZPTrXqCo0bpKRCijXAVYQI/LhBvo7+xn2Ck3KrnrC1Iw6C0
         8vSbAHHsCe0AmbF4VFr0RF7ZpmRF0IPHed6rL0Ve4wGlh861Sn2MlOwQCZfLdd3FG4CZ
         KX1JJeX1leq/ISH7qGGDWck6FiHfi+lbd6GZVveyyIb+UKlJC1SWTSh2NOmkYa21HDf/
         V4DpKm0sOc/NhlZH95lsPa6PaeZX/eU6M8rIV9g+Gx7/IWlQFGerbml9d6YpU2GAUTEV
         b04niW2fx6mTll7NuLn8g1v/pDDyMzTCMy3n4eqGzgL/AyFfH0wkg0l/3g4XXfJKXxKm
         HtOw==
X-Gm-Message-State: AJIora9faz5UM/VDXnEeNm9/X2Kc9r2n6SpeMMU9UXMmtx2bCpZKOTdV
        EWKwSMAD+xQO5rb1X23bBSjZ+A==
X-Google-Smtp-Source: AGRyM1uh11Q9cdp3jm/parZ80PTYH/PGg1DPcFzwpRjaXgM4jNO+OmAJzFdk7fBt01oISacfNg5A0g==
X-Received: by 2002:a17:90b:1c8c:b0:1f1:be0b:8903 with SMTP id oo12-20020a17090b1c8c00b001f1be0b8903mr8541666pjb.160.1658363908283;
        Wed, 20 Jul 2022 17:38:28 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902ab8700b001677fa34a07sm176882plr.43.2022.07.20.17.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 17:38:27 -0700 (PDT)
Date:   Thu, 21 Jul 2022 00:38:24 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, x86@kernel.org,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH v2 09/11] KVM: x86: emulator/smm: use smram struct for 64
 bit smram load/restore
Message-ID: <YtigALu4ccTi4/v0@google.com>
References: <20220621150902.46126-1-mlevitsk@redhat.com>
 <20220621150902.46126-10-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621150902.46126-10-mlevitsk@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022, Maxim Levitsky wrote:
> Use kvm_smram_state_64 struct to save/restore the 64 bit SMM state
> (used when X86_FEATURE_LM is present in the guest CPUID,
> regardless of 32-bitness of the guest).
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
> @@ -9814,7 +9805,7 @@ static void enter_smm(struct kvm_vcpu *vcpu)
>  	memset(buf, 0, 512);
>  #ifdef CONFIG_X86_64
>  	if (guest_cpuid_has(vcpu, X86_FEATURE_LM))
> -		enter_smm_save_state_64(vcpu, buf);
> +		enter_smm_save_state_64(vcpu, (struct kvm_smram_state_64 *)buf);
>  	else
>  #endif
>  		enter_smm_save_state_32(vcpu, (struct kvm_smram_state_32 *)buf);

Hrm, I _love_ the approach overall, but I really dislike having to cast an
arbitrary buffer, especially in the SVM code.

Aha!  Rather than keeping a buffer and casting, create a union to hold everything:

	union kvm_smram {
		struct kvm_smram_state_64 smram64;
		struct kvm_smram_state_32 smram32;
		u8 bytes[512];
	};

and then enter_smm() becomes:

  static void enter_smm(struct kvm_vcpu *vcpu)
  {
	struct kvm_segment cs, ds;
	struct desc_ptr dt;
	unsigned long cr0;

	union kvm_smram smram;

	BUILD_BUG_ON(sizeof(smram) != 512);

	memset(smram.bytes, 0, sizeof(smram));
#ifdef CONFIG_X86_64
	if (guest_cpuid_has(vcpu, X86_FEATURE_LM))
		enter_smm_save_state_64(vcpu, &smram.smram64);
	else
#endif
		enter_smm_save_state_32(vcpu, &smram.smram32);

	/*
	 * Give enter_smm() a chance to make ISA-specific changes to the vCPU
	 * state (e.g. leave guest mode) after we've saved the state into the
	 * SMM state-save area.
	 */
	static_call(kvm_x86_enter_smm)(vcpu, &smram);

	kvm_smm_changed(vcpu, true);
	kvm_vcpu_write_guest(vcpu, vcpu->arch.smbase + 0xfe00, smram.bytes, sizeof(smram));

and em_rsm() gets similar treatment.  Then the vendor code doesn't have to cast,
e.g. SVM can do:

	smram->smram64.svm_guest_flag = 1;
	smram->smram64.svm_guest_vmcb_gpa = svm->nested.vmcb12_gpa;

That way we don't have to refactor this all again if we want to use SMRAM to save
something on Intel for VMX (though I agree with Jim that that's probably a bad idea).
