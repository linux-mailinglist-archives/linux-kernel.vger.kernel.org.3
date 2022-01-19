Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37B8493768
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352365AbiASJfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:35:20 -0500
Received: from mga12.intel.com ([192.55.52.136]:63131 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348111AbiASJfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:35:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642584918; x=1674120918;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=ndvrmURrxy4kiioDfTfLexZ1VBXN7lk0j3l4UZmp0q4=;
  b=IPmdFZ5Ouo0NMWUs4VZtqbbpS1Ac+itSQTDQJy66FSDPLjOTDOlpY8/3
   Se/6kCLdgvOX56ZQYCn6KfWJVCp8kYfM5zIkftxJ9D551IvBgzJqc3uIn
   TSO46VmuEKu++ekD3FRUmpmtKXMTdz1AHEluO+N6BnJr/qb39uyKB8ZC8
   FDNOhTpKR2wECkx9WRkSY9PkKsyKLKx/8+kT635pKgRhz/g44jtIm3NTK
   X0saCbcYEkx05F2b5jv0GZ4EeUlb8d1xGfXgcFi1gmTF+MS0ocEbUfddQ
   lJftLPPdgtbA3MZ8A1ABGvQ42VQaEpMHLI2EoWJ/SJT286jnPQTCGoaSx
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="225004386"
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="225004386"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 01:35:11 -0800
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="532204900"
Received: from elenadel-mobl.ger.corp.intel.com (HELO localhost) ([10.252.50.196])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 01:35:08 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Yaroslav Bolyukin <iam@lach.pw>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     Yaroslav Bolyukin <iam@lach.pw>, David Airlie <airlied@linux.ie>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH] drm/edid: Support type 7 timings
In-Reply-To: <20220118215956.17229-1-iam@lach.pw>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220118215956.17229-1-iam@lach.pw>
Date:   Wed, 19 Jan 2022 11:35:06 +0200
Message-ID: <874k60cblh.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2022, Yaroslav Bolyukin <iam@lach.pw> wrote:
> Per VESA DisplayID Standard v2.0: Type VII Timing =E2=80=93 Detailed Timi=
ng Data
>
> Definitions were already provided as type I, but not used

Thanks for the patch. Functionally I think it looks correct, and
something we'll want. I do have some nitpicks though, comments inline.

For the next version, please consider Cc'ing the intel-gfx list as well
to get our CI results on it too.

BR,
Jani.

>
> Signed-off-by: Yaroslav Bolyukin <iam@lach.pw>
> ---
>  drivers/gpu/drm/drm_edid.c  | 26 +++++++++++++++++---------
>  include/drm/drm_displayid.h |  6 +++---
>  2 files changed, 20 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 12893e7be..5fcefd9b5 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -5404,13 +5404,17 @@ u32 drm_add_display_info(struct drm_connector *co=
nnector, const struct edid *edi
>  	return quirks;
>  }
>=20=20
> -static struct drm_display_mode *drm_mode_displayid_detailed(struct drm_d=
evice *dev,
> -							    struct displayid_detailed_timings_1 *timings)
> +static struct drm_display_mode *drm_mode_displayid_detailed_1_7(struct d=
rm_device *dev,
> +								struct displayid_detailed_timings_1_7 *timings,
> +								bool type_7)

I think the function rename here is unnecessary.

