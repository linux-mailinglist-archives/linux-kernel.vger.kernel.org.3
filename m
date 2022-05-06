Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A35B51D321
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 10:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389958AbiEFIRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 04:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390020AbiEFIRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 04:17:31 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCE2689A8
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 01:13:13 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id y21so7832647edo.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 01:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=48nMT+gnh1vkPS6WcET22AquP1bwix2Jf1ru/W7jPF0=;
        b=IbrYmItb1Lwf9ZtD0tkpri3RJ99v62ia17YxLpggBwo/VDMDe1Ih5cYt7l1XNud4Wt
         RLP7ykYKZ1toxZIj8GYyTDh5v4Y1YXumWCCqv4+blU/qCeqYrOSl6U0+YdllXrDZBWRk
         VoQm4xJTCGGR+pbuWS8Ql7SqkviUCoRy7B/MFqRZ7S3qCCRYYui1N5cd13Gl8lJ9JvHz
         3tBQEVPh1Adm0NplEjXWdn8LiuGyqpyjIJ/atYzZzorngDy1gyG4jgl1qZp4QkR9FVkY
         ae0j32HSF9IIpSv3S5OL8MAyV6A17UPBHK38D53THuUVNcHIfXAEpOQ35Wem0hgUnQGN
         PMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=48nMT+gnh1vkPS6WcET22AquP1bwix2Jf1ru/W7jPF0=;
        b=eEoCElGf/lVguHx6fYnzR3AR4iqYBqtvmI3M5qGKvLF8LqEEidwHwV1yYu2fXRDjxx
         tozyl30p6DszCxe5agF0tJkogWomz1xAeaAUz/6TTA9xoRc3bRBORf2SaY5OM1Onssx3
         sEf3qcHS55dTy6gGM+84Cj8C8I6RnnlOOPMIcexiTYeGaJFogB5auLdWc01hVF9yJyXA
         QIF5k7VqfkfU3zNuJTXFerle/5z1wiexCfGw9OEeUtCEGpjo5jhgtxJ9fTFOyZc5uSdD
         bcHQvMqWvwFeB41TPL6l265FhmzpHeJKJjUKR3qiox/Vjq/SAs82/pkRTPuhaEhRfg9Q
         qSlw==
X-Gm-Message-State: AOAM530HTirFQ6Sda2ISnrmACB2M02kHhnjqD6NKOvD67VoLwqdyRMPA
        +Pv1J6K0ktNj2YSBGz6j4QZeX1DcAWyK7esqoIo=
X-Google-Smtp-Source: ABdhPJxIFQMjjNdAGODnpdwMXhA+ZLqwYfEpmReeo1+QFMSEzYOfnbnjWCAwmWbcvLH9QkTWfefCdwcPh7x+UX7xDoM=
X-Received: by 2002:a05:6402:1a42:b0:424:20bb:3e37 with SMTP id
 bf2-20020a0564021a4200b0042420bb3e37mr2214361edb.29.1651824792251; Fri, 06
 May 2022 01:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220506073623.2679-1-puyou.lu@gmail.com>
In-Reply-To: <20220506073623.2679-1-puyou.lu@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 6 May 2022 10:12:36 +0200
Message-ID: <CAHp75Ve4ez0HKqXTqrtRYPv5T04CtDGafA3UoU1Wzt_DZOHbBA@mail.gmail.com>
Subject: Re: [PATCH v2] lib/string_helpers: fix not adding strarray to
 device's resource list.
To:     Puyou Lu <puyou.lu@gmail.com>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org
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

On Fri, May 6, 2022 at 9:36 AM Puyou Lu <puyou.lu@gmail.com> wrote:
>
> Add allocated strarray to device's resource list. This is a must to
> automatically release strarray when the device disappears.

LGTM,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Thanks!

> Fixes: acdb89b6c87a ("lib/string_helpers: Introduce managed variant of kasprintf_strarray()")
> Signed-off-by: Puyou Lu <puyou.lu@gmail.com>
>
> ---
>
> Change since v1:
> also set 'n' of strarray https://lore.kernel.org/lkml/20220506022845.26750-1-puyou.lu@gmail.com/
>
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
> +
>         return ptr->array;
>  }
>  EXPORT_SYMBOL_GPL(devm_kasprintf_strarray);
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
