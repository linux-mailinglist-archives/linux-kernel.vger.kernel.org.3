Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4E84B0F7F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 14:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242529AbiBJN6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 08:58:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235060AbiBJN6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 08:58:09 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F0B9A;
        Thu, 10 Feb 2022 05:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644501490; x=1676037490;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wHeKyQCVnyauIWBqHolq/Aeqe75EVRZohHRCGcosvUQ=;
  b=T3Vf8AWRRcNfqPdFPql/dEV4d3AGuOnQHXvBjjWs0BXu9woK/ucMM3xM
   tlj4jG3v8GVoLVgKgwDsia+mKHlsFHJ31ORunTQ1PRo4scz7JaoDVYHzV
   FOFWgywEWvMaECJ0LtFELg6vzF7a2Gagp9q2h/ggtouFQXV5fPHZMM3Zh
   o9QO0KPCjhhM12StC6vVQ42ycIpgMBWJ3Dk/j+ID3YvG9/wRyBOY7Jd7U
   pnUBexKGYOrxQqZs0JhgrF4HCr6DlR3rpkAPqkzk/0UCXrZ44NVTzV1wt
   CwwM68scG0057m4xEjTuH2czMNNjIZXLQs8R7scbjGCgE6YtuIBKi7YIv
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="335910153"
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="335910153"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 05:58:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="526487206"
Received: from silpixa00400294.ir.intel.com ([10.237.222.100])
  by orsmga007.jf.intel.com with ESMTP; 10 Feb 2022 05:58:08 -0800
From:   Wojciech Ziemba <wojciech.ziemba@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, Wojciech Ziemba <wojciech.ziemba@intel.com>
Subject: [PATCH v2 0/3] Introduce support for QAT Dynamic Power Management
Date:   Thu, 10 Feb 2022 13:38:24 +0000
Message-Id: <20220210133827.2366901-1-wojciech.ziemba@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set consist of following updates:
1. Add misc workqueue for general purpose usage.
2. Move error source related CSRs from 4xxx to the wider GEN4 header
file.
3. Add support for HW QAT Power Management (PM) feature.
        This feature is enabled at init time (1) by sending an admin
message to
        the firmware, targeting the admin AE, that sets the idle time
before
        the device changes state and (2) by unmasking the PM source of
        interrupt in ERRMSK2.

        The interrupt handler is extended to handle a PM interrupt which
        is triggered by HW when a PM transition occurs. In this case,
the
        driver responds acknowledging the transaction using the HOST_MSG
        mailbox.

Changes since v1:
- Moved unmasking PM interrupts after PM interrupt source enable to
  avoid a spurious interrupt
- Fixed kbuild bot issue by moving adf_handle_pm_int() out of
  CONFIG_PCI_IOV scope
- Rename [..]_init_pm() functions to [..]_enable_pm() as the function
  needs to be called inside adf_start()


Wojciech Ziemba (3):
  crypto: qat - add misc workqueue
  crypto: qat - move and rename GEN4 error register definitions
  crypto: qat - enable power management for QAT GEN4

 .../crypto/qat/qat_4xxx/adf_4xxx_hw_data.c    |  21 +--
 .../crypto/qat/qat_4xxx/adf_4xxx_hw_data.h    |  24 ---
 drivers/crypto/qat/qat_common/Makefile        |   1 +
 .../crypto/qat/qat_common/adf_accel_devices.h |   2 +
 drivers/crypto/qat/qat_common/adf_admin.c     |  37 +++++
 .../crypto/qat/qat_common/adf_common_drv.h    |   4 +
 drivers/crypto/qat/qat_common/adf_ctl_drv.c   |   6 +
 .../crypto/qat/qat_common/adf_gen4_hw_data.h  |  14 ++
 drivers/crypto/qat/qat_common/adf_gen4_pm.c   | 137 ++++++++++++++++++
 drivers/crypto/qat/qat_common/adf_gen4_pm.h   |  44 ++++++
 drivers/crypto/qat/qat_common/adf_init.c      |   6 +
 drivers/crypto/qat/qat_common/adf_isr.c       |  42 ++++++
 .../qat/qat_common/icp_qat_fw_init_admin.h    |   1 +
 13 files changed, 306 insertions(+), 33 deletions(-)
 create mode 100644 drivers/crypto/qat/qat_common/adf_gen4_pm.c
 create mode 100644 drivers/crypto/qat/qat_common/adf_gen4_pm.h

-- 
2.29.2

