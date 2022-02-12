Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42A44B32F8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 05:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiBLE1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 23:27:24 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiBLE1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 23:27:21 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D85E22B15
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 20:27:19 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id p5so30349801ybd.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 20:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DfQm6EEcsSkwyy63qL81Cd+ZyuEaHmK7nTBsAbZcXyA=;
        b=N/U6SUGgLU0tWcghD0vaA+qEFiL9RTFNdgbmxNjeyYV1uI6e4VfKjse2slU+uYzuaY
         onfplrXVmoZieT69Bj1Y7WBbbn9WE+9UjAP2LTrxQ4FXEZ+DJWJ5XbuFIJjbCD+8wPPi
         gLNI7478a4sCyxGpQmscGV/xbNpwSyAdllatujRSXVFGC9GUtQMpcylkgmEutE33LyuD
         1loKz9awPt1Y26EHtyWFam9tPYy1EknSoVJvytY9wJDG7bWbKmZbBVGWkfJ6cn25z2Cr
         tDwJA0l5NizNW9lN3R92ucC/XqnrzPkURBps8Pk7Xf5epsBxR0DVI2OoeYq1Se3pJ0r4
         UUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DfQm6EEcsSkwyy63qL81Cd+ZyuEaHmK7nTBsAbZcXyA=;
        b=upYnmj3KAmVjOs9ikgOHHsiS/KIXvXZ+sByT9X0OJ5MGD/S/uXrR+lbcKTq8Va5WEB
         94puA3KVC9LyD/XBRxs1DJs5ZhHU/ZW4rf0uNmKb1YLctTljA0lmNp+7kHCogtfE4eOL
         Ucxu1IB0KJujDr3H0dQj02EA8KDXdyzUQirGO6QwCe3Ub3gLl54jJUCAJuTs2FZPphsv
         LtxZmBu5E7YOphHgjdX+tG6NV81VJhl6RCNje8l3nw64XKKZR5nhEMniel3SNWBKm377
         pUQxN2C0ii0oeDiUgFLZe8O1b2b7HaxovsC0kbFMPq58cb+KmBVj13meJQc6897FZ4KC
         t2cw==
X-Gm-Message-State: AOAM531R3CCtnpQ696jFRK6G7QZS9Ix1GlslwLMvdrN6ca4bXuxaOWcR
        pvwnwvv3QAgm1vcuLKNAtEt4WKNXTB72048/g6Hcf/voer4wgg==
X-Google-Smtp-Source: ABdhPJwnVcqj2bnnlrVz0TB871Ta9JaGYSq8R4qZprEgvBVL41IXJsopEMqTiZY9h7f1L56RO+dopNhnzX3XJUJn9uU=
X-Received: by 2002:a81:4528:: with SMTP id s40mr5276837ywa.188.1644640038788;
 Fri, 11 Feb 2022 20:27:18 -0800 (PST)
MIME-Version: 1.0
References: <20220209093700.30901-1-nunes.erico@gmail.com>
In-Reply-To: <20220209093700.30901-1-nunes.erico@gmail.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Sat, 12 Feb 2022 12:27:07 +0800
Message-ID: <CAKGbVbt2nxYQahrryGkU5RMwB81xqBLUtE9q8b4bxKpKHf5zPw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/lima: avoid error task dump attempt when not enabled
To:     Erico Nunes <nunes.erico@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, lima@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to drm-misc-next.

On Wed, Feb 9, 2022 at 5:37 PM Erico Nunes <nunes.erico@gmail.com> wrote:
>
> Currently when users try to run an application with lima and that hits
> an issue such as a timeout, a message saying "fail to save task state"
> and "error task list is full" is shown in dmesg.
>
> The error task dump is a debug feature disabled by default, so the
> error task list is usually not going to be available at all.
> The message can be misleading and creates confusion in bug reports.
>
> We can avoid that code path and that particular message when the user
> has not explicitly set the max_error_tasks parameter to enable the
> feature.
>
> Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
> Reviewed-by: Qiang Yu <yuq825@gmail.com>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> v2:
> - collect review tags
> - update summary line to "drm/lima:"
> ---
>  drivers/gpu/drm/lima/lima_sched.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
> index 5612d73f238f..12437e42cc76 100644
> --- a/drivers/gpu/drm/lima/lima_sched.c
> +++ b/drivers/gpu/drm/lima/lima_sched.c
> @@ -409,7 +409,8 @@ static enum drm_gpu_sched_stat lima_sched_timedout_job(struct drm_sched_job *job
>
>         drm_sched_increase_karma(&task->base);
>
> -       lima_sched_build_error_task_list(task);
> +       if (lima_max_error_tasks)
> +               lima_sched_build_error_task_list(task);
>
>         pipe->task_error(pipe);
>
> --
> 2.34.1
>
