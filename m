Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4549B591D6C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 03:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240187AbiHNBNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 21:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiHNBNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 21:13:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452151581C;
        Sat, 13 Aug 2022 18:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660439620; x=1691975620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dhKkSzBmVvUqQlk2H6PYP/DhZeE0cXbKpgag3Koj5YM=;
  b=ZzH6zAUz/sPCPb8v+JlwTnr5KRsoNbVgKiJHEAAYsFG2htBKkojKUMIC
   vKFkZDSvB65kNc/Mi+Rc2Iz52Q5bk1Ej9GONphObN6TVkGwG9eXns28xi
   WJ2GMdL2JwtSsaMloZcQeFeCzu4e6EpvePksWMwlfkXKPsm6fswYdGXVh
   2lrvmNBT7mR8lLeLRIsFKfAbmeYXEVGt3Aox4dCFXGdr8xFGYqd+ElK8f
   Cmg7EbwnqCKRVvYPchIaLhmRwd5qHGyZItAlsMesQNoKalTZvpM8uN2lu
   nhMGnAacpe+uQX2Vlc9IXA8+euiWGwlSzBEnTHfbx9bOHFkLSMV+iXQZi
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="289356938"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="289356938"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 18:13:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="934109122"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 13 Aug 2022 18:13:36 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oN2C8-0002HT-0A;
        Sun, 14 Aug 2022 01:13:36 +0000
Date:   Sun, 14 Aug 2022 09:13:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Olivier Masse <olivier.masse@nxp.com>, etienne.carriere@linaro.org,
        jens.wiklander@linaro.org, sumit.garg@linaro.org,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        op-tee@lists.trustedfirmware.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        clement.faure@nxp.com, olivier.masse@nxp.com
Subject: Re: [PATCH 1/1] tee: new ioctl to a register tee_shm from a dmabuf
 file descriptor
Message-ID: <202208140900.TNSQFBzy-lkp@intel.com>
References: <20220812143055.12938-2-olivier.masse@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812143055.12938-2-olivier.masse@nxp.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olivier,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on drm-tip/drm-tip linus/master v5.19 next-20220812]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Olivier-Masse/tee-Add-tee_shm_register_fd/20220812-223302
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
config: arm-randconfig-r026-20220814 (https://download.01.org/0day-ci/archive/20220814/202208140900.TNSQFBzy-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 3329cec2f79185bafd678f310fafadba2a8c76d2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/994ce362c3244904f79f1e7d4cb436ea162421d1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Olivier-Masse/tee-Add-tee_shm_register_fd/20220812-223302
        git checkout 994ce362c3244904f79f1e7d4cb436ea162421d1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: "__aeabi_uldivmod" [drivers/mtd/mtdswap.ko] undefined!
>> ERROR: modpost: module tee uses symbol dma_buf_get from namespace DMA_BUF, but does not import it.
>> ERROR: modpost: module tee uses symbol dma_buf_attach from namespace DMA_BUF, but does not import it.
>> ERROR: modpost: module tee uses symbol dma_buf_map_attachment from namespace DMA_BUF, but does not import it.
>> ERROR: modpost: module tee uses symbol dma_buf_unmap_attachment from namespace DMA_BUF, but does not import it.
>> ERROR: modpost: module tee uses symbol dma_buf_detach from namespace DMA_BUF, but does not import it.
>> ERROR: modpost: module tee uses symbol dma_buf_put from namespace DMA_BUF, but does not import it.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
