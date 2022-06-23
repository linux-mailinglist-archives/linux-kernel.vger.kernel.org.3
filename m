Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7500557707
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiFWJqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiFWJqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:46:34 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A63B49B40;
        Thu, 23 Jun 2022 02:46:30 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 25N9kFqq015247;
        Thu, 23 Jun 2022 18:46:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 25N9kFqq015247
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1655977576;
        bh=1uhnTAJRfb/h1YXlrMjIdSP2he3o0rrnFwOQHF2pkvc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lkaGpbmJrHiinfaqJkDmd2SI0Zrk2Z0Zl8RHfO24a+pGvf1DP49THExTXaP/NtIOK
         MgpWztEdofHAi3xtfoa519PmaEsBjFbSJkiGUDLorqxDTHKdX4MUK8caOx7bF2ad2i
         YX6bYkfl1aDiAIJO8ft+fbcm6Sp4pAx4jpiq8IrcKWp++WA4/Cpo0wqCyLYWCB1+mE
         jkqjwvrZ+jBjwWZxUnsLL66yYO3pfEALRXAtEAodTuXJfYfeSFViJK3ErH5J/Nd/PQ
         v1jU6jjUIqACDJAJGK/T101YrK0D6T5eZL3+c3U5bnkKx1saOdzsCUiLtt77GFRj45
         5xI6mAyPnTOPA==
X-Nifty-SrcIP: [209.85.128.41]
Received: by mail-wm1-f41.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so1124211wmb.5;
        Thu, 23 Jun 2022 02:46:16 -0700 (PDT)
X-Gm-Message-State: AJIora+dFgumbqaTis/3en0sSgHEjIoPJBMw5khr6Q6sHIh0cAgD/4/m
        qPb050OinulgOnsYiD1BSCPEYZ7xZwpc+27tnJg=
X-Google-Smtp-Source: AGRyM1tQ1TimxhhoceiZVUCEyqRunMVLsqa3SY56McKgJhhBFde9zSnnhe3dkK9WNOjy6Tzgk5uNzVUZwkMqBgAcUOk=
X-Received: by 2002:a05:600c:2157:b0:39a:a4d0:54e1 with SMTP id
 v23-20020a05600c215700b0039aa4d054e1mr3111566wml.14.1655977574443; Thu, 23
 Jun 2022 02:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220623083105.26354-1-jslaby@suse.cz>
In-Reply-To: <20220623083105.26354-1-jslaby@suse.cz>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 23 Jun 2022 18:45:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNARaB8-4mm4sZwH2DxGE=GAhS8HiF+-uT9suiHYHe8PgwQ@mail.gmail.com>
Message-ID: <CAK7LNARaB8-4mm4sZwH2DxGE=GAhS8HiF+-uT9suiHYHe8PgwQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild, link-vmlinux: Don't delete output files with make -i
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 5:31 PM Jiri Slaby <jslaby@suse.cz> wrote:
>
> From: Andi Kleen <andi@firstfloor.org>
>
> make -i is useful to see output files which normally get deleted on an
> error.  Make this work with link-vmlinux.sh too. Don't delete the output
> files on error when make -i is used.
>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: linux-kbuild@vger.kernel.org
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---



I am afraid you missed this commit:



commit 51eb95e2da41802454f48b9afeb4d96a77295035
Author: Andi Kleen <ak@linux.intel.com>
Date:   Tue May 4 20:35:27 2021 -0700

    kbuild: Don't remove link-vmlinux temporary files on exit/signal

    Keep them around until they are cleaned up by make clean. This
    uses a bit more disk space, but makes it easier to debug any
    problems with the kernel link process.

    Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
    Signed-off-by: Andi Kleen <ak@linux.intel.com>
    Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>













>  scripts/link-vmlinux.sh | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index eecc1863e556..d21759aad4f3 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -193,6 +193,11 @@ sorttable()
>  # Delete output files in case of error
>  cleanup()
>  {
> +       # don't delete for make -i
> +       case "$MFLAGS" in
> +       *-i*) return ;;
> +       esac
> +
>         rm -f .btf.*
>         rm -f System.map
>         rm -f vmlinux
> --
> 2.36.1
>


-- 
Best Regards
Masahiro Yamada
