Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB3B4952BF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 17:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377188AbiATQ5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 11:57:23 -0500
Received: from mga12.intel.com ([192.55.52.136]:10462 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1377176AbiATQ5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 11:57:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642697839; x=1674233839;
  h=date:from:to:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to;
  bh=pCcwTYYesBJwbUxzk/FlPOIcKf6xw2HINpD6RNQi8Ug=;
  b=mio8YSRAqurha6z+YCGHa20GK7EYxbTZdcZIc0dtbdAcOMiuQ+UeYDGv
   4m4zlra6u5dzYy5w6vwc3Id8sT2JaEzm9HlmriMtmNgq7dLMi/G0ODVj6
   wDeVaDZNsYuK9O573TPBt9FecNiuUgIPNXTY761U9wviUSuVfIGWEPybe
   JZKdcdUUxwmR/S88u2nWKizRmSIAy2XuSyxxxJkTqIho4BQEvazqQFE/0
   dMvn8dDcTI3FFDYvkdp/TO2oTHsyDxcl3iru/8SratB5IX2J5ma8vDQvi
   lzdieDMnVBxuy6L28+BlKIBDkF0ZN06M6Avkn/dIPeeRzclHC1AWjVT5h
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="225377673"
X-IronPort-AV: E=Sophos;i="5.88,302,1635231600"; 
   d="scan'208";a="225377673"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 08:57:18 -0800
X-IronPort-AV: E=Sophos;i="5.88,302,1635231600"; 
   d="scan'208";a="532859202"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 08:57:18 -0800
Date:   Thu, 20 Jan 2022 08:57:17 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [Intel-gfx] [PATCH 0/7] DRM kmap() fixes and kmap_local_page()
 conversions
Message-ID: <20220120165717.GG209936@iweiny-DESK2.sc.intel.com>
References: <20211210232404.4098157-1-ira.weiny@intel.com>
 <20220119165356.GD209936@iweiny-DESK2.sc.intel.com>
 <YehJRt+JngIsj+Gd@phenom.ffwll.local>
 <20220119235542.GF209936@iweiny-DESK2.sc.intel.com>
 <fb71af05-a889-8f6e-031b-426b58a64f00@amd.com>
 <YemEYndwyP6BHwMx@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YemEYndwyP6BHwMx@phenom.ffwll.local>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 04:48:50PM +0100, Daniel Vetter wrote:
> On Thu, Jan 20, 2022 at 09:16:35AM +0100, Christian König wrote:
> > Am 20.01.22 um 00:55 schrieb Ira Weiny:
> > > On Wed, Jan 19, 2022 at 06:24:22PM +0100, Daniel Vetter wrote:
> > > > On Wed, Jan 19, 2022 at 08:53:56AM -0800, Ira Weiny wrote:
> > > > > On Fri, Dec 10, 2021 at 03:23:57PM -0800, 'Ira Weiny' wrote:
> > > > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > > > 
> > > > > > This series starts by converting the last easy kmap() uses to
> > > > > > kmap_local_page().
> > > > > > 
> > > > > > There is one more call to kmap() wrapped in ttm_bo_kmap_ttm().  Unfortunately,
> > > > > > ttm_bo_kmap_ttm() is called in a number of different ways including some which
> > > > > > are not thread local.  I have a patch to convert that call.  However, it is not
> > > > > > straight forward so it is not included in this series.
> > > > > > 
> > > > > > The final 2 patches fix bugs found while working on the ttm_bo_kmap_ttm()
> > > > > > conversion.
> > > > > Gentile ping on this series?  Will it make this merge window?
> > > > I think this fell through the cracks and so no. Note that generally we
> > > > feature-freeze drm tree around -rc6 anyway for the upcoming merge window,
> > > > so you were cutting this all a bit close anyway.
> > > Ok, No problem.  I just had not heard if this was picked up or not.
> > > 
> > > > Also looks like the ttm
> > > > kmap caching question didn't get resolved?
> > > I'm sorry I thought it was resolve for this series.  Christian said the patches
> > > in this series were "a good bug fix" even if not strictly necessary.[1]  Beyond
> > > this series I was discussing where to go from here, and is it possible to go
> > > further with more changes.[2]  At the moment I don't think I will.
> > > 
> > > Christian did I misunderstand?  I can drop patch 6 and 7 if they are not proper
> > > bug fixes or at least clarifications to the code.
> > 
> > Yeah, it is indeed a correct cleanup. I would just *not* put a CC stable on
> > it because it doesn't really fix anything.
> 
> Ok can you pls get the amd/radeon ones stuffed into alex' tree? Or do we
> want to put all the ttm ones into drm-misc instead?

I just updated to the latest master and there is a minor conflict.  Since this
is not going in this window.  Let me rebase and resend.

Ira

> -Daniel
> 
