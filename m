Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B380A478683
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 09:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbhLQIwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 03:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbhLQIwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 03:52:14 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89B4C061746;
        Fri, 17 Dec 2021 00:52:13 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id m9so2023898iop.0;
        Fri, 17 Dec 2021 00:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=6H38uGu9oxzNmbHpInukzrA1bB8JViq3OxCgrYvQ+q8=;
        b=c5mUaFxuA3v3wQSuX/Y9Vj6wug2seSdy8IrJ/XtUCevIu7fN1npr+1EmOxqVxVkmjO
         YwC4b8Zk2LPD5OXLcBx9+Cy/TouT/SJXr1nCc5hrPdXoXo7u+EV2/7+f6L0sBONIuP3j
         bbWd7uBzIqsXFuABnyu18H54j1Ml45nqpf8wizllo+WORJJzRJ9hD6E3wIzdr6/6Faxe
         0NJqccOGpVXQMw5rkvHG+TtSK81w5JyPu8KgxD90JG8gpYmOE1EgVwmDQm0dFVjspSmi
         dXIo4Pm6sSo7+PCuMV5d9h/R/ANh0TuNDovLFonS799bMBCtcIT2zmZERXG98uByl7CS
         wwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=6H38uGu9oxzNmbHpInukzrA1bB8JViq3OxCgrYvQ+q8=;
        b=6nQ1KPRFCOjT2dfzl7/yFtbvCzAdc6adgiDqXTHh6f5iz3U9tODWdJikpmVvravGLZ
         BOLxMM8KGCSlfJ1gA0dolI9+IBW/JjT4vpE374GgUlwToXR3iSkJAVN/n+bOKsk0dUUl
         BP0yE008HXjwkx4Uv9I0CZVEQrYcYstD9vu6LvzaGTLymgpQbUMZ+oBvGJSGhNp2HvFj
         pT7ftitSWRz5913reUkyunMqb44UDBo4ia7HKvEKOHgLxH85MzC7iOpa1/UTMKarzAdL
         Wi7/M21+BHtRU3WN0udpCZq3ApnfjHsZdY6m6IDEIKZk0MIweFN2/yptZsPs7mPdeiGf
         ejBQ==
X-Gm-Message-State: AOAM532d03iXIuzxHSycmEuSCwT/mZ48y2xRuri060vzAgnrVZdKMz0f
        GukbE7VPHOU9+pOsTZeyazSEa6Zr5I8guqqZ73A=
X-Google-Smtp-Source: ABdhPJzD3xzZ28BUDmkVh4LKRUS0V2gfVPmeLFXT+fv/Dtx2Up7oF4eysOQeKXy+7O/0A6+jw8B9D8RLxiGpdmszHJc=
X-Received: by 2002:a05:6638:1346:: with SMTP id u6mr1184173jad.126.1639731133009;
 Fri, 17 Dec 2021 00:52:13 -0800 (PST)
MIME-Version: 1.0
References: <20211124153105.155739-1-alex_y_xu@yahoo.ca> <20211124153105.155739-2-alex_y_xu@yahoo.ca>
In-Reply-To: <20211124153105.155739-2-alex_y_xu@yahoo.ca>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 17 Dec 2021 09:51:36 +0100
Message-ID: <CA+icZUUZwGG-mJg26DOmadZksm4fMCE5QUmnX4ZghWxXzAy9HQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kbuild: pass --stream-size --no-content-size to zstd
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        Nick Terrell <terrelln@fb.com>
Cc:     Michael Forney <forney@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 4:30 PM Alex Xu (Hello71) <alex_y_xu@yahoo.ca> wrote:
>
> Otherwise, it allocates 2 GB of memory at once. Even though the majority
> of this memory is never touched, the default heuristic overcommit
> refuses this request if less than 2 GB of RAM+swap is currently
> available. This results in "zstd: error 11 : Allocation error : not
> enough memory" and the kernel failing to build.
>
> When the size is specified, zstd will reduce the memory request
> appropriately. For typical kernel sizes of ~32 MB, the largest mmap
> request will be reduced to 512 MB, which will succeed on all but the
> smallest devices.
>
> For inputs around this size, --stream-size --no-content-size may
> slightly decrease the compressed size, or slightly increase it:
> https://github.com/facebook/zstd/issues/2848.
>

Hi Alex and Nick T.,

some questions:

Can I apply this patch as a single patch - without patch 1/2?

Is there an impact also on the kernel's ZRAM/ZSWAP support plus using
ZSTD as (de)comp-algo?

Here I have:

$ grep -i zstd /boot/config-5.15.7-1-amd64-clang13-lto | egrep -i 'zram|zswap'
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD=y
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="zstd"
CONFIG_ZRAM_DEF_COMP_ZSTD=y
CONFIG_ZRAM_DEF_COMP="zstd"

Thanks.

Regards,
- Sedat -

> Signed-off-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
> ---
>  scripts/Makefile.lib | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index ca901814986a..c98a82ca38e6 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -466,12 +466,20 @@ quiet_cmd_xzmisc = XZMISC  $@
>  # single pass, so zstd doesn't need to allocate a window buffer. When streaming
>  # decompression is used, like initramfs decompression, zstd22 should likely not
>  # be used because it would require zstd to allocate a 128 MB buffer.
> +#
> +# --stream-size to reduce zstd memory usage (otherwise zstd -22 --ultra
> +# allocates, but does not use, 2 GB) and potentially improve compression.
> +#
> +# --no-content-size to save three bytes which we do not use (we use size_append).
> +
> +# zstd --stream-size is only supported since 1.4.4
> +zstd_stream_size = $(shell $(ZSTD) -1c --stream-size=0 --no-content-size </dev/null >/dev/null 2>&1 && printf '%s' '--stream-size=$(total_size) --no-content-size')
>
>  quiet_cmd_zstd = ZSTD    $@
> -      cmd_zstd = { cat $(real-prereqs) | $(ZSTD) -19; $(size_append); } > $@
> +      cmd_zstd = { cat $(real-prereqs) | $(ZSTD) $(zstd_stream_size) -19; $(size_append); } > $@
>
>  quiet_cmd_zstd22 = ZSTD22  $@
> -      cmd_zstd22 = { cat $(real-prereqs) | $(ZSTD) -22 --ultra; $(size_append); } > $@
> +      cmd_zstd22 = { cat $(real-prereqs) | $(ZSTD) $(zstd_stream_size) -22 --ultra; $(size_append); } > $@
>
>  # ASM offsets
>  # ---------------------------------------------------------------------------
> --
> 2.34.0
>
