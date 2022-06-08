Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539445430C7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 14:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239682AbiFHMtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 08:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239617AbiFHMtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:49:43 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F25B1ABA47;
        Wed,  8 Jun 2022 05:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1654692580; x=1686228580;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jLyjVkpDRkNVymK/Liuwued2h9G1245EKg9LgrWfsBg=;
  b=o/KUEgV7Ky/1AOeNf/SOoDSG+Z20XA9VjFuKV9qrskXV+Yso2oJ+rIUy
   2jM5zD1Qk35ssWFjmDcndi91fm+Sxa96meT3CEsc0iuz7JpolqDcpnsBL
   2jufFLZDML2BYuAEZpZoKNsXrb+ViGVleJTB7/3JrIA63XYnU34lpGROR
   WDDmtjxfXcTr3dDfLFD45DXxxZd1xVSs2xA/3GLNIfN4tqT2qpkEY07yW
   fdFW074F23BaGtgQyFR1GiqKNe5ivyxX4fWerSSip4lbLVeG//5FElYP+
   eMPgU47WvEq3b7gClFyhqxC3cucbwnA06AGtFfPexseppiqdP2ff5WkoG
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,286,1647298800"; 
   d="scan'208";a="24330538"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 08 Jun 2022 14:49:31 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 08 Jun 2022 14:49:31 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 08 Jun 2022 14:49:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1654692571; x=1686228571;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jLyjVkpDRkNVymK/Liuwued2h9G1245EKg9LgrWfsBg=;
  b=Jexq7rxFMowENfJmMae2KO+3IUzGaf2b+5DXOV6u4rKB5wI/fxlijT/O
   pfJZdEvDamJ0ZC0Y3L+E/t9LOf7kbqHjSpRsG/9w4pjPw1nXGCXN+a74I
   CYvjXMuPlXmn/FMDKLmHPGu4mYP8wtgWbGKgVp9V/avDR/oMCmZq/7Erf
   FplARYPAzhRSnKSZslg7HPj4mflPh3383epf0TNxBczhObGIRmW/DTnjt
   aFSuSsdr7eHjM9HHzzc4U8b97IzU9rbGtn/AUttjP583B7XIBGfEpO0Pd
   Lrs2E3skxxss6uVyrnuWP6PB6Q8V+m2PW3OWXMPyWar749XAJqjGu/qCZ
   g==;
X-IronPort-AV: E=Sophos;i="5.91,286,1647298800"; 
   d="scan'208";a="24330537"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 08 Jun 2022 14:49:31 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.136])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id A556D280073;
        Wed,  8 Jun 2022 14:49:30 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Lyude Paul <lyude@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 2/9] Input: synaptics-rmi4 - introduce rmi_f34v7_check_command_status() helper
Date:   Wed,  8 Jun 2022 14:48:01 +0200
Message-Id: <20220608124808.51402-3-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220608124808.51402-1-matthias.schiffer@ew.tq-group.com>
References: <20220608124808.51402-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a function that waits for the last command to complete and checks
the status, and use it where appropriate. This prepares for the subsequent
fix of the completion condition in rmi_f34_attention(), which would
previously lead to a timeout instead of a more detailed error message
whenever a command was unsuccessful with v7/v8 bootloaders.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/input/rmi4/rmi_f34v7.c | 36 +++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f34v7.c b/drivers/input/rmi4/rmi_f34v7.c
index 8d7ec9d89b18..9049acb3a994 100644
--- a/drivers/input/rmi4/rmi_f34v7.c
+++ b/drivers/input/rmi4/rmi_f34v7.c
@@ -72,6 +72,24 @@ static int rmi_f34v7_wait_for_idle(struct f34_data *f34, int timeout_ms)
 	return 0;
 }
 
