Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE6C4D6D05
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 07:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiCLGeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 01:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiCLGeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 01:34:13 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADD538BCA
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 22:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647066787; x=1678602787;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+b0VZEx+YMOz50j9JYS/6oci0qLqoQBc4dJLtODBa3U=;
  b=FB/Vo5vQspOJyHnNQyznJnwzXG7fR8Cl0qbmy+4Z93dz7eE2mAQdJJoP
   9U6yoxVl+FdFTXLHa5IpUzmveCEHz98ij6xZIid8a7pXX8Go+QXS80BZ1
   TPzpFOG6X1a/OpiRfCAUT2It+lALjQg66JOAn3Yapwr692feIy0jWnBGI
   S5wsjoKYM2KcvCXsNoV61Cz7dGPfY4RlD+Wco9iUrf4mI4yTyvv3MPt6H
   1nCW85EkhnopntjY7mFXAbUOPBGYve5jlozuJzuid9QBv+YPN1CfTQEVC
   VCUbaUKMeAujIommvr2Jl54EPNNHAd3u0ghcCfQpdGUw50UYWAouCz5z2
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="254595054"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="254595054"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 22:33:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="555663939"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 11 Mar 2022 22:33:05 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSvJJ-0007bZ-2A; Sat, 12 Mar 2022 06:33:05 +0000
Date:   Sat, 12 Mar 2022 14:32:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: arch/arm64/kernel/proton-pack.c:953 this_cpu_set_vectors() warn:
 unsigned 'slot' is never less than zero.
Message-ID: <202203121458.ZX5wQMAu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   68453767131a5deec1e8f9ac92a9042f929e585d
commit: 558c303c9734af5a813739cd284879227f7297d2 arm64: Mitigate spectre style branch history side channels
date:   2 weeks ago
config: arm64-randconfig-m031-20220310 (https://download.01.org/0day-ci/archive/20220312/202203121458.ZX5wQMAu-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
arch/arm64/kernel/proton-pack.c:953 this_cpu_set_vectors() warn: unsigned 'slot' is never less than zero.

vim +/slot +953 arch/arm64/kernel/proton-pack.c

   948	
   949	static void this_cpu_set_vectors(enum arm64_bp_harden_el1_vectors slot)
   950	{
   951		const char *v = arm64_get_bp_hardening_vector(slot);
   952	
 > 953		if (slot < 0)
   954			return;
   955	
   956		__this_cpu_write(this_cpu_vector, v);
   957	
   958		/*
   959		 * When KPTI is in use, the vectors are switched when exiting to
   960		 * user-space.
   961		 */
   962		if (arm64_kernel_unmapped_at_el0())
   963			return;
   964	
   965		write_sysreg(v, vbar_el1);
   966		isb();
   967	}
   968	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
