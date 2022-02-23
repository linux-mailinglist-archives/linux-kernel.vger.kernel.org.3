Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDC04C1E90
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 23:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244128AbiBWWfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 17:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244002AbiBWWfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 17:35:37 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8033AA4C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 14:35:08 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id f17so200112wrh.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 14:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Owyqqw4ZciiVsh4eNvQY483r2Ssh0yACfpW7BZLM4Mc=;
        b=dY+p/msL2shWcnl9rA194MZDfMK0Kt849BI/KEcfTQ78OurKFQ9zqDFtrnWyc3Iw8R
         XVKm16ZEzEg4qCDWE+q0eGAQaF0aGoP5rJTEeh+IlpdMc82Zp18NWXzE9p+NnGkU0leC
         W8i3hutXpcUVdmR8Dhee51RMd2n3jDoFHFT+TJlJGm1Bw/K96B0ds9wC9LFkI8HxB5HN
         wWJ3lde1LgqX0t6SdUkMO3fGWapU8FSgPPKvTCDvx8KJN/Dg5cN2YAl8t5EkSIlqzx1v
         e9GvLQzN4tCBeVe7Grk3cWXnKVUSmWoRVl7415yhk323JDXNVgxYnGxl5xsgkJpbGtjm
         YwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Owyqqw4ZciiVsh4eNvQY483r2Ssh0yACfpW7BZLM4Mc=;
        b=dHp3NMCZ30fK7w+U3HAYFYnBpK6WXSpe6R5Z82sn156bOsnF7Qq8sX8c0I8W5x3YSw
         vd4jwpTnXMWjlovGUn8vDJjvK4Qxw1Rd8zG9TXecIRx7Xy/CbHg9gYoyYm8NXW0z4YRG
         NMVDD6+6LzpmsB8iD9thYfaq0VjtL35s/u+UqiA4TF3oLsli4xPNOc48LeUvlKuqgyvk
         ivjidHdL6853v8WPRonOJQECS+HAlNa7d2Xle+HrM5KBxnd1PY1wBgiaUGcMnC59eLJL
         PA2uO5NNqG4ZfJKE+hWKI+9PltsZ6hI++jojMneft5MyLv2Um07rLYJzhDmyU4myjs5U
         Hr5A==
X-Gm-Message-State: AOAM531jEvDdT0t8kwrCIIQ4Tq5jtSd7n2Oy7f05BkEY9wtJfQL5zXfB
        FhPzCrrXQwYpMsCb4n4ZUxOQtw==
X-Google-Smtp-Source: ABdhPJyhl15G3bAPoLbVstbkhLKh6b5K/EpXjs4YmkBJKKa28uI8oZthKhrehQSA5cyOwT99MbiNVg==
X-Received: by 2002:adf:d1cc:0:b0:1ea:8355:88cc with SMTP id b12-20020adfd1cc000000b001ea835588ccmr1237538wrd.313.1645655707438;
        Wed, 23 Feb 2022 14:35:07 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id c9sm729435wrn.51.2022.02.23.14.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 14:35:06 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Knox Chiou <knoxchiou@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/3] nvmem: qfprom: Increase fuse blow timeout to prevent write fail
Date:   Wed, 23 Feb 2022 22:35:00 +0000
Message-Id: <20220223223502.29454-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220223223502.29454-1-srinivas.kandagatla@linaro.org>
References: <20220223223502.29454-1-srinivas.kandagatla@linaro.org>
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

From: Knox Chiou <knoxchiou@chromium.org>

sc7180 blow fuses got slightly chances to hit qfprom_reg_write timeout.
Current timeout is simply too low. Since blowing fuses is a
very rare operation, so the risk associated with overestimating this
number is low.
Increase fuse blow timeout from 1ms to 10ms.

Signed-off-by: Knox Chiou <knoxchiou@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/qfprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index 061293f9136b..162132c7dab9 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -22,7 +22,7 @@
 
 /* Amount of time required to hold charge to blow fuse in micro-seconds */
 #define QFPROM_FUSE_BLOW_POLL_US	100
-#define QFPROM_FUSE_BLOW_TIMEOUT_US	1000
+#define QFPROM_FUSE_BLOW_TIMEOUT_US	10000
 
 #define QFPROM_BLOW_STATUS_OFFSET	0x048
 #define QFPROM_BLOW_STATUS_BUSY		0x1
-- 
2.21.0

