Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E21C56C54D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 02:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiGIAHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 20:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiGIAHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 20:07:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518D0691D0;
        Fri,  8 Jul 2022 17:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657325204; x=1688861204;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GXx+zHGTkfRPNz2ElI/nqimWtZFLg+8XXSQyrC7jW0c=;
  b=bFqzBZnkiEbRukQstPA2vTBWC8rJHPq2mBQg6i0yEkMXW2pDobruAxVz
   ATR9bq1dH5bGk839lgbBbqgIJniWr5D9ZJgoOjXFd3X8znN0aDXAcX7mk
   3Dl58RD/jiP702JovHgjtwC2YUk3v/HzyNFtrPMDNUepcbtkP5aCmWiSS
   vGUIR4eLXNmv4p1vtpoTG33k6acSV3jAyxAIpGxvdy2fG6lbuLPZIQ+6K
   rsjhbOuFleNbeErkSQCfaqwFOB/tVLGJcUF+qsaaK5n2KKUyfFlA8bpTg
   Og2Uy6Qr474edYscs8T1cn7fdtg9V9HBssFXlasErlNybzeQaD8fzl3NQ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="370700483"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="370700483"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 17:06:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="697045271"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 08 Jul 2022 17:06:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B41585CC; Sat,  9 Jul 2022 03:06:46 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 6/7] platform/x86: serial-multi-instantiate: Get rid of redundant 'else'
Date:   Sat,  9 Jul 2022 03:06:35 +0300
Message-Id: <20220709000636.35550-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220709000636.35550-1-andriy.shevchenko@linux.intel.com>
References: <20220709000636.35550-1-andriy.shevchenko@linux.intel.com>
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

In the snippets like the following

	if (...)
		return / goto / break / continue ...;
	else
		...

the 'else' is redundant. Get rid of it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/serial-multi-instantiate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
index 38bc644a50c3..3f8fc80ec9cc 100644
--- a/drivers/platform/x86/serial-multi-instantiate.c
+++ b/drivers/platform/x86/serial-multi-instantiate.c
@@ -98,7 +98,7 @@ static int smi_spi_probe(struct platform_device *pdev, struct smi *smi,
 	ret = acpi_spi_count_resources(adev);
 	if (ret < 0)
 		return ret;
-	else if (!ret)
+	if (!ret)
 		return -ENOENT;
 
 	count = ret;
@@ -180,7 +180,7 @@ static int smi_i2c_probe(struct platform_device *pdev, struct smi *smi,
 	ret = i2c_acpi_client_count(adev);
 	if (ret < 0)
 		return ret;
-	else if (!ret)
+	if (!ret)
 		return -ENOENT;
 
 	count = ret;
-- 
2.35.1

