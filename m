Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3FE5AFB85
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 07:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiIGFFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 01:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIGFFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 01:05:36 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA217C1AC
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 22:05:35 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t14so11236614wrx.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 22:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=7IkNcBKROZDe2svNOYayhMA1/a0HRnLUmIvfHwVW83g=;
        b=jl1pBdPjIR7HAtqWy+xpe+7nHp3bSmGOzUZapTfXlJD2/iSmmJeBl6Rk7IQu17M5iy
         Fum5G6E8b2J/dmp0cUopju7+GlUuMotsE4noU4U34dXI38OYuNMVH/YvqtKHXZFdt/kZ
         edQzy66ZVrIsygnn2PcY08npLQ7CH2eVCI1yP/ZcJjXonQMfADXUHACb2l3aFlT0TGd7
         gfBGYDzF2E9hrb/JZ9dQQ4RpD0KXRqPv0WkG+etJi7VzNVp5tZw/FB7WsfLohdK5ai0U
         AqsxV25fK/XVVxTRmm9tDoYa8XpP/Qb830FT2szPkixe48b8/zQ1NjA3CBMOC4TT/WD3
         0jnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=7IkNcBKROZDe2svNOYayhMA1/a0HRnLUmIvfHwVW83g=;
        b=Od0YYxCfY5Tvy71RavDLGX4RIxuCMoILC4pv97Z8EcTSvXOGPtljsKqi9DqwkpqPj+
         FdtaNoBFy5n39kfM20SCeo2F8THGyfn0RbX6ToaZWAJpnzbuF3dXkNUWrbmlj3/k7u4/
         pjCV8pwefeRehW10vrglQhgGSQeolz1WVD876NG4W+4H3UlgSqdLPAJ3SWmeh36KoBKB
         p19CuVmpZbBGyKV1rU20JalKoo+4RgGx+VHTesk5mCSnk/uTEPMXsoLMG9Darw/XzQ8X
         ZQEqmNRHOWmf1RZbjgbFu79MhaKzwD0GgGveliFWXt+XoQvhUPhznhTSBP8UiSJQ+F2r
         XZUg==
X-Gm-Message-State: ACgBeo3cfwqbqQOkZhzhwn6tWOb+9/hHV8eHhjwMZNqediZqaQipDfmi
        jJDU0X5O5s+UnH32kujelDAOE2fb39mOcDqlju4frw==
X-Google-Smtp-Source: AA6agR5xMz1crSLnEY2JX1frHd4Sog5WgE7koMrc+outnsENL5YUmTaNsUhsxsMOhbw8cQJfIhmyWN+8fmeYkn95+IM=
X-Received: by 2002:a5d:6084:0:b0:228:67c1:e160 with SMTP id
 w4-20020a5d6084000000b0022867c1e160mr794726wrt.83.1662527133494; Tue, 06 Sep
 2022 22:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220905083619.672091-1-masahiroy@kernel.org>
In-Reply-To: <20220905083619.672091-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 6 Sep 2022 22:05:21 -0700
Message-ID: <CAKwvOdnFZJK+MjSgQpg8MZoMPOM+G8kfhNaH6sTaLU=eP7nK+g@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: move -Werror from KBUILD_CFLAGS to KBUILD_CPPFLAGS
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
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

On Mon, Sep 5, 2022 at 1:37 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> CONFIG_WERROR makes warnings into errors, but it only happens for *.c
> files because -Werror is added to KBUILD_CFLAGS.
>
> For example, you can put a #warning directive in any preprocessed
> source file:
>
>     #warning "blah blah ..."
>
> If it is placed in a *.c file, it emits a warning by default, and it
> is promoted to an error when CONFIG_WERROR is enabled:
>
>     error: #warning "blah blah ..." [-Werror=cpp]
>
> If it is placed in a *.S file, it is still a warning.
>
> Move it to KBUILD_CPPFLAGS, so it works in the same way for *.c,
> *.S, *.lds.S or whatever needs preprocessing.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for the patch. I see in lore you sent many more cleanups but
didn't cc me explicitly...I should probably subscribe to that mailing
list! I probably won't have time to review many patches until after
Linux Plumbers Conf next week.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index ebcb75442d7f..027d9163eff6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -788,7 +788,8 @@ stackp-flags-$(CONFIG_STACKPROTECTOR_STRONG)      := -fstack-protector-strong
>
>  KBUILD_CFLAGS += $(stackp-flags-y)
>
> -KBUILD_CFLAGS-$(CONFIG_WERROR) += -Werror
> +KBUILD_CPPFLAGS-$(CONFIG_WERROR) += -Werror
> +KBUILD_CPPFLAGS += $(KBUILD_CPPFLAGS-y)
>  KBUILD_CFLAGS-$(CONFIG_CC_NO_ARRAY_BOUNDS) += -Wno-array-bounds
>  KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
>
> --
> 2.34.1
>


-- 
Thanks,
~Nick Desaulniers
