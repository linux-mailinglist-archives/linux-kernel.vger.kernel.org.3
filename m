Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C35E5A0411
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 00:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiHXWc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 18:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiHXWcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 18:32:55 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBB0BE20
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 15:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661380374; x=1692916374;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P+GzUkvuEW3dDb+qIZ8XvSjCR0TNCgtfL1gqFbGWrYo=;
  b=Y2GHHnls9J8ZLCPAcEjwblvhldXkJSgSL1UholGggmLntKH2Sm656rRy
   se7DDiBqkPZCVUuO5vEyTIOwFaqTDvl99f+Voa1zc9EHaHNjLJMHY95TV
   y6ecWeYkT1mtwGdBuTqNmJ3RqwjyXBVQSU07EQKTo+5GscSN+m7EQ+pPM
   OCRQGsiyJxmROlrtq/rWC0kkmWpQYAfUBzUrQcIZ+pRLYoqPY3WiWLlpo
   XD3132PV/j+e/g4A5+WyVDBPAASTFpi0SNtEqgwWdjhjYA6fA8QisXsQ2
   5qI5f/phdj5J41uNHz2I8XilImfvxNumBldSlzPJdpXkOlAFq+vOqYYfd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="355817020"
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="355817020"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 15:32:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="752251962"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 24 Aug 2022 15:32:51 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQyva-0001Je-34;
        Wed, 24 Aug 2022 22:32:50 +0000
Date:   Thu, 25 Aug 2022 06:32:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Davis <afd@ti.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tomi Valkeinen <tomba@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH] drm: omapdrm: Improve check for contiguous buffers
Message-ID: <202208250645.sVXFPe8D-lkp@intel.com>
References: <20220823000326.10056-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823000326.10056-1-afd@ti.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on drm-intel/for-linux-next drm-tip/drm-tip linus/master v6.0-rc2 next-20220824]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrew-Davis/drm-omapdrm-Improve-check-for-contiguous-buffers/20220823-080542
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220825/202208250645.sVXFPe8D-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/5eeaaada78b2038b8f2bf483926b4aee998016ff
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andrew-Davis/drm-omapdrm-Improve-check-for-contiguous-buffers/20220823-080542
        git checkout 5eeaaada78b2038b8f2bf483926b4aee998016ff
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/omapdrm/omap_gem.c:151:62: error: unknown type name 'size'; did you mean 'size_t'?
     151 | static bool omap_gem_sgt_is_contiguous(struct sg_table *sgt, size)
         |                                                              ^~~~
         |                                                              size_t
   drivers/gpu/drm/omapdrm/omap_gem.c: In function 'omap_gem_is_contiguous':
>> drivers/gpu/drm/omapdrm/omap_gem.c:162:13: error: implicit declaration of function 'omap_gem_sgt_is_contiguous'; did you mean 'omap_gem_is_contiguous'? [-Werror=implicit-function-declaration]
     162 |             omap_gem_sgt_is_contiguous(omap_obj->sgt, omap_obj->base->size))
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |             omap_gem_is_contiguous
>> drivers/gpu/drm/omapdrm/omap_gem.c:162:69: error: invalid type argument of '->' (have 'struct drm_gem_object')
     162 |             omap_gem_sgt_is_contiguous(omap_obj->sgt, omap_obj->base->size))
         |                                                                     ^~
   cc1: some warnings being treated as errors


vim +151 drivers/gpu/drm/omapdrm/omap_gem.c

   150	
 > 151	static bool omap_gem_sgt_is_contiguous(struct sg_table *sgt, size)
   152	{
   153		return !(drm_prime_get_contiguous_size(sgt) < size);
   154	}
   155	
   156	static bool omap_gem_is_contiguous(struct omap_gem_object *omap_obj)
   157	{
   158		if (omap_obj->flags & OMAP_BO_MEM_DMA_API)
   159			return true;
   160	
   161		if ((omap_obj->flags & OMAP_BO_MEM_DMABUF) &&
 > 162		    omap_gem_sgt_is_contiguous(omap_obj->sgt, omap_obj->base->size))
   163			return true;
   164	
   165		return false;
   166	}
   167	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
