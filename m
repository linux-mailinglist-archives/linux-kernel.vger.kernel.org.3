Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2134C7524
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 18:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238881AbiB1RvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 12:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239960AbiB1Ro4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:44:56 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B929625C67
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646069844; x=1677605844;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=otMrQcJF+SpZJz5Bqs02HUjndBH02zw57A9ihjLnzBE=;
  b=azqRs5CcsBXxDZcG3gpIkezdbmGGQi9hqY4ir/AdeD8/NJimigV1e27p
   gkFYcdF02i1oTJamD5nAxFx3SiBvkcJeIRN4G65HosdAO1V1cNBkUT++S
   +0RfiBNAR8hQjF3ZBScbtIeTeOGtvLSrc2pu68/oMQvZE4pVdLsT0+kG9
   5q1RgzWj0xd+JIag8y98px/K+4cvLvwfzP64NzVrw3ePFnPNzg2JROxso
   R1W3uTbb58BDBpb6usbv2vsVzvfCRfQLPmI39oDYae/67l7SgiLhSSlCK
   qLhvg2gOeReLV31bzNON45kvK+R9Dvhfd04Sg8ad0Qqk3kmuBxsM7xxgJ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="252865639"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="252865639"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 09:37:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="629712522"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Feb 2022 09:37:20 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOjxS-0007cR-LK; Mon, 28 Feb 2022 17:37:14 +0000
Date:   Tue, 1 Mar 2022 01:36:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhenguo Yao <yaozhenguo1@gmail.com>, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com
Cc:     kbuild-all@lists.01.org, nvdimm@lists.linux.dev, yaozhenguo@jd.com,
        linux-kernel@vger.kernel.org, Zhenguo Yao <yaozhenguo1@gmail.com>
Subject: Re: [PATCH v1] device-dax: Adding match parameter to select which
 driver to match dax devices
Message-ID: <202203010043.CdGByjRQ-lkp@intel.com>
References: <20220228094938.32153-1-yaozhenguo1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228094938.32153-1-yaozhenguo1@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhenguo,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.17-rc6 next-20220225]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Zhenguo-Yao/device-dax-Adding-match-parameter-to-select-which-driver-to-match-dax-devices/20220228-175040
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3
config: arm64-randconfig-r006-20220227 (https://download.01.org/0day-ci/archive/20220301/202203010043.CdGByjRQ-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/5be3350fe78893555785550e6fdf382715c2dca9
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Zhenguo-Yao/device-dax-Adding-match-parameter-to-select-which-driver-to-match-dax-devices/20220228-175040
        git checkout 5be3350fe78893555785550e6fdf382715c2dca9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> aarch64-linux-ld: drivers/dax/kmem.o:(.bss+0x10): multiple definition of `match'; drivers/dax/device.o:(.data+0xb8): first defined here

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
