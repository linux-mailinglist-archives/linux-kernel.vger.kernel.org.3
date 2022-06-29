Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D0755F9B5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 09:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbiF2Hxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 03:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbiF2HxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 03:53:12 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE503B3FA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 00:53:00 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id q6so30767189eji.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 00:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=l4c6eL6FkT3F5Q2UMeh1SdTOW/jzEthp0aJ+P51R6LI=;
        b=AV4NEcyHx8w1xqDMI5YOYNDvdZip64G+iNWEh/ZDv5T4AfyWfiY2Dx63X8iNx5c1no
         13qprKhyHd6K9peeLiYqGLkEya2BS+rj5WqWdXb+TucvbalQQ8rv/LTe3MrRoHLkoSCK
         /Xu+4+UUyNHh73MKUWfTNeS4NXOROyPPNjUSHrUiKAWRsxXoMFbkuZuLRExCI6oYQLXJ
         yiCd34hujtJoszLTJsUG/5Ju1lx566hR2GeAhbx1EKXl2VEZIyLKgUFsTYryaOh9QoRN
         WrFoBEwj/gJ6Ok7RIMih29H5y5iOPFtjQmOdFrs1bCIwPVDORL6Y0/z1py1r5jfTaGFa
         85qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l4c6eL6FkT3F5Q2UMeh1SdTOW/jzEthp0aJ+P51R6LI=;
        b=ovjQIs7JP6VDvRaufKyyKrAESkzgLhjjscrAGywyiGMG5Hzg7PN3QkFFUWi9DVznch
         PypPNJnQY8Obf63CW+CFwSMBANQzBkDHbsmH+5Xrstxz0l3ZZMbrwcb0IAD3rHuhEq21
         IbbdmuwiECDgg/aThgysiMB163/yUHQRz4DJkEjv2xKhCxdM6aCTcAtQEb6pFcUqWnBJ
         uiZE/Lm6Ra1ubEnR5x3teVuSmpUgdiIBIcI69sFerAIoNR5ysUQ+YDQpWVJSQdZ/cxm8
         s3+j1ptIQHVZdKhSAbUersDdTkpYS7YKnyA+CsW5F9sdHG9SAqFycUP8Pk9ire5DuWLF
         Byww==
X-Gm-Message-State: AJIora+Ogh43E2yawVifwpDYdmWvb+kS2iVggec3KeR7uJNIDy0ww6Oh
        HXsNNb6V989klpTot3r1CBbsTw==
X-Google-Smtp-Source: AGRyM1tMc7nBQ3SvkzcyGP9WZi4dulRVf6CGwCKOxfFwJ6EBO9vmDI5R4xCDDINWYm2Rk8hIPhTkUA==
X-Received: by 2002:a17:906:20c6:b0:716:646d:c019 with SMTP id c6-20020a17090620c600b00716646dc019mr1901895ejc.529.1656489179257;
        Wed, 29 Jun 2022 00:52:59 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id t2-20020a056402020200b00437db6acaeesm432173edv.95.2022.06.29.00.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 00:52:58 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 3/4] arm64: defconfig: enable Qualcomm Bandwidth Monitor
Date:   Wed, 29 Jun 2022 09:52:49 +0200
Message-Id: <20220629075250.17610-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220629075250.17610-1-krzysztof.kozlowski@linaro.org>
References: <20220629075250.17610-1-krzysztof.kozlowski@linaro.org>
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

Enable the Qualcomm Bandwidth Monitor to allow scaling interconnects
depending on bandwidth usage between CPU and memory.  This is used
already on Qualcomm SDM845 SoC.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6906b83f5e45..6edbcfd3f4ca 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1096,6 +1096,7 @@ CONFIG_QCOM_SOCINFO=m
 CONFIG_QCOM_STATS=m
 CONFIG_QCOM_WCNSS_CTRL=m
 CONFIG_QCOM_APR=m
+CONFIG_QCOM_ICC_BWMON=m
 CONFIG_ARCH_R8A77995=y
 CONFIG_ARCH_R8A77990=y
 CONFIG_ARCH_R8A77950=y
-- 
2.34.1

