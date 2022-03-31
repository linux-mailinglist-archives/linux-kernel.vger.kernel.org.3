Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130084EE02B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 20:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbiCaSLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 14:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiCaSLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 14:11:30 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C26654F89
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 11:09:42 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id e203so789303ybc.12
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 11:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v9BQfqx+QR/8GDRGh/dAUoF4sFhZTDX8u5cvw9HwmsI=;
        b=YTYC2EbqeAY1YZNs8TgmTRl+kr6Pm5pI67XwcxyaDL/9OsDAv19wTHVy+R+o6kXEtd
         C4HCEundNKoKUVTBMrn4Cg6DFKPwXA0ZUXcWZJ7ZutAsKspQqY/B3oKeACM87WmVp7xm
         xsuWhe94GXMFFFyh5PJkFtYH9DU8RJh9W3JQwnW9cMgG5+sO8mmPztmJcdG7d1kVGuJR
         yr7m4s1p0o3HlFja5uWhuuyI5tRTmCstvNcgNLXDSRQx/+5bJUXSdhnKWttb5bJ5x17v
         CwM/XW+zoK7beRYTSWbC7VHC8jKxEHZmZPm3eL6YWbFj/PvyHMREibYC8SGC32tY8vf5
         wNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v9BQfqx+QR/8GDRGh/dAUoF4sFhZTDX8u5cvw9HwmsI=;
        b=J25Fk4KKLJ6zfhaBYW1RLbOHIGWFVEqGiXcPhSt6dVR4jox2YLi0dVlak+T9h3QWTK
         yYuMxUxm/DTXyFC1RqM6elwWPtCP+6Szgfg3y0ReLcZC3C+vy14+ChcvAdjWevY3byfl
         ccpHJr97IL0rLeBP+ytmfEEs9eCVMR4qR695sTY1Xua11vBkZl2Uof/zrdadXukNPdH+
         lpwvqNwxYaT9WS3xhxmhzM32zVVliJpilIaQ2q8BsR1umKvIHojQgGTPpFOlYI9ASPWH
         R043sNc8cPaiDW8JteiBlKRuLmFSIDRHnkeaYnPIJ9mjNOUY0P9HXTJFcS4nG7kbUr5Q
         rIcw==
X-Gm-Message-State: AOAM5320WnWiwKEZHiACUSEJzOLjTPS2c5s2FDi2gpzDSy6pvDV85zcx
        IxFvGQPg33NFlkMgeP7VfdA1CmggCHiwOan5KeK1tQ==
X-Google-Smtp-Source: ABdhPJw1UulaD3jXz0tBcoNQUoS8U/7SHhtulmw9uZD59qR9Zw7+7Vv3/v131MYfdMdYK+kGrTlUR1ovozmNsvzV2Mg=
X-Received: by 2002:a25:9b89:0:b0:63d:20e4:13e7 with SMTP id
 v9-20020a259b89000000b0063d20e413e7mr5362323ybo.168.1648750181427; Thu, 31
 Mar 2022 11:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220331180501.4130549-1-nogikh@google.com>
In-Reply-To: <20220331180501.4130549-1-nogikh@google.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 31 Mar 2022 20:09:05 +0200
Message-ID: <CANpmjNMcjocJfA_8Qmg+Vx2FBQ7+m8JUXdQm4aAj-zeb4B35Kw@mail.gmail.com>
Subject: Re: [PATCH] kcov: don't generate a warning on vm_insert_page()'s failure
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

On Thu, 31 Mar 2022 at 20:05, Aleksandr Nogikh <nogikh@google.com> wrote:
>
> vm_insert_page()'s failure is not an unexpected condition, so don't do
> WARN_ONCE() in such a case.
>
> Instead, print a kernel message and just return an error code.
>
> Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
> ---
>  kernel/kcov.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index 475524bd900a..961536a03127 100644
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
> +                       pr_warn_once("kcov: vm_insert_page() failed");

pr_*() should be terminated by "\n" -- sorry, I missed this.

> +                       return res;
> +               }
>         }
>         return 0;
>  exit:
> --
> 2.35.1.1094.g7c7d902a7c-goog
>
