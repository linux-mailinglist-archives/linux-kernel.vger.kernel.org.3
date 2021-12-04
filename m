Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E7F468730
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 20:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348573AbhLDT12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 14:27:28 -0500
Received: from mga04.intel.com ([192.55.52.120]:18469 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347719AbhLDT11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 14:27:27 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10188"; a="235876561"
X-IronPort-AV: E=Sophos;i="5.87,288,1631602800"; 
   d="scan'208";a="235876561"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2021 11:24:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,288,1631602800"; 
   d="scan'208";a="461339091"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 04 Dec 2021 11:23:59 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtadb-000JLm-2c; Sat, 04 Dec 2021 19:23:59 +0000
Date:   Sun, 5 Dec 2021 03:23:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     M Chetan Kumar <m.chetan.kumar@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/wwan/iosm/iosm_ipc_mux_codec.c:833:21: sparse: sparse:
 Using plain integer as NULL pointer
Message-ID: <202112050318.uBUvlyTo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bbef3c7a63d2a4cb0f3f839db9e767f168c5e348
commit: f7af616c632ee2ac3af0876fe33bf9e0232e665a net: iosm: infrastructure
date:   6 months ago
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20211205/202112050318.uBUvlyTo-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f7af616c632ee2ac3af0876fe33bf9e0232e665a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f7af616c632ee2ac3af0876fe33bf9e0232e665a
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/wwan/iosm/ drivers/staging/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/net/wwan/iosm/iosm_ipc_mux_codec.c:833:21: sparse: sparse: Using plain integer as NULL pointer

vim +833 drivers/net/wwan/iosm/iosm_ipc_mux_codec.c

9413491e20e1ab M Chetan Kumar 2021-06-13  814  
9413491e20e1ab M Chetan Kumar 2021-06-13  815  void ipc_mux_ul_encoded_process(struct iosm_mux *ipc_mux, struct sk_buff *skb)
9413491e20e1ab M Chetan Kumar 2021-06-13  816  {
9413491e20e1ab M Chetan Kumar 2021-06-13  817  	struct mux_adgh *adgh;
9413491e20e1ab M Chetan Kumar 2021-06-13  818  	u16 adgh_len;
9413491e20e1ab M Chetan Kumar 2021-06-13  819  
9413491e20e1ab M Chetan Kumar 2021-06-13  820  	adgh = (struct mux_adgh *)skb->data;
9413491e20e1ab M Chetan Kumar 2021-06-13  821  	adgh_len = le16_to_cpu(adgh->length);
9413491e20e1ab M Chetan Kumar 2021-06-13  822  
9413491e20e1ab M Chetan Kumar 2021-06-13  823  	if (adgh->signature == cpu_to_le32(MUX_SIG_ADGH) &&
9413491e20e1ab M Chetan Kumar 2021-06-13  824  	    ipc_mux->ul_flow == MUX_UL)
9413491e20e1ab M Chetan Kumar 2021-06-13  825  		ipc_mux->ul_data_pend_bytes = ipc_mux->ul_data_pend_bytes -
9413491e20e1ab M Chetan Kumar 2021-06-13  826  					      adgh_len;
9413491e20e1ab M Chetan Kumar 2021-06-13  827  
9413491e20e1ab M Chetan Kumar 2021-06-13  828  	if (ipc_mux->ul_flow == MUX_UL)
9413491e20e1ab M Chetan Kumar 2021-06-13  829  		dev_dbg(ipc_mux->dev, "ul_data_pend_bytes: %lld",
9413491e20e1ab M Chetan Kumar 2021-06-13  830  			ipc_mux->ul_data_pend_bytes);
9413491e20e1ab M Chetan Kumar 2021-06-13  831  
9413491e20e1ab M Chetan Kumar 2021-06-13  832  	/* Reset the skb settings. */
9413491e20e1ab M Chetan Kumar 2021-06-13 @833  	skb->tail = 0;
9413491e20e1ab M Chetan Kumar 2021-06-13  834  	skb->len = 0;
9413491e20e1ab M Chetan Kumar 2021-06-13  835  
9413491e20e1ab M Chetan Kumar 2021-06-13  836  	/* Add the consumed ADB to the free list. */
9413491e20e1ab M Chetan Kumar 2021-06-13  837  	skb_queue_tail((&ipc_mux->ul_adb.free_list), skb);
9413491e20e1ab M Chetan Kumar 2021-06-13  838  }
9413491e20e1ab M Chetan Kumar 2021-06-13  839  

:::::: The code at line 833 was first introduced by commit
:::::: 9413491e20e1aba6e471d90c19cc43e523216a4d net: iosm: encode or decode datagram

:::::: TO: M Chetan Kumar <m.chetan.kumar@intel.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
