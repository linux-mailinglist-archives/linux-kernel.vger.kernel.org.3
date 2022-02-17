Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7254D4BA2C5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241801AbiBQOTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:19:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbiBQOTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:19:13 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9082AB503;
        Thu, 17 Feb 2022 06:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645107538; x=1676643538;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dfr3+NzWMDc2P50WqcshEqNKyOz9LK+XeSUh54taYro=;
  b=aX9+oZT5Bim0Nqff6jEtsVmesxBJA/Y1I+Sl0EABEwHO4bQP/q1BR8oX
   4XJX9/cK6gIziDjyBpM425EtLWtL5AYcbl7hvLMco1zAeLvWUj952OflB
   8dVgQXpAqH/4jMT+nGpkoENwk0MgnA4Lg4of9bA2vCdln1XQWsV2JxAmX
   HnzcMzaloPaAWktA188YnLvA8IPFAuMWY9EugqWOQDoOoTA9zQOFKtfrv
   TVycY5KVt+ABM9jjJKw29hflV15AKm2t5SIuRV5iWF+gRZNX+hsQZtWIL
   bx9gOrLXoESBmO3/u2VI+5zaerv799YOEegFUlw+QRLVVr3c3PJfAFp8s
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="250618090"
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="250618090"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 06:18:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="604972249"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 17 Feb 2022 06:18:51 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKhcQ-0000Fy-Kv; Thu, 17 Feb 2022 14:18:50 +0000
Date:   Thu, 17 Feb 2022 22:18:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sui Jingfeng <15330273260@189.cn>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dan Carpenter <error27@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Qing Zhang <zhangqing@loongson.cn>,
        suijingfeng <suijingfeng@loongson.cn>
Cc:     kbuild-all@lists.01.org, devicetree@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/4] drm/lsdc: add drm driver for loongson display
 controller
Message-ID: <202202172257.4uMfltD8-lkp@intel.com>
References: <20220217105523.1525122-2-15330273260@189.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217105523.1525122-2-15330273260@189.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sui,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on drm/drm-next]
[also build test WARNING on robh/for-next v5.17-rc4 next-20220217]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Sui-Jingfeng/drm-lsdc-add-drm-driver-for-loongson-display-controller/20220217-185718
base:   git://anongit.freedesktop.org/drm/drm drm-next
config: alpha-buildonly-randconfig-r001-20220217 (https://download.01.org/0day-ci/archive/20220217/202202172257.4uMfltD8-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/822d08dcd4408130e10897446cfdd640bcd53c8a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Sui-Jingfeng/drm-lsdc-add-drm-driver-for-loongson-display-controller/20220217-185718
        git checkout 822d08dcd4408130e10897446cfdd640bcd53c8a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/gpu/drm/lsdc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/lsdc/lsdc_plane.c: In function 'lsdc_cursor_atomic_disable':
>> drivers/gpu/drm/lsdc/lsdc_plane.c:420:26: warning: variable 'crtc' set but not used [-Wunused-but-set-variable]
     420 |         struct drm_crtc *crtc;
         |                          ^~~~


vim +/crtc +420 drivers/gpu/drm/lsdc/lsdc_plane.c

   413	
   414	static void lsdc_cursor_atomic_disable(struct drm_plane *plane,
   415					       struct drm_atomic_state *state)
   416	{
   417		struct drm_device *ddev = plane->dev;
   418		struct lsdc_device *ldev = to_lsdc(ddev);
   419		struct drm_plane_state *old_plane_state;
 > 420		struct drm_crtc *crtc;
   421	
   422		old_plane_state = drm_atomic_get_old_plane_state(state, plane);
   423	
   424		if (old_plane_state)
   425			crtc = old_plane_state->crtc;
   426	
   427		lsdc_reg_write32(ldev, LSDC_CURSOR_CFG_REG, 0);
   428	
   429		drm_dbg(ddev, "%s disabled\n", plane->name);
   430	}
   431	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
