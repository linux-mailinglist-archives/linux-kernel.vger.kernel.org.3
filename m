Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C134E7FB7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 08:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbiCZHLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 03:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiCZHLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 03:11:40 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BE126D124
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 00:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648278604; x=1679814604;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3XkKh4q0FSbrwEfEJ2bDjGkElgUoUsT2LDobzniVLOc=;
  b=JQ4Z0e9WQpNDNCEGXQhL0Nfsw2f2f8kW7GLWAWPUF2GnLT/0SYWzN2zf
   ZzqelFMfG8IcL5XVlXSb8Xj2DSch4L/iJ3KL7WcgxQc3W4/yxlNyIGWld
   JjVHQHZB7eSfCXqQg/9gxe5NYDWeN/VsFzTsbyAaHGIgKOrFhXmm+7hoi
   HUcJxBh/Px8vqqGeKP3sHGXu47TbWJ7zQZvaQ5xj+Qouw3BbJKar+dL8P
   hFZM/vFkI6Ct4rgFzNIlh5YJUFwpsZFrsbZEDW4x+ZFvjwGPlvDvMB2rS
   L01NGdEBWPJYX43fB2D/uOJcyXuQc5t+z1/XdfgzPjIDGHJIqw73woLmg
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="258953146"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="258953146"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2022 00:10:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="520443144"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 26 Mar 2022 00:10:03 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nY0Yk-000N6r-Ha; Sat, 26 Mar 2022 07:10:02 +0000
Date:   Sat, 26 Mar 2022 15:09:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: arch/arm64/kernel/proton-pack.c:953 this_cpu_set_vectors() warn:
 unsigned 'slot' is never less than zero.
Message-ID: <202203261509.y4KJfZNv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   52d543b5497cf31d6baeb0bcfe5a5474c3238578
commit: 558c303c9734af5a813739cd284879227f7297d2 arm64: Mitigate spectre style branch history side channels
date:   4 weeks ago
config: arm64-randconfig-m031-20220325 (https://download.01.org/0day-ci/archive/20220326/202203261509.y4KJfZNv-lkp@intel.com/config)
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
