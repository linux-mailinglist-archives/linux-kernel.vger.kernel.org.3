Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0123C536ACC
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 06:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355785AbiE1E4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 00:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiE1E4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 00:56:38 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB69911907C;
        Fri, 27 May 2022 21:56:36 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id x143so5956622pfc.11;
        Fri, 27 May 2022 21:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6IclY1xHRAIGlsluMDPEkIdCto/PORM26qL8UPSef/g=;
        b=P96vJ6iQ712gwQUBc9k0w2mtKJb73OvrpQTTO9A7n5Ns1gOiNttVSxZCdchHqZv0s1
         jXqEiBEveYhw9NKASLThn1Cq/e483sHaNbPdqScREszhpnpdmue60HHDDU100/HtDcty
         0rRwCeHF9KE/a1S7Uw6qtKLs/KAVAIEoLhjge30D2EJn1klV8Qb9k1zetv5/Oeamy3tJ
         YAGdnBr86LO/DgCNXgQD44Jk+Snm91T/gz1OJ5mIveuJeguDZfmWmNoaG1I1utxLg5ZX
         jV0M7+zIBdDyL3ebqgxrsG3G/3EPS+bmiyUWMR+/2+/tGqVnSTbUPNE6Wkzbyq5OgBgF
         au2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6IclY1xHRAIGlsluMDPEkIdCto/PORM26qL8UPSef/g=;
        b=0kfGLnEBkUZpe74fsATY6WeuSjhdMvnyTjxySEP34DaRPZGppB++79AV7FZjxBkiG4
         tWakmE7bFSDYPMsK/wtncBwkhv+gSPZYM4DBE+djoBp17/aJJD7TfJ8/UPenHC/uL7AH
         9p1Mtqy5BxQuDzVjjuBBHo3VAGaLEVk/ZMXmkpFl+WyLJoimDIlyTxcMeTk7tPemGcPG
         08Lfj5/LSlMUc+o4ZJMeRy82BxRselqlMc/AyIzdrIZ+2NkDD5fnXB83L1/w8K3fgFQE
         HbVtZOMgRv5nGztmrXxa9Iwo2yFNFPcFdkPW/DM/DYU/YNh5tE6vY+9ly7zJdTfT0RNP
         gIXA==
X-Gm-Message-State: AOAM531vFNmuyhfD0mhmG1Aty/oX49BcRodL5sRwpKvgjh+h04gfMuZq
        5LHTyUddNxKfQzNvjCZqfM3gUhV6FBo=
X-Google-Smtp-Source: ABdhPJwJ89X5/ZM35Vu/XQhgnvPZy7apTuWz1cslHnkISeVZAD/fnLCGJQtdBDys8nX/eO3hC5ewGQ==
X-Received: by 2002:a63:fe08:0:b0:3fa:b2bd:e616 with SMTP id p8-20020a63fe08000000b003fab2bde616mr17301871pgh.114.1653713796116;
        Fri, 27 May 2022 21:56:36 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:331d:9bef:6841:67a4])
        by smtp.gmail.com with ESMTPSA id q5-20020a17090311c500b001620960f1dfsm4594202plh.198.2022.05.27.21.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 21:56:34 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Michael Hennerich <michael.hennerich@analog.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] Input: adp5588-keys - drop CONFIG_PM guards
Date:   Fri, 27 May 2022 21:56:28 -0700
Message-Id: <20220528045631.289821-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
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

To improve compile-time coverage let's drop #ifdef CONFIG_PM guards
and use SIMPLE_DEV_PM_OPS and __maybe_unused attributes and rely on
the linker to drop unused code.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

Since we are talking about keeping the driver and switching it away from
platform data and towards device properties, here are some cleanups.

Only compiled, not tested.

 drivers/input/keyboard/adp5588-keys.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/keyboard/adp5588-keys.c
index 1592da4de336..ea67d0834be1 100644
--- a/drivers/input/keyboard/adp5588-keys.c
+++ b/drivers/input/keyboard/adp5588-keys.c
@@ -612,8 +612,7 @@ static int adp5588_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int adp5588_suspend(struct device *dev)
+static int __maybe_unused adp5588_suspend(struct device *dev)
 {
 	struct adp5588_kpad *kpad = dev_get_drvdata(dev);
 	struct i2c_client *client = kpad->client;
@@ -627,7 +626,7 @@ static int adp5588_suspend(struct device *dev)
 	return 0;
 }
 
-static int adp5588_resume(struct device *dev)
+static int __maybe_unused adp5588_resume(struct device *dev)
 {
 	struct adp5588_kpad *kpad = dev_get_drvdata(dev);
 	struct i2c_client *client = kpad->client;
@@ -640,11 +639,7 @@ static int adp5588_resume(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops adp5588_dev_pm_ops = {
-	.suspend = adp5588_suspend,
-	.resume  = adp5588_resume,
-};
-#endif
+static SIMPLE_DEV_PM_OPS(adp5588_dev_pm_ops, adp5588_suspend, adp5588_resume);
 
 static const struct i2c_device_id adp5588_id[] = {
 	{ "adp5588-keys", 0 },
@@ -656,9 +651,7 @@ MODULE_DEVICE_TABLE(i2c, adp5588_id);
 static struct i2c_driver adp5588_driver = {
 	.driver = {
 		.name = KBUILD_MODNAME,
-#ifdef CONFIG_PM
 		.pm   = &adp5588_dev_pm_ops,
-#endif
 	},
 	.probe    = adp5588_probe,
 	.remove   = adp5588_remove,
-- 
2.36.1.124.g0e6072fb45-goog

