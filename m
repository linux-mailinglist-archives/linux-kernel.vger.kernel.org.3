Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DFD5292F6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 23:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349364AbiEPVgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 17:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347346AbiEPVf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 17:35:59 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7315A101E
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 14:35:58 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id q130so19683727ljb.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 14:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uwkH153JjE/VISwDC6yOaTP7NOzBFSKZdipSvNP+ktE=;
        b=pPEsL44A8/+VNexCO9dAr1v1HAI5ycZSTdy7Flz8UBakDFVI1Rxg0FRqBCOmyGWTXT
         TVAE+qwcOA6paQsDhTqw2ITaa/gsU/0l/O/x52asujpIJJuF0kTMD7zhJ8OECUjiJTSm
         or+nY2JtuynV/X2RIdxr05qWoL1N7dVZ9+ghQy3Ox46w6lwgjIwEYwNcr8Bo9Kehx8Wx
         UpJumvUJjYDPDPWt1ycthLsqqFZEMNJ3HM9JE0VYSbPSrAE3GEZpuyUd8TnRW1qK+e6M
         Uu2iZivkDEufqTjA9Pnfqxj/SRSwptWKzhvDJMHRaNO6zEfuDLy//XKHmnvMwvb2xWGg
         I7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uwkH153JjE/VISwDC6yOaTP7NOzBFSKZdipSvNP+ktE=;
        b=otaF0BRKCpMCl7ctb2v2WJ1+wUrAIvGUzOwZAPFVptJKaKfOiE5AtfY/AnfcnQ4IOW
         sk1LQgMTIWFDi0RkszZJXX6L81ZsW+zLKfTIg8RIUzfBDNgom8Q4XoAZakcG0FRol4Mq
         0ycTCzNVRJoCXEMwKsY29UnaQo34FwA54+aBgZMycUt051UiA8SedUkek0mAv2jtPyeU
         k3WOOlMq8rvjHI8zEeL/AxaIPjwDOASNOouYA3Lo2G5axMR3ofFy696hnM1AFpVnR47T
         Vgjfpg4l308LGLiECBLXW/JfzzUL7HqEXxhjn+Nc+6hZTH76YTCj48hNz/I2KtTtNEy8
         IxxA==
X-Gm-Message-State: AOAM5330Cp1TQEG/wEQvwMY/AnP20sod+VcOUL1D9eCgeQTrDqGA0x1I
        FyBG97CA/7P+cVayC48VddlC1OXevfBoKiMIytM7GUlw0doOuw==
X-Google-Smtp-Source: ABdhPJzU9+gfgDOfFGF1PxDHLodCEyA3jCCPrw7fhlBjvTt89XPwU+9AcC6bORZU1NTMdnruU+wLNmh9RPLfai8Jksg=
X-Received: by 2002:a2e:91cf:0:b0:24f:11ea:d493 with SMTP id
 u15-20020a2e91cf000000b0024f11ead493mr12125591ljg.408.1652736956594; Mon, 16
 May 2022 14:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220511174531.1098548-1-keescook@chromium.org>
In-Reply-To: <20220511174531.1098548-1-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 16 May 2022 14:35:45 -0700
Message-ID: <CAKwvOdkXUiB3T_YkcqDZAkdvN0=cB2NH-i6jj+Y=sL8r9VCJ6A@mail.gmail.com>
Subject: Re: [PATCH] lib: overflow: Always build 64-bit test cases
To:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Vitor Massaru Iha <vitor@massaru.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
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

On Wed, May 11, 2022 at 10:45 AM Kees Cook <keescook@chromium.org> wrote:
>
> There shouldn't be a reason to not build the 64-bit test cases on 32-bit
> systems; the types exist there too. Remove the #ifdefs.

I think this is breaking 32b ARM for clang-13 and older?
https://github.com/ClangBuiltLinux/linux/issues/1636

>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/lkml/202205110324.7GrtxG8u-lkp@intel.com
> Fixes: 455a35a6cdb6 ("lib: add runtime test of check_*_overflow functions")
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Vitor Massaru Iha <vitor@massaru.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Daniel Latypov <dlatypov@google.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  lib/overflow_kunit.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
> index 475f0c064bf6..ac37bb543476 100644
> --- a/lib/overflow_kunit.c
> +++ b/lib/overflow_kunit.c
> @@ -255,10 +255,8 @@ DEFINE_TEST_FUNC(u16, "%d");
>  DEFINE_TEST_FUNC(s16, "%d");
>  DEFINE_TEST_FUNC(u32, "%u");
>  DEFINE_TEST_FUNC(s32, "%d");
> -#if BITS_PER_LONG == 64
>  DEFINE_TEST_FUNC(u64, "%llu");
>  DEFINE_TEST_FUNC(s64, "%lld");
> -#endif
>
>  static void overflow_shift_test(struct kunit *test)
>  {
> @@ -650,10 +648,8 @@ static struct kunit_case overflow_test_cases[] = {
>         KUNIT_CASE(s16_overflow_test),
>         KUNIT_CASE(u32_overflow_test),
>         KUNIT_CASE(s32_overflow_test),
> -#if BITS_PER_LONG == 64
>         KUNIT_CASE(u64_overflow_test),
>         KUNIT_CASE(s64_overflow_test),
> -#endif
>         KUNIT_CASE(overflow_shift_test),
>         KUNIT_CASE(overflow_allocation_test),
>         KUNIT_CASE(overflow_size_helpers_test),
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
