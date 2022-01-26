Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E544449C40E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 08:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbiAZHJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 02:09:39 -0500
Received: from mga12.intel.com ([192.55.52.136]:56754 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbiAZHJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 02:09:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643180978; x=1674716978;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3LxuYhn+DPcDbYi9QL4BEi76zfJYJiigC2SK/UTOTu4=;
  b=hQighq1oOKa0cq37QCfviMt+vhx6u/gkCzOZ7EC80YKVQ7DjNSis2ckZ
   zQ2mKfPdodUmRMU8H+VqypRakwHVFzL/oTSbCCuuItUFlZxJzapXFPFkQ
   P/OyRyDFCyH5SjKTybqBga6R6QK63jRq224HT5pvvSTZ1s4QQLooxPSB+
   1W9i47jzXN8gkNeoAGpv96yVHi5ts9eBX6igEsv+BvA7J+FsfCPa60MX1
   NMQJ3aqwicedWDt45hWDPDsyp/DCjOB6bv3OiXONiiG+6m7OnPnAIjnhH
   4Vkpy0HPfLGV/lczhelPRUdfRkZsdJAYI4npUw8JDWGKQX1eTR57KUgmY
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="226471580"
X-IronPort-AV: E=Sophos;i="5.88,317,1635231600"; 
   d="scan'208";a="226471580"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 23:09:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,317,1635231600"; 
   d="scan'208";a="696127828"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 25 Jan 2022 23:09:37 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCcQy-000KuL-Cg; Wed, 26 Jan 2022 07:09:36 +0000
Date:   Wed, 26 Jan 2022 15:08:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/parisc/kernel/setup.c:64 setup_cmdline() warn: inconsistent
 indenting
Message-ID: <202201261513.lCbDYZFQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0280e3c58f92b2fe0e8fbbdf8d386449168de4a8
commit: 5f7ee6e37a3cadefe45378c17c4285fa41141d92 parisc: Autodetect default output device and set console= kernel parameter
date:   5 days ago
config: parisc-randconfig-m031-20220126 (https://download.01.org/0day-ci/archive/20220126/202201261513.lCbDYZFQ-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
arch/parisc/kernel/setup.c:64 setup_cmdline() warn: inconsistent indenting

vim +64 arch/parisc/kernel/setup.c

    47	
    48	void __init setup_cmdline(char **cmdline_p)
    49	{
    50		extern unsigned int boot_args[];
    51		char *p;
    52	
    53		/* Collect stuff passed in from the boot loader */
    54	
    55		/* boot_args[0] is free-mem start, boot_args[1] is ptr to command line */
    56		if (boot_args[0] < 64) {
    57			/* called from hpux boot loader */
    58			boot_command_line[0] = '\0';
    59		} else {
    60			strscpy(boot_command_line, (char *)__va(boot_args[1]),
    61				COMMAND_LINE_SIZE);
    62	
    63		/* autodetect console type (if not done by palo yet) */
  > 64		p = boot_command_line;
    65		if (!str_has_prefix(p, "console=") && !strstr(p, " console=")) {
    66			strlcat(p, " console=", COMMAND_LINE_SIZE);
    67			if (PAGE0->mem_cons.cl_class == CL_DUPLEX)
    68				strlcat(p, "ttyS0", COMMAND_LINE_SIZE);
    69			else
    70				strlcat(p, "tty0", COMMAND_LINE_SIZE);
    71		}
    72	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
