Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57293511F78
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243083AbiD0Q1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242940AbiD0Q0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:26:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDE5956F8F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651076377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j1g4Lo5UORRm0vFgOwsRrO7418gb/Lu+Zn38d1Vgpl4=;
        b=SHPMDaj5xGPmSOodmUPzixK7/wSmJ4MSqk/GrKhvFylNq/FrKuegxdWdb245FCpnT9Elc0
        HjS4fVmccpvrZWC5Fdyt4JC7GWXW2sCGJJTYRXpTydcRva7p2KggVe8aZDCzfafXz4b5BU
        9F686ZGiTu3OGa+4W30hLRzMnyrR42Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-8UspmCuOMKWl4eIJ3rM0fg-1; Wed, 27 Apr 2022 12:19:35 -0400
X-MC-Unique: 8UspmCuOMKWl4eIJ3rM0fg-1
Received: by mail-ed1-f72.google.com with SMTP id cn27-20020a0564020cbb00b0041b5b91adb5so1258151edb.15
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j1g4Lo5UORRm0vFgOwsRrO7418gb/Lu+Zn38d1Vgpl4=;
        b=BzACGuHilb/XPiXB1snYNMQxWYx1iOZJW6ORa8zw7nV7h3e73KnMbWJCVL01Zsz0Lo
         WSGki2Pgz90w9dV0Rl+pFGn8KYFrshnc/PpBZZQL68+KXYb7QmwrBgsFyF/BoX6i4cmK
         w8JJVEYY/GXgDpq4vI5X8tpOi7wz6h+j5TrxvwEFHjBI6Elig8/0fxy5xeOMtumTkv6o
         qwzW+jOR/G8WRhrdheKCICCiWt6H8B4IfZRD1E92Ir2NvBFoRJFMJR+XtFsVCPe8UAKE
         PBKRkAxRT7DxcryGXp5v5EurFoZy6tF+H7WMDN071akm1NrRMrx9M1RshpZBCguvTNuP
         UaJw==
X-Gm-Message-State: AOAM531vHRCFloC0spIlBlbv3rI4nxsYHTCLvJl4AQDaRrMpimr+i32m
        EHf0QEG0q1hjvHVVpVaPkw+4lWOXb7FKz2iHPLNsFQltAUnRY7+qbFazZy49aWmb85wLZM/BbaG
        W670ZeL5fu9dZEvfWU0YcqyVC
X-Received: by 2002:a17:907:3e2a:b0:6f3:aa0c:ab94 with SMTP id hp42-20020a1709073e2a00b006f3aa0cab94mr10805950ejc.23.1651076374584;
        Wed, 27 Apr 2022 09:19:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjZ6W9xmB5XG3x6XEQmtkDBUgc5GdXJZS/TzhSKPE/kMrcxbEZy+QKYLx6jksmh7d3X6pSNw==
X-Received: by 2002:a17:907:3e2a:b0:6f3:aa0c:ab94 with SMTP id hp42-20020a1709073e2a00b006f3aa0cab94mr10805925ejc.23.1651076374380;
        Wed, 27 Apr 2022 09:19:34 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id ah14-20020a1709069ace00b006f38e912d3dsm4816355ejc.99.2022.04.27.09.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 09:19:33 -0700 (PDT)
Message-ID: <17052637-912d-fee2-094c-d043355e682a@redhat.com>
Date:   Wed, 27 Apr 2022 18:19:32 +0200
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
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
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

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

