Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76311497E7C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238189AbiAXMIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238097AbiAXMIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:08:30 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1859FC06173B;
        Mon, 24 Jan 2022 04:08:30 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 131so322672wmc.4;
        Mon, 24 Jan 2022 04:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=XArnnH4OvrxRcoFfpFy+puuAOs1zK8Kgo1S3kPJSJSw=;
        b=Jc276FuGvUAjhsukljJ+yBmJsnTKcW5NrocuudRyuV338c+REYomAqV50vs3b9w4gw
         jQUdowlUT4PRsPPsTAx3vb+xhwoOyrYKpR9Yc+Tii6O6Pa7p/nbIXGl23Dc7cyglQCdj
         /h5svWv15McmcBB+SVksjK92+h0n0fJw40OLE2eieebA957FhvtKGR0hjGKQV4L8E1jT
         ULJQlldeeOX3wdAa0621QBFB1gY3WE2BqPzwM3CJ5bFnJLxjaQPzu5VlFPBnYQIxnLda
         Vhqv8J9RWPMvMK4I0olcJ33FVxRcdbNGVrSgt20UGyTLJIwHtLqMfwvzw6f3J+0KLU90
         m9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XArnnH4OvrxRcoFfpFy+puuAOs1zK8Kgo1S3kPJSJSw=;
        b=vFxQFofijTNIGACU3PYRhevl6jGMJEA9+8+Kgmw6Y9hrWZVia+MrO8mUGJD+mTZwAl
         4Sbiwml2YpIg5Om9+lvCzJUy+y7HhUHeIhfsD8kHn+C5LAPPrwsNJ1F0i6atmGE0w/Ux
         0B8//PlaVst06hGWXYPHpsZSmV1xFAI1vCpl5aps+rqCnRilzR1re1Jqyy0zfVzTkZCG
         jifCIgxEQ786NS4a/hPhn3UhdZtkB2GGqrcVz2HgFgzcCNghZxyaXA5rfO7I/oaN+xis
         iRQonN5vauePOCf7XEUkQViQOQKHUIWFWiSOGaM1efAuT+SJAsZbfumf9ADUz3Y+QnC0
         +nqw==
X-Gm-Message-State: AOAM530oQ0JLccCPXuwGOsTY5/WnrNoZaHZWK5pGMG/v/SytAhVNX69C
        kQ6utowu2Ri9GPjAStUczrU=
X-Google-Smtp-Source: ABdhPJxx9aW2LXSFk8wJPNYSMOgRQT/XrKepKIzP/Y7B/Y5B2yDT0IK8LOJk1hzSqfc71Sgws6OTQA==
X-Received: by 2002:a7b:c5c4:: with SMTP id n4mr1572870wmk.134.1643026108567;
        Mon, 24 Jan 2022 04:08:28 -0800 (PST)
Received: from [192.168.178.21] (p57b0bff8.dip0.t-ipconnect.de. [87.176.191.248])
        by smtp.gmail.com with ESMTPSA id c14sm17849799wri.32.2022.01.24.04.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 04:08:28 -0800 (PST)
Subject: Re: [PATCH V2 0/7] DRM kmap() fixes and kmap_local_page() conversions
To:     ira.weiny@intel.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>
Cc:     linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org
References: <20220124015409.807587-1-ira.weiny@intel.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <a56344b6-b1bd-6749-5ed2-5f38bf79dcee@gmail.com>
Date:   Mon, 24 Jan 2022 13:08:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220124015409.807587-1-ira.weiny@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 24.01.22 um 02:54 schrieb ira.weiny@intel.com:
> From: Ira Weiny <ira.weiny@intel.com>
>
> Changes from V1:
> 	Use memcpy_to_page() where appropriate
> 	Rebased to latest
>
> The kmap() call may cause issues with work being done with persistent memory.
> For this and other reasons it is being deprecated.

I'm really wondering how we should be able to implement the kernel 
mapping without kmap in TTM.

> This series starts by converting the last easy kmap() uses in the drm tree to
> kmap_local_page().
>
> The final 2 patches fix bugs found while working on the ttm_bo_kmap_ttm()
> conversion.  They are valid fixes but were found via code inspection not
> because of any actual bug so don't require a stable tag.[1]
>
> There is one more call to kmap() used in ttm_bo_kmap_ttm().  Unfortunately,
> fixing this is not straight forward so it is left to future work.[2]

Patches #2, #4, #6 and #7 are Reviewed-by: Christian König 
<christian.koenig@amd.com>

How to you now want to push those upstream? I can pick them up for the 
AMD tree like Daniel suggested or you can push them through something else.

Regards,
Christian.

>
> [1] https://lore.kernel.org/lkml/fb71af05-a889-8f6e-031b-426b58a64f00@amd.com/
> [2] https://lore.kernel.org/lkml/20211215210949.GW3538886@iweiny-DESK2.sc.intel.com/
>
>
> Ira Weiny (7):
> drm/i915: Replace kmap() with kmap_local_page()
> drm/amd: Replace kmap() with kmap_local_page()
> drm/gma: Remove calls to kmap()
> drm/radeon: Replace kmap() with kmap_local_page()
> drm/msm: Alter comment to use kmap_local_page()
> drm/amdgpu: Ensure kunmap is called on error
> drm/radeon: Ensure kunmap is called on error
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 8 ++++----
> drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 1 +
> drivers/gpu/drm/gma500/gma_display.c | 6 ++----
> drivers/gpu/drm/gma500/mmu.c | 8 ++++----
> drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 6 ++----
> drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c | 8 ++++----
> drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c | 4 ++--
> drivers/gpu/drm/i915/gt/shmem_utils.c | 7 ++-----
> drivers/gpu/drm/i915/i915_gem.c | 8 ++++----
> drivers/gpu/drm/i915/i915_gpu_error.c | 4 ++--
> drivers/gpu/drm/msm/msm_gem_submit.c | 4 ++--
> drivers/gpu/drm/radeon/radeon_ttm.c | 4 ++--
> drivers/gpu/drm/radeon/radeon_uvd.c | 1 +
> 13 files changed, 32 insertions(+), 37 deletions(-)
>
> --
> 2.31.1
>

