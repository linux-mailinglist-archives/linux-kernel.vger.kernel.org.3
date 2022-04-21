Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1785097BC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384956AbiDUGgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384898AbiDUGfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:35:39 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAE413F48
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650522771; x=1682058771;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mhbp/tI1jCiWHlLUfY1TZKLSXrvWKD+nbgz2PLjn/8w=;
  b=RH3qd9gcFAMbJ4OvwfTfQiU1QpcYFAdBCvqTCYkdbAtrlQdimEJIRI12
   z5/ex8I977mI2SCjVs987E+qQpEU9Qt7FSMauW+3XIrv5/mnayfkFtEoJ
   rfliJTr/eW+YDkPdWGWHu+3l8XpzqVKAXRh5riusAMj2l+TgNLTIAPkqL
   o+1js8wRDYvTnhJt9FOMG1BX9V83uczAHax7Xv/QvYtD0GpmmnUuHv7zv
   PBves0fsFnT47lEc/QQWp3+LsFLNE9Jmp5jUE/Zk0rkV+4Rz0wQ/OJcPD
   uT0UGZuyU8r9pDAAuYwx9BsCK80zowMihtnrLfEreHh4N7GdF6V4RmKTb
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="264427589"
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="264427589"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:32:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="562446171"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 20 Apr 2022 23:32:49 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQMy-0007wP-97;
        Thu, 21 Apr 2022 06:32:48 +0000
Date:   Thu, 21 Apr 2022 14:31:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Karol Herbst <kherbst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, Karol Herbst <kherbst@redhat.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [Intel-gfx] [PATCH] drm/i915: Fix race in
 __i915_vma_remove_closed
Message-ID: <202204201854.2R6j6WjR-lkp@intel.com>
References: <20220419234436.2638649-1-kherbst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419234436.2638649-1-kherbst@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Karol,

I love your patch! Yet something to improve:

[auto build test ERROR on drm-tip/drm-tip]
[also build test ERROR on linus/master v5.18-rc3 next-20220420]
[cannot apply to drm-intel/for-linux-next linux/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Karol-Herbst/drm-i915-Fix-race-in-__i915_vma_remove_closed/20220420-074525
base:   git://anongit.freedesktop.org/drm/drm-tip drm-tip
config: x86_64-randconfig-c002 (https://download.01.org/0day-ci/archive/20220420/202204201854.2R6j6WjR-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/50a17180127b7d2527ee9a8f5c9e8207e158afb6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Karol-Herbst/drm-i915-Fix-race-in-__i915_vma_remove_closed/20220420-074525
        git checkout 50a17180127b7d2527ee9a8f5c9e8207e158afb6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/drm/i915/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/drm/i915/i915_vma.c: In function 'release_references':
>> drivers/gpu/drm/i915/i915_vma.c:1654:9: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
    1654 |         struct intel_gt *gt = vma->vm->gt;
         |         ^~~~~~
   cc1: all warnings being treated as errors


vim +1654 drivers/gpu/drm/i915/i915_vma.c

  1640	
  1641	static void release_references(struct i915_vma *vma, bool vm_ddestroy)
  1642	{
  1643		struct drm_i915_gem_object *obj = vma->obj;
  1644	
  1645		GEM_BUG_ON(i915_vma_is_active(vma));
  1646	
  1647		spin_lock(&obj->vma.lock);
  1648		list_del(&vma->obj_link);
  1649		if (!RB_EMPTY_NODE(&vma->obj_node))
  1650			rb_erase(&vma->obj_node, &obj->vma.tree);
  1651	
  1652		spin_unlock(&obj->vma.lock);
  1653	
> 1654		struct intel_gt *gt = vma->vm->gt;
  1655	
  1656		spin_lock_irq(&gt->closed_lock);
  1657		__i915_vma_remove_closed(vma);
  1658		spin_unlock_irq(&gt->closed_lock);
  1659	
  1660		if (vm_ddestroy)
  1661			i915_vm_resv_put(vma->vm);
  1662	
  1663		i915_active_fini(&vma->active);
  1664		GEM_WARN_ON(vma->resource);
  1665		i915_vma_free(vma);
  1666	}
  1667	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
