Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF565803AA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 19:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbiGYRw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 13:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiGYRw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 13:52:57 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CBF1EC6B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 10:52:55 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id y11so19074752lfs.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 10:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FreRpovf0mVIW2Zhb1lvjjWuatAZVEz7BtIiXLJK1wI=;
        b=sCqJneU/e+EImVUW0AgfhNVAzLxTz3jjWXmAgQWpV5hwZVrpflAC2CzroKrLuu30jC
         6Dm2/C+sdg2h/STEztOeeNNuiIp9gCS2ZrJCO7hCrVgCac/MV8i4BxFFrFYccCFAf4F1
         R5/BFt0beMKeW3hR3zbEZn3QKUpOpigSIsdXW2E0RZeh2FRmUB7ddJiJQ4BTRqShxXOM
         ZjDu97T3QoAG4DqtR7AQVbFYdokNc45w94e0WkgBiFYVu/Uk4zOibF01fXFZviUxbe9F
         Rz9iTDBpxMXQt5QvLklABzx4ed5mn/hCkiFQFg4WEQIiknvpPfbWpPP6Wg4Q9XhyygfZ
         qZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FreRpovf0mVIW2Zhb1lvjjWuatAZVEz7BtIiXLJK1wI=;
        b=7yzNKekLHrms4cFSmSxzaKIdgSO/Qm+OUKtTWGsmqdw5qyJd9m0jgqSOm4x5bhDCkT
         HIvGmvvylsP99sGpQplYXW7OdzVj0OEG211HArHqJ8AOmNYacexwzNvEvMHUCwI9yloz
         foA/t8YwBz2rHic0NGEWjYe/JAIG0/7oGyN+KNemcs2bQDHzX3wskXchBG08MfWmMAQ3
         ShvUe7l+NXr8+Kgm1H7nfdqyPbnHGEwz80Arp+zCdCUQOF9UrFV1LmnqmFVsG6Wvd9fK
         tmdXTgFmW8Odc8csyjgx66f2XqZFy4fV5KPC+698wF7hetzwxQfMVJFLBS77SMmVuBlo
         RjXg==
X-Gm-Message-State: AJIora9jrWqvoJof5uTj5qCXmkjMtitV+jteU8aL0e+Qc7beUSUHFVlE
        mKoYyCihIUHFOdZHGVz0mE7sjc451SUi6dk/qWIxZQ==
X-Google-Smtp-Source: AGRyM1vI4nBqg+nOIN1K6S/SLeIGDe2Bxh+Byy0/zOW8Qb1y2+dATjUCbmWBwx7zJqp+xU/9MPLu9ZTAvX99MFB0yek=
X-Received: by 2002:ac2:44af:0:b0:48a:9e9f:74e5 with SMTP id
 c15-20020ac244af000000b0048a9e9f74e5mr94845lfm.100.1658771573140; Mon, 25 Jul
 2022 10:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220725021902.625630-1-masahiroy@kernel.org> <20220725021902.625630-2-masahiroy@kernel.org>
In-Reply-To: <20220725021902.625630-2-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 25 Jul 2022 10:52:41 -0700
Message-ID: <CAKwvOdkWxZy-is5uxWEizgNM4UXB5E_=QSO3iEeVFdPFqv00EA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] riscv/purgatory: Omit use of bin2c
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Borislav Petkov <bp@suse.de>,
        Helge Deller <deller@gmx.de>,
        Li Zhengyu <lizhengyu3@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org
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

On Sun, Jul 24, 2022 at 7:22 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> The .incbin assembler directive is much faster than bin2c + $(CC).
>
> Do similar refactoring as in commit 4c0f032d4963 ("s390/purgatory:
> Omit use of bin2c").
>
> Please note the .quad directive matches to size_t in C (both 8 byte)
> because the purgatory is compiled only for the 64-bit kernel.
> (KEXEC_FILE depends on 64BIT).
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Seems fine.  Is the overall goal working towards removing scripts/bin2c?
Acked-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> Changes in v2:
>   - Fix a typo (kexec_purgatroy_end -> kexec_purgatory_end)
>
>  arch/riscv/Kconfig                     |  1 -
>  arch/riscv/purgatory/.gitignore        |  1 -
>  arch/riscv/purgatory/Makefile          |  8 +-------
>  arch/riscv/purgatory/kexec-purgatory.S | 14 ++++++++++++++
>  scripts/remove-stale-files             |  2 ++
>  5 files changed, 17 insertions(+), 9 deletions(-)
>  create mode 100644 arch/riscv/purgatory/kexec-purgatory.S
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 32ffef9f6e5b..218c2f12b3ef 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -447,7 +447,6 @@ config KEXEC_FILE
>
>  config ARCH_HAS_KEXEC_PURGATORY
>         def_bool KEXEC_FILE
> -       select BUILD_BIN2C
>         depends on CRYPTO=y
>         depends on CRYPTO_SHA256=y
>
> diff --git a/arch/riscv/purgatory/.gitignore b/arch/riscv/purgatory/.gitignore
> index 38d7d1bda4d7..6e4dfb024ad2 100644
> --- a/arch/riscv/purgatory/.gitignore
> +++ b/arch/riscv/purgatory/.gitignore
> @@ -1,4 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  purgatory.chk
>  purgatory.ro
> -kexec-purgatory.c
> diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
> index c2d14e2f345d..dd58e1d99397 100644
> --- a/arch/riscv/purgatory/Makefile
> +++ b/arch/riscv/purgatory/Makefile
> @@ -84,12 +84,6 @@ $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
>  $(obj)/purgatory.chk: $(obj)/purgatory.ro FORCE
>                 $(call if_changed,ld)
>
> -targets += kexec-purgatory.c
> -
> -quiet_cmd_bin2c = BIN2C   $@
> -      cmd_bin2c = $(objtree)/scripts/bin2c kexec_purgatory < $< > $@
> -
> -$(obj)/kexec-purgatory.c: $(obj)/purgatory.ro $(obj)/purgatory.chk FORCE
> -       $(call if_changed,bin2c)
> +$(obj)/kexec-purgatory.o: $(obj)/purgatory.ro $(obj)/purgatory.chk
>
>  obj-y += kexec-purgatory.o
> diff --git a/arch/riscv/purgatory/kexec-purgatory.S b/arch/riscv/purgatory/kexec-purgatory.S
> new file mode 100644
> index 000000000000..32c53581b8f2
> --- /dev/null
> +++ b/arch/riscv/purgatory/kexec-purgatory.S
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +       .section .rodata, "a"
> +
> +       .align  8
> +kexec_purgatory:
> +       .globl  kexec_purgatory
> +       .incbin "arch/riscv/purgatory/purgatory.ro"
> +.Lkexec_purgatory_end:
> +
> +       .align  8
> +kexec_purgatory_size:
> +       .globl  kexec_purgatory_size
> +       .quad   .Lkexec_purgatory_end - kexec_purgatory
> diff --git a/scripts/remove-stale-files b/scripts/remove-stale-files
> index 7adab4618035..d75a52199a38 100755
> --- a/scripts/remove-stale-files
> +++ b/scripts/remove-stale-files
> @@ -40,4 +40,6 @@ if [ -n "${building_out_of_srctree}" ]; then
>         done
>  fi
>
> +rm -f arch/riscv/purgatory/kexec-purgatory.c
> +
>  rm -f scripts/extract-cert
> --
> 2.34.1
>


-- 
Thanks,
~Nick Desaulniers
