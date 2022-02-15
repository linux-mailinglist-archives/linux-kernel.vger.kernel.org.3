Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A4D4B72AF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240041AbiBOPa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:30:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240102AbiBOP3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:29:50 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7429BF52B;
        Tue, 15 Feb 2022 07:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644938914; x=1676474914;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9CDhZJWW1q2vhq2fCgbv/Rf44s8ghp54BeJ5kvboSuc=;
  b=Xkf9bTo/aMazx/d2L/BB9rn/04Yefef4Rk8V9wgDLh73Fh9+KjTQCmla
   4AUqUB7GPhn3Ri9NmDePAb9Lbb0l8Q262mFpvVsfQ+FSuO2n22LXQXMct
   yQxwhCvVoVedExdyGwNIVDW0m/sq2YVYltnFTT7ol2ZDjoFVEguoNaMcm
   OmkuNw4C9agmDTjDbYYRPuvm4Q2A5n4uoveitBPi9zgtrcOZPtptDvCGC
   tdnM80n+JeOhJD0w9UcFzeCW0pA8M5F+hs0wyzXYsNMPe6WhOktyi2Lnz
   swD5LeNJgmUPwhuiET0TM+5zLHgKc6PRbwjNHNCcRg27DadzSZCGN9dvR
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="250115603"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="250115603"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 07:27:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="587743696"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 15 Feb 2022 07:27:53 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9754C107; Tue, 15 Feb 2022 17:28:09 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/4] pinctrl: tigerlake: Revert "Add Alder Lake-M ACPI ID"
Date:   Tue, 15 Feb 2022 17:27:57 +0200
Message-Id: <20220215152800.21104-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that last minute change moved ACPI ID of Alder Lake-M
to the INTC1055, which is already in the driver.

This ID on the other hand will be used elsewhere.

This reverts commit 258435a1c8187f559549e515d2f77fa0b57bcd27.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-tigerlake.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/intel/pinctrl-tigerlake.c b/drivers/pinctrl/intel/pinctrl-tigerlake.c
index 0bcd19597e4a..3ddaeffc0415 100644
--- a/drivers/pinctrl/intel/pinctrl-tigerlake.c
+++ b/drivers/pinctrl/intel/pinctrl-tigerlake.c
@@ -749,7 +749,6 @@ static const struct acpi_device_id tgl_pinctrl_acpi_match[] = {
 	{ "INT34C5", (kernel_ulong_t)&tgllp_soc_data },
 	{ "INT34C6", (kernel_ulong_t)&tglh_soc_data },
 	{ "INTC1055", (kernel_ulong_t)&tgllp_soc_data },
-	{ "INTC1057", (kernel_ulong_t)&tgllp_soc_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, tgl_pinctrl_acpi_match);
-- 
2.34.1

