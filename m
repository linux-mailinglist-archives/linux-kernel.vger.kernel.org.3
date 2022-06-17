Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CF654F952
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 16:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382788AbiFQOkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 10:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbiFQOks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:40:48 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FEE39684;
        Fri, 17 Jun 2022 07:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655476847; x=1687012847;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nUf3VSmAhMT7KhA0SZgvMeAAppiMPu6TfIssmeBBkZ0=;
  b=Iu3o569Zq7X/KFY3ys6MNnLHLpzc43WCvCoXjM/MTeGREhs7gOA174ob
   KDPIe+QVFKcoVut3CyIRjkJDbJUoVbqhBkfT73wxDpupUtOKZhYaYqIZU
   0jD6NdgGjGnEMLcmwKFibowiD9qMjZUM6UPwFrSvfqIJyptPrffZYbnIM
   IPp6E8grhv2V4maIQVenz3ZvaRRWpElzY3oUR8Bgalc73z4zbsmCkexoO
   LCsl6XLlb0EMw7GG1vfALSrTdAKeT0C/L3PWTiA4sCgt1LLSAWyTFs5gV
   XjjvN1/Buh7p12rKXvgMwm583NZ9D4mkt04OnDhRo2P7EnDNUw2oCEToE
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="341193588"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="341193588"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 07:40:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="713789777"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 17 Jun 2022 07:40:44 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2D9P-000PVx-Mp;
        Fri, 17 Jun 2022 14:40:43 +0000
Date:   Fri, 17 Jun 2022 22:40:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ricardo Ribalda <ribalda@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, tfiga@chromium.org,
        senozhatsky@chromium.org, yunkec@google.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-media@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
Subject: Re: [PATCH v7 2/8] media: uvcvideo: Add support for per-device
 control mapping overrides
Message-ID: <202206172239.M4dQBUhz-lkp@intel.com>
References: <20220617103645.71560-3-ribalda@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617103645.71560-3-ribalda@chromium.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

I love your patch! Perhaps something to improve:

[auto build test WARNING on media-tree/master]
[also build test WARNING on linus/master v5.19-rc2 next-20220617]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Ricardo-Ribalda/uvcvideo-Fix-handling-of-power_line_frequency/20220617-185644
base:   git://linuxtv.org/media_tree.git master
config: hexagon-randconfig-r045-20220617 (https://download.01.org/0day-ci/archive/20220617/202206172239.M4dQBUhz-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d764aa7fc6b9cc3fbe960019018f5f9e941eb0a6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/10bdca4191d7a8be97c77dbe4ba89c05713ee0e2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ricardo-Ribalda/uvcvideo-Fix-handling-of-power_line_frequency/20220617-185644
        git checkout 10bdca4191d7a8be97c77dbe4ba89c05713ee0e2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/media/usb/uvc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/media/usb/uvc/uvc_ctrl.c:2442:6: warning: variable 'mapping' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (chain->dev->info->mappings) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/usb/uvc/uvc_ctrl.c:2459:9: note: uninitialized use occurs here
           mend = mapping + ARRAY_SIZE(uvc_ctrl_mappings);
                  ^~~~~~~
   drivers/media/usb/uvc/uvc_ctrl.c:2442:2: note: remove the 'if' if its condition is always true
           if (chain->dev->info->mappings) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/usb/uvc/uvc_ctrl.c:2406:43: note: initialize the variable 'mapping' to silence this warning
           const struct uvc_control_mapping *mapping;
                                                    ^
                                                     = NULL
   1 warning generated.


vim +2442 drivers/media/usb/uvc/uvc_ctrl.c

  2396	
  2397	/*
  2398	 * Add control information and hardcoded stock control mappings to the given
  2399	 * device.
  2400	 */
  2401	static void uvc_ctrl_init_ctrl(struct uvc_video_chain *chain,
  2402				       struct uvc_control *ctrl)
  2403	{
  2404		const struct uvc_control_info *info = uvc_ctrls;
  2405		const struct uvc_control_info *iend = info + ARRAY_SIZE(uvc_ctrls);
  2406		const struct uvc_control_mapping *mapping;
  2407		const struct uvc_control_mapping *mend;
  2408	
  2409		/* XU controls initialization requires querying the device for control
  2410		 * information. As some buggy UVC devices will crash when queried
  2411		 * repeatedly in a tight loop, delay XU controls initialization until
  2412		 * first use.
  2413		 */
  2414		if (UVC_ENTITY_TYPE(ctrl->entity) == UVC_VC_EXTENSION_UNIT)
  2415			return;
  2416	
  2417		for (; info < iend; ++info) {
  2418			if (uvc_entity_match_guid(ctrl->entity, info->entity) &&
  2419			    ctrl->index == info->index) {
  2420				uvc_ctrl_add_info(chain->dev, ctrl, info);
  2421				/*
  2422				 * Retrieve control flags from the device. Ignore errors
  2423				 * and work with default flag values from the uvc_ctrl
  2424				 * array when the device doesn't properly implement
  2425				 * GET_INFO on standard controls.
  2426				 */
  2427				uvc_ctrl_get_flags(chain->dev, ctrl, &ctrl->info);
  2428				break;
  2429			 }
  2430		}
  2431	
  2432		if (!ctrl->initialized)
  2433			return;
  2434	
  2435		/*
  2436		 * First check if the device provides a custom mapping for this control,
  2437		 * used to override standard mappings for non-conformant devices. Don't
  2438		 * process standard mappings if a custom mapping is found. This
  2439		 * mechanism doesn't support combining standard and custom mappings for
  2440		 * a single control.
  2441		 */
> 2442		if (chain->dev->info->mappings) {
  2443			bool custom = false;
  2444			unsigned int i;
  2445	
  2446			for (i = 0; (mapping = chain->dev->info->mappings[i]); ++i) {
  2447				if (uvc_entity_match_guid(ctrl->entity, mapping->entity) &&
  2448				    ctrl->info.selector == mapping->selector) {
  2449					__uvc_ctrl_add_mapping(chain, ctrl, mapping);
  2450					custom = true;
  2451				}
  2452			}
  2453	
  2454			if (custom)
  2455				return;
  2456		}
  2457	
  2458		/* Process common mappings next. */
  2459		mend = mapping + ARRAY_SIZE(uvc_ctrl_mappings);
  2460		for (mapping = uvc_ctrl_mappings; mapping < mend; ++mapping) {
  2461			if (uvc_entity_match_guid(ctrl->entity, mapping->entity) &&
  2462			    ctrl->info.selector == mapping->selector)
  2463				__uvc_ctrl_add_mapping(chain, ctrl, mapping);
  2464		}
  2465	
  2466		/* Finally process version-specific mappings. */
  2467		if (chain->dev->uvc_version < 0x0150) {
  2468			mapping = uvc_ctrl_mappings_uvc11;
  2469			mend = mapping + ARRAY_SIZE(uvc_ctrl_mappings_uvc11);
  2470		} else {
  2471			mapping = uvc_ctrl_mappings_uvc15;
  2472			mend = mapping + ARRAY_SIZE(uvc_ctrl_mappings_uvc15);
  2473		}
  2474	
  2475		for (; mapping < mend; ++mapping) {
  2476			if (uvc_entity_match_guid(ctrl->entity, mapping->entity) &&
  2477			    ctrl->info.selector == mapping->selector)
  2478				__uvc_ctrl_add_mapping(chain, ctrl, mapping);
  2479		}
  2480	}
  2481	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
