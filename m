Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F70592F18
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 14:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242221AbiHOMlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 08:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241893AbiHOMli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 08:41:38 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7105D127
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 05:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660567296; x=1692103296;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SplSxesvyZvRRgtnISH+hq5JWR2pxgb/KkEgyQmKz54=;
  b=nZ7lzjsN/2DxNu/lp8wWzPLhgUIh3gkdiBwebxrmfMkxrvsB7wfh55LO
   ZkhA1y10OH60fQQ8t+pK9JeKxWgTCjTUKVE5DkalBU5Z1L36bGGYV97jU
   JCggGzF0ZMLmI5PAcqpK8BKQS7UGsAY8QtrVXghcIwp9w0udL+QXnvoMN
   LBIVQtdG5HS5K/NbXsX9sTfaFV5QjwObZpvJG2YJpGj9hcKnzjLrkXwWw
   kKp96yZSETvRGUr7WRTX3z08HUquKEX6oIPYJTOrdGg2u1gCrDJ04Y07w
   YNVbvFBlrJ9vfbpBdIPsLxY9iLxomixtp+36PsBFnnIIbYUpHz6T89hXV
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="272341553"
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="272341553"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 05:41:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="674820064"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 15 Aug 2022 05:41:34 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNZPR-00010O-1F;
        Mon, 15 Aug 2022 12:41:33 +0000
Date:   Mon, 15 Aug 2022 20:40:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kassey Li <quic_yingangl@quicinc.com>, akpm@linux-foundation.org,
        vbabka@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Kassey Li <quic_yingangl@quicinc.com>, minchan@kernel.org,
        vbabka@suse.cz, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7] mm/page_owner.c: add llseek for page_owner
Message-ID: <202208152007.a6QeCOGK-lkp@intel.com>
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
config: hexagon-randconfig-r041-20220814 (https://download.01.org/0day-ci/archive/20220815/202208152007.a6QeCOGK-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 6afcc4a459ead8809a0d6d9b4bf7b64bcc13582b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f9ef28f8ab55cdd176ab5ce7ad606ca45b4dbcc0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kassey-Li/mm-page_owner-c-add-llseek-for-page_owner/20220815-143155
        git checkout f9ef28f8ab55cdd176ab5ce7ad606ca45b4dbcc0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/page_owner.c:575:8: warning: no previous prototype for function 'lseek_page_owner' [-Wmissing-prototypes]
   loff_t lseek_page_owner(struct file *file, loff_t offset, int orig)
          ^
   mm/page_owner.c:575:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   loff_t lseek_page_owner(struct file *file, loff_t offset, int orig)
   ^
   static 
   1 warning generated.


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
