Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD7C4FE85B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 20:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351155AbiDLTBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 15:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358825AbiDLTAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 15:00:25 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A68D4BFD8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 11:58:07 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c6so8353909edn.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 11:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hpa4N5vsb9gM4LzFPyO/7ve7HdAU0SOf4yN5lG8PbWY=;
        b=HgVZUoTC+gx8PCPFFLnAywUZ8CUoq5mmDC3QTucWlg1VezUrWG0GdIhCuBtFLv8tyl
         VEQDO3GSP4ox2p1SUPDaMmoPvV6L9nBPTvZEQI03+2UY4VYL62fC+Fo3VOqOzrnDJiQl
         UOwhXzAQQAtkHZzeGIAtrEfJRLZEY0aQyPa4u134U3tWNgEV1/I2JLuOjwj+y08VmnyN
         mPJpPc4wCZiIMrTOkWXj8wDZ3VEjGdYEj+upacu0akQ0ZXB3lwb1HBN9vVVqNat57DpJ
         jGEbFk9l0FA+tN3qS9x6gAb/s70vTP2j/7nKwGxhMcE/3oKzNLxWpK+Wzc8uEJFhf0k8
         vFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hpa4N5vsb9gM4LzFPyO/7ve7HdAU0SOf4yN5lG8PbWY=;
        b=XdLlbYBS5esXn/elg49KjIssocd4oSYSjIzSw0BkPCW67fGBV+OffeEYiXRUpYDJfZ
         sNc6iQIhkCXd7sswyVREysLxrhZVa5ZSpSKCEqy0GtvP0bBvNgkRiPVAsMC2h2+2pAF5
         4ejhSkR/NNJOqQmjgYib0lHNG9MsTJZhDuIwWpPVxTyxwIazNEk6kq6JERGESXzegWlr
         YgZ8UHHBhojW4XZNr8rWExwH0Hzht6enY/3YZHJjNM+IVsqzDs3yHmTv7qdHDML1zjzQ
         vsu1wdz+QHIxbRTgGWGS5PIKrSae+Q+I8f/8dVzEizclPYBozDE4AUEP65uTLX+QkHfj
         0zcg==
X-Gm-Message-State: AOAM532XanRHijeckPDZaENhdERFCKehN+mpCjgKxBhgEhaYe33FewRk
        RZ76sOEYMuThJhy9ob1mKUg=
X-Google-Smtp-Source: ABdhPJxfSkH/23aJHVUbzKtMu+PEFUbtRkCS3kd4XoG51Dtd6o0rHViRyN1QxNgGj6jVF+kgF4Lm1Q==
X-Received: by 2002:a05:6402:cac:b0:410:a920:4e90 with SMTP id cn12-20020a0564020cac00b00410a9204e90mr39599935edb.60.1649789886129;
        Tue, 12 Apr 2022 11:58:06 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id q22-20020a170906771600b006cf8a37ebf5sm13443482ejm.103.2022.04.12.11.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 11:58:05 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 6/6] staging: r8188eu: clean up long lines in block_write()
Date:   Tue, 12 Apr 2022 20:57:54 +0200
Message-Id: <20220412185754.8695-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412185754.8695-1-straube.linux@gmail.com>
References: <20220412185754.8695-1-straube.linux@gmail.com>
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

Store the address and the data pointer for calls to rtw_writeN() and
rtw_write8() in local variables. This avoids long lines and improves
readability.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_fw.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
index 1e930799a0b3..8620f3c92b52 100644
--- a/drivers/staging/r8188eu/core/rtw_fw.c
+++ b/drivers/staging/r8188eu/core/rtw_fw.c
@@ -75,7 +75,8 @@ static int block_write(struct adapter *padapter, u8 *buffer, u32 size)
 {
 	int ret = _SUCCESS;
 	u32 blocks, block_size, remain;
-	u32 i, offset;
+	u32 i, offset, addr;
+	u8 *data;
 
 	block_size = MAX_REG_BLOCK_SIZE;
 
@@ -83,7 +84,10 @@ static int block_write(struct adapter *padapter, u8 *buffer, u32 size)
 	remain = size % block_size;
 
 	for (i = 0; i < blocks; i++) {
-		ret = rtw_writeN(padapter, (FW_8188E_START_ADDRESS + i * block_size), block_size, (buffer + i * block_size));
+		addr = FW_8188E_START_ADDRESS + i * block_size;
+		data = buffer + i * block_size;
+
+		ret = rtw_writeN(padapter, addr, block_size, data);
 		if (ret == _FAIL)
 			goto exit;
 	}
@@ -96,7 +100,10 @@ static int block_write(struct adapter *padapter, u8 *buffer, u32 size)
 		remain = remain % block_size;
 
 		for (i = 0; i < blocks; i++) {
-			ret = rtw_writeN(padapter, (FW_8188E_START_ADDRESS + offset + i * block_size), block_size, (buffer + offset + i * block_size));
+			addr = FW_8188E_START_ADDRESS + offset + i * block_size;
+			data = buffer + offset + i * block_size;
+
+			ret = rtw_writeN(padapter, addr, block_size, data);
 			if (ret == _FAIL)
 				goto exit;
 		}
@@ -109,7 +116,10 @@ static int block_write(struct adapter *padapter, u8 *buffer, u32 size)
 		blocks = remain;
 
 		for (i = 0; i < blocks; i++) {
-			ret = rtw_write8(padapter, (FW_8188E_START_ADDRESS + offset + i), *(buffer + offset + i));
+			addr = FW_8188E_START_ADDRESS + offset + i;
+			data = buffer + offset + i;
+
+			ret = rtw_write8(padapter, addr, *data);
 			if (ret == _FAIL)
 				goto exit;
 		}
-- 
2.35.1

