Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431AC50C7DA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 08:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbiDWGwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 02:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiDWGwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 02:52:49 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DC97F202;
        Fri, 22 Apr 2022 23:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650696592; x=1682232592;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/TgZTP8Sb4P0FH9slFXu/lphspGv+TGMH48WzenOT9M=;
  b=CgLv0cNokeVuUc3sPD/1E8DHwcNLhxdF2M9XMrt7IVRTWO2dfb+Nmmjz
   jv/wumVJ8SHweS0qUGLrlzCcGONGTySvXdvDCr+4pH4ynzSsJg1sX1tNy
   hURvwnyHX+hWdV+kSr3hBpixlKTLx4x6trrvW6X8fGImBI0RpXoCkclHf
   O/UyiiRBtVzEPhyq5eO2jAaergFn3ylNyLITwvwsqDe5p95V4AWScoLuz
   xS1HAcxD0X2BRt6ufjIfONpMeLLW1WyXwYLC191hiRcxQMR3aIOgsXJY4
   nRdeOJu90R44M0s8Zmqd4wrIF0m5mMik3oD/Klqy69EBMztsRv249KDyv
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="327776409"
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="327776409"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 23:49:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; 
   d="scan'208";a="627297258"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 22 Apr 2022 23:49:48 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ni9aW-000B6g-75;
        Sat, 23 Apr 2022 06:49:48 +0000
Date:   Sat, 23 Apr 2022 14:49:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miles Chen <miles.chen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-media@vger.kernel.org, Miles Chen <miles.chen@mediatek.com>,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/mediatek: fix NULL pointer dereference when
 printing dev_name
Message-ID: <202204231446.IYKdZ674-lkp@intel.com>
References: <20220422223549.4173-1-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422223549.4173-1-miles.chen@mediatek.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miles,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on joro-iommu/next]
[also build test WARNING on v5.18-rc3 next-20220422]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Miles-Chen/iommu-mediatek-fix-NULL-pointer-dereference-when-printing-dev_name/20220423-070605
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
config: hexagon-randconfig-r041-20220422 (https://download.01.org/0day-ci/archive/20220423/202204231446.IYKdZ674-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5bd87350a5ae429baf8f373cb226a57b62f87280)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/85771767e503ca60069fe4e6ec2ddb80c7f9bafa
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Miles-Chen/iommu-mediatek-fix-NULL-pointer-dereference-when-printing-dev_name/20220423-070605
        git checkout 85771767e503ca60069fe4e6ec2ddb80c7f9bafa
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/iommu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/iommu/mtk_iommu.c:605:6: warning: variable 'larbdev' is uninitialized when used here [-Wuninitialized]
           if (larbdev) {
               ^~~~~~~
   drivers/iommu/mtk_iommu.c:597:24: note: initialize the variable 'larbdev' to silence this warning
           struct device *larbdev;
                                 ^
                                  = NULL
   1 warning generated.


vim +/larbdev +605 drivers/iommu/mtk_iommu.c

   592	
   593	static void mtk_iommu_release_device(struct device *dev)
   594	{
   595		struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
   596		struct mtk_iommu_data *data;
   597		struct device *larbdev;
   598		unsigned int larbid;
   599	
   600		if (!fwspec || fwspec->ops != &mtk_iommu_ops)
   601			return;
   602	
   603		data = dev_iommu_priv_get(dev);
   604		larbid = MTK_M4U_TO_LARB(fwspec->ids[0]);
 > 605		if (larbdev) {
   606			larbdev = data->larb_imu[larbid].dev;
   607			device_link_remove(dev, larbdev);
   608		}
   609	
   610		iommu_fwspec_free(dev);
   611	}
   612	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
