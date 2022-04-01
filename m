Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EA64EEAB5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 11:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344755AbiDAJsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 05:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344725AbiDAJsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 05:48:50 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E0026B399
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 02:47:01 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2e64a6b20eeso26642007b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 02:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GAYB7YHwkTinDw7E1Hr055TsYKSrU9cTtU3idS1nwFE=;
        b=T7TFO+XXJNRV6magk4KPRqHtgWPszHdyFBawap8mmDRpZQfcZqDlupwIvwwexFyXSJ
         BvNrViFBSbXPbkSPpw1/B3T9YHBEvUUr/8xAYh7JjR+TUBi/DHPSEnOn/tbCx3Jg2K5p
         XQRmVFqwPJRQ+EKvsdyP41cTWtdGjyJe45yX5wJjuY85t38tH9yRXa+yT+8/lqcoi44N
         7M/Ccre6sBRqYh4rAuEgRuBM7eViN82F+6vFRKIYJmoauDHtzlA7Hj+ojHi51jSf9K5o
         xN++pgLJhECEFLBDf1FzyTzmSDOXenq1BEeAU6Liq/7aJvSdlhFYgtpNZ3gguA+APqsz
         cfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GAYB7YHwkTinDw7E1Hr055TsYKSrU9cTtU3idS1nwFE=;
        b=X1bNJmCjH16YUhYb/GyoGEc2kqUgULUBj+lg5ViH6Km8JanBvtTkEHUsCo07KAQAAC
         /kMAQkAK8mN0R401toQIaIFRLGRGUzW1F9MLxRv8Q7YlfastAQ/gdiHtpldPNIV8WgrH
         BR4y/GxLD+gfqltAiDaWERuzWQFri0zqviwS/y2dv51wSm+ft+EfyzRED/h3WT/tLtAt
         hYDK9c5A7/DLGJlZSNvaEqlGd9YK0RGQjnNdpGwH7AUozssHFk+Fp5Z3a2eg7m4L2Q3c
         14KKk94EpkVXeqDbWXcmRV0BpYbgqIsH4Njk6THCulymY0t74w76uX4VabfCITk8HLOT
         fppA==
X-Gm-Message-State: AOAM533584ZgqjtbHkXj5U9AyTZcAfN+zm8DfMQ+Ehe1nzMezSRnc0C3
        xBlO2YehzycRonMu8RjgPTJK/i8FkmcBUAtUY9uztA==
X-Google-Smtp-Source: ABdhPJx/jKPikl4GfrIg4T3A7vPOTssiwcfuqoQuqq/ArA/daD1Xd6c4VHqAMRBs+NmYysldNlTvSIYZsoUag8B+UiE=
X-Received: by 2002:a0d:c306:0:b0:2e5:96ab:592e with SMTP id
 f6-20020a0dc306000000b002e596ab592emr9300635ywd.316.1648806420888; Fri, 01
 Apr 2022 02:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220401084333.85616-1-nogikh@google.com>
In-Reply-To: <20220401084333.85616-1-nogikh@google.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 1 Apr 2022 11:46:24 +0200
Message-ID: <CANpmjNO=qjoY+8m9Nf-8vanFZTgsiDwfchv_JsLoksFKwU98BQ@mail.gmail.com>
Subject: Re: [PATCH v2] kcov: don't generate a warning on vm_insert_page()'s failure
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, dvyukov@google.com,
        andreyknvl@gmail.com, glider@google.com, tarasmadan@google.com,
        bigeasy@linutronix.de
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

On Fri, 1 Apr 2022 at 10:43, Aleksandr Nogikh <nogikh@google.com> wrote:
>
> vm_insert_page()'s failure is not an unexpected condition, so don't do
> WARN_ONCE() in such a case.
>
> Instead, print a kernel message and just return an error code.
>
> Signed-off-by: Aleksandr Nogikh <nogikh@google.com>

Acked-by: Marco Elver <elver@google.com>


Just minor "process" comments:
1) There should be a '---' so that the below doesn't appear in the
commit message on 'git am' and maintainers don't have to manually
remove it.

> PATCH v2:
> * Added a newline at the end of pr_warn_once().
>
> PATCH v1: https://lkml.org/lkml/2022/3/31/909

2) We should use lore permalinks, because lkml.org isn't official and
was actually down most of this week. v1 was
https://lore.kernel.org/all/20220331180501.4130549-1-nogikh@google.com/

> ---
>  kernel/kcov.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index 475524bd900a..b3732b210593 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -475,8 +475,11 @@ static int kcov_mmap(struct file *filep, struct vm_area_struct *vma)
>         vma->vm_flags |= VM_DONTEXPAND;
>         for (off = 0; off < size; off += PAGE_SIZE) {
>                 page = vmalloc_to_page(kcov->area + off);
> -               if (vm_insert_page(vma, vma->vm_start + off, page))
> -                       WARN_ONCE(1, "vm_insert_page() failed");
> +               res = vm_insert_page(vma, vma->vm_start + off, page);
> +               if (res) {
> +                       pr_warn_once("kcov: vm_insert_page() failed\n");
> +                       return res;
> +               }
>         }
>         return 0;
>  exit:
> --
> 2.35.1.1094.g7c7d902a7c-goog
>
