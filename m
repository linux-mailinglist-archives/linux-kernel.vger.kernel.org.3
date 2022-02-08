Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F334AE524
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 00:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbiBHXAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 18:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiBHXAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 18:00:43 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2EEC061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 15:00:39 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id i34so859905lfv.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 15:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MQGz6t0law5MVgqGGrzII5NWEt2DOl/FdzL0iPkOG9k=;
        b=E9TiYK6DZsY1U5F0Tz/ZT9q4LEvVWT6mkphsbB6E0Y1n5Dlkxhz4SP8L5DIe0g0vw0
         TBjFERjJM/SoPlnnskAFnDAxXbaaA/VBkK3AwKQZZQoeH0aXbtWhAa4ckS8Msfw9sMt/
         L/hwgWpDqGuZ26Xz3UnMuQ0f1DPRvr8rAwZpmJYC3SezqbcKajn15tKuUHb/A4Kq6NtJ
         I8jIqfhBUMKDLr0ovEbwGyHpY7X8wJB35ug8ElrKLDs/jIZGeIop6uAXzkxw3U0KSBRP
         HRW0PcDbqGlJDKpseICjPdFOfuyB2wOlgkYr3/iFjOdIE6/GrzEpdpJLM2ZvF146Jr3D
         ToMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MQGz6t0law5MVgqGGrzII5NWEt2DOl/FdzL0iPkOG9k=;
        b=3gaffxUPanDAwHNufbE/Ru1/YtHr9q1vsvsyPu2hrM1zUejDGrRzPJLVxHXkIeMVI/
         XSn0M5jDpo4IL8EIIMBFJvtFzyszJtNLwylV4feGE9cuSf2KdxR2OxUzczRKr5XFisdL
         FhobBheZDSDZm3bdlBiF/RWfPUgudlTsWlgkfxV5yU4uXPCGYfh1dKkZrREeh+swhTT7
         GGyvQ98f+MCmaE4kNe7aPJYdxc3HO/T6XYkAAOsAP4jREaJRg7iWllbycJPPCxVeSI/N
         ILsmp6lzL6rtSPxSXuSnPTXwoUInHkxwlX9/hloLYB5j8ikuOX9k1GbWlTmns+lzqeF2
         PTWQ==
X-Gm-Message-State: AOAM532h709kOcn5ebDS1DdiBQrA+wI9QLXuhGpokNUmJAUN3YzKC7F/
        gnhSbLaWibW4AiJPYrgMEhT2/RQa+M5ecWo0+vb6Tw==
X-Google-Smtp-Source: ABdhPJx8HIMe+XoTHDDgW/Bf8ZuBvIj0tal1BRdAYtu9iAQbllOd6YD7uh/lhTuv7ckF9ZyKCebOEGMWskDEAM7zE8g=
X-Received: by 2002:a05:6512:3f97:: with SMTP id x23mr2035026lfa.550.1644361237277;
 Tue, 08 Feb 2022 15:00:37 -0800 (PST)
MIME-Version: 1.0
References: <20220208225350.1331628-1-keescook@chromium.org> <20220208225350.1331628-3-keescook@chromium.org>
In-Reply-To: <20220208225350.1331628-3-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 8 Feb 2022 15:00:25 -0800
Message-ID: <CAKwvOdn0huB+HYMCkO9VEryg0AwPA2gpwaUJHGEvV+4846ytSw@mail.gmail.com>
Subject: Re: [PATCH v7 2/8] Compiler Attributes: Add __pass_object_size for Clang
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        Miguel Ojeda <ojeda@kernel.org>,
        George Burgess IV <gbiv@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
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

On Tue, Feb 8, 2022 at 2:53 PM Kees Cook <keescook@chromium.org> wrote:
>
> In order to gain greater visibility to type information when using
> __builtin_object_size(), Clang has a function attribute "pass_object_size"
> that will make size information available for marked arguments in
> a function by way of implicit additional function arguments that are
> then wired up the __builtin_object_size().
>
> This is needed to implement FORTIFY_SOURCE in Clang, as a workaround
> to Clang's __builtin_object_size() having limited visibility[1] into types
> across function calls (even inlines).
>
> This attribute has an additional benefit that it can be used even on
> non-inline functions to gain argument size information.
>
> [1] https://github.com/llvm/llvm-project/issues/53516

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: llvm@lists.linux.dev
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/compiler_attributes.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> index 37e260020221..d0c503772061 100644
> --- a/include/linux/compiler_attributes.h
> +++ b/include/linux/compiler_attributes.h
> @@ -263,6 +263,20 @@
>   */
>  #define __packed                        __attribute__((__packed__))
>
> +/*
> + * Note: the "type" argument should match any __builtin_object_size(p, type) usage.
> + *
> + * Optional: not supported by gcc.
> + * Optional: not supported by icc.
> + *
> + * clang: https://clang.llvm.org/docs/AttributeReference.html#pass-object-size-pass-dynamic-object-size
> + */
> +#if __has_attribute(__pass_object_size__)
> +# define __pass_object_size(type)      __attribute__((__pass_object_size__(type)))
> +#else
> +# define __pass_object_size(type)
> +#endif
> +
>  /*
>   *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-pure-function-attribute
>   */
> --
> 2.30.2
>
>


-- 
Thanks,
~Nick Desaulniers
