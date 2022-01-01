Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9563D4827D3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 16:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbiAAO6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 09:58:49 -0500
Received: from mga01.intel.com ([192.55.52.88]:60969 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232444AbiAAO6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 09:58:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641049128; x=1672585128;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0O5H27av7NSYt37Hv9lB3GHJPdxTwFi3IRt+x+jlGsc=;
  b=BfEqU4ApTFoUdu/Dq+tqNfRJK2pdH7D2NBjqDXR9sDXu64Lp2CKpM/O+
   DujV9peojZj2LAl0P/y8bsIMXj5C3wHdh/EyI3wQsIKg8kMhgSg0E1BYh
   kyOs8ZtZ/TQWG2Zta95hy+PRMpeINzFrQ2Hw89GULgITKg2y6fj5+p3Tg
   3cv7zv/l1rlVZ3840sYjXh0fAFNMtfbdHmgaVWVgYsp/Lr401K6cGWRfu
   PnkmK1Ex29oOQEEVHnz0rJKE7mmAC1Tp/PV/LTLbxKZoHCj5ckgzxzkMY
   OCwId2TWXAxfmHF51J+tjVdC/bOP2s7MRcvxwOG6Sv48nASQy/1gYNhgK
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10214"; a="266155795"
X-IronPort-AV: E=Sophos;i="5.88,254,1635231600"; 
   d="scan'208";a="266155795"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2022 06:58:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,254,1635231600"; 
   d="scan'208";a="471175757"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 01 Jan 2022 06:58:46 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n3fqI-000CZo-9A; Sat, 01 Jan 2022 14:58:46 +0000
Date:   Sat, 1 Jan 2022 22:57:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:tglx/devel/hrtimer 11/11]
 kernel/time/hrtimer.c:1087:12: sparse: sparse: function
 'hrtimer_forward_now' with external linkage has definition
Message-ID: <202201012226.XYB7q71g-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block tglx/devel/hrtimer
head:   9ad8708a7b7f585067bef93398ca52581ab4474c
commit: 9ad8708a7b7f585067bef93398ca52581ab4474c [11/11] hrtimer: Make hrtimer_forward() private to core timer code
config: i386-randconfig-s001-20211231 (https://download.01.org/0day-ci/archive/20220101/202201012226.XYB7q71g-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/9ad8708a7b7f585067bef93398ca52581ab4474c
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block tglx/devel/hrtimer
        git checkout 9ad8708a7b7f585067bef93398ca52581ab4474c
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash kernel/time/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> kernel/time/hrtimer.c:1087:12: sparse: sparse: function 'hrtimer_forward_now' with external linkage has definition

vim +/hrtimer_forward_now +1087 kernel/time/hrtimer.c

  1070	
  1071	/**
  1072	 * hrtimer_forward_now - forward the timer expiry so it expires after now
  1073	 * @timer:	hrtimer to forward
  1074	 * @interval:	the interval to forward
  1075	 *
  1076	 * Forward the timer expiry so it will expire after the current time
  1077	 * of the hrtimer clock base. Returns the number of overruns.
  1078	 *
  1079	 * Can be safely called from the callback function of @timer. If
  1080	 * called from other contexts @timer must neither be enqueued nor
  1081	 * running the callback and the caller needs to take care of
  1082	 * serialization.
  1083	 *
  1084	 * Note: This only updates the timer expiry value and does not requeue
  1085	 * the timer.
  1086	 */
> 1087	extern u64 hrtimer_forward_now(struct hrtimer *timer, ktime_t interval)
  1088	{
  1089		return hrtimer_forward(timer, timer->base->get_time(), interval);
  1090	}
  1091	EXPORT_SYMBOL_GPL(hrtimer_forward_now);
  1092	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
