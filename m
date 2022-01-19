Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4EF4940ED
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 20:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237219AbiASTca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 14:32:30 -0500
Received: from mga02.intel.com ([134.134.136.20]:51948 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238608AbiASTc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 14:32:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642620746; x=1674156746;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hA5pSNQjxDTLN0gQu3qfl7xtlPzKT55FdGnVp2YHmjo=;
  b=n2RzNA0cu70jI0tKMlC8cgrd1/NaO9fD1K1V1Ju2f9M+X82zYNCTYZFi
   +n6NZ2aqRDqdlzc4jIJAgZ76AeLnskoi/OwFNUBhoEG0hn8pD82nIWJfz
   bodapKd9ek8gCBTtk/k+iWIdE3qoRFfJm+2G2J3xu6phTGNbg8gsQt0li
   7JPWFWa12RUnmYYt6dXG+N9ZSSsqwVBFc67kgpfTSIOsq5VP41JijYsUV
   sB5jUoBwF4BExbpJdTyH7lkEVeHTOT0otv7K+ZJrgnaFU+GBsWILq0bl0
   BTr0KB3foyg0UzSHG7fESjJTzg7P9EkZXnXdxQRqBx/vmib8rxJ0p7aNz
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="232534823"
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="232534823"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 11:18:55 -0800
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="530741414"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 11:18:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nAGSd-00CETd-Sx;
        Wed, 19 Jan 2022 21:17:35 +0200
Date:   Wed, 19 Jan 2022 21:17:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Esaki Tomohito <etom@igel.co.jp>
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
Message-ID: <Yehjz1ixBKqL7Qw+@smile.fi.intel.com>
References: <20220114101753.24996-1-etom@igel.co.jp>
 <20220114101753.24996-3-etom@igel.co.jp>
 <YeGFugZvwbF7l2I/@smile.fi.intel.com>
 <0cf405a1-0d2d-ed5e-abdf-be645e7a9209@igel.co.jp>
 <YeaOHqfTcf+evbVC@smile.fi.intel.com>
 <94bddda6-9823-6479-bc1d-cbb8c1079877@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94bddda6-9823-6479-bc1d-cbb8c1079877@igel.co.jp>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 11:35:22AM +0900, Esaki Tomohito wrote:
> On 2022/01/18 18:53, Andy Shevchenko wrote:
> > On Mon, Jan 17, 2022 at 02:15:48PM +0900, Esaki Tomohito wrote:
> > > On 2022/01/14 23:16, Andy Shevchenko wrote:
> > > > On Fri, Jan 14, 2022 at 07:17:52PM +0900, Tomohito Esaki wrote:
> > > > > The LINEAR modifier is advertised as default if a driver doesn't specify
> > > > > modifiers.
> > > > 
> > > > ...
> > > > 
> > > > > +	const uint64_t default_modifiers[] = {
> > > > > +		DRM_FORMAT_MOD_LINEAR,
> > > > > +		DRM_FORMAT_MOD_INVALID
> > > > 
> > > > + Comma?
> > > 
> > > There is no mention in the coding style about adding/removing a comma to the
> > > last element of an array. Is there a policy in drm driver?
> > > 
> > > I think the advantage of adding a comma to the last element of an array is
> > > that diff is only one line when an element is added to the end.
> > > However since INVALID is always the last element in the modifiers array, I
> > > think it can be either in this case.
> > > If there is a policy, I will match it.
> > 
> > Indeed, but there is a common sense. The idea behind (multi-line) definitions
> > that when next time somebody will add an element in the array, there are will
> > be:
> > 
> > a) no additional churn (like in case of this patch, if the item will be added
> >     at the bottom;
> > 
> > b) an element that may not be added behind the terminator, which will look
> >     weird.
> > 
> > That said, the question is if the element is terminator one or not, if not,
> > comma is better than no comma and vise versa.
> 
> Ah I see. In this case, DRM_FORMAT_MOD_INVALID is terminator, so it
> should not have a comma.

Thanks for pointing this out. In this case we are good and any new item, AFAIU,
must be added before _INVALID one.

-- 
With Best Regards,
Andy Shevchenko


