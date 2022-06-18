Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FC45501E1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 04:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383829AbiFRCMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 22:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiFRCMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 22:12:05 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0092D6A433;
        Fri, 17 Jun 2022 19:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655518324; x=1687054324;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ILh8GqVgRpG2pN5N4Xid5VlyXwM8fCENiMr0RWu+Cu0=;
  b=YRPYTT7XtHSvR6bdE0vSvE/WsmljAOGitRF32dDkdU+h54fmsHx9kp3e
   U/qmGNr1g2a0Y3XOI7lr0U9ycBShzsfZ8YLeeCW1SN1uVfcfVE1q6kDkn
   QL3BzxZcQmZ3rnH9QvXzegeCLV0FQBAQU3NZVbdEXSvKm3S0DvrA5zuw6
   3ZMAlP7gy7awgCsYbT6JTxniHRlOTURr+TN58zTNvoqEV5zF3+lVjX6Wr
   6Mzk1r0WvGxTu1z4WxPw7Hvk8XSrkTfenYrJ/IwBAGJIzK9ZBt8S+PdYk
   Z6tjXQFeCn4z26rGGY7DORwScSXrEocXMLuSKO2w48iZeYSXPILESeiFu
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="268336605"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="268336605"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 19:12:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="688548056"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 17 Jun 2022 19:12:01 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2NwP-000Pw7-6g;
        Sat, 18 Jun 2022 02:12:01 +0000
