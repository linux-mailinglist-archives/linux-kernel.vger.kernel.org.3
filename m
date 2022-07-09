Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C15456C4D2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 02:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiGIAHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 20:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiGIAHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 20:07:10 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC09C691CA;
        Fri,  8 Jul 2022 17:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657325201; x=1688861201;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DnxCMeas++YLy+iZ8/T9EXjN08NjQVaxnLSelIgxV1Q=;
  b=Um67GYsucFDXy10/c+q9x+HjFi4uW39Mza7SK+SKY4Rc55TkZYQbfX6G
   wAnLtUdGftD0Jyj/iRnlY2H42huGxyshsWBHXWZOEdswsQt55LvhMW6XG
   wjTeGh6rvPR4vyXcOuFACp6YI9E4oewhnzIKkMd24l5vDobs1ber1v0qN
   QlU8GQJeMJFyVB8s7heqy/P9IGHPVVa4iSkcEt33q46EK18BZgFHkkDz9
   Fe6yoTwHIE73qDMjswrYM51TmMsglajdrBGbBpGccc6QcfOtmUPfJbw2Q
   87Jn6FkhLo4bRH7coTYYjgbZrbPNCSDQFGsjk4F0SAqK2BUWjqZ7wrUUl
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="309977707"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="309977707"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 17:06:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="770940121"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 08 Jul 2022 17:06:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A58F85AD; Sat,  9 Jul 2022 03:06:46 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 5/7] platform/x86: serial-multi-instantiate: Use while (i--) pattern to clean up
Date:   Sat,  9 Jul 2022 03:06:34 +0300
Message-Id: <20220709000636.35550-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220709000636.35550-1-andriy.shevchenko@linux.intel.com>
References: <20220709000636.35550-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use more natural while (i--) patter to clean up allocated resources.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/serial-multi-instantiate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
index 520236b11b2c..38bc644a50c3 100644
--- a/drivers/platform/x86/serial-multi-instantiate.c
+++ b/drivers/platform/x86/serial-multi-instantiate.c
@@ -70,11 +70,11 @@ static int smi_get_irq(struct platform_device *pdev, struct acpi_device *adev,
 
 static void smi_devs_unregister(struct smi *smi)
 {
-	while (smi->i2c_num > 0)
-		i2c_unregister_device(smi->i2c_devs[--smi->i2c_num]);
+	while (smi->i2c_num--)
+		i2c_unregister_device(smi->i2c_devs[smi->i2c_num]);
 
-	while (smi->spi_num > 0)
-		spi_unregister_device(smi->spi_devs[--smi->spi_num]);
+	while (smi->spi_num--)
+		spi_unregister_device(smi->spi_devs[smi->spi_num]);
 }
 
 /**
-- 
2.35.1

