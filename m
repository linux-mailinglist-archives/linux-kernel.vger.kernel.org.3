Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F67550D258
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 16:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239401AbiDXOor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 10:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbiDXOop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 10:44:45 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D898B68320
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 07:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650811304; x=1682347304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VZiqp3rR5p++LyucOgObTUfn4d4gCSPvi2jpqkhWT74=;
  b=ImVa1PRmVTgU0RuLPUWlDj0snLRYY2Dcamcoz+vtbjp5tIVdx4rf3i+r
   5Gg0ibz6xTerNmssHM5sV88rX4u6fqwCq1RJIDWxDpAN1+WDCoOm2C9//
   lSTLugcEDqZvJKmmsOdNT4IF+gyWbM0gzbu57Pqb4o4pPwQOZ/RKQPB8P
   WBU9wLGjgr5Di206kSKJx8BqHfem2xJ84QqUJfn+qwH5lYFSzB3YrLjjd
   pQvWaC03psXMFjsgHZ+A/CktnjdSF1WjPfdEfEaGQmpCbVTnUdOoPEt+r
   mvOpTMuNMCPETNHWeBT+rOMRO4ucL7rMv848Tr+aAGs1RK0h1VDqsalAO
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="264841044"
X-IronPort-AV: E=Sophos;i="5.90,286,1643702400"; 
   d="scan'208";a="264841044"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2022 07:41:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,286,1643702400"; 
   d="scan'208";a="578818288"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 24 Apr 2022 07:41:42 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nidQk-0001Wx-8Y;
        Sun, 24 Apr 2022 14:41:42 +0000
Date:   Sun, 24 Apr 2022 22:40:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hongnan Li <hongnan.li@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] erofs: make filesystem exportable
Message-ID: <202204242223.Hf6HESVt-lkp@intel.com>
References: <20220424130104.102365-1-hongnan.li@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220424130104.102365-1-hongnan.li@linux.alibaba.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hongnan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on xiang-erofs/dev-test]
[also build test WARNING on v5.18-rc3 next-20220422]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Hongnan-Li/erofs-make-filesystem-exportable/20220424-211653
base:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220424/202204242223.Hf6HESVt-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c0fc15c5ccc4a5090cc32744ba63bde8ea558ac7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Hongnan-Li/erofs-make-filesystem-exportable/20220424-211653
        git checkout c0fc15c5ccc4a5090cc32744ba63bde8ea558ac7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/erofs/super.c:601:16: warning: no previous prototype for 'erofs_get_parent' [-Wmissing-prototypes]
     601 | struct dentry *erofs_get_parent(struct dentry *child)
         |                ^~~~~~~~~~~~~~~~


vim +/erofs_get_parent +601 fs/erofs/super.c

   600	
 > 601	struct dentry *erofs_get_parent(struct dentry *child)
   602	{
   603		erofs_nid_t nid;
   604		unsigned int d_type;
   605		int err;
   606	
   607		err = erofs_namei(d_inode(child), &dotdot_name, &nid, &d_type);
   608		if (err)
   609			return ERR_PTR(err);
   610		return d_obtain_alias(erofs_iget(child->d_sb, nid, d_type == FT_DIR));
   611	}
   612	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
