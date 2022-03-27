Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268274E890E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 18:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbiC0RBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 13:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236126AbiC0RBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 13:01:25 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4662E4D636
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 09:59:46 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id p12-20020a05600c430c00b0038cbdf52227so7199852wme.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 09:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4dHculRAI2T1sdBQuUCuijr3MsMNFpwYgNhV4UVBo28=;
        b=dGEfnIpxH7NETyD6jMggdWVlUItaxdC6Sa1P3MX9M9phQ/WFxnobiOMzyxs/Nd1hZH
         IHZsMJeV3JmCU+CPHg0AwfMCIX0eFpltuSfYmJZANz+dd7kiKjb1FfuHFEQrbsMRLQPB
         dI0kCQ+VaZOdYwlGHIREjg9SQMgR9Fg/f+G6/eas47WKjPNes43TNbBvBWE9pd8HebAE
         A8UE47KXwoLzqbDlu1321k7wagdGvoceKQmC1AluHRtCtCGrXfdMYGijdQzS/pWUmdQQ
         yE0yQ2TyyThSobsQ5t9m1gg/sWXVC+9pbIIgYh4M5i9yPXCM4IfdV/IHYjlIWy/+Sn0m
         LcPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4dHculRAI2T1sdBQuUCuijr3MsMNFpwYgNhV4UVBo28=;
        b=RYocMSw4cHzOgN0M9EnDqwq+D5ndHdm1VZ4aJYrbyyosFo7pNzNpNLpW3/hh8r/Ncw
         uu85nntUOxAiGPDib5w8EXv8Nxo6N+WESUC09yzra4qF7vEQswexWjn6wkmvSW4PXriZ
         laOJ1DM9YMowT3iZ7XJeBPvNOJJHzYY9OhuoDfSdXXn2fjMTPju3oGs//g06jrPkn+0F
         ihoOVXWEhUNX5ldTMg1OLM0nNTQwNNjAqj/4h5M+4iNbRAQuu/QFc0E5ecTBUc8lZkVL
         KlZzikvtB+00fP6Lf8h9LRhvyeVMVWfE/m/MqgZ4MFbnFynnoumzSGdttod/m/ivoLf2
         AAgw==
X-Gm-Message-State: AOAM530c34gtCqpn29NU4XeHGHZNibQ8lrt4qzHk5yRZwUvFxjVThI3+
        DaTjQ0/QQEooxuzDSl0lAwrLqKC0OIWA6w==
X-Google-Smtp-Source: ABdhPJzC7L0Pd32AE623df9SYio+x6E6ipqoM2hmzAtWQN10D49PTa8avorj4SAOwUCmgWJKDctbUA==
X-Received: by 2002:a1c:f211:0:b0:381:6c60:742f with SMTP id s17-20020a1cf211000000b003816c60742fmr21224906wmc.130.1648400384729;
        Sun, 27 Mar 2022 09:59:44 -0700 (PDT)
Received: from radium.lan ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id 2-20020a1c1902000000b00380d3873d6asm9979423wmz.43.2022.03.27.09.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 09:59:44 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: defconfig: enable some mt6360 PMIC drivers
Date:   Sun, 27 Mar 2022 18:58:37 +0200
Message-Id: <20220327165837.3048639-5-fparent@baylibre.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220327165837.3048639-1-fparent@baylibre.com>
References: <20220327165837.3048639-1-fparent@baylibre.com>
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

