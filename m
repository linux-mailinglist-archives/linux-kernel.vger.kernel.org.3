Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443CD4C3A98
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 01:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbiBYA7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 19:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbiBYA7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 19:59:13 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1C918C7B0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:58:42 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 12so3253233pgd.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KVylA7c4QreaqL3IEnPyuKDimwPrtrjRybV/nnL1tjA=;
        b=VLezqZJc+jGxvHEgirOlFROmKIdgMTLquAgf7ZPsuvNWiNOmfxPxjIL66Qq7aDgEpc
         HNxrsNX0TU8Kh/gfyIghAy6cjJu3/ZWaZ9zZABqnMqSNO1i+UVv1/2CGPM5cgpm8STOA
         JOx7gf2uutGYuxXrO0TX5LpejX/WtKcgsccnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KVylA7c4QreaqL3IEnPyuKDimwPrtrjRybV/nnL1tjA=;
        b=noYyIg9gTwAo3NWwaj8a6zqPCVEVSJXJZqtnXX1iZHEMWliuPBCmeaXgyrkkpvNsJm
         KscIbK5v/wHFlfV0Ysk60Nn65AXCwjnNdtAHMAmy7zoPJQkTzul/mCqNX6DZABAhCbwn
         WTYsP/HdR6JhRus/uYXc1zE0wxqJ5r6fNAsw7Su2PlTbxxrHC3I7A8F3SqI60W1JkUWM
         s6zQCmloAa4xj88JpQaq6cL3ES/AbQP2qkY09ujA5KBU1/QcyRJt1gditlqbGSOA4IHy
         ea6SX9m7cM3IwJH+Q9cGc3YO/F4efbaOspPBr+L9whgzE4WNcWHzX5jm4CUvDkgIbIAk
         BOWA==
X-Gm-Message-State: AOAM5337UcGRjYQ2pFsRlE7X2ePIT80FUAm/D02EGXJVBVJPP7mKazHM
        VBMNLZesMAyaC0u2csTqV+UzxA==
X-Google-Smtp-Source: ABdhPJzP7RwKYNjsY1KMBLscD49zWj2hDte4pRzb33UrHvI/KxQSOQ63bB4EeIsT8z32DkDfcGX9yA==
X-Received: by 2002:aa7:8d0f:0:b0:4e1:31de:9080 with SMTP id j15-20020aa78d0f000000b004e131de9080mr5395122pfe.1.1645750722307;
        Thu, 24 Feb 2022 16:58:42 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v10-20020a056a00148a00b004e0f420dd90sm740317pfu.40.2022.02.24.16.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 16:58:41 -0800 (PST)
Date:   Thu, 24 Feb 2022 16:58:41 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 15/39] x86/ibt,kprobes: Fix more +0 assumptions
Message-ID: <202202241657.6C894F8@keescook>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.892372059@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224151322.892372059@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 03:51:53PM +0100, Peter Zijlstra wrote:
> With IBT on, sym+0 is no longer the __fentry__ site.
> 
> NOTE: the architecture has a special case and *does* allow placing an
> INT3 breakpoint over ENDBR in which case #BP has precedence over #CP
> and as such we don't need to disallow probing these instructions.
> 
> NOTE: irrespective of the above; there is a complication in that
> direct branches to functions are rewritten to not execute ENDBR, so
> any breakpoint thereon might miss lots of actual function executions.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/kprobes/core.c |   11 +++++++++++
>  kernel/kprobes.c               |   15 ++++++++++++---
>  2 files changed, 23 insertions(+), 3 deletions(-)
> 
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -1156,3 +1162,8 @@ int arch_trampoline_kprobe(struct kprobe
>  {
>  	return 0;
>  }
> +
> +bool arch_kprobe_on_func_entry(unsigned long offset)
> +{
> +	return offset <= 4*HAS_KERNEL_IBT;
> +}

Let's avoid magic (though obvious right now) literal values. Can the "4"
be changed to a new ENBR_INSTR_SIZE macro or something?

-- 
Kees Cook
