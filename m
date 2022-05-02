Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4EC517790
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 21:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387162AbiEBTti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 15:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238542AbiEBTtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 15:49:36 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0387565BD
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 12:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651520762; x=1683056762;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=M4niFshntDK2QmAcs2/a7uHttMZ31/JR2/RX9cUSQiY=;
  b=TzY8khPahPW/xDLbrsL+cngPiKU3cC2EWHOv+jlOq/L89cbeACV0V6e8
   D2ksFctfjzw7lmRE/x3Kcu3Qu5IyMU5lYT8QVvGi4nAnXXubERk1CYXUY
   85JfQ+skAqYr8f5Qn4gf7zyQ39umSRLZs5y+fw2rcIwB0c9uNcjtl9Oj3
   NGo3EJdrYjGCxgu2HeLBu/pOTEeLkAdKjhk+2aiwNQTAXPyaADDtkElCP
   goQCANMqvQSnCgru7hj2Wb6t6vQvELHmkel47CUz0Ovh7xZ7lzpZHRdQK
   Uob6VZSPzzwhjBlwzfyMLau3SIqswxhn+D/JbQBLEvb9YpQyLaEydSJbE
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="330305168"
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="330305168"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 12:46:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="546592237"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 02 May 2022 12:46:01 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlbzc-0009p0-R3;
        Mon, 02 May 2022 19:46:00 +0000
Date:   Tue, 3 May 2022 03:45:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [asahilinux:bits/100-shutdown-notifier 4/20] kernel/reboot.o:
 warning: objtool: sys_off_handler_power_off() falls through to next function
 type_store()
Message-ID: <202205030300.tbyjHXmy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/100-shutdown-notifier
head:   06115822707a3ed6f89da2ea9c157c283b6750ee
commit: 6025f4b3d1a321e1cfc8a6b6651395cc43ceb2f3 [4/20] kernel: Add combined power-off+restart handler call chain API
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220503/202205030300.tbyjHXmy-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/AsahiLinux/linux/commit/6025f4b3d1a321e1cfc8a6b6651395cc43ceb2f3
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/100-shutdown-notifier
        git checkout 6025f4b3d1a321e1cfc8a6b6651395cc43ceb2f3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/reboot.o: warning: objtool: sys_off_handler_power_off() falls through to next function type_store()

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
