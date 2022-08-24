Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9CC5A03F1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 00:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiHXW2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 18:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiHXW2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 18:28:51 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1A67EFC3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 15:28:50 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 67so9676564pfv.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 15:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=yAEeUYWmYhxNKGYcVjQKExoIw8PLAY9dFJ2qCbmO4Fk=;
        b=FfHIVto/5ebxp1vTr806NuYVnNp5UiwDZlbaiR9KnThDMHyfTOihi1DEIOZmHlS6D9
         dCNsyTUdjVjvBuAY8rqv1FD1sKvRSOuTc9h8iH9Mlg5/4Vi1x9ZItOC2UrGZbWy5bCkg
         BGwWL4rf/WnZwYPn9tAz9MdhnX3vy5Niy+Mps7z4MnVsdndAl+jrCaMlgZHBR3a5LYcC
         KhjqHBDWw3Td01XdjFyNCYAagwkBRr8F1DmIVzmTOTR8nEn26Rq8UrxCIOWJNMEsFd2N
         lEwpqGQKifpyBT/L6VLqqhQ08TfwQMgRWiN98qos9ni78APzNVfE5WJxHMch5fcvUmkC
         c3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=yAEeUYWmYhxNKGYcVjQKExoIw8PLAY9dFJ2qCbmO4Fk=;
        b=sAERnQiFOjP/PkycKq9cQPITOwtN6pdhz8Jar6yP1HzROejZxgF0uzQ415LgHHSgII
         Vi/PVdT++84Kac7vb0kUy51HeoUEXDUt6KlDM+UHY/0I0rv9CuwIuLY0afEfOUjDY6g2
         6W1674z7bdJPKvP0bfe3GmLXc5hG+ODowg2XQqWSUTUDk6aCQI4ANwjNDiVmLEdPRLGc
         Xu+ZaS1rMHp9iQHOPuirls91OZ69OWXNOiXNvb2UsQ8KMdpEy84s7duJCeLLtqUzhIDZ
         3UyywCX8pBu60sapySJ18XazFi3vegjsm2ApwRm1qdQalbmYQD49FQrBhOv3QrdEr0Cd
         Izwg==
X-Gm-Message-State: ACgBeo0LFBaBkk3Y8Iy7fBXpVWu8kWlJ1T9xCHTAs1YFGedhL/+LTttE
        JAENiVPi74S3FYgbR2E93OPv0w==
X-Google-Smtp-Source: AA6agR5M1oj1tY8sjh+PX/x/v1cTVy+qrcbir+JM822+YF/uxToEwAzb6pXj5Ytn3T0bMyscSGJd+w==
X-Received: by 2002:a65:6d0f:0:b0:42b:42f8:efe0 with SMTP id bf15-20020a656d0f000000b0042b42f8efe0mr816349pgb.197.1661380129390;
        Wed, 24 Aug 2022 15:28:49 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id a2-20020a170902ee8200b0016bdcb8fbcdsm11297046pld.47.2022.08.24.15.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 15:28:49 -0700 (PDT)
Date:   Wed, 24 Aug 2022 22:28:45 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Jim Mattson <jmattson@google.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 09/13] KVM: x86: emulator/smm: use smram struct for 32
 bit smram load/restore
Message-ID: <YwamHYLokbGX96cG@google.com>
References: <20220803155011.43721-1-mlevitsk@redhat.com>
 <20220803155011.43721-10-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803155011.43721-10-mlevitsk@redhat.com>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022, Maxim Levitsky wrote:
