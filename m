Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DCB4F86EA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 20:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346764AbiDGSJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 14:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbiDGSJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 14:09:51 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3409D20C18C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 11:07:47 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id gt4so6311326pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 11:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bvt6qT0ydiLPDM+FkX2HWRHILEkRiZIn0dbygo3Xhps=;
        b=nyQcAr9pwnzY6dw+wJEhG2eJ1JtXx//ENhWVYqgZQpnD33DyY5wL3elf8tyqcQPoFq
         UMdfumX4x+QoJyv+js8W7EdBKH59hxhbtouyjDj3Cni9zV440g/YHzsY4m9qzRn4dGdt
         u/c/Jnd9PW0WV/iWzGwyqFGZkLPdNhmY0BFrBycMyJBKOIr+GMycRESpyKVFHwSmqlFl
         kLTlSMFiTjBkyc3ItL61L5TIF2CEHQxFgFFeeQKtApr6gBODBu8o/kpqYRI+0yy9CKth
         XHJa/7gwNDnbyxYJKpO90fVmnGb+Yhot4Px2ulLI5iKAIorB1iQRvFAJHgoI6y6oNpRG
         edYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bvt6qT0ydiLPDM+FkX2HWRHILEkRiZIn0dbygo3Xhps=;
        b=qi3yxXLbPUK+yrZznsWWfKGSuchnBaNCvw69w3kT0CQx3WtnAXThP41sgvHFMjYgVc
         2TXkmEu57EACxajpiBhRx97HEIvYXqSrdi2nhLo8hCiwHmYoYcVWWrZOSdpdxg7JkjjN
         E14sruh32eJJ6dvRBhlFru3pTpmvhr5rkwg2BC1+NGnptis+h4kNJCDxzlb2AysC7KzW
         b9+00odQEb1Dplp5jdjgaDx1wL+3Tgwq1E7YznKD/MpYwe7ncf9uiJg5rYYeOxacNx37
         KJY7KpRFno8ComrKV72hdrk/qJpgIfm0F/OyueeRQ9ljIVj/qLkQ9a4vwVmgILDfV+15
         fZEQ==
X-Gm-Message-State: AOAM5314aF1mY/3kAZCcTE8WDsoc1S9nyPY6hr3eFQMzY78u0N5JBP10
        ve+r632yF2SyC2jj6HjF9uSb6A==
X-Google-Smtp-Source: ABdhPJwtYsBW+j0nzPeb2zOfa01FDXBiPQqbFRpPG4HEe52dbQcKbsIphKSopKNQd8U4Qhkd9agPNw==
X-Received: by 2002:a17:903:190:b0:154:9ee:cd25 with SMTP id z16-20020a170903019000b0015409eecd25mr15132719plg.102.1649354866427;
        Thu, 07 Apr 2022 11:07:46 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id g6-20020a056a000b8600b004faa49add69sm23389396pfj.107.2022.04.07.11.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 11:07:45 -0700 (PDT)
Date:   Thu, 7 Apr 2022 18:07:42 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/31] KVM: x86: hyper-v: Introduce
 kvm_hv_is_tlb_flush_hcall()
Message-ID: <Yk8obi5/1uB88viW@google.com>
References: <20220407155645.940890-1-vkuznets@redhat.com>
 <20220407155645.940890-13-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407155645.940890-13-vkuznets@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022, Vitaly Kuznetsov wrote:
> The newly introduced helper checks whether vCPU is performing a
> Hyper-V TLB flush hypercall. This is required to filter out Direct TLB
> flush hypercalls from L2 for processing.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/hyperv.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
> index 448877b478ef..3687e1e61e0d 100644
> --- a/arch/x86/kvm/hyperv.h
> +++ b/arch/x86/kvm/hyperv.h
> @@ -168,6 +168,30 @@ static inline void kvm_hv_vcpu_empty_flush_tlb(struct kvm_vcpu *vcpu)
>  	tlb_flush_ring = kvm_hv_get_tlb_flush_ring(vcpu);
>  	tlb_flush_ring->read_idx = tlb_flush_ring->write_idx;
>  }
> +
> +static inline bool kvm_hv_is_tlb_flush_hcall(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
> +	u16 code;
> +
> +	if (!hv_vcpu)
> +		return false;
> +
> +#ifdef CONFIG_X86_64
> +	if (is_64_bit_hypercall(vcpu)) {
> +		code = kvm_rcx_read(vcpu) & 0xffff;
> +	} else
> +#endif
> +	{
> +		code = kvm_rax_read(vcpu) & 0xffff;
> +	}

	if (IS_ENABLED(CONFIG_X86_64) && is_64_bit_hypercall(vcpu))
		code = kvm_rcx_read(vcpu) & 0xffff;
	else
		code = kvm_rax_read(vcpu) & 0xffff;

Though I honestly don't see the point, is_64_bit_hypercall() will do the right
thing.

And is the 0xffff really needed?  An implicit cast should work just fine.  If I'm
overlooking something, an explicit would be better, e.g. why not

	code = is_64_bit_hypercall(vcpu) ? kvm_rcx_read(vcpu) :
					   kvm_rax_read(vcpu);

> +
> +	return (code == HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE ||
> +		code == HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST ||
> +		code == HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX ||
> +		code == HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX);
> +}
> +
>  void kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu);
>  
>  
> -- 
> 2.35.1
> 
