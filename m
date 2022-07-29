Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE82585669
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 23:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239218AbiG2VS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 17:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiG2VS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 17:18:27 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB92E7756C
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 14:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659129505; x=1690665505;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qiSMksfHsoNMXsKEbHSVPl/Oe3oEf1KSad2punHaBUQ=;
  b=isggLY/YkkM4uvG1aHk0aObXCYaIAqtteUpJnQbLyNJbopULHrz6UiiA
   wbOhBY1+I9kK1fVTrgSvz9SjGSfORpMv7stL/zC0fBKMy+QQVat3J5pZV
   EYqgXz837TgKXNmqQO8NgIOWICWrAhyUanN9UNUku91hoaADlkjKpP7UR
   LdSVMQIrtvsmzi/j3RGjDZ/Q7xaoqwO4N3B+eUo2zoKNZT7SW2eB3U9RY
   tC1Otvj0mmwQXEaOcKwUlg/NnzoQu+WGWXPVB9ByEYwVp8EkgfmaRzNc8
   KK/tqxLBFPZWK1DEbJHr+QxkDtpcts6YI1hJZWoEtJELHiwsXLHIuZwuy
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="271890160"
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="271890160"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 14:18:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="629519311"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 29 Jul 2022 14:18:24 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHXNH-000C6H-15;
        Fri, 29 Jul 2022 21:18:23 +0000
Date:   Sat, 30 Jul 2022 05:17:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, 0day robot <lkp@intel.com>
Subject: ERROR: modpost: "__iget" [fs/fuse/fuse.ko] undefined!
Message-ID: <202207300555.ifWYohxt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220730-014236/Tycho-Andersen/sched-__fatal_signal_pending-should-also-check-shared/20220712-042911
head:   ac9225bf0cc3ae54d88be11ebf712c819bd0812b
commit: ac9225bf0cc3ae54d88be11ebf712c819bd0812b fuse: In fuse_flush only wait if someone wants the return code
date:   3 hours ago
config: s390-randconfig-r044-20220729 (https://download.01.org/0day-ci/archive/20220730/202207300555.ifWYohxt-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 8dfaecc4c24494337933aff9d9166486ca0949f1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/ac9225bf0cc3ae54d88be11ebf712c819bd0812b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20220730-014236/Tycho-Andersen/sched-__fatal_signal_pending-should-also-check-shared/20220712-042911
        git checkout ac9225bf0cc3ae54d88be11ebf712c819bd0812b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__iget" [fs/fuse/fuse.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
