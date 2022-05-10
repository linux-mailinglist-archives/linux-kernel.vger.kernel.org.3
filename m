Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D4E522683
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 23:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbiEJVzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 17:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbiEJVzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 17:55:48 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5388D1032;
        Tue, 10 May 2022 14:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652219745; x=1683755745;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4RYB0zZZfnXkXzP1aYf9qSZ/Jnp/XkShxgoTSmMnvzw=;
  b=Rd5njsS9DhNw8tTR2B+f2fqzeYk5IYP5qXLz+AoceXSbCYSuLp5bpolG
   s4yKlG212wxA7usuR2Togvbsex5p5O/gVOu11dq72/2oftpoWOV1y8m1b
   8f9NUWolrEAHGOl3mcOaX42wWVG9sfwlENBDagLseR3xQCJ8HfMRO+Dpg
   YeVQLz5u/ZZWd5WapMf1rfzYlruv1zeF3t6hWmr5rHY6RKBNxK8tzqkoq
   NULu8oMkHDVe3uumpT+VYD0LDnmHRZe7DM+XkxsgunZsK7hxw6/RGP66z
   wZ+2/SHCrxkTUXet9LJdcjvFPbHS+9jQjr5/Sfh1rs+ibZC4laoeRoQt2
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="250046667"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="250046667"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 14:55:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="565861866"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 10 May 2022 14:55:42 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noXpV-000IQc-Cl;
        Tue, 10 May 2022 21:55:41 +0000
Date:   Wed, 11 May 2022 05:55:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>,
        gregkh@linuxfoundation.org, christian.koenig@amd.com,
        sumit.semwal@linaro.org, hridya@google.com, daniel.vetter@ffwll.ch,
        tjmercier@google.com
Cc:     kbuild-all@lists.01.org, linaro-mm-sig@lists.linaro.org,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH V2] dmabuf: ensure unique directory name for dmabuf stats
Message-ID: <202205110511.E0d8TXXC-lkp@intel.com>
References: <1652191562-18700-1-git-send-email-quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652191562-18700-1-git-send-email-quic_charante@quicinc.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.18-rc6 next-20220510]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Charan-Teja-Kalla/dmabuf-ensure-unique-directory-name-for-dmabuf-stats/20220510-221009
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 9be9ed2612b5aedb52a2c240edb1630b6b743cb6
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220511/202205110511.E0d8TXXC-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/1bc947824de94b4d4a87c48772c0d36872eaf731
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Charan-Teja-Kalla/dmabuf-ensure-unique-directory-name-for-dmabuf-stats/20220510-221009
        git checkout 1bc947824de94b4d4a87c48772c0d36872eaf731
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/dma-buf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/dma-buf/dma-buf-sysfs-stats.c: In function 'dma_buf_stats_setup':
>> drivers/dma-buf/dma-buf-sysfs-stats.c:196:43: warning: format '%lu' expects argument of type 'long unsigned int', but argument 6 has type 's64' {aka 'long long int'} [-Wformat=]
     196 |                                    "%lu-%lu", file_inode(dmabuf->file)->i_ino,
         |                                         ~~^
         |                                           |
         |                                           long unsigned int
         |                                         %llu
     197 |                                    atomic64_add_return(1, &unique_id));
         |                                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                    |
         |                                    s64 {aka long long int}


vim +196 drivers/dma-buf/dma-buf-sysfs-stats.c

   170	
   171	int dma_buf_stats_setup(struct dma_buf *dmabuf)
   172	{
   173		struct dma_buf_sysfs_entry *sysfs_entry;
   174		int ret;
   175		static atomic64_t unique_id = ATOMIC_INIT(0);
   176	
   177		if (!dmabuf || !dmabuf->file)
   178			return -EINVAL;
   179	
   180		if (!dmabuf->exp_name) {
   181			pr_err("exporter name must not be empty if stats needed\n");
   182			return -EINVAL;
   183		}
   184	
   185		sysfs_entry = kzalloc(sizeof(struct dma_buf_sysfs_entry), GFP_KERNEL);
   186		if (!sysfs_entry)
   187			return -ENOMEM;
   188	
   189		sysfs_entry->kobj.kset = dma_buf_per_buffer_stats_kset;
   190		sysfs_entry->dmabuf = dmabuf;
   191	
   192		dmabuf->sysfs_entry = sysfs_entry;
   193	
   194		/* create the directory for buffer stats */
   195		ret = kobject_init_and_add(&sysfs_entry->kobj, &dma_buf_ktype, NULL,
 > 196					   "%lu-%lu", file_inode(dmabuf->file)->i_ino,

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
