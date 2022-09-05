Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713E85AD84A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 19:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbiIERT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 13:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiIERTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 13:19:53 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070ED1EC69;
        Mon,  5 Sep 2022 10:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662398392; x=1693934392;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=H1x3D21Fgj3oIVsGcghx8kOsLr/B4ZFW56g8adE84zI=;
  b=QCcjUe21IL33v8n9+6fJ2hC2sQ2X02M0WsJlA7jwWmuP7esoVZoMiYhB
   sJWdwtdnQA9wv2Ej8VYAJj4wz479a4pNl5Chd8Miv4qbTaeTKqpi5+27G
   Og5BeMkW8MqSoSpbvGsAG8y/KC5TM4D/2n9RFcenlXDBNLFq3KJqox2P5
   /JWWhYBydIByslzvnTujshXA9Ty9IHHO4sS74QY4A4Omt4wBKSGdImPYw
   m07KYctpFmbC+J64xOBrb6Jpk1ew60gIFqxQiiwUuyFRklPiHfiDyttV0
   dEW1C3VUdoZAecWK60JBIVJb4vkWsdK5K2JzZZU15nZ6nVyjd+Ml68waA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="358143073"
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="358143073"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 10:19:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="739647611"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 05 Sep 2022 10:19:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 76464101; Mon,  5 Sep 2022 20:20:05 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v1 1/1] Input: icn8505 - Utilize acpi_get_subsystem_id()
Date:   Mon,  5 Sep 2022 20:20:01 +0300
Message-Id: <20220905172001.69244-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace open coded variant of recently introduced acpi_get_subsystem_id().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/input/touchscreen/chipone_icn8505.c | 29 ++++++---------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/input/touchscreen/chipone_icn8505.c b/drivers/input/touchscreen/chipone_icn8505.c
index f9ca5502ac8c..bb5e63b87c5d 100644
--- a/drivers/input/touchscreen/chipone_icn8505.c
+++ b/drivers/input/touchscreen/chipone_icn8505.c
@@ -364,32 +364,19 @@ static irqreturn_t icn8505_irq(int irq, void *dev_id)
 
 static int icn8505_probe_acpi(struct icn8505_data *icn8505, struct device *dev)
 {
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	const char *subsys = "unknown";
-	struct acpi_device *adev;
-	union acpi_object *obj;
-	acpi_status status;
-
-	adev = ACPI_COMPANION(dev);
-	if (!adev)
-		return -ENODEV;
+	const char *subsys;
 
-	status = acpi_evaluate_object(adev->handle, "_SUB", NULL, &buffer);
-	if (ACPI_SUCCESS(status)) {
-		obj = buffer.pointer;
-		if (obj->type == ACPI_TYPE_STRING)
-			subsys = obj->string.pointer;
-		else
-			dev_warn(dev, "Warning ACPI _SUB did not return a string\n");
-	} else {
-		dev_warn(dev, "Warning ACPI _SUB failed: %#x\n", status);
-		buffer.pointer = NULL;
-	}
+	subsys = acpi_get_subsystem_id(ACPI_HANDLE(dev));
+	if (IS_ERR(subsys) && PTR_ERR(subsys) != -ENODATA)
+		return PTR_ERR(subsys);
+
+	if (IS_ERR(subsys) && PTR_ERR(subsys) == -ENODATA)
+		subsys = kstrdup_const("unknown", GFP_KERNEL);
 
 	snprintf(icn8505->firmware_name, sizeof(icn8505->firmware_name),
 		 "chipone/icn8505-%s.fw", subsys);
 
-	kfree(buffer.pointer);
+	kfree_const(subsys);
 	return 0;
 }
 
-- 
2.35.1

