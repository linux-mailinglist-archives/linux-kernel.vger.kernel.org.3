Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380DF58114D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 12:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238845AbiGZKfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 06:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238826AbiGZKfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 06:35:01 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1888D32BA7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 03:34:39 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h9so19580816wrm.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 03:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q0bfqfMqQSJcpc1+aVCgnjanNpycrzNmDHTHeEFNbZk=;
        b=EmeuLyhmsZNzNUv7RzZOqLrwRAPQz1WuCf4Rl4rq9RMQLCx93o3CtNv86xX9ZEODAq
         Euc+LAFz041qUTdDZABB8xxgSZyj0Jb1S//oWrWNo3ur3Qr6YUWVP+iijN9+etDA24PX
         hS/X4tVLPMGD7iCSNh6Y/wDEac8JK7Aj9D8XnWNKpbJsBBRXuO+G/VyD5goeao5FjJPv
         +NA3MJfWj/uOl8Pe4OAkGJzeVgSiPI6X5vqMCr7AGeq/0ooXLgcbkMszyhVtTnSRbSSq
         3Oe6UlAFnxASeB2zasE2H+vMGHM30nwPlICiEkXw9ftZ4uLM0UweOzznqrw/HpVsVpeT
         hwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q0bfqfMqQSJcpc1+aVCgnjanNpycrzNmDHTHeEFNbZk=;
        b=gaJdRtN1+RXeUc7zK5Iruo+Rg5Wwlu2WwWrZi+3voHM9bcidsVqGsPOVI26UPTM1U/
         7WYRAop7aj7IxYpYks4tiEqwlhD+Alm2pJ/+nIs5rjRuIWouzYi4vktVRWRzLULwGFZ4
         9aalsoePArC8wKxAee66gPiSxqqABhECeZXekyigWItQcZH7MKNUvUJKjDJ8BUPomCiD
         ALGzt6mRiMeevat5YnRh1uhkl7FOrsJYXiPL77ARTM2n5yViz+ZfLSDy7JrfP1NF1/L8
         sE2JUJeXP97VQEZO3exyX1bkif3/8nzKjqc6c5BYZV8eV6YG/kewuYIXq6II1KwE2D+l
         wOKQ==
X-Gm-Message-State: AJIora8h+cFILLpCkt1vvQBIG5vTmy0w2A7ZMyaMcHXB/T3kJ1K+LGOy
        QuRHWr0xeLJ3Sqa3RKukEpiLlg==
X-Google-Smtp-Source: AGRyM1vCxzqwtflK9GM5XrqDCoN/AwmG2s4vgIPxRslovpsQLPXrdBRWKD3WrqtRVVhpgfwSMvmLwg==
X-Received: by 2002:a5d:594a:0:b0:21e:81a6:d713 with SMTP id e10-20020a5d594a000000b0021e81a6d713mr7678169wri.318.1658831678426;
        Tue, 26 Jul 2022 03:34:38 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-4641-6f91-91b7-326a-5d27-a1c3.rev.sfr.net. [2a02:8440:4641:6f91:91b7:326a:5d27:a1c3])
        by smtp.gmail.com with ESMTPSA id ay35-20020a05600c1e2300b003a2e42ae9a4sm20617121wmb.14.2022.07.26.03.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 03:34:37 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org
Cc:     khilman@baylibre.com, narmstrong@baylibre.com, msp@baylibre.com,
        j-keerthy@ti.com, lee.jones@linaro.org, jneanne@baylibre.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 11/11] arm64: defconfig: Add tps65219 as modules
Date:   Tue, 26 Jul 2022 12:33:55 +0200
Message-Id: <20220726103355.17684-12-jneanne@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220726103355.17684-1-jneanne@baylibre.com>
References: <20220726103355.17684-1-jneanne@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds defconfig option to support TPS65219 PMIC, MFD, Regulators
and power-button.

Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7d1105343bc2..988397574e3c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -412,6 +412,7 @@ CONFIG_TOUCHSCREEN_GOODIX=m
 CONFIG_TOUCHSCREEN_EDT_FT5X06=m
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_PM8941_PWRKEY=y
+CONFIG_INPUT_TPS65219_PWRBUTTON=m
 CONFIG_INPUT_PM8XXX_VIBRATOR=m
 CONFIG_INPUT_PWM_BEEPER=m
 CONFIG_INPUT_PWM_VIBRA=m
@@ -641,6 +642,7 @@ CONFIG_MFD_SPMI_PMIC=y
 CONFIG_MFD_RK808=y
 CONFIG_MFD_SEC_CORE=y
 CONFIG_MFD_SL28CPLD=y
+CONFIG_MFD_TPS65219=m
 CONFIG_MFD_ROHM_BD718XX=y
 CONFIG_MFD_WCD934X=m
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
@@ -668,6 +670,7 @@ CONFIG_REGULATOR_QCOM_SPMI=y
 CONFIG_REGULATOR_RK808=y
 CONFIG_REGULATOR_S2MPS11=y
 CONFIG_REGULATOR_TPS65132=m
+CONFIG_REGULATOR_TPS65219=m
 CONFIG_REGULATOR_VCTRL=m
 CONFIG_RC_CORE=m
 CONFIG_RC_DECODERS=y
-- 
2.17.1

