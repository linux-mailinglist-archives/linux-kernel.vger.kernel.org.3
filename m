Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B91057F6B7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 21:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiGXTo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 15:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiGXToY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 15:44:24 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49006DF7D
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 12:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658691863; x=1690227863;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tQKpN6ikynGTSGkv/G/Uuuz7oZm68bMYo/lj8l6Ddc4=;
  b=Hf7sXlJn+gTLy8ic1QHURiXbW/GlDbH9ZFXlMnHbr3P84MrZ6whBSysW
   Zr74Q60jxCTES6tgR0XREWK6fbZ8Mgq9ou63x4/305zDWWY5d1M3QZOZ8
   W4F3JFYWV1PrEEGXsOhxF6jIfS/qSFqJuWSjE0QZ1myyo4UOpCjm5KCqq
   /VCpP5TcRqR1OwGCT5br7oscVFl2gPiVOsEI/1EUyEFi8fFEUkXia+L8J
   1czRZTe0GcnF9qZ2yiIxQGNDO/7ImJVwivns7pxpkJ60FA0ZRimW3OxYX
   OTU0FM8XptS//R2NZ3sl7KMXwNzOo/HQC3Ex1bsp4HiIORxEsSdoy5WoB
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="288751388"
X-IronPort-AV: E=Sophos;i="5.93,191,1654585200"; 
   d="scan'208";a="288751388"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 12:44:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,191,1654585200"; 
   d="scan'208";a="845292578"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 24 Jul 2022 12:44:20 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFhWV-0004CX-2M;
        Sun, 24 Jul 2022 19:44:19 +0000
Date:   Mon, 25 Jul 2022 03:44:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Kalle Valo <quic_kvalo@quicinc.com>
Subject: [ammarfaizi2-block:kvalo/ath/pending 3/9]
 drivers/net/wireless/ath/wil6210/debugfs.c:1030:9: warning: variable 'rc' is
 uninitialized when used here
Message-ID: <202207250332.5ud26AGE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block kvalo/ath/pending
head:   086f67ba21ede199307e78476353bda9ffef982c
commit: 7a4836560a6198d245d5732e26f94898b12eb760 [3/9] wifi: wil6210: debugfs: fix info leak in wil_write_file_wmi()
config: powerpc-randconfig-r002-20220718 (https://download.01.org/0day-ci/archive/20220725/202207250332.5ud26AGE-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d74b88c69dc2644bd0dc5d64e2d7413a0d4040e5)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/7a4836560a6198d245d5732e26f94898b12eb760
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block kvalo/ath/pending
        git checkout 7a4836560a6198d245d5732e26f94898b12eb760
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/net/wireless/ath/wil6210/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/ath/wil6210/debugfs.c:1030:9: warning: variable 'rc' is uninitialized when used here [-Wuninitialized]
           return rc;
                  ^~
   drivers/net/wireless/ath/wil6210/debugfs.c:1013:8: note: initialize the variable 'rc' to silence this warning
           int rc, rc1;
                 ^
                  = 0
   1 warning generated.


vim +/rc +1030 drivers/net/wireless/ath/wil6210/debugfs.c

2be7d22f062535 Vladimir Kondratiev 2012-12-20  1000  
ff974e40833413 Vladimir Kondratiev 2014-06-16  1001  /* Write WMI command (w/o mbox header) to this file to send it
ff974e40833413 Vladimir Kondratiev 2014-06-16  1002   * WMI starts from wil6210_mbox_hdr_wmi header
ff974e40833413 Vladimir Kondratiev 2014-06-16  1003   */
ff974e40833413 Vladimir Kondratiev 2014-06-16  1004  static ssize_t wil_write_file_wmi(struct file *file, const char __user *buf,
ff974e40833413 Vladimir Kondratiev 2014-06-16  1005  				  size_t len, loff_t *ppos)
ff974e40833413 Vladimir Kondratiev 2014-06-16  1006  {
ff974e40833413 Vladimir Kondratiev 2014-06-16  1007  	struct wil6210_priv *wil = file->private_data;
e00243fab84b4e Lior David          2018-02-26  1008  	struct wil6210_vif *vif = ndev_to_vif(wil->main_ndev);
b874ddecae0a08 Lior David          2016-03-01  1009  	struct wmi_cmd_hdr *wmi;
ff974e40833413 Vladimir Kondratiev 2014-06-16  1010  	void *cmd;
b874ddecae0a08 Lior David          2016-03-01  1011  	int cmdlen = len - sizeof(struct wmi_cmd_hdr);
ff974e40833413 Vladimir Kondratiev 2014-06-16  1012  	u16 cmdid;
ff974e40833413 Vladimir Kondratiev 2014-06-16  1013  	int rc, rc1;
ff974e40833413 Vladimir Kondratiev 2014-06-16  1014  
7a4836560a6198 Dan Carpenter       2022-07-15  1015  	if (cmdlen < 0 || *ppos != 0)
ff974e40833413 Vladimir Kondratiev 2014-06-16  1016  		return -EINVAL;
ff974e40833413 Vladimir Kondratiev 2014-06-16  1017  
7a4836560a6198 Dan Carpenter       2022-07-15  1018  	wmi = memdup_user(buf, len);
7a4836560a6198 Dan Carpenter       2022-07-15  1019  	if (IS_ERR(wmi))
7a4836560a6198 Dan Carpenter       2022-07-15  1020  		return PTR_ERR(wmi);
ff974e40833413 Vladimir Kondratiev 2014-06-16  1021  
69218a48005d0c Lior David          2016-03-21  1022  	cmd = (cmdlen > 0) ? &wmi[1] : NULL;
b874ddecae0a08 Lior David          2016-03-01  1023  	cmdid = le16_to_cpu(wmi->command_id);
ff974e40833413 Vladimir Kondratiev 2014-06-16  1024  
e00243fab84b4e Lior David          2018-02-26  1025  	rc1 = wmi_send(wil, cmdid, vif->mid, cmd, cmdlen);
ff974e40833413 Vladimir Kondratiev 2014-06-16  1026  	kfree(wmi);
ff974e40833413 Vladimir Kondratiev 2014-06-16  1027  
af3db60a30331d Lazar Alexei        2017-01-20  1028  	wil_info(wil, "0x%04x[%d] -> %d\n", cmdid, cmdlen, rc1);
ff974e40833413 Vladimir Kondratiev 2014-06-16  1029  
ff974e40833413 Vladimir Kondratiev 2014-06-16 @1030  	return rc;
ff974e40833413 Vladimir Kondratiev 2014-06-16  1031  }
ff974e40833413 Vladimir Kondratiev 2014-06-16  1032  

:::::: The code at line 1030 was first introduced by commit
:::::: ff974e4083341383d3dd4079e52ed30f57f376f0 wil6210: debugfs interface to send raw WMI command

:::::: TO: Vladimir Kondratiev <qca_vkondrat@qca.qualcomm.com>
:::::: CC: John W. Linville <linville@tuxdriver.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
