Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54FF4E89EC
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 22:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236553AbiC0UFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 16:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236606AbiC0UFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 16:05:43 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EF21262C
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 13:04:03 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d7so17560792wrb.7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 13:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iJbD7GeiV3igl6VNguRP5qJL5l5Nl/axoFONn8QJIfU=;
        b=fEMDx2bCuxS4Zm8LB3F3FJphxpSoTBI7fBsMmIAkzSS+RhLEApfcfzASulW3rvHIUj
         Fzc9L04NYrob1El3aZndJkZyXdVJzx7iwUbU0cI2KWZZVnlBM468nPoKdO+Cyr1zb43F
         QmUtpU4piIotMa3dnw/TmJCwWy5cWRiGC1TmHYqas8lHbRAj6hmaCiHMKVSx6BZdI6YC
         JHVsuspeV7Re/SeDKLFjkULD6A3TfGopFlIkwDU2yfG7eBDP5sT9fL0Y8nP90rEI2JIJ
         x6KKz0wcDB+7BahOWyOjLej77CpOgieONpyiP/JpNj12eLkT1q4SA1+zgO37qsxjjtGC
         JgBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iJbD7GeiV3igl6VNguRP5qJL5l5Nl/axoFONn8QJIfU=;
        b=KQRXZrDg0ax/ylOK3OMgPfsy88UcdIAl5PNPHrQVi4olLR0C9ARW5XHbR6A9uku3pQ
         vqn/Me38fbYXTyJEQedHaKD4Uv4MjH7mj6Ta0w+MD8NqbBGzpErlQQlOQ4mc4NQs8Jey
         aDT0KKcB3M5hkdVsKRHcAAcwL1mstao/H4+VkQOtMc6wVXqKqgbfoICn5Gx06HZncPFb
         Wk6prZbjyyuoxHf8omnR/UOYWLHknHSSDTcvJ24y95mH9oJolLfky+FqvjG4us2k/PL0
         dggRrSpHnm04JKsmD+rZTlMZt4N5BPaDxqJFWPaUMcyl0xDzDg0zV/SDWAcbJ3oqEKQB
         znvw==
X-Gm-Message-State: AOAM530PHX8jR/xHxuiEN7pYCrlpZNxuoFqWXP/NzZB0fd40Yeqt7zio
        GMFfUlarUV1C/goLOgvFHpLT8w==
X-Google-Smtp-Source: ABdhPJx9fDpUw9UHjouZ5xNgvBdvHwpAvG/dOlQFuld3IFFhBQo3mpP4z82x+04LskxTKLhhh2Z1Hg==
X-Received: by 2002:a05:6000:1e19:b0:205:94ac:34d3 with SMTP id bj25-20020a0560001e1900b0020594ac34d3mr17030169wrb.200.1648411441890;
        Sun, 27 Mar 2022 13:04:01 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b0038d06cc21b2sm1354555wmg.35.2022.03.27.13.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 13:04:01 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] arm64: defconfig: enable some mt6360 PMIC drivers
Date:   Sun, 27 Mar 2022 22:03:12 +0200
Message-Id: <20220327200312.3090515-5-fparent@baylibre.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220327200312.3090515-1-fparent@baylibre.com>
References: <20220327200312.3090515-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the charger and regulator driver for the
MT6360 PMIC. These drivers are essential for
some MediaTek MT8195 based boards to boot properly.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
v2: no changes

 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 1e521f17cb39..3848246f6727 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -565,6 +565,7 @@ CONFIG_SYSCON_REBOOT_MODE=y
 CONFIG_BATTERY_SBS=m
 CONFIG_BATTERY_BQ27XXX=y
 CONFIG_BATTERY_MAX17042=m
+CONFIG_CHARGER_MT6360=m
 CONFIG_CHARGER_BQ25890=m
 CONFIG_CHARGER_BQ25980=m
 CONFIG_SENSORS_ARM_SCMI=y
@@ -625,6 +626,7 @@ CONFIG_MFD_EXYNOS_LPASS=m
 CONFIG_MFD_HI6421_PMIC=y
 CONFIG_MFD_HI655X_PMIC=y
 CONFIG_MFD_MAX77620=y
+CONFIG_MFD_MT6360=y
 CONFIG_MFD_MT6397=y
 CONFIG_MFD_SPMI_PMIC=y
 CONFIG_MFD_RK808=y
@@ -645,6 +647,7 @@ CONFIG_REGULATOR_MAX8973=y
 CONFIG_REGULATOR_MP8859=y
 CONFIG_REGULATOR_MT6358=y
 CONFIG_REGULATOR_MT6359=y
+CONFIG_REGULATOR_MT6360=y
 CONFIG_REGULATOR_MT6397=y
 CONFIG_REGULATOR_PCA9450=y
 CONFIG_REGULATOR_PF8X00=y
-- 
2.35.1

