Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF04850CBEA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 17:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbiDWPrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 11:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbiDWPrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 11:47:15 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15172BB0B
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 08:44:16 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id t25so19151794lfg.7
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 08:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hfKZvtI/V1RB7ImohZ4GyUEx6ziFwIp7DfRzHaG4QmM=;
        b=DiHDhYVtJ6mN9p21nI9d2hTsPdoU6rSCAw8cBNBF+4qy/YtbI335KdJcJCZqFlSXvO
         jpOu2UQb1C+gtw8xsQT4X5HjpUTV0daTppKW8tMnTT+bniLkpDWxZl91QZPp9JuzkiTI
         srMqOLLZ1kjp3tS8BKacxt7dETeCBH4scRBOomvH2IFAoVTKsVc8lgxop+Z7Vykru/jv
         uMFR2t2zoJ8/f6k3KE/welgT/qrgmpkRU80XPg92Qvr0D4shOZ3mOkq+D0pgDDb8A9XS
         HnwuUewjbsmG6Lqfo7uugsorPE1q8nSrQ45YkSwxs45giZvXsEJH2lGvl2ddUwzbqpg0
         NbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hfKZvtI/V1RB7ImohZ4GyUEx6ziFwIp7DfRzHaG4QmM=;
        b=I11rXExvDf/a4mR4iw4tiseIiZGRss0OdZXrI2OSd0PAWK16RefVGFeGNoeDDFiVb7
         ydsMBmc8mxMDM7cdrloLxQV98uGly0BK3KEeAWjbQfeDN2rEmcanN7d/yVAxzsq7HTca
         oNtiVVf9y3EKPdJphMMKT7wJCr61wgZTgbcjl5unKfA7ibm6WzMq5/VjiueXXmwnb6+/
         fU1KGZ7Hs4i5E+StKMYJnDcxRaAKV4NwKaWIKyuhS5Ki2RGg/rqEQEBXFmGnufo3z+3z
         sqUK4UTaW23M2Xfjt8/3i6hDKrD6v1D1z8nXCXwaodkcpldL2UNGcI5HrUVs1WeymAOS
         zHSw==
X-Gm-Message-State: AOAM532ltUUuH6tyzktM+oX1x+n7Njswi4LRohJ0HNrXQPulWZtZSn1N
        Oj8C/YQAOiOGO8GylypDqUhFfuhUgE4EaRhSBricfg==
X-Google-Smtp-Source: ABdhPJy/6uEu30VxnahyAvRcr5w0UpMdLC3qntcN+PT5EYI7AtF/tDd20hIccAr0Dirl9Z90Nq17jOv10nNc7qxtU6M=
X-Received: by 2002:a05:6512:1293:b0:471:fca1:e60 with SMTP id
 u19-20020a056512129300b00471fca10e60mr759404lfs.668.1650728654765; Sat, 23
 Apr 2022 08:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220423102421.16869-1-fmdefrancesco@gmail.com> <20220423102421.16869-4-fmdefrancesco@gmail.com>
In-Reply-To: <20220423102421.16869-4-fmdefrancesco@gmail.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Sat, 23 Apr 2022 08:44:03 -0700
Message-ID: <CAHRSSExiZMX-q_miUBOMOKrxPrvdXO2J3Wtchsn=0Etp7mvuLw@mail.gmail.com>
Subject: Re: [PATCH 3/3] binder: Use kmap_local_page() in binder_alloc_get_page()
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org
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

On Sat, Apr 23, 2022 at 3:24 AM Fabio M. De Francesco
<fmdefrancesco@gmail.com> wrote:
>
> The use of kmap_atomic() is being deprecated in favor of kmap_local_page()
> where it is feasible. Each call of kmap_atomic() in the kernel creates
> a non-preemptible section and disable pagefaults. This could be a source
> of unwanted latency, so it should be only used if it is absolutely
> required, otherwise kmap_local_page() should be preferred.
>
> With kmap_local_page(), the mapping is per thread, CPU local and not
> globally visible. Furthermore, the mapping can be acquired from any context
> (including interrupts).
>
> Therefore, use kmap_local_page() / kunmap_local() in place of
> kmap_atomic() / kunmap_atomic().
>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binder_alloc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index 0875c463c002..058595cc7ff0 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -1250,17 +1250,17 @@ static int binder_alloc_do_buffer_copy(struct binder_alloc *alloc,
>                 page = binder_alloc_get_page(alloc, buffer,
>                                              buffer_offset, &pgoff);
>                 size = min_t(size_t, bytes, PAGE_SIZE - pgoff);
> -               base_ptr = kmap_atomic(page);
> +               base_ptr = kmap_local_page(page);
>                 tmpptr = base_ptr + pgoff;
>                 if (to_buffer)
>                         memcpy(tmpptr, ptr, size);
>                 else
>                         memcpy(ptr, tmpptr, size);
>                 /*
> -                * kunmap_atomic() takes care of flushing the cache
> +                * kunmap_local() takes care of flushing the cache
>                  * if this device has VIVT cache arch
>                  */
> -               kunmap_atomic(base_ptr);
> +               kunmap_local(base_ptr);
>                 bytes -= size;
>                 pgoff = 0;
>                 ptr = ptr + size;
> --
> 2.34.1
>
