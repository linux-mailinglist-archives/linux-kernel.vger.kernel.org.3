Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6D053A01F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344501AbiFAJN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbiFAJN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:13:56 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715A338791
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 02:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654074835; x=1685610835;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2iRND0sR2JrAd5jopntHy39jQB2cI4jEtYJQYCcb5o8=;
  b=Cw6gM7CB5HlfnKR+OG3ANOvdlG6ZrU9rVE0tuL8QaoemvQMxya+S13Uf
   AL6XFylej2jJWQpmM74IOEOleRYEXFzX1lxA6bqEMHrOgyriZsM9vuEJj
   83WBph8aOAjJlwNmL1HwpMD1r+8HNSu+qqk5Wy/c5TCbPeADE/WpHqq3m
   p+E4ms29K4PGljFW5noanne8w39/HnySC3P+6bubcRvgmUFkSJUs2Qcyr
   /y2ZY+ru/1wKG3FLM5FHTQZNdKZw8vTeOkCQb8l9ZlTkyTKlwnoWLF8ES
   YOPUGwqxAfL+UuaZEjFpBG1xGsSe6FaT+w6FIoiSjWRTcVAhQqDNyouY1
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="338571740"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="338571740"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 02:13:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="612241710"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 01 Jun 2022 02:13:54 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwKQL-0003n2-Em;
        Wed, 01 Jun 2022 09:13:53 +0000
Date:   Wed, 1 Jun 2022 17:13:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:sched/idle 13/19] vmlinux.o: warning: objtool:
 tick_check_broadcast_expired+0x2f: call to __kasan_check_read() leaves
 .noinstr.text section
Message-ID: <202206011749.IenKXuNb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/idle
head:   800e96de10eefe4eca5bb5f4492a77dac04b52dc
commit: 998ebff7327f7dfd547abe683c254fe949e2336c [13/19] idle: Fix rcu_idle_*() usage
config: x86_64-randconfig-a014-20211121 (https://download.01.org/0day-ci/archive/20220601/202206011749.IenKXuNb-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=998ebff7327f7dfd547abe683c254fe949e2336c
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue sched/idle
        git checkout 998ebff7327f7dfd547abe683c254fe949e2336c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: exc_nmi+0x109: call to static_key_count.constprop.0() leaves .noinstr.text section
   vmlinux.o: warning: objtool: exc_page_fault+0x34: call to static_key_count() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: tick_check_broadcast_expired+0x2f: call to __kasan_check_read() leaves .noinstr.text section

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
