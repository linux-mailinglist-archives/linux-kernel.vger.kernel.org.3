Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95977511D63
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242677AbiD0Q1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243304AbiD0Q0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:26:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21C4D554A5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651076437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=83+lExEquq/TP/9hyzfhpR3+5YzqAxqbFTxiC98HG4o=;
        b=XegGqXE/uPqh7tZLz6QgTD5HpFQxGb43DH28TRkFVbaG15s3m0fzSSK4sxSQ5qD3dKm3Y9
        LYP9Uff1fLF3epwN+8SECX571gdD/v1GcCZGQ5ouM0LZKQLvCngWOUh2ZgPSK3WyK3r97W
        gmQ7zYloU9Br5WSv6GUduscXf8QADq4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-jvP5pl_vMGCtcpGjqBAEKQ-1; Wed, 27 Apr 2022 12:20:36 -0400
X-MC-Unique: jvP5pl_vMGCtcpGjqBAEKQ-1
Received: by mail-ed1-f70.google.com with SMTP id k13-20020a50ce4d000000b00425e4447e64so1248878edj.22
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=83+lExEquq/TP/9hyzfhpR3+5YzqAxqbFTxiC98HG4o=;
        b=ZrEyT2OQKOa5KQR7uJu0Dwswg6wRpsMMqY3RdO2aYf4AXqISsEnStPO9BjtS7yvBf1
         ZUG5/xRS9FNcEN7LFSf8Be5V+w0gs6Yfm+XtxNfzjRE92cMyVKncawD0APgTCOudd4Aa
         rqYJ1ZW+xeHOdumcZ8/+lkxPr4ELjTYtrVqny4d1tiwt+olrstaUM32K1Rki97MeVYgT
         7n6t2BPEwXcsE6e4Tet1kiztXhDYnFGgeqfgMaasysC22LZ6Mbo6xUgS+XWvYAE0mQtq
         whL764rTBGquS+MJmGm7mvppoMcgk59AOAKWSzCVnsaH2S0NSRguVDUJjJpowFWI+4cc
         TssQ==
X-Gm-Message-State: AOAM532mJXaxUkz8RuHpXqRXzlZ0S2fDEsIiiS8yQoM+3u/vV3WU4IHb
        tm3yuNM3gXJkpEL+QP9LK1ji2E7SGezpH7Hj/6Wt2xvW8oA0FDjWXvzX1X01nMtGorYdUEEbcsE
        ac0WUbxgtw1OcAKqJ714GNxRD
X-Received: by 2002:a05:6402:5114:b0:423:f33d:b3c with SMTP id m20-20020a056402511400b00423f33d0b3cmr31024567edd.199.1651076435254;
        Wed, 27 Apr 2022 09:20:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaQWQ7Wg8rNXXtZJlFyprY45cox4R7Vhp7rOOBvcOlg0SxHaS5dn6YgLEo3JBObuGlKPU+uQ==
X-Received: by 2002:a05:6402:5114:b0:423:f33d:b3c with SMTP id m20-20020a056402511400b00423f33d0b3cmr31024545edd.199.1651076435023;
        Wed, 27 Apr 2022 09:20:35 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id v17-20020a1709060b5100b006f38cf075cbsm4929985ejg.104.2022.04.27.09.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 09:20:33 -0700 (PDT)
Message-ID: <eed92d33-cfd7-80cf-3474-4d38e6da4ea5@redhat.com>
Date:   Wed, 27 Apr 2022 18:20:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH MANUALSEL 5.15 4/7] KVM: x86/mmu: do not allow readers to
 acquire references to invalid roots
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, kvm@vger.kernel.org
References: <20220427155431.19458-1-sashal@kernel.org>
 <20220427155431.19458-4-sashal@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220427155431.19458-4-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/22 17:54, Sasha Levin wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> [ Upstream commit 614f6970aa70242a3f8a8051b01244c029f77b2a ]
> 
> Remove the "shared" argument of for_each_tdp_mmu_root_yield_safe, thus ensuring
> that readers do not ever acquire a reference to an invalid root.  After this
> patch, all readers except kvm_tdp_mmu_zap_invalidated_roots() treat
> refcount=0/valid, refcount=0/invalid and refcount=1/invalid in exactly the
> same way.  kvm_tdp_mmu_zap_invalidated_roots() is different but it also
> does not acquire a reference to the invalid root, and it cannot see
> refcount=0/invalid because it is guaranteed to run after
> kvm_tdp_mmu_invalidate_all_roots().
> 
> Opportunistically add a lockdep assertion to the yield-safe iterator.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   arch/x86/kvm/mmu/tdp_mmu.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index 853780eb033b..7e854313ec3b 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -155,14 +155,15 @@ static struct kvm_mmu_page *tdp_mmu_next_root(struct kvm *kvm,
>   	for (_root = tdp_mmu_next_root(_kvm, NULL, _shared, _only_valid);	\
>   	     _root;								\
>   	     _root = tdp_mmu_next_root(_kvm, _root, _shared, _only_valid))	\
> -		if (kvm_mmu_page_as_id(_root) != _as_id) {			\
> +		if (kvm_lockdep_assert_mmu_lock_held(_kvm, _shared) &&		\
> +		    kvm_mmu_page_as_id(_root) != _as_id) {			\
>   		} else
>   
>   #define for_each_valid_tdp_mmu_root_yield_safe(_kvm, _root, _as_id, _shared)	\
>   	__for_each_tdp_mmu_root_yield_safe(_kvm, _root, _as_id, _shared, true)
>   
> -#define for_each_tdp_mmu_root_yield_safe(_kvm, _root, _as_id, _shared)		\
> -	__for_each_tdp_mmu_root_yield_safe(_kvm, _root, _as_id, _shared, false)
> +#define for_each_tdp_mmu_root_yield_safe(_kvm, _root, _as_id)			\
> +	__for_each_tdp_mmu_root_yield_safe(_kvm, _root, _as_id, false, false)
>   
>   #define for_each_tdp_mmu_root(_kvm, _root, _as_id)				\
>   	list_for_each_entry_rcu(_root, &_kvm->arch.tdp_mmu_roots, link,		\
> @@ -828,7 +829,7 @@ bool __kvm_tdp_mmu_zap_gfn_range(struct kvm *kvm, int as_id, gfn_t start,
>   {
>   	struct kvm_mmu_page *root;
>   
> -	for_each_tdp_mmu_root_yield_safe(kvm, root, as_id, false)
> +	for_each_tdp_mmu_root_yield_safe(kvm, root, as_id)
>   		flush = zap_gfn_range(kvm, root, start, end, can_yield, flush,
>   				      false);
>   

Sorry no, this is a NACK.

Paolo

