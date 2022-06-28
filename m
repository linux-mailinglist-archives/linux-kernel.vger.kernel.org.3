Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A02155D0EC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345521AbiF1L2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345519AbiF1L2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:28:30 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FA310565;
        Tue, 28 Jun 2022 04:28:18 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u12so25058020eja.8;
        Tue, 28 Jun 2022 04:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wqgc6jUPRcLl2k1wjcuUn82u931h34UR3GkTMv8F/kk=;
        b=T95YBreZPHTSDKz9UPS5xFBpfWAVG8hi6XrIHo7W9zdKnDZlexZmx9ONBDVkhTa9ws
         L8QQ8OLu6Ver0m5jCahivuQrSXNQ90kJzWweUUYjzjcbYB9cdf3HBGtPB4qpxD3TFS6a
         UDP5sxqwtjdY+69yYYwkcvZECJW/fRPUHt7XoUuVoS7Kt2QUgZxyLXiRsHr2h2tuR9cP
         hrjCQcJFDxdwN/LWyB7bLCY8pY5e3Ks3rpeKYwce+THJ8BJNc+4CoZRa6rXnk/MXIFVD
         L22apaVIqSmKSwWsGsMGrVHhIE0KALKi/afSsBzevtO0jD2IEyA7tTqu3Em2Pw+YYZWa
         Iq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wqgc6jUPRcLl2k1wjcuUn82u931h34UR3GkTMv8F/kk=;
        b=1alQj/rPdj5Gxv0Lz8lttGxflYG0dNeqiqvcd26UQVFHrWtAMIzjVSVd3Tmt+F0fBu
         3Z7xUu+CQj5+vVg28jmMHURhXKCmzeo4B1BZxy9PGvsxJshBZz0uMDDaWD9rQ4/+6m4T
         FueHg8x5GDTIh2bfynl35KSrduFIK4lpVL/1op1tDdjAvSyQLQzsgU2hXCOBTWyAhNgV
         ju5aQpXHPI06WBlXDQID9miWiZGrjOp3UEhkFB9fJLx2wKjPXGNuqRQZrj4AAK9Y0sq/
         O6VB51JK2c7fFj2axt1ZN0fdQi25ZMn4ltZmGVdrfg12t6sa/73P8pBLdo+04f4+gUhw
         OD7A==
X-Gm-Message-State: AJIora9LG0z9zaAJNuun0TpdePtPhWBfRNE3lS+8zijLBA31p5wo/rI5
        Bw/7LRhwPMUExQwcPuNEiIs=
X-Google-Smtp-Source: AGRyM1uI8tzxdpgnoE1YZHUjY+YKpwDRC1XmWEmYBE3VDOktzn/VoqQrNVoFIeXHaES1lKfRHOvuCQ==
X-Received: by 2002:a17:906:58d5:b0:722:fc0b:305a with SMTP id e21-20020a17090658d500b00722fc0b305amr16784769ejs.251.1656415697498;
        Tue, 28 Jun 2022 04:28:17 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-114-061-215.95.114.pool.telefonica.de. [95.114.61.215])
        by smtp.googlemail.com with ESMTPSA id h6-20020aa7cdc6000000b00435720b7a1csm9456318edw.20.2022.06.28.04.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 04:28:17 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tlanger@maxlinear.com,
        rtanwar@maxlinear.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFC v1 7/8] mtd: rawnand: intel: Remove unused clk_rate member from struct ebu_nand
Date:   Tue, 28 Jun 2022 13:27:30 +0200
Message-Id: <20220628112731.2041976-8-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628112731.2041976-1-martin.blumenstingl@googlemail.com>
References: <20220628112731.2041976-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clk_rate member from struct ebu_nand is only written but never read.
Remove this unused and unneeded member.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mtd/nand/raw/intel-nand-controller.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/intel-nand-controller.c b/drivers/mtd/nand/raw/intel-nand-controller.c
index de4f85368988..e486db11ecc3 100644
--- a/drivers/mtd/nand/raw/intel-nand-controller.c
+++ b/drivers/mtd/nand/raw/intel-nand-controller.c
@@ -118,7 +118,6 @@ struct ebu_nand_controller {
 	struct dma_chan *dma_tx;
 	struct dma_chan *dma_rx;
 	struct completion dma_access_complete;
-	unsigned long clk_rate;
 	struct clk *clk;
 	u32 nd_para0;
 	u8 cs_num;
@@ -636,7 +635,6 @@ static int ebu_nand_probe(struct platform_device *pdev)
 		dev_err(dev, "failed to enable clock: %d\n", ret);
 		return ret;
 	}
-	ebu_host->clk_rate = clk_get_rate(ebu_host->clk);
 
 	ebu_host->dma_tx = dma_request_chan(dev, "tx");
 	if (IS_ERR(ebu_host->dma_tx)) {
-- 
2.36.1

