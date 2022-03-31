Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EFA4EE133
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 20:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237657AbiCaS7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 14:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235959AbiCaS7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 14:59:34 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C991B9FC5;
        Thu, 31 Mar 2022 11:57:46 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id p26-20020a05600c1d9a00b0038ccbff1951so2348540wms.1;
        Thu, 31 Mar 2022 11:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RcGA7qZL8bg5E6qFk3sdBJk26ZdghHIeSb/SgsZqBag=;
        b=cv7vJCYuueHR+RjurisIFmW8Xs45KZu/1kaJ+IcCX9wfrhy37/Q4x2pelmTd5sgbpE
         HQzJ0ZJjl7w4caBkZbkmW2WH0a0/x96En8B6WNH4QpgvPLE3JmOYpH1eLtTqiXLIk5RX
         os5c3ObHVviLGC5WFoo5DsFCWygJUx72OxxREXOHc6YvkuUkKJydvFGqaTQWS8UdKbnP
         DOjSpXD2xkTPWQyXU2ZF7txd+9B2tTtcO33Gd+ZU9kky4jrW/o6q8U2mLG3CyFS/jC7V
         nuU+AIB/7AnzXXJPEvhTK//ag26NrJIxg3Wa9JKxm0jqAw67nuu7Zs99kWVs8cA4kqj7
         kPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RcGA7qZL8bg5E6qFk3sdBJk26ZdghHIeSb/SgsZqBag=;
        b=u3WIs1R1oQBoo6zsYLfDQDcxSmLUNGnW0yYFAgnmpZNk3wK8heZvQV9EGHAHYg3Cps
         1CZ4tjqatmQo9ljfLP7Kl126xBzPLI/yorgyUumVviHwCHLlBmEEs9V1bRnU9aVLrwNi
         9QhY1a6vIMzVvHzQ2Y6OrhaWmxlEu17NIFVy99fzW/yRWOfq2u9V6dOSFxmYwrkvyghj
         wbOncVye07q8IL34fsU9Ijvt3Ev9SIXs/7rAOuj0gC3ucq+/JkGosm/gQl2prf+eCVws
         JCSqkKbSTg3iFEZInsoY/F6UfYFWI2gK2+Q0FE21EbsALriYlivtEiEn/KYXJisOP0IE
         216w==
X-Gm-Message-State: AOAM533lbrjazJR7jRRm8GmPjw/4j21nJgCBp9KxlkTbqPIvURWmqHbP
        EiMxEfgVnA2eduhSNoJ6Zt8qKW9ljdCfurp6bLIDapBB
X-Google-Smtp-Source: ABdhPJzjWFQNfQlScp7L8msEibU0gM72m999QKy+C7eRMt+/vP9w0VatzkP5yDG6lf4lyS4mdaftC+0wu2HwQWo8nt0=
X-Received: by 2002:a05:600c:35d0:b0:38c:e6fa:44eb with SMTP id
 r16-20020a05600c35d000b0038ce6fa44ebmr5803865wmq.102.1648753065007; Thu, 31
 Mar 2022 11:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220330204804.660819-1-robdclark@gmail.com> <20220330204804.660819-8-robdclark@gmail.com>
 <83979c7b-8a8a-5006-6af3-f3ca8b0d8ced@collabora.com>
In-Reply-To: <83979c7b-8a8a-5006-6af3-f3ca8b0d8ced@collabora.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 31 Mar 2022 11:58:36 -0700
Message-ID: <CAF6AEGtEczCSzwMNcr2EJJ=OcncABC2ZM2dVpAYoJM+5TBTKXQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] drm/msm/gem: Rework vma lookup and pin
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
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

On Thu, Mar 31, 2022 at 11:27 AM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 3/30/22 23:47, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Combines duplicate vma lookup in the get_and_pin path.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >  drivers/gpu/drm/msm/msm_gem.c | 50 ++++++++++++++++++-----------------
> >  1 file changed, 26 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> > index deafae6feaa8..218744a490a4 100644
> > --- a/drivers/gpu/drm/msm/msm_gem.c
> > +++ b/drivers/gpu/drm/msm/msm_gem.c
> > @@ -376,39 +376,40 @@ put_iova_vmas(struct drm_gem_object *obj)
> >       }
> >  }
> >
> > -static int get_iova_locked(struct drm_gem_object *obj,
> > -             struct msm_gem_address_space *aspace, uint64_t *iova,
> > +static struct msm_gem_vma *get_vma_locked(struct drm_gem_object *obj,
> > +             struct msm_gem_address_space *aspace,
> >               u64 range_start, u64 range_end)
> >  {
> >       struct msm_gem_vma *vma;
> > -     int ret = 0;
> >
> >       GEM_WARN_ON(!msm_gem_is_locked(obj));
> >
> >       vma = lookup_vma(obj, aspace);
> >
> >       if (!vma) {
> > +             int ret;
> > +
> >               vma = add_vma(obj, aspace);
> >               if (IS_ERR(vma))
> > -                     return PTR_ERR(vma);
> > +                     return vma;
> >
> >               ret = msm_gem_init_vma(aspace, vma, obj->size,
> >                       range_start, range_end);
> >               if (ret) {
> You're allocation range_start -> range_end
>
>
> >                       del_vma(vma);
> > -                     return ret;
> > +                     return ERR_PTR(ret);
> >               }
> > +     } else {
> > +             GEM_WARN_ON(vma->iova < range_start);
> > +             GEM_WARN_ON((vma->iova + obj->size) > range_end);
>
> and then comparing range_start -> range_start + obj->size, hence you're
> assuming that range_end always equals to obj->size during the allocation.
>
> I'm not sure what is the idea here.. this looks inconsistent. I think
> you wanted to write:
>
>                 GEM_WARN_ON(vma->iova < range_start);
>                 GEM_WARN_ON(vma->iova + (vma->node.size << PAGE_SHIFT) > range_end);
>
> But is it really useful to check whether the new range is inside of the
> old range? Shouldn't it be always a error to change the IOVA range
> without reallocating vma?

There are a few cases (for allocations for GMU) where the range is
larger than the bo.. see a6xx_gmu_memory_alloc()

BR,
-R

>
> I'd expect to see:
>
>                 GEM_WARN_ON(vma->iova != range_start);
>                 GEM_WARN_ON(vma->iova + (vma->node.size << PAGE_SHIFT) != range_end);
>
> and then error out if range mismatches.
