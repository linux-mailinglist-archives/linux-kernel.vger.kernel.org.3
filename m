Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AA258EEF6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 17:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbiHJPIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 11:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiHJPI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 11:08:29 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672E96C12F;
        Wed, 10 Aug 2022 08:08:28 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id h138so12348521iof.12;
        Wed, 10 Aug 2022 08:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=P8TXeNV+7zskV8fKSSy2utDBKNnP7PwHXswFotxFdK0=;
        b=WSpLVtuzfN5igBK8LD8eFpSXdWpwPBUjySGUljTob+BUjSVxKylVO7RDdomFHBrH8B
         jFvSm6eJkbuw5XlkXEaQGHqaatqFW7VEHvQAgl1jx/b4vTlpmCgEO1Qm8HA4U7lvAWQz
         hl9+/qx0cuemGM39X4lyM6r8ab9sNmDaCXYI4YSZ3LCprskOPyFHh/RssVwnfQZPDzqO
         Dt7JO4n6bBN3S9C7384h/zV3UT7z6ZhdOy5pwVMYj9KZH0aqWiaP+i0IXHscoTLQs7Yc
         nYna+23vqtrzY1+2tePKwaKhoZQfRuUZCvsnjEqlMgQYHg6C3dhyFZV/kHWkcmGsGcHS
         oI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=P8TXeNV+7zskV8fKSSy2utDBKNnP7PwHXswFotxFdK0=;
        b=xYXjSeZcZHULGqZwjYJugKpGPxSkKwhZEpyHp7PQ3Rd5WU56UuIUruA3Cz9677XpMR
         yzQ0P4aMvY+7KfrpFXmB4IqlvXXDNWx+N/eC2xH1ASQXPuTG4nuGeEMu0AeLB0Zb0xvf
         E9Ie6MlAhK9WuQct+wXtZ2UD8GdYNTQY0NJ03yaDwyLus8eOgrafuO+MBiItMDfQvbIx
         aZ4KoItHzwBVwMvumm5BBk3zB3UY8L9CMqCWWhyDsx8+sLpdkfoCA0bi5nnRwI/XQYKj
         Dsa+INJH6Nz44B2eSdPEXHlIgpmNTwnSfot7Mz/72z07IfmrcYpcDaH8dtmRBHiu182s
         8QOw==
X-Gm-Message-State: ACgBeo1+XQHg2ghVVLshRikGd6a9vYPMN0IlRmxuBAw3MoaTjvil1dok
        EaHDvF/zslPXmLvb7fpGR5i7DgjXwSIjMXShIW4=
X-Google-Smtp-Source: AA6agR74RZvvSswze2RlPU2jPG2C0znVnnazQXl+qZfN9DPU4Mu2uILtC9LaOZUSLAH9emrDZl1TfXxVIUeu5/kSLNk=
X-Received: by 2002:a05:6602:26c7:b0:67b:72ef:b87b with SMTP id
 g7-20020a05660226c700b0067b72efb87bmr11903368ioo.175.1660144107634; Wed, 10
 Aug 2022 08:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220701090240.1896131-1-dmitry.osipenko@collabora.com>
 <20220701090240.1896131-3-dmitry.osipenko@collabora.com> <2bb95e80-b60a-36c0-76c8-a06833032c77@amd.com>
 <CAF6AEGtqPeF1DjmBKgzWK39Yi81YiNjTjDNn85TKx7uwicFTSA@mail.gmail.com>
 <2a646ce4-c2ec-3b11-77a0-cc720afd6fe1@collabora.com> <YvOav/vF2awVWIu0@phenom.ffwll.local>
In-Reply-To: <YvOav/vF2awVWIu0@phenom.ffwll.local>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 10 Aug 2022 08:08:15 -0700
Message-ID: <CAF6AEGvfAJgwBe4+sK0gAkZ++MwH9x4=698C8XSnmfYNMFZqfA@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] drm/gem: Don't map imported GEMs
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Rob Clark <robdclark@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        linux-tegra@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        kernel@collabora.com
Cc:     Daniel Vetter <daniel@ffwll.ch>
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

