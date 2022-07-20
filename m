Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CBD57C11B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 01:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiGTXuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 19:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiGTXuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 19:50:09 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB977D4D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 16:50:07 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id b133so202944pfb.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 16:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SDnyggnh9pThzoDcJ3VXXCME6j9cwwo6N50/QOAGYi4=;
        b=PlQVOfMoLRbWIbLQUit4qc8Cr9e1p1I+DEw8K9HdObjZpV1NVWuTIWGnOwAR/eu+CT
         tJbWMjF81xfy2Ihd+23mqaALZYKa97ZBOR7gwq0Ifvw2/gKM30EM5Puj0/PgTvU3Z0UN
         LbKQbr6ZIuain8733He3iMd1TMnz2fJ1/V9vuz9d86IyXDQwswapDVpGLz2YzVdaL6rz
         Eylh7axUrLtGiPSwVtUO4JcvhaJQDKMM5J4eEcUb8FbW2jG40PJTjZfSCn+QXuotErLM
         1HuH8/fM948Pttrj8jzfmYtASASRdosYB2NTqPzzP3h0sXT10GkU3C6bgtsQJWLZclbt
         sYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SDnyggnh9pThzoDcJ3VXXCME6j9cwwo6N50/QOAGYi4=;
        b=LTUuQjKyWNVRrCLn2jBko3NGgaMlm1jvjuVz6dk/59jjukGRm6r3d+W1Y6sQc8fCne
         o2EpZPqF3UP1PLns13r25V/cXR3C5nZ8hk4wHK83x1EfeuFMk7ENN11Y5FVYbsYqUzfI
         nMSaPUJCjYKjokqXTD1XkMXZ64BZ6GMoc32exv8MFK5S7NMlkzmhkHVAGFY+VWHR73E/
         9c+uYlx9bNh08DkiPsgZ7ODg6zZCX3stfr+fgFI3V1c+YvpCLVo7Bkn+RyXS7/CcVGq7
         6NnIhy7w2VcOS5RBCWzi2Px26suc8BaQyHLOKO0ckU0tC7cxtD0HTZO9Kb8FqPjIuh0i
         CMcA==
X-Gm-Message-State: AJIora8gogkRPRzKHEzX5iSd9r1GLasMJmLk/2drkG3dZcATW8TnBDrL
        kgctfrVvA1rFJqgjws62CHCkLg==
X-Google-Smtp-Source: AGRyM1uIj7US8Y7oIaCy/d4XVt8BGXMupWNBQUm7cMoPwn35cUNrKPQn/t+NucZZwTv0f2vXj6iJpg==
X-Received: by 2002:a63:4f52:0:b0:41a:3744:d952 with SMTP id p18-20020a634f52000000b0041a3744d952mr12528022pgl.186.1658361007090;
        Wed, 20 Jul 2022 16:50:07 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id z15-20020a17090abd8f00b001f21f7821e0sm68648pjr.2.2022.07.20.16.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 16:50:06 -0700 (PDT)
Date:   Wed, 20 Jul 2022 23:50:03 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, x86@kernel.org,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH v2 05/11] KVM: x86: emulator: update the emulation mode
 after CR0 write
Message-ID: <YtiUq7jm2Z1NTRv3@google.com>
References: <20220621150902.46126-1-mlevitsk@redhat.com>
 <20220621150902.46126-6-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621150902.46126-6-mlevitsk@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022, Maxim Levitsky wrote:
> CR0.PE toggles real/protected mode, thus its update
> should update the emulation mode.
> 
> This is likely a benign bug because there is no writeback
> of state, other than the RIP increment, and when toggling
> CR0.PE, the CPU has to execute code from a very low memory address.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  arch/x86/kvm/emulate.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index 6f4632babc4cd8..002687d17f9364 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -3659,11 +3659,22 @@ static int em_movbe(struct x86_emulate_ctxt *ctxt)
>  
>  static int em_cr_write(struct x86_emulate_ctxt *ctxt)
>  {
> -	if (ctxt->ops->set_cr(ctxt, ctxt->modrm_reg, ctxt->src.val))
> +	int cr_num = ctxt->modrm_reg;
> +	int r;
> +
> +	if (ctxt->ops->set_cr(ctxt, cr_num, ctxt->src.val))
>  		return emulate_gp(ctxt, 0);
>  
>  	/* Disable writeback. */
>  	ctxt->dst.type = OP_NONE;
> +
> +	if (cr_num == 0) {
> +		/* CR0 write might have updated CR0.PE */

Or toggled CR0.PG.  It's probably also worth noting that ->set_cr() handles side
effects to other registers, e.g. the lack of an EFER.LMA update makes this look
suspicious at first glance.

> +		r = update_emulation_mode(ctxt);
> +		if (r != X86EMUL_CONTINUE)
> +			return r;
> +	}
> +
>  	return X86EMUL_CONTINUE;
>  }
>  
> -- 
> 2.26.3
> 
