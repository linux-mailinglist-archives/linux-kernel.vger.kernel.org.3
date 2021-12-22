Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D765947D64B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbhLVSLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:11:01 -0500
Received: from mga03.intel.com ([134.134.136.65]:33348 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230262AbhLVSLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:11:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640196660; x=1671732660;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rk+tA9JmZAod42g/Oa/YvvojwiIES7soxlbjsghydkI=;
  b=S15B5/D7OPPBC1hXhoB3TKYiValxcGIzOWKTZK6t5QvlxMA7lSWRYz9p
   gWhH1qz46F7TfUC7ivRdroPtz+xxnTTy5BSqiZCR4gTZfg3ukUodAn8hX
   V1/ewCwxgcx28knpA+gcqdRsc8d9mRAXv/tMuqX55zl9zcL73fTswEd/+
   2nMPbqHsZ8gaWd+C+nlCBziHQQh0idfSJkcgBx/BNVKFGDphUl8EDYpTJ
   wTfy2ep3EVDtTAjZm77QXBHSAMe6MDVWBMhlrwuCTsPUKE1m6rwH63ys2
   xPGg9mGdvwp23A8MDB4OOoSAziFXmJQpQg4bPLaxJqyGmyj8BRtdhKCsf
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="240636170"
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; 
   d="scan'208";a="240636170"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 10:10:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; 
   d="scan'208";a="758650549"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 22 Dec 2021 10:10:58 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n064o-0000pM-1t; Wed, 22 Dec 2021 18:10:58 +0000
Date:   Thu, 23 Dec 2021 02:10:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        John Fastabend <john.fastabend@gmail.com>
Subject: kernel/bpf/verifier.c:1371 __reg32_bound_s64() warn: always true
 condition '(a <= (((~0) >> 1))) => (s32min-s32max <= s32max)'
Message-ID: <202112230216.VClmulwe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2f47a9a4dfa3674fad19a49b40c5103a9a8e1589
commit: e572ff80f05c33cd0cb4860f864f5c9c044280b6 bpf: Make 32->64 bounds propagation slightly more robust
date:   6 days ago
config: x86_64-randconfig-m001-20211222 (https://download.01.org/0day-ci/archive/20211223/202112230216.VClmulwe-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
kernel/bpf/verifier.c:1371 __reg32_bound_s64() warn: always true condition '(a <= (((~0) >> 1))) => (s32min-s32max <= s32max)'

vim +1371 kernel/bpf/verifier.c

  1368	
  1369	static bool __reg32_bound_s64(s32 a)
  1370	{
> 1371		return a >= 0 && a <= S32_MAX;
  1372	}
  1373	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
