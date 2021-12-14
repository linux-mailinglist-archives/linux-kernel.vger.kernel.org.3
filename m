Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC304741E9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 13:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbhLNMBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 07:01:09 -0500
Received: from mga11.intel.com ([192.55.52.93]:16769 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229579AbhLNMBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 07:01:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639483268; x=1671019268;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oZJUHPH1yotOnSZkKJ/4AQ9YUNfC9FQ4k3ALhKElxTw=;
  b=Hf2o6naKp9/aVyrbdMEcOtxXphJ8DIc/yT1cves2Dp7Z1rS+0qt5n8d3
   YgZl9/e2CnSYqR5rZ8FcsKzC86vcKTv79kWaP3QUrwe6YfM34HxTj+nar
   eolG0h6BF5Ik4ux3htv295mhxgqulqk8lmBdduo0U5i33V2CQG5/XuZdE
   EfDT7XfWSVTvWmaqaw0zzBpV+Jr6/84JJ1lZ5jMTAr2cJQI8NIaEk6oRD
   GebO40KRkBNltWcUla8Gnr+m/40OOFPVWmBiYHBMLhVZlMuWxxAusiUkO
   Ei52k0QwX7dJWtH54twOrX9banwjF8rpuD0AGSelpzQlvFkCU4wuv9fM/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="236495785"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="236495785"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 04:01:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="465054778"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 14 Dec 2021 04:01:06 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mx6UT-0000Fu-DF; Tue, 14 Dec 2021 12:01:05 +0000
Date:   Tue, 14 Dec 2021 20:00:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [robh:for-kernelci 1/9] drivers/tty/serial/lantiq.c:732
 fetch_irq_lantiq() warn: unsigned 'ltq_port->tx_irq' is never less than
 zero.
Message-ID: <202112141920.cCz4wG5n-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-kernelci
head:   0e59c9b64d3363b98201fc040101f8ff62c7eafb
commit: e12887def507246bafed1c9b1b7f4f03ab225da5 [1/9] serial: lantiq: Remove usage of of_irq_to_resource_table()/of_irq_get()
config: i386-randconfig-m021-20211210 (https://download.01.org/0day-ci/archive/20211214/202112141920.cCz4wG5n-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
drivers/tty/serial/lantiq.c:732 fetch_irq_lantiq() warn: unsigned 'ltq_port->tx_irq' is never less than zero.
drivers/tty/serial/lantiq.c:735 fetch_irq_lantiq() warn: unsigned 'ltq_port->rx_irq' is never less than zero.
drivers/tty/serial/lantiq.c:738 fetch_irq_lantiq() warn: unsigned 'ltq_port->err_irq' is never less than zero.

vim +732 drivers/tty/serial/lantiq.c

   725	
   726	static int fetch_irq_lantiq(struct device *dev, struct ltq_uart_port *ltq_port)
   727	{
   728		struct uart_port *port = &ltq_port->port;
   729		struct platform_device *pdev = to_platform_device(dev);
   730	
   731		ltq_port->tx_irq = platform_get_irq(pdev, 0);
 > 732		if (ltq_port->tx_irq < 0)
   733			return ltq_port->tx_irq;
   734		ltq_port->rx_irq = platform_get_irq(pdev, 1);
 > 735		if (ltq_port->rx_irq < 0)
   736			return ltq_port->rx_irq;
   737		ltq_port->err_irq = platform_get_irq(pdev, 2);
 > 738		if (ltq_port->err_irq < 0)
   739			return ltq_port->err_irq;
   740	
   741		port->irq = ltq_port->tx_irq;
   742	
   743		return 0;
   744	}
   745	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
