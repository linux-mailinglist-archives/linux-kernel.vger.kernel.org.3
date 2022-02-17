Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8614B9985
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 07:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbiBQG4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 01:56:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiBQG4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 01:56:19 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE66727F298;
        Wed, 16 Feb 2022 22:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645080965; x=1676616965;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nbe4Fwiyx8rYqaNPl7hAoUCmlKv54SDhqXwRa/L9Toc=;
  b=hTdE9UcvGinkNDmcXWf3TcmLw/9RbIRb9Tux8Js3HTMFleG4kwJAHjB1
   ryD5tnsywx06DLTMp0X1wBnzl2GvRA7Z3qAVoZoQKGM1V8HB4+2agrcxx
   ZVmlIHaQjBJHOB4crOCkslkyi2Q2CrwuMHhmPMf9Q0uW4X9H/XkVBL2Jy
   1kax8RMf3bBWzGjQACqBt8tb4wvcKF3OD7GvMVKupmZv9s3NQ5ngx0+NN
   gEAXxvse09ccffUyP2jyufp4EYmy7nZQtRueIcBIkIovSIDjpv2dSHFO9
   VMwWXy04ouhCuZMg3VMDgZZjNtKhBTOs1NWYCow0hqKBIFg3etK2k+3le
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="231432854"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="231432854"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 22:56:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="625853020"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Feb 2022 22:56:03 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKahu-000BXe-RS; Thu, 17 Feb 2022 06:56:02 +0000
Date:   Thu, 17 Feb 2022 14:55:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guixin Liu <kanie@linux.alibaba.com>, gregkh@linuxfoundation.org,
        bostroesser@gmail.com, martin.petersen@oracle.com
Cc:     kbuild-all@lists.01.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaoguang.wang@linux.alibaba.com, xlpang@linux.alibaba.com
Subject: Re: [PATCH 1/2] uio: add ioctl to uio
Message-ID: <202202171444.RSO1up2n-lkp@intel.com>
References: <1645064962-94123-1-git-send-email-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645064962-94123-1-git-send-email-kanie@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
config: arc-randconfig-r035-20220217 (https://download.01.org/0day-ci/archive/20220217/202202171444.RSO1up2n-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/8786f129af888d844bc38ed78db7a6788e45655c
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Guixin-Liu/uio-add-ioctl-to-uio/20220217-103120
        git checkout 8786f129af888d844bc38ed78db7a6788e45655c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/uio/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/uio/uio.c:818:6: warning: no previous prototype for 'uio_ioctl' [-Wmissing-prototypes]
     818 | long uio_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
         |      ^~~~~~~~~


vim +/uio_ioctl +818 drivers/uio/uio.c

   817	
 > 818	long uio_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
   819	{
   820		struct uio_listener *listener = filep->private_data;
   821		struct uio_device *idev = listener->dev;
   822		long retval = 0;
   823	
   824		mutex_lock(&idev->info_lock);
   825		if (!idev->info || !idev->info->ioctl) {
   826			retval = -EINVAL;
   827			goto out;
   828		}
   829	
   830		retval = idev->info->ioctl(idev->info, cmd, arg);
   831	out:
   832		mutex_unlock(&idev->info_lock);
   833		return retval;
   834	}
   835	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
