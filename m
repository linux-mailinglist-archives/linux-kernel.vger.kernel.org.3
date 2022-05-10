Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717A052143D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241249AbiEJLzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235005AbiEJLzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:55:39 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7EE26FA54
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652183502; x=1683719502;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B9dvgBmCF5L3kTd7CYqO7etly7B/b4QuOSBtMc3H03Q=;
  b=JGn/lF8srZwmgtaQD/Y4yE9HvjacuSycSNwcyQbQFl8/d/5a1DQEDmN9
   k1bUMHpke/jpw4tKrmiXwqn7zszlas/ye/qxvzjeJJ0FVS9/05w+4ZeWM
   /riSCGFC29e+HJcQw3WyKXb314Qx46Q9z4aKVY9mNjMp7BKf4g6D/lQf0
   IAhc3t5PELEq+w+55wgZnItU4WBRhKKL3hEUELewShztmayFMJ0tzYdqa
   R5qogP/byP6tXVhCUEbeoZMyDcD3erkCr357FUHQVt2TaA34dOrXQ+J/q
   NUFIVX3tJ4dAE4E3rg7904F3qxDxTAj454cXWRO/Ym6hi2NXDRXY3DU5R
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="249879040"
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="249879040"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 04:51:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="669843159"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 10 May 2022 04:51:31 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noOOp-000Hpq-9O;
        Tue, 10 May 2022 11:51:31 +0000
Date:   Tue, 10 May 2022 19:50:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guixin Liu <kanie@linux.alibaba.com>, gregkh@linuxfoundation.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uio: Replace mutex info_lock with percpu_ref
Message-ID: <202205101914.ZJmSORCV-lkp@intel.com>
References: <1652161831-77791-1-git-send-email-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652161831-77791-1-git-send-email-kanie@linux.alibaba.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guixin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on linux/master linus/master v5.18-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Guixin-Liu/uio-Replace-mutex-info_lock-with-percpu_ref/20220510-135202
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 33a1c6618677fe33f8e84cb7bedc45abbce89a50
config: s390-randconfig-s031-20220509 (https://download.01.org/0day-ci/archive/20220510/202205101914.ZJmSORCV-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/intel-lab-lkp/linux/commit/4d3e70c70de7bcf57d176790db79b8cbee990171
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Guixin-Liu/uio-Replace-mutex-info_lock-with-percpu_ref/20220510-135202
        git checkout 4d3e70c70de7bcf57d176790db79b8cbee990171
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/uio/uio.c:564:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __poll_t @@     got int @@
   drivers/uio/uio.c:564:24: sparse:     expected restricted __poll_t
   drivers/uio/uio.c:564:24: sparse:     got int
   drivers/uio/uio.c:567:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __poll_t [usertype] ret @@     got int @@
   drivers/uio/uio.c:567:21: sparse:     expected restricted __poll_t [usertype] ret
   drivers/uio/uio.c:567:21: sparse:     got int

vim +564 drivers/uio/uio.c

   556	
   557	static __poll_t uio_poll(struct file *filep, poll_table *wait)
   558	{
   559		struct uio_listener *listener = filep->private_data;
   560		struct uio_device *idev = listener->dev;
   561		__poll_t ret = 0;
   562	
   563		if (!percpu_ref_tryget_live(&idev->info_ref))
 > 564			return -EIO;
   565	
   566		if (!idev->info || !idev->info->irq)
   567			ret = -EIO;
   568		percpu_ref_put(&idev->info_ref);
   569	
   570		if (ret)
   571			return ret;
   572	
   573		poll_wait(filep, &idev->wait, wait);
   574		if (listener->event_count != atomic_read(&idev->event))
   575			return EPOLLIN | EPOLLRDNORM;
   576		return 0;
   577	}
   578	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
