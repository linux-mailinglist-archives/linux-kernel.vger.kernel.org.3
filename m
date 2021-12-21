Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE7547C1C4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 15:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238593AbhLUOnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 09:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbhLUOnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 09:43:39 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24F4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 06:43:38 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id j17so13039230qtx.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 06:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=epf+WjKxZfy4MqSd+K2oWsIRS0SOqREyZW9UCHGm1zE=;
        b=luP0qgoHtaxcMvVx9FE00UV5b7nw3rWNVSn3Iu/pdC2HaO5OYr/DhBX6DM+58RSQez
         KhSuQl83dohUUUS3CcJUlRzQulaiqIEPtHi1H74zP4mg3rJ0IcfDKWo6tQQ0wmYeEbVk
         1Gs7ekqd3czZ5LEWB6spHgyjAwKhN/YTYamBlnD1fTA0fSXpNQwZe7xh4m1nimKk3MXt
         TmLTc5wmJ1sNUoqggo3mbRJBWyIZd8NO9tj6Q4HT/LrnCnZQn9uysUEjWqqFYt+zVv16
         PqZqnfVoHUiem5iqoqgaF+3hivIPCvpXdFFGllnbX8BqSQE2y324tuZMEdaW5ef2FoLd
         /Qng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=epf+WjKxZfy4MqSd+K2oWsIRS0SOqREyZW9UCHGm1zE=;
        b=LmFjDQsYNj4s0tKeR8SCYlk2kyGETk/i+9gkLr9bxLzTGjWjYEOndooKnG0RvyuyEB
         BFE0Hj7hrdKVSRqanCeynTRK5FrcZ6s/Fltf37C6dFyT7VE0vHDiSfzbTPzU6ZD1muEi
         s6Qcz7vOWTR6Ca2Q5iVPvN7xxn8WpDLX+KYYZZJ1H3VtPieOCyRfcLaY1lCAUXM4WHOx
         ISxKpmMZBOucK7Baxrc98CSBXVFgO2YgYjpv4eNOpkFUNk3V0NdFfH9uUCu4NvAlyIgB
         hV303ZGSBIk3ExMp0AhLJmme4xcl2TENk/iSrLIai8+g5ZJcRLZaL3cjxOHSlaQASfNm
         mucg==
X-Gm-Message-State: AOAM531+hP/17FJ8cpD47GbIt28c3OI+2nJxghZNfflNP2vR9dcx9sXY
        0ipQIS2g5wBSFlndpOACzD5fThCbvtKuTLdziu6EYw==
X-Google-Smtp-Source: ABdhPJzZx3oD4cz+uBcL4ueqzLXkj2LkNIi95rfYr2IXYKXMIwBh4iAy0eBuo3w5a/XCDbLYXEpG09mZcuuF53WFUqo=
X-Received: by 2002:ac8:7fc5:: with SMTP id b5mr2467950qtk.492.1640097817903;
 Tue, 21 Dec 2021 06:43:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1640036051.git.andreyknvl@google.com> <f7e26047d2fb7b963aebb894a23989cd830265bd.1640036051.git.andreyknvl@google.com>
