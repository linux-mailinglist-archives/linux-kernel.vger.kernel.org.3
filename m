Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBB8538397
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 16:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242302AbiE3Ogx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 10:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241699AbiE3OR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 10:17:58 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4FF793B0;
        Mon, 30 May 2022 06:47:58 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id p5-20020a1c2905000000b003970dd5404dso6479243wmp.0;
        Mon, 30 May 2022 06:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1pogo+Rv5tv/SQVuIFRfnUxU3Jbc6+ErgEhXQlEuH7Q=;
        b=EgKmyAppjZbMOVnfQCO9MvfkDvMr+4bRewuD6ZUn/bdV7ecI0uWF5Wck1N/xzVzGBP
         q1aP+cC6TzWU0T7V406WfklMmWpdBDC2YcH0XIULHHAw/CG9lgeFrjbJCQcmWgTFVXFE
         ShI/kvcxCFcDEPze5rWor+yDkJ/nOqiI5MNP6mK6yW0bW/uvzOHoKL6RTkOdeROje5O7
         CtBl+wvl+mi6mUuSpQoJsZPcLNyrZZQHM7XFSWten5gD91Mzm8Ki6pMPBgX8hlzPrDWx
         kW/ASef/d62eot597BBs1qtCQsRLwhsjVWWR9SGads+97s4WmlryGoKH9rAke9OyIoH1
         3u9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1pogo+Rv5tv/SQVuIFRfnUxU3Jbc6+ErgEhXQlEuH7Q=;
        b=ZukBFx+fi3ih2Zin6IfRWhxgCgotJ3Jv9gVw+vm9Rp0wCYc0hL1D5X69qXJE+jUWs/
         kwj6nvSdG3S4og85P59Tz0sFeU4Sq/7SsQya5fK8jcTynKD86sWn2wqQABQfuXUBVbuG
         8nuF+0JZmHrhj1U1KL5DJPHT4M2Psx8++MhA3V+kG73yHEVrHgjY72UZhx0f+SojaLpq
         7jwBM9MEsnAnPuL410A+g1jibq3JMIjnBjkK9b4O6MCo1MsPIiwtc6vrJYetGzpOChJU
         T8i4pBFK9QOdG/yCHrj/HiHLpBqSxXSX0VHWyh4mhntEQCyluNz8jekF+Zk6aWpuV/3P
         ROsg==
X-Gm-Message-State: AOAM533GYr7P01bSBiFjaRUeepk1OvzVobS8AFekWvuIbSNxrmUoR6Jm
        ku3ayXL3MKGGoGIF4eSYj6n9fTLQD6zgn320qiIV97tz
X-Google-Smtp-Source: ABdhPJxKwfq4ycqFXAM+C8AheHuI+NB1Jymb9X57td3iSrPCizEAfyrJbVEDX+hf+1fVrrb5pR/iFCEG7v/503K0ua8=
X-Received: by 2002:a05:600c:6011:b0:398:fa3:c02d with SMTP id
 az17-20020a05600c601100b003980fa3c02dmr12803839wmb.183.1653918476657; Mon, 30
 May 2022 06:47:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220529162936.2539901-1-robdclark@gmail.com> <0bf230f4-c888-b9c9-f061-7450406baa4a@suse.de>
In-Reply-To: <0bf230f4-c888-b9c9-f061-7450406baa4a@suse.de>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 30 May 2022 06:47:55 -0700
Message-ID: <CAF6AEGthAfWyAvbuE4EP+u52LEKS2Fs6X=gG8qUjc7gci6oh-A@mail.gmail.com>
Subject: Re: [PATCH] drm/prime: Ensure mmap offset is initialized
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        freedreno <freedreno@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 12:26 AM Thomas Zimmermann <tzimmermann@suse.de> wr=
ote:
>
> Hi
>
> Am 29.05.22 um 18:29 schrieb Rob Clark:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > If a GEM object is allocated, and then exported as a dma-buf fd which i=
s
> > mmap'd before or without the GEM buffer being directly mmap'd, the
> > vma_node could be unitialized.  This leads to a situation where the CPU
> > mapping is not correctly torn down in drm_vma_node_unmap().
>
> Which drivers are affected by this problem?
>
> I checked several drivers and most appear to be initializing the offset
> during object construction, such as GEM SHMEM. [1] TTM-based drivers
> also seem unaffected. [2]
>
>  From a quick grep, only etnaviv, msm and omapdrm appear to be affected?
> They only seem to run drm_gem_create_mmap_offset() from their
> ioctl-handling code.
>
> If so, I'd say it's preferable to fix these drivers and put a
> drm_WARN_ONCE() into drm_gem_prime_mmap().

That is good if fewer drivers are affected, however I disagree with
your proposal.  At least for freedreno userspace, a lot of bo's never
get mmap'd (either directly of via dmabuf), so we should not be
allocating a mmap offset unnecessarily.

BR,
-R

> Best regards
> Thomas
>
> [1]
> https://elixir.bootlin.com/linux/v5.18/source/drivers/gpu/drm/drm_gem_shm=
em_helper.c#L85
> [2]
> https://elixir.bootlin.com/linux/v5.18/source/drivers/gpu/drm/ttm/ttm_bo.=
c#L1002
>
> >
> > Fixes: e5516553999f ("drm: call drm_gem_object_funcs.mmap with fake off=
set")
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> > Note, it's possible the issue existed in some related form prior to the
> > commit tagged with Fixes.
> >
> >   drivers/gpu/drm/drm_prime.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> > index e3f09f18110c..849eea154dfc 100644
> > --- a/drivers/gpu/drm/drm_prime.c
> > +++ b/drivers/gpu/drm/drm_prime.c
> > @@ -716,6 +716,11 @@ int drm_gem_prime_mmap(struct drm_gem_object *obj,=
 struct vm_area_struct *vma)
> >       struct file *fil;
> >       int ret;
> >
> > +     /* Ensure that the vma_node is initialized: */
> > +     ret =3D drm_gem_create_mmap_offset(obj);
> > +     if (ret)
> > +             return ret;
> > +
> >       /* Add the fake offset */
> >       vma->vm_pgoff +=3D drm_vma_node_start(&obj->vma_node);
> >
>
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
> (HRB 36809, AG N=C3=BCrnberg)
> Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev
