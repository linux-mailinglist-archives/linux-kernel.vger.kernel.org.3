Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A953E47FA27
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 06:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhL0FOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 00:14:15 -0500
Received: from mga05.intel.com ([192.55.52.43]:51119 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229486AbhL0FOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 00:14:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640582055; x=1672118055;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=RpSMF+3ff+nLgcbvAwxYHiZVOLHjyewz7UBKq1wZB5s=;
  b=VzbPevQKDDO/KpqcAtgLkn0zMJWrpr+RpKpxEFMoMY4AlwfUvB7Dy1LC
   yH/rfz/p/8Dl3BwZzoPME+J4VH4g0WsZl0B+0W5zTB0zSsYGpampAN01Y
   pIDX21KTb1uHC70iuGCEdeDFGcULeHscP6N2pn6AoWKZ0QruHrvr5g7zt
   tZ1fQ0CwYS/6Pr4PaS/nvC9Z1uN8N6r5FC3noKfwyj1K4RK8zw5JegOcp
   6sASPrbz3t9XppRmrrJz2f8bsL7MZ/Kk4ptU5+Pglabs4Fwu+6+z+baKJ
   l3wRPq6NvVFCjtWDi+TNpX5tpIrWvtzR/ZIBqggmp3dS+xa77zcXvjai9
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10209"; a="327487950"
X-IronPort-AV: E=Sophos;i="5.88,238,1635231600"; 
   d="scan'208";a="327487950"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2021 21:14:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,238,1635231600"; 
   d="scan'208";a="553665547"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 26 Dec 2021 21:14:11 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n1iKo-00065f-B7; Mon, 27 Dec 2021 05:14:10 +0000
Date:   Mon, 27 Dec 2021 13:13:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 3/3] nvmem: add driver handling U-Boot environment
 variables
Message-ID: <202112271307.07oSwFJV-lkp@intel.com>
References: <20211222192320.21974-3-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211222192320.21974-3-zajec5@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Rafał,

I love your patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on mtd/mtd/next mtd/mtd/fixes linus/master v5.16-rc7 next-20211224]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Rafa-Mi-ecki/mtd-core-call-devm_of_platform_populate-for-MTD-devices/20211223-032456
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: riscv-randconfig-c006-20211227 (https://download.01.org/0day-ci/archive/20211227/202112271307.07oSwFJV-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 511726c64d3b6cca66f7c54d457d586aa3129f67)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/0day-ci/linux/commit/43acf8c3e5ac48785826453744a925ff149b1d60
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Rafa-Mi-ecki/mtd-core-call-devm_of_platform_populate-for-MTD-devices/20211223-032456
        git checkout 43acf8c3e5ac48785826453744a925ff149b1d60
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/nvmem/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> drivers/nvmem/u-boot-env.c:126:46: warning: format specifies type 'unsigned int' but the argument has type 'size_t' (aka 'unsigned long') [-Wformat]
           dev_info(dev, "offset:0x%08x len:0x%08x\n", image_offset, image_len);
                                   ~~~~                ^~~~~~~~~~~~
                                   %08lx
   include/linux/dev_printk.h:150:67: note: expanded from macro 'dev_info'
           dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                    ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                ~~~    ^~~~~~~~~~~
   drivers/nvmem/u-boot-env.c:126:60: warning: format specifies type 'unsigned int' but the argument has type 'size_t' (aka 'unsigned long') [-Wformat]
           dev_info(dev, "offset:0x%08x len:0x%08x\n", image_offset, image_len);
                                              ~~~~                   ^~~~~~~~~
                                              %08lx
   include/linux/dev_printk.h:150:67: note: expanded from macro 'dev_info'
           dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                    ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                ~~~    ^~~~~~~~~~~
>> drivers/nvmem/u-boot-env.c:190:38: error: incompatible pointer types passing 'size_t *' (aka 'unsigned long *') to parameter of type 'u32 *' (aka 'unsigned int *') [-Werror,-Wincompatible-pointer-types]
           if (of_property_read_u32(np, "reg", &priv->offset) ||
                                               ^~~~~~~~~~~~~
   include/linux/of.h:1255:17: note: passing argument to parameter 'out_value' here
                                          u32 *out_value)
                                               ^
   drivers/nvmem/u-boot-env.c:191:47: error: incompatible pointer types passing 'size_t *' (aka 'unsigned long *') to parameter of type 'u32 *' (aka 'unsigned int *') [-Werror,-Wincompatible-pointer-types]
               of_property_read_u32_index(np, "reg", 1, &priv->size)) {
                                                        ^~~~~~~~~~~
   include/linux/of.h:311:28: note: passing argument to parameter 'out_value' here
                                          u32 index, u32 *out_value);
                                                          ^
   2 warnings and 2 errors generated.


