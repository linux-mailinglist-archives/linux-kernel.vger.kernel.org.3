Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67EC1585824
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 05:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239734AbiG3DDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 23:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiG3DDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 23:03:41 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930EE25C6D
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 20:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659150220; x=1690686220;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yWLJrWfiYOhP2GrDM/RfY8uWpLUU1KeC3w9W08D9/Mk=;
  b=UFPg3Ng2thKGKYmOVUXsYTxU1cRd92KJzrRWmkowzxthBlrQJnmPc8MH
   ZZiVrlnY43pSbHb8h2g3YPhdO6WyKJWVajReSzJkkcg1o74QBP/0b1+UK
   1Dn/194xL3/TeJtYBK0HxYr5MjfXVNTPaMvmmK3+LrVX+3y8qPEUnKT4x
   0335x3IKWzMjHn4HNVNWgy8rLMgMFTk9NIJ9L7zdzyHwHw6ODHbtyUvCp
   KHuvYwswlt0nIsGvT93daZZj0tCsgIzQs49S7MeD9rzxaBlbiLRh/l+re
   2Fo9JICgRxiK/UCH3VPCpmhr3VFGZZZe5ll029bkLZdLdhD5Pvu2sMIBf
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="268653211"
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="268653211"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 20:03:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="704389955"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jul 2022 20:03:35 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHclK-000CJh-1P;
        Sat, 30 Jul 2022 03:03:34 +0000
Date:   Sat, 30 Jul 2022 11:03:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Maxime Ripard <maxime@cerno.tech>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Phil Elwell <phil@raspberrypi.com>,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        Dom Cobley <dom@raspberrypi.com>
Subject: Re: [PATCH v1 22/35] drm/vc4: vec: Use TV Reset implementation
Message-ID: <202207301024.h3rifgQO-lkp@intel.com>
References: <20220728-rpi-analog-tv-properties-v1-22-3d53ae722097@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728-rpi-analog-tv-properties-v1-22-3d53ae722097@cerno.tech>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

I love your patch! Perhaps something to improve:

[auto build test WARNING on 37b355fdaf31ee18bda9a93c2a438dc1cbf57ec9]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxime-Ripard/drm-Analog-TV-Improvements/20220730-004859
base:   37b355fdaf31ee18bda9a93c2a438dc1cbf57ec9
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220730/202207301024.h3rifgQO-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2f380bf85052b89ae0ffc6cfdf2dc91cdcde5a75
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Maxime-Ripard/drm-Analog-TV-Improvements/20220730-004859
        git checkout 2f380bf85052b89ae0ffc6cfdf2dc91cdcde5a75
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/gpu/drm/vc4/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/vc4/vc4_vec.c:257:6: warning: no previous prototype for 'vc4_vec_connector_reset' [-Wmissing-prototypes]
     257 | void vc4_vec_connector_reset(struct drm_connector *connector)
         |      ^~~~~~~~~~~~~~~~~~~~~~~


vim +/vc4_vec_connector_reset +257 drivers/gpu/drm/vc4/vc4_vec.c

   256	
 > 257	void vc4_vec_connector_reset(struct drm_connector *connector)
   258	{
   259		drm_atomic_helper_connector_reset(connector);
   260		drm_atomic_helper_connector_tv_reset(connector);
   261	}
   262	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
