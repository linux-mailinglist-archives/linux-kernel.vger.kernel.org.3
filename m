Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69A753BFA0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 22:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238877AbiFBUVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 16:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236784AbiFBUUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 16:20:53 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CCBEB1;
        Thu,  2 Jun 2022 13:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654201251; x=1685737251;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JwdZ+aUhBkAHVprboLx4+/JjEUNbZt0Zm07qXGPgYis=;
  b=hnkIKpelo0e8syX2zXGayAdVJ+iKc4/yINFYQ8tLYL2xQ/g8l83ifI1+
   aG8hIzEk1UJbrLz2CxM7/Zlr8JBthpk9RWuYiiQIHVSDoX5Dw37FTLkEc
   8NJ+0pFVQt1z34LPXjLHWNrqg4o2faPeMZ3vg2R3EZ6yrEshJgmhdbJlk
   0UArqg6VmgQCuxUWfZykEjBI+CgkEJa7/5ohNit8ht5MjIbmq3a3slGkw
   nZo371jbPrpg2uqwcRtRdI4krFiFAgghvvYjeQvAyjcwBy2Un1eB9qZom
   vWufyYKvmiS4/dnT6Ohyiq3zXR51GnzjpseZzy6BTAxMuEyf0PEW9joxq
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="301439827"
X-IronPort-AV: E=Sophos;i="5.91,272,1647327600"; 
   d="scan'208";a="301439827"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 13:20:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,272,1647327600"; 
   d="scan'208";a="646155381"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 02 Jun 2022 13:20:49 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwrJI-0005Pw-UJ;
        Thu, 02 Jun 2022 20:20:48 +0000
Date:   Fri, 3 Jun 2022 04:20:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     kbuild-all@lists.01.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_manafm@quicinc.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 2/3] thermal/debugfs: Add debugfs information
Message-ID: <202206030425.4QFicgCF-lkp@intel.com>
References: <20220601151441.9128-2-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601151441.9128-2-daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

I love your patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/thermal]
[also build test WARNING on v5.18 next-20220602]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Lezcano/thermal-core-Encapsulate-the-set_cur_state-function/20220601-231733
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
config: i386-randconfig-s001 (https://download.01.org/0day-ci/archive/20220603/202206030425.4QFicgCF-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-14-g5a0004b5-dirty
        # https://github.com/intel-lab-lkp/linux/commit/04c295f7e8b49af742179609949736f6f056b49c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daniel-Lezcano/thermal-core-Encapsulate-the-set_cur_state-function/20220601-231733
        git checkout 04c295f7e8b49af742179609949736f6f056b49c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/thermal/thermal_core.c: note: in included file (through drivers/thermal/thermal_core.h):
>> drivers/thermal/thermal_debugfs.h:11:40: sparse: sparse: marked inline, but without a definition

vim +11 drivers/thermal/thermal_debugfs.h

     2	
     3	#ifdef CONFIG_THERMAL_DEBUGFS
     4	void thermal_debugfs_init(void);
     5	void thermal_debugfs_cdev_register(struct thermal_cooling_device *cdev);
     6	void thermal_debugfs_cdev_unregister(struct thermal_cooling_device *cdev);
     7	void thermal_debugfs_tz_register(struct thermal_zone_device *tz);
     8	void thermal_debugfs_tz_unregister(struct thermal_zone_device *tz);
     9	void thermal_debugfs_cdev_transition(struct thermal_cooling_device *cdev, int state);
    10	#else
  > 11	static inline void thermal_debugfs_init(void);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
