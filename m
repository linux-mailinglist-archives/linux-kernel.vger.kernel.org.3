Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783FA49EB29
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 20:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239931AbiA0TjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 14:39:13 -0500
Received: from mga05.intel.com ([192.55.52.43]:34274 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229639AbiA0TjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 14:39:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643312352; x=1674848352;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=K8TsweYnEBuPUmpbQF/V+mUt3gLgV/uS+4rbemKBr0g=;
  b=Bg4F9KLm0QOhga2dDiVh1sDGjXID7amOOv9jyHmU28VnxHSLBNsXZdCq
   eecE7rnSU/+Z19zQ9ugTwdX5BqJp0lWdXOcPfCXJfRsI+PivSnKKhPElA
   Ip1MqmryS2yLJBDqiBGoU62lAWa24jwalD3/empiAyJ9ix3WOtRAKEPhR
   /7phUrR1GQtEB18iP0xrLhHiakeZ+R2tI3sx0zpmPI0hVlBHKpZdhZOpn
   jVASBTqDmbeZVNbBbUeBNbKYoRKciTzt8MqG66sHxmIR5J8eF20hx7XGv
   WsGqLzdxzQpvmxHexsZRXQip+0hESxJE9ekPEkbUwWgoOaN8O+EXWUVKy
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="333301866"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="333301866"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 11:39:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="480431704"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 27 Jan 2022 11:39:10 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDAbu-000Mxz-1H; Thu, 27 Jan 2022 19:39:10 +0000
Date:   Fri, 28 Jan 2022 03:39:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [davidhildenbrand:single_zone 4/4] drivers/base/memory.c:648:14:
 warning: no previous prototype for 'early_node_zone_for_memory_block'
Message-ID: <202201280300.xX8fHtiK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://github.com/davidhildenbrand/linux single_zone
head:   176a3d535903312944f7489127f520c5494bc810
commit: 176a3d535903312944f7489127f520c5494bc810 [4/4] tmp
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220128/202201280300.xX8fHtiK-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/davidhildenbrand/linux/commit/176a3d535903312944f7489127f520c5494bc810
        git remote add davidhildenbrand git://github.com/davidhildenbrand/linux
        git fetch --no-tags davidhildenbrand single_zone
        git checkout 176a3d535903312944f7489127f520c5494bc810
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/base/memory.c:648:14: warning: no previous prototype for 'early_node_zone_for_memory_block' [-Wmissing-prototypes]
     648 | struct zone *early_node_zone_for_memory_block(int nid, struct memory_block *mem)
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/early_node_zone_for_memory_block +648 drivers/base/memory.c

   647	
 > 648	struct zone *early_node_zone_for_memory_block(int nid, struct memory_block *mem)
   649	{
   650		const unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
   651		const unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
   652	
   653		struct zone *zone, *matching_zone = NULL;
   654		pg_data_t *pgdat = NODE_DATA(nid);
   655		int i;
   656	
   657		/*
   658		 * This logic only works for early memory, when the applicable zones
   659		 * already span the memory block. We don't expect overlapping zones on
   660		 * a single node for early memory. So if we're told that some pfns
   661		 * of a node fall into this memory block, we can assume that all node
   662		 * zones that intersect with the memory block are actually applicable.
   663		 * No need to look at the memmap.
   664		 *
   665		 * Memory hot(un)plug updates the zone manually after memory
   666		 * onlinig/offlining succeed.
   667		 */
   668		for (i = 0; i < MAX_NR_ZONES; i++) {
   669			zone = pgdat->node_zones + i;
   670			if (!populated_zone(zone))
   671				continue;
   672			if (!zone_intersects(zone, start_pfn, nr_pages))
   673				continue;
   674			if (!matching_zone) {
   675				matching_zone = zone;
   676				continue;
   677			}
   678			/* Spans multiple zones ... */
   679			matching_zone = NULL;
   680			break;
   681		}
   682		return matching_zone;
   683	}
   684	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
