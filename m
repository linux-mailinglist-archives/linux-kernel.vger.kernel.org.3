Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3A7540235
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343899AbiFGPPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343900AbiFGPO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:14:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD3971AF2D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 08:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654614893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6/ubDDYUq7JsSD5y7BKE6Pnt9grBbg8NpCvbzWDfuGc=;
        b=NQbWoUFv7cezwYTHlXbqmgDo9GuspCEaimV5dfKlug6uukNyh07LnyHaqKRfWA/9EoJQir
        PKbRuHk+mNSAtviVM4YV7dIYm7GJR7nGadYNLh9jOsoGby5H1yZ0PzUZPJUBNRBkBpPuo8
        j7AvACs7U7fncK/+HtKC9rSE9roWWrk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-Fe2PgdDFM1W7KBGwPNzQ1Q-1; Tue, 07 Jun 2022 11:14:52 -0400
X-MC-Unique: Fe2PgdDFM1W7KBGwPNzQ1Q-1
Received: by mail-wr1-f69.google.com with SMTP id i10-20020a5d55ca000000b002103d76ffcaso4046910wrw.17
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 08:14:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6/ubDDYUq7JsSD5y7BKE6Pnt9grBbg8NpCvbzWDfuGc=;
        b=ySFov6Z1LIM7iMawfdMkEQ6F2IIS4NrdrtzNziVxnhe3sVWD3FG2Lm8qpJMxqqTWN/
         sQjETo8KZgb3kNSnMA4wvkor46gvm6NASnjJeQr3INvx4MNcFKPu96BHeb5jbaI7FIiR
         hwMUX0PXknd1KW1nGEyBojE97Nv1AaB/myt5RNcETtFey+OnhAJ+f1mDiJdDqQS6/byk
         v3pvnsqFm/4ND3wlBSTWpUa+0VNxFZwYX1kjrthsQ0NWevG1fuVnj32DcLLKrW4BIrcF
         SetUUCg4jI/sGTMIu1kS40ETJmPSX+cN79y/fMjmZgzOVc0I2hInQ5nfcaKfWmZtpstV
         ZVfg==
X-Gm-Message-State: AOAM533PmWZYnYUkzDcrNsKert65itpaQg8pZ42y0In3MePdggfPDW31
        +H02dgeF1zIMfbAABP7coE7UfIGLeyecRitjAdA9Kfq8ubTf2U1tAo3VQgWlTCBanMSRPhR/E8s
        3coFvp76u1HZI+oPT4Wu62ULv
X-Received: by 2002:a7b:c341:0:b0:37b:ed90:7dad with SMTP id l1-20020a7bc341000000b0037bed907dadmr28506807wmj.138.1654614891007;
        Tue, 07 Jun 2022 08:14:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUdbpCo/MOt8IWw71ZrXkaFebf2wItJLgp9HKWhrVYS9665oEGQ/r6dzZuLlTCgCgb4RxP8g==
X-Received: by 2002:a7b:c341:0:b0:37b:ed90:7dad with SMTP id l1-20020a7bc341000000b0037bed907dadmr28506758wmj.138.1654614890592;
        Tue, 07 Jun 2022 08:14:50 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id u10-20020adfdd4a000000b002102cc4d63asm21428082wrm.81.2022.06.07.08.14.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 08:14:49 -0700 (PDT)
Message-ID: <97789f9e-a33e-bb8d-d5b1-9be31232b64a@redhat.com>
Date:   Tue, 7 Jun 2022 17:14:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] KVM: x86/mmu: Check every prev_roots in
 __kvm_mmu_free_obsolete_roots()
Content-Language: en-US
To:     shaoqin.huang@intel.com
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ben Gardon <bgardon@google.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220607005905.2933378-1-shaoqin.huang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220607005905.2933378-1-shaoqin.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/22 02:59, shaoqin.huang@intel.com wrote:
> From: Shaoqin Huang <shaoqin.huang@intel.com>
> 
> When freeing obsolete previous roots, check prev_roots as intended, not
> the current root.
> 
> Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
> Fixes: 527d5cd7eece ("KVM: x86/mmu: Zap only obsolete roots if a root shadow page is zapped")
> ---
> Changes in v2:
>    - Make the commit message more clearer.
>    - Fixed the missing idx.
> 
>   arch/x86/kvm/mmu/mmu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index f4653688fa6d..e826ee9138fa 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -5179,7 +5179,7 @@ static void __kvm_mmu_free_obsolete_roots(struct kvm *kvm, struct kvm_mmu *mmu)
>   		roots_to_free |= KVM_MMU_ROOT_CURRENT;
>   
>   	for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++) {
> -		if (is_obsolete_root(kvm, mmu->root.hpa))
> +		if (is_obsolete_root(kvm, mmu->prev_roots[i].hpa))
>   			roots_to_free |= KVM_MMU_ROOT_PREVIOUS(i);
>   	}
>   

Queued, thanks.

Paolo