Date:   Sat, 18 Jun 2022 10:11:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: Re: [PATCH 20/20] block, blksnap: adds a blksnap to the kernel tree
Message-ID: <202206181039.UczT9AgC-lkp@intel.com>
References: <1655135593-1900-21-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655135593-1900-21-git-send-email-sergei.shtepa@veeam.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergei,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on v5.19-rc2 next-20220617]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Sergei-Shtepa/blksnap-creating-non-persistent-snapshots-for-backup/20220614-025950
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: parisc-allmodconfig (https://download.01.org/0day-ci/archive/20220618/202206181039.UczT9AgC-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/1cdaf9c498b3c016f311f65998256e2129623f70
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sergei-Shtepa/blksnap-creating-non-persistent-snapshots-for-backup/20220614-025950
        git checkout 1cdaf9c498b3c016f311f65998256e2129623f70
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/ fs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/block/blksnap/diff_buffer.c:10:6: warning: no previous prototype for 'diff_buffer_free' [-Wmissing-prototypes]
      10 | void diff_buffer_free(struct diff_buffer *diff_buffer)
         |      ^~~~~~~~~~~~~~~~
>> drivers/block/blksnap/diff_buffer.c:34:21: warning: no previous prototype for 'diff_buffer_new' [-Wmissing-prototypes]
      34 | struct diff_buffer *diff_buffer_new(size_t page_count, size_t buffer_size,
         |                     ^~~~~~~~~~~~~~~
--
>> drivers/block/blksnap/diff_storage.c:134:22: warning: no previous prototype for 'diff_storage_bdev_by_id' [-Wmissing-prototypes]
     134 | struct block_device *diff_storage_bdev_by_id(struct diff_storage *diff_storage,
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
--
>> drivers/block/blksnap/tracker.c:44:6: warning: no previous prototype for 'tracker_free' [-Wmissing-prototypes]
      44 | void tracker_free(struct tracker *tracker)
         |      ^~~~~~~~~~~~


vim +/diff_buffer_free +10 drivers/block/blksnap/diff_buffer.c

9377564e255bc9 Sergei Shtepa 2022-06-13   9  
9377564e255bc9 Sergei Shtepa 2022-06-13 @10  void diff_buffer_free(struct diff_buffer *diff_buffer)
9377564e255bc9 Sergei Shtepa 2022-06-13  11  {
9377564e255bc9 Sergei Shtepa 2022-06-13  12  	size_t inx = 0;
9377564e255bc9 Sergei Shtepa 2022-06-13  13  	struct page *page;
9377564e255bc9 Sergei Shtepa 2022-06-13  14  
9377564e255bc9 Sergei Shtepa 2022-06-13  15  	if (unlikely(!diff_buffer))
9377564e255bc9 Sergei Shtepa 2022-06-13  16  		return;
9377564e255bc9 Sergei Shtepa 2022-06-13  17  
9377564e255bc9 Sergei Shtepa 2022-06-13  18  	for (inx = 0; inx < diff_buffer->page_count; inx++) {
9377564e255bc9 Sergei Shtepa 2022-06-13  19  		page = diff_buffer->pages[inx];
9377564e255bc9 Sergei Shtepa 2022-06-13  20  		if (page) {
9377564e255bc9 Sergei Shtepa 2022-06-13  21  			__free_page(page);
9377564e255bc9 Sergei Shtepa 2022-06-13  22  #ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
9377564e255bc9 Sergei Shtepa 2022-06-13  23  			memory_object_dec(memory_object_page);
9377564e255bc9 Sergei Shtepa 2022-06-13  24  #endif
9377564e255bc9 Sergei Shtepa 2022-06-13  25  		}
9377564e255bc9 Sergei Shtepa 2022-06-13  26  	}
9377564e255bc9 Sergei Shtepa 2022-06-13  27  
9377564e255bc9 Sergei Shtepa 2022-06-13  28  	kfree(diff_buffer);
9377564e255bc9 Sergei Shtepa 2022-06-13  29  #ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
9377564e255bc9 Sergei Shtepa 2022-06-13  30  	memory_object_dec(memory_object_diff_buffer);
9377564e255bc9 Sergei Shtepa 2022-06-13  31  #endif
9377564e255bc9 Sergei Shtepa 2022-06-13  32  }
9377564e255bc9 Sergei Shtepa 2022-06-13  33  
9377564e255bc9 Sergei Shtepa 2022-06-13 @34  struct diff_buffer *diff_buffer_new(size_t page_count, size_t buffer_size,
9377564e255bc9 Sergei Shtepa 2022-06-13  35  				    gfp_t gfp_mask)
9377564e255bc9 Sergei Shtepa 2022-06-13  36  {
9377564e255bc9 Sergei Shtepa 2022-06-13  37  	struct diff_buffer *diff_buffer;
9377564e255bc9 Sergei Shtepa 2022-06-13  38  	size_t inx = 0;
9377564e255bc9 Sergei Shtepa 2022-06-13  39  	struct page *page;
9377564e255bc9 Sergei Shtepa 2022-06-13  40  
9377564e255bc9 Sergei Shtepa 2022-06-13  41  	if (unlikely(page_count <= 0))
9377564e255bc9 Sergei Shtepa 2022-06-13  42  		return NULL;
9377564e255bc9 Sergei Shtepa 2022-06-13  43  
9377564e255bc9 Sergei Shtepa 2022-06-13  44  	/*
9377564e255bc9 Sergei Shtepa 2022-06-13  45  	 * In case of overflow, it is better to get a null pointer
9377564e255bc9 Sergei Shtepa 2022-06-13  46  	 * than a pointer to some memory area. Therefore + 1.
9377564e255bc9 Sergei Shtepa 2022-06-13  47  	 */
9377564e255bc9 Sergei Shtepa 2022-06-13  48  	diff_buffer = kzalloc(sizeof(struct diff_buffer) +
9377564e255bc9 Sergei Shtepa 2022-06-13  49  				      (page_count + 1) * sizeof(struct page *),
9377564e255bc9 Sergei Shtepa 2022-06-13  50  			      gfp_mask);
9377564e255bc9 Sergei Shtepa 2022-06-13  51  	if (!diff_buffer)
9377564e255bc9 Sergei Shtepa 2022-06-13  52  		return NULL;
9377564e255bc9 Sergei Shtepa 2022-06-13  53  #ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
9377564e255bc9 Sergei Shtepa 2022-06-13  54  	memory_object_inc(memory_object_diff_buffer);
9377564e255bc9 Sergei Shtepa 2022-06-13  55  #endif
9377564e255bc9 Sergei Shtepa 2022-06-13  56  	INIT_LIST_HEAD(&diff_buffer->link);
9377564e255bc9 Sergei Shtepa 2022-06-13  57  	diff_buffer->size = buffer_size;
9377564e255bc9 Sergei Shtepa 2022-06-13  58  	diff_buffer->page_count = page_count;
9377564e255bc9 Sergei Shtepa 2022-06-13  59  
9377564e255bc9 Sergei Shtepa 2022-06-13  60  	for (inx = 0; inx < page_count; inx++) {
9377564e255bc9 Sergei Shtepa 2022-06-13  61  		page = alloc_page(gfp_mask);
9377564e255bc9 Sergei Shtepa 2022-06-13  62  		if (!page)
9377564e255bc9 Sergei Shtepa 2022-06-13  63  			goto fail;
9377564e255bc9 Sergei Shtepa 2022-06-13  64  #ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
9377564e255bc9 Sergei Shtepa 2022-06-13  65  		memory_object_inc(memory_object_page);
9377564e255bc9 Sergei Shtepa 2022-06-13  66  #endif
9377564e255bc9 Sergei Shtepa 2022-06-13  67  		diff_buffer->pages[inx] = page;
9377564e255bc9 Sergei Shtepa 2022-06-13  68  	}
9377564e255bc9 Sergei Shtepa 2022-06-13  69  	return diff_buffer;
9377564e255bc9 Sergei Shtepa 2022-06-13  70  fail:
9377564e255bc9 Sergei Shtepa 2022-06-13  71  	diff_buffer_free(diff_buffer);
9377564e255bc9 Sergei Shtepa 2022-06-13  72  	return NULL;
9377564e255bc9 Sergei Shtepa 2022-06-13  73  }
9377564e255bc9 Sergei Shtepa 2022-06-13  74  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
