Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1AF5AD8FD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 20:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbiIESY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 14:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiIESYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 14:24:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437C113E9E;
        Mon,  5 Sep 2022 11:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662402291; x=1693938291;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CxRyLZFpzNJgRD8JEVnKifggxfl/jfPeJoUCS/Yew7M=;
  b=W9C+T+9gMZR/jvQrl+xMlptJ9T6eUhWwcOPn5t+xfoMsofGcHPTMDN7/
   6LLcFGODYZCMuWZ513qBHT73bAht5wPKtjkjlwF1AhX7VSrLz59kxlp0m
   GlMroU9N7lBqlZgazPPCi/W0L/K63Rz6RFUSaNK1yBG8bjv7QmRXYtyPO
   uDh2rEqK4sGFYKz4a4btTMBP+W0WTwBVbxK8m/4cvMVv3f/XFNPS6u570
   /G6ngl+agh7qKOLRGDu5ADsDGR4RpRLbaetxZhOJWMjoSE19qCODNSwD6
   9RQi0rmZw79fgjJelKW/BmUnZfruZBd+TlQVChLjBZp0ZwEC+/wX+MMkA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="297223835"
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="297223835"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 11:24:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="643883081"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 05 Sep 2022 11:24:49 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVGm8-0004QL-1V;
        Mon, 05 Sep 2022 18:24:48 +0000
Date:   Tue, 6 Sep 2022 02:24:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jianglei Nie <niejianglei2021@163.com>, rafael@kernel.org
Cc:     kbuild-all@lists.01.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: Re: [PATCH] PM: hibernate: Fix potential memory leak in
 hibernate_preallocate_memory() and prepare_highmem_image()
Message-ID: <202209060246.TutWrNwg-lkp@intel.com>
References: <20220905083559.49438-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905083559.49438-1-niejianglei2021@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianglei,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.0-rc4 next-20220901]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jianglei-Nie/PM-hibernate-Fix-potential-memory-leak-in-hibernate_preallocate_memory-and-prepare_highmem_image/20220905-163900
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 7e18e42e4b280c85b76967a9106a13ca61c16179
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20220906/202209060246.TutWrNwg-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/e7861e5c6a8fa89ecf844515db5843131bb0412c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jianglei-Nie/PM-hibernate-Fix-potential-memory-leak-in-hibernate_preallocate_memory-and-prepare_highmem_image/20220905-163900
        git checkout e7861e5c6a8fa89ecf844515db5843131bb0412c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/power/snapshot.c: In function 'hibernate_preallocate_memory':
>> kernel/power/snapshot.c:1755:32: error: incompatible type for argument 1 of 'memory_bm_free'
    1755 |                 memory_bm_free(orig_bm, PG_UNSAFE_CLEAR);
         |                                ^~~~~~~
         |                                |
         |                                struct memory_bitmap
   kernel/power/snapshot.c:723:50: note: expected 'struct memory_bitmap *' but argument is of type 'struct memory_bitmap'
     723 | static void memory_bm_free(struct memory_bitmap *bm, int clear_nosave_free)
         |                            ~~~~~~~~~~~~~~~~~~~~~~^~


