Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5325164AD
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 16:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240427AbiEAONd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 10:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiEAONb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 10:13:31 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B44513D13
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 07:10:05 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id o11so9547110qtp.13
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 07:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BRwGtOiAYfwSN6Oles1YkgeEY1NKrbkCB/10eptXYYY=;
        b=ClFxWUjH8XMA/vgyIe0hQoH/MzjY7rMmcS4ORgWAsYLQMdB11XCi+8aDZo5xJHxoia
         rGUM3u8GjHZzPvRLqInRjExs8EXMTpVvq3UyPI35dr20I+Pgss217fMN4CB1QPDUF2P7
         jqbGaf/CSr0/vxi50FnsoKOypQITAUMKcbsliEZW2GnvNnakXXqlRquIskrv9hG6ZnKB
         Wra+6tDrbA3taShQH7U8Pvjiav2Xbvo+W6GxaxcjON+1kWo8hzCzrj/TeYY/B25/WxSm
         kCUm7A1y54+VXBprfqyef9JLQz4Yei7i4EqNgf75MlR3duwRaj4R7QR2SNOTADEqLkvK
         onDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BRwGtOiAYfwSN6Oles1YkgeEY1NKrbkCB/10eptXYYY=;
        b=RvYEAeGHgxgxdzFkHaVLgwaf2kg16CaYgNq17BWBnuejLyqhYqVYkGLUczIwAERbuW
         ifWcGL8r+heY8RnRBe5GWxgWs2K5gI3jvaouWInmVEAVdXpyuO1mf8lPF4iNowvUduBx
         +QPV6dOoLMy4rc23ZdZnH+9D6zNZicBGLPppHtWKJTTrDllNd8yQiEtQP222dEYaryuW
         tFVCgIBPAPcXs3G8GX3iYVpfC+RRO08f6Cx/a7envKyJDiF/fkzo1QSo8iWbDxL72ERR
         qHxgsAK+O6MYMGXPMG2pAEAdxW/E3NRIS8cUBX21nqRkzYIwCZDQ7G4gPnRtwC20K5WS
         7iWA==
X-Gm-Message-State: AOAM532hFyjHCQpCVTwhAYLca2W+gBqrt02Ec4fEh374QxPcnYvz8hyf
        laGF70h2Of8wiglcvapjoqQ=
X-Google-Smtp-Source: ABdhPJxPM2isTbHISz0t0AcLxXTLolOd3oSBp6e9+AzqjOY7OiPXahL7T0OmhvO4YXUviKQdBzYLSQ==
X-Received: by 2002:a05:622a:5d0:b0:2e1:d430:a5c9 with SMTP id d16-20020a05622a05d000b002e1d430a5c9mr6931254qtb.639.1651414204081;
        Sun, 01 May 2022 07:10:04 -0700 (PDT)
Received: from mail.google.com ([207.246.89.135])
        by smtp.gmail.com with ESMTPSA id g20-20020ac84694000000b002f39b99f6b6sm2688086qto.80.2022.05.01.07.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 07:10:03 -0700 (PDT)
Date:   Sun, 1 May 2022 22:09:53 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, changbin.du@gmail.com,
        rostedt@goodmis.org, mingo@redhat.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH] RISC-V: Don't check text_mutex during stop_machine
Message-ID: <20220501140953.3dkqa6jhkcxzammq@mail.google.com>
References: <20220322022331.32136-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322022331.32136-1-palmer@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 07:23:31PM -0700, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmerdabbelt@google.com>
> 
> We're currently using stop_machine() to update ftrace, which means that
> the thread that takes text_mutex during ftrace_prepare() may not be the
> same as the thread that eventually patches the code.  This isn't
> actually a race because the lock is still held (preventing any other
> concurrent accesses) and there is only one thread running during
> stop_machine(), but it does trigger a lockdep failure.
> 
> This patch just elides the lockdep check during stop_machine.
> 
> Fixes: c15ac4fd60d5 ("riscv/ftrace: Add dynamic function tracer support")
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Reported-by: Changbin Du <changbin.du@gmail.com>
> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> --
> 
> Changes since v1 [<20210506071041.417854-1-palmer@dabbelt.com>]:
> * Use ftrace_arch_ocde_modify_{prepare,post_process}() to set the flag.
>   I remember having a reason I wanted the function when I wrote the v1,
>   but it's been almost a year and I forget what that was -- maybe I was
>   just crazy, the patch was sent at midnight.
> * Fix DYNAMIC_FTRACE=n builds.
> ---
>  arch/riscv/include/asm/ftrace.h |  7 +++++++
>  arch/riscv/kernel/ftrace.c      | 12 ++++++++++++
>  arch/riscv/kernel/patch.c       | 10 +++++++++-
>  3 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
> index 04dad3380041..3ac7609f4ee9 100644
> --- a/arch/riscv/include/asm/ftrace.h
> +++ b/arch/riscv/include/asm/ftrace.h
> @@ -81,8 +81,15 @@ do {									\
>  struct dyn_ftrace;
>  int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
>  #define ftrace_init_nop ftrace_init_nop
> +extern int riscv_ftrace_in_stop_machine;
>  #endif
>  
> +#else /* CONFIG_DYNAMIC_FTRACE */
> +
> +#ifndef __ASSEMBLY__
> +#define riscv_ftrace_in_stop_machine 0
>  #endif
>  
> +#endif /* CONFIG_DYNAMIC_FTRACE */
> +
>  #endif /* _ASM_RISCV_FTRACE_H */
> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> index 4716f4cdc038..c5f77922d7ea 100644
> --- a/arch/riscv/kernel/ftrace.c
> +++ b/arch/riscv/kernel/ftrace.c
> @@ -11,15 +11,27 @@
>  #include <asm/cacheflush.h>
>  #include <asm/patch.h>
>  
> +int riscv_ftrace_in_stop_machine;
> +
>  #ifdef CONFIG_DYNAMIC_FTRACE
>  int ftrace_arch_code_modify_prepare(void) __acquires(&text_mutex)
>  {
>  	mutex_lock(&text_mutex);
> +
> +	/*
> +	 * The code sequences we use for ftrace can't be patched while the
> +	 * kernel is running, so we need to use stop_machine() to modify them
> +	 * for now.  This doesn't play nice with text_mutex, we use this flag
> +	 * to elide the check.
> +	 */
> +	riscv_ftrace_in_stop_machine = true;
> +
>  	return 0;
>  }
>  
>  int ftrace_arch_code_modify_post_process(void) __releases(&text_mutex)
>  {
> +	riscv_ftrace_in_stop_machine = false;
>  	mutex_unlock(&text_mutex);
>  	return 0;
>  }

The function ftrace_init_nop() should be updated. That's not in stop-machine
context.

@@ -136,9 +124,9 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
 {
        int out;

-       ftrace_arch_code_modify_prepare();
+       mutex_lock(&text_mutex);
        out = ftrace_make_nop(mod, rec, MCOUNT_ADDR);
-       ftrace_arch_code_modify_post_process();
+       mutex_unlock(&text_mutex);


-- 
Cheers,
Changbin Du
