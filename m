Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8887852117A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 11:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239350AbiEJJ45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 05:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239333AbiEJJ4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:56:48 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B1E2A1FD6
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 02:52:51 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id c11so22973755wrn.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 02:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wNYpWGO+GrpCk66Nh5RWJKF3WobSkmY4PbioKCEWPFY=;
        b=hFqZZ0ICYkgRQGCbRC8+DcodIWSYgUjTTQHgu6FnKubGjg/utvGRQLhLyDdpl2fXaJ
         1xFvUmnBl+Dcuo8dGRQAkdF5Sa3ZM0hVgtjbe8g+CkAvp4foejeduVfTGZ5x04G2qMuc
         nsSNwz6mK4S+KhBUMhJ9y9UEFAPV62oxmA0zcvXtF9B6o9tgVHfIyh3aLegOabR1hfxv
         VrAoSLOfAd9reVTyQ+aLC5SKNU5q9HJOuOCPjZBhQkbWRIeg/tM27zZG0e2igWBnuTWZ
         fXI1UeGpztBj/M3hKGcKyQI1NKEgrQ4gUqh3E0NT7MDscmKUhTkWTtX3elV9KuOlrw4f
         3Bjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wNYpWGO+GrpCk66Nh5RWJKF3WobSkmY4PbioKCEWPFY=;
        b=BwmKUp+LL3fSYlxfiVHlTgBE2FBLdevRszaWrV4wtW0zBsg1F9aHGP0W+uLL393bp7
         kzgiUSEcQdWRU9GNfWXu/NAKuCj5/WkrKXLb+u7wrN116hlSna3ik1PtU1e6rHycFC4k
         2Xn2GaRKIKxnJLfVhxYscmMPCSjpoMfdc4uEKbyK+v47nG0GzbsuLPT4CFfGyR4dZqEz
         YPsi2ksMow+OaTQEVDBl5HrgiUUshyqVEwwkWYIAVKFJkh3RXv01/M2DGGebPxeJxjnZ
         ndrjsCY6Esf4COBS3bxzEi2tdNHhl/PZadej/0ySKU4/tuReL6aVJ+gQdTeukDl2ppCl
         grkQ==
X-Gm-Message-State: AOAM530XiK6aI8EBC/nyQ2nmsqFN5EnyBNBJo2bLw1TRo6ZvRjZ0Sjsx
        trD1sbA93Q4zo9DyH6rPLmbRaMyiHON/Tg==
X-Google-Smtp-Source: ABdhPJx49jdydbEGnXpJv3NmqOOxutVO+GieeI3/xpyyI6lzHnwpBDlasvHYIipVw31cQ+pqsq74Cw==
X-Received: by 2002:adf:fb03:0:b0:20a:e253:b8c7 with SMTP id c3-20020adffb03000000b0020ae253b8c7mr17386100wrr.119.1652176370219;
        Tue, 10 May 2022 02:52:50 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b003942a244f40sm2268252wms.25.2022.05.10.02.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 02:52:49 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 2/2] slimbus: qcom: Remove unnecessary print function dev_err()
Date:   Tue, 10 May 2022 10:52:05 +0100
Message-Id: <20220510095205.337-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220510095205.337-1-srinivas.kandagatla@linaro.org>
References: <20220510095205.337-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Li <yang.lee@linux.alibaba.com>

The print function dev_err() is redundant because
platform_get_irq_byname() already prints an error.

Eliminate the follow coccicheck warning:
./drivers/slimbus/qcom-ctrl.c:514:2-9: line 514 is redundant because
platform_get_irq() already prints an error

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ctrl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index ec58091fc948..c0c4f895d76e 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -510,10 +510,8 @@ static int qcom_slim_probe(struct platform_device *pdev)
 	}
 
 	ctrl->irq = platform_get_irq(pdev, 0);
-	if (ctrl->irq < 0) {
-		dev_err(&pdev->dev, "no slimbus IRQ\n");
+	if (ctrl->irq < 0)
 		return ctrl->irq;
-	}
 
 	sctrl = &ctrl->ctrl;
 	sctrl->dev = &pdev->dev;
-- 
2.21.0