vim +/memory_bm_free +1755 kernel/power/snapshot.c

  1713	
  1714	/**
  1715	 * hibernate_preallocate_memory - Preallocate memory for hibernation image.
  1716	 *
  1717	 * To create a hibernation image it is necessary to make a copy of every page
  1718	 * frame in use.  We also need a number of page frames to be free during
  1719	 * hibernation for allocations made while saving the image and for device
  1720	 * drivers, in case they need to allocate memory from their hibernation
  1721	 * callbacks (these two numbers are given by PAGES_FOR_IO (which is a rough
  1722	 * estimate) and reserved_size divided by PAGE_SIZE (which is tunable through
  1723	 * /sys/power/reserved_size, respectively).  To make this happen, we compute the
  1724	 * total number of available page frames and allocate at least
  1725	 *
  1726	 * ([page frames total] + PAGES_FOR_IO + [metadata pages]) / 2
  1727	 *  + 2 * DIV_ROUND_UP(reserved_size, PAGE_SIZE)
  1728	 *
  1729	 * of them, which corresponds to the maximum size of a hibernation image.
  1730	 *
  1731	 * If image_size is set below the number following from the above formula,
  1732	 * the preallocation of memory is continued until the total number of saveable
  1733	 * pages in the system is below the requested image size or the minimum
  1734	 * acceptable image size returned by minimum_image_size(), whichever is greater.
  1735	 */
  1736	int hibernate_preallocate_memory(void)
  1737	{
  1738		struct zone *zone;
  1739		unsigned long saveable, size, max_size, count, highmem, pages = 0;
  1740		unsigned long alloc, save_highmem, pages_highmem, avail_normal;
  1741		ktime_t start, stop;
  1742		int error;
  1743	
  1744		pr_info("Preallocating image memory\n");
  1745		start = ktime_get();
  1746	
  1747		error = memory_bm_create(&orig_bm, GFP_IMAGE, PG_ANY);
  1748		if (error) {
  1749			pr_err("Cannot allocate original bitmap\n");
  1750			goto err_out;
  1751		}
  1752	
  1753		error = memory_bm_create(&copy_bm, GFP_IMAGE, PG_ANY);
  1754		if (error) {
> 1755			memory_bm_free(orig_bm, PG_UNSAFE_CLEAR);
  1756			pr_err("Cannot allocate copy bitmap\n");
  1757			goto err_out;
  1758		}
  1759	
  1760		alloc_normal = 0;
  1761		alloc_highmem = 0;
  1762	
  1763		/* Count the number of saveable data pages. */
  1764		save_highmem = count_highmem_pages();
  1765		saveable = count_data_pages();
  1766	
  1767		/*
  1768		 * Compute the total number of page frames we can use (count) and the
  1769		 * number of pages needed for image metadata (size).
  1770		 */
  1771		count = saveable;
  1772		saveable += save_highmem;
  1773		highmem = save_highmem;
  1774		size = 0;
  1775		for_each_populated_zone(zone) {
  1776			size += snapshot_additional_pages(zone);
  1777			if (is_highmem(zone))
  1778				highmem += zone_page_state(zone, NR_FREE_PAGES);
  1779			else
  1780				count += zone_page_state(zone, NR_FREE_PAGES);
  1781		}
  1782		avail_normal = count;
  1783		count += highmem;
  1784		count -= totalreserve_pages;
  1785	
  1786		/* Compute the maximum number of saveable pages to leave in memory. */
  1787		max_size = (count - (size + PAGES_FOR_IO)) / 2
  1788				- 2 * DIV_ROUND_UP(reserved_size, PAGE_SIZE);
  1789		/* Compute the desired number of image pages specified by image_size. */
  1790		size = DIV_ROUND_UP(image_size, PAGE_SIZE);
  1791		if (size > max_size)
  1792			size = max_size;
  1793		/*
  1794		 * If the desired number of image pages is at least as large as the
  1795		 * current number of saveable pages in memory, allocate page frames for
  1796		 * the image and we're done.
  1797		 */
  1798		if (size >= saveable) {
  1799			pages = preallocate_image_highmem(save_highmem);
  1800			pages += preallocate_image_memory(saveable - pages, avail_normal);
  1801			goto out;
  1802		}
  1803	
  1804		/* Estimate the minimum size of the image. */
  1805		pages = minimum_image_size(saveable);
  1806		/*
  1807		 * To avoid excessive pressure on the normal zone, leave room in it to
  1808		 * accommodate an image of the minimum size (unless it's already too
  1809		 * small, in which case don't preallocate pages from it at all).
  1810		 */
  1811		if (avail_normal > pages)
  1812			avail_normal -= pages;
  1813		else
  1814			avail_normal = 0;
  1815		if (size < pages)
  1816			size = min_t(unsigned long, pages, max_size);
  1817	
  1818		/*
  1819		 * Let the memory management subsystem know that we're going to need a
  1820		 * large number of page frames to allocate and make it free some memory.
  1821		 * NOTE: If this is not done, performance will be hurt badly in some
  1822		 * test cases.
  1823		 */
  1824		shrink_all_memory(saveable - size);
  1825	
  1826		/*
  1827		 * The number of saveable pages in memory was too high, so apply some
  1828		 * pressure to decrease it.  First, make room for the largest possible
  1829		 * image and fail if that doesn't work.  Next, try to decrease the size
  1830		 * of the image as much as indicated by 'size' using allocations from
  1831		 * highmem and non-highmem zones separately.
  1832		 */
  1833		pages_highmem = preallocate_image_highmem(highmem / 2);
  1834		alloc = count - max_size;
  1835		if (alloc > pages_highmem)
  1836			alloc -= pages_highmem;
  1837		else
  1838			alloc = 0;
  1839		pages = preallocate_image_memory(alloc, avail_normal);
  1840		if (pages < alloc) {
  1841			/* We have exhausted non-highmem pages, try highmem. */
  1842			alloc -= pages;
  1843			pages += pages_highmem;
  1844			pages_highmem = preallocate_image_highmem(alloc);
  1845			if (pages_highmem < alloc) {
  1846				pr_err("Image allocation is %lu pages short\n",
  1847					alloc - pages_highmem);
  1848				goto err_out;
  1849			}
  1850			pages += pages_highmem;
  1851			/*
  1852			 * size is the desired number of saveable pages to leave in
  1853			 * memory, so try to preallocate (all memory - size) pages.
  1854			 */
  1855			alloc = (count - pages) - size;
  1856			pages += preallocate_image_highmem(alloc);
  1857		} else {
  1858			/*
  1859			 * There are approximately max_size saveable pages at this point
  1860			 * and we want to reduce this number down to size.
  1861			 */
  1862			alloc = max_size - size;
  1863			size = preallocate_highmem_fraction(alloc, highmem, count);
  1864			pages_highmem += size;
  1865			alloc -= size;
  1866			size = preallocate_image_memory(alloc, avail_normal);
  1867			pages_highmem += preallocate_image_highmem(alloc - size);
  1868			pages += pages_highmem + size;
  1869		}
  1870	
  1871		/*
  1872		 * We only need as many page frames for the image as there are saveable
  1873		 * pages in memory, but we have allocated more.  Release the excessive
  1874		 * ones now.
  1875		 */
  1876		pages -= free_unnecessary_pages();
  1877	
  1878	 out:
  1879		stop = ktime_get();
  1880		pr_info("Allocated %lu pages for snapshot\n", pages);
  1881		swsusp_show_speed(start, stop, pages, "Allocated");
  1882	
  1883		return 0;
  1884	
  1885	 err_out:
  1886		swsusp_free();
  1887		return -ENOMEM;
  1888	}
  1889	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
