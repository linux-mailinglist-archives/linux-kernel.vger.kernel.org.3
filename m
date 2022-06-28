Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2289E55E3A6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345878AbiF1Mpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345328AbiF1MpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:45:24 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9C21D0FE;
        Tue, 28 Jun 2022 05:45:22 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id n8so3436883eda.0;
        Tue, 28 Jun 2022 05:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OC/Q0ZHSYivrSfFoAF8zUByQ32IP+ZgOcCZoC0yMQAM=;
        b=MHL34CI71jL8wxvfIo3kffmm6/Bzw/zxa4CCePVNSukTsqOG4zJCqZbR4IQ1WfSXda
         23Cw8J9CMbGMEBKxBYOSkHrh3hqgyXrY2wjsTguu+bx9/hVf6/bJrHYeZXa//qVQAvqV
         ixOQEP8JPKMDauiCghdNu0zNGLPYfXSyVxJzTG0BI5K63EPR/gAhM5dKetJkrJmW/fR9
         xXurrBhZHaOiYR2QC+De+xa+UbtcJk1Vv+rUmi8kSfu/3lv0L0DqWmkiwQzRfrTednpo
         fLbWFah/u1N234w0DqNvtk3UE/yt7Eh6z8M3ei1Pd0f5l51wej/FKIhVZyDeaIarLQh3
         r7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OC/Q0ZHSYivrSfFoAF8zUByQ32IP+ZgOcCZoC0yMQAM=;
        b=g0idSh+zYrhfi3gTCQXD+b8xjnkTMKSBF5bnGadF1Fhr/1IjKnA31n3XpcHYQ715bf
         abesNBmqFYur6XiU6fIQHfuyqy8RHvVr2BICGYZok16ktk0hWKI2aVzEcGQAmdebSPA+
         i7jxT8gCRrye7Iy9qdYGUDb+/aA9RfbtOE9GKdHXnuxwD7VTT5Wsr2DwWjHxKefpqBJY
         +7tqdCMYKvTUmaJo7CfdrsN1M6Iw3OgC50FMRHlD+/T6jwX0kax3ZoLW9YlVSYUOjDkr
         VOQ4AqPMTjYURGw2jSXx6itycqMn6/8NXOlpeoFH76AyLXJfOoVGViZJKXg6sV43djE+
         MKKQ==
X-Gm-Message-State: AJIora/lJIxpMlAfopuauahbolXV1EPwRIJjHqiFHFAo7lcxwyAqTVIo
        NZZFryXtrXJoroivORFyr9wRhxxRtnY=
X-Google-Smtp-Source: AGRyM1vqBRQVrT6TUJUFUK5kgHWfZrgH/Pox3xpk7zeJlTAV5RZe6o1hdfy1TmD9IPFIQ71bSiek+Q==
X-Received: by 2002:a05:6402:5306:b0:437:8bbd:b313 with SMTP id eo6-20020a056402530600b004378bbdb313mr14675188edb.123.1656420321414;
        Tue, 28 Jun 2022 05:45:21 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-114-061-215.95.114.pool.telefonica.de. [95.114.61.215])
        by smtp.googlemail.com with ESMTPSA id f13-20020a170906824d00b00726e108b566sm622871ejx.173.2022.06.28.05.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 05:45:21 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        p.zabel@pengutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        vkoul@kernel.org, kishon@ti.com, rtanwar@maxlinear.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 5/9] reset: intel: Allow enabling the driver on "LANTIQ" (MIPS) platforms
Date:   Tue, 28 Jun 2022 14:44:37 +0200
Message-Id: <20220628124441.2385023-6-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628124441.2385023-1-martin.blumenstingl@googlemail.com>
References: <20220628124441.2385023-1-martin.blumenstingl@googlemail.com>
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

Lantiq MIPS SoC use CONFIG_LANTIQ. Allow enabling the Intel GW reset
driver there as well so we can get rid of the reset-lantiq driver in
future.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 93c8d07ee328..68a5ea44612e 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -84,7 +84,7 @@ config RESET_IMX7
 
 config RESET_INTEL_GW
 	bool "Intel Reset Controller Driver"
-	depends on X86 || COMPILE_TEST
+	depends on X86 || LANTIQ || COMPILE_TEST
 	depends on OF && HAS_IOMEM
 	select REGMAP_MMIO
 	help
-- 
2.36.1

