Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6354558992
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiFWTvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiFWTu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:50:57 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DACB7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 12:50:56 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-317741c86fdso4956267b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 12:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A0c0cqma89+9GUKY/iVUbbVU1cNPUk0oJ5cVoRl/jck=;
        b=ZyyNFMRx5E/9vt53oa8zxARaSY/cuXaXex0tUYjxfFMVjar+zI2VF0BhKLrJb7oK39
         CYgTLmmqeQ+sWk0jH1Bcj78r3PASgzRRZy2XLkpZ8qiChRHGj2+hb4vNUUVT1INj8yA6
         LT1EPXm7Cul0FfmXNy/6qvRJyCF6EtUorIhTRySZqmOZ8ZIGWZoaAmrqdFylW8YNttUj
         M9TWmpBtuLJxaI9V0RbPatHmrILiHD/rJUrbsE/zYlY6oHeeK2gKAN7lzpvhoofhDlxg
         Zk4AEK0cpx1IwnW+3LJRs8qcK52k+sP9i0PTMtVIm56LBPuC7Ozz4FMiUvfSQqEL7Li1
         lc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A0c0cqma89+9GUKY/iVUbbVU1cNPUk0oJ5cVoRl/jck=;
        b=7COVaOyOBDWk4gXpL3O41gNtkyctBsNcUK3hqEO9IZ7PimbyaYpF16bMRy9elRgBPS
         6T8xsiICUbeNbStFdsyU4fC4RcvUZFpJ51n+ADyH+4eEY3y82zCR/zVtq63XUl0EtIiB
         IAK34L2GibUESyUwlqabdFlvwwhF0Y1C9Na9LXbv9/tnUE6Urmz5Tm3iZRFwGh213bw8
         5njySoeIXkTSoV3YXHIXAAtLLklZ8RePqrftElUS2l0Bwoa4lYHIP1i8e0L/ust6I1Zf
         plOXpQevNhZxFXdX4HhLe8oPXuNl6aFeB+wuPMqpl7CUGM/VZFBNIgz/e/pL412gSRib
         jJzQ==
X-Gm-Message-State: AJIora+qwXgFJALbGWFLczNnzXf9hIiPVpm3RclcrowB0/ua2OGRyFqk
        MSO1IUMQJmwkULaW3ltjUEFP2+D0sIEuGef00gu/Eg==
X-Google-Smtp-Source: AGRyM1tzrobr2NzAtujqB5kVrNJZt5e0DxPVJogaxye2ERCF+QHcMFNh9iBbGIqmKcu24EEvO9jCEWNRrFH7KHoPhXg=
X-Received: by 2002:a81:c44b:0:b0:317:5a3b:3fc5 with SMTP id
 s11-20020a81c44b000000b003175a3b3fc5mr12474505ywj.39.1656013855437; Thu, 23
 Jun 2022 12:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220623191147.1916067-1-masahiroy@kernel.org>
In-Reply-To: <20220623191147.1916067-1-masahiroy@kernel.org>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 23 Jun 2022 12:50:19 -0700
Message-ID: <CABCJKucFQtqKqZTdF06cCuLJqSp6f6NBmffsU4jGC05XOPqFrg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: link vmlinux only once for CONFIG_TRIM_UNUSED_KSYMS
 (2nd attempt)
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Pitre <nico@fluxnic.net>
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

On Thu, Jun 23, 2022 at 12:12 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> If CONFIG_TRIM_UNUSED_KSYMS is enabled and the kernel is built from
> a pristine state, the vmlinux is linked twice.
>
> Commit 3fdc7d3fe4c0 ("kbuild: link vmlinux only once for
> CONFIG_TRIM_UNUSED_KSYMS") explains why this happens, but it did not fix
> the issue at all.
>
> Now I realized I had applied a wrong patch.
>
> In v1 patch [1], the autoksyms_recursive target correctly recurses to
> "$(MAKE) -f $(srctree)/Makefile autoksyms_recursive".
>
> In v2 patch [2], I accidentally dropped the diff line, and it recurses to
> "$(MAKE) -f $(srctree)/Makefile vmlinux".
>
> Restore the code I intended in v1.
>
> [1]: https://lore.kernel.org/linux-kbuild/1521045861-22418-8-git-send-email-yamada.masahiro@socionext.com/
> [2]: https://lore.kernel.org/linux-kbuild/1521166725-24157-8-git-send-email-yamada.masahiro@socionext.com/
>
> Fixes: 3fdc7d3fe4c0 ("kbuild: link vmlinux only once for CONFIG_TRIM_UNUSED_KSYMS")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 513c1fbf7888..a3ff166c5035 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1141,7 +1141,7 @@ KBUILD_MODULES := 1
>
>  autoksyms_recursive: descend modules.order
>         $(Q)$(CONFIG_SHELL) $(srctree)/scripts/adjust_autoksyms.sh \
> -         "$(MAKE) -f $(srctree)/Makefile vmlinux"
> +         "$(MAKE) -f $(srctree)/Makefile autoksyms_recursive"
>  endif
>
>  autoksyms_h := $(if $(CONFIG_TRIM_UNUSED_KSYMS), include/generated/autoksyms.h)

Thanks for looking into this, Masahiro! I can confirm that this patch
fixes the issue with vmlinux getting linked twice in our use case.

Tested-by: Sami Tolvanen <samitolvanen@google.com>

Sami
