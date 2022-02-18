Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620094BBD4C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbiBRQTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:19:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237678AbiBRQR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:17:58 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12242A4A18
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:17:35 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 195so8279578pgc.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FRSZd3fBk7csQd6ekFYVUPxE635CUFF9aE3/2GpUFwY=;
        b=Nj6hmVanszUmzi9KjB+xJ4F/ntkI5tTY/48glTq88ZFVzRRwA+YJBnklzlNn7V/mf8
         BbZB1fKWW4YcAZ2NQQohD/DXqbwgvqIy9AWZmcS6GGxDgJNwcupy5GpbHV13in668gkR
         mzF+6ou++t9PcdNil+CM7qTsnDFssX4Y7uU2fRGRiOAIYlj1TZrYGyU1hL/5OQcWTVMd
         fX7bp29qB4QsKLv7SH7Q/hRwuy27WPVF0VzGPNWRkBQBGZ866qX3p+Ey2oJ1zpJ8MxA3
         ehnGTyFvgcq/VUtxUUrz8qCI7Wc8eZmxXTAN4FimrFxsiJG/a0vOFeKAKEApAjQcKWQi
         jgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FRSZd3fBk7csQd6ekFYVUPxE635CUFF9aE3/2GpUFwY=;
        b=5kWHXZeILWPaT6fl0sS4Ll+TNTcznRmj7wudeSUaSer4FwhmBd7YeJ3EJk3YDqVcMy
         Ktzz7GTCrYIb4jQAQBG96WIE3/AkDLWw3DfS6A+RTfPE0V2NU4dTjbOB5AOwGFjUibs0
         kePySrz/lOoFlKvwb1yN92ss48/HxEDasp+e9oMEV5j77cTygJ01r/P5Mw0p0g5BYiZa
         aomzXY2BViqO9i2jZW8Ltm/X0WDc0/Kt0/ItaC5OE4SjcefeHn0zjQXXiceKSXr/R48U
         88D4IsSyyAz3bFKXlVhbcCy+mqWi2N0RY6AOB3JkPD5bV0jSypSGZM8ue8X97Ixr7wpW
         BvsA==
X-Gm-Message-State: AOAM532+fQ66Y6sRk5xRVJGqn5HzDYIL2+xfhDZD2glRoWiyy/HfD4UX
        ewHTbeMAstEDNhVAq1HqhemiQA==
X-Google-Smtp-Source: ABdhPJxpbuKhDBeeP4BqX4FrhvC6lUgdxX0u4ICIDjV5mLveme+6a+IXNA092AMbXmo/1ibMLKxc3A==
X-Received: by 2002:a05:6a00:124f:b0:4c0:6242:c14e with SMTP id u15-20020a056a00124f00b004c06242c14emr8463713pfi.83.1645201054938;
        Fri, 18 Feb 2022 08:17:34 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id hk3sm5818815pjb.12.2022.02.18.08.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 08:17:34 -0800 (PST)
Date:   Fri, 18 Feb 2022 16:17:30 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peng Hao <flyingpenghao@gmail.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  kvm/vmx: Make setup/unsetup under the same conditions
Message-ID: <Yg/GmgbmLKTRqUbo@google.com>
References: <20220218111113.11861-1-flyingpeng@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218111113.11861-1-flyingpeng@tencent.com>
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

"KVM: VMX" for the scope, or maybe even "KVM: nVMX:" despite this not touching
vmx/nested.c.  Either way (but not "kvm/vmx:").

On Fri, Feb 18, 2022, Peng Hao wrote:
> Make sure nested_vmx_hardware_setup/unsetup are called in pairs under
> the same conditions.

Probably worth adding a sentence to clarify that the existing code isn't buggy
only because free_page() plays nice with getting passed '0' and vmx_bitmap is
initialized to zero.  Something like:

  Make sure nested_vmx_hardware_setup/unsetup() are called in pairs under
  the same conditions.  Calling nested_vmx_hardware_unsetup() when nested
  is false "works" right now because it only calls free_page() on zero-
  initialized pointers, but it's possible that more code will be added to
  nested_vmx_hardware_unsetup() in the future.

Reviewed-by: Sean Christopherson <seanjc@google.com>


> 
> Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 0ffcfe54eea5..5392def71093 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7852,7 +7852,7 @@ static __init int hardware_setup(void)
>  	vmx_set_cpu_caps();
>  
>  	r = alloc_kvm_area();
> -	if (r)
> +	if (r && nested)
>  		nested_vmx_hardware_unsetup();
>  
>  	kvm_set_posted_intr_wakeup_handler(pi_wakeup_handler);
> -- 
> 2.27.0
> 
