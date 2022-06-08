Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A518154254E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbiFHES4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 00:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbiFHERz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 00:17:55 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8812F4F5B;
        Tue,  7 Jun 2022 18:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654652448; x=1686188448;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zbm4iZu1MGqfCpOkzqcAjxrsjpBC11cUbsTqwp4M7J0=;
  b=WrKfzuHlSJLzjsBoSP5ZCx4IEQRpzr5B3A6KqL6rokwYTWVd1kiHY32e
   sSGZ9pKsPcQhSW1yGCeNd//nyH43m+nE3+W5TmJMJQPPhn58d/IjEAtc3
   12j4Rte3l2rLukXfu7ixgFS4IdJKvUpycEtxKArzBLrhJW9mBNFfEL4F/
   dNlszB9OqWns7OxavDI3VHy9vw530rnc4k6ocWtSfhG6VADJV0HCrnoLy
   29zJobdrqYn1M0mbulkb69jrb1bSgo7pWDey5ppWCmKjMiuezZV7b9qel
   Vl1kSJDCJFSCsW2ALFr6D2+hCTQR9wJbOczBez3yrDYrEopAV8/Xf1r1/
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="340797571"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="340797571"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 18:40:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="670294643"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Jun 2022 18:40:13 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nykg8-000E8z-R5;
        Wed, 08 Jun 2022 01:40:12 +0000
Date:   Wed, 8 Jun 2022 09:39:48 +0800
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
Subject: Re: [PATCH V14 7/9] regulator: Add a regulator driver for the PM8008
 PMIC
Message-ID: <202206080910.XAMKbeVH-lkp@intel.com>
References: <1654602615-28849-8-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1654602615-28849-8-git-send-email-quic_c_skakit@quicinc.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
[also build test WARNING on robh/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Satya-Priya/Add-Qualcomm-Technologies-Inc-PM8008-regulator-driver/20220607-195327
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220608/202206080910.XAMKbeVH-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/11e915cb6368e90fdc4186104c56a3619aa63440
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Satya-Priya/Add-Qualcomm-Technologies-Inc-PM8008-regulator-driver/20220607-195327
        git checkout 11e915cb6368e90fdc4186104c56a3619aa63440
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/regulator/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/regulator/qcom-pm8008-regulator.c: In function 'pm8008_regulator_get_voltage':
>> drivers/regulator/qcom-pm8008-regulator.c:74:13: warning: unused variable 'rc' [-Wunused-variable]
      74 |         int rc, uV;
         |             ^~


vim +/rc +74 drivers/regulator/qcom-pm8008-regulator.c

    69	
    70	static int pm8008_regulator_get_voltage(struct regulator_dev *rdev)
    71	{
    72		struct pm8008_regulator *pm8008_reg = rdev_get_drvdata(rdev);
    73		__le16 mV;
  > 74		int rc, uV;
    75	
    76		regmap_bulk_read(pm8008_reg->regmap,
    77				LDO_VSET_LB_REG(pm8008_reg->base), (void *)&mV, 2);
    78	
    79		uV = le16_to_cpu(mV) * 1000;
    80		return (uV - pm8008_reg->rdesc.min_uV) / pm8008_reg->rdesc.uV_step;
    81	}
    82	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
