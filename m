Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C062B580483
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 21:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236190AbiGYTg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 15:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiGYTgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 15:36:24 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27A51F2C3;
        Mon, 25 Jul 2022 12:36:23 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id sz17so22444974ejc.9;
        Mon, 25 Jul 2022 12:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+uGxyBOj8uy9/NOJeYkAeNRty35auyq9QTyL2vbKIqs=;
        b=aWBpxnn9sn41kMtCQ2/UguJehnh4aNWK34ndCiRANpD781prisqPqWZCnfCezDxegX
         s6ryz28pxVg6ESxPFX80xxA9DvybUChS08+UihxC2YS4dupc2pRcGPeaeECyoyXUig/H
         dt1lhQeexIJaGPulZ+6ZsoEwTBKGV7nAL2YbotEcdDGiM0I8jwR5Y5Ub00r9xYxalhMP
         h8annn3GiOUJ1PL84vn9aApsRQuCxbpu1nULWy3NEjs5Mk7L6YQuh3ahiauj6VL/KDA7
         PYJk9QLiPkqzI3c/EOuKWceWUSuLB3sDn97ZVJpseghUsAP39zL7meAPQo9Ks98EEIWn
         bIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+uGxyBOj8uy9/NOJeYkAeNRty35auyq9QTyL2vbKIqs=;
        b=FmxAIJlr+VKYzMQv1F58Nu2bKBeaK9o44/mWwylWJ5ix7j902aeimsCtW+To7OAJlS
         8mtWv0dQYZjenVi4PduWyRtvMhGAec3W34IhkvuBMr/DoIEYsdaPBJpDHSS1tbDRpEvs
         0Kgw1cuXZGKWvlYoa1RuoIXp1pcvF32kxjvTHDZB1iqvLHovL6JAc9VkPzLT3n/A15BB
         H9FhslKKzAsK/S+lxKeflRcPWD7e/oo7nwAcrPJv380jPJOTXUrIYbqm60He2axEFCpw
         W5aVYQXHTEYU5n5cYR1K3KWmKUXIXmaBocLUjxxPmZ+sMJM9tawKWmo1m1IapMJX86T4
         FU6Q==
X-Gm-Message-State: AJIora9+Nl3vJFbkxw2p4+I+cVBSTk6PVe1QuJ21x+beiiNOpQ0Qb2NF
        40BKMBbZYRi8SqvXwK20NoS+KxXusjs=
X-Google-Smtp-Source: AGRyM1vYaSolC/1IbcKL/tdF8eKMind/3he4Dge0drIwIiFgbLYBeHdnz4tJkJdybuLB41IEfF5c1g==
X-Received: by 2002:a17:907:6e8a:b0:72b:1496:7161 with SMTP id sh10-20020a1709076e8a00b0072b14967161mr11612393ejc.519.1658777781976;
        Mon, 25 Jul 2022 12:36:21 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-c1ab-4100-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:c1ab:4100::e63])
        by smtp.googlemail.com with ESMTPSA id k14-20020aa7d8ce000000b0043a6e807febsm7571001eds.46.2022.07.25.12.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 12:36:21 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bert@biot.com, sander@svanheule.net,
        mail@birger-koblitz.de,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFC v1] spi: realtek-rtl: Fix clearing some register bits
Date:   Mon, 25 Jul 2022 21:35:47 +0200
Message-Id: <20220725193547.1038414-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.37.1
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

The code seemingly tries to clear RTL_SPI_SFCSR_LEN_MASK (before then
setting either RTL_SPI_SFCSR_LEN1 or RTL_SPI_SFCSR_LEN4) and
RTL_SPI_SFCSR_CS. What it actually does is only keeping these bits and
clearing all other bits, even the ones which were just set before. Fix
the operation to clear the bits in the selected mask and keep all other
ones.

Fixes: a8af5cc2ff1e80 ("spi: realtek-rtl: Add support for Realtek RTL838x/RTL839x SPI controllers")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
I stumbled across this while reading the driver. This patch is untested
because I don't have any hardware with this controller.


 drivers/spi/spi-realtek-rtl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-realtek-rtl.c b/drivers/spi/spi-realtek-rtl.c
index 866b0477dbd7..e5ad0f11996f 100644
--- a/drivers/spi/spi-realtek-rtl.c
+++ b/drivers/spi/spi-realtek-rtl.c
@@ -49,7 +49,7 @@ static void set_size(struct rtspi *rtspi, int size)
 	u32 value;
 
 	value = readl(REG(RTL_SPI_SFCSR));
-	value &= RTL_SPI_SFCSR_LEN_MASK;
+	value &= ~RTL_SPI_SFCSR_LEN_MASK;
 	if (size == 4)
 		value |= RTL_SPI_SFCSR_LEN4;
 	else if (size == 1)
@@ -143,7 +143,7 @@ static void init_hw(struct rtspi *rtspi)
 	/* Permanently disable CS1, since it's never used */
 	value |= RTL_SPI_SFCSR_CSB1;
 	/* Select CS0 for use */
-	value &= RTL_SPI_SFCSR_CS;
+	value &= ~RTL_SPI_SFCSR_CS;
 	writel(value, REG(RTL_SPI_SFCSR));
 }
 
-- 
2.37.1

