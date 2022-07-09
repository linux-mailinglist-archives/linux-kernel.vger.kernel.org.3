Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152CA56C528
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 02:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiGIAH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 20:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiGIAHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 20:07:16 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B458466B83;
        Fri,  8 Jul 2022 17:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657325229; x=1688861229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TFn/sMvlvQR9LES2lJ5zpS9l2SX8VRuOj2PgTtGMOGY=;
  b=TuyigJmn09d1pW+/qet1FswMl0u2XrTDXvvAsIDDBp6VhAIo7LAEZMvn
   5Y1K6ASV6aUAkLYR2abL5suC9ENlVY76GzNSyG6syQU8YmS3y85jiz/mU
   l4uutqjiBA6el0fn1GiO0Jups6quaBSKWBS0nqcCodY48WFDLs5k3fC8K
   OBYNchtTZqrO6ci83l0OhVe9wpwJgwz+mZP+N0wEowyLfh8EWaAs596te
   KgHDIZ7qQvkQEKvFbJd1AH8/mtH4UQWnxYUviy5vUIYjVAIJ+LCAoiaJv
   fkZj7pf5O8dTI9Ylut1Y/ZPmkg3G4OiMstu7ofbX3ySxEB00QJ/zddvMO
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="285516172"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="285516172"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 17:07:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="651754287"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 08 Jul 2022 17:07:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CD398AD; Sat,  9 Jul 2022 03:07:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] spi: remove duplicate parameters check in acpi_spi_add_resource()
Date:   Sat,  9 Jul 2022 03:07:09 +0300
Message-Id: <20220709000709.35622-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220709000709.35622-1-andriy.shevchenko@linux.intel.com>
References: <20220709000709.35622-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The acpi_spi_add_resource() is never called with ctrl == NULL and
index == -1. The only caller already performs the check. Hence
remove the duplication from the acpi_spi_add_resource().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index d4a8665410ea..9b080dafa52c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2459,9 +2459,6 @@ static int acpi_spi_add_resource(struct acpi_resource *ares, void *data)
 			if (lookup->index != -1 && lookup->n++ != lookup->index)
 				return 1;
 
-			if (lookup->index == -1 && !ctlr)
-				return -ENODEV;
-
 			status = acpi_get_handle(NULL,
 						 sb->resource_source.string_ptr,
 						 &parent_handle);
-- 
2.35.1

