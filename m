Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C73654E56D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 16:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377323AbiFPOyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 10:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbiFPOys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 10:54:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B87CE2BB1E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 07:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655391285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1cICD+IJ7/ONnZC/LuWzYTAkQtdI3gcDnjHQFrlNn6s=;
        b=CMHUCruMM+cGLA1rUqthgTk3l2ARntw4SSePv27TWKA1gxwjMbGvvpx1vZQ8C3hF3+qH1l
        4/YwPr3/gHMFJu+81S5rzJquDJZqbhWczT0UNX8jqcPIlG1kBpi1OWr7pP/n9gib/4/DET
        PbjPUVRrMQ/aW/xFviiGQ2BA1kCGbzc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-oUCb3boEMrCkrfYYPhKn9A-1; Thu, 16 Jun 2022 10:54:40 -0400
X-MC-Unique: oUCb3boEMrCkrfYYPhKn9A-1
Received: by mail-ej1-f69.google.com with SMTP id z7-20020a170906434700b007108b59c212so721220ejm.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 07:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1cICD+IJ7/ONnZC/LuWzYTAkQtdI3gcDnjHQFrlNn6s=;
        b=cgS1pmbsYfd/xucuknncRLIkKYknseNpP4rE5xScp+oNbSCsW7nsLaybvtkYIIRmQw
         rmckhG57g2g4dFG1nWXZTbT7ELLIHAnrhYtCUea5BynGNbWhzbF2bfU+/+VjWhSJkYJG
         6Y8U9n5kdNFdkHDEfIy62LwzxMOYPxQ8mW0fzKYJN5MjmNvf9SD4nmIzt6xFP+LSqRAz
         6Y7l5kpCWEC8nFjh7WpQWWBM4LnIFFBwMcUaR907q0++/KZg5Tx+LSMcGjQU7Rh4otIZ
         R/FXGaovfMcrjaAtAyTCHs0dI4fZm4rwilqNLlsUCjXp4g11QAMyuRRiHjI101/SsMnk
         MTIg==
X-Gm-Message-State: AJIora/6arLKobpmanTCzR0+fiu+OFoHYjX/sctWaM+h9oZ4n7VeLZ04
        wwk2EgyhsP4ZJzfI8TcSq1Qeq01vBUTbdShuHfSpPqfhAujqLjeK4x8xvgWp4bCbnZeAEtApvtE
        Kag0S5ARRrRuctpTQMdDhMsQz
X-Received: by 2002:a05:6402:11d1:b0:433:4a09:3f49 with SMTP id j17-20020a05640211d100b004334a093f49mr6891859edw.357.1655391275523;
        Thu, 16 Jun 2022 07:54:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tz5m+CaNItXHHf5d7bcmJBR3NWAYfylhg778tBfOwYbogq00BMubl8ww1j2446kZCToO+fSw==
X-Received: by 2002:a05:6402:11d1:b0:433:4a09:3f49 with SMTP id j17-20020a05640211d100b004334a093f49mr6891844edw.357.1655391275329;
        Thu, 16 Jun 2022 07:54:35 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id h18-20020a056402281200b0043173ab6728sm2090037ede.7.2022.06.16.07.54.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 07:54:34 -0700 (PDT)
Message-ID: <3dccee6c-8682-66c8-6a22-e58630825443@redhat.com>
Date:   Thu, 16 Jun 2022 16:54:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 01/10] KVM: Do not zero initialize 'pfn' in hva_to_pfn()
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220429010416.2788472-1-seanjc@google.com>
 <20220429010416.2788472-2-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220429010416.2788472-2-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/22 03:04, Sean Christopherson wrote:
> Drop the unnecessary initialization of the local 'pfn' variable in
> hva_to_pfn().  First and foremost, '0' is not an invalid pfn, it's a
> perfectly valid pfn on most architectures.  I.e. if hva_to_pfn() were to
> return an "uninitializd" pfn, it would actually be interpeted as a legal
> pfn by most callers.
> 
> Second, hva_to_pfn() can't return an uninitialized pfn as hva_to_pfn()
> explicitly sets pfn to an error value (or returns an error value directly)
> if a helper returns failure, and all helpers set the pfn on success.
> 
> Note, the zeroing of 'pfn' was introduced by commit 2fc843117d64 ("KVM:
> reorganize hva_to_pfn"), and was unnecessary and misguided paranoia even
> then.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   virt/kvm/kvm_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 0848430f36c6..04ed4334473c 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2567,7 +2567,7 @@ kvm_pfn_t hva_to_pfn(unsigned long addr, bool atomic, bool *async,
>   		     bool write_fault, bool *writable)
>   {
>   	struct vm_area_struct *vma;
> -	kvm_pfn_t pfn = 0;
> +	kvm_pfn_t pfn;
>   	int npages, r;
>   
>   	/* we can do it either atomically or asynchronously, not both */

I wonder if it was needed to avoid uninitialized variable warnings on 
"return pfn;"...

Paolo

