Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32454DDC6A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 16:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237808AbiCRPHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 11:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237779AbiCRPHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 11:07:35 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA911580C4;
        Fri, 18 Mar 2022 08:06:16 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d7so12114932wrb.7;
        Fri, 18 Mar 2022 08:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pG68kiu/++U7tqyFs9qijXM9HYdZLbHBS4VEGs1eM0I=;
        b=Ri+IYudXxdnlsvQY3QJh6kMqmIlSISE8BeVr71HKzveKdHoyllvY4vjSlZ+UIprX1B
         a4Bj0KhALFAKV0/HsLKSQG9e2x0CC3wRfiHZGOdJw3kxRDSfkTPF9s43Ej5kpLglcqor
         MV00SYcOTvVClsd430MSmdDKE4I0ninaxZCvuX3Bgt2G8/F+FI1Ig69vrN5tl9jutDju
         ku7QfWoq8zvVra0rWjwOJNVzYZFBbjG1KW5g1wXNSVryszIVjSXSHTdr5jb/gxQvD7Ur
         nKUFT+/VVHXeM551HxsZ6Ggn9o/RvpuSgYjyVJnWNRwHOULYiQff2EBRtWd0vYLWDHnp
         F5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pG68kiu/++U7tqyFs9qijXM9HYdZLbHBS4VEGs1eM0I=;
        b=diKKgYjyO7lJ7dt3r6pKbvb4H6kv6cI6es5VITMZ+b3AFUhDRv4nuaazsgr00FSsoS
         OC9n7tznBvhSvLZp6iI/5j8Zn9pITFiZsCvZXCYoxZqYZR9dKHL2ft4q8TIwtV1xnhIE
         ukagNGgzzpjdyXRD1y354LtlxjkkB0emVfgqT8veKhnB5N/KvTNuuV+wSlXtxUhgi+De
         fzM+mfXPb5V/xT9F8ANziaFlwHJpmi1AH53T82IooYT7aBIuXvZelEVfcx3zHMLZ8uZ2
         2DwqUd1+hqOB4oRyYinyEIzsFzFox1mdhv4k4DoqQ2+LM+jCyQ55cVcDsvg6BdT/Q53n
         FMFg==
X-Gm-Message-State: AOAM533EUs5XgyvQtuC7uJpDxBP4iEiIl1NmegwPFhDzl1T3MDMkXURX
        jRWiB4HxI3X3AkY/krb07Pbhs8TDKmeuiYwCDZY=
X-Google-Smtp-Source: ABdhPJwM9l/MXHGIr1umxgGzV4s9hhgx8LJL7YXtZMHDO2SJbjgrcaNg81bfFHjfTAsi9Ohk3p2Obnd4dTBWS37CRLU=
X-Received: by 2002:adf:dd4d:0:b0:203:f178:b78b with SMTP id
 u13-20020adfdd4d000000b00203f178b78bmr5002998wrm.93.1647615975124; Fri, 18
 Mar 2022 08:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220317002950.193449-1-robdclark@gmail.com> <20220317002950.193449-4-robdclark@gmail.com>
 <20220317082121.GH1841@kadam> <CAF6AEGsnXz05fCnYAvFk+Hp-2z7N1kdVS0kYKn7+ejohLp8H7w@mail.gmail.com>
 <20220318071843.GF336@kadam>
In-Reply-To: <20220318071843.GF336@kadam>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 18 Mar 2022 08:06:57 -0700
Message-ID: <CAF6AEGs+yfLHzFag4dMNiBxO7fcVQFSP+4n8zdfttwXpeS+X5w@mail.gmail.com>
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

On Fri, Mar 18, 2022 at 12:19 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Thu, Mar 17, 2022 at 08:03:59AM -0700, Rob Clark wrote:
> > > > diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> > > > index 4ec62b601adc..68f3f8ade76d 100644
> > > > --- a/drivers/gpu/drm/msm/msm_gpu.c
> > > > +++ b/drivers/gpu/drm/msm/msm_gpu.c
> > > > @@ -364,14 +364,21 @@ static void retire_submits(struct msm_gpu *gpu);
> > > >
> > > >  static void get_comm_cmdline(struct msm_gem_submit *submit, char **comm, char **cmd)
> > > >  {
> > > > +     struct msm_file_private *ctx = submit->queue->ctx;
> > > >       struct task_struct *task;
> > > >
> > > > +     *comm = kstrdup(ctx->comm, GFP_KERNEL);
> > > > +     *cmd  = kstrdup(ctx->cmdline, GFP_KERNEL);
> > > > +
> > > >       task = get_pid_task(submit->pid, PIDTYPE_PID);
> > > >       if (!task)
> > > >               return;
> > > >
> > > > -     *comm = kstrdup(task->comm, GFP_KERNEL);
> > > > -     *cmd = kstrdup_quotable_cmdline(task, GFP_KERNEL);
> > > > +     if (!*comm)
> > > > +             *comm = kstrdup(task->comm, GFP_KERNEL);
> > >
> > > What?
> > >
> > > If the first allocation failed, then this one is going to fail as well.
> > > Just return -ENOMEM.  Or maybe this is meant to be checking for an empty
> > > string?
> >
> > fwiw, if ctx->comm is NULL, the kstrdup() will return NULL, so this
> > isn't intended to deal with OoM, but the case that comm and/or cmdline
> > is not overridden.
>
> Ah, I should have thought about that.  Thanks!

np, I realized it was fairly non-obvious so I added a comment in v2 to
hopefully make it more clear

BR,
-R

> regards,
> dan carpenter
>
