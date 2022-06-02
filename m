Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE95553B5AE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 11:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbiFBJFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 05:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbiFBJFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 05:05:40 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98F22A80EB;
        Thu,  2 Jun 2022 02:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654160738; x=1685696738;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=4oEeBotuaVj/tAGV+5gO0EXVh2xbVUIWuPkd2EPJER8=;
  b=W/YG8gcGJHt5XWwLbIYCqZxY48ZjEGv6ifGKwtYOgU4ioEATM+RNaukX
   G5CyaWfYMw7wLaR2K1l5LEx43jHsVWc1EDDMG7/dGnmYUd+ydsyvuwHho
   oDxcV5lPc91TmLkgaMF1WQd58QLoqWTXkF49MIPCd27sUgyHkmX+PHEQQ
   euYn4S9HDuigtf2dsoHfrandeSdURfZvOE/uM+J+KS9WMPmcQuNNjZSxc
   ZHTNl0OEVWR220azfC4wH/EQtM8yl/CT4QSpVXz40qzaP/61wACqSVa7p
   Up2ExgvvUoTcZTOgigwMnErzuTRXXKhGsSBgMumB1Kitvc3e2nrRxpduJ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="275894022"
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="275894022"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 02:05:38 -0700
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="552747058"
Received: from fbackhou-mobl.ger.corp.intel.com (HELO localhost) ([10.252.46.4])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 02:05:32 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>
Cc:     dmitry.baryshkov@linaro.org, tzimmermann@suse.de,
        linux-arm-msm@vger.kernel.org, swboyd@chromium.org,
        ville.syrjala@linux.intel.com, quic_sbillaka@quicinc.com,
        quic_khsieh@quicinc.com, quic_abhinavk@quicinc.com,
        robdclark@gmail.com, freedreno@lists.freedesktop.org,
        quic_aravindh@quicinc.com,
        Douglas Anderson <dianders@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] drm/probe-helper: Default to 640x480 if no EDID on DP
In-Reply-To: <20220601112302.v4.1.I31ec454f8d4ffce51a7708a8092f8a6f9c929092@changeid>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220601112302.v4.1.I31ec454f8d4ffce51a7708a8092f8a6f9c929092@changeid>
Date:   Thu, 02 Jun 2022 12:05:29 +0300
Message-ID: <87v8tjph9i.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Jun 2022, Douglas Anderson <dianders@chromium.org> wrote:
> If we're unable to read the EDID for a display because it's corrupt /
> bogus / invalid then we'll add a set of standard modes for the
> display. Since we have no true information about the connected
> display, these modes are essentially guesses but better than nothing.
> At the moment, none of the modes returned is marked as preferred, but
> the modes are sorted such that the higher resolution modes are listed
> first.
>
> When userspace sees these modes presented by the kernel it needs to
> figure out which one to pick. At least one userspace, ChromeOS [1]
> seems to use the rules (which seem pretty reasonable):
> 1. Try to pick the first mode marked as preferred.
> 2. Try to pick the mode which matches the first detailed timing
>    descriptor in the EDID.
> 3. If no modes were marked as preferred then pick the first mode.
>
> Unfortunately, userspace's rules combined with what the kernel is
> doing causes us to fail section 4.2.2.6 (EDID Corruption Detection) of
> the DP 1.4a Link CTS. That test case says that, while it's OK to allow
> some implementation-specific fall-back modes if the EDID is bad that
> userspace should _default_ to 640x480.
>
> Let's fix this by marking 640x480 as default for DP in the no-EDID
> case.
>
> NOTES:
> - In the discussion around v3 of this patch [2] there was talk about
>   solving this in userspace and I even implemented a patch that would
>   have solved this for ChromeOS, but then the discussion turned back
>   to solving this in the kernel.
> - Also in the discussion of v3 [2] it was requested to limit this
> 83;40900;0c  change to just DP since folks were worried that it would break some
>   subtle corner case on VGA or HDMI.
>
> [1] https://source.chromium.org/chromium/chromium/src/+/a051f741d0a15caff2251301efe081c30e0f4a96:ui/ozone/platform/drm/common/drm_util.cc;l=488
> [2] https://lore.kernel.org/r/20220513130533.v3.1.I31ec454f8d4ffce51a7708a8092f8a6f9c929092@changeid
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
> I put Abhinav's Reviewed-by tag from v2 here since this is nearly the
> same as v2. Hope this is OK.
>
> Changes in v4:
> - Code is back to v2, but limit to just DP.
> - Beefed up the commit message.
>
> Changes in v3:
> - Don't set preferred, just disable the sort.
>
> Changes in v2:
> - Don't modify drm_add_modes_noedid() 'cause that'll break others
> - Set 640x480 as preferred in drm_helper_probe_single_connector_modes()
>
>  drivers/gpu/drm/drm_probe_helper.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
> index 425f56280d51..75a71649b64d 100644
> --- a/drivers/gpu/drm/drm_probe_helper.c
> +++ b/drivers/gpu/drm/drm_probe_helper.c
> @@ -569,8 +569,17 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
>  		count = drm_add_override_edid_modes(connector);
>  
>  	if (count == 0 && (connector->status == connector_status_connected ||
> -			   connector->status == connector_status_unknown))
> +			   connector->status == connector_status_unknown)) {
>  		count = drm_add_modes_noedid(connector, 1024, 768);
> +
> +		/*
> +		 * Section 4.2.2.6 (EDID Corruption Detection) of the DP 1.4a
> +		 * Link CTS specifies that 640x480 (the official "failsafe"
> +		 * mode) needs to be the default if there's no EDID.
> +		 */
> +		if (connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort)

If we're doing this primarily to appease the CTS, this is fine.

If we think this is a functional improvement for regular use, I suppose
we should consider doing this also for DRM_MODE_CONNECTOR_eDP. Which is
irrelevant for the CTS.

Either way,

Acked-by: Jani Nikula <jani.nikula@intel.com>

> +			drm_set_preferred_mode(connector, 640, 480);
> +	}
>  	count += drm_helper_probe_add_cmdline_mode(connector);
>  	if (count != 0) {
>  		ret = __drm_helper_update_and_validate(connector, maxX, maxY, &ctx);

-- 
Jani Nikula, Intel Open Source Graphics Center
