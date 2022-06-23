Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D27556FE3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 03:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349738AbiFWB2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 21:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343614AbiFWB2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 21:28:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6688C1758A;
        Wed, 22 Jun 2022 18:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655947684; x=1687483684;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FVJa2+JGTCHuOb6NnEu37R8kKk2s4YcOMsTCEJXQcog=;
  b=nfK/ZSbT8CgjOScdaM/5lU3+AFNNAHdVtN63K59q6p/2ndNOu+jQ0QxF
   crmKLVR5FMXrDzw35gYybMUWf8uMIa/X1drK+3Sze5WjRWiZCBHQ+AdQZ
   exrm3rdZ65qyUnOubB9ssJDCbLhu858mwwaLVF8v6BeBnWFSTd+sWve8C
   q5slLBfgVZzEANLm4AYG2A8KT2/UzEKVZBObiNCieOmB1X0ASvpcysuhZ
   0K3EZkLqC975pBk+PvIDO4Lzl8dHjTHSw7TR5HtYChOeuMC+cTAOqhbNF
   7m2mtUPnKOg6nDVk/sbcJhHGhYyil9p+mVsPjDRqJElW9BwatCvKE7Ao/
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="263625916"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="263625916"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 18:28:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="730624806"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Jun 2022 18:27:59 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4BdW-0000Fq-N0;
        Thu, 23 Jun 2022 01:27:58 +0000
Date:   Thu, 23 Jun 2022 08:25:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, quic_msavaliy@quicinc.com,
        dianders@chromium.org, mka@chromium.org, swboyd@chromium.org,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: Re: [PATCH] tty: serial: qcom-geni-serial: Fix get_clk_div_rate()
 which otherwise could return a sub-optimal clock rate.
Message-ID: <202206230849.dxzRCvaU-lkp@intel.com>
References: <1655834239-20812-1-git-send-email-quic_vnivarth@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655834239-20812-1-git-send-email-quic_vnivarth@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vijaya,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on linus/master v5.19-rc3 next-20220622]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Vijaya-Krishna-Nivarthi/tty-serial-qcom-geni-serial-Fix-get_clk_div_rate-which-otherwise-could-return-a-sub-optimal-clock-rate/20220622-015826
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
config: arm-randconfig-r016-20220622 (https://download.01.org/0day-ci/archive/20220623/202206230849.dxzRCvaU-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/668659f1481053090a9dbe9c83bd769de527a5c2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Vijaya-Krishna-Nivarthi/tty-serial-qcom-geni-serial-Fix-get_clk_div_rate-which-otherwise-could-return-a-sub-optimal-clock-rate/20220622-015826
        git checkout 668659f1481053090a9dbe9c83bd769de527a5c2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: arm-linux-gnueabi-ld: DWARF error: could not find abbrev number 121
   drivers/tty/serial/qcom_geni_serial.o: in function `find_clk_rate_in_tol':
>> qcom_geni_serial.c:(.text+0x764): undefined reference to `__aeabi_uldivmod'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
