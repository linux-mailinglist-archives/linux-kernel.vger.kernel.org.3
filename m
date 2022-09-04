Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0275AC58B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 19:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbiIDRAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 13:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIDRAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 13:00:11 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C692B19026
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 10:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662310810; x=1693846810;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IDkSGEvdi2JFPpMmSwpstePx7wStEcfV/4m6fbYKC1o=;
  b=BXP//saPLdlRhqdQ9wCMXfBnn7PqThCSKfidEGf0eEQ3zah/iIMdhDNX
   lFsC/qtZ/yGqTIw9d0sWPyy+/hcwomA/vSbN5oAWslX+GGWb3WQvffLQX
   L01C9PUJmP9k5/4Zy0Y4H+PT2v+pmkNSkHbJp8OEcGipqRl5pprZRRzWb
   o0ODzCjm9FLOtGxdictj29RZD7NDndCt8wuledKqd1/S+Z2iBrDhRv8l4
   +LNtpFDFazIsLx3CIcZplnxv0Jy8jvBbTakjCWC8VdrU0HBR7UGtuopdb
   wHZiJyCsYUINfWDE/v1uc8FN5FFRX8lY4T7ulNDeGpLF3djIKlGl2Qx6Z
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="297560477"
X-IronPort-AV: E=Sophos;i="5.93,289,1654585200"; 
   d="scan'208";a="297560477"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2022 10:00:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,289,1654585200"; 
   d="scan'208";a="564506213"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 04 Sep 2022 10:00:08 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUsye-0003GD-00;
        Sun, 04 Sep 2022 17:00:08 +0000
Date:   Mon, 5 Sep 2022 01:00:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cheng Li <lic121@chinatelecom.cn>, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Cheng Li <lic121@chinatelecom.cn>
Subject: Re: [PATCH] mm: use mem_map_offset instead of mem_map_next
Message-ID: <202209050027.b6h4HE6N-lkp@intel.com>
References: <1662300161-22049-1-git-send-email-lic121@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662300161-22049-1-git-send-email-lic121@chinatelecom.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cheng,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Cheng-Li/mm-use-mem_map_offset-instead-of-mem_map_next/20220904-220520
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220905/202209050027.b6h4HE6N-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/18a9446796efe2ae164f38013cbd4272a6b89cb1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Cheng-Li/mm-use-mem_map_offset-instead-of-mem_map_next/20220904-220520
        git checkout 18a9446796efe2ae164f38013cbd4272a6b89cb1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   mm/hugetlb.c: In function '__prep_compound_gigantic_page':
>> mm/hugetlb.c:1798:39: warning: passing argument 2 of 'mem_map_offset' makes integer from pointer without a cast [-Wint-conversion]
    1798 |                 p = mem_map_offset(p, page, i);
         |                                       ^~~~
         |                                       |
         |                                       struct page *
   In file included from mm/hugetlb.c:47:
   mm/internal.h:646:66: note: expected 'int' but argument is of type 'struct page *'
     646 | static inline struct page *mem_map_offset(struct page *base, int offset)
         |                                                              ~~~~^~~~~~
>> mm/hugetlb.c:1798:21: error: too many arguments to function 'mem_map_offset'
    1798 |                 p = mem_map_offset(p, page, i);
         |                     ^~~~~~~~~~~~~~
   In file included from mm/hugetlb.c:47:
   mm/internal.h:646:28: note: declared here
     646 | static inline struct page *mem_map_offset(struct page *base, int offset)
         |                            ^~~~~~~~~~~~~~


vim +/mem_map_offset +1798 mm/hugetlb.c

  1785	
  1786	static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
  1787									bool demote)
  1788	{
  1789		int i, j;
  1790		int nr_pages = 1 << order;
  1791		struct page *p;
  1792	
  1793		/* we rely on prep_new_huge_page to set the destructor */
  1794		set_compound_order(page, order);
  1795		__ClearPageReserved(page);
  1796		__SetPageHead(page);
  1797		for (i = 1; i < nr_pages; i++) {
> 1798			p = mem_map_offset(p, page, i);
  1799	
  1800			/*
  1801			 * For gigantic hugepages allocated through bootmem at
  1802			 * boot, it's safer to be consistent with the not-gigantic
  1803			 * hugepages and clear the PG_reserved bit from all tail pages
  1804			 * too.  Otherwise drivers using get_user_pages() to access tail
  1805			 * pages may get the reference counting wrong if they see
  1806			 * PG_reserved set on a tail page (despite the head page not
  1807			 * having PG_reserved set).  Enforcing this consistency between
  1808			 * head and tail pages allows drivers to optimize away a check
  1809			 * on the head page when they need know if put_page() is needed
  1810			 * after get_user_pages().
  1811			 */
  1812			__ClearPageReserved(p);
  1813			/*
  1814			 * Subtle and very unlikely
  1815			 *
  1816			 * Gigantic 'page allocators' such as memblock or cma will
  1817			 * return a set of pages with each page ref counted.  We need
  1818			 * to turn this set of pages into a compound page with tail
  1819			 * page ref counts set to zero.  Code such as speculative page
  1820			 * cache adding could take a ref on a 'to be' tail page.
  1821			 * We need to respect any increased ref count, and only set
  1822			 * the ref count to zero if count is currently 1.  If count
  1823			 * is not 1, we return an error.  An error return indicates
  1824			 * the set of pages can not be converted to a gigantic page.
  1825			 * The caller who allocated the pages should then discard the
  1826			 * pages using the appropriate free interface.
  1827			 *
  1828			 * In the case of demote, the ref count will be zero.
  1829			 */
  1830			if (!demote) {
  1831				if (!page_ref_freeze(p, 1)) {
  1832					pr_warn("HugeTLB page can not be used due to unexpected inflated ref count\n");
  1833					goto out_error;
  1834				}
  1835			} else {
  1836				VM_BUG_ON_PAGE(page_count(p), p);
  1837			}
  1838			set_compound_head(p, page);
  1839		}
  1840		atomic_set(compound_mapcount_ptr(page), -1);
  1841		atomic_set(compound_pincount_ptr(page), 0);
  1842		return true;
  1843	
  1844	out_error:
  1845		/* undo tail page modifications made above */
  1846		for (j = 1; j < i; j++) {
  1847			p = mem_map_offset(page, j);
  1848			clear_compound_head(p);
  1849			set_page_refcounted(p);
  1850		}
  1851		/* need to clear PG_reserved on remaining tail pages  */
  1852		for (; j < nr_pages; j++) {
  1853			p = mem_map_offset(page, j);
  1854			__ClearPageReserved(p);
  1855		}
  1856		set_compound_order(page, 0);
  1857	#ifdef CONFIG_64BIT
  1858		page[1].compound_nr = 0;
  1859	#endif
  1860		__ClearPageHead(page);
  1861		return false;
  1862	}
  1863	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
