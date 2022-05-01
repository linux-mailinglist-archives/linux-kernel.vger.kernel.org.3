Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2F751619C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 06:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236930AbiEAEdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 00:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiEAEdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 00:33:35 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D13BE9
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 21:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651379408; x=1682915408;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=q5AVfg/RvNHVlzWVyiEqd8E8CxJ1CYs3+SOBK7SKTtQ=;
  b=N/vcvjC3+fv4Des5TGESz7lrGHRem0LYegp5QBKvlvL9r2W4E21LWacb
   6t7I9/X0M0DP9+Fc4W8IbtWeTJ7DicFzhkL3GiSi4nc0jFi74BsqdAERP
   dbSBaQeAV3xwRSGnsacM/B4J6qszdtS+UzmUrkSYLN0tlLSpcYXoy4aVc
   sLhBtOJWD+fs9ZpRhJ4dH2g13/yBaJqx9jfeJ1h7qnmPFNfVKq9Qzg/KH
   zWNQ0ngYtD7+TgSpwqzQZpQfPO9Bp5HPrsQ5NQJMV+Sm1ePMGl6TB29mj
   momuZ3YawsZQWAU6UrzPcf3fZ2By19o3P1j7she27GL5g2LheknmLrCzA
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10333"; a="353385532"
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; 
   d="scan'208";a="353385532"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 21:30:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; 
   d="scan'208";a="561116743"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 30 Apr 2022 21:30:06 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nl1Di-0008To-85;
        Sun, 01 May 2022 04:30:06 +0000
Date:   Sun, 1 May 2022 12:29:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>
Subject: include/linux/seq_file.h:247:9: warning: 'strncpy' output may be
 truncated copying 4 bytes from a string of length 4
Message-ID: <202205011239.gGl2ZZel-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ilya,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   57ae8a492116910bad2b3497ffe555b3a4b4180f
commit: e37b3dd063a1a68e28a7cfaf77c84c472112e330 s390: enable KCSAN
date:   9 months ago
config: s390-randconfig-r015-20220501 (https://download.01.org/0day-ci/archive/20220501/202205011239.gGl2ZZel-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e37b3dd063a1a68e28a7cfaf77c84c472112e330
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e37b3dd063a1a68e28a7cfaf77c84c472112e330
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/seq_file_net.h:5,
                    from include/net/net_namespace.h:179,
                    from include/linux/inet.h:42,
                    from fs/ocfs2/super.c:21:
   fs/ocfs2/super.c: In function 'ocfs2_show_options':
>> include/linux/seq_file.h:247:9: warning: 'strncpy' output may be truncated copying 4 bytes from a string of length 4 [-Wstringop-truncation]
     247 |         strncpy(val_buf, value, length);                \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/ocfs2/super.c:1539:17: note: in expansion of macro 'seq_show_option_n'
    1539 |                 seq_show_option_n(s, "cluster_stack", osb->osb_cluster_stack,
         |                 ^~~~~~~~~~~~~~~~~


vim +/strncpy +247 include/linux/seq_file.h

a068acf2ee7769 Kees Cook 2015-09-04  233  
a068acf2ee7769 Kees Cook 2015-09-04  234  /**
a068acf2ee7769 Kees Cook 2015-09-04  235   * seq_show_option_n - display mount options with appropriate escapes
a068acf2ee7769 Kees Cook 2015-09-04  236   *		       where @value must be a specific length.
a068acf2ee7769 Kees Cook 2015-09-04  237   * @m: the seq_file handle
a068acf2ee7769 Kees Cook 2015-09-04  238   * @name: the mount option name
a068acf2ee7769 Kees Cook 2015-09-04  239   * @value: the mount option name's value, cannot be NULL
a068acf2ee7769 Kees Cook 2015-09-04  240   * @length: the length of @value to display
a068acf2ee7769 Kees Cook 2015-09-04  241   *
a068acf2ee7769 Kees Cook 2015-09-04  242   * This is a macro since this uses "length" to define the size of the
a068acf2ee7769 Kees Cook 2015-09-04  243   * stack buffer.
a068acf2ee7769 Kees Cook 2015-09-04  244   */
a068acf2ee7769 Kees Cook 2015-09-04  245  #define seq_show_option_n(m, name, value, length) {	\
a068acf2ee7769 Kees Cook 2015-09-04  246  	char val_buf[length + 1];			\
a068acf2ee7769 Kees Cook 2015-09-04 @247  	strncpy(val_buf, value, length);		\
a068acf2ee7769 Kees Cook 2015-09-04  248  	val_buf[length] = '\0';				\
a068acf2ee7769 Kees Cook 2015-09-04  249  	seq_show_option(m, name, val_buf);		\
a068acf2ee7769 Kees Cook 2015-09-04  250  }
a068acf2ee7769 Kees Cook 2015-09-04  251  

:::::: The code at line 247 was first introduced by commit
:::::: a068acf2ee77693e0bf39d6e07139ba704f461c3 fs: create and use seq_show_option for escaping

:::::: TO: Kees Cook <keescook@chromium.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
