Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E35494626
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 04:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358385AbiATD24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 22:28:56 -0500
Received: from mga09.intel.com ([134.134.136.24]:9423 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358362AbiATD2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 22:28:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642649332; x=1674185332;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yGEX533S2tbV/dEA7pP2AmauuodkY6I0Rfh4AIdL+OM=;
  b=Ub6OmV95sHNDlv2csiKllX7dZD+6gX/pvFXu6BFN4h9/5W26oyaaY1ig
   JyehNGs15hh6nfzfHskFN5bhb7pktxtji2MCCWyyDdmVOUNuTa831Nk4P
   5xo5+OOkSMgMRi+G2MVrvNZ+pVLHrA0GfNPZIdLLTzMSosCGZIlEwlftW
   A/yMjEw5By/4XE+mORf+RvhQDGPYkzqc2qdS2XD/qOHrSHUEmaYIZD+u7
   3Om1uMkp4GCB73PKg1CAvDMEPYKSkZq6X0+kQRGXgLcfT5IKT6Y8p/DUa
   4AydBXzg7AqtulEoADygTjHRYcagqGmc7wgsV4Feikmz88oX1TPzdxw8w
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10232"; a="245055621"
X-IronPort-AV: E=Sophos;i="5.88,301,1635231600"; 
   d="scan'208";a="245055621"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 19:28:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,301,1635231600"; 
   d="scan'208";a="477639300"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 19 Jan 2022 19:28:48 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nAO7z-000Dxo-JC; Thu, 20 Jan 2022 03:28:47 +0000
Date:   Thu, 20 Jan 2022 11:27:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mnyman-xhci:dbc 5/5] drivers/usb/host/xhci-dbgtty.c:423
 xhci_dbc_tty_register_device() warn: unsigned 'port->minor' is never less
 than zero.
Message-ID: <202201200955.C9pzrtCw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git dbc
head:   595547d1cfa3f6c591ea084cc1f77cd45bd81213
commit: 595547d1cfa3f6c591ea084cc1f77cd45bd81213 [5/5] xhci: dbgtty: use IDR to support several dbc instances.
config: riscv-randconfig-m031-20220118 (https://download.01.org/0day-ci/archive/20220120/202201200955.C9pzrtCw-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
drivers/usb/host/xhci-dbgtty.c:423 xhci_dbc_tty_register_device() warn: unsigned 'port->minor' is never less than zero.

vim +423 drivers/usb/host/xhci-dbgtty.c

   407	
   408	static int xhci_dbc_tty_register_device(struct xhci_dbc *dbc)
   409	{
   410		int			ret;
   411		struct device		*tty_dev;
   412		struct dbc_port		*port = dbc_to_port(dbc);
   413	
   414		if (port->registered)
   415			return -EBUSY;
   416	
   417		xhci_dbc_tty_init_port(dbc, port);
   418	
   419		mutex_lock(&dbc_tty_minors_lock);
   420		port->minor = idr_alloc(&dbc_tty_minors, port, 0, 64, GFP_KERNEL);
   421		mutex_unlock(&dbc_tty_minors_lock);
   422	
 > 423		if (port->minor < 0) {
   424			ret = port->minor;
   425			goto err_idr;
   426		}
   427	
   428		ret = kfifo_alloc(&port->write_fifo, DBC_WRITE_BUF_SIZE, GFP_KERNEL);
   429		if (ret)
   430			goto err_exit_port;
   431	
   432		ret = xhci_dbc_alloc_requests(dbc, BULK_IN, &port->read_pool,
   433					      dbc_read_complete);
   434		if (ret)
   435			goto err_free_fifo;
   436	
   437		ret = xhci_dbc_alloc_requests(dbc, BULK_OUT, &port->write_pool,
   438					      dbc_write_complete);
   439		if (ret)
   440			goto err_free_requests;
   441	
   442		tty_dev = tty_port_register_device(&port->port,
   443						   dbc_tty_driver, port->minor, NULL);
   444		if (IS_ERR(tty_dev)) {
   445			ret = PTR_ERR(tty_dev);
   446			goto err_free_requests;
   447		}
   448	
   449		port->registered = true;
   450	
   451		return 0;
   452	
   453	err_free_requests:
   454		xhci_dbc_free_requests(&port->read_pool);
   455		xhci_dbc_free_requests(&port->write_pool);
   456	err_free_fifo:
   457		kfifo_free(&port->write_fifo);
   458	err_exit_port:
   459		idr_remove(&dbc_tty_minors, port->minor);
   460	err_idr:
   461		xhci_dbc_tty_exit_port(port);
   462	
   463		dev_err(dbc->dev, "can't register tty port, err %d\n", ret);
   464	
   465		return ret;
   466	}
   467	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
