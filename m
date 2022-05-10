Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1998F5220C9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346065AbiEJQMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbiEJQMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:12:51 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F410266F34;
        Tue, 10 May 2022 09:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652198933; x=1683734933;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bAh3WJmCp5NTIqxc6IUYDZLmG+5NOa+aaHz6HMfWXqM=;
  b=W7T6ir0d9QJxkbase0AXY83JCno21uIv0h0iAUlvWL60BivSS9qf9Uiu
   i6kxkRJJtFaGviiNN/CykQjXJ3OI3XBoQ+un1AIZFWJ4HVeQUngVR/AEM
   aldoc/VbyqhrbpElbqMScn0M/eH7gGXEsQGqpwKHRhA3zULDr1ycUiWlh
   Zy4Dn6VTaeDiq3JKrK15X6LZiC8r5eaoWj2ipPNPPC5v59eMd+WQLRimh
   TptK4PPrM5LMFmIJT+EYrhGR9bnhJKn8XqITqLPOiACVZaW4sfA0tnNrM
   E2JBKWsdJJyainBCcUOBC8p2st9R5iQz9/yZGYfebCJkAVKvQz6gXSIqw
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="269359300"
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="269359300"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 09:07:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="552905905"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 10 May 2022 09:07:10 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noSOE-000I7A-3o;
        Tue, 10 May 2022 16:07:10 +0000
Date:   Wed, 11 May 2022 00:06:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sibi Sankar <quic_sibis@quicinc.com>, bjorn.andersson@linaro.org,
        mani@kernel.org, jassisinghbrar@gmail.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, Prasad Sodagudi <quic_psodagud@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: Re: [PATCH] mailbox: qcom-ipcc: Log the pending interrupt during
 resume
Message-ID: <202205102334.mtvIIqAz-lkp@intel.com>
References: <1652168893-11814-1-git-send-email-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652168893-11814-1-git-send-email-quic_sibis@quicinc.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sibi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.18-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Sibi-Sankar/mailbox-qcom-ipcc-Log-the-pending-interrupt-during-resume/20220510-155032
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 9be9ed2612b5aedb52a2c240edb1630b6b743cb6
config: arm-randconfig-r015-20220509 (https://download.01.org/0day-ci/archive/20220510/202205102334.mtvIIqAz-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 18dd123c56754edf62c7042dcf23185c3727610f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/5389a3f93e441ca9fed19981d15d5e74708aaa4f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sibi-Sankar/mailbox-qcom-ipcc-Log-the-pending-interrupt-during-resume/20220510-155032
        git checkout 5389a3f93e441ca9fed19981d15d5e74708aaa4f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "irq_to_desc" [drivers/mailbox/qcom-ipcc.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
