Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A252755AA05
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 14:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbiFYMjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 08:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbiFYMjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 08:39:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5639205D5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 05:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656160750; x=1687696750;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gUVh1otMnfm1JZsH4Bw5ldTSUYJyZgjBw+O/iuC0J74=;
  b=VVHAZ5Z95j6D6FFB8hHPYy61eYdzpoJwEzadP+tIoxo4BIwN/b3vYmWS
   Gsjy7tBn7ycztIvYbL21vQwYpaytU0RC8zIqWm63/nDaCghcEJgg6NMrB
   ZcqS/+weVhkyQ48RFkeN4akDYufxNfo/03k89abisxLXfa2PxQJjD/l0A
   /IONEEY2bKSRFiSKnuZXKmFZ0nUWEvDwaK2JNPItBtOhctO/xDbyFzmGw
   T3qW8367T3iasJgOHfV7rfJ16l+yYZsGg75hpdoWszjaLQQd121GPeJDD
   YaQDO4Up7UgLHVupsJANCpMFquFyar8RMbBVGJctlcapSwrJBz+B+O0rS
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="278726372"
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="278726372"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 05:39:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="616260237"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 25 Jun 2022 05:39:07 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5546-0005kN-Jo;
        Sat, 25 Jun 2022 12:39:06 +0000
Date:   Sat, 25 Jun 2022 20:39:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chenyang Li <lichenyang@loongson.cn>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dan Carpenter <error27@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, devel@linuxdriverproject.org
Cc:     kbuild-all@lists.01.org, Sam Ravnborg <sam@ravnborg.org>,
        linux-kernel@vger.kernel.org, Yi Li <liyi@loongson.cn>
Subject: Re: [PATCH v7 2/4] drm/loongson: Add GPIO and I2C driver for
 loongson drm.
Message-ID: <202206252021.a42lokOo-lkp@intel.com>
References: <20220625090715.3663-2-lichenyang@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625090715.3663-2-lichenyang@loongson.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chenyang,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on linus/master v5.19-rc3 next-20220624]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Chenyang-Li/drm-loongson-Add-DRM-Driver-for-Loongson-7A1000-bridge-chip/20220625-171037
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
config: powerpc-allmodconfig
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3af56da81352153b38e05c082b8f2bf8c9fc0320
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Chenyang-Li/drm-loongson-Add-DRM-Driver-for-Loongson-7A1000-bridge-chip/20220625-171037
        git checkout 3af56da81352153b38e05c082b8f2bf8c9fc0320
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/gpu/drm/loongson/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/loongson/loongson_encoder.c:10:27: warning: no previous prototype for 'loongson_bridge_detect' [-Wmissing-prototypes]
      10 | enum drm_connector_status loongson_bridge_detect(struct drm_bridge *bridge)
         |                           ^~~~~~~~~~~~~~~~~~~~~~


vim +/loongson_bridge_detect +10 drivers/gpu/drm/loongson/loongson_encoder.c

     9	
  > 10	enum drm_connector_status loongson_bridge_detect(struct drm_bridge *bridge)
    11	{
    12		unsigned char start = 0x0;
    13		struct i2c_msg msgs = {
    14			.addr = DDC_ADDR,
    15			.flags = 0,
    16			.len = 1,
    17			.buf = &start,
    18		};
    19	
    20		if (i2c_transfer(bridge->ddc, &msgs, 1) != 1)
    21			return connector_status_disconnected;
    22		else
    23			return connector_status_connected;
    24	}
    25	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
