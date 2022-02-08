Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6B64ADFB7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 18:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352835AbiBHRea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 12:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352792AbiBHRe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 12:34:27 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C6EC061578;
        Tue,  8 Feb 2022 09:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644341666; x=1675877666;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KkloPP/K7N4qIwGXeUPEt/qTLkJBInnSrpG7Dur3z3U=;
  b=E2EdfGQ3se5jnHRG+oXbu04U5a4eEyRVbaId3E4N5npiTusXKNIUiSXv
   6uhW3cXEIFk5CQzsyzCsf96AysGzsBOlELWeDgwWIEFLz6LmZr7WHLIka
   xL4K3hASe3OSDPNpLOJA5+YNOc5frdgMd8wjnMzJblOcVKyPZ9Ftot8ZX
   pfkUbUW2Aye3q29TVgsdGb/nddWd6jxx301cy/ML0jwsfb7tRw6i25x46
   Pc+ORuw44Xn9Pz9KyH/Ud1MB8CTcMV5cWmw75U5c6ifXqr+6PHMgJ8lYX
   HFa2RDJDnp6U6bDSpARVIcE4sX+BQ4m4GAKaTXQMXduYiKmJlqBhfgx4V
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="335409074"
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="335409074"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 09:34:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="499641130"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 08 Feb 2022 09:33:59 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHUNL-0000W8-8d; Tue, 08 Feb 2022 17:33:59 +0000
Date:   Wed, 9 Feb 2022 01:33:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wojciech Ziemba <wojciech.ziemba@intel.com>,
        herbert@gondor.apana.org.au
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Marcinx Malinowski <marcinx.malinowski@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Marco Chiappero <marco.chiappero@intel.com>
Subject: Re: [PATCH 3/3] crypto: qat - enable power management for QAT GEN4
Message-ID: <202202090111.cyDiSbN4-lkp@intel.com>
References: <20220203135434.584967-4-wojciech.ziemba@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203135434.584967-4-wojciech.ziemba@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wojciech,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on herbert-cryptodev-2.6/master]
[also build test ERROR on herbert-crypto-2.6/master linux/master linus/master v5.17-rc3 next-20220208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Wojciech-Ziemba/Introduce-support-for-QAT-Dynamic-Power-Management/20220203-221431
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220209/202202090111.cyDiSbN4-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project e8bff9ae54a55b4dbfeb6ba55f723abbd81bf494)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/00718c83e19e0fbffe30e7eb8cd58eaf4d52af34
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Wojciech-Ziemba/Introduce-support-for-QAT-Dynamic-Power-Management/20220203-221431
        git checkout 00718c83e19e0fbffe30e7eb8cd58eaf4d52af34
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/crypto/qat/qat_common/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/crypto/qat/qat_common/adf_isr.c:148:6: error: implicit declaration of function 'adf_handle_pm_int' [-Werror,-Wimplicit-function-declaration]
           if (adf_handle_pm_int(accel_dev))
               ^
   1 error generated.


vim +/adf_handle_pm_int +148 drivers/crypto/qat/qat_common/adf_isr.c

   147	
 > 148		if (adf_handle_pm_int(accel_dev))
   149			return IRQ_HANDLED;
   150	
   151		dev_dbg(&GET_DEV(accel_dev), "qat_dev%d spurious AE interrupt\n",
   152			accel_dev->accel_id);
   153	
   154		return IRQ_NONE;
   155	}
   156	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
