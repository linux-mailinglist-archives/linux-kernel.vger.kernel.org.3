Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6134B590B7F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 07:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236903AbiHLF1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 01:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236270AbiHLF1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 01:27:37 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0F8A0274;
        Thu, 11 Aug 2022 22:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660282056; x=1691818056;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aD66a3tlUSHNk9f+LMWfIXawj2d8pgOYlU8yPhvZhyU=;
  b=ODgj4mUt+jPWKjqYHAmrc57fc7Au6RCRsG69z4u/FaGQYJM7+h1MrDip
   kM/3aZ6Lt7hlOYokEfHf91H5uZg7g6Pt3FPO7L/ZYHT/aXF7Hr854f37h
   F1g8/rUrgYvTElf9jKjAV5FsV5VcZt6zkV+f5T+8NcDU8d6NAOPzP/9Gh
   r65DNUzlFYgKQvxNL+UhYxI8UAYPWr97YBzTJ7huxNeMG3btNyaTxNVRm
   ntGh5guIcCUq8JJI18XP0S/ZbXWqIs1IWtT+T/hQWaKXcicQIgF5Qo8Gm
   N4jD36XYaAlMq1ZXzcESjTW/Hrw+5xoylclm0kZG3yIJ/kJFZLLhnw1Tl
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="278475234"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="278475234"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 22:27:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="556407140"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 11 Aug 2022 22:27:33 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMNCm-0000CU-2a;
        Fri, 12 Aug 2022 05:27:32 +0000
Date:   Fri, 12 Aug 2022 13:27:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Olivier Masse <olivier.masse@nxp.com>, jens.wiklander@linaro.org,
        sumit.garg@linaro.org, sumit.semwal@linaro.org,
        christian.koenig@amd.com, op-tee@lists.trustedfirmware.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     kbuild-all@lists.01.org, clement.faure@nxp.com,
        olivier.masse@nxp.com
Subject: Re: [PATCH 1/1] tee: new ioctl to a register tee_shm from a dmabuf
 file descriptor
Message-ID: <202208121326.FWVAzlch-lkp@intel.com>
References: <20220811135637.6332-2-olivier.masse@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811135637.6332-2-olivier.masse@nxp.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olivier,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on drm-tip/drm-tip linus/master v5.19 next-20220811]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Olivier-Masse/tee-Add-tee_shm_register_fd/20220811-220012
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220812/202208121326.FWVAzlch-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/2e8827973f200fdfe64366bec5a57686086f4672
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Olivier-Masse/tee-Add-tee_shm_register_fd/20220811-220012
        git checkout 2e8827973f200fdfe64366bec5a57686086f4672
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/linux/tee.h:136:13: error: expected declaration specifiers or '...' before numeric constant
     136 | } __aligned(8);
         |             ^

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
