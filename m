Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3C0523C28
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 20:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346063AbiEKSBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 14:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346027AbiEKSBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 14:01:17 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0B551E50
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 11:01:15 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id b18so4904071lfv.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 11:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vapj0kW4KwHiPms6GfxtxLcmGObJK471bDUmNzQRuog=;
        b=BFD5fz+C7GTIOPRH8A7H7w72GvFbrLP4mTnO1BVj2UVwNJd6mVAlOOCMUTtqhGxUt0
         VxLr9shPiDClWFiSXLImqDCVH8Jko3dbCW1ioEQ7whrSgDTzpFsPGFAQgjnkC/8x3t10
         DSUiXJE5fJ5eMMA78q4HZU5jhfq/qUkGnqA9DMyAHKRerVelAj1X4WHCXw5/HhbX4mLV
         3lB5D0c2VpPuoPt9wqtpYe6qFT+7onxnil8dOeCdK1i54YqCN4cSR4fP0Gcg17PRIYk2
         SoFB5GfleAb54SzI+XQdfvjbQ0CkD7Y70NfFk7ESmAerbbsrcDa4r/Znf43bVqgAvUtX
         zzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vapj0kW4KwHiPms6GfxtxLcmGObJK471bDUmNzQRuog=;
        b=VVpcNlyqOGOHgD1DEr1UZxEEL8Y0pw/jymW0waum2ilrgyLGp+3XHMMWGPcnvdL9KK
         sT6Im0TmtI8SwmBsRupda1sWALtiNuRP/3wH3PFjmt7NA6ekQZoGwReA2oW4FkUt0RJj
         7Vo1y97d7jLrJFT+EaiUdKCEnPmpati7uZy9QnXmkF6aYHe0Moot511rphS3sah/Vp66
         uMyrW7oR9hgLI0417UsrbaHMLbTS2+oVHi8LonbgbEGb1h2dWahRJ/rzmAg84XIMdKvU
         jlu0U7Nr1Wnk8JCZBRPDSVXkI8kJmzntC9+LqgeRYOCjK5CXi0zsSLuW4ylxdsJ5DZ8H
         79Hg==
X-Gm-Message-State: AOAM532lueziy0Gjy5xnSGO3bD51YAADe9XmPInuTGbWNuMHVpTORT5d
        6+iIsyNWqeSZwrdKldAVXdKNnFZAYmIxt57Y7+z5Fw==
X-Google-Smtp-Source: ABdhPJw18n/anGk78kJcfwbuCm1c1DJCRW8ONkjNYYHy9a4WHBpUUwKabm1HCH5hU465b4Sn61BD1WIu+IYeBknLcys=
X-Received: by 2002:a05:6512:1291:b0:473:b522:ef58 with SMTP id
 u17-20020a056512129100b00473b522ef58mr20617140lfs.190.1652292073536; Wed, 11
 May 2022 11:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220511072747.3960-1-jiangshanlai@gmail.com> <20220511072747.3960-2-jiangshanlai@gmail.com>
In-Reply-To: <20220511072747.3960-2-jiangshanlai@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 11 May 2022 11:01:02 -0700
Message-ID: <CAKwvOdmF_5KudQbC8j5hJT1CqxvYtMneZxb1Si3A2uNxopk3yQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] x86/entry: Introduce __entry_text for entry code
 written in C
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Marco Elver <elver@google.com>, Hao Luo <haoluo@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, May 11, 2022 at 12:27 AM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
>
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
>
> Some entry code will be implemented in C files.
> Introduce __entry_text to set them in .entry.text section.
>
> The new __entry_text disables instrumentation like noinstr, so
> __noinstr_section() is added for noinstr and the new __entry_text.
>
> Note, entry code can not access to %gs before the %gs base is switched
> to kernel %gs base, so stack protector can not be used on the C entry
> code.  But __entry_text doesn't disable stack protector since some
> compilers might not support function level granular attribute to
> disable stack protector.  It will be disabled in C file level.
>
> Cc: Borislav Petkov <bp@alien8.de>
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> ---
>  arch/x86/include/asm/idtentry.h | 3 +++
>  include/linux/compiler_types.h  | 8 +++++---
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
> index 72184b0b2219..acc4c99f801c 100644
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -13,6 +13,9 @@
>
>  #include <asm/irq_stack.h>
>
> +/* Entry code written in C. */
> +#define __entry_text __noinstr_section(".entry.text")
> +
>  /**
>   * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
>   *                   No error code pushed by hardware
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 1c2c33ae1b37..8c7e81efe9bf 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -225,9 +225,11 @@ struct ftrace_likely_data {
>  #endif
>
>  /* Section for code which can't be instrumented at all */
> -#define noinstr                                                                \
> -       noinline notrace __attribute((__section__(".noinstr.text")))    \
> -       __no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage
> +#define __noinstr_section(section)                             \
> +       noinline notrace __section(section) __no_profile        \
> +       __no_kcsan __no_sanitize_address __no_sanitize_coverage
> +
> +#define noinstr __noinstr_section(".noinstr.text")

I haven't looked at the rest of the series, but isn't `noinstr` used
in a bunch of places? Wont this commit break all those uses or at
least make it break bisection?

Also, my suggestion was simply not to open code
__attribute__((section(""))). Does this work?

```
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 7924f27f5c8b..10ec7039e17d 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -13,6 +13,9 @@

 #include <asm/irq_stack.h>

+/* Entry code written in C. Override the section used by noinstr. */
+#define __entry_text noinstr __section(".entry.text")
+
 /**
  * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
  *                   No error code pushed by hardware
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 1c2c33ae1b37..ce623099eb21 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -226,8 +226,8 @@ struct ftrace_likely_data {

 /* Section for code which can't be instrumented at all */
 #define noinstr
         \
-       noinline notrace __attribute((__section__(".noinstr.text")))    \
-       __no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage
+       noinline notrace __section(".noinstr.text") __no_kcsan          \
+       __no_sanitize_address __no_profile __no_sanitize_coverage

 #endif /* __KERNEL__ */
```
-- 
Thanks,
~Nick Desaulniers
