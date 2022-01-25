Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C5D49B426
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 13:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383877AbiAYMkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 07:40:12 -0500
Received: from mga03.intel.com ([134.134.136.65]:36892 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1383482AbiAYMfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 07:35:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643114136; x=1674650136;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=o5TdtsHZe7kwjYyqWeQhslE5X0C70dUziNr8LYxQRmA=;
  b=UbweR1a8LHb59kyioxb4gmTHwpZfEdq1JvPkiVtJo0Kry0RiVETuvNNv
   e51ZjwkruHOHpXX3MbHHT7/BDI4ANtu44Z6tG6JtHZTblEqIowSiKdcqo
   SS553kYqqfakbQuVmbkp9kblJmqUP2nmJ7oBUv9UYx8i0bXh5NSwITP3m
   RL+mlJbnxyPBO61OUCogsfILSzL/z2PC3ACBJN5vpUznmZFJwKCXUe2E3
   9akIX9yL/35WJYuKDVQ7ssfQp20FI+QWC7UwFijp1DV7jgr8R0LMJRdfU
   a/Z1bsJ7lnHtbGwaiGfkuw0QlN4DlH1cgbpk3QVYAWouEDApwgLEI1y7F
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="246234128"
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="246234128"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 04:35:30 -0800
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="534708149"
Received: from skirillo-mobl1.ccr.corp.intel.com (HELO localhost) ([10.252.32.77])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 04:35:27 -0800
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
In-Reply-To: <87lez41eon.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220118215956.17229-1-iam@lach.pw>
 <20220123191955.57994-1-iam@lach.pw> <87lez41eon.fsf@intel.com>
Date:   Tue, 25 Jan 2022 14:35:12 +0200
Message-ID: <87zgnkyovz.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Sun, 23 Jan 2022, Yaroslav Bolyukin <iam@lach.pw> wrote:
>> Per VESA DisplayID Standard v2.0: Type VII Timing =E2=80=93 Detailed Tim=
ing Data
>>
>> Definitions were already provided as type I, but not used
>>
>> Signed-off-by: Yaroslav Bolyukin <iam@lach.pw>
>
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>

And pushed to drm-misc-next, thanks for the patch.

BR,
Jani.

>
>> ---
>>  drivers/gpu/drm/drm_edid.c | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
>> index 12893e7be..5f2ae5bfa 100644
>> --- a/drivers/gpu/drm/drm_edid.c
>> +++ b/drivers/gpu/drm/drm_edid.c
>> @@ -5405,7 +5405,8 @@ u32 drm_add_display_info(struct drm_connector *con=
nector, const struct edid *edi
>>  }
>>=20=20
>>  static struct drm_display_mode *drm_mode_displayid_detailed(struct drm_=
device *dev,
>> -							    struct displayid_detailed_timings_1 *timings)
>> +							    struct displayid_detailed_timings_1 *timings,
>> +							    bool type_7)
>>  {
>>  	struct drm_display_mode *mode;
>>  	unsigned pixel_clock =3D (timings->pixel_clock[0] |
>> @@ -5426,7 +5427,8 @@ static struct drm_display_mode *drm_mode_displayid=
_detailed(struct drm_device *d
>>  	if (!mode)
>>  		return NULL;
>>=20=20
>> -	mode->clock =3D pixel_clock * 10;
>> +	/* resolution is kHz for type VII, and 10 kHz for type I */
>> +	mode->clock =3D type_7 ? pixel_clock : pixel_clock * 10;
>>  	mode->hdisplay =3D hactive;
>>  	mode->hsync_start =3D mode->hdisplay + hsync;
>>  	mode->hsync_end =3D mode->hsync_start + hsync_width;
>> @@ -5457,6 +5459,7 @@ static int add_displayid_detailed_1_modes(struct d=
rm_connector *connector,
>>  	int num_timings;
>>  	struct drm_display_mode *newmode;
>>  	int num_modes =3D 0;
>> +	bool type_7 =3D block->tag =3D=3D DATA_BLOCK_2_TYPE_7_DETAILED_TIMING;
>>  	/* blocks must be multiple of 20 bytes length */
>>  	if (block->num_bytes % 20)
>>  		return 0;
>> @@ -5465,7 +5468,7 @@ static int add_displayid_detailed_1_modes(struct d=
rm_connector *connector,
>>  	for (i =3D 0; i < num_timings; i++) {
>>  		struct displayid_detailed_timings_1 *timings =3D &det->timings[i];
>>=20=20
>> -		newmode =3D drm_mode_displayid_detailed(connector->dev, timings);
>> +		newmode =3D drm_mode_displayid_detailed(connector->dev, timings, type=
_7);
>>  		if (!newmode)
>>  			continue;
>>=20=20
>> @@ -5484,7 +5487,8 @@ static int add_displayid_detailed_modes(struct drm=
_connector *connector,
>>=20=20
>>  	displayid_iter_edid_begin(edid, &iter);
>>  	displayid_iter_for_each(block, &iter) {
>> -		if (block->tag =3D=3D DATA_BLOCK_TYPE_1_DETAILED_TIMING)
>> +		if (block->tag =3D=3D DATA_BLOCK_TYPE_1_DETAILED_TIMING ||
>> +		    block->tag =3D=3D DATA_BLOCK_2_TYPE_7_DETAILED_TIMING)
>>  			num_modes +=3D add_displayid_detailed_1_modes(connector, block);
>>  	}
>>  	displayid_iter_end(&iter);
>>
>> base-commit: 99613159ad749543621da8238acf1a122880144e

--=20
Jani Nikula, Intel Open Source Graphics Center
