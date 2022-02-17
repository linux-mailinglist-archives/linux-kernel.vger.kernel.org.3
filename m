Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABE14B9DFC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 12:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239741AbiBQLAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 06:00:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239633AbiBQK6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:58:52 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664C12AE065;
        Thu, 17 Feb 2022 02:58:18 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id x6-20020a4a4106000000b003193022319cso6091952ooa.4;
        Thu, 17 Feb 2022 02:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lLWDb1QANHeU0tDITDX2Se5UlYYAadlTb8UAohw65dA=;
        b=Y+BsR2AKN3IsoVIAqgYdXR9oWZCzTrGtgv1QKFf8KIDJ92fjMFo+xA1vcxDKaJJ6Np
         MA2Uiui9yMA+flwSXX2WeGyMFy49VTnUduZ5IqHQFAYdKN3OlBlAF9DvqpiNxkRlBk0Z
         OvOxYjZ3Wmp92Ggms4wajwO7c+DcIq76xFMsdoL2bXPMgQimqeQpHxPS7xALJcx8uivK
         T/+eN5fesr5QZgImLUCZP2OpOnguBckm/nvHHQPt/bmdVHgwRgSGUI1HvSGBySUEQvrC
         VRQSjNUexnRHIk3L0iQTWwJaM6MElh2NM0BR4/I4EBUE353dWbUGCOBLWFIG0NQvMYEL
         +uNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lLWDb1QANHeU0tDITDX2Se5UlYYAadlTb8UAohw65dA=;
        b=ipAgfQFw+Lko3uMmuKuEH0QA0rQ3f8qRgEpE22ezhH9WTNMf5PDPbfxoAncBQ4GbOG
         LHBdgcHH+QJ35rh+HBNxd7wtlOHVV+WPZhD6KlAXIIQssQ5GXv2ZDSHJMdLtxrmObrU3
         KJzWqZGxbL4SdvNK4ZbJJCWqBIpu0SCyaCVTOioCyFMV30NeYs7m+X7E6GtPgvwkk1ra
         i9iaLzJzU+AgOJuG4lTaqlG1Y52rr+N5ua7sa8HUFmoGGzom+1d1zgC8ePAwiHDsaQf2
         J70oqq8VVGqxJixFfxBanJx3FLMmVY5hUp3Vb4+B7WqbXfCubfXWLDqfxF0rh51iXfT/
         Is2A==
X-Gm-Message-State: AOAM533NmF8mlNLHf1bOqxgtlaHKwM7w0Q49nAOwZ0PWdG78Dr3/i79I
        I+cNnZr+kTtJksXwmRuwsEfwpc8CUixPb+uEmkXj72w8S3gP3FDZwS0=
X-Google-Smtp-Source: ABdhPJw1/7GKnKJYHkYeUjjSIqHHSSDLZrcsK2N+dSmEPyM7eId8BbBcs0vwEbBpPaYjIi8138ARe5f3y+BlWGKRzWU=
X-Received: by 2002:a05:6870:d205:b0:d3:52c0:2ba3 with SMTP id
 g5-20020a056870d20500b000d352c02ba3mr719256oac.96.1645095497621; Thu, 17 Feb
 2022 02:58:17 -0800 (PST)
MIME-Version: 1.0
References: <20220217090440.4468-1-qiang.yu@amd.com> <5d3fdd2c-e74a-49f4-2b28-32c06483236f@amd.com>
 <CAKGbVbtLTBJPF5eTu4rABUTBa8eqjQvqjo1AEUrzgPgYgCREuA@mail.gmail.com>
 <dac70c05-e712-d2e3-2267-278380895f1e@amd.com> <CAKGbVbvtLbDiKrX80-dMnipdLkTE+FP=g_mx37e12fuMtA1Y4Q@mail.gmail.com>
 <ca27a9c6-f390-a938-dd66-ac23f3b44dc4@amd.com>
In-Reply-To: <ca27a9c6-f390-a938-dd66-ac23f3b44dc4@amd.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Thu, 17 Feb 2022 18:58:06 +0800
Message-ID: <CAKGbVbv4UFCybS_OFj5UkDgevbrB5qe3pv+0nHv9WdefYhy6Ww@mail.gmail.com>
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

