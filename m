Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC8D4AAE53
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 09:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiBFIRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 03:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiBFIRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 03:17:16 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18B0C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 00:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644135435; x=1675671435;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IkilXivbkOSPTd9GDT2CMjBASm4tYIqrfiaLGhFJnLE=;
  b=gQMQ0Xp6I/oHYAhgr5X3p2Q+J3wZdXzIgEujT4GNfoDBCsbz2EflUOop
   sqd3VNVLUEP4cSPt4JkT1HhOYd9/bNjFDLpOAUOh81FTW+6UTEVmW+IR+
   ACWNn3RTvZd2Zvghq9N5hnyyb+4AFSR3NdyXZUXMN+GdfoS4olDz7DDKF
   8u+HMjlW+g8pUWdCu4IaLqfe03OEPRw/aKsY1eMaDs04aQqStTcimQlGw
   V9ubeiluceLOLsfAMKF7RVm8t7GaZNo/DQyyZbfW2orwrmpNLFKD0Ot4G
   K6fVcO68xS5ktYqRmsSX7024qNooPjDfJfb2mg4LeK57dQLs+N/gfr85I
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10249"; a="229211250"
X-IronPort-AV: E=Sophos;i="5.88,347,1635231600"; 
   d="scan'208";a="229211250"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 00:17:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,347,1635231600"; 
   d="scan'208";a="584544758"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 06 Feb 2022 00:17:13 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nGcjR-000a6P-0N; Sun, 06 Feb 2022 08:17:13 +0000
Date:   Sun, 6 Feb 2022 16:16:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matteo Croce <mcroce@microsoft.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: [esmil:visionfive 2/62] mm/kasan/shadow.c:63:7: warning: no previous
 prototype for function 'memcpy'
Message-ID: <202202061637.N7eINjAH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

tree:   https://github.com/esmil/linux visionfive
head:   8c758048edfd830baceb991167131c9d55786544
commit: 691cec28111689bd4ad88cbe0360dbb6eb4b3baa [2/62] riscv: optimized memcpy
config: riscv-randconfig-c006-20220206 (https://download.01.org/0day-ci/archive/20220206/202202061637.N7eINjAH-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6daaf5a44925592c764c59219b0024ee06317028)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/esmil/linux/commit/691cec28111689bd4ad88cbe0360dbb6eb4b3baa
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout 691cec28111689bd4ad88cbe0360dbb6eb4b3baa
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash mm/kasan/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/kasan/shadow.c:63:7: warning: no previous prototype for function 'memcpy' [-Wmissing-prototypes]
   void *memcpy(void *dest, const void *src, size_t len)
         ^
   mm/kasan/shadow.c:63:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void *memcpy(void *dest, const void *src, size_t len)
   ^
   static 
   1 warning generated.


vim +/memcpy +63 mm/kasan/shadow.c

bb359dbcb70085 Andrey Konovalov 2020-12-22  61  
bb359dbcb70085 Andrey Konovalov 2020-12-22  62  #undef memcpy
bb359dbcb70085 Andrey Konovalov 2020-12-22 @63  void *memcpy(void *dest, const void *src, size_t len)
bb359dbcb70085 Andrey Konovalov 2020-12-22  64  {
f00748bfa0246c Andrey Konovalov 2021-02-24  65  	if (!kasan_check_range((unsigned long)src, len, false, _RET_IP_) ||
f00748bfa0246c Andrey Konovalov 2021-02-24  66  	    !kasan_check_range((unsigned long)dest, len, true, _RET_IP_))
bb359dbcb70085 Andrey Konovalov 2020-12-22  67  		return NULL;
bb359dbcb70085 Andrey Konovalov 2020-12-22  68  
bb359dbcb70085 Andrey Konovalov 2020-12-22  69  	return __memcpy(dest, src, len);
bb359dbcb70085 Andrey Konovalov 2020-12-22  70  }
bb359dbcb70085 Andrey Konovalov 2020-12-22  71  

:::::: The code at line 63 was first introduced by commit
:::::: bb359dbcb70085a63e8bdbf14837a900750f0cf7 kasan: split out shadow.c from common.c

:::::: TO: Andrey Konovalov <andreyknvl@google.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
