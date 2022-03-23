Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8524E5B0C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 23:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345128AbiCWWId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 18:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238850AbiCWWI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 18:08:27 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92FA5C657;
        Wed, 23 Mar 2022 15:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648073216; x=1679609216;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5s1qopCxdkYmFefmU0dSFgayuEQVpBsi4yLTT+cXSbo=;
  b=Zb9baPiT4nu9ikiih2Hqo/FzfGstbbvXm6MefxkhdhjhriUdSQTV0xjr
   FR1pBX24AOzLaDiubz6bwOL4VAqRB0qpMYFjUMQmPTKzmJoHVtSRMeUF4
   qe3zOM8VY9fGKpWM8B0hbdE4PB+uzvrBcVfgN8fZax9tQzrMqK53H9h4n
   +gzXPHXm5uDjhFP7jHZECw/IWG+7QyldCHM1mbDyaNb839V731chGi5jF
   qBs4bX77Kvg/ZShbsGaj7U3TDmwm1u59hs8dNJX5AURpTnyd/OlMrc8J0
   Z9CREzWUMQOrH4gNG7Vb5P9qmnG4eTQFnUctcwnkjwF9jYMhFiA9SI/3y
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="245712689"
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="245712689"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 15:06:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="693101127"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 23 Mar 2022 15:06:52 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nX980-000KPK-9L; Wed, 23 Mar 2022 22:06:52 +0000
Date:   Thu, 24 Mar 2022 06:06:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com
Cc:     kbuild-all@lists.01.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v5 1/4] mm: hugetlb_vmemmap: introduce
 STRUCT_PAGE_SIZE_IS_POWER_OF_2
Message-ID: <202203240546.MHJzsBaO-lkp@intel.com>
References: <20220323125523.79254-2-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323125523.79254-2-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Muchun,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hnaz-mm/master]
[also build test ERROR on linus/master next-20220323]
[cannot apply to mcgrof/sysctl-next v5.17]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Muchun-Song/add-hugetlb_free_vmemmap-sysctl/20220323-205902
base:   https://github.com/hnaz/linux-mm master
config: arc-randconfig-r043-20220323 (https://download.01.org/0day-ci/archive/20220324/202203240546.MHJzsBaO-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/64211be650af117819368a26d7b86c33df5deea4
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Muchun-Song/add-hugetlb_free_vmemmap-sysctl/20220323-205902
        git checkout 64211be650af117819368a26d7b86c33df5deea4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> cc1: fatal error: cannot open 'kernel/bounds.s' for writing: No such file or directory
   compilation terminated.
   make[2]: *** [scripts/Makefile.build:127: kernel/bounds.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1261: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:226: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
