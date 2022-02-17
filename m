Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F5A4B9C37
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 10:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238774AbiBQJks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 04:40:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238747AbiBQJkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 04:40:46 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C59E29720E;
        Thu, 17 Feb 2022 01:40:32 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id s8so2768492oij.13;
        Thu, 17 Feb 2022 01:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uhOJfm6H7seDFtparrRa6LVFSq5tSizAXtRZfKmDyxU=;
        b=O7qfDwrOyYJHNrXZmT/XCBCXsPd5PbpbwH6wv5sCvteVtj85muRvNxFwDu5hJ+5zwV
         7CRIi6DzaoYc6+lDkFbCIqnHqmn1CnSkUmHZoWFIFWwV7AUiPp+F1opnFUECx8JMEasi
         K3HXYRm941hMxMb0PEwQffUOtRUpq4w2lHIdbOlbsM5srVSSQixNGNv8IL6kX9p0uWFk
         S4U+kD5YfFIebrado0QkLzyne8pcU61SPvryIYGxjtiYUR7Jsa2nfj6ReDx2ht7QwTLn
         X3YYnJXrToVTLlnR5wAPxyL5slkBqAR/JUHVHNEjXmgFP6rHXygA96Td3ayOV8ysIJYX
         Kcmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uhOJfm6H7seDFtparrRa6LVFSq5tSizAXtRZfKmDyxU=;
        b=lUl4CBvI7laooQt/WWqByGYvHSFMubW9GAVuIxMhIlSEQmYoYE63/+4gUc8NM7K1m3
         eyxWIa+4vyUFL3daY1+4rfOjWr+UQc5sE6rKwszjy/KEXlzd1G+UUd+ocbrRU6sTwRuJ
         NOGBvMw5sRfQUlt0Az9r+y9OdSYMmOhlBwHIfXmk+tUJV8NmdGAsL1dtY1+A7KoAIndL
         w2y5j3ls7N30TnGaZWmdwVrjj/73tzFaYPKLlj0xcaYXt8CgknJT4YGD7HsbDy1cKJvP
         pwxG0hXDN47AilvUM9nFE00W2sn9gosP24ZvGTrO2f+vQhFsf7GuYpN7ZhWqlCPC3K7C
         yZ8g==
X-Gm-Message-State: AOAM531W+huKKUVgBiBLjfCQz9Vm+mnI+z111Et6ugp8T49ydz4fWksE
        pmMSKWeOAYUX3KmtZ+Cl8TueSBdMdJ0ILQjR/TI=
X-Google-Smtp-Source: ABdhPJzW3ysr0A/QNZN637zadxiYZAwSsq5TpxDuuAQxvChDfoDHi5vCMCyqiI2d2M6+0Mxp5rxQaZ5QlpMNaRhieYQ=
X-Received: by 2002:a05:6808:188b:b0:2d4:70f2:3cfa with SMTP id
 bi11-20020a056808188b00b002d470f23cfamr790214oib.168.1645090831535; Thu, 17
 Feb 2022 01:40:31 -0800 (PST)
MIME-Version: 1.0
References: <20220217090440.4468-1-qiang.yu@amd.com> <5d3fdd2c-e74a-49f4-2b28-32c06483236f@amd.com>
In-Reply-To: <5d3fdd2c-e74a-49f4-2b28-32c06483236f@amd.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Thu, 17 Feb 2022 17:40:19 +0800
Message-ID: <CAKGbVbtLTBJPF5eTu4rABUTBa8eqjQvqjo1AEUrzgPgYgCREuA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: check vm bo eviction valuable at last
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Qiang Yu <qiang.yu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 5:15 PM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 17.02.22 um 10:04 schrieb Qiang Yu:
> > Workstation application ANSA/META get this error dmesg:
> > [drm:amdgpu_gem_va_ioctl [amdgpu]] *ERROR* Couldn't update BO_VA (-16)
> >
> > This is caused by:
> > 1. create a 256MB buffer in invisible VRAM
> > 2. CPU map the buffer and access it causes vm_fault and try to move
> >     it to visible VRAM
> > 3. force visible VRAM space and traverse all VRAM bos to check if
> >     evicting this bo is valuable
> > 4. when checking a VM bo (in invisible VRAM), amdgpu_vm_evictable()
> >     will set amdgpu_vm->evicting, but latter due to not in visible
> >     VRAM, won't really evict it so not add it to amdgpu_vm->evicted
> > 5. before next CS to clear the amdgpu_vm->evicting, user VM ops
> >     ioctl will pass amdgpu_vm_ready() (check amdgpu_vm->evicted)
> >     but fail in amdgpu_vm_bo_update_mapping() (check
> >     amdgpu_vm->evicting) and get this error log
> >
> > This error won't affect functionality as next CS will finish the
> > waiting VM ops. But we'd better make the amdgpu_vm->evicting
> > correctly reflact the vm status and clear the error log.
>
> Well NAK, that is intentional behavior.
>
> The VM page tables where considered for eviction, so setting the flag is
> correct even when the page tables later on are not actually evicted.
>
But this will unnecessarily stop latter user VM ops in ioctl before CS
even when the VM bos are not evicted.
Won't this have any negative effect when could do better?

Regards,
Qiang

