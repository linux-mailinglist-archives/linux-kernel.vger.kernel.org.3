Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407BD5401F2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244808AbiFGO6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343800AbiFGO6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:58:37 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C63F68B2;
        Tue,  7 Jun 2022 07:58:34 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a15so16031432wrh.2;
        Tue, 07 Jun 2022 07:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w/x0GYJIyglYGzsLMtcs2N+UdxoGHu5iQjLjq7gDOa8=;
        b=mnolo5fLNDdBuBMvlwaCPryzz8RBix8JR7j5txmuj3HpmexQIJcKZ0WRj2TDLOGlKV
         eYi7+7ZJHGeQve1+oBuw+oLFq7T9Yr+xLFozhFvuSZar1J0XmxxdFE5aozzgXRt3P06K
         Y2sq5jwvUjX6GibC1NrppLGFBqwd2rXJYZ3XqJGbNXxvgsrR2sWENE1FYtj0ajqZ9MMR
         bfyL9nr4gBdbp4Vq4N5lVOffSCj0v+rbe8am4yZYbkvuBfvwtorzMCXREQkALIJ5+6Tb
         FnnWBEbeTqOOWnNdVWaaWKsWZbdpeuN/wJ15uIQBpt6yQh9S0tU0fPdBqwh43ZFLKx3h
         h1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w/x0GYJIyglYGzsLMtcs2N+UdxoGHu5iQjLjq7gDOa8=;
        b=2aQqKC4RQDE6fn7OXBE3a9Epg95KqSdpcHTGCTZAgE6/NvqKJZH5SeMzBw0JUxaY9s
         TTltrvmNXultivnuKgBd1nnqZ7CbvWiKTRl7F/yJGP9aCgGVHvi1XGx1ErDcd1zilZlA
         uARPG4VBjmDM5rCbhlQuMQNWVdsf6Mpmx3iaLOdtFzIAzfGLlzhHYAx6iqeqk0TNWPJx
         Qtqw5YXMwairt+oqAmOescwTij+FPjvVywAFdfoa7nDT2koDVjVmZ8D45Pb7mmMMgpPY
         8Rlb9pmzvH6Z5qDLTXdJsvsIcZQP41iEHmnzdFSEG93Fn9vI1t0IAeo4yMOJlFqwae9g
         e0Ig==
X-Gm-Message-State: AOAM532qjRWmeoWiBiQvBrMHQ5fq2b7PuwcUwWbOod5rX+QRx+iET9DR
        RJoDbAg7Hr2c2Q/uPsI37k0k8ptxbu5q4dJfv8M=
X-Google-Smtp-Source: ABdhPJwRNN4z4XBKhcVm2933w90dY8yGBFVxOqV2cYUSjdAP95m0E38O7iji7hfuIr68iVFLPD1tEZKwD7DNfMrpJnk=
X-Received: by 2002:adf:fb0d:0:b0:20d:97e:17ce with SMTP id
 c13-20020adffb0d000000b0020d097e17cemr28428199wrr.585.1654613913189; Tue, 07
 Jun 2022 07:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220606195432.1888346-1-robdclark@gmail.com> <34aacfa3-9eb9-d3d5-07b7-805fd1408bb7@suse.de>
In-Reply-To: <34aacfa3-9eb9-d3d5-07b7-805fd1408bb7@suse.de>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 7 Jun 2022 07:58:36 -0700
Message-ID: <CAF6AEGuikc8Qh2ixEvJoeN0hQ+VLJNk_jBQm8fqYQAJ=ihpo1g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm: Add DRM_GEM_FOPS
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
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

On Mon, Jun 6, 2022 at 11:56 PM Thomas Zimmermann <tzimmermann@suse.de> wro=
te:
>
> Hi
>
> Am 06.06.22 um 21:54 schrieb Rob Clark:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > The DEFINE_DRM_GEM_FOPS() helper is a bit limiting if a driver wants to
> > provide additional file ops, like show_fdinfo().
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >   include/drm/drm_gem.h | 26 ++++++++++++++++++--------
> >   1 file changed, 18 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> > index 9d7c61a122dc..dc88d4a2cdf6 100644
> > --- a/include/drm/drm_gem.h
> > +++ b/include/drm/drm_gem.h
> > @@ -314,6 +314,23 @@ struct drm_gem_object {
> >       const struct drm_gem_object_funcs *funcs;
> >   };
> >
> > +/**
> > + * DRM_GEM_FOPS - Default drm GEM file operations
> > + *
> > + * This macro provides a shorthand for setting the GEM file ops in the
> > + * &file_operations structure.
>
> I would appreciate a reference to DEFINE_DRM_GEM_FOPS. Something along
> the lines of 'if all you need are the default ops, use DEFINE_DRM_GEM_FOP=
S'.
>
> > + */
> > +#define DRM_GEM_FOPS \
> > +     .open           =3D drm_open,\
> > +     .release        =3D drm_release,\
> > +     .unlocked_ioctl =3D drm_ioctl,\
> > +     .compat_ioctl   =3D drm_compat_ioctl,\
> > +     .poll           =3D drm_poll,\
> > +     .read           =3D drm_read,\
> > +     .llseek         =3D noop_llseek,\
> > +     .mmap           =3D drm_gem_mmap
> > +
> > +
>
> Only one empty line please.
>
> >   /**
> >    * DEFINE_DRM_GEM_FOPS() - macro to generate file operations for GEM =
drivers
> >    * @name: name for the generated structure
> > @@ -330,14 +347,7 @@ struct drm_gem_object {
> >   #define DEFINE_DRM_GEM_FOPS(name) \
> >       static const struct file_operations name =3D {\
> >               .owner          =3D THIS_MODULE,\
>
> Is there a specific reason why .owner is still set here? I suspect that
> DRM_GEM_FOPS is strictly for callback functions?

I was on the fence about that one, but it seemed better to not mix
"magic" and the callbacks.. but I could be convinced in either
direction

> In any case
>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

thx, I'll fixup the other nits in v3.

>
> Best regards
> Thomas
>
> > -             .open           =3D drm_open,\
> > -             .release        =3D drm_release,\
> > -             .unlocked_ioctl =3D drm_ioctl,\
> > -             .compat_ioctl   =3D drm_compat_ioctl,\
> > -             .poll           =3D drm_poll,\
> > -             .read           =3D drm_read,\
> > -             .llseek         =3D noop_llseek,\
> > -             .mmap           =3D drm_gem_mmap,\
> > +             DRM_GEM_FOPS,\
> >       }
> >
> >   void drm_gem_object_release(struct drm_gem_object *obj);
>
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
> (HRB 36809, AG N=C3=BCrnberg)
> Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev
