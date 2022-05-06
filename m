Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4CA51D18D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 08:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354088AbiEFGrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 02:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239392AbiEFGro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 02:47:44 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB2366AC8
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 23:44:01 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l18so12614443ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 23:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JjbITbyCt88G21h1vrLTiEcy6QiMRWWUBf0UViKztG8=;
        b=klZ5mHj1PXrqItiwb+Wt09K7TE7oRdYYqmK5ol5BcNgsR/M/Q5ZHvMKB7yQZRpGPup
         /1zitMD6BLv+OahsLgPfaJT5RSEZMoP1Re6LLpjXfr+IX4xreKb2OkpwC7KAu0nOC0df
         O+yAyW91A/jVgcB+vdFYJoCSvw0jiRQ1ymiu7H0epvNpLq+TIIKh2BML8fl8j9sXmB9w
         L51pdXo+K4CGc8zLKCkZRlnd92F8Fhe8xP/AmyvDNmquzggeR2rwCPsV22ZAZDBjaS09
         MACHTzpB/MJi3nljoi/SB3dximnfBWYhdhRU2L549zZbTBPdFXNrE+B1/duBrvJzlvrI
         /9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JjbITbyCt88G21h1vrLTiEcy6QiMRWWUBf0UViKztG8=;
        b=f9Lv1IQUPrJWn/orBSGX9mXBvhPjxqSlSiaFTp0W/QoL/iXEa/v/1bRi/n3fqiIklD
         uIlIg9q+WzYVIv4kOb1qSmvZqsiKK0ap8a/vCS5d7vupELebVbYcDuWV2O5Q1jiOcX4N
         uHcZYXHM4aWgw4CS5pDtz8iW2GA7IBQhPfd6/quUoLf3By3FOsC6wtjPPoDCVqw9zBov
         KjNLNFVaUkRUKF3HXcXIxQ5pCgb56XJt59GKLUKCqhHPOQhqPysztBspnYU5v12zOZO+
         kxFqxIX7BS4+G/d5HsFxHqEVCmOuNRaU1a2CWtuhI68ypc54dLrBPxttvt6DdRv5zI2I
         sdRQ==
X-Gm-Message-State: AOAM533WEQvfEgKxYAOiAarx25uAnVZQuNMWUkMC+2Yoqut/4CfWpGL7
        u0fQHXYUE9v4xoLDARn2f2/LgNGVfzGsLQASQco=
X-Google-Smtp-Source: ABdhPJwrK9knP/ucLMTpkNf6FduxrWrJvdX2L8jIgO5yD5PFOWfYNLzWyysUAGsTqZ64pADyvjrxHlre+1LBdT5YuPE=
X-Received: by 2002:a17:907:628e:b0:6d9:c6fa:6168 with SMTP id
 nd14-20020a170907628e00b006d9c6fa6168mr1646407ejc.132.1651819440269; Thu, 05
 May 2022 23:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220506032333.28249-1-puyou.lu@gmail.com> <20220506044409.30066-1-puyou.lu@gmail.com>
In-Reply-To: <20220506044409.30066-1-puyou.lu@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 6 May 2022 08:43:24 +0200
Message-ID: <CAHp75VfJoiAW+rMcDawFdaSZrNhjjnFF9j94B=1mDKLSeMNYBw@mail.gmail.com>
Subject: Re: [PATCH] lib/string_helpers: add allocated strarray to device's
 resource list.
To:     Puyou Lu <puyou.lu@gmail.com>
Cc:     akpm@linux-foundation.org, andy@kernel.org, chris@chrisdown.name,
        keescook@chromium.org, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux@roeck-us.net, pmladek@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 6, 2022 at 6:44 AM Puyou Lu <puyou.lu@gmail.com> wrote:
>
> This is a must to automatically release strarray when the device
> disappears.

Thanks for your patch!

First of all, since this is a v2 of it, you need to update the subject
to reflect this and add a changelog after the cutter '--- ' line
below.
Second, because this is the fix, please add a Fixes tag.

> Signed-off-by: Puyou Lu <puyou.lu@gmail.com>
> ---
>  lib/string_helpers.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/lib/string_helpers.c b/lib/string_helpers.c
> index 4f877e9551d5..5ed3beb066e6 100644
> --- a/lib/string_helpers.c
> +++ b/lib/string_helpers.c
> @@ -757,6 +757,9 @@ char **devm_kasprintf_strarray(struct device *dev, const char *prefix, size_t n)
>                 return ERR_PTR(-ENOMEM);
>         }
>
> +       ptr->n = n;
> +       devres_add(dev, ptr);

The code seems correct, good catch!

>         return ptr->array;
>  }
>  EXPORT_SYMBOL_GPL(devm_kasprintf_strarray);
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
