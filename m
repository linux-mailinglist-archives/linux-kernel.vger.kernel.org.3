Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BF858E8D8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 10:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbiHJIeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 04:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbiHJIdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 04:33:40 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA3C5726A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 01:33:34 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id n133so16946435oib.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 01:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=qng18ezuViFS4JHv1suUwHMOD3dA0ddp/TS8ruYkzxY=;
        b=Xo7HewGoXQ93vdJ673ZkR+tcoUdDl9VfPro55Vby9VrJvIMSVQRWW+l8IzswksIecM
         FJ23GJpiXQh/pyuvnpU5g3iQbV02xodcvNiDJwDMgL67ZXX2fNtmG9OBAvT/AJiLKz1O
         m57OQJzScr8ptLkEC3wAZsB50Mtf/5dHx8myw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=qng18ezuViFS4JHv1suUwHMOD3dA0ddp/TS8ruYkzxY=;
        b=qkgWJeQv1/FWU1QQmlK0U/AxRqSkTku5uLgEYh1SWBjYHsi6hfusgTrJ4mu6sr2WMJ
         gezbFYCVCpTPZq5agYob3dSeI0MQVGtCd1H1kcvkBXRKR1eyivAbdgARSNJyMyxIsiN7
         psL4L6zxawA0zpkdxJIXNqhNzY+SiUGQCjBU2k31KZHYiXYLtu3TlFPKwpZNY91L7VBZ
         PTZY8g0pps/e3CT1bP21+5DwX4AugD4ck0yKDW+acZQnlPk0AK0kxBSwovMjtuibcONS
         P6Q5zcr4eb2qbWLIYSYlprLBJnO9J9iCiYpuR48T+3KJuiK7lx9egyMKknEromTRnq2U
         9SYw==
X-Gm-Message-State: ACgBeo2tpjdbOp1t31YIdli/o8TYXODMjODfDr2DVRR4Y5idiOOX1i2U
        kk9o7GMDpKo3tbMM3kv9nopz7K0rhQfGGZMZfegOww==
X-Google-Smtp-Source: AA6agR6cStCNNsa+U2EXzNpks0Z071z2RD/SJln63AZJsOezVgSlE5S5WcCDeNCK/XxqGOBfJDhs4RSMetdDlNSIpBY=
X-Received: by 2002:a05:6808:1489:b0:33a:861c:838e with SMTP id
 e9-20020a056808148900b0033a861c838emr895072oiw.228.1660120413972; Wed, 10 Aug
 2022 01:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220701090240.1896131-1-dmitry.osipenko@collabora.com>
 <20220701090240.1896131-2-dmitry.osipenko@collabora.com> <a42237c9-6304-4b06-cede-2175c7e7b87d@amd.com>
 <YvKO5r5Sr56e9vBf@phenom.ffwll.local> <e760f555-7f2d-dea9-70b2-c0881adc3afc@amd.com>
In-Reply-To: <e760f555-7f2d-dea9-70b2-c0881adc3afc@amd.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 10 Aug 2022 10:33:22 +0200
Message-ID: <CAKMK7uEd1xX6P4YRgYOfjvqpwVmQ0YZPkHdK=4auwrkBE9CEzQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] drm/gem: Properly annotate WW context on
 drm_gem_lock_reservations() error
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-tegra@vger.kernel.org, kernel@collabora.com,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2022 at 08:52, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> Am 09.08.22 um 18:44 schrieb Daniel Vetter:
> > On Tue, Jul 05, 2022 at 01:33:51PM +0200, Christian K=C3=B6nig wrote:
> >> Am 01.07.22 um 11:02 schrieb Dmitry Osipenko:
> >>> Use ww_acquire_fini() in the error code paths. Otherwise lockdep
> >>> thinks that lock is held when lock's memory is freed after the
> >>> drm_gem_lock_reservations() error. The ww_acquire_context needs to be
> >>> annotated as "released", which fixes the noisy "WARNING: held lock fr=
eed!"
> >>> splat of VirtIO-GPU driver with CONFIG_DEBUG_MUTEXES=3Dy and enabled =
lockdep.
> >>>
> >>> Cc: stable@vger.kernel.org
> >>> Fixes: 7edc3e3b975b5 ("drm: Add helpers for locking an array of BO re=
servations.")
> >>> Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> >>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Also added this r-b tag when merging to drm-misc-next-fixes.
>
> IIRC I've already pushed this to drm-misc-fixes with a CC stable tag
> about 2 weeks ago.
>
> Please double check, it probably just hasn't come down the stream again y=
et.

Hm quickly check and I didn't spot it? There's a few patches from
Dmitry in the last few pulls, and some more stuff pending, but not
these two afaics?
-Daniel

>
> Christian.
>
> > -Daniel
> >
> >>> ---
> >>>    drivers/gpu/drm/drm_gem.c | 4 ++--
> >>>    1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> >>> index eb0c2d041f13..86d670c71286 100644
> >>> --- a/drivers/gpu/drm/drm_gem.c
> >>> +++ b/drivers/gpu/drm/drm_gem.c
> >>> @@ -1226,7 +1226,7 @@ drm_gem_lock_reservations(struct drm_gem_object=
 **objs, int count,
> >>>             ret =3D dma_resv_lock_slow_interruptible(obj->resv,
> >>>                                                              acquire_=
ctx);
> >>>             if (ret) {
> >>> -                   ww_acquire_done(acquire_ctx);
> >>> +                   ww_acquire_fini(acquire_ctx);
> >>>                     return ret;
> >>>             }
> >>>     }
> >>> @@ -1251,7 +1251,7 @@ drm_gem_lock_reservations(struct drm_gem_object=
 **objs, int count,
> >>>                             goto retry;
> >>>                     }
> >>> -                   ww_acquire_done(acquire_ctx);
> >>> +                   ww_acquire_fini(acquire_ctx);
> >>>                     return ret;
> >>>             }
> >>>     }
>


--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
