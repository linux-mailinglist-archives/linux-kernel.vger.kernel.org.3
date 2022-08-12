Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB995914BA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 19:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239278AbiHLRSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 13:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiHLRSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 13:18:03 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B111DB1BB1;
        Fri, 12 Aug 2022 10:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660324682; x=1691860682;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yAUb1g8BPPCo00CwCVUUCW/MEhmxy2A/zFgeWAZglu4=;
  b=YNhocms2E/VMypvzbV9aaGfFEd7JinWt7YgzPuhbJctfbA0gM5kWWwc7
   lDMHhkaxjlO/gsKLYjy0aNxJ1cNB6iMOvXXNHhajK3MzF6bKR1pW9eFwd
   K1S4kmCM6ZUPMtL5EBspm89kcCWFBytdXMU4G41ywDJfC0If0+4LqS4NE
   uGwh9EM0SHhyO4GwYPbYINGnofxcnVcu1zYiabezT7CzrZ6K9dnOyBDxd
   sO+9TKuUHvif86468fkmiEpPo4B5AOAcBMFVlVCI1AytAcXHM5AtX3vYu
   2JZ8QyHZswsYoyl6h+3AIVsZUFxkVNC0SCmmRsXB0SGLRsaFiPIGIY5uX
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="278593618"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="278593618"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 10:17:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="748258212"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 12 Aug 2022 10:17:50 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMYI9-0000m3-1Z;
        Fri, 12 Aug 2022 17:17:49 +0000
Date:   Sat, 13 Aug 2022 01:17:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     kbuild-all@lists.01.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>
Subject: Re: [PATCH v2 26/26] thermal/drivers/intel: Use generic
 thermal_zone_get_trip() function
Message-ID: <202208130155.HquqN8f2-lkp@intel.com>
References: <20220809220436.711020-27-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809220436.711020-27-daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

I love your patch! Yet something to improve:

[auto build test ERROR on next-20220809]
[cannot apply to rafael-pm/thermal tegra/for-next linus/master v5.19 v5.19-rc8 v5.19-rc7 v5.19]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Lezcano/Rework-the-trip-points-creation/20220810-060933
base:    6c8f479764ebe2848589de3249743ea552ed2495
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220813/202208130155.HquqN8f2-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/b38db2fe0562e475bb6240a64e6f6156352d41d1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daniel-Lezcano/Rework-the-trip-points-creation/20220810-060933
        git checkout b38db2fe0562e475bb6240a64e6f6156352d41d1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "thermal_zone_device_register_with_trips" [drivers/thermal/intel/x86_pkg_temp_thermal.ko] undefined!
ERROR: modpost: "thermal_zone_device_register_with_trips" [drivers/platform/x86/acerhdf.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
