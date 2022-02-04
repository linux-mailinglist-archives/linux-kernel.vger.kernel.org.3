Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04B94AA00D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 20:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbiBDT2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 14:28:18 -0500
Received: from mga14.intel.com ([192.55.52.115]:4508 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233122AbiBDT2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:28:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644002896; x=1675538896;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/tGio2O+4Nz0M4txcIhkv9RrfgoAhivXZIjNFxQms88=;
  b=knbOgWrbg5U4REbSuWcEzSk/JKG9jsrReFhtskffxoei3NdsBdQSe0sA
   fhBI6BPQVEDLFCS0JMqxLizHbFwh5kGCoE1LH2m4uc2+ZSXk+ritFpTfA
   hGRWys5PGUNqXg7KARSzFPvAJ37b0Hf7JwIffdfgVvR3WOzHsM4u0IcPg
   7rvCEWE3rJBlCNjglPZFE5aDY9f+mOb85m/srf8lS2eiY3Y5pWx8s1QZ1
   A6FHQHwYEQeSwdhKkwGpaVqeLWhlAkszkmbphK4UVlg+qotTRGIjE7UUJ
   WkZj2nouBpeorP7b86WjQGekljEma0SFInDU9im7FePdb81+XMLX2B0t3
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="248643014"
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="248643014"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 11:28:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="498571774"
Received: from safernan-mobl2.amr.corp.intel.com (HELO ldmartin-desk2) ([10.212.210.69])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 11:28:14 -0800
Date:   Fri, 4 Feb 2022 11:28:08 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Matthew Brost <matthew.brost@intel.com>,
        Thomas =?utf-8?Q?Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>, linux-kernel@vger.kernel.org,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        John Harrison <John.C.Harrison@intel.com>
Subject: Re: [PATCH 02/19] iosys-map: Add offset to iosys_map_memcpy_to()
Message-ID: <20220204192808.dx3wwjfj6sdmj5ze@ldmartin-desk2>
X-Patchwork-Hint: comment
References: <20220204174436.830121-1-lucas.demarchi@intel.com>
 <20220204174436.830121-3-lucas.demarchi@intel.com>
 <59ec3b5a-6e3f-ed8a-4cc1-c0bedb923bb8@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59ec3b5a-6e3f-ed8a-4cc1-c0bedb923bb8@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 07:48:10PM +0100, Thomas Zimmermann wrote:
>Hi
>
>Am 04.02.22 um 18:44 schrieb Lucas De Marchi:
>>In certain situations it's useful to be able to write to an
>>offset of the mapping. Add a dst_offset to iosys_map_memcpy_to().
>>
>>Cc: Sumit Semwal <sumit.semwal@linaro.org>
>>Cc: Christian König <christian.koenig@amd.com>
>>Cc: Thomas Zimmermann <tzimmermann@suse.de>
>>Cc: dri-devel@lists.freedesktop.org
>>Cc: linux-kernel@vger.kernel.org
>>Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>>---
>>  drivers/gpu/drm/drm_cache.c     |  2 +-
>>  drivers/gpu/drm/drm_fb_helper.c |  2 +-
>>  include/linux/iosys-map.h       | 17 +++++++++--------
>>  3 files changed, 11 insertions(+), 10 deletions(-)
>>
>>diff --git a/drivers/gpu/drm/drm_cache.c b/drivers/gpu/drm/drm_cache.c
>>index 66597e411764..c3e6e615bf09 100644
>>--- a/drivers/gpu/drm/drm_cache.c
>>+++ b/drivers/gpu/drm/drm_cache.c
>>@@ -218,7 +218,7 @@ static void memcpy_fallback(struct iosys_map *dst,
>>  	if (!dst->is_iomem && !src->is_iomem) {
>>  		memcpy(dst->vaddr, src->vaddr, len);
>>  	} else if (!src->is_iomem) {
>>-		iosys_map_memcpy_to(dst, src->vaddr, len);
>>+		iosys_map_memcpy_to(dst, 0, src->vaddr, len);
>>  	} else if (!dst->is_iomem) {
>>  		memcpy_fromio(dst->vaddr, src->vaddr_iomem, len);
>>  	} else {
>>diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
>>index 238f815cb2a0..bf5cc9a42e5a 100644
>>--- a/drivers/gpu/drm/drm_fb_helper.c
>>+++ b/drivers/gpu/drm/drm_fb_helper.c
>>@@ -385,7 +385,7 @@ static void drm_fb_helper_damage_blit_real(struct drm_fb_helper *fb_helper,
>>  	iosys_map_incr(dst, offset); /* go to first pixel within clip rect */
>>  	for (y = clip->y1; y < clip->y2; y++) {
>>-		iosys_map_memcpy_to(dst, src, len);
>>+		iosys_map_memcpy_to(dst, 0, src, len);
>>  		iosys_map_incr(dst, fb->pitches[0]);
>>  		src += fb->pitches[0];
>>  	}
>>diff --git a/include/linux/iosys-map.h b/include/linux/iosys-map.h
>>index f4186f91caa6..edd7fa3be9e9 100644
>>--- a/include/linux/iosys-map.h
>>+++ b/include/linux/iosys-map.h
>>@@ -220,22 +220,23 @@ static inline void iosys_map_clear(struct iosys_map *map)
>>  }
>>  /**
>>- * iosys_map_memcpy_to - Memcpy into iosys mapping
>>+ * iosys_map_memcpy_to_offset - Memcpy into offset of iosys_map
>
>'iosys_map_memcpy_to'
>
>With that fixed:
>
>Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

thanks, I noticed that, but looks like I squashed to the wrong patch.

Lucas De Marchi
