Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0EE552A52
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 06:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344040AbiFUEim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 00:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236377AbiFUEij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 00:38:39 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119491C907
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 21:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655786316; x=1687322316;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wxRDMNaSdD/o6Y8ae4DltMvFeXD/i5ZhZHiA8fnXnDI=;
  b=AieI4QCc3YD2wuDdtmsiJ0uqhjAvTtrMn8KmttRdqvmO7xAsOxqOl9yp
   PTPk8kJbzVPulAOS+4mLu/y9sJN1+RHmnMDifesmovJjsph3KgmNJvWKP
   ZIWHR6mu2M+goWTFEQZKe8i+IlEq06uDOya1Yi+OWgSaW09dihc5nFvdm
   TcgPesRuQvKEjwuGGuAXMJb/G3bbwI+t/IfYupZ3tN+z+FBtmwrJVjXQr
   7tzl9S5R9RhSLa3tB+lCivhTFdFc/151YFl/ECYy3aQVg160Zi3iSeZwA
   lQp65/h6c+EIF1ERNvxjSIvcYp0ZAF0B+Ga6sy7psYphGe/IK2S1cAHJ6
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="280755751"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="280755751"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 21:38:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="764320018"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 20 Jun 2022 21:38:33 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3Veq-000YIP-Vw;
        Tue, 21 Jun 2022 04:38:32 +0000
Date:   Tue, 21 Jun 2022 12:37:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     kbuild-all@lists.01.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: Make drm_buddy a part of drm module
Message-ID: <202206211156.FjsteJJC-lkp@intel.com>
References: <20220621015151.11129-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621015151.11129-1-cai.huoqing@linux.dev>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cai,

I love your patch! Yet something to improve:

[auto build test ERROR on drm/drm-next]
[also build test ERROR on linus/master v5.19-rc2 next-20220617]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Cai-Huoqing/drm-Make-drm_buddy-a-part-of-drm-module/20220621-095417
base:   git://anongit.freedesktop.org/drm/drm drm-next
config: microblaze-buildonly-randconfig-r003-20220620 (https://download.01.org/0day-ci/archive/20220621/202206211156.FjsteJJC-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/517d5f44c861a5173eaa9a06efebe2ce2a6601a1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Cai-Huoqing/drm-Make-drm_buddy-a-part-of-drm-module/20220621-095417
        git checkout 517d5f44c861a5173eaa9a06efebe2ce2a6601a1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   microblaze-linux-ld: drivers/gpu/drm/drm_buddy.o: in function `drm_buddy_block_print':
   drivers/gpu/drm/drm_buddy.c:731: undefined reference to `drm_printf'
   microblaze-linux-ld: drivers/gpu/drm/drm_buddy.o: in function `drm_buddy_print':
   drivers/gpu/drm/drm_buddy.c:745: undefined reference to `drm_printf'
>> microblaze-linux-ld: drivers/gpu/drm/drm_buddy.c:757: undefined reference to `drm_printf'
   microblaze-linux-ld: drivers/gpu/drm/drm_buddy.c:763: undefined reference to `drm_printf'
   microblaze-linux-ld: drivers/gpu/drm/drm_buddy.c:765: undefined reference to `drm_printf'
   microblaze-linux-ld: drivers/gpu/drm/drm_buddy.o:drivers/gpu/drm/drm_buddy.c:761: more undefined references to `drm_printf' follow

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
