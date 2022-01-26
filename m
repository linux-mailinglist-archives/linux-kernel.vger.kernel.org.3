Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F6549D152
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 19:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244015AbiAZSAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 13:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiAZSA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:00:26 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F11C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:00:25 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id q189so274147qkf.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=howett-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tLA5GTCgKfgQQC1OG/H7L2DP7bInBONzdJzamPGkAX8=;
        b=T2XF/LDoiy8VFaDEHNmhLV39/5Kb+tmEiaZWQeYmkoo3qF/QehjFcty15rc0GzFdLi
         0Mlm9nAd3x4mBm994ymaN2ZqDBX054SrGsmj4jd+NdKm2kGz6UZiU13C5dGmdz+DtLyu
         IU1/xlrmSqM9qUjyN9hTd69XhATeg5WLWefMlwaFWVnSkPOSuPRfg2aPUy/rEK4Z+fPK
         U6NRdgZRkEh+Nxk0khV+ZO0QAqy6/mKQGrHzPVhOv1HpwdnqU//PgYpQZEFOsVr9J+jx
         XcoWfjP5/rjJDw6KP2B8bVhRCTfBOlOp6JuFs2rDp3vkjdJT/t3nwz/Vvzl2yPQkb22N
         bAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tLA5GTCgKfgQQC1OG/H7L2DP7bInBONzdJzamPGkAX8=;
        b=hXh5hFtetEaQD6CF+ghrDBuE4M7tiH4bIk0O4UJROBkZU2C+KHB4cO2GJjfn2y+Atn
         ssbW11pWyjhkuqMe08m4KSDCrWLi+meUseXr8Rt2cp7gO7b0kREKsGxYvrEtS7yyF6oD
         UUk+ML119qaIKUxE2IHOLpS7x0An5nCHcZBuCeQPIcoNF+P5BpwQr8RdGjX/kqGPV4V0
         nl3vT2qatGZWep/7KvgkkB2k8dXLTfOhHIeCprWzDnncbT0QlMMXAtz8bEpq1qG4vSmh
         82j1v9oqpnVnpmOKAjhRx+KljExgtAE28SrMql8oetMBLP2czabKz+destms+gasKc7K
         3PFg==
X-Gm-Message-State: AOAM530jWfRw5pDdR7A6FEeI2Y8b2E+yfTYVEkddcrG/ESnSHTskkmaN
        vwmuxdIQi1uSiFLVI9OFtmEiIdLKQOqedUg/
X-Google-Smtp-Source: ABdhPJyIX8j6WIGxw7KvGQm++/Vh7IAtJyU9ErRJEiAh+vCrrb5NvHqpYqUgJz125qNic4dQhJLU+A==
X-Received: by 2002:a37:6947:: with SMTP id e68mr19035700qkc.26.1643220024314;
        Wed, 26 Jan 2022 10:00:24 -0800 (PST)
Received: from rigel.delfino.n.howett.net ([2600:1700:df50:a7cf::725])
        by smtp.googlemail.com with ESMTPSA id 2sm5702342qtf.9.2022.01.26.10.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 10:00:23 -0800 (PST)
From:   "Dustin L. Howett" <dustin@howett.net>
To:     linux-kernel@vger.kernel.org
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Michael Niksa <michael.niksa@live.com>,
        "Dustin L. Howett" <dustin@howett.net>
Subject: [PATCH v2 2/2] platform/chrome: cros_ec_lpcs: reserve the MEC LPC I/O ports first
Date:   Wed, 26 Jan 2022 12:00:20 -0600
Message-Id: <20220126180020.15873-3-dustin@howett.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220126180020.15873-1-dustin@howett.net>
References: <20220126180020.15873-1-dustin@howett.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some ChromeOS EC devices (such as the Framework Laptop) only map I/O
ports 0x800-0x807. Making the larger reservation required by the non-MEC
LPC (the 0xFF ports for the memory map, and the 0xFF ports for the
parameter region) is non-viable on these devices.

Since we probe the MEC EC first, we can get away with a smaller
reservation that covers the MEC EC ports. If we fall back to classic
LPC, we can grow the reservation to cover the memory map and the
parameter region.

