Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4CC4B9AA3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 09:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237343AbiBQIIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 03:08:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbiBQIIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:08:22 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C745627DF3C;
        Thu, 17 Feb 2022 00:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645085287; x=1676621287;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1VhacoEn/GVrgLJ8/r7CdUqdxZnPwYJJHumHS8rVU3s=;
  b=iNBSytUnGytzvJpG7vmE3DhLqlFH9f0T5F59oqoht56JZYgZ8mxXFwsR
   WErEPsOx9hCezJ3Ip+xGGo+KAg1hAcFzAgG6aPNR4tdw7EHzWAj6TSXWV
   Pkl5eqfuCp6AG6FT/mVzILQTvMEflAcWio5s/DfaCfL904gihLk5ERozf
   xz5hx8Rl7Z5o2Lq/fP1l/WkwJo17Cme697xutFNQ2rF5BJsqz4oXDrN12
   4uNeRh8xw6sdZZZ+QrQr9rRpAToQv48VvGuJHN7IGqyTX+w+HakER7ZhT
   nkI4MP+zqQ3N00E8n7+VRBXg2jxLUUoR5x53/N9FLbqPG3upqOiTnyE9d
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="251019574"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="251019574"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 00:08:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="776993133"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 17 Feb 2022 00:08:04 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKbpc-000BbD-5y; Thu, 17 Feb 2022 08:08:04 +0000
Date:   Thu, 17 Feb 2022 16:07:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guixin Liu <kanie@linux.alibaba.com>, gregkh@linuxfoundation.org,
        bostroesser@gmail.com, martin.petersen@oracle.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguang.wang@linux.alibaba.com,
        xlpang@linux.alibaba.com
Subject: Re: [PATCH 2/2] scsi:target:tcmu: reduce once copy by using uio ioctl
Message-ID: <202202171541.grdjAOIT-lkp@intel.com>
References: <1645064962-94123-2-git-send-email-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645064962-94123-2-git-send-email-kanie@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
config: riscv-randconfig-r042-20220217 (https://download.01.org/0day-ci/archive/20220217/202202171541.grdjAOIT-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0bad7cb56526f2572c74449fcf97c1fcda42b41d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/0day-ci/linux/commit/c604d03c2be8ca4b3533bb151bcd2d10379debff
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Guixin-Liu/uio-add-ioctl-to-uio/20220217-103120
        git checkout c604d03c2be8ca4b3533bb151bcd2d10379debff
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/target/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/target/target_core_user.c:1987:6: warning: no previous prototype for function 'tcmu_ioctl_copy_between_sgl_and_iovec' [-Wmissing-prototypes]
   long tcmu_ioctl_copy_between_sgl_and_iovec(struct tcmu_cmd *tcmu_cmd,
        ^
   drivers/target/target_core_user.c:1987:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   long tcmu_ioctl_copy_between_sgl_and_iovec(struct tcmu_cmd *tcmu_cmd,
   ^
   static 
>> drivers/target/target_core_user.c:2031:6: warning: no previous prototype for function 'tcmu_ioctl' [-Wmissing-prototypes]
   long tcmu_ioctl(struct uio_info *info, unsigned int cmd, unsigned long arg)
        ^
   drivers/target/target_core_user.c:2031:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   long tcmu_ioctl(struct uio_info *info, unsigned int cmd, unsigned long arg)
   ^
   static 
   2 warnings generated.


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
