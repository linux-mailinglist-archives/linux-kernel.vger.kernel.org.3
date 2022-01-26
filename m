Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5AE49CB9C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241756AbiAZNy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241821AbiAZNyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:54:41 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CE1C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 05:54:40 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id n8so27733767wmk.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 05:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BnDmn/bGiXHzA/HR2vbnCnaA9xu9dPUN92kb7gNI0E8=;
        b=RiTu8S4Ln7+O0WBUqkkUsl7/Y8RGgsnBr2QEGirlJGd5zv/J2sKYcCOIKi43UG0OIv
         huxteankWCJT7bWllcRYrm7tlbM+644kIo9Gl2UfI3aj4ihrfuygcZnp8WYhX41Y6OK1
         q69MJ9QVDRNA1v1eaGcQfOJrX9hqUKCjqwJFyr5W6b6ZaBUlhRweBkfU8XTq4AnE0AYx
         2+qbazic7fNyaLMuzM4COM9Y7imeMx1cMQTmjHHno7X0fvDgpgtnWsSLQY8sTjjP9vif
         6JVJ+tA9loPtnaHRAZ+8UnJ/uLRT1rzYOsQMCyr7eXO0Llk0BTRW171515gVHCvaE+vk
         xSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BnDmn/bGiXHzA/HR2vbnCnaA9xu9dPUN92kb7gNI0E8=;
        b=QapaI5smvEo+xMyPldlCP2roJDHyaJ7/SN62WjkCpVGiJCZCQ5ZKkpSXk9SsdHGEle
         GGVydREYcgXJo3PdtBb2qq2ySY5i4bfgowWPlgRaj6XSeQuNXGlcFa4oPhixMhRvhsJa
         lMx00p49y83Dc6pdCt+zcvuQ+9ZirVti4p5CmLUajYxbL7awpOAE/LFWAU6WgjfvI+zf
         zbQ81y72CAn9KhLWp2D74Sbve5K7kgATjDmIrdEe2uWUdq4baepBINbhQiYFHpmmHRWz
         Y+AJMG+Mzdr1yxAygQ0pEMHU9Vdkgtd2LM9vIok9y/f5ZqiJAYiHQ9wMpa8bycOwhGFz
         pRoA==
X-Gm-Message-State: AOAM533t7yYeaHrS7506ce4UlG0pYLnUwvOftZelWPWG3D5h5C2a2qZY
        y2VP3Ny9Pl6LJOVfJ2B8pSz1LQ==
X-Google-Smtp-Source: ABdhPJyel63/sPQgccttrP2TI12+cJQazZbJYZemZWsjq8GWdGcvGhyZNBoQMvKbAPIMSpCJumUbPw==
X-Received: by 2002:a7b:c401:: with SMTP id k1mr7506568wmi.67.1643205279377;
        Wed, 26 Jan 2022 05:54:39 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id n15sm3356593wmr.26.2022.01.26.05.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 05:54:38 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, ekangupt@qti.qualcomm.com,
        bkumar@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        srini@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, Jeya R <jeyr@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 12/12] arm64: dts: qcom: add non-secure domain property to fastrpc nodes
Date:   Wed, 26 Jan 2022 13:53:04 +0000
Message-Id: <20220126135304.16340-13-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220126135304.16340-1-srinivas.kandagatla@linaro.org>
References: <20220126135304.16340-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeya R <jeyr@codeaurora.org>

FastRPC DSP domain would be set as secure if non-secure dsp property is not
added to the fastrpc DT node. Add this property to DT files of msm8916,
sdm845, sm8150, sm8250 and sm8350 so that nothing is broken after secure
domain patchset.

This patch is purely for backward compatibility reasons.

