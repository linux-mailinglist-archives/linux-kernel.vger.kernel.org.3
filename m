Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7AD4FE5E9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 18:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348084AbiDLQeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 12:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243406AbiDLQed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 12:34:33 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33F05DE6D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 09:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649781134; x=1681317134;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KHX2L3FCEjjS2GpVNfVcIgf1yeK+WvX/Qvr9mamnz2o=;
  b=AeRXR0LPb+STNjWzV5njT/oWMLHWbcQg8DQDrxrKF7ttaMYUaIonaB9O
   EAJ2lqYm3qX0KZATcNDWCYwYJI3sEz2PNy2UTGk0WI/4NBY63IYhZwW44
   qGnkug/LU6yAoChEJQPPXuorz1kN1TQPZNmSI2hvsT9keCWkkSVAtIoVL
   1KuH2r83pWt1ryUxo5Jzu6EM4hGjamqeU9nQUi1cGZi/sYiklS2xI6tXt
   YvF9ltDBt4A2kvqV541dv0d9YElCH4ASyGCWJs2gZsFst7WzcvvybGjPo
   1BhUBoCQSZHqtVWx9Rt/8qhYn47BOIIMRMZCI98E0gTQ1ti74E7WCFKtK
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="322872818"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="322872818"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 09:17:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="551780219"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 12 Apr 2022 09:17:19 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neJCh-0002z3-6E;
        Tue, 12 Apr 2022 16:17:19 +0000
Date:   Wed, 13 Apr 2022 00:16:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jirislaby:devel 48/48] drivers/tty/serial/atmel_serial.c:981:24:
 warning: variable 'tx_len' is uninitialized when used here
Message-ID: <202204130036.n7mzFmFK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git devel
head:   ea94a80635daaf36a289f1ec1f982b1e094faeca
commit: ea94a80635daaf36a289f1ec1f982b1e094faeca [48/48] tty: serial, use kfifo
config: hexagon-randconfig-r045-20220411 (https://download.01.org/0day-ci/archive/20220413/202204130036.n7mzFmFK-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project fe2478d44e4f7f191c43fef629ac7a23d0251e72)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=ea94a80635daaf36a289f1ec1f982b1e094faeca
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby devel
        git checkout ea94a80635daaf36a289f1ec1f982b1e094faeca
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/tty/serial/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/tty/serial/atmel_serial.c:981:24: warning: variable 'tx_len' is uninitialized when used here [-Wuninitialized]
                   atmel_port->tx_len = tx_len;
                                        ^~~~~~
   drivers/tty/serial/atmel_serial.c:927:21: note: initialize the variable 'tx_len' to silence this warning
           unsigned int tx_len, /*part1_len, part2_len,*/ sg_len;
                              ^
                               = 0
   drivers/tty/serial/atmel_serial.c:985:13: warning: variable 'sg_len' is uninitialized when used here [-Wuninitialized]
                                                  sg_len,
                                                  ^~~~~~
   drivers/tty/serial/atmel_serial.c:927:55: note: initialize the variable 'sg_len' to silence this warning
           unsigned int tx_len, /*part1_len, part2_len,*/ sg_len;
                                                                ^
                                                                 = 0
   2 warnings generated.


vim +/tx_len +981 drivers/tty/serial/atmel_serial.c

5f258b3e3d223b Cyrille Pitchen 2015-07-02   976  
5f258b3e3d223b Cyrille Pitchen 2015-07-02   977  		/*
5f258b3e3d223b Cyrille Pitchen 2015-07-02   978  		 * save tx_len so atmel_complete_tx_dma() will increase
5f258b3e3d223b Cyrille Pitchen 2015-07-02   979  		 * xmit->tail correctly
5f258b3e3d223b Cyrille Pitchen 2015-07-02   980  		 */
5f258b3e3d223b Cyrille Pitchen 2015-07-02  @981  		atmel_port->tx_len = tx_len;
08f738be88bb7a Elen Song       2013-07-22   982  
08f738be88bb7a Elen Song       2013-07-22   983  		desc = dmaengine_prep_slave_sg(chan,
5f258b3e3d223b Cyrille Pitchen 2015-07-02   984  					       sgl,
5f258b3e3d223b Cyrille Pitchen 2015-07-02   985  					       sg_len,
08f738be88bb7a Elen Song       2013-07-22   986  					       DMA_MEM_TO_DEV,
08f738be88bb7a Elen Song       2013-07-22   987  					       DMA_PREP_INTERRUPT |
08f738be88bb7a Elen Song       2013-07-22   988  					       DMA_CTRL_ACK);
08f738be88bb7a Elen Song       2013-07-22   989  		if (!desc) {
08f738be88bb7a Elen Song       2013-07-22   990  			dev_err(port->dev, "Failed to send via dma!\n");
08f738be88bb7a Elen Song       2013-07-22   991  			return;
08f738be88bb7a Elen Song       2013-07-22   992  		}
08f738be88bb7a Elen Song       2013-07-22   993  
5f258b3e3d223b Cyrille Pitchen 2015-07-02   994  		dma_sync_sg_for_device(port->dev, sg_tx, 1, DMA_TO_DEVICE);
08f738be88bb7a Elen Song       2013-07-22   995  
08f738be88bb7a Elen Song       2013-07-22   996  		atmel_port->desc_tx = desc;
08f738be88bb7a Elen Song       2013-07-22   997  		desc->callback = atmel_complete_tx_dma;
08f738be88bb7a Elen Song       2013-07-22   998  		desc->callback_param = atmel_port;
08f738be88bb7a Elen Song       2013-07-22   999  		atmel_port->cookie_tx = dmaengine_submit(desc);
1e67bd2b8cb90b Tudor Ambarus   2021-11-25  1000  		if (dma_submit_error(atmel_port->cookie_tx)) {
1e67bd2b8cb90b Tudor Ambarus   2021-11-25  1001  			dev_err(port->dev, "dma_submit_error %d\n",
1e67bd2b8cb90b Tudor Ambarus   2021-11-25  1002  				atmel_port->cookie_tx);
1e67bd2b8cb90b Tudor Ambarus   2021-11-25  1003  			return;
1e67bd2b8cb90b Tudor Ambarus   2021-11-25  1004  		}
4f4b9b5895614e Tudor Ambarus   2021-11-25  1005  
4f4b9b5895614e Tudor Ambarus   2021-11-25  1006  		dma_async_issue_pending(chan);
08f738be88bb7a Elen Song       2013-07-22  1007  	}
08f738be88bb7a Elen Song       2013-07-22  1008  
ea94a80635daaf Jiri Slaby      2022-01-05  1009  	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
08f738be88bb7a Elen Song       2013-07-22  1010  		uart_write_wakeup(port);
08f738be88bb7a Elen Song       2013-07-22  1011  }
08f738be88bb7a Elen Song       2013-07-22  1012  

:::::: The code at line 981 was first introduced by commit
:::::: 5f258b3e3d223b5cb6d1753b2f9b821ba4455f81 tty/serial: at91: use 32bit writes into TX FIFO when DMA is enabled

:::::: TO: Cyrille Pitchen <cyrille.pitchen@atmel.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
