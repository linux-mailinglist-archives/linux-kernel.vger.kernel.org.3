Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0049A468DC1
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 23:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240061AbhLEW5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 17:57:02 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:29230 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbhLEW5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 17:57:01 -0500
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 1B5MrK2f025862;
        Mon, 6 Dec 2021 07:53:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 1B5MrK2f025862
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1638744801;
        bh=02y8Hmq7k4uWGAUBXxegYbr6n1JwV2k+j9cXSqS837g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GxreuHn4bYs0iL/J1LTufSwbvQcC1NCB7TzmCUxf8a4lSnG631qU8obeQwwxwiwG6
         7RTO1xszqcbcKPCMPgHg6NsWFUjvf0BvD3/2uLqSYIz+5MSHS7yDl8kO65mK5dWkcU
         aoyRvz/AiqvxNS9RWzcs1En72Ph7SHLtZMgaSNSCXvO6i2GerLKinmT0LzcP3XhRPN
         DraX3+4baU88Akfy6P5kTqP1tDdrdAkneDVZfD2O0hx+wOZu9yk6EYo7SaYAf5dM1X
         7jif5Lhjt7+UiNifeGplQGZOch9P3B4hhH/Zg2Xi0FTjxOnMcv/+kWnMhDVXFTm1sd
         0H6WaEXwfsW4A==
X-Nifty-SrcIP: [209.85.214.181]
Received: by mail-pl1-f181.google.com with SMTP id z6so5882105plk.6;
        Sun, 05 Dec 2021 14:53:20 -0800 (PST)
X-Gm-Message-State: AOAM533gCpmGxAF7D9Y2FQHOI08V4RfdV2MKycU3Jk6yjE/mcGiGZqz6
        0OD8Hil8wtHT1Sr7clpW4MGdKlQHizv4h2uEvq8=
X-Google-Smtp-Source: ABdhPJxxd7SYLDUb3KwfD+jjXQPAqAkN8dUiek9XQ87bpYUK5CNmtdu6FkRtHWyC1ZnRg2okpV1cxrBHSROqtSKN1aE=
X-Received: by 2002:a17:90b:1d0e:: with SMTP id on14mr32470530pjb.119.1638744800126;
 Sun, 05 Dec 2021 14:53:20 -0800 (PST)
MIME-Version: 1.0
References: <20211124153105.155739-1-alex_y_xu@yahoo.ca> <20211124153105.155739-2-alex_y_xu@yahoo.ca>
In-Reply-To: <20211124153105.155739-2-alex_y_xu@yahoo.ca>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 6 Dec 2021 07:52:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNASO_EmCp2zR_sBq_YNiw83Px8pKhcW78HKv1My7eKB+2w@mail.gmail.com>
Message-ID: <CAK7LNASO_EmCp2zR_sBq_YNiw83Px8pKhcW78HKv1My7eKB+2w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kbuild: pass --stream-size --no-content-size to zstd
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc:     Michael Forney <forney@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Terrell <terrelln@fb.com>, Ingo Molnar <mingo@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 12:30 AM Alex Xu (Hello71) <alex_y_xu@yahoo.ca> wrote:
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
> Signed-off-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>




The reason why we need this workaround is just because we do
"cat and compress".  zstd must allocate a huge memory beforehand
since it cannot predict how long the stream it will receive.

If zstd is given with a file name, it can fstat it to know its file size
and allocate the minimal amount of memory.


This is my test.
I used 'ulimit' to set the upper limit of the memory the zstd can use.


[test steps]

  # Create a 1kB file
  $ truncate --size=1k dummy

  # Set the memory size limit to 10MB
  $ ulimit -S -v 10240

  # Pass the file as a argument; success
  $ zstd -19 -o dummy.zst dummy
  dummy                :  2.15%   (  1024 =>     22 bytes, dummy.zst)

  # cat and zstd; fail
  $ cat dummy | zstd -19 > dummy.zst
  zstd: error 11 : Allocation error : not enough memory

  # cat and zstd --stream-size; success
  $ cat dummy | zstd -19 --stream-size=1024 > dummy.zst




scripts/Makefile.modinst was written in such a way
that zstd can know the file size by itself.

      cmd_zstd = $(ZSTD) -T0 --rm -f -q $<


We cannot rewrite scripts/Makefile.lib in that way because
arch/x86/boot/compress/Makefile concatenates two files before
compression. And this is the only use-case of this feature.

So, I am seriously considering to revert this commit:

commit d3dd3b5a29bb9582957451531fed461628dfc834
Author: H. Peter Anvin <hpa@zytor.com>
Date:   Tue May 5 21:17:15 2009 -0700

    kbuild: allow compressors (gzip, bzip2, lzma) to take multiple inputs




With that commit reverted, zstd will take a single input file,
and we can do "zstd -o <output> <input>".


So, I will take some time to investigate that approach.




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


-- 
Best Regards
Masahiro Yamada
