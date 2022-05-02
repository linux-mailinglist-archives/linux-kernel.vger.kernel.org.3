Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8AD51769E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 20:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386972AbiEBSjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 14:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386890AbiEBSia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 14:38:30 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C4F63E1
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 11:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651516500; x=1683052500;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+VOK6jP+OrAKvsLrW0t0c00GfOFL8z+TZqst8BnkWQA=;
  b=JdljOnPwXhVF4HsawmSzx3nHdKYMNMvReuyv6joy8wFurwxhLepLbIkn
   NgscScqmYWl3gpevOt5lTUwkoJntp7ucYxhpIeZ9YSuPeT7TwrWqnDIbC
   VYDdcckSNh/44qqrrRiVAWLdLS2V2PKDTjF3rkFjM+7XSIe6qSXmz/FbG
   6DDqssApWW66nhYhxryvkmF8zMPe9NWSUcf4+gIQ/7mt+rr6cRCGnf8ea
   6oSspi4Ts/QuUg0WT9/wAtN50UvwMvJLOglXlvQXgXj6SB/MoxEqOOyGW
   z+Cn9Q1O1JKNowRQEw+Ce4SydiK2JUJHeGswQroDxZn8mucOqnBPowiZ2
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="267451369"
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="267451369"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 11:34:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="631203584"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 02 May 2022 11:34:56 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlasq-0009mZ-9i;
        Mon, 02 May 2022 18:34:56 +0000
Date:   Tue, 3 May 2022 02:34:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gaston Gonzalez <gascoar@gmail.com>,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Subject: Re: [PATCH v1 1/1] staging: vc04_services: Re-use generic struct
 s32_fract
Message-ID: <202205030211.MkM1PfmX-lkp@intel.com>
References: <20220502120355.84334-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502120355.84334-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I love your patch! Yet something to improve:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/staging-vc04_services-Re-use-generic-struct-s32_fract/20220502-200543
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git 5fe7856ad59afc56a6ff35d091bfaddd1d4f4bce
config: hexagon-randconfig-r041-20220502 (https://download.01.org/0day-ci/archive/20220503/202205030211.MkM1PfmX-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 09325d36061e42b495d1f4c7e933e260eac260ed)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c0fbdbd092e007c2567a367389e86df9d1cd7ee3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/staging-vc04_services-Re-use-generic-struct-s32_fract/20220502-200543
        git checkout c0fbdbd092e007c2567a367389e86df9d1cd7ee3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/staging/vc04_services/bcm2835-camera/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/staging/vc04_services/bcm2835-camera/controls.c:162:17: error: no member named 'numumerator' in 'struct s32_fract'; did you mean 'numerator'?
           rational_value.numumerator = ctrl->val;
                          ^~~~~~~~~~~
                          numerator
   include/linux/math.h:117:1: note: 'numerator' declared here
   __STRUCT_FRACT(s32)
   ^
   include/linux/math.h:112:11: note: expanded from macro '__STRUCT_FRACT'
           __##type numerator;                             \
                    ^
   1 error generated.


vim +162 drivers/staging/vc04_services/bcm2835-camera/controls.c

   152	
   153	static int ctrl_set_rational(struct bcm2835_mmal_dev *dev,
   154				     struct v4l2_ctrl *ctrl,
   155				     const struct bcm2835_mmal_v4l2_ctrl *mmal_ctrl)
   156	{
   157		struct s32_fract rational_value;
   158		struct vchiq_mmal_port *control;
   159	
   160		control = &dev->component[COMP_CAMERA]->control;
   161	
 > 162		rational_value.numumerator = ctrl->val;
   163		rational_value.denominator = 100;
   164	
   165		return vchiq_mmal_port_parameter_set(dev->instance, control,
   166						     mmal_ctrl->mmal_id,
   167						     &rational_value,
   168						     sizeof(rational_value));
   169	}
   170	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
