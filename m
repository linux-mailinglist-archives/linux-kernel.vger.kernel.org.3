Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647D6588EDC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 16:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiHCOpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 10:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbiHCOpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 10:45:15 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF00BC34;
        Wed,  3 Aug 2022 07:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659537913; x=1691073913;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jc9iaoHtDaS/17+3DuSieLDblRv7+NtY9ZHlvVuU4zs=;
  b=fTJJlHymIltBjIR0UaWYk+RfB6BBn2S8LrJM5zGVitZxYtRkkKRzERmh
   W7vQQGw++liKt67OnCMmy5e+pZjYVD/i8iQg/kOXrzq7wyW7WK7x6Hrso
   Z25QeS9+SEuKARzuczkVhYI9RPQIaAuUt0aG7SDOjlMtBeQNjMvzNTVJ/
   ZjwoOa3NGzXyKC3aRN7OzcP3TW8FCLAit7hTCaV+qu3OesWTDxlP5d/+d
   p8E2CMWTOy82banGSPof014zMzmh6SSnv1aGqPFnSI8ARo16ygN5tKEfI
   OeqgvfeHWpLGMVTDm1MTYdNni31HbFWCrF+wkJFY9wTaMjRjY+6SEl1nc
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="351401283"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="351401283"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 07:45:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="635704667"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 03 Aug 2022 07:45:10 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJFcT-000HN9-2b;
        Wed, 03 Aug 2022 14:45:09 +0000
Date:   Wed, 3 Aug 2022 22:44:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eddie James <eajames@linux.ibm.com>, joel@jms.id.au
Cc:     kbuild-all@lists.01.org, linux@roeck-us.net, jdelvare@suse.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-fsi@lists.ozlabs.org, devicetree@vger.kernel.org,
        Eddie James <eajames@linux.ibm.com>
Subject: Re: [PATCH 3/3] hwmon: (occ) Check for device property for setting
 OCC active during probe
Message-ID: <202208032229.qba4UTzM-lkp@intel.com>
References: <20220802194656.240564-4-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802194656.240564-4-eajames@linux.ibm.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eddie,

I love your patch! Yet something to improve:

