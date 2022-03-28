Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62964EA1A8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345347AbiC1Ul4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345349AbiC1Uk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:40:56 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E47644C4;
        Mon, 28 Mar 2022 13:39:15 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z92so18314778ede.13;
        Mon, 28 Mar 2022 13:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xw6/eHXGYfyQo41MlHn2HdfwjJIHINXKEO94qSppq28=;
        b=b9iImZGKfs3WXC8l0oFuFZaIT4EL8lWv990T7tzJDZ/JCoZfmiHuaQdc0wBbjADKgP
         pz9RoVFnLZtDqu7juxQR8eaS+NrrHwSFtVfQnijQAPH7NQqVwEKLMFwF6KCJnha01cku
         ZjxUGFM7SRxzSdQ05IFVG9EOK7WDaJ/nAVrd++ogw+D7GI52yQ4rkQ7SdzBX+DjMEH+o
         A1nKxj05unPlW0bLqxImCIf4qHc+PnsNdSxmO/Vak6uZtNRINsHJxAVyoY8TDxEFTy/w
         NGcv1jpMb8yBJGbzyXpIApg/IrNqwllJ310kyJZd3kogLQT8ziLRofCJhNUjSmwSm2Jk
         pdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xw6/eHXGYfyQo41MlHn2HdfwjJIHINXKEO94qSppq28=;
        b=3usLX8XxP8xdqZ5gORVT2mdi/ItXvXnu6vIMbKuaaTIfOUr1zEfrGH59NKaZqs0zYe
         IiHFD+OTANmleKhohbZcPx3GyGzrTjR4qpTkMqms0ADP1q1QbYbhtrkpdAv6UsZXVZz7
         ncoPHZAaIYW0ynwcYgl+bAQzE95W4P/Mh08SkAMIoEIMzPrj6hJzjXcsEs8Mrx8Tzup1
         e/jsGSGVfYIHyrOLvVTy4igNdxE7/t509D4YYFQKlhEc57takHLBJKGbX2xeP5J6CDk/
         gNTzeZS6Lu1rWJZgMLrDltyGLIYtHiwLs059a8LYtYGSPvMhFtSmxSL500ihjG6QLUm4
         +qhQ==
X-Gm-Message-State: AOAM530Oss3uW0mQrhg7TAQwiJoeXLvaNjrqb6nolpEj63Ik0/SMeGvu
        mB3D9rdGOXmVqbZRWecbbbnZChTII/vTJGwNUpE=
X-Google-Smtp-Source: ABdhPJxNcNGSt0E34cJpbJ65P1lTtbFVtcXgaCXAMxqv38Y+bWSTAANcprjUbbcH+2VeLvdVtVd+xFb4arFR+965IIg=
X-Received: by 2002:a05:6402:27d1:b0:419:1b02:4a04 with SMTP id
 c17-20020a05640227d100b004191b024a04mr18437384ede.218.1648499953845; Mon, 28
 Mar 2022 13:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220207125933.81634-1-paul@crapouillou.net> <20220207125933.81634-3-paul@crapouillou.net>
In-Reply-To: <20220207125933.81634-3-paul@crapouillou.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 28 Mar 2022 23:38:38 +0300
Message-ID: <CAHp75VeE2_D39X3gWidPTd49v=bdkgnMeoSBh60enp2hKJ-KPw@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] iio: buffer-dma: Enable buffer write support
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linaro-mm-sig@lists.linaro.org,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
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

On Wed, Feb 9, 2022 at 9:10 AM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Adding write support to the buffer-dma code is easy - the write()
> function basically needs to do the exact same thing as the read()
> function: dequeue a block, read or write the data, enqueue the block
> when entirely processed.
>
> Therefore, the iio_buffer_dma_read() and the new iio_buffer_dma_write()
> now both call a function iio_buffer_dma_io(), which will perform this
> task.
>
> The .space_available() callback can return the exact same value as the
> .data_available() callback for input buffers, since in both cases we
> count the exact same thing (the number of bytes in each available
> block).
>
> Note that we preemptively reset block->bytes_used to the buffer's size
> in iio_dma_buffer_request_update(), as in the future the
> iio_dma_buffer_enqueue() function won't reset it.

...

> v2: - Fix block->state not being reset in
>       iio_dma_buffer_request_update() for output buffers.
>     - Only update block->bytes_used once and add a comment about why we
>       update it.
>     - Add a comment about why we're setting a different state for output
>       buffers in iio_dma_buffer_request_update()
>     - Remove useless cast to bool (!!) in iio_dma_buffer_io()

Usual place for changelog is after the cutter '--- ' line below...

> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
> ---

...somewhere here.

>  drivers/iio/buffer/industrialio-buffer-dma.c | 88 ++++++++++++++++----
>  include/linux/iio/buffer-dma.h               |  7 ++

...

> +static int iio_dma_buffer_io(struct iio_buffer *buffer,
> +                            size_t n, char __user *user_buffer, bool is_write)

I believe there is a room for size_t n on the previous line.

...

> +       if (is_write)

I would name it is_from_user.

> +               ret = copy_from_user(addr, user_buffer, n);
> +       else
> +               ret = copy_to_user(user_buffer, addr, n);

...

> +int iio_dma_buffer_write(struct iio_buffer *buffer, size_t n,
> +                        const char __user *user_buffer)
> +{
> +       return iio_dma_buffer_io(buffer, n, (__force char *)user_buffer, true);

Why do you drop address space markers?

> +}

-- 
With Best Regards,
Andy Shevchenko
