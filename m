Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D1150610C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240901AbiDSAnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235718AbiDSAnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:43:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB13E0D5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650328871; x=1681864871;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HOYO7JlUYf5H14URgos3ZrjOtwiy2yVhHwcj7ha5tsM=;
  b=aME0RFkFCPoV98/inWqFhps/rHFGsE76WB/3dD509lzgnm984MfMcTjt
   y04YA6B4GR71ovYJMfrcPsoPIn4WoKS1Zb7tl2qhNDvmM9eJCzTKhj11f
   OJB+R2HQqQTG29u/7Lq3EHY6RHmSNJNPdinS7y41a4pKLqJ9rkANV1/9Y
   rhnMCr9ubgP+Y6IxnmKDCzwoKCasVe1eAIYgh77DylQhopSmHjLZw+SAG
   uDuOXuH8foP80pnyaKYrO8v0QcuRfirQIImz1nQxnotyjFSJEM8kiNIj1
   ovGXvJGsUlFzM6dylynE9tDIBHvgUb885VWTg78aEaGjwRH7oQjXgYiep
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="324083887"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="324083887"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 17:41:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="529822632"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 18 Apr 2022 17:41:08 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngbvX-000584-S1;
        Tue, 19 Apr 2022 00:41:07 +0000
Date:   Tue, 19 Apr 2022 08:41:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>, mcgrof@kernel.org,
        rafael@kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH v3 3/8] firmware_loader: Split sysfs support from fallback
Message-ID: <202204190831.KrZOnvww-lkp@intel.com>
References: <20220418223753.639058-4-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418223753.639058-4-russell.h.weight@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russ,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on driver-core/driver-core-testing]
[also build test ERROR on shuah-kselftest/next mcgrof/sysctl-next linus/master v5.18-rc3 next-20220414]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Russ-Weight/Extend-FW-framework-for-user-FW-uploads/20220419-064126
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git 3123109284176b1532874591f7c81f3837bbdc17
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220419/202204190831.KrZOnvww-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/7fb618c8a43c6350d4f11246daf3a62cd2c2843d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Russ-Weight/Extend-FW-framework-for-user-FW-uploads/20220419-064126
        git checkout 7fb618c8a43c6350d4f11246daf3a62cd2c2843d
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/base/firmware_loader/fallback.h:9,
                    from drivers/base/firmware_loader/main.c:44:
   drivers/base/firmware_loader/sysfs.h: In function '__firmware_loading_timeout':
>> drivers/base/firmware_loader/sysfs.h:74:34: error: invalid use of undefined type 'struct firmware_fallback_config'
      74 |         return fw_fallback_config.loading_timeout;
         |                                  ^
   drivers/base/firmware_loader/sysfs.h: In function '__fw_fallback_set_timeout':
   drivers/base/firmware_loader/sysfs.h:80:27: error: invalid use of undefined type 'struct firmware_fallback_config'
      80 |         fw_fallback_config.loading_timeout = timeout;
         |                           ^


vim +74 drivers/base/firmware_loader/sysfs.h

    70	
    71	/* These getters are vetted to use int properly */
    72	static inline int __firmware_loading_timeout(void)
    73	{
  > 74		return fw_fallback_config.loading_timeout;
    75	}
    76	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
