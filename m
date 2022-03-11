Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B252B4D67C1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 18:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350825AbiCKRkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 12:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350819AbiCKRkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 12:40:46 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5101C57EB
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 09:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647020382; x=1678556382;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zYn7nenMY87v8uoKOz+5CcKHSn0YLCLJmC0iRm39VBo=;
  b=QAlSQJBE43mx1qqu/tBBscvgVStvmS4C3RcI/eOVuwScmBLVFd/XEmsg
   zNVwiawuCU3oYo9yIxtw4T0A3SwtTAw48jCp6QpORfE8R3bODDSNakHMQ
   1Q0qemjBN+YnIWMjbpJ+4OXYPe/xyUWOYjgIf4vwy22GY+DZkY5+sh3oc
   tbObuqgbMPfjTojKkOgIj8Rdl6q0ycDCxvk8CLVxSqhNxuR62kQ2g2GIf
   xl77Vt9mByk1546fU6QcgEe24M85aZWRnb9ilxZLaxy3DiAnT8+auvrUC
   Zq51wHBQV2cQlgK3fB4LTljow4tuAytwsUF7AjsXCYNhJ2YmkTMLauuVG
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="280363042"
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="280363042"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 09:39:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="579357724"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 11 Mar 2022 09:39:39 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSjEp-0006s9-7J; Fri, 11 Mar 2022 17:39:39 +0000
Date:   Sat, 12 Mar 2022 01:39:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>, rostedt@goodmis.org,
        mingo@redhat.com
Cc:     kbuild-all@lists.01.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, mark-pk.tsai@mediatek.com,
        yj.chiang@mediatek.com
Subject: Re: [PATCH] tracing: make tracer_init_tracefs initcall asynchronous
Message-ID: <202203120105.7vxKh4v9-lkp@intel.com>
References: <20220311112656.25348-1-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311112656.25348-1-mark-pk.tsai@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark-PK,

I love your patch! Perhaps something to improve:

[auto build test WARNING on rostedt-trace/for-next]
[also build test WARNING on v5.17-rc7 next-20220310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Mark-PK-Tsai/tracing-make-tracer_init_tracefs-initcall-asynchronous/20220311-192857
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git for-next
config: sh-randconfig-r031-20220311 (https://download.01.org/0day-ci/archive/20220312/202203120105.7vxKh4v9-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/134c5fb991a16bf28b500e8e52296447013b5b01
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Mark-PK-Tsai/tracing-make-tracer_init_tracefs-initcall-asynchronous/20220311-192857
        git checkout 134c5fb991a16bf28b500e8e52296447013b5b01
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0x144bfc): Section mismatch in reference from the function tracefs_init() to the function .init.text:set_reset_devices()
The function tracefs_init() references
the function __init set_reset_devices().
This is often because tracefs_init lacks a __init
annotation or the annotation of set_reset_devices is wrong.

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
