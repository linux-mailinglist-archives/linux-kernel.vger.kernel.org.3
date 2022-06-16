Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3B454E83F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 19:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347257AbiFPQ76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240141AbiFPQ6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:58:32 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B7F3B546
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655398711; x=1686934711;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S5O1PtSeWWp85IzvqLzspKlCA3tRqJn7LtXeyvRwsbI=;
  b=cMBhkc6IAJ8AxpW5r0zFXRL5XRn0wJCvd98bLwmdhcL9hKrTGc5HP5wn
   mGo2j5q6B2i+OpnMn3gOxYqr2Ck27Xa3CJ5ESBzxsRAH8r6OUE+3h1nyj
   DcXJrpUKgtR1Qefp/Mp3m2Al90NqxK4xUMwaCYdyd5uWQ1Xt1t3p8n296
   kU1jV8rdkDmPBJYgQQvvikHzs7d5xVt8DfkbSMdOKhEZxz+pdiyLwAEF/
   Z+gOYDYou8kcNlDld4zNQFBKVxT+/CgYBycbFUo5l9aI81/0l+L/mcI7s
   z6MRT48W+blrvwSy1+TjgTMliHHdgt1hZ2DPdRIijXL/9wxHPSnNm7SyH
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="304739433"
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="304739433"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 09:58:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="762925713"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 16 Jun 2022 09:58:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8BD1E3B9; Thu, 16 Jun 2022 19:58:31 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v1 07/11] mfd: intel_soc_pmic_bxtwc: Drop redundant ACPI_PTR()
Date:   Thu, 16 Jun 2022 19:58:19 +0300
Message-Id: <20220616165823.4919-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220616165823.4919-1-andriy.shevchenko@linux.intel.com>
References: <20220616165823.4919-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver depends on ACPI (via MFD_INTEL_PMC_BXT), ACPI_PTR() resolution
is always the same. Otherwise a compiler may produce a warning.

That said, the rule of thumb either ugly ifdeffery with ACPI_PTR or
none should be used in a driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_soc_pmic_bxtwc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index 6e4c2ca47d82..b48e620de7a3 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -575,7 +575,7 @@ static struct platform_driver bxtwc_driver = {
 	.driver	= {
 		.name	= "BXTWC PMIC",
 		.pm     = pm_sleep_ptr(&bxtwc_pm_ops),
-		.acpi_match_table = ACPI_PTR(bxtwc_acpi_ids),
+		.acpi_match_table = bxtwc_acpi_ids,
 		.dev_groups = bxtwc_groups,
 	},
 };
-- 
2.35.1

