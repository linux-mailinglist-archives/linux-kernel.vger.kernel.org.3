Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953FB5A3D86
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 14:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiH1MdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 08:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiH1MdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 08:33:00 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5363B2C667
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 05:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661689979; x=1693225979;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ue7ZUWR+YEjBmUB+q633OAVUfBnabNRXuEZylx1L4+w=;
  b=YdvwPDtMStOjPaIUFFPo4h/Q6TnwfZbgguAQWYHlFid3sBnxefznFB1A
   AqTIUrHzrEATguCT1DfcKKXr0l2z8aBiblSBGq8vjvv+UKapDA+xm7srj
   pleJtBdH+VFp1p8efX6aUKXyQjlImrkHwkrOGlWbowjxLyaCQNvLZ5i3g
   Gnc8eBPHYERHpDtkgCb38OadWqhRye8AYOixquH5DWrTjpY5YioUUQTna
   FnDQwOvOoi7skqj8nbjbgr3msvwIKJbD6G06lvWQ63fgMQ2ngY8j1FPD5
   zWxqktEhvrP6RCZYDESiw+lyAqw3mvtdqS5tJMP+NqeMWHoaM7I5GbqNZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10452"; a="358702062"
X-IronPort-AV: E=Sophos;i="5.93,270,1654585200"; 
   d="scan'208";a="358702062"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2022 05:32:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,270,1654585200"; 
   d="scan'208";a="753343699"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 28 Aug 2022 05:32:55 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSHTC-00014d-1Q;
        Sun, 28 Aug 2022 12:32:54 +0000
Date:   Sun, 28 Aug 2022 20:32:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        javierm@redhat.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        dri-devel@lists.freedesktop.org, tzimmermann@suse.de,
        magalilemes00@gmail.com, airlied@linux.ie, maira.canal@usp.br,
        dlatypov@google.com, linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
        geert@linux-m68k.org, tales.aparecida@gmail.com,
        davidgow@google.com,
        =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        isabbasso@riseup.net, kunit-dev@googlegroups.com
Subject: Re: [PATCH v2 2/3] drm/format-helper: Add KUnit tests for
 drm_fb_xrgb8888_to_xrgb2101010()
Message-ID: <202208282022.9682WEre-lkp@intel.com>
References: <20220828090121.13243-3-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220828090121.13243-3-jose.exposito89@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "José,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on 61a9fa154d217c13eea90aa5bc635bc4b1fcb66e]

url:    https://github.com/intel-lab-lkp/linux/commits/Jos-Exp-sito/KUnit-tests-for-RGB888-XRGB2101010-and-grayscale/20220828-170347
base:   61a9fa154d217c13eea90aa5bc635bc4b1fcb66e
config: hexagon-randconfig-r014-20220828 (https://download.01.org/0day-ci/archive/20220828/202208282022.9682WEre-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project a2100daf12fb980a29fd1a9c85ccf8eaaaf79730)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/5b513d5c5cc6ccf62c7b8d72f431079041ce69d7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jos-Exp-sito/KUnit-tests-for-RGB888-XRGB2101010-and-grayscale/20220828-170347
        git checkout 5b513d5c5cc6ccf62c7b8d72f431079041ce69d7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "drm_fb_xrgb8888_to_xrgb2101010" [drivers/gpu/drm/tests/drm_format_helper_test.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
