Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA3A49BDAB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 22:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbiAYVFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 16:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbiAYVFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 16:05:11 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D83C061744
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 13:05:10 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id b14so11877456ljb.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 13:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XLr11RmA2AsEsAGIvu6LFWVYm3NHYmVWxw0+ls1/TdE=;
        b=QUWfHk9WV1KTbszaLi9egxfOjV/uD8tv1t5VVCEh2nJ9qr2z82kowz5Lle5w6tg/Jl
         HvMRq295ASar4VSYHNK8BgQsd8dloA/t8ZxhlywU2ZVE17bIVS5y8iqzOZNd0hBzQjvb
         Eh1MGUZTyU6zjUyLjqRpfGNyCn/LGfOU3FKhvxcU0Ndc21xuxOherCoB7bx1ZCYerOl4
         JxVBYgBK8RSmkJvUhzpS7EDkpQfHA1rpYuIcnwbjqwTeXfm6xOmCnErqfmEMPuDsDDEV
         DJSMVGAHmQmnin3P7tsWzYEqtuQwqzJQz+Fag/3VGkGGL9h1sj9zpmjMjh7ACeHO9Du3
         VMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XLr11RmA2AsEsAGIvu6LFWVYm3NHYmVWxw0+ls1/TdE=;
        b=MKC6BjjdgVeqz9767bMt8CEwpKr9cKaiJTQ5l1UIUMcUJt3iEAT9NOVEtEom9vKD/h
         5ESUU/3Zbkjk/YpQNrxaXSSbHLFZ2GgPquWR2WD6x8wMLBmZAkVgN7GJW2gFGdIvSJtT
         QL64nk9s03qSCfHI64RLMzsI1HCGVuMEC29a3dO7ybK1192yGMZKWc9SlzA8GQ3QZ5v+
         IWg0CTYo7alLd2ARr6uhikC8PXg+FR51fDJsBhAwJkKht0Z4rVMZo4unTIieq29amH+f
         ewSYSRoCiyaZB/Y7TuGBaDAn3MRdfpinKc++RCP29HtXK3ZdR6nUSyY4lQ60vgs88Fbf
         05lg==
X-Gm-Message-State: AOAM532qdQUGSv9MroTPLFNgdwSLGqIdViXJZSxLYy9tPnAT2D39KYB6
        IU5S5KVc2rdyry4ErS1zCoPJikQy6Mgblh0dMHlVSA==
X-Google-Smtp-Source: ABdhPJwmZJaSrZtIXa0BY54/Kae4qB25rrrEKRjYzyw+6Bb7/FlwJZvmGT/mxCtEy/L7nnIdDjcq6FSmPXMJgkp7WaE=
X-Received: by 2002:a2e:9654:: with SMTP id z20mr16081823ljh.526.1643144708634;
 Tue, 25 Jan 2022 13:05:08 -0800 (PST)
