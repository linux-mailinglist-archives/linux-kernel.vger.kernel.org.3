Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3EE590944
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 01:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbiHKXnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 19:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiHKXnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 19:43:17 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1CA9AFCC
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 16:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660261396; x=1691797396;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EvJB+EyyjrE/ViFyxaCElIufWhOTNa4V37QL/lXPjow=;
  b=TuF/6sK4wWBQPg6/dfkAKbcuDKE9y8k0tgEqXEoX/oB4PtdGWrip6k3o
   M9VuRpP69QP9u2oXhLV487CTntyHrPZRcyVFRclJEXxWce+shMrSvb6ug
   EZ0jGekmMw8uldE3GEj8vEttIAtGOw/pi7jkuQJQZGLqO6ODimOM+zyMW
   wdkGciU5u53Jj4HTugiMOAoMhTDM7UPq8xhS7oG90GF/SkgIYfSYN5gRC
   Ll/DMXM3ZxOJ6+AahkDyQwx6RwXOsQTqn04RYQzpsGwmnCfEjbFZHvJzZ
   6HeY6idNCQG3tUuXcYCpqNkwektH6NV0mbV4D/EALc9aOQMza6wYE41KG
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="289055194"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="289055194"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 16:43:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="673890841"
Received: from lkp-server02.sh.intel.com (HELO cfab306db114) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 11 Aug 2022 16:43:13 -0700
Received: from kbuild by cfab306db114 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMHpZ-0000o3-07;
        Thu, 11 Aug 2022 23:43:13 +0000
Date:   Fri, 12 Aug 2022 07:42:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhenneng Li <lizhenneng@kylinos.cn>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     kbuild-all@lists.01.org, Jack Xiao <Jack.Xiao@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>, David Airlie <airlied@linux.ie>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, Zhenneng Li <lizhenneng@kylinos.cn>,
        dri-devel@lists.freedesktop.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: use native mode for dp aux transfer
Message-ID: <202208120737.JG7NkugC-lkp@intel.com>
References: <20220811072012.962460-1-lizhenneng@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811072012.962460-1-lizhenneng@kylinos.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhenneng,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on linus/master v5.19 next-20220811]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhenneng-Li/drm-amdgpu-use-native-mode-for-dp-aux-transfer/20220811-193443
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220812/202208120737.JG7NkugC-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/1098c6fecb4292d634dbdccff9e720400dc7138d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Zhenneng-Li/drm-amdgpu-use-native-mode-for-dp-aux-transfer/20220811-193443
        git checkout 1098c6fecb4292d634dbdccff9e720400dc7138d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/

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
