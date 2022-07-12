Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB79572164
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbiGLQvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbiGLQu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:50:58 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA939CD3CE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:50:57 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id f2so11994030wrr.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gUq4aoUBvcByToPP+7UKCjXNaAh3FW4+50wwxtlcpGU=;
        b=JEJsrYrsJsr22QMN1yr81Aorvtq5Ct8d8HgnV/jPqm81K6bJ32bYeLFSODfJeqUX3Q
         4PwypjJzRNWcdo/pdUWwQc0MhCHufvduRJDkzXBQ19M/AZUclVle7bMxmlwOnOAr6Q66
         8s1RuD7cdiFMGtEc83MFecs4GyepKCmIwwooW6xEp+D0tmrJWiCv6SgdoAD5Qxrb7aFS
         Wy2StusuL6qBeDsuol606vvabAG0Xn7wXPP6HHwsy1aRYFaEuqyOXK4wSvq8yXSj0YtE
         mV02CRyZfJjCgIpIJh02WCSsPq9jYM6XncFxmXt2ndIqnRkD23NJ1a/opd68njNnCDrl
         upHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gUq4aoUBvcByToPP+7UKCjXNaAh3FW4+50wwxtlcpGU=;
        b=qiReUzwHeEGZXSxtyuCl7wExlHOY01XCN7GNlS36rNm16HGkYNoRUUL6SiWFG/5R6W
         9vHkZkOs2FGiK46OGAZtYCUFwb3eaqJAsrwiPS1jxDjBaECNk51r0MbOFuLQPvzglwmG
         vlV74/wPfXsLjX96IK/rAgJ6e4DUygD+2Caj396bz8h1EgkJYC/wp+RJY7y8rA9TGIM+
         DNQ+MuVBrjjJ/sJuNnBsBlT9M4PYcLAtdHlyVrU/mnBki7z6/7ye2r2Dz0dyTWEe3jA0
         evjXCp0Bp5rcfPajvp3mZ5G8hRFKywQ33yGhdjmG/Iy8VRMASsf6xqJO5DwrAS/i0glx
         1U4g==
X-Gm-Message-State: AJIora8+u97Y3l8yY22V8FwgfHYRRlJXgdE7pBKWTdAzg+JSZsMsZJs2
        wVDI9ldNqHvawRuID3lHaji+OCG3jAtuBlxg9HP+C8cOY60c
X-Google-Smtp-Source: AGRyM1ss2apZFJS9xIlHo11FoTeRrFiKUVCgHVHsLGjP6oHcSPVWodn6AasEsHrm2u39Ss+yNO+vO0PyKEA7Gtd/Qh4=
X-Received: by 2002:adf:e804:0:b0:21d:6e85:7550 with SMTP id
 o4-20020adfe804000000b0021d6e857550mr24217908wrm.337.1657644656109; Tue, 12
 Jul 2022 09:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220712042258.293010-1-jstultz@google.com> <20220712042258.293010-2-jstultz@google.com>
 <6e490429-e34c-fa51-c6d9-3315c4639d9d@amd.com>
In-Reply-To: <6e490429-e34c-fa51-c6d9-3315c4639d9d@amd.com>
From:   John Stultz <jstultz@google.com>
Date:   Tue, 12 Jul 2022 09:50:44 -0700
Message-ID: <CANDhNCo1WAUC9DhGfT19Smq2Z5duruAAwOs6AWUWUvNAjZqgAg@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/3] drm: vgem: Enable SYNCOBJ and SYNCOBJ_TIMELINE
 on vgem driver
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 12:46 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 12.07.22 um 06:22 schrieb John Stultz:
> > Allows for basic SYNCOBJ api testing, in environments
> > like VMs where there may not be a supported drm driver.
> >
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: Jason Ekstrand <jason@jlekstrand.net>
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Cc: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
> > Cc: Chunming Zhou <david1.zhou@amd.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: John Stultz <jstultz@google.com>
> > ---
> >   drivers/gpu/drm/vgem/vgem_drv.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vge=
m_drv.c
> > index c5e3e5457737..e5427d7399da 100644
> > --- a/drivers/gpu/drm/vgem/vgem_drv.c
> > +++ b/drivers/gpu/drm/vgem/vgem_drv.c
> > @@ -109,7 +109,8 @@ static struct drm_gem_object *vgem_gem_create_objec=
t(struct drm_device *dev, siz
> >   }
> >
> >   static const struct drm_driver vgem_driver =3D {
> > -     .driver_features                =3D DRIVER_GEM | DRIVER_RENDER,
> > +     .driver_features                =3D DRIVER_GEM | DRIVER_RENDER |
> > +                                       DRIVER_SYNCOBJ | DRIVER_SYNCOBJ=
_TIMELINE,
>
> Well that's rather surprising. I'm not an export on VGEM, but AFAIK you
> need to adjust the CS interface to support that stuff as well.

Apologies, could you clarify a bit more what you mean here?  This was
just helpful to enable the generic userland ioctls for the example
test tool in this series.

Are you proposing to add interfaces so the vgem driver can
attach/signal syncobjs similar to the
DRM_IOCTL_VGEM_FENCE_ATTACH/DRM_IOCTL_VGEM_FENCE_SIGNAL calls?

thanks
-john
