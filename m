Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC9E51B5D7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 04:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238720AbiEEC1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 22:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236673AbiEEC1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 22:27:03 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3314BB9D;
        Wed,  4 May 2022 19:23:25 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id j14so3128599plx.3;
        Wed, 04 May 2022 19:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lFFrhJmbK0PSipTPxwjwV3fHJdLQ0jjKSAlpMZiepxg=;
        b=lOTfWI6YdJdZP0livjRoOh3ATgDq1yk1r6M31p8O8yGO5dhXdvm10Kovu/1wVLk7kS
         IgZh6DaQregbT9u7/PF8eU270rdYjPiPL4RkSPh3gDWyEmp6SV1d0aIJrq2nJ9gTPqod
         3jtXVmGoJ3Z3RLYlkxhljNXrsUynUKhLARSFsP8NDAsz3Io9PfKn7lBs+USbRoOHL9SS
         ElVxWnX3NiXyhrfUbYy5QxtSOwQQiomprHe7PGi/ha5GGStO4MaAWOPFpyHAKvDxHKq0
         nkESBpdq6vefcF25nR6vRmJ1suN0bJBmumVhUddnz1/V9E1d91I73ou+1MqzNuG9LSZ9
         z4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lFFrhJmbK0PSipTPxwjwV3fHJdLQ0jjKSAlpMZiepxg=;
        b=bd0mxsTiX30Vp5MsuOSKmmXqX3xmWotTbNKb0gRh8+cLSz2jn+/453cJdM73nkwzUs
         1IiGarGYuuTCKyexUmUHrfaPmZR808+bpdX9RAeDn55NzarJ4Fx/pn3ChT9AT28DYYYN
         5qSSJlPwnal7SC5VUDQS7pbqQPc+qac6zC0EWXegN/xdy8W+MXG75us+w4Kuqt60yFcn
         TI05QPtoe6wdiroUk4PtcdhXi2VRmGX3mWXHNjw0MozXNpq3MAXhir4abSWun8ME24OY
         kGwtOwDV68ic7P81NpJCz+zRDhf6M1g6AKNYXwrM/Tb3XAmNs4ChQ0wIdprMzIoUZJrR
         NS3Q==
X-Gm-Message-State: AOAM532uIVv2Xmd8YKI1UjblDtvW5hz5Yg7X5Nw5zMRLPIxHFGS7Uc6P
        tkIHiqrX8Ed34mvcPdIvwhqutm6/Byk=
X-Google-Smtp-Source: ABdhPJwp3xJ/8ojilBsTldfF7NRGzBixfmWfZad6Y090DItVCi8BI5x2bbzvVourA9sdC1ejrosTzw==
X-Received: by 2002:a17:90b:1d82:b0:1dc:ba02:52a0 with SMTP id pf2-20020a17090b1d8200b001dcba0252a0mr1211577pjb.246.1651717405280;
        Wed, 04 May 2022 19:23:25 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id f5-20020a170902ce8500b0015e8d4eb1c5sm212496plg.15.2022.05.04.19.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 19:23:24 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     a.zummo@towertech.it
Cc:     alexandre.belloni@bootlin.com, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] rtc: simplify the return expression of rx8025_set_offset()
Date:   Thu,  5 May 2022 02:23:14 +0000
Message-Id: <20220505022314.59822-1-chi.minghao@zte.com.cn>
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

Simplify the return expression.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/rtc/rtc-rx8025.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-rx8025.c b/drivers/rtc/rtc-rx8025.c
index 5bfdd34a72ff..b32117ccd74b 100644
--- a/drivers/rtc/rtc-rx8025.c
+++ b/drivers/rtc/rtc-rx8025.c
@@ -436,7 +436,6 @@ static int rx8025_set_offset(struct device *dev, long offset)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	u8 digoff;
-	int err;
 
 	offset /= RX8025_ADJ_RESOLUTION;
 	if (offset > RX8025_ADJ_DATA_MAX)
@@ -449,11 +448,7 @@ static int rx8025_set_offset(struct device *dev, long offset)
 		offset += 128;
 	digoff = offset;
 
-	err = rx8025_write_reg(client, RX8025_REG_DIGOFF, digoff);
-	if (err)
-		return err;
-
-	return 0;
+	return rx8025_write_reg(client, RX8025_REG_DIGOFF, digoff);
 }
 
 static const struct rtc_class_ops rx8025_rtc_ops = {
-- 
2.25.1