>  {
>  	struct drm_display_mode *mode;
>  	unsigned pixel_clock =3D (timings->pixel_clock[0] |
>  				(timings->pixel_clock[1] << 8) |
>  				(timings->pixel_clock[2] << 16)) + 1;
> +	// type 7 allows higher precision pixel clock

Please don't use // style comments.

For the comment contents, I think you should just state the units for
each; 10 kHz for type I, kHz for type VII.

> +	if (!type_7)
> +		pixel_clock *=3D 10;

Please don't mix declarations and code.

>  	unsigned hactive =3D (timings->hactive[0] | timings->hactive[1] << 8) +=
 1;
>  	unsigned hblank =3D (timings->hblank[0] | timings->hblank[1] << 8) + 1;
>  	unsigned hsync =3D (timings->hsync[0] | (timings->hsync[1] & 0x7f) << 8=
) + 1;
> @@ -5426,7 +5430,7 @@ static struct drm_display_mode *drm_mode_displayid_=
detailed(struct drm_device *d
>  	if (!mode)
>  		return NULL;
>=20=20
> -	mode->clock =3D pixel_clock * 10;
> +	mode->clock =3D pixel_clock;

Since we used to have the multiplication here (and we don't mix
declarations and code anyway) I'd keep it here.

Maybe:

	mode->clock =3D type_7 ? pixel_clock : pixel_clock * 10;

>  	mode->hdisplay =3D hactive;
>  	mode->hsync_start =3D mode->hdisplay + hsync;
>  	mode->hsync_end =3D mode->hsync_start + hsync_width;
> @@ -5449,10 +5453,12 @@ static struct drm_display_mode *drm_mode_displayi=
d_detailed(struct drm_device *d
>  	return mode;
>  }
>=20=20
> -static int add_displayid_detailed_1_modes(struct drm_connector *connecto=
r,
> -					  const struct displayid_block *block)
> +static int add_displayid_detailed_1_7_modes(struct drm_connector *connec=
tor,
> +					    const struct displayid_block *block,
> +					    bool type_7)
>  {
> -	struct displayid_detailed_timing_block *det =3D (struct displayid_detai=
led_timing_block *)block;
> +	struct displayid_detailed_timing_1_7_block *det =3D
> +		(struct displayid_detailed_timing_1_7_block *)block;

I think the displayid_detailed_timing_block ->
displayid_detailed_timing_1_7_block rename is unnecessary.

>  	int i;
>  	int num_timings;
>  	struct drm_display_mode *newmode;
> @@ -5463,9 +5469,9 @@ static int add_displayid_detailed_1_modes(struct dr=
m_connector *connector,
>=20=20
>  	num_timings =3D block->num_bytes / 20;
>  	for (i =3D 0; i < num_timings; i++) {
> -		struct displayid_detailed_timings_1 *timings =3D &det->timings[i];
> +		struct displayid_detailed_timings_1_7 *timings =3D &det->timings[i];
>=20=20
> -		newmode =3D drm_mode_displayid_detailed(connector->dev, timings);
> +		newmode =3D drm_mode_displayid_detailed_1_7(connector->dev, timings, t=
ype_7);
>  		if (!newmode)
>  			continue;
>=20=20
> @@ -5485,7 +5491,9 @@ static int add_displayid_detailed_modes(struct drm_=
connector *connector,
>  	displayid_iter_edid_begin(edid, &iter);
>  	displayid_iter_for_each(block, &iter) {
>  		if (block->tag =3D=3D DATA_BLOCK_TYPE_1_DETAILED_TIMING)
> -			num_modes +=3D add_displayid_detailed_1_modes(connector, block);
> +			num_modes +=3D add_displayid_detailed_1_7_modes(connector, block, fal=
se);
> +		else if (block->tag =3D=3D DATA_BLOCK_2_TYPE_7_DETAILED_TIMING)
> +			num_modes +=3D add_displayid_detailed_1_7_modes(connector, block, tru=
e);

I'd probably not add a true/false parameter here, since we pass in block
anyway, and the function can have and initialize the bool local variable
internally based on block->tag.

>  	}
>  	displayid_iter_end(&iter);
>=20=20
> diff --git a/include/drm/drm_displayid.h b/include/drm/drm_displayid.h
> index 7ffbd9f7b..268ff5e1f 100644
> --- a/include/drm/drm_displayid.h
> +++ b/include/drm/drm_displayid.h
> @@ -111,7 +111,7 @@ struct displayid_tiled_block {
>  	u8 topology_id[8];
>  } __packed;
>=20=20
> -struct displayid_detailed_timings_1 {
> +struct displayid_detailed_timings_1_7 {
>  	u8 pixel_clock[3];
>  	u8 flags;
>  	u8 hactive[2];
> @@ -124,9 +124,9 @@ struct displayid_detailed_timings_1 {
>  	u8 vsw[2];
>  } __packed;
>=20=20
> -struct displayid_detailed_timing_block {
> +struct displayid_detailed_timing_1_7_block {

Like I said, I wouldn't rename this.

>  	struct displayid_block base;
> -	struct displayid_detailed_timings_1 timings[];
> +	struct displayid_detailed_timings_1_7 timings[];
>  };
>=20=20
>  #define DISPLAYID_VESA_MSO_OVERLAP	GENMASK(3, 0)
>
> base-commit: 99613159ad749543621da8238acf1a122880144e

--=20
Jani Nikula, Intel Open Source Graphics Center
