Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B56746915B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 09:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239131AbhLFIWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 03:22:37 -0500
Received: from mga18.intel.com ([134.134.136.126]:63123 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239064AbhLFIWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 03:22:33 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="224140327"
X-IronPort-AV: E=Sophos;i="5.87,290,1631602800"; 
   d="scan'208";a="224140327"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 00:19:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,290,1631602800"; 
   d="scan'208";a="461719780"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 06 Dec 2021 00:19:00 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mu9DA-000L2K-6c; Mon, 06 Dec 2021 08:19:00 +0000
Date:   Mon, 6 Dec 2021 16:18:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/myricom/myri10ge/myri10ge.c:390:32: warning:
 'cmd.data0' is used uninitialized
Message-ID: <202112061623.Cy7sn1ra-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1
commit: 63415767a2446136372e777cde5bb351f21ec21d ethernet: myri10ge: Fix a use after free in myri10ge_sw_tso
date:   8 months ago
config: arc-buildonly-randconfig-r004-20211204 (https://download.01.org/0day-ci/archive/20211206/202112061623.Cy7sn1ra-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=63415767a2446136372e777cde5bb351f21ec21d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 63415767a2446136372e777cde5bb351f21ec21d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/net/ethernet/myricom/myri10ge/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/swab.h:5,
                    from include/uapi/linux/byteorder/little_endian.h:13,
                    from include/linux/byteorder/little_endian.h:5,
                    from arch/arc/include/uapi/asm/byteorder.h:16,
                    from include/asm-generic/bitops/le.h:6,
                    from arch/arc/include/asm/bitops.h:373,
                    from include/linux/bitops.h:32,
                    from include/linux/kernel.h:11,
                    from include/linux/skbuff.h:13,
                    from include/linux/tcp.h:17,
                    from drivers/net/ethernet/myricom/myri10ge/myri10ge.c:43:
   In function 'myri10ge_send_cmd',
       inlined from 'myri10ge_get_firmware_capabilities' at drivers/net/ethernet/myricom/myri10ge/myri10ge.c:691:11:
>> drivers/net/ethernet/myricom/myri10ge/myri10ge.c:390:32: warning: 'cmd.data0' is used uninitialized [-Wuninitialized]
     390 |         buf->data0 = htonl(data->data0);
   include/uapi/linux/swab.h:118:39: note: in definition of macro '__swab32'
     118 |         (__builtin_constant_p((__u32)(x)) ?     \
         |                                       ^
   include/linux/byteorder/generic.h:134:21: note: in expansion of macro '__cpu_to_be32'
     134 | #define ___htonl(x) __cpu_to_be32(x)
         |                     ^~~~~~~~~~~~~
   include/linux/byteorder/generic.h:139:18: note: in expansion of macro '___htonl'
     139 | #define htonl(x) ___htonl(x)
         |                  ^~~~~~~~
   drivers/net/ethernet/myricom/myri10ge/myri10ge.c:390:22: note: in expansion of macro 'htonl'
     390 |         buf->data0 = htonl(data->data0);
         |                      ^~~~~
   drivers/net/ethernet/myricom/myri10ge/myri10ge.c: In function 'myri10ge_get_firmware_capabilities':
   drivers/net/ethernet/myricom/myri10ge/myri10ge.c:686:29: note: 'cmd' declared here
     686 |         struct myri10ge_cmd cmd;
         |                             ^~~
   In file included from include/linux/swab.h:5,
                    from include/uapi/linux/byteorder/little_endian.h:13,
                    from include/linux/byteorder/little_endian.h:5,
                    from arch/arc/include/uapi/asm/byteorder.h:16,
                    from include/asm-generic/bitops/le.h:6,
                    from arch/arc/include/asm/bitops.h:373,
                    from include/linux/bitops.h:32,
                    from include/linux/kernel.h:11,
                    from include/linux/skbuff.h:13,
                    from include/linux/tcp.h:17,
                    from drivers/net/ethernet/myricom/myri10ge/myri10ge.c:43:
   In function 'myri10ge_send_cmd',
       inlined from 'myri10ge_get_firmware_capabilities' at drivers/net/ethernet/myricom/myri10ge/myri10ge.c:691:11:
>> drivers/net/ethernet/myricom/myri10ge/myri10ge.c:391:32: warning: 'cmd.data1' is used uninitialized [-Wuninitialized]
     391 |         buf->data1 = htonl(data->data1);
   include/uapi/linux/swab.h:118:39: note: in definition of macro '__swab32'
     118 |         (__builtin_constant_p((__u32)(x)) ?     \
         |                                       ^
   include/linux/byteorder/generic.h:134:21: note: in expansion of macro '__cpu_to_be32'
     134 | #define ___htonl(x) __cpu_to_be32(x)
         |                     ^~~~~~~~~~~~~
   include/linux/byteorder/generic.h:139:18: note: in expansion of macro '___htonl'
     139 | #define htonl(x) ___htonl(x)
         |                  ^~~~~~~~
   drivers/net/ethernet/myricom/myri10ge/myri10ge.c:391:22: note: in expansion of macro 'htonl'
     391 |         buf->data1 = htonl(data->data1);
         |                      ^~~~~
   drivers/net/ethernet/myricom/myri10ge/myri10ge.c: In function 'myri10ge_get_firmware_capabilities':
   drivers/net/ethernet/myricom/myri10ge/myri10ge.c:686:29: note: 'cmd' declared here
     686 |         struct myri10ge_cmd cmd;
         |                             ^~~
   In file included from include/linux/swab.h:5,
                    from include/uapi/linux/byteorder/little_endian.h:13,
                    from include/linux/byteorder/little_endian.h:5,
                    from arch/arc/include/uapi/asm/byteorder.h:16,
                    from include/asm-generic/bitops/le.h:6,
                    from arch/arc/include/asm/bitops.h:373,
                    from include/linux/bitops.h:32,
                    from include/linux/kernel.h:11,
                    from include/linux/skbuff.h:13,
                    from include/linux/tcp.h:17,
                    from drivers/net/ethernet/myricom/myri10ge/myri10ge.c:43:
   In function 'myri10ge_send_cmd',
       inlined from 'myri10ge_get_firmware_capabilities' at drivers/net/ethernet/myricom/myri10ge/myri10ge.c:691:11:
>> drivers/net/ethernet/myricom/myri10ge/myri10ge.c:392:32: warning: 'cmd.data2' is used uninitialized [-Wuninitialized]
     392 |         buf->data2 = htonl(data->data2);
   include/uapi/linux/swab.h:118:39: note: in definition of macro '__swab32'
     118 |         (__builtin_constant_p((__u32)(x)) ?     \
         |                                       ^
   include/linux/byteorder/generic.h:134:21: note: in expansion of macro '__cpu_to_be32'
     134 | #define ___htonl(x) __cpu_to_be32(x)
         |                     ^~~~~~~~~~~~~
   include/linux/byteorder/generic.h:139:18: note: in expansion of macro '___htonl'
     139 | #define htonl(x) ___htonl(x)
         |                  ^~~~~~~~
   drivers/net/ethernet/myricom/myri10ge/myri10ge.c:392:22: note: in expansion of macro 'htonl'
     392 |         buf->data2 = htonl(data->data2);
         |                      ^~~~~
   drivers/net/ethernet/myricom/myri10ge/myri10ge.c: In function 'myri10ge_get_firmware_capabilities':
   drivers/net/ethernet/myricom/myri10ge/myri10ge.c:686:29: note: 'cmd' declared here
     686 |         struct myri10ge_cmd cmd;
         |                             ^~~


vim +390 drivers/net/ethernet/myricom/myri10ge/myri10ge.c

7d3510356b066b drivers/net/myri10ge/myri10ge.c Rusty Russell 2010-08-11  375  
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  376  static int
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  377  myri10ge_send_cmd(struct myri10ge_priv *mgp, u32 cmd,
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  378  		  struct myri10ge_cmd *data, int atomic)
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  379  {
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  380  	struct mcp_cmd *buf;
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  381  	char buf_bytes[sizeof(*buf) + 8];
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  382  	struct mcp_cmd_response *response = mgp->cmd;
e700f9f4a208bf drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-08-14  383  	char __iomem *cmd_addr = mgp->sram + MXGEFW_ETH_CMD;
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  384  	u32 dma_low, dma_high, result, value;
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  385  	int sleep_total = 0;
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  386  
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  387  	/* ensure buf is aligned to 8 bytes */
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  388  	buf = (struct mcp_cmd *)ALIGN((unsigned long)buf_bytes, 8);
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  389  
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23 @390  	buf->data0 = htonl(data->data0);
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23 @391  	buf->data1 = htonl(data->data1);
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23 @392  	buf->data2 = htonl(data->data2);
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  393  	buf->cmd = htonl(cmd);
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  394  	dma_low = MYRI10GE_LOWPART_TO_U32(mgp->cmd_bus);
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  395  	dma_high = MYRI10GE_HIGHPART_TO_U32(mgp->cmd_bus);
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  396  
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  397  	buf->response_addr.low = htonl(dma_low);
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  398  	buf->response_addr.high = htonl(dma_high);
40f6cff5c47efa drivers/net/myri10ge/myri10ge.c Al Viro       2006-11-20  399  	response->result = htonl(MYRI10GE_NO_RESPONSE_RESULT);
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  400  	mb();
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  401  	myri10ge_pio_copy(cmd_addr, buf, sizeof(*buf));
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  402  
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  403  	/* wait up to 15ms. Longest command is the DMA benchmark,
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  404  	 * which is capped at 5ms, but runs from a timeout handler
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  405  	 * that runs every 7.8ms. So a 15ms timeout leaves us with
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  406  	 * a 2.2ms margin
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  407  	 */
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  408  	if (atomic) {
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  409  		/* if atomic is set, do not sleep,
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  410  		 * and try to get the completion quickly
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  411  		 * (1ms will be enough for those commands) */
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  412  		for (sleep_total = 0;
8e95a2026f3b43 drivers/net/myri10ge/myri10ge.c Joe Perches   2009-12-03  413  		     sleep_total < 1000 &&
8e95a2026f3b43 drivers/net/myri10ge/myri10ge.c Joe Perches   2009-12-03  414  		     response->result == htonl(MYRI10GE_NO_RESPONSE_RESULT);
bd2db0cf2411eb drivers/net/myri10ge/myri10ge.c Brice Goglin  2008-05-09  415  		     sleep_total += 10) {
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  416  			udelay(10);
bd2db0cf2411eb drivers/net/myri10ge/myri10ge.c Brice Goglin  2008-05-09  417  			mb();
bd2db0cf2411eb drivers/net/myri10ge/myri10ge.c Brice Goglin  2008-05-09  418  		}
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  419  	} else {
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  420  		/* use msleep for most command */
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  421  		for (sleep_total = 0;
8e95a2026f3b43 drivers/net/myri10ge/myri10ge.c Joe Perches   2009-12-03  422  		     sleep_total < 15 &&
8e95a2026f3b43 drivers/net/myri10ge/myri10ge.c Joe Perches   2009-12-03  423  		     response->result == htonl(MYRI10GE_NO_RESPONSE_RESULT);
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  424  		     sleep_total++)
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  425  			msleep(1);
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  426  	}
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  427  
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  428  	result = ntohl(response->result);
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  429  	value = ntohl(response->data);
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  430  	if (result != MYRI10GE_NO_RESPONSE_RESULT) {
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  431  		if (result == 0) {
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  432  			data->data0 = value;
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  433  			return 0;
85a7ea1b0a3263 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-08-21  434  		} else if (result == MXGEFW_CMD_UNKNOWN) {
85a7ea1b0a3263 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-08-21  435  			return -ENOSYS;
5443e9ead4f53f drivers/net/myri10ge/myri10ge.c Brice Goglin  2007-05-07  436  		} else if (result == MXGEFW_CMD_ERROR_UNALIGNED) {
5443e9ead4f53f drivers/net/myri10ge/myri10ge.c Brice Goglin  2007-05-07  437  			return -E2BIG;
236bb5e649c2a7 drivers/net/myri10ge/myri10ge.c Brice Goglin  2008-09-28  438  		} else if (result == MXGEFW_CMD_ERROR_RANGE &&
236bb5e649c2a7 drivers/net/myri10ge/myri10ge.c Brice Goglin  2008-09-28  439  			   cmd == MXGEFW_CMD_ENABLE_RSS_QUEUES &&
236bb5e649c2a7 drivers/net/myri10ge/myri10ge.c Brice Goglin  2008-09-28  440  			   (data->
236bb5e649c2a7 drivers/net/myri10ge/myri10ge.c Brice Goglin  2008-09-28  441  			    data1 & MXGEFW_SLICE_ENABLE_MULTIPLE_TX_QUEUES) !=
236bb5e649c2a7 drivers/net/myri10ge/myri10ge.c Brice Goglin  2008-09-28  442  			   0) {
236bb5e649c2a7 drivers/net/myri10ge/myri10ge.c Brice Goglin  2008-09-28  443  			return -ERANGE;
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  444  		} else {
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  445  			dev_err(&mgp->pdev->dev,
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  446  				"command %d failed, result = %d\n",
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  447  				cmd, result);
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  448  			return -ENXIO;
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  449  		}
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  450  	}
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  451  
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  452  	dev_err(&mgp->pdev->dev, "command %d timed out, result = %d\n",
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  453  		cmd, result);
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  454  	return -EAGAIN;
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  455  }
0da34b6dfe5581 drivers/net/myri10ge/myri10ge.c Brice Goglin  2006-05-23  456  

:::::: The code at line 390 was first introduced by commit
:::::: 0da34b6dfe55810ae60db57e08e2af8a808c0a55 [PATCH] Add Myri-10G Ethernet driver

:::::: TO: Brice Goglin <brice@myri.com>
:::::: CC: Jeff Garzik <jeff@garzik.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
