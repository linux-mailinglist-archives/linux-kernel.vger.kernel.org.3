Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D0348D021
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 02:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiAMB33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 20:29:29 -0500
Received: from mga11.intel.com ([192.55.52.93]:1861 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231303AbiAMB32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 20:29:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642037368; x=1673573368;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=44E57msuB2H7YHdtNqAyGFlMXG9dpj/zagbz7iiFyqo=;
  b=X/eqJTuHBQkEeY0lr70BclWaae+vev6wNoWHSTOUjcMi75OzRDOGnTXk
   p6wiqm1ceBQp/82u6y0AAW9j5OSSlSCu9yHDmnmh00pe6tl/wDeLSb/FX
   Zz6cwvBzYCTFBRjLYLdfKHreC0Ya2rD/N47J9RGbVGBH5udsLWhLKfbHU
   Mg1w6ck3DsE/ZaCqu37nIrXpUBr2EGCeSo4PyU5FgElYe1HeC7FsrPTDX
   37N7V0AkHkM5gFBpgPhHAvbAHiR3S7MQeNuNIZF2be5JTQmCu0FLNgWVg
   XIFvtUP2XVmvm/ZtMC6LbT1GajSFZB+e7I8A2uCLkw9LE6hMLQdMP02IM
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="241459798"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="241459798"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 17:29:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="558926219"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 12 Jan 2022 17:29:26 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7ovd-0006fh-Iq; Thu, 13 Jan 2022 01:29:25 +0000
Date:   Thu, 13 Jan 2022 09:28:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Russell King <rmk+kernel@arm.linux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [rmk-arm:clearfog 9/10] drivers/pci/pcie/aspm.c:581
 pcie_aspm_cap_init() warn: inconsistent indenting
Message-ID: <202201130852.IDPlE7QI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm clearfog
head:   27b69dc920b15953866994cb8b100311543699e8
commit: 6289d10eda064419c96bdbc966aadf3a6e0c43be [9/10] mvebu/clearfog pcie updates
config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220113/202201130852.IDPlE7QI-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
drivers/pci/pcie/aspm.c:581 pcie_aspm_cap_init() warn: inconsistent indenting

vim +581 drivers/pci/pcie/aspm.c

   542	
   543	static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
   544	{
   545		struct pci_dev *child = link->downstream, *parent = link->pdev;
   546		u32 parent_lnkcap, child_lnkcap;
   547		u16 parent_lnkctl, child_lnkctl;
   548		u32 parent_l1ss_cap, child_l1ss_cap;
   549		u32 parent_l1ss_ctl1 = 0, child_l1ss_ctl1 = 0;
   550		struct pci_bus *linkbus = parent->subordinate;
   551	
   552		if (blacklist) {
   553			/* Set enabled/disable so that we will disable ASPM later */
   554			link->aspm_enabled = ASPM_STATE_ALL;
   555			link->aspm_disable = ASPM_STATE_ALL;
   556			return;
   557		}
   558	
   559		/*
   560		 * If ASPM not supported, don't mess with the clocks and link,
   561		 * bail out now.
   562		 */
   563		pcie_capability_read_dword(parent, PCI_EXP_LNKCAP, &parent_lnkcap);
   564		pcie_capability_read_dword(child, PCI_EXP_LNKCAP, &child_lnkcap);
   565		if (!(parent_lnkcap & child_lnkcap & PCI_EXP_LNKCAP_ASPMS))
   566			return;
   567	
   568		/* Configure common clock before checking latencies */
   569		pcie_aspm_configure_common_clock(link);
   570	
   571		/*
   572		 * Re-read upstream/downstream components' register state after
   573		 * clock configuration.  L0s & L1 exit latencies in the otherwise
   574		 * read-only Link Capabilities may change depending on common clock
   575		 * configuration (PCIe r5.0, sec 7.5.3.6).
   576		 */
   577		pcie_capability_read_dword(parent, PCI_EXP_LNKCAP, &parent_lnkcap);
   578		pcie_capability_read_dword(child, PCI_EXP_LNKCAP, &child_lnkcap);
   579		pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &parent_lnkctl);
   580		pcie_capability_read_word(child, PCI_EXP_LNKCTL, &child_lnkctl);
 > 581	dev_info(&parent->dev, "up support %x enabled %x\n",
   582		 (parent_lnkcap & PCI_EXP_LNKCAP_ASPMS) >> 10,
   583		 !!(parent_lnkctl & PCI_EXP_LNKCTL_ASPMC));
   584	dev_info(&parent->dev, "dn support %x enabled %x\n",
   585		 (child_lnkcap & PCI_EXP_LNKCAP_ASPMS) >> 10,
   586		 !!(child_lnkctl & PCI_EXP_LNKCTL_ASPMC));
   587	
   588		/*
   589		 * Setup L0s state
   590		 *
   591		 * Note that we must not enable L0s in either direction on a
   592		 * given link unless components on both sides of the link each
   593		 * support L0s.
   594		 */
   595		if (parent_lnkcap & child_lnkcap & PCI_EXP_LNKCAP_ASPM_L0S)
   596			link->aspm_support |= ASPM_STATE_L0S;
   597	
   598		if (child_lnkctl & PCI_EXP_LNKCTL_ASPM_L0S)
   599			link->aspm_enabled |= ASPM_STATE_L0S_UP;
   600		if (parent_lnkctl & PCI_EXP_LNKCTL_ASPM_L0S)
   601			link->aspm_enabled |= ASPM_STATE_L0S_DW;
   602		link->latency_up.l0s = calc_l0s_latency(parent_lnkcap);
   603		link->latency_dw.l0s = calc_l0s_latency(child_lnkcap);
   604	
   605		/* Setup L1 state */
   606		if (parent_lnkcap & child_lnkcap & PCI_EXP_LNKCAP_ASPM_L1)
   607			link->aspm_support |= ASPM_STATE_L1;
   608	
   609		if (parent_lnkctl & child_lnkctl & PCI_EXP_LNKCTL_ASPM_L1)
   610			link->aspm_enabled |= ASPM_STATE_L1;
   611		link->latency_up.l1 = calc_l1_latency(parent_lnkcap);
   612		link->latency_dw.l1 = calc_l1_latency(child_lnkcap);
   613	
   614		/* Setup L1 substate */
   615		pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CAP,
   616				      &parent_l1ss_cap);
   617		pci_read_config_dword(child, child->l1ss + PCI_L1SS_CAP,
   618				      &child_l1ss_cap);
   619	
   620		if (!(parent_l1ss_cap & PCI_L1SS_CAP_L1_PM_SS))
   621			parent_l1ss_cap = 0;
   622		if (!(child_l1ss_cap & PCI_L1SS_CAP_L1_PM_SS))
   623			child_l1ss_cap = 0;
   624	
   625		/*
   626		 * If we don't have LTR for the entire path from the Root Complex
   627		 * to this device, we can't use ASPM L1.2 because it relies on the
   628		 * LTR_L1.2_THRESHOLD.  See PCIe r4.0, secs 5.5.4, 6.18.
   629		 */
   630		if (!child->ltr_path)
   631			child_l1ss_cap &= ~PCI_L1SS_CAP_ASPM_L1_2;
   632	
   633		if (parent_l1ss_cap & child_l1ss_cap & PCI_L1SS_CAP_ASPM_L1_1)
   634			link->aspm_support |= ASPM_STATE_L1_1;
   635		if (parent_l1ss_cap & child_l1ss_cap & PCI_L1SS_CAP_ASPM_L1_2)
   636			link->aspm_support |= ASPM_STATE_L1_2;
   637		if (parent_l1ss_cap & child_l1ss_cap & PCI_L1SS_CAP_PCIPM_L1_1)
   638			link->aspm_support |= ASPM_STATE_L1_1_PCIPM;
   639		if (parent_l1ss_cap & child_l1ss_cap & PCI_L1SS_CAP_PCIPM_L1_2)
   640			link->aspm_support |= ASPM_STATE_L1_2_PCIPM;
   641	
   642		if (parent_l1ss_cap)
   643			pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
   644					      &parent_l1ss_ctl1);
   645		if (child_l1ss_cap)
   646			pci_read_config_dword(child, child->l1ss + PCI_L1SS_CTL1,
   647					      &child_l1ss_ctl1);
   648	
   649		if (parent_l1ss_ctl1 & child_l1ss_ctl1 & PCI_L1SS_CTL1_ASPM_L1_1)
   650			link->aspm_enabled |= ASPM_STATE_L1_1;
   651		if (parent_l1ss_ctl1 & child_l1ss_ctl1 & PCI_L1SS_CTL1_ASPM_L1_2)
   652			link->aspm_enabled |= ASPM_STATE_L1_2;
   653		if (parent_l1ss_ctl1 & child_l1ss_ctl1 & PCI_L1SS_CTL1_PCIPM_L1_1)
   654			link->aspm_enabled |= ASPM_STATE_L1_1_PCIPM;
   655		if (parent_l1ss_ctl1 & child_l1ss_ctl1 & PCI_L1SS_CTL1_PCIPM_L1_2)
   656			link->aspm_enabled |= ASPM_STATE_L1_2_PCIPM;
   657	
   658		if (link->aspm_support & ASPM_STATE_L1SS)
   659			aspm_calc_l1ss_info(link, parent_l1ss_cap, child_l1ss_cap);
   660	
   661		/* Save default state */
   662		link->aspm_default = link->aspm_enabled;
   663	
   664		/* Setup initial capable state. Will be updated later */
   665		link->aspm_capable = link->aspm_support;
   666	
   667		/* Get and check endpoint acceptable latencies */
   668		list_for_each_entry(child, &linkbus->devices, bus_list) {
   669			u32 reg32, encoding;
   670			struct aspm_latency *acceptable =
   671				&link->acceptable[PCI_FUNC(child->devfn)];
   672	
   673			if (pci_pcie_type(child) != PCI_EXP_TYPE_ENDPOINT &&
   674			    pci_pcie_type(child) != PCI_EXP_TYPE_LEG_END)
   675				continue;
   676	
   677			pcie_capability_read_dword(child, PCI_EXP_DEVCAP, &reg32);
   678			/* Calculate endpoint L0s acceptable latency */
   679			encoding = (reg32 & PCI_EXP_DEVCAP_L0S) >> 6;
   680			acceptable->l0s = calc_l0s_acceptable(encoding);
   681			/* Calculate endpoint L1 acceptable latency */
   682			encoding = (reg32 & PCI_EXP_DEVCAP_L1) >> 9;
   683			acceptable->l1 = calc_l1_acceptable(encoding);
   684	
   685			pcie_aspm_check_latency(child);
   686		}
   687	}
   688	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
