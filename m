Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25085871E5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 22:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbiHAUAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 16:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiHAUAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 16:00:44 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FC01572B;
        Mon,  1 Aug 2022 13:00:41 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id w15so18926063lft.11;
        Mon, 01 Aug 2022 13:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=V5gQ5qjxqGzCmOK1PLGxzPSbavAClYglR/pW8JvcVsY=;
        b=EOL03vS8sJyZdeSxpiRsCpF+3QVM3bz3TKLSdmNrCoN76SVWyUko+Tv6vsSYLW7ohS
         OoFPkFDsJRnCHJ8rN0rBpqI8kXsGle4DYUVWllYVv4qGUEKKkiDcieFDGBfMgt6tEi7t
         LP86DXRvoqv4wH2xg+sMC+aIO5Wf/uE9oLW9FlN2WJvKg9mQqtKopNHU39gskBLHOLhg
         oqT9ulPJApTuxEbnIx4D096yBekO7hEns8wHMQ8Vga8PMh+bdRVTg2U1BdfxwzpUz+Sa
         x2ALv/PS9Hp6ZtJQhZD3YGGC5A9n7f4sDdG7YeKW3OJkegRDy04hq3vJtVLEaS9RiQd6
         Co6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=V5gQ5qjxqGzCmOK1PLGxzPSbavAClYglR/pW8JvcVsY=;
        b=SDSkPpxwyBOnaglBbh/mTbdlIKQDsfJ9SUok8cwUuAqEyD3/4u4/Sz2Qx4tC6nW+8X
         +2YV+f078IdV9J07YHSHMSbORL7X6cRCzqdZM2TduufPrVqjXW+caVaJ5oW7RfV05ezc
         x0tQ53yFbH81T985/fHVadF9LE8f00FjZvVLSGWCgxADnwzuBZTIOCs5jnVKTCO4AyLq
         uvZ8Ihu4J78fHbnB8OJy7shpPtae1Ka0g0HCKzBhS6IJrhI9JcS2EhbNiesKw0FU+hNv
         DFJMsArQgQWajosW6Qoe8ytijNAJwJOzkTCVEOX5/SCUfuiz+c3nnZeUE4UwRWE8AMri
         mu9g==
X-Gm-Message-State: AJIora+OMxPL1drjHj4EIQlrOyRdCT5wMLfi0sT4zU+SIm0XOBmlqXeE
        7jTTbetOUkiQs9hIjeBjm0cvFugHqxKV9MsgU18=
X-Google-Smtp-Source: AGRyM1vBBRHawcG8ftTonyM9q75QurQ3p3zcaTaySOV/jAW8LTQYo2ezKlXopdPACqJAWiV0BTKWTE1V6STR2cdwnFI=
X-Received: by 2002:a05:6512:3f13:b0:48a:a89e:3ccb with SMTP id
 y19-20020a0565123f1300b0048aa89e3ccbmr5804969lfa.245.1659384039913; Mon, 01
 Aug 2022 13:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220726175043.1027731-1-robdclark@gmail.com> <20220726175043.1027731-10-robdclark@gmail.com>
 <def8e47c-067e-0841-4ae4-1eb90244cd50@collabora.com>
In-Reply-To: <def8e47c-067e-0841-4ae4-1eb90244cd50@collabora.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 1 Aug 2022 13:00:27 -0700
Message-ID: <CAF6AEGtV4GY6=PmQh0wrKxjxk_baRCzOo=s=Uz-uKBNEn7SBBg@mail.gmail.com>
Subject: Re: [PATCH v3 09/15] drm/gem: Add LRU/shrinker helper
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 1, 2022 at 12:41 PM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 7/26/22 20:50, Rob Clark wrote:
> > +/**
> > + * drm_gem_lru_remove - remove object from whatever LRU it is in
> > + *
> > + * If the object is currently in any LRU, remove it.
> > + *
> > + * @obj: The GEM object to remove from current LRU
> > + */
> > +void
> > +drm_gem_lru_remove(struct drm_gem_object *obj)
> > +{
> > +     struct drm_gem_lru *lru = obj->lru;
> > +
> > +     if (!lru)
> > +             return;
> > +
> > +     mutex_lock(lru->lock);
> > +     lru_remove(obj);
> > +     mutex_unlock(lru->lock);
> > +}
> > +EXPORT_SYMBOL(drm_gem_lru_remove);
>
> I made a preliminary port of the DRM-SHMEM shrinker on top of the the
> latest version of dma-buf locking convention and yours LRU patches. It
> all works good, the only thing that is missing for the DRM-SHMEM
> shrinker is the drm_gem_lru_remove_locked().
>
> What about to add a locked variant of drm_gem_lru_remove()?

Sounds fine to me.. the only reason it didn't exist yet was because it
wasn't needed yet..

I can respin w/ an addition of a _locked() version, or you can add it
on top in your patchset.  Either is fine by me

BR,
-R
