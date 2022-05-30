Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD1C5384EF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 17:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239717AbiE3P31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 11:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242281AbiE3P3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 11:29:13 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000601DE8E0;
        Mon, 30 May 2022 07:32:48 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h5so6822435wrb.0;
        Mon, 30 May 2022 07:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gSTJ1X2wuqX0lNp5B2IPR5UrMFLMFHeOCXzMZ0hn2b4=;
        b=OsFLSUzvyABeW29XWfSvKzCGNQnyj+ADgKauQh4p9sWs1MaqIZbckKyZTwq6O9poQn
         C74ES4SMcuigLnfMiVRuygm6ZTO0pkcwYbkLuBBCHKMpRuYnjNsNn+GfhmqVs6U7vamO
         xcEdrZOejon5nwrtb5Zm07ZriInzEsvdyRNMP1UrtLa+3i8Ad+n/B0L/v7+4yddZg0eU
         zdJ1Yml71RFWuHRuPr5Y2IMz2pcCXbZlE8rkotGQyGj8NmCD3dJKC1Gs6eoSZCvhJp+U
         kLV/muHTMpSb08fAG82Yetymgk6+YNCKDvaLbnIWBRQGdkVfo+bmBzedobhJQKGhbj29
         fT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gSTJ1X2wuqX0lNp5B2IPR5UrMFLMFHeOCXzMZ0hn2b4=;
        b=F4cdIcbZjjk79ZUtiXII5ejbyVWPjYbP5wC4Im1K0D6GkYAHGHfj5pcESHweSmyCW8
         wZpRQkwO6mpGceNS/dPeF+/jlSlrj8MTF8b4iNBWlhmIhZ3BPnvyIOI9tOeVeD6K1TEq
         Zp6j3P4vqrvK5m8X/cEsOkpzA51MA1FrsoSChPztLhU3MCflT5QCfRIWF7lXBndhD8wf
         EEsM2medxbRwSt2RwLZUxTHzroCvmd9Qbz/bTtCGpCGdLp+89QCUt4FsTHNjuO9X8iF0
         G3fDRUH4ZFQwxGFih+7u8PwLjD9/92HAnXdtlFoOCOmTg2QEui7tznlyIPxPkystcpWk
         q4+g==
X-Gm-Message-State: AOAM533446JhGnuDVY65ljTJujdrEjyX2Le9681c6MRbBRff94Ydm1Vy
        BEy0XdFEG7yphDeyS0MQjviiU2LIZP6KBFMwjyY=
X-Google-Smtp-Source: ABdhPJzn3Xi0lceSImCJ9R+jP77+VllF+ZZP4ZhztUgDtItqbVmUaA9faRS23xFdbwO4BeGKAXv8o3o8lRcMS3aMsDU=
X-Received: by 2002:a05:6000:547:b0:20f:ca41:cc51 with SMTP id
 b7-20020a056000054700b0020fca41cc51mr36432204wrf.221.1653921166691; Mon, 30
 May 2022 07:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220529162936.2539901-1-robdclark@gmail.com> <0bf230f4-c888-b9c9-f061-7450406baa4a@suse.de>
 <CAF6AEGthAfWyAvbuE4EP+u52LEKS2Fs6X=gG8qUjc7gci6oh-A@mail.gmail.com> <6169ea6b-7452-e8e3-f253-1329f4924a67@suse.de>
In-Reply-To: <6169ea6b-7452-e8e3-f253-1329f4924a67@suse.de>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 30 May 2022 07:32:45 -0700
Message-ID: <CAF6AEGt2GOTgwqdfLJXbMcMcSpA=cuZ=kiaOcLWVg905JM_caA@mail.gmail.com>
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

On Mon, May 30, 2022 at 7:16 AM Thomas Zimmermann <tzimmermann@suse.de> wro=
te:
>
> Hi
>
> Am 30.05.22 um 15:47 schrieb Rob Clark:
> > On Mon, May 30, 2022 at 12:26 AM Thomas Zimmermann <tzimmermann@suse.de=
> wrote:
> >>
> >> Hi
> >>
> >> Am 29.05.22 um 18:29 schrieb Rob Clark:
> >>> From: Rob Clark <robdclark@chromium.org>
> >>>
> >>> If a GEM object is allocated, and then exported as a dma-buf fd which=
 is
