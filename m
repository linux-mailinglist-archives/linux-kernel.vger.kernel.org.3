Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63035008FE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241281AbiDNI7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241279AbiDNI7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:59:41 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642BB689BF;
        Thu, 14 Apr 2022 01:57:15 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id h15-20020a17090a054f00b001cb7cd2b11dso5045824pjf.5;
        Thu, 14 Apr 2022 01:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PtdPy5iIEOQcZoHnDSw0hgLztC3cDH19YHNzNyg9apQ=;
        b=aFbdo82vr3djW557YX6je9lvRJYsV5O/9ZQFrW0drz/4ggQWtg9Iuz7+UQHR0lH9rF
         6LnGlpny3SYoWrV3yX7J7046VUhDDh+zLUh5/zCckRIMaQHmG4GRXcIBy4LDZX4AWoNr
         AGxEM33cXxOcgZgnNTXgyAyp8jNOOBFvFSegc4N8XZdVHhdQ3ADwP+xpMag8fvl+IeCK
         5hM1vVWFo4R9rgbDzB19j/ixYCCon/N6TaeqO0NjN55jkv5iet4zG/rbmxcMi+5qpkkZ
         at2FScNr2JpdYO856a777+p7JqDba2j0Gt7Eyopi0uEzRauDXX3Sgt8U58+gV/ugY+TW
         dh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PtdPy5iIEOQcZoHnDSw0hgLztC3cDH19YHNzNyg9apQ=;
        b=fZ2Co1ONbRcFBOcpjoVQhYP6yae2sgs7RaFyckkCgrdJXq3YLrNsPVF63EEWiMyaWQ
         DSIDkrO4gCCCqFutYe1SPt24eXkol3RdBeSZeGyf0eWuctZCddJ0MTdW26FFm+sJC6zR
         uwTCjanBbL2C2PdFcEGx6xBVbZAabs76cmFYroTCvCkpCuE7AkmW6MUGxzSBG6tKu/8Z
         gQCcbC1EaFbNDGhDn//KBPdrltkBt3/cajOoWWasClqBhH6E1uNyAaDD4EsSzInxITEp
         jbdZs7GZVb3kZcbxLg5zWMwesHfG5xzlhztr/Tz3ujYpAZQ/8FtGF3oxbE6CcGuoPlzz
         ILAQ==
X-Gm-Message-State: AOAM533BoPwot63p/oJXYCl5j4gHa6Efl8JuoCUEXYfQpsVgwA9gMUfA
        qEqY6QG9fV4IM7Qf2aR15XQ=
X-Google-Smtp-Source: ABdhPJwRBr22PhiEYJRK6ncnt221HNdSddHEQ2APA92Yamavz6QvRQN5vUnY1Wr2TERt85f6dwVdcg==
X-Received: by 2002:a17:902:ced2:b0:158:85e5:4c8e with SMTP id d18-20020a170902ced200b0015885e54c8emr12707893plg.92.1649926634976;
        Thu, 14 Apr 2022 01:57:14 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 21-20020a630115000000b00382a0895661sm1320168pgb.11.2022.04.14.01.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:57:14 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] input: omap4-keypad: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Thu, 14 Apr 2022 08:57:10 +0000
Message-Id: <20220414085710.2541867-1-chi.minghao@zte.com.cn>
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

Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
pm_runtime_put_noidle. This change is just to simplify the code, no
actual functional changes.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/input/keyboard/omap4-keypad.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index 43375b38ee59..df6ab8006807 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -179,11 +179,9 @@ static irqreturn_t omap4_keypad_irq_thread_fn(int irq, void *dev_id)
 	int error;
 	u64 keys;
 
-	error = pm_runtime_get_sync(dev);
-	if (error < 0) {
-		pm_runtime_put_noidle(dev);
+	error = pm_runtime_resume_and_get(dev);
+	if (error < 0)
 		return IRQ_NONE;
-	}
 
 	low = kbd_readl(keypad_data, OMAP4_KBD_FULLCODE31_0);
 	high = kbd_readl(keypad_data, OMAP4_KBD_FULLCODE63_32);
@@ -207,11 +205,9 @@ static int omap4_keypad_open(struct input_dev *input)
 	struct device *dev = input->dev.parent;
 	int error;
 
-	error = pm_runtime_get_sync(dev);
-	if (error < 0) {
-		pm_runtime_put_noidle(dev);
+	error = pm_runtime_resume_and_get(dev);
+	if (error < 0)
 		return error;
-	}
 
 	disable_irq(keypad_data->irq);
 
@@ -254,9 +250,7 @@ static void omap4_keypad_close(struct input_dev *input)
 	struct device *dev = input->dev.parent;
 	int error;
 
-	error = pm_runtime_get_sync(dev);
-	if (error < 0)
-		pm_runtime_put_noidle(dev);
+	error = pm_runtime_resume_and_get(dev);
 
 	disable_irq(keypad_data->irq);
 	omap4_keypad_stop(keypad_data);
@@ -392,10 +386,9 @@ static int omap4_keypad_probe(struct platform_device *pdev)
 	 * Enable clocks for the keypad module so that we can read
 	 * revision register.
 	 */
-	error = pm_runtime_get_sync(dev);
+	error = pm_runtime_resume_and_get(dev);
 	if (error) {
-		dev_err(dev, "pm_runtime_get_sync() failed\n");
-		pm_runtime_put_noidle(dev);
+		dev_err(dev, "pm_runtime_resume_and_get() failed\n");
 		return error;
 	}
 
-- 
2.25.1


