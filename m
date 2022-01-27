Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A30249E6D9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 17:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243334AbiA0QBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 11:01:55 -0500
Received: from mga04.intel.com ([192.55.52.120]:25457 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243322AbiA0QBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:01:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643299314; x=1674835314;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gyBZixaBm40qjjJXVPmiJ75pob0TuT04D30E4HETsXo=;
  b=AVuFUIJwgrPxo8wX4MvAUkySZ7BNJc7JpyyUy8WFvgFqiCwyL5sFTuLZ
   HrXpidAXTxCSJNQEB6u4NtOkiz95M5Epk6mQbOfWs0jTfFlkfQClPlNg0
   SZYyHOyV2Ox3vzUeiHiyXaz5PjihHiLpBMs6bTY6HL1RHgg/vIWIexhM0
   Tq4RgeVJhlF3vtPivbLmeBLE3dYT7MehN9KkjFsSfnvnS2X5CKVOkEdiU
   F6Q22oUiYzsSn+yxqiJNHfZqcwq7C6aA63gQh/5DA7xJk0PZF0Lhjg8O1
   6aot2J81lpVre5loqTtaN/q1SY8hUZaUM6z+iwQLDBjYeskcwIeau9tno
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="245735788"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="245735788"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 08:01:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="563833241"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 27 Jan 2022 08:01:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C5CBD167; Thu, 27 Jan 2022 18:01:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Allen Pais <apais@linux.microsoft.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] firmware: tee_bnxt: Use UUID API for exporting the UUID
Date:   Thu, 27 Jan 2022 18:01:50 +0200
Message-Id: <20220127160150.48140-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is export_uuid() function which exports uuid_t to the u8 array.
Use it instead of open coding variant.

This allows to hide the uuid_t internals.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: resent with Cc to Christoph since the original maintainers are
    non-responsive for mare than a year (previous resent was dated
    2021-01-21).

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
2.34.1

