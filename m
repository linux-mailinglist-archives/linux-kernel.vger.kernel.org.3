Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3DB48ED06
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242688AbiANPT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:19:26 -0500
Received: from mga01.intel.com ([192.55.52.88]:57555 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239340AbiANPTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:19:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642173554; x=1673709554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gQypZeKb20iK6V4Fo2vqovMOcW37eXRpK9D4ZpMA80M=;
  b=BtH88BUhEmWlwFXXte+qLw3Vvhv3gqQk8ax+w+tSh2xstShTBvIDV56V
   PUsCKlImoNoj6t9b8S+UNiO0BR3jgJ7IY/cbAugfXLJNoOW4Sprdt2JsP
   zl6J1rREoHd4keoQ3+fBLgZH9RcNG/GdtqpMUxE2Q1U5X7k/QtPu23Gx4
   PbVH6zuztG2ajbheN8fq/nneNzygRZ+qXiALSn5Ql8FXpYrMcHGWJYick
   c+osJESBMt+vxSnZqnCajDT8Hsw7+1MUBnfB8t8SovAWIECC6uh3Ksm4J
   xeUbUHUZ81YgYvHNGcjjd94PPxp7dHS3EwB+rm4QYWW/T6BxeZ8lbtHit
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="268628145"
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="268628145"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 07:19:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="594058641"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 07:19:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n8OKv-00AgJa-UJ;
        Fri, 14 Jan 2022 17:17:53 +0200
Date:   Fri, 14 Jan 2022 17:17:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Simon Ser <contact@emersion.fr>
Cc:     Tomohito Esaki <etom@igel.co.jp>, dri-devel@lists.freedesktop.org,
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
Message-ID: <YeGUIYK3hYo7wLJt@smile.fi.intel.com>
References: <20220114101753.24996-1-etom@igel.co.jp>
 <20220114101753.24996-3-etom@igel.co.jp>
 <YeGFugZvwbF7l2I/@smile.fi.intel.com>
 <7eljcd3F4aWL2jjBRwr3DISmyt0XPWFIH1_kebFGqZTJXLZRx0bm_8c8yaIuEuH8rS0MaJhU6SY1y-fc6U_zCLaKgoLM124nZpr0H91nSjw=@emersion.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7eljcd3F4aWL2jjBRwr3DISmyt0XPWFIH1_kebFGqZTJXLZRx0bm_8c8yaIuEuH8rS0MaJhU6SY1y-fc6U_zCLaKgoLM124nZpr0H91nSjw=@emersion.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 03:07:21PM +0000, Simon Ser wrote:
> On Friday, January 14th, 2022 at 15:16, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Why not enum?
> 
> There is no enum for DRM format modifiers.

I'm not sure how this prevents to use enum in the code instead of const u64.
Any specific reason for that?

-- 
With Best Regards,
Andy Shevchenko


