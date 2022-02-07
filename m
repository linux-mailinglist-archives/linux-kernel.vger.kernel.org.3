Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF994ACC09
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 23:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244492AbiBGWZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 17:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244451AbiBGWZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 17:25:51 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002A1C06109E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 14:25:50 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id v74so15491871pfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 14:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JKKByTaqxwBETFgifuJGqMvFg0/F2eEogOf15wsQKv0=;
        b=NbyPzld53eTimR/fpMxmGI7Wm69fxft6mLphoK4914TdhrqdtbPZTrArO81lodDHt8
         /l/YWsRIi6ka2wbOcEX2QpmraG46HaWq1GMspikF/Qsdzj+EDSaM3N2WzIQklIFhGdaa
         o+ArZdNn28MtPMXmgZr2GndTWsaCVhi9Tudn5K4hN43y6EzoAFuvatiglo5mL+B1ZErB
         BMMGuPR0gehBxGmRBeh2DwvHS6rxiKz1DJGDqBcj0L66D7/wDDIEwWkZbSMEaWXfd22n
         x4l+YxcZw9f+IzFq/jar629/1uWsjJxs6PaLSRdcIbxgIAqtPQow9vioIIM2eHUBxXvW
         LHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JKKByTaqxwBETFgifuJGqMvFg0/F2eEogOf15wsQKv0=;
        b=0DTb+i+0jz93wSJXz3WGonHY5dv4QGv0OxcUsDkDtQhc1PnAJYRorU7yknWWkxRn6F
         EWMk3WdvFM+xTjpQoC2LDoeS9sxBoYvVM/eypmK5D1mRIwId4uWX5zoxqZKqz/EAcjRf
         NMOzZkxzcy4yR9hOTip58RjVWDxJOFjB3XzNLyiy1qB9TOX2vNP9i49ouuTz6sn0bbmX
         6xrBzMI5tzXOtnJlK6d16HzQ2GuoJkPIgYssrtpkle4qpzN3NOZW8Xbjkm3CzXt1AV0b
         mSubFzSS9VXs/xn3PI1jv43BFYht/5kjGfvcoKxl/sDCUkzuzI7bcy/ev3y6rUsHR/lL
         J44g==
X-Gm-Message-State: AOAM533ScC4P8Jrku5b0QOpyAWxso4clGAuvMKgiYJHLrfgNYmlBC8hi
        cR9gHoJs3nMVhAODmcwkuL/MDQ==
X-Google-Smtp-Source: ABdhPJw2GiXbzYApnPpFCG3QBzOoEg1ES9DoDLuTdiofLWgz85dQUsRxQnQHdWtzQ5l4siviT6EH1w==
X-Received: by 2002:a63:1517:: with SMTP id v23mr648351pgl.207.1644272750296;
        Mon, 07 Feb 2022 14:25:50 -0800 (PST)
Received: from google.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id g2sm12989560pfj.83.2022.02.07.14.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 14:25:49 -0800 (PST)
Date:   Mon, 7 Feb 2022 22:25:46 +0000
From:   David Matlack <dmatlack@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        seanjc@google.com, vkuznets@redhat.com
Subject: Re: [PATCH 13/23] KVM: MMU: remove
 kvm_calc_shadow_root_page_role_common
Message-ID: <YgGcagaLENvf3Y/t@google.com>
References: <20220204115718.14934-1-pbonzini@redhat.com>
 <20220204115718.14934-14-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204115718.14934-14-pbonzini@redhat.com>
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

On Fri, Feb 04, 2022 at 06:57:08AM -0500, Paolo Bonzini wrote:
> kvm_calc_shadow_root_page_role_common is the same as
> kvm_calc_cpu_role except for the level, which is overwritten
> afterwards in kvm_calc_shadow_mmu_root_page_role
> and kvm_calc_shadow_npt_root_page_role.
> 
> role.base.direct is already set correctly for the CPU role,
> and CR0.PG=1 is required for VMRUN so it will also be
> correct for nested NPT.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: David Matlack <dmatlack@google.com>

> ---
>  arch/x86/kvm/mmu/mmu.c | 21 ++-------------------
>  1 file changed, 2 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index d6b5d8c1c0dc..19abf1e4cee9 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4772,27 +4772,11 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu,
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
> +	union kvm_mmu_role role = kvm_calc_cpu_role(vcpu, regs);
>  
>  	if (!____is_efer_lma(regs))
>  		role.base.level = PT32E_ROOT_LEVEL;
> @@ -4853,9 +4837,8 @@ kvm_calc_shadow_npt_root_page_role(struct kvm_vcpu *vcpu,
>  				   const struct kvm_mmu_role_regs *regs)
>  {
>  	union kvm_mmu_role role =
> -		kvm_calc_shadow_root_page_role_common(vcpu, regs);
> +               kvm_calc_cpu_role(vcpu, regs);
>  
> -	role.base.direct = false;
>  	role.base.level = kvm_mmu_get_tdp_level(vcpu);
>  
>  	return role;
> -- 
> 2.31.1
> 
> 
