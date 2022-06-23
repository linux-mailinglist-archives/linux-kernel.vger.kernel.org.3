Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4021755899F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiFWT6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiFWT6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:58:44 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A5A33A16
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 12:58:43 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id by38so365603ljb.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 12:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YZmdOLUgEpuTcs1Er5G/nrfMC7op/4LBGH4A+xFyAt0=;
        b=ZebJOSWT2zWcG2uvS9eF3zF5SQ4HNIFc/WJ7Bphdxi0+AerWwxhNUpk+VEMC8yc6xp
         aGFOeMpzCTsccoXpVwW0qQYIANqcICuf2JQDu2E2/B8r0M+GP2tgwouM5IeHrcpE4bgO
         aA+Ll+TejeUihxrA/Dg8oI4agSim/A3o9gYWF5yTB5rGhl0sO5ocEhni9kIRj0CNUPFO
         W1uBH2Sg05XhI3I29EhBiPhJNGYtC5OB5kiC+4/o6I1ZFry+SFWV66SOkIJQ9Gn49MWq
         oW++ew/TpJk2iiIt5mb7xisPBSZyvhmWHIdHNYsJKHRh/wRV6E5lJoY3XSKiONqetOrh
         e4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YZmdOLUgEpuTcs1Er5G/nrfMC7op/4LBGH4A+xFyAt0=;
        b=quJwtr3o7C1VPnvBn6kb8O8NP3HctzYc1tZhPPgxjwpTh8+0LNKPg8jbDZFlgEOA0t
         s7rK31guiB7A4h0zqm0qJ2fyo3wWHcYm7m6VktC8cEzZvkrpUoPpDaYp3EcO3vy5I0zn
         aEgwSewAvlmztZSR+88NakObeQARtKM+bqHejO3BgzGJ/xbzIfJFxPbmgnsKWu0HKm8B
         hEla18jacrT3JFBlTMui4NfnW8EozFTuHX53l9DDbIjgggGr212pGQAtO/21CseRGr2Q
         Q+bqrIdCWP/Tw8qQ/WTZURNgCpj2uBy3sIZ1u91iZgt8K4GCvNVDGrqsE7ZyzXYLNUu2
         8mrA==
X-Gm-Message-State: AJIora9XB6A0mrw7uzAGVIFPVlHxu3tC7ukewqWU7JlWcTAXvD2XLiFY
        2gB1VdTgnMkXATHmmMnMlWDzBP3UcuwtKFuvI568wA==
X-Google-Smtp-Source: AGRyM1sW41dkNu1yPnHok/IKa2eFD9oNjNnp9/++s2YawW1f4VSUU9UuDeraaVVUzZk6WxiUJgd5EpGB76EEj5iBgdQ=
X-Received: by 2002:a2e:3109:0:b0:25a:8a0c:40e2 with SMTP id
 x9-20020a2e3109000000b0025a8a0c40e2mr5029528ljx.26.1656014321462; Thu, 23 Jun
 2022 12:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220623191147.1916067-1-masahiroy@kernel.org>
In-Reply-To: <20220623191147.1916067-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 23 Jun 2022 12:58:29 -0700
Message-ID: <CAKwvOd=DWQBQC4OnF8Y=T7s0+kAai7QseN7_zYRoraU4a9Nosw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: link vmlinux only once for CONFIG_TRIM_UNUSED_KSYMS
 (2nd attempt)
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
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

Thanks for digging into this more!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

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
> --
> 2.34.1
>


-- 
Thanks,
~Nick Desaulniers
