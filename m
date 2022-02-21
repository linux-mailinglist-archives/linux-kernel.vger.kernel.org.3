Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A328A4BEEC5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 02:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237194AbiBUXmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 18:42:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237086AbiBUXmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 18:42:15 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59B62700
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 15:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645486909; x=1677022909;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zPiVt7qLwbT6nB0jKSQdDpJT674lr4cYd2X+OAPFFyo=;
  b=kWqndGvPYzq158NCywo7BJHHeQ1/wC7ZtFOo1/788bTEIzQ0e2qJTzdL
   j5mvuYYYVdfsj/wvU2Y798pl9H7WItmQcpegW6p08PamqsDoKMVkxDymc
   cPHlOUypyqO7jwkpQucmG9EyG1letirfcYvLOz92S0ANggiDrAp9pnQKn
   pDU6rPtznwIKGBjLjU8VB5Rn8XqStycQRDd6FC6NT2XF0GIiCfoKGQ0aA
   JMMBUUni/G7LMhzU4zo6HFkwCmqStz7GslY8VKt8TeqeXDxVWviQr7kPx
   xTZh5cQqJ+m5euWJgq3221Wy20o6bxs3thuNtkGQao3BjNyib4Yn/IiDM
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="231548616"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="231548616"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 15:41:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="591103571"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 21 Feb 2022 15:41:45 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMIJN-00025T-1D; Mon, 21 Feb 2022 23:41:45 +0000
Date:   Tue, 22 Feb 2022 07:41:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yongzhi Liu <lyz_cs@pku.edu.cn>, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com, airlied@linux.ie, daniel@ffwll.ch,
        thomas.hellstrom@linux.intel.com,
        maarten.lankhorst@linux.intel.com, matthew.auld@intel.com,
        matthew.d.roper@intel.com, tzimmermann@suse.de,
        michal.winiarski@intel.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/i915: Check input parameter for NULL
Message-ID: <202202220722.25BhJJ6r-lkp@intel.com>
References: <1645455221-38580-1-git-send-email-lyz_cs@pku.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645455221-38580-1-git-send-email-lyz_cs@pku.edu.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yongzhi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on drm-intel/for-linux-next]
[also build test WARNING on v5.17-rc5 next-20220217]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Yongzhi-Liu/drm-i915-Check-input-parameter-for-NULL/20220221-225508
base:   git://anongit.freedesktop.org/drm-intel for-linux-next
config: i386-randconfig-a014-20220221 (https://download.01.org/0day-ci/archive/20220222/202202220722.25BhJJ6r-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/c54be425a38b3f4cb82c5badecf6b343f9e24a90
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Yongzhi-Liu/drm-i915-Check-input-parameter-for-NULL/20220221-225508
        git checkout c54be425a38b3f4cb82c5badecf6b343f9e24a90
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/i915/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/i915/gem/i915_gem_phys.c:100:13: warning: mixing declarations and code is a C99 extension [-Wdeclaration-after-statement]
           dma_addr_t dma = sg_dma_address(pages->sgl);
                      ^
   1 warning generated.


vim +100 drivers/gpu/drm/i915/gem/i915_gem_phys.c

f033428db28bdf Chris Wilson      2019-05-28   93  
a61170975718d5 Maarten Lankhorst 2021-03-23   94  void
f033428db28bdf Chris Wilson      2019-05-28   95  i915_gem_object_put_pages_phys(struct drm_i915_gem_object *obj,
f033428db28bdf Chris Wilson      2019-05-28   96  			       struct sg_table *pages)
f033428db28bdf Chris Wilson      2019-05-28   97  {
c54be425a38b3f Yongzhi Liu       2022-02-21   98  	if (!pages)
c54be425a38b3f Yongzhi Liu       2022-02-21   99  		return;
c6790dc22312f5 Chris Wilson      2020-02-02 @100  	dma_addr_t dma = sg_dma_address(pages->sgl);
c6790dc22312f5 Chris Wilson      2020-02-02  101  	void *vaddr = sg_page(pages->sgl);
c6790dc22312f5 Chris Wilson      2020-02-02  102  
f033428db28bdf Chris Wilson      2019-05-28  103  	__i915_gem_object_release_shmem(obj, pages, false);
f033428db28bdf Chris Wilson      2019-05-28  104  
f033428db28bdf Chris Wilson      2019-05-28  105  	if (obj->mm.dirty) {
f033428db28bdf Chris Wilson      2019-05-28  106  		struct address_space *mapping = obj->base.filp->f_mapping;
c6790dc22312f5 Chris Wilson      2020-02-02  107  		void *src = vaddr;
f033428db28bdf Chris Wilson      2019-05-28  108  		int i;
f033428db28bdf Chris Wilson      2019-05-28  109  
f033428db28bdf Chris Wilson      2019-05-28  110  		for (i = 0; i < obj->base.size / PAGE_SIZE; i++) {
f033428db28bdf Chris Wilson      2019-05-28  111  			struct page *page;
f033428db28bdf Chris Wilson      2019-05-28  112  			char *dst;
f033428db28bdf Chris Wilson      2019-05-28  113  
f033428db28bdf Chris Wilson      2019-05-28  114  			page = shmem_read_mapping_page(mapping, i);
f033428db28bdf Chris Wilson      2019-05-28  115  			if (IS_ERR(page))
f033428db28bdf Chris Wilson      2019-05-28  116  				continue;
f033428db28bdf Chris Wilson      2019-05-28  117  
f033428db28bdf Chris Wilson      2019-05-28  118  			dst = kmap_atomic(page);
c6790dc22312f5 Chris Wilson      2020-02-02  119  			drm_clflush_virt_range(src, PAGE_SIZE);
c6790dc22312f5 Chris Wilson      2020-02-02  120  			memcpy(dst, src, PAGE_SIZE);
f033428db28bdf Chris Wilson      2019-05-28  121  			kunmap_atomic(dst);
f033428db28bdf Chris Wilson      2019-05-28  122  
f033428db28bdf Chris Wilson      2019-05-28  123  			set_page_dirty(page);
f033428db28bdf Chris Wilson      2019-05-28  124  			if (obj->mm.madv == I915_MADV_WILLNEED)
f033428db28bdf Chris Wilson      2019-05-28  125  				mark_page_accessed(page);
f033428db28bdf Chris Wilson      2019-05-28  126  			put_page(page);
c6790dc22312f5 Chris Wilson      2020-02-02  127  
c6790dc22312f5 Chris Wilson      2020-02-02  128  			src += PAGE_SIZE;
f033428db28bdf Chris Wilson      2019-05-28  129  		}
f033428db28bdf Chris Wilson      2019-05-28  130  		obj->mm.dirty = false;
f033428db28bdf Chris Wilson      2019-05-28  131  	}
f033428db28bdf Chris Wilson      2019-05-28  132  
f033428db28bdf Chris Wilson      2019-05-28  133  	sg_free_table(pages);
f033428db28bdf Chris Wilson      2019-05-28  134  	kfree(pages);
f033428db28bdf Chris Wilson      2019-05-28  135  
8ff5446a7ca47c Thomas Zimmermann 2021-01-28  136  	dma_free_coherent(obj->base.dev->dev,
c6790dc22312f5 Chris Wilson      2020-02-02  137  			  roundup_pow_of_two(obj->base.size),
c6790dc22312f5 Chris Wilson      2020-02-02  138  			  vaddr, dma);
f033428db28bdf Chris Wilson      2019-05-28  139  }
f033428db28bdf Chris Wilson      2019-05-28  140  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