Signed-off-by: Jeya R <jeyr@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 1 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi  | 2 ++
 arch/arm64/boot/dts/qcom/sm8150.dtsi  | 3 +++
 arch/arm64/boot/dts/qcom/sm8250.dtsi  | 3 +++
 arch/arm64/boot/dts/qcom/sm8350.dtsi  | 3 +++
 5 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 41897eb3736a..a1543012c4fa 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1370,6 +1370,7 @@
 					compatible = "qcom,fastrpc";
 					qcom,smd-channels = "fastrpcsmd-apps-dsp";
 					label = "adsp";
+					qcom,non-secure-domain;
 
 					#address-cells = <1>;
 					#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index cfdeaa81f1bb..c9d613063966 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -838,6 +838,7 @@
 				compatible = "qcom,fastrpc";
 				qcom,glink-channels = "fastrpcglink-apps-dsp";
 				label = "adsp";
+				qcom,non-secure-domain;
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -888,6 +889,7 @@
 				compatible = "qcom,fastrpc";
 				qcom,glink-channels = "fastrpcglink-apps-dsp";
 				label = "cdsp";
+				qcom,non-secure-domain;
 				#address-cells = <1>;
 				#size-cells = <0>;
 
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 9255982adb69..637c6a6d4054 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1755,6 +1755,7 @@
 					compatible = "qcom,fastrpc";
 					qcom,glink-channels = "fastrpcglink-apps-dsp";
 					label = "sdsp";
+					qcom,non-secure-domain;
 					#address-cells = <1>;
 					#size-cells = <0>;
 
@@ -2997,6 +2998,7 @@
 					compatible = "qcom,fastrpc";
 					qcom,glink-channels = "fastrpcglink-apps-dsp";
 					label = "cdsp";
+					qcom,non-secure-domain;
 					#address-cells = <1>;
 					#size-cells = <0>;
 
@@ -3442,6 +3444,7 @@
 					compatible = "qcom,fastrpc";
 					qcom,glink-channels = "fastrpcglink-apps-dsp";
 					label = "adsp";
+					qcom,non-secure-domain;
 					#address-cells = <1>;
 					#size-cells = <0>;
 
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index c97ea638f6aa..3be4e630c2fe 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2594,6 +2594,7 @@
 					compatible = "qcom,fastrpc";
 					qcom,glink-channels = "fastrpcglink-apps-dsp";
 					label = "sdsp";
+					qcom,non-secure-domain;
 					#address-cells = <1>;
 					#size-cells = <0>;
 
@@ -2659,6 +2660,7 @@
 					compatible = "qcom,fastrpc";
 					qcom,glink-channels = "fastrpcglink-apps-dsp";
 					label = "cdsp";
+					qcom,non-secure-domain;
 					#address-cells = <1>;
 					#size-cells = <0>;
 
@@ -4429,6 +4431,7 @@
 					compatible = "qcom,fastrpc";
 					qcom,glink-channels = "fastrpcglink-apps-dsp";
 					label = "adsp";
+					qcom,non-secure-domain;
 					#address-cells = <1>;
 					#size-cells = <0>;
 
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 53b39e718fb6..a9a11c747a3a 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1996,6 +1996,7 @@
 					compatible = "qcom,fastrpc";
 					qcom,glink-channels = "fastrpcglink-apps-dsp";
 					label = "sdsp";
+					qcom,non-secure-domain;
 					#address-cells = <1>;
 					#size-cells = <0>;
 
@@ -2065,6 +2066,7 @@
 					compatible = "qcom,fastrpc";
 					qcom,glink-channels = "fastrpcglink-apps-dsp";
 					label = "cdsp";
+					qcom,non-secure-domain;
 					#address-cells = <1>;
 					#size-cells = <0>;
 
@@ -2367,6 +2369,7 @@
 					compatible = "qcom,fastrpc";
 					qcom,glink-channels = "fastrpcglink-apps-dsp";
 					label = "adsp";
+					qcom,non-secure-domain;
 					#address-cells = <1>;
 					#size-cells = <0>;
 
-- 
2.21.0

