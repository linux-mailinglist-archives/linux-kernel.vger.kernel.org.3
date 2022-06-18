Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC0F550765
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 01:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbiFRXAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 19:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiFRXAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 19:00:52 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2255FD3C;
        Sat, 18 Jun 2022 16:00:51 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 25IN0U4M020802;
        Sun, 19 Jun 2022 08:00:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 25IN0U4M020802
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1655593232;
        bh=OPafFCN8j6/Th3TYQPVTAZ/0OBtsya/p0tqu/GJE6Tw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Wfj8c0Xv4Vypn9wH5hNN3yxI1i14Gphn2bb7EZtURjTNwc2bOjjPwtfwf0Q9RBye0
         iqTfMUs0+kvrBeGlZAbkyJoMc84j60Q5XMu5UeF/BZ3jwL8Gk/b4LcQIzGMH750z9r
         1yn7L/7Pt+CYOGrX3yxQ5I2jowbvmPnNtliCKivei0w9staXod7zDbkbuzsku7JOeR
         iAHz/XpA/rWEi0AQBxUJk1fvl1gMOdQoj7shN6Nsm+vAZ+2Roc8ojKTKKzB6iR+End
         SlS0RvWHeL6KNHjwCdTv9wev47W0dzcl1ngJuFkgorBmIE2+G4kJ7ypwo6g6mZ0NsV
         A3lpkKJMK8Psg==
X-Nifty-SrcIP: [209.85.221.42]
Received: by mail-wr1-f42.google.com with SMTP id g27so3277041wrb.10;
        Sat, 18 Jun 2022 16:00:31 -0700 (PDT)
X-Gm-Message-State: AJIora8rEA5XUv4vNTTyBZ1z8vv26fkLMih2rv2Sl3fufnRFXXMMKtf5
        e7ResmPfLHRye+yijRZ75Y7mdM1stksSzM3VuxE=
X-Google-Smtp-Source: AGRyM1uhD22NFFPkUhQ5XGaigVBR/j7MXgiMhah0d2kWo210TD4RGX89dnUFCNeCcwmUk8oFnRzZb1Epvf+P9tdoqbE=
X-Received: by 2002:a5d:638b:0:b0:218:54a2:71ec with SMTP id
 p11-20020a5d638b000000b0021854a271ecmr15449262wru.477.1655593230127; Sat, 18
 Jun 2022 16:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220616195759.3214538-1-samitolvanen@google.com>
In-Reply-To: <20220616195759.3214538-1-samitolvanen@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 19 Jun 2022 07:59:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNARAAdWPxaMWawQf5Y4kYJ065OMtvrnUaHkjCquL_BZYYQ@mail.gmail.com>
Message-ID: <CAK7LNARAAdWPxaMWawQf5Y4kYJ065OMtvrnUaHkjCquL_BZYYQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Ignore __this_module in gen_autoksyms.sh
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Nicolas Schier <nicolas@fjasle.eu>,
        Alexander Lobakin <alobakin@pm.me>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Steve Muckle <smuckle@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 4:58 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> Module object files can contain an undefined reference to __this_module,
> which isn't resolved until we link the final .ko. The kernel doesn't
> export this symbol, so ignore it in gen_autoksyms.sh.

OK, I understand these two sentences.

> This avoids an
> unnecessary vmlinux rebuild with UNUSED_KSYMS_WHITELIST when we have a
> symbol list that already contains all the module dependencies.
>

I do not understand how this can happen.


Can you provide me steps to reproduce it?







> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  scripts/gen_autoksyms.sh | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/scripts/gen_autoksyms.sh b/scripts/gen_autoksyms.sh
> index faacf7062122..653fadbad302 100755
> --- a/scripts/gen_autoksyms.sh
> +++ b/scripts/gen_autoksyms.sh
> @@ -56,4 +56,7 @@ EOT
>  # point addresses.
>  sed -e 's/^\.//' |
>  sort -u |
> +# Ignore __this_module. It's not an exported symbol, and will be resolved
> +# when the final .ko's are linked.
> +grep -v '^__this_module$' |
>  sed -e 's/\(.*\)/#define __KSYM_\1 1/' >> "$output_file"
> --
> 2.36.1.476.g0c4daa206d-goog
>


-- 
Best Regards
Masahiro Yamada
