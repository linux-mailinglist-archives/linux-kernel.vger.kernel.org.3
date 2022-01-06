Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2EF486487
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 13:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239003AbiAFMnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 07:43:20 -0500
Received: from mga07.intel.com ([134.134.136.100]:28912 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238945AbiAFMnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 07:43:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641472999; x=1673008999;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dKDig3d7tYjU4WQGca7wfhZRASXnqqm1m8LBSyQVmuI=;
  b=i7kPvJ3Z1Gj+NDROhQwCN6qmMf7x1tjhgERFvOCX744KkcvOQsLL/bfB
   030kyyAtw3+WJanDGC7cLl1ZJUZZkGHSnNe+JBClqrAHLKvfqoP9790WG
   R6D+kpiOmDLaTGoKyh19Fp6LeFVvuRRfHFe7Eb2BqalEN6L/QcmCy/TfB
   ZMV5hVaB2YQNur/Hj0nBsj+t2iS6IIz+pAzQCx2MnQGNMVlFH2inQY9t7
   JszIW5zHsdokij8Pt/uQxSaX5v/YyR8vNPYYeulqp8wcD7tEvAn4xPAH1
   O+AeBlsS0dQyPXWe0vNupaJze8cSwXYuk+Gie2Ahu0gazj9KZ0bA1dCRV
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="306001670"
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="306001670"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 04:43:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="470933719"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 06 Jan 2022 04:43:15 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5S6t-000HeU-26; Thu, 06 Jan 2022 12:43:15 +0000
Date:   Thu, 6 Jan 2022 20:42:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, linmq006@gmail.com,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: atmel: atmel-isc: Fix PM disable depth imbalance
 in atmel_isc_probe
Message-ID: <202201062034.BD2L4uCe-lkp@intel.com>
References: <20220105111056.4662-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105111056.4662-1-linmq006@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miaoqian,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on media-tree/master]
[also build test WARNING on v5.16-rc8 next-20220105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Miaoqian-Lin/media-atmel-atmel-isc-Fix-PM-disable-depth-imbalance-in-atmel_isc_probe/20220105-191228
base:   git://linuxtv.org/media_tree.git master
config: riscv-randconfig-r002-20220106 (https://download.01.org/0day-ci/archive/20220106/202201062034.BD2L4uCe-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project ca7ffe09dc6e525109e3cd570cc5182ce568be13)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/0day-ci/linux/commit/f116d8f81c642486900c9589a7c10d137d7eb0a2
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Miaoqian-Lin/media-atmel-atmel-isc-Fix-PM-disable-depth-imbalance-in-atmel_isc_probe/20220105-191228
        git checkout f116d8f81c642486900c9589a7c10d137d7eb0a2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/media/platform/atmel/ net/xfrm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/media/platform/atmel/atmel-sama5d2-isc.c:30:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:36:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/media/platform/atmel/atmel-sama5d2-isc.c:30:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:34:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/media/platform/atmel/atmel-sama5d2-isc.c:30:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:1024:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
                                                     ~~~~~~~~~~ ^
>> drivers/media/platform/atmel/atmel-sama5d2-isc.c:562:1: warning: unused label 'disable_pm_runtime' [-Wunused-label]
   disable_pm_runtime:
   ^~~~~~~~~~~~~~~~~~~
   8 warnings generated.


vim +/disable_pm_runtime +562 drivers/media/platform/atmel/atmel-sama5d2-isc.c

   380	
   381	static int atmel_isc_probe(struct platform_device *pdev)
   382	{
   383		struct device *dev = &pdev->dev;
   384		struct isc_device *isc;
   385		struct resource *res;
   386		void __iomem *io_base;
   387		struct isc_subdev_entity *subdev_entity;
   388		int irq;
   389		int ret;
   390		u32 ver;
   391	
   392		isc = devm_kzalloc(dev, sizeof(*isc), GFP_KERNEL);
   393		if (!isc)
   394			return -ENOMEM;
   395	
   396		platform_set_drvdata(pdev, isc);
   397		isc->dev = dev;
   398	
   399		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   400		io_base = devm_ioremap_resource(dev, res);
   401		if (IS_ERR(io_base))
   402			return PTR_ERR(io_base);
   403	
   404		isc->regmap = devm_regmap_init_mmio(dev, io_base, &isc_regmap_config);
   405		if (IS_ERR(isc->regmap)) {
   406			ret = PTR_ERR(isc->regmap);
   407			dev_err(dev, "failed to init register map: %d\n", ret);
   408			return ret;
   409		}
   410	
   411		irq = platform_get_irq(pdev, 0);
   412		if (irq < 0)
   413			return irq;
   414	
   415		ret = devm_request_irq(dev, irq, isc_interrupt, 0,
   416				       "atmel-sama5d2-isc", isc);
   417		if (ret < 0) {
   418			dev_err(dev, "can't register ISR for IRQ %u (ret=%i)\n",
   419				irq, ret);
   420			return ret;
   421		}
   422	
   423		isc->gamma_table = isc_sama5d2_gamma_table;
   424		isc->gamma_max = 2;
   425	
   426		isc->max_width = ISC_SAMA5D2_MAX_SUPPORT_WIDTH;
   427		isc->max_height = ISC_SAMA5D2_MAX_SUPPORT_HEIGHT;
   428	
   429		isc->config_dpc = isc_sama5d2_config_dpc;
   430		isc->config_csc = isc_sama5d2_config_csc;
   431		isc->config_cbc = isc_sama5d2_config_cbc;
   432		isc->config_cc = isc_sama5d2_config_cc;
   433		isc->config_gam = isc_sama5d2_config_gam;
   434		isc->config_rlp = isc_sama5d2_config_rlp;
   435		isc->config_ctrls = isc_sama5d2_config_ctrls;
   436	
   437		isc->adapt_pipeline = isc_sama5d2_adapt_pipeline;
   438	
   439		isc->offsets.csc = ISC_SAMA5D2_CSC_OFFSET;
   440		isc->offsets.cbc = ISC_SAMA5D2_CBC_OFFSET;
   441		isc->offsets.sub422 = ISC_SAMA5D2_SUB422_OFFSET;
   442		isc->offsets.sub420 = ISC_SAMA5D2_SUB420_OFFSET;
   443		isc->offsets.rlp = ISC_SAMA5D2_RLP_OFFSET;
   444		isc->offsets.his = ISC_SAMA5D2_HIS_OFFSET;
   445		isc->offsets.dma = ISC_SAMA5D2_DMA_OFFSET;
   446		isc->offsets.version = ISC_SAMA5D2_VERSION_OFFSET;
   447		isc->offsets.his_entry = ISC_SAMA5D2_HIS_ENTRY_OFFSET;
   448	
   449		isc->controller_formats = sama5d2_controller_formats;
   450		isc->controller_formats_size = ARRAY_SIZE(sama5d2_controller_formats);
   451		isc->formats_list = sama5d2_formats_list;
   452		isc->formats_list_size = ARRAY_SIZE(sama5d2_formats_list);
   453	
   454		/* sama5d2-isc - 8 bits per beat */
   455		isc->dcfg = ISC_DCFG_YMBSIZE_BEATS8 | ISC_DCFG_CMBSIZE_BEATS8;
   456	
   457		/* sama5d2-isc : ISPCK is required and mandatory */
   458		isc->ispck_required = true;
   459	
   460		ret = isc_pipeline_init(isc);
   461		if (ret)
   462			return ret;
   463	
   464		isc->hclock = devm_clk_get(dev, "hclock");
   465		if (IS_ERR(isc->hclock)) {
   466			ret = PTR_ERR(isc->hclock);
   467			dev_err(dev, "failed to get hclock: %d\n", ret);
   468			return ret;
   469		}
   470	
   471		ret = clk_prepare_enable(isc->hclock);
   472		if (ret) {
   473			dev_err(dev, "failed to enable hclock: %d\n", ret);
   474			return ret;
   475		}
   476	
   477		ret = isc_clk_init(isc);
   478		if (ret) {
   479			dev_err(dev, "failed to init isc clock: %d\n", ret);
   480			goto unprepare_hclk;
   481		}
   482		ret = v4l2_device_register(dev, &isc->v4l2_dev);
   483		if (ret) {
   484			dev_err(dev, "unable to register v4l2 device.\n");
   485			goto unprepare_clk;
   486		}
   487	
   488		ret = isc_parse_dt(dev, isc);
   489		if (ret) {
   490			dev_err(dev, "fail to parse device tree\n");
   491			goto unregister_v4l2_device;
   492		}
   493	
   494		if (list_empty(&isc->subdev_entities)) {
   495			dev_err(dev, "no subdev found\n");
   496			ret = -ENODEV;
   497			goto unregister_v4l2_device;
   498		}
   499	
   500		list_for_each_entry(subdev_entity, &isc->subdev_entities, list) {
   501			struct v4l2_async_subdev *asd;
   502			struct fwnode_handle *fwnode =
   503				of_fwnode_handle(subdev_entity->epn);
   504	
   505			v4l2_async_nf_init(&subdev_entity->notifier);
   506	
   507			asd = v4l2_async_nf_add_fwnode_remote(&subdev_entity->notifier,
   508							      fwnode,
   509							      struct v4l2_async_subdev);
   510	
   511			of_node_put(subdev_entity->epn);
   512			subdev_entity->epn = NULL;
   513	
   514			if (IS_ERR(asd)) {
   515				ret = PTR_ERR(asd);
   516				goto cleanup_subdev;
   517			}
   518	
   519			subdev_entity->notifier.ops = &isc_async_ops;
   520	
   521			ret = v4l2_async_nf_register(&isc->v4l2_dev,
   522						     &subdev_entity->notifier);
   523			if (ret) {
   524				dev_err(dev, "fail to register async notifier\n");
   525				goto cleanup_subdev;
   526			}
   527	
   528			if (video_is_registered(&isc->video_dev))
   529				break;
   530		}
   531	
   532		pm_runtime_set_active(dev);
   533		pm_runtime_enable(dev);
   534		pm_request_idle(dev);
   535	
   536		isc->ispck = isc->isc_clks[ISC_ISPCK].clk;
   537	
   538		ret = clk_prepare_enable(isc->ispck);
   539		if (ret) {
   540			dev_err(dev, "failed to enable ispck: %d\n", ret);
   541			goto cleanup_subdev;
   542		}
   543	
   544		/* ispck should be greater or equal to hclock */
   545		ret = clk_set_rate(isc->ispck, clk_get_rate(isc->hclock));
   546		if (ret) {
   547			dev_err(dev, "failed to set ispck rate: %d\n", ret);
   548			goto unprepare_clk;
   549		}
   550	
   551		regmap_read(isc->regmap, ISC_VERSION + isc->offsets.version, &ver);
   552		dev_info(dev, "Microchip ISC version %x\n", ver);
   553	
   554		return 0;
   555	
   556	unprepare_clk:
   557		clk_disable_unprepare(isc->ispck);
   558	
   559	cleanup_subdev:
   560		isc_subdev_cleanup(isc);
   561	
 > 562	disable_pm_runtime:
   563		pm_runtime_disable(dev);
   564	
   565	unregister_v4l2_device:
   566		v4l2_device_unregister(&isc->v4l2_dev);
   567	
   568	unprepare_hclk:
   569		clk_disable_unprepare(isc->hclock);
   570	
   571		isc_clk_cleanup(isc);
   572	
   573		return ret;
   574	}
   575	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
