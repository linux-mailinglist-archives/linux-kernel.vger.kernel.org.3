Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27C457761B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 14:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbiGQMTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 08:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiGQMTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 08:19:34 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839906253
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 05:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658060373; x=1689596373;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fm0yl+AmZGkN8KmCTahys4EupjeO4maSBEAoi742aEI=;
  b=RiF88pjqhMzSqeXpFSSttT3muTYJg91scxwwJhz0odK8vPLJ0qItWIAa
   fFee0o++053oBcJJcoMGqv6HQToUXjAKAySqfzJKp6zeuSHRJRJ/sz2se
   pL/1bEZiZZi6MlChtOppak+BojZoaILJFbt4GUDestOve4Mhl2Z+D9VT8
   cywoAFFp81cPFHNX4FIFaFU+7HEQP72mhJHAEDDJgPFY6LOVLJTuY6zYz
   7N7EvX7a2AZ0jrDv/I+TaMy33xh0SRluzDY7HoLwL759BTrpBG4S4sIw1
   3F39ZdjxWsQUjdnXnl2VDl0w8x/hmGeOPL2CMkBdfRt8qby9F17rBCzBB
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="269079474"
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="269079474"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 05:19:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="924020499"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 17 Jul 2022 05:19:30 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oD3FB-0003DK-UR;
        Sun, 17 Jul 2022 12:19:29 +0000
Date:   Sun, 17 Jul 2022 20:18:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matthieu CHARETTE <matthieu.charette@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        andrealmeid@igalia.com
Cc:     kbuild-all@lists.01.org,
        Matthieu CHARETTE <matthieu.charette@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: Fix EDID firmware load on resume
Message-ID: <202207172035.mtErdlaw-lkp@intel.com>
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
config: loongarch-randconfig-s052-20220715 (https://download.01.org/0day-ci/archive/20220717/202207172035.mtErdlaw-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/e583aaf4f6464add35f2350c728d80a3fe790638
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Matthieu-CHARETTE/drm-Fix-EDID-firmware-load-on-resume/20220716-214028
        git checkout e583aaf4f6464add35f2350c728d80a3fe790638
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/gpu/drm/drm_connector.c: note: in included file:
>> include/drm/drm_edid.h:387:24: sparse: sparse: marked inline, but without a definition

vim +387 include/drm/drm_edid.h

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
