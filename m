Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992335770F8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 21:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbiGPTEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 15:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiGPTEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 15:04:37 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DE9205DE
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 12:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657998276; x=1689534276;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8frvfJ6bz/9hCYcXkLFOuympGu4Rfw7p/JbRkZZZy0Y=;
  b=HiCR9EVH76URPxrWSkzRg6WDtZ+3n5Ih9gCL2+BfsTtz3hz16BB5jKWr
   vtOZCo1gNZx2/6ukyshsrzTiQYwbpmtxjjfgcAkj/t9ugrpIPceiA3HLK
   l1+5V7qae/kCBMpdpa4K+y0umuCUqLyUe5MHNL+B8oEjtMsLxUzaWts7z
   a/EnXevmJPJ21AUizmpghKGaHl+65SNhzFS1JhYdnp+b5qYA1GLYqnon1
   eaFm6sVujHah5/wUAD3HC3b+9H3y+/wAyhGq/yHHPQA2p5liDgq81c6ZE
   ppdW6dPpflyAS+r9NAP/wX0M+PXRBhbEr2BG2AXKjZEhmu7ePwZ6ajp9M
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="269021473"
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="269021473"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 12:04:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="686305192"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jul 2022 12:04:33 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCn5c-00021a-Hm;
        Sat, 16 Jul 2022 19:04:32 +0000
Date:   Sun, 17 Jul 2022 03:04:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matthieu CHARETTE <matthieu.charette@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        andrealmeid@igalia.com
Cc:     kbuild-all@lists.01.org,
        Matthieu CHARETTE <matthieu.charette@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: Fix EDID firmware load on resume
Message-ID: <202207170211.AaMpUwPs-lkp@intel.com>
References: <20220715092253.17529-1-matthieu.charette@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715092253.17529-1-matthieu.charette@gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthieu,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v5.19-rc6]
[also build test WARNING on linus/master]
[cannot apply to drm-misc/drm-misc-next next-20220715]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthieu-CHARETTE/drm-Fix-EDID-firmware-load-on-resume/20220716-214028
base:    32346491ddf24599decca06190ebca03ff9de7f8
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220717/202207170211.AaMpUwPs-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/e583aaf4f6464add35f2350c728d80a3fe790638
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Matthieu-CHARETTE/drm-Fix-EDID-firmware-load-on-resume/20220716-214028
        git checkout e583aaf4f6464add35f2350c728d80a3fe790638
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/drm_connector.c:25:
>> include/drm/drm_edid.h:387:1: warning: 'drm_cache_edid_firmware' used but never defined
     387 | drm_cache_edid_firmware(struct drm_connector *connector);
         | ^~~~~~~~~~~~~~~~~~~~~~~


vim +/drm_cache_edid_firmware +387 include/drm/drm_edid.h

   374	
   375	int drm_edid_to_sad(const struct edid *edid, struct cea_sad **sads);
   376	int drm_edid_to_speaker_allocation(const struct edid *edid, u8 **sadb);
   377	int drm_av_sync_delay(struct drm_connector *connector,
   378			      const struct drm_display_mode *mode);
   379	
   380	#ifdef CONFIG_DRM_LOAD_EDID_FIRMWARE
   381	void drm_cache_edid_firmware(struct drm_connector *connector);
   382	struct edid *drm_load_edid_firmware(struct drm_connector *connector);
   383	int __drm_set_edid_firmware_path(const char *path);
   384	int __drm_get_edid_firmware_path(char *buf, size_t bufsize);
   385	#else
   386	static inline void
 > 387	drm_cache_edid_firmware(struct drm_connector *connector);
   388	static inline struct edid *
   389	drm_load_edid_firmware(struct drm_connector *connector)
   390	{
   391		return ERR_PTR(-ENOENT);
   392	}
   393	#endif
   394	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
