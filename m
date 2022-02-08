Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB0A4ADA20
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239556AbiBHNjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349830AbiBHNjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 08:39:18 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56F3C03FECE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 05:39:17 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id bt13so25930576ybb.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 05:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jkWKVFY9Ane+4hLx7KO8wJLB4fAu322gdHrEZT3DJhA=;
        b=roCaBezV/DQ17i+sXf/6XpzD0kL3lOx0tmGDYIQeLnFfebE+ICp2HRuPG2IM2OTZ6U
         oxUfMDdFvyCgHJWd07HTyS796Uu/Xb40/dqYd0h2UgrG0FDL1UEWaTPpvJ+Bn0XaXkHW
         z79H5Oz0JfkFDiomzRoZug3tTey8JUBGRcKGzeViKw8Cn2IbxzfPPkbBrupntOFHryUy
         phoG8jGtTaisDjxtJW0duvFMpIYU1ydx+KE98ezaImPdL2JSEInpLxYQuhlKF1ncpz/y
         L/DKbzp03/UiCgOARSWW+guLsK9dx4vi8Jfi3cq1N+i6yudIQC4v9hq8A+N0imsmrdkg
         ZDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jkWKVFY9Ane+4hLx7KO8wJLB4fAu322gdHrEZT3DJhA=;
        b=pCy8z2zSl4zUOy4n0GJAFxvJVOXwYD/sRSp10Gq5igocVqLkyZCScM6z/yMQt1bds1
         96NVMTHyn+GCEWwQhVKG61NU5leeYTnAfrI9wRZYeddQ+bgAqxbzMv0f6wz3mwhKCKZ1
         Q5CAfDAwnD5mp0HkPDXkL5NNO2AbjssOM88Z22CnElwLqT5vLe7vHcxltjqURuwZV7Te
         eUEIb9JlE9n8E6bPmJ50cV8MaRDZD96e6EasvW2lIROmR3gGKyO9sJm5ma7Mgc25DaQO
         t2T/y0W+uuQxekzm4iciC4RF1b9q2QPraYGv5XQeyIeCl7sySFWhNoOi41DGGL2S/bEr
         dNJw==
X-Gm-Message-State: AOAM531jurVtcP42Uoxb8Hun2K4LxAahhkbNUyJo8Tx5naCoR0EKgv1U
        6fqEV/lzO5Fc++pWyLaA3TiA2mmGhbotfn6lHwggKA==
X-Google-Smtp-Source: ABdhPJxVPX7eETUkWHJHX+qRDcXXalcx4ypoqmAMKW5Ugv2G+t/qfCIMALqgvBuTV9JQ7+kf/GBhkFyc36+EodIy1rk=
X-Received: by 2002:a81:1153:: with SMTP id 80mr4667357ywr.327.1644327556844;
 Tue, 08 Feb 2022 05:39:16 -0800 (PST)
MIME-Version: 1.0
References: <1644324666-15947-1-git-send-email-yangtiezhu@loongson.cn> <1644324666-15947-5-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1644324666-15947-5-git-send-email-yangtiezhu@loongson.cn>
From:   Marco Elver <elver@google.com>
Date:   Tue, 8 Feb 2022 14:39:05 +0100
Message-ID: <CANpmjNOFL1vTZS28z_DWSz+X64_ghXBiGj3Fhee=wpRexZy7kA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] ubsan: no need to unset panic_on_warn in ubsan_epilogue()
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Xuefeng Li <lixuefeng@loongson.cn>, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 8 Feb 2022 at 13:51, Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> panic_on_warn is unset inside panic(), so no need to unset it
> before calling panic() in ubsan_epilogue().
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Reviewed-by: Marco Elver <elver@google.com>


> ---
>  lib/ubsan.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/lib/ubsan.c b/lib/ubsan.c
> index bdc380f..36bd75e 100644
> --- a/lib/ubsan.c
> +++ b/lib/ubsan.c
> @@ -154,16 +154,8 @@ static void ubsan_epilogue(void)
>
>         current->in_ubsan--;
>
> -       if (panic_on_warn) {
> -               /*
> -                * This thread may hit another WARN() in the panic path.
> -                * Resetting this prevents additional WARN() from panicking the
> -                * system on this thread.  Other threads are blocked by the
> -                * panic_mutex in panic().
> -                */
> -               panic_on_warn = 0;
> +       if (panic_on_warn)
>                 panic("panic_on_warn set ...\n");
> -       }
>  }
>
>  void __ubsan_handle_divrem_overflow(void *_data, void *lhs, void *rhs)
> --
> 2.1.0
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/1644324666-15947-5-git-send-email-yangtiezhu%40loongson.cn.
