Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028E54E5F0C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243967AbiCXHCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348262AbiCXHCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:02:05 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAE26D972
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:00:15 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id e5so3807103pls.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nathanrossi.com; s=google;
        h=date:message-id:from:to:cc:subject:content-transfer-encoding
         :mime-version;
        bh=9KqvrxLo1G07hfDRYkFXfXDwuhue1HJtF4AZIGRJRfs=;
        b=kLesff5qCI0HzQizbChuJhKB9KB6Ky0V6lmu/+gXYSvvOjWNH6fW+tCao9aVwQVGPp
         WNWNy43eY7wjfprkeSVyP2P+AZv1XbGCFbl/BhGhbdeCp9mb0p90vKpRqHX2aZKO235U
         glPY1lbb/tB1DA5W3pTZa9t/PA+6mB2BYBhYn5GZq96Vwt6KBZEwHz496pYJmfFSo6mR
         iZG1KlatiLX1HDV2FL6I7eYbZ5FBKic32DV/GPgTaHli0w0i7o7FOaSFVUmiNdOic4Rs
         PM8bUMh4FVxHstu1z9ZIgLQJkfGQoJsXzN5o3ov0nE9vjhIOxprCKkKezEtfkH0eN3Hj
         vMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:from:to:cc:subject
         :content-transfer-encoding:mime-version;
        bh=9KqvrxLo1G07hfDRYkFXfXDwuhue1HJtF4AZIGRJRfs=;
        b=FwcUIkh8rkYdM9ThunZiLWg3XVu/86TIV1LGafkaZVdE0VsCJspgc4MEaZjJUHLqSJ
         uFUQ0sX9pnQDwgaQOzZEJVgG73g2uRC56s9Smuvg9mIhNzfcXXWRY3zdq6nFwA+Gsf9y
         7sQgt76NAft/MBs4QVTZAwTBs59ApG8STxVIG3+aDCVT6eGKtpD1s7lhobNRMcAuiuC9
         PqBAAOSuzsqH8ImDMO79QKwSx3CqaasIFlR2+lYN6PPykUH8wuDraAlZReZOMcQ/k7xf
         yIGOgxVFZa17bhbnCJN50Y/RKheiP5sxTC7trUWOO1pTuj4hnI5bp3jhjMwuwxRgp7aq
         MmyA==
X-Gm-Message-State: AOAM531Y//YkdEkid47t6h/qbsByiJk6BfyOSLCOBnBAJWtELSDDc6Ok
        15cGCB8Lhp7qCYgrbbqg8T5W5g==
X-Google-Smtp-Source: ABdhPJxvpPy6O6jHCvjqweYTUKvXaA/YkxiVZaAc9Z2fv7eYKK7HxH2YvrO8WjRr34htasGBvtgllQ==
X-Received: by 2002:a17:90a:289:b0:1c6:584c:acc6 with SMTP id w9-20020a17090a028900b001c6584cacc6mr4397492pja.124.1648105215194;
        Thu, 24 Mar 2022 00:00:15 -0700 (PDT)
Received: from [127.0.1.1] (117-20-68-98.751444.bne.nbn.aussiebb.net. [117.20.68.98])
        by smtp.gmail.com with UTF8SMTPSA id q2-20020a056a00084200b004f761a7287dsm2136914pfk.131.2022.03.24.00.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 00:00:14 -0700 (PDT)
Date:   Thu, 24 Mar 2022 07:00:04 +0000
Message-Id: <20220324070004.225738-1-nathan@nathanrossi.com>
From:   Nathan Rossi <nathan@nathanrossi.com>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Nathan Rossi <nathan@nathanrossi.com>,
        Nathan Rossi <nathan.rossi@digi.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH] mtd: spi-nor: core: Fix 16bit write sr_and_check status check
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Rossi <nathan.rossi@digi.com>

The spi_nor_write_16bit_sr_and_check function description describes that
the function compares the value of the status and config registers after
the write. However the function does not implement the status register
compare only the config register check.

This causes the function to differ in behaviour to the equivalent
spi_nor_write_sr1_and_check for non-16bit writes to the status register.
This is important as other functions rely on the return code of
spi_nor_write_sr_and_check. For example spi_nor_sr_unlock returns the
result directly, which is returned to userspace such that failing to
unlock the spi-nor device was resulting in a return code of 0 instead of
the expected non-zero indicating the failure.

Signed-off-by: Nathan Rossi <nathan.rossi@digi.com>
---
 drivers/mtd/spi-nor/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 04ea180118..d75d4f8a45 100644
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
+		dev_dbg(nor->dev, "SR: read back test failed\n");
+		return -EIO;
+	}
+
 	if (nor->flags & SNOR_F_NO_READ_CR)
 		return 0;
 
---
2.35.1
