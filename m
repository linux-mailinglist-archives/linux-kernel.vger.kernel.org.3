Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2053257CD98
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbiGUO1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiGUO1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:27:48 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC7981B2E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:27:47 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id n18so3100018lfq.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vVPqdnUfLoXatTXc15bcg0nhUyjA2e3G5yJNqLlYJCQ=;
        b=MqOKGHlFubPD3KsBefcVz9F6wXbCvDSAEF4Ezkx7YkU9R3TQO9bDXREtmH/oGHtvod
         1giSYYH2lrsBuxeDOpfOc/PuuswDwFjosAOjvqaVqV46inoMMJ6HhqErhxWOjX7KS9+A
         r3bKAxeW9OA98aKOYKGKqim9/qyxfpMD2AqFMv01kFdT/5NqXpdcpj54E8z1e//nEWBu
         F6fEUywVgpya+D0TvVmnOyrdQHUx/Gd+0BIrhgu/YS1dkFY3ozbr7NxIXE6/GZqbahlX
         iyouIzFROTE+w99RDbQqdA2PGYvvjDZXwFuLYZW/GUVMXVzXunnU042ha9wxUnRaxQUl
         01ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vVPqdnUfLoXatTXc15bcg0nhUyjA2e3G5yJNqLlYJCQ=;
        b=4X6K5yUGNbr5EcIe+LSofwn/TzykVUmfXUQnsx6+JMumqhmYO0AY8aN+ZRhKs2mFPg
         FAr9vA+XputuUMUVAjwcgQTgsKNHndE8gXxT3DWZ4pekNhtFDDoUvT3rIBwn4xDz3Uvc
         RDhOKCUDotcv1HMqU3ZFO6niELGzJ+9bbG1dpFqFGCujudhchl+IaO661ojbr9qD20y0
         k20MXMYiiXRBCf5J1vP776PYLCashp5EvUaW0TWKZk0KQ9N/uMo5CAJxq/j65Wcpgyh0
         y8W07H5+V0NJ6o8wJSUpgsZPKnTqU/HRWU5FiN0uWTPfZUoe/gfiiBSa2/cFBs9boT9+
         xXkg==
X-Gm-Message-State: AJIora9lmxuklA+LFN0g14Eg0Kx17ui0EQ6jLzvl85JjRyE4AtMCOyPG
        K8eu8AHjFXPy+3h6844ByDFsk8WJSAjsXMEASbS8Zw==
X-Google-Smtp-Source: AGRyM1udVa2irl52OVMBnbqGFxA+aMG+iMRiI2R2lJXR6gMSb6uY94C6ywicucAlyyZxSxAiMOnEbLUPonXlaBWfboM=
X-Received: by 2002:a19:7902:0:b0:48a:6872:68ab with SMTP id
 u2-20020a197902000000b0048a687268abmr1918109lfc.626.1658413665896; Thu, 21
 Jul 2022 07:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220720232332.2720091-1-justinstitt@google.com>
In-Reply-To: <20220720232332.2720091-1-justinstitt@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 21 Jul 2022 07:27:34 -0700
Message-ID: <CAKwvOdnSjyOdCZZ9AegCyfns3bvH3fbtbVgdThO2+rJAE=1bag@mail.gmail.com>
Subject: Re: [PATCH] Makefile.extrawarn: re-enable -Wformat for clang
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 4:23 PM Justin Stitt <justinstitt@google.com> wrote:
>
> There's been an ongoing mission to re-enable the -Wformat warning for
> Clang. A previous attempt at enabling the warning showed that there were
> many instances of this warning throughout the codebase. The sheer amount
> of these warnings really polluted builds and thus -Wno-format was added
> to _temporarily_ toggle them off.
>
> After many patches the warning has largely been eradicated for x86,
> x86_64, arm, and arm64 on a variety of configs. The time to enable the
> warning has never been better as it seems for the first time we are
> ahead of them and can now solve them as they appear rather than tackling
> from a backlog.
>
> As to the root cause of this large backlog of warnings, Clang seems to
> pickup on some more nuanced cases of format warnings caused by implicit
> integer conversion as well as default argument promotions from
> printf-like functions.
>
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Previous attempt: (https://patchwork.kernel.org/project/linux-kbuild/patch/20190201210853.244043-1-jflat@chromium.org/)
>
> Note:
> For this patch to land on its feet, the plethora of supporting patches that
> fixed various -Wformat warnings need to be picked up. Thanfully, a lot
> of them have!
>
> Here are the patches still waiting to be picked up:
> * https://lore.kernel.org/all/20220718230626.1029318-1-justinstitt@google.com/
> * https://lore.kernel.org/all/20220711222919.2043613-1-justinstitt@google.com/

Hi Masahiro, Nathan, and Tom,
What are your thoughts for _when_ in the release cycle this should be
picked up?  I worry that if we don't remove this soon, we will
backslide, and more -Wformat issues will crop up making removing this
in the future like digging in sand.  Justin has chased down many
instances of this warning, and I'm happy to help clean up fallout from
landing this.

>
>  scripts/Makefile.extrawarn | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index f5f0d6f09053..9bbaf7112a9b 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -47,7 +47,6 @@ else
>
>  ifdef CONFIG_CC_IS_CLANG
>  KBUILD_CFLAGS += -Wno-initializer-overrides
> -KBUILD_CFLAGS += -Wno-format
>  KBUILD_CFLAGS += -Wno-sign-compare
>  KBUILD_CFLAGS += -Wno-format-zero-length
>  KBUILD_CFLAGS += $(call cc-disable-warning, pointer-to-enum-cast)
> --
> 2.37.0.170.g444d1eabd0-goog
>


-- 
Thanks,
~Nick Desaulniers
