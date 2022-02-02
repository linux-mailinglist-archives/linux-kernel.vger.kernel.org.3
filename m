Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0134A7A0B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 22:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347443AbiBBVKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 16:10:45 -0500
Received: from mga06.intel.com ([134.134.136.31]:55101 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347458AbiBBVKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:10:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643836237; x=1675372237;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iMWumcGhp4QWhnuLTMkak/W/OcXG87n/jUcrqAHhooc=;
  b=XzH+WgfPZ5Pv0I+2+XJOIPu4RigYn/WEiQRpZiXOz3YX+jrizbQOfM3o
   nmvdXqjJlQpdtFXPnTx72k8xLkNBV3cj3IdUcYuusr64xTTZ3Bkd0+5Hg
   5KWgWMuGJRXEotHJE0cHA6izNUXaZ4a1BxH8MEPeeCcge7oA8UO22apbt
   DZ9Fa4P4nm5Lqzs4462HWRBOIV9bNAKY2yiih8uy4Y39pj+u9L6hfEo2f
   xXUGK1MYj6pvLWcn/AArX6OlCg4ezMKZ4AlXs8lOLc5QMbcmbiAjJzq+R
   uZYY66EGwdXh5yId0N/8M1izpIrqhGWRE/p9ZsjmwhLnKVyQ0rVKqzAnL
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="308749204"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="308749204"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 13:10:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="699056130"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 02 Feb 2022 13:10:27 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFMtW-000V8Q-Ni; Wed, 02 Feb 2022 21:10:26 +0000
Date:   Thu, 3 Feb 2022 05:09:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jorgen Hansen <jhansen@vmware.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     kbuild-all@lists.01.org, gregkh@linuxfoundation.org,
        pv-drivers@vmware.com, Jorgen Hansen <jhansen@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>
Subject: [RFC PATCH] VMCI: dma dg: vmci_read_reg() can be static
Message-ID: <20220202210943.GA88437@f185d0c9484e>
References: <20220202144910.10349-3-jhansen@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202144910.10349-3-jhansen@vmware.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/misc/vmw_vmci/vmci_guest.c:93:14: warning: symbol 'vmci_read_reg' was not declared. Should it be static?
drivers/misc/vmw_vmci/vmci_guest.c:100:6: warning: symbol 'vmci_write_reg' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 vmci_guest.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index d00430e5aba36..081f7b0c23f5f 100644
--- a/drivers/misc/vmw_vmci/vmci_guest.c
+++ b/drivers/misc/vmw_vmci/vmci_guest.c
@@ -90,14 +90,14 @@ u32 vmci_get_vm_context_id(void)
 	return vm_context_id;
 }
 
-unsigned int vmci_read_reg(struct vmci_guest_device *dev, u32 reg)
+static unsigned int vmci_read_reg(struct vmci_guest_device *dev, u32 reg)
 {
 	if (dev->mmio_base != NULL)
 		return readl(dev->mmio_base + reg);
 	return ioread32(dev->iobase + reg);
 }
 
-void vmci_write_reg(struct vmci_guest_device *dev, u32 val, u32 reg)
+static void vmci_write_reg(struct vmci_guest_device *dev, u32 val, u32 reg)
 {
 	if (dev->mmio_base != NULL)
 		writel(val, dev->mmio_base + reg);