[auto build test ERROR on next-20220728]
[also build test ERROR on v5.19]
[cannot apply to groeck-staging/hwmon-next linus/master v5.19 v5.19-rc8 v5.19-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Eddie-James/occ-Restore-default-behavior-of-polling-OCC-during-init/20220803-034854
base:    7c5e07b73ff3011c9b82d4a3286a3362b951ad2b
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220803/202208032229.qba4UTzM-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/31dc5bad51ddf22f4e097c0c5862d14341708188
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Eddie-James/occ-Restore-default-behavior-of-polling-OCC-during-init/20220803-034854
        git checkout 31dc5bad51ddf22f4e097c0c5862d14341708188
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/hwmon/occ/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from drivers/hwmon/occ/p9_sbe.c:4:
>> drivers/hwmon/occ/p9_sbe.c:188:25: error: 'p8_i2c_occ_of_match' undeclared here (not in a function); did you mean 'p9_sbe_occ_of_match'?
     188 | MODULE_DEVICE_TABLE(of, p8_i2c_occ_of_match);
         |                         ^~~~~~~~~~~~~~~~~~~
   include/linux/module.h:244:15: note: in definition of macro 'MODULE_DEVICE_TABLE'
     244 | extern typeof(name) __mod_##type##__##name##_device_table               \
         |               ^~~~
>> include/linux/module.h:244:21: error: '__mod_of__p8_i2c_occ_of_match_device_table' aliased to undefined symbol 'p8_i2c_occ_of_match'
     244 | extern typeof(name) __mod_##type##__##name##_device_table               \
         |                     ^~~~~~
   drivers/hwmon/occ/p9_sbe.c:188:1: note: in expansion of macro 'MODULE_DEVICE_TABLE'
     188 | MODULE_DEVICE_TABLE(of, p8_i2c_occ_of_match);
         | ^~~~~~~~~~~~~~~~~~~


vim +188 drivers/hwmon/occ/p9_sbe.c

     3	
   > 4	#include <linux/device.h>
     5	#include <linux/errno.h>
     6	#include <linux/slab.h>
     7	#include <linux/fsi-occ.h>
     8	#include <linux/mm.h>
     9	#include <linux/module.h>
    10	#include <linux/mod_devicetable.h>
    11	#include <linux/mutex.h>
    12	#include <linux/platform_device.h>
    13	#include <linux/string.h>
    14	#include <linux/sysfs.h>
    15	
    16	#include "common.h"
    17	
    18	#define OCC_CHECKSUM_RETRIES	3
    19	
    20	struct p9_sbe_occ {
    21		struct occ occ;
    22		bool sbe_error;
    23		void *ffdc;
    24		size_t ffdc_len;
    25		size_t ffdc_size;
    26		struct mutex sbe_error_lock;	/* lock access to ffdc data */
    27		struct device *sbe;
    28	};
    29	
    30	#define to_p9_sbe_occ(x)	container_of((x), struct p9_sbe_occ, occ)
    31	
    32	static ssize_t ffdc_read(struct file *filp, struct kobject *kobj,
    33				 struct bin_attribute *battr, char *buf, loff_t pos,
    34				 size_t count)
    35	{
    36		ssize_t rc = 0;
    37		struct occ *occ = dev_get_drvdata(kobj_to_dev(kobj));
    38		struct p9_sbe_occ *ctx = to_p9_sbe_occ(occ);
    39	
    40		mutex_lock(&ctx->sbe_error_lock);
    41		if (ctx->sbe_error) {
    42			rc = memory_read_from_buffer(buf, count, &pos, ctx->ffdc,
    43						     ctx->ffdc_len);
    44			if (pos >= ctx->ffdc_len)
    45				ctx->sbe_error = false;
    46		}
    47		mutex_unlock(&ctx->sbe_error_lock);
    48	
    49		return rc;
    50	}
    51	static BIN_ATTR_RO(ffdc, OCC_MAX_RESP_WORDS * 4);
    52	
    53	static bool p9_sbe_occ_save_ffdc(struct p9_sbe_occ *ctx, const void *resp,
    54					 size_t resp_len)
    55	{
    56		bool notify = false;
    57	
    58		mutex_lock(&ctx->sbe_error_lock);
    59		if (!ctx->sbe_error) {
    60			if (resp_len > ctx->ffdc_size) {
    61				kvfree(ctx->ffdc);
    62				ctx->ffdc = kvmalloc(resp_len, GFP_KERNEL);
    63				if (!ctx->ffdc) {
    64					ctx->ffdc_len = 0;
    65					ctx->ffdc_size = 0;
    66					goto done;
    67				}
    68	
    69				ctx->ffdc_size = resp_len;
    70			}
    71	
    72			notify = true;
    73			ctx->sbe_error = true;
    74			ctx->ffdc_len = resp_len;
    75			memcpy(ctx->ffdc, resp, resp_len);
    76		}
    77	
    78	done:
    79		mutex_unlock(&ctx->sbe_error_lock);
    80		return notify;
    81	}
    82	
    83	static int p9_sbe_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len,
    84				       void *resp, size_t resp_len)
    85	{
    86		struct p9_sbe_occ *ctx = to_p9_sbe_occ(occ);
    87		int rc, i;
    88	
    89		for (i = 0; i < OCC_CHECKSUM_RETRIES; ++i) {
    90			rc = fsi_occ_submit(ctx->sbe, cmd, len, resp, &resp_len);
    91			if (rc >= 0)
    92				break;
    93			if (resp_len) {
    94				if (p9_sbe_occ_save_ffdc(ctx, resp, resp_len))
    95					sysfs_notify(&occ->bus_dev->kobj, NULL,
    96						     bin_attr_ffdc.attr.name);
    97				return rc;
    98			}
    99			if (rc != -EBADE)
   100				return rc;
   101		}
   102	
   103		switch (((struct occ_response *)resp)->return_status) {
   104		case OCC_RESP_CMD_IN_PRG:
   105			rc = -ETIMEDOUT;
   106			break;
   107		case OCC_RESP_SUCCESS:
   108			rc = 0;
   109			break;
   110		case OCC_RESP_CMD_INVAL:
   111		case OCC_RESP_CMD_LEN_INVAL:
   112		case OCC_RESP_DATA_INVAL:
   113		case OCC_RESP_CHKSUM_ERR:
   114			rc = -EINVAL;
   115			break;
   116		case OCC_RESP_INT_ERR:
   117		case OCC_RESP_BAD_STATE:
   118		case OCC_RESP_CRIT_EXCEPT:
   119		case OCC_RESP_CRIT_INIT:
   120		case OCC_RESP_CRIT_WATCHDOG:
   121		case OCC_RESP_CRIT_OCB:
   122		case OCC_RESP_CRIT_HW:
   123			rc = -EREMOTEIO;
   124			break;
   125		default:
   126			rc = -EPROTO;
   127		}
   128	
   129		return rc;
   130	}
   131	
   132	static int p9_sbe_occ_probe(struct platform_device *pdev)
   133	{
   134		int rc;
   135		struct occ *occ;
   136		struct p9_sbe_occ *ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx),
   137						      GFP_KERNEL);
   138		if (!ctx)
   139			return -ENOMEM;
   140	
   141		mutex_init(&ctx->sbe_error_lock);
   142	
   143		ctx->sbe = pdev->dev.parent;
   144		occ = &ctx->occ;
   145		occ->bus_dev = &pdev->dev;
   146		platform_set_drvdata(pdev, occ);
   147	
   148		occ->powr_sample_time_us = 500;
   149		occ->poll_cmd_data = 0x20;		/* P9 OCC poll data */
   150		occ->send_cmd = p9_sbe_occ_send_cmd;
   151	
   152		rc = occ_setup(occ);
   153		if (rc == -ESHUTDOWN)
   154			rc = -ENODEV;	/* Host is shutdown, don't spew errors */
   155	
   156		if (!rc) {
   157			rc = device_create_bin_file(occ->bus_dev, &bin_attr_ffdc);
   158			if (rc) {
   159				dev_warn(occ->bus_dev,
   160					 "failed to create SBE error ffdc file\n");
   161				rc = 0;
   162			}
   163		}
   164	
   165		return rc;
   166	}
   167	
   168	static int p9_sbe_occ_remove(struct platform_device *pdev)
   169	{
   170		struct occ *occ = platform_get_drvdata(pdev);
   171		struct p9_sbe_occ *ctx = to_p9_sbe_occ(occ);
   172	
   173		device_remove_bin_file(occ->bus_dev, &bin_attr_ffdc);
   174	
   175		ctx->sbe = NULL;
   176		occ_shutdown(occ);
   177	
   178		kvfree(ctx->ffdc);
   179	
   180		return 0;
   181	}
   182	
   183	static const struct of_device_id p9_sbe_occ_of_match[] = {
   184		{ .compatible = "ibm,p9-occ-hwmon" },
   185		{ .compatible = "ibm,p10-occ-hwmon" },
   186		{}
   187	};
 > 188	MODULE_DEVICE_TABLE(of, p8_i2c_occ_of_match);
   189	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
