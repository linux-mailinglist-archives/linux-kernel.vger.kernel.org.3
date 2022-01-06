Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0AC486BDC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 22:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244223AbiAFVZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 16:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244183AbiAFVZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 16:25:20 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FD9C061245;
        Thu,  6 Jan 2022 13:25:19 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c66so2692127wma.5;
        Thu, 06 Jan 2022 13:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vdXrDJ4OGgH87kXvidbsh7YMpaWehzM8oiGm13LOrvk=;
        b=lKdzJXQ2qmdGhcNVb1TkFY75kEWKwf0LAD7u+ZY8Zz4S7vGtb+nquBWZaacwgazPuz
         Xb9iJUq//9Rwk97oWhIngqPrrz0vZAIOf2nXxy1c9YrSiBnie6ZnIfxCnQQWf3plR5aI
         tpfWfyVP9KdS6+M9k++DjBCTR1z6yplco6N5X/uXcubda90lfS6O1mWWXoVsZ5V0owbY
         AzC9anubnjG6zSuNfXxHCfKxO6n/n2eohdSRg3hKC7x+VKotctFBkha+yRUqpHvsXG0m
         EElyhrTzgXAXJr5j0YhWTblp8kL1GU6EGYnqS14ZkRX36MGubcTvas++1JMbvGGLg//d
         IuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vdXrDJ4OGgH87kXvidbsh7YMpaWehzM8oiGm13LOrvk=;
        b=zJxqyfIeWao/gXgwJ8Q7l75t831ijZeGiZnkt0ejTh/uusXeko+ROceueaiqwIqOLa
         H29zThXqlvIPyKFlOcUvLCwdnBezFsV97j0mUnqWuLHl2YGhAmj9z647A4XQXHuDopXv
         YzS8/HbfBjU1bh8yFNjB32/z1TjoEIcdLa5OvxH4mRVxdQtvo+Uei0RzYLM+klT9pyJ1
         S5ls6xkHH4xdh5CPP8EBXYc5dD/fNQjXV9AAYmsJYwwo17s9PV7fC5Ewh5RtDAIFjk9b
         Sdr1+OXvcOEo5vkoCLHFHYvFuqzjEnbsGXPsqNZSwRH0So3g57o0V+2KlFjqRlDG4QNR
         Em0Q==
X-Gm-Message-State: AOAM532iQ2bxC+JuNR9xy1W2ricRQxEtD51VJ/PCEZQTrxNqOmqvxeW/
        ZJ+5Re2pJ7IPLeziKFDqRuc=
X-Google-Smtp-Source: ABdhPJy2Zt6YIbjl1VfoC13/SWJc07NSzyU8hkAmSA6QB6jQNiLSL1dvhVKqnOroLLrpgKL5BahsKw==
X-Received: by 2002:a1c:7909:: with SMTP id l9mr4869477wme.143.1641504318435;
        Thu, 06 Jan 2022 13:25:18 -0800 (PST)
Received: from fedora.robimarko.hr (dh207-96-150.xnet.hr. [88.207.96.150])
        by smtp.googlemail.com with ESMTPSA id w17sm3106197wmc.14.2022.01.06.13.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 13:25:17 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2] arm64: dts: ipq8074: add SMEM support
Date:   Thu,  6 Jan 2022 22:25:12 +0100
Message-Id: <20220106212512.1970828-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ8074 uses SMEM like other modern QCA SoC-s, so since its already
supported by the kernel add the required DT nodes.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v2:
* Use the MMIO TCSR binding
* Use the updated SMEM binding directly under reserved-memory node
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index e6cc261201ef..bd70092b7156 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -76,6 +76,20 @@ psci {
 		method = "smc";
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		smem@4ab00000 {
+			compatible = "qcom,smem";
+			reg = <0x0 0x4ab00000 0x0 0x00100000>;
+			no-map;
+
+			hwlocks = <&tcsr_mutex 0>;
+		};
+	};
+
 	firmware {
 		scm {
 			compatible = "qcom,scm-ipq8074", "qcom,scm";
@@ -331,6 +345,12 @@ gcc: gcc@1800000 {
 			#reset-cells = <0x1>;
 		};
 
+		tcsr_mutex: hwlock@1905000 {
+			compatible = "qcom,tcsr-mutex";
+			reg = <0x01905000 0x20000>;
+			#hwlock-cells = <1>;
+		};
+
 		spmi_bus: spmi@200f000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0x0200f000 0x001000>,
-- 
2.34.1