+static int rmi_f34v7_check_command_status(struct f34_data *f34, int timeout_ms)
+{
+	int ret;
+
+	ret = rmi_f34v7_wait_for_idle(f34, timeout_ms);
+	if (ret < 0)
+		return ret;
+
+	ret = rmi_f34v7_read_flash_status(f34);
+	if (ret < 0)
+		return ret;
+
+	if (f34->v7.flash_status != 0x00)
+		return -EIO;
+
+	return 0;
+}
+
 static int rmi_f34v7_write_command_single_transaction(struct f34_data *f34,
 						      u8 cmd)
 {
@@ -318,6 +336,10 @@ static int rmi_f34v7_read_partition_table(struct f34_data *f34)
 		return ret;
 	}
 
+	/*
+	 * rmi_f34v7_check_command_status() can't be used here, as this
+	 * function is called before IRQs are available
+	 */
 	timeout = msecs_to_jiffies(F34_WRITE_WAIT_MS);
 	while (time_before(jiffies, timeout)) {
 		usleep_range(5000, 6000);
@@ -674,7 +696,7 @@ static int rmi_f34v7_erase_config(struct f34_data *f34)
 		break;
 	}
 
-	ret = rmi_f34v7_wait_for_idle(f34, F34_ERASE_WAIT_MS);
+	ret = rmi_f34v7_check_command_status(f34, F34_ERASE_WAIT_MS);
 	if (ret < 0)
 		return ret;
 
@@ -693,7 +715,7 @@ static int rmi_f34v7_erase_guest_code(struct f34_data *f34)
 	if (ret < 0)
 		return ret;
 
-	ret = rmi_f34v7_wait_for_idle(f34, F34_ERASE_WAIT_MS);
+	ret = rmi_f34v7_check_command_status(f34, F34_ERASE_WAIT_MS);
 	if (ret < 0)
 		return ret;
 
@@ -712,7 +734,7 @@ static int rmi_f34v7_erase_all(struct f34_data *f34)
 	if (ret < 0)
 		return ret;
 
-	ret = rmi_f34v7_wait_for_idle(f34, F34_ERASE_WAIT_MS);
+	ret = rmi_f34v7_check_command_status(f34, F34_ERASE_WAIT_MS);
 	if (ret < 0)
 		return ret;
 
@@ -787,7 +809,7 @@ static int rmi_f34v7_read_blocks(struct f34_data *f34,
 		if (ret < 0)
 			return ret;
 
-		ret = rmi_f34v7_wait_for_idle(f34, F34_ENABLE_WAIT_MS);
+		ret = rmi_f34v7_check_command_status(f34, F34_ENABLE_WAIT_MS);
 		if (ret < 0)
 			return ret;
 
@@ -871,7 +893,7 @@ static int rmi_f34v7_write_f34v7_blocks(struct f34_data *f34,
 			return ret;
 		}
 
-		ret = rmi_f34v7_wait_for_idle(f34, F34_ENABLE_WAIT_MS);
+		ret = rmi_f34v7_check_command_status(f34, F34_ENABLE_WAIT_MS);
 		if (ret < 0)
 			return ret;
 
@@ -944,7 +966,7 @@ static int rmi_f34v7_write_flash_config(struct f34_data *f34)
 	rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev,
 		"%s: Erase flash config command written\n", __func__);
 
-	ret = rmi_f34v7_wait_for_idle(f34, F34_WRITE_WAIT_MS);
+	ret = rmi_f34v7_check_command_status(f34, F34_WRITE_WAIT_MS);
 	if (ret < 0)
 		return ret;
 
@@ -1297,7 +1319,7 @@ static int rmi_f34v7_enter_flash_prog(struct f34_data *f34)
 	if (ret < 0)
 		return ret;
 
-	ret = rmi_f34v7_wait_for_idle(f34, F34_ENABLE_WAIT_MS);
+	ret = rmi_f34v7_check_command_status(f34, F34_ENABLE_WAIT_MS);
 	if (ret < 0)
 		return ret;
 
-- 
2.25.1

