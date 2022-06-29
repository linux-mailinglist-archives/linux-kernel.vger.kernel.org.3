Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3801C560BCC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 23:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiF2Vfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 17:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiF2Vf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 17:35:28 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD5E326E7;
        Wed, 29 Jun 2022 14:35:27 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id g26so35147002ejb.5;
        Wed, 29 Jun 2022 14:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GtoWH3Twv71XknYtu8BYL5GG9PgQIu+29g9mDNFEswk=;
        b=qy/Ujs6iCq2aqMwtZJGfA0A64dA2U63n8Zciy8Dr4CBpy6bSY9OI81Las6pQTv7OBb
         XwAyqF6Iwnz8SW9OGhyYKWgqCyd+BPf+MwFzJ6BJJypZrYk6MYQdsyrlm5CB6j8TYHiX
         UoBi1VUVWEav0k+edCZBgbH0Lrqs6+olUQwQvFCi7ZpUJlYsWWgHxymxCL5sryFiJI0J
         S0Rp7s0iaihV5mwwqc0LMKhkdUprlqRvSLAATH/ZhSOa/PwYpjLw1XQHvLp3E9I5QRQF
         RsOEb/ot2m5dtEOivXQe6xc0PNv/HWo5G+470UtmXmtUTYd72DtaGg9li5My96R69/Ox
         pHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GtoWH3Twv71XknYtu8BYL5GG9PgQIu+29g9mDNFEswk=;
        b=XTtGd1HU2VkHDTbaa4C5DTTuF4MRUuIuVt2qyypJJnjX7DzszYFyCN+47hTEF0i5JC
         +MVoHmWwoi9wAe8j6+Y3AsuMIs0F7Ipn0qiVnTF2truA0Wh2EJPA6u//l25kOvgjL0XZ
         cT7UgZgoaZqKS974N4WmjygH0t8I/x2im/e1FtvOGdoeeS/wh1GIVJSo9I6X0ECIhblG
         sU/ZENBNMH/oFRAk/ZfqmYAfhBnPgR5PO/vVWLkqnSDUljyED67GCbjSmFHoSy2hbKTA
         2sm1PvWVnmSMSPWAV4NsK2aBllCiiYKhSIdx3CaGAZHzkNfH7k4Kyx3OWiFg54xC0Ksj
         pm0g==
X-Gm-Message-State: AJIora+ozlFGehs1DmDuatJo/9TagLLoNesJ2DK8kzqmnbkKDKPERJkB
        YVUwK7hEZf6a6m+chxsZa2oT9Oc0DeE=
X-Google-Smtp-Source: AGRyM1uZslft79Zvkhn1i0YctuGmD0m1jD8CSzhgeqC2ueG5/IEVdWc3eTKV4AviJNRwhelZcA7xKA==
X-Received: by 2002:a17:906:ce:b0:715:705e:52fb with SMTP id 14-20020a17090600ce00b00715705e52fbmr5297494eji.303.1656538525688;
        Wed, 29 Jun 2022 14:35:25 -0700 (PDT)
Received: from localhost.localdomain (dynamic-077-007-003-132.77.7.pool.telefonica.de. [77.7.3.132])
        by smtp.googlemail.com with ESMTPSA id s7-20020a1709066c8700b0070c4abe4706sm8237889ejr.158.2022.06.29.14.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 14:35:25 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tlanger@maxlinear.com,
        rtanwar@maxlinear.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 7/8] mtd: rawnand: intel: Remove unused clk_rate member from struct ebu_nand
Date:   Wed, 29 Jun 2022 23:35:07 +0200
Message-Id: <20220629213508.1989600-8-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220629213508.1989600-1-martin.blumenstingl@googlemail.com>
References: <20220629213508.1989600-1-martin.blumenstingl@googlemail.com>
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
2.37.0

