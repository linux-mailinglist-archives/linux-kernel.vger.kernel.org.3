Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08A656B8BE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 13:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237238AbiGHLkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 07:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237704AbiGHLkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:40:49 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C749C20F5A;
        Fri,  8 Jul 2022 04:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657280448; x=1688816448;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZdDYQxLCE/FVW3YmiAHPRARr9uSRhV0hY5cuMuzEJx0=;
  b=MMTD1AIMtYlwPfte9/38kC20k2FtoXUpaZy+BPdvuVHGYGMoAPoAoujn
   iD2NWJ/l9ZXMph21xw/zbaNy4HAYL9lWSYYZ1zvDezTIpb0y0bNtNbId+
   7DgK110b14bvvbnhY7si9xPKA/jk0RbSl+mWGJG+dhkGYtIUpMS5s1xtc
   ihJugeLXqNGu+nmy1sIRUFboB3NY6g+7i5Zta+U1DeS4qj5mo8TynNBIe
   OLhSlYzwIAtlNgcp+lse7beIltITi0Ktg/0zI0zIOGZbf+JrHyU4MXcz+
   4isKtH/Z7nDqZA0HAoowNXRA5oFRe8uETqw4CCBW20Brsslf1MlWjZddJ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="348246301"
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="348246301"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 04:40:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="626681120"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 08 Jul 2022 04:40:46 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9mLl-000NPf-Cc;
        Fri, 08 Jul 2022 11:40:45 +0000
Date:   Fri, 8 Jul 2022 19:40:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     kbuild-all@lists.01.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/3] thermal: qcom: tsens: Implement re-initialization
 workaround quirk
Message-ID: <202207081955.SXcfKpLo-lkp@intel.com>
References: <20220701145815.2037993-4-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701145815.2037993-4-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhupesh,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on rafael-pm/thermal]
[also build test ERROR on linus/master v5.19-rc5 next-20220707]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bhupesh-Sharma/Add-support-for-tsens-controller-reinit-via-trustzone/20220701-230113
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
config: arm64-randconfig-r015-20220707 (https://download.01.org/0day-ci/archive/20220708/202207081955.SXcfKpLo-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/32929e13eb338e76b714bb8b4805899e2857734f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Bhupesh-Sharma/Add-support-for-tsens-controller-reinit-via-trustzone/20220701-230113
        git checkout 32929e13eb338e76b714bb8b4805899e2857734f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: ID map text too big or misaligned
   aarch64-linux-ld: drivers/thermal/qcom/tsens.o: in function `tsens_probe':
>> drivers/thermal/qcom/tsens.c:1337: undefined reference to `qcom_scm_is_available'
   aarch64-linux-ld: drivers/thermal/qcom/tsens.o: in function `get_temp_tsens_valid':
>> drivers/thermal/qcom/tsens.c:714: undefined reference to `qcom_scm_tsens_reinit'


vim +1337 drivers/thermal/qcom/tsens.c

  1293	
  1294	static int tsens_probe(struct platform_device *pdev)
  1295	{
  1296		int ret, i;
  1297		struct device *dev;
  1298		struct device_node *np;
  1299		struct tsens_priv *priv;
  1300		const struct tsens_plat_data *data;
  1301		const struct of_device_id *id;
  1302		u32 num_sensors;
  1303	
  1304		if (pdev->dev.of_node)
  1305			dev = &pdev->dev;
  1306		else
  1307			dev = pdev->dev.parent;
  1308	
  1309		np = dev->of_node;
  1310	
  1311		id = of_match_node(tsens_table, np);
  1312		if (id)
  1313			data = id->data;
  1314		else
  1315			data = &data_8960;
  1316	
  1317		num_sensors = data->num_sensors;
  1318	
  1319		if (np)
  1320			of_property_read_u32(np, "#qcom,sensors", &num_sensors);
  1321	
  1322		if (num_sensors <= 0) {
  1323			dev_err(dev, "%s: invalid number of sensors\n", __func__);
  1324			return -EINVAL;
  1325		}
  1326	
  1327		priv = devm_kzalloc(dev,
  1328				     struct_size(priv, sensor, num_sensors),
  1329				     GFP_KERNEL);
  1330		if (!priv)
  1331			return -ENOMEM;
  1332	
  1333		priv->dev = dev;
  1334		priv->num_sensors = num_sensors;
  1335		priv->needs_reinit_wa = data->needs_reinit_wa;
  1336	
> 1337		if (priv->needs_reinit_wa && !qcom_scm_is_available())
  1338			return -EPROBE_DEFER;
  1339	
  1340		if (priv->needs_reinit_wa) {
  1341			priv->reinit_wa_worker = alloc_workqueue("tsens_reinit_work",
  1342								 WQ_HIGHPRI, 0);
  1343			if (!priv->reinit_wa_worker)
  1344				return -ENOMEM;
  1345	
  1346			INIT_WORK(&priv->reinit_wa_notify, tsens_reinit_worker_notify);
  1347		}
  1348	
  1349		priv->ops = data->ops;
  1350		for (i = 0;  i < priv->num_sensors; i++) {
  1351			if (data->hw_ids)
  1352				priv->sensor[i].hw_id = data->hw_ids[i];
  1353			else
  1354				priv->sensor[i].hw_id = i;
  1355		}
  1356		priv->feat = data->feat;
  1357		priv->fields = data->fields;
  1358	
  1359		platform_set_drvdata(pdev, priv);
  1360	
  1361		if (!priv->ops || !priv->ops->init || !priv->ops->get_temp) {
  1362			ret = -EINVAL;
  1363			goto free_wq;
  1364		}
  1365	
  1366		ret = priv->ops->init(priv);
  1367		if (ret < 0) {
  1368			dev_err(dev, "%s: init failed\n", __func__);
  1369			goto free_wq;
  1370		}
  1371	
  1372		if (priv->ops->calibrate) {
  1373			ret = priv->ops->calibrate(priv);
  1374			if (ret < 0) {
  1375				if (ret != -EPROBE_DEFER)
  1376					dev_err(dev, "%s: calibration failed\n", __func__);
  1377	
  1378				goto free_wq;
  1379			}
  1380		}
  1381	
  1382		ret = tsens_register(priv);
  1383		if (ret < 0) {
  1384			dev_err(dev, "%s: registration failed\n", __func__);
  1385			goto free_wq;
  1386		}
  1387	
  1388		list_add_tail(&priv->list, &tsens_device_list);
  1389		return 0;
  1390	
  1391	free_wq:
  1392		destroy_workqueue(priv->reinit_wa_worker);
  1393		return ret;
  1394	}
  1395	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
