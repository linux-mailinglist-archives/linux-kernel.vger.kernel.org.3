Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895F9589D1F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239596AbiHDN5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbiHDN5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:57:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39DA41B7B4
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 06:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659621424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T/pAj5FlZm909/pQhfkLNAfClouHpR4Wf8ZAzH72SW0=;
        b=gz1EbIZGGF3a2aoOeB8hKSCb6dqP1PecfvqMelI85d5dyoh12hE6zMNlvGf6OsB/orL1eG
        vDxWp49ycCa/9sCB5l+c4ANcDdZa9G+NeqoRP+QnvzJ87ObMLi4xyO3qeRvUTP94BpRWC6
        Gpzzc+5thKCK0aHtb8m1LgCLewt/9V8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-357-iwajSFHDPPeg4n7l53WLJw-1; Thu, 04 Aug 2022 09:57:02 -0400
X-MC-Unique: iwajSFHDPPeg4n7l53WLJw-1
Received: by mail-wm1-f71.google.com with SMTP id v64-20020a1cac43000000b003a4bea31b4dso2641318wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 06:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=T/pAj5FlZm909/pQhfkLNAfClouHpR4Wf8ZAzH72SW0=;
        b=LvoQ0AX6x9PXCKt1AfbkP/1komWDzFGxfRgbunIGPBUBeikmmMfNjDydtE8iAtfo0B
         U4+/YxcyEEbP19oUa9GQrkHKLU0H5VAXh8L9T2111KvjxUhbSPPzBvD2iYZRwqzAtwJf
         JkXtSR2QRr/d0T/q4wiD0NYUrkcTdDyn5fFNYfkf8s+m+jjDinIiYvoJunludWS8Glco
         HteG1ndTYEKHQ3SSpiw7z1Prv65I87rdjNblCnOrUWiBA9IDp/iM2GsoTtOeym8SaCr8
         Ko0QUaTYRR5/7xAsFeFro11obR97LeG5qgCfV2CHOOm9+l7vCuWveGh6ndX3KdHArC3t
         NxAQ==
X-Gm-Message-State: ACgBeo0cfCmILbX6wvBh2QyGOTFBb4eRjggrBxRRypkdiI1pK2uCQS7Y
        yw1nxHCu7vIQw2kal8NwDp2iRVmnL8VxLhHJfTOpc719KYJJS4jQt6vJp7SsSA+15VNYOBWKUBi
        OAOiuBA+qCNNgHGdPwC26tm0S
X-Received: by 2002:adf:ebc5:0:b0:21d:640e:dc2f with SMTP id v5-20020adfebc5000000b0021d640edc2fmr1506713wrn.227.1659621421469;
        Thu, 04 Aug 2022 06:57:01 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7cvW8o7PqcjvWiuOb6gGkLOZgKKDPA9oqTWEvS6JOcsOP2mo3oKfsJS1fvn8oIHDeYxeI2oQ==
X-Received: by 2002:adf:ebc5:0:b0:21d:640e:dc2f with SMTP id v5-20020adfebc5000000b0021d640edc2fmr1506704wrn.227.1659621421209;
        Thu, 04 Aug 2022 06:57:01 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id e3-20020adf9bc3000000b0020e6ce4dabdsm1202927wrc.103.2022.08.04.06.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 06:57:00 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Dave Young <ruyang@redhat.com>, Xiaoying Yan <yiyan@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>, stable@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: revalidate steal time cache if MSR value changes
In-Reply-To: <20220804132832.420648-1-pbonzini@redhat.com>
References: <20220804132832.420648-1-pbonzini@redhat.com>
Date:   Thu, 04 Aug 2022 15:56:59 +0200
Message-ID: <87v8r8yuvo.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> Commit 7e2175ebd695 ("KVM: x86: Fix recording of guest steal time
> / preempted status", 2021-11-11) open coded the previous call to
> kvm_map_gfn, but in doing so it dropped the comparison between the cached
> guest physical address and the one in the MSR.  This cause an incorrect
> cache hit if the guest modifies the steal time address while the memslots
> remain the same.  This can happen with kexec, in which case the steal
> time data is written at the address used by the old kernel instead of
> the old one.
>
> While at it, rename the variable from gfn to gpa since it is a plain
> physical address and not a right-shifted one.
>
> Reported-by: Dave Young <ruyang@redhat.com>
> Reported-by: Xiaoying Yan  <yiyan@redhat.com>
> Analyzed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: David Woodhouse <dwmw@amazon.co.uk>
> Cc: stable@vger.kernel.org
> Fixes: 7e2175ebd695 ("KVM: x86: Fix recording of guest steal time / preempted status")
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/x86.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index e5fa335a4ea7..36dcf18b04bf 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3380,6 +3380,7 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
>  	struct gfn_to_hva_cache *ghc = &vcpu->arch.st.cache;
>  	struct kvm_steal_time __user *st;
>  	struct kvm_memslots *slots;
> +	gpa_t gpa = vcpu->arch.st.msr_val & KVM_STEAL_VALID_BITS;
>  	u64 steal;
>  	u32 version;
>  
> @@ -3397,13 +3398,12 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
>  	slots = kvm_memslots(vcpu->kvm);
>  
>  	if (unlikely(slots->generation != ghc->generation ||
> +		     gpa != ghc->gpa ||
>  		     kvm_is_error_hva(ghc->hva) || !ghc->memslot)) {
> -		gfn_t gfn = vcpu->arch.st.msr_val & KVM_STEAL_VALID_BITS;
> -
>  		/* We rely on the fact that it fits in a single page. */
>  		BUILD_BUG_ON((sizeof(*st) - 1) & KVM_STEAL_VALID_BITS);
>  
> -		if (kvm_gfn_to_hva_cache_init(vcpu->kvm, ghc, gfn, sizeof(*st)) ||
> +		if (kvm_gfn_to_hva_cache_init(vcpu->kvm, ghc, gpa, sizeof(*st)) ||

(It would be nice to somehow get at least a warning when 'gfn_t' is used
instead of 'gpa_t' and vice versa)

>  		    kvm_is_error_hva(ghc->hva) || !ghc->memslot)
>  			return;
>  	}

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

