Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90350502C3E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354789AbiDOPD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354788AbiDOPD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:03:56 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51786AACB5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 08:01:28 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id u17-20020a05600c211100b0038eaf4cdaaeso7920502wml.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 08:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j0vnaKGxmv5JfYEKM5Bm4tqmu20hS3lgUguCbFOzoU8=;
        b=Aw60U+AxFr5ae1fP0IpaNSJWX8/bPiZtH5VfPVop0FZHr53WY4hZXtXAKPJSArfPH2
         xgqe8qUM1DokOD7cJ31F4vPKVi/+TwWnS/gs2irgt5pOdTJ+cEvBg+EVJWYPF7KJkUHw
         hUKFd+cF+Dsmig+l+9a5MELvhWloS44Ll+O7A1NZ8jVHnnLWfWdffFNqfwwaMlEt6nmv
         No3laHS1zcgC3hzCKVfw2Tz2YPMr3Tht0yzi6+Z2TaX0VkkuCUrIBGFjNeKSHdaWBua4
         L6Uk6pke8jRiD6YK5bKtH8snkjGDeGED5F0DSOhhGnJPBtnYSQu2WUAV/uaTPOHBOtxS
         4j4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j0vnaKGxmv5JfYEKM5Bm4tqmu20hS3lgUguCbFOzoU8=;
        b=q89SUA2nupjkpH8yX9RqwpJukR8SGbJVJxqsgFz9SwsIUgsF5WsosvtWcUxbFAGXCK
         rkPdEbUh9DVsxwBQ+u9OkcrWANu6PWcrfi9rAObd5SlSc3RU6Go/SbKXuN+eLQ/mBU5z
         cUu0A72jRivU7vS2WWsTa3IM9dMyMd4V9vLTW7BYXZG5qqNlha3B97MjzoHNpucTu1cr
         y/f8QRhmdxQKadkBLOwcw5+WeDbQIc/DK0HxEq1jyL67kCH1BqlenPujTOOM3hM3YR/L
         pkGR3SKrgPozgM1QSCjc6aL5Zh3bKi8IgNth6v+sMtBXGia4td4LtchKMba9r3JorGi/
         g5BQ==
X-Gm-Message-State: AOAM530d+dX/r6a3P+999nUuO9Bn6QTaBvetEYSO+wqPHJ0HPI7H3tBp
        KiNnVYc1QKgZXM7k0viz9lLyGoUDSRz/Ng==
X-Google-Smtp-Source: ABdhPJyIDFZhXfMb5NDUQ+PJx1ThOwc70zKh0UxZUkNz38TTnVnb/WRpbNmjQV4mVGVHF6LWMRQkIQ==
X-Received: by 2002:a1c:1981:0:b0:392:4dd9:b5ec with SMTP id 123-20020a1c1981000000b003924dd9b5ecmr591483wmz.149.1650034886920;
        Fri, 15 Apr 2022 08:01:26 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id n2-20020a5d6b82000000b0020a7e34ef20sm1579664wrx.47.2022.04.15.08.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 08:01:26 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] arm64: defconfig: enable some mt6360 PMIC drivers
Date:   Fri, 15 Apr 2022 17:00:03 +0200
Message-Id: <20220415150003.1793063-5-fparent@baylibre.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220415150003.1793063-1-fparent@baylibre.com>
References: <20220415150003.1793063-1-fparent@baylibre.com>
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
v3: no changes
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
2.35.2

