Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89D8554A74
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351477AbiFVNIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350562AbiFVNIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:08:07 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF29B64E9;
        Wed, 22 Jun 2022 06:08:04 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25M8oRuP016502;
        Wed, 22 Jun 2022 08:07:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=ntxFv34fd+vFLPQPi1Xmyq/mW6Q27ifhC5yz+XojRyE=;
 b=V1vqjGNaFSkM+gdJj+xs+Z8tnK5DsQR46sXTEh/ke1Fa11WYcY6/tGv94NscN2IGw+I7
 zBMSV9c/+p/zQ+PMSrLuUxtl6mvIW5q6Hwqv6aPmWn0qtW3upwKvt117Q1n8o8zXHzK/
 Kcl75B+j3cTC80guD2jZPjvezp+VdsaHQeye25CcNSOh92VTIgfMNJxhq/kidYjwnfbs
 CyUogcZq8Xz7DZhtn/AD5MhRsNiP20b/UN4h6bGX/4IcC5lv5mK0zumWNTa0BNtEq7n2
 A4jyQLOYtkthki8dl3aon3K4CGhF52CBmcRwaGG+t5RZy3CjfDGLsPUSDHgonTRw5SCH 6Q== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3gsc41d2wb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 22 Jun 2022 08:07:57 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 22 Jun
 2022 14:07:55 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 22 Jun 2022 14:07:55 +0100
Received: from sbinding-cirrus-dsktp.ad.cirrus.com (unknown [198.90.238.151])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 35A7A478;
        Wed, 22 Jun 2022 13:07:53 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
CC:     <linux-acpi@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 1/2] ACPI: utils: Add api to read _SUB from ACPI
Date:   Wed, 22 Jun 2022 14:07:29 +0100
Message-ID: <20220622130730.1573747-2-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220622130730.1573747-1-sbinding@opensource.cirrus.com>
References: <20220622130730.1573747-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: OtYPNvyMW17wUUEj7zk8fODjthptNpou
X-Proofpoint-ORIG-GUID: OtYPNvyMW17wUUEj7zk8fODjthptNpou
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a wrapper function to read the _SUB string from ACPI.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 drivers/acpi/utils.c | 26 ++++++++++++++++++++++++++
 include/linux/acpi.h |  8 ++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 3a9773a09e19..5d1bdb79e372 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -291,6 +291,32 @@ int acpi_get_local_address(acpi_handle handle, u32 *addr)
 }
 EXPORT_SYMBOL(acpi_get_local_address);
 
+int acpi_get_sub(acpi_handle handle, char *sub, size_t size)
+{
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
+	acpi_status status;
+	int ret;
+
+	status = acpi_evaluate_object(handle, METHOD_NAME__SUB, NULL, &buffer);
+	if (!ACPI_SUCCESS(status)) {
+		acpi_handle_debug(handle, "Reading ACPI _SUB failed: %#x\n", status);
+		return -ENOENT;
+	}
+
+	obj = buffer.pointer;
+	if (obj->type == ACPI_TYPE_STRING) {
+		ret = strscpy(sub, obj->string.pointer, size);
+	} else {
+		acpi_handle_warn(handle, "Warning ACPI _SUB did not return a string\n");
+		ret = -EINVAL;
+	}
+	acpi_os_free(buffer.pointer);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(acpi_get_sub);
+
 acpi_status
 acpi_evaluate_reference(acpi_handle handle,
 			acpi_string pathname,
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4f82a5bc6d98..9bf18adf5920 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -21,6 +21,8 @@
 #endif
 #include <acpi/acpi.h>
 
+#define ACPI_MAX_SUB_BUF_SIZE	9
+
 #ifdef	CONFIG_ACPI
 
 #include <linux/list.h>
@@ -762,6 +764,7 @@ static inline u64 acpi_arch_get_root_pointer(void)
 #endif
 
 int acpi_get_local_address(acpi_handle handle, u32 *addr);
+int acpi_get_sub(acpi_handle handle, char *sub, size_t size);
 
 #else	/* !CONFIG_ACPI */
 
@@ -1023,6 +1026,11 @@ static inline int acpi_get_local_address(acpi_handle handle, u32 *addr)
 	return -ENODEV;
 }
 
+static int acpi_get_sub(acpi_handle handle, char *sub, size_t size)
+{
+	return -ENODEV;
+}
+
 static inline int acpi_register_wakeup_handler(int wake_irq,
 	bool (*wakeup)(void *context), void *context)
 {
-- 
2.25.1

