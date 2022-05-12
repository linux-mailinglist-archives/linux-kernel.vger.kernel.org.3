Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9533C524D48
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353911AbiELMp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349598AbiELMpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:45:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 646AADEC4
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652359546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GE6JfwZBCORMKMiuFLLmROx+N1+Jhd1whG8cx/zsZ9o=;
        b=c0KG44EWDCp4K5TxMPVuYxnkKECpgFTY7BBOHYdQ4j+PN1RhXyViybthGyu2VeZFVUA601
        ZKqt92T2YhdkmieqDZg5aGg0N3orRJKcctrRihFuJhhf7CLrwMYoLGmWFKm/N2y3r0G0hl
        Yytj+aPXeHVpmG32TIci6cXx6hrqXgs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-rvVFIXNOOF6vBOcaNtkysg-1; Thu, 12 May 2022 08:45:45 -0400
X-MC-Unique: rvVFIXNOOF6vBOcaNtkysg-1
Received: by mail-wm1-f70.google.com with SMTP id bg7-20020a05600c3c8700b0039468585269so1579150wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=GE6JfwZBCORMKMiuFLLmROx+N1+Jhd1whG8cx/zsZ9o=;
        b=R2/eXJqUZni7/u1ZPdbnCPLbcdgTAb8Jg6pzg8DCbLVjBek4NtRmPWTsrxp6IziSPD
         xZb7lERFwXTEAj6e7L9lX0REDyVWfPSFtm3Ihomaratcaxa91vHfZAYF6wMkdnC0v03K
         AW7gNNRsJ1wxYJQ7Q1ANIKj107T7wEWwHshp3qZPQ8K1svA5lSHaLHDOSJB7tDiDkecj
         DnvmpuownlfhcEIHp0J4YcotCnUDpFoYrKcjTF6RvilD2NPHHZsaBbmvvMvqQtdkY/Za
         Ek+3vOvPpSE3SQSNpTQJsnQ1QnYUpJ0/D/c4fnwdjY/TftJgVP9cgRj2kWZsy5XIrN9Z
         SiUg==
X-Gm-Message-State: AOAM532cyaH0jfFSfXi1bkWDOvQ/4XNgNMyeuEOB2pq4ks+wpTt28NJm
        69c6IYX5MxhrqlAYNbNt744o75M6w96NBy59teVefTz/wK/TVVdut69IvAAn/wzct3EzaPxmlM/
        WL2WKuZ2MszP8m4GdrjaipeHq
X-Received: by 2002:a05:6000:2a2:b0:20c:999d:bdec with SMTP id l2-20020a05600002a200b0020c999dbdecmr27231149wry.36.1652359544475;
        Thu, 12 May 2022 05:45:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztqWcgGDjjW9D8ehcA9/U1thvNGr5ujzH+lSg/D+ZXL9ikdaMlxHzDCdO8wke/OBeILi4NnA==
X-Received: by 2002:a05:6000:2a2:b0:20c:999d:bdec with SMTP id l2-20020a05600002a200b0020c999dbdecmr27231131wry.36.1652359544195;
        Thu, 12 May 2022 05:45:44 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id p190-20020a1c29c7000000b003942a244ee7sm2617058wmp.44.2022.05.12.05.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 05:45:43 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH] KVM: x86: fix a typo in __try_cmpxchg_user that caused
 cmpxchg to be not atomic
In-Reply-To: <20220512101420.306759-1-mlevitsk@redhat.com>
References: <20220202004945.2540433-5-seanjc@google.com>
 <20220512101420.306759-1-mlevitsk@redhat.com>
Date:   Thu, 12 May 2022 14:45:42 +0200
Message-ID: <875ymayl55.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxim Levitsky <mlevitsk@redhat.com> writes:

> Fixes: 1c2361f667f36 ("KVM: x86: Use __try_cmpxchg_user() to emulate atomic accesses")
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  arch/x86/kvm/x86.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Yes, this is the root cause of the TDP mmu leak I was doing debug of in the last week.
> Non working cmpxchg on which TDP mmu relies makes it install two differnt shadow pages
> under same spte.

In case the fix is not squashed with 1c2361f667f36, the above should
really go before '---'.

>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 8ee8c91fa7625..79cabd3d97d22 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7329,7 +7329,7 @@ static int emulator_cmpxchg_emulated(struct x86_emulate_ctxt *ctxt,
>  		goto emul_write;
>  
>  	hva = kvm_vcpu_gfn_to_hva(vcpu, gpa_to_gfn(gpa));
> -	if (kvm_is_error_hva(addr))
> +	if (kvm_is_error_hva(hva))

Looks like a typo indeed, so

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

>  		goto emul_write;
>  
>  	hva += offset_in_page(gpa);

-- 
Vitaly

