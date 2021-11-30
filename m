Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E774636C4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242217AbhK3OhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbhK3OhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:37:12 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E25C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 06:33:52 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id 14so26183162ioe.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 06:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KvFvndBl4Bydux7YEgvSu6yBLgLtvHPAwDkKBUzy3MQ=;
        b=DTpy4LJX5vuS+gtnzgO+ty8a1J2mBtBHacEvP1LZaKaTqkRDxbjFzJI99OAaZwlblU
         iw6pUW5DB/W9iWDF0Me9jj5mlzYr1J0dBOoIo1jVzH91TK4aAm5dCIZxVYZi7AxY67hn
         rJBiUcKmWm/L6g8qzPoZ+eTyDPND6CoPfEed1nSwAEoRwoWEOOmc3e5hU/9hPb/BnNwT
         zwO249C2NX6cb3rHF0JFCtBgXkmeuPOFs8dmi4nYHimvyTQ0X0jxcb6bWh7lrHDlA0Ii
         2KY+nGNL9ug8Ny/6adOjhf2deqTWn7Gklh+KBZ4g3ix/akUO/VRb3NEB1YwjdoftvY2x
         yuhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KvFvndBl4Bydux7YEgvSu6yBLgLtvHPAwDkKBUzy3MQ=;
        b=haqh8oEIrXE+nILDpP9a8f0TaDJ5n8c1hldRCwKMeGKQaGCY7+O4Rwklm4qQgkoW3W
         mfZPkbYe+DK9iibQBLO0RVhh9tgyeiO7WkllpQFGq9Y213OVCTIsrVCmh+A6vFHMFxWC
         Y7+hyLW2HWeQLtNe5o34EGB2AjN3yNS6l5HT23AXv1WeHITA8Lk1gYOF69DUYRcqmD33
         coNONgJSjrHQ1M9C0YZPNvKH6mDkYMaD0kd+Iv5aCjH7qmj2ZryGozlvNV4p/42OosG1
         r9F1DatweeIxwBQLqfRquVPdt8SxcGImTW4ysup4BRoR/gXhErxX0e1aGyRQ7BOY4Ubl
         MZJA==
X-Gm-Message-State: AOAM532ahwmUELs6rC6YYqdvaj2VKBYSlgoYutVpmYN8pv7TbXPsauD0
        g4pVlHAxhfi9k7u6ItqnZ8VF+AZ37pUQHcPwC8I=
X-Google-Smtp-Source: ABdhPJzI7PIJq5HrCfzlxDRzoUVWPYEqe5LkOcdc3MqSXtKmXZp9CsxTy+8jedmlD8Ani/UF1Mfqt8vJbKVG0KUZqGI=
X-Received: by 2002:a05:6638:2257:: with SMTP id m23mr72343928jas.17.1638282832252;
 Tue, 30 Nov 2021 06:33:52 -0800 (PST)
MIME-Version: 1.0
References: <20211130095727.2378739-1-elver@google.com>
In-Reply-To: <20211130095727.2378739-1-elver@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 30 Nov 2021 15:33:41 +0100
Message-ID: <CA+fCnZdO4OqLqUyCJ6YQbpgAOpDk_BQrUBgP87KQmw7qv7zTZQ@mail.gmail.com>
Subject: Re: [PATCH] lib/stackdepot: always do filter_irq_stacks() in stack_depot_save()
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Imran Khan <imran.f.khan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Jani Nikula <jani.nikula@intel.com>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 11:14 AM Marco Elver <elver@google.com> wrote:
>
> The non-interrupt portion of interrupt stack traces before interrupt
> entry is usually arbitrary. Therefore, saving stack traces of interrupts
> (that include entries before interrupt entry) to stack depot leads to
> unbounded stackdepot growth.
>
> As such, use of filter_irq_stacks() is a requirement to ensure
> stackdepot can efficiently deduplicate interrupt stacks.
>
> Looking through all current users of stack_depot_save(), none (except
> KASAN) pass the stack trace through filter_irq_stacks() before passing
> it on to stack_depot_save().
>
> Rather than adding filter_irq_stacks() to all current users of
> stack_depot_save(), it became clear that stack_depot_save() should
> simply do filter_irq_stacks().
>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  lib/stackdepot.c  | 13 +++++++++++++
>  mm/kasan/common.c |  1 -
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index b437ae79aca1..519c7898c7f2 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -305,6 +305,9 @@ EXPORT_SYMBOL_GPL(stack_depot_fetch);
>   * (allocates using GFP flags of @alloc_flags). If @can_alloc is %false, avoids
>   * any allocations and will fail if no space is left to store the stack trace.
>   *
> + * If the stack trace in @entries is from an interrupt, only the portion up to
> + * interrupt entry is saved.
> + *
>   * Context: Any context, but setting @can_alloc to %false is required if
>   *          alloc_pages() cannot be used from the current context. Currently
>   *          this is the case from contexts where neither %GFP_ATOMIC nor
> @@ -323,6 +326,16 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>         unsigned long flags;
>         u32 hash;
>
> +       /*
> +        * If this stack trace is from an interrupt, including anything before
> +        * interrupt entry usually leads to unbounded stackdepot growth.
> +        *
> +        * Because use of filter_irq_stacks() is a requirement to ensure
> +        * stackdepot can efficiently deduplicate interrupt stacks, always
> +        * filter_irq_stacks() to simplify all callers' use of stackdepot.
> +        */
> +       nr_entries = filter_irq_stacks(entries, nr_entries);
> +
>         if (unlikely(nr_entries == 0) || stack_depot_disable)
>                 goto fast_exit;
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 8428da2aaf17..efaa836e5132 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -36,7 +36,6 @@ depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc)
>         unsigned int nr_entries;
>
>         nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
> -       nr_entries = filter_irq_stacks(entries, nr_entries);
>         return __stack_depot_save(entries, nr_entries, flags, can_alloc);
>  }
>
> --
> 2.34.0.rc2.393.gf8c9666880-goog
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
