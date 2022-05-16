Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F8252831C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 13:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243056AbiEPLXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 07:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243029AbiEPLXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 07:23:34 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3012238785
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 04:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652700213; x=1684236213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=J11eG9Z8B4HYN0ujde5sOnR2ETQToSb8LLwMG0HWeUg=;
  b=aJVDARMJJYTqCXhkvbl7j4GAjOtBWIhuwpH/VJxvehajEgOcvPqxEhOf
   7bJUzTN1mfqWvNVbEN7MLGaayyvbK5dD3Ci2denHw9Xl3rMavaPb2dcF6
   c+UftroZBFhBTKHL4LfSneQdi4nEEnxfUZ5J3M+RriY980fc/ENYtt2yp
   /q1LsgAj/604ffZxHwGQqrlENXcA5dmTkS/Qa/Hj0OeLP4VcRawF3wUbi
   JWjE4wX7k+hRgfC+V3WnnARIHZOyqYo8pU0oV70gcTexmGr+cF+NkReSr
   +AH8JdPUROAI9wCa6mSCDLllFocbOiSg4xFpQEGZJ82KHkhmPDgxQEfph
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="269628654"
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="269628654"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 04:23:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="555204817"
Received: from lkp-server02.sh.intel.com (HELO 0628dcddc537) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 16 May 2022 04:23:29 -0700
Received: from kbuild by 0628dcddc537 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqYoy-000037-D0;
        Mon, 16 May 2022 11:23:28 +0000
Date:   Mon, 16 May 2022 19:23:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?utf-8?B?WWHFn2FyIEFyYWJhY8Sx?= <yasar11732@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        paulo.miguel.almeida.rodenas@gmail.com, dan.carpenter@oracle.com,
        alexandre.belloni@bootlin.com, realwakka@gmail.com,
        u.kleine-koenig@pengutronix.de, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?WWHFn2FyIEFyYWJhY8Sx?= <yasar11732@gmail.com>
Subject: Re: [PATCH] Staging: pi433: Don't use ioctl for per-client
 configuration
