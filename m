Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E154A77E4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 19:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346639AbiBBSYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 13:24:42 -0500
Received: from mga07.intel.com ([134.134.136.100]:56229 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346617AbiBBSYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 13:24:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643826281; x=1675362281;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DPfe9S7gsr3XHu4Wjcofqz2TIxLgJSBh0vUtgBSr5RM=;
  b=bLG2Dgb+gWanVKYq65gi+agM4SLh6ssO0DJMNTEP7G3+VlNOOZHT63Hs
   lxpu2SlK+N4qUo+2CK03RHmPUbStyqdr+GnQUQfhv6HYzaZ3BlJvLt+tH
   m77E6VARgr1+BEeeXXlI4ea55SZ+b1k3L3AAHYryvrcHB4TuVSXvwJh/N
   Lgvmljzf6xhgRuwBVh6Ue423o6ZRbAcurkJyHb0vF0DLTttjdqS6r6X9R
   ZDaBfgVoPnQBVNTo9Y1+DpK8anmpDxSXbew5NsaWQ231qGmP7RnA+FDwV
   ZuBv6wbZpoQCF3x0g4bS4tvQu6htfGhxBliYMiLUzpa1AhsJAL0NT9coF
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="311297740"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="311297740"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 10:24:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="566088755"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 02 Feb 2022 10:24:39 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9779C3B7; Wed,  2 Feb 2022 20:24:53 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] mmc: dw_mmc: Use device_property_string_array_count()
Date:   Wed,  2 Feb 2022 20:24:50 +0200
Message-Id: <20220202182450.54925-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use device_property_string_array_count() to get number of strings
in a string array property.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/dw_mmc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 99b201921954..3420a7ad6098 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3057,8 +3057,7 @@ static void dw_mci_init_dma(struct dw_mci *host)
 		dev_info(host->dev, "Using internal DMA controller.\n");
 	} else {
 		/* TRANS_MODE_EDMAC: check dma bindings again */
-		if ((device_property_read_string_array(dev, "dma-names",
-						       NULL, 0) < 0) ||
+		if ((device_property_string_array_count(dev, "dma-names") < 0) ||
 		    !device_property_present(dev, "dmas")) {
 			goto no_dma;
 		}
-- 
2.34.1

