Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7D958154D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239333AbiGZOb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239359AbiGZObT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:31:19 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953C72DA;
        Tue, 26 Jul 2022 07:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658845877; x=1690381877;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HyJuY4dDj8OhMbbzCipE0Oq++iocGKX3QqwG3vu56BM=;
  b=M8TxrMtaYoiseamWYQCdT2JziBD5PecfJasRkRtCViNc08X9W9lQJhud
   ZebtWsHcJo6Xmg7h8mKcRf6CSgJ9IZY0OT8JHSQzObWcc9F/Jo3LoxK1q
   jXG1etU73OMWgGBD8qIce+0DQBlRqDo5nm1eKo9kRLJysFf8CBiclaPOM
   hBu59QYynaiR8zTitRWlkmofJhKPdjZ/nYcLglWobzH0YvThgHwFRJDcw
   fegfNwlvafVcV06qDcD0nE6cf0vOxBVH0jzZnF4BGWcKhoVAbWxVUxg8I
   I9RwXs2Ca6Q7WLEui5lK5ztxRDFNFm6IJZEPNr1KyszeKA4Wc7OJAzfBc
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="349668376"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="349668376"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 07:31:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="603776622"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 26 Jul 2022 07:31:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E3F07F1; Tue, 26 Jul 2022 17:31:12 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Eddie James <eajames@linux.ibm.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] hwmon: (occ) Replace open-coded variant of %*phN specifier
Date:   Tue, 26 Jul 2022 17:31:10 +0300
Message-Id: <20220726143110.4809-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

printf()-like functions in the kernel have extensions, such as
%*phN to dump small pieces of memory as hex bytes.

Replace custom approach with the direct use of %*phN.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwmon/occ/common.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
index 157b73a3da29..45407b12db4b 100644
--- a/drivers/hwmon/occ/common.c
+++ b/drivers/hwmon/occ/common.c
@@ -729,18 +729,14 @@ static ssize_t occ_show_extended(struct device *dev,
 			rc = sysfs_emit(buf, "%u",
 					get_unaligned_be32(&extn->sensor_id));
 		} else {
-			rc = sysfs_emit(buf, "%02x%02x%02x%02x\n",
-					extn->name[0], extn->name[1],
-					extn->name[2], extn->name[3]);
+			rc = sysfs_emit(buf, "%4phN\n", extn->name);
 		}
 		break;
 	case 1:
 		rc = sysfs_emit(buf, "%02x\n", extn->flags);
 		break;
 	case 2:
-		rc = sysfs_emit(buf, "%02x%02x%02x%02x%02x%02x\n",
-				extn->data[0], extn->data[1], extn->data[2],
-				extn->data[3], extn->data[4], extn->data[5]);
+		rc = sysfs_emit(buf, "%6phN\n", extn->data);
 		break;
 	default:
 		return -EINVAL;
-- 
2.35.1