MIME-Version: 1.0
References: <20220125064027.873131-1-masahiroy@kernel.org>
In-Reply-To: <20220125064027.873131-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 25 Jan 2022 13:04:56 -0800
Message-ID: <CAKwvOdm=-x1EP_xu2V_OZNdPid=gacVzCTx+=uSYqzCv+1Rbfw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: unify cmd_copy and cmd_shipped
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Michal Simek <monstr@monstr.eu>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 10:41 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> cmd_copy and cmd_shipped have similar functionality. The difference is
> that cmd_copy uses 'cp' while cmd_shipped 'cat'.
>
> Unify them into cmd_copy because this macro name is more intuitive.
>
> Going forward, cmd_copy will use 'cat' to avoid the permission issue.
> I also thought of 'cp --no-preserve=mode' but this option is not
> mentioned in the POSIX spec [1], so I am keeping the 'cat' command.
>
> [1]: https://pubs.opengroup.org/onlinepubs/009695299/utilities/cp.html
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/microblaze/boot/Makefile     |  2 +-
>  arch/microblaze/boot/dts/Makefile |  2 +-
>  fs/unicode/Makefile               |  2 +-
>  scripts/Makefile.lib              | 12 ++++--------
>  usr/Makefile                      |  4 ++--
>  5 files changed, 9 insertions(+), 13 deletions(-)
>
> diff --git a/arch/microblaze/boot/Makefile b/arch/microblaze/boot/Makefile
> index cff570a71946..2b42c370d574 100644
> --- a/arch/microblaze/boot/Makefile
> +++ b/arch/microblaze/boot/Makefile
> @@ -29,7 +29,7 @@ $(obj)/simpleImage.$(DTB).ub: $(obj)/simpleImage.$(DTB) FORCE
>         $(call if_changed,uimage)
>
>  $(obj)/simpleImage.$(DTB).unstrip: vmlinux FORCE
> -       $(call if_changed,shipped)
> +       $(call if_changed,copy)
>
>  $(obj)/simpleImage.$(DTB).strip: vmlinux FORCE
>         $(call if_changed,strip)
> diff --git a/arch/microblaze/boot/dts/Makefile b/arch/microblaze/boot/dts/Makefile
> index ef00dd30d19a..b84e2cbb20ee 100644
> --- a/arch/microblaze/boot/dts/Makefile
> +++ b/arch/microblaze/boot/dts/Makefile
> @@ -12,7 +12,7 @@ $(obj)/linked_dtb.o: $(obj)/system.dtb
>  # Generate system.dtb from $(DTB).dtb
>  ifneq ($(DTB),system)
>  $(obj)/system.dtb: $(obj)/$(DTB).dtb
> -       $(call if_changed,shipped)
> +       $(call if_changed,copy)
>  endif
>  endif
>
> diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
> index 2f9d9188852b..74ae80fc3a36 100644
> --- a/fs/unicode/Makefile
> +++ b/fs/unicode/Makefile
> @@ -31,7 +31,7 @@ $(obj)/utf8data.c: $(obj)/mkutf8data $(filter %.txt, $(cmd_utf8data)) FORCE
>  else
>
>  $(obj)/utf8data.c: $(src)/utf8data.c_shipped FORCE

do we want to retitle the _shipped suffix for this file to _copy now, too?
fs/unicode/Makefile:11
fs/unicode/Makefile:33
fs/unicode/Makefile:34

Either way
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> -       $(call if_changed,shipped)
> +       $(call if_changed,copy)
>
>  endif
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 79be57fdd32a..40735a3adb54 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -246,20 +246,16 @@ $(foreach m, $(notdir $1), \
>         $(addprefix $(obj)/, $(foreach s, $3, $($(m:%$(strip $2)=%$(s)))))))
>  endef
>
> -quiet_cmd_copy = COPY    $@
> -      cmd_copy = cp $< $@
> -
> -# Shipped files
> +# Copy a file
>  # ===========================================================================
>  # 'cp' preserves permissions. If you use it to copy a file in read-only srctree,
>  # the copy would be read-only as well, leading to an error when executing the
>  # rule next time. Use 'cat' instead in order to generate a writable file.
> -
> -quiet_cmd_shipped = SHIPPED $@
> -cmd_shipped = cat $< > $@
> +quiet_cmd_copy = COPY    $@
> +      cmd_copy = cat $< > $@
>
>  $(obj)/%: $(src)/%_shipped
> -       $(call cmd,shipped)
> +       $(call cmd,copy)
>
>  # Commands useful for building a boot image
>  # ===========================================================================
> diff --git a/usr/Makefile b/usr/Makefile
> index cc0d2824e100..59d9e8b07a01 100644
> --- a/usr/Makefile
> +++ b/usr/Makefile
> @@ -3,7 +3,7 @@
>  # kbuild file for usr/ - including initramfs image
>  #
>
> -compress-y                                     := shipped
> +compress-y                                     := copy
>  compress-$(CONFIG_INITRAMFS_COMPRESSION_GZIP)  := gzip
>  compress-$(CONFIG_INITRAMFS_COMPRESSION_BZIP2) := bzip2
>  compress-$(CONFIG_INITRAMFS_COMPRESSION_LZMA)  := lzma
> @@ -37,7 +37,7 @@ endif
>  # .cpio.*, use it directly as an initramfs, and avoid double compression.
>  ifeq ($(words $(subst .cpio.,$(space),$(ramfs-input))),2)
>  cpio-data := $(ramfs-input)
> -compress-y := shipped
> +compress-y := copy
>  endif
>
>  endif
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
