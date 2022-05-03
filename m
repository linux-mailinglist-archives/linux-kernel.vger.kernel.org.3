Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881B4518649
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 16:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236810AbiECORu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 10:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236805AbiECORn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 10:17:43 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2094A193F1;
        Tue,  3 May 2022 07:14:11 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e24so23536952wrc.9;
        Tue, 03 May 2022 07:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OpVFLxl9pFOrEMMRYurod/ib5CbjrjCpO741fI+XBvY=;
        b=ORZ5qamh0mtHiKUsp6Fsrqgs6cYzaoQsveccu4xwYWKnkIx69MGl6kFqs/vJuMNA7f
         8F4kJHrlhCJ1BJHsmYT7q2d7ksTHVG0AElPCf9HOMpGKvj/x3FKDmq/8B6CjOYMNY6bR
         XjWo6uFJ3DLx5WRMfep4udC5lmGEB5aUJV1EIlrMx+BgFL3vFronlN3nn83fTJAjjoTz
         F0/WrfJEQwyEtfLgctGJnLXu5730T+IbV7kbAsy3cMUr4UMsZr84KgRnIGFKBmptwW4P
         lbQPnRg42BwPDILk0vcq0WY+nKGLo5NP0hpZPLNrXlT0maXHoEdzYzCk1DqXxrtsbfAa
         hdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OpVFLxl9pFOrEMMRYurod/ib5CbjrjCpO741fI+XBvY=;
        b=E7m9qI9mey1spjHWJQG30rl7EKeckvFPoxOr5wyDAIjetW+qzVcYK/ai5mOtmfHTIA
         96x67h/x1ygpRwHabQUcvm5pJkfqaawsMjxr8h2wUhxOTHhqEhzCEAS9hwmEvfwNSAyJ
         ikT00iiUP7WTedNnk68nIgd/BEhy6aMQ0J06WjEwScpkg4bnzwHtWYGwpjjIbdupl+Ql
         eAWLuVxGgls0L2Ec3dh5d88W+rfJZynlp8te5ojL7p42oWV6sPLM1daEVFhUv0MdR+YU
         s/LdZTdLm/mJcdDspZFf7jsuoKMZh/LrmIbk2ZMQItQ+1nGcNkhjQHjJLJYy6UVSSuMG
         TXEQ==
X-Gm-Message-State: AOAM531gQiLr9VGSYmZ9Ok/+3MiWlMD0SR4yGUPo+pN09pcB+Hu35s12
        +nl/VgloFjHBIcN2wusMVLUoJWbVl1D/c40/sDI=
X-Google-Smtp-Source: ABdhPJxfCQsPR/EgO4+YAJav9yefxL/RYqx57TttjxZzGPlfPZF6XdSj2vXBbpV/r5m5E2PqVw7XTGqwYv3OdqLPtKU=
X-Received: by 2002:adf:d1ec:0:b0:20c:6228:e2c8 with SMTP id
 g12-20020adfd1ec000000b0020c6228e2c8mr8026476wrd.328.1651587249457; Tue, 03
 May 2022 07:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220502172908.3569799-1-robdclark@gmail.com> <86160889d7be260c5012044643b81d10098943fe.camel@pengutronix.de>
In-Reply-To: <86160889d7be260c5012044643b81d10098943fe.camel@pengutronix.de>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 3 May 2022 07:13:55 -0700
Message-ID: <CAF6AEGve4OYRYvSim6_7ihYZb-HuwQkBqm8D_=1MRxDHhhQFag@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Limit command submission when no IOMMU
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        open list <linux-kernel@vger.kernel.org>,
        Luca Weiss <luca@z3ntu.xyz>, Sean Paul <sean@poorly.run>,
        freedreno <freedreno@lists.freedesktop.org>
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

On Tue, May 3, 2022 at 5:12 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Am Montag, dem 02.05.2022 um 10:29 -0700 schrieb Rob Clark:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Running the GPU without an IOMMU is not really a supported (or sane)
> > configuration.  Yet it can be useful during SoC bringup (ie. if the
> > iommu driver doesn't work yet).
> >
> > Lets limit it to users who already have /dev/mem access, to avoid the
> > chance that a user accidentially configures kernel without IOMMU
> > support.
>
> I haven't followed MSM too closely, so ctx->aspace may also include the
> GPU MMU, but if this really only includes the IOMMU (as the commit
> message implies) then this breaks Freedreno on i.MX5.

it includes the gpu mmu, so a2xx should be fine.

BR,
-R

> Regards,
> Lucas
>
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >  drivers/gpu/drm/msm/msm_gem_submit.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
> > index 23b68bc945f6..9cd8c8708990 100644
> > --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> > +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> > @@ -734,6 +734,11 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
> >       if (args->pad)
> >               return -EINVAL;
> >
> > +     if (unlikely(!ctx->aspace) && !capable(CAP_SYS_RAWIO)) {
> > +             DRM_ERROR_RATELIMITED("IOMMU support or CAP_SYS_RAWIO required!\n");
> > +             return -EPERM;
> > +     }
> > +
> >       /* for now, we just have 3d pipe.. eventually this would need to
> >        * be more clever to dispatch to appropriate gpu module:
> >        */
>
>
