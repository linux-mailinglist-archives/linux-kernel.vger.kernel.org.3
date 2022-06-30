Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE23561A53
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 14:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbiF3MaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 08:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbiF3M37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 08:29:59 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F3D2E6A6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 05:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656592198; x=1688128198;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MytoE3ZDa2HDH9XPgt3Y9EwvwW3hTdWujRhXjGnnAEE=;
  b=JoAl8dpWInmD7EVP5Olx5RyceBcOXHRYUEobiWJz/X7xYi6biafMSeoJ
   a55ImO/c/SZw0Ft/shYdAxWq3B6CxLhgFqDDoNF1LfHR9fvL912XKhkFr
   hhvmwIiYtN9JvC89EITY9YWsvhb3mFl2RMz0wa7/snY6wj/N+cZAxFVSq
   G33DsGxmV69z5Zyj4pRUksRBkjqmJ4jGPNqIZ9NrtNazV9sqCgxIMAm/0
   fp6S6anTbyER+rwLPvL9hYSHuXnuoXfcRDlj1naexKcQkwv9kJmSLlLQs
   7f8v2UzUmaS/wc3H+i+c2I0qGKIp5JuB/jMeOTnGMcNOM9IfXzXuSALQp
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="307841303"
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="307841303"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 05:29:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="595669977"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 30 Jun 2022 05:29:50 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o6tIr-000CkA-G6;
        Thu, 30 Jun 2022 12:29:49 +0000
Date:   Thu, 30 Jun 2022 20:29:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     hmy <huanglin@uniontech.com>, robh+dt@kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        hmy <huanglin@uniontech.com>
Subject: Re: [PATCH] FIX CONFIG_CMDLINE is not avail when kernel config line
 in grub ends with --
Message-ID: <202206302025.8eyzYH5h-lkp@intel.com>
References: <20220630043823.19242-1-huanglin@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630043823.19242-1-huanglin@uniontech.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi hmy,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v5.19-rc4 next-20220630]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/hmy/FIX-CONFIG_CMDLINE-is-not-avail-when-kernel-config-line-in-grub-ends-with/20220630-124059
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220630/202206302025.8eyzYH5h-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/a68da93a13a9544ea17147828f16894ab6cfd204
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review hmy/FIX-CONFIG_CMDLINE-is-not-avail-when-kernel-config-line-in-grub-ends-with/20220630-124059
        git checkout a68da93a13a9544ea17147828f16894ab6cfd204
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/of/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/of/fdt.c: In function 'early_init_dt_scan_chosen':
>> drivers/of/fdt.c:1163:15: warning: unused variable 'q' [-Wunused-variable]
    1163 |         char *q;
         |               ^


vim +/q +1163 drivers/of/fdt.c

  1158	
  1159	int __init early_init_dt_scan_chosen(char *cmdline)
  1160	{
  1161		int l, node;
  1162		const char *p;
> 1163		char *q;
  1164		const void *rng_seed;
  1165		const void *fdt = initial_boot_params;
  1166	
  1167		node = fdt_path_offset(fdt, "/chosen");
  1168		if (node < 0)
  1169			node = fdt_path_offset(fdt, "/chosen@0");
  1170		if (node < 0)
  1171			return -ENOENT;
  1172	
  1173		chosen_node_offset = node;
  1174	
  1175		early_init_dt_check_for_initrd(node);
  1176		early_init_dt_check_for_elfcorehdr(node);
  1177	
  1178		/* Retrieve command line */
  1179		p = of_get_flat_dt_prop(node, "bootargs", &l);
  1180		if (p != NULL && l > 0)
  1181			strlcpy(cmdline, p, min(l, COMMAND_LINE_SIZE));
  1182	
  1183		/*
  1184		 * CONFIG_CMDLINE is meant to be a default in case nothing else
  1185		 * managed to set the command line, unless CONFIG_CMDLINE_FORCE
  1186		 * is set in which case we override whatever was found earlier.
  1187		 */
  1188	#ifdef CONFIG_CMDLINE
  1189	#if defined(CONFIG_CMDLINE_EXTEND)
  1190		strlcat(cmdline, " ", COMMAND_LINE_SIZE);
  1191		strlcat(cmdline, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
  1192		q = strstr(data, "--");
  1193		if (q)
  1194			*q = '\0';
  1195	#elif defined(CONFIG_CMDLINE_FORCE)
  1196		strlcpy(cmdline, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
  1197	#else
  1198		/* No arguments from boot loader, use kernel's  cmdl*/
  1199		if (!((char *)cmdline)[0])
  1200			strlcpy(cmdline, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
  1201	#endif
  1202	#endif /* CONFIG_CMDLINE */
  1203	
  1204		pr_debug("Command line is: %s\n", (char *)cmdline);
  1205	
  1206		rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
  1207		if (rng_seed && l > 0) {
  1208			add_bootloader_randomness(rng_seed, l);
  1209	
  1210			/* try to clear seed so it won't be found. */
  1211			fdt_nop_property(initial_boot_params, node, "rng-seed");
  1212	
  1213			/* update CRC check value */
  1214			of_fdt_crc32 = crc32_be(~0, initial_boot_params,
  1215					fdt_totalsize(initial_boot_params));
  1216		}
  1217	
  1218		return 0;
  1219	}
  1220	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