On Thu, Feb 17, 2022 at 6:39 PM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
>
>
> Am 17.02.22 um 11:13 schrieb Qiang Yu:
> > On Thu, Feb 17, 2022 at 5:46 PM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >> Am 17.02.22 um 10:40 schrieb Qiang Yu:
> >>> On Thu, Feb 17, 2022 at 5:15 PM Christian K=C3=B6nig
> >>> <christian.koenig@amd.com> wrote:
> >>>> Am 17.02.22 um 10:04 schrieb Qiang Yu:
> >>>>> Workstation application ANSA/META get this error dmesg:
> >>>>> [drm:amdgpu_gem_va_ioctl [amdgpu]] *ERROR* Couldn't update BO_VA (-=
16)
> >>>>>
> >>>>> This is caused by:
> >>>>> 1. create a 256MB buffer in invisible VRAM
> >>>>> 2. CPU map the buffer and access it causes vm_fault and try to move
> >>>>>       it to visible VRAM
> >>>>> 3. force visible VRAM space and traverse all VRAM bos to check if
> >>>>>       evicting this bo is valuable
> >>>>> 4. when checking a VM bo (in invisible VRAM), amdgpu_vm_evictable()
> >>>>>       will set amdgpu_vm->evicting, but latter due to not in visibl=
e
> >>>>>       VRAM, won't really evict it so not add it to amdgpu_vm->evict=
ed
> >>>>> 5. before next CS to clear the amdgpu_vm->evicting, user VM ops
> >>>>>       ioctl will pass amdgpu_vm_ready() (check amdgpu_vm->evicted)
> >>>>>       but fail in amdgpu_vm_bo_update_mapping() (check
> >>>>>       amdgpu_vm->evicting) and get this error log
> >>>>>
> >>>>> This error won't affect functionality as next CS will finish the
> >>>>> waiting VM ops. But we'd better make the amdgpu_vm->evicting
> >>>>> correctly reflact the vm status and clear the error log.
> >>>> Well NAK, that is intentional behavior.
> >>>>
> >>>> The VM page tables where considered for eviction, so setting the fla=
g is
> >>>> correct even when the page tables later on are not actually evicted.
> >>>>
> >>> But this will unnecessarily stop latter user VM ops in ioctl before C=
S
> >>> even when the VM bos are not evicted.
> >>> Won't this have any negative effect when could do better?
> >> No, this will have a positive effect. See the VM was already considere=
d
> >> for eviction because it is idle.
> >>
> >> Updating it immediately doesn't necessarily make sense, we should wait
> >> with that until its next usage.
> >>
> >> Additional to that this patch doesn't really fix the problem, it just
> >> mitigates it.
> >>
> >> Eviction can fail later on for a couple of reasons and we absolutely
> >> need to check the flag instead of the list in amdgpu_vm_ready().
> > The flag only for both flag and list? Looks like should be both as
> > the list indicate some vm page table need to be updated and could
> > delay the user update with the same logic as you described above.
>
> I think checking the flag should be enough. The issue is that the list
> was there initially, but to avoid race conditions we added the flag with
> separate lock protection later on.
>
But list and flag does not align always, there are cases like
list-empty/flag-set (this problem) and list-non-empty/flag-unset (non-vm bo
eviction). If only check flag list-non-empty/flag-unset change behavior.

Regards,
Qiang

