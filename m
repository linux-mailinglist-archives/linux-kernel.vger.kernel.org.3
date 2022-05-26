Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF047534A47
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 08:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346024AbiEZGAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 02:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbiEZF77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 01:59:59 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335FEA502E;
        Wed, 25 May 2022 22:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653544798; x=1685080798;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IbId82WCVDv7cpQcFi8e6oIhim/+07YWCKAjF9dj3EM=;
  b=lC4phcRyLXf81nzGmdMY+TISLfkVUm4takyZ9T1wvCxsn8nd00T36em1
   1eIKLyseprHlcsmIRGuxAZLg7pb9PAaJNYsIz6+gmCK7o9L9/2rr41KpQ
   kZHQ6Wz8pHvfbjs9gnwyzAuIeCNtNjNO1OSgITUz26Rl135iM7dBdZJ+b
   RrXggng0lyO9HGOdCaa4eXqgDsEwqPifWrQKzfcq3/Lvd//o/AsjMDwh2
   myNFixJNZpTe87V2QMiuDqgETuKYk+Vaztk7aNVlL93YgwxvNy7zjbz7n
   IKliPL6SOrN+5hHDXK3vdlVUXzEXSsW5lcatftABqu+LqI8AM19Qxxk7c
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="299381457"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="299381457"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 22:59:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="560039745"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 25 May 2022 22:59:52 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nu6XH-0003e2-Le;
        Thu, 26 May 2022 05:59:51 +0000
Date:   Thu, 26 May 2022 13:59:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sibi Sankar <quic_sibis@quicinc.com>, bjorn.andersson@linaro.org
Cc:     kbuild-all@lists.01.org, agross@kernel.org,
        mathieu.poirier@linaro.org, dmitry.baryshkov@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: Re: [PATCH 6/7] remoteproc: qcom: Check elf class before minidump
Message-ID: <202205261332.p94yBoKE-lkp@intel.com>
References: <1653398017-28426-7-git-send-email-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1653398017-28426-7-git-send-email-quic_sibis@quicinc.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sibi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on remoteproc/rproc-next]
[cannot apply to linux/master linus/master v5.18]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Sibi-Sankar/Miscellaneous-PAS-fixes/20220524-211743
base:   git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git rproc-next
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20220526/202205261332.p94yBoKE-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0db77918ce08718d9dbaadd1ceed8dcfb6488abf
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sibi-Sankar/Miscellaneous-PAS-fixes/20220524-211743
        git checkout 0db77918ce08718d9dbaadd1ceed8dcfb6488abf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "rproc_coredump" [drivers/remoteproc/qcom_common.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
