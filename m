Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E5D4C5EED
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 21:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbiB0U6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 15:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbiB0U5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 15:57:32 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43A586E4F2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 12:56:48 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 226C41063;
        Sun, 27 Feb 2022 12:56:48 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB1263F66F;
        Sun, 27 Feb 2022 12:56:46 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        peter.hilber@opensynergy.com, cristian.marussi@arm.com
Subject: [RFC PATCH 16/16] [DEBUG]: firmware: arm_scmi: Add Kconfig to allow SCMI Testing driver coexistence
Date:   Sun, 27 Feb 2022 20:56:08 +0000
Message-Id: <20220227205608.30812-17-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220227205608.30812-1-cristian.marussi@arm.com>
References: <20220227205608.30812-1-cristian.marussi@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

firmware: arm_scmi: Add Kconfig to allow SCMI Testing driver coexistence

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/Kconfig  |  6 ++++++
 drivers/firmware/arm_scmi/driver.c | 15 ++++++++-------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index a3726074c89e..c3fc608d5373 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -160,4 +160,10 @@ config ARM_SCMI_TEST_DRIVER
 	  This driver can also be built as a module.  If so, the module
 	  will be called scmi_test_driver.
 
+config ARM_SCMI_TEST_DRIVER_COEXISTENCE
+	bool "Allow Coexistence of SCMI standard drivers and test driver"
+	depends on ARM_SCMI_TEST_DRIVER
+	help
+	  This enables coexistence for concurrent SCMI drievrs and testing driver.
+
 endmenu
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 8c4706b24368..ff692c458a0b 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1782,14 +1782,15 @@ static int scmi_protocol_device_request(const struct scmi_device_id *id_table)
 	pr_debug("Requesting SCMI device (%s) for protocol %x\n",
 		 id_table->name, id_table->protocol_id);
 
-#if IS_ENABLED(CONFIG_ARM_SCMI_TEST_DRIVER)
-	/* Reject non-testing SCMI drivers */
-	if (strncmp(id_table->name, "__scmi_test", strlen("__scmi_test"))) {
-		pr_warn("SCMI Test driver loaded. Rejecting '%s'/0x%X\n",
-			id_table->name, id_table->protocol_id);
-		return -EINVAL;
+	if (IS_ENABLED(CONFIG_ARM_SCMI_TEST_DRIVER) &&
+	    !IS_ENABLED(CONFIG_ARM_SCMI_TEST_DRIVER_COEXISTENCE)) {
+		/* Reject non-testing SCMI drivers */
+		if (strncmp(id_table->name, "__scmi_test", strlen("__scmi_test"))) {
+			pr_warn("SCMI Test driver loaded. Rejecting driver: '%s'/0x%X\n",
+				id_table->name, id_table->protocol_id);
+			return -EBUSY;
+		}
 	}
-#endif
 
 	/*
 	 * Search for the matching protocol rdev list and then search
-- 
2.17.1

