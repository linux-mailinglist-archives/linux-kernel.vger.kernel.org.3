Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EB94B996D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 07:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbiBQGqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 01:46:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiBQGqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 01:46:20 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B415A23E5E6;
        Wed, 16 Feb 2022 22:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645080366; x=1676616366;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8izTYU5ikyTgPzpWzPc6BESbcbuST2IfNuKXkeEdjAw=;
  b=HXCaGf2NnSWeTG4AWPlxPPJwhza7hNo2pkpbFhLd2yjhvvR2JQ34UEa3
   Ky7cJ3+DR4WWSfjLwj/zo0pn7t+WFKULVZuEGpLAe6uj9MU1SBgnPvARr
   JDbKDT+11W0CPymL5EHySXYS21ImYgnWPL/Ekom6guaxbnptYyLj+qqYX
   aulaohPXeT5fznNmItzu/Ie+L6+1n6u5XXPob3b4U6BrZj8pm8Nh+FTLl
   C1PrwhGoRN1W4b5C54BWxQBozmq/79GWW7K0pW9sffz7zWLlEE2+gJrun
   Jvz1Q/vm91hHN18L8kN8vrs5mNkuEWkSLlwDfY4aH1QImqQT6s8WATCiT
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="238212133"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="238212133"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 22:46:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="774447747"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 16 Feb 2022 22:46:03 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKaYE-000BXD-Ms; Thu, 17 Feb 2022 06:46:02 +0000
Date:   Thu, 17 Feb 2022 14:45:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guixin Liu <kanie@linux.alibaba.com>, gregkh@linuxfoundation.org,
        bostroesser@gmail.com, martin.petersen@oracle.com
Cc:     kbuild-all@lists.01.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaoguang.wang@linux.alibaba.com, xlpang@linux.alibaba.com
Subject: Re: [PATCH 2/2] scsi:target:tcmu: reduce once copy by using uio ioctl
Message-ID: <202202171452.MblxpwJx-lkp@intel.com>
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
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220217/202202171452.MblxpwJx-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/c604d03c2be8ca4b3533bb151bcd2d10379debff
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Guixin-Liu/uio-add-ioctl-to-uio/20220217-103120
        git checkout c604d03c2be8ca4b3533bb151bcd2d10379debff
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/target/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/target/target_core_user.c:1987:6: warning: no previous prototype for 'tcmu_ioctl_copy_between_sgl_and_iovec' [-Wmissing-prototypes]
    1987 | long tcmu_ioctl_copy_between_sgl_and_iovec(struct tcmu_cmd *tcmu_cmd,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/target/target_core_user.c:2031:6: warning: no previous prototype for 'tcmu_ioctl' [-Wmissing-prototypes]
    2031 | long tcmu_ioctl(struct uio_info *info, unsigned int cmd, unsigned long arg)
         |      ^~~~~~~~~~


vim +/tcmu_ioctl_copy_between_sgl_and_iovec +1987 drivers/target/target_core_user.c

  1986	
> 1987	long tcmu_ioctl_copy_between_sgl_and_iovec(struct tcmu_cmd *tcmu_cmd,
  1988				struct iovec __user *uiovec,
  1989				unsigned long vcnt,
  1990				bool is_copy_to_sgl)
  1991	{
  1992		struct iovec iovstack[UIO_FASTIOV];
  1993		struct iovec *iov = iovstack;
  1994		struct iov_iter iter;
  1995		ssize_t ret;
  1996		struct se_cmd *se_cmd = tcmu_cmd->se_cmd;
  1997		struct scatterlist *data_sg, *sg;
  1998		int i;
  1999		unsigned int data_nents;
  2000		long copy_ret = 0;
  2001	
  2002		if (se_cmd->se_cmd_flags & SCF_BIDI) {
  2003			data_sg = se_cmd->t_bidi_data_sg;
  2004			data_nents = se_cmd->t_bidi_data_nents;
  2005		} else {
  2006			data_sg = se_cmd->t_data_sg;
  2007			data_nents = se_cmd->t_data_nents;
  2008		}
  2009	
  2010		ret = import_iovec(READ, uiovec, vcnt, ARRAY_SIZE(iovstack), &iov, &iter);
  2011		if (ret < 0) {
  2012			pr_err("import iovec failed.\n");
  2013			return -EFAULT;
  2014		}
  2015	
  2016		for_each_sg(data_sg, sg, data_nents, i) {
  2017			if (is_copy_to_sgl)
  2018				ret = copy_page_from_iter(sg_page(sg), sg->offset, sg->length, &iter);
  2019			else
  2020				ret = copy_page_to_iter(sg_page(sg), sg->offset, sg->length, &iter);
  2021			if (ret < 0) {
  2022				pr_err("copy failed.\n");
  2023				copy_ret = -EFAULT;
  2024				break;
  2025			}
  2026		}
  2027		kfree(iov);
  2028		return copy_ret;
  2029	}
  2030	
> 2031	long tcmu_ioctl(struct uio_info *info, unsigned int cmd, unsigned long arg)
  2032	{
  2033		struct tcmu_dev *udev = container_of(info, struct tcmu_dev, uio_info);
  2034		struct tcmu_data_xfer __user *uxfer = (struct tcmu_data_xfer __user *)arg;
  2035		struct tcmu_data_xfer xfer;
  2036		struct tcmu_cmd *tcmu_cmd;
  2037	
  2038		if (!test_bit(TCMU_DEV_BIT_BYPASS_DATA_AREA, &udev->flags))
  2039			return -EINVAL;
  2040	
  2041		if (copy_from_user(&xfer, uxfer, sizeof(xfer)))
  2042			return -EFAULT;
  2043	
  2044		tcmu_cmd = xa_load(&udev->commands, xfer.cmd_id);
  2045		if (!tcmu_cmd) {
  2046			set_bit(TCMU_DEV_BIT_BROKEN, &udev->flags);
  2047			return -EFAULT;
  2048		}
  2049	
  2050		if (test_bit(TCMU_CMD_BIT_EXPIRED, &tcmu_cmd->flags))
  2051			return -EFAULT;
  2052	
  2053		switch (cmd) {
  2054		case TCMU_IOCTL_CMD_COPY_TO_SGL:
  2055			return tcmu_ioctl_copy_between_sgl_and_iovec(tcmu_cmd, xfer.iovec,
  2056								     xfer.iov_cnt, true);
  2057		case TCMU_IOCTL_CMD_COPY_FROM_SGL:
  2058			return tcmu_ioctl_copy_between_sgl_and_iovec(tcmu_cmd, xfer.iovec,
  2059								     xfer.iov_cnt, false);
  2060		default:
  2061			return -EINVAL;
  2062		}
  2063	}
  2064	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
