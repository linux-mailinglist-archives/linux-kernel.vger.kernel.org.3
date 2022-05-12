Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E7352528F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356459AbiELQ36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343801AbiELQ3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:29:55 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF861B57B4;
        Thu, 12 May 2022 09:29:53 -0700 (PDT)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 24CGTdRr000432;
        Fri, 13 May 2022 01:29:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 24CGTdRr000432
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652372980;
        bh=mO/DMNrIOb9APlTM3yT+RrP66+SqAVMQ3Ym8daEBsB8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Au1gJMIjZjri4c45hmo3gtGE7edeeRZZiAj50KRCy93yqQEX3OiJc27G2vejdK/Rr
         SUkCPjY/bM5k2he0yiFxrOT/fF6M2XBnQxRW6uC+SQbH9PJl3bz/FIjj912CdGJE0W
         9TT1bAnCZzhs0dnpCqrIHoQ67+DHvE9o4MnJ+9esQrGuIetwcYueGNOFpYFk5jjQfQ
         PIHLlQzb7nNNbOh2CYRdUfX8b84e1HBeXve+49vBPxn4i2QGlHQcGAbrKoTTSJ+kYR
         7rV5SYftOIjaIbLqLugI5kDM9OSwKLxE7tIlPzuK6nRSqVRYzN6NBGVMeCw06vcpxt
         B9Okg8BC7RxcQ==
X-Nifty-SrcIP: [209.85.214.181]
Received: by mail-pl1-f181.google.com with SMTP id q4so5379133plr.11;
        Thu, 12 May 2022 09:29:40 -0700 (PDT)
X-Gm-Message-State: AOAM531Ckf51Ih4XDxmd/r5rREO4UKnvxWdJHkZ56WUaAVsfwG4KWRFl
        85esODfWFn0dwuDbofs2hFNiW0EBkmuXRxjEDvo=
X-Google-Smtp-Source: ABdhPJx92l367XcU+G3abVD603tgi5nQTDTAzhgbiPSkPLV6qRfWMHMAOxL8BNsF/qgdsmuh+OjAz9m/oAaHyRFzl18=
X-Received: by 2002:a17:90b:1bca:b0:1dd:1f36:dc2a with SMTP id
 oa10-20020a17090b1bca00b001dd1f36dc2amr11680027pjb.119.1652372979433; Thu, 12
 May 2022 09:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220511164514.2741934-1-masahiroy@kernel.org> <20220511164514.2741934-4-masahiroy@kernel.org>
In-Reply-To: <20220511164514.2741934-4-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 13 May 2022 01:28:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNATt7iFAHqxqW=5GggJJ_k9mXuDmSEkNyyJKG3c4MkxK_w@mail.gmail.com>
Message-ID: <CAK7LNATt7iFAHqxqW=5GggJJ_k9mXuDmSEkNyyJKG3c4MkxK_w@mail.gmail.com>
Subject: Re: [PATCH v5 03/12] modpost: extract symbol versions from *.cmd files
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules <linux-modules@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 1:49 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Currently, CONFIG_MODVERSIONS needs extra link to embed the symbol
> versions into ELF objects. Then, modpost extracts the version CRCs
> from them.
>
> The following figures show how it currently works, and how I am trying
> to change it.
>
> Current implementation
> ======================
>                                                            |----------|
>                  embed CRC      -------------------------->| final    |
>        $(CC)       $(LD)       /  |---------|              | link for |
>        -----> *.o -------> *.o -->| modpost |              | vmlinux  |
>       /              /            |         |-- *.mod.c -->| or       |
>      / genksyms     /             |---------|              | module   |
>   *.c ------> *.symversions                                |----------|
>
> Genksyms outputs the calculated CRCs in the form of linker script
> (*.symversions), which is used by $(LD) to update the object.
>
> If CONFIG_LTO_CLANG=y, the build process is much more complex. Embedding
> the CRCs is postponed until the LLVM bitcode is converted into ELF,
> creating another intermediate *.prelink.o.
>
> However, this complexity is unneeded. There is no reason why we must
> embed version CRCs in objects so early.
>
> There is final link stage for vmlinux (scripts/link-vmlinux.sh) and
> modules (scripts/Makefile.modfinal). We can link CRCs at the very last
> moment.
>
> New implementation
> ==================
>                                                            |----------|
>                    --------------------------------------->| final    |
>        $(CC)      /    |---------|                         | link for |
>        -----> *.o ---->|         |                         | vmlinux  |
>       /                | modpost |--- .vmlinux.export.c -->| or       |
>      / genksyms        |         |--- *.mod.c ------------>| module   |
>   *.c ------> *.cmd -->|---------|                         |----------|
>
> Pass the symbol versions to modpost as separate text data, which are
> available in *.cmd files.
>
> This commit changes modpost to extract CRCs from *.cmd files instead of
> from ELF objects.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>
> (no changes since v2)
>
> Changes in v2:
>   - Simplify the implementation (parse .cmd files after ELF)
>
>  scripts/mod/modpost.c | 177 ++++++++++++++++++++++++++++++------------
>  1 file changed, 129 insertions(+), 48 deletions(-)



> +/*
> + * The CRCs are recorded in .*.cmd files in the form of:
> + * #SYMVER <name> <crc>
> + */
> +static void extract_crcs_for_object(const char *object, struct module *mod)
> +{
> +       char cmd_file[PATH_MAX];
> +       char *buf, *p;
> +       const char *base;
> +       int dirlen, ret;
> +
> +       base = strrchr(object, '/');
> +       if (base) {
> +               base++;
> +               dirlen = base - object;
> +       } else {
> +               dirlen = 0;
> +               base = object;
> +       }
> +
> +       ret = snprintf(cmd_file, sizeof(cmd_file), "%.*s.%s.cmd",
> +                      dirlen, object, base);
> +       if (ret >= sizeof(cmd_file)) {
> +               error("%s: too long path was truncated\n", cmd_file);
> +               return;
> +       }
> +
> +       buf = read_text_file(cmd_file);
> +       p = buf;
> +
> +       while ((p = strstr(p, "\n#SYMVER "))) {
> +               char *name;
> +               size_t namelen;
> +               unsigned int crc;
> +               struct symbol *sym;
> +
> +               name = p + strlen("\n#SYMVER ");
> +
> +               p = strchr(name, ' ');
> +               if (!p)
> +                       break;
> +
> +               namelen = p - name;
> +               p++;
> +
> +               if (!isdigit(*p))
> +                       continue;       /* skip this line */
> +
> +               crc = strtol(p, &p, 0);
> +               if (*p != '\n')
> +                       continue;       /* skip this line */
> +
> +               name[namelen] = '\0';
> +
> +               sym = sym_find_with_module(name, mod);
> +               if (!sym) {
> +                       warn("Skip the version for unexported symbol \"%s\" [%s%s]\n",
> +                            name, mod->name, mod->is_vmlinux ? "" : ".ko");
> +                       continue;
> +               }


A lot of warnings are displayed when CONFIG_TRIM_UNUSED_KSYMS=y.

I will fix this in v6.




-- 
Best Regards
Masahiro Yamada
