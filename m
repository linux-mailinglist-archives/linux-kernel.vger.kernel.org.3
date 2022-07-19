Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01ED579614
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbiGSJSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237199AbiGSJSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:18:11 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270ED2612B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:18:08 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id n12so7795864wrc.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=71TlD2VyblxTnCcd8MbBLG5/3iBaeSN8BsgIQzsv+OA=;
        b=aaAxVJ9MRXtu56qNnJ5XQpfX7bCv+BlqgAUksFb1lvMNgpFM3QNa+CBdCpuiE6bFQN
         RjHqTLbsm4BoV8qOmAcgZ8eoxbiBrdBb96bSvSXSjNtORANhEC3FpdjLN07FYhWp/6jf
         7zLGBUHbzt/2ktdztEsI7b/nDEPW6PTp37h59yvMfO4apNfKrQW98/3tSy/T3gsiFJpn
         H713JPYt7TnWcG9EaRydQZWTYff0jy4E7Ig6ocm6VpWeL0akyTLvobGXK2pSuwvtrnhw
         ibB6js1DJQlsG1PzhH7sbqgpQx8tXgJMpJ1Sp/e/j8I9Eup50PApPWDBQhP1tNW2/Kec
         nxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=71TlD2VyblxTnCcd8MbBLG5/3iBaeSN8BsgIQzsv+OA=;
        b=XYUOjP21Scpo5KdkbqnD/Exc0izblXDaAS833nQyHvkwxvjjVCDGgZ8H56aPXL4JYg
         KeZiQkCJB4bGehcN7zxYHbNepA5uWX8bNKPsZdodEDLkOsDBJD1JR3EnX/ACoUdkKLfL
         MMXdRrbSdvzkrZ4z8Guwb+VfJOBKbZ+lqFeafg5yIDttNp2cBKgTRpz7HL8h8kzp6QTq
         iqtcbCJop8sAyJpn6pbKAht5DzmRQWM+J9fxoAtOeCsL6ZyQil3AIe50ZOLkSI8SizQ1
         8yGL8iWicglYrwMsql063LWfbzDDcmlp+sxfG6G0OYsN/hHgkLvsCadq3Ra6OQpBYDyb
         CgBg==
X-Gm-Message-State: AJIora9vG5UdwKBVZx0BOR5w3TOp5q/WMVvUK1abQ/BB3Y5X62Klu9Kz
        +8tMwn5eSmZPjDqA90NMIlKL2g==
X-Google-Smtp-Source: AGRyM1sAEcvApB7e3HJq4boK0jYk+wPampNFyqR5u9LQvw5R8LdxeHaYlCjZiRVeHtlt3L2PX6l4qQ==
X-Received: by 2002:adf:d1c1:0:b0:21d:be64:5539 with SMTP id b1-20020adfd1c1000000b0021dbe645539mr24649559wrd.473.1658222286654;
        Tue, 19 Jul 2022 02:18:06 -0700 (PDT)
Received: from localhost.localdomain (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id bk19-20020a0560001d9300b0021d63fe0f03sm12944281wrb.12.2022.07.19.02.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 02:18:06 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org
Cc:     khilman@baylibre.com, narmstrong@baylibre.com, msp@baylibre.com,
        j-keerthy@ti.c, lee.jones@linaro.org, jneanne@baylibre.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 10/14] arm64: defconfig: Add tps65219 as modules
Date:   Tue, 19 Jul 2022 11:17:38 +0200
Message-Id: <20220719091742.3221-11-jneanne@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220719091742.3221-1-jneanne@baylibre.com>
References: <20220719091742.3221-1-jneanne@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds defconfig option to support TPS65219 PMIC, MFD and Regulators

Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7d1105343bc2..f031dd6a9f76 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -641,6 +641,7 @@ CONFIG_MFD_SPMI_PMIC=y
 CONFIG_MFD_RK808=y
 CONFIG_MFD_SEC_CORE=y
 CONFIG_MFD_SL28CPLD=y
+CONFIG_MFD_TPS65219=m
 CONFIG_MFD_ROHM_BD718XX=y
 CONFIG_MFD_WCD934X=m
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
@@ -668,6 +669,7 @@ CONFIG_REGULATOR_QCOM_SPMI=y
 CONFIG_REGULATOR_RK808=y
 CONFIG_REGULATOR_S2MPS11=y
 CONFIG_REGULATOR_TPS65132=m
+CONFIG_REGULATOR_TPS65219=m
 CONFIG_REGULATOR_VCTRL=m
 CONFIG_RC_CORE=m
 CONFIG_RC_DECODERS=y
-- 
2.17.1