On Wed, Aug 10, 2022 at 4:47 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Wed, Jul 06, 2022 at 10:02:07AM +0300, Dmitry Osipenko wrote:
> > On 7/6/22 00:48, Rob Clark wrote:
> > > On Tue, Jul 5, 2022 at 4:51 AM Christian K=C3=B6nig <christian.koenig=
@amd.com> wrote:
> > >>
> > >> Am 01.07.22 um 11:02 schrieb Dmitry Osipenko:
> > >>> Drivers that use drm_gem_mmap() and drm_gem_mmap_obj() helpers don'=
t
> > >>> handle imported dma-bufs properly, which results in mapping of some=
thing
> > >>> else than the imported dma-buf. On NVIDIA Tegra we get a hard locku=
p when
> > >>> userspace writes to the memory mapping of a dma-buf that was import=
ed into
> > >>> Tegra's DRM GEM.
> > >>>
> > >>> Majority of DRM drivers prohibit mapping of the imported GEM object=
s.
> > >>> Mapping of imported GEMs require special care from userspace since =
it
> > >>> should sync dma-buf because mapping coherency of the exporter devic=
e may
> > >>> not match the DRM device. Let's prohibit the mapping for all DRM dr=
ivers
> > >>> for consistency.
> > >>>
> > >>> Suggested-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.c=
om>
> > >>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > >>
> > >> I'm pretty sure that this is the right approach, but it's certainly =
more
> > >> than possible that somebody abused this already.
> > >
> > > I suspect that this is abused if you run deqp cts on android.. ie. al=
l
> > > winsys buffers are dma-buf imports from gralloc.  And then when you
> > > hit readpix...
> > >
> > > You might only hit this in scenarios with separate gpu and display (o=
r
> > > dGPU+iGPU) because self-imports are handled differently in
> > > drm_gem_prime_import_dev().. and maybe not in cases where you end up
> > > with a blit from tiled/compressed to linear.. maybe that narrows the
> > > scope enough to just fix it in userspace?
> >
> > Given that that only drivers which use DRM-SHMEM potentially could've
> > map imported dma-bufs (Panfrost, Lima) and they already don't allow to
> > do that, I think we're good.
>
> So can I have an ack from Rob here or are there still questions that this
> might go boom?
>
> Dmitry, since you have a bunch of patches merged now I think would also b=
e
> good to get commit rights so you can drive this more yourself. I've asked
> Daniel Stone to help you out with getting that.

I *think* we'd be ok with this on msm, mostly just by dumb luck.
Because the dma-buf's we import will be self-import.  I'm less sure
about panfrost (src/panfrost/lib/pan_bo.c doesn't seem to have a
special path for imported dma-bufs either, and in that case they won't
be self-imports.. but I guess no one has tried to run android cts on
panfrost).

What about something less drastic to start, like (apologies for
hand-edited patch):

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 86d670c71286..fc9ec42fa0ab 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1034,6 +1034,10 @@ int drm_gem_mmap_obj(struct drm_gem_object
*obj, unsigned long obj_size,
 {
        int ret;

+       WARN_ON_ONCE(obj->import_attach);
+
        /* Check for valid size. */
        if (obj_size < vma->vm_end - vma->vm_start)
                return -EINVAL;
diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c
b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 8ad0e02991ca..6190f5018986 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -609,17 +609,8 @@ EXPORT_SYMBOL_GPL(drm_gem_shmem_vm_ops);
  */
 int drm_gem_shmem_mmap(struct drm_gem_shmem_object *shmem, struct
vm_area_struct *vma)
 {
-       struct drm_gem_object *obj =3D &shmem->base;
        int ret;

        if (obj->import_attach) {
-               /* Drop the reference drm_gem_mmap_obj() acquired.*/
-               drm_gem_object_put(obj);
-               vma->vm_private_data =3D NULL;
-
-               return dma_buf_mmap(obj->dma_buf, vma, 0);
+               return -EINVAL;
        }

        ret =3D drm_gem_shmem_get_pages(shmem);
        if (ret) {
                drm_gem_vm_close(vma);
--
2.36.1
