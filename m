Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD021478C93
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 14:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236749AbhLQNoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 08:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236709AbhLQNon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 08:44:43 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800B1C061574;
        Fri, 17 Dec 2021 05:44:43 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id w1so1624324ilh.9;
        Fri, 17 Dec 2021 05:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=/1U8rmm2v6IW4IrlYfu1WGU3nMyw7RqXx+g8a0tWtd8=;
        b=J7gTZ5TlrzQDpy3rrzs2OPkxDkRN8Dlke+E+3xJl+6SbHzTuzoDgXjjl0t2CJjrDLy
         pO0Sg4QrDFHAdMaHwr6c2Ve3txnkLqqhVgAfDndOYO4S3fct3uYmfBO2kL8CvOXgp67x
         O359f5MCFQwYMYZBDac4HTrVXnXLOQQTEa3leh4kGoD3/P45UxVEMF6N2h5hnLDvJrUO
         AOvTmuj557deI/P2K1dCNQmWRBNyhxb2vxs5OrPG7PfoUH4yE+2OPUQcE9ExMnykbu5/
         jizkXWMJaWSYEzL8KVWCwbNSeGoJLmo82qgOha5fGyVd3HWz9zovyZ51buC9vjHHy2Am
         2u+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=/1U8rmm2v6IW4IrlYfu1WGU3nMyw7RqXx+g8a0tWtd8=;
        b=2pxU3PDk8Hwwsb37YvMsVilPAKw+1fQ6j90mW9+6GaOIroUcL11uyhTiZjauxC+6za
         CXL5jgYftpyksJufrCY5f+4Ot3LsoDNjCa1iJOie04YuTAN0H6epd4rwSPcCaFbExTIs
         JsRwyECcZdnDKCYk73O4qJ8fQQ49QCISRZ/u2mqkztfat03e9uc4Sb1mb64y52envo97
         aEUHC8DpJXR1s9Q585GnylA/YeTRuJ/SF52LgaX1A9pFQS+kXWQa9mEVhYADbvvQBgwu
         WrF2OHbxBDCgD22dF2Ro02NM/614EOTxDP1+HtNpRj9p21pMgTTBeLsu9TMDUU/bh3GH
         58Yg==
X-Gm-Message-State: AOAM533/+koahT9RZvG3IFZAGUvvPd8wy1J9b4SdxEUcTD1567RSJW7t
        nUPx/8Wsqpr2LI7fQIPC8pBfux4+ZlSYupGTEPA=
X-Google-Smtp-Source: ABdhPJyekkbwWcJQs6XjMX15028dFAptq/1f6BUnjcBFltMAWPJUtvD9jqGfG3HcakoEEBti8xAUenGk38bfuQzMQuc=
X-Received: by 2002:a05:6e02:180d:: with SMTP id a13mr1518285ilv.1.1639748682866;
 Fri, 17 Dec 2021 05:44:42 -0800 (PST)
MIME-Version: 1.0
References: <20211124153105.155739-1-alex_y_xu@yahoo.ca> <20211124153105.155739-2-alex_y_xu@yahoo.ca>
 <CA+icZUUZwGG-mJg26DOmadZksm4fMCE5QUmnX4ZghWxXzAy9HQ@mail.gmail.com>
In-Reply-To: <CA+icZUUZwGG-mJg26DOmadZksm4fMCE5QUmnX4ZghWxXzAy9HQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 17 Dec 2021 14:44:06 +0100
Message-ID: <CA+icZUXLrENSgHJHy1Huy-tX-STpEQXyjQGO_fmdnhq7oMKhzA@mail.gmail.com>
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

On Fri, Dec 17, 2021 at 9:51 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Wed, Nov 24, 2021 at 4:30 PM Alex Xu (Hello71) <alex_y_xu@yahoo.ca> wrote:
> >
> > Otherwise, it allocates 2 GB of memory at once. Even though the majority
> > of this memory is never touched, the default heuristic overcommit
> > refuses this request if less than 2 GB of RAM+swap is currently
> > available. This results in "zstd: error 11 : Allocation error : not
> > enough memory" and the kernel failing to build.
> >
> > When the size is specified, zstd will reduce the memory request
> > appropriately. For typical kernel sizes of ~32 MB, the largest mmap
> > request will be reduced to 512 MB, which will succeed on all but the
> > smallest devices.
> >
> > For inputs around this size, --stream-size --no-content-size may
> > slightly decrease the compressed size, or slightly increase it:
> > https://github.com/facebook/zstd/issues/2848.
> >
>
> Hi Alex and Nick T.,
>
> some questions:
>
> Can I apply this patch as a single patch - without patch 1/2?
>
> Is there an impact also on the kernel's ZRAM/ZSWAP support plus using
> ZSTD as (de)comp-algo?
>
> Here I have:
>
> $ grep -i zstd /boot/config-5.15.7-1-amd64-clang13-lto | egrep -i 'zram|zswap'
> CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD=y
> CONFIG_ZSWAP_COMPRESSOR_DEFAULT="zstd"
> CONFIG_ZRAM_DEF_COMP_ZSTD=y
> CONFIG_ZRAM_DEF_COMP="zstd"
>

$ egrep 'stream-size' build-log_5.15.9-1-amd64-clang13-lto.txt
49360:  { cat arch/x86/boot/compressed/vmlinux.bin
arch/x86/boot/compressed/vmlinux.relocs | zstd --stream-size=53340760
--no-content-size -22 --ultra; printf \130\352
\055\003; } > arch/x86/boot/compressed/vmlinux.bin.zst

Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

- Sedat -

> Thanks.
>
> Regards,
> - Sedat -
>
> > Signed-off-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
> > ---
> >  scripts/Makefile.lib | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index ca901814986a..c98a82ca38e6 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
> > @@ -466,12 +466,20 @@ quiet_cmd_xzmisc = XZMISC  $@
> >  # single pass, so zstd doesn't need to allocate a window buffer. When streaming
> >  # decompression is used, like initramfs decompression, zstd22 should likely not
> >  # be used because it would require zstd to allocate a 128 MB buffer.
> > +#
> > +# --stream-size to reduce zstd memory usage (otherwise zstd -22 --ultra
> > +# allocates, but does not use, 2 GB) and potentially improve compression.
> > +#
> > +# --no-content-size to save three bytes which we do not use (we use size_append).
> > +
> > +# zstd --stream-size is only supported since 1.4.4
> > +zstd_stream_size = $(shell $(ZSTD) -1c --stream-size=0 --no-content-size </dev/null >/dev/null 2>&1 && printf '%s' '--stream-size=$(total_size) --no-content-size')
> >
> >  quiet_cmd_zstd = ZSTD    $@
> > -      cmd_zstd = { cat $(real-prereqs) | $(ZSTD) -19; $(size_append); } > $@
> > +      cmd_zstd = { cat $(real-prereqs) | $(ZSTD) $(zstd_stream_size) -19; $(size_append); } > $@
> >
> >  quiet_cmd_zstd22 = ZSTD22  $@
> > -      cmd_zstd22 = { cat $(real-prereqs) | $(ZSTD) -22 --ultra; $(size_append); } > $@
> > +      cmd_zstd22 = { cat $(real-prereqs) | $(ZSTD) $(zstd_stream_size) -22 --ultra; $(size_append); } > $@
> >
> >  # ASM offsets
> >  # ---------------------------------------------------------------------------
> > --
> > 2.34.0
> >
