Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B155AA71A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 07:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbiIBEtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 00:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiIBEtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 00:49:05 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91197B2746
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 21:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662094144; x=1693630144;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uWWeTrRXwjpOrChuGrhJNnY+K0/3p8HKfIFEywc8td8=;
  b=G+hJLXTbb24RCdJKYnfQtSA6eBgaAew37siGUiDyCOWAyfyVsxKfsTNG
   M8RijBCD9g56oJslQ0hGgqS4W0K6Crskg9Oa0dRraEmc39iEhN1OSB3C4
   C6qHwIVAJqASNb0tS+cvJha2Llx+XFJxafZmtxkDdkQR0SY1byFfVA5+v
   e6HkAuwqexPvX86h7rQXfRlkuS3kBCZTTixM4ntx8TEywcniERuy/DKjM
   uS6yKgU+vvKLC7ZeWSXzGrPqbG9Z+1dqUp63DPbXruZ5Ct6LDCzOQgFhF
   n0+VaVdPp6xBQMw91TsIOAVuI7iqW4b6jxJ7/kMQ5NrHspluxP/meCdSR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="293470181"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="293470181"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 21:49:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="645960524"
Received: from lkp-server02.sh.intel.com (HELO fccc941c3034) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 01 Sep 2022 21:48:59 -0700
Received: from kbuild by fccc941c3034 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTybz-00009b-0G;
        Fri, 02 Sep 2022 04:48:59 +0000
Date:   Fri, 2 Sep 2022 12:48:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Muchun Song <songmuchun@bytedance.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, osalvador@suse.de, david@redhat.com,
        ying.huang@intel.com, aneesh.kumar@linux.ibm.com,
        rientjes@google.com
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: hugetlb: eliminate memory-less nodes handling
Message-ID: <202209021255.1ChhyCsl-lkp@intel.com>
References: <20220901083023.42319-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901083023.42319-1-songmuchun@bytedance.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Muchun,

I love your patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Muchun-Song/mm-hugetlb-eliminate-memory-less-nodes-handling/20220901-163132
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: loongarch-buildonly-randconfig-r004-20220901 (https://download.01.org/0day-ci/archive/20220902/202209021255.1ChhyCsl-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/8e3d203cb06be81565d117b3f6d5e279a833174c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Muchun-Song/mm-hugetlb-eliminate-memory-less-nodes-handling/20220901-163132
        git checkout 8e3d203cb06be81565d117b3f6d5e279a833174c
        # save the config file
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 ARCH=loongarch 

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/base/node.c: In function 'register_node':
>> drivers/base/node.c:614:17: error: implicit declaration of function 'hugetlb_register_node'; did you mean 'unregister_node'? [-Werror=implicit-function-declaration]
     614 |                 hugetlb_register_node(node);
         |                 ^~~~~~~~~~~~~~~~~~~~~
         |                 unregister_node
   drivers/base/node.c: In function 'unregister_node':
>> drivers/base/node.c:630:9: error: implicit declaration of function 'hugetlb_unregister_node'; did you mean 'unregister_node'? [-Werror=implicit-function-declaration]
     630 |         hugetlb_unregister_node(node);
         |         ^~~~~~~~~~~~~~~~~~~~~~~
         |         unregister_node
   cc1: some warnings being treated as errors


vim +614 drivers/base/node.c

   594	
   595	/*
   596	 * register_node - Setup a sysfs device for a node.
   597	 * @num - Node number to use when creating the device.
   598	 *
   599	 * Initialize and register the node device.
   600	 */
   601	static int register_node(struct node *node, int num)
   602	{
   603		int error;
   604	
   605		node->dev.id = num;
   606		node->dev.bus = &node_subsys;
   607		node->dev.release = node_device_release;
   608		node->dev.groups = node_dev_groups;
   609		error = device_register(&node->dev);
   610	
   611		if (error) {
   612			put_device(&node->dev);
   613		} else {
 > 614			hugetlb_register_node(node);
   615			compaction_register_node(node);
   616		}
   617	
   618		return error;
   619	}
   620	
   621	/**
   622	 * unregister_node - unregister a node device
   623	 * @node: node going away
   624	 *
   625	 * Unregisters a node device @node.  All the devices on the node must be
   626	 * unregistered before calling this function.
   627	 */
   628	void unregister_node(struct node *node)
   629	{
 > 630		hugetlb_unregister_node(node);
   631		compaction_unregister_node(node);
   632		node_remove_accesses(node);
   633		node_remove_caches(node);
   634		device_unregister(&node->dev);
   635	}
   636	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
