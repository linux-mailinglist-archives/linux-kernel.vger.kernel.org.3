Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBE64C2B19
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbiBXLjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbiBXLjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:39:03 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659391A6143;
        Thu, 24 Feb 2022 03:38:32 -0800 (PST)
Received: from localhost.localdomain (ip5f5aee05.dynamic.kabel-deutschland.de [95.90.238.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 10DF461EA1939;
        Thu, 24 Feb 2022 12:38:29 +0100 (CET)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] acpi: exsystem: Add units to time variable names
Date:   Thu, 24 Feb 2022 12:38:03 +0100
Message-Id: <20220224113807.91771-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`how_long` uses different units in both functions, so make it more
clear, what unit they expect.

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/acpi/acpica/exsystem.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpica/exsystem.c b/drivers/acpi/acpica/exsystem.c
index 1281c07112de..6bc5b46e6927 100644
--- a/drivers/acpi/acpica/exsystem.c
+++ b/drivers/acpi/acpica/exsystem.c
@@ -107,7 +107,7 @@ acpi_status acpi_ex_system_wait_mutex(acpi_mutex mutex, u16 timeout)
  *
  * FUNCTION:    acpi_ex_system_do_stall
  *
- * PARAMETERS:  how_long        - The amount of time to stall,
+ * PARAMETERS:  how_long_us     - The amount of time to stall,
  *                                in microseconds
  *
  * RETURN:      Status
@@ -120,13 +120,13 @@ acpi_status acpi_ex_system_wait_mutex(acpi_mutex mutex, u16 timeout)
  *
  ******************************************************************************/
 
-acpi_status acpi_ex_system_do_stall(u32 how_long)
+acpi_status acpi_ex_system_do_stall(u32 how_long_us)
 {
 	acpi_status status = AE_OK;
 
 	ACPI_FUNCTION_ENTRY();
 
-	if (how_long > 255) {	/* 255 microseconds */
+	if (how_long_us > 255) {	/* 255 microseconds */
 		/*
 		 * Longer than 255 usec, this is an error
 		 *
@@ -134,10 +134,10 @@ acpi_status acpi_ex_system_do_stall(u32 how_long)
 		 * order to support existing BIOSs)
 		 */
 		ACPI_ERROR((AE_INFO,
-			    "Time parameter is too large (%u)", how_long));
+			    "Time parameter is too large (%u)", how_long_us));
 		status = AE_AML_OPERAND_VALUE;
 	} else {
-		acpi_os_stall(how_long);
+		acpi_os_stall(how_long_us);
 	}
 
 	return (status);
@@ -147,7 +147,7 @@ acpi_status acpi_ex_system_do_stall(u32 how_long)
  *
  * FUNCTION:    acpi_ex_system_do_sleep
  *
- * PARAMETERS:  how_long        - The amount of time to sleep,
+ * PARAMETERS:  how_long_ms     - The amount of time to sleep,
  *                                in milliseconds
  *
  * RETURN:      None
@@ -156,7 +156,7 @@ acpi_status acpi_ex_system_do_stall(u32 how_long)
  *
  ******************************************************************************/
 
-acpi_status acpi_ex_system_do_sleep(u64 how_long)
+acpi_status acpi_ex_system_do_sleep(u64 how_long_ms)
 {
 	ACPI_FUNCTION_ENTRY();
 
@@ -168,11 +168,11 @@ acpi_status acpi_ex_system_do_sleep(u64 how_long)
 	 * For compatibility with other ACPI implementations and to prevent
 	 * accidental deep sleeps, limit the sleep time to something reasonable.
 	 */
-	if (how_long > ACPI_MAX_SLEEP) {
-		how_long = ACPI_MAX_SLEEP;
+	if (how_long_ms > ACPI_MAX_SLEEP) {
+		how_long_ms = ACPI_MAX_SLEEP;
 	}
 
-	acpi_os_sleep(how_long);
+	acpi_os_sleep(how_long_ms);
 
 	/* And now we must get the interpreter again */
 
-- 
2.35.1

