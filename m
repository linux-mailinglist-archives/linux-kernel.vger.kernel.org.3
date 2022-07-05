Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34854567982
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 23:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbiGEVs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 17:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbiGEVsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 17:48:25 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECE510AF;
        Tue,  5 Jul 2022 14:48:23 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so8080069wme.0;
        Tue, 05 Jul 2022 14:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PU7Lk/8Sax5XmlQiaVaA1dEst+rO/Dc76xfk8EMg5rU=;
        b=VWKoc1vTC7dmodEJ7AnbFDZ5fs/4+Nq8GI6aDF//zH1sFJE8ous9N8DVmhCdNBDu7J
         TEV0OZ7bot7bTz3H4yd56ZRrkwxGIFMbiNXyMqyxTYq3VKR1u9rg6rHhTYMEXhscqSPb
         Ccm6AxwWMhv1d8/+zxJYMjbHjFhlhaXe+b5fXKLXVU2U8ZbZY80EwHbaMEMkj/MpnXbt
         Uw0LZyDNux3g8GLLZXWynLp0GUTzkeUfRCaJubH+VuWeVBLJXqR6LPAfYZV768F05DkS
         81qT5rHG43qh7gdNNw7b8ZC4JsCyyDamnVIJ9F70HPL12MxnnMZIoo1SVum0jci5LIaF
         DoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PU7Lk/8Sax5XmlQiaVaA1dEst+rO/Dc76xfk8EMg5rU=;
        b=BHzZCVcA51KikK3eBRptwRhimizcV57bdkg3j6/yveqmvKVagPPEm57yggJ7Tb6Pe+
         3bYms8OlDHFtsAXmCXow2ZUGd2I5f3H/kPmpg/05vS47G1HT8Cret2dNAuiN1a++RzVa
         +hip0s3OrQBIc+wdUs9xmwMynRw5roYwHmZUdiQaZNbom+KlbPnuV7vMYS7Ry6YZCHDa
         Y7tEJLZsTsrjfdTVeJfHEceE8T9C7p2WJR/PsUJPxSzreV4BkhDFQ4TCyY04/ayrucNB
         LltIbXXREfC6oT9wfEor8wQNsY2vHmB3z8UKK0o4qBT8Fz0XQCukNSAODgSGmtU8cPwq
         AcVw==
X-Gm-Message-State: AJIora8HdXQsxChXq21vzeItZKuOuiNfAyEh5PVdI1zUT8CTcbBd2fUS
        Ef44s7uhA2+CMDexJOSlbQvsvQ7GXRjbEUS3sOQ=
X-Google-Smtp-Source: AGRyM1s4DVmvwO3UYi3am/1hl7v5k+11uGFQz8SR7b/jLPUtCXxxfUROpF6gbwNkgnUr5Rze8aRIMeW9WGiopFicipE=
X-Received: by 2002:a05:600c:4f83:b0:3a1:7310:62e7 with SMTP id
 n3-20020a05600c4f8300b003a1731062e7mr36978255wmq.84.1657057702289; Tue, 05
 Jul 2022 14:48:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220701090240.1896131-1-dmitry.osipenko@collabora.com>
 <20220701090240.1896131-3-dmitry.osipenko@collabora.com> <2bb95e80-b60a-36c0-76c8-a06833032c77@amd.com>
In-Reply-To: <2bb95e80-b60a-36c0-76c8-a06833032c77@amd.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 5 Jul 2022 14:48:34 -0700
Message-ID: <CAF6AEGtqPeF1DjmBKgzWK39Yi81YiNjTjDNn85TKx7uwicFTSA@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] drm/gem: Don't map imported GEMs
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
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

On Tue, Jul 5, 2022 at 4:51 AM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> Am 01.07.22 um 11:02 schrieb Dmitry Osipenko:
> > Drivers that use drm_gem_mmap() and drm_gem_mmap_obj() helpers don't
> > handle imported dma-bufs properly, which results in mapping of somethin=
g
> > else than the imported dma-buf. On NVIDIA Tegra we get a hard lockup wh=
en
> > userspace writes to the memory mapping of a dma-buf that was imported i=
nto
> > Tegra's DRM GEM.
> >
> > Majority of DRM drivers prohibit mapping of the imported GEM objects.
> > Mapping of imported GEMs require special care from userspace since it
> > should sync dma-buf because mapping coherency of the exporter device ma=
y
> > not match the DRM device. Let's prohibit the mapping for all DRM driver=
s
> > for consistency.
> >
> > Suggested-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>
> I'm pretty sure that this is the right approach, but it's certainly more
> than possible that somebody abused this already.

I suspect that this is abused if you run deqp cts on android.. ie. all
winsys buffers are dma-buf imports from gralloc.  And then when you
hit readpix...

You might only hit this in scenarios with separate gpu and display (or
dGPU+iGPU) because self-imports are handled differently in
drm_gem_prime_import_dev().. and maybe not in cases where you end up
with a blit from tiled/compressed to linear.. maybe that narrows the
scope enough to just fix it in userspace?

BR,
-R

> Anyway patch is Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.c=
om>
> since you are really fixing a major stability problem here.
>
> Regards,
> Christian.
>
> > ---
> >   drivers/gpu/drm/drm_gem.c              | 4 ++++
> >   drivers/gpu/drm/drm_gem_shmem_helper.c | 9 ---------
> >   2 files changed, 4 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> > index 86d670c71286..fc9ec42fa0ab 100644
> > --- a/drivers/gpu/drm/drm_gem.c
> > +++ b/drivers/gpu/drm/drm_gem.c
> > @@ -1034,6 +1034,10 @@ int drm_gem_mmap_obj(struct drm_gem_object *obj,=
 unsigned long obj_size,
> >   {
> >       int ret;
> >
> > +     /* Don't allow imported objects to be mapped */
> > +     if (obj->import_attach)
> > +             return -EINVAL;
> > +
> >       /* Check for valid size. */
> >       if (obj_size < vma->vm_end - vma->vm_start)
> >               return -EINVAL;
> > diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/d=
rm_gem_shmem_helper.c
> > index 8ad0e02991ca..6190f5018986 100644
> > --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> > +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> > @@ -609,17 +609,8 @@ EXPORT_SYMBOL_GPL(drm_gem_shmem_vm_ops);
> >    */
> >   int drm_gem_shmem_mmap(struct drm_gem_shmem_object *shmem, struct vm_=
area_struct *vma)
> >   {
> > -     struct drm_gem_object *obj =3D &shmem->base;
> >       int ret;
> >
> > -     if (obj->import_attach) {
> > -             /* Drop the reference drm_gem_mmap_obj() acquired.*/
> > -             drm_gem_object_put(obj);
> > -             vma->vm_private_data =3D NULL;
> > -
> > -             return dma_buf_mmap(obj->dma_buf, vma, 0);
> > -     }
> > -
> >       ret =3D drm_gem_shmem_get_pages(shmem);
> >       if (ret) {
> >               drm_gem_vm_close(vma);
>
