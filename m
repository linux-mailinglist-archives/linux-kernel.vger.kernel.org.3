Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEA7504F1C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 12:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237760AbiDRK6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 06:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbiDRK6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 06:58:34 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2415119C2E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 03:55:56 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d14so1823247qtw.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 03:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=04JNQ4bNSWDf9nai4sAo8uNf8YU45zdAqbc+gwJY/Os=;
        b=L8QgQHgaLGvKMHF5Cn0gPx8KthUCv7F5DASuU0w83wfC4qP1QWP5tnjqNJ/PL0IW+s
         qwxtvzrSE8oMw24QsmvtNkh1flxQNxzT44tOV8LtU/Ch0Do1KPbQ1IHzVVgy279vv/Gc
         BmTWjXqltOCRGhFjwMe4q0P6Q2wuro597uPlXhjBAzvpQTRc1wdvZ312A5zHF3iA7i0a
         W1qnDSqEheJnoc7P+U51c5+h4Wg/7TdDltSOO31YR5DHhbVJXMuYmbwzPg7R0P/kgQ+J
         77zdLt3Cpk5US/tnSdytC2TB4GteNhxdD90NA4lZYHwMJknFv5cNBUA9g5ysHTejwTZB
         V5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=04JNQ4bNSWDf9nai4sAo8uNf8YU45zdAqbc+gwJY/Os=;
        b=kAkz8LCKiwuzuJF3HKLz50+YVof7i81l+Ss5vc90RcSb53qlxmw2q+Z1QHQ/QaNtnm
         VwtzExjSc7YUoiK5WPeWqlWm6EIU9Us+C3gvpM80FYA6Q7vb48NlomoXGOlGcpLUUE+J
         bj+rwso56Bwm3sv+FVVq+q3O/gUYjEeK0y9sGxbDKDU3zwvCkE0wcsb+9MXj/pjtYImY
         3ZaIjI9f3wJ5iD3ChZFT7XRVUWQL2hit/UHitpANXXHkkxY8MhSaqWt3z+WxbdnnPxWz
         7q8HKbKwJcWG4soQASzBpUCx8eOn0FkkAmay5NKUY+yDnp22RU27WWmwvkZUI7icpfCt
         Lg7Q==
X-Gm-Message-State: AOAM533hsBKWfTW39INR7K+WQ5yfawGW8BYMiOvGxhzVMxBRwpSNy5xs
        pT8ZF34y4KRSkx9JKJbaYio=
X-Google-Smtp-Source: ABdhPJyIahOd8LheVs5dSWdbwkvdAFmtzyN6uLbgaP4/mPBCrW3brMLgzIUVShvTAGKnO2Vh6xzAsg==
X-Received: by 2002:ac8:7fcc:0:b0:2f2:5bf:6c with SMTP id b12-20020ac87fcc000000b002f205bf006cmr501496qtk.655.1650279355332;
        Mon, 18 Apr 2022 03:55:55 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id i17-20020a05620a405100b0069c45deb548sm6909392qko.130.2022.04.18.03.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 03:55:55 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     han.xu@nxp.com
Cc:     miquel.raynal@bootlin.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] mtd: nand: gpmi-nand: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Mon, 18 Apr 2022 10:55:49 +0000
Message-Id: <20220418105549.2558765-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Using pm_runtime_resume_and_get is more appropriate
for simplifing code

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index 44b14c9dc9a7..6e7477aef8a7 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -148,11 +148,9 @@ static int gpmi_init(struct gpmi_nand_data *this)
 	struct resources *r = &this->resources;
 	int ret;
 
-	ret = pm_runtime_get_sync(this->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(this->dev);
+	ret = pm_runtime_resume_and_get(this->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = gpmi_reset_block(r->gpmi_regs, false);
 	if (ret)
@@ -544,11 +542,9 @@ static int bch_set_geometry(struct gpmi_nand_data *this)
 	if (ret)
 		return ret;
 
-	ret = pm_runtime_get_sync(this->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(this->dev);
+	ret = pm_runtime_resume_and_get(this->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	/*
 	* Due to erratum #2847 of the MX23, the BCH cannot be soft reset on this
@@ -2286,11 +2282,9 @@ static int gpmi_nfc_exec_op(struct nand_chip *chip,
 	for (i = 0; i < GPMI_MAX_TRANSFERS; i++)
 		this->transfers[i].direction = DMA_NONE;
 
-	ret = pm_runtime_get_sync(this->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(this->dev);
+	ret = pm_runtime_resume_and_get(this->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	/*
 	 * This driver currently supports only one NAND chip. Plus, dies share
-- 
2.25.1