> Use kvm_smram_state_32 struct to save/restore 32 bit SMM state
> (used when X86_FEATURE_LM is not present in the guest CPUID).
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  arch/x86/kvm/emulate.c | 81 +++++++++++++++---------------------------
>  arch/x86/kvm/x86.c     | 75 +++++++++++++++++---------------------
>  2 files changed, 60 insertions(+), 96 deletions(-)
> 
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index 610978d00b52b0..3339d542a25439 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -2371,25 +2371,17 @@ static void rsm_set_desc_flags(struct desc_struct *desc, u32 flags)
>  	desc->type = (flags >>  8) & 15;
>  }
>  
> -static int rsm_load_seg_32(struct x86_emulate_ctxt *ctxt, const char *smstate,
> +static void rsm_load_seg_32(struct x86_emulate_ctxt *ctxt,
> +			   const struct kvm_smm_seg_state_32 *state,

Alignment is off by one.

> +			   u16 selector,
>  			   int n)

These can go on a single line.

static void rsm_load_seg_32(struct x86_emulate_ctxt *ctxt,
			    const struct kvm_smm_seg_state_32 *state,
			    u16 selector, int n)

>  	struct desc_struct desc;
> -	int offset;
> -	u16 selector;
> -
> -	selector = GET_SMSTATE(u32, smstate, 0x7fa8 + n * 4);
> -
> -	if (n < 3)
> -		offset = 0x7f84 + n * 12;
> -	else
> -		offset = 0x7f2c + (n - 3) * 12;
>  
> -	set_desc_base(&desc,      GET_SMSTATE(u32, smstate, offset + 8));
> -	set_desc_limit(&desc,     GET_SMSTATE(u32, smstate, offset + 4));
> -	rsm_set_desc_flags(&desc, GET_SMSTATE(u32, smstate, offset));
> +	set_desc_base(&desc,      state->base);
> +	set_desc_limit(&desc,     state->limit);
> +	rsm_set_desc_flags(&desc, state->flags);
>  	ctxt->ops->set_segment(ctxt, selector, &desc, 0, n);
> -	return X86EMUL_CONTINUE;
>  }
>  

...

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index cbbe49bdc58787..6abe35f7687e2c 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9833,22 +9833,18 @@ static u32 enter_smm_get_segment_flags(struct kvm_segment *seg)
>  	return flags;
>  }
>  
> -static void enter_smm_save_seg_32(struct kvm_vcpu *vcpu, char *buf, int n)
> +static void enter_smm_save_seg_32(struct kvm_vcpu *vcpu,
> +					 struct kvm_smm_seg_state_32 *state,
> +					 u32 *selector,
> +					 int n)

Similar issues here.

static void enter_smm_save_seg_32(struct kvm_vcpu *vcpu,
				  struct kvm_smm_seg_state_32 *state,
				  u32 *selector, int n)
>  {
>  	struct kvm_segment seg;
> -	int offset;
>  
>  	kvm_get_segment(vcpu, &seg, n);
> -	put_smstate(u32, buf, 0x7fa8 + n * 4, seg.selector);
> -
> -	if (n < 3)
> -		offset = 0x7f84 + n * 12;
> -	else
> -		offset = 0x7f2c + (n - 3) * 12;
> -
> -	put_smstate(u32, buf, offset + 8, seg.base);
> -	put_smstate(u32, buf, offset + 4, seg.limit);
> -	put_smstate(u32, buf, offset, enter_smm_get_segment_flags(&seg));
> +	*selector = seg.selector;
> +	state->base = seg.base;
> +	state->limit = seg.limit;
> +	state->flags = enter_smm_get_segment_flags(&seg);
>  }
>  
>  #ifdef CONFIG_X86_64
> @@ -9869,54 +9865,47 @@ static void enter_smm_save_seg_64(struct kvm_vcpu *vcpu, char *buf, int n)
>  }
>  #endif
>  
> -static void enter_smm_save_state_32(struct kvm_vcpu *vcpu, char *buf)
> +static void enter_smm_save_state_32(struct kvm_vcpu *vcpu, struct kvm_smram_state_32 *smram)

Please wrap, no reason to run long.

static void enter_smm_save_state_32(struct kvm_vcpu *vcpu,
				    struct kvm_smram_state_32 *smram)


