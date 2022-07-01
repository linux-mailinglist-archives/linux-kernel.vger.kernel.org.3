Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC182563410
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 15:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbiGANJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 09:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiGANI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 09:08:57 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01592E696
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 06:08:56 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-101bb9275bcso3449746fac.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 06:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KChte2H+GQGgzLuFF3Cguq7pYgmwTYanbBPncuTfAMs=;
        b=KSuIzE1BB0zTfWAwGuIu8v9r4eTugMyUZCsyrQ1R8whMGosfla2cMrxtMrclif7+rs
         m6EpqBhrbVJG5RkeB9GzGXArf032gaSCEh2/XtcVP3SbNyyyjcv7+86nrROVxXUUYQPW
         5Z7mR4+62aGEpOrTyCC/Ct7wCq+w9GfM0IbAUlTyBvVMiJ8gYiXCZUwhcybCugN0h+E0
         6Ar/AvNRHnM+e9+gbVRMgNyYpfhHtC0s5PMZLN7ItLj4AGknhp/PSiJEjHgei+3JSM1c
         GWdkl2uwPFTz4lKECT4PCkqFyDHmCtNDdYMgRe0VCaGJkMgl9v5lUqXZ6140RclOP+Gw
         hZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KChte2H+GQGgzLuFF3Cguq7pYgmwTYanbBPncuTfAMs=;
        b=JamphWjxAJy7bTDejcQHP0n5AlE2WkB1tQ85bHfLNe3InSHF/lFwNTjtU7vlaE4Gwx
         vz2bJeYwJbKyaucsNJC58YYUIPK+AEIlx55a9E/zkoXx/xuufiy3vxXTZ5I9onHz3fxO
         3F6ElaTIVxA82kNvtQ0V6muInNSH6kALYZtrRr1bADb+Q1Jt1RNfbdm//yKXy2uhRFK7
         zJ2hDt0OE1lNE0Y/9lhR3eN63eqr3RrJi6Nixzwdjk/Jz+DgPmqdefv3vpWQ5x2TsnV+
         3KrxozsbkjH2xrAijMU1/fUkYxOSi1LOjIjgZe8rqeVbYc9kNjYnY5cPD6MK83dUT9vt
         GoNQ==
X-Gm-Message-State: AJIora/PGJySEtCxhQIGw2N0F6Totb3AP4KW1mTOMV98aHHMm9q0eX2J
        IW5kmeidhPPTrycmefcj6Jcbi7zPEiaSedqRa74vyw==
X-Google-Smtp-Source: AGRyM1vAduFxKJgGNeq4OgKjn06zHGpr8i13LXKC6Bg6uNio4tgI7fXFw67CA5Rwoja1UB3xpLFdkkE+nG4PhT70n4I=
X-Received: by 2002:a05:6870:d3c7:b0:104:9120:8555 with SMTP id
 l7-20020a056870d3c700b0010491208555mr8291131oag.181.1656680936157; Fri, 01
 Jul 2022 06:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220701042122.5273-1-liubo03@inspur.com>
In-Reply-To: <20220701042122.5273-1-liubo03@inspur.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 1 Jul 2022 06:08:45 -0700
Message-ID: <CALMp9eSFvTFn5Uogyu2XJbu6gcNL89R7OqbeF1yop650PUhYJw@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/mmu: Return true/false from bool function
To:     Bo Liu <liubo03@inspur.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Jun 30, 2022 at 10:50 PM Bo Liu <liubo03@inspur.com> wrote:
>
> Return boolean values ("true" or "false") instead of integer values
> from bool function.
>
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index bfb50262fd37..572e0c487376 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -1024,7 +1024,7 @@ static bool rmap_can_add(struct kvm_vcpu *vcpu)
>         struct kvm_mmu_memory_cache *mc;
>
>         mc = &vcpu->arch.mmu_pte_list_desc_cache;
> -       return kvm_mmu_memory_cache_nr_free_objects(mc);
> +       return !!kvm_mmu_memory_cache_nr_free_objects(mc);

This is entirely unnecessary, since conversion of any scalar type to
bool already converts 0 to false and non-zero to true.

>  }
>
>  static void rmap_remove(struct kvm *kvm, u64 *spte)
> --
> 2.27.0
>
