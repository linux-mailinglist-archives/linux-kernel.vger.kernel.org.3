Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7788510B25
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 23:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355361AbiDZVWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355327AbiDZVWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:22:47 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5E9C8677;
        Tue, 26 Apr 2022 14:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651007979; x=1682543979;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EpwUa4TvzlVvOHJi5+yOiqfv4c3h+/WtFw0HkynHRMc=;
  b=jw0FGDzob5T0ofLUw3h07A5ZmFhNoI8V8bjB7MsxC+bSOyqc2YzYGWOQ
   zhZC2+MwAqzcokjlaf8QzkN/fjzviRqEi4lDA/36pPsoyV/9JAhWmCUTo
   y269u+E89CqLF6R6pQ/4LX7DmkIKb8yNyfGwGr42OVVCK/jF3Quvuqwp/
   QZBLOC+GM+Pun7UD/KrV98+j+1hA9xqzKQqjm5IWKSAdJBwc3yjF2Rx1z
   Vb9HdBtozEv5Pjukx+0Fw3TnZ12WymRMznpADYW4p7JmvUNYERGJOFDLD
   RnPiyrgkoCHT18Iee7DZb/RnZhx3hCOXKjMb8IjhBL0sNEEWzGIf1O+/D
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="263317228"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="263317228"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 14:19:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="595960382"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 26 Apr 2022 14:19:36 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njSau-0003zy-4H;
        Tue, 26 Apr 2022 21:19:36 +0000
Date:   Wed, 27 Apr 2022 05:18:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yogesh Lal <quic_ylal@quicinc.com>, bjorn.andersson@linaro.org,
        quic_sibis@quicinc.com
Cc:     kbuild-all@lists.01.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yogesh Lal <quic_ylal@quicinc.com>
Subject: Re: [PATCH v2] remoteproc: qcom: Add fallback mechanism for full
 coredump collection
Message-ID: <202204270556.J6HOrXrU-lkp@intel.com>
References: <1650969374-19245-1-git-send-email-quic_ylal@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650969374-19245-1-git-send-email-quic_ylal@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yogesh,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on remoteproc/rproc-next]
[also build test ERROR on v5.18-rc4 next-20220426]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Yogesh-Lal/remoteproc-qcom-Add-fallback-mechanism-for-full-coredump-collection/20220426-184634
base:   git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git rproc-next
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220427/202204270556.J6HOrXrU-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/679fb5eca3c1ce97bbd22b4f082d9db24f13b878
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yogesh-Lal/remoteproc-qcom-Add-fallback-mechanism-for-full-coredump-collection/20220426-184634
        git checkout 679fb5eca3c1ce97bbd22b4f082d9db24f13b878
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "rproc_coredump" [drivers/remoteproc/qcom_common.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
