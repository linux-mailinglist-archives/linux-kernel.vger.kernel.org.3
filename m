Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCD0461D54
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 19:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350128AbhK2SI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 13:08:56 -0500
Received: from mga06.intel.com ([134.134.136.31]:3804 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243023AbhK2SGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 13:06:51 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="296844349"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="296844349"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 10:01:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="459251126"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 29 Nov 2021 10:01:16 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mrkxo-000CCY-1J; Mon, 29 Nov 2021 18:01:16 +0000
Date:   Tue, 30 Nov 2021 02:00:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     pandith.n@intel.com, djakov@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, mgross@linux.intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        Pandith N <pandith.n@intel.com>
Subject: Re: [PATCH V8 1/1] interconnect: intel: Add Keem Bay noc driver
Message-ID: <202111300127.TJsMMckG-lkp@intel.com>
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
[also build test WARNING on v5.16-rc3 next-20211129]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/pandith-n-intel-com/interconnect-intel-Add-Keem-Bay-noc-driver/20211129-235117
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git d58071a8a76d779eedab38033ae4c821c30295a5
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20211130/202111300127.TJsMMckG-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/724e8829a62d4ae6908d011f927e0c3ae5b0a80c
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review pandith-n-intel-com/interconnect-intel-Add-Keem-Bay-noc-driver/20211129-235117
        git checkout 724e8829a62d4ae6908d011f927e0c3ae5b0a80c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/interconnect/intel/

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
