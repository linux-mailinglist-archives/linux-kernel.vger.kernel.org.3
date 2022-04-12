Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81DA4FDF99
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241926AbiDLM0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239826AbiDLM0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:26:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAAA7306F;
        Tue, 12 Apr 2022 04:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649763176; x=1681299176;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SKjITbPb7i0r99ypkNUGhZ8LVM6D2ZzpcpXODGPohDQ=;
  b=iWnMgIoq6Bw5QWZzPswk2qF7N6k6KAU4+yyBV5oiZsYteKk1VHgjF4nR
   qtV/kpSp/v8Am/2IrOQRZNMUIajc78x7a1GDda9tbxlCnyV9WdjXOqo9G
   RAHZePTnaFv3PQpSWa/vd/rdATqFZBu2dCEST35rfVubtrUAZq1DdyBpV
   NV79jP0Q1tXLVeE94x33XtFsM/xl06c3sm5E23yesu44EX9SBVXPKEEA1
   b0ifPts5Z91vhvSEJNw2P68uK7jhaDo8Yafo8XDanBKoqj/gG+a9mDOx0
   k7RQ7MVoM5babXcaRfqjCRe9RApq9gulrbiNUe+AVq/8/Wy3og4DmFsHR
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="262534791"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="262534791"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 04:32:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="655072819"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 12 Apr 2022 04:32:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 260E212C; Tue, 12 Apr 2022 14:32:53 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Allen Pais <apais@linux.microsoft.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 1/1] firmware: tee_bnxt: Use UUID API for exporting the UUID
Date:   Tue, 12 Apr 2022 14:32:50 +0300
Message-Id: <20220412113250.57997-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is export_uuid() function which exports uuid_t to the u8 array.
Use it instead of open coding variant.

This allows to hide the uuid_t internals.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: rebased on the latest vanilla, added Andrew since it has no move for 1y+
 drivers/firmware/broadcom/tee_bnxt_fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/broadcom/tee_bnxt_fw.c b/drivers/firmware/broadcom/tee_bnxt_fw.c
index a5bf4c3f6dc7..40e3183a3d11 100644
--- a/drivers/firmware/broadcom/tee_bnxt_fw.c
+++ b/drivers/firmware/broadcom/tee_bnxt_fw.c
@@ -197,7 +197,7 @@ static int tee_bnxt_fw_probe(struct device *dev)
 		return -ENODEV;
 
 	/* Open session with Bnxt load Trusted App */
-	memcpy(sess_arg.uuid, bnxt_device->id.uuid.b, TEE_IOCTL_UUID_LEN);
+	export_uuid(sess_arg.uuid, &bnxt_device->id.uuid);
 	sess_arg.clnt_login = TEE_IOCTL_LOGIN_PUBLIC;
 	sess_arg.num_params = 0;
 
-- 
2.35.1

