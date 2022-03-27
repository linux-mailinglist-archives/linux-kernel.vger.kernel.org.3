Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FF04E85F9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 07:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbiC0Fhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 01:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbiC0Fhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 01:37:32 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E785DAE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 22:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648359353; x=1679895353;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4TYUpfpG6TbN1datt2KoN1OWaOXfrEoX5o19f6S765o=;
  b=bZ86DdFDziAUjXmOhdgd64ueamT/eDAWeKkYQgQdwyJOmz8lfy78fQDx
   QTfIXHhBTTuUro9w6yC/KdEQyK5B+wiQlXhSzYbVuK9ec4tpZqlw5+kTG
   rS//QYpnofujfUUMPeu5BPvnJegh7yC3U5kkIE97lss8qY+w6FiKWz36e
   CffSPQg8wzkHFXK//12YtPlmraFf5duKCFe61lr85bLTNcRLhHOhgH8W7
   ukeWNBMQGZoYa8X2TC4NObf1Fkvx/eEUeSHZFizp6meQY+QXAj3brg+Wx
   kwk0j1PdCCDGvi/swDgOQuRD6Q+zHr84NbXf4XWvOxB8JnmvHLu+RjWHE
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10298"; a="283709438"
X-IronPort-AV: E=Sophos;i="5.90,214,1643702400"; 
   d="scan'208";a="283709438"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2022 22:35:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,214,1643702400"; 
   d="scan'208";a="602442660"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 26 Mar 2022 22:35:51 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYLZ8-0000kn-Fc; Sun, 27 Mar 2022 05:35:50 +0000
Date:   Sun, 27 Mar 2022 13:35:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     wujunwen <wudaemon@163.com>, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        wujunwen <wudaemon@163.com>
Subject: Re: [PATCH v1] char: misc:use DEFINE_PROC_SHOW_ATTRIBUTE micro to
 simplify misc proc_fops
Message-ID: <202203271316.pktWRsr4-lkp@intel.com>
References: <20220327035854.219491-1-wudaemon@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220327035854.219491-1-wudaemon@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi wujunwen,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on soc/for-next linux/master linus/master v5.17 next-20220325]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/wujunwen/char-misc-use-DEFINE_PROC_SHOW_ATTRIBUTE-micro-to-simplify-misc-proc_fops/20220327-120053
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 37fd83916da2e4cae03d350015c82a67b1b334c4
config: xtensa-randconfig-m031-20220327 (https://download.01.org/0day-ci/archive/20220327/202203271316.pktWRsr4-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/738cb3f8808411f37ad8cb6c2529c6686a87eddf
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review wujunwen/char-misc-use-DEFINE_PROC_SHOW_ATTRIBUTE-micro-to-simplify-misc-proc_fops/20220327-120053
        git checkout 738cb3f8808411f37ad8cb6c2529c6686a87eddf
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash drivers/char/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/char/misc.c: In function 'misc_init':
>> drivers/char/misc.c:254:45: error: 'misc_proc_ops' undeclared (first use in this function); did you mean 'misc_fops'?
     254 |         ret = proc_create("misc", 0, NULL, &misc_proc_ops);
         |                                             ^~~~~~~~~~~~~
         |                                             misc_fops
   drivers/char/misc.c:254:45: note: each undeclared identifier is reported only once for each function it appears in


vim +254 drivers/char/misc.c

   248	
   249	static int __init misc_init(void)
   250	{
   251		int err;
   252		struct proc_dir_entry *ret;
   253	
 > 254		ret = proc_create("misc", 0, NULL, &misc_proc_ops);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
