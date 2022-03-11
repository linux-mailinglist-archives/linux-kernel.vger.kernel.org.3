Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7997C4D6256
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 14:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348905AbiCKNY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 08:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345965AbiCKNYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 08:24:12 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A0C76E2F;
        Fri, 11 Mar 2022 05:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647004988; x=1678540988;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UXpw8xMUXXNMq602k1Jggox1J6ysJh5BAv361tPlTcw=;
  b=KZEkNrHTIeAtqBK4mOqvbDsHCjg7dYekL3ojVUQwWmuJAYhfPMwg2Z0T
   RcawHPKZXCCmQVjj3rcSYh+ZGbOCORdM9QHOrQf2bZL/xehOjn0Ql9XQv
   SrN+drxYJhdJDZmPsDRnQYtJ0FcSUBszIFfW0gViCKs6jMihnFa61CuIZ
   peI3gYeNql6Oqr54agAszoDlI+5XEARj0NdX8nk3cY9KqfdEqACalbR1z
   bHOPrsVJ97OLvy0MLvK6EHV41GsosqqHTXl/Rtd+K4hh+L5kVFg0MLMLA
   ykRkPm850ZSr4OYC51w2xMxT1DuN6uG01y1y4C4BBV4s5lZGZp4hk2VhS
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="254398554"
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="254398554"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 05:23:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="612153648"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 11 Mar 2022 05:23:05 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSfEX-0006Sh-18; Fri, 11 Mar 2022 13:23:05 +0000
Date:   Fri, 11 Mar 2022 21:22:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     kbuild-all@lists.01.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] tracing: Add snapshot at end of kernel boot up
Message-ID: <202203112151.vHjFh9wP-lkp@intel.com>
References: <20220310214133.0e58e321@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310214133.0e58e321@gandalf.local.home>
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

Hi Steven,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on rostedt-trace/for-next]
[also build test WARNING on linux/master hnaz-mm/master linus/master v5.17-rc7 next-20220310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Steven-Rostedt/tracing-Add-snapshot-at-end-of-kernel-boot-up/20220311-104216
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git for-next
config: xtensa-buildonly-randconfig-r002-20220310 (https://download.01.org/0day-ci/archive/20220311/202203112151.vHjFh9wP-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/60ed6397c93a264f9ccbc8a6ca0b3ecc4dfdf6da
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Steven-Rostedt/tracing-Add-snapshot-at-end-of-kernel-boot-up/20220311-104216
        git checkout 60ed6397c93a264f9ccbc8a6ca0b3ecc4dfdf6da
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0x7c164): Section mismatch in reference from the function __se_sys_delete_module() to the function .init.text:ftrace_boot_snapshot()
The function __se_sys_delete_module() references
the function __init ftrace_boot_snapshot().
This is often because __se_sys_delete_module lacks a __init
annotation or the annotation of ftrace_boot_snapshot is wrong.

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