This patch also fixes an issue where we would interact with I/O ports
0x800-0x807 without first making a reservation.

Signed-off-by: Dustin L. Howett <dustin@howett.net>
---
 drivers/platform/chrome/cros_ec_lpc.c         | 39 ++++++++++++-------
 .../linux/platform_data/cros_ec_commands.h    |  4 ++
 2 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 458eb59db2ff..06fdfe365710 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -341,9 +341,14 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 	u8 buf[2];
 	int irq, ret;
 
-	if (!devm_request_region(dev, EC_LPC_ADDR_MEMMAP, EC_MEMMAP_SIZE,
-				 dev_name(dev))) {
-		dev_err(dev, "couldn't reserve memmap region\n");
+	/*
+	 * The Framework Laptop (and possibly other non-ChromeOS devices)
+	 * only exposes the eight I/O ports that are required for the Microchip EC.
+	 * Requesting a larger reservation will fail.
+	 */
+	if (!devm_request_region(dev, EC_HOST_CMD_REGION0,
+				 EC_HOST_CMD_MEC_REGION_SIZE, dev_name(dev))) {
+		dev_err(dev, "couldn't reserve MEC region\n");
 		return -EBUSY;
 	}
 
@@ -357,6 +362,12 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 	cros_ec_lpc_ops.write = cros_ec_lpc_mec_write_bytes;
 	cros_ec_lpc_ops.read(EC_LPC_ADDR_MEMMAP + EC_MEMMAP_ID, 2, buf);
 	if (buf[0] != 'E' || buf[1] != 'C') {
+		if (!devm_request_region(dev, EC_LPC_ADDR_MEMMAP, EC_MEMMAP_SIZE,
+					 dev_name(dev))) {
+			dev_err(dev, "couldn't reserve memmap region\n");
+			return -EBUSY;
+		}
+
 		/* Re-assign read/write operations for the non MEC variant */
 		cros_ec_lpc_ops.read = cros_ec_lpc_read_bytes;
 		cros_ec_lpc_ops.write = cros_ec_lpc_write_bytes;
@@ -366,17 +377,19 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 			dev_err(dev, "EC ID not detected\n");
 			return -ENODEV;
 		}
-	}
 
-	if (!devm_request_region(dev, EC_HOST_CMD_REGION0,
-				 EC_HOST_CMD_REGION_SIZE, dev_name(dev))) {
-		dev_err(dev, "couldn't reserve region0\n");
-		return -EBUSY;
-	}
-	if (!devm_request_region(dev, EC_HOST_CMD_REGION1,
-				 EC_HOST_CMD_REGION_SIZE, dev_name(dev))) {
-		dev_err(dev, "couldn't reserve region1\n");
-		return -EBUSY;
+		/* Reserve the remaining I/O ports required by the non-MEC protocol. */
+		if (!devm_request_region(dev, EC_HOST_CMD_REGION0 + EC_HOST_CMD_MEC_REGION_SIZE,
+					 EC_HOST_CMD_REGION_SIZE - EC_HOST_CMD_MEC_REGION_SIZE,
+					 dev_name(dev))) {
+			dev_err(dev, "couldn't reserve remainder of region0\n");
+			return -EBUSY;
+		}
+		if (!devm_request_region(dev, EC_HOST_CMD_REGION1,
+					 EC_HOST_CMD_REGION_SIZE, dev_name(dev))) {
+			dev_err(dev, "couldn't reserve region1\n");
+			return -EBUSY;
+		}
 	}
 
 	ec_dev = devm_kzalloc(dev, sizeof(*ec_dev), GFP_KERNEL);
diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index 271bd87bff0a..a85b1176e6c0 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -55,6 +55,10 @@
 #define EC_HOST_CMD_REGION0    0x800
 #define EC_HOST_CMD_REGION1    0x880
 #define EC_HOST_CMD_REGION_SIZE 0x80
+/*
+ * Other machines report only the region spanned by the Microchip MEC EC.
+ */
+#define EC_HOST_CMD_MEC_REGION_SIZE 0x08
 
 /* EC command register bit functions */
 #define EC_LPC_CMDR_DATA	BIT(0)  /* Data ready for host to read */
-- 
2.34.1

