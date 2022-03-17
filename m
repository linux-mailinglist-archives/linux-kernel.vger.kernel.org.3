Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EC84DC981
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbiCQPEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiCQPEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:04:36 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA67F17E37;
        Thu, 17 Mar 2022 08:03:19 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 123-20020a1c1981000000b0038b3616a71aso3310766wmz.4;
        Thu, 17 Mar 2022 08:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6D/2aZGnY6875EFh+ETsZseL6iAzu/82ojLJG78YCws=;
        b=FTTHOCemfWozPSr8gX8l5dWg1G/wnR7w2M6aOlxOwFgx6ps3obsAt8FtZSZ/YEKj4D
         6sOYVo5l9+eEdsUYJWPMLtD1U86OlzUjqd9voYmMfMoy8cpXTqH/Hdbd97r/buY4+Pqg
         nqsFWh0EVXsKhl61ux49MECgqplDEskANCCtOz9vC2NuUO8l6aDJ8sPfk1k4qBrasi9M
         Fct7+mU8Fwa6wkPWn8of8GzWRHf9oJQ5sYizPBtiUVKLuL7WC+DLCn4yXv71Jk/xAQBC
         MpMNcy9A5q0CWDufuBZvstp/HV/xY9VapxU+kP+7OpVLMrgzN2Q5YlVeMhQKnLUD1oM1
         nnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6D/2aZGnY6875EFh+ETsZseL6iAzu/82ojLJG78YCws=;
        b=chqKapgIvTlHn846NFhic4SZCrhqG4aP4tz8i6SqhwV8cgUKieu4IKWCW9XMPgQ7lt
         sudQ5Z0EVO/p51wgQjEmZJ5/SbeXTMKdKwfOrGta3zEpnw7GbMLAv/1vfsrYW/q2vx/1
         2gyBKTmYW7I3OjKU4PftQtdo6qolM36Gh47mJ3ZQf0Q58jIbFNwMQmSt7dttqRkLYakd
         uGfZHgQ/BNZAnyR5Ajpaf8JdGeZcw/B3prZk0Zhxdk3bFIEQuDu4fE06DUoEWnkN4iTN
         L4df2nUouV4YVWJrFnijVHNkEtyq1qkvZSl+boVkM25g8/UJ+KdGHaqe+NoLqgYpfzHB
         xtlg==
X-Gm-Message-State: AOAM5318sSaaTK1FXby4fKWJdtzkUNy6OZoWe7x501+QZi65Ccz0Bf3p
        mVHsiiD7EPYOv5/qr8IKDGh1GyH5g6FNTiliqElRXC1U
X-Google-Smtp-Source: ABdhPJydCT/vtakfbrKWR+jM9qGo9W4JZv3KtibLEtGonA920Vs0jF6DIVS1wTmv1X1WByZ46++UqLd5CDENDqqK+cA=
X-Received: by 2002:a05:600c:22c4:b0:38c:70f5:25a9 with SMTP id
 4-20020a05600c22c400b0038c70f525a9mr4309084wmg.119.1647529398246; Thu, 17 Mar
 2022 08:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220317002950.193449-1-robdclark@gmail.com> <20220317002950.193449-4-robdclark@gmail.com>
 <20220317082121.GH1841@kadam>
In-Reply-To: <20220317082121.GH1841@kadam>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 17 Mar 2022 08:03:59 -0700
Message-ID: <CAF6AEGsnXz05fCnYAvFk+Hp-2z7N1kdVS0kYKn7+ejohLp8H7w@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/msm: Add a way to override processes comm/cmdline
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Emma Anholt <emma@anholt.net>,
        open list <linux-kernel@vger.kernel.org>
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

On Thu, Mar 17, 2022 at 1:21 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Wed, Mar 16, 2022 at 05:29:45PM -0700, Rob Clark wrote:
> >       switch (param) {
> > +     case MSM_PARAM_COMM:
> > +     case MSM_PARAM_CMDLINE: {
> > +             char *str, **paramp;
> > +
> > +             str = kmalloc(len + 1, GFP_KERNEL);
>
> if (!str)
>         return -ENOMEM;
>
> > +             if (copy_from_user(str, u64_to_user_ptr(value), len)) {
> > +                     kfree(str);
> > +                     return -EFAULT;
> > +             }
> > +
> > +             /* Ensure string is null terminated: */
> > +             str[len] = '\0';
> > +
> > +             if (param == MSM_PARAM_COMM) {
> > +                     paramp = &ctx->comm;
> > +             } else {
> > +                     paramp = &ctx->cmdline;
> > +             }
> > +
> > +             kfree(*paramp);
> > +             *paramp = str;
> > +
> > +             return 0;
> > +     }
> >       case MSM_PARAM_SYSPROF:
> >               if (!capable(CAP_SYS_ADMIN))
> >                       return -EPERM;
> > diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> > index 4ec62b601adc..68f3f8ade76d 100644
> > --- a/drivers/gpu/drm/msm/msm_gpu.c
> > +++ b/drivers/gpu/drm/msm/msm_gpu.c
> > @@ -364,14 +364,21 @@ static void retire_submits(struct msm_gpu *gpu);
> >
> >  static void get_comm_cmdline(struct msm_gem_submit *submit, char **comm, char **cmd)
> >  {
> > +     struct msm_file_private *ctx = submit->queue->ctx;
> >       struct task_struct *task;
> >
> > +     *comm = kstrdup(ctx->comm, GFP_KERNEL);
> > +     *cmd  = kstrdup(ctx->cmdline, GFP_KERNEL);
> > +
> >       task = get_pid_task(submit->pid, PIDTYPE_PID);
> >       if (!task)
> >               return;
> >
> > -     *comm = kstrdup(task->comm, GFP_KERNEL);
> > -     *cmd = kstrdup_quotable_cmdline(task, GFP_KERNEL);
> > +     if (!*comm)
> > +             *comm = kstrdup(task->comm, GFP_KERNEL);
>
> What?
>
> If the first allocation failed, then this one is going to fail as well.
> Just return -ENOMEM.  Or maybe this is meant to be checking for an empty
> string?

fwiw, if ctx->comm is NULL, the kstrdup() will return NULL, so this
isn't intended to deal with OoM, but the case that comm and/or cmdline
is not overridden.

BR,
-R

>
> > +
> > +     if (!*cmd)
> > +             *cmd = kstrdup_quotable_cmdline(task, GFP_KERNEL);
>
> Same.
>
> >
> >       put_task_struct(task);
> >  }
>
> regards,
> dan carpenter
>
