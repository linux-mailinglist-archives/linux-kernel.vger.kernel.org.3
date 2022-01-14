Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87AFE48E434
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 07:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239352AbiANGXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 01:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbiANGXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 01:23:44 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09D7C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 22:23:43 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id n11so10513248plf.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 22:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=YlBuHVJNhLTTS49RUYF71HhX7jm/XgcILxOyefrpYh4=;
        b=ff9TSWN6sHPkw/cOIiKlFzpwxBYyzIM2oodoXjW2UpJogE/8korjmOKlonPOjLEGFZ
         oI/ntzLW8FeD7MaqZgYNfc99VS2UwUzDYf0fSiYZiHcfh+HkIE1UySexNS9EKwUMxXK4
         U5Gs1I4QvjuNE3hUe4tgpvcdkFUp8iZJOCDbPWzce5SUg1NBn74nLvoeTvj4VUC5IwH8
         bP9tF1z29kpBVh2GQb6bz+r55vn2Hlco/thudioU/fx9gEAi4YRQ3Sn6MYuFmSYLlJzk
         ZMaUo5ybY6MWUpr1Z7coC+3LD87IC/ntJcJq7xFUzS6iA1hCPZVnByIF05ZbUMu/oBgt
         AEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YlBuHVJNhLTTS49RUYF71HhX7jm/XgcILxOyefrpYh4=;
        b=vutmeShvGce65hwVAHtNFPkbaVV8T9el8ripbfrgtQoez/tJ5FgEPQ54HledRt1fe6
         fgXLjjxt/BnEG2NB2PhcWl80kR8VBvlKryi/+/EyxrAskMT/pl2GFCKKZzAxbloPRLMq
         8Vh/ib3OXxflgyDlkkioL6pXsWivZO7SDgMSKlmcCsvfyj7pSTfIyE9GKsChyvpBcZi4
         uLzRIut95+ISKzBG1wCtGyPBrV2ZIt7t5y8SHygGQeauGWORumyrL4L/MZbMah+7wtF8
         ncXTKC5nZTZdJ4RTA8ZqdggzkUqkWs3D/CzskkvHXukEOkmZ/9uv6Lr05ET5GYJ7tlQR
         gspg==
X-Gm-Message-State: AOAM530H9t3NysvmkkX31HWt9vsyHKAUqEHKNs7h2ipqd0Hgfj05Cydd
        1UianMc3U294PrlkvpT/6FM=
X-Google-Smtp-Source: ABdhPJz4PsDyEwcrP8nnfaBqgQF0eFooxBiwroU3cq6N0PHSAeUD/Wox166lAy4Cu7qE9jRZ1hflOg==
X-Received: by 2002:a17:902:e54f:b0:14a:48d6:d39e with SMTP id n15-20020a170902e54f00b0014a48d6d39emr8499336plf.123.1642141423260;
        Thu, 13 Jan 2022 22:23:43 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id f7sm4952907pfe.210.2022.01.13.22.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 22:23:43 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Haavard Skinnemoen <hskinnemoen@atmel.com>,
        Hans-Christian Egtvedt <hcegtvedt@atmel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] misc: atmel-ssc: Fix IRQ check in ssc_probe
Date:   Fri, 14 Jan 2022 06:23:07 +0000
Message-Id: <20220114062307.15199-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_irq() returns negative error number instead 0 on failure.
And the doc of platform_get_irq() provides a usage example:

    int irq = platform_get_irq(pdev, 0);
    if (irq < 0)
        return irq;

Fix the check of return value to catch errors correctly.

Fixes: eb1f2930609b ("Driver for the Atmel on-chip SSC on AT32AP and AT91")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/misc/atmel-ssc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
index d6cd5537126c..69f9b0336410 100644
--- a/drivers/misc/atmel-ssc.c
+++ b/drivers/misc/atmel-ssc.c
@@ -232,9 +232,9 @@ static int ssc_probe(struct platform_device *pdev)
 	clk_disable_unprepare(ssc->clk);
 
 	ssc->irq = platform_get_irq(pdev, 0);
-	if (!ssc->irq) {
+	if (ssc->irq < 0) {
 		dev_dbg(&pdev->dev, "could not get irq\n");
-		return -ENXIO;
+		return ssc->irq;
 	}
 
 	mutex_lock(&user_lock);
-- 
2.17.1

