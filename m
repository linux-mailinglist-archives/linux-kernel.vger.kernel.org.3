Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8C04AB30C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 02:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243541AbiBGBTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 20:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiBGBS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 20:18:58 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77953C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 17:18:57 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id c6so35640495ybk.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 17:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wF7wLYknrAguQRg8tSTIkfoRb2Q1jL2Myx81XhHaTX0=;
        b=boKjz6VniFotg9L1M4r51qKoS+gj2GSrZLEftSekUQtk9xP8ZLl1pFCkxQZldC/GE0
         D7ODLMupOoMZT5VDL664MHe1Pz/iQI7YI00lTwySRG+msmoV0+qBFundg3Gj7hadxC1T
         VwLYyCa9mOqzy7ZjjLJ+c1MjFCKVT+wa04wdbNwkRwvTMZvDw9+Kt2oYf7o+FC5EIxVL
         Zp3oYPE3y8dc+kOyDVmQXpyw6/31cYOkNn+Y6mFprWIwwUvLeL3ec/Sx+st0CcPMZp0R
         lLMxuzNRMsGWe5ZQlA1gujF267zV9ix6QPNEHLmacr3zxcZURPTbBMmYlVRLRzcW1U56
         e6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wF7wLYknrAguQRg8tSTIkfoRb2Q1jL2Myx81XhHaTX0=;
        b=oKiWwFhuFnaRiO1kjFb4IaFnPp74wCiHDqxVo31aYCa/x9yW53jaoZemMZ/Ytsy1xU
         i7ppC6XDSMB5MIf78I7EjTAdfSkv99Pq2/GuZJ44d4J0F79Kkc6EZzKeH8PNco+BlNs5
         HBgmjZ9CduZDA8m8JRqR0p0Gufe+2uVzTiW8Nr64iBfSQUSJ7Fgm8GCKOWN0URa7PVBJ
         LvgBcH32sZIhddpwrar/pLBzTcpMZVK7GPwv2B8p6EyqPXYr/h2SQBbxErTVZV+05cc0
         vz84z/q6GixVC301gFq9+BGJrZMNozitsVS1bskduyEtgigPcMKRUkG8iGg/ktqoLL2H
         uxoA==
X-Gm-Message-State: AOAM5335isCkL/kW372/jm9bdsR0C6OqOc04ZNzeGQIZBEVeYjUidON1
        gHXVGBPX5iPDki6e4ttuV+uno8oTeNSLQMn1q8M=
X-Google-Smtp-Source: ABdhPJwxpTAT1hMwpB3AuslkxEXuPVtmbiBZWNr8UkvUpClzvuPZ4wfXfvx4LQhFpZ4/e1BOnV86QZfHSXxcD7D3Zu8=
X-Received: by 2002:a25:4489:: with SMTP id r131mr8279192yba.538.1644196736547;
 Sun, 06 Feb 2022 17:18:56 -0800 (PST)
MIME-Version: 1.0
References: <20220205185909.878643-1-nunes.erico@gmail.com>
In-Reply-To: <20220205185909.878643-1-nunes.erico@gmail.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Mon, 7 Feb 2022 09:18:45 +0800
Message-ID: <CAKGbVbsBy5=b8bACbiQ57qMe2Jw_MN-4p=o7Qd+9BCS8U1ZQJw@mail.gmail.com>
Subject: Re: [PATCH] lima: avoid error task dump attempt when not enabled
To:     Erico Nunes <nunes.erico@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, lima@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Looks good for me, patch is:
Reviewed-by: Qiang Yu <yuq825@gmail.com>

On Sun, Feb 6, 2022 at 2:59 AM Erico Nunes <nunes.erico@gmail.com> wrote:
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
