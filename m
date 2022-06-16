Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0309754E5DE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377573AbiFPPUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbiFPPUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:20:09 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7725D344FA;
        Thu, 16 Jun 2022 08:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655392808; x=1686928808;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9GFnmtQhesbFhhI0eu3wSxeKy81JLBgTOD42fl56qpI=;
  b=JEW6yD50IZIDv9HeKAhilIvU9jCu8in+F3PrbAhi8rYSvHErin/qG6Cl
   m+F91NqpgDYfwOEZl6HnTl5qPlYW7FDtVvEs48IsAPdoxB1yQYgX5JQ00
   Go9KNJf1xfTYbYjFARb79XcZE+wsycLFh5Q/SdUqtxTRxwSm5MX+EhYt3
   xZrznowtEFN2Anij6/B/gxgEzT9wBBVDgjdPkk5P7TRXwAbEnZt6yAGIj
   wdYClxUDpektpMuyePlMh/MTPWLNqWuuqnWiKiB929X0ThPOCq/IKIIet
   z98UhDxlf+C1CN64C+JYJXVrEUmC5m+a71Vpt1ZPw7hj5V869V4S0vzE0
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="259733613"
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="259733613"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 08:20:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="653200801"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 16 Jun 2022 08:20:04 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1rHv-000OUJ-JV;
        Thu, 16 Jun 2022 15:20:03 +0000
Date:   Thu, 16 Jun 2022 23:20:00 +0800
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
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH V4 13/20] rv/reactor: Add the panic reactor
Message-ID: <202206162325.aggB6gj9-lkp@intel.com>
References: <67e522ab57e64eee313af508a8c70f3cce33e525.1655368610.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e522ab57e64eee313af508a8c70f3cce33e525.1655368610.git.bristot@kernel.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Bristot-de-Oliveira/The-Runtime-Verification-RV-interface/20220616-164837
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git for-next
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220616/202206162325.aggB6gj9-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/c32f84c1978c0e0b8526da45a2ab87e191246f68
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daniel-Bristot-de-Oliveira/The-Runtime-Verification-RV-interface/20220616-164837
        git checkout c32f84c1978c0e0b8526da45a2ab87e191246f68
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/trace/rv/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/trace/rv/reactor_panic.c:28:5: warning: no previous prototype for 'register_react_panic' [-Wmissing-prototypes]
      28 | int register_react_panic(void)
         |     ^~~~~~~~~~~~~~~~~~~~
>> kernel/trace/rv/reactor_panic.c:34:6: warning: no previous prototype for 'unregister_react_panic' [-Wmissing-prototypes]
      34 | void unregister_react_panic(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~


vim +/register_react_panic +28 kernel/trace/rv/reactor_panic.c

    27	
  > 28	int register_react_panic(void)
    29	{
    30		rv_register_reactor(&rv_panic);
    31		return 0;
    32	}
    33	
  > 34	void unregister_react_panic(void)
    35	{
    36		rv_unregister_reactor(&rv_panic);
    37	}
    38	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
