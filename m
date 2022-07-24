Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7C157F360
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 07:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbiGXFkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 01:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbiGXFko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 01:40:44 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A849D140AC
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 22:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658641243; x=1690177243;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3nI5X01Dh6IyD7hFrhUwCh3/XGjZuDdxbiFmhDVbdQI=;
  b=EMnmc1ncUjGBqXJeNgIAYrXiUCDE0dnjNzLe4MF6Rf9IPmMUDIG7+hmZ
   MbjY4DiC23iEZSYKfl1uGdQ8b71S/Ke4lr/+u7XRam9TwOGYUNp+RNrQp
   TizqRoSNEgkmnNsC/Fgwxi65Qa844h5oPFtQC50p2oYWUcq/G2irYOQkn
   jdY8blDLQ9ab/XJ05B5bOzdO36yrdXdXMHFR4FUPThIcFCBqpKyzJwIs2
   kYt+ySkTbLZ+dAiPDd01fPRp5s/AxJjumI4waDYjiDVojeTDPR3/lFhR5
   4Ci++dNJBFf3U6u4XRYEUqy6uZZxD7+pvfv0oZ3EQiC2yqa9ImPWHII80
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="286276459"
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="286276459"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 22:40:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="667104768"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jul 2022 22:40:41 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFUM4-0003bV-2K;
        Sun, 24 Jul 2022 05:40:40 +0000
Date:   Sun, 24 Jul 2022 13:39:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dennis Cagle <d-cagle@codeaurora.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [linux-stable-rc:linux-4.9.y 967/2229]
 drivers/staging/android/ion/ion-ioctl.c:71:6: warning: variable 'ret' is
 used uninitialized whenever 'if' condition is false
Message-ID: <202207241311.Dv86CbAo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
head:   65be5f5665a580424a7b1102f1a04c4259c559b5
commit: a8200613c8c9fbaf7b55d4d438376ebaf0c4ce7e [967/2229] ion: Protect kref from userspace manipulation
config: mips-randconfig-r034-20220719 (https://download.01.org/0day-ci/archive/20220724/202207241311.Dv86CbAo-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project fa0c7639e91fa1cd0cf2ff0445a1634a90fe850a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mipsel-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=a8200613c8c9fbaf7b55d4d438376ebaf0c4ce7e
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-4.9.y
        git checkout a8200613c8c9fbaf7b55d4d438376ebaf0c4ce7e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/staging/android/ion/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/staging/android/ion/ion-ioctl.c:71:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (--handle->user_ref_count == 0)
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/android/ion/ion-ioctl.c:74:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/staging/android/ion/ion-ioctl.c:71:2: note: remove the 'if' if its condition is always true
           if (--handle->user_ref_count == 0)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/android/ion/ion-ioctl.c:69:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   1 warning generated.


vim +71 drivers/staging/android/ion/ion-ioctl.c

    65	
    66	/* Must hold the client lock */
    67	static int user_ion_handle_put_nolock(struct ion_handle *handle)
    68	{
    69		int ret;
    70	
  > 71		if (--handle->user_ref_count == 0)
    72			ret = ion_handle_put_nolock(handle);
    73	
    74		return ret;
    75	}
    76	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
