Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD599484CBB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 04:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237209AbiAEDNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 22:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237196AbiAEDNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 22:13:21 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950C6C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 19:13:21 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id a1so36182327qtx.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 19:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=howett-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x2aLfuFCUBuE8UDjNrDJd69eskK7afYXIDfF2xwCx/k=;
        b=scyKv0LYLY1sy4CUnszbnaBg87nSFiZ9zph8mHIm6HGa/VwVkfN3x7M2pOYss+F8NT
         WkJFVcFpL8OpQPye7vbkrmo4Oqqcuk0AoJ+6mv7bsaXXNkAQY0VqkKKYn+4ToKbAoPHX
         VBHqeF2jciTYqpdihj09Nasj+EQUHVJrgaOwT20Rk2FSOPNwclGzTjmfITMimxH0keG8
         hSmuRKUd8F2zzEKxb7pjZz6ofrGklMW90iTnH9W3w2QqzqzSSjok0gqajiOIHBnn4nVR
         j3lCgrG9fo8azWrb417n25+G4V9jljZBOK0u7S2H3QU140yYZugE7eh9o0PeFRKZ3bOr
         BPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x2aLfuFCUBuE8UDjNrDJd69eskK7afYXIDfF2xwCx/k=;
        b=GdgnB/WUtxDIw25hUx0CRBMjGWcuQ7scqBv0+kDYvY55jMRDBBbXwvsBFl/m2SJXt0
         NPrbQOYqWmByT3M/tYhgLW9MdpEIxGfDOguwB1PSGYsr9uWneetDnA9h0c8UJMiULuF/
         vFuStq2DxmH8lIes6TQLCyH+y+zAZxcC2RLgcIfkilraYXeadD8F9DVG0oX+i+X9497L
         DN21O1gOmx2FMy67ltBZ07HLJK7qnrnvKcej04djYR+zBPkxpxNx85qqlT4mU4Ouc/x6
         k7qzxNyiQhqnnojaDC1HFl5nFgllSvAC4tk+WHE0F+gLqQeT6zIsmusrCMKGhGMU6MoH
         0UIw==
X-Gm-Message-State: AOAM533z/pGhStIpaQ0J70WjZTt/9NzrKTHXq3Z/Zp99qYTVAn92LZ2X
        EGIiNG3nbNnSkbKM9CyeR0W8X36MisUcCg==
X-Google-Smtp-Source: ABdhPJy5nRzomOipRnlclsRvwahR3C0E28eEcO24eqwBzOMQiQpw+pkqgmT27Gk/YiVjar56MXwZFQ==
X-Received: by 2002:a05:622a:548:: with SMTP id m8mr30413350qtx.126.1641352400478;
        Tue, 04 Jan 2022 19:13:20 -0800 (PST)
Received: from rigel.delfino.n.howett.net ([2600:1700:df50:a7cf::725])
        by smtp.googlemail.com with ESMTPSA id s6sm32629632qki.23.2022.01.04.19.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 19:13:20 -0800 (PST)
From:   "Dustin L. Howett" <dustin@howett.net>
To:     linux-kernel@vger.kernel.org
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>
Subject: [PATCH 2/2] platform/chrome: reserve only the I/O ports required for the MEC EC
Date:   Tue,  4 Jan 2022 21:12:42 -0600
Message-Id: <20220105031242.287751-3-dustin@howett.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220105031242.287751-1-dustin@howett.net>
References: <20220105031242.287751-1-dustin@howett.net>
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

