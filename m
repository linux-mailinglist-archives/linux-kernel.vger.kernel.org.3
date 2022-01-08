Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F094882CF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 10:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbiAHJ2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 04:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiAHJ2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 04:28:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBD7C061574;
        Sat,  8 Jan 2022 01:28:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C669AB80761;
        Sat,  8 Jan 2022 09:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B30FC36AF3;
        Sat,  8 Jan 2022 09:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641634115;
        bh=y4ep/F5PBEWZUrYeJuA0/XjOUSWGAFc4NcKBSn7/XHA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N69OittcDHFsKRVNTdEd4hgh4lOrW37sEYnQxnPKlWMdYJbuqH1hABOLImzSXp85w
         WfjVJn+nZgKH0rHlLggoHcuwCpZqBcSIn15vVQwgyC4z3ih8kzsN3xUHChBVRrFa5b
         zWoT5buC9prSdeu0ifvSBsLhXtFsX2nAaSdlgM6iDPGv4rtJ71JCxAgNv9JxgGSfCT
         64OOQTIZPxzaQQGt+B+4tQJlcXs7LMnQWxHFfGb2YoOwxSKV9UBvdHJvMWHIhZ2oC+
         3e69Klikw81LIHkHrQJA+auXL1ywytPzPjl3xaziDP+ZVq09qUihULL6b7rnheHkGr
         Wr+hmDMyZhGDA==
Received: by mail-wr1-f51.google.com with SMTP id w20so15816447wra.9;
        Sat, 08 Jan 2022 01:28:35 -0800 (PST)
X-Gm-Message-State: AOAM53356z8gG4FrqqPXUP8Txj2Iv5b2Q3lmA1t8JNG14f6NTywRjtLE
        ieIL0w6IKrE8CHRDJKTHX/xqGzOz7CNb0RIsYR8=
X-Google-Smtp-Source: ABdhPJyukHr4M5a6n/vBvBkRTI+74AD5T6HuJpUY4GGoeQfjhVfDWc17TiBkifGIHuX1VaYsc3hUH5MF6ZqGBR1YiuE=
X-Received: by 2002:adf:fe08:: with SMTP id n8mr1294483wrr.417.1641634113765;
 Sat, 08 Jan 2022 01:28:33 -0800 (PST)
MIME-Version: 1.0
References: <20220105174953.2433019-1-keescook@chromium.org>
In-Reply-To: <20220105174953.2433019-1-keescook@chromium.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 8 Jan 2022 10:28:22 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFi=A+QZWom_CYDQ0UVPrB10MkxJFtQ=KT0HQNprgrUjw@mail.gmail.com>
Message-ID: <CAMj1kXFi=A+QZWom_CYDQ0UVPrB10MkxJFtQ=KT0HQNprgrUjw@mail.gmail.com>
Subject: Re: [PATCH v2] crypto: octeontx2 - Avoid stack variable overflow
To:     Kees Cook <keescook@chromium.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Arnaud Ebalard <arno@natisbad.org>,
        Srujana Challa <schalla@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Suheil Chandran <schandran@marvell.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Lukasz Bartosik <lbartosik@marvell.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jan 2022 at 18:50, Kees Cook <keescook@chromium.org> wrote:
>
> Building with -Warray-bounds showed a stack variable array index
> overflow. Increase the expected size of the array to avoid the warning:
>
> In file included from ./include/linux/printk.h:555,
>                  from ./include/asm-generic/bug.h:22,
>                  from ./arch/x86/include/asm/bug.h:84,
>                  from ./include/linux/bug.h:5,
>                  from ./include/linux/mmdebug.h:5,
>                  from ./include/linux/gfp.h:5,
>                  from ./include/linux/firmware.h:7,
>                  from drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c:5:
> drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c: In function 'otx2_cpt_print_uc_dbg_info':
> ./include/linux/dynamic_debug.h:162:33: warning: array subscript 4 is above array bounds of 'u32[4]' {aka 'unsigned int[4]'} [-Warray-bounds]
>   162 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
>       |                                 ^
> ./include/linux/dynamic_debug.h:134:17: note: in definition of macro '__dynamic_func_call'
>   134 |                 func(&id, ##__VA_ARGS__);               \
>       |                 ^~~~
> ./include/linux/dynamic_debug.h:162:9: note: in expansion of macro '_dynamic_func_call'
>   162 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
>       |         ^~~~~~~~~~~~~~~~~~
> ./include/linux/printk.h:570:9: note: in expansion of macro 'dynamic_pr_debug'
>   570 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
>       |         ^~~~~~~~~~~~~~~~
> drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c:1807:41: note: in expansion of macro 'pr_debug'
>  1807 |                                         pr_debug("Mask: %8.8x %8.8x %8.8x %8.8x %8.8x",
>       |                                         ^~~~~~~~
> drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c:1765:13: note: while referencing 'mask'
>  1765 |         u32 mask[4];
>       |             ^~~~
>
> This is justified because the mask size (eng_grps->engs_num) can be at
> most 144 (OTX2_CPT_MAX_ENGINES bits), which is larger than available
> storage. 4 * 32 == 128, so this must be 5: 5 * 32bit = 150.
>

160

> Additionally clear the mask before conversion so trailing bits are zero.
>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Boris Brezillon <bbrezillon@kernel.org>
> Cc: Arnaud Ebalard <arno@natisbad.org>
> Cc: Srujana Challa <schalla@marvell.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Suheil Chandran <schandran@marvell.com>
> Cc: Shijith Thotton <sthotton@marvell.com>
> Cc: Lukasz Bartosik <lbartosik@marvell.com>
> Cc: linux-crypto@vger.kernel.org
> Fixes: d9d7749773e8 ("crypto: octeontx2 - add apis for custom engine groups")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
> v1: https://lore.kernel.org/lkml/20211215225558.1995027-1-keescook@chromium.org/
> v2:
>  - expliticly zero "mask"
>  - explain math in commit log
>  - move definition into local context
> ---
>  drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
> index 4c8ebdf671ca..1b4d425bbf0e 100644
> --- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
> +++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
> @@ -1753,7 +1753,6 @@ void otx2_cpt_print_uc_dbg_info(struct otx2_cptpf_dev *cptpf)
>         char engs_info[2 * OTX2_CPT_NAME_LENGTH];
>         struct otx2_cpt_eng_grp_info *grp;
>         struct otx2_cpt_engs_rsvd *engs;
> -       u32 mask[4];
>         int i, j;
>
>         pr_debug("Engine groups global info");
> @@ -1785,6 +1784,8 @@ void otx2_cpt_print_uc_dbg_info(struct otx2_cptpf_dev *cptpf)
>                 for (j = 0; j < OTX2_CPT_MAX_ETYPES_PER_GRP; j++) {
>                         engs = &grp->engs[j];
>                         if (engs->type) {
> +                               u32 mask[5] = { };
> +
>                                 get_engs_info(grp, engs_info,
>                                               2 * OTX2_CPT_NAME_LENGTH, j);
>                                 pr_debug("Slot%d: %s", j, engs_info);
> --
> 2.30.2
>
