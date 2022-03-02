Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B194B4CAB54
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243731AbiCBRQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243522AbiCBRQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:16:12 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6BFCB66B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646241319; x=1677777319;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JPgNcN3yRPkWhdAdp6hz0bJtkS6p6GHR+izGPZ6HtW0=;
  b=bWiy3WGOUkwangoqODvaZvq1HiULbo4W+bJHZLkg40SovWXBNAzQaUWf
   Uy1E6tlF53pLx9rzGdSXFyo87Qc2gx5z6D9ANU75fIYBWLNBVVeUXixgt
   42Rt3wJJdATvGQ1v57Pk4C0RhxF5SYsgCqylW6/lI4NFCNHW87CIhljpB
   9lJhbwNi3Ay5uH2ktZMW2HGANZH+3Xnw1AnpXHNvlVJICnLjjgXOOKfQB
   Lc9bgJ44ga08VwP75lyGfFoD5uzktergEV9/Svz95Yn+8jq1NIEZDHlI/
   4WRnAz2/alr3TYiegErO5IRX9EA3CZ6XjyO8RjMuSBQAKrgVbSMISVJeE
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="278129942"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="278129942"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 09:15:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="535466041"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 02 Mar 2022 09:15:17 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPSZI-0001dq-QF; Wed, 02 Mar 2022 17:15:16 +0000
Date:   Thu, 3 Mar 2022 01:14:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/fscache-next 36/39]
 fs/netfs/io.c:630:2: warning: variable 'ret' is used uninitialized whenever
 'if' condition is false
Message-ID: <202203030120.FpZOVtN6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

First bad commit (maybe != root cause):

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/fscache-next
head:   78e12b114b9c804d4b1eef16b6df1112cde6a960
commit: ad9e5adb388f358027a51032b3944913d98f7866 [36/39] netfs: Rename rename read_helper.c to io.c
config: hexagon-buildonly-randconfig-r006-20220302 (https://download.01.org/0day-ci/archive/20220303/202203030120.FpZOVtN6-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/ad9e5adb388f358027a51032b3944913d98f7866
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/fscache-next
        git checkout ad9e5adb388f358027a51032b3944913d98f7866
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/netfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/netfs/io.c:630:2: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (sync) {
           ^~~~~~~~~
   include/linux/compiler.h:56:28: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:30: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/netfs/io.c:655:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   fs/netfs/io.c:630:2: note: remove the 'if' if its condition is always true
           if (sync) {
           ^~~~~~~~~~
   include/linux/compiler.h:56:23: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                         ^
   fs/netfs/io.c:604:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   1 warning generated.


vim +630 fs/netfs/io.c

3d3c95046742e4 fs/netfs/read_helper.c David Howells 2020-05-13  595  
c19a5d31b470e0 fs/netfs/read_helper.c David Howells 2022-03-02  596  /*
c19a5d31b470e0 fs/netfs/read_helper.c David Howells 2022-03-02  597   * Begin the process of reading in a chunk of data, where that data may be
c19a5d31b470e0 fs/netfs/read_helper.c David Howells 2022-03-02  598   * stitched together from multiple sources, including multiple servers and the
c19a5d31b470e0 fs/netfs/read_helper.c David Howells 2022-03-02  599   * local cache.
c19a5d31b470e0 fs/netfs/read_helper.c David Howells 2022-03-02  600   */
c19a5d31b470e0 fs/netfs/read_helper.c David Howells 2022-03-02  601  int netfs_begin_read(struct netfs_io_request *rreq, bool sync)
c19a5d31b470e0 fs/netfs/read_helper.c David Howells 2022-03-02  602  {
c19a5d31b470e0 fs/netfs/read_helper.c David Howells 2022-03-02  603  	unsigned int debug_index = 0;
c19a5d31b470e0 fs/netfs/read_helper.c David Howells 2022-03-02  604  	int ret;
c19a5d31b470e0 fs/netfs/read_helper.c David Howells 2022-03-02  605  
c19a5d31b470e0 fs/netfs/read_helper.c David Howells 2022-03-02  606  	_enter("R=%x %llx-%llx",
c19a5d31b470e0 fs/netfs/read_helper.c David Howells 2022-03-02  607  	       rreq->debug_id, rreq->start, rreq->start + rreq->len - 1);
c19a5d31b470e0 fs/netfs/read_helper.c David Howells 2022-03-02  608  
c19a5d31b470e0 fs/netfs/read_helper.c David Howells 2022-03-02  609  	if (rreq->len == 0) {
c19a5d31b470e0 fs/netfs/read_helper.c David Howells 2022-03-02  610  		pr_err("Zero-sized read [R=%x]\n", rreq->debug_id);
c19a5d31b470e0 fs/netfs/read_helper.c David Howells 2022-03-02  611  		netfs_put_request(rreq, false, netfs_rreq_trace_put_zero_len);
c19a5d31b470e0 fs/netfs/read_helper.c David Howells 2022-03-02  612  		return -EIO;
c19a5d31b470e0 fs/netfs/read_helper.c David Howells 2022-03-02  613  	}
c19a5d31b470e0 fs/netfs/read_helper.c David Howells 2022-03-02  614  
c19a5d31b470e0 fs/netfs/read_helper.c David Howells 2022-03-02  615  	rreq->work.func = netfs_rreq_work;
c19a5d31b470e0 fs/netfs/read_helper.c David Howells 2022-03-02  616  
c19a5d31b470e0 fs/netfs/read_helper.c David Howells 2022-03-02  617  	if (sync)
c19a5d31b470e0 fs/netfs/read_helper.c David Howells 2022-03-02  618  		netfs_get_request(rreq, netfs_rreq_trace_get_hold);
c19a5d31b470e0 fs/netfs/read_helper.c David Howells 2022-03-02  619  
c19a5d31b470e0 fs/netfs/read_helper.c David Howells 2022-03-02  620  	/* Chop the read into slices according to what the cache and the netfs
c19a5d31b470e0 fs/netfs/read_helper.c David Howells 2022-03-02  621  	 * want and submit each one.
c19a5d31b470e0 fs/netfs/read_helper.c David Howells 2022-03-02  622  	 */
c19a5d31b470e0 fs/netfs/read_helper.c David Howells 2022-03-02  623  	atomic_set(&rreq->nr_outstanding, 1);
c19a5d31b470e0 fs/netfs/read_helper.c David Howells 2022-03-02  624  	do {
c19a5d31b470e0 fs/netfs/read_helper.c David Howells 2022-03-02  625  		if (!netfs_rreq_submit_slice(rreq, &debug_index))
c19a5d31b470e0 fs/netfs/read_helper.c David Howells 2022-03-02  626  			break;
c19a5d31b470e0 fs/netfs/read_helper.c David Howells 2022-03-02  627  
c19a5d31b470e0 fs/netfs/read_helper.c David Howells 2022-03-02  628  	} while (rreq->submitted < rreq->len);
c19a5d31b470e0 fs/netfs/read_helper.c David Howells 2022-03-02  629  
c19a5d31b470e0 fs/netfs/read_helper.c David Howells 2022-03-02 @630  	if (sync) {

:::::: The code at line 630 was first introduced by commit
:::::: c19a5d31b470e0a7dea07a71bb7b98a916b449e9 netfs: Add a function to consolidate beginning a read

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: David Howells <dhowells@redhat.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
