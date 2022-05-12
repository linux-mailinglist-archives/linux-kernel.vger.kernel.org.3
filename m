Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BF6524A56
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 12:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352667AbiELKd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 06:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352688AbiELKdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 06:33:21 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315F722384E;
        Thu, 12 May 2022 03:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652351597; x=1683887597;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j2jLl94ZVv6+GyAHgqDQMoLNb5is4/daKLdqORUvrdg=;
  b=c8gsRy5vrkVgf5ltd4jkh27OZFBQbAjROQCHP1hb46tNjRnfIA1ouAFz
   sIBlWfB43/C/oc5kT6TRCMomhblfCkLJzMTCtbTcSsQ4FWwzpy6YX1rVo
   YphJ6sDG8AkBECaC6mJiu7oK6isTxjWjMb1+9hFeaXUbkUWhjO6u9kakB
   1Vj0AT1bi876t577ACjpv4boZtolbHugcKX5IbPmMi1r5ztoY5dmcitxL
   I9JJLhwgiPgomiG4SwQHLiFcQ278Bbfe9XkNfX4fjfpag1EIZa6O717N8
   ZPuf3dR+DTErGSUn/Ailsd91AXdBtAeDswP53y7NRwCLnJKA+btXZRUMO
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="269637629"
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="269637629"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 03:33:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="711867159"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 12 May 2022 03:33:11 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1np686-000KIM-T5;
        Thu, 12 May 2022 10:33:10 +0000
Date:   Thu, 12 May 2022 18:32:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Markuss Broks <markuss.broks@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Markuss Broks <markuss.broks@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Song Qiang <songqiang1304521@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/5] proximity: vl53l0x: Prefer already initialized
 interrupt flags
Message-ID: <202205121820.qRBa5PNP-lkp@intel.com>
References: <20220511214718.50879-3-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511214718.50879-3-markuss.broks@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markuss,

I love your patch! Yet something to improve:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on robh/for-next linux/master linus/master v5.18-rc6 next-20220511]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Markuss-Broks/Add-support-for-ToF-sensor-on-Yoshino-platform/20220512-054917
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: s390-randconfig-r032-20220509 (https://download.01.org/0day-ci/archive/20220512/202205121820.qRBa5PNP-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 18dd123c56754edf62c7042dcf23185c3727610f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/b4103f031e2c0265ae4f15f107341bcfc83008f0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Markuss-Broks/Add-support-for-ToF-sensor-on-Yoshino-platform/20220512-054917
        git checkout b4103f031e2c0265ae4f15f107341bcfc83008f0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/iio/proximity/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/iio/proximity/vl53l0x-i2c.c:60:18: error: call to undeclared function 'irq_get_trigger_type'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           int irq_flags = irq_get_trigger_type(client->irq);
                           ^
   1 error generated.


vim +/irq_get_trigger_type +60 drivers/iio/proximity/vl53l0x-i2c.c

    56	
    57	static int vl53l0x_configure_irq(struct i2c_client *client,
    58					 struct iio_dev *indio_dev)
    59	{
  > 60		int irq_flags = irq_get_trigger_type(client->irq);
    61		struct vl53l0x_data *data = iio_priv(indio_dev);
    62		int ret;
    63	
    64		if (!irq_flags)
    65			irq_flags = IRQF_TRIGGER_FALLING;
    66	
    67		ret = devm_request_irq(&client->dev, client->irq, vl53l0x_handle_irq,
    68				irq_flags, indio_dev->name, indio_dev);
    69		if (ret) {
    70			dev_err(&client->dev, "devm_request_irq error: %d\n", ret);
    71			return ret;
    72		}
    73	
    74		ret = i2c_smbus_write_byte_data(data->client,
    75				VL_REG_SYSTEM_INTERRUPT_CONFIG_GPIO,
    76				VL_REG_SYSTEM_INTERRUPT_GPIO_NEW_SAMPLE_READY);
    77		if (ret < 0)
    78			dev_err(&client->dev, "failed to configure IRQ: %d\n", ret);
    79	
    80		return ret;
    81	}
    82	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
