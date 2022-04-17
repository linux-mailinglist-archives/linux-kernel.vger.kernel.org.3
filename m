Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A21650498F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 23:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbiDQVHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 17:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbiDQVHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 17:07:25 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8951C299;
        Sun, 17 Apr 2022 14:04:46 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id n33-20020a17090a5aa400b001d28f5ee3f9so951344pji.4;
        Sun, 17 Apr 2022 14:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H5PLHpOPu/P0/D/ENQErcFm5UdYHzQLJAeVelvf+H+M=;
        b=n1TRzbeLZAYMlhU0G+JJLiIYuspf83z2OOPf3epr7pi0hRmIu62AGSi6ewyF2XTGMX
         5FnINtTnyfHHKjWHWaDko6U05BTcX0O/+VRPYuQDmUTDpZ+lgOGLX/vsOnZe1JxLeEaN
         W6QT7AsH+M45//5TdSYJWiquMnCQhJem0kw50cOtzUNEJi5c6mfe85Z0tdmSPeL2Nzba
         p+vMYhSrIiwsDhmEN99fOzIv8579qPSA2aroR9Za8sdYJY2JR2tlXX+JWlZx7d28hIqa
         4BF741apyOUJ2zSQc/iBXaqo0s8n3y7ZR+KJop/x79i4xXL8wcjjhFq14FEl1QQcxn3C
         smxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H5PLHpOPu/P0/D/ENQErcFm5UdYHzQLJAeVelvf+H+M=;
        b=mxv82SeNEz4Ux3uQpLzj5a0o+bp/5SKdMc477Hqi9aWglYGZULmTRYO9ik/9G7Z3nj
         nwJp99eZqIPMIhg320CsO4k+32HYoTSgW4fu8jJlXdbiioW149F9kKiY75rcCKPvGvyc
         MXFEZJNjZpkyaI9Grwt5gCe1Rq7PkCBg71Ae+34oHkyIDDQ8fYZvbBIf9MF1yPO3A3N9
         cmguObJfKd/ENSAl+yoK6KzFnPo0a4k/QHv09rrfOvGhAGXPe29qTTY1+1rtwCGg9qC2
         8Sm6c8G2J1HGUJ+Q+dVDmU8lZLbRv+aCterflRW/sFZkAsb261IUtEqBlPhblZrsCMO2
         WW2w==
X-Gm-Message-State: AOAM530NTBROcgsCVK7pULSDpeMJ0DtrXElTAdU5I8M7LM7qzkeeIyMT
        2b97+ZkhFmdH4HVIoyEewMNYc27j41A=
X-Google-Smtp-Source: ABdhPJw9i20+9CtCx8moPCH918q3/p6xIHAZRiHcHEgP1U8rRGvB1ESNS+kGz0/NaEv1MhwrnG/Okg==
X-Received: by 2002:a17:902:e84d:b0:158:cd1b:8168 with SMTP id t13-20020a170902e84d00b00158cd1b8168mr8028035plg.43.1650229485896;
        Sun, 17 Apr 2022 14:04:45 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id 137-20020a63078f000000b0039d9c13cd39sm10547711pgh.67.2022.04.17.14.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 14:04:45 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 1/6] ARM: dts: qcom: apq8064: User generic node name for DMA
Date:   Mon, 18 Apr 2022 02:34:31 +0530
Message-Id: <20220417210436.6203-2-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220417210436.6203-1-singh.kuldeep87k@gmail.com>
References: <20220417210436.6203-1-singh.kuldeep87k@gmail.com>
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

Qcom BAM DT spec expects generic DMA controller node name as
"dma-controller" to enable validations.

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v3: Add Krzysztof R-b tag
---
v2: No change
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index a1c8ae516d21..b2975be3ae04 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -1040,7 +1040,7 @@ sata0: sata@29000000 {
 		};
 
 		/* Temporary fixed regulator */
-		sdcc1bam:dma@12402000{
+		sdcc1bam: dma-controller@12402000{
 			compatible = "qcom,bam-v1.3.0";
 			reg = <0x12402000 0x8000>;
 			interrupts = <0 98 IRQ_TYPE_LEVEL_HIGH>;
@@ -1050,7 +1050,7 @@ sdcc1bam:dma@12402000{
 			qcom,ee = <0>;
 		};
 
-		sdcc3bam:dma@12182000{
+		sdcc3bam: dma-controller@12182000{
 			compatible = "qcom,bam-v1.3.0";
 			reg = <0x12182000 0x8000>;
 			interrupts = <0 96 IRQ_TYPE_LEVEL_HIGH>;
@@ -1060,7 +1060,7 @@ sdcc3bam:dma@12182000{
 			qcom,ee = <0>;
 		};
 
-		sdcc4bam:dma@121c2000{
+		sdcc4bam: dma-controller@121c2000{
 			compatible = "qcom,bam-v1.3.0";
 			reg = <0x121c2000 0x8000>;
 			interrupts = <0 95 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.25.1

