Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92127508473
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 11:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376983AbiDTJHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 05:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351576AbiDTJHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 05:07:12 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987F72229B;
        Wed, 20 Apr 2022 02:04:27 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id b17so876341qvp.6;
        Wed, 20 Apr 2022 02:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MY0b/G9laj2Vseo8bgaP5QaAPEk7Q0dPmckO9qswG3M=;
        b=RxSeSOVwNhrQOmDIYoEmX8pFYgtQ8n6xdhoJBdOoJYH7zzBgpYRm58Mdr0axfehxgG
         PjdBQJ4ZNgKKH46qig8EyNIvzSiAB5BuoqG+ZGzCOy05CxR30E6JjrYkqkMj5rni8mbD
         6d7hSgjd6BywIPpzWXE0U1IUej95bmAAu9Y5ave14sL/1U1ilrIunGEMXYyUY4lczBQq
         g1rQJIpycyutpqM8ulEWiWv3Jt9y17+/0I3xxIGe/I8uroj3RExtIDOu7TpnO1rqyaZY
         uR5V33ayYKeMSMQslwRAQgAtEWQvv8cC5zCQ7MaTOjbYge4/HsQ4sF4QFxURrIFJC1/4
         NTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MY0b/G9laj2Vseo8bgaP5QaAPEk7Q0dPmckO9qswG3M=;
        b=7hsaGiWEozyLdQzYmHpMrb2Rw5iyu/qviOq31wWwO/TdzniQwG+6HOVsnT0mYfhsi1
         By7CuA3p45STznvugWQ4WYkhalt3ST9xvAwcujNgfmDH7Wo+Q7rqBUzKjbpeLS0v/VUW
         ZYQxTtrbiwUNB0siJw2T5mUNuKqdB6vSplBGRE/OC0sGo5dM5YOXeRawK9CkVGIKBRGj
         cxWMrEJKio3A4KJt6K4ZI06GETWfoqYBkmQz/MG/9uOgNm1HtH0VCj4BxXf1PpY5jma7
         XmTqxZUm9d1OSuQm4yi1XgtQg0fsrQr5kPOphTejGcjSDoa5yt3/JXNQaRPbciyXcQBp
         TElQ==
X-Gm-Message-State: AOAM5316yF6xDqy5QNMl8oToSPlPfIVyMLtwy2fXxsqPfo7HoDp6TMhj
        pr4PqhsPSb2AsOjMywwlLeQ=
X-Google-Smtp-Source: ABdhPJwmTjwhK/z5QHJtvi6qT9bcAbSSdME7Wm9jqJsTM3Bq349xWOpdNfQ0Rg3RBWoIyQjesuzRLQ==
X-Received: by 2002:a05:6214:3006:b0:443:cf1e:58d7 with SMTP id ke6-20020a056214300600b00443cf1e58d7mr14631865qvb.53.1650445466868;
        Wed, 20 Apr 2022 02:04:26 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a7-20020a05622a064700b002e238d6db02sm1516867qtb.54.2022.04.20.02.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 02:04:26 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     broonie@kernel.org
Cc:     shawnguo@kernel.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] spi: mxs: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Wed, 20 Apr 2022 09:04:20 +0000
Message-Id: <20220420090420.2588868-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
pm_runtime_put_noidle. This change is just to simplify the code, no
actual functional changes.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/spi/spi-mxs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 435309b09227..55178579f3c6 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -605,9 +605,8 @@ static int mxs_spi_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = pm_runtime_get_sync(ssp->dev);
+	ret = pm_runtime_resume_and_get(ssp->dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(ssp->dev);
 		dev_err(ssp->dev, "runtime_get_sync failed\n");
 		goto out_pm_runtime_disable;
 	}
-- 
2.25.1