> Regards,
> Christian.
>
> >
> > Regards,
> > Qiang
> >
> >> Regards,
> >> Christian.
> >>
> >>> Regards,
> >>> Qiang
> >>>
> >>>> What we should rather do is to fix amdgpu_vm_ready() to take a look =
at
> >>>> the flag instead of the linked list.
> >>>>
> >>>> Regards,
> >>>> Christian.
> >>>>
> >>>>> Signed-off-by: Qiang Yu <qiang.yu@amd.com>
> >>>>> ---
> >>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 85 ++++++++++++++----=
-------
> >>>>>     1 file changed, 47 insertions(+), 38 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_ttm.c
> >>>>> index 5a32ee66d8c8..88a27911054f 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >>>>> @@ -1306,45 +1306,11 @@ uint64_t amdgpu_ttm_tt_pte_flags(struct amd=
gpu_device *adev, struct ttm_tt *ttm,
> >>>>>         return flags;
> >>>>>     }
> >>>>>
> >>>>> -/*
> >>>>> - * amdgpu_ttm_bo_eviction_valuable - Check to see if we can evict =
a buffer
> >>>>> - * object.
> >>>>> - *
> >>>>> - * Return true if eviction is sensible. Called by ttm_mem_evict_fi=
rst() on
> >>>>> - * behalf of ttm_bo_mem_force_space() which tries to evict buffer =
objects until
> >>>>> - * it can find space for a new object and by ttm_bo_force_list_cle=
an() which is
> >>>>> - * used to clean out a memory space.
> >>>>> - */
> >>>>> -static bool amdgpu_ttm_bo_eviction_valuable(struct ttm_buffer_obje=
ct *bo,
> >>>>> -                                         const struct ttm_place *p=
lace)
> >>>>> +static bool amdgpu_ttm_mem_eviction_valuable(struct ttm_buffer_obj=
ect *bo,
> >>>>> +                                          const struct ttm_place *=
place)
> >>>>>     {
> >>>>>         unsigned long num_pages =3D bo->resource->num_pages;
> >>>>>         struct amdgpu_res_cursor cursor;
> >>>>> -     struct dma_resv_list *flist;
> >>>>> -     struct dma_fence *f;
> >>>>> -     int i;
> >>>>> -
> >>>>> -     /* Swapout? */
> >>>>> -     if (bo->resource->mem_type =3D=3D TTM_PL_SYSTEM)
> >>>>> -             return true;
> >>>>> -
> >>>>> -     if (bo->type =3D=3D ttm_bo_type_kernel &&
> >>>>> -         !amdgpu_vm_evictable(ttm_to_amdgpu_bo(bo)))
> >>>>> -             return false;
> >>>>> -
> >>>>> -     /* If bo is a KFD BO, check if the bo belongs to the current =
process.
> >>>>> -      * If true, then return false as any KFD process needs all it=
s BOs to
> >>>>> -      * be resident to run successfully
> >>>>> -      */
> >>>>> -     flist =3D dma_resv_shared_list(bo->base.resv);
> >>>>> -     if (flist) {
> >>>>> -             for (i =3D 0; i < flist->shared_count; ++i) {
> >>>>> -                     f =3D rcu_dereference_protected(flist->shared=
[i],
> >>>>> -                             dma_resv_held(bo->base.resv));
> >>>>> -                     if (amdkfd_fence_check_mm(f, current->mm))
> >>>>> -                             return false;
> >>>>> -             }
> >>>>> -     }
> >>>>>
> >>>>>         switch (bo->resource->mem_type) {
> >>>>>         case AMDGPU_PL_PREEMPT:
> >>>>> @@ -1377,10 +1343,53 @@ static bool amdgpu_ttm_bo_eviction_valuable=
(struct ttm_buffer_object *bo,
> >>>>>                 return false;
> >>>>>
> >>>>>         default:
> >>>>> -             break;
> >>>>> +             return ttm_bo_eviction_valuable(bo, place);
> >>>>>         }
> >>>>> +}
> >>>>>
> >>>>> -     return ttm_bo_eviction_valuable(bo, place);
> >>>>> +/*
> >>>>> + * amdgpu_ttm_bo_eviction_valuable - Check to see if we can evict =
a buffer
> >>>>> + * object.
> >>>>> + *
> >>>>> + * Return true if eviction is sensible. Called by ttm_mem_evict_fi=
rst() on
> >>>>> + * behalf of ttm_bo_mem_force_space() which tries to evict buffer =
objects until
> >>>>> + * it can find space for a new object and by ttm_bo_force_list_cle=
an() which is
> >>>>> + * used to clean out a memory space.
> >>>>> + */
> >>>>> +static bool amdgpu_ttm_bo_eviction_valuable(struct ttm_buffer_obje=
ct *bo,
> >>>>> +                                         const struct ttm_place *p=
lace)
> >>>>> +{
> >>>>> +     struct dma_resv_list *flist;
> >>>>> +     struct dma_fence *f;
> >>>>> +     int i;
> >>>>> +
> >>>>> +     /* Swapout? */
> >>>>> +     if (bo->resource->mem_type =3D=3D TTM_PL_SYSTEM)
> >>>>> +             return true;
> >>>>> +
> >>>>> +     /* If bo is a KFD BO, check if the bo belongs to the current =
process.
> >>>>> +      * If true, then return false as any KFD process needs all it=
s BOs to
> >>>>> +      * be resident to run successfully
> >>>>> +      */
> >>>>> +     flist =3D dma_resv_shared_list(bo->base.resv);
> >>>>> +     if (flist) {
> >>>>> +             for (i =3D 0; i < flist->shared_count; ++i) {
> >>>>> +                     f =3D rcu_dereference_protected(flist->shared=
[i],
> >>>>> +                             dma_resv_held(bo->base.resv));
> >>>>> +                     if (amdkfd_fence_check_mm(f, current->mm))
> >>>>> +                             return false;
> >>>>> +             }
> >>>>> +     }
> >>>>> +
> >>>>> +     /* Check by different mem type. */
> >>>>> +     if (!amdgpu_ttm_mem_eviction_valuable(bo, place))
> >>>>> +             return false;
> >>>>> +
> >>>>> +     /* VM bo should be checked at last because it will mark VM ev=
icting. */
> >>>>> +     if (bo->type =3D=3D ttm_bo_type_kernel)
> >>>>> +             return amdgpu_vm_evictable(ttm_to_amdgpu_bo(bo));
> >>>>> +
> >>>>> +     return true;
> >>>>>     }
> >>>>>
> >>>>>     static void amdgpu_ttm_vram_mm_access(struct amdgpu_device *ade=
v, loff_t pos,
>
