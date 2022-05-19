Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2931D52D01C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 12:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236537AbiESKGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 06:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236473AbiESKGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 06:06:46 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2A03A5D5;
        Thu, 19 May 2022 03:06:45 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id p189so2592476wmp.3;
        Thu, 19 May 2022 03:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XBWLqbdmzfQgEw0/TRzerfoDbzPzGOJbF95S1SOzfNM=;
        b=f+GBf9Qh4cVJUQMRY/rpCcSXUz0c7J4JYRsnY9Uvzh+68vgvCx30cbPMnboSRuVJN/
         ldNXY1l2f9wCgjnYHQHZv1+higU7BzOrV3RFeEC/RD1H8hp5sWyY2Y+j4CZQkUKDa+sV
         Ei8TjxSCua8YeEjgbFV1ZRP73rfgdglhTvy+zp8uIVUfNYqDmlB3p/Wb/7yjq0SUvE7F
         Szx+IMCTneg/ulioC4VzawxWMAdKtmukF9ByJaXMRO5knSUQRxZK5eQjevxamYtOruLq
         +nDMbLlKNRMWA4qPB/EYEPDQGYxHws4mHEcFKfsTy1tqTytkPINuiLr7WNPNsqpm8ykw
         SzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XBWLqbdmzfQgEw0/TRzerfoDbzPzGOJbF95S1SOzfNM=;
        b=s6KgC/CqMEAQNMzf6tLackwyBgTW8RO3FeRbjTdji/aQk+4BIyvgcBRv3WBmwDMm46
         0Geu+Fzy+n6vmxu0AT9H8RyoK7QIFC5yZbOO5kUSHpUBVTXYVgJ3fEatZ0XMfKBoo+YQ
         n1Z8pjoFkTrNa3kQ8f7r9QpbkkTj5/ag1yFAZ7e4bCJ5WwsK7pfHw5w/H9CWD4jf56sx
         OUE9D53VCc1Ao/EwTWv1L5zwuNak6AjtN1Qj1BgogydAbIGe4RRI8Mz5e/sOHRXdE8iH
         1hcgjEJ4OmF5MzLRnKViCRZbqIyCMtteJoVrrOZwf0ZY02xH/f0mM3+49fXX2WIXiU3V
         5JNA==
X-Gm-Message-State: AOAM531GausgTXY4+yda4cRyP089SCvG788mGdI5ySBoZDtER+5l963y
        SVg/vgoinK3ZoPvkGpGlOwQ=
X-Google-Smtp-Source: ABdhPJwxCE6AVFhSoylPIebvZAf66K1HbsHHnHzTPOFaqkhljsKfIhuv9psUcQFsta/ZLBayjn41/Q==
X-Received: by 2002:a05:600c:4e91:b0:394:8d30:d6dd with SMTP id f17-20020a05600c4e9100b003948d30d6ddmr3033496wmq.21.1652954803528;
        Thu, 19 May 2022 03:06:43 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id q21-20020adfb195000000b0020c5253d8basm4986182wra.6.2022.05.19.03.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 03:06:42 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        linux-rtc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] rtc: rzn1: Fix uninitialized variable val
Date:   Thu, 19 May 2022 11:06:41 +0100
Message-Id: <20220519100641.595608-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Variable val is not being initialized and is later being read with
a potentially garbage value. Fix this by initializing val to zero.

Detected by clang scan build:
warning: variable 'val' is uninitialized when used here [-Wuninitialized]

Fixes: deeb4b5393e1 ("rtc: rzn1: Add new RTC driver")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/rtc/rtc-rzn1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 980ade8c9601..0b4bf6e43464 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -272,7 +272,7 @@ static int rzn1_rtc_set_offset(struct device *dev, long offset)
 	struct rzn1_rtc *rtc = dev_get_drvdata(dev);
 	unsigned int steps;
 	int stepsh, stepsl;
-	u32 val;
+	u32 val = 0;
 	int ret;
 
 	/*
-- 
2.35.1

