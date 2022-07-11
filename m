Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CA9570652
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 16:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiGKO4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 10:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiGKO4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 10:56:35 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC48571BC1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 07:56:33 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id o18so4927377pgu.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 07:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3+iOhYm5m5ryVsh6j+fvjnI4Rfo7Ca22Rrvor4EkRvU=;
        b=DYiXCU7qoygF17O0LWqvkzaFglZoWfbOLX+t0kfP0XggKmfv8oF1pGaE3oHz4wnSh/
         UApcn654dX2cOuxxl0hBop8U+LVF2pQV8d5xhOL2aAroTRBowfXsWnm6QxHXxnqypyYF
         IPuu9rLUANAH08JMPQw5kXUwtastU3TEj3E00YOAFPCjeS1vqMIPJCy/tm4YRsPYvd5h
         Y7TMLpeFLy5/1YYGHUSQwQwULPsyMBElRe3ItwT4icPwMcy2dkhUUinT2n3leAyLHYV4
         oj+pTxIoqgTr075BZshB250y0poddl9LkF9bSeAhUaNl+9xrEqyUl6yDlebY+GEWYrtD
         fpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3+iOhYm5m5ryVsh6j+fvjnI4Rfo7Ca22Rrvor4EkRvU=;
        b=u2ELWacLheDydaEYCM4t1TtdFYwfufmi222SqYiplhYKgIxQ20Xw0/CkHCpu2zDZ7i
         dNKMnh9jOFqudra0uWbcr1vwarG8SwdmH+DY6tu6Wq2mjPQgJEsTmvNzrUIFXO+TGgTN
         r6+eSatlUe3Fhaz5IQzK/sXYKuVUrGZo7fJfxrMfjV3Qf8C79FP8V8B3Q94YlqvqsHrT
         qGvAz38EPeAdqpoQT857jw6ZpQAlYbi3FWGCcJqrlqlGl8B+NqaJPKsV+MOz7ebkfh2H
         PrOBQKReE8vI+MRDlo57aCy8S9nypxMPXqlBm1KOII7ORxDnFJeOdDPz2j61K8wKO6LN
         fR+w==
X-Gm-Message-State: AJIora8Tx7LidtmlD3fyI6ZsTBx0DRI+b/j/Pu+TYv2u4uCuOAxFdoYh
        qErpJbiapgQ94rqz22W1EIsWsw==
X-Google-Smtp-Source: AGRyM1tD5FLJm9utZyMOONa7Crgl1trLeTWMauVgyscm0Xm4ffO2NG2ev7JJYLskSEzfyoDne0B/Lg==
X-Received: by 2002:a05:6a00:134e:b0:52a:d5b4:19bb with SMTP id k14-20020a056a00134e00b0052ad5b419bbmr3587768pfu.45.1657551393173;
        Mon, 11 Jul 2022 07:56:33 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id k10-20020aa7998a000000b0052ab0a7375fsm4813900pfh.209.2022.07.11.07.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 07:56:32 -0700 (PDT)
Date:   Mon, 11 Jul 2022 14:56:29 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     isaku.yamahata@intel.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        isaku.yamahata@gmail.com, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v7 043/102] KVM: x86/mmu: Focibly use TDP MMU for TDX
Message-ID: <Ysw6HdGSIECkP5RC@google.com>
References: <cover.1656366337.git.isaku.yamahata@intel.com>
 <c198d2be26aa9a041176826cf86b51a337427783.1656366338.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c198d2be26aa9a041176826cf86b51a337427783.1656366338.git.isaku.yamahata@intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/Focibly/Forcibly, but that's a moot point because KVM shouldn't override the
the module param.  KVM should instead _require_ the TDP MMU to be enabled.  E.g.
if userspace disables the TDP MMU to workaround a fatal bug, then forcing the TDP
MMU may silently expose KVM to said bug.

And overriding tdp_enabled is just mind-boggling broken, all of the SPTE masks
will be wrong.

On Mon, Jun 27, 2022, isaku.yamahata@intel.com wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> In this patch series, TDX supports only TDP MMU and doesn't support legacy
> MMU.  Forcibly use TDP MMU for TDX irrelevant of kernel parameter to
> disable TDP MMU.

Do not refer to the "patch series", instead phrase the statement with respect to
what KVM support.

  Require the TDP MMU for TDX guests, the so called "shadow" MMU does not
  support mapping guest private memory, i.e. does not support Secure-EPT.

> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---
>  arch/x86/kvm/mmu/tdp_mmu.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index 82f1bfac7ee6..7eb41b176d1e 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -18,8 +18,13 @@ int kvm_mmu_init_tdp_mmu(struct kvm *kvm)
>  {
>  	struct workqueue_struct *wq;
>  
> -	if (!tdp_enabled || !READ_ONCE(tdp_mmu_enabled))
> -		return 0;
> +	/*
> +	 *  Because TDX supports only TDP MMU, forcibly use TDP MMU in the case
> +	 *  of TDX.
> +	 */
> +	if (kvm->arch.vm_type != KVM_X86_TDX_VM &&
> +		(!tdp_enabled || !READ_ONCE(tdp_mmu_enabled)))
> +		return false;

Yeah, no.

	if (!tdp_enabled || !READ_ONCE(tdp_mmu_enabled))
		return kvm->arch.vm_type == KVM_X86_TDX_VM ? -EINVAL : 0;

>  
>  	wq = alloc_workqueue("kvm", WQ_UNBOUND|WQ_MEM_RECLAIM|WQ_CPU_INTENSIVE, 0);
>  	if (!wq)
> -- 
> 2.25.1
> 
