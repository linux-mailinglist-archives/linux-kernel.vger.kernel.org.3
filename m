Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF08A508551
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 11:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377422AbiDTKBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 06:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377392AbiDTKBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:01:05 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB283BFB0;
        Wed, 20 Apr 2022 02:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650448700; x=1681984700;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=trrHFL7bIpVdCRcSGzbp0komwu6+rthAc9Zo3KrMj/o=;
  b=gPESC9sYS3wxXfnN8l1ZBVG8l87LX1ZAEK4H2e0jC8DmtgDyJ/uGE27q
   M0v5/6hxVE+Jas+s7Ymmv4Ub5Edc3s19hhRgom2b4tsIkoCEN+7SjkfHn
   DmIAI3/5Nigl4bjmOMBMNoDAB/SvML3cahGogMvikSOyWYr/odtECiIK1
   5dZ2iXCYHGM5/SuuKfXBL5wmY2vS/U9mELmC8Yp3H+jcoRNGTtGphl2gG
   iD20ia/2wSywSNebzHSIYGWyFz9eLGwl/7Kl31jUSkbhIFXPz9ynA+Mpn
   Dly0fsxE5PXxcNcWzNvAvcNItzjX0Ir4UZziOheaOrXRc9NScrYAycm9Q
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="262846702"
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="262846702"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 02:58:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="562049243"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 20 Apr 2022 02:58:17 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nh76G-0006qx-IU;
        Wed, 20 Apr 2022 09:58:16 +0000
Date:   Wed, 20 Apr 2022 17:57:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     kbuild-all@lists.01.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH 2/2] drm/nvdla: Add driver support for NVDLA
Message-ID: <202204201710.5Gcg1PUu-lkp@intel.com>
References: <20220419135908.39606-3-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419135908.39606-3-cai.huoqing@linux.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cai,

I love your patch! Yet something to improve:

[auto build test ERROR on drm/drm-next]
[also build test ERROR on drm-intel/for-linux-next drm-tip/drm-tip linus/master v5.18-rc3 next-20220419]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Cai-Huoqing/drm-nvdla-Add-driver-support-for-NVDLA/20220419-220255
base:   git://anongit.freedesktop.org/drm/drm drm-next
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20220420/202204201710.5Gcg1PUu-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7539e5487eb7d0c6f13c03bba596e51a2238106d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Cai-Huoqing/drm-nvdla-Add-driver-support-for-NVDLA/20220419-220255
        git checkout 7539e5487eb7d0c6f13c03bba596e51a2238106d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/gpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> make[5]: *** No rule to make target 'drivers/gpu/drm/nvdla/nvdla_engine_data.o', needed by 'drivers/gpu/drm/nvdla/nvdla-drm.o'.
>> make[5]: *** No rule to make target 'drivers/gpu/drm/nvdla/nvdla_engine_debug.o', needed by 'drivers/gpu/drm/nvdla/nvdla-drm.o'.
   make[5]: Target '__build' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
