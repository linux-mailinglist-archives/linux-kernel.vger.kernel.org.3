Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76540538590
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 17:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241972AbiE3P4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 11:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238912AbiE3Pz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 11:55:56 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E13F33B7;
        Mon, 30 May 2022 08:41:09 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id s24so7853413wrb.10;
        Mon, 30 May 2022 08:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HVYE9hD3JrlMP+VW+LXUcgvWsAPOc0+ADO1o4rrMIPE=;
        b=cOfon/AQdRZHUtaWUXSrjOLVbe/SaIrsAT1iSjEE4S2pJaqFJrshFUwG7CuV8zJNBE
         YjxmI7Z3mPwwK4lp3hdexT3bc0rF6YjTKT87FQZsXEyYd0fJ/8Q/TsNxV0cTPPGA76pZ
         nHewp/PRdVsYuBvd70KIDsjutHnHc10KAtPkI0wY1EzigLuqLSNoeNkxXcODBbrbD0Ha
         Pk+Im4A+VrBL5j49XDhHZICFI3ZuHCP0+11fTJXS+eUUcwTjVEepR4g9YZkv8WvGTUcU
         O6U+aB3ugr4S0gMR2kam5UEAjXrQ4bFO5XgrX9K2VRJSWWTTVGwvGTe5RMdc5mJOaZrW
         K8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HVYE9hD3JrlMP+VW+LXUcgvWsAPOc0+ADO1o4rrMIPE=;
        b=1MmJnFxMQP8laI9OBr8SizNBFXw1/EoXB8oxkwb3nj//RkcGGkHhjuiTS/CciXQv3o
         hsHz/1yofahPSEZ6hxELEnjzXi8wcV/CESIuGsaJjrnRYRR3nhRGAR3qvHFpPP2mrbSe
         uN0h+bPueETQQ3CZMh3FIVS5jiVarkNwccDzOjlT6ZGW7YkJkAK7v4WxhPSX1nhGPgyH
         UnFNoWknpkyLmKn3atVjt8gHHN544nTdW0XSJ664BrMUJFc4ZDaalecCQdy2zQIlWkXy
         PQOzR58ZcMAHLRSpHfMcEA2nvr11xgABha/6+6zw1CTnpQfnwZvMLr8qulzm3JepOl+o
         5kVQ==
X-Gm-Message-State: AOAM531DHQbWIyrWul+doUzN6ycDNQHxs4XQBQcIHuvmO2C3eRcDx9Rr
        1uCyd/OoO/N0Bbg5Nw3Lu9I7lCJ0L957Nqw+nj0=
X-Google-Smtp-Source: ABdhPJwZAdTGyIwawuuNR1GgsN3ZUEq8rIP+BodHV6Uu26K2LWerRbcastuQYCbyWx1CE0THq9R0WpkDkQENKunHmT8=
X-Received: by 2002:adf:f645:0:b0:20e:652d:2a4e with SMTP id
 x5-20020adff645000000b0020e652d2a4emr47995950wrp.344.1653925267454; Mon, 30
 May 2022 08:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220529162936.2539901-1-robdclark@gmail.com> <0bf230f4-c888-b9c9-f061-7450406baa4a@suse.de>
 <CAF6AEGthAfWyAvbuE4EP+u52LEKS2Fs6X=gG8qUjc7gci6oh-A@mail.gmail.com> <CAKMK7uG9=EcmD4hPqm4zYsDHiS9Mr=y_5tUa_R1veDxSSK-P-Q@mail.gmail.com>
In-Reply-To: <CAKMK7uG9=EcmD4hPqm4zYsDHiS9Mr=y_5tUa_R1veDxSSK-P-Q@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 30 May 2022 08:41:09 -0700
Message-ID: <CAF6AEGuLeLmD4m+yi5csGdb0XZbnAOfYOKx6c-wEgMGt6rj7Cw@mail.gmail.com>
Subject: Re: [PATCH] drm/prime: Ensure mmap offset is initialized
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
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

