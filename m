Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4FE4DB7B6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 19:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350787AbiCPSDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 14:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbiCPSDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 14:03:09 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB1440919
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 11:01:51 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id y27-20020a4a9c1b000000b0032129651bb0so3640132ooj.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 11:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d8UDUPCagSybiysvIhI5BIqU58eMg3iRfrR4eYtybjA=;
        b=xtASAU7wDaIm+b/Xk6+2pUb1aGShhm7O6WqcS5BCdDlhIoH84j1qti5oFq6+1TJ5SI
         J+layVpKVy7aWAleN7DXxRh1KI/dZcBnK0lFxO03FcRDLr6qpcXmw262hV51mA/7zO+3
         pfuk9u1pV3OCrMr3mq/OP8U5zh6V3ZoMhX01oiWRxrcMYRXGRl4bdZWoJqJkCyRPhUz0
         nzBW9oPfswwJ43raEMm8zxOMPGlzbPi8r3fZauMB3GFzH8rwD5S4w2wT2mo9vNj3GRjT
         k6FN/PnenP5VxUbriuoN/vOXjDXviD7XKwO+eA9aPW8MHVhjwh1sQryZ/2JcVR2M3nF5
         mVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d8UDUPCagSybiysvIhI5BIqU58eMg3iRfrR4eYtybjA=;
        b=qw1mcNl8Sso6O0X0xO/yZLCD2SLupgKQ+sqCSe2/ZcoasRqdE6EKVCvVFKR3TqVdHv
         OGYAduu9kBthC2Rifbr9ZlEdiUYNh6A8lEbuy8CvS0QuLPnBLYVBQGaBzVWHgySRBmMG
         zzMl5/FMmAiPR6kNt72SJD3YXzm6MykoUs5GNqqdQzFxYTK7qnueuj6ncgVlHK3+NyH0
         02RmbryfSHNyxCi8EQd90uKglxr5vVGs7Uw316LXnv4joG4C8I5r/PhsNFZeg25NgZXs
         KxmPI5K0SNdaTt1qA/bR5xHfLlucYbVXxGRzds/ABzZGmrPvOxyh/wh1O6Gs+89PXj7d
         6A6g==
X-Gm-Message-State: AOAM533v9Ck37tKi0VW1rFOIR3OyByycTpvT7glWPhVhzn8ntP5nkDUg
        27Z3sGzCbM9R/Tk4kEBYuziFxQ==
X-Google-Smtp-Source: ABdhPJzursgp/IXFlioGmkDd/1LMOK2ELicz8/m7QIxCTlhJM0Q7gJO648o0f0y6q7/vwOsvWNuKgQ==
X-Received: by 2002:a05:6870:4195:b0:da:9790:288b with SMTP id y21-20020a056870419500b000da9790288bmr387093oac.284.1647453710856;
        Wed, 16 Mar 2022 11:01:50 -0700 (PDT)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id 96-20020a9d0469000000b005c959dd643csm1215810otc.3.2022.03.16.11.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 11:01:49 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] thermal/drivers/qcom/lmh: Fix irq handler return value
Date:   Wed, 16 Mar 2022 11:03:22 -0700
Message-Id: <20220316180322.88132-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After enough invocations the LMh irq is eventually reported as bad, because the
handler doesn't return IRQ_HANDLED, fix this.

Fixes: 53bca371cdf7 ("thermal/drivers/qcom: Add support for LMh driver")
Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/thermal/qcom/lmh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
index c7f91cbdccc7..af9f0872614f 100644
--- a/drivers/thermal/qcom/lmh.c
+++ b/drivers/thermal/qcom/lmh.c
@@ -45,7 +45,7 @@ static irqreturn_t lmh_handle_irq(int hw_irq, void *data)
 	if (irq)
 		generic_handle_irq(irq);
 
-	return 0;
+	return IRQ_HANDLED;
 }
 
 static void lmh_enable_interrupt(struct irq_data *d)
-- 
2.33.1

