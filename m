Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF39C4D07BD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 20:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245117AbiCGTb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 14:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245110AbiCGTbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 14:31:22 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C127E0B1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 11:30:28 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id s18so1682967plp.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 11:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q9MIZw6teCffW6Igi7yqKRQRmAst7rY6bxwkmUE9mhs=;
        b=bZD8Y3SqOgghrjCIHTeGTF6y6uqzsnVMF4L6I6oOWCeeoTHF94gaNNfuDiAr11u+qa
         M+fjbH8BA93m9z4YCAZ1qs+tII+HXl7jmhJf9EFLpNy/zuGf0prGeo7Ba0dnTt5JxiCN
         9/5N2y2e4zqUHuOOgZ4rz2Q4HnUK+2M5MrVfIyKBFGIFsYzj6wxWB5syvmVxBSP4NUxk
         r3xQuoFO0F4eCOaFmTBQVV9t6tIbhMH6Oc1MvsC1jJffUHd5jOLs+ntjvfh6ylYTm1Ff
         snO7v4AJlAOzYvTfXCpISPyvw6RKAnTkeVXNoQ5DnQvl9fxQ7RurPKRpiQoipSNIHK4B
         T+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q9MIZw6teCffW6Igi7yqKRQRmAst7rY6bxwkmUE9mhs=;
        b=qjiBBAhYroGrRL8Za0+uywHdkdT3qOaueJ/2JWAfq5WdR+5Y1Nrrqp/B0udjINGTN9
         XXnTf+A5kyzADvMey4XNQKBo3YV/RL76Q1mBb6bRQuQ71L1ci+ZsFJOOcu4EA58FCMla
         UTNKf1KlzxGTTDhiItmL+LLmUifw2oEWh6WcxJ/rusGjJ57gV+x2kIPPbG/au0u138OE
         slOIuszx1HozIXRoIP7rPwZCcbfBrEh2nk/xkF7f4xpwNonVD9opEA5wR7MAJX2oBjqW
         cxGVzLLBlJiPxBQAw+F5TU1ZGHv3h6cEFXHp51/SgKO5fh2TUR40pdJFT0flrwl+E8qx
         EfeQ==
X-Gm-Message-State: AOAM530e6930vgXn8Pyt/cVVbGQWnlk6yjff5fgEHcgWCRB7kt1X33s5
        9axz0Cosr3utipLK729PnvUPoA==
X-Google-Smtp-Source: ABdhPJyueplzty6iTaelh4axK7ODYO1cjiZs/oKOKz7W6sQIdDdh6KDUi0nMOLA3BiyTcV+lPPH0aw==
X-Received: by 2002:a17:90a:ba10:b0:1bf:6900:2c5d with SMTP id s16-20020a17090aba1000b001bf69002c5dmr601274pjr.36.1646681427476;
        Mon, 07 Mar 2022 11:30:27 -0800 (PST)
Received: from google.com ([2620:15c:211:202:ed1d:9a92:2389:76be])
        by smtp.gmail.com with ESMTPSA id g6-20020a056a001a0600b004f2a4316a0asm16426990pfv.60.2022.03.07.11.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 11:30:26 -0800 (PST)
Date:   Mon, 7 Mar 2022 11:30:18 -0800
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 6/8] compiler_types.h: Add unified
 __diag_ignore_all for GCC/LLVM
Message-ID: <YiZdSoNcaESkzvBs@google.com>
References: <20220304224645.3677453-1-memxor@gmail.com>
 <20220304224645.3677453-7-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304224645.3677453-7-memxor@gmail.com>
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

On Sat, Mar 05, 2022 at 04:16:43AM +0530, Kumar Kartikeya Dwivedi wrote:
> Add a __diag_ignore_all macro, to ignore warnings for both GCC and LLVM,
> without having to specify the compiler type and version. By default, GCC
> 8 and clang 11 are used. This will be used by bpf subsystem to ignore
> -Wmissing-prototypes warning for functions that are meant to be global
> functions so that they are in vmlinux BTF, but don't have a prototype.
> 
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/compiler-clang.h | 3 +++
>  include/linux/compiler-gcc.h   | 3 +++
>  include/linux/compiler_types.h | 4 ++++
>  3 files changed, 10 insertions(+)
> 
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index f1aa41d520bd..babb1347148c 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -90,3 +90,6 @@
>  #else
>  #define __diag_clang_11(s)
>  #endif
> +
> +#define __diag_ignore_all(option, comment) \
> +	__diag_clang(11, ignore, option)
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index ccbbd31b3aae..d364c98a4a80 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -151,6 +151,9 @@
>  #define __diag_GCC_8(s)
>  #endif
>  
> +#define __diag_ignore_all(option, comment) \
> +	__diag_GCC(8, ignore, option)

While this approach will work for clang, it doesn't seem scalable for
GCC. Documentation/process/changes.rst documents that we support gcc
5.1+. This approach will only disable diagnostics for gcc 8+.

> +
>  /*
>   * Prior to 9.1, -Wno-alloc-size-larger-than (and therefore the "alloc_size"
>   * attribute) do not work, and must be disabled.
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 3f31ff400432..8e5d2f50f951 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -371,4 +371,8 @@ struct ftrace_likely_data {
>  #define __diag_error(compiler, version, option, comment) \
>  	__diag_ ## compiler(version, error, option)
>  
> +#ifndef __diag_ignore_all
> +#define __diag_ignore_all(option, comment)
> +#endif
> +
>  #endif /* __LINUX_COMPILER_TYPES_H */
> -- 
> 2.35.1
> 
