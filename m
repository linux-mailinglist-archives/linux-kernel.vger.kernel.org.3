Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840EE5A17DC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 19:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240934AbiHYRSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 13:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242134AbiHYRST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 13:18:19 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A48BC834
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 10:18:18 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 67so12233650pfv.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 10:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=gnMljPJ/lm4q/RBQXlsRGj0qaMzhOLblX5QXKQT9GOA=;
        b=p1XusnwBuXPciTUrnlwiAdph5OC6EkXk+q666UtGjiflFY51AQZo97IAR+bXvBE5mc
         6ZnwuE95uHUD9rAwsuB/gtyXhWQJwLI85ad5uXmJjUUNquSP3RzKzdeAlXyC99WVlm3R
         Y2lh8kQTg0EL/k5qB2L6VdySGhKh+I7I+ijgqd5xFk6Le4GhtS0Nk9THw5+VUlFpCYJI
         /HFiss9A50VlnXbP24JxGRhOojtOvQi3M31evuhjT92gnr7Fx1EAGVDT8Ys06xTC9MIS
         tZSV/bVEufRX/bA3tqR1mhypO9d7NYqoJHS6MHJy5HTfpGDzxuI3okYr/7DFGgHTxpRS
         t0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=gnMljPJ/lm4q/RBQXlsRGj0qaMzhOLblX5QXKQT9GOA=;
        b=n13+/84WgxRZDoFS+adCYPalD1Adzaff+Dqa98fyk6o9owZk8c9Tuhp23yCPY8ie2E
         Db5RtglJzJFBtzlaA/iEqOTb37AOcVUnJjq76PinSJCUZDW2WufUrWsmDk+2hff9gp1E
         OrEzC2aHXtVl3Sh09hW1u26FLEv7v1ynuhs3jtDdpIgkvp0qLZixhqoSE439jTCQgMC2
         G5oOCMiSwkt6Of90DW3ccRkYk/BED65VTl/bfGTwnLQ8dQEl9p9Fv2TavsREzxnBpM7g
         VE3pqzm35AP3M9DSBwpf/w1uyVXgr+isp3GCqFnC++Vew0wssMe7Bvqi3pJE2IoeQ3Uk
         6UoQ==
X-Gm-Message-State: ACgBeo1d/Gxj2xaE7kKyA89jvz58E1VdfHoxR7VZOVsbsBSSG0Aj8kty
        NiOAxY0CoxAueWj7IzPCQSvtiw==
X-Google-Smtp-Source: AA6agR6tK/D5enD9fgdi0ecU+FGxTwOMoe8z3P512kBNwxfyORCYzrkGCt7PVHxGWuY2Ef4fCuM4Vw==
X-Received: by 2002:a63:494a:0:b0:41c:f29e:2a2e with SMTP id y10-20020a63494a000000b0041cf29e2a2emr78650pgk.477.1661447898207;
        Thu, 25 Aug 2022 10:18:18 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id l63-20020a622542000000b00535e49245d6sm15216396pfl.12.2022.08.25.10.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 10:18:17 -0700 (PDT)
Date:   Thu, 25 Aug 2022 17:18:13 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        keescook@chromium.org
Subject: Re: [PATCH] x86/mm: Refuse W^X violations
Message-ID: <Yweu1dvkJ8aV+C+T@google.com>
References: <YwdpwykpV9RB+4tL@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwdpwykpV9RB+4tL@worktop.programming.kicks-ass.net>
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

On Thu, Aug 25, 2022, Peter Zijlstra wrote:
> 
> x86 has STRICT_*_RWX, but not even a warning when someone violates it.
> 
> Add this warning and fully refuse the transition.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 1abd5438f126..9e9bef3f36b3 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -579,6 +579,30 @@ static inline pgprot_t static_protections(pgprot_t prot, unsigned long start,
>  	return __pgprot(pgprot_val(prot) & ~forbidden);
>  }
>  
> +/*
> + * Validate and enforce strict W^X semantics.
> + */
> +static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long start,
> +				  unsigned long pfn, unsigned long npg)
> +{
> +	unsigned long end;
> +

I think this needs

	if (!(__supported_pte_mask & _PAGE_NX))
		return new;

to play nice with non-PAE 32-bit kernels.

> +	if (!((pgprot_val(old) ^ pgprot_val(new)) & (_PAGE_RW | _PAGE_NX)))
> +		return new;
> +
> +	if ((pgprot_val(new) & (_PAGE_RW | _PAGE_NX)) != _PAGE_RW)
> +		return new;
> +
> +	end = start + npg * PAGE_SIZE - 1;
> +	WARN(1, "CPA refuse W^X violation: %016llx -> %016llx range: 0x%016lx - 0x%016lx PFN %lx\n",

WARN_ONCE() to avoid eternal spam if something does go sideways?

> +	     (unsigned long long)pgprot_val(old),
> +	     (unsigned long long)pgprot_val(new),
> +	     start, end, pfn);
> +
> +	/* refuse the transition into WX */
> +	return old;
> +}
