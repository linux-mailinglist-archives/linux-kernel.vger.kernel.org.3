Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F48C4E863F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 08:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbiC0GSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 02:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiC0GSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 02:18:32 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E76BFC1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 23:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648361815; x=1679897815;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=08G6ifSTauJ8kgC7zzmccUPip4T8HRtfNK+jtuN3/W4=;
  b=cb1v2YCRxIZtBsV67D7TjAFY3SfWWMQU/yWaFODPjVUAGFVjHhPUwGAv
   4lHKaHl95atpg2e+shaJIJwoEY2qABj+Dj5wjqtI/GlF5Ojq4x+N35xyK
   O6fgRSw6bTGDmXhI4LL+9c9P+s6JXKiYWuOcy8t/lthYzdLtx2RmJqTj3
   oHnC0HPAF0nY7FQo6R7j+nkoKGCb7cgWecRCth+BfYDGOPuGEh1iJDx3e
   iGiChTqOdBDmkdCv+iX73MM6KoOzzlGeMtgshmnMxBtjJHLQrnmtOKvHK
   9eHUWtpusBUu2wAuZ+lv0TiSIs64b3aiSG91aWlWVuCrn+AmIP5PsQo97
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10298"; a="345263997"
X-IronPort-AV: E=Sophos;i="5.90,214,1643702400"; 
   d="scan'208";a="345263997"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2022 23:16:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,214,1643702400"; 
   d="scan'208";a="584858534"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 26 Mar 2022 23:16:52 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYMCq-0000ma-96; Sun, 27 Mar 2022 06:16:52 +0000
Date:   Sun, 27 Mar 2022 14:16:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     wujunwen <wudaemon@163.com>, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, wujunwen <wudaemon@163.com>
Subject: Re: [PATCH v1] char: misc:use DEFINE_PROC_SHOW_ATTRIBUTE micro to
 simplify misc proc_fops
Message-ID: <202203271414.XUS8IhaO-lkp@intel.com>
References: <20220327035854.219491-1-wudaemon@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220327035854.219491-1-wudaemon@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
config: hexagon-randconfig-r045-20220327 (https://download.01.org/0day-ci/archive/20220327/202203271414.XUS8IhaO-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/738cb3f8808411f37ad8cb6c2529c6686a87eddf
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review wujunwen/char-misc-use-DEFINE_PROC_SHOW_ATTRIBUTE-micro-to-simplify-misc-proc_fops/20220327-120053
        git checkout 738cb3f8808411f37ad8cb6c2529c6686a87eddf
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/char/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/char/misc.c:254:38: error: use of undeclared identifier 'misc_proc_ops'; did you mean 'misc_fops'?
           ret = proc_create("misc", 0, NULL, &misc_proc_ops);
                                               ^~~~~~~~~~~~~
                                               misc_fops
   drivers/char/misc.c:132:37: note: 'misc_fops' declared here
   static const struct file_operations misc_fops = {
                                       ^
   1 error generated.


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
