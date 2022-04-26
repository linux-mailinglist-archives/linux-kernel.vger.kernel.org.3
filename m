Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2DF50F29D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238662AbiDZHiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238496AbiDZHiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:38:09 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F04248
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:35:01 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id g10so2831136ilf.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T6uVKqz/bxBh0XcbvcuRA0UyoUPF9VXe65F1cQD8y4Q=;
        b=ObEunFSl4crRLGfpGD9vb4uNjucdcW+SwMC5wjs68ErQM98eX2dd/1bhFqvb4MQrUZ
         aNBQiYOEZs6DAFrjwy4GxIX9P710BE5dNtb9ren8SoNbyoDCq1JSrqMW6bcxyN3g457u
         /+gBpA8szyFlMBKjZqPcqtIcg53tpCAgbfmBRZ+EQiSDL0bYkiLUkJAuAA+ESILGYbW5
         jVcb61+A+66M7v7MKaJKTdQY27E/r9amtlm20dB0rHCxpqld0qjq5eRsqvCmPNleg1uA
         MTGwgfxKApBNNdQAeaBp8qoeybFa8FJ6gos+fYTUTeB4wg78apx7w8FkSb2oMxvxLXSe
         mDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T6uVKqz/bxBh0XcbvcuRA0UyoUPF9VXe65F1cQD8y4Q=;
        b=sDy21wQB8KgLvyful5kxI4sUxeBz1G/7swhvWnzW62bOyJMOBf0hjd5byEicXW3D3h
         fYbsUtTmM1qbUj2fxEpTBrdJkfiARxmoWT0h9W1Icf0fYU2pKxh2vTDvKbp+dBskiwqN
         XtUh1SevKelgY5am06D+bhUdiTGYJ9b1VKXUmK/RNR2lDA8GobLGZDCbhl2crk2qnggu
         rO71TjzS6d4iW/L0sU3kcZvSY0UEWuD+smunVD94N62hY/PKKvUrQwuuTGkTuu9/hIOX
         Lcq0yLUrw60QZ6Qr6CDgj9gMONrU6t91MmhuoZq9XKb1pU49zYf902VqWVvlRdLH+WBE
         0kaQ==
X-Gm-Message-State: AOAM531qyDoRkHCYghe0hjjdEZSca817Y1wBm22FhSEOn9M1sQUR/Rrm
        fyphLNSNaMh+9G5yiSdHKy9kVw==
X-Google-Smtp-Source: ABdhPJzzgIPYx4mfeq03H4D4LkohxnIEdiAlT4JnSJ/rUPy7BWzzJro8BOalbut4cMQo3UF9wiXwfw==
X-Received: by 2002:a05:6e02:b23:b0:2cd:89db:f685 with SMTP id e3-20020a056e020b2300b002cd89dbf685mr5194103ilu.296.1650958500701;
        Tue, 26 Apr 2022 00:35:00 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id w5-20020a05660205c500b006546d0b5f6dsm9257784iox.41.2022.04.26.00.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 00:34:59 -0700 (PDT)
Date:   Tue, 26 Apr 2022 07:34:56 +0000
From:   Oliver Upton <oupton@google.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Marc Zyngier <maz@kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v3 4/6] KVM: arm64/mmu: count KVM page table pages in
 pagetable stats
Message-ID: <YmegoB/fBkfwaE5z@google.com>
References: <20220426053904.3684293-1-yosryahmed@google.com>
 <20220426053904.3684293-5-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426053904.3684293-5-yosryahmed@google.com>
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

Hi Yosry,

On Tue, Apr 26, 2022 at 05:39:02AM +0000, Yosry Ahmed wrote:
> Count the pages used by KVM in arm64 for page tables in pagetable stats.
> 
> Account pages allocated for PTEs in pgtable init functions and
> kvm_set_table_pte().
> 
> Since most page table pages are freed using put_page(), add a helper
> function put_pte_page() that checks if this is the last ref for a pte
> page before putting it, and unaccounts stats accordingly.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  arch/arm64/kernel/image-vars.h |  3 ++
>  arch/arm64/kvm/hyp/pgtable.c   | 50 +++++++++++++++++++++-------------
>  2 files changed, 34 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
> index 241c86b67d01..25bf058714f6 100644
> --- a/arch/arm64/kernel/image-vars.h
> +++ b/arch/arm64/kernel/image-vars.h
> @@ -143,6 +143,9 @@ KVM_NVHE_ALIAS(__hyp_rodata_end);
>  /* pKVM static key */
>  KVM_NVHE_ALIAS(kvm_protected_mode_initialized);
>  
> +/* Called by kvm_account_pgtable_pages() to update pagetable stats */
> +KVM_NVHE_ALIAS(__mod_lruvec_page_state);
> +
>  #endif /* CONFIG_KVM */
>  
>  #endif /* __ARM64_KERNEL_IMAGE_VARS_H */
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index 2cb3867eb7c2..53e13c3313e9 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -152,6 +152,7 @@ static void kvm_set_table_pte(kvm_pte_t *ptep, kvm_pte_t *childp,
>  
>  	WARN_ON(kvm_pte_valid(old));
>  	smp_store_release(ptep, pte);
> +	kvm_account_pgtable_pages((void *)childp, +1);

What page tables do we want to account? KVM on ARM manages several page
tables.

For regular KVM, the host kernel manages allocations for the hyp stage 1
tables in addition to the stage 2 tables used for a particular VM. The
former is system overhead whereas the latter could be attributed to a
guest VM.

I imagine protected KVM is out of scope, since it actually manages its
own allocations outside of the host kernel.

Given this, I would recommend adding the accounting hooks to mmu.c as
that is where we alloc/free table pages and it is in the host address
space. kvm_s2_mm_ops and kvm_hyp_mm_ops point to all the relevant
functions, though the latter is only relevant if we want to count system
page tables too.

--
Thanks,
Oliver
