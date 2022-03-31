Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0D84EE142
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 21:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238097AbiCaTDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 15:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238038AbiCaTDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:03:32 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31EA20DB01;
        Thu, 31 Mar 2022 12:01:44 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u16so1094512wru.4;
        Thu, 31 Mar 2022 12:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T9+AkiW/4h4A1Ms4Miaw1I42u6H5Nq21dOfaVBmxDOY=;
        b=YhXQSDQNFt1PUyiQir/KzfA2QkhaB5iXoDEQqrvlYnBuvliALMKTvUF/Tst9kBbB4J
         3SNayKANcUSbmkrIBfOB11eokDrjDFeazk5bLvOuuZ4y8rx4zeCDpIi026N2sJjKSBvO
         MLyPRQCBNRqwW41BtETq9xWEHbm8pmQeI5NYZJD57XBOlNH+RELCfvheG81DDNXbfrW5
         9V51RZJSTRfoGOfhBH/9emqzBACiqYXX7x+tMVXyOuVUUFOwQZ2CpUr+Isk4MflSzgt/
         lC6ridW1AAiN1lJPO3jwMQmplC3eS2daZ4s+pQGQBaxFHIrfLJFYlsbAsQptf933E6Ba
         kSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T9+AkiW/4h4A1Ms4Miaw1I42u6H5Nq21dOfaVBmxDOY=;
        b=4mgmH9MKEqNrZDHp7LizhNdyOBrrZyyx4Xd2gFc/DjVvKHBTypPle9q4BXCHWt54ud
         hjLoFbDrjQcJKxefUsKSUVlAkV06RM0SucDEv2qVrsldqDkOmYTEiW1ctA+PXwXXUrWJ
         UaINEq/2isvyflF22o8+Tt0QPsByIEGODmJ6bE3pQCjWWgHuNfWL18FPNtqw12/xQ17B
         qNz6QZ5UY3GrVOWQ/UtuNvzJA7oYEBNqE5ogMqJkEtbYjy6ttftN/h3tBMUwfCklloS5
         IipZio20EP1vUgiv3g5Jv9p94nhjDLbSuBlgRcLWN+UN/7Vu5vc9cxSknPKr/ZtRb6OB
         HSaA==
X-Gm-Message-State: AOAM530TQ88MDNASVl3dLAWLTKSHpwqLUoVq3vyWflHAzVdMDjqfVuDE
        WrXx6fmedT8Gkklrcdg3VGOfs4PAWbFgSq7Wn2g=
X-Google-Smtp-Source: ABdhPJwX9ypiRh4trrEQoi/7vM1BBV0U8zxJnGyxDNIWxKMhout7D4Lj2PJ5oVdWZLsHo820nf/TSIMiwiSGtr2XH7o=
X-Received: by 2002:adf:f20f:0:b0:203:fc73:a9a0 with SMTP id
 p15-20020adff20f000000b00203fc73a9a0mr5182581wro.418.1648753303352; Thu, 31
 Mar 2022 12:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220330204804.660819-1-robdclark@gmail.com> <20220330204804.660819-11-robdclark@gmail.com>
 <ad97096f-cc90-4f20-0f73-f33e9b275f1a@collabora.com>
In-Reply-To: <ad97096f-cc90-4f20-0f73-f33e9b275f1a@collabora.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 31 Mar 2022 12:02:35 -0700
Message-ID: <CAF6AEGvZqM1OT_n1C+x+C1GTd4PbFkH4c7P-BseDOUGj7yj3Eg@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] drm/msm: Add a way for userspace to allocate GPU iova
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
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Emma Anholt <emma@anholt.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
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

On Thu, Mar 31, 2022 at 11:52 AM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> ...
> > +/*
> > + * Get the requested iova but don't pin it.  Fails if the requested iova is
> > + * not available.  Doesn't need a put because iovas are currently valid for
> > + * the life of the object.
> > + *
> > + * Setting an iova of zero will clear the vma.
> > + */
> > +int msm_gem_set_iova(struct drm_gem_object *obj,
> > +                  struct msm_gem_address_space *aspace, uint64_t iova)
> > +{
> > +     int ret = 0;
>
> nit: No need to initialize the ret

actually, we do

> > +     msm_gem_lock(obj);
> > +     if (!iova) {
> > +             ret = clear_iova(obj, aspace);
> > +     } else {
> > +             struct msm_gem_vma *vma;
> > +             vma = get_vma_locked(obj, aspace, iova, iova + obj->size);
> > +             if (IS_ERR(vma)) {
> > +                     ret = PTR_ERR(vma);
> > +             } else if (GEM_WARN_ON(vma->iova != iova)) {
> > +                     clear_iova(obj, aspace);
> > +                     ret = -ENOSPC;
>
> The (vma->iova != iova) means that vma is already set, but to a
> different address. Is -ENOSPC really appropriate here? -EBUSY or -EINVAL
> looks more natural to me.

yeah, -EBUSY is better

> > +             }
> > +     }
> > +     msm_gem_unlock(obj);
> > +
> > +     return ret;
> > +}
> > +
> >  /*
> >   * Unpin a iova by updating the reference counts. The memory isn't actually
> >   * purged until something else (shrinker, mm_notifier, destroy, etc) decides
> > diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
> > index 38d66e1248b1..efa2e5c19f1e 100644
> > --- a/drivers/gpu/drm/msm/msm_gem.h
> > +++ b/drivers/gpu/drm/msm/msm_gem.h
> > @@ -38,6 +38,12 @@ struct msm_gem_address_space {
> >
> >       /* @faults: the number of GPU hangs associated with this address space */
> >       int faults;
> > +
> > +     /** @va_start: lowest possible address to allocate */
> > +     uint64_t va_start;
> > +
> > +     /** @va_size: the size of the address space (in bytes) */
> > +     uint64_t va_size;
> >  };
> >
> >  struct msm_gem_address_space *
> > @@ -144,6 +150,8 @@ struct msm_gem_vma *msm_gem_get_vma_locked(struct drm_gem_object *obj,
> >                                          struct msm_gem_address_space *aspace);
> >  int msm_gem_get_iova(struct drm_gem_object *obj,
> >               struct msm_gem_address_space *aspace, uint64_t *iova);
> > +int msm_gem_set_iova(struct drm_gem_object *obj,
> > +             struct msm_gem_address_space *aspace, uint64_t iova);
> >  int msm_gem_get_and_pin_iova_range(struct drm_gem_object *obj,
> >               struct msm_gem_address_space *aspace, uint64_t *iova,
> >               u64 range_start, u64 range_end);
> nit: There is an odd mix of uint64_t and u64 (and alike) in the MSM code
> :) The uint64_t variant shouldn't be used by kernel code in general and
> checkpatch should want about it.

one of many things that I disagree with checkpatch about ;-)

I prefer standard types to custom ones.  I _kinda_ get the argument in
case of uapi (but IMHO that doesn't apply to how drm uapi headers are
used)

BR,
-R
