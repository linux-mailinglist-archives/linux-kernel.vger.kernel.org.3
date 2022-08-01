Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA57587267
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 22:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbiHAUmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 16:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiHAUms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 16:42:48 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1EC13F99;
        Mon,  1 Aug 2022 13:42:47 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y11so19085036lfs.6;
        Mon, 01 Aug 2022 13:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=kIthB6TdDhvPyIaexnTVyNbX/FCo84yFP9KPpNhWWBY=;
        b=j5MzaMTJnqz34fw2Csn3rJvONY9AS+T7ZuCnNuEncmdiqawrf3dEvAWUK/l/ifXNpY
         f9yQT1qgelDTxzM7vKCNjQEXOSdxokMVX2uisDsUoMSP/ckxTJPivRSnBhUe8w9H9L+s
         r9buZwZv5h7nQ3u696dl6dRlS/0cfc8zMH11Du4ZeFyRfcs0YZvABnxuDlUFk4nI0amC
         74S6c4DYN1QeUY33mD0yMOTRTA5xQ1ZheteO8wVfbJV2O7ZmBf0eOkEwnn4MR9PDYkOD
         egI1v6NsRu6NiR+ye/zAIyWCXR0QWx6zhsEaIlUAcg6vAQyjSEpzZh/J9xDTEcp5wp36
         G7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=kIthB6TdDhvPyIaexnTVyNbX/FCo84yFP9KPpNhWWBY=;
        b=0eY8Ktn7CyifusKcT86zLZuRpaV0HL0coqwxipOCPOUWx6KGSpVNOflIEFdCJiv4iC
         xh6ZwSSpCNMiH2UpFZG2aRukwejMhA9NGgShNn6JMB2X4WE0xgqWc947PCczQDSAVHLU
         ORfS6wu3GnwtzQscLNxZ4J0z810XlO/niYzWuXD1eQcI/+H5LtIgQwwj8U1L4qnQOxoB
         d4SZqwFaL1PAA/+D6sm/b3G0ACpzw2HWwAQu2ffS7sL57A/t7g9rORY/IoUzjCys6Xrf
         HucmAwhmDGgCWVjtOpylZ1qOqwN7p9Buo5TUGhliraF9gkW5vtk+7IfNl+YOSfdE7Yo5
         UaHg==
X-Gm-Message-State: AJIora/VlBSjRAG7HLml11QUc+IShdpCQD2xg8fFR9+k/CJKfpc82hxE
        EMF2M4utK48+WKYZtiBH2zn64MjwLLzSGsfYJ4o=
X-Google-Smtp-Source: AGRyM1skt9q0ry/mgHPex0SgVfhaLl0kYvKNgfxFdnPqi7je6iVIXJWKfJkgv19VqjAta18vJNQs/Cr++y8j7e0NBV8=
X-Received: by 2002:ac2:4f03:0:b0:481:50f7:ac07 with SMTP id
 k3-20020ac24f03000000b0048150f7ac07mr5817490lfr.422.1659386565885; Mon, 01
 Aug 2022 13:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220726175043.1027731-1-robdclark@gmail.com> <20220726175043.1027731-10-robdclark@gmail.com>
 <def8e47c-067e-0841-4ae4-1eb90244cd50@collabora.com> <CAF6AEGtV4GY6=PmQh0wrKxjxk_baRCzOo=s=Uz-uKBNEn7SBBg@mail.gmail.com>
 <6b35b912-68e5-e722-0b5a-0f7bd06c22c2@collabora.com> <733f5d3f-293e-f951-a00b-fcd3052f68e7@collabora.com>
 <88576d7a-da5f-753d-51cf-08ed22f7c81e@collabora.com>
In-Reply-To: <88576d7a-da5f-753d-51cf-08ed22f7c81e@collabora.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 1 Aug 2022 13:42:33 -0700
Message-ID: <CAF6AEGu1_5EBmKQR8cMs=or6o_ALBWxTyKA_JL-G-AhemDyaww@mail.gmail.com>
Subject: Re: [PATCH v3 09/15] drm/gem: Add LRU/shrinker helper
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 1, 2022 at 1:26 PM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 8/1/22 23:13, Dmitry Osipenko wrote:
> > On 8/1/22 23:11, Dmitry Osipenko wrote:
> >> On 8/1/22 23:00, Rob Clark wrote:
> >>> On Mon, Aug 1, 2022 at 12:41 PM Dmitry Osipenko
> >>> <dmitry.osipenko@collabora.com> wrote:
> >>>>
> >>>> On 7/26/22 20:50, Rob Clark wrote:
> >>>>> +/**
> >>>>> + * drm_gem_lru_remove - remove object from whatever LRU it is in
> >>>>> + *
> >>>>> + * If the object is currently in any LRU, remove it.
> >>>>> + *
> >>>>> + * @obj: The GEM object to remove from current LRU
> >>>>> + */
> >>>>> +void
> >>>>> +drm_gem_lru_remove(struct drm_gem_object *obj)
> >>>>> +{
> >>>>> +     struct drm_gem_lru *lru = obj->lru;
> >>>>> +
> >>>>> +     if (!lru)
> >>>>> +             return;
> >>>>> +
> >>>>> +     mutex_lock(lru->lock);
> >>>>> +     lru_remove(obj);
> >>>>> +     mutex_unlock(lru->lock);
> >>>>> +}
> >>>>> +EXPORT_SYMBOL(drm_gem_lru_remove);
> >>>>
> >>>> I made a preliminary port of the DRM-SHMEM shrinker on top of the the
> >>>> latest version of dma-buf locking convention and yours LRU patches. It
> >>>> all works good, the only thing that is missing for the DRM-SHMEM
> >>>> shrinker is the drm_gem_lru_remove_locked().
> >>>>
> >>>> What about to add a locked variant of drm_gem_lru_remove()?
> >>>
> >>> Sounds fine to me.. the only reason it didn't exist yet was because it
> >>> wasn't needed yet..
> >>
> >> There is no use for the drm_gem_lru_move_tail_locked() as well, you're
> >> not using it in the MSM driver. Hence I thought it might be good to add
> >> the drm_gem_lru_remove_locked(), or maybe the
> >> drm_gem_lru_move_tail_locked() should be dropped then?
> >>
> >>> I can respin w/ an addition of a _locked() version, or you can add it
> >>> on top in your patchset.  Either is fine by me
> >>
> >> The either option is fine by me too. If you'll keep the unused
> >> drm_gem_lru_move_tail_locked(), then will be nice to add
> >> drm_gem_lru_remove_locked().
> >>
> >
> > The drm_gem_lru_move_tail_locked() will be needed by DRM-SHMEM shrinker,
> > BTW.
>
> On the other hand, I see now that DRM-SHMEM shrinker can use the
> unlocked versions only. Hence both drm_gem_lru_move_tail_locked() and
> drm_gem_lru_remove_locked() aren't needed.

drm_gem_lru_move_tail_locked() is used internally, but I guess it
could be made static since there ended up not being external users
(yet?)

I could see _move_tail_locked() being useful for a driver that wanted
to bulk update a bunch of GEM objs, for ex. all the bo's associated
with a submit/job.

BR,
-R
