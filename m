Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589975A849D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiHaRlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbiHaRlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:41:18 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAC7E0BB
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:40:37 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id c7so12563836wrp.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=n/oAIIbQC6X9/4TYjpXgoCLnqch074NpwWXcWhpGZUU=;
        b=kzWNO0R5mowae1zsB33fojPTZwHoiimNytdIdEM9pAl9vTa3Km02k8esak+mL45vSJ
         XHlpH5qoILPtWK/pDKEvlh4xe4S3bsXvLbxG8xZ34ERouN2lElUkWXkQQ0wZD1QdCEvE
         pYp2eFyBg0AModntqsO5EUP3Aoyc4RsDQngD4NVmVROQAEN4+Q6/feAv1WDh+z6PTH8Q
         W0I9equd8n5PcsPy2cdsjGxjBafA0r5/CGliM6dOBkSkSXJAiBytlaR1eTNhV1RGBJ9v
         bW7CANGbl7HCnIGKz483Z92xH1mfXxhkdEB4HHWLc59xZI2abJ4UQW+xDEnzDwlZ32jp
         ZW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=n/oAIIbQC6X9/4TYjpXgoCLnqch074NpwWXcWhpGZUU=;
        b=ZY8OxkV8lwXJQ77MPCALGO6400U+XTdyw2vxw/YayrSKI/wtpVYudT+CKXD4aRKwXL
         dCctNX75xQnms+aYRGeBtXrK0/ptWG2GmhpZl8c0S3ekaYnnBbblv9XxifdK2frnxaCC
         V0X0fHUz6YEaYaVCQ07zFMiVSXOHcPrtOHJHkfQJeGm4Gr9+sLgapnuUIh2djs0Fe+5h
         YT4rczNlQFPnSBpepkN+10QcujFLngB6SDTXkFnaXLF7Q4uniOCUkTRi7a3lebwZCfMK
         IVpK+Ul1bCd87bs6LvK7XgLcfd/F3IEAbiRi0VkwZqkG+QSf8wfB2a2ioU6cBo193goh
         /5ww==
X-Gm-Message-State: ACgBeo0+gNbukVub40MQ6j5lAuMjwQfL6/Hcb69OmHOYrkuetUQLVr4c
        GlHH7MK7/XF+FIhy9BAarK3uDyU37LugxS93xZNuVQ==
X-Google-Smtp-Source: AA6agR7jf/5wN9tWi2BmC7xA0UtJf55pCgzE1Qm3Wv4DAx6hUBuxcAAXc5Ctfg8gLto5EW/U5x+6kyyr2Z80D+5uwSI=
X-Received: by 2002:a05:6000:813:b0:226:da5a:84a9 with SMTP id
 bt19-20020a056000081300b00226da5a84a9mr9049383wrb.309.1661967636251; Wed, 31
 Aug 2022 10:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220826181035.859042-1-ndesaulniers@google.com> <20220826181035.859042-4-ndesaulniers@google.com>
In-Reply-To: <20220826181035.859042-4-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 31 Aug 2022 10:40:24 -0700
Message-ID: <CAKwvOdnOz_iH2x1a_CSBqPSbjbXcv7b3ojYa2TahWArAFjqj9A@mail.gmail.com>
Subject: Re: [PATCH 3/3] Makefile.debug: set -g unconditional on CONFIG_DEBUG_INFO_SPLIT
To:     Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev, x86@kernel.org,
        Dmitrii Bundin <dmitrii.bundin.a@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Alexey Alexandrov <aalexand@google.com>,
        Bill Wendling <morbo@google.com>,
        Greg Thelen <gthelen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>
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

On Fri, Aug 26, 2022 at 11:10 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Dmitrii, Fangrui, and Mashahiro note:
>
>   Before GCC 11 and Clang 12 -gsplit-dwarf implicitly uses -g2.
>
> Fix CONFIG_DEBUG_INFO_SPLIT for gcc-11+ & clang-12+ which now need -g
> specified in order for -gsplit-dwarf to work at all.

Looking at
commit 866ced950bcd ("kbuild: Support split debug info v4")
I'm curious whether -gsplit-dwarf needed to be mutually exclusive with
-g, possibly for older compilers? Andi, do you recall?
I have gcc-9 handy; that doesn't seem to be the case. I get the same
size binary with `-gsplit-dwarf` as I do with `-g -gsplit-dwarf`.  So
it does seem like mutual exclusion between the two is not necessary.

x86_64-gcc-5.5.0-nolibc-x86_64-linux.tar.gz from
https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/5.5.0/
seems to really need libisl.so.15...
$ cd /tmp
$ wget https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/5.5.0/x86_64-gcc-5.5.0-nolibc-x86_64-linux.tar.gz
$ echo "void foo(void) {}" > x.c
$ ./gcc-5.5.0-nolibc/x86_64-linux/bin/x86_64-linux-gcc-5.5.0
-gsplit-dwarf x.c -c
/tmp/gcc-5.5.0-nolibc/x86_64-linux/bin/../libexec/gcc/x86_64-linux/5.5.0/cc1:
error while loading shared libraries: libisl.so.15: cannot open shared
object file: No such file or directory
$ find /usr/lib -name libisl\*
/usr/lib/x86_64-linux-gnu/libisl.so.23.2.0
/usr/lib/x86_64-linux-gnu/libisl.so.23
/usr/lib/x86_64-linux-gnu/libisl.a
/usr/lib/x86_64-linux-gnu/libisl.so

>
> Link: https://lore.kernel.org/lkml/20220815013317.26121-1-dmitrii.bundin.a@gmail.com/
> Link: https://lore.kernel.org/lkml/CAK7LNARPAmsJD5XKAw7m_X2g7Fi-CAAsWDQiP7+ANBjkg7R7ng@mail.gmail.com/
> Link: https://reviews.llvm.org/D80391
> Reported-by: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
> Reported-by: Fangrui Song <maskray@google.com>
> Reported-by: Masahiro Yamada <masahiroy@kernel.org>
> Suggested-by: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  scripts/Makefile.debug | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/Makefile.debug b/scripts/Makefile.debug
> index a7a6da7f6e7d..0f9912f7bd4c 100644
> --- a/scripts/Makefile.debug
> +++ b/scripts/Makefile.debug
> @@ -1,10 +1,8 @@
> -DEBUG_CFLAGS   :=
> +DEBUG_CFLAGS   := -g
> +KBUILD_AFLAGS  += -g
>
>  ifdef CONFIG_DEBUG_INFO_SPLIT
>  DEBUG_CFLAGS   += -gsplit-dwarf
> -else
> -DEBUG_CFLAGS   += -g
> -KBUILD_AFLAGS  += -g
>  endif
>
>  ifdef CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
> --
> 2.37.2.672.g94769d06f0-goog
>


-- 
Thanks,
~Nick Desaulniers
