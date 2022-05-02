Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA73517285
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 17:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385751AbiEBPci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 11:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385727AbiEBPcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 11:32:36 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC175F5F
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 08:29:07 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bu29so25930561lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 08:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mJZi3ZHZzznhkvhk6k2BNWLD+9VacVh10y6OH5XXW78=;
        b=XmdUB3iEBInrRe1NBUO/9Q2vVt6hEdx6QMkGnBwl19RxBGB57mYSp6n6aLsy+gJfjr
         o682oi9l2Ika+uaoK36Mf9anJ8cX9RVM3hGCG0mU8KG9Kq4FECPiSgjHYtDbvmxD1V2F
         G7HVsQUuwU/OUvl0u0B+VeUwau2w+3rzTqt/jeA76AED3uxLVfvA716VRHwfCa8tu5Se
         S2kqb5bUHeRE27PP6ZiwUACUsMOVp5w6XGNBInY9WUtSzhLqa9ulQgffgpkSJTdCT5ww
         5xepv5fAF4h6WdK0/iJeYByCp+NV6+8GuO+4zEmyotEkFpwNYa3CQPvUHlUBu8/Wwtcq
         c5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mJZi3ZHZzznhkvhk6k2BNWLD+9VacVh10y6OH5XXW78=;
        b=w9ovxmdsImLwZgSnHzQtuedh4K4Kgn5fh1YWBFcRLwEC5NKlLJKhai9soBwrommbae
         7HqOhnSkFWaUHy1o36Qc+UXe+vu0COJ5A9sDsKHwvHa1RV3fquV6rWHADp/QPxzzmPr1
         qd4IaBAQtWIbE1vE5usEbP5gx5seSDkj4jki89vtVRWl6nPV5lLfooxk3u7FEdc8Bhfp
         LbseC07jTHOTV1qi9ioRPJgo12rftnWFkV7m5nzONVRCL1fRu8JC3RcWZ7Kd2asiP2Fl
         tIryoMiYJJxjCauSV/ujG7OIfbZ/Qg0VU9sAyCKARDIhVMHb2HitshBco0XHaiURHEMg
         oGQw==
X-Gm-Message-State: AOAM5326gZffaT3sHqQhUChspcW5n9YxiKp8gZtOiue0rA4Df0y0VEOr
        Hs9Ayp3Q7eJKUlKu4CsFnSu7tlGDcJXW0e1eCfkK7bn93k3dSQ==
X-Google-Smtp-Source: ABdhPJzWRcMOAcnFWErCA4rKebXrGc+HSsjxp963gy+7FZ3YP+hroKlsDZbT2mXVoscyvNkXT+k+MeAIapO9+y9XUS4=
X-Received: by 2002:a05:6512:3c9b:b0:472:60d0:ebb0 with SMTP id
 h27-20020a0565123c9b00b0047260d0ebb0mr5571780lfv.682.1651505345339; Mon, 02
 May 2022 08:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220429235644.697372-1-cmllamas@google.com> <20220429235644.697372-5-cmllamas@google.com>
In-Reply-To: <20220429235644.697372-5-cmllamas@google.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Mon, 2 May 2022 08:28:53 -0700
Message-ID: <CAHRSSEyRm2wkFhxE+wz6bVgne7+pBE0_cjL=bhcesFqA1=Sy6Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] binder: convert logging macros into functions
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Hridya Valsaraju <hridya@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Li Li <dualli@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kselftest@vger.kernel.org
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

On Fri, Apr 29, 2022 at 4:57 PM Carlos Llamas <cmllamas@google.com> wrote:
>
> Converting binder_debug() and binder_user_error() macros into functions
> reduces the overall object size by 16936 bytes when cross-compiled with
> aarch64-linux-gnu-gcc 11.2.0:
>
> $ size drivers/android/binder.o.{old,new}
>    text    data     bss     dec     hex filename
>   77935    6168   20264  104367   197af drivers/android/binder.o.old
>   65551    1616   20264   87431   15587 drivers/android/binder.o.new
>
> This is particularly beneficial to functions binder_transaction() and
> binder_thread_write() which repeatedly use these macros and are both
> part of the critical path for all binder transactions.
>
> $ nm --size vmlinux.{old,new} |grep ' binder_transaction$'
> 0000000000002f60 t binder_transaction
> 0000000000002358 t binder_transaction
>
> $ nm --size vmlinux.{old,new} |grep binder_thread_write
> 0000000000001c54 t binder_thread_write
> 00000000000014a8 t binder_thread_write
>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binder.c | 41 ++++++++++++++++++++++++++++------------
>  1 file changed, 29 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index b9df0c8a68d3..bfb21e258427 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -133,19 +133,36 @@ static int binder_set_stop_on_user_error(const char *val,
>  module_param_call(stop_on_user_error, binder_set_stop_on_user_error,
>         param_get_int, &binder_stop_on_user_error, 0644);
>
> -#define binder_debug(mask, x...) \
> -       do { \
> -               if (binder_debug_mask & mask) \
> -                       pr_info_ratelimited(x); \
> -       } while (0)
> +static __printf(2, 3) void binder_debug(int mask, const char *format, ...)
> +{
> +       struct va_format vaf;
> +       va_list args;
>
> -#define binder_user_error(x...) \
> -       do { \
> -               if (binder_debug_mask & BINDER_DEBUG_USER_ERROR) \
> -                       pr_info_ratelimited(x); \
> -               if (binder_stop_on_user_error) \
> -                       binder_stop_on_user_error = 2; \
> -       } while (0)
> +       if (binder_debug_mask & mask) {
> +               va_start(args, format);
> +               vaf.va = &args;
> +               vaf.fmt = format;
> +               pr_info_ratelimited("%pV", &vaf);
> +               va_end(args);
> +       }
> +}
> +
> +static __printf(1, 2) void binder_user_error(const char *format, ...)
> +{
> +       struct va_format vaf;
> +       va_list args;
> +
> +       if (binder_debug_mask & BINDER_DEBUG_USER_ERROR) {
> +               va_start(args, format);
> +               vaf.va = &args;
> +               vaf.fmt = format;
> +               pr_info_ratelimited("%pV", &vaf);
> +               va_end(args);
> +       }
> +
> +       if (binder_stop_on_user_error)
> +               binder_stop_on_user_error = 2;
> +}
>
>  #define binder_set_extended_error(ee, _id, _command, _param) \
>         do { \
> --
> 2.36.0.464.gb9c8b46e94-goog
>
