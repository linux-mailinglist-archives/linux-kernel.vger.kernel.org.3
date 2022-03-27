Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76A84E87EF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 15:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbiC0Nyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 09:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233574AbiC0Nyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 09:54:53 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BAFB85C;
        Sun, 27 Mar 2022 06:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648389194; x=1679925194;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ftpBL5isBU6wAN2J5Wb1nf5ir7WISc6nuxwRuY7UEnQ=;
  b=AH5HJqpY8gYjvzL5p+C5B4WXt4rh/rFz+V14QbJ1hBzgk3zpCY/79i31
   XMx3t3rQHDm7Rbz1K0m99KeumHI8PAMem5c8LKjdaHIkzyp5gxf7yluwd
   qJlkassnuhUBBo5GCc7A8nSsTbAs1AcN8xYLRB8G7XHW5RfOMRLe0uQsm
   N4vyDH6vqMhk+ZAdhDOEEdLvmpWsZ0KVGe3YWr9u58BTLKmnOgDAaUobS
   4XP8SLtWdsOwW+EF27VkMJV1s4OjrXeAe2rsw1Lg8Q0Ssp5YbtG/NQcks
   KtF0kJjfaoqv0C+BCsbRKwy/67zFo8HlUhmgRXSFcBYIo0UyBM2wZN3z3
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="258820343"
X-IronPort-AV: E=Sophos;i="5.90,215,1643702400"; 
   d="scan'208";a="258820343"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2022 06:53:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,215,1643702400"; 
   d="scan'208";a="617542612"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 27 Mar 2022 06:53:07 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYTKM-00014v-Cw; Sun, 27 Mar 2022 13:53:06 +0000
Date:   Sun, 27 Mar 2022 21:52:32 +0800
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
        linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 5/6] drm/loongson: add drm driver for loongson
 display controller
Message-ID: <202203272117.q6tMwBFo-lkp@intel.com>
References: <20220327113846.2498146-6-15330273260@189.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220327113846.2498146-6-15330273260@189.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sui,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on drm/drm-next]
[also build test WARNING on robh/for-next linus/master v5.17 next-20220325]
[cannot apply to mripard/sunxi/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Sui-Jingfeng/drm-loongson-add-drm-driver-for-loongson-display-controller/20220327-194016
base:   git://anongit.freedesktop.org/drm/drm drm-next
config: parisc-randconfig-r003-20220327 (https://download.01.org/0day-ci/archive/20220327/202203272117.q6tMwBFo-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/e90d831d05f2c1b5631fd706fb449e83e64f632c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sui-Jingfeng/drm-loongson-add-drm-driver-for-loongson-display-controller/20220327-194016
        git checkout e90d831d05f2c1b5631fd706fb449e83e64f632c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash drivers/gpu/drm/loongson/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/loongson/lsdc_debugfs.c:149: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * vram debugfs related ...


vim +149 drivers/gpu/drm/loongson/lsdc_debugfs.c

   147	
   148	/**
 > 149	 * vram debugfs related ...
   150	 */
   151	static int lsdc_vram_mm_show(struct seq_file *m, void *data)
   152	{
   153		struct drm_info_node *node = (struct drm_info_node *)m->private;
   154		struct drm_vram_mm *vmm = node->minor->dev->vram_mm;
   155		struct ttm_resource_manager *man = ttm_manager_type(&vmm->bdev, TTM_PL_VRAM);
   156		struct drm_printer p = drm_seq_file_printer(m);
   157	
   158		ttm_resource_manager_debug(man, &p);
   159		return 0;
   160	}
   161	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
