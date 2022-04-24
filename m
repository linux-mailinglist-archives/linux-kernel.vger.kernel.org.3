Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E4150D2F6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 17:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbiDXPu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 11:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiDXPuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 11:50:24 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64082369E3;
        Sun, 24 Apr 2022 08:47:23 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j15so4374946wrb.2;
        Sun, 24 Apr 2022 08:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HL7fiyqBRJgE+CGCRvNmcBkaeCPL+1i1yCArETsMyBM=;
        b=n2yWnonI7du9MFsjYTSAWxBiEk3Zx4vMDTNeK4HGkocQMwrAHedYIpioUmELh5BuMf
         tw+hs3iMD8c2kPcRipWzi9NEy25L7t6RVmlW8YuLJyIMMIHSkH/sd9Fw+uZPqeJ9F7iS
         8tRKAXD7zsFUplY5aKdHoePaghWshlXzK/j4Cxjz8GAcz1RW7d1BEsy/Z/qmC7MaXGfi
         lF+7Z96VQzo8YOqGaSA26zAmR04pOO0Vf30YRWGGFmhPvVUZ+ddlT+PqfFFcCGqhSTAN
         dsvDMmePDzEWLKv6Dsq3SzcrbUh6woAPxlIhsjYI3PGHNVPDsvPLeK5sOqx2zn2D5k8Q
         sXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HL7fiyqBRJgE+CGCRvNmcBkaeCPL+1i1yCArETsMyBM=;
        b=EEplXDSsqZLiNdkv/XM+pYpqd+i6Gzp6TaKaXLa+iP5CTrVaYeEwrPU1bOAfqQRyUx
         DF2VK/XGZeCOYxYgcOT/F/w8OKRz/pUqhD1zXsC8EOA6i7dWHQ/dIjiqSO1eOh2349jv
         a19ytkqq0thA61icnr87sURm6ucqEFplXIP0hF/MtJbL0lo88Fn/0Zr0yK38j/Mw1Z77
         7TI62MpPkN71QY3Z4Alp5LtOUhqTUlYh3PkEKQp7wxk0JPH8Fe0UpP/7mMhvfw8Z/3fM
         E6OVDYpfqFxybWp2EPUxaQSWVUrwI5r+f1SUAfAePjfbm1aZhIgT+OpWxIn9fn6VT2lb
         tirg==
X-Gm-Message-State: AOAM533m4Oah7k2G+wd3fKxj1J32h3JdKTIUVMeduw64ksX5EQjxWvAg
        q+ftVKzWkI5EUbhEo2AZ3Es=
X-Google-Smtp-Source: ABdhPJztWvLsOXWw956Mfgn5IeL2UgX9y+VtogVSBEpQQHlKROzfOtMt4S3ZnFmm8Ws3U3WoOKUyhw==
X-Received: by 2002:adf:db86:0:b0:205:bccf:8cbf with SMTP id u6-20020adfdb86000000b00205bccf8cbfmr10914407wri.346.1650815241868;
        Sun, 24 Apr 2022 08:47:21 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id q16-20020a1ce910000000b0038eabd31749sm7937628wmc.32.2022.04.24.08.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 08:47:21 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: dvbdev: remove redundant initialization of variable ret
Date:   Sun, 24 Apr 2022 16:47:20 +0100
Message-Id: <20220424154720.1356873-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable ret is being ininitialized with a value that is never read.
The ininitializtion is redundant and can be removed. Move the variable
to the scope it is required.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/media/dvb-core/dvbdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index 675d877a67b2..d5a142ef9876 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -243,7 +243,7 @@ static void dvb_media_device_free(struct dvb_device *dvbdev)
 static int dvb_create_tsout_entity(struct dvb_device *dvbdev,
 				    const char *name, int npads)
 {
-	int i, ret = 0;
+	int i;
 
 	dvbdev->tsout_pads = kcalloc(npads, sizeof(*dvbdev->tsout_pads),
 				     GFP_KERNEL);
@@ -260,6 +260,7 @@ static int dvb_create_tsout_entity(struct dvb_device *dvbdev,
 	for (i = 0; i < npads; i++) {
 		struct media_pad *pads = &dvbdev->tsout_pads[i];
 		struct media_entity *entity = &dvbdev->tsout_entity[i];
+		int ret;
 
 		entity->name = kasprintf(GFP_KERNEL, "%s #%d", name, i);
 		if (!entity->name)
-- 
2.35.1

