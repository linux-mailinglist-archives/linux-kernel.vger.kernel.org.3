Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5564F21B0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiDECw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbiDECvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:51:43 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE223A4F9F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649123969; x=1680659969;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rFzUkn5Y5xQQ2HAB0qQSLI8m5kgEaFLoljYOb1PCiZg=;
  b=U91uwvCRl680fupQY4wxT96uCHtJO0j9uK4Gi3dRyTSB2H2sLpbi4OcT
   b7gGaia2zmlRGEoHU4yQOq5qSlKNZfjqwW8sjf4e9k9mZB1SrK8XlgJbH
   wfbqFwbqUP2z7PQRKJ36i83K7Oy1T2ek/bZadpeWX1nmyFYiX7VURRtyw
   X9mRMIkFEspgXUJufyu9xMmJmFfBGA+lVhDCRwVgq5U0oQCX5j+LdrskW
   vas0gmf1BeKaqcANIJ1ZA1eSdEBzVwfVmfKOCs0bGbnHNLArTCn+omX7O
   B509Rwg/67FuVHOSs9z3AjWh78Ii49DEzQiFAgh6m+0vRyz+hoJYrAbVt
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="323811701"
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="323811701"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 17:34:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="548858094"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 04 Apr 2022 17:34:39 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbX9b-0002Uh-8C;
        Tue, 05 Apr 2022 00:34:39 +0000
Date:   Tue, 5 Apr 2022 08:34:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [intel-tdx:host-upstream 4/22] arch/x86/virt/vmx/tdx/seamcall.o:
 warning: objtool: __seamcall()+0x46: missing int3 after ret
Message-ID: <202204050802.3XX06naF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai,

First bad commit (maybe != root cause):

tree:   https://github.com/intel/tdx.git host-upstream
head:   5361812499e28ae0203df555669b6c1d79754fd1
commit: 40b2c61b1b21e86f5b32ec6222cfc11270fe0ce1 [4/22] x86/virt/tdx: Implement the SEAMCALL base function
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220405/202204050802.3XX06naF-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/40b2c61b1b21e86f5b32ec6222cfc11270fe0ce1
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx host-upstream
        git checkout 40b2c61b1b21e86f5b32ec6222cfc11270fe0ce1
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/virt/vmx/tdx/seamcall.o: warning: objtool: __seamcall()+0x46: missing int3 after ret

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
