Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762D04AD28D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 08:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348641AbiBHHwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 02:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245326AbiBHHwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 02:52:13 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96684C03FEC4;
        Mon,  7 Feb 2022 23:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644306732; x=1675842732;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zSjGWEp/lad+yOmZqYzDcbgsisGuWA+cNAYLyxP20Lw=;
  b=XAhWITI5qrEcow3cU1PcUWoWGS7L55PvbmUO8ud2xNVCVoGSftShXyuz
   eg50BYITTG70YHsha3yzTAeFMCUimAdzClbFwEJxfS3/+HsDIczw3M9MK
   B6ySixkCgeOP2VamGrbyYhUuNpTmZr9EnzZWvC7er6iGmF0LaJePH3QX5
   j4PeD86aD5j7GfTQ2cn5oyNsT8kgB59/RZBDGD/lTJWlahlwqwEt4f8Nx
   uCukxUM9Lv5CtF/yrxyjM1BEy2QPXpfFKJ7InHBGWlrgjsJhdn8C9CNch
   PHXGf36tNpm3zHxnS/7J569cPOlwuQdWmH9jHHbc2qGEpuV0p85+bT/rc
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="248843415"
X-IronPort-AV: E=Sophos;i="5.88,352,1635231600"; 
   d="scan'208";a="248843415"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 23:52:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,352,1635231600"; 
   d="scan'208";a="484724374"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.151])
  by orsmga006.jf.intel.com with SMTP; 07 Feb 2022 23:52:06 -0800
Received: by stinkbox (sSMTP sendmail emulation); Tue, 08 Feb 2022 09:52:05 +0200
Date:   Tue, 8 Feb 2022 09:52:05 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        devicetree@vger.kernel.org, Simon Ser <contact@emersion.fr>,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Harry Wentland <harry.wentland@amd.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [Intel-gfx] [PATCH v7 1/3] gpu: drm: separate panel orientation
 property creating and value setting
Message-ID: <YgIhJb3+MckKD4dC@intel.com>
References: <20220208073714.1540390-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220208073714.1540390-1-hsinyi@chromium.org>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 03:37:12PM +0800, Hsin-Yi Wang wrote:
> +int drm_connector_init_panel_orientation_property(
> +	struct drm_connector *connector)
> +{
> +	struct drm_device *dev = connector->dev;
> +	struct drm_property *prop;
> +
> +	prop = drm_property_create_enum(dev, DRM_MODE_PROP_IMMUTABLE,
> +			"panel orientation",
> +			drm_panel_orientation_enum_list,
> +			ARRAY_SIZE(drm_panel_orientation_enum_list));
> +	if (!prop)
> +		return -ENOMEM;
> +
> +	dev->mode_config.panel_orientation_property = prop;

Leak when called multiple times. I guess you could just put
this into drm_connector_create_standard_properties() instead
and avoid that issue entirely.

-- 
Ville Syrjälä
Intel
