Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B1849D343
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 21:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiAZUOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 15:14:21 -0500
Received: from mga09.intel.com ([134.134.136.24]:15905 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229896AbiAZUOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 15:14:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643228059; x=1674764059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/ukKSFdAUPpf/QfN0sGPLQ3JOBHzlkmjhMof0xl0gJk=;
  b=IYXVsnRbpCQP95GzI2MRP9NTCV5P59WbGitNaZN/JZGx/acYbNUiUXk5
   h8eEyDY90PMZjYWCBQnLZ7QaEC5VUFgBLvyeU1eqX8NDHAVwv7XRIYH0g
   LQO8nq4ASi4pgfCaCZjS3LkRznH9rHylHAyHqc5XCdzBD45aHXNp8LLIV
   DpRxceY9Snj8ubMfI0DlPEr8LrkW6zHpL8RvrTYss91I1BPQHJhwsrUiW
   NM9lPSa8IG0GQ5h3z/0EUJMsEUyzS8YzbVpI7uDKBEoEFNe2aU0xAga+B
   GQ2pYe6fH9UeE8JxiydxVHqmY8sVhdMm8WucXb5NBFAdSl/aS/Fp6TA7A
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="246419408"
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="246419408"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 12:14:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="767244739"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 26 Jan 2022 12:14:16 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCogJ-000LcA-FA; Wed, 26 Jan 2022 20:14:15 +0000
Date:   Thu, 27 Jan 2022 04:14:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        robh+dt@kernel.org, gregkh@linuxfoundation.org
Cc:     kbuild-all@lists.01.org, devicetree@vger.kernel.org,
        ekangupt@qti.qualcomm.com, bkumar@qti.qualcomm.com,
        linux-kernel@vger.kernel.org, srini@kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        Vamsi Krishna Gattupalli <quic_vgattupa@quicinc.com>
Subject: Re: [PATCH v3 11/12] misc: fastrpc: Add dma handle implementation
Message-ID: <202201270412.QDMYUTEr-lkp@intel.com>
References: <20220126135304.16340-12-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126135304.16340-12-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on robh/for-next linux/master linus/master v5.17-rc1 next-20220125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Srinivas-Kandagatla/misc-fastrpc-Add-missing-DSP-FastRPC-features/20220126-215705
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 515a2f507491e7c3818e74ef4f4e088c1fecb190
config: arc-randconfig-r003-20220126 (https://download.01.org/0day-ci/archive/20220127/202201270412.QDMYUTEr-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/70d5973b9373ab26b6a1ed520ee07b71c7bdba63
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Srinivas-Kandagatla/misc-fastrpc-Add-missing-DSP-FastRPC-features/20220126-215705
        git checkout 70d5973b9373ab26b6a1ed520ee07b71c7bdba63
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/misc/fastrpc.c: In function 'fastrpc_req_mem_unmap_impl':
   drivers/misc/fastrpc.c:1761:23: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1761 |         args[0].ptr = (u64) &req_msg;
         |                       ^
   drivers/misc/fastrpc.c: In function 'fastrpc_req_mem_map':
   drivers/misc/fastrpc.c:1811:19: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    1811 |         map->va = (void *) req.vaddrin;
         |                   ^
   drivers/misc/fastrpc.c:1816:23: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1816 |         args[0].ptr = (u64) &req_msg;
         |                       ^
   drivers/misc/fastrpc.c:1822:23: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1822 |         args[1].ptr = (u64) &pages;
         |                       ^
   drivers/misc/fastrpc.c:1825:23: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1825 |         args[2].ptr = (u64) &pages;
         |                       ^
   drivers/misc/fastrpc.c:1828:23: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1828 |         args[3].ptr = (u64) &rsp_msg;
         |                       ^
   drivers/misc/fastrpc.c: In function 'fastrpc_get_info_from_kernel.constprop':
>> drivers/misc/fastrpc.c:1552:1: warning: the frame size of 1076 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    1552 | }
         | ^


vim +1552 drivers/misc/fastrpc.c

a22465bb4904fac Jeya R 2022-01-26  1515  
a22465bb4904fac Jeya R 2022-01-26  1516  static int fastrpc_get_info_from_kernel(struct fastrpc_ioctl_capability *cap,
a22465bb4904fac Jeya R 2022-01-26  1517  					struct fastrpc_user *fl)
a22465bb4904fac Jeya R 2022-01-26  1518  {
a22465bb4904fac Jeya R 2022-01-26  1519  	struct fastrpc_channel_ctx *cctx = fl->cctx;
a22465bb4904fac Jeya R 2022-01-26  1520  	uint32_t attribute_id = cap->attribute_id;
a22465bb4904fac Jeya R 2022-01-26  1521  	uint32_t dsp_attributes[FASTRPC_MAX_DSP_ATTRIBUTES];
a22465bb4904fac Jeya R 2022-01-26  1522  	unsigned long flags;
a22465bb4904fac Jeya R 2022-01-26  1523  	uint32_t domain = cap->domain;
a22465bb4904fac Jeya R 2022-01-26  1524  	int err;
a22465bb4904fac Jeya R 2022-01-26  1525  
a22465bb4904fac Jeya R 2022-01-26  1526  	spin_lock_irqsave(&cctx->lock, flags);
a22465bb4904fac Jeya R 2022-01-26  1527  	/* check if we already have queried dsp for attributes */
a22465bb4904fac Jeya R 2022-01-26  1528  	if (cctx->valid_attributes) {
a22465bb4904fac Jeya R 2022-01-26  1529  		spin_unlock_irqrestore(&cctx->lock, flags);
a22465bb4904fac Jeya R 2022-01-26  1530  		goto done;
a22465bb4904fac Jeya R 2022-01-26  1531  	}
a22465bb4904fac Jeya R 2022-01-26  1532  	spin_unlock_irqrestore(&cctx->lock, flags);
a22465bb4904fac Jeya R 2022-01-26  1533  
a22465bb4904fac Jeya R 2022-01-26  1534  	err = fastrpc_get_info_from_dsp(fl, &dsp_attributes[0], FASTRPC_MAX_DSP_ATTRIBUTES);
a22465bb4904fac Jeya R 2022-01-26  1535  	if (err == DSP_UNSUPPORTED_API) {
a22465bb4904fac Jeya R 2022-01-26  1536  		dev_info(&cctx->rpdev->dev,
a22465bb4904fac Jeya R 2022-01-26  1537  			 "Warning: DSP capabilities not supported on domain: %d\n", domain);
a22465bb4904fac Jeya R 2022-01-26  1538  		return -EOPNOTSUPP;
a22465bb4904fac Jeya R 2022-01-26  1539  	} else if (err) {
a22465bb4904fac Jeya R 2022-01-26  1540  		dev_err(&cctx->rpdev->dev, "Error: dsp information is incorrect err: %d\n", err);
a22465bb4904fac Jeya R 2022-01-26  1541  		return err;
a22465bb4904fac Jeya R 2022-01-26  1542  	}
a22465bb4904fac Jeya R 2022-01-26  1543  
a22465bb4904fac Jeya R 2022-01-26  1544  	spin_lock_irqsave(&cctx->lock, flags);
a22465bb4904fac Jeya R 2022-01-26  1545  	memcpy(cctx->dsp_attributes, dsp_attributes, sizeof(u32) * FASTRPC_MAX_DSP_ATTRIBUTES);
a22465bb4904fac Jeya R 2022-01-26  1546  	cctx->valid_attributes = true;
a22465bb4904fac Jeya R 2022-01-26  1547  	spin_unlock_irqrestore(&cctx->lock, flags);
a22465bb4904fac Jeya R 2022-01-26  1548  done:
a22465bb4904fac Jeya R 2022-01-26  1549  	cap->capability = cctx->dsp_attributes[attribute_id];
a22465bb4904fac Jeya R 2022-01-26  1550  
a22465bb4904fac Jeya R 2022-01-26  1551  	return 0;
a22465bb4904fac Jeya R 2022-01-26 @1552  }
a22465bb4904fac Jeya R 2022-01-26  1553  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
