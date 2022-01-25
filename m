Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559DE49AD44
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 08:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358845AbiAYHKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 02:10:08 -0500
Received: from mga17.intel.com ([192.55.52.151]:45815 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1442352AbiAYHHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 02:07:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643094458; x=1674630458;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=yGV7YtKAgiBGeCNiwRFnIigFHqGr5li2VVz16Ut0GkA=;
  b=nkJvrgCS3b1v/PO9jk4QZs7wuFMS/+dh+hGrFrwZXgkP3uCsdHsMzlYD
   MitNvV4Nurx8YQZsFRGiO6eQTwH84CTmo2v46kC4bc6WXo4NHOPCapAZW
   yRsVhS2YuucCvqxeN7ewjUEmHoR5X02Q4HN6/GkJ0vjcIoqe4fZhsvGcm
   demNDV/ySMMX35e3D48+kaZMeIRz+PYKOjg7mHMMrQ5BpfPuHCEQX8Wzb
   R0fFRxmLszTGiLZpev1XSYmchcwr3yli6Qm4aoaDQrrlJ6TkJK3/2bl4Z
   5JEa9R8x8eU37vluBOcmpzkHj1AhogOUZDRstlD6li7hYOu0iycGuXOXN
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="226908641"
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="226908641"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 23:02:19 -0800
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="534599476"
Received: from skirillo-mobl1.ccr.corp.intel.com (HELO localhost) ([10.252.32.77])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 23:02:15 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Yaroslav Bolyukin <iam@lach.pw>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     intel-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Yaroslav Bolyukin <iam@lach.pw>
Subject: Re: [PATCH v2] drm/edid: Support type 7 timings
In-Reply-To: <20220123191955.57994-1-iam@lach.pw>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220118215956.17229-1-iam@lach.pw>
 <20220123191955.57994-1-iam@lach.pw>
Date:   Tue, 25 Jan 2022 09:02:00 +0200
Message-ID: <87lez41eon.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jan 2022, Yaroslav Bolyukin <iam@lach.pw> wrote:
> Per VESA DisplayID Standard v2.0: Type VII Timing =E2=80=93 Detailed Timi=
ng Data
>
> Definitions were already provided as type I, but not used
>
> Signed-off-by: Yaroslav Bolyukin <iam@lach.pw>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/gpu/drm/drm_edid.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 12893e7be..5f2ae5bfa 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -5405,7 +5405,8 @@ u32 drm_add_display_info(struct drm_connector *conn=
ector, const struct edid *edi
>  }
>=20=20
>  static struct drm_display_mode *drm_mode_displayid_detailed(struct drm_d=
evice *dev,
> -							    struct displayid_detailed_timings_1 *timings)
> +							    struct displayid_detailed_timings_1 *timings,
> +							    bool type_7)
>  {
>  	struct drm_display_mode *mode;
>  	unsigned pixel_clock =3D (timings->pixel_clock[0] |
> @@ -5426,7 +5427,8 @@ static struct drm_display_mode *drm_mode_displayid_=
detailed(struct drm_device *d
>  	if (!mode)
>  		return NULL;
>=20=20
> -	mode->clock =3D pixel_clock * 10;
> +	/* resolution is kHz for type VII, and 10 kHz for type I */
> +	mode->clock =3D type_7 ? pixel_clock : pixel_clock * 10;
>  	mode->hdisplay =3D hactive;
>  	mode->hsync_start =3D mode->hdisplay + hsync;
>  	mode->hsync_end =3D mode->hsync_start + hsync_width;
> @@ -5457,6 +5459,7 @@ static int add_displayid_detailed_1_modes(struct dr=
m_connector *connector,
>  	int num_timings;
>  	struct drm_display_mode *newmode;
>  	int num_modes =3D 0;
> +	bool type_7 =3D block->tag =3D=3D DATA_BLOCK_2_TYPE_7_DETAILED_TIMING;
>  	/* blocks must be multiple of 20 bytes length */
>  	if (block->num_bytes % 20)
>  		return 0;
> @@ -5465,7 +5468,7 @@ static int add_displayid_detailed_1_modes(struct dr=
m_connector *connector,
>  	for (i =3D 0; i < num_timings; i++) {
>  		struct displayid_detailed_timings_1 *timings =3D &det->timings[i];
>=20=20
> -		newmode =3D drm_mode_displayid_detailed(connector->dev, timings);
> +		newmode =3D drm_mode_displayid_detailed(connector->dev, timings, type_=
7);
>  		if (!newmode)
>  			continue;
>=20=20
> @@ -5484,7 +5487,8 @@ static int add_displayid_detailed_modes(struct drm_=
connector *connector,
>=20=20
>  	displayid_iter_edid_begin(edid, &iter);
>  	displayid_iter_for_each(block, &iter) {
> -		if (block->tag =3D=3D DATA_BLOCK_TYPE_1_DETAILED_TIMING)
> +		if (block->tag =3D=3D DATA_BLOCK_TYPE_1_DETAILED_TIMING ||
> +		    block->tag =3D=3D DATA_BLOCK_2_TYPE_7_DETAILED_TIMING)
>  			num_modes +=3D add_displayid_detailed_1_modes(connector, block);
>  	}
>  	displayid_iter_end(&iter);
>
> base-commit: 99613159ad749543621da8238acf1a122880144e

--=20
Jani Nikula, Intel Open Source Graphics Center
