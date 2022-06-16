Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F9F54D683
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349462AbiFPAyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349093AbiFPAyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:54:03 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C725536E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:02 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id w29so389084pgl.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/8m6MhDbOK9+V515hZszn9vJkAN/TqZqKv8XaJa+cRs=;
        b=CdFncK695RkHcbTK1Pgb3G1/LJP+K0xyx4djSr60w3isPqxCBAtlt5Bpurr+PSknUQ
         cxtMeCi62MyyybzWNvZuhmwpiyLOFlQjCsQxdvzp3u7cW2K39pAueoJKekX5l20j5/2R
         haARQupkGopxcDxbwUhDDQj1+ghfXhOzOtLX62hgt4TpwdYRjozKMqzrSZ+MFeOfCuiK
         yRlhJehTp6hJ90/y1X4gpG1dM9lOLncTbblW+WtR5DpIoSe7s16ukBTXratFvXfoXDeh
         gtWgna+LKcT1ABGMjcuHSauU5QbSFFfootcUx/R16oucPcObhIxWEZT2R+mUO6//LZRI
         PcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/8m6MhDbOK9+V515hZszn9vJkAN/TqZqKv8XaJa+cRs=;
        b=XDMLYAGKERyKNMZNiMvFlqDl4J5XJqYEqYrTAREJ+Pl3aULSDYNECeT26rbwNAJ9f/
         gl+qfgfAG9VsGLAGyijipLZKbF25axaSsAnSR8/OYI2W0pm6QAZajQmTiEb1tI23i1ce
         R7BMorwtpal42nhTpjSW6hI3Gnc44BlmFdiLP6X2LHWlYhfki4asz1697hmbgPwngxKE
         WjDa4/bWDrDH/sT865y95haouqOWTE/fcDQdfflcnU17KSE3KINhiri2BfuiNNUjBhtz
         QVPdNxFj+/S1x12wTKFjD5DSm9CiDdMOjbKA/+L6mY6vxZ0cr2o9EK9HgGR6O7jF40U3
         r6Bw==
X-Gm-Message-State: AJIora/zXhJaXFgbGtAIeWaB/n3PTuN8ey+BJTKzIV4j2TKnOh0xMH4m
        fbNCwron3NFCFzusHvtYnlvfrg==
X-Google-Smtp-Source: AGRyM1t6yfuLylrv3e4vYfkN0h1NUNBGLQps1pD5oFMNcHJ/nnCL14mq2T5En49fwPDsRha7e3GmzQ==
X-Received: by 2002:a05:6a00:1da5:b0:522:cb12:549b with SMTP id z37-20020a056a001da500b00522cb12549bmr2135800pfw.81.1655340841637;
        Wed, 15 Jun 2022 17:54:01 -0700 (PDT)
Received: from krzk-bin.. ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016760c06b76sm233660pll.194.2022.06.15.17.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:54:01 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 05/40] arm64: dts: apm: correct gpio-keys properties
Date:   Wed, 15 Jun 2022 17:52:58 -0700
Message-Id: <20220616005333.18491-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpio-keys children do not use unit addresses.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/apm/apm-merlin.dts  | 2 +-
 arch/arm64/boot/dts/apm/apm-mustang.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/apm/apm-merlin.dts b/arch/arm64/boot/dts/apm/apm-merlin.dts
index 217d7728b63a..049e7a5edca7 100644
--- a/arch/arm64/boot/dts/apm/apm-merlin.dts
+++ b/arch/arm64/boot/dts/apm/apm-merlin.dts
@@ -22,7 +22,7 @@ memory {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		button@1 {
+		button {
 			label = "POWER";
 			linux,code = <116>;
 			linux,input-type = <0x1>;
diff --git a/arch/arm64/boot/dts/apm/apm-mustang.dts b/arch/arm64/boot/dts/apm/apm-mustang.dts
index e927811ade28..efac50aeca64 100644
--- a/arch/arm64/boot/dts/apm/apm-mustang.dts
+++ b/arch/arm64/boot/dts/apm/apm-mustang.dts
@@ -22,7 +22,7 @@ memory {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		button@1 {
+		button {
 			label = "POWER";
 			linux,code = <116>;
 			linux,input-type = <0x1>;
-- 
2.34.1

