Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD804E5CA6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 02:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347128AbiCXBNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 21:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347157AbiCXBM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 21:12:57 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECB591AF4;
        Wed, 23 Mar 2022 18:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648084287; x=1679620287;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x9Y+ZVR9L2dUK89RM1SaeuSyuI0EqbEz3AxQWL4lxVg=;
  b=QUxw/mTSBTzDNbhCQt72jEWJi0SGuTwg2N3idzrsLGQMd7BY1HFKQJ9i
   Y4BL7PZJlHoE0LuPYWBamc1LLeEsfWXvqcc+yu7KptAqfUg4zhUzz5UA8
   wUQyr8Ufaz7ppF6c0vu4C8k6B86wOxxYCBOXbYU5X7sUfgKeME/a0EjvJ
   KAJkF5i9xcndMkva6QbZDzmEgKNOmF8tPDoE6uinSatIZcgvXhmUMvr/a
   KIG5WAQkAs5Kx4IpJD7b/Yja3nsvPmSEG2fNW/eWFUhlByJEnU2WGw0g4
   SD++Bmx+5G/k9FW8hrqzbfdZpmvFAzkndxLW6JQFfJjDX6qx0QEvH5oMZ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="238863984"
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="238863984"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 18:11:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="637678469"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Mar 2022 18:11:23 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXC0Y-000KXd-RV; Thu, 24 Mar 2022 01:11:22 +0000
Date:   Thu, 24 Mar 2022 09:11:10 +0800
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
Message-ID: <202203240912.6ZaeXSiH-lkp@intel.com>
References: <20220323125523.79254-2-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323125523.79254-2-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220324/202203240912.6ZaeXSiH-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/64211be650af117819368a26d7b86c33df5deea4
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Muchun-Song/add-hugetlb_free_vmemmap-sysctl/20220323-205902
        git checkout 64211be650af117819368a26d7b86c33df5deea4
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> cc1: fatal error: can't open 'kernel/bounds.s' for writing: No such file or directory
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
