Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C6051E1CC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 01:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444824AbiEFWof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 18:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380258AbiEFWo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 18:44:27 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1443719012;
        Fri,  6 May 2022 15:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651876842; x=1683412842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gpR8WS924247ctuNc4WCcNsqtDd/VFN3XlYWLR4JePg=;
  b=FmFGLwRtL3dlKXPdjdwhnY6qSRMehsJA3QVb3QDgbg6NBr0KfmmCT+Ov
   Iq1Ig1A0r4LnawApx5SZjtVKvAu9HIi5xGdg2Gla/yHJK8b8S5DuYJHfF
   nM4RhGjslVSO7HIpQVHGez6MSTPVMXfUIGspRxfbN7JvXihYa/IjEqk8W
   bzotSet0daWC1QvgzGq8xfTa9Yfwrgo5MeLdBUsc/4dHVUFmKGP6Yx6m0
   0VOXZbuIBcZsm3zd61clDRhRQFNC0PuyhIDgV3UHCWC49WztkFAMYea98
   A1ajLoQGgRSbPyAdwan6QenZRRD5OBDgKewWfvPOXQ1P44Miw+EgRtTYe
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="248499419"
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="248499419"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 15:40:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="622011041"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 06 May 2022 15:40:29 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nn6ce-000Dyx-Ri;
        Fri, 06 May 2022 22:40:28 +0000
Date:   Sat, 7 May 2022 06:40:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sibi Sankar <quic_sibis@quicinc.com>, bjorn.andersson@linaro.org,
        arnd@arndb.de
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, sboyd@kernel.org, agross@kernel.org,
        linux-remoteproc@vger.kernel.org, mathieu.poirier@linaro.org,
        mka@chromium.org, Sibi Sankar <quic_sibis@quicinc.com>
Subject: Re: [PATCH] remoteproc: qcom_q6v5_mss: map/unmap metadata region
 before/after use
Message-ID: <202205070616.N8LRPhTW-lkp@intel.com>
References: <1651845086-16535-1-git-send-email-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651845086-16535-1-git-send-email-quic_sibis@quicinc.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sibi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on remoteproc/rproc-next]
[also build test ERROR on soc/for-next linux/master linus/master v5.18-rc5 next-20220506]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Sibi-Sankar/remoteproc-qcom_q6v5_mss-map-unmap-metadata-region-before-after-use/20220506-215346
base:   git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git rproc-next
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220507/202205070616.N8LRPhTW-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7a6766ecbb124cd4e41ae630420109330879239d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sibi-Sankar/remoteproc-qcom_q6v5_mss-map-unmap-metadata-region-before-after-use/20220506-215346
        git checkout 7a6766ecbb124cd4e41ae630420109330879239d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "dma_pgprot" [drivers/remoteproc/qcom_q6v5_mss.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
