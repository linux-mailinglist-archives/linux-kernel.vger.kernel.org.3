Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904D45777DA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 20:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiGQS5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 14:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiGQS5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 14:57:06 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045FB101F9;
        Sun, 17 Jul 2022 11:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658084226; x=1689620226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mTiA/vrtq0gwBE8+IY0vEqWFd+SHutRTRDePbcfSerA=;
  b=WVKRwQd9TMYt2gYxCZKH251kCK7/OKtn02wpjYIncwmfPsmW17dtfmDe
   ye/k8LyAv5wCc4JtIBt/Tw6Mo/egUCHJZOy24uvndF6cqy8Q0U8Kkq2R9
   /iDcavpYmcVZ8u5+9H41oPZQSniCnDTK0D5tzHvTxpL/6jLop/qrCTVu+
   aeqZgJsTe9bFhgKioepbJTZON0Xi0/G+ZvghbIBxKn0x8JFeO1tarE8gW
   e4GAfJm69DTGs4aJMcfgAkZz5QYnwqF20V3I/WQYMp959FoQe7ncJg2Rk
   gnhtmLdT0RaV78L29JYW2Pz6aKfT613QgL6U2I7TAZK0TZXd+uWPhkmYh
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="265868014"
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="265868014"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 11:57:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="597025744"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 17 Jul 2022 11:57:00 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oD9Rr-0003ao-R6;
        Sun, 17 Jul 2022 18:56:59 +0000
Date:   Mon, 18 Jul 2022 02:56:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     kbuild-all@lists.01.org,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Tao Zhou <tao.zhou@linux.dev>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH V5 02/16] rv: Add runtime reactors interface
Message-ID: <202207180241.ovP1XE48-lkp@intel.com>
References: <4a66bc1c858b0a11750321696333d897677eff6b.1657745645.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a66bc1c858b0a11750321696333d897677eff6b.1657745645.git.bristot@kernel.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

I love your patch! Perhaps something to improve:

[auto build test WARNING on rostedt-trace/for-next]
[also build test WARNING on tip/sched/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Bristot-de-Oliveira/The-Runtime-Verification-RV-interface/20220714-052220
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git for-next
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20220718/202207180241.ovP1XE48-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/aa2ae8ed1dd28e5df7022e89ed27a9a5283647d9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daniel-Bristot-de-Oliveira/The-Runtime-Verification-RV-interface/20220714-052220
        git checkout aa2ae8ed1dd28e5df7022e89ed27a9a5283647d9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/misc/lkdtm/ kernel/trace/rv/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> kernel/trace/rv/rv_reactors.c:73:1: sparse: sparse: symbol 'rv_reactors_list' was not declared. Should it be static?
>> kernel/trace/rv/rv_reactors.c:451:19: sparse: sparse: symbol 'rv_nop' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
