Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F41511D14
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241604AbiD0Q1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243225AbiD0Q0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:26:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4852C22CAA1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651076355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=++UuqgJt9YgxlZT4xRTgU+kEGmMRwOlAsDaCv/rlgcE=;
        b=K0SWNlyR8B5b08PdVCuo76ImJYl1KtSrMOsE1GAQrN2c8oN7wJJme2/h7kX39o0mr9vJMr
        4RA/9TTGV07eBhH6e/MCOUiH6us55oVxkpr92cdIHsGOvDkNRJjEUGlr7o1nlufY76aKW/
        vpSj0o1aTvCrBSltwOinCqkHrOQosn0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-t20E7k64OEmftX28AA2SeA-1; Wed, 27 Apr 2022 12:19:13 -0400
X-MC-Unique: t20E7k64OEmftX28AA2SeA-1
Received: by mail-ed1-f72.google.com with SMTP id ee56-20020a056402293800b00425b0f5b9c6so1256833edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:19:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=++UuqgJt9YgxlZT4xRTgU+kEGmMRwOlAsDaCv/rlgcE=;
        b=xq9RHcLsnrsbCKKU8qByYJZkL67myA7UpsUqOS7Eg9YTHS/udn5LDOsIUG/F96ofg0
         NssUqDC5CJ7CU+y+JPKXuvkb4iTH3Y2+Y7p+ce3LBIWmGUintyuoQOArJHpc10Z9y41i
         ySQC1czjgpEaVrRHzJVyA3Lxc40SMfSno3pLghzB8KLAI8nKz6gDy5Sd/2NlBAjr5AfW
         bJ19vWr/DpyH3Y5tATTeWwVRL7pBhrT+/TMqnTWTsiHxC4BDFM3CwzRQGnN28Cui5brO
         gXcZA9ZMtbTCyK1d9qwQzAb2ISsLTPlXINwKZltERA424mZEeUKxxqwnJNo2jZCidIUy
         3odQ==
X-Gm-Message-State: AOAM531ae7jCb6kmOqU3FzAxY5atfMOchgj5wNmkb3kPc5ucro/WjFS1
        9qKiA6vO3VsFfHghsRZzbwmE6HQdx9HiRJefNsGsGFh9byJhmmRkW2udTiY4glkNgZyexbCGYEu
        4pQN7k9eXJ2YlPfcpvlILg/c8
X-Received: by 2002:a05:6402:400b:b0:425:f59a:c221 with SMTP id d11-20020a056402400b00b00425f59ac221mr13331402eda.307.1651076352252;
        Wed, 27 Apr 2022 09:19:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPfGEmBUJ67ZizyPHjPOEfag4PaOgCK7brbyiJjf81tHh9zOvEYRKi3rSxDx1hdZ20vjrEHg==
X-Received: by 2002:a05:6402:400b:b0:425:f59a:c221 with SMTP id d11-20020a056402400b00b00425f59ac221mr13331379eda.307.1651076352033;
        Wed, 27 Apr 2022 09:19:12 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id cn27-20020a0564020cbb00b00418b0c7fbbfsm8594619edb.32.2022.04.27.09.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 09:19:11 -0700 (PDT)
Message-ID: <5d9b9296-f116-0661-d1c2-6eb7d132e4f0@redhat.com>
Date:   Wed, 27 Apr 2022 18:19:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH MANUALSEL 5.10 3/4] KVM: x86/mmu: avoid NULL-pointer
 dereference on page freeing bugs
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, kvm@vger.kernel.org
References: <20220427155435.19554-1-sashal@kernel.org>
 <20220427155435.19554-3-sashal@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220427155435.19554-3-sashal@kernel.org>
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
> [ Upstream commit 9191b8f0745e63edf519e4a54a4aaae1d3d46fbd ]
> 
> WARN and bail if KVM attempts to free a root that isn't backed by a shadow
> page.  KVM allocates a bare page for "special" roots, e.g. when using PAE
> paging or shadowing 2/3/4-level page tables with 4/5-level, and so root_hpa
> will be valid but won't be backed by a shadow page.  It's all too easy to
> blindly call mmu_free_root_page() on root_hpa, be nice and WARN instead of
> crashing KVM and possibly the kernel.
> 
> Reviewed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   arch/x86/kvm/mmu/mmu.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 99ea1ec12ffe..70ef5b542681 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3140,6 +3140,8 @@ static void mmu_free_root_page(struct kvm *kvm, hpa_t *root_hpa,
>   		return;
>   
>   	sp = to_shadow_page(*root_hpa & PT64_BASE_ADDR_MASK);
> +	if (WARN_ON(!sp))
> +		return;
>   
>   	if (kvm_mmu_put_root(kvm, sp)) {
>   		if (sp->tdp_mmu_page)

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

