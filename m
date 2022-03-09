Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7D04D3CC4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238574AbiCIWTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234505AbiCIWTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:19:38 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CB8119427
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646864318; x=1678400318;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zehQ3kdJ3E/dxPKf/DnEfn6NdkY1zXH6CPpFNHXdb6k=;
  b=eXdf4M936SNyGBcKoE2QaIOpaXIDU58MWYWPU4UKk6/OoXrvoh3ammuk
   7ftVPCumg2JKtsnYl2oV1HfWueGm8nCV1JAJCI08kBG+twJoqHp6HzPQ/
   t/Q3MoeV8in7pj+qBP/juwl4ouBnGV+zFPnEkNALRhiSHSyaT6cF7mbsV
   Q/TTGg9UzkAsyL/MiKfGgb77DzVLS+nfc0IYNgrW08EuyucgjDvrCubVE
   WuXuMCIpVbmTSs6fFof4c/DE8n4V1abc0ZggP/resYMIhz0WW10Z8KtM/
   8UuoJ0nv+ce2iHc8sbsuqrzy9aTkbHUGDlTkZNPNRRuIRDIp33XH+kkUc
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="235055216"
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="235055216"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 14:18:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="712116256"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 09 Mar 2022 14:18:36 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nS4df-0003tG-CU; Wed, 09 Mar 2022 22:18:35 +0000
Date:   Thu, 10 Mar 2022 06:17:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Raghu Bankapur <quic_rbankapu@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Krishna Jha <quic_kkishorj@quicinc.com>
Subject: Re: [PATCH V0 1/1] ASoC: msm: fix integer overflow for long duration
 offload playback
Message-ID: <202203100601.sczPjPL5-lkp@intel.com>
References: <b906dbaf772d0152a3af52d639b090d15fe8c362.1646835508.git.quic_rbankapu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b906dbaf772d0152a3af52d639b090d15fe8c362.1646835508.git.quic_rbankapu@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Raghu,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tiwai-sound/for-next]
[also build test ERROR on vkoul-dmaengine/next broonie-sound/for-next v5.17-rc7 next-20220309]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Raghu-Bankapur/ASoC-msm-fix-integer-overflow-for-long-duration-compress-offload-playback/20220309-222520
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
config: i386-randconfig-c001 (https://download.01.org/0day-ci/archive/20220310/202203100601.sczPjPL5-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/9020c5c2e38ba210a8d822d20e32bed85a4ffcab
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Raghu-Bankapur/ASoC-msm-fix-integer-overflow-for-long-duration-compress-offload-playback/20220309-222520
        git checkout 9020c5c2e38ba210a8d822d20e32bed85a4ffcab
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>, old ones prefixed by <<):

In file included from include/linux/printk.h:555,
from include/linux/kernel.h:29,
from arch/x86/include/asm/percpu.h:27,
from arch/x86/include/asm/current.h:6,
from include/linux/sched.h:12,
from include/linux/delay.h:23,
from sound/soc/intel/atom/sst/sst_drv_interface.c:13:
sound/soc/intel/atom/sst/sst_drv_interface.c: In function 'sst_cdev_tstamp':
>> sound/soc/intel/atom/sst/sst_drv_interface.c:369:15: warning: format '%d' expects argument of type 'int', but argument 5 has type '__u64' {aka 'long long unsigned int'} [-Wformat=]
369 |  dev_dbg(dev, "Ptr Query on strid = %d  copied_total %d, decodec %dn",
|               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/dynamic_debug.h:134:15: note: in definition of macro '__dynamic_func_call'
134 |   func(&id, ##__VA_ARGS__);           |               ^~~~~~~~~~~
include/linux/dynamic_debug.h:166:2: note: in expansion of macro '_dynamic_func_call'
166 |  _dynamic_func_call(fmt,__dynamic_dev_dbg,            |  ^~~~~~~~~~~~~~~~~~
include/linux/dev_printk.h:155:2: note: in expansion of macro 'dynamic_dev_dbg'
155 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
|  ^~~~~~~~~~~~~~~
include/linux/dev_printk.h:155:23: note: in expansion of macro 'dev_fmt'
155 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
|                       ^~~~~~~
sound/soc/intel/atom/sst/sst_drv_interface.c:369:2: note: in expansion of macro 'dev_dbg'
369 |  dev_dbg(dev, "Ptr Query on strid = %d  copied_total %d, decodec %dn",
|  ^~~~~~~
sound/soc/intel/atom/sst/sst_drv_interface.c:369:55: note: format string is defined here
369 |  dev_dbg(dev, "Ptr Query on strid = %d  copied_total %d, decodec %dn",
|                                                      ~^
|                                                       |
|                                                       int
|                                                      %lld
--
>> ERROR: modpost: "__umoddi3" [sound/soc/intel/atom/snd-soc-sst-atom-hifi2-platform.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
