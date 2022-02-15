Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC6D4B6027
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 02:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbiBOBuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 20:50:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbiBOBuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 20:50:01 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB06B0C6E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 17:49:51 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id l125so18497117ybl.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 17:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FJj1WBzKHeHq7xycI/vstmM3MgrQelS5LPmPdKG2Z3E=;
        b=iaQxBnfnmpmtqAOkM7vQnm9gu8pVdJjB1Um1XNTsT9hdbvwpt5VzEy/ogrvfM3wL1A
         luQdviok/PdDEqUlA9cE8BlDs5K/BgMcoD78ezH7jmwmLR7vf1GbbweN4gP1RrOHo+Zv
         UC+bgIuZ03xtmldU0X1lOtFQMzFB2Y9EXluB5hO/ZJ3fzBqK/zsoWyH4XQC4zxl0TdzA
         NhgzVCFB/zSvHiG/CKPYpkqEI8JwNNTYU4dYEJTTZcumGx4+xempMO/Z0DZw55Bw+Rev
         EsYTPMAo9auvX8eLThdp5uz1iUizJ2bVPBdRGDCxWGg/Y2tWfe539o4fljMND/rGE6bs
         zGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FJj1WBzKHeHq7xycI/vstmM3MgrQelS5LPmPdKG2Z3E=;
        b=NdTOrdRuxM+F28CqAdICaLf0hk5b1+ekq2frSNP+MiwrzHk6y3K/nZv3DKpLrDU1Cn
         wiwFZhlLTWOte1XXF6IptgPkAY4EEBLakOkB/9ktSEvIZWUefNJxh9/BctW+IDTf52I9
         xS4UmXQnMpE0zLRJf/GSG2zAXnJ0+XR0Dt21cx16tBTFpHgkczBkWB0TZ09tD8qZnYR8
         KmGXGMaExPb2Db7mZ8kdTuFn2kE0flQi48JjpwRY2oZIu7kEWOdv6Bl/0j36gzB5Z1tG
         B9oyAQWL4uKQaxR4yo/K5abs7ZAdy6zUchu+s4Pt3uM3pjfux3Y4vo092PNr2NR7E+7m
         jW5Q==
X-Gm-Message-State: AOAM532EABwJrAvLcDD6lKZREHBdrHpGdp5lqPH/mxV74+jvLbdA7nA5
        9xZHMDf8fxZ5gD0e+6Gu6FOqZO3rji+cKuzq8Lnc
X-Google-Smtp-Source: ABdhPJy+H1L4z3tZTUtJLjIPjqTxMpQkQuBqADy+loxDTVrSCqFR3Jj29hjSCFtNNnzq0gZZW1arF/8sOQO5i1aMwEw=
X-Received: by 2002:a5b:443:: with SMTP id s3mr1797685ybp.117.1644889790701;
 Mon, 14 Feb 2022 17:49:50 -0800 (PST)
MIME-Version: 1.0
References: <20220202055123.2144842-1-wedsonaf@google.com>
In-Reply-To: <20220202055123.2144842-1-wedsonaf@google.com>
From:   Wedson Almeida Filho <wedsonaf@google.com>
Date:   Tue, 15 Feb 2022 01:49:39 +0000
Message-ID: <CAMKQLN+Q3asVqP3MZVFZO66CvZVVfGOZn=pMXmiNqZ7t2i55wg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/module_64: use module_init_section instead of
 patching names
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>
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

Hi Michael,

On Wed, 2 Feb 2022 at 05:53, Wedson Almeida Filho <wedsonaf@google.com> wrote:
>
> Without this patch, module init sections are disabled by patching their
> names in arch-specific code when they're loaded (which prevents code in
> layout_sections from finding init sections). This patch uses the new
> arch-specific module_init_section instead.
>
> This allows modules that have .init_array sections to have the
> initialisers properly called (on load, before init). Without this patch,
> the initialisers are not called because .init_array is renamed to
> _init_array, and thus isn't found by code in find_module_sections().
>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> ---
>  arch/powerpc/kernel/module_64.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
> index 5d77d3f5fbb5..6a45e6ddbe58 100644
> --- a/arch/powerpc/kernel/module_64.c
> +++ b/arch/powerpc/kernel/module_64.c
> @@ -277,6 +277,12 @@ static Elf64_Sym *find_dot_toc(Elf64_Shdr *sechdrs,
>         return NULL;
>  }
>
> +bool module_init_section(const char *name)
> +{
> +       /* We don't handle .init for the moment: always return false. */
> +       return false;
> +}
> +
>  int module_frob_arch_sections(Elf64_Ehdr *hdr,
>                               Elf64_Shdr *sechdrs,
>                               char *secstrings,
> @@ -286,7 +292,6 @@ int module_frob_arch_sections(Elf64_Ehdr *hdr,
>
>         /* Find .toc and .stubs sections, symtab and strtab */
>         for (i = 1; i < hdr->e_shnum; i++) {
> -               char *p;
>                 if (strcmp(secstrings + sechdrs[i].sh_name, ".stubs") == 0)
>                         me->arch.stubs_section = i;
>                 else if (strcmp(secstrings + sechdrs[i].sh_name, ".toc") == 0) {
> @@ -298,10 +303,6 @@ int module_frob_arch_sections(Elf64_Ehdr *hdr,
>                         dedotify_versions((void *)hdr + sechdrs[i].sh_offset,
>                                           sechdrs[i].sh_size);
>
> -               /* We don't handle .init for the moment: rename to _init */
> -               while ((p = strstr(secstrings + sechdrs[i].sh_name, ".init")))
> -                       p[0] = '_';
> -
>                 if (sechdrs[i].sh_type == SHT_SYMTAB)
>                         dedotify((void *)hdr + sechdrs[i].sh_offset,
>                                  sechdrs[i].sh_size / sizeof(Elf64_Sym),
> --
> 2.35.0.rc2.247.g8bbb082509-goog

Would any additional clarification from my part be helpful here?

I got an email saying it was under review (and checks passed) but
nothing appears to have happened since.

Cheers,
-Wedson
