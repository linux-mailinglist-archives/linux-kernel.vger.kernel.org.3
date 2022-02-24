Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239FA4C2B18
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbiBXLj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbiBXLjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:39:05 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF42C1B0C7C;
        Thu, 24 Feb 2022 03:38:35 -0800 (PST)
Received: from localhost.localdomain (ip5f5aee05.dynamic.kabel-deutschland.de [95.90.238.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3F2C561EA193D;
        Thu, 24 Feb 2022 12:38:34 +0100 (CET)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] acpi: exsystem: Decrease sleep warning threshold to 10 ms
Date:   Thu, 24 Feb 2022 12:38:06 +0100
Message-Id: <20220224113807.91771-4-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220224113807.91771-1-pmenzel@molgen.mpg.de>
References: <20220224113807.91771-1-pmenzel@molgen.mpg.de>
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

50 ms is quite long for todays systems and requirements. 10 ms seems
like a more appropriate limit, and everything else needing more should
be rewritten to use polling.

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/acpi/acpica/exsystem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/exsystem.c b/drivers/acpi/acpica/exsystem.c
index bdffb8aac05c..676459ccc8d7 100644
--- a/drivers/acpi/acpica/exsystem.c
+++ b/drivers/acpi/acpica/exsystem.c
@@ -167,9 +167,9 @@ acpi_status acpi_ex_system_do_sleep(u64 how_long_ms)
 
 	acpi_ex_exit_interpreter();
 
-	if (how_long_ms > 50) {
+	if (how_long_ms > 10) {
 		ACPI_WARNING((AE_INFO,
-		    "Time parameter %llu > 50 ms. Please contact firmware vendor for more responsive system.", how_long_ms));
+		    "Time parameter %llu > 10 ms. Please contact firmware vendor for more responsive system.", how_long_ms));
 	}
 
 	/*
-- 
2.35.1

