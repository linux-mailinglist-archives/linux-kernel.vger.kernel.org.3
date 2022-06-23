Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C57557E0B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 16:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbiFWOqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 10:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiFWOqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 10:46:18 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5156377D6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 07:46:17 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id u37so19315508pfg.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 07:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XoO7ESB32RV6It/bv3sCZc7jqSp5ygArn4dp49/Te3Y=;
        b=m+vseIWPrJS5h+yWXbxnAASP7WipdB/WdQ35XDIZvwyp3G004IaTSBgX2iXZMmcUrz
         JgPMn1V93+cwvO3PgmFiNhLS8twBBeZ+4eLyyTaGrs9FT/1k2yGwD0aHuExMbdEtCxOc
         +DHrh7GM8eByAUsQC7rkUATDrxiKLgkO1tNDdUosATZ6Af/WD6RPfOGfWelNquNZdqI4
         vHqxdVDqKJYB02A5HZQsnb9TadnpDN6qZY7ChVaJpbf6B/k64VTXjP89bMXjqCX79N0m
         lzaLLcdniS2tHbb68OmhEQxV6lIjZ66dbN9J4G9aantCrHoecOy1GQ5Y2lCklYEIHtw8
         Zk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XoO7ESB32RV6It/bv3sCZc7jqSp5ygArn4dp49/Te3Y=;
        b=mjWUJ+02s6yCO8o+g3LfdhXWbbnqgAN2d4Ng44HRDMiqyULEwTOkevSyJXEVcDZpv1
         83efpT2Oo4UO4+w3ar7XHBIbHE3tGZ6GTu4Mj9eW7/jQKpYjoTFbf+6q53N2BvGhx3FH
         d0SrlN9+P18ISMPN/P1ZnILbk90/h+aDQKy1XCqOxZ5ckVfVqq/H8SgSHBOSf6MSliZE
         3B0ujiwF9s7sVoNwaukx03ECZsFhiJ2PRfei2O+tX+z842IQamQ7DOqiJPfrIfDuZaZq
         JGFwsRLye61L3TTQwSHhtnT98k65HsL5xNMbIRNuafL8JUroW/9Cn7Co4+gtY55rlMnI
         mGTA==
X-Gm-Message-State: AJIora9wWN4pkZrKRpR8SHX3rIFCvjSv9YQHG80yxZyuZEX4asdUKyFI
        +MFQDxsdcvb6QVIQM9CeaKvWvQ==
X-Google-Smtp-Source: AGRyM1tK3xPVSaeZB/nRQExRDbnxBwwsb/ysSZCcGTt7qU3WXdtH5Qv2rC7HnwpCIfde7rX9RyVKGg==
X-Received: by 2002:a05:6a02:117:b0:3fa:de2:357a with SMTP id bg23-20020a056a02011700b003fa0de2357amr7805740pgb.169.1655995572571;
        Thu, 23 Jun 2022 07:46:12 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id d12-20020a17090abf8c00b001ec839fff50sm1990244pjs.34.2022.06.23.07.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 07:46:12 -0700 (PDT)
Date:   Thu, 23 Jun 2022 14:46:08 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux MM Mailing List <linux-mm@kvack.org>
Subject: Re: [PATCH 4/4] kvm/x86: Allow to respond to generic signals during
 slow page faults
Message-ID: <YrR8sKap6KHT22Dx@google.com>
References: <20220622213656.81546-1-peterx@redhat.com>
 <20220622213656.81546-5-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622213656.81546-5-peterx@redhat.com>
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

On Wed, Jun 22, 2022, Peter Xu wrote:
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index e92f1ab63d6a..b39acb7cb16d 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3012,6 +3012,13 @@ static int kvm_handle_bad_page(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
>  static int handle_abnormal_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
>  			       unsigned int access)
>  {
> +	/* NOTE: not all error pfn is fatal; handle intr before the other ones */
> +	if (unlikely(is_intr_pfn(fault->pfn))) {
> +		vcpu->run->exit_reason = KVM_EXIT_INTR;
> +		++vcpu->stat.signal_exits;
> +		return -EINTR;
> +	}
> +
>  	/* The pfn is invalid, report the error! */
>  	if (unlikely(is_error_pfn(fault->pfn)))
>  		return kvm_handle_bad_page(vcpu, fault->gfn, fault->pfn);
> @@ -4017,6 +4024,8 @@ static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
>  		}
>  	}
>  
> +	/* Allow to respond to generic signals in slow page faults */

"slow" is being overloaded here.  The previous call __gfn_to_pfn_memslot() will
end up in hva_to_pfn_slow(), but because of passing a non-null async it won't wait.
This code really should have a more extensive comment irrespective of the interruptible
stuff, now would be a good time to add that.

Comments aside, isn't this series incomplete from the perspective that there are
still many flows where KVM will hang if gfn_to_pfn() gets stuck in gup?  E.g. if
KVM is retrieving a page pointed at by vmcs12.

> +	flags |= KVM_GTP_INTERRUPTIBLE;
>  	fault->pfn = __gfn_to_pfn_memslot(slot, fault->gfn, flags, NULL,
>  					  &fault->map_writable, &fault->hva);
>  	return RET_PF_CONTINUE;
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 4f84a442f67f..c8d98e435537 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1163,6 +1163,7 @@ typedef unsigned int __bitwise kvm_gtp_flag_t;
>  
>  #define  KVM_GTP_WRITE          ((__force kvm_gtp_flag_t) BIT(0))
>  #define  KVM_GTP_ATOMIC         ((__force kvm_gtp_flag_t) BIT(1))
> +#define  KVM_GTP_INTERRUPTIBLE  ((__force kvm_gtp_flag_t) BIT(2))
>  
>  kvm_pfn_t __gfn_to_pfn_memslot(const struct kvm_memory_slot *slot, gfn_t gfn,
>  			       kvm_gtp_flag_t gtp_flags, bool *async,
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 952400b42ee9..b3873cac5672 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2462,6 +2462,8 @@ static int hva_to_pfn_slow(unsigned long addr, bool *async,
>  		flags |= FOLL_WRITE;
>  	if (async)
>  		flags |= FOLL_NOWAIT;
> +	if (gtp_flags & KVM_GTP_INTERRUPTIBLE)
> +		flags |= FOLL_INTERRUPTIBLE;
>  
>  	npages = get_user_pages_unlocked(addr, 1, &page, flags);
>  	if (npages != 1)
> @@ -2599,6 +2601,8 @@ kvm_pfn_t hva_to_pfn(unsigned long addr, kvm_gtp_flag_t gtp_flags, bool *async,
>  	npages = hva_to_pfn_slow(addr, async, gtp_flags, writable, &pfn);
>  	if (npages == 1)
>  		return pfn;
> +	if (npages == -EINTR)
> +		return KVM_PFN_ERR_INTR;
>  
>  	mmap_read_lock(current->mm);
>  	if (npages == -EHWPOISON ||
> -- 
> 2.32.0
> 
