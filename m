Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A621C593048
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbiHONxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbiHONxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:53:38 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F55C1F2C9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 06:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660571618; x=1692107618;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o2XiW+yxUok6Tdrk84ZcRgZcADmd7A774QcSxAhcmZ0=;
  b=AjE+I7qvKuwMcBjMqULJi+lz2E0X+x9bGs9oDeNen43w3706UzrltDOn
   eth/hzW2AjRE4Y9mnUoUBymMAUxsMkALkKzrRB/S4YbYwStFkyiCqweY+
   mVrb3Ss3FqruYIeb466oUzqzW7mtfQb3yLT0dJ8L/fiWB+9m7IvfuLGw8
   4Wcl+xu7UZq8s0Mdlp/NgHDdXNAugnFtlJBR9CinJAQFPXAIkz3l6M49F
   obySg0tuy7LqPFLf3tenv9PTnf6LZ1v7YbUj7YhCsOWpC1bo9RI2hnHWv
   6nPr53daOudSqOXopKI6YBZOemo8quu/QttkxmhCSd+6CwCyet1Z/NNWw
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="378248463"
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="378248463"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 06:53:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="639651299"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 15 Aug 2022 06:53:35 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNaX8-00012b-15;
        Mon, 15 Aug 2022 13:53:34 +0000
Date:   Mon, 15 Aug 2022 21:53:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kassey Li <quic_yingangl@quicinc.com>, akpm@linux-foundation.org,
        vbabka@kernel.org
Cc:     kbuild-all@lists.01.org, Kassey Li <quic_yingangl@quicinc.com>,
        minchan@kernel.org, vbabka@suse.cz, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7] mm/page_owner.c: add llseek for page_owner
Message-ID: <202208152108.7XytfeP8-lkp@intel.com>
References: <20220815063010.22462-1-quic_yingangl@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815063010.22462-1-quic_yingangl@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kassey,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.0-rc1 next-20220815]
[cannot apply to akpm-mm/mm-everything]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kassey-Li/mm-page_owner-c-add-llseek-for-page_owner/20220815-143155
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220815/202208152108.7XytfeP8-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f9ef28f8ab55cdd176ab5ce7ad606ca45b4dbcc0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kassey-Li/mm-page_owner-c-add-llseek-for-page_owner/20220815-143155
        git checkout f9ef28f8ab55cdd176ab5ce7ad606ca45b4dbcc0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/page_owner.c:575:8: warning: no previous prototype for 'lseek_page_owner' [-Wmissing-prototypes]
     575 | loff_t lseek_page_owner(struct file *file, loff_t offset, int orig)
         |        ^~~~~~~~~~~~~~~~


vim +/lseek_page_owner +575 mm/page_owner.c

   574	
 > 575	loff_t lseek_page_owner(struct file *file, loff_t offset, int orig)
   576	{
   577		switch (orig) {
   578		case SEEK_SET:
   579			file->f_pos = offset;
   580			break;
   581		case SEEK_CUR:
   582			file->f_pos += offset;
   583			break;
   584		default:
   585			return -EINVAL;
   586		}
   587		return file->f_pos;
   588	}
   589	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
