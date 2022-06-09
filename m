Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9B754578E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 00:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236786AbiFIWm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 18:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiFIWmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 18:42:24 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5371E048D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 15:42:22 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id r71so23172817pgr.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 15:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lelPW5lpCggZHvNs+wr3m0ZEWB3pzhs4qG1pUg8elhM=;
        b=ZZSoXoM1DbaycxvcgDpFuRODWzmX4fkykaNvl7T4TWumygRhWt13WBrCf87O5R8UoN
         +2LanqJtH3c9ttuPEY0YktJkjFPGD0W03xeKbJAUPB+M+p89drQy3+BzWheAZfrh8ZqV
         MlXKVHEUHaoIGKzcVoyj1tCJ4lviw95YneigqkEM6UHkqhNJZ+rjp+drX0/ciW4jQwrV
         UlPlQT78ggSI5XzGp/F4cp97+W252N3/G2FjCCB+bO5tpBgy73gW36cHIWKc+ptU0Y9m
         GpqgqA7IIMqTLwckCP2FYR6DOq0VQA4MVQ6VcrVUKDDfFD1D3glaP/Wnxri1KUoaN6SO
         2K5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lelPW5lpCggZHvNs+wr3m0ZEWB3pzhs4qG1pUg8elhM=;
        b=tPpE6v1UPZjuXt70AUsvdD4po2F6i8P9EPrZu4dpL/PRnULlWWf8YoRnNuph9gtdGv
         6UtsYVHA0T9ipMd/pI5/ATxNfEGAGWOB7bmqvT3m3pt6L+Fm+VFeEuA0ZM/S3t3tTzdM
         MhyqllJqBRaNZbECQSPhNb8U8ohvhwAbyRfp08q1+hgNXEmuHGSEPGVXwnQUMUIwgBNN
         8AMskqatLlsDAHevl+59GohzI3GP62EuNpINbqfH2I7L3l0u4r4Thi92oNZ311skFBnw
         zEkjdAukDRvIGe+jPBfrLaTtJKBGj9h9ZGhUHN8aga2yglE8A9apklTmODlicypi2i34
         0Zxw==
X-Gm-Message-State: AOAM531N1wAIe34tYnjzQhIfPWt/1w3HOJf906I+JfVJjo+qMWQ47xlX
        +nhJUYZKkL3GAZFzclV2ZnTgYA==
X-Google-Smtp-Source: ABdhPJy3a1oYttRHKD6u1tbHs3WsBjK+zg7wNq5WP8biWjs5gXbBbv7SniXEv/KhSZ5FvZeVrs66gw==
X-Received: by 2002:a63:114:0:b0:3fd:431a:dd77 with SMTP id 20-20020a630114000000b003fd431add77mr28873731pgb.619.1654814542283;
        Thu, 09 Jun 2022 15:42:22 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id d4-20020a170903230400b00167729dfe0bsm10004981plh.168.2022.06.09.15.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 15:42:21 -0700 (PDT)
Date:   Thu, 9 Jun 2022 22:42:18 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH 5/6] KVM: x86: de-underscorify __emulator_pio_in
Message-ID: <YqJ3So/Snq31R2Ym@google.com>
References: <20220608121253.867333-1-pbonzini@redhat.com>
 <20220608121253.867333-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608121253.867333-6-pbonzini@redhat.com>
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

On Wed, Jun 08, 2022, Paolo Bonzini wrote:
> Now all callers except emulator_pio_in_emulated are using
> __emulator_pio_in/complete_emulator_pio_in explicitly.
> Move the "either copy the result or attempt PIO" logic in
> emulator_pio_in_emulated, and rename __emulator_pio_in to
> just emulator_pio_in.

Wrap changelogs closer to 75 chars, <60 is a bit too aggressive.

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/x86.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index aefcc71a7040..fd4382602f65 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7456,7 +7456,7 @@ static int emulator_pio_in_out(struct kvm_vcpu *vcpu, int size,
>  	return 0;
>  }
>  
> -static int __emulator_pio_in(struct kvm_vcpu *vcpu, int size,
> +static int emulator_pio_in(struct kvm_vcpu *vcpu, int size,
>  			     unsigned short port, void *val, unsigned int count)

Align the second line of parameters.  Even gets it below 80 columns ;-)

>  {
>  	int r = emulator_pio_in_out(vcpu, size, port, val, count, true);
> @@ -7475,9 +7475,11 @@ static void complete_emulator_pio_in(struct kvm_vcpu *vcpu, void *val)
>  	vcpu->arch.pio.count = 0;
>  }
>  
> -static int emulator_pio_in(struct kvm_vcpu *vcpu, int size,
> -			   unsigned short port, void *val, unsigned int count)
> +static int emulator_pio_in_emulated(struct x86_emulate_ctxt *ctxt,
> +				    int size, unsigned short port, void *val,

"int size" fits on the first line, emulator_pio_in_emulated() and
emulator_pio_out_emulated() have different formatting either way.

> +				    unsigned int count)
>  {
> +	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);

Newline after variable declarations.

>  	if (vcpu->arch.pio.count) {
>  		/*
>  		 * Complete a previous iteration that required userspace I/O.
> @@ -7489,18 +7491,10 @@ static int emulator_pio_in(struct kvm_vcpu *vcpu, int size,
>  		complete_emulator_pio_in(vcpu, val);
>  		return 1;
>  	} else {
> -		return __emulator_pio_in(vcpu, size, port, val, count);
> +		return emulator_pio_in(vcpu, size, port, val, count);
>  	}
>  }
>  
> -static int emulator_pio_in_emulated(struct x86_emulate_ctxt *ctxt,
> -				    int size, unsigned short port, void *val,
> -				    unsigned int count)
> -{
> -	return emulator_pio_in(emul_to_vcpu(ctxt), size, port, val, count);
> -
> -}
> -
>  static int emulator_pio_out(struct kvm_vcpu *vcpu, int size,
>  			    unsigned short port, const void *val,
>  			    unsigned int count)
> @@ -8707,7 +8701,7 @@ static int kvm_fast_pio_in(struct kvm_vcpu *vcpu, int size,
>  	/* For size less than 4 we merge, else we zero extend */
>  	val = (size < 4) ? kvm_rax_read(vcpu) : 0;
>  
> -	ret = __emulator_pio_in(vcpu, size, port, &val, 1);
> +	ret = emulator_pio_in(vcpu, size, port, &val, 1);
>  	if (ret) {
>  		kvm_rax_write(vcpu, val);
>  		return ret;
> @@ -13078,7 +13072,7 @@ static int kvm_sev_es_ins(struct kvm_vcpu *vcpu, unsigned int size,
>  	for (;;) {
>  		unsigned int count =
>  			min_t(unsigned int, PAGE_SIZE / size, vcpu->arch.sev_pio_count);
> -		if (!__emulator_pio_in(vcpu, size, port, vcpu->arch.sev_pio_data, count))
> +		if (!emulator_pio_in(vcpu, size, port, vcpu->arch.sev_pio_data, count))
>  			break;
>  
>  		/* Emulation done by the kernel.  */
> -- 
> 2.31.1
> 
> 
