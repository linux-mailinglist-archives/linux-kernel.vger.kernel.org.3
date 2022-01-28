Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB51549F8C4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 12:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348252AbiA1LwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 06:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244520AbiA1LwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:52:23 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC05C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 03:52:23 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id n6-20020a9d6f06000000b005a0750019a7so5456606otq.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 03:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O60yGiuWnnbcMYfMLAv37vqkxweJf6XzlR6Lpk0bdI0=;
        b=P6xylPxu3oTF9ElqWG2+KKyUYq5JMNnqiPQRZUeDXqQie4aQmyPakvGVQD017+Sq5j
         w8WBVC0gRu5xZKxAFyYY2+ykLjSZ+O71IYW2FlMwViM/WIiwXp03lW9R8sZe5cCUlKfy
         P8c6ut1lo3vrggu9qgXKs1LoMnKbJoy9NFW8ZJeXZvE7GKCnAU39YhigoMzswo9cVR6f
         AN7r7VuDpulWZS82z9ushmAgLKUGp/8dAFq31IbINk/a43TB8V/KRTywy/HtecTt4Qt6
         nXeKqrtg9ysDBm4AJvx3Q87lxFKbMQc4SIwbwvGxp8+ia4JOg/O1GYhE3VU8wXtXX1j4
         VPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O60yGiuWnnbcMYfMLAv37vqkxweJf6XzlR6Lpk0bdI0=;
        b=rYUg97z1aRCv7D7TOEoMjAHl0NDh2lDwCR0qQmAZE4qIx4WJa49s8QV0cQnehCLkGB
         i4xyy8UdBYI1dS+7uDGAR/FoO8OYW7TbnpKEIiOcZI1+dTf3MyubSW5Naz+WfkXhjxfW
         an6Oxod+IEOQn4aY6VqCLKJr+HQJgYUzI0qy+IBN9gglV2gdyUtFrzbiCwJiNFpLNpj2
         Yx220+aYdAEUJQXSc8QnDUZ/RbrWm9rfCZglkVwn3uZ11bojZy1yD8o4C7idh3bdJQtw
         267ss9BGSLDk4bTjmmbazL8/Rio6ooA+dXPqGsYBvEpml67zyzcO3USjz5YC+Lc8zUoK
         35fw==
X-Gm-Message-State: AOAM531y0Ws9+AllNAB4UIxTwUX4xs38v7tFXuFFNwiTgcNIuG6Sv7bU
        uE83TMRWIMOaWuWxxsQ1LrAbSMJy60BGDgG8EKQlfw==
X-Google-Smtp-Source: ABdhPJxFKUeb+z6L0PRMViTxwQseod5Vc2HUsrALgKw44oNXB9A/OsmkbGwTROjG05J4k1ROmFYME63G71BRWJvmWSU=
X-Received: by 2002:a05:6830:25d5:: with SMTP id d21mr3350658otu.246.1643370742236;
 Fri, 28 Jan 2022 03:52:22 -0800 (PST)
MIME-Version: 1.0
References: <1643370145-26831-1-git-send-email-yangtiezhu@loongson.cn> <1643370145-26831-5-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1643370145-26831-5-git-send-email-yangtiezhu@loongson.cn>
From:   Marco Elver <elver@google.com>
Date:   Fri, 28 Jan 2022 12:52:10 +0100
Message-ID: <CANpmjNPYYAy2jy_U_c7QjTsco6f1Hk2q=HP34di4YRMgdKsa+g@mail.gmail.com>
Subject: Re: [PATCH 4/5] sched: unset panic_on_warn before calling panic()
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2022 at 12:42, Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> As done in the full WARN() handler, panic_on_warn needs to be cleared
> before calling panic() to avoid recursive panics.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  kernel/sched/core.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 848eaa0..f5b0886 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5524,8 +5524,17 @@ static noinline void __schedule_bug(struct task_struct *prev)
>                 pr_err("Preemption disabled at:");
>                 print_ip_sym(KERN_ERR, preempt_disable_ip);
>         }
> -       if (panic_on_warn)
> +
> +       if (panic_on_warn) {
> +               /*
> +                * This thread may hit another WARN() in the panic path.
> +                * Resetting this prevents additional WARN() from panicking the
> +                * system on this thread.  Other threads are blocked by the
> +                * panic_mutex in panic().
> +                */
> +               panic_on_warn = 0;
>                 panic("scheduling while atomic\n");

I agree this is worth fixing.

But: Why can't the "panic_on_warn = 0" just be moved inside panic(),
instead of copy-pasting this all over the place?

I may be missing something obvious why this hasn't been done before...

Thanks,
-- Marco
