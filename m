Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC1858031E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 18:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236587AbiGYQuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 12:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiGYQuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 12:50:09 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FCBCE31
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:50:05 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id m12so17886971lfj.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tyI9td67bcc1mM3GHqCajUCSH3Ke5VbHVOY+UYWHBPY=;
        b=lHkLhY0qdqZ4adsXwuEPRaaSbxs80DBJCp9xCDBJ7V1yz0WhdkXaJ871FHl6vBAQJN
         2h+PeH59ml4zJjNNYheXFXoJn+TlXEsxN3W5Hpo745CyUq0+Wxe2rOHhq1mmQyGY5T+E
         PyjrCoWk30ONwyrkbTu2mTFAfQj9TfdHZsjDtBx7Vl1R6HWAQgeEGUdcic1GCuU8Z7F8
         RejkwqXZ9dvw6rB1O1NDRLCkl8XZkjMdg6U9B5xxIUspu88ypJTD68oiezzFIDFdLo4b
         loQUWuItLqIb28iPM3v3kRZVls+xaBE3aGA/99FaKAWU7Lxjz/Le9G/FZvB5qJsW2jmn
         Bg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tyI9td67bcc1mM3GHqCajUCSH3Ke5VbHVOY+UYWHBPY=;
        b=txQ9b2wiZJ8iWn2FJnTUjrviaVvFmV+q2ZQ6csWR+IeR5RW+7ceAbtfHXdh2WgXbgj
         ttqWUtleI9vCZBMo1A8lcPne97yXYfu6uT1jyzm/bpnYiP0oRn4G7c8r4VcCazBnrM2N
         WOrfg0qs8r3LF73S42oWNkl+nkme/ycZcdt65prwwmqm0Zh+scTqccbqLXAeDGU8yfXS
         7YpO+IdYJzPodXGFjjOCYgPYjipmfyTrIhy9Ft1d3aOLMq9J68RQG1K9lGmM3CxNmTj3
         0rFMZtC/Rb35dPdAIqquq+sd3vkGHsKy0dh5W+toYwO+FURKHK2R3zWEO5lpvh/JjGM9
         d05g==
X-Gm-Message-State: AJIora8bf7XIC8+W9qOIP1+GAg80iJvYRjAhO1vTiEtyVLhvx//AndL8
        S0A1Wjit18a2BfnEXPrjbeM6Hxxf1rw2YE/VmrQodw==
X-Google-Smtp-Source: AGRyM1sWe9k4cPeb13Il+HCc0lh1LpjXywelNryWBo6WxT3bAYC6FdPBZQZhRxJBtQ5Jio/DsZsXLEUKSuBbs1AaevI=
X-Received: by 2002:ac2:4c46:0:b0:489:e93c:69b with SMTP id
 o6-20020ac24c46000000b00489e93c069bmr4695898lfk.403.1658767803942; Mon, 25
 Jul 2022 09:50:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220719165300.3000580-1-masahiroy@kernel.org>
In-Reply-To: <20220719165300.3000580-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 25 Jul 2022 09:49:51 -0700
Message-ID: <CAKwvOdkscrCW45bJmTPX+rv+Ry0xJ3-vzz4Cm6JwYV=Pxtp-TA@mail.gmail.com>
Subject: Re: [PATCH 1/2] modpost: drop executable ELF support
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
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

On Tue, Jul 19, 2022 at 9:53 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Since commit 269a535ca931 ("modpost: generate vmlinux.symvers and
> reuse it for the second modpost"), modpost only parses relocatable
> files (ET_REL).
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  scripts/mod/modpost.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 7735d095338c..6370f9accb8e 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -321,9 +321,6 @@ static void *sym_get_data_by_offset(const struct elf_info *info,
>  {
>         Elf_Shdr *sechdr = &info->sechdrs[secindex];
>
> -       if (info->hdr->e_type != ET_REL)
> -               offset -= sechdr->sh_addr;
> -
>         return (void *)info->hdr + sechdr->sh_offset + offset;
>  }
>
> @@ -477,6 +474,10 @@ static int parse_elf(struct elf_info *info, const char *filename)
>         sechdrs = (void *)hdr + hdr->e_shoff;
>         info->sechdrs = sechdrs;
>
> +       /* modpost only works for relocatable objects */
> +       if (hdr->e_type != ET_REL)
> +               fatal("%s: not relocatable object.", filename);
> +
>         /* Check if file offset is correct */
>         if (hdr->e_shoff > info->size) {
>                 fatal("section header offset=%lu in file '%s' is bigger than filesize=%zu\n",
> @@ -1633,9 +1634,6 @@ static int addend_386_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
>                 break;
>         case R_386_PC32:
>                 r->r_addend = TO_NATIVE(*location) + 4;
> -               /* For CONFIG_RELOCATABLE=y */
> -               if (elf->hdr->e_type == ET_EXEC)
> -                       r->r_addend += r->r_offset;
>                 break;
>         }
>         return 0;
> --
> 2.34.1
>


-- 
Thanks,
~Nick Desaulniers
