Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C3D4A85EB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351058AbiBCON2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:13:28 -0500
Received: from mga03.intel.com ([134.134.136.65]:49619 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233643AbiBCONZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:13:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643897605; x=1675433605;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LPWp9f2uly6FLQ+/bYyJY7Be+gTMmKIa7Jwx/IUzBCE=;
  b=Pfv86l8qUZ+ippFXj64H66JWA5NStSTRTrB4hsTL+oCxJP7dRI5Yclkb
   XC0bh8xX+el+ytBY2yCb4JBXtiaugngW/bOmbNKGQHVITz3Ai9zSUhLen
   1XHW/Tk52Ga/mgBBrNcu8FZOtMqBZYXzSy3Hy8nFKDOt3jmrVXUmhUe+E
   XrDwyvmuVZGD1LF571tN9MFWv6dCTu7ErnEIw/e4/ZV3mnmUF3bUkjP9O
   LnLJ5nnpYx98r1rG5LrL03X3jiOeskbfIX0X+sT37oXnQ7FQj2dQQ7ul2
   ZuzOrMEnNOpjBn8rhkAr5ZB33DtGB0gULnS8MeZjjJj1N5obaaGkuVmC7
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="248102379"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="248102379"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 06:13:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="699324072"
Received: from silpixa00400294.ir.intel.com ([10.237.222.100])
  by orsmga005.jf.intel.com with ESMTP; 03 Feb 2022 06:13:06 -0800
From:   Wojciech Ziemba <wojciech.ziemba@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, Wojciech Ziemba <wojciech.ziemba@intel.com>
Subject: [PATCH 0/3] Introduce support for QAT Dynamic Power Management
Date:   Thu,  3 Feb 2022 13:54:31 +0000
Message-Id: <20220203135434.584967-1-wojciech.ziemba@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

--------------------------------------------------------------
Intel Research and Development Ireland Limited
Registered in Ireland
Registered Office: Collinstown Industrial Park, Leixlip, County Kildare
Registered Number: 308263


This e-mail and any attachments may contain confidential material for the sole
use of the intended recipient(s). Any review or distribution by others is
strictly prohibited. If you are not the intended recipient, please contact the
sender and delete all copies.

