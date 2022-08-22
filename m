Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E87859BF2D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 14:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbiHVMEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 08:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbiHVMDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 08:03:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3E2BF45
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 05:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661169831; x=1692705831;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=N4IygWGbFvd1xw7DblqtBUK8DO5oWv3ABVwqtuqqmPE=;
  b=lIR75HXJuzDTpD0r7LFbsPPGWvUfoqDk5n1F5Wh8pfhzkIQCXK1q0klx
   LXrpllibUPuh3dzsAyJvsB23ZAvhNXUS3e3oH9cvEjdFvKFYkpX58zAmf
   71Mh1mzySzmjtAtQj7eUCcxWANNeGm8m2LPRgi/qA525hLgaA7et0vQKL
   ENgb1e7kLVkdcCuaJ3KVHn7X6AgJWSI6siuSjyW1BPLLS5BFiwl+2nIru
   fYhVxkdR6g8PTBlBwGWRpXIuSq/HXWlmoDwyP34N/Jl/S+r+FFVjZ154s
   MD+WSKe4AE+hLAF9oOIptIb7rqBxu65QekDorQ/NZlOKtj+dlXqBlkv0e
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10446"; a="294183778"
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="294183778"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 05:03:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="751259944"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Aug 2022 05:03:49 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQ69k-0005JD-2J;
        Mon, 22 Aug 2022 12:03:48 +0000
