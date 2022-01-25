Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEAE849BBEF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 20:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiAYTRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 14:17:55 -0500
Received: from mga07.intel.com ([134.134.136.100]:29240 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229693AbiAYTRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 14:17:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643138238; x=1674674238;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZmdgKV23shC62GQNH4kvDMIZaD91wpZTmCxoePGuLRA=;
  b=Dt2gQopILpjkeVb/N5NFIlu98Rvjxd4PzJw0/dnrsFV0kfuSYqM8MJQq
   yQbMEnCFZKCQl+xCVv7NdGdYQjoHPd4XDbZjW8FrCOX7fhIJ9sDtgMOh2
   Xtutr7ub9Ks71gLlE0RexNiGQfr6zBvqHiy/ceRDdfXYdPGoftKBMxg4e
   WFqdC7Dyd3rMs4wnmUfRHJqc/XQ2zgF/DW1NYbXGEiXeKNHnb54yZqpYC
   JLh5EwR/qDAqAFvfSX2dr8MXvjCKbN7H8+JVkHkzIw/L6OZ741nLpIf4C
   AVs188ooD5ryNnYUg8Tk2P+B6b21SZtX7lOGnS0KMNgByWNx7E02F6aWA
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="309708926"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="309708926"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 11:17:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="534868816"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 25 Jan 2022 11:17:16 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCRJb-000KKo-Dt; Tue, 25 Jan 2022 19:17:15 +0000
Date:   Wed, 26 Jan 2022 03:17:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [morse:mpam/snapshot/v5.16 4/137]
 arch/x86/kernel/cpu/resctrl/core.c:417:6: warning: no previous prototype for
 'domain_free'
Message-ID: <202201260142.TfzTxnA2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v5.16
head:   364c1c42b229912132e1615c2ce15be7154e2156
commit: 22965510f006f9207f1615ffb3543c9314ac6d01 [4/137] x86/resctrl: Group struct rdt_hw_domain cleanup
config: i386-randconfig-m021-20220124 (https://download.01.org/0day-ci/archive/20220126/202201260142.TfzTxnA2-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?id=22965510f006f9207f1615ffb3543c9314ac6d01
        git remote add morse https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
        git fetch --no-tags morse mpam/snapshot/v5.16
        git checkout 22965510f006f9207f1615ffb3543c9314ac6d01
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kernel/cpu/resctrl/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/cpu/resctrl/core.c:417:6: warning: no previous prototype for 'domain_free' [-Wmissing-prototypes]
     417 | void domain_free(struct rdt_hw_domain *hw_dom)
         |      ^~~~~~~~~~~


vim +/domain_free +417 arch/x86/kernel/cpu/resctrl/core.c

   416	
 > 417	void domain_free(struct rdt_hw_domain *hw_dom)
   418	{
   419		kfree(hw_dom->ctrl_val);
   420		kfree(hw_dom->mbps_val);
   421		kfree(hw_dom);
   422	}
   423	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
