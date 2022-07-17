Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB945778E7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 01:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiGQXxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 19:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGQXxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 19:53:11 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36A610FF0;
        Sun, 17 Jul 2022 16:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658101990; x=1689637990;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9pF+52u5sIt8iKnb9u1XPMvY1nWRTKK736yt0w7idas=;
  b=Uz1ZdOEWU1ks6zZDlYQyoiUF22njluq3RLkEUgfWOYU8pEF18XMvcn0A
   I/W/7CvOH3idi0Vsiywpdb+9+imlZzP02iEEN5t6GiKQGd6T+HkyDw4v8
   EipJKRncXZ0eWgxUB8Y0KDStidoH1GwmTFDYzhIosUh6x73TN1BOeMxU/
   VpslscMRGEoQGrjDDsERwvQvv0nctdVHRUXJgb9xQ1HxYia2MzAtgxk4s
   oM7DmHPwS8OojH4vGw6CTMxQn5PGBQKBqZQJ2TAw9LoRo/9ewHWPBnwSI
   cc2e0dcXPRh7mJVXEDj7vfvYFiO24SgWnac29LMCu9ZOif99ZttlXhdBk
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="287245441"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="287245441"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 16:53:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="594283394"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 17 Jul 2022 16:53:05 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDE4O-0003o3-FB;
        Sun, 17 Jul 2022 23:53:04 +0000
Date:   Mon, 18 Jul 2022 07:52:21 +0800
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
Subject: Re: [PATCH V5 15/16] rv/reactor: Add the printk reactor
Message-ID: <202207180703.hiH5bbyO-lkp@intel.com>
References: <5fcf3d21b51bc4c1a6d2968cfd0c60fdbc1d471b.1657745645.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fcf3d21b51bc4c1a6d2968cfd0c60fdbc1d471b.1657745645.git.bristot@kernel.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20220718/202207180703.hiH5bbyO-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/d1746223447deb1d1646f968512a065a1cd63a9c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daniel-Bristot-de-Oliveira/The-Runtime-Verification-RV-interface/20220714-052220
        git checkout d1746223447deb1d1646f968512a065a1cd63a9c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/misc/lkdtm/ kernel/trace/rv/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> kernel/trace/rv/reactor_printk.c:20:19: sparse: sparse: symbol 'rv_printk' was not declared. Should it be static?
>> kernel/trace/rv/reactor_printk.c:26:5: sparse: sparse: symbol 'register_react_printk' was not declared. Should it be static?
>> kernel/trace/rv/reactor_printk.c:32:6: sparse: sparse: symbol 'unregister_react_printk' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
