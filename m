Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565F74FDA3B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358869AbiDLIcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 04:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353574AbiDLHZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:25:46 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FBD43AC6;
        Tue, 12 Apr 2022 00:01:39 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id cw11so619368pfb.1;
        Tue, 12 Apr 2022 00:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=9aYYnSxcM8j7TWBW5FU1fmumHEAakEs8qu5ewn9nHDA=;
        b=KYutpTLeuNsfF3Shhsm4Sy+4a/8mEGtBWt6JK8P7ED8bjwQS1+uBes83hGG2QsXBfs
         Ls3+23AYCTK0RIDNBoLXneLxNYMlw8SvMMa8aO2N3Ay3Otq6H6Mh69tSBI+IWdbshf2i
         tBYum6NCPO6VKeOEXg77OsW4k3zH0W9pVWVV8p4YLjxM6Jpj/Wj0lxw6N2JZkAkQdfEt
         ht+e6FOwWpu8YcXZGfPW24RDd2PDHo2UxkpgsgWoDL0RvSTW5VCFl55mamFQMQpnRbDD
         pO5T6H6cAh++YWypC2iS0eHeRMC1cVOfjWVY/J1mx/TBpAp/iViD5qEQGO2SA00u7Kna
         Rwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=9aYYnSxcM8j7TWBW5FU1fmumHEAakEs8qu5ewn9nHDA=;
        b=qhBnwmwRWGOP+pHAILMVn1dAjsvx9M9jyXDafknyuzTvWT2tCZEyNV3+dN7Wc0NCyC
         YD4C8eOf526vTfuxdFpFFHH+qvdPdV+7t/pxD4Jyzl9KgifltbEsSioBA3wWq16d4vJg
         dZkrxRSEehI1B87acmwse/r5xjVoIk4Da0dY8qJ+2Z4RnBczfBe28OmV9DeiLZ+w607Z
         U/G37Kd6C/X3OmRR12dY3h0zdeex+QyCBW8uDSndh13URKwjv2Xkv2cSiLs72sLR7Rvv
         MUVIQmyoEsvfUJ7eGDhKCsCd4uC81uFdxmhiRC5/VxCn9+XYx1oe6/lPlV8TcRe2UDt9
         zrpQ==
X-Gm-Message-State: AOAM531UckyKCt83dGCE4PztkcJim9NtEssZ5X5pisNfMm+pVBcB+rf5
        E6N+cR53J5X3oerzqp5JueM=
X-Google-Smtp-Source: ABdhPJwKi8UmPRpJcgOPJf1aRNgXPKsIJ1ysNMGQGR6Cefo/MFRMIN46eXYPwV77wm+UitlOiBoPdQ==
X-Received: by 2002:a63:40c6:0:b0:39d:9463:94ac with SMTP id n189-20020a6340c6000000b0039d946394acmr1645793pga.289.1649746897974;
        Tue, 12 Apr 2022 00:01:37 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id b16-20020a17090a011000b001cb4815d135sm1773149pjb.9.2022.04.12.00.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 00:01:37 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        "G, Manjunath Kondaiah" <manjugk@ti.com>,
        Felipe Balbi <balbi@ti.com>,
        "Poddar, Sourav" <sourav.poddar@ti.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: omap4-keypad - Fix pm_runtime_get_sync() error checking
Date:   Tue, 12 Apr 2022 07:01:26 +0000
Message-Id: <20220412070131.19848-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the device is already in a runtime PM enabled state
pm_runtime_get_sync() will return 1, so a test for negative
value should be used to check for errors.

Fixes: f77621cc640a ("Input: omap-keypad - dynamically handle register offsets")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/input/keyboard/omap4-keypad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index 43375b38ee59..8a7ce41b8c56 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -393,7 +393,7 @@ static int omap4_keypad_probe(struct platform_device *pdev)
 	 * revision register.
 	 */
 	error = pm_runtime_get_sync(dev);
-	if (error) {
+	if (error < 0) {
 		dev_err(dev, "pm_runtime_get_sync() failed\n");
 		pm_runtime_put_noidle(dev);
 		return error;
-- 
2.17.1

