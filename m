Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E9D4D1F66
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349266AbiCHRto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348693AbiCHRtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:49:42 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7E34839E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 09:48:45 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id k92so8772592pjh.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 09:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9EY+jbz7yxv8opR/z4nwJHkmZWRpRix7BFXhHKCoISQ=;
        b=HXAGF40IVistJKOXvEgTZPX31PpRTlv2NhZQsp0w0nAlT2c3IssIMwMm2CLCQGRgfV
         LqMUB0KqsayxM/XW+vAOSclwOFINpQGuUCmIaQTzvbU/PELYLARX16koTM8NzkLc3ELA
         8ihK5SuqfLYJm5oCY7ubBwGo1uTABBeS3ChzZTuMt/SBatkzzUgdsUSHyxb6ZYtsczQt
         TlruRmDyHW292Lc2Eg7PbhrmWIRY7OSl43JwLv7e7Co0iqfRRlj5UGmwvbrZTVgry/t7
         wsHLI7NrvxKHkQGXKWpe8I/MqFFP96YKNsRNAHneRx1okFTEcK5kyY+jm0+nM1pCUD+F
         Y4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9EY+jbz7yxv8opR/z4nwJHkmZWRpRix7BFXhHKCoISQ=;
        b=ossaLhBN4ivYVlR3T01Pd+BtXvbFQ1lktNGcQTB4Yiyq2+310RUsFYcoVeIZlCABht
         IRZ/kckgQJsc4EJvf6rV7RyO1OE1nadunrICfecBIU6f8YoLOpSqzL86s1EaNRRJsjFO
         fAcgBRpsi6V0Mlt/0RcIKOjPVAc7hGiwIhKIgy0PiOOJDnFXwX5cr+KirfIMmyeLhYZs
         i9CAdVBLds6NcLss9N4s4ssQPP2LZUCa9mSWztjinYWtQS8O8Se+pOLCaWGNLyQ70cDb
         65roJcVpbTU8X0Dga3n+d9Ct9B8PWglFiond00Ynp2by72NVnp2j5PYt87GdXCyP2eN0
         0yPQ==
X-Gm-Message-State: AOAM530bOEWwZrbnf0u3gkkdl3T9gUYVSYMhcHlCzOtm7CWmRMiq5VZo
        0ArkfueoSLdSW+8Ec+UfFESw+g==
X-Google-Smtp-Source: ABdhPJzAMqaA2eVSkxGml9gMR9kbyJkC+ocfJL8hF2J8qHUTa3dshAXxR+KRdUTYP8+4wSVp0hTH3w==
X-Received: by 2002:a17:90a:5d93:b0:1bc:4f9c:8eed with SMTP id t19-20020a17090a5d9300b001bc4f9c8eedmr5918639pji.180.1646761725209;
        Tue, 08 Mar 2022 09:48:45 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id i11-20020a056a00004b00b004f6907b2cd3sm19046452pfk.122.2022.03.08.09.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 09:48:44 -0800 (PST)
Date:   Tue, 8 Mar 2022 17:48:40 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        dmatlack@google.com
Subject: Re: [PATCH v2 11/25] KVM: x86/mmu: remove
 kvm_calc_shadow_root_page_role_common
Message-ID: <YieW+PZarPdsSnO7@google.com>
References: <20220221162243.683208-1-pbonzini@redhat.com>
 <20220221162243.683208-12-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221162243.683208-12-pbonzini@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022, Paolo Bonzini wrote:
> kvm_calc_shadow_root_page_role_common is the same as
> kvm_calc_cpu_mode except for the level, which is overwritten
> afterwards in kvm_calc_shadow_mmu_root_page_role
> and kvm_calc_shadow_npt_root_page_role.
> 
> role.base.direct is already set correctly for the CPU mode,
> and CR0.PG=1 is required for VMRUN so it will also be
> correct for nested NPT.

Bzzzt, this is wrong, the nested NPT MMU is indirect but will be computed as direct.

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 21 ++-------------------
>  1 file changed, 2 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 3ffa6f2bf991..31874fad12fb 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4796,27 +4796,11 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu,
>  	reset_tdp_shadow_zero_bits_mask(context);
>  }
>  
> -static union kvm_mmu_role
> -kvm_calc_shadow_root_page_role_common(struct kvm_vcpu *vcpu,
> -				      const struct kvm_mmu_role_regs *regs)
> -{
> -	union kvm_mmu_role role = kvm_calc_mmu_role_common(vcpu, regs);
> -
> -	role.base.smep_andnot_wp = role.ext.cr4_smep && !____is_cr0_wp(regs);
> -	role.base.smap_andnot_wp = role.ext.cr4_smap && !____is_cr0_wp(regs);
> -	role.base.has_4_byte_gpte = ____is_cr0_pg(regs) && !____is_cr4_pae(regs);
> -
> -	return role;
> -}
> -
>  static union kvm_mmu_role
>  kvm_calc_shadow_mmu_root_page_role(struct kvm_vcpu *vcpu,
>  				   const struct kvm_mmu_role_regs *regs)
>  {
> -	union kvm_mmu_role role =
> -		kvm_calc_shadow_root_page_role_common(vcpu, regs);
> -
> -	role.base.direct = !____is_cr0_pg(regs);
> +	union kvm_mmu_role role = kvm_calc_cpu_mode(vcpu, regs);
>  
>  	if (!____is_efer_lma(regs))
>  		role.base.level = PT32E_ROOT_LEVEL;
> @@ -4869,9 +4853,8 @@ kvm_calc_shadow_npt_root_page_role(struct kvm_vcpu *vcpu,
>  				   const struct kvm_mmu_role_regs *regs)
>  {
>  	union kvm_mmu_role role =
> -		kvm_calc_shadow_root_page_role_common(vcpu, regs);
> +               kvm_calc_cpu_mode(vcpu, regs);

No need to split this line with the less verbose name.

>  
> -	role.base.direct = false;

As above, this line needs to stay.

>  	role.base.level = kvm_mmu_get_tdp_level(vcpu);
>  
>  	return role;
> -- 
> 2.31.1
> 
> 
