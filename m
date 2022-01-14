Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A0948EB7D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 15:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbiANOSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 09:18:35 -0500
Received: from mga14.intel.com ([192.55.52.115]:47609 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232484AbiANOSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 09:18:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642169914; x=1673705914;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AEvnDslGsOGfg/KTFj4CDj9oYhA5k0NUZG4ddu+7HzE=;
  b=OOj8h1vBGwHAM8kwVRbbjWVBsB8+1yJWuF/BngmiP2JhWA+7VLt1Q5hK
   1W/unN1HrRaNunJLstevQHNtLgPnm+RsPRXGD93GGr+JFQeP5aJ6P9NN6
   g5+eIcsw1Hd78Lj3tz9IgrI8OU0Yn66fvAUWowRyTVkP0lx6BGFILZNEh
   SsZXzzc95GUfYTZzartVm6WDoz9Nc++9D4wLmMAnC8fhKYip+6g5i3ucv
   C0OYR8FNTgd/S6k2jj6PJMRCGDw5xf2TKjkK+/e2IpMHHtTbTs5wQrqPC
   C0mLNAP+nc2yUVy+5ZQw/2FkdArYD69XhzIU4ou2Q9qIq3M+4bgvYIQnZ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="244453355"
X-IronPort-AV: E=Sophos;i="5.88,288,1635231600"; 
   d="scan'208";a="244453355"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 06:18:34 -0800
X-IronPort-AV: E=Sophos;i="5.88,288,1635231600"; 
   d="scan'208";a="692227145"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 06:18:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n8NNq-00AeD8-2B;
        Fri, 14 Jan 2022 16:16:50 +0200
Date:   Fri, 14 Jan 2022 16:16:26 +0200
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
Subject: Re: [RFC PATCH v3 2/3] drm: add support modifiers for drivers whose
 planes only support linear layout
Message-ID: <YeGFugZvwbF7l2I/@smile.fi.intel.com>
References: <20220114101753.24996-1-etom@igel.co.jp>
 <20220114101753.24996-3-etom@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220114101753.24996-3-etom@igel.co.jp>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 07:17:52PM +0900, Tomohito Esaki wrote:
> The LINEAR modifier is advertised as default if a driver doesn't specify
> modifiers.

...

> +	const uint64_t default_modifiers[] = {
> +		DRM_FORMAT_MOD_LINEAR,
> +		DRM_FORMAT_MOD_INVALID

+ Comma?

> +	};

Why not enum?


-- 
With Best Regards,
Andy Shevchenko


