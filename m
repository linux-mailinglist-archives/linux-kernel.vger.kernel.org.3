Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CAA492351
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 10:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiARJzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 04:55:03 -0500
Received: from mga04.intel.com ([192.55.52.120]:10568 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235911AbiARJyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 04:54:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642499694; x=1674035694;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iCK4/KbCsLlMc5j0Y8eHw+xQocZMcWu5acqJbztI50s=;
  b=k3jgwShbIZUiAiw1s/gcq6ZZB8KZ2t420StYpNyCMDcyx2+wl+Notlcc
   BPszJMqFA7vvH8ukwJpb6neQmhGHusLCWKNbv4tpJeXEEvUF/P0Q4lwPm
   /K9S7I8eIYTfzSMJfr7GqnYiaAzDrJmyH3gZqKzt/nRslMnR9pRxeHLne
   gUTBlctvJLkU1Jvg+IBa/IhOgC4BbVCj+smIJtzcWlTKS8UuA+y9oFaZN
   HAYSP8OM4nLX5jBrsLNPlxsOMlJn+uikpDi5aZ/kLC19azDLI595rM3HB
   1OhVv/+veFPcwj/dJrp24Byngw9aPAaPWKHwmpWA7bs3hmMTuiEXnF73K
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="243602768"
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="243602768"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 01:54:52 -0800
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="595015751"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 01:54:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n9lBG-00Bnof-PN;
        Tue, 18 Jan 2022 11:53:34 +0200
Date:   Tue, 18 Jan 2022 11:53:34 +0200
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
Message-ID: <YeaOHqfTcf+evbVC@smile.fi.intel.com>
References: <20220114101753.24996-1-etom@igel.co.jp>
 <20220114101753.24996-3-etom@igel.co.jp>
 <YeGFugZvwbF7l2I/@smile.fi.intel.com>
 <0cf405a1-0d2d-ed5e-abdf-be645e7a9209@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cf405a1-0d2d-ed5e-abdf-be645e7a9209@igel.co.jp>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 02:15:48PM +0900, Esaki Tomohito wrote:
> On 2022/01/14 23:16, Andy Shevchenko wrote:
> > On Fri, Jan 14, 2022 at 07:17:52PM +0900, Tomohito Esaki wrote:
> > > The LINEAR modifier is advertised as default if a driver doesn't specify
> > > modifiers.
> > 
> > ...
> > 
> > > +	const uint64_t default_modifiers[] = {
> > > +		DRM_FORMAT_MOD_LINEAR,
> > > +		DRM_FORMAT_MOD_INVALID
> > 
> > + Comma?
> 
> There is no mention in the coding style about adding/removing a comma to the
> last element of an array. Is there a policy in drm driver?
> 
> I think the advantage of adding a comma to the last element of an array is
> that diff is only one line when an element is added to the end.
> However since INVALID is always the last element in the modifiers array, I
> think it can be either in this case.
> If there is a policy, I will match it.

Indeed, but there is a common sense. The idea behind (multi-line) definitions
that when next time somebody will add an element in the array, there are will
be:

a) no additional churn (like in case of this patch, if the item will be added
   at the bottom;

b) an element that may not be added behind the terminator, which will look
   weird.

That said, the question is if the element is terminator one or not, if not,
comma is better than no comma and vise versa.

-- 
With Best Regards,
Andy Shevchenko