> >>> mmap'd before or without the GEM buffer being directly mmap'd, the
> >>> vma_node could be unitialized.  This leads to a situation where the C=
PU
> >>> mapping is not correctly torn down in drm_vma_node_unmap().
> >>
> >> Which drivers are affected by this problem?
> >>
> >> I checked several drivers and most appear to be initializing the offse=
t
> >> during object construction, such as GEM SHMEM. [1] TTM-based drivers
> >> also seem unaffected. [2]
> >>
> >>   From a quick grep, only etnaviv, msm and omapdrm appear to be affect=
ed?
> >> They only seem to run drm_gem_create_mmap_offset() from their
> >> ioctl-handling code.
> >>
> >> If so, I'd say it's preferable to fix these drivers and put a
> >> drm_WARN_ONCE() into drm_gem_prime_mmap().
> >
> > That is good if fewer drivers are affected, however I disagree with
> > your proposal.  At least for freedreno userspace, a lot of bo's never
> > get mmap'd (either directly of via dmabuf), so we should not be
> > allocating a mmap offset unnecessarily.
>
> I see.
>
> I the reason I'm arguing against the current patch is that the fix
> appears like a workaround and 6 months from now, few will remember why
> it's there. Especially since most drivers initialize the offset
> correctly. (Not too long ago, I refactored the handling of these mmap
> calls throughout DRM drivers and it was confusing at times.)

I dispute the "correctly" part.. and that this is a workaround ;-)

But I can send a v2 with the addition of a comment explaining the
reason, so git-blame archeology isn't required to understand the
reasoning

BR,
-R

> So here's another suggestion:  I further looked at the 3 drivers that I
> mentioned. etnaviv and msm can easily wrap the call to
> drm_gem_prime_mmap() and init the offset first. [1][2]  omapdrm doesn't
> actually use drm_gem_prime_mmap(). The offset can instead be initialized
> at the top of the driver's dmabuf mmap function. [3]
>
> Best regards
> Thomas
>
> [1]
> https://elixir.bootlin.com/linux/v5.18/source/drivers/gpu/drm/etnaviv/etn=
aviv_drv.c#L480
> [2]
> https://elixir.bootlin.com/linux/v5.18/source/drivers/gpu/drm/msm/msm_drv=
.c#L961
> [3]
> https://elixir.bootlin.com/linux/v5.18/source/drivers/gpu/drm/omapdrm/oma=
p_gem_dmabuf.c#L66
>
> >
> > BR,
> > -R
> >
> >> Best regards
> >> Thomas
> >>
> >> [1]
> >> https://elixir.bootlin.com/linux/v5.18/source/drivers/gpu/drm/drm_gem_=
shmem_helper.c#L85
> >> [2]
> >> https://elixir.bootlin.com/linux/v5.18/source/drivers/gpu/drm/ttm/ttm_=
bo.c#L1002
> >>
> >>>
> >>> Fixes: e5516553999f ("drm: call drm_gem_object_funcs.mmap with fake o=
ffset")
> >>> Signed-off-by: Rob Clark <robdclark@chromium.org>
> >>> ---
> >>> Note, it's possible the issue existed in some related form prior to t=
he
> >>> commit tagged with Fixes.
> >>>
> >>>    drivers/gpu/drm/drm_prime.c | 5 +++++
> >>>    1 file changed, 5 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.=
c
> >>> index e3f09f18110c..849eea154dfc 100644
> >>> --- a/drivers/gpu/drm/drm_prime.c
> >>> +++ b/drivers/gpu/drm/drm_prime.c
> >>> @@ -716,6 +716,11 @@ int drm_gem_prime_mmap(struct drm_gem_object *ob=
j, struct vm_area_struct *vma)
> >>>        struct file *fil;
> >>>        int ret;
> >>>
> >>> +     /* Ensure that the vma_node is initialized: */
> >>> +     ret =3D drm_gem_create_mmap_offset(obj);
> >>> +     if (ret)
> >>> +             return ret;
> >>> +
> >>>        /* Add the fake offset */
> >>>        vma->vm_pgoff +=3D drm_vma_node_start(&obj->vma_node);
> >>>
> >>
> >> --
> >> Thomas Zimmermann
> >> Graphics Driver Developer
> >> SUSE Software Solutions Germany GmbH
> >> Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
> >> (HRB 36809, AG N=C3=BCrnberg)
> >> Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev
>
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
> (HRB 36809, AG N=C3=BCrnberg)
> Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev
