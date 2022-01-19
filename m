Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9C9493EFE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 18:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356384AbiASRY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 12:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347341AbiASRY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 12:24:27 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6EFC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 09:24:26 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id f202-20020a1c1fd3000000b0034dd403f4fbso3661404wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 09:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=eOH9iqU5IVX14/tYvkJqEjk8Qx7vTHtd1JM4aN1Uy+o=;
        b=DmDrtO1qA5+xS6RSFjC8YRAgWKLJSBrsCK3C1mYCeL3ScNiBJNJt+zzuegOEmgLjoP
         +/1qV59z4FrPlFKaNmWWmOAzeWqYXZefKd0ekBDSMLyaEC7lt9t07rqtIL/3zUc121jm
         +dcjCTcj0zrh3pRs67AwP1TQsb2jKMgygW7C8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=eOH9iqU5IVX14/tYvkJqEjk8Qx7vTHtd1JM4aN1Uy+o=;
        b=3f2/Qke2vLFXSQcvIYEPhSVG5cHEXM6tZhJoG3GQdNFYc4bzF+ftXie+9LjlslkCCU
         3ht6jn37WgZq80kkqblCHV9yGFDUZ5TaSVZoS0IlOXVmCRfJIH7IBF6jeZM7l1GDSlK4
         BPdAAp7L4gpvN7Tp2mruE7N8Fz7kC4+hhqQt7IsAUP2lFWNyH5vCfxjZcwo2kkFFJJg0
         2X3sU8bywsbZ4eFwaQCH+AeggQAZnAbRdoH2SIULSLxiy1P8oQcoYiwcvgGayXafEhnx
         Eo6eBHoTt/XLE67wXzMSYL8hi4Q8Is9ZK51b9wdDWU9BZ2qxHlOvTZI8T6pzbxgX/5sm
         G9ig==
X-Gm-Message-State: AOAM530OjNnH+Dn2+r2xbhNqGdi9KNlYHELmRBGAgjyigZc/3M3c35rt
        znlfedpslZ5ZErcoYLe2hW2lfA==
X-Google-Smtp-Source: ABdhPJwmz4gHSPo9o9SV/Nix2goUKu/7MKdI00pmWvKG61VzYeY9XiHQLJbDl27v8A+WKNfPotxwNQ==
X-Received: by 2002:adf:e291:: with SMTP id v17mr29163539wri.479.1642613064738;
        Wed, 19 Jan 2022 09:24:24 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f6sm428161wrj.26.2022.01.19.09.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 09:24:24 -0800 (PST)
Date:   Wed, 19 Jan 2022 18:24:22 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/7] DRM kmap() fixes and kmap_local_page() conversions
Message-ID: <YehJRt+JngIsj+Gd@phenom.ffwll.local>
Mail-Followup-To: Ira Weiny <ira.weiny@intel.com>,
        David Airlie <airlied@linux.ie>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org
References: <20211210232404.4098157-1-ira.weiny@intel.com>
 <20220119165356.GD209936@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119165356.GD209936@iweiny-DESK2.sc.intel.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 08:53:56AM -0800, Ira Weiny wrote:
> On Fri, Dec 10, 2021 at 03:23:57PM -0800, 'Ira Weiny' wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > This series starts by converting the last easy kmap() uses to
> > kmap_local_page().
> > 
> > There is one more call to kmap() wrapped in ttm_bo_kmap_ttm().  Unfortunately,
> > ttm_bo_kmap_ttm() is called in a number of different ways including some which
> > are not thread local.  I have a patch to convert that call.  However, it is not
> > straight forward so it is not included in this series.
> > 
> > The final 2 patches fix bugs found while working on the ttm_bo_kmap_ttm()
> > conversion.
> 
> Gentile ping on this series?  Will it make this merge window?

I think this fell through the cracks and so no. Note that generally we
feature-freeze drm tree around -rc6 anyway for the upcoming merge window,
so you were cutting this all a bit close anyway. Also looks like the ttm
kmap caching question didn't get resolved?

Anyway if patches are stuck resend with RESEND and if people still don't
pick them up poke me and I'll apply as fallback.

Cheers, Daniel

> 
> Thanks,
> Ira
> 
> > 
> > 
> > Ira Weiny (7):
> > drm/i915: Replace kmap() with kmap_local_page()
> > drm/amd: Replace kmap() with kmap_local_page()
> > drm/gma: Remove calls to kmap()
> > drm/radeon: Replace kmap() with kmap_local_page()
> > drm/msm: Alter comment to use kmap_local_page()
> > drm/amdgpu: Ensure kunmap is called on error
> > drm/radeon: Ensure kunmap is called on error
> > 
> > drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 8 ++++----
> > drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 1 +
> > drivers/gpu/drm/gma500/gma_display.c | 6 ++----
> > drivers/gpu/drm/gma500/mmu.c | 8 ++++----
> > drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 4 ++--
> > drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c | 8 ++++----
> > drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c | 4 ++--
> > drivers/gpu/drm/i915/gt/shmem_utils.c | 4 ++--
> > drivers/gpu/drm/i915/i915_gem.c | 8 ++++----
> > drivers/gpu/drm/i915/i915_gpu_error.c | 4 ++--
> > drivers/gpu/drm/msm/msm_gem_submit.c | 4 ++--
> > drivers/gpu/drm/radeon/radeon_ttm.c | 4 ++--
> > drivers/gpu/drm/radeon/radeon_uvd.c | 1 +
> > 13 files changed, 32 insertions(+), 32 deletions(-)
> > 
> > --
> > 2.31.1
> > 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