vim +190 drivers/nvmem/u-boot-env.c

    99	
   100	static int u_boot_env_parse(struct u_boot_env *priv)
   101	{
   102		struct device *dev = priv->dev;
   103		struct u_boot_env_image *image;
   104		size_t image_offset;
   105		size_t image_len;
   106		uint32_t crc32;
   107		size_t bytes;
   108		uint8_t *buf;
   109		int err;
   110	
   111		image_offset = 0;
   112		image_len = priv->size;
   113		if (priv->format == U_BOOT_FORMAT_BRCM) {
   114			struct u_boot_brcm_header header;
   115	
   116			err = mtd_read(priv->mtd, priv->offset, sizeof(header), &bytes,
   117				       (uint8_t *)&header);
   118			if (err && !mtd_is_bitflip(err)) {
   119				dev_err(dev, "Failed to read from mtd: %d\n", err);
   120				return err;
   121			}
   122	
   123			image_offset = sizeof(header);
   124			image_len = le32_to_cpu(header.len);
   125		}
 > 126		dev_info(dev, "offset:0x%08x len:0x%08x\n", image_offset, image_len);
   127	
   128		buf = kcalloc(1, image_len, GFP_KERNEL);
   129		if (!buf) {
   130			err = -ENOMEM;
   131			goto err_out;
   132		}
   133		image = (struct u_boot_env_image *)buf;
   134	
   135		err = mtd_read(priv->mtd, priv->offset + image_offset, image_len, &bytes, buf);
   136		if (err && !mtd_is_bitflip(err)) {
   137			dev_err(dev, "Failed to read from mtd: %d\n", err);
   138			goto err_kfree;
   139		}
   140	
   141		crc32 = crc32(~0, buf + 4, image_len - 4) ^ ~0L;
   142		if (crc32 != le32_to_cpu(image->crc32)) {
   143			dev_err(dev, "Invalid calculated CRC32: 0x%08x\n", crc32);
   144			err = -EINVAL;
   145			goto err_kfree;
   146		}
   147	
   148		buf[image_len - 1] = '\0';
   149		err = u_boot_env_add_cells(priv, image_offset + sizeof(*image),
   150					   buf + sizeof(*image),
   151					   image_len - sizeof(*image));
   152		if (err)
   153			dev_err(dev, "Failed to add cells: %d\n", err);
   154	
   155	err_kfree:
   156		kfree(buf);
   157	err_out:
   158		return err;
   159	}
   160	
   161	static const struct of_device_id u_boot_env_of_match_table[] = {
   162		{ .compatible = "u-boot,env", .data = (void *)U_BOOT_FORMAT_DEFAULT, },
   163		{ .compatible = "brcm,env", .data = (void *)U_BOOT_FORMAT_BRCM, },
   164		{},
   165	};
   166	
   167	static int u_boot_env_probe(struct platform_device *pdev)
   168	{
   169		struct nvmem_config config = {
   170			.name = "u-boot-env",
   171			.reg_read = u_boot_env_read,
   172		};
   173		struct device *dev = &pdev->dev;
   174		struct device_node *np = dev->of_node;
   175		const struct of_device_id *of_id;
   176		struct u_boot_env *priv;
   177		const char *label;
   178		int err;
   179	
   180		priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
   181		if (!priv)
   182			return -ENOMEM;
   183		priv->dev = dev;
   184	
   185		of_id = of_match_device(u_boot_env_of_match_table, dev);
   186		if (!of_id)
   187			return -EINVAL;
   188		priv->format = (uintptr_t)of_id->data;
   189	
 > 190		if (of_property_read_u32(np, "reg", &priv->offset) ||
   191		    of_property_read_u32_index(np, "reg", 1, &priv->size)) {
   192			dev_err(dev, "Failed to read \"reg\" property\n");
   193			return -EINVAL;
   194		}
   195	
   196		label = of_get_property(np->parent, "label", NULL);
   197		if (!label)
   198			label = np->parent->name;
   199	
   200		priv->mtd = get_mtd_device_nm(label);
   201		if (IS_ERR(priv->mtd)) {
   202			dev_err(dev, "Failed to find \"%s\" MTD device: %ld\n", label, PTR_ERR(priv->mtd));
   203			return PTR_ERR(priv->mtd);
   204		}
   205	
   206		err = u_boot_env_parse(priv);
   207		if (err)
   208			return err;
   209	
   210		config.dev = dev;
   211		config.cells = priv->cells;
   212		config.ncells = priv->ncells;
   213		config.priv = priv;
   214		config.size = priv->size;
   215	
   216		return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &config));
   217	}
   218	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
