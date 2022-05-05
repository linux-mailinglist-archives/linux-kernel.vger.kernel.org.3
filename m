Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A85F51C47C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 18:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356920AbiEEQGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 12:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiEEQGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 12:06:48 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7F32DE5;
        Thu,  5 May 2022 09:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651766588; x=1683302588;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zlTpNAuOWVsLMZxKenOm6Jo9aWTy0OBhL/05VXpK+aU=;
  b=EVhNcVEZkmrXQTUB+q24buU9l4oPOunAfEopPJU33di8leg7EaWXRuOX
   uhvDB8JUsGXOCE+pck8Rv8TVqMkso22X0z3ziZ3Fojr5iHngHqIp9O2yi
   ZbdCdFaPZLhGFIXhB8T+BEDLrurIDEfOFjGF0Et71d53tvMmGyMI+z1hV
   OoFijJ2gT5yiZ5ZkVFeZ7qAk3+kEKDqXxO/7puxZfdfQhXX/JN8I6wbnR
   K/IJrUR64RC36f8n6Ji0phpwnAeophrdttAbXTqSjER1MiqubHSOIKtPi
   hg0ERLErcma8SiFT/1wXgjkTBDeG6HPVzEhdzpK5AD8B7zx5cL8vd3KPk
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="354594634"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="354594634"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 08:54:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="891389408"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 05 May 2022 08:54:40 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmdoO-000CWs-2M;
        Thu, 05 May 2022 15:54:40 +0000
Date:   Thu, 5 May 2022 23:54:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Satya Priya <quic_c_skakit@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     kbuild-all@lists.01.org, Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_jprakash@quicinc.com,
        Satya Priya <quic_c_skakit@quicinc.com>
Subject: Re: [PATCH V11 6/9] mfd: pm8008: Use i2c_new_dummy_device() API
Message-ID: <202205052333.90qqQnWQ-lkp@intel.com>
References: <1651742739-12338-7-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651742739-12338-7-git-send-email-quic_c_skakit@quicinc.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Satya,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on lee-mfd/for-mfd-next]
[also build test WARNING on robh/for-next broonie-regulator/for-next v5.18-rc5 next-20220505]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Satya-Priya/Add-Qualcomm-Technologies-Inc-PM8008-regulator-driver/20220505-173045
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220505/202205052333.90qqQnWQ-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/28e91eacf6442c72c4f1ca25e5ad90fedc73ab73
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Satya-Priya/Add-Qualcomm-Technologies-Inc-PM8008-regulator-driver/20220505-173045
        git checkout 28e91eacf6442c72c4f1ca25e5ad90fedc73ab73
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/mfd/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/mfd/qcom-pm8008.c:154:16: warning: no previous prototype for 'pm8008_get_regmap' [-Wmissing-prototypes]
     154 | struct regmap *pm8008_get_regmap(struct pm8008_data *chip)
         |                ^~~~~~~~~~~~~~~~~


vim +/pm8008_get_regmap +154 drivers/mfd/qcom-pm8008.c

   153	
 > 154	struct regmap *pm8008_get_regmap(struct pm8008_data *chip)
   155	{
   156		return chip->regulators_regmap;
   157	}
   158	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
