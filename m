Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D021A47CAAE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 02:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240622AbhLVBT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 20:19:26 -0500
Received: from mga12.intel.com ([192.55.52.136]:18849 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240545AbhLVBTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 20:19:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640135964; x=1671671964;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vtS7ouF3TOFWRpidAt0aRiMo+56z6XAZqUDoj4bu7+0=;
  b=ncacJ2zcoNWlntBlv19wL7MNSfAOx8RJUec9pZ57qYAW99LY71vvSVy9
   0vMVcbo98tyPeL5F+n+f6ex1tFKOO4I4R947KwDX7E6vMUXwyv/KuRYo6
   7Y0C/3WTV4kVqaUiJ82derC8y62fNGZ7IDWWs+6ICikbl2Qn16TWBM8Sc
   +KEB19UIBunoqcu3flqRuFeRc4NJkdV852QJ7qcuIDDSVcWquvfBXoyah
   9MCRFZMjLGtWniXQhgVhGTg2H/hkjcWQlP0edq/LYJ9F0S0ZU2i0jIODi
   IOLAsFvtOZskJqTeK05rtro5TmTq83ZwHiBzEiOPWdUX5+MgbdRkAP6Og
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="220533439"
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="220533439"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 17:19:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="613659873"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 21 Dec 2021 17:19:22 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzqHq-0009kS-5v; Wed, 22 Dec 2021 01:19:22 +0000
Date:   Wed, 22 Dec 2021 09:19:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        bristot@kernel.org, luto@kernel.org
Subject: Re: [PATCH] trace: Fix check for trace_percpu_buffer validity in
 get_trace_buf()
Message-ID: <202112220904.4XhObpcQ-lkp@intel.com>
References: <20211221162529.1480652-1-naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221162529.1480652-1-naveen.n.rao@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Naveen,

I love your patch! Perhaps something to improve:

[auto build test WARNING on f7f0bb5eaecb1aff9cc8ab13425d43690b71ec44]

url:    https://github.com/0day-ci/linux/commits/Naveen-N-Rao/trace-Fix-check-for-trace_percpu_buffer-validity-in-get_trace_buf/20211222-002823
base:   f7f0bb5eaecb1aff9cc8ab13425d43690b71ec44
config: x86_64-randconfig-s021-20211219 (https://download.01.org/0day-ci/archive/20211222/202112220904.4XhObpcQ-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/95971333cdb4ace06eb41bd7ca1dee65f77487d2
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Naveen-N-Rao/trace-Fix-check-for-trace_percpu_buffer-validity-in-get_trace_buf/20211222-002823
        git checkout 95971333cdb4ace06eb41bd7ca1dee65f77487d2
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/trace/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   kernel/trace/trace.c:392:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct trace_export **list @@     got struct trace_export [noderef] __rcu ** @@
   kernel/trace/trace.c:392:28: sparse:     expected struct trace_export **list
   kernel/trace/trace.c:392:28: sparse:     got struct trace_export [noderef] __rcu **
   kernel/trace/trace.c:406:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct trace_export **list @@     got struct trace_export [noderef] __rcu ** @@
   kernel/trace/trace.c:406:33: sparse:     expected struct trace_export **list
   kernel/trace/trace.c:406:33: sparse:     got struct trace_export [noderef] __rcu **
   kernel/trace/trace.c:2836:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct event_filter *filter @@     got struct event_filter [noderef] __rcu *filter @@
   kernel/trace/trace.c:2836:38: sparse:     expected struct event_filter *filter
   kernel/trace/trace.c:2836:38: sparse:     got struct event_filter [noderef] __rcu *filter
   kernel/trace/trace.c:3244:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct trace_buffer_struct *buffers @@     got struct trace_buffer_struct [noderef] __percpu * @@
   kernel/trace/trace.c:3244:17: sparse:     expected struct trace_buffer_struct *buffers
   kernel/trace/trace.c:3244:17: sparse:     got struct trace_buffer_struct [noderef] __percpu *
>> kernel/trace/trace.c:3248:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct trace_buffer_struct [noderef] __percpu *static [toplevel] trace_percpu_buffer @@     got struct trace_buffer_struct *buffers @@
   kernel/trace/trace.c:3248:29: sparse:     expected struct trace_buffer_struct [noderef] __percpu *static [toplevel] trace_percpu_buffer
   kernel/trace/trace.c:3248:29: sparse:     got struct trace_buffer_struct *buffers
   kernel/trace/trace.c:346:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace.c:346:9: sparse:    struct trace_export [noderef] __rcu *
   kernel/trace/trace.c:346:9: sparse:    struct trace_export *
   kernel/trace/trace.c:361:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace.c:361:9: sparse:    struct trace_export [noderef] __rcu *
   kernel/trace/trace.c:361:9: sparse:    struct trace_export *

vim +3248 kernel/trace/trace.c

07d777fe8c3985 Steven Rostedt          2011-09-22  3236  
07d777fe8c3985 Steven Rostedt          2011-09-22  3237  static int alloc_percpu_trace_buffer(void)
07d777fe8c3985 Steven Rostedt          2011-09-22  3238  {
07d777fe8c3985 Steven Rostedt          2011-09-22  3239  	struct trace_buffer_struct *buffers;
07d777fe8c3985 Steven Rostedt          2011-09-22  3240  
38ce2a9e33db61 Steven Rostedt (VMware  2020-08-06  3241) 	if (trace_percpu_buffer)
38ce2a9e33db61 Steven Rostedt (VMware  2020-08-06  3242) 		return 0;
38ce2a9e33db61 Steven Rostedt (VMware  2020-08-06  3243) 
07d777fe8c3985 Steven Rostedt          2011-09-22  3244  	buffers = alloc_percpu(struct trace_buffer_struct);
24589e3a20876d Steven Rostedt (VMware  2020-01-25  3245) 	if (MEM_FAIL(!buffers, "Could not allocate percpu trace_printk buffer"))
e2ace001176dc9 Andy Lutomirski         2016-05-26  3246  		return -ENOMEM;
07d777fe8c3985 Steven Rostedt          2011-09-22  3247  
07d777fe8c3985 Steven Rostedt          2011-09-22 @3248  	trace_percpu_buffer = buffers;
07d777fe8c3985 Steven Rostedt          2011-09-22  3249  	return 0;
07d777fe8c3985 Steven Rostedt          2011-09-22  3250  }
07d777fe8c3985 Steven Rostedt          2011-09-22  3251  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
