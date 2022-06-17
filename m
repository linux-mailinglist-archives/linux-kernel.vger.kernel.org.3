Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4463554FC35
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 19:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382581AbiFQR2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 13:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382854AbiFQR2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 13:28:32 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9CD31385
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 10:28:28 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id h23so7926256lfe.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 10:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2iMWXBPnOAvL91x7XXFneze/ct4K35iTffkNzMkLzqw=;
        b=qTp8DjoJBHy8bXuV22ichr8sHQMtE/7h3V0NQD2dj7DJ0EYOK9Wq2BjbGgsLQJbQJG
         Ua7x2+6cHrpS1MzOou1kn/Na2Od9g2j2f136mlLmNbqUTlzgtgeD3Ye0BTiOBFoJpRwn
         P7ncosost+TDrkGr+Wsc6boVqgMXUOXeMoJpH+jm9vYr5vdvvvMF3Pado4xdm3Y8pfQF
         2B7bD+FbkXGXVDgX3bsUt4gvzWV7yANEbtMXgZfG6tZpgSbjL+6xYEM9IUbeTHeJC2bu
         U1yQhp4ptvtPvRWUShcStK8ME13e7N5vOxUegrWIZj+j3VLqRzTPuynZYRVq2SqrV8gc
         q+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2iMWXBPnOAvL91x7XXFneze/ct4K35iTffkNzMkLzqw=;
        b=y7gzVCEXmLtB6gw2mTBwQkR9h4+v24hhyd2DrR4xuypNCiXv9oxJfh3mn2dOMLCnWu
         oS63QYx0BC40Zn6nlL8IxV3bWRm2Ow1+S3SwaTtuewCQShqX43i8rPdnYsotizBM2VhQ
         FUHtt3H5rg4m/ZqN4v9f1IdrEfkDUFwqlXE7bRSPRE788VABjCGbFj8WOxLE/Xlsitmb
         LDMz7Vm1NvvCbaK/rd5Bneh9pbThFGq0h/jg7r63Q+CFlRDV+1RVIwCzjMqq/rIl1F7Z
         f7YUg31disNpWsRiFiLj79JVGzAq82pJiAc3BC7K++In8nsNhzCcongJ/VwjT1+BUh6W
         FnsQ==
X-Gm-Message-State: AJIora+nKBM475zV4ROBjSaeY+PgIR1Yf/d4pA4Mx7VUSCAMhUUfy0Dd
        uUtZOxE/vDdDUHThqAzmF+4o60fZinBAuAPbGwpgUMZ9TARVrw==
X-Google-Smtp-Source: AGRyM1sqczh0IkiJhWSqWEM7HeqRGPhYZRjgy0DpAv7jHEKD44Tx9Td1xlg5nsppbN59C9tWEx66hV/Do8ddRP6Eqbc=
X-Received: by 2002:a05:6512:10cb:b0:479:682e:7f0c with SMTP id
 k11-20020a05651210cb00b00479682e7f0cmr6180930lfg.626.1655486906328; Fri, 17
 Jun 2022 10:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220616195759.3214538-1-samitolvanen@google.com>
In-Reply-To: <20220616195759.3214538-1-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 17 Jun 2022 10:28:14 -0700
Message-ID: <CAKwvOd=KWfNsUFcW4Enq5i94t0zyi7+C9p1-+QUP8+SvoHs=NA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Ignore __this_module in gen_autoksyms.sh
To:     Sami Tolvanen <samitolvanen@google.com>,
        Ramji Jiyani <ramjiyani@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Alexander Lobakin <alobakin@pm.me>,
        Steve Muckle <smuckle@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Sedat
Re: https://lore.kernel.org/linux-kbuild/CAKwvOdmb5xdF70TzNp=4STCpzkGh16FnuKE1KbdzDhHt=OuRFA@mail.gmail.com/
In case this helps.

+ Ramji
Ramji, it sounds like you helped test this downstream? If that's the
case, mind supplying your tested-by tag for the record? Thanks for
help verifying this change. Thanks too, Steve!

On Thu, Jun 16, 2022 at 12:58 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> Module object files can contain an undefined reference to __this_module,
> which isn't resolved until we link the final .ko. The kernel doesn't
> export this symbol, so ignore it in gen_autoksyms.sh. This avoids an
> unnecessary vmlinux rebuild with UNUSED_KSYMS_WHITELIST when we have a
> symbol list that already contains all the module dependencies.

Worth mentioning that this also fixes a significant build time
regression made more painful by CONFIG_LTO_CLANG_FULL when using
CONFIG_UNUSED_KSYMS_WHITELIST.

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
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
Thanks,
~Nick Desaulniers
