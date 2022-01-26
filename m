Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1815249C45C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 08:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237858AbiAZHds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 02:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiAZHdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 02:33:46 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04835C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 23:33:46 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id h20-20020a17090adb9400b001b518bf99ffso3934851pjv.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 23:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yoxv9TkwSWCw0FOtU6AluVOp0+jEM6CR8CmoyaRpUNM=;
        b=ZbEEe75gALbVnYqP5DJDIi4cJdA++eoSi+o3xHVPSH/HHHh+Gwm3shw1W7KQB1OoP+
         wCHUMQCTbdQDtxUBa3lYxaWV5sD96lgdpXNk4wggL7ntREEZu80K8MA7PqU4J0twLr2c
         UJtslw4cEo+4K/J1hfIINGJyIRy2yCHWgjER8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yoxv9TkwSWCw0FOtU6AluVOp0+jEM6CR8CmoyaRpUNM=;
        b=MI9HgKOODDVrC24toKHdpCL4tyQZYSQQB5X3anY24rx+erXn4+Z8FOlSA9EhuO60g1
         EU4wULd3Szr02Z8rh9k8cWA/sxKWiC8hfOKE9iw5UBkYB3n9S/vxWqW95yHvvm+Ou4Hu
         q8NOy/fcxl3Ywu/i+0bQ7uDrVzDQPITfYAGXQEGZGL3YFGNfG9/rEKoz28f5yCoyQl/n
         1aW853LWFndv9gJHq5o8bg7BMRgWC7uQii3N+fGT/A7bMpZSXMMcSGcs/cS/OCS5VALG
         hxNF7wTzS9mKzRPCV4QBmc0aoWM1XuC/SPZaz/Y43UOfS/4DE1dD/UAEb7GdHGCavWhp
         gfZg==
X-Gm-Message-State: AOAM533seEf90npT7jXq5mBrYduuKV5kNI1VLS0B8DPSI8bxWhoIG8Z2
        G46d5qNwfFq0VmLWfBGJPrOTIg==
X-Google-Smtp-Source: ABdhPJyDNLx2iPQQ5w5mvvbnDtjcrusu0DL1t2Cw+Bvkcd6IGCVe2Z7+w5seVe/xZzFq3vk4CzEZ5w==
X-Received: by 2002:a17:902:c201:b0:14b:2c5f:b278 with SMTP id 1-20020a170902c20100b0014b2c5fb278mr18151198pll.13.1643182425468;
        Tue, 25 Jan 2022 23:33:45 -0800 (PST)
Received: from chentsungp920.tpe.corp.google.com ([2401:fa00:1:10:189e:b22e:a147:b5e1])
        by smtp.gmail.com with ESMTPSA id b14sm1183763pfm.17.2022.01.25.23.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 23:33:44 -0800 (PST)
From:   Chen-Tsung Hsieh <chentsung@chromium.org>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Chen-Tsung Hsieh <chentsung@chromium.org>
Subject: [RESEND PATCH] mtd: spi-nor: core: Check written SR value in spi_nor_write_16bit_sr_and_check()
Date:   Wed, 26 Jan 2022 15:32:26 +0800
Message-Id: <20220126073227.3401275-1-chentsung@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read back Status Register 1 to ensure that the written byte match the
received value and return -EIO if read back test failed.

Without this patch, spi_nor_write_16bit_sr_and_check() only check the
second half of the 16bit. It causes errors like spi_nor_sr_unlock()
return success incorrectly when spi_nor_write_16bit_sr_and_check()
doesn't write SR successfully.

Fixes: 39d1e3340c73 ("mtd: spi-nor: Fix clearing of QE bit on lock()/unlock()")
Signed-off-by: Chen-Tsung Hsieh <chentsung@chromium.org>
---

 drivers/mtd/spi-nor/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 04ea180118e3..426bfa9a65f4 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1007,6 +1007,15 @@ static int spi_nor_write_16bit_sr_and_check(struct spi_nor *nor, u8 sr1)
 	if (ret)
 		return ret;
 
+	ret = spi_nor_read_sr(nor, sr_cr);
+	if (ret)
+		return ret;
+
+	if (sr1 != sr_cr[0]) {
+		dev_dbg(nor->dev, "SR: Read back test failed\n");
+		return -EIO;
+	}
+
 	if (nor->flags & SNOR_F_NO_READ_CR)
 		return 0;
 
-- 
2.35.0.rc0.227.g00780c9af4-goog
Resend patch to move maintainers from 'Cc' to 'To' list.
