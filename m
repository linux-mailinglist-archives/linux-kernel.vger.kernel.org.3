Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE54583F5D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237830AbiG1M6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237168AbiG1M6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:58:16 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40EC46DAC;
        Thu, 28 Jul 2022 05:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659013095; x=1690549095;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VqGMwL7Lma99b1Lz1Z4Qv/qEv0GH5EqC0hCdpYV4L4k=;
  b=WB0n5eT29jJO2AWPJ08+VGIb4YysdLfB5EUsFz+8uxFmReUvVAbmiQ8N
   JxJP9KAjclXhxHMJjuHF7xzgX82t5nfWn0VBLreAPolkcfaI0OJ9UycK2
   PWEWcvLUkb4tSWpeCVTS7Fnk1+KfiEpsmnrVxe042n17dJCa576oi15+B
   tIflwSZrsI23HuDDG3Qeb0gxGIx/aeuFiI29d2nWS3J87IIvlruRhkDxb
   P09csQjaHEJVa5nCp353LBCfnUUlV+VHB7jNMej47xv8E4vkJOLjiYoEK
   NTlHkJOoiBWbCqd/fd+FPV89WUSrcYFhxPCwONRiKHRWOBRir7oa8bkDa
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="350208096"
X-IronPort-AV: E=Sophos;i="5.93,198,1654585200"; 
   d="scan'208";a="350208096"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 05:58:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,198,1654585200"; 
   d="scan'208";a="846692228"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 28 Jul 2022 05:58:11 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oH35e-000A16-1s;
        Thu, 28 Jul 2022 12:58:10 +0000
Date:   Thu, 28 Jul 2022 20:57:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@quicinc.com, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, quic_rohkumar@quicinc.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, devicetree@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: Re: [PATCH] ASoC: qcom: SC7280: Add support for external DMIC bias
 supply
Message-ID: <202207282036.84w516Y3-lkp@intel.com>
References: <1658992233-28372-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658992233-28372-1-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivasa,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on broonie-sound/for-next]
[also build test ERROR on linus/master v5.19-rc8 next-20220728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Srinivasa-Rao-Mandadapu/ASoC-qcom-SC7280-Add-support-for-external-DMIC-bias-supply/20220728-151249
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220728/202207282036.84w516Y3-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d59fc8cd6dd22df37f41309d1d18a7853929e2f8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Srinivasa-Rao-Mandadapu/ASoC-qcom-SC7280-Add-support-for-external-DMIC-bias-supply/20220728-151249
        git checkout d59fc8cd6dd22df37f41309d1d18a7853929e2f8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash sound/soc/qcom/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   sound/soc/qcom/sc7280.c: In function 'sc7280_snd_platform_probe':
>> sound/soc/qcom/sc7280.c:413:37: error: expected ')' before 'return'
     413 |         if (IS_ERR(data->vdd_supply)
         |            ~                        ^
         |                                     )
     414 |                 return PTR_ERR(data->vdd_supply);
         |                 ~~~~~~               
>> sound/soc/qcom/sc7280.c:417:1: error: expected expression before '}' token
     417 | }
         | ^
   sound/soc/qcom/sc7280.c:417:1: error: control reaches end of non-void function [-Werror=return-type]
     417 | }
         | ^
   cc1: some warnings being treated as errors


vim +413 sound/soc/qcom/sc7280.c

   380	
   381	static int sc7280_snd_platform_probe(struct platform_device *pdev)
   382	{
   383		struct snd_soc_card *card;
   384		struct sc7280_snd_data *data;
   385		struct device *dev = &pdev->dev;
   386		struct snd_soc_dai_link *link;
   387		int ret, i;
   388	
   389		data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
   390		if (!data)
   391			return -ENOMEM;
   392	
   393		card = &data->card;
   394		snd_soc_card_set_drvdata(card, data);
   395	
   396		card->owner = THIS_MODULE;
   397		card->driver_name = "SC7280";
   398		card->dev = dev;
   399	
   400		card->dapm_widgets = sc7280_snd_widgets;
   401		card->num_dapm_widgets = ARRAY_SIZE(sc7280_snd_widgets);
   402	
   403		ret = qcom_snd_parse_of(card);
   404		if (ret)
   405			return ret;
   406	
   407		for_each_card_prelinks(card, i, link) {
   408			link->init = sc7280_init;
   409			link->ops = &sc7280_ops;
   410		}
   411	
   412		data->vdd_supply = devm_regulator_get(dev, "vdd-dmic-bias");
 > 413		if (IS_ERR(data->vdd_supply)
   414			return PTR_ERR(data->vdd_supply);
   415	
   416		return devm_snd_soc_register_card(dev, card);
 > 417	}
   418	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
