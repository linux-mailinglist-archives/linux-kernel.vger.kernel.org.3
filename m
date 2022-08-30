Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156075A70C4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 00:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiH3W1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 18:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbiH3W0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 18:26:48 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9003F1C9;
        Tue, 30 Aug 2022 15:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661898316; x=1693434316;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T23UGD/5EjeN81gASNitfZBg0JcN/vFD5UBlBTbI9bY=;
  b=V7zUVu39WWxGZVx/Jd4PsqTkc6IU+HDhl/mhTbGzgaZfzLKcitm+qarE
   KoR2cPlXy7vaBO463ZpxPSpk2LMEhkNAUM9g2lGFRcH86HIlG3zWMP43R
   pWhKPu+Fo/pxE2yPqxwauzpSnIAA/gfSM1NYHGcbB7WrlqSI55R0NZtP8
   jNqA8kcsQQ00986+SwBup0KShibceAnWtKaFjDt45Fvr37n1uGbPrLnJQ
   gDqBWo2paRU+QU9gBsi32o8nhpQUvPAM//VFcR8p2c34PBH7CoiCKPfe4
   3jwPl1AWXgZ+FLF/bUvLz14KUsGCK2yUpeawbP2+KHw3LzkcYKybDqsEk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="381615058"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="381615058"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 15:19:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="715485464"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 30 Aug 2022 15:19:39 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oT9a2-0000gN-0b;
        Tue, 30 Aug 2022 22:19:34 +0000
Date:   Wed, 31 Aug 2022 06:18:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, andy.shevchenko@gmail.com,
        u.kleine-koenig@pengutronix.de, johan@kernel.org,
        wander@redhat.com, etremblay@distech-controls.com,
        macro@orcam.me.uk, geert+renesas@glider.be, jk@ozlabs.org,
        phil.edworthy@renesas.com, lukas@wunner.de
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v1 tty-next 1/2] 8250: microchip: pci1xxxx: Add driver
 for the quad-uart function in the  multi-function endpoint of pci1xxxx
 device.
Message-ID: <202208310659.5tM9wAHE-lkp@intel.com>
References: <20220830180054.1998296-2-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830180054.1998296-2-kumaravel.thiagarajan@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kumaravel,

I love your patch! Perhaps something to improve:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on linus/master v6.0-rc3 next-20220830]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kumaravel-Thiagarajan/8250-microchip-pci1xxxx-Add-driver-for-the-pci1xxxx-s-quad-uart-function/20220831-020314
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20220831/202208310659.5tM9wAHE-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/075ee716bd7ce075396d0539dffa4ae59e6b985a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kumaravel-Thiagarajan/8250-microchip-pci1xxxx-Add-driver-for-the-pci1xxxx-s-quad-uart-function/20220831-020314
        git checkout 075ee716bd7ce075396d0539dffa4ae59e6b985a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/tty/serial/8250/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/tty/serial/8250/8250_pci1xxxx.c: In function 'mchp_pci1xxxx_setup':
   drivers/tty/serial/8250/8250_pci1xxxx.c:289:32: error: assignment to 'void (*)(struct uart_port *, struct ktermios *, const struct ktermios *)' from incompatible pointer type 'void (*)(struct uart_port *, struct ktermios *, struct ktermios *)' [-Werror=incompatible-pointer-types]
     289 |         port->port.set_termios = mchp_pci1xxxx_set_termios;
         |                                ^
   drivers/tty/serial/8250/8250_pci1xxxx.c: At top level:
