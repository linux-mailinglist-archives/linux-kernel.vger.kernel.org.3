Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8294751C4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 05:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbhLOErs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 23:47:48 -0500
Received: from mga02.intel.com ([134.134.136.20]:45635 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhLOErs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 23:47:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639543668; x=1671079668;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1uW5QOngP5WpnCI+sY0Rq/P1SHaeRBfR2R49hTMmOjM=;
  b=OzXsJSDWQU4CCFQK5DbkqC9tEwahy6l8FrodhFGXbIOk/AZVWm5pBM9k
   6faYDbZKn7P2o4OreZyxKzQVWuGTV0O7yfDaAdenE1CLo88CyIfESNP64
   by530yyZDm1VXiqb1BqFaC/d07pBNCCm/P1KuCcNIQvR+PKIhla+1VbUv
   amvGSJ6bV7vpA7MqS5ceenUXNUBUtF8t6z3kwDtNpbpKib65BqD8aq8Qc
   9ROpxgEvASHerk4gE5AR8j5libxc8HJm2h0kD9xy1/H/qxjgjH9P+y0k1
   TGcZhlcd0lz0ZQqHBcWRRxlLyYu9vAX0v53khlUqLar8wiMlFQdxCN4e1
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="226427109"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="226427109"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 20:47:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="482252121"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 14 Dec 2021 20:47:44 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxMCe-0001Ge-6T; Wed, 15 Dec 2021 04:47:44 +0000
Date:   Wed, 15 Dec 2021 12:47:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Alexey Makhalov <amakhalov@vmware.com>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux-foundation.org>
Subject: Re: [PATCH v2 2/4] mm: handle uninitialized numa nodes gracefully
Message-ID: <202112151219.xAI8NaQR-lkp@intel.com>
References: <20211214100732.26335-3-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214100732.26335-3-mhocko@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

I love your patch! Perhaps something to improve:

[auto build test WARNING on hnaz-mm/master]

url:    https://github.com/0day-ci/linux/commits/Michal-Hocko/mm-memory_hotplug-make-arch_alloc_nodedata-independent-on-CONFIG_MEMORY_HOTPLUG/20211214-190817
base:   https://github.com/hnaz/linux-mm master
config: ia64-defconfig (https://download.01.org/0day-ci/archive/20211215/202112151219.xAI8NaQR-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/65c560a3ac2561750c1dc71213f042e660b9bbc0
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Michal-Hocko/mm-memory_hotplug-make-arch_alloc_nodedata-independent-on-CONFIG_MEMORY_HOTPLUG/20211214-190817
        git checkout 65c560a3ac2561750c1dc71213f042e660b9bbc0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0x566a2): Section mismatch in reference from the function arch_alloc_nodedata() to the function .init.text:memblock_alloc_try_nid()
The function arch_alloc_nodedata() references
the function __init memblock_alloc_try_nid().
This is often because arch_alloc_nodedata lacks a __init
annotation or the annotation of memblock_alloc_try_nid is wrong.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
