Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF07D596247
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 20:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbiHPSSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 14:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiHPSSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 14:18:04 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D182861E0;
        Tue, 16 Aug 2022 11:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660673883; x=1692209883;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JnZ+/9C5jcfCqjDZytcjZuBiCh23D0qZXJHc8J+J2JY=;
  b=ljIrwL0TJC4MqYosOM9/NeZcik4H/6X6kbFOF7huNY7E+Chzydl1nG0E
   rxjBe8P64JgTzuG9fb2Xr/Y+6ITkLO6bCfDRVMdzeQ5tpobAe4E3Rna7A
   NNjBZl3C2V5aJmnn6ZVYPDJ3FeEM8TpZycK9mRrz8gphv9N0bZJ2KgfG9
   yQ1LE4Jc3LTVcLP6gSc8CdpXs2QYGTQbCCJZ0fb2UiU4FSJDhFZDZ5Qnr
   ubw00RZ3PFbE4Vg+YjBjzlmBuf9Eu+j0kCsjxUt+MiNKSrnTZB24iN7XJ
   SNpGSkOmCKHlf/A9EBjqyj+ZnCV7YHxxTc9+Qw72Hwj7AvAlrq5gclolH
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="272063867"
X-IronPort-AV: E=Sophos;i="5.93,241,1654585200"; 
   d="scan'208";a="272063867"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 11:18:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,241,1654585200"; 
   d="scan'208";a="749407845"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 16 Aug 2022 11:17:59 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oO18Y-00007s-1N;
        Tue, 16 Aug 2022 18:17:58 +0000
Date:   Wed, 17 Aug 2022 02:17:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eliav Farber <farbere@amazon.com>, jdelvare@suse.com,
        linux@roeck-us.net, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, farbere@amazon.com, talel@amazon.com,
        hhhawa@amazon.com, jonnyc@amazon.com, hanochu@amazon.com,
        ronenk@amazon.com, itamark@amazon.com, shellykz@amazon.com,
        shorer@amazon.com, amitlavi@amazon.com, almogbs@amazon.com,
        dwmw@amazon.co.uk, rtanwar@maxlinear.com
