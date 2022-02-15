Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD344B7569
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242279AbiBORLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 12:11:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242448AbiBORK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 12:10:57 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5875B11ADC7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 09:10:47 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id ki18-20020a17090ae91200b001b8be87e9abso2229432pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 09:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mEraMBeUE18bI33qHJkvvFUiCOk/eT80q1v2VF9D8eA=;
        b=Y2hTZAlbfIY0sJ4Pctd9xklYW1gH9TwRSnUUH+BwwdPOuEDWodjUp5lPlKoEsEh+Ag
         SOBLKdP6tIGC82foLAuSFxsrx/nWjd6r4+WEew3aboADsbOG8JiQdZ9ym4O8drWJI0e9
         U12lKonAPKkqD9S58rS2IM64n+xgB1vme6q1isirP5eH9mp5p8kelt+x0P3gKcRikKfK
         L/yx5+xPFCMsdCAySNolWGsnnEVT3MXMZ50dmQG2JESLatDSDfsm9/xfwAEPdr6XTM7F
         /chdKDmSzH/P7BXfWFl2E/6nw7YjnxWnORhcGiIPW8tZ/mWGlWY9IQVngRLQpU9AbdLs
         C4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mEraMBeUE18bI33qHJkvvFUiCOk/eT80q1v2VF9D8eA=;
        b=r14oaEh4bgUN7s+zd1rJJIkrIOLt37kRv46ZFdCpGFXVT/6AXnXFvBNZbeWzvZd55R
         hX5pQQDY9Pkt9y30vkuGjNikx55IROmgdmnknWGuOLDScNnBbEauD9sbgSefa8Y4sKh/
         oQeew/Qv/92YZ+ojXsaKrtwf3d44eyZG3jtETJRZHPcOu11TVy4lLxxPSwxBH4hB26Ha
         3MThmQGKNWzKjUSeApbsjeoHi/erXB9uWewsc8WRlr87C0tQ5DY0ITHoZ79JtOm/0ToM
         I7CRGYWy7CuBemCC/XyLqysxHUglQzOaT9ma2GVe9NH0oRAddlOcuUyifCurWe/L3zL+
         pj0g==
X-Gm-Message-State: AOAM532vebUQuMlDSJQ9XZwgc9C5KH7ApUYkbk2+9+8oC/PrWBvIWzrZ
        Q6Lk1n87t13BI+DoI06Yw5Rerqm+J4dq4w==
X-Google-Smtp-Source: ABdhPJwlALiTyfkx/TwN6Da9Nsxe/fE0Q+xb8I449j0PrXfCJeYxSsSVM4gGc2IlgzH2m11QdX/ZCQ==
X-Received: by 2002:a17:90b:214:: with SMTP id fy20mr5463066pjb.89.1644945046677;
        Tue, 15 Feb 2022 09:10:46 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id w4sm3006166pgs.28.2022.02.15.09.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 09:10:46 -0800 (PST)
Date:   Tue, 15 Feb 2022 17:10:41 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 3/5] KVM: x86: warn on incorrectly NULL static calls
Message-ID: <YgvekYk2QEIzOc+T@google.com>
References: <20220214131614.3050333-1-pbonzini@redhat.com>
 <20220214131614.3050333-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214131614.3050333-4-pbonzini@redhat.com>
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

For the shortlog, it's not the "static call" that's incorrectly NULL, it's the
kvm_x86_ops.func that's wrong.  E.g. yank out static calls and KVM could still
keep the WARN.

On Mon, Feb 14, 2022, Paolo Bonzini wrote:
> Use the newly corrected KVM_X86_OP annotations to warn about possible
> NULL pointer dereferences as soon as the vendor module is loaded.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index e3f7d958c150..5dce6fbd9ab6 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1546,9 +1546,10 @@ extern struct kvm_x86_ops kvm_x86_ops;
>  
>  static inline void kvm_ops_static_call_update(void)
>  {
> -#define KVM_X86_OP(func) \
> +#define KVM_X86_OP_OPTIONAL(func) \
>  	static_call_update(kvm_x86_##func, kvm_x86_ops.func);
> -#define KVM_X86_OP_OPTIONAL KVM_X86_OP
> +#define KVM_X86_OP(func) \
> +	WARN_ON(!kvm_x86_ops.func); KVM_X86_OP_OPTIONAL(func)

As before, I'd prefer that we not have a KVM_X86_OP => KVM_X86_OP_OPTIONAL
dependency and instead have a common __KVM_X86_OP for this one case.

>  #include <asm/kvm-x86-ops.h>
>  }
>  
> -- 
> 2.31.1
> 
> 
