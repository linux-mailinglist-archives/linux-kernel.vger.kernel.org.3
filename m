Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3047856C54F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 02:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiGIAHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 20:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiGIAHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 20:07:09 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE1766AFA;
        Fri,  8 Jul 2022 17:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657325201; x=1688861201;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2PHVLxm0nwiHtIkBNkq8RAlB72SqG9LFMuILiBDy8xs=;
  b=WWl8VHMkUidl+JIgh/NTlDF3KoD8PpjOvMDBVNoCvqoc0rJcy0p3cYuz
   BnfHTVrqVXelcEDK26LKYHl1k3+GCoSYWtnfI3ynKIEDlEIaA0kc0cnDB
   p8+lj8Y+eIxnBdfa5WVL1jtOZ+g6MJnYrTcb4wqt+kOZi1hhcF7Q3yGgf
   2DqpqjaOKOjWt2wGQCq6EYJ8/O9ilao4My42d3oA5VPJGo4gSbBofD2yc
   aTOBfmiQ4Dw8Lo+h7W87OUGuYkxJlglSDSUg4+ibRts2vq7x5D1c70eer
   yeJJ8yzkn4ICmMBL91XpbddX2ac5KQGZY8d6bnAA8NIhMCEB8b6MVuBsF
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="264802886"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="264802886"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 17:06:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="683821846"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Jul 2022 17:06:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8DA39481; Sat,  9 Jul 2022 03:06:46 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/7] platform/x86: serial-multi-instantiate: Improve autodetection
Date:   Sat,  9 Jul 2022 03:06:31 +0300
Message-Id: <20220709000636.35550-2-andriy.shevchenko@linux.intel.com>
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

Instead of calling specific resource counter, let just probe each
of the type and see what it says. Also add a debug message when
none is found.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/serial-multi-instantiate.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
index 97db23243018..e599058196bb 100644
--- a/drivers/platform/x86/serial-multi-instantiate.c
+++ b/drivers/platform/x86/serial-multi-instantiate.c
@@ -232,6 +232,7 @@ static int smi_probe(struct platform_device *pdev)
 	const struct smi_node *node;
 	struct acpi_device *adev;
 	struct smi *smi;
+	int ret;
 
 	adev = ACPI_COMPANION(dev);
 	if (!adev)
@@ -255,15 +256,20 @@ static int smi_probe(struct platform_device *pdev)
 	case SMI_SPI:
 		return smi_spi_probe(pdev, adev, smi, node->instances);
 	case SMI_AUTO_DETECT:
-		if (i2c_acpi_client_count(adev) > 0)
-			return smi_i2c_probe(pdev, adev, smi, node->instances);
-		else
-			return smi_spi_probe(pdev, adev, smi, node->instances);
+		ret = smi_i2c_probe(pdev, adev, smi, node->instances);
+		if (ret && ret != -ENOENT)
+			return ret;
+		ret = smi_spi_probe(pdev, adev, smi, node->instances);
+		if (ret && ret != -ENOENT)
+			return ret;
+		if (ret)
+			return dev_err_probe(dev, ret, "Error No resources found\n");
+		break;
 	default:
 		return -EINVAL;
 	}
 
-	return 0; /* never reached */
+	return 0;
 }
 
 static int smi_remove(struct platform_device *pdev)
-- 
2.35.1