In-Reply-To: <f7e26047d2fb7b963aebb894a23989cd830265bd.1640036051.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 21 Dec 2021 15:43:01 +0100
Message-ID: <CAG_fn=VUBm7Q74u=U29zn3Ba75PsQNsObqjcH_=14cosGU8bug@mail.gmail.com>
Subject: Re: [PATCH mm v4 35/39] kasan: add kasan.vmalloc command line flag
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 11:02 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Allow disabling vmalloc() tagging for HW_TAGS KASAN via a kasan.vmalloc
> command line switch.
>
> This is a fail-safe switch intended for production systems that enable
> HW_TAGS KASAN. In case vmalloc() tagging ends up having an issue not
> detected during testing but that manifests in production, kasan.vmalloc
> allows to turn vmalloc() tagging off while leaving page_alloc/slab
> tagging on.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> ---
>
> Changes v1->v2:
> - Mark kasan_arg_stacktrace as __initdata instead of __ro_after_init.
> - Combine KASAN_ARG_VMALLOC_DEFAULT and KASAN_ARG_VMALLOC_ON switch
>   cases.
> ---
>  mm/kasan/hw_tags.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
>  mm/kasan/kasan.h   |  6 ++++++
>  2 files changed, 50 insertions(+), 1 deletion(-)
>
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index 99230e666c1b..657b23cebe28 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -32,6 +32,12 @@ enum kasan_arg_mode {
>         KASAN_ARG_MODE_ASYMM,
>  };
>
> +enum kasan_arg_vmalloc {
> +       KASAN_ARG_VMALLOC_DEFAULT,
> +       KASAN_ARG_VMALLOC_OFF,
> +       KASAN_ARG_VMALLOC_ON,
> +};
> +
>  enum kasan_arg_stacktrace {
>         KASAN_ARG_STACKTRACE_DEFAULT,
>         KASAN_ARG_STACKTRACE_OFF,
> @@ -40,6 +46,7 @@ enum kasan_arg_stacktrace {
>
>  static enum kasan_arg kasan_arg __ro_after_init;
>  static enum kasan_arg_mode kasan_arg_mode __ro_after_init;
> +static enum kasan_arg_vmalloc kasan_arg_vmalloc __initdata;
>  static enum kasan_arg_stacktrace kasan_arg_stacktrace __initdata;
>
>  /* Whether KASAN is enabled at all. */
> @@ -50,6 +57,9 @@ EXPORT_SYMBOL(kasan_flag_enabled);
>  enum kasan_mode kasan_mode __ro_after_init;
>  EXPORT_SYMBOL_GPL(kasan_mode);
>
> +/* Whether to enable vmalloc tagging. */
> +DEFINE_STATIC_KEY_FALSE(kasan_flag_vmalloc);
> +
>  /* Whether to collect alloc/free stack traces. */
>  DEFINE_STATIC_KEY_FALSE(kasan_flag_stacktrace);
>
> @@ -89,6 +99,23 @@ static int __init early_kasan_mode(char *arg)
>  }
>  early_param("kasan.mode", early_kasan_mode);
>
> +/* kasan.vmalloc=off/on */
> +static int __init early_kasan_flag_vmalloc(char *arg)
> +{
> +       if (!arg)
> +               return -EINVAL;
> +
> +       if (!strcmp(arg, "off"))
> +               kasan_arg_vmalloc = KASAN_ARG_VMALLOC_OFF;
> +       else if (!strcmp(arg, "on"))
> +               kasan_arg_vmalloc = KASAN_ARG_VMALLOC_ON;
> +       else
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +early_param("kasan.vmalloc", early_kasan_flag_vmalloc);
> +
>  /* kasan.stacktrace=off/on */
>  static int __init early_kasan_flag_stacktrace(char *arg)
>  {
> @@ -172,6 +199,18 @@ void __init kasan_init_hw_tags(void)
>                 break;
>         }
>
> +       switch (kasan_arg_vmalloc) {
> +       case KASAN_ARG_VMALLOC_DEFAULT:
> +               /* Default to enabling vmalloc tagging. */
> +               fallthrough;
> +       case KASAN_ARG_VMALLOC_ON:
> +               static_branch_enable(&kasan_flag_vmalloc);
> +               break;
> +       case KASAN_ARG_VMALLOC_OFF:
> +               /* Do nothing, kasan_flag_vmalloc keeps its default value. */
> +               break;
> +       }

I think we should be setting the default when defining the static key
(e.g. in this case it should be DEFINE_STATIC_KEY_TRUE), so that:
 - the _DEFAULT case is always empty;
 - the _ON case explicitly enables the static branch
 - the _OFF case explicitly disables the branch
This way we'll only need to change DEFINE_STATIC_KEY_TRUE to
DEFINE_STATIC_KEY_FALSE if we want to change the default, but we don't
have to mess up with the rest of the code.
Right now the switch statement is confusing, because the _OFF case
refers to some "default" value, whereas the _DEFAULT one actively
changes the state.

I see that this code is copied from kasan_flag_stacktrace
implementation, and my comment also applies there (but I don't insist
on fixing that one right now).
