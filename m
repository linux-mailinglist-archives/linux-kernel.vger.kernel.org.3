Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC974FD3CC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 11:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387107AbiDLJFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359825AbiDLHnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:43:43 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B81243AE0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649748383; x=1681284383;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5OyqKZ2t12lVTvKw/fJWrzDUz4nPfGALPPcWHIJFgN8=;
  b=O+Qvlm3KUxP6NVMuF9f3Uk8PHtLEqAfxKw7hl4eGYCN5b31hkBJvLS1M
   aUVFvkSmYbolPm7NkycXFjPBRL3+yPHekPwZ7rEu8+lP3cjWpo7vaGX3m
   Gixz6Yr6xG4ExcXlWfLWQ37eohuUu/fCETc/hZq1gZNLcd+owgIKhnO14
   0VOmEQNTQuAQPWlj0dA2SKe3803QAl3yAgBnsZ+szM3l42GIk1cIrBcre
   KdVEg7nt/MExsG3DxptHOB9k5174nlPqBG9fQsaetQk69QFeAZjMIQMqJ
   Jni85dpNPkRsJW0SH29DcVw6BTOamZCtPUZrO9AsI9lbtIJKI1W4aXCPv
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="259893989"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="259893989"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 00:26:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="644602157"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Apr 2022 00:26:17 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neAun-0002cr-5k;
        Tue, 12 Apr 2022 07:26:17 +0000
Date:   Tue, 12 Apr 2022 15:25:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Clark <robdclark@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        dri-devel@lists.freedesktop.org,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v3 11/15] drm/shmem-helper: Add generic memory shrinker
Message-ID: <202204121523.qVMxOvZg-lkp@intel.com>
References: <20220411215937.281655-12-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411215937.281655-12-dmitry.osipenko@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

I love your patch! Perhaps something to improve:

[auto build test WARNING on next-20220411]
[cannot apply to drm/drm-next v5.18-rc2 v5.18-rc1 v5.17 v5.18-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Dmitry-Osipenko/Add-generic-memory-shrinker-to-VirtIO-GPU-and-Panfrost-DRM-drivers/20220412-060325
base:    d12d7e1cfe38e0c36d28c7a9fbbc436ad0d17c14
config: i386-randconfig-a005-20220411 (https://download.01.org/0day-ci/archive/20220412/202204121523.qVMxOvZg-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project fe2478d44e4f7f191c43fef629ac7a23d0251e72)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/683ba8a9d72ba7770a61a9266a2b33949f3874f2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Dmitry-Osipenko/Add-generic-memory-shrinker-to-VirtIO-GPU-and-Panfrost-DRM-drivers/20220412-060325
        git checkout 683ba8a9d72ba7770a61a9266a2b33949f3874f2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/drm_gem_shmem_helper.c:289:11: warning: variable 'new_state' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           else if (shmem->madv < 0)
                    ^~~~~~~~~~~~~~~
   drivers/gpu/drm/drm_gem_shmem_helper.c:292:46: note: uninitialized use occurs here
           drm_gem_shmem_set_pages_state_locked(shmem, new_state);
                                                       ^~~~~~~~~
   drivers/gpu/drm/drm_gem_shmem_helper.c:289:7: note: remove the 'if' if its condition is always true
           else if (shmem->madv < 0)
                ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/drm_gem_shmem_helper.c:278:2: note: variable 'new_state' is declared here
           enum drm_gem_shmem_pages_state new_state;
           ^
   1 warning generated.


vim +289 drivers/gpu/drm/drm_gem_shmem_helper.c

   273	
   274	static void drm_gem_shmem_update_pages_state_locked(struct drm_gem_shmem_object *shmem)
   275	{
   276		struct drm_gem_object *obj = &shmem->base;
   277		struct drm_gem_shmem_shrinker *gem_shrinker = obj->dev->shmem_shrinker;
   278		enum drm_gem_shmem_pages_state new_state;
   279	
   280		if (!gem_shrinker || obj->import_attach)
   281			return;
   282	
   283		mutex_lock(&gem_shrinker->lock);
   284	
   285		if (!shmem->madv)
   286			new_state = DRM_GEM_SHMEM_PAGES_STATE_ACTIVE;
   287		else if (shmem->madv > 0)
   288			new_state = DRM_GEM_SHMEM_PAGES_STATE_PURGEABLE;
 > 289		else if (shmem->madv < 0)
   290			new_state = DRM_GEM_SHMEM_PAGES_STATE_PURGED;
   291	
   292		drm_gem_shmem_set_pages_state_locked(shmem, new_state);
   293	
   294		mutex_unlock(&gem_shrinker->lock);
   295	}
   296	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
