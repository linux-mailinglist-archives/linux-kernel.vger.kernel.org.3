Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412EB4B850F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 11:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbiBPJ7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:59:33 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbiBPJ7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:59:31 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FA6265136
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:59:19 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id p5so4302615ybd.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g6yc0CzjhZvL8asvAOjVxpZRVzWjAV26MMR3ayD0Jss=;
        b=XGdkv5sh7wesUFoBMJy2j3M0ZGke0f+k0scopU8aYxlvCwi4vR/FyE53oliA3nse3E
         GsEQ2lf4rd2ykfkXR34DrqI2ga7koqk5dbsQuGeuH7cfUy4adGZqDjSF3dPD0ex7Uwzi
         DM9zTFb60MwwHYDFxNhz7o/AH6f226Pms31VGM5NbXsno/58svkXLg73g0cnzKXY7KCi
         KUQwn8q07xqK1RpieHRGRmyz7zDGH/5/T9Rf1sT/D7sJXvytIMv6oUjLJCCu0dUYNu4A
         GOgq+VSjs6Eat5SoNAhgOqF664kfJ/lRXA+T7/mtIrz+MWugKBILKg2OzeWPdTaHa1nn
         HGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g6yc0CzjhZvL8asvAOjVxpZRVzWjAV26MMR3ayD0Jss=;
        b=kBJ7em2DkuN0EnaaCTuY3ydaSeCBCOag+6FOekMShfnQTwGQ6DKXgDZhcZ64pGronv
         5J+lsknqcBKucMq+0d4yEmdblDYNwz9tXS6sP1IYRt9/5NsU3In1j3JMqS1ZuuWPsg2k
         D08tcZ6pEXru7ss1TnrWtj/jyXwLoftINPxHKqEO9NebfTU355rW5pIaRMKM9VnrOUFE
         /2/SSP6Lg76yeUHM18quLvxmrgCzd0vzjwixm+WNZFtnUBgXFQw/I75lSQ1JbjZC1ECa
         VvzXi+hgGNiH/i69fvgDRpJvTywws/O7RwJi9CHe6ETd2j/+KRQL6SkfcvHwXfDo9IZI
         MG7w==
X-Gm-Message-State: AOAM5326GBM14pcgLY5jKcqHh20pi4MhHvw6E8FH6QIR7U+Onya9oGOY
        ITLlI2ABrk8VnoF6Lz0Ay0ivSc1DFWMc3IvKdJoJiA==
X-Google-Smtp-Source: ABdhPJwU2OW7Do06toZ0xEFJUCUVefzB/0WZylYASkRpbaMU0drvCjN+jE7XQsJzmZgcUW8m27rMfk57hP+0LQAV3nA=
X-Received: by 2002:a0d:ee41:0:b0:2d2:f0aa:d3ba with SMTP id
 x62-20020a0dee41000000b002d2f0aad3bamr1771660ywe.512.1645005558266; Wed, 16
 Feb 2022 01:59:18 -0800 (PST)
MIME-Version: 1.0
References: <f50c5f96ef896d7936192c888b0c0a7674e33184.1644943792.git.andreyknvl@google.com>
In-Reply-To: <f50c5f96ef896d7936192c888b0c0a7674e33184.1644943792.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 16 Feb 2022 10:59:06 +0100
Message-ID: <CANpmjNPG2wP9xiGDJboMJzf-YD+skOO532O+bKkAz+tpvDsF=g@mail.gmail.com>
Subject: Re: [PATCH mm] fix for "kasan, fork: reset pointer tags of vmapped stacks"
To:     andrey.konovalov@linux.dev
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
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

On Tue, 15 Feb 2022 at 17:52, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> That patch didn't update the case when a stack is retrived from
> cached_stacks in alloc_thread_stack_node(). As cached_stacks stores
> vm_structs and not stack pointers themselves, the pointer tag needs
> to be reset there as well.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

Did the test catch this? If not, can this be tested?

> ---
>  kernel/fork.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 57d624f05182..5e3ad2e7a756 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -226,15 +226,17 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
>                 if (!s)
>                         continue;
>
> -               /* Mark stack accessible for KASAN. */
> +               /* Reset stack metadata. */
>                 kasan_unpoison_range(s->addr, THREAD_SIZE);
>
> +               stack = kasan_reset_tag(s->addr);
> +
>                 /* Clear stale pointers from reused stack. */
> -               memset(s->addr, 0, THREAD_SIZE);
> +               memset(stack, 0, THREAD_SIZE);
>
>                 tsk->stack_vm_area = s;
> -               tsk->stack = s->addr;
> -               return s->addr;
> +               tsk->stack = stack;
> +               return stack;
>         }
>
>         /*
> --
> 2.25.1
>
