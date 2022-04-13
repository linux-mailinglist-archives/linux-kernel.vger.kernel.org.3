Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285CD4FF38E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbiDMJey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiDMJeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:34:50 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C07E53B69
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:32:30 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id v12so1472432plv.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PJvC/v5Z4vt3b0hI2Sufdr2aXHGEjFQtW1ly8K8dLZI=;
        b=Ch4ipHIxNsXyYDqVwxC/e70s5eHUWoUyDfr5iOo7gNCQFoSr2QfbSqM4JKJs8rr8/X
         t1+Uvy+HoCOPGxe1CeWGhSaOLLvS7fq7o5Jm6QVVa5c7maPphqqEMl9866Enex3JN6g0
         n4UCN1wsKIHOlyF8SrX2xvatGTS2gPTqomgFJJG488mAqQUzhKuGWdL16djI7z5m9zwB
         XM4cVUoIOggsrhVDzfA+swEVw+DvflnCRhIpakPYKePgOEpQx4pDtubss01MTTqMsyA8
         ZgYyXZsftnHShjxBpsPqC4HwJY1niDbsIFbVW8zNHNA/OTd4/3fuUGpeCRf4VWFmSOpq
         eaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PJvC/v5Z4vt3b0hI2Sufdr2aXHGEjFQtW1ly8K8dLZI=;
        b=7OgF9hqo+2yIWTnoyumC+Y+6wOTq66U8mpreFtgHCs0MmRA+yqqEoCIE5f44YAl3+R
         pHktzqNAtGX9/AVTdOvLG9OajibZKhrWR6IU51B83pIijuaG1q3sxpLgXIxL/ElWckPZ
         2f4QnaREOWsk3tt7PnP/zTs9XLq40gJK6OFCtJTjyj4b+n87jxYolyBtktr7Gnxr656w
         C49IT9Dnidwecew2uGxJ22z55QGcv/zlxF4aeFW845lWC6EYXkPZ2xRcRXRG5I7kKcDZ
         wMO54H1iiEfaZ6uGoEcoNVxP1jQRmjhTDIbZ6CYuZ7U29W6ImQyjPw6+/Uc+b2zQES+m
         b/Tw==
X-Gm-Message-State: AOAM530MbmXYKUDWro2kFL66vhTf9D2pBMfD+IUuwARNJt3raVhWDP/e
        Qp67Tzx3lXs4zjBrQk5oD72jHSJy5uQ=
X-Google-Smtp-Source: ABdhPJwIJOGTTokRQt4hDbORGoKVbzbIKfMTdf8SBVleRESVFNyF143qsiRt7l98H2SZ866pSOaDtw==
X-Received: by 2002:a17:90a:de87:b0:1cb:b207:a729 with SMTP id n7-20020a17090ade8700b001cbb207a729mr9715897pjv.144.1649842349882;
        Wed, 13 Apr 2022 02:32:29 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h18-20020a63c012000000b0039cc3c323f7sm5411339pgg.33.2022.04.13.02.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 02:32:29 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     codrin.ciubotariu@microchip.com
Cc:     arnd@arndb.de, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] misc: atmel-ssc: fix error check return value of platform_get_irq()
Date:   Wed, 13 Apr 2022 09:32:22 +0000
Message-Id: <20220413093222.2538066-1-lv.ruyi@zte.com.cn>
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

From: Lv Ruyi <lv.ruyi@zte.com.cn>

platform_get_irq() return negative value on failure, so null check of
ssc->irq is incorrect. Fix it by comparing whether it is less than zero.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/misc/atmel-ssc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
index d6cd5537126c..5e7b290d9515 100644
--- a/drivers/misc/atmel-ssc.c
+++ b/drivers/misc/atmel-ssc.c
@@ -232,7 +232,7 @@ static int ssc_probe(struct platform_device *pdev)
 	clk_disable_unprepare(ssc->clk);
 
 	ssc->irq = platform_get_irq(pdev, 0);
-	if (!ssc->irq) {
+	if (ssc->irq < 0) {
 		dev_dbg(&pdev->dev, "could not get irq\n");
 		return -ENXIO;
 	}
-- 
2.25.1

