Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792AA4B9E66
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 12:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239636AbiBQLNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 06:13:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237224AbiBQLNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 06:13:02 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F210A1DE8BF;
        Thu, 17 Feb 2022 03:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645096369; x=1676632369;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7LuC6+1zs4/fdUkb7NAYI3fM7fCNsq1bJk+vs9e7YV8=;
  b=b+9/gyxNVSQnIOCrWDP2WpUx3QaKuWNGjxG6WkwfBg9OHOFrmq0IraOP
   Gx0A/QjYiWCXB9ufEnF4kOFIb2irSec5KZOcfIV7yESVRdslUD0trwl1A
   bNdi0V2FD0/EvlNSy1oaOXWGuVhBtCF57GllRJdv1Q8NAwGazmjZhiaou
   F+T6VPEy2ZEYUI+OC6GwTO8jZnaX9BfOTDRjh0udgvyS4SoO+gMf0v/UG
   EQyV2KYJJI8jc0kWdWyObrSRR98NhPI01ZNYxRj0YojSiPypGSevwn7hI
   dGRBTwFp4MKLegLd47QENHAMNO3ZfFIgBjhAR/xUDc4S1/t5WMZ2oG13j
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="250587312"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="250587312"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 03:12:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="637049221"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 17 Feb 2022 03:12:46 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKeiL-00006P-HL; Thu, 17 Feb 2022 11:12:45 +0000
Date:   Thu, 17 Feb 2022 19:12:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guixin Liu <kanie@linux.alibaba.com>, gregkh@linuxfoundation.org,
        bostroesser@gmail.com, martin.petersen@oracle.com
Cc:     kbuild-all@lists.01.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaoguang.wang@linux.alibaba.com, xlpang@linux.alibaba.com
Subject: Re: [PATCH 2/2] scsi:target:tcmu: reduce once copy by using uio ioctl
Message-ID: <202202171918.s8P0xa1Y-lkp@intel.com>
References: <1645064962-94123-2-git-send-email-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645064962-94123-2-git-send-email-kanie@linux.alibaba.com>
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

Hi Guixin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on mkp-scsi/for-next linux/master linus/master v5.17-rc4 next-20220216]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Guixin-Liu/uio-add-ioctl-to-uio/20220217-103120
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git e6cb9c167eeb8f90ab924666c573e69e85e700a0
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20220217/202202171918.s8P0xa1Y-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/c604d03c2be8ca4b3533bb151bcd2d10379debff
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Guixin-Liu/uio-add-ioctl-to-uio/20220217-103120
        git checkout c604d03c2be8ca4b3533bb151bcd2d10379debff
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/target/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/target/target_core_user.c:1987:6: sparse: sparse: symbol 'tcmu_ioctl_copy_between_sgl_and_iovec' was not declared. Should it be static?
>> drivers/target/target_core_user.c:2031:6: sparse: sparse: symbol 'tcmu_ioctl' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
