Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285C047459A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 15:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbhLNOwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 09:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbhLNOwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 09:52:36 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE2EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 06:52:35 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id jo22so17392137qvb.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 06:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xf7q3Jbcz4/LEcmcTeVISoI2B4bGeUUdk0hxUCLs5rs=;
        b=FHi3n63QOeG6gLzhJVCdkONlfQpsuxOmAKW/cofmDUuTckCd4qt7wzrPBtLFf38Tb+
         xczhmQro+FHcyY+W6wlhd2Sq+Q344IDjN7C31P+Vs/LqsdG1ym0O/AnPKb36EWvJW8y/
         /pr28c+ss/0UsW6wYuaNVwi0NwfBGCtzMBbNmDR73IqCHGKJj/ek4Xq8F83t9by2FunU
         IAFZ435a4UvJ5CbpXMzQ3/gEcwcr2pH08XvUHL//xRzEm2DOW9ur1GyrfFVnyu98v1kI
         fMMtbJ3zynCSm7ZbK99IzJ36XpRZZ7cd4a8Qr+lFLn//i6QS7Q9xAIgsFhZFdC2LAwr8
         hEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xf7q3Jbcz4/LEcmcTeVISoI2B4bGeUUdk0hxUCLs5rs=;
        b=bHKPBDVxVUd4q2UfHos327zx6UpD3eqbrLvVjcfx+in4mZuCqYMGyrCvvn+hTPBq7a
         T7jE4jxCyKNq29rpjw3Na5EIkhPE1dsyMLwlLU1CUHFjCexpUay3stzFM/LExTD+bHMQ
         M6dlO5WN9kxZKICqfmZ2uyikosn3AK2b+oghMJUuPJLceYKJiSjiLoFeJz2HERshwJ3u
         xg2BCifshONNPc4W7GIHDEsDs4JQVp0VRB+LubAW0MhhdysKI82mY8tFROOkCLDL2IfY
         wLJO977tV6R+X1amq+/2zO15jxS0VSqELzl4zDaACr10f5h/VjEqIUk6UrAZwPqfCTB8
         oIkg==
X-Gm-Message-State: AOAM532cJ8NpWzNgLxCCCsSSghKGF6GcQsERVY8bv5BeugZwPI902kHO
        7W/cuIOIOcA29X14j9ll+8rpm+D2lCDR4i0BasHy4XSqap0=
X-Google-Smtp-Source: ABdhPJwS/wVbUCr/fISQSZfIT4fbHE551R+9VucYnxwH9401gRXCgl3ytnT4zp3UABFRvuUFhflcOEQJnA9jSart4iY=
X-Received: by 2002:ad4:5ce8:: with SMTP id iv8mr5919659qvb.21.1639493554305;
 Tue, 14 Dec 2021 06:52:34 -0800 (PST)
MIME-Version: 1.0
References: <20211210195005.2582884-1-bob.beckett@collabora.com> <e7cad6ca-d106-c529-6f22-93a7847cd7c0@intel.com>
In-Reply-To: <e7cad6ca-d106-c529-6f22-93a7847cd7c0@intel.com>
From:   Matthew Auld <matthew.william.auld@gmail.com>
Date:   Tue, 14 Dec 2021 14:52:08 +0000
Message-ID: <CAM0jSHNn4yq1u_Qwr9v9kUCcEexBmb+=LML2=OF1Rspyf-TDfA@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH] drm/i915/ttm: fix large buffer population trucation
To:     Matthew Auld <matthew.auld@intel.com>
Cc:     Robert Beckett <bob.beckett@collabora.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>, Oak Zeng <oak.zeng@intel.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 at 13:03, Matthew Auld <matthew.auld@intel.com> wrote:
>
> On 10/12/2021 19:50, Robert Beckett wrote:
> > ttm->num_pages is uint32_t which was causing very large buffers to
> > only populate a truncated size.
> >
> > This fixes gem_create@create-clear igt test on large memory systems.
> >
> > Fixes: 7ae034590cea ("drm/i915/ttm: add tt shmem backend")
> > Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
>
> Nice catch,
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>

Pushed to drm-intel-gt-next. Thanks again for the fix.

>
> > ---
> >   drivers/gpu/drm/i915/gem/i915_gem_ttm.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> > index 218a9b3037c7..923cc7ad8d70 100644
> > --- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> > +++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> > @@ -166,7 +166,7 @@ static int i915_ttm_tt_shmem_populate(struct ttm_device *bdev,
> >       struct intel_memory_region *mr = i915->mm.regions[INTEL_MEMORY_SYSTEM];
> >       struct i915_ttm_tt *i915_tt = container_of(ttm, typeof(*i915_tt), ttm);
> >       const unsigned int max_segment = i915_sg_segment_size();
> > -     const size_t size = ttm->num_pages << PAGE_SHIFT;
> > +     const size_t size = (size_t)ttm->num_pages << PAGE_SHIFT;
> >       struct file *filp = i915_tt->filp;
> >       struct sgt_iter sgt_iter;
> >       struct sg_table *st;
> >
