Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5447A4EF708
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351803AbiDAPtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 11:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351273AbiDAPof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 11:44:35 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479C914D007;
        Fri,  1 Apr 2022 08:18:03 -0700 (PDT)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 231FHNEr002306;
        Sat, 2 Apr 2022 00:17:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 231FHNEr002306
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1648826243;
        bh=aWSDnl67ZAVuOzUgpvfUYGuvMYbT+i3ZC0clLwIqow8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HO+aCqANR698vxLRd2zHTiGEPbFLQK11xUb6OWjyYdBitBL71GXZszC12pCmb2dw7
         +3vwoSpXZ3mBry1PL09RU7uiQ0Oui1V4BHIxsu4JqP3pbixn6q4WhttHBcFi3KB5fV
         nXa7bQohZqYH1A14kFgPvblae8YLgtvnY601eey+LHVi5FwbV5Y5L5ea86MNGMN3t9
         uiLFqD87ZGQYEt+fKsbRJ8IWwQPLKShQfMar7heuHDo4ik399knH29W9YZn3eLy7rd
         fGW+r0IQ+vhBtyLipab6EGjzkBiLWM6a3LO1VSt3c7GzgM7ynbN6IFvd0JYOkJDMp+
         U6gcwwAv0CNhA==
X-Nifty-SrcIP: [209.85.216.49]
Received: by mail-pj1-f49.google.com with SMTP id bx24-20020a17090af49800b001c6872a9e4eso2813207pjb.5;
        Fri, 01 Apr 2022 08:17:23 -0700 (PDT)
X-Gm-Message-State: AOAM530H/1agg4r76LI147oTkk9nar47nffPdS11EwK4uV89w2bG1Acl
        hjTQEMydktztF82vcB1+lcp3sA+oiD/Ks6fh9cs=
X-Google-Smtp-Source: ABdhPJyLhqMgW9ayGW3v4PXQ+B6/7L5uzpdrCapWyDke96izvWf0Rh0ZSlE2wWBznetoSBd44AMKM/YtlO28NT72+iM=
X-Received: by 2002:a17:90a:8405:b0:1bc:d521:b2c9 with SMTP id
 j5-20020a17090a840500b001bcd521b2c9mr12425126pjn.119.1648826242638; Fri, 01
 Apr 2022 08:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220329021437.308790-1-masahiroy@kernel.org>
In-Reply-To: <20220329021437.308790-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 2 Apr 2022 00:16:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNASUgORfWVMVYdJg+qKRSnSuFQhwwPPBhKsN4VwFzbk+=g@mail.gmail.com>
Message-ID: <CAK7LNASUgORfWVMVYdJg+qKRSnSuFQhwwPPBhKsN4VwFzbk+=g@mail.gmail.com>
Subject: Re: [PATCH] kbuild: fix empty ${PYTHON} in scripts/link-vmlinux.sh
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 11:15 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> The two commits
>
>   d8d2d38275c1 ("kbuild: remove PYTHON variable")
>   a8cccdd95473 ("init: lto: ensure initcall ordering")
>
> were applied in the same development cycle, in two different trees.
>
> After they were merged together, this ${PYTHON} expands to an empty
> string.
>
> Therefore, ${srctree}/scripts/jobserver-exec is executed directly.
> (it has the executable bit set)
>
> This is working but let's fix the code into the intended form.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Applied to linux-kbuild/fixes.


>
>  scripts/link-vmlinux.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index f704034ebbe6..20f44504a644 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -50,7 +50,7 @@ gen_initcalls()
>  {
>         info GEN .tmp_initcalls.lds
>
> -       ${PYTHON} ${srctree}/scripts/jobserver-exec             \
> +       ${PYTHON3} ${srctree}/scripts/jobserver-exec            \
>         ${PERL} ${srctree}/scripts/generate_initcall_order.pl   \
>                 ${KBUILD_VMLINUX_OBJS} ${KBUILD_VMLINUX_LIBS}   \
>                 > .tmp_initcalls.lds
> --
> 2.32.0
>


-- 
Best Regards
Masahiro Yamada
