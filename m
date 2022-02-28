Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DC64C752D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 18:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239009AbiB1RwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 12:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238490AbiB1Rpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:45:32 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D880D43EDE;
        Mon, 28 Feb 2022 09:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646069870; x=1677605870;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YtFAYAFND6XX0wPXuY5rYg2LX5oHVkQyEKvx0qDeeZw=;
  b=egAxhoxCfkCRjZgJUphGW24wumXkeyy8zvBgtHJM+7cr4GvaBRyIL0k8
   2qpj8YbhBG744LJMzSA2JLpMkuk5tiuqsIykRWYgYvOfn85SJRyksERwS
   JjaXiz4uV7Ih+VajWcZsxLK84xCXmEagsgWcRAtA4Gct7fYpG1Lo0xmJb
   bN6xAgoObcxfjdXM5sedxC/IzR0yevGyMknajTZj29lJ/miBq9qbdQuJ8
   MIrr13KZ4aJK6R2+XmjU1MWQYizQHza02ZNAvOVzBsoILv+RiPYUW0p12
   sPdQT+hqBHVqW5WDRyLudYQgikq6M+hLGmdQdGvAQjspTKeWeVPo3BBuy
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="316154512"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="316154512"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 09:37:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="608524901"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 28 Feb 2022 09:37:15 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOjxS-0007cY-Mj; Mon, 28 Feb 2022 17:37:14 +0000
Date:   Tue, 1 Mar 2022 01:37:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Cc:     kbuild-all@lists.01.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH 3/3] mm: hugetlb: add hugetlb_free_vmemmap sysctl
Message-ID: <202203010141.TqyZvdm5-lkp@intel.com>
References: <20220228071022.26143-4-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228071022.26143-4-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
[also build test ERROR on next-20220225]
[cannot apply to mcgrof/sysctl-next linus/master v5.17-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Muchun-Song/add-hugetlb_free_vmemmap-sysctl/20220228-151303
base:   https://github.com/hnaz/linux-mm master
config: x86_64-randconfig-c022 (https://download.01.org/0day-ci/archive/20220301/202203010141.TqyZvdm5-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/a2a3193fd949ff24ed0c138ef495e67373839483
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Muchun-Song/add-hugetlb_free_vmemmap-sysctl/20220228-151303
        git checkout a2a3193fd949ff24ed0c138ef495e67373839483
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/hugetlb_vmemmap.c: In function 'hugetlb_vmemmap_sysctl_handler':
>> mm/hugetlb_vmemmap.c:156:55: error: 'memmap_on_memory' undeclared (first use in this function)
     156 |  if (write && (!is_power_of_2(sizeof(struct page)) || memmap_on_memory))
         |                                                       ^~~~~~~~~~~~~~~~
   mm/hugetlb_vmemmap.c:156:55: note: each undeclared identifier is reported only once for each function it appears in


vim +/memmap_on_memory +156 mm/hugetlb_vmemmap.c

   148	
   149	int hugetlb_vmemmap_sysctl_handler(struct ctl_table *table, int write,
   150					   void *buffer, size_t *length, loff_t *ppos)
   151	{
   152		/*
   153		 * The vmemmap pages cannot be optimized if a "struct page" crosses page
   154		 * boundaries or memory_hotplug.memmap_on_memory is enabled.
   155		 */
 > 156		if (write && (!is_power_of_2(sizeof(struct page)) || memmap_on_memory))

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