Date:   Mon, 22 Aug 2022 20:03:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: {standard input}:12363: Error: Insn slot not set in unwind record.
Message-ID: <202208221921.b20Q8McO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   15b3f48a4339e3c16acf18624e2b7f60bc5e9a2c
commit: d4252071b97d2027d246f6a82cbee4d52f618b47 add barriers to buffer_uptodate and set_buffer_uptodate
date:   13 days ago
config: ia64-randconfig-r001-20220820 (https://download.01.org/0day-ci/archive/20220822/202208221921.b20Q8McO-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d4252071b97d2027d246f6a82cbee4d52f618b47
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d4252071b97d2027d246f6a82cbee4d52f618b47
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   {standard input}:7964: Error: Register number out of range 0..1
   {standard input}:7964: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 37
   {standard input}:7962: Warning: This is the location of the conflicting usage
   {standard input}:7966: Error: Register number out of range 0..1
   {standard input}:7966: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 37
   {standard input}:7962: Warning: This is the location of the conflicting usage
   {standard input}:7966: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 37
   {standard input}:7964: Warning: This is the location of the conflicting usage
   {standard input}:7967: Error: Register number out of range 0..1
   {standard input}:7967: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 37
   {standard input}:7962: Warning: This is the location of the conflicting usage
   {standard input}:7967: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 37
   {standard input}:7964: Warning: This is the location of the conflicting usage
   {standard input}:7967: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 37
   {standard input}:7966: Warning: This is the location of the conflicting usage
   {standard input}:7968: Error: Register number out of range 0..1
   {standard input}:7968: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 37
   {standard input}:7962: Warning: This is the location of the conflicting usage
   {standard input}:7968: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 37
   {standard input}:7964: Warning: This is the location of the conflicting usage
   {standard input}:7968: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 37
   {standard input}:7966: Warning: This is the location of the conflicting usage
   {standard input}:7968: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 37
   {standard input}:7967: Warning: This is the location of the conflicting usage
   {standard input}:7971: Error: Register number out of range 0..1
   {standard input}:7972: Error: Register number out of range 0..1
   {standard input}:7972: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 37
   {standard input}:7971: Warning: This is the location of the conflicting usage
   {standard input}:8857: Error: Register number out of range 0..2
   {standard input}:8857: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 41
   {standard input}:8857: Warning: Only the first path encountering the conflict is reported
   {standard input}:8853: Warning: This is the location of the conflicting usage
   {standard input}:8858: Error: Register number out of range 0..2
   {standard input}:8858: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 41
   {standard input}:8858: Warning: Only the first path encountering the conflict is reported
   {standard input}:8853: Warning: This is the location of the conflicting usage
   {standard input}:8858: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 41
   {standard input}:8858: Warning: Only the first path encountering the conflict is reported
   {standard input}:8857: Warning: This is the location of the conflicting usage
   {standard input}:8859: Error: Register number out of range 0..2
   {standard input}:8859: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 41
   {standard input}:8859: Warning: Only the first path encountering the conflict is reported
   {standard input}:8853: Warning: This is the location of the conflicting usage
   {standard input}:8859: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 41
   {standard input}:8859: Warning: Only the first path encountering the conflict is reported
   {standard input}:8857: Warning: This is the location of the conflicting usage
   {standard input}:8859: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 41
   {standard input}:8859: Warning: Only the first path encountering the conflict is reported
   {standard input}:8858: Warning: This is the location of the conflicting usage
   {standard input}:8862: Error: Register number out of range 0..2
   {standard input}:8863: Error: Register number out of range 0..2
   {standard input}:8863: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 41
   {standard input}:8863: Warning: Only the first path encountering the conflict is reported
   {standard input}:8862: Warning: This is the location of the conflicting usage
   {standard input}:9529: Error: Register number out of range 0..3
   {standard input}:9529: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 39
   {standard input}:9529: Warning: Only the first path encountering the conflict is reported
   {standard input}:9524: Warning: This is the location of the conflicting usage
   {standard input}:9530: Error: Register number out of range 0..3
   {standard input}:9530: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 39
   {standard input}:9530: Warning: Only the first path encountering the conflict is reported
   {standard input}:9524: Warning: This is the location of the conflicting usage
   {standard input}:9530: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 39
   {standard input}:9530: Warning: Only the first path encountering the conflict is reported
   {standard input}:9529: Warning: This is the location of the conflicting usage
   {standard input}:9533: Error: Register number out of range 0..3
   {standard input}:9534: Error: Register number out of range 0..3
   {standard input}:9534: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 39
   {standard input}:9534: Warning: Only the first path encountering the conflict is reported
   {standard input}:9533: Warning: This is the location of the conflicting usage
   {standard input}:9626: Error: Register number out of range 0..3
   {standard input}:9626: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 39
   {standard input}:9621: Warning: This is the location of the conflicting usage
   {standard input}:9627: Error: Register number out of range 0..3
   {standard input}:9627: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 39
   {standard input}:9621: Warning: This is the location of the conflicting usage
   {standard input}:9627: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 39
   {standard input}:9626: Warning: This is the location of the conflicting usage
   {standard input}:9630: Error: Register number out of range 0..3
   {standard input}:9631: Error: Register number out of range 0..3
   {standard input}:9631: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 39
   {standard input}:9630: Warning: This is the location of the conflicting usage
   {standard input}:10882: Error: Register number out of range 0..6
   {standard input}:11721: Error: Register number out of range 0..4
   {standard input}:11722: Error: Register number out of range 0..4
   {standard input}:11722: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 46
   {standard input}:11722: Warning: Only the first path encountering the conflict is reported
   {standard input}:11721: Warning: This is the location of the conflicting usage
   {standard input}:11726: Error: Register number out of range 0..4
   {standard input}:12079: Error: Register number out of range 0..4
   {standard input}:12080: Error: Register number out of range 0..4
   {standard input}:12080: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 46
   {standard input}:12079: Warning: This is the location of the conflicting usage
   {standard input}:12084: Error: Register number out of range 0..4
   {standard input}:12336: Error: Register number out of range 0..4
   {standard input}:12337: Error: Register number out of range 0..4
   {standard input}:12337: Warning: Use of 'mov' violates WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 46
   {standard input}:12337: Warning: Only the first path encountering the conflict is reported
   {standard input}:12336: Warning: This is the location of the conflicting usage
   {standard input}:12341: Error: Register number out of range 0..4
>> {standard input}:12363: Error: Insn slot not set in unwind record.
   {standard input}:12363: Fatal error: Section switching in code is not supported.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