Subject: Re: [PATCH 08/16] hwmon: (mr75203) add VM active channel support
Message-ID: <202208170228.YsVOxCg7-lkp@intel.com>
References: <20220816082757.11990-9-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816082757.11990-9-farbere@amazon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eliav,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on linus/master v6.0-rc1 next-20220816]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Eliav-Farber/Variety-of-fixes-and-new-features-for-mr75203-driver/20220816-183655
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
config: powerpc-randconfig-s031-20220816 (https://download.01.org/0day-ci/archive/20220817/202208170228.YsVOxCg7-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/75e49737eb6188733096da72eb4692cfed872101
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Eliav-Farber/Variety-of-fixes-and-new-features-for-mr75203-driver/20220816-183655
        git checkout 75e49737eb6188733096da72eb4692cfed872101
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/hwmon/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/hwmon/mr75203.c:604:27: sparse: sparse: Variable length array is used.
   drivers/hwmon/mr75203.c:605:33: sparse: sparse: Variable length array is used.

vim +604 drivers/hwmon/mr75203.c

   514	
   515	static int mr75203_probe(struct platform_device *pdev)
   516	{
   517		const struct hwmon_channel_info **pvt_info;
   518		u32 ts_num, vm_num, pd_num, ch_num, val, index, i, j, k;
   519		struct device *dev = &pdev->dev;
   520		u32 *temp_config, *in_config;
   521		struct device *hwmon_dev;
   522		struct pvt_device *pvt;
   523		int ret;
   524	
   525		pvt = devm_kzalloc(dev, sizeof(*pvt), GFP_KERNEL);
   526		if (!pvt)
   527			return -ENOMEM;
   528	
   529		ret = pvt_get_regmap(pdev, "common", pvt);
   530		if (ret)
   531			return ret;
   532	
   533		pvt->clk = devm_clk_get(dev, NULL);
   534		if (IS_ERR(pvt->clk))
   535			return dev_err_probe(dev, PTR_ERR(pvt->clk), "failed to get clock\n");
   536	
   537		ret = pvt_clk_enable(dev, pvt);
   538		if (ret) {
   539			dev_err(dev, "failed to enable clock\n");
   540			return ret;
   541		}
   542	
   543		if (of_property_read_bool(dev->of_node, "reset-control-skip")) {
   544			dev_info(dev, "skipping reset-control\n");
   545		} else {
   546			pvt->rst = devm_reset_control_get_exclusive(dev, NULL);
   547			if (IS_ERR(pvt->rst))
   548				return dev_err_probe(dev, PTR_ERR(pvt->rst),
   549						     "failed to get reset control\n");
   550	
   551			ret = pvt_reset_control_deassert(dev, pvt);
   552			if (ret)
   553				return dev_err_probe(dev, ret,
   554						     "cannot deassert reset control\n");
   555		}
   556	
   557		ret = regmap_read(pvt->c_map, PVT_IP_CONFIG, &val);
   558		if(ret < 0)
   559			return ret;
   560	
   561		ts_num = (val & TS_NUM_MSK) >> TS_NUM_SFT;
   562		pd_num = (val & PD_NUM_MSK) >> PD_NUM_SFT;
   563		vm_num = (val & VM_NUM_MSK) >> VM_NUM_SFT;
   564		ch_num = (val & CH_NUM_MSK) >> CH_NUM_SFT;
   565		pvt->t_num = ts_num;
   566		pvt->p_num = pd_num;
   567		pvt->v_num = vm_num;
   568		val = 0;
   569		if (ts_num)
   570			val++;
   571		if (vm_num)
   572			val++;
   573		if (!val)
   574			return -ENODEV;
   575	
   576		pvt_info = devm_kcalloc(dev, val + 2, sizeof(*pvt_info), GFP_KERNEL);
   577		if (!pvt_info)
   578			return -ENOMEM;
   579		pvt_info[0] = HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ);
   580		index = 1;
   581	
   582		if (ts_num) {
   583			ret = pvt_get_regmap(pdev, "ts", pvt);
   584			if (ret)
   585				return ret;
   586	
   587			temp_config = devm_kcalloc(dev, ts_num + 1,
   588						   sizeof(*temp_config), GFP_KERNEL);
   589			if (!temp_config)
   590				return -ENOMEM;
   591	
   592			memset32(temp_config, HWMON_T_INPUT, ts_num);
   593			pvt_temp.config = temp_config;
   594			pvt_info[index++] = &pvt_temp;
   595		}
   596	
   597		if (pd_num) {
   598			ret = pvt_get_regmap(pdev, "pd", pvt);
   599			if (ret)
   600				return ret;
   601		}
   602	
   603		if (vm_num) {
 > 604			u8 vm_idx[vm_num];
   605			u8 vm_active_ch[vm_num];
   606	
   607			ret = pvt_get_regmap(pdev, "vm", pvt);
   608			if (ret)
   609				return ret;
   610	
   611			ret = device_property_read_u8_array(dev, "intel,vm-map", vm_idx,
   612							    vm_num);
   613			if (ret) {
   614				/*
   615				 * Incase intel,vm-map property is not defined, we
   616				 * assume incremental channel numbers.
   617				 */
   618				for (i = 0; i < vm_num; i++)
   619					vm_idx[i] = i;
   620			} else {
   621				for (i = 0; i < vm_num; i++)
   622					if (vm_idx[i] >= vm_num || vm_idx[i] == 0xff)
   623						break;
   624	
   625				vm_num = i;
   626				pvt->v_num = i;
   627			}
   628	
   629			ret = device_property_read_u8_array(dev, "vm-active-channels",
   630							    vm_active_ch, vm_num);
   631			if (ret) {
   632				/*
   633				 * Incase vm-active-channels property is not defined,
   634				 * we assume each VM sensor has all of its channels
   635				 * active.
   636				 */
   637				for (i = 0; i < vm_num; i++)
   638					vm_active_ch[i] = ch_num;
   639	
   640				pvt->vm_ch_max = ch_num;
   641				pvt->vm_ch_total = ch_num * vm_num;
   642			} else {
   643				for (i = 0; i < vm_num; i++) {
   644					if (vm_active_ch[i] > ch_num) {
   645						dev_err(dev,
   646							"invalid active channels: %u\n",
   647							vm_active_ch[i]);
   648						return -EINVAL;
   649					}
   650	
   651					pvt->vm_ch_total += vm_active_ch[i];
   652	
   653					if (vm_active_ch[i] > pvt->vm_ch_max)
   654						pvt->vm_ch_max = vm_active_ch[i];
   655				}
   656			}
   657	
   658			/*
   659			 * Map between the channel-number to VM-index and channel-index.
   660			 * Example - 3 VMs, vm_active_ch = [05 02 04]:
   661			 * vm_map = [0 0 0 0 0 1 1 2 2 2 2]
   662			 * ch_map = [0 1 2 3 4 0 1 0 1 2 3]
   663			 */
   664			pvt->vd = devm_kcalloc(dev, pvt->vm_ch_total, sizeof(*pvt->vd),
   665					       GFP_KERNEL);
   666			if (!pvt->vd)
   667				return -ENOMEM;
   668	
   669			k = 0;
   670			for (i = 0; i < vm_num; i++)
   671				for (j = 0; j < vm_active_ch[i]; j++) {
   672					pvt->vd[k].vm_map = vm_idx[i];
   673					pvt->vd[k].ch_map = j;
   674					k++;
   675				}
   676	
   677			in_config = devm_kcalloc(dev, pvt->vm_ch_total + 1,
   678						 sizeof(*in_config), GFP_KERNEL);
   679			if (!in_config)
   680				return -ENOMEM;
   681	
   682			memset32(in_config, HWMON_I_INPUT, pvt->vm_ch_total);
   683			in_config[pvt->vm_ch_total] = 0;
   684			pvt_in.config = in_config;
   685	
   686			pvt_info[index++] = &pvt_in;
   687		}
   688	
   689		ret = pvt_init(pvt);
   690		if (ret) {
   691			dev_err(dev, "failed to init pvt: %d\n", ret);
   692			return ret;
   693		}
   694	
   695		pvt_chip_info.info = pvt_info;
   696		hwmon_dev = devm_hwmon_device_register_with_info(dev, "pvt",
   697								 pvt,
   698								 &pvt_chip_info,
   699								 NULL);
   700	
   701		return PTR_ERR_OR_ZERO(hwmon_dev);
   702	}
   703	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