Message-ID: <202205161930.aGSjQp2u-lkp@intel.com>
References: <20220515104711.94567-1-yasar11732@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220515104711.94567-1-yasar11732@gmail.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Yaşar,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Ya-ar-Arabac/Staging-pi433-Don-t-use-ioctl-for-per-client-configuration/20220515-185057
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git e41f7a5521d7f03dca99e3207633df71740569dd
config: riscv-randconfig-r036-20220516 (https://download.01.org/0day-ci/archive/20220516/202205161930.aGSjQp2u-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 853fa8ee225edf2d0de94b0dcbd31bea916e825e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/0cfbff215eb0e9e558af6b491d319fc736a927c6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ya-ar-Arabac/Staging-pi433-Don-t-use-ioctl-for-per-client-configuration/20220515-185057
        git checkout 0cfbff215eb0e9e558af6b491d319fc736a927c6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/staging/pi433/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/staging/pi433/pi433_if.c:832:4: warning: variable 'required' is uninitialized when used here [-Wuninitialized]
                           required, available);
                           ^~~~~~~~
   include/linux/dev_printk.h:155:39: note: expanded from macro 'dev_dbg'
           dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                ^~~~~~~~~~~
   include/linux/dynamic_debug.h:167:19: note: expanded from macro 'dynamic_dev_dbg'
                              dev, fmt, ##__VA_ARGS__)
                                          ^~~~~~~~~~~
   include/linux/dynamic_debug.h:152:56: note: expanded from macro '_dynamic_func_call'
           __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
                                                                 ^~~~~~~~~~~
   include/linux/dynamic_debug.h:134:15: note: expanded from macro '__dynamic_func_call'
                   func(&id, ##__VA_ARGS__);               \
                               ^~~~~~~~~~~
   drivers/staging/pi433/pi433_if.c:801:24: note: initialize the variable 'required' to silence this warning
           unsigned int            required, available, copied;
                                           ^
                                            = 0
   1 warning generated.


vim +/required +832 drivers/staging/pi433/pi433_if.c

874bcba65f9a3a Marcus Wolf          2017-07-16  792  
874bcba65f9a3a Marcus Wolf          2017-07-16  793  static ssize_t
874bcba65f9a3a Marcus Wolf          2017-07-16  794  pi433_write(struct file *filp, const char __user *buf,
874bcba65f9a3a Marcus Wolf          2017-07-16  795  	    size_t count, loff_t *f_pos)
874bcba65f9a3a Marcus Wolf          2017-07-16  796  {
874bcba65f9a3a Marcus Wolf          2017-07-16  797  	struct pi433_instance	*instance;
0cfbff215eb0e9 Yaşar Arabacı        2022-05-15  798  	struct pi433_tx_cfg *tx_cfg;
874bcba65f9a3a Marcus Wolf          2017-07-16  799  	struct pi433_device	*device;
57f8965af417f9 Stefano Manni        2017-11-16  800  	int                     retval;
5451dab9b7f546 Valentin Vidic       2018-04-19  801  	unsigned int		required, available, copied;
874bcba65f9a3a Marcus Wolf          2017-07-16  802  
874bcba65f9a3a Marcus Wolf          2017-07-16  803  	instance = filp->private_data;
874bcba65f9a3a Marcus Wolf          2017-07-16  804  	device = instance->device;
874bcba65f9a3a Marcus Wolf          2017-07-16  805  
63688e61d5629c Sophie Matter        2018-07-11  806  	/*
63688e61d5629c Sophie Matter        2018-07-11  807  	 * check, whether internal buffer (tx thread) is big enough
63688e61d5629c Sophie Matter        2018-07-11  808  	 * for requested size
63688e61d5629c Sophie Matter        2018-07-11  809  	 */
0cfbff215eb0e9 Yaşar Arabacı        2022-05-15  810  	if (unlikely(count > MAX_MSG_SIZE))
874bcba65f9a3a Marcus Wolf          2017-07-16  811  		return -EMSGSIZE;
874bcba65f9a3a Marcus Wolf          2017-07-16  812  
0cfbff215eb0e9 Yaşar Arabacı        2022-05-15  813  	if (unlikely(count < sizeof(struct pi433_tx_cfg)))
0cfbff215eb0e9 Yaşar Arabacı        2022-05-15  814  		return -EMSGSIZE;
0cfbff215eb0e9 Yaşar Arabacı        2022-05-15  815  
0cfbff215eb0e9 Yaşar Arabacı        2022-05-15  816  	tx_cfg = (struct pi433_tx_cfg *)buf;
0cfbff215eb0e9 Yaşar Arabacı        2022-05-15  817  
0cfbff215eb0e9 Yaşar Arabacı        2022-05-15  818  	if (unlikely(count != sizeof(struct pi433_tx_cfg)) + tx_cfg->payload_size)
0cfbff215eb0e9 Yaşar Arabacı        2022-05-15  819  		return -EMSGSIZE;
ce514dadc61a53 Paulo Miguel Almeida 2022-01-15  820  
63688e61d5629c Sophie Matter        2018-07-11  821  	/*
63688e61d5629c Sophie Matter        2018-07-11  822  	 * write the following sequence into fifo:
056eeda2f9e637 Derek Robson         2017-07-22  823  	 * - tx_cfg
056eeda2f9e637 Derek Robson         2017-07-22  824  	 * - size of message
056eeda2f9e637 Derek Robson         2017-07-22  825  	 * - message
056eeda2f9e637 Derek Robson         2017-07-22  826  	 */
874bcba65f9a3a Marcus Wolf          2017-07-16  827  	mutex_lock(&device->tx_fifo_lock);
5451dab9b7f546 Valentin Vidic       2018-04-19  828  
5451dab9b7f546 Valentin Vidic       2018-04-19  829  	available = kfifo_avail(&device->tx_fifo);
0cfbff215eb0e9 Yaşar Arabacı        2022-05-15  830  	if (count > available) {
1b6a6147374eb3 Paulo Miguel Almeida 2022-02-07  831  		dev_dbg(device->dev, "write to fifo failed: %d bytes required but %d available\n",
5451dab9b7f546 Valentin Vidic       2018-04-19 @832  			required, available);
5451dab9b7f546 Valentin Vidic       2018-04-19  833  		mutex_unlock(&device->tx_fifo_lock);
5451dab9b7f546 Valentin Vidic       2018-04-19  834  		return -EAGAIN;
5451dab9b7f546 Valentin Vidic       2018-04-19  835  	}
5451dab9b7f546 Valentin Vidic       2018-04-19  836  
874bcba65f9a3a Marcus Wolf          2017-07-16  837  	retval = kfifo_from_user(&device->tx_fifo, buf, count, &copied);
874bcba65f9a3a Marcus Wolf          2017-07-16  838  	if (retval || copied != count)
874bcba65f9a3a Marcus Wolf          2017-07-16  839  		goto abort;
874bcba65f9a3a Marcus Wolf          2017-07-16  840  
874bcba65f9a3a Marcus Wolf          2017-07-16  841  	mutex_unlock(&device->tx_fifo_lock);
874bcba65f9a3a Marcus Wolf          2017-07-16  842  
874bcba65f9a3a Marcus Wolf          2017-07-16  843  	/* start transfer */
874bcba65f9a3a Marcus Wolf          2017-07-16  844  	wake_up_interruptible(&device->tx_wait_queue);
1b6a6147374eb3 Paulo Miguel Almeida 2022-02-07  845  	dev_dbg(device->dev, "write: generated new msg with %d bytes.\n", copied);
874bcba65f9a3a Marcus Wolf          2017-07-16  846  
dd1114693bcc7d Oliver Graute        2017-12-19  847  	return copied;
874bcba65f9a3a Marcus Wolf          2017-07-16  848  
874bcba65f9a3a Marcus Wolf          2017-07-16  849  abort:
5451dab9b7f546 Valentin Vidic       2018-04-19  850  	dev_warn(device->dev,
1b6a6147374eb3 Paulo Miguel Almeida 2022-02-07  851  		 "write to fifo failed, non recoverable: 0x%x\n", retval);
874bcba65f9a3a Marcus Wolf          2017-07-16  852  	mutex_unlock(&device->tx_fifo_lock);
874bcba65f9a3a Marcus Wolf          2017-07-16  853  	return -EAGAIN;
874bcba65f9a3a Marcus Wolf          2017-07-16  854  }
874bcba65f9a3a Marcus Wolf          2017-07-16  855  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
