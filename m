Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAE64C7D97
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 23:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbiB1WkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 17:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiB1WkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:40:06 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E4F125580;
        Mon, 28 Feb 2022 14:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646087967; x=1677623967;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I/xzPQYPViZYmQiFHdTjC1qJcKT4z40XLV6xEE2jUmU=;
  b=bPEj2W6S6AOoj9CA5BM3EOBFFtILfYxU5zz0U8mhsFa98XnNK1c78OfL
   zpQct25IRCSF2IhSv71jTDR6vVdEtJnV2FzVuyoP/R86rMQpzrEyMBTE0
   Rm+IeLZcvKDpKw4Ed2R8Aa2Sv8xNNSNilGhR77efkqSR1CIPNiH/5v8+A
   UukCfsJU0njwjBV5vn2Qa7kKwtw5ciyQ/ixO3Xhvzpy/CGgCEiMQoWvcm
   TC2DHyLMl0OkL+pFIyx5RvjwEQW5lGV3e3WroxvWYLm1Z8lekr8J6j57s
   pg0OeFzqQDTy91JbWRKf7wLh4kMDK2BJayypnWxGLehCbfeJhEzSni+2x
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="313724231"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="313724231"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 14:39:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="685501808"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2022 14:39:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2372F14A; Tue,  1 Mar 2022 00:39:42 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 3/7] ACPI: enumeration: Remove redundant .owner assignment
Date:   Tue,  1 Mar 2022 00:39:32 +0200
Message-Id: <20220228223936.54310-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220228223936.54310-1-andriy.shevchenko@linux.intel.com>
References: <20220228223936.54310-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The owner member of the struct i2c_driver is assigned by a corresponding macro.
No need to assign it explicitly.

Fixes: 59c3987805a9 ("ACPI: add documentation about ACPI 5 enumeration")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/firmware-guide/acpi/enumeration.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/firmware-guide/acpi/enumeration.rst b/Documentation/firmware-guide/acpi/enumeration.rst
index f4bb5ddca528..c7dbf79d45b0 100644
--- a/Documentation/firmware-guide/acpi/enumeration.rst
+++ b/Documentation/firmware-guide/acpi/enumeration.rst
@@ -282,7 +282,6 @@ input driver::
 	static struct i2c_driver mpu3050_i2c_driver = {
 		.driver	= {
 			.name	= "mpu3050",
-			.owner	= THIS_MODULE,
 			.pm	= &mpu3050_pm,
 			.of_match_table = mpu3050_of_match,
 			.acpi_match_table = ACPI_PTR(mpu3050_acpi_match),
@@ -291,6 +290,7 @@ input driver::
 		.remove		= mpu3050_remove,
 		.id_table	= mpu3050_ids,
 	};
+	module_i2c_driver(mpu3050_i2c_driver);
 
 Reference to PWM device
 =======================
-- 
2.34.1

