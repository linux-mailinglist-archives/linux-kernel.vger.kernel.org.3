Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CE65964BB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 23:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236381AbiHPVh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 17:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbiHPVh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 17:37:26 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C8F8B985
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:37:22 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id t3so2498178ply.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=thSDw69OBYs6EfsBdSFpUoSc0SPob+6FERoL5av+zQ8=;
        b=hgYGQ6fvQu+WmlcJoxSVdZtZBZc1WrNZZiVOS8gGyW9Fj7+b54VWzgoveaM8H55EGT
         Hi6ZxkNJP9CCc+Q+PD1ZeDBtBQs1AXMVbmKSNH8/rqnK8q6CKLZAJvPLpEmK99wH/uHO
         DikuwLg3JVF8zVA6a/HZ3foNxoy8pV7peh+3sUS2iGTL9el2pkBTrCoBP3QmtvIiTp2y
         mZ15BjAUsseUX/dhzL4Kgfzz0en2pYdudeiBpzsxzOeENv11LBOs0VZhoN9qxAplHllV
         BI9OLR8h/C4l5rLMPIJdJiJNae9ZGwDTQvdwE7BvcFTQTovGHNRp5z3upjhtlUgusILu
         XAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=thSDw69OBYs6EfsBdSFpUoSc0SPob+6FERoL5av+zQ8=;
        b=5C5P60PCrKrFP3uP9njLzq/nbwvxZUvG6KZiGM9wCWSG7oA+/CrFsw/PaAWnrKo+W1
         55NGl4omTnt/UTrKCjVo6cgPNqqBBl52IosGb8ooYpGSifonzNWVxoHqGq0em8tvRy5I
         jONUz09sK4GougMqINDWtE4OISR8C8PYSIaNJLr/MiIw5IW/wIYbPhwNRjaZ/rw+F5Vs
         YqCyyhy31dgoIowzUCy47JEzEtJWwvtT8ULGIDx1FG3Sh+ReyCZBnN8QD/9/oJ7h4stv
         3PScmaKBYehrmS0JIk+T9yX4otys7vdxQkAC/Ir1ap6gP4nBhqObmLaNfiGWk0FxqVkm
         jHoA==
X-Gm-Message-State: ACgBeo2awmwaP0TAYYtLDV4D+Iyu054CAiwl/wBjIebGcfxLbGon0tHK
        aefsznHhD4ydpATIMQvK4egRvw==
X-Google-Smtp-Source: AA6agR5jgV99sVVYGTK+5Fsy8W0ABW7Jmij59m/Rs9vKbUbYddLcjeBMZRIs7a8DkUgNDppn7vlHmQ==
X-Received: by 2002:a17:902:da92:b0:16e:f4a4:9f93 with SMTP id j18-20020a170902da9200b0016ef4a49f93mr23641439plx.27.1660685841828;
        Tue, 16 Aug 2022 14:37:21 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id e19-20020a17090a4a1300b001f23db09351sm5082pjh.46.2022.08.16.14.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 14:37:21 -0700 (PDT)
Date:   Tue, 16 Aug 2022 21:37:17 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, tglx@linutronix.de,
        leobras@redhat.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org
Subject: Re: [PATCH] KVM: x86: Always enable legacy fp/sse
Message-ID: <YvwODUu/rdzjzDjk@google.com>
References: <20220816175936.23238-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816175936.23238-1-dgilbert@redhat.com>
X-Spam-Status: No, score=-14.4 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> A live migration under qemu is currently failing when the source
> host is ~Nehalem era (pre-xsave) and the destination is much newer,
> (configured with a guest CPU type of Nehalem).
> QEMU always calls kvm_put_xsave, even on this combination because
> KVM_CAP_CHECK_EXTENSION_VM always returns true for KVM_CAP_XSAVE.
> 
> When QEMU calls kvm_put_xsave it's rejected by
>    fpu_copy_uabi_to_guest_fpstate->
>      copy_uabi_to_xstate->
>        validate_user_xstate_header
> 
> when the validate checks the loaded xfeatures against
> user_xfeatures, which it finds to be 0.
> 
> I think our initialisation of user_xfeatures is being
> too strict here, and we should always allow the base FP/SSE.
> 
> Fixes: ad856280ddea ("x86/kvm/fpu: Limit guest user_xfeatures to supported bits of XCR0")
> bz: https://bugzilla.redhat.com/show_bug.cgi?id=2079311
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  arch/x86/kvm/cpuid.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index de6d44e07e34..3b2319cecfd1 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -298,7 +298,8 @@ static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>  	guest_supported_xcr0 =
>  		cpuid_get_supported_xcr0(vcpu->arch.cpuid_entries, vcpu->arch.cpuid_nent);
>  
> -	vcpu->arch.guest_fpu.fpstate->user_xfeatures = guest_supported_xcr0;
> +	vcpu->arch.guest_fpu.fpstate->user_xfeatures = guest_supported_xcr0 |
> +		XFEATURE_MASK_FPSSE;

I don't think this is correct.  This will allow the guest to set the SSE bit
even when XSAVE isn't supported due to kvm_guest_supported_xcr0() returning
user_xfeatures.

  static inline u64 kvm_guest_supported_xcr0(struct kvm_vcpu *vcpu)
  {
	return vcpu->arch.guest_fpu.fpstate->user_xfeatures;
  }

I believe the right place to fix this is in validate_user_xstate_header().  It's
reachable if and only if XSAVE is supported in the host, and when XSAVE is _not_
supported, the kernel unconditionally allows FP+SSE.  So it follows that the kernel
should also allow FP+SSE when using XSAVE too.  That would also align the logic
with fpu_copy_guest_fpstate_to_uabi(), which fordces the FPSSE flags.  Ditto for
the non-KVM save_xstate_epilog().

Aha!  And fpu__init_system_xstate() ensure the host supports FP+SSE when XSAVE
is enabled (knew their had to be a sanity check somewhere).

---
 arch/x86/kernel/fpu/xstate.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index c8340156bfd2..83b9a9653d47 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -399,8 +399,13 @@ int xfeature_size(int xfeature_nr)
 static int validate_user_xstate_header(const struct xstate_header *hdr,
 				       struct fpstate *fpstate)
 {
-	/* No unknown or supervisor features may be set */
-	if (hdr->xfeatures & ~fpstate->user_xfeatures)
+	/*
+	 * No unknown or supervisor features may be set.  Userspace is always
+	 * allowed to restore FP+SSE state (XSAVE/XRSTOR are used by the kernel
+	 * if and only if FP+SSE are supported in xstate).
+	 */
+	if (hdr->xfeatures & ~fpstate->user_xfeatures &
+	    ~(XFEATURE_MASK_FP | XFEATURE_MASK_SSE))
 		return -EINVAL;

 	/* Userspace must use the uncompacted format */

base-commit: de3d415edca23831c5d1f24f10c74a715af7efdb
--

