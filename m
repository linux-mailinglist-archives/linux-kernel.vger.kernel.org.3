Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB9D4CB9B2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbiCCI7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiCCI73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:59:29 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81B916AA6F;
        Thu,  3 Mar 2022 00:58:43 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id u10so5044244wra.9;
        Thu, 03 Mar 2022 00:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MQJEo4upM9dSdfpug7K8DnThChzSPXUmNu2eyU+dF0c=;
        b=Gha4Rawl9ZluKz5YWzXzEN2XIGAG+bVjt3e5SJt0uA2BR89mC8aU3Iy5NQ0VfXKh9g
         kfesiK9eGEfxcURrhDHf+jBVKvIURS1woL7ItJJqTQpi7zfbvtnuZ+UJArukyBbTTNtP
         aIc0ztOnpbZiug1qIO2nGgYq/TJfq+qxOqt251Jlyr4OwBP6nfRoXfe0UST1t6JmBJWj
         YpJZFNoCPP3IrxoF6BFrZ+calNPV0ruIjn8FRqHh+FyAP2YF/Rx4oq9m7q2syd6CHXEE
         D7z9oxSI2sVBUCUEFZ0kgsYuhBmd2+RQxr4vILUwWJiNP1VRV2dUTEIDR08MTR8nabiL
         cX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MQJEo4upM9dSdfpug7K8DnThChzSPXUmNu2eyU+dF0c=;
        b=UpK8YtPwqNDUcoKTZg7x6rghz1FYeyLZAlR3rG7Lb5LOrm2KRKRS15h+U2cwoB7kQG
         lnmoyBuov7j3ZG5YJkfR2i8dMaU3FQD9zxpB+URSARofofWPEVe+TZJauryQXtU7f7AX
         Q4MrPthruPFe+CaS1UAQeBypfdW/LxSaj+kUroRD2x2MFOZczi+p2V4IRgvffI03Dl6+
         yd8oFjr50Olm81f3zil2i/uu5Zpa4bBh4Zrsi6u7POF/TilMXy7hBD8tO285i9zGVwi+
         tI5xQmtZfnlmEqtkiXrkklXURNfQPXpxLAIHeOqtY0ht22B/x/xUQVjx6qA2H4AfemOE
         9ghQ==
X-Gm-Message-State: AOAM531tnBr0V8nwrAFLB/8RBcuozfZskXl7Yf9/TS1OZsmJQ+Y5M008
        OjvvwM5s3YyvmwbzBJ5BTkiExi40Nsg8/A==
X-Google-Smtp-Source: ABdhPJzb79AfvihErqIaACg4s+qnD0+s9McBGRubFqnZIJTZQBGBFrhdjoEUdNRjlwKSfBwdcpzncQ==
X-Received: by 2002:a05:6000:1e0c:b0:1f0:95f:42e7 with SMTP id bj12-20020a0560001e0c00b001f0095f42e7mr8929437wrb.239.1646297922269;
        Thu, 03 Mar 2022 00:58:42 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id f4-20020a5d4dc4000000b001d8e67e5214sm1418022wru.48.2022.03.03.00.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 00:58:41 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-wireless@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bcma: gpio: remove redundant re-assignment of chip->owner
Date:   Thu,  3 Mar 2022 08:58:41 +0000
Message-Id: <20220303085841.1124766-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There are two identical assignments of chip->owner to the same value,
the second assignment is redundant and can be removed.

Cleans up cppcheck warning:
drivers/bcma/driver_gpio.c:184:15: style: Variable 'chip->owner' is
reassigned a value before the old one has been used. [redundantAssignment]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/bcma/driver_gpio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bcma/driver_gpio.c b/drivers/bcma/driver_gpio.c
index 8a1e4705bc87..1e74ec1c7f23 100644
--- a/drivers/bcma/driver_gpio.c
+++ b/drivers/bcma/driver_gpio.c
@@ -181,7 +181,6 @@ int bcma_gpio_init(struct bcma_drv_cc *cc)
 	chip->set		= bcma_gpio_set_value;
 	chip->direction_input	= bcma_gpio_direction_input;
 	chip->direction_output	= bcma_gpio_direction_output;
-	chip->owner		= THIS_MODULE;
 	chip->parent		= bus->dev;
 #if IS_BUILTIN(CONFIG_OF)
 	chip->of_node		= cc->core->dev.of_node;
-- 
2.34.1

