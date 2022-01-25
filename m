Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611B049B7B0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 16:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357540AbiAYPen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 10:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349272AbiAYPcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 10:32:09 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6543C061762
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 07:30:12 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id h20-20020a17090adb9400b001b518bf99ffso2302244pjv.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 07:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GrAtAIlMK2rk7KAp7C2s7R2F2nNCdug8ASeh5+c9Xxw=;
        b=hmA+4kWIT0VJkfsrIj3CAk+o2e5xm3EHa9OOGgMLC6V8kk3s6txEmtpOvHCwQCFu/z
         f6Z1KLDIBThomje+wVZtC/avAyK1NYKshJzQbEKYVjuh+o+SiJevaxvP9ArK8rWsbreG
         W0NdXjX/AzBkRxSlOjgUb2e5K+WqPzSqA/cXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GrAtAIlMK2rk7KAp7C2s7R2F2nNCdug8ASeh5+c9Xxw=;
        b=DyQfZKg/l6A0rIoqT5KeBrEeZ+X4csrK4TlpG4c9lUnXZ1Br/x1c+4M8GMuqtNxvFQ
         SDm9ezvefYXcLo514hUERaJHZ7o8Tqrr3C7QZBNHHXCO2LkXSgLXy2CBdOyCkesxuJ7N
         su88IUvWLWRHwWoEizxehlYkxw72PZEN1ExT8jS2s+2zlmKUkiJ05SW0KUEEZ3l8IfGz
         FTMGGubef7WsyJNMmnVXZBrzt1ELALvzSXHJxEJWir29vIASQSCgnxIf1FMuVd7nP0r5
         BTImXZhJ058w0BkpICUyubXb+ldhdQhLEwlRqrD9LJp4VDm9s4B6QWauVba88Zgf6uMe
         Zmkg==
X-Gm-Message-State: AOAM5307pYHGjhK2Tv3YGyE7BEIwK+wTewoWquXXSVkz5lc/+11/5/Hn
        +jiynMT/ezPoYxeL/fXqe6NAMg43n7lo4w==
X-Google-Smtp-Source: ABdhPJzd5aF6C+FAPgDlRwmXwFEc5etijNnVCwLbg8thUNE5rIwkeqTw25zE2c3dG5DyN9uNQ8t/ig==
X-Received: by 2002:a17:902:7d81:b0:149:c926:7c2e with SMTP id a1-20020a1709027d8100b00149c9267c2emr19600182plm.27.1643124612092;
        Tue, 25 Jan 2022 07:30:12 -0800 (PST)
Received: from chentsungp920.tpe.corp.google.com ([2401:fa00:1:10:b78b:8e2a:968c:d872])
        by smtp.gmail.com with ESMTPSA id k5sm20989991pfc.85.2022.01.25.07.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 07:30:11 -0800 (PST)
From:   Chen-Tsung Hsieh <chentsung@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Chen-Tsung Hsieh <chentsung@chromium.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH] mtd: spi-nor: core: Check written SR value in spi_nor_write_16bit_sr_and_check()
Date:   Tue, 25 Jan 2022 23:30:00 +0800
Message-Id: <20220125153000.3263064-1-chentsung@chromium.org>
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

