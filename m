Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5CA491168
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 22:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243298AbiAQVsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 16:48:53 -0500
Received: from mga14.intel.com ([192.55.52.115]:14142 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235812AbiAQVsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 16:48:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642456131; x=1673992131;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DBeO6aDiIEQG/4PRcF+TRJQpRxMi0Jc+fiRJum1lmsQ=;
  b=L5BBb+VVEGznJIqePsth4bcO7yEDMAhACbHL6uhFI58wDYCCrD7ozM5R
   bXY/KHq1J7LU+9i0XyWFbLCT8r9TtL59AM+GhdEtVR4gwO5xrkSkxgpwC
   8bWJ4ZYCTYRlhQJnuwrewNtYpNrRIM2ixHiI5i53+dZAZ1tp2Ar8qvlv2
   +Y6Z9YbT0AlXWp+DErhJkM+Vkh08YyFCkSFs6MThGSfvKNwxQHKYl8fgH
   qCQ5AC2If8W954Z+KiI8iyK8qXfh4VJtB6FsrOVMVlcgTpRTYJGBgBFd3
   SXaytTIiMjukrnvGGwgLHXw35AF97RJKPXvQ8XxgtTP2WTG07KpSIosTa
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="244893342"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="244893342"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 13:48:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="476768406"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 17 Jan 2022 13:48:49 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9Zrt-000BtY-Au; Mon, 17 Jan 2022 21:48:49 +0000
Date:   Tue, 18 Jan 2022 05:48:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-lib 14/24]
 fs/netfs/read_helper.c:979:14: warning: variable 'folio' is uninitialized
 when used here
Message-ID: <202201180514.gVYTloyy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-lib
head:   e450b62f32df4384c141a6a382811b3fe5723bad
commit: e6b340ed3634bb80396afb564c499eebdeff601f [14/24] netfs: Use a buffer in netfs_read_request and add pages to it
config: x86_64-randconfig-a001-20220117 (https://download.01.org/0day-ci/archive/20220118/202201180514.gVYTloyy-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5f782d25a742302d25ef3c8b84b54f7483c2deb9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/e6b340ed3634bb80396afb564c499eebdeff601f
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-lib
        git checkout e6b340ed3634bb80396afb564c499eebdeff601f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/netfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/netfs/read_helper.c:979:14: warning: variable 'folio' is uninitialized when used here [-Wuninitialized]
                           folio_put(folio);
                                     ^~~~~
   fs/netfs/read_helper.c:928:21: note: initialize the variable 'folio' to silence this warning
           struct folio *folio;
                              ^
                               = NULL
   1 warning generated.


vim +/folio +979 fs/netfs/read_helper.c

   943	
   944		ret = netfs_rreq_add_folios_to_buffer(rreq, want_index, have_index - 1,
   945						      gfp_mask);
   946		if (ret < 0)
   947			return ret;
   948		have_folios += have_index - want_index;
   949	
   950		ret = netfs_rreq_add_folios_to_buffer(rreq, have_index + have_folios,
   951						      want_index + want_folios - 1,
   952						      gfp_mask);
   953		if (ret < 0)
   954			return ret;
   955	
   956		/* Transfer the folios proposed by the VM into the buffer and take refs
   957		 * on them.  The locks will be dropped in netfs_rreq_unlock().
   958		 */
   959		if (ractl) {
   960			while ((folio = readahead_folio(ractl))) {
   961				folio_get(folio);
   962				if (folio == keep)
   963					folio_get(folio);
   964				ret = xa_insert_set_mark(&rreq->buffer,
   965							 folio_index(folio), folio,
   966							 XA_MARK_0, gfp_mask);
   967				if (ret < 0) {
   968					if (folio != keep)
   969						folio_unlock(folio);
   970					folio_put(folio);
   971					return ret;
   972				}
   973			}
   974		} else {
   975			folio_get(keep);
   976			ret = xa_insert_set_mark(&rreq->buffer, keep->index, keep,
   977						 XA_MARK_0, gfp_mask);
   978			if (ret < 0) {
 > 979				folio_put(folio);
   980				return ret;
   981			}
   982		}
   983		return 0;
   984	}
   985	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
