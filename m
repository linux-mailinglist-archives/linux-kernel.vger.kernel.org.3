Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADF65A6033
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiH3KFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiH3KEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:04:06 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BEDE9275
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:02:05 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id q7so14782370lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Ujio0bEzfH+9rUBEwCRFEVlch5eJO1HsdYpiFACcp/8=;
        b=diCNxWgz1aqkX1plRZyuGSrPZV8oH/eErVfFkGJ4tKIPC7jAe5AuV8wRf9MXBSQpNu
         YgM4he1Ub9dGcN1aPiQs47Hn5+7uhhhuIMAswkvjDCW/qpOgcWWF+hQiYm+30Z3mmcb2
         27iwtHGryPTRjCB/t+nVKHwGruHcvUM2NF74w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Ujio0bEzfH+9rUBEwCRFEVlch5eJO1HsdYpiFACcp/8=;
        b=vtm1DoCKDoggEVhRKa3dMvInzfndoi2jJd5qk7K9pyy9JJPKOpNMe/ou3fr73sZSYo
         aDv9ws40l87+22PnO/3hGDOUtIgAlQ6Tl/4JOaUBlW6StMQvHD1xO6ZCeMGk0g2BpjUG
         no/qnUDM5M93npP/oItk0MQkFY5ayKu0ZGv5G2iL1+IjQrvDqoXKuVAAmj4UDV5ujpEV
         SmDImrqmt2hvJJilZo5TJn8IAzaO+yk8xAmEeL1+lUd/7U2dqIeyX49+Rq26wEGMgBnH
         +EpXhJCnM4jViSahORjy0m8wLolovOCpF4n4GlsxQa7g8mk6nrS5lCoPdQxNjS7HtyBK
         VBnQ==
X-Gm-Message-State: ACgBeo2mME39lmagAb8jAcEBAjSZWtc1yE2bUHdLj5KxS/WDIkANza4I
        6Vs1XYZEJ3hcSrsIqmhbSsKyiQ==
X-Google-Smtp-Source: AA6agR6J8CeUqogF4N/i7VP9cHvGkgyGGFTuou5FxVIIZ5hnBqnwA6mGAV83ZWSs234Jl37OcKgoTA==
X-Received: by 2002:a05:6512:1524:b0:48a:aff5:59d0 with SMTP id bq36-20020a056512152400b0048aaff559d0mr7005849lfb.122.1661853723938;
        Tue, 30 Aug 2022 03:02:03 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id m6-20020a056512114600b0048af6242892sm1573435lfg.14.2022.08.30.03.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 03:02:03 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] rtc: isl12022: use dev_set_drvdata() instead of i2c_set_clientdata()
Date:   Tue, 30 Aug 2022 12:01:49 +0200
Message-Id: <20220830100152.698506-4-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220830100152.698506-1-linux@rasmusvillemoes.dk>
References: <20220830100152.698506-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As another preparation for removing direct references to the
i2c_client in the helper functions, stash a pointer to the private
data via dev_set_drvdata() instead of i2c_set_clientdata().

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/rtc/rtc-isl12022.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
index 5e6bb9153c89..234201ea2f7d 100644
--- a/drivers/rtc/rtc-isl12022.c
+++ b/drivers/rtc/rtc-isl12022.c
@@ -153,7 +153,7 @@ static int isl12022_rtc_read_time(struct device *dev, struct rtc_time *tm)
 static int isl12022_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct isl12022 *isl12022 = i2c_get_clientdata(client);
+	struct isl12022 *isl12022 = dev_get_drvdata(dev);
 	size_t i;
 	int ret;
 	uint8_t buf[ISL12022_REG_DW + 1];
@@ -242,8 +242,7 @@ static int isl12022_probe(struct i2c_client *client)
 				GFP_KERNEL);
 	if (!isl12022)
 		return -ENOMEM;
-
-	i2c_set_clientdata(client, isl12022);
+	dev_set_drvdata(&client->dev, isl12022);
 
 	isl12022->rtc = devm_rtc_allocate_device(&client->dev);
 	if (IS_ERR(isl12022->rtc))
-- 
2.37.2

