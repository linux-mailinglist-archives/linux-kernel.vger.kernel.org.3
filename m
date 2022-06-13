Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252E5549C73
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345091AbiFMS7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345728AbiFMS63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:58:29 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34F62A96C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 09:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655136551; x=1686672551;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XkiVhgQtjYa74jxc4fNcCogOvoJpuvPnLCoIHPR00Jo=;
  b=CAnomKoFyhPma+j4HAxDEI6jHA2xsF6Rt7z+7X/y3fpKHzRtXxc2ePG8
   Eeo4Wo++eQKJb52TBB7xT62cPjkU3Ni+utdsb1I76d2TgvLCdCsHgGULp
   SEdOv/tmB57pMcpADUzSf2TZDWYJY0Y5IjZ2JAjCbK9kw8coUQs1uaZO6
   2jQWO6nOf6LLtlXNWN4hV+RvREADinPEtzxTtQWPR1qKsvRMcvuyADBpd
   wPsDyvb//4Y12aS6uydz+j4OfcV8hQDZqIKRV+g0s9fzE9lQBqg6wFE8T
   PDAvM7YaDa+W0J4PwfJos+S6EXzpRJ2h57nk3MJBhGABiTmS87ucKtETb
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="303727929"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="303727929"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 09:08:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="651502987"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 13 Jun 2022 09:08:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4F257346; Mon, 13 Jun 2022 19:08:52 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Ferry Toth <ftoth@exalondelft.nl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] phy: ti: tusb1210: Don't check for write errors when powering on
Date:   Mon, 13 Jun 2022 19:08:48 +0300
Message-Id: <20220613160848.82746-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some platforms, like Intel Merrifield, the writing values during power on
may timeout:

   tusb1210 dwc3.0.auto.ulpi: error -110 writing val 0x41 to reg 0x80
   phy phy-dwc3.0.auto.ulpi.0: phy poweron failed --> -110
   dwc3 dwc3.0.auto: error -ETIMEDOUT: failed to initialize core
   dwc3: probe of dwc3.0.auto failed with error -110

which effectively fails the probe of the USB controller.
Drop the check as it was before the culprit commit (see Fixes tag).

Fixes: 09a3512681b3 ("phy: ti: tusb1210: Improve ulpi_read()/_write() error checking")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/phy/ti/phy-tusb1210.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/ti/phy-tusb1210.c b/drivers/phy/ti/phy-tusb1210.c
index c3ab4b69ea68..669c13d6e402 100644
--- a/drivers/phy/ti/phy-tusb1210.c
+++ b/drivers/phy/ti/phy-tusb1210.c
@@ -105,8 +105,9 @@ static int tusb1210_power_on(struct phy *phy)
 	msleep(TUSB1210_RESET_TIME_MS);
 
 	/* Restore the optional eye diagram optimization value */
-	return tusb1210_ulpi_write(tusb, TUSB1210_VENDOR_SPECIFIC2,
-				   tusb->vendor_specific2);
+	tusb1210_ulpi_write(tusb, TUSB1210_VENDOR_SPECIFIC2, tusb->vendor_specific2);
+
+	return 0;
 }
 
 static int tusb1210_power_off(struct phy *phy)
-- 
2.35.1

