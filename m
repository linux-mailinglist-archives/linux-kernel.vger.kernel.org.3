Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0455453A510
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 14:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348221AbiFAMbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 08:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352882AbiFAMaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 08:30:39 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0698CCFF
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 05:30:37 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id g205so1827759pfb.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 05:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dobCxK4OC92EBjp1RkCP1kDTote0DN9ExGNqTwwRdRU=;
        b=Yj2ztRMVWHrKvL/JjhY21O2YiqbJ7ALPDfBZz7UhFk5/nSCS/hoBMD2HHjfAd26Jb4
         m/kLFwbSjHyd55sxC0qFS2xVdH5zu/OkzelDi6G4LNAWlFtuy7WI+Eo7PO8NS9oIuZLi
         xAGi+FcjpGcxg0PQHjfKIGogSKwzo5HKtPPecSWUMtnZaY+IS2m2PIOR5b4dep2Nx5XB
         CGFnq6XTV/qrlYGU4H3Ze4OiF2PVCoL0qPx2LXvB65CCfIMElK955GzratfNiTKdExlW
         audMBqkPtbKxCE8ddp5UEjdhyBVpix6Uu8sAEaWtO5yA9d61QoTOVruo00p4nL+/hhzy
         1fnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dobCxK4OC92EBjp1RkCP1kDTote0DN9ExGNqTwwRdRU=;
        b=CguR8iq99U8p2j6EdZ/dt8y5s+S1e0x5SC6hthAYnvvDHeWGAqzu7tepq/El1tvPwZ
         cvlYN7Fta8+BJ7MbCG/tkjU3uXYc0N15gDGC/n/nxa7YF0yf+FF2gfajqEZQaB8BAEbK
         aWffd597bKsXDECaiZpl+uEQ47pAzQTbnBljRhaHKnzkRinK9svAC670Awb5VhA47wJa
         tNP1O0wtBdiLjkpJ14ddLFmtcVVm9XLJlwp+OMq2tyvf4gocAd/D/UF1R/1lSvjgDnqG
         GtnVe8OjelnDYIoc/iycrn0vLpDXkKmNDWyXfOoyattXKdyBnXGSZVMqPXxesPms063j
         1LxQ==
X-Gm-Message-State: AOAM5332g6+GdRpvenMYEcZaWSR8oNO0j3tf0QGpbr0yPaqzPIuQc4MI
        76eTb0CejCymoWN/93LJIiQ=
X-Google-Smtp-Source: ABdhPJzy47iKor+i/UJAy5jAnbJ63ro9WfMBurWXy0/UksARPx2R31tHOrC/Zo8U5p9FKx23f3CXpQ==
X-Received: by 2002:a05:6a00:164c:b0:50a:472a:6b0a with SMTP id m12-20020a056a00164c00b0050a472a6b0amr66474311pfc.77.1654086636639;
        Wed, 01 Jun 2022 05:30:36 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id x1-20020a170902820100b001618383483fsm1424740pln.224.2022.06.01.05.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 05:30:35 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Hans-Christian Egtvedt <hcegtvedt@atmel.com>,
        Haavard Skinnemoen <hskinnemoen@atmel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [RESEND PATCH] misc: atmel-ssc: Fix IRQ check in ssc_probe
Date:   Wed,  1 Jun 2022 16:30:26 +0400
Message-Id: <20220601123026.7119-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
2.25.1

