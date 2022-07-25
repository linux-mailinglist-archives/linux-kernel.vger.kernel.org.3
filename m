Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EFA580801
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 01:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbiGYXLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 19:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiGYXLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 19:11:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B0BBF68;
        Mon, 25 Jul 2022 16:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658790676; x=1690326676;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sOZHgtI0Aszjfo0V/PNPgA+M8VlOJa/SdqFbd4pmrWs=;
  b=X0p7t2nhD3NYn/p3oLSh7vzt5DXUzS94VBXfvp1ZLbY91QCWu+3bNO6H
   snGkD9+CEweolomAGIR76hYJ05pAHWksP3Ah/oTRW/YAE3/OCMjccilDg
   PuhMV++mszSR+9NJ6z0LfT6pjis0OuzwEQIzx1SowYZOsMhJq1oG7/nPW
   twuntO8J0sbtOP7hU5hOsX+GarrpaCRbNspZlT5Urnh8e+ChwedcZ37vR
   4X8cM1n17c1WLgw5bOo8ZuANo1KDJKxoPPV/aVrRkhaZmZ1qfWQJINndT
   kGGIhWKrHnQOuwPopxrNvgMgduoZgukQlaI05SWOSAquK/RxBYUt97Xus
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="313570583"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="313570583"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 16:11:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="927092344"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 25 Jul 2022 16:11:13 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oG7EH-0005eH-0v;
        Mon, 25 Jul 2022 23:11:13 +0000
Date:   Tue, 26 Jul 2022 07:10:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     kbuild-all@lists.01.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        linux-arm-msm@vger.kernel.org, daniel.lezcano@linaro.org,
        robh+dt@kernel.org, rafael@kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Subject: Re: [PATCH v2 3/5] thermal: qcom: tsens: Add driver support for
 re-initialization quirk
Message-ID: <202207260755.tUajnfB4-lkp@intel.com>
References: <20220724122424.2509021-4-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220724122424.2509021-4-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhupesh,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on rafael-pm/thermal]
[also build test ERROR on linus/master v5.19-rc8 next-20220725]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bhupesh-Sharma/Add-support-for-tsens-controller-reinit-via-trustzone/20220724-202546
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
config: ia64-randconfig-r005-20220724 (https://download.01.org/0day-ci/archive/20220726/202207260755.tUajnfB4-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2356630fadc0a622264bf292b6930f8c728b0709
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Bhupesh-Sharma/Add-support-for-tsens-controller-reinit-via-trustzone/20220724-202546
        git checkout 2356630fadc0a622264bf292b6930f8c728b0709
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ia64-linux-ld: drivers/thermal/qcom/tsens.o: in function `tsens_probe':
>> tsens.c:(.text+0x6d2): undefined reference to `qcom_scm_is_available'
   ia64-linux-ld: drivers/thermal/qcom/tsens.o: in function `tsens_health_check_and_reinit.constprop.0':
>> tsens.c:(.text+0x10c2): undefined reference to `qcom_scm_tsens_reinit'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