>> drivers/tty/serial/8250/8250_pci1xxxx.c:301:6: warning: no previous prototype for 'mchp_pci1xxxx_irq_assign' [-Wmissing-prototypes]
     301 | void mchp_pci1xxxx_irq_assign(struct pci1xxxx_8250 *priv,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_pci1xxxx.c: In function 'pci1xxxx_serial_probe':
   drivers/tty/serial/8250/8250_pci1xxxx.c:395:57: error: 'PCI_IRQ_ALL_TYPES' undeclared (first use in this function)
     395 |         num_vectors  = pci_alloc_irq_vectors(dev, 1, 4, PCI_IRQ_ALL_TYPES);
         |                                                         ^~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_pci1xxxx.c:395:57: note: each undeclared identifier is reported only once for each function it appears in
   drivers/tty/serial/8250/8250_pci1xxxx.c: At top level:
>> drivers/tty/serial/8250/8250_pci1xxxx.c:459:1: warning: data definition has no type or storage class
     459 | module_pci_driver(pci1xxxx_pci_driver);
         | ^~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_pci1xxxx.c:459:1: error: type defaults to 'int' in declaration of 'module_pci_driver' [-Werror=implicit-int]
>> drivers/tty/serial/8250/8250_pci1xxxx.c:459:1: warning: parameter names (without types) in function declaration
   drivers/tty/serial/8250/8250_pci1xxxx.c:452:26: warning: 'pci1xxxx_pci_driver' defined but not used [-Wunused-variable]
     452 | static struct pci_driver pci1xxxx_pci_driver = {
         |                          ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/mchp_pci1xxxx_irq_assign +301 drivers/tty/serial/8250/8250_pci1xxxx.c

   300	
 > 301	void mchp_pci1xxxx_irq_assign(struct pci1xxxx_8250 *priv,
   302				      struct uart_8250_port *uart, int idx)
   303	{
   304		switch (priv->dev->subsystem_device) {
   305		case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_1p0:
   306		case PCI_SUBDEVICE_ID_MCHP_PCI12000:
   307		case PCI_SUBDEVICE_ID_MCHP_PCI11010:
   308		case PCI_SUBDEVICE_ID_MCHP_PCI11101:
   309		case PCI_SUBDEVICE_ID_MCHP_PCI11400:
   310			uart->port.irq = pci_irq_vector(priv->dev, 0);
   311			break;
   312		case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_1p1:
   313			uart->port.irq = pci_irq_vector(priv->dev, 1);
   314			break;
   315		case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_1p2:
   316			uart->port.irq = pci_irq_vector(priv->dev, 2);
   317			break;
   318		case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_1p3:
   319			uart->port.irq = pci_irq_vector(priv->dev, 3);
   320			break;
   321		case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p01:
   322			uart->port.irq = pci_irq_vector(priv->dev, idx);
   323			break;
   324		case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p02:
   325			if (idx > 0)
   326				idx++;
   327			uart->port.irq = pci_irq_vector(priv->dev, idx);
   328			break;
   329		case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p03:
   330			if (idx > 0)
   331				idx += 2;
   332			uart->port.irq = pci_irq_vector(priv->dev, idx);
   333			break;
   334		case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p12:
   335			uart->port.irq = pci_irq_vector(priv->dev, idx + 1);
   336			break;
   337		case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p13:
   338			if (idx > 0)
   339				idx += 1;
   340			uart->port.irq = pci_irq_vector(priv->dev, idx + 1);
   341			break;
   342		case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p23:
   343			uart->port.irq = pci_irq_vector(priv->dev, idx + 2);
   344			break;
   345		case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_3p012:
   346			uart->port.irq = pci_irq_vector(priv->dev, idx);
   347			break;
   348		case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_3p013:
   349			if (idx > 1)
   350				idx++;
   351			uart->port.irq = pci_irq_vector(priv->dev, idx);
   352			break;
   353		case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_3p023:
   354			if (idx > 0)
   355				idx++;
   356			uart->port.irq = pci_irq_vector(priv->dev, idx);
   357			break;
   358		case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_3p123:
   359			uart->port.irq = pci_irq_vector(priv->dev, idx + 1);
   360			break;
   361		case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_4p:
   362		case PCI_SUBDEVICE_ID_MCHP_PCI11414:
   363			uart->port.irq = pci_irq_vector(priv->dev, idx);
   364			break;
   365		}
   366	}
   367	
   368	static int pci1xxxx_serial_probe(struct pci_dev *dev,
   369					 const struct pci_device_id *ent)
   370	{
   371		struct pci1xxxx_8250 *priv;
   372		struct uart_8250_port uart;
   373		unsigned int nr_ports, i;
   374		int num_vectors = 0;
   375		int rc;
   376	
   377		rc = pcim_enable_device(dev);
   378		pci_save_state(dev);
   379		if (rc)
   380			return rc;
   381	
   382		nr_ports = pci1xxxx_get_num_ports(dev);
   383	
   384		priv = devm_kzalloc(&dev->dev, struct_size(priv, line, nr_ports), GFP_KERNEL);
   385	
   386		priv->membase = pcim_iomap(dev, 0, 0);
   387		priv->dev = dev;
   388		priv->nr =  nr_ports;
   389	
   390		if (!priv)
   391			return -ENOMEM;
   392	
   393		pci_set_master(dev);
   394	
   395		num_vectors  = pci_alloc_irq_vectors(dev, 1, 4, PCI_IRQ_ALL_TYPES);
   396		if (num_vectors < 0)
   397			return rc;
   398	
   399		memset(&uart, 0, sizeof(uart));
   400		uart.port.flags = UPF_SHARE_IRQ | UPF_FIXED_TYPE | UPF_FIXED_PORT;
   401		uart.port.uartclk = 48000000;
   402		uart.port.dev = &dev->dev;
   403	
   404		if (num_vectors == 4)
   405			writeb(UART_PCI_CTRL_SET_MULTIPLE_MSI, (priv->membase + UART_PCI_CTRL_REG));
   406		else
   407			uart.port.irq = pci_irq_vector(dev, 0);
   408	
   409		for (i = 0; i < nr_ports; i++) {
   410			if (num_vectors == 4)
   411				mchp_pci1xxxx_irq_assign(priv, &uart, i);
   412			rc = mchp_pci1xxxx_setup(priv, &uart, i);
   413			if (rc) {
   414				dev_err(&dev->dev, "Failed to setup port %u\n", i);
   415				break;
   416			}
   417			priv->line[i] = serial8250_register_8250_port(&uart);
   418	
   419			if (priv->line[i] < 0) {
   420				dev_err(&dev->dev,
   421					"Couldn't register serial port %lx, irq %d, type %d, error %d\n",
   422					uart.port.iobase, uart.port.irq,
   423					uart.port.iotype, priv->line[i]);
   424				break;
   425			}
   426		}
   427	
   428		pci_set_drvdata(dev, priv);
   429	
   430		return 0;
   431	}
   432	
   433	static void pci1xxxx_serial_remove(struct pci_dev *dev)
   434	{
   435		struct pci1xxxx_8250 *priv = pci_get_drvdata(dev);
   436		int i;
   437	
   438		for (i = 0; i < priv->nr; i++)
   439			serial8250_unregister_port(priv->line[i]);
   440	}
   441	
   442	static const struct pci_device_id pci1xxxx_pci_tbl[] = {
   443		{ PCI_DEVICE(PCI_VENDOR_ID_MCHP_PCI1XXXX, PCI_DEVICE_ID_MCHP_PCI11010) },
   444		{ PCI_DEVICE(PCI_VENDOR_ID_MCHP_PCI1XXXX, PCI_DEVICE_ID_MCHP_PCI11101) },
   445		{ PCI_DEVICE(PCI_VENDOR_ID_MCHP_PCI1XXXX, PCI_DEVICE_ID_MCHP_PCI11400) },
   446		{ PCI_DEVICE(PCI_VENDOR_ID_MCHP_PCI1XXXX, PCI_DEVICE_ID_MCHP_PCI11414) },
   447		{ PCI_DEVICE(PCI_VENDOR_ID_MCHP_PCI1XXXX, PCI_DEVICE_ID_MCHP_PCI12000) },
   448		{0,}
   449	};
   450	MODULE_DEVICE_TABLE(pci, pci1xxxx_pci_tbl);
   451	
   452	static struct pci_driver pci1xxxx_pci_driver = {
   453		.name		= "pci1xxxx serial",
   454		.probe		= pci1xxxx_serial_probe,
   455		.remove	= pci1xxxx_serial_remove,
   456		.id_table	= pci1xxxx_pci_tbl,
   457	};
   458	
 > 459	module_pci_driver(pci1xxxx_pci_driver);
   460	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
