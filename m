Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8964D20C6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 19:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347951AbiCHS47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 13:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236164AbiCHS45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:56:57 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21AE54186
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 10:55:58 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id e15so138819pfv.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 10:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y40f+LRCmG2arycVRHxOvpE+w/RZPs9orfaERHReGAg=;
        b=bcCUYI+9/valn64igaiGGIKkFleK2VVOpLQ/Ce62yPauw4vMRigqISiCiyTYqxAkHQ
         +oVGv80ZKvRJwlXg2Qb/+JDkRbq42rqCVi/G5e1TshasTHSKtI8YtwMb1fdI0A7tnzEV
         Lx/0sfSqS/3w3TPB9LX2h7rO3qGKXHQJcXR3QbLzlxKusX0A4VXIU3UMeIBvIEXVatRh
         gg3zEnioIFLtuYv3zudFcUO9XIX1q4qjWEuG2hKNcqxEVEbEO5hS3e9KgITt/QCE5l5l
         hqb5XNkxo6PmRpDSkYz0S8aJMm91uZo/+Ctxa1sVlBOy/w8/4Ja8C7xbWXGwhtctt50d
         n39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y40f+LRCmG2arycVRHxOvpE+w/RZPs9orfaERHReGAg=;
        b=Vp4p5zdTJQ3Otk991nklQ36E+8AENqsD4D2EFIDQm425qwK0dUxR0mDi7ZpGt6FSGu
         K3k6nzO2vcz/QGJg4FEpAI6Wwvfpa5n2GaevfbK1ZjeKyM2ZnuGMRMQx8jPUG3F5SbPl
         5D/TOIH/BTgZeBhShqn/xLNfEiq3gciIvnCFu6Oo/S9zw6nKzuti7w/e0s3lrsaMPx+3
         stHRoxLXoYuogZZtM2FbimtshyzrufkSye3CIpmK4VmRN7o8DHEhEYODOFBBejEo4JY6
         XCM9f8rhkPA3E22cebADh4DAyd1Es+3G0B9fqasf6rmTl4xJdWQdfu1+zQ9k5IvmtyQr
         MwzQ==
X-Gm-Message-State: AOAM53352+WRKl2RNhYFakh5c4Hg+ZnkuXAzkg4/Q58/exOsu88UtHnB
        wkDSSyS9EK/adjxdPI28jFhXdg==
X-Google-Smtp-Source: ABdhPJwcEDBu6JX4mIGKlcpXlcrkdx2/792obZa79cvfvYy/QfjS4SaXi48cxFejeJgdTIyDxVMRiQ==
X-Received: by 2002:a63:698a:0:b0:36c:1d0a:2808 with SMTP id e132-20020a63698a000000b0036c1d0a2808mr15284498pgc.567.1646765757848;
        Tue, 08 Mar 2022 10:55:57 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id q20-20020a056a00151400b004f3cd061d33sm21169799pfu.204.2022.03.08.10.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 10:55:57 -0800 (PST)
Date:   Tue, 8 Mar 2022 18:55:53 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        dmatlack@google.com
Subject: Re: [PATCH v2 08/25] KVM: x86/mmu: split cpu_mode from mmu_role
Message-ID: <YiemuYKEFjqFvDlL@google.com>
References: <20220221162243.683208-1-pbonzini@redhat.com>
 <20220221162243.683208-9-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221162243.683208-9-pbonzini@redhat.com>
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
> @@ -4800,13 +4836,15 @@ kvm_calc_shadow_mmu_root_page_role(struct kvm_vcpu *vcpu,
>  }
>  
>  static void shadow_mmu_init_context(struct kvm_vcpu *vcpu, struct kvm_mmu *context,
> -				    const struct kvm_mmu_role_regs *regs,
> -				    union kvm_mmu_role new_role)
> +				    union kvm_mmu_role cpu_mode,

Can you give all helpers this treatment (rename "role" => "cpu_mode")?  I got
tripped up a few times reading patches because the ones where it wasn't necessary,
i.e. where there's only a single kvm_mmu_role paramenter, were left as-is.

I think kvm_calc_shadow_npt_root_page_role() and kvm_calc_shadow_mmu_root_page_role()
are the only offenders.

> +				    union kvm_mmu_role mmu_role)
>  {
> -	if (new_role.as_u64 == context->mmu_role.as_u64)
> +	if (cpu_mode.as_u64 == context->cpu_mode.as_u64 &&
> +	    mmu_role.as_u64 == context->mmu_role.as_u64)
>  		return;
>  
> -	context->mmu_role.as_u64 = new_role.as_u64;
> +	context->cpu_mode.as_u64 = cpu_mode.as_u64;
> +	context->mmu_role.as_u64 = mmu_role.as_u64;
>  
>  	if (!is_cr0_pg(context))
>  		nonpaging_init_context(context);