> What we should rather do is to fix amdgpu_vm_ready() to take a look at
> the flag instead of the linked list.
>
> Regards,
> Christian.
>
> >
> > Signed-off-by: Qiang Yu <qiang.yu@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 85 ++++++++++++++----------=
-
> >   1 file changed, 47 insertions(+), 38 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ttm.c
> > index 5a32ee66d8c8..88a27911054f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -1306,45 +1306,11 @@ uint64_t amdgpu_ttm_tt_pte_flags(struct amdgpu_=
device *adev, struct ttm_tt *ttm,
> >       return flags;
> >   }
> >
> > -/*
> > - * amdgpu_ttm_bo_eviction_valuable - Check to see if we can evict a bu=
ffer
> > - * object.
> > - *
> > - * Return true if eviction is sensible. Called by ttm_mem_evict_first(=
) on
> > - * behalf of ttm_bo_mem_force_space() which tries to evict buffer obje=
cts until
> > - * it can find space for a new object and by ttm_bo_force_list_clean()=
 which is
> > - * used to clean out a memory space.
> > - */
> > -static bool amdgpu_ttm_bo_eviction_valuable(struct ttm_buffer_object *=
bo,
> > -                                         const struct ttm_place *place=
)
> > +static bool amdgpu_ttm_mem_eviction_valuable(struct ttm_buffer_object =
*bo,
> > +                                          const struct ttm_place *plac=
e)
> >   {
> >       unsigned long num_pages =3D bo->resource->num_pages;
> >       struct amdgpu_res_cursor cursor;
> > -     struct dma_resv_list *flist;
> > -     struct dma_fence *f;
> > -     int i;
> > -
> > -     /* Swapout? */
> > -     if (bo->resource->mem_type =3D=3D TTM_PL_SYSTEM)
> > -             return true;
> > -
> > -     if (bo->type =3D=3D ttm_bo_type_kernel &&
> > -         !amdgpu_vm_evictable(ttm_to_amdgpu_bo(bo)))
> > -             return false;
> > -
> > -     /* If bo is a KFD BO, check if the bo belongs to the current proc=
ess.
> > -      * If true, then return false as any KFD process needs all its BO=
s to
> > -      * be resident to run successfully
> > -      */
> > -     flist =3D dma_resv_shared_list(bo->base.resv);
> > -     if (flist) {
> > -             for (i =3D 0; i < flist->shared_count; ++i) {
> > -                     f =3D rcu_dereference_protected(flist->shared[i],
> > -                             dma_resv_held(bo->base.resv));
> > -                     if (amdkfd_fence_check_mm(f, current->mm))
> > -                             return false;
> > -             }
> > -     }
> >
> >       switch (bo->resource->mem_type) {
> >       case AMDGPU_PL_PREEMPT:
> > @@ -1377,10 +1343,53 @@ static bool amdgpu_ttm_bo_eviction_valuable(str=
uct ttm_buffer_object *bo,
> >               return false;
> >
> >       default:
> > -             break;
> > +             return ttm_bo_eviction_valuable(bo, place);
> >       }
> > +}
> >
> > -     return ttm_bo_eviction_valuable(bo, place);
> > +/*
> > + * amdgpu_ttm_bo_eviction_valuable - Check to see if we can evict a bu=
ffer
> > + * object.
> > + *
> > + * Return true if eviction is sensible. Called by ttm_mem_evict_first(=
) on
> > + * behalf of ttm_bo_mem_force_space() which tries to evict buffer obje=
cts until
> > + * it can find space for a new object and by ttm_bo_force_list_clean()=
 which is
> > + * used to clean out a memory space.
> > + */
> > +static bool amdgpu_ttm_bo_eviction_valuable(struct ttm_buffer_object *=
bo,
> > +                                         const struct ttm_place *place=
)
> > +{
> > +     struct dma_resv_list *flist;
> > +     struct dma_fence *f;
> > +     int i;
> > +
> > +     /* Swapout? */
> > +     if (bo->resource->mem_type =3D=3D TTM_PL_SYSTEM)
> > +             return true;
> > +
> > +     /* If bo is a KFD BO, check if the bo belongs to the current proc=
ess.
> > +      * If true, then return false as any KFD process needs all its BO=
s to
> > +      * be resident to run successfully
> > +      */
> > +     flist =3D dma_resv_shared_list(bo->base.resv);
> > +     if (flist) {
> > +             for (i =3D 0; i < flist->shared_count; ++i) {
> > +                     f =3D rcu_dereference_protected(flist->shared[i],
> > +                             dma_resv_held(bo->base.resv));
> > +                     if (amdkfd_fence_check_mm(f, current->mm))
> > +                             return false;
> > +             }
> > +     }
> > +
> > +     /* Check by different mem type. */
> > +     if (!amdgpu_ttm_mem_eviction_valuable(bo, place))
> > +             return false;
> > +
> > +     /* VM bo should be checked at last because it will mark VM evicti=
ng. */
> > +     if (bo->type =3D=3D ttm_bo_type_kernel)
> > +             return amdgpu_vm_evictable(ttm_to_amdgpu_bo(bo));
> > +
> > +     return true;
> >   }
> >
> >   static void amdgpu_ttm_vram_mm_access(struct amdgpu_device *adev, lof=
f_t pos,
>
