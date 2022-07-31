Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAF3585F23
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 15:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237111AbiGaNjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 09:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiGaNjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 09:39:36 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E94BC26
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 06:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659274774; x=1690810774;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XUMw2GCkJoEjozVFDeMbgBe4REkA82oGwVdbepixBjs=;
  b=WBJoZFgmpUtD9ez9+kpvYzxizvzFwlWISXMiQ+uEDJILrldeXegCCbcB
   PVRkpQeGYiMTbq9LYnNq9fv/9Hozvxj01ljfQ/iyAvwuxAievFIEYqg0B
   /4w+80QrCVrTwiGqorlaPl6CP7Beb2WgEJL4nG4PbD5rX0lsQEHlB+KQd
   x20nq9J8or9SWte9bj5U+26ag7zaOv6x6zpyQHQVsRGdRnd3lkDL0B3Jg
   Sbq1W2fnnLtdLvKfZXhW/n44zDDmduOQaebAWAvqhKQ8SBURN9YDo58Yq
   Pt+R+eIQVVBaxWZbEyfZBGD4cL6AqjHoq5Q6W0eY5Q9RAQnItdE7raOvH
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="268762274"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="268762274"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 06:39:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="577486747"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 31 Jul 2022 06:39:30 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oI9AH-000EBT-2k;
        Sun, 31 Jul 2022 13:39:29 +0000
Date:   Sun, 31 Jul 2022 21:38:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhenneng Li <lizhenneng@kylinos.cn>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     kbuild-all@lists.01.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Zhenneng Li <lizhenneng@kylinos.cn>
Subject: Re: [PATCH] drm/amdgpu: use native mode for dp aux transfer
Message-ID: <202207312143.yefmpijn-lkp@intel.com>
References: <20220720021639.58406-1-lizhenneng@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720021639.58406-1-lizhenneng@kylinos.cn>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhenneng,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on linus/master v5.19-rc8 next-20220728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhenneng-Li/drm-amdgpu-use-native-mode-for-dp-aux-transfer/20220720-103324
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
config: csky-randconfig-r036-20220718 (https://download.01.org/0day-ci/archive/20220731/202207312143.yefmpijn-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/8429a257cb9bf2f0e850afeef0a3dbc4cd3006da
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Zhenneng-Li/drm-amdgpu-use-native-mode-for-dp-aux-transfer/20220720-103324
        git checkout 8429a257cb9bf2f0e850afeef0a3dbc4cd3006da
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/amdgpu_dp_auxch.c:73:10: warning: no previous prototype for 'venus_mm_rreg_slow' [-Wmissing-prototypes]
      73 | uint32_t venus_mm_rreg_slow(struct amdgpu_device *adev, uint32_t reg)
         |          ^~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/amdgpu_dp_auxch.c:84:6: warning: no previous prototype for 'venus_mm_wreg_slow' [-Wmissing-prototypes]
      84 | void venus_mm_wreg_slow(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
         |      ^~~~~~~~~~~~~~~~~~


vim +/venus_mm_rreg_slow +73 drivers/gpu/drm/amd/amdgpu/amdgpu_dp_auxch.c

    69	
    70	#define R100_MM_INDEX                   0x0000
    71	#define R100_MM_DATA                      0x0004
    72	#define AMDGPU_MIN_MMIO_SIZE 0x10000
  > 73	uint32_t venus_mm_rreg_slow(struct amdgpu_device *adev, uint32_t reg)
    74	{
    75	        unsigned long flags;
    76	        uint32_t ret;
    77	
    78	        spin_lock_irqsave(&adev->mmio_idx_lock, flags);
    79	        writel(reg, ((void __iomem *)adev->rmmio) + R100_MM_INDEX);
    80	        ret = readl(((void __iomem *)adev->rmmio) + R100_MM_DATA);
    81	        spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
    82	        return ret;
    83	}
  > 84	void venus_mm_wreg_slow(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
    85	{
    86	        unsigned long flags;
    87	
    88	        spin_lock_irqsave(&adev->mmio_idx_lock, flags);
    89	        writel(reg, ((void __iomem *)adev->rmmio) + R100_MM_INDEX);
    90	        writel(v, ((void __iomem *)adev->rmmio) + R100_MM_DATA);
    91	        spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
    92	}
    93	static inline uint32_t venus_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
    94	                                    bool always_indirect)
    95	{
    96	        /* The mmio size is 64kb at minimum. Allows the if to be optimized out. */
    97	        if ((reg < adev->rmmio_size || reg < AMDGPU_MIN_MMIO_SIZE) && !always_indirect)
    98	                return readl(((void __iomem *)adev->rmmio) + reg);
    99	        else
   100	                return venus_mm_rreg_slow(adev, reg);
   101	}
   102	static inline void venus_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
   103	                                bool always_indirect)
   104	{
   105	        if ((reg < adev->rmmio_size || reg < AMDGPU_MIN_MMIO_SIZE) && !always_indirect)
   106	                writel(v, ((void __iomem *)adev->rmmio) + reg);
   107	        else
   108	                venus_mm_wreg_slow(adev, reg, v);
   109	}
   110	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
