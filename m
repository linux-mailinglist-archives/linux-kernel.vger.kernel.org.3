Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6955A0ED4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 13:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241416AbiHYLRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 07:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237854AbiHYLRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:17:11 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EAFAEDA3;
        Thu, 25 Aug 2022 04:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661426230; x=1692962230;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z5RouuAve2+jxGRgV1TIbVlWtMgQgmKAmpebOxdUZwU=;
  b=KQkhTVM8Jaj3bFzcqbgXj7v6PD/PGsoRcbBS/QQ36GC/XB21V+7YPSGA
   YE6g5m4cFOeRQoQIhM63JZzxpz8zVuo8GUNEVsjgjmdQtozPGQah9m+Gv
   HYWlqyaYCF/YH1peGGcj4N0DYzCfRXLqk0xlKV9439ELVkQfR13L8gzgW
   KGE7uz8X5z7QXWWmQYTsv2Fn24ziS+Jyen5gn4o6sj4YncTyZUWB0ZCkV
   yF435BpSPJEaYX+rJpwx/Jso5Tf5NuHhrDA2HMXB0k1LGY/4D4n7PQOL5
   l/AkP9mxCArY+80tLGmW3RFgm5GP3Yr4eAPYGLlCBF5KczuvdHDYzkbdZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="281183062"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="281183062"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 04:17:06 -0700
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="736225192"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 04:17:04 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 63F2A20531;
        Thu, 25 Aug 2022 14:17:02 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1oRArM-00Ch8J-3Z; Thu, 25 Aug 2022 14:17:16 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        sbinding@opensource.cirrus.com, andriy.shevchenko@intel.com,
        patches@opensource.cirrus.com, rafael@kernel.org
Subject: [PATCH 1/1] acpi: Remove default association from integer maximum values
Date:   Thu, 25 Aug 2022 14:17:15 +0300
Message-Id: <20220825111715.3025694-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the default association from integer maximum value checks. It is
not necessary and has caused a bug in other associations being unnoticed.

Fixes: 923044133367 ("ACPI: property: Unify integer value reading functions")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 91d0e75859d37..d4c168ce428ca 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1046,8 +1046,7 @@ static int acpi_data_prop_read_single(const struct acpi_device_data *data,
 								u8 *: U8_MAX, \
 								u16 *: U16_MAX, \
 								u32 *: U32_MAX, \
-								u64 *: U64_MAX, \
-								default: 0U)) { \
+								u64 *: U64_MAX)) { \
 				ret = -EOVERFLOW;			\
 				break;					\
 			}						\
-- 
2.30.2

