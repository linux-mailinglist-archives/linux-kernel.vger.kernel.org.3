Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F6C4D20C2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 19:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349321AbiCHSzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 13:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236164AbiCHSzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:55:53 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8477D3151B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 10:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646765696; x=1678301696;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=I6866jtO/MZB0w49OeoXo8Fqe0d9qFDHNlUqfWCJ6vk=;
  b=mOATg/xFIzFCfpfUagARHcb/K4mjZTfci9ph7oKCagw9YT3/pzRUHSY2
   d9ZBQDG/bhwatNee5XIfI3Wo44SuJXsRclSeqyv7Uh/1iMayqMA81tK8b
   OMbF/R87CZ9g+EgYRmXLLe4B2WbE5sv83xfBG/rukAfjE7FtnHBS0XWM2
   EbAc9w3qiipvceuvDq1XnxWezCF5D0GO3OcHEnAKmus3Sg9pz/cYYB3r5
   lS6UrlTdMyFKN12xvPG7BGKjnH48KsCAnqO63jYgfFkQrqSeY7IcbPK/r
   ynb/F7TOoTb2ttHATbg7eaeA2l2fepXEnsqU9X/9H6aIoASVsZn8AxHE6
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="242225442"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="242225442"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 10:54:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="641867106"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 08 Mar 2022 10:54:35 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nReyh-0001pu-7q; Tue, 08 Mar 2022 18:54:35 +0000
Date:   Wed, 9 Mar 2022 02:54:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [asahilinux:bits/100-shutdown-notifier 4/21] kernel/reboot.o:
 warning: objtool: sys_off_handler_power_off() falls through to next function
 register_power_off_handler()
Message-ID: <202203090241.r9sME55M-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/100-shutdown-notifier
head:   0ade1bb4fabcb819cbee8750358d32dfee49c7c3
commit: ee5b82d202cf9b01a6e96c765f52710b74ba4739 [4/21] kernel: Add combined power-off+restart handler call chain API
config: x86_64-randconfig-a003-20220307 (https://download.01.org/0day-ci/archive/20220309/202203090241.r9sME55M-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/AsahiLinux/linux/commit/ee5b82d202cf9b01a6e96c765f52710b74ba4739
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/100-shutdown-notifier
        git checkout ee5b82d202cf9b01a6e96c765f52710b74ba4739
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/reboot.o: warning: objtool: sys_off_handler_power_off() falls through to next function register_power_off_handler()

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
