Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A7B463E51
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 20:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238979AbhK3TDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 14:03:35 -0500
Received: from mga01.intel.com ([192.55.52.88]:57429 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234889AbhK3TDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 14:03:30 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="260262544"
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="260262544"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 11:00:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="477231734"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 30 Nov 2021 11:00:05 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ms8MH-000Dfl-31; Tue, 30 Nov 2021 19:00:05 +0000
Date:   Wed, 1 Dec 2021 02:59:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     pandith.n@intel.com, djakov@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        mgross@linux.intel.com, furong.zhou@intel.com,
        mallikarjunappa.sangannavar@intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        Pandith N <pandith.n@intel.com>
Subject: Re: [PATCH V8 1/1] interconnect: intel: Add Keem Bay noc driver
Message-ID: <202112010223.Pb0XZMHN-lkp@intel.com>
References: <20211129154337.14398-1-pandith.n@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129154337.14398-1-pandith.n@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.16-rc3 next-20211130]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/pandith-n-intel-com/interconnect-intel-Add-Keem-Bay-noc-driver/20211129-235117
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git d58071a8a76d779eedab38033ae4c821c30295a5
config: i386-randconfig-c001-20211130 (https://download.01.org/0day-ci/archive/20211201/202112010223.Pb0XZMHN-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 25eb7fa01d7ebbe67648ea03841cda55b4239ab2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/724e8829a62d4ae6908d011f927e0c3ae5b0a80c
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review pandith-n-intel-com/interconnect-intel-Add-Keem-Bay-noc-driver/20211129-235117
        git checkout 724e8829a62d4ae6908d011f927e0c3ae5b0a80c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/interconnect/intel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/interconnect/intel/keembay-bwmon.c:142: warning: expecting prototype for flexnoc_counterp_capture(). Prototype was for flexnoc_counter_capture() instead


vim +142 drivers/interconnect/intel/keembay-bwmon.c

   122	
   123	/**
   124	 * flexnoc_counterp_capture() - Capture the counter statistic values
   125	 * @noc: NOC type to setup counters
   126	 * @counter:  Counter number to capture statistics values for n and n+1
   127	 * @value: statistics values read are returned in this address passed
   128	 *
   129	 * This function will return the statistics value of started counters.
   130	 * When this function returns NOC_PROBE_COMPLETED, it is guaranteed that NOC
   131	 * counters are idle and finished probing.
   132	 * Algo : The values should not returned when counters are active/running.
   133	 * Once the counter is frozen, the values are good to read. There is an
   134	 * iteration logic implemented to check this. An maximum timeout config
   135	 * is provided to for capture timeout - NOC_CAPTURE_TIMEOUT_MSEC
   136	 *
   137	 *  Returns NOC_PROBE_COMPLETED if the counters are stopped or
   138	 *  NOC_PROBE_ERR_IN_PROGRESS if counters are still running
   139	 */
   140	enum noc_status flexnoc_counter_capture(enum noc_ss_type noc,
   141						enum noc_counter counter, u32  *value)
 > 142	{
   143		unsigned long timeout;
   144		u32 c0_0, c0_1;
   145	
   146		if (noc >= NOC_TYPE_MAX ||
   147		    counter >= NOC_COUNTER_MAX  ||
   148		    !value)
   149			return NOC_PROBE_ERR_INVALID_ARGS;
   150	
   151		timeout = jiffies + msecs_to_jiffies(NOC_CAPTURE_TIMEOUT_MSEC);
   152		do {
   153			c0_0 = noc_readl((c_offset[counter] + C_VAL));
   154			usleep_range(10000, 11000);
   155			c0_1 = noc_readl((c_offset[counter] + C_VAL));
   156			/* If mainctrl is zero , return error */
   157			if (noc_readl(MAINCTL) == 0)
   158				return NOC_PROBE_ERR_IN_PROGRESS;
   159			/* If counters are zero, keep reading */
   160			if (0 == c0_0 && 0 == c0_1) {
   161				break;
   162			} else if (c0_0 != c0_1) {
   163				continue;
   164			} else {
   165				/* counters look good break the while */
   166				break;
   167			}
   168		} while (time_before(jiffies, timeout));
   169	
   170		if (c0_0 != c0_1)
   171			return NOC_PROBE_ERR_IN_PROGRESS;
   172	
   173		c0_0 = noc_readl((c_offset[counter] + C_VAL));
   174		c0_1 = noc_readl((c_offset[counter + 1] + C_VAL));
   175		*value = (c0_0 | (c0_1 << 16));
   176	
   177		return NOC_PROBE_COMPLETED;
   178	}
   179	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
