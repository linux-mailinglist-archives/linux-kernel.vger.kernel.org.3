Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D797492313
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 10:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbiARJrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 04:47:08 -0500
Received: from mga17.intel.com ([192.55.52.151]:1355 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232981AbiARJrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 04:47:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642499225; x=1674035225;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L+OPdNsaU2FY8wr/SJr9DyBE7V4Xr+Q/OlCWELomdhA=;
  b=nTY0FFD9zDnkccdxOlHdWX1x4/kl+E/yxDMzCRgeZGiVZcd0pyNagA6m
   VsRmag6NO73/3kQKCbXRSZ5otOcn52ScoE8anWDj3VVmNR8g47uDLSNBW
   PQPlSNfM80/T90XuIkoYJiqHHm1O5ZHZWR8MJWsjOdHyDFWVAcUC2ekd5
   8t0S9PS7NeexulONalq4sTFEHciy9D8LFSKt1kUQUQarcw+wEYP8GoN6s
   HrcBa+uvvyRY9KIhfs7ufja0J+5zaD5uXYDMY3RGDXgB4TzqThlryyanT
   w0wxKc2+aXpKfdtPpkWjAdPs2CIS81yYCNjzp8kOQ4fqSlRP64coaWuLy
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="225455430"
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="225455430"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 01:47:04 -0800
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="622085988"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 01:46:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n9l3i-00BnjX-K9;
        Tue, 18 Jan 2022 11:45:46 +0200
Date:   Tue, 18 Jan 2022 11:45:46 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tomohito Esaki <etom@igel.co.jp>
Cc:     dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ben Skeggs <bskeggs@redhat.com>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <mdaenzer@redhat.com>,
        Simon Ser <contact@emersion.fr>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Mark Yacoub <markyacoub@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Evan Quan <evan.quan@amd.com>, Petr Mladek <pmladek@suse.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org, Daniel Stone <daniel@fooishbar.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Damian Hobson-Garcia <dhobsong@igel.co.jp>,
        Takanari Hayama <taki@igel.co.jp>
Subject: Re: [RFC PATCH v4 0/3] Add support modifiers for drivers whose
 planes only support linear layout
Message-ID: <YeaMSguM7hTN/I2B@smile.fi.intel.com>
References: <20220118083652.16335-1-etom@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118083652.16335-1-etom@igel.co.jp>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 05:36:49PM +0900, Tomohito Esaki wrote:
> Some drivers whose planes only support linear layout fb do not support format
> modifiers.
> These drivers should support modifiers, however the DRM core should handle this
> rather than open-coding in every driver.
> 
> In this patch series, these drivers expose format modifiers based on the
> following suggestion[1].
> 
> On Thu, Nov 18, 2021 at 01:02:11PM +0000, Daniel Stone wrote:
> > I think the best way forward here is:
> >   - add a new mode_config.cannot_support_modifiers flag, and enable
> > this in radeon (plus any other drivers in the same boat)
> >   - change drm_universal_plane_init() to advertise the LINEAR modifier
> > when NULL is passed as the modifier list (including installing a
> > default .format_mod_supported hook)
> >   - remove the mode_config.allow_fb_modifiers hook and always
> > advertise modifier support, unless
> > mode_config.cannot_support_modifiers is set

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> [1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20190509054518.10781-1-etom@igel.co.jp/#24602575
> 
> v4:
> * modify documentation for fb_modifiers_not_supported flag in kerneldoc
> 
> v3: https://www.spinics.net/lists/dri-devel/msg329102.html
> * change the order as follows:
>    1. add fb_modifiers_not_supported flag
>    2. add default modifiers
>    3. remove allow_fb_modifiers flag
> * add a conditional disable in amdgpu_dm_plane_init()
> 
> v2: https://www.spinics.net/lists/dri-devel/msg328939.html
> * rebase to the latest master branch (5.16.0+)
>       + "drm/plane: Make format_mod_supported truly optional" patch [2]
>   [2] https://patchwork.freedesktop.org/patch/467940/?series=98255&rev=3
> 
> v1: https://www.spinics.net/lists/dri-devel/msg327352.html
> * The initial patch set
> 
> Tomohito Esaki (3):
>   drm: introduce fb_modifiers_not_supported flag in mode_config
>   drm: add support modifiers for drivers whose planes only support
>     linear layout
>   drm: remove allow_fb_modifiers
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  6 ++---
>  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |  2 ++
>  drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |  2 ++
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |  1 +
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |  2 ++
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 +++
>  drivers/gpu/drm/drm_framebuffer.c             |  6 ++---
>  drivers/gpu/drm/drm_ioctl.c                   |  2 +-
>  drivers/gpu/drm/drm_plane.c                   | 22 +++++++++----------
>  drivers/gpu/drm/nouveau/nouveau_display.c     |  6 +++--
>  drivers/gpu/drm/radeon/radeon_display.c       |  2 ++
>  .../gpu/drm/selftests/test-drm_framebuffer.c  |  1 -
>  include/drm/drm_mode_config.h                 | 18 +++++----------
>  include/drm/drm_plane.h                       |  3 +++
>  14 files changed, 43 insertions(+), 33 deletions(-)
> 
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


