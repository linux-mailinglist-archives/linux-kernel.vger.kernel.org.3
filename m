Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72BD6463BA7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243486AbhK3Q0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:26:13 -0500
Received: from mga04.intel.com ([192.55.52.120]:33086 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234862AbhK3Q0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:26:12 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="234975213"
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="234975213"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 08:22:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="540465576"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by orsmga001.jf.intel.com with SMTP; 30 Nov 2021 08:22:49 -0800
Received: by stinkbox (sSMTP sendmail emulation); Tue, 30 Nov 2021 18:22:48 +0200
Date:   Tue, 30 Nov 2021 18:22:48 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     David Airlie <airlied@linux.ie>, kjlu@umn.edu,
        linux-kernel@vger.kernel.org, Zhao Yakui <yakui.zhao@intel.com>,
        dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] drm/gma500/cdv: Fix a wild pointer dereference in
 cdv_intel_dp_get_modes()
Message-ID: <YaZP2HzTQw1QJxOK@intel.com>
References: <20211130132328.129383-1-zhou1615@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211130132328.129383-1-zhou1615@umn.edu>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 09:23:28PM +0800, Zhou Qingyang wrote:
> In cdv_intel_dp_get_modes(), the third return value of
> drm_mode_duplicate() is assigned to mode and used in
> drm_mode_probed_add(). drm_mode_probed_add() passes mode->head to
> list_add_tail(). list_add_tail() will further call __list_add() and
> there is a dereference of mode->head in __list_add(), which could lead
> to a wild pointer dereference on failure of drm_mode_duplicate().
> 
> Fix this bug by adding a check of mode.
> 
> This bug was found by a static analyzer. The analysis employs
> differential checking to identify inconsistent security operations
> (e.g., checks or kfrees) between two code paths and confirms that the
> inconsistent operations are not recovered in the current function or
> the callers, so they constitute bugs.
> 
> Note that, as a bug found by static analysis, it can be a false
> positive or hard to trigger. Multiple researchers have cross-reviewed
> the bug.
> 
> Builds with CONFIG_DRM_GMA500=m show no new warnings,
> and our static analyzer no longer warns about this code.
> 
> Fixes: d112a8163f83 ("gma500/cdv: Add eDP support")
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> ---
>  drivers/gpu/drm/gma500/cdv_intel_dp.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/gma500/cdv_intel_dp.c b/drivers/gpu/drm/gma500/cdv_intel_dp.c
> index ba6ad1466374..b389008965a9 100644
> --- a/drivers/gpu/drm/gma500/cdv_intel_dp.c
> +++ b/drivers/gpu/drm/gma500/cdv_intel_dp.c
> @@ -1773,6 +1773,9 @@ static int cdv_intel_dp_get_modes(struct drm_connector *connector)
>  		if (intel_dp->panel_fixed_mode != NULL) {
>  			struct drm_display_mode *mode;
>  			mode = drm_mode_duplicate(dev, intel_dp->panel_fixed_mode);
> +			if (!mode)
> +				return -ENOMEM;

.get_modes() isn't supposed to return negative values.

> +
>  			drm_mode_probed_add(connector, mode);
>  			return 1;
>  		}
> -- 
> 2.25.1

-- 
Ville Syrjälä
Intel