On Mon, May 30, 2022 at 7:49 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Mon, 30 May 2022 at 15:54, Rob Clark <robdclark@gmail.com> wrote:
> >
> > On Mon, May 30, 2022 at 12:26 AM Thomas Zimmermann <tzimmermann@suse.de=
> wrote:
> > >
> > > Hi
> > >
> > > Am 29.05.22 um 18:29 schrieb Rob Clark:
> > > > From: Rob Clark <robdclark@chromium.org>
> > > >
> > > > If a GEM object is allocated, and then exported as a dma-buf fd whi=
ch is
> > > > mmap'd before or without the GEM buffer being directly mmap'd, the
> > > > vma_node could be unitialized.  This leads to a situation where the=
 CPU
> > > > mapping is not correctly torn down in drm_vma_node_unmap().
> > >
> > > Which drivers are affected by this problem?
> > >
> > > I checked several drivers and most appear to be initializing the offs=
et
> > > during object construction, such as GEM SHMEM. [1] TTM-based drivers
> > > also seem unaffected. [2]
> > >
> > >  From a quick grep, only etnaviv, msm and omapdrm appear to be affect=
ed?
> > > They only seem to run drm_gem_create_mmap_offset() from their
> > > ioctl-handling code.
> > >
> > > If so, I'd say it's preferable to fix these drivers and put a
> > > drm_WARN_ONCE() into drm_gem_prime_mmap().
> >
> > That is good if fewer drivers are affected, however I disagree with
> > your proposal.  At least for freedreno userspace, a lot of bo's never
> > get mmap'd (either directly of via dmabuf), so we should not be
> > allocating a mmap offset unnecessarily.
>
> Does this actually matter in the grand scheme of things? We originally
> allocated mmap offset only on demand because userspace only had 32bit
> loff_t support and so simply couldn't mmap anything if the offset
> ended up above 32bit (even if there was still va space available).
>
> But those days are long gone (about 10 years or so) and the allocation
> overhead for an mmap offset is tiny. So I think unless you can
> benchmark an impact allocating it at bo alloc seems like the simplest
> design overall, and hence what we should be doing. And if the vma
> offset allocation every gets too slow due to fragmentation we can lift
> the hole tree from i915 into drm_mm and the job should be done. At
> that point we could also allocate the offset unconditionally in the
> gem_init function and be done with it.
>
> Iow I concur with Thomas here, unless there's hard data contrary
> simplicity imo trumps here.

32b userspace is still alive and well, at least on arm chromebooks ;-)

BR,
-R

> -Daniel
>
> >
> > BR,
> > -R
> >
> > > Best regards
> > > Thomas
> > >
> > > [1]
> > > https://elixir.bootlin.com/linux/v5.18/source/drivers/gpu/drm/drm_gem=
_shmem_helper.c#L85
> > > [2]
> > > https://elixir.bootlin.com/linux/v5.18/source/drivers/gpu/drm/ttm/ttm=
_bo.c#L1002
> > >
> > > >
> > > > Fixes: e5516553999f ("drm: call drm_gem_object_funcs.mmap with fake=
 offset")
> > > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > > ---
> > > > Note, it's possible the issue existed in some related form prior to=
 the
> > > > commit tagged with Fixes.
> > > >
> > > >   drivers/gpu/drm/drm_prime.c | 5 +++++
> > > >   1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prim=
e.c
> > > > index e3f09f18110c..849eea154dfc 100644
> > > > --- a/drivers/gpu/drm/drm_prime.c
> > > > +++ b/drivers/gpu/drm/drm_prime.c
> > > > @@ -716,6 +716,11 @@ int drm_gem_prime_mmap(struct drm_gem_object *=
obj, struct vm_area_struct *vma)
> > > >       struct file *fil;
> > > >       int ret;
> > > >
> > > > +     /* Ensure that the vma_node is initialized: */
> > > > +     ret =3D drm_gem_create_mmap_offset(obj);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > >       /* Add the fake offset */
> > > >       vma->vm_pgoff +=3D drm_vma_node_start(&obj->vma_node);
> > > >
> > >
> > > --
> > > Thomas Zimmermann
> > > Graphics Driver Developer
> > > SUSE Software Solutions Germany GmbH
> > > Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
> > > (HRB 36809, AG N=C3=BCrnberg)
> > > Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev
>
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
