Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C035710C1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 05:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiGLDVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 23:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiGLDVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 23:21:14 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C159D2ED6F;
        Mon, 11 Jul 2022 20:21:12 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 26C3KxVE015855;
        Tue, 12 Jul 2022 12:21:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 26C3KxVE015855
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1657596060;
        bh=DOhN9aOTUQ78HPm07pl3GGSxyC8IkiOMP2V1fqQ8GPE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bqGRbfHV5p8+9Q6NvDM9/fWsnfXgbCyahMluxK8yF62xo9hLlgvfmfHtr/mtgg/tE
         BHRleVdF8JMhlkGv3wPhYB9fegWQZsdWieMJTz3oL/lKVRHTw7OKsM5ORhXAnjCqul
         ZdAQcVNNrHwube0Sgvvevh2UhW41wo2LxDcyicFvkH0nIMf0bma3mjBz+P+887WZzg
         LU1VnfwmhffpYG4oXUEuOmPw2rr4SULsmo9zw9MCes1NWeAwbCIRH1mUgaJDlyROI+
         XS99qCL5SERxwnEIsVH+X6Wz6izuaaK6vXfC711YVL472Tx/QR+jkCcFV9mI4amBOR
         1NTiipCXi9DNw==
X-Nifty-SrcIP: [209.85.128.53]
Received: by mail-wm1-f53.google.com with SMTP id n185so3988289wmn.4;
        Mon, 11 Jul 2022 20:20:59 -0700 (PDT)
X-Gm-Message-State: AJIora8aP52Bp8lQH36lQB+37bk7lrBAos09BWiEJP7aVTzFrA20P5ks
        anBG3TJBf0V1Y1V+/7kGaXLHnW655fTwcQw8NTU=
X-Google-Smtp-Source: AGRyM1t7PapFZYY82X2BRYLHLU8fWFry2vboUwz/ie3okECdT1R20+nSKKeMmfqGWck5GBWOApjFmcLyDqj3UvFa+Yc=
X-Received: by 2002:a1c:6a06:0:b0:3a0:5099:f849 with SMTP id
 f6-20020a1c6a06000000b003a05099f849mr1398898wmc.14.1657596058483; Mon, 11 Jul
 2022 20:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220711120923.1004759-1-omosnace@redhat.com>
In-Reply-To: <20220711120923.1004759-1-omosnace@redhat.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 12 Jul 2022 12:20:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR8UV9jECd41tVfpRDMnZaPaErYm2-d1TmS+T_pZauQwg@mail.gmail.com>
Message-ID: <CAK7LNAR8UV9jECd41tVfpRDMnZaPaErYm2-d1TmS+T_pZauQwg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: dummy-tools: avoid tmpdir leak in dummy gcc
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
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

On Mon, Jul 11, 2022 at 9:09 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> When passed -print-file-name=plugin, the dummy gcc script creates a
> temporary directory that is never cleaned up. To avoid cluttering
> $TMPDIR, instead use a static directory included in the source tree.
>
> Fixes: 76426e238834 ("kbuild: add dummy toolchains to enable all cc-option etc. in Kconfig")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---

Applied to linux-kbuild. Thanks.



>  .../dummy-tools/dummy-plugin-dir/include/plugin-version.h | 0
>  scripts/dummy-tools/gcc                                   | 8 ++------
>  2 files changed, 2 insertions(+), 6 deletions(-)
>  create mode 100644 scripts/dummy-tools/dummy-plugin-dir/include/plugin-version.h
>
> diff --git a/scripts/dummy-tools/dummy-plugin-dir/include/plugin-version.h b/scripts/dummy-tools/dummy-plugin-dir/include/plugin-version.h
> new file mode 100644
> index 000000000000..e69de29bb2d1
> diff --git a/scripts/dummy-tools/gcc b/scripts/dummy-tools/gcc
> index b2483149bbe5..7db825843435 100755
> --- a/scripts/dummy-tools/gcc
> +++ b/scripts/dummy-tools/gcc
> @@ -96,12 +96,8 @@ fi
>
>  # To set GCC_PLUGINS
>  if arg_contain -print-file-name=plugin "$@"; then
> -       plugin_dir=$(mktemp -d)
> -
> -       mkdir -p $plugin_dir/include
> -       touch $plugin_dir/include/plugin-version.h
> -
> -       echo $plugin_dir
> +       # Use $0 to find the in-tree dummy directory
> +       echo "$(dirname "$(readlink -f "$0")")/dummy-plugin-dir"
>         exit 0
>  fi
>
> --
> 2.36.1
>


-- 
Best Regards
Masahiro Yamada
