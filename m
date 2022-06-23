Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65228557A92
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 14:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbiFWMoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 08:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiFWMom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:44:42 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052713CFD3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 05:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655988280; x=1687524280;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FieWEyT/caqjNhcMBknVB9mXgAFMFFEzfYIMC7+krtA=;
  b=mN0oyuLFOr7BI/R4cQxUXUaXXcXuWcFpxUOeB+3k5JJ8TtwWpKlmb0lK
   k6GLerOuSN1PwM9K7/vhB8zDqULu9PjlOaDYipsE7jmgocTNguxjZmecp
   mUa2GOeY2v1f024HXqFZsNnq645Tl30nYozHSZc/LpvPt7ntyz2Sv8lvQ
   fDrFlgLFoji5zJVc6op3Qussb+A/DX3+KwTIN6AnSi7rn51pB1Hil53g3
   CL+7feFec+BBMgfWpi8KE/pbat2BvYXrHpe26UfjCdSKomNR9AiVHaFWj
   OL3qBNkHVLznjdRRVLCxhys3SBqZ2Ydf+t/0bU2PYsjFf54I9GjEyjs3L
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="306167615"
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="306167615"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 05:44:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="730838473"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jun 2022 05:44:38 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4MCM-0001GJ-5B;
        Thu, 23 Jun 2022 12:44:38 +0000
Date:   Thu, 23 Jun 2022 20:44:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, Ben Widawsky <bwidawsk@kernel.org>
Subject: [cxl:preview 41/49] kernel/resource.c:1823:25: warning: variable
 'res' is uninitialized when used within its own initialization
Message-ID: <202206232003.bjvwazsK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git preview
head:   b2d4fd5c97b59f622e6c45ac51020cdcd66bb022
commit: 96ec07f789bf8a52f5c00d3310d9b7ec4c701738 [41/49] cxl/region: Allocate host physical address (HPA) capacity to new regions
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220623/202206232003.bjvwazsK-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 46be5faaf03466c3751f8a2882bef5a217e15926)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=96ec07f789bf8a52f5c00d3310d9b7ec4c701738
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl preview
        git checkout 96ec07f789bf8a52f5c00d3310d9b7ec4c701738
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/resource.c:1823:25: warning: variable 'res' is uninitialized when used within its own initialization [-Wuninitialized]
           struct resource *res = res;
                            ~~~   ^~~
   1 warning generated.


vim +/res +1823 kernel/resource.c

6f2443c3ffee66 Dan Williams 2022-05-20  1820  
6f2443c3ffee66 Dan Williams 2022-05-20  1821  static void remove_free_mem_region(void *_res)
6f2443c3ffee66 Dan Williams 2022-05-20  1822  {
6f2443c3ffee66 Dan Williams 2022-05-20 @1823  	struct resource *res = res;
6f2443c3ffee66 Dan Williams 2022-05-20  1824  
6f2443c3ffee66 Dan Williams 2022-05-20  1825  	if (res->parent)
6f2443c3ffee66 Dan Williams 2022-05-20  1826  		remove_resource(res);
6f2443c3ffee66 Dan Williams 2022-05-20  1827  	free_resource(res);
6f2443c3ffee66 Dan Williams 2022-05-20  1828  }
6f2443c3ffee66 Dan Williams 2022-05-20  1829  

:::::: The code at line 1823 was first introduced by commit
:::::: 6f2443c3ffee6675ef14a4b1256400a9c8a652ca resource: Introduce alloc_free_mem_region()

:::::: TO: Dan Williams <dan.j.williams@intel.com>
:::::: CC: Dan Williams <dan.j.williams@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
