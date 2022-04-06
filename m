Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BF74F61E7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbiDFOUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235792AbiDFOTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:19:05 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44131DEC2A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 19:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649212967; x=1680748967;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XqZiME2WI/xF09uZoYLGxX4vJjPqXlqi0xTQO1zAkVo=;
  b=It20CEUDRw+DziUT5eySlzw+xryTC4OvuJnmBJE70fla5rIix18dFuOJ
   D8WJDHEFUB5QbuKERqdfSzcJo0N78XI6WnMXgX8z7vs3ZwcDx6X5K+ue4
   B+4KOpCx8QUlFCJ3ivaVUlhnn9FElcYXJ6tbG27gVjD7QKXA34oe80HZy
   3UH8IdlumdJQg88m5i9I/6zNhZEWwP80haRnrhljWIBogqYCNfo9zpYbB
   ZL6n5N1mwuPbHd+zCRqGkMu7AVQdAWtq/QHuceGER5vN5vberMrjbpch+
   Dao6DEj466EIuTu0GVkqKwFZqBLvc9wIZxoa1gYfab/UBO3RvDlSjChfQ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="260926160"
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="260926160"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 19:42:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="523739696"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 05 Apr 2022 19:42:46 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbvd7-000400-FO;
        Wed, 06 Apr 2022 02:42:45 +0000
Date:   Wed, 6 Apr 2022 10:42:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Omar Sandoval <osandov@fb.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [hnaz-mm:master 16/188] mm/vmalloc.c:1747:6: warning: no previous
 prototype for 'iounmap_purge_vmap_area'
Message-ID: <202204061005.jSc4B5gA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/hnaz/linux-mm master
head:   71e0d841ccd1c91e7038d385825e26342e87d198
commit: 56de161065643707f3a3a0fd0cc2c9e747148eae [16/188] mm/vmalloc: fix spinning drain_vmap_work after reading from /proc/vmcore
config: um-x86_64_defconfig (https://download.01.org/0day-ci/archive/20220406/202204061005.jSc4B5gA-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/hnaz/linux-mm/commit/56de161065643707f3a3a0fd0cc2c9e747148eae
        git remote add hnaz-mm https://github.com/hnaz/linux-mm
        git fetch --no-tags hnaz-mm master
        git checkout 56de161065643707f3a3a0fd0cc2c9e747148eae
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/vmalloc.c:1747:6: warning: no previous prototype for 'iounmap_purge_vmap_area' [-Wmissing-prototypes]
    1747 | void iounmap_purge_vmap_area(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~


vim +/iounmap_purge_vmap_area +1747 mm/vmalloc.c

  1744	
  1745	#ifdef CONFIG_X86_64
  1746	/* Called after iounmap() to immediately free vm_area_struct's. */
> 1747	void iounmap_purge_vmap_area(void)
  1748	{
  1749		mutex_lock(&vmap_purge_lock);
  1750		__purge_vmap_area_lazy(ULONG_MAX, 0);
  1751		mutex_unlock(&vmap_purge_lock);
  1752	}
  1753	#endif /* CONFIG_X86_64 */
  1754	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
