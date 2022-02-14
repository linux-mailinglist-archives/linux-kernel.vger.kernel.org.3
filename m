Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E914B4F42
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352170AbiBNLjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:39:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351964AbiBNLj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:39:29 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43814BC86;
        Mon, 14 Feb 2022 03:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644838175; x=1676374175;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xqXAjqj9UB3uzzHP4hrVah9w4aiJB22TXUi2vtc3JR4=;
  b=bndRfRJgZAuW1GRN5IIqbeieYL5ioaa0Mlnc61PqzcrmWgbg0y+Z/oQ0
   9aEbzDtvTCj226l1RvwVKLT50NX8q3qcqs0bRh/EiqrDKVZ6dPmsBRasX
   lYj4jRi7cnsgneRboNhna52fmV+32J/f55bSw2GYAHymiadehgHF4nr8i
   iIr+OxuURf1U/TAR4FSD2o+PIJ5IjAWz5mDd4E6+y4nrWWOCIhOBLh3KK
   HGJFu4NZCAWNa2cIOoLAJW8tN95Qefq1g0veqaVzZEFfUStS3jAo7cqCH
   BIqzy88aW6427ktsuUjVviKwtGRcnJeft+IrnNtAnUsyUQptoRXzpQq9L
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="250276718"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="250276718"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 03:29:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="587166931"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by fmsmga008.fm.intel.com with ESMTP; 14 Feb 2022 03:29:32 -0800
From:   Tianfei zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, Tianfei zhang <tianfei.zhang@intel.com>
Subject: [PATCH v1 0/7] Add Intel OFS support for DFL driver
Date:   Mon, 14 Feb 2022 06:26:12 -0500
Message-Id: <20220214112619.219761-1-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adding IOFS (Intel Open FPGA stack) support for
DFL driver. IOFS is Intel's version of a common core set of
RTL to allow customers to easily interface to logic and IP
on the FPGA. IOFS leverage the DFL for the implementation of
the FPGA RTL design.

Patch 1, adds architecture description about IOFS support for DFL
in documentation.
Patch 2, checks feature type during the user interrupt enumeration.
On IOFS, the Feature ID of the PMCI device and Port User Interrupts
are identical.
Patch 3, allows a port may not be connected any local BAR space.
Patch 4 and 5, fix VF creation when ports have no local
BAR space and no port connected to VF.
Patch 6, handles dfl's starting with AFU and allows for VFs
to be created.
Patch 7, adds PCIe Device ID for OFS. 

Matthew Gerlach (5):
  fpga: dfl: Allow for ports with no local bar space.
  fpga: dfl: fix VF creation when ports have no local BAR space
  drivers: fpga: dfl: handle empty port list
  fpga: dfl: Handle dfl's starting with AFU
  fpga: dfl: pci: Add generic OFS PCI PID

Tianfei Zhang (2):
  Documentation: fpga: dfl: add description of IOFS
  fpga: dfl: check feature type before parse irq info

 Documentation/fpga/dfl.rst | 99 +++++++++++++++++++++++++++++++++++++-
 drivers/fpga/dfl-pci.c     | 19 +++++++-
 drivers/fpga/dfl.c         | 47 +++++++++++++-----
 3 files changed, 151 insertions(+), 14 deletions(-)


base-commit: f1baf68e1383f6ed93eb9cff2866d46562607a43
-- 
2.17.1

