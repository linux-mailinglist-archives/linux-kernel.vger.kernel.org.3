Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93597536AD2
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 06:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355832AbiE1E5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 00:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355788AbiE1E4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 00:56:42 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCFD11907C;
        Fri, 27 May 2022 21:56:41 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id v5-20020a17090a7c0500b001df84fa82f8so6012776pjf.5;
        Fri, 27 May 2022 21:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ve267SFN8Pme2jGTGvHDb20Y5JH3qsdE6rBDHoAACPM=;
        b=eWy3kF5pqY/02M9mhY8Wj1p102SeDVc2tZcg2vVeDHSxwnH8Bh58mxGhHoLOhR6QWI
         hr1cOytRIrBioBs9bQXcpiZjGT479XmfPx3VK9LBWBv7Zvch76RpfONOD3RkSvwTmZT+
         uEWxa5rkk996oBYRbporlgrvSgCUbx5/Fwl2LVm26CLNDPamFiyhPs+PCR5xDH8jbwm2
         R0Pw/GOC0TdIU0DjC64owExn3dRh7r3HVEKFoZnIdgOxjQEsdfLu4Yq2BnmuqRBiDXxW
         4HJ+TZWMIr9PmUn6Bjp4VxkrbH1R1D+w3FAoBxB0GnMSgV/C0eWZ+MEkppGLyVdoNu4y
         VYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ve267SFN8Pme2jGTGvHDb20Y5JH3qsdE6rBDHoAACPM=;
        b=mR3qBsXzMAr98KdaKM9eTV21+a1yEprNlg51DgeESgqHC7RN3DuMuHx6En56N2YNHe
         rQCB5lvm8+JlFzi5HNhAMocD9A0+DSw9pmAcdIPdFlxOnMNuIBGMMKUwaMdyvv3mr6eS
         SK0ImV7w8vTCr02UYTHLOQsVwV3t07lhOLOPZW+iJNqhjoA/yt+FNnrka3or8oX+PD4b
         xbS5XrGeOSroW7m+WExO6t8PbukRL7EyFc7fjsr1G+9OnIJoscp8g3MVAPzIrrQFZ+jP
         hmth2V+FB3VA8Uij8Tl7BVHD8j4er4ORiHdfrTIailzQGelbNokRb+W/y+v3Fjcq/mCe
         v26Q==
X-Gm-Message-State: AOAM532O9jZubHH3z37rplcOy0AGLy8fIqzh8MM23XCqjP3fZ84ysI77
        zukL+VCtnrqvfR0BFA3v+sc=
X-Google-Smtp-Source: ABdhPJwHkjWibOlv3EnhUt8TxtMv7RGtNL0ED7aU3GT3uqRyYWaJjSMZCRYyf9jaQmekSbeEsqIk8w==
X-Received: by 2002:a17:903:240c:b0:153:c8df:7207 with SMTP id e12-20020a170903240c00b00153c8df7207mr45765498plo.44.1653713800929;
        Fri, 27 May 2022 21:56:40 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:331d:9bef:6841:67a4])
        by smtp.gmail.com with ESMTPSA id q5-20020a17090311c500b001620960f1dfsm4594202plh.198.2022.05.27.21.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 21:56:39 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Michael Hennerich <michael.hennerich@analog.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] Input: adp5588-keys - do not explicitly set device as wakeup source
Date:   Fri, 27 May 2022 21:56:31 -0700
Message-Id: <20220528045631.289821-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220528045631.289821-1-dmitry.torokhov@gmail.com>
References: <20220528045631.289821-1-dmitry.torokhov@gmail.com>
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

I2C core will set up device as a wakeup source and will configure interrupt
as a wakeup interrupt if client is created with I2C_CLIENT_WAKE flag. Let's
rely on this facility and to not unconditionally set up the device as
wakeup device in the driver.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/adp5588-keys.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/keyboard/adp5588-keys.c
index df84a2998ed2..2a274240facb 100644
--- a/drivers/input/keyboard/adp5588-keys.c
+++ b/drivers/input/keyboard/adp5588-keys.c
@@ -589,8 +589,6 @@ static int adp5588_probe(struct i2c_client *client,
 	if (error)
 		return error;
 
-	device_init_wakeup(&client->dev, 1);
-
 	dev_info(&client->dev, "Rev.%d keypad, irq %d\n", revid, client->irq);
 	return 0;
 }
@@ -609,9 +607,6 @@ static int __maybe_unused adp5588_suspend(struct device *dev)
 
 	disable_irq(client->irq);
 
-	if (device_may_wakeup(&client->dev))
-		enable_irq_wake(client->irq);
-
 	return 0;
 }
 
@@ -619,9 +614,6 @@ static int __maybe_unused adp5588_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 
-	if (device_may_wakeup(&client->dev))
-		disable_irq_wake(client->irq);
-
 	enable_irq(client->irq);
 
 	return 0;
-- 
2.36.1.124.g0e6072fb45-goog

