Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7525149874B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244277AbiAXRyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244437AbiAXRyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:54:38 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205D1C06173B;
        Mon, 24 Jan 2022 09:54:38 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id r15so14554309ilj.7;
        Mon, 24 Jan 2022 09:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v3YviFAQ/40r1Ln+w4BlMxkBPCxENdD7r0D/7v9ETwo=;
        b=dWoGsnVbWXxYZrsoyRM4jqwgPH9tlliG+bskmwwLky9K61904rvDw4ff/Y0EXFBm1W
         nqabQyNDPO5FqYFCMVQZRWMfJeXuWn/k69QV4RxH8Ii4Fn8I2lJsTrk681VjkePLs5WY
         rVYsdSkowmEbcuPmbMzKFFT9EvTJi77N7epzNQax3NnQhuT7c5xIfv40tBWrIVzL5ifa
         788H3IGZpHjsn9YuPREbV/XU8E5siypl6FHQ0iYDQChGBGz3fNlELG1n0j4q4+TZmWk7
         lskk0jV2J18Ztm/tu/IB6fWUf9Ff+G8LnNq21o+eOdHXml4BThTcox6PNCDA5lJKsQhT
         S/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v3YviFAQ/40r1Ln+w4BlMxkBPCxENdD7r0D/7v9ETwo=;
        b=fuMC/4j4/VkjzTmbfFGk3JwpfM/E+SghbzbZW6Tzz4t7TzICelxtX0Uzp/cH06utLY
         vDfHqKSFLnzEThANny7OaFJMe2xjLIaVr5ymDxyi0ve7NTJUFh6CePUu20obVMmmXl4y
         XjXItwHX8ElPgoNhQZiIewPLmJDhRrZJRPHeRuhYQwnmF68gQmbscx0NuvvTkYzZY8pi
         ge+GrmA/GpLgJ8YitVWw5oyKaCmgZAA2FxsUODdd8Ihyq7MGRhJKLTTuMaAGOdVgXE6v
         pNvnCCbMYZoDz3PrJSDo6FWEdSsPC/cRPZ0hdx7yydQOxqE/W7HGYkbP6DDewO2W0Lqs
         38KQ==
X-Gm-Message-State: AOAM531JcSRHvDDXbsYracQg4Vq+5NnMpoZKTPk8V9UgqJAjfbUiM5RH
        vp3K8yXBwnWetGoaxR7fkiTsW0XCdfDjsBQK67hMMHlSCjg=
X-Google-Smtp-Source: ABdhPJysOYoTc4Ltu0dYW29wGEgvxAwalCuXafYeH1tLPI1C1zlPZNNpjzs+IsMamsYtNilhMnqNb0qGWRiYo2s3MVY=
X-Received: by 2002:a05:6e02:1568:: with SMTP id k8mr7648938ilu.235.1643046877495;
 Mon, 24 Jan 2022 09:54:37 -0800 (PST)
MIME-Version: 1.0
References: <20220124160744.1244685-1-elver@google.com>
In-Reply-To: <20220124160744.1244685-1-elver@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 24 Jan 2022 18:54:26 +0100
Message-ID: <CA+fCnZd9fhv0RShoSF5xStQZuXFC2DGv8JQpthffdm6qVA2D3w@mail.gmail.com>
Subject: Re: [PATCH] kasan: test: fix compatibility with FORTIFY_SOURCE
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Kees Cook <keescook@chromium.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-hardening@vger.kernel.org, Nico Pache <npache@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 -On Mon, Jan 24, 2022 at 5:07 PM Marco Elver <elver@google.com> wrote:
>
> With CONFIG_FORTIFY_SOURCE enabled, string functions will also perform
> dynamic checks using __builtin_object_size(ptr), which when failed will
> panic the kernel.
>
> Because the KASAN test deliberately performs out-of-bounds operations,
> the kernel panics with FORITY_SOURCE, for example:

Nit: FORITY_SOURCE -> FORTIFY_SOURCE

>
>  | kernel BUG at lib/string_helpers.c:910!
>  | invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
>  | CPU: 1 PID: 137 Comm: kunit_try_catch Tainted: G    B             5.16.0-rc3+ #3
>  | Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
>  | RIP: 0010:fortify_panic+0x19/0x1b
>  | ...
>  | Call Trace:
>  |  <TASK>
>  |  kmalloc_oob_in_memset.cold+0x16/0x16
>  |  ...
>
> Fix it by also hiding `ptr` from the optimizer, which will ensure that
> __builtin_object_size() does not return a valid size, preventing
> fortified string functions from panicking.
>
> Reported-by: Nico Pache <npache@redhat.com>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  lib/test_kasan.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 847cdbefab46..26a5c9007653 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -492,6 +492,7 @@ static void kmalloc_oob_in_memset(struct kunit *test)
>         ptr = kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> +       OPTIMIZER_HIDE_VAR(ptr);
>         OPTIMIZER_HIDE_VAR(size);
>         KUNIT_EXPECT_KASAN_FAIL(test,
>                                 memset(ptr, 0, size + KASAN_GRANULE_SIZE));
> @@ -515,6 +516,7 @@ static void kmalloc_memmove_negative_size(struct kunit *test)
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
>         memset((char *)ptr, 0, 64);
> +       OPTIMIZER_HIDE_VAR(ptr);
>         OPTIMIZER_HIDE_VAR(invalid_size);
>         KUNIT_EXPECT_KASAN_FAIL(test,
>                 memmove((char *)ptr, (char *)ptr + 4, invalid_size));
> @@ -531,6 +533,7 @@ static void kmalloc_memmove_invalid_size(struct kunit *test)
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
>         memset((char *)ptr, 0, 64);
> +       OPTIMIZER_HIDE_VAR(ptr);
>         KUNIT_EXPECT_KASAN_FAIL(test,
>                 memmove((char *)ptr, (char *)ptr + 4, invalid_size));
>         kfree(ptr);
> @@ -893,6 +896,7 @@ static void kasan_memchr(struct kunit *test)
>         ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> +       OPTIMIZER_HIDE_VAR(ptr);
>         OPTIMIZER_HIDE_VAR(size);
>         KUNIT_EXPECT_KASAN_FAIL(test,
>                 kasan_ptr_result = memchr(ptr, '1', size + 1));
> @@ -919,6 +923,7 @@ static void kasan_memcmp(struct kunit *test)
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>         memset(arr, 0, sizeof(arr));
>
> +       OPTIMIZER_HIDE_VAR(ptr);
>         OPTIMIZER_HIDE_VAR(size);
>         KUNIT_EXPECT_KASAN_FAIL(test,
>                 kasan_int_result = memcmp(ptr, arr, size+1));
> --
> 2.35.0.rc0.227.g00780c9af4-goog
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
