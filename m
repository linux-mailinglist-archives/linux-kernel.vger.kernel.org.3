Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A00D585A89
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 15:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbiG3NLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 09:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbiG3NLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 09:11:16 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBC715734;
        Sat, 30 Jul 2022 06:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659186672; x=1690722672;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8WinKOkiACvMCIL7j4JUfw0p1az0NmOrR3j3M1UjeuM=;
  b=J5AWyuR0YDBoB12vabpvWioq1sK41U08jQPEBItvSYvzNQjxDAHeKJzr
   189DolUf4jELabtTp9FdCbO+cce8OOXSSx6Kw1DFC5kxtPGghcX+xljoF
   CkekzjOqULACKHOCn2DfQz7FtcdP3LT/eNNLb0SdjnZ2XksGSbJkQa9Cn
   G9t24rjV9NQIPM/UhFXvLwCCm/qklefJjRJuZvd06zzk6CwCpiKHjPl//
   /4reYaG+qpzx4uyecPTIB6Qgkhxg0LXVCDGSUixfF7tYDDcG2SXuji7qB
   UfXg7FhgxtF3BnQdkDrfz0tBoGmhxKgk49NwDWxl1p/jYrrFW2hMCO1ZO
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="314727781"
X-IronPort-AV: E=Sophos;i="5.93,204,1654585200"; 
   d="scan'208";a="314727781"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 06:11:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,204,1654585200"; 
   d="scan'208";a="728001021"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 30 Jul 2022 06:11:08 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHmFI-000Cqf-0W;
        Sat, 30 Jul 2022 13:11:08 +0000
Date:   Sat, 30 Jul 2022 21:10:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     kbuild-all@lists.01.org, Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 2/5] clk: qcom: Allow custom reset ops
Message-ID: <202207302137.mPbHPaHz-lkp@intel.com>
References: <20220730144713.2.I4b69f984a97535179acd9637426a1331f84f6646@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220730144713.2.I4b69f984a97535179acd9637426a1331f84f6646@changeid>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akhil,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on robh/for-next drm-misc/drm-misc-next drm-tip/drm-tip linus/master v5.19-rc8 next-20220728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Akhil-P-Oommen/clk-qcom-Support-gdsc-collapse-polling-using-reset-inteface/20220730-171922
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: ia64-randconfig-r031-20220729 (https://download.01.org/0day-ci/archive/20220730/202207302137.mPbHPaHz-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/971a03493e9854ff4a227ee4d80b533997959891
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Akhil-P-Oommen/clk-qcom-Support-gdsc-collapse-polling-using-reset-inteface/20220730-171922
        git checkout 971a03493e9854ff4a227ee4d80b533997959891
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/clk/qcom/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/clk/qcom/reset.c: In function 'qcom_reset':
>> drivers/clk/qcom/reset.c:17:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
      17 |         const struct qcom_reset_map *map = &rst->reset_map[id];
         |         ^~~~~


vim +17 drivers/clk/qcom/reset.c

    13	
    14	static int qcom_reset(struct reset_controller_dev *rcdev, unsigned long id)
    15	{
    16		struct qcom_reset_controller *rst = to_qcom_reset_controller(rcdev);
  > 17		const struct qcom_reset_map *map = &rst->reset_map[id];
    18	
    19		if (map->op)
    20			return map->op(map);
    21	
    22		rcdev->ops->assert(rcdev, id);
    23		udelay(1);
    24		rcdev->ops->deassert(rcdev, id);
    25		return 0;
    26	}
    27	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
