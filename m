Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C9953FF70
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244228AbiFGMyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242548AbiFGMyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:54:07 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82F56CA85
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:54:05 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id o7so1708284eja.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 05:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7NOMlCyOOzxhbCbuwq3ZJ0vTGpi3XnqAoh4xLB3lmQU=;
        b=kO99fIKDL7qtIqBbuxvxvhMhbQfe59GBQb1vhmNeL0sEIa99mujKCOsr9wfhhngxXv
         OwjoGk/cCLVGGGPWCNUqHoWNBrhfExW6eb/6ixYRX82RWuCvN8/aeqZpjw/aKMJLfBG8
         /LNoym75s/DLbaBpkLawwx0ocrnQjQjjdfrdSHH14TaPRLCq8f8kCvfwWweQjycRwZ5h
         R+IimHKKAXKXvpJUo0F7a7MyWaB/SmS+MxherhonEQ0ODXyZWSXTTQBxPZ4dK1plHcBO
         vlkhd3/x5qVaAIu5/Ch6v9vKGffn2DSpz0z2WkSKNtPpgeJ5olRYkhxINBsO3vBBiV4q
         Vv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7NOMlCyOOzxhbCbuwq3ZJ0vTGpi3XnqAoh4xLB3lmQU=;
        b=ioa0DxnPQX7W70En7UdWUXgrgk4WhiptLw5K/zrzx+FJa+EOPMbIfIeDIceQiNf7V7
         ZEgS6I9jLnZeVHUQJRNJ7BXeGzh8XoGCK+C36FX2gzJGG5GsSWOpfxzs/EcvYrjAOpCa
         jxzsL2D7cA5i6lwazlf188qao+o9HH8PQ2lW/4DWHmuYX7JBesNh4qjS75KL7mDx2y40
         JMYQJUn6vKbugMFfYQLa+AwdvbveIHX+1v2EiQTbQlP+Ab6LLi+iFNRolwk0lPrLENzN
         xRoBytYD9yqj1gET6mxJLjP4Stc6KRAx3f6yle3DyBRF2iSWGdtlGrKCDOSOgS+hcCuD
         2nYw==
X-Gm-Message-State: AOAM533fU8xcD78XCYTx63nBlSNJF7n1ESUekPZfsWoBuCCrR10uHfoz
        zjf6XYeJF54Ybs5wGFjgFlMRZThxorTFo0VEyKs=
X-Google-Smtp-Source: ABdhPJxQN01lGZphXqLlwP/JB31yWjBQPvrSqFT6IzA0+0422NzSBqsqEmeaZGhOtCNCUoWk4FLXTBxtPL+uUtKCw6I=
X-Received: by 2002:a17:906:74b:b0:710:e677:1383 with SMTP id
 z11-20020a170906074b00b00710e6771383mr15248400ejb.444.1654606444227; Tue, 07
 Jun 2022 05:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220607105958.382076-1-bhe@redhat.com> <20220607105958.382076-2-bhe@redhat.com>
In-Reply-To: <20220607105958.382076-2-bhe@redhat.com>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Tue, 7 Jun 2022 14:53:52 +0200
Message-ID: <CA+KHdyVMh-yWJaWc+9o0DhP8TG9Nvua6EywRAwEJjqfTgDXAJQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm/vmalloc: invoke classify_va_fit_type() in adjust_va_to_fit_type()
To:     Baoquan He <bhe@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> In function adjust_va_to_fit_type(), it checks all values of passed
> in fit type, including NOTHING_FIT in the else branch. However, the
> check of NOTHING_FIT has been done inside adjust_va_to_fit_type() and
> before it's called in all call sites.
>
> In fact, both of these two functions are coupled tightly, since
> classify_va_fit_type() is doing the preparation work for
> adjust_va_to_fit_type(). So putting invocation of classify_va_fit_type()
> inside adjust_va_to_fit_type() can simplify code logic and the redundant
> check of NOTHING_FIT issue will go away.
>
> Suggested-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/vmalloc.c | 23 ++++++-----------------
>  1 file changed, 6 insertions(+), 17 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 07db42455dd4..f9d45aa90b7c 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1335,10 +1335,10 @@ classify_va_fit_type(struct vmap_area *va,
>
>  static __always_inline int
>  adjust_va_to_fit_type(struct vmap_area *va,
> -       unsigned long nva_start_addr, unsigned long size,
> -       enum fit_type type)
> +       unsigned long nva_start_addr, unsigned long size)
>  {
>         struct vmap_area *lva = NULL;
> +       enum fit_type type = classify_va_fit_type(va, nva_start_addr, size);
>
>         if (type == FL_FIT_TYPE) {
>                 /*
> @@ -1444,7 +1444,6 @@ __alloc_vmap_area(unsigned long size, unsigned long align,
>         bool adjust_search_size = true;
>         unsigned long nva_start_addr;
>         struct vmap_area *va;
> -       enum fit_type type;
>         int ret;
>
>         /*
> @@ -1472,14 +1471,9 @@ __alloc_vmap_area(unsigned long size, unsigned long align,
>         if (nva_start_addr + size > vend)
>                 return vend;
>
> -       /* Classify what we have found. */
> -       type = classify_va_fit_type(va, nva_start_addr, size);
> -       if (WARN_ON_ONCE(type == NOTHING_FIT))
> -               return vend;
> -
>         /* Update the free vmap_area. */
> -       ret = adjust_va_to_fit_type(va, nva_start_addr, size, type);
> -       if (ret)
> +       ret = adjust_va_to_fit_type(va, nva_start_addr, size);
> +       if (WARN_ON_ONCE(ret))
>                 return vend;
>
>  #if DEBUG_AUGMENT_LOWEST_MATCH_CHECK
> @@ -3735,7 +3729,6 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
>         int area, area2, last_area, term_area;
>         unsigned long base, start, size, end, last_end, orig_start, orig_end;
>         bool purged = false;
> -       enum fit_type type;
>
>         /* verify parameters and allocate data structures */
>         BUG_ON(offset_in_page(align) || !is_power_of_2(align));
> @@ -3846,15 +3839,11 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
>                         /* It is a BUG(), but trigger recovery instead. */
>                         goto recovery;
>
> -               type = classify_va_fit_type(va, start, size);
> -               if (WARN_ON_ONCE(type == NOTHING_FIT))
> +               ret = adjust_va_to_fit_type(va, start, size);
> +               if (WARN_ON_ONCE(unlikely(ret)))
>                         /* It is a BUG(), but trigger recovery instead. */
>                         goto recovery;
>
> -               ret = adjust_va_to_fit_type(va, start, size, type);
> -               if (unlikely(ret))
> -                       goto recovery;
> -
>                 /* Allocated area. */
>                 va = vas[area];
>                 va->va_start = start;
> --
> 2.34.1
>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

-- 
Uladzislau Rezki
