Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6425A2499
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343872AbiHZJh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343980AbiHZJhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:37:17 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5B098D24
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:37:16 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id m5so1291171lfj.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Rtt6I8OWylHlnxQVoWRkuUmUkB38DHKDhrC1yMa3aN8=;
        b=W8+o0pPJmi+uAWge1iUcu/iV4O0ElsGBu8FBCkWteGM/sZqivBYxv58UBZz+fyRRSp
         HXPHviTq0ENypF6lrC71dVX2b8D9q+Ej6tjgkWNs7yGfdPPkXZrFkOk7BtFKKIQvDhxJ
         MMyDVrtYd6X23MzfCvmaE0nBqt0eoI4QiEgHnG/8PhR3l5FFUfa2lHIzZOWTkGwIF0WA
         doVam2Tn6I2HKMpoJ66nQtywK1rMhfN84A3Y+o2oG+2NSioCUQ/+P4C9BoFFdG1aVGwV
         dHmLqTaTzmNy7u/cWfnFQlV6BB5hmY0eFdHGS3x/obpBwmwoJGXbqOebCvFvN9/ibQCT
         ScSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Rtt6I8OWylHlnxQVoWRkuUmUkB38DHKDhrC1yMa3aN8=;
        b=0GxKuOomH/C/r5MVXS4fGXL7a5WSC3+7sXjiQX8H3+5xl05OtJ0oUn/i6vmeu76KNB
         7OgGgB/bhT4bgsDNrC43YEBZ5xtiFAGX/gkFA9eI4+nIR7CJfLI4OybY8nMlDCrmGIdO
         vYwkbTfppzBzW8Yqcnd92oOTDfUnkQxT3GML0zIfrhzqBqVVLsKAQiDd+NJw1JKKMRUu
         umMbnO+snyGdHG9eWST4SNdaDIVeQnDp3La4hpamJo2bBiu/k4pM+VbVwez9e3VNbVXT
         XDwobLGcW5ov4YZieHBq3051afuFEbG1qCVIVKQjUpjbrnG7W45hfTlkffYvHoOAXQm9
         kv1w==
X-Gm-Message-State: ACgBeo3ATCYTNWa1ccVMJihuY6Nk+RaeDRd7EjakKtNPkXdZJeulozaU
        M/N0f7wLKsmspPkkaz8xR9qbFA==
X-Google-Smtp-Source: AA6agR7tdipdx6OYxvNpdG2tIX82dtvaUbyVs+VyV/UcfBX9DMk0QPV7We0gpWr/h4R/fpdtYRNDnw==
X-Received: by 2002:ac2:4e07:0:b0:492:d129:e019 with SMTP id e7-20020ac24e07000000b00492d129e019mr2471974lfr.350.1661506634894;
        Fri, 26 Aug 2022 02:37:14 -0700 (PDT)
Received: from krzk-bin.starman.ee (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id y13-20020a2e828d000000b0025e4e7c016dsm400579ljg.16.2022.08.26.02.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 02:37:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] slimbus: qcom-ngd-ctrl: allow compile testing without QCOM_RPROC_COMMON
Date:   Fri, 26 Aug 2022 12:37:11 +0300
Message-Id: <20220826093711.1059319-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm common remote-proc code (CONFIG_QCOM_RPROC_COMMON) has
necessary stubs, so it is not needed for compile testing.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/slimbus/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/slimbus/Kconfig b/drivers/slimbus/Kconfig
index 1235b7dc8496..2ed821f75816 100644
--- a/drivers/slimbus/Kconfig
+++ b/drivers/slimbus/Kconfig
@@ -22,7 +22,8 @@ config SLIM_QCOM_CTRL
 
 config SLIM_QCOM_NGD_CTRL
 	tristate "Qualcomm SLIMbus Satellite Non-Generic Device Component"
-	depends on HAS_IOMEM && DMA_ENGINE && NET && QCOM_RPROC_COMMON
+	depends on HAS_IOMEM && DMA_ENGINE && NET
+	depends on QCOM_RPROC_COMMON || COMPILE_TEST
 	depends on ARCH_QCOM || COMPILE_TEST
 	select QCOM_QMI_HELPERS
 	select QCOM_PDR_HELPERS
-- 
2.34.1

