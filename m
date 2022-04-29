Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229B951451D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356201AbiD2JNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbiD2JNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:13:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 710C741631
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651223431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pupWbqPYz0UQZt/8VHvKPet4oN1wf/RiLXi2v8R6fSo=;
        b=W+IE+/JW/YQ7iVb5L3uoXLjVuKTUsPHZ+e0CYn4BJOJdpz/1QPDm9Tj+D/tDd6gg/ZFqYe
        HiN4/+F4owQGHTdAZL/iNbJ1sp4pY63+ESNHesOXQZT1Lql6gEbzeXRZJKKvHWRpCb3hTU
        LaLz2HrdKm74lth33RkdgMQLxRcipwI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-465-qTdjZjgTPNe128OwyULDcg-1; Fri, 29 Apr 2022 05:10:29 -0400
X-MC-Unique: qTdjZjgTPNe128OwyULDcg-1
Received: by mail-ed1-f71.google.com with SMTP id eg38-20020a05640228a600b00425d61d0302so4174249edb.17
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=pupWbqPYz0UQZt/8VHvKPet4oN1wf/RiLXi2v8R6fSo=;
        b=xz+Q9/TCUEJu85HmFT0EKL7ZpLQC/S5309oNvj3jZmUW2dXtQFbULehbbblT1KP7mV
         PxZ4lfk+AOnYs8DiHwMrKxIA/todXKJNKATWts/daC4iizwCUbKo+NR+PkS4V2i3vW25
         dMJOYJ4SDVZy69WskpzarFbOvOHReS/N10qYKsZ4CTL8W2NFYRf8cj8QbTpJnbolxFcN
         QvbTbxRosA+VjDIo9+/29WtYsJQyYmoOvvH9MjsVxvqjp3tBIjl9tK0YNbKPrs5bSJM3
         y4ArjrFLOjg3Wq2c+WwHR5X3SC7af9zHwis+x3mK2xDs7Wwx8D6MkaPmVXVwr5rw+4Ww
         iVcA==
X-Gm-Message-State: AOAM532uTfUWYxLVJU+RAeUD1F8Q1WR72UxsqD46mVP7XUGNN2MSUIVx
        HE/Ht75bGek/n9Cafk36XhUd6GC3G86a12RljBHrNeWCMu6FAgtmKyigwWpBKIyIImVX2aAdwAU
        MkISAtSLnJtxYog+2LrRIYoj5
X-Received: by 2002:a17:907:3e0e:b0:6f3:845a:8d2d with SMTP id hp14-20020a1709073e0e00b006f3845a8d2dmr27770794ejc.78.1651223428698;
        Fri, 29 Apr 2022 02:10:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaMA9RdgJKXrTdp7tsMOQOsSHWbGyLXCFR0P/WlBVaCjJ+hLH1E7nQItFGn5G7kGCzyWOUIA==
X-Received: by 2002:a17:907:3e0e:b0:6f3:845a:8d2d with SMTP id hp14-20020a1709073e0e00b006f3845a8d2dmr27770774ejc.78.1651223428443;
        Fri, 29 Apr 2022 02:10:28 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id el8-20020a170907284800b006f3ef214e0asm453756ejc.112.2022.04.29.02.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 02:10:27 -0700 (PDT)
Message-ID: <4b0936bf-fd3e-950a-81af-fd393475553f@redhat.com>
Date:   Fri, 29 Apr 2022 11:10:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220429031757.2042406-1-mizhang@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: x86/mmu: fix potential races when walking host page
 table
In-Reply-To: <20220429031757.2042406-1-mizhang@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/22 05:17, Mingwei Zhang wrote:
> @@ -2838,11 +2836,7 @@ static int host_pfn_mapping_level(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
>   	 */
>   	hva = __gfn_to_hva_memslot(slot, gfn);
>   
> -	pte = lookup_address_in_mm(kvm->mm, hva, &level);
> -	if (unlikely(!pte))
> -		return PG_LEVEL_4K;
> -
> -	return level;
> +	return kvm_lookup_address_level_in_mm(kvm, hva);
>   }

The function can be just inlined in host_pfn_mapping_level.

>   int kvm_mmu_max_mapping_level(struct kvm *kvm,
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 951d0a78ccdae..61406efe4ea7f 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -13044,6 +13044,76 @@ int kvm_sev_es_string_io(struct kvm_vcpu *vcpu, unsigned int size,
>   }
>   EXPORT_SYMBOL_GPL(kvm_sev_es_string_io);
>   
> +/*
> + * Lookup the valid mapping level for a virtual address in the current mm.
> + * Return the level of the mapping if there is present one. Otherwise, always
> + * return PG_LEVEL_NONE.

This is a change in semantics, because host_pfn_mapping_level never 
returned PG_LEVEL_NONE.  Returning PG_LEVEL_4K for a non-present entry 
is safe; if it happens, MMU notifiers will force a retry.  If the 
function is inlined in host_pfn_mapping_level, returning PG_LEVEL_4K 
would allow making the semantic change in a separate patch.

In fact, kvm_mmu_hugepage_adjust will go on and set fault->req_level and 
fault->goal_level to PG_LEVEL_NONE, which is wrong even if it does not 
cause havoc.

> + * Note: the information retrieved may be stale. Use it with causion.

The comment should point out that mmu_notifier_retry make it safe to use 
the stale value---of course this is only true if 
kvm_lookup_address_level_in_mm is used where mmu_notifier_retry is used, 
and might be another point in favor of inlining.

> +	ptep = pte_offset_map(&pmd, address);
> +	pte = ptep_get(ptep);
> +	if (pte_present(pte)) {
> +		pte_unmap(ptep);
> +		level = PG_LEVEL_4K;
> +		goto out;
> +	}
> +	pte_unmap(ptep);

Not needed as long as PG_LEVEL_4K is returned for a non-present PTE.

> +out:
> +	local_irq_restore(flags);
> +	return level;
> +}
> +EXPORT_SYMBOL_GPL(kvm_lookup_address_level_in_mm);

Exporting is not needed.

Thanks for writing the walk code though.  I'll adapt it and integrate 
the patch.

Paolo

>   EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_entry);
>   EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_exit);
>   EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_fast_mmio);
> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index 588792f003345..f1cdcc8483bd0 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -454,4 +454,6 @@ int kvm_sev_es_string_io(struct kvm_vcpu *vcpu, unsigned int size,
>   			 unsigned int port, void *data,  unsigned int count,
>   			 int in);
>   
> +int kvm_lookup_address_level_in_mm(struct kvm *kvm, unsigned long address);
> +
>   #endif
> 
> base-commit: 2a39d8b39bffdaf1a4223d0d22f07baee154c8f3

