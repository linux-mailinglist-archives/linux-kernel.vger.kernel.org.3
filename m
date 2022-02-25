Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0084C51D2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 23:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238943AbiBYXAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 18:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiBYXAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 18:00:02 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153DC1AAFC1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 14:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645829969; x=1677365969;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kZGBjE0P0yqbpvYUmiW8+NhaoXZTRgiidLYRgI+UBUc=;
  b=oHXQ4ECVTzlNLhpjh55LANlKvbWLUgzjkzeaquVKXYepwKkRn5qpHPkI
   +0pN/UXVP/TJnA32gy1253D38gVxXKN/KNzGnooKxfr10GIajo7s6pLrN
   HIQK11MSOp/G/3nKHSS9P+rJGSEYxk011BrW824zb15pbzZ2jsj1nyxzZ
   VLLRY9ujaVbpr3Jz70UepYABLOGlPFCO5adIm/qPPviGi4ZAaVMwKG4Rg
   0JMHFG1c0reoF6FaF/n2AijqY6qaenQGQ/zcVdsyfI70I4zcQ/srwcMXw
   34Pc38YYBJuHnVoA/u9ivTfde6jWXuDXeIBcoCpLYGsZLYJdtETD2W2tO
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10269"; a="252792688"
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="252792688"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 14:59:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="607901989"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 25 Feb 2022 14:59:26 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNjYc-0004nN-7h; Fri, 25 Feb 2022 22:59:26 +0000
Date:   Sat, 26 Feb 2022 06:59:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [rppt:kasper 6/6] drivers/gpu/drm/vmwgfx/vmwgfx_kms.c:2623:2:
 warning: variable 'mode' is used uninitialized whenever 'for' loop exits
 because its condition is false
Message-ID: <202202260631.sb20qmrj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git kasper
head:   7b670b09e6e571dc47d64528131db6c9da12578d
commit: 7b670b09e6e571dc47d64528131db6c9da12578d [6/6] treewide: remove check of list iterator against head past the loop body
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220226/202202260631.sb20qmrj-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/commit/?id=7b670b09e6e571dc47d64528131db6c9da12578d
        git remote add rppt https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git
        git fetch --no-tags rppt kasper
        git checkout 7b670b09e6e571dc47d64528131db6c9da12578d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kernel/ drivers/gpu/drm/vmwgfx/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/vmwgfx/vmwgfx_kms.c:2623:2: warning: variable 'mode' is used uninitialized whenever 'for' loop exits because its condition is false [-Wsometimes-uninitialized]
           list_for_each_entry(tmp2, &con->modes, head) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:639:7: note: expanded from macro 'list_for_each_entry'
                !list_entry_is_head(pos, head, member);                    \
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/vmwgfx/vmwgfx_kms.c:2630:7: note: uninitialized use occurs here
           if (!mode) {
                ^~~~
   drivers/gpu/drm/vmwgfx/vmwgfx_kms.c:2623:2: note: remove the condition if it is always true
           list_for_each_entry(tmp2, &con->modes, head) {
           ^
   include/linux/list.h:639:7: note: expanded from macro 'list_for_each_entry'
                !list_entry_is_head(pos, head, member);                    \
                ^
   drivers/gpu/drm/vmwgfx/vmwgfx_kms.c:2588:31: note: initialize the variable 'mode' to silence this warning
           struct drm_display_mode *mode;
                                        ^
                                         = NULL
   1 warning generated.


vim +2623 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c

  2576	
  2577	int vmw_kms_fbdev_init_data(struct vmw_private *dev_priv,
  2578				    unsigned unit,
  2579				    u32 max_width,
  2580				    u32 max_height,
  2581				    struct drm_connector **p_con,
  2582				    struct drm_crtc **p_crtc,
  2583				    struct drm_display_mode **p_mode)
  2584	{
  2585		struct drm_connector *con = NULL;
  2586		struct drm_connector *tmp1;
  2587		struct vmw_display_unit *du;
  2588		struct drm_display_mode *mode;
  2589		struct drm_display_mode *tmp2;
  2590		int i = 0;
  2591		int ret = 0;
  2592	
  2593		mutex_lock(&dev_priv->drm.mode_config.mutex);
  2594		list_for_each_entry(tmp1, &dev_priv->drm.mode_config.connector_list,
  2595				    head) {
  2596			if (i == unit) {
  2597				con = tmp1;
  2598				break;
  2599			}
  2600	
  2601			++i;
  2602		}
  2603	
  2604		if (!con) {
  2605			DRM_ERROR("Could not find initial display unit.\n");
  2606			ret = -EINVAL;
  2607			goto out_unlock;
  2608		}
  2609	
  2610		if (list_empty(&con->modes))
  2611			(void) vmw_du_connector_fill_modes(con, max_width, max_height);
  2612	
  2613		if (list_empty(&con->modes)) {
  2614			DRM_ERROR("Could not find initial display mode.\n");
  2615			ret = -EINVAL;
  2616			goto out_unlock;
  2617		}
  2618	
  2619		du = vmw_connector_to_du(con);
  2620		*p_con = con;
  2621		*p_crtc = &du->crtc;
  2622	
> 2623		list_for_each_entry(tmp2, &con->modes, head) {
  2624			if (tmp2->type & DRM_MODE_TYPE_PREFERRED) {
  2625				mode = tmp2;
  2626				break;
  2627			}
  2628		}
  2629	
  2630		if (!mode) {
  2631			WARN_ONCE(true, "Could not find initial preferred mode.\n");
  2632			*p_mode = list_first_entry(&con->modes,
  2633						   struct drm_display_mode,
  2634						   head);
  2635		} else {
  2636			*p_mode = mode;
  2637		}
  2638	
  2639	 out_unlock:
  2640		mutex_unlock(&dev_priv->drm.mode_config.mutex);
  2641	
  2642		return ret;
  2643	}
  2644	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
